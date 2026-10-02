require('dotenv').config();
const express = require('express');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors({
  origin: process.env.FRONTEND_URL || 'http://localhost:3000',
  credentials: true
}));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

// Static files
app.use(express.static(path.join(__dirname, 'public')));
app.use('/uploads', express.static(path.join(__dirname, 'public/uploads')));

// API Routes
app.use('/api/auth', require('./backend/routes/auth'));
app.use('/api/lawyers', require('./backend/routes/lawyers'));
app.use('/api/cases', require('./backend/routes/cases'));
app.use('/api/appointments', require('./backend/routes/appointments'));
app.use('/api/documents', require('./backend/routes/documents'));
app.use('/api/notifications', require('./backend/routes/notifications'));
app.use('/api/admin', require('./backend/routes/admin'));
// API Index route
app.get('/api', (req, res) => {
  res.json({
    status: 'online',
    message: 'Hire A Lawyer API is active',
    website: 'http://localhost:' + PORT,
    endpoints: {
      auth: '/api/auth (login, register, me)',
      lawyers: '/api/lawyers',
      cases: '/api/cases',
      appointments: '/api/appointments',
      documents: '/api/documents',
      notifications: '/api/notifications',
      admin: '/api/admin',
      health: '/api/health'
    }
  });
});

// Serve HTML pages
app.get('/', (req, res) => res.sendFile(path.join(__dirname, 'public', 'index.html')));
app.get('/login', (req, res) => res.sendFile(path.join(__dirname, 'public', 'login.html')));
app.get('/register', (req, res) => res.sendFile(path.join(__dirname, 'public', 'register.html')));
app.get('/dashboard', (req, res) => res.sendFile(path.join(__dirname, 'public', 'dashboard.html')));
app.get('/lawyers', (req, res) => res.sendFile(path.join(__dirname, 'public', 'lawyers.html')));
app.get('/cases', (req, res) => res.sendFile(path.join(__dirname, 'public', 'cases.html')));
app.get('/appointments', (req, res) => res.sendFile(path.join(__dirname, 'public', 'appointments.html')));
app.get('/admin', (req, res) => res.sendFile(path.join(__dirname, 'public', 'admin.html')));

// Health check & DB diagnostic
app.get('/api/health', async (req, res) => {
  try {
    const pool = require('./backend/config/db');
    await pool.query('SELECT 1');
    const [userCount] = await pool.query('SELECT COUNT(*) as count FROM users');
    res.json({
      status: 'OK',
      database: 'connected',
      usersInDatabase: userCount[0].count,
      timestamp: new Date().toISOString()
    });
  } catch (err) {
    res.status(500).json({
      status: 'ERROR',
      database: 'disconnected',
      code: err.code,
      message: err.message,
      help: err.code === 'ECONNREFUSED'
        ? 'MySQL service is not running. Start MySQL80 in Windows Services.'
        : err.code === 'ER_ACCESS_DENIED_ERROR'
        ? 'Wrong MySQL password. Check DB_PASSWORD in .env.'
        : err.code === 'ER_BAD_DB_ERROR'
        ? 'hire_a_lawyer database does not exist. Run schema.sql in MySQL Workbench.'
        : err.message
    });
  }
});

// 404 handler
app.use((req, res) => {
  if (req.path.startsWith('/api')) {
    return res.status(404).json({ success: false, message: 'API route not found.' });
  }
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Error handler
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ success: false, message: err.message || 'Internal server error.' });
});

const server = app.listen(PORT, () => {
  console.log(`\n🚀 Hire A Lawyer Server running at http://localhost:${PORT}`);
  console.log(`📊 API available at http://localhost:${PORT}/api`);
  console.log(`\nDefault credentials:`);
  console.log(`  Admin:  admin@hirelawyer.com  / Admin@123`);
  console.log(`  Lawyer: priya.sharma@hirelawyer.com / Admin@123`);
  console.log(`  Client: ravi.kumar@example.com / Admin@123\n`);
});

server.on('error', (err) => {
  if (err.code === 'EADDRINUSE') {
    console.error(`\n⚠️ Port ${PORT} is ALREADY IN USE!`);
    console.error(`👉 The server is already running in another terminal window or background process.`);
    console.error(`👉 You can directly open http://localhost:${PORT} in your browser, OR close the old terminal in VS Code.\n`);
  } else {
    console.error('Server error:', err);
  }
});
