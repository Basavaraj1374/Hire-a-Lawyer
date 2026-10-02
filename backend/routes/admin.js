const express = require('express');
const router = express.Router();
const pool = require('../config/db');
const { authenticate, authorize } = require('../middleware/auth');

// GET /api/admin/dashboard - Admin dashboard stats
router.get('/dashboard', authenticate, authorize('admin'), async (req, res) => {
  try {
    const [[userStats]] = await pool.query(`
      SELECT 
        COUNT(*) as total_users,
        SUM(role = 'client') as total_clients,
        SUM(role = 'lawyer') as total_lawyers
      FROM users WHERE is_active = 1
    `);
    const [[caseStats]] = await pool.query(`
      SELECT 
        COUNT(*) as total_cases,
        SUM(status = 'open') as open_cases,
        SUM(status = 'active') as active_cases,
        SUM(status = 'closed') as closed_cases
      FROM cases
    `);
    const [[apptStats]] = await pool.query(`
      SELECT COUNT(*) as total_appointments,
             SUM(status = 'pending') as pending_appointments,
             SUM(status = 'confirmed') as confirmed_appointments
      FROM appointments
    `);
    const [recentCases] = await pool.query(`
      SELECT c.id, c.title, c.status, c.created_at, uc.name as client_name, ul.name as lawyer_name
      FROM cases c JOIN users uc ON c.client_id = uc.id LEFT JOIN users ul ON c.lawyer_id = ul.id
      ORDER BY c.created_at DESC LIMIT 5
    `);
    res.json({ success: true, data: { userStats, caseStats, apptStats, recentCases } });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

// GET /api/admin/users - All users
router.get('/users', authenticate, authorize('admin'), async (req, res) => {
  try {
    const { role } = req.query;
    let query = 'SELECT id, name, email, role, phone, is_active, created_at FROM users';
    const params = [];
    if (role) { query += ' WHERE role = ?'; params.push(role); }
    query += ' ORDER BY created_at DESC';
    const [users] = await pool.query(query, params);
    res.json({ success: true, data: users });
  } catch (err) {
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

// PUT /api/admin/users/:id/toggle - Toggle user active status
router.put('/users/:id/toggle', authenticate, authorize('admin'), async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT is_active FROM users WHERE id = ?', [req.params.id]);
    if (rows.length === 0) return res.status(404).json({ success: false, message: 'User not found.' });
    const newStatus = rows[0].is_active ? 0 : 1;
    await pool.query('UPDATE users SET is_active = ? WHERE id = ?', [newStatus, req.params.id]);
    res.json({ success: true, message: `User ${newStatus ? 'activated' : 'deactivated'} successfully.` });
  } catch (err) {
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

// GET /api/admin/cases - All cases
router.get('/cases', authenticate, authorize('admin'), async (req, res) => {
  try {
    const [cases] = await pool.query(`
      SELECT c.*, uc.name as client_name, ul.name as lawyer_name
      FROM cases c JOIN users uc ON c.client_id = uc.id LEFT JOIN users ul ON c.lawyer_id = ul.id
      ORDER BY c.created_at DESC
    `);
    res.json({ success: true, data: cases });
  } catch (err) {
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

// PUT /api/admin/cases/:id/assign - Assign lawyer to case
router.put('/cases/:id/assign', authenticate, authorize('admin'), async (req, res) => {
  const { lawyer_id } = req.body;
  try {
    await pool.query('UPDATE cases SET lawyer_id = ?, status = "pending" WHERE id = ?', [lawyer_id, req.params.id]);
    const [caseRows] = await pool.query('SELECT * FROM cases WHERE id = ?', [req.params.id]);
    // Notify both
    if (caseRows.length > 0) {
      await pool.query(
        `INSERT INTO notifications (user_id, type, title, message, reference_id, reference_type)
         VALUES (?, 'case_assigned', 'Lawyer Assigned', 'A lawyer has been assigned to your case.', ?, 'case'),
                (?, 'case_assigned', 'Case Assigned', 'You have been assigned a new case.', ?, 'case')`,
        [caseRows[0].client_id, req.params.id, lawyer_id, req.params.id]
      );
    }
    res.json({ success: true, message: 'Lawyer assigned to case.' });
  } catch (err) {
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

module.exports = router;
