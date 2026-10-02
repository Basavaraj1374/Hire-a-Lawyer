# ⚖️ Hire A Lawyer — Full-Stack Web Application

> **5th Semester Web Development Project**

A full-stack web platform connecting **clients** and **lawyers**, supporting appointment booking, document sharing, and case tracking.

---

## 🚀 Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | HTML5, CSS3, Vanilla JavaScript |
| Backend | Node.js + Express.js |
| Database | MySQL |
| Auth | JWT (JSON Web Tokens) |
| File Uploads | Multer |

---

## 📁 Project Structure

```
hire-a-lawyer/
├── backend/
│   ├── config/
│   │   ├── db.js           # MySQL connection pool
│   │   └── schema.sql      # Database schema + seed data
│   ├── middleware/
│   │   ├── auth.js         # JWT authentication + RBAC
│   │   └── upload.js       # Multer file upload middleware
│   └── routes/
│       ├── auth.js         # Register, Login, /me
│       ├── lawyers.js      # Lawyer listing & profiles
│       ├── cases.js        # Case CRUD + status tracking
│       ├── appointments.js # Appointment booking
│       ├── documents.js    # Document upload/download
│       ├── notifications.js# In-app notifications
│       └── admin.js        # Admin dashboard & management
├── public/
│   ├── css/styles.css      # Global stylesheet
│   ├── js/app.js           # API client, Auth, UI helpers
│   ├── uploads/            # Uploaded documents (auto-created)
│   ├── index.html          # Landing page
│   ├── login.html          # Login + Register
│   ├── dashboard.html      # Role-based dashboard
│   ├── lawyers.html        # Browse & search lawyers
│   ├── cases.html          # Case management
│   ├── appointments.html   # Appointment booking
│   └── admin.html          # Admin panel
├── server.js               # Express server entry point
├── package.json
└── .env                    # Environment variables
```

---

## ⚙️ Setup Instructions

### Prerequisites
- Node.js v18+
- MySQL 8.x
- VS Code (recommended)

### 1. Database Setup

1. Open **MySQL Workbench** or run in terminal:
   ```sql
   mysql -u root -p
   ```
2. Run the schema file:
   ```sql
   SOURCE backend/config/schema.sql;
   ```
   Or import via MySQL Workbench.

### 2. Configure Environment

Edit `.env` file:
```env
PORT=3000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_mysql_password   ← UPDATE THIS
DB_NAME=hire_a_lawyer
JWT_SECRET=hire_lawyer_super_secret_2024_key
```

### 3. Install Dependencies

```bash
npm install
```

### 4. Start the Server

```bash
# Development (auto-reload)
npm run dev

# Production
npm start
```

### 5. Open in Browser

Navigate to: **http://localhost:3000**

---

## 👤 Default Test Accounts

> All accounts use the same password: **`Admin@123`**

| Role | Email |
|------|-------|
| 🛡️ Admin | admin@hirelawyer.com |
| ⚖️ Lawyer | priya.sharma@hirelawyer.com |
| ⚖️ Lawyer | rahul.verma@hirelawyer.com |
| 👤 Client | ravi.kumar@example.com |

---

## 🔗 API Endpoints

### Authentication
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/auth/register` | Register new user |
| POST | `/api/auth/login` | Login |
| GET | `/api/auth/me` | Get current user |

### Lawyers
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/lawyers` | List lawyers (with filters) |
| GET | `/api/lawyers/:id` | Get lawyer profile + reviews |
| PUT | `/api/lawyers/profile` | Update own profile (lawyer) |

### Cases
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/cases` | Get cases (role-filtered) |
| POST | `/api/cases` | Create case (client) |
| GET | `/api/cases/:id` | Case details + timeline + docs |
| PUT | `/api/cases/:id/status` | Update status (lawyer/admin) |
| DELETE | `/api/cases/:id` | Delete case (admin) |

### Appointments
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/appointments` | List appointments |
| POST | `/api/appointments` | Book appointment (client) |
| PUT | `/api/appointments/:id/status` | Confirm/Cancel/Complete |

### Documents
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/documents/upload` | Upload file |
| GET | `/api/documents` | List documents |
| GET | `/api/documents/:id/download` | Download file |
| DELETE | `/api/documents/:id` | Delete document |

### Admin
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/admin/dashboard` | Platform stats |
| GET | `/api/admin/users` | All users |
| PUT | `/api/admin/users/:id/toggle` | Activate/deactivate user |
| PUT | `/api/admin/cases/:id/assign` | Assign lawyer to case |

---

## 🔐 Role-Based Access Control

| Feature | Client | Lawyer | Admin |
|---------|--------|--------|-------|
| Browse lawyers | ✅ | ✅ | ✅ |
| Create case | ✅ | ❌ | ❌ |
| View own cases | ✅ | ✅ | ✅ |
| Update case status | ❌ | ✅ | ✅ |
| Book appointment | ✅ | ❌ | ❌ |
| Confirm/complete appointment | ❌ | ✅ | ❌ |
| Upload documents | ✅ | ✅ | ✅ |
| Admin panel | ❌ | ❌ | ✅ |
| Manage all users | ❌ | ❌ | ✅ |
| Assign lawyers | ❌ | ❌ | ✅ |

---

## 🗄️ Database Schema

The MySQL schema includes **10 tables**:

- `users` — Multi-role user accounts (client/lawyer/admin)
- `lawyer_profiles` — Extended lawyer information
- `cases` — Legal case records with status tracking
- `case_status_history` — Full audit trail of case changes
- `appointments` — Consultation bookings
- `documents` — Uploaded files linked to cases
- `messages` — In-app messaging (prepared)
- `reviews` — Lawyer ratings and feedback
- `notifications` — Real-time in-app notifications
- `availability_slots` — Lawyer schedule management

---

## 📸 Pages Overview

1. **Landing Page** (`/`) — Hero section, features, how-it-works
2. **Login/Register** (`/login`) — Combined auth with role selection
3. **Dashboard** (`/dashboard`) — Role-based overview with stats
4. **Lawyers** (`/lawyers`) — Search, filter, book appointments
5. **Cases** (`/cases`) — Create, track, update with timeline
6. **Appointments** (`/appointments`) — Book and manage meetings
7. **Admin Panel** (`/admin`) — Full platform management

---

*Built for 5th Semester — Full-Stack Web Development*
