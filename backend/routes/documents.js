const express = require('express');
const router = express.Router();
const path = require('path');
const fs = require('fs');
const pool = require('../config/db');
const { authenticate } = require('../middleware/auth');
const upload = require('../middleware/upload');

// POST /api/documents/upload - Upload document
router.post('/upload', authenticate, upload.single('file'), async (req, res) => {
  if (!req.file) {
    return res.status(400).json({ success: false, message: 'No file uploaded.' });
  }
  const { case_id, description, is_confidential } = req.body;
  try {
    const [result] = await pool.query(
      `INSERT INTO documents (case_id, uploaded_by, file_name, original_name, file_type, file_size, file_path, description, is_confidential)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        case_id || null,
        req.user.id,
        req.file.filename,
        req.file.originalname,
        req.file.mimetype,
        req.file.size,
        req.file.path,
        description || null,
        is_confidential === 'true' ? 1 : 0
      ]
    );

    // Notify case participants if attached to a case
    if (case_id) {
      const [caseRows] = await pool.query('SELECT * FROM cases WHERE id = ?', [case_id]);
      if (caseRows.length > 0) {
        const notifyId = req.user.role === 'client' ? caseRows[0].lawyer_id : caseRows[0].client_id;
        if (notifyId) {
          await pool.query(
            `INSERT INTO notifications (user_id, type, title, message, reference_id, reference_type)
             VALUES (?, 'document_upload', 'New Document Uploaded', ?, ?, 'document')`,
            [notifyId, `A new document "${req.file.originalname}" has been uploaded for your case.`, result.insertId]
          );
        }
      }
    }

    res.status(201).json({
      success: true,
      message: 'Document uploaded successfully.',
      data: {
        id: result.insertId,
        filename: req.file.filename,
        originalname: req.file.originalname,
        size: req.file.size
      }
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Server error during upload.' });
  }
});

// GET /api/documents - Get documents
router.get('/', authenticate, async (req, res) => {
  const { case_id } = req.query;
  try {
    let query = `SELECT d.*, u.name as uploaded_by_name FROM documents d JOIN users u ON d.uploaded_by = u.id`;
    const params = [];
    if (case_id) { query += ' WHERE d.case_id = ?'; params.push(case_id); }
    query += ' ORDER BY d.created_at DESC';
    const [docs] = await pool.query(query, params);
    res.json({ success: true, data: docs });
  } catch (err) {
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

// GET /api/documents/:id/download - Download document
router.get('/:id/download', authenticate, async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM documents WHERE id = ?', [req.params.id]);
    if (rows.length === 0) return res.status(404).json({ success: false, message: 'Document not found.' });
    const doc = rows[0];
    if (!fs.existsSync(doc.file_path)) {
      return res.status(404).json({ success: false, message: 'File not found on server.' });
    }
    res.download(doc.file_path, doc.original_name);
  } catch (err) {
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

// DELETE /api/documents/:id
router.delete('/:id', authenticate, async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM documents WHERE id = ?', [req.params.id]);
    if (rows.length === 0) return res.status(404).json({ success: false, message: 'Document not found.' });
    const doc = rows[0];
    if (req.user.role !== 'admin' && doc.uploaded_by !== req.user.id) {
      return res.status(403).json({ success: false, message: 'Access denied.' });
    }
    // Remove file from disk
    if (fs.existsSync(doc.file_path)) {
      fs.unlinkSync(doc.file_path);
    }
    await pool.query('DELETE FROM documents WHERE id = ?', [req.params.id]);
    res.json({ success: true, message: 'Document deleted.' });
  } catch (err) {
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

module.exports = router;
