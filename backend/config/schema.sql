-- =============================================
-- Hire A Lawyer - MySQL Database Schema
-- =============================================

CREATE DATABASE IF NOT EXISTS hire_a_lawyer;
USE hire_a_lawyer;

-- Users table (multi-role: client, lawyer, admin)
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role ENUM('client', 'lawyer', 'admin') NOT NULL DEFAULT 'client',
  phone VARCHAR(20),
  avatar VARCHAR(255),
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Lawyer profiles (extends users)
CREATE TABLE IF NOT EXISTS lawyer_profiles (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL UNIQUE,
  specialization VARCHAR(100) NOT NULL,
  bar_number VARCHAR(50),
  experience_years INT DEFAULT 0,
  bio TEXT,
  hourly_rate DECIMAL(10, 2) DEFAULT 0.00,
  rating DECIMAL(3, 2) DEFAULT 0.00,
  total_reviews INT DEFAULT 0,
  location VARCHAR(150),
  availability_status ENUM('available', 'busy', 'unavailable') DEFAULT 'available',
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Cases table
CREATE TABLE IF NOT EXISTS cases (
  id INT AUTO_INCREMENT PRIMARY KEY,
  case_number VARCHAR(50) NOT NULL UNIQUE,
  title VARCHAR(200) NOT NULL,
  description TEXT,
  category VARCHAR(100),
  client_id INT NOT NULL,
  lawyer_id INT,
  status ENUM('open', 'pending', 'active', 'closed', 'rejected') DEFAULT 'open',
  priority ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  closed_at TIMESTAMP NULL,
  FOREIGN KEY (client_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (lawyer_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Case status history (audit trail)
CREATE TABLE IF NOT EXISTS case_status_history (
  id INT AUTO_INCREMENT PRIMARY KEY,
  case_id INT NOT NULL,
  old_status VARCHAR(50),
  new_status VARCHAR(50) NOT NULL,
  changed_by INT NOT NULL,
  note TEXT,
  changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (case_id) REFERENCES cases(id) ON DELETE CASCADE,
  FOREIGN KEY (changed_by) REFERENCES users(id) ON DELETE CASCADE
);

-- Appointments table
CREATE TABLE IF NOT EXISTS appointments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  case_id INT,
  client_id INT NOT NULL,
  lawyer_id INT NOT NULL,
  title VARCHAR(200) NOT NULL,
  description TEXT,
  appointment_date DATE NOT NULL,
  appointment_time TIME NOT NULL,
  duration_minutes INT DEFAULT 60,
  status ENUM('pending', 'confirmed', 'cancelled', 'completed', 'no_show') DEFAULT 'pending',
  meeting_type ENUM('in_person', 'video_call', 'phone_call') DEFAULT 'in_person',
  meeting_link VARCHAR(255),
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (case_id) REFERENCES cases(id) ON DELETE SET NULL,
  FOREIGN KEY (client_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (lawyer_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Documents table
CREATE TABLE IF NOT EXISTS documents (
  id INT AUTO_INCREMENT PRIMARY KEY,
  case_id INT,
  uploaded_by INT NOT NULL,
  file_name VARCHAR(255) NOT NULL,
  original_name VARCHAR(255) NOT NULL,
  file_type VARCHAR(100),
  file_size INT,
  file_path VARCHAR(500) NOT NULL,
  description TEXT,
  is_confidential BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (case_id) REFERENCES cases(id) ON DELETE CASCADE,
  FOREIGN KEY (uploaded_by) REFERENCES users(id) ON DELETE CASCADE
);

-- Messages table (in-app messaging)
CREATE TABLE IF NOT EXISTS messages (
  id INT AUTO_INCREMENT PRIMARY KEY,
  case_id INT,
  sender_id INT NOT NULL,
  receiver_id INT NOT NULL,
  subject VARCHAR(200),
  body TEXT NOT NULL,
  is_read BOOLEAN DEFAULT FALSE,
  read_at TIMESTAMP NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (case_id) REFERENCES cases(id) ON DELETE SET NULL,
  FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Reviews table
CREATE TABLE IF NOT EXISTS reviews (
  id INT AUTO_INCREMENT PRIMARY KEY,
  lawyer_id INT NOT NULL,
  client_id INT NOT NULL,
  case_id INT,
  rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (lawyer_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (client_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (case_id) REFERENCES cases(id) ON DELETE SET NULL
);

-- Notifications table
CREATE TABLE IF NOT EXISTS notifications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  type VARCHAR(50) NOT NULL,
  title VARCHAR(200) NOT NULL,
  message TEXT NOT NULL,
  is_read BOOLEAN DEFAULT FALSE,
  reference_id INT,
  reference_type VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Lawyer availability slots
CREATE TABLE IF NOT EXISTS availability_slots (
  id INT AUTO_INCREMENT PRIMARY KEY,
  lawyer_id INT NOT NULL,
  day_of_week TINYINT NOT NULL COMMENT '0=Sun, 1=Mon, ..., 6=Sat',
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  is_active BOOLEAN DEFAULT TRUE,
  FOREIGN KEY (lawyer_id) REFERENCES users(id) ON DELETE CASCADE
);

-- =============================================
-- Seed Data
-- =============================================

-- Admin user (password: Admin@123)
INSERT IGNORE INTO users (name, email, password, role, phone) VALUES
('Admin User', 'admin@hirelawyer.com', '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'admin', '9000000000');

-- Sample lawyers (password: Lawyer@123)
INSERT IGNORE INTO users (name, email, password, role, phone) VALUES
('Adv. Priya Sharma', 'priya.sharma@hirelawyer.com', '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9111111111'),
('Adv. Rahul Verma', 'rahul.verma@hirelawyer.com', '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9222222222'),
('Adv. Sita Nair', 'sita.nair@hirelawyer.com', '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9333333333');

-- Sample lawyer profiles
INSERT IGNORE INTO lawyer_profiles (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Family Law', 'BAR-2015-001', 10, 'Experienced family law attorney specializing in divorce, child custody, and adoption cases.', 2500.00, 4.8, 45, 'Mumbai, Maharashtra', 'available'
FROM users u WHERE u.email = 'priya.sharma@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Criminal Law', 'BAR-2012-042', 13, 'Senior criminal defense attorney with expertise in white-collar crimes and bail proceedings.', 3500.00, 4.6, 72, 'Delhi, NCR', 'available'
FROM users u WHERE u.email = 'rahul.verma@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Corporate Law', 'BAR-2018-109', 7, 'Corporate lawyer specializing in startup compliance, M&A, and contract law.', 2000.00, 4.9, 28, 'Bengaluru, Karnataka', 'available'
FROM users u WHERE u.email = 'sita.nair@hirelawyer.com';

-- Sample client (password: Client@123)
INSERT IGNORE INTO users (name, email, password, role, phone) VALUES
('Ravi Kumar', 'ravi.kumar@example.com', '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'client', '9444444444');
