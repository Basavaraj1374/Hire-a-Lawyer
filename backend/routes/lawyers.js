const express = require('express');
const router = express.Router();
const pool = require('../config/db');
const { authenticate, authorize } = require('../middleware/auth');

// GET /api/lawyers - List all lawyers with profiles
router.get('/', async (req, res) => {
  try {
    const { specialization, location, search, page = 1, limit = 10 } = req.query;
    const offset = (page - 1) * limit;
    let query = `
      SELECT u.id, u.name, u.email, u.phone, u.avatar,
             lp.specialization, lp.experience_years, lp.hourly_rate,
             lp.rating, lp.total_reviews, lp.location, lp.bio, lp.availability_status
      FROM users u
      JOIN lawyer_profiles lp ON u.id = lp.user_id
      WHERE u.role = 'lawyer' AND u.is_active = 1
    `;
    const params = [];
    if (specialization) { query += ' AND lp.specialization = ?'; params.push(specialization); }
    if (location) { query += ' AND lp.location LIKE ?'; params.push(`%${location}%`); }
    if (search) { query += ' AND (u.name LIKE ? OR lp.bio LIKE ?)'; params.push(`%${search}%`, `%${search}%`); }
    query += ' ORDER BY lp.rating DESC LIMIT ? OFFSET ?';
    params.push(parseInt(limit), parseInt(offset));

    const [lawyers] = await pool.query(query, params);
    const [countResult] = await pool.query(
      `SELECT COUNT(*) as total FROM users u JOIN lawyer_profiles lp ON u.id = lp.user_id WHERE u.role = 'lawyer'`
    );
    res.json({ success: true, data: lawyers, total: countResult[0].total, page: parseInt(page), limit: parseInt(limit) });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

// GET /api/lawyers/:id - Get single lawyer profile
router.get('/:id', async (req, res) => {
  try {
    const [rows] = await pool.query(
      `SELECT u.id, u.name, u.email, u.phone, u.avatar, u.created_at,
              lp.specialization, lp.bar_number, lp.experience_years, lp.hourly_rate,
              lp.rating, lp.total_reviews, lp.location, lp.bio, lp.availability_status
       FROM users u
       JOIN lawyer_profiles lp ON u.id = lp.user_id
       WHERE u.id = ? AND u.role = 'lawyer'`,
      [req.params.id]
    );
    if (rows.length === 0) return res.status(404).json({ success: false, message: 'Lawyer not found.' });
    
    // Get reviews
    const [reviews] = await pool.query(
      `SELECT r.rating, r.comment, r.created_at, u.name as client_name
       FROM reviews r JOIN users u ON r.client_id = u.id
       WHERE r.lawyer_id = ? ORDER BY r.created_at DESC LIMIT 5`,
      [req.params.id]
    );
    res.json({ success: true, data: { ...rows[0], reviews } });
  } catch (err) {
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

// PUT /api/lawyers/profile - Update own lawyer profile
router.put('/profile', authenticate, authorize('lawyer'), async (req, res) => {
  const { specialization, bio, hourly_rate, location, experience_years, availability_status } = req.body;
  try {
    await pool.query(
      `UPDATE lawyer_profiles SET specialization=?, bio=?, hourly_rate=?, location=?, experience_years=?, availability_status=?
       WHERE user_id=?`,
      [specialization, bio, hourly_rate, location, experience_years, availability_status, req.user.id]
    );
    res.json({ success: true, message: 'Profile updated successfully.' });
  } catch (err) {
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

// GET /api/lawyers/:id/slots - Get available slots
router.get('/:id/slots', authenticate, async (req, res) => {
  try {
    const [slots] = await pool.query(
      'SELECT * FROM availability_slots WHERE lawyer_id = ? AND is_active = 1 ORDER BY day_of_week, start_time',
      [req.params.id]
    );
    res.json({ success: true, data: slots });
  } catch (err) {
    res.status(500).json({ success: false, message: 'Server error.' });
  }
});

module.exports = router;
