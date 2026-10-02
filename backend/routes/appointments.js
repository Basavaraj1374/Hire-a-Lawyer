const express = require('express');
const router = express.Router();
const pool = require('../config/db');
const { authenticate, authorize } = require('../middleware/auth');

// GET /api/appointments - Get appointments based on role
router.get('/', authenticate, async (req, res) => {
  try {
    let query, params = [];
    if (req.user.role === 'client') {
      query = `SELECT a.*, u.name as lawyer_name, u.email as lawyer_email
               FROM appointments a JOIN users u ON a.lawyer_id = u.id
               WHERE a.client_id = ? ORDER BY a.appointment_date DESC, a.appointment_time DESC`;
      params = [req.user.id];
    } else if (req.user.role === 'lawyer') {
      query = `SELECT a.*, u.name as client_name, u.email as client_email
               FROM appointments a JOIN users u ON a.client_id = u.id
               WHERE a.lawyer_id = ? ORDER BY a.appointment_date ASC, a.appointment_time ASC`;
      params = [req.user.id];
    } else {
      query = `SELECT a.*, uc.name as client_name, ul.name as lawyer_name
               FROM appointments a JOIN users uc ON a.client_id = uc.id
               JOIN users ul ON a.lawyer_id = ul.id ORDER BY a.appointment_date DESC`;
    }
    const [appointments] = await pool.query(query, params);
    res.json({ success: true, data: appointments });
  } catch (err) {
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

// POST /api/appointments - Book appointment (client only)
router.post('/', authenticate, authorize('client'), async (req, res) => {
  const { case_id, lawyer_id, title, description, appointment_date, appointment_time, duration_minutes, meeting_type } = req.body;
  if (!lawyer_id || !appointment_date || !appointment_time || !title) {
    return res.status(400).json({ success: false, message: 'Lawyer, date, time and title are required.' });
  }
  try {
    // Check for conflicts
    const [conflict] = await pool.query(
      `SELECT id FROM appointments WHERE lawyer_id = ? AND appointment_date = ? AND appointment_time = ? AND status NOT IN ('cancelled', 'no_show')`,
      [lawyer_id, appointment_date, appointment_time]
    );
    if (conflict.length > 0) {
      return res.status(409).json({ success: false, message: 'This time slot is already booked.' });
    }

    const [result] = await pool.query(
      `INSERT INTO appointments (case_id, client_id, lawyer_id, title, description, appointment_date, appointment_time, duration_minutes, meeting_type, status)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending')`,
      [case_id || null, req.user.id, lawyer_id, title, description || null, appointment_date, appointment_time, duration_minutes || 60, meeting_type || 'in_person']
    );

    // Notify lawyer
    await pool.query(
      `INSERT INTO notifications (user_id, type, title, message, reference_id, reference_type)
       VALUES (?, 'appointment_request', 'New Appointment Request', ?, ?, 'appointment')`,
      [lawyer_id, `New appointment requested for ${appointment_date} at ${appointment_time}`, result.insertId]
    );

    res.status(201).json({ success: true, message: 'Appointment booked successfully.', data: { id: result.insertId } });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

// PUT /api/appointments/:id/status - Update appointment status
router.put('/:id/status', authenticate, async (req, res) => {
  const { status } = req.body;
  const validStatuses = ['confirmed', 'cancelled', 'completed', 'no_show'];
  if (!validStatuses.includes(status)) {
    return res.status(400).json({ success: false, message: 'Invalid status.' });
  }
  try {
    const [rows] = await pool.query('SELECT * FROM appointments WHERE id = ?', [req.params.id]);
    if (rows.length === 0) return res.status(404).json({ success: false, message: 'Appointment not found.' });
    
    const appt = rows[0];
    // Lawyers can confirm/complete/cancel, clients can only cancel
    if (req.user.role === 'client' && appt.client_id !== req.user.id) {
      return res.status(403).json({ success: false, message: 'Access denied.' });
    }
    if (req.user.role === 'lawyer' && appt.lawyer_id !== req.user.id) {
      return res.status(403).json({ success: false, message: 'Access denied.' });
    }

    await pool.query('UPDATE appointments SET status = ? WHERE id = ?', [status, req.params.id]);

    // Notify the other party
    const notifyUser = req.user.role === 'lawyer' ? appt.client_id : appt.lawyer_id;
    await pool.query(
      `INSERT INTO notifications (user_id, type, title, message, reference_id, reference_type)
       VALUES (?, 'appointment_update', 'Appointment Status Updated', ?, ?, 'appointment')`,
      [notifyUser, `Appointment "${appt.title}" has been ${status}.`, appt.id]
    );

    res.json({ success: true, message: 'Appointment status updated.' });
  } catch (err) {
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

// DELETE /api/appointments/:id
router.delete('/:id', authenticate, async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM appointments WHERE id = ?', [req.params.id]);
    if (rows.length === 0) return res.status(404).json({ success: false, message: 'Appointment not found.' });
    if (req.user.role !== 'admin' && rows[0].client_id !== req.user.id) {
      return res.status(403).json({ success: false, message: 'Access denied.' });
    }
    await pool.query('DELETE FROM appointments WHERE id = ?', [req.params.id]);
    res.json({ success: true, message: 'Appointment deleted.' });
  } catch (err) {
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

module.exports = router;
