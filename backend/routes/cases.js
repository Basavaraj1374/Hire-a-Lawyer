const express = require('express');
const router = express.Router();
const pool = require('../config/db');
const { authenticate, authorize } = require('../middleware/auth');
const { v4: uuidv4 } = require('uuid');

// Helper: generate case number
const generateCaseNumber = () => `CASE-${Date.now()}-${Math.floor(Math.random() * 1000)}`;

// GET /api/cases - Get cases based on role
router.get('/', authenticate, async (req, res) => {
  try {
    let query, params = [];
    if (req.user.role === 'client') {
      query = `SELECT c.*, u.name as lawyer_name FROM cases c LEFT JOIN users u ON c.lawyer_id = u.id WHERE c.client_id = ? ORDER BY c.created_at DESC`;
      params = [req.user.id];
    } else if (req.user.role === 'lawyer') {
      query = `SELECT c.*, u.name as client_name FROM cases c JOIN users u ON c.client_id = u.id WHERE c.lawyer_id = ? ORDER BY c.created_at DESC`;
      params = [req.user.id];
    } else { // admin
      query = `SELECT c.*, uc.name as client_name, ul.name as lawyer_name FROM cases c JOIN users uc ON c.client_id = uc.id LEFT JOIN users ul ON c.lawyer_id = ul.id ORDER BY c.created_at DESC`;
    }
    const [cases] = await pool.query(query, params);
    res.json({ success: true, data: cases });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

// GET /api/cases/:id - Get single case
router.get('/:id', authenticate, async (req, res) => {
  try {
    const [rows] = await pool.query(
      `SELECT c.*, uc.name as client_name, uc.email as client_email,
              ul.name as lawyer_name, ul.email as lawyer_email
       FROM cases c
       JOIN users uc ON c.client_id = uc.id
       LEFT JOIN users ul ON c.lawyer_id = ul.id
       WHERE c.id = ?`,
      [req.params.id]
    );
    if (rows.length === 0) return res.status(404).json({ success: false, message: 'Case not found.' });
    const theCase = rows[0];

    // Access control
    if (req.user.role === 'client' && theCase.client_id !== req.user.id) {
      return res.status(403).json({ success: false, message: 'Access denied.' });
    }
    if (req.user.role === 'lawyer' && theCase.lawyer_id !== req.user.id) {
      return res.status(403).json({ success: false, message: 'Access denied.' });
    }

    // Get status history
    const [history] = await pool.query(
      `SELECT csh.*, u.name as changed_by_name FROM case_status_history csh
       JOIN users u ON csh.changed_by = u.id WHERE csh.case_id = ? ORDER BY csh.changed_at ASC`,
      [req.params.id]
    );

    // Get documents
    const [docs] = await pool.query(
      `SELECT d.*, u.name as uploaded_by_name FROM documents d
       JOIN users u ON d.uploaded_by = u.id WHERE d.case_id = ? ORDER BY d.created_at DESC`,
      [req.params.id]
    );

    res.json({ success: true, data: { ...theCase, history, documents: docs } });
  } catch (err) {
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

// POST /api/cases - Create new case (client only)
router.post('/', authenticate, authorize('client'), async (req, res) => {
  const { title, description, category, lawyer_id, priority } = req.body;
  if (!title) return res.status(400).json({ success: false, message: 'Title is required.' });
  try {
    const caseNumber = generateCaseNumber();
    const [result] = await pool.query(
      `INSERT INTO cases (case_number, title, description, category, client_id, lawyer_id, status, priority)
       VALUES (?, ?, ?, ?, ?, ?, 'open', ?)`,
      [caseNumber, title, description || null, category || null, req.user.id, lawyer_id || null, priority || 'medium']
    );
    const caseId = result.insertId;

    // Log initial status
    await pool.query(
      `INSERT INTO case_status_history (case_id, new_status, changed_by, note) VALUES (?, 'open', ?, 'Case created')`,
      [caseId, req.user.id]
    );

    // Notify lawyer if assigned
    if (lawyer_id) {
      await pool.query(
        `INSERT INTO notifications (user_id, type, title, message, reference_id, reference_type)
         VALUES (?, 'case_assigned', 'New Case Assigned', ?, ?, 'case')`,
        [lawyer_id, `You have been assigned a new case: ${title}`, caseId]
      );
    }

    res.status(201).json({ success: true, message: 'Case created successfully.', data: { id: caseId, case_number: caseNumber } });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

// PUT /api/cases/:id/status - Update case status
router.put('/:id/status', authenticate, authorize('lawyer', 'admin'), async (req, res) => {
  const { status, note } = req.body;
  const validStatuses = ['pending', 'active', 'closed', 'rejected'];
  if (!validStatuses.includes(status)) {
    return res.status(400).json({ success: false, message: 'Invalid status.' });
  }
  try {
    const [rows] = await pool.query('SELECT * FROM cases WHERE id = ?', [req.params.id]);
    if (rows.length === 0) return res.status(404).json({ success: false, message: 'Case not found.' });
    
    const oldStatus = rows[0].status;
    await pool.query('UPDATE cases SET status = ? WHERE id = ?', [status, req.params.id]);
    await pool.query(
      `INSERT INTO case_status_history (case_id, old_status, new_status, changed_by, note) VALUES (?, ?, ?, ?, ?)`,
      [req.params.id, oldStatus, status, req.user.id, note || null]
    );

    // Notify client
    await pool.query(
      `INSERT INTO notifications (user_id, type, title, message, reference_id, reference_type)
       VALUES (?, 'case_update', 'Case Status Updated', ?, ?, 'case')`,
      [rows[0].client_id, `Your case "${rows[0].title}" status changed to "${status}".`, req.params.id]
    );

    res.json({ success: true, message: 'Case status updated.' });
  } catch (err) {
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

// DELETE /api/cases/:id - Admin only
router.delete('/:id', authenticate, authorize('admin'), async (req, res) => {
  try {
    await pool.query('DELETE FROM cases WHERE id = ?', [req.params.id]);
    res.json({ success: true, message: 'Case deleted.' });
  } catch (err) {
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

module.exports = router;
