-- =============================================
-- ADD MORE LAWYERS & CASES — Hire A Lawyer
-- Run this in MySQL Workbench
-- Password for all accounts below: Lawyer@123
-- (hash generated with bcrypt rounds=10)
-- =============================================

USE hire_a_lawyer;

-- =============================================
-- ADD MORE LAWYERS (password = Admin@123)
-- Using same bcrypt hash as existing seed users
-- =============================================

INSERT IGNORE INTO users (name, email, password, role, phone) VALUES
('Adv. Arjun Mehta',     'arjun.mehta@hirelawyer.com',   '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9500000001'),
('Adv. Kavya Reddy',     'kavya.reddy@hirelawyer.com',   '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9500000002'),
('Adv. Suresh Patel',    'suresh.patel@hirelawyer.com',  '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9500000003'),
('Adv. Meera Iyer',      'meera.iyer@hirelawyer.com',    '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9500000004'),
('Adv. Vikram Singh',    'vikram.singh@hirelawyer.com',  '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9500000005'),
('Adv. Deepa Nambiar',   'deepa.nambiar@hirelawyer.com', '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9500000006'),
('Adv. Rohit Joshi',     'rohit.joshi@hirelawyer.com',   '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9500000007'),
('Adv. Ananya Bose',     'ananya.bose@hirelawyer.com',   '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9500000008'),
('Adv. Kiran Desai',     'kiran.desai@hirelawyer.com',   '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9500000009'),
('Adv. Pooja Kulkarni',  'pooja.kulkarni@hirelawyer.com','$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9500000010');

-- =============================================
-- ADD LAWYER PROFILES
-- =============================================

INSERT IGNORE INTO lawyer_profiles 
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Property Law', 'BAR-2016-201', 9,
  'Expert in real estate transactions, land disputes, and property registration cases across Maharashtra.',
  2200.00, 4.7, 38, 'Pune, Maharashtra', 'available'
FROM users u WHERE u.email = 'arjun.mehta@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles 
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Labour Law', 'BAR-2019-045', 6,
  'Specializes in employee rights, wrongful termination, and workplace dispute resolution.',
  1800.00, 4.5, 22, 'Hyderabad, Telangana', 'available'
FROM users u WHERE u.email = 'kavya.reddy@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles 
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Tax Law', 'BAR-2010-088', 15,
  'Senior tax lawyer with 15 years experience in GST, income tax disputes, and corporate taxation.',
  4000.00, 4.9, 91, 'Ahmedabad, Gujarat', 'available'
FROM users u WHERE u.email = 'suresh.patel@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles 
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Civil Law', 'BAR-2014-156', 11,
  'Handles civil suits, injunctions, damages, and contract breach disputes with high success rate.',
  2800.00, 4.6, 55, 'Chennai, Tamil Nadu', 'available'
FROM users u WHERE u.email = 'meera.iyer@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles 
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Criminal Law', 'BAR-2011-033', 14,
  'Former public prosecutor with deep expertise in criminal defense, bail applications, and trial proceedings.',
  3800.00, 4.8, 103, 'Delhi, NCR', 'available'
FROM users u WHERE u.email = 'vikram.singh@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles 
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Immigration Law', 'BAR-2017-072', 8,
  'Assists clients with visa applications, OCI cards, citizenship issues, and immigration appeals.',
  2400.00, 4.4, 31, 'Kochi, Kerala', 'available'
FROM users u WHERE u.email = 'deepa.nambiar@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles 
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Intellectual Property', 'BAR-2018-099', 7,
  'Specializes in trademarks, patents, copyrights, and IP litigation for startups and enterprises.',
  3200.00, 4.7, 44, 'Bengaluru, Karnataka', 'available'
FROM users u WHERE u.email = 'rohit.joshi@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles 
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Family Law', 'BAR-2020-011', 5,
  'Compassionate family law attorney handling divorce, alimony, child custody, and domestic issues.',
  1600.00, 4.3, 18, 'Kolkata, West Bengal', 'available'
FROM users u WHERE u.email = 'ananya.bose@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles 
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Corporate Law', 'BAR-2013-067', 12,
  'Corporate lawyer specializing in mergers, acquisitions, due diligence, and board governance.',
  3500.00, 4.8, 76, 'Mumbai, Maharashtra', 'available'
FROM users u WHERE u.email = 'kiran.desai@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles 
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Consumer Law', 'BAR-2015-142', 10,
  'Fights for consumer rights in product liability, fraud, deficient services, and e-commerce disputes.',
  2000.00, 4.5, 49, 'Jaipur, Rajasthan', 'available'
FROM users u WHERE u.email = 'pooja.kulkarni@hirelawyer.com';

-- =============================================
-- ADD MORE CLIENTS
-- =============================================

INSERT IGNORE INTO users (name, email, password, role, phone) VALUES
('Amit Sharma',       'amit.sharma@example.com',    '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'client', '9600000001'),
('Preethi Rao',       'preethi.rao@example.com',    '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'client', '9600000002'),
('Sunil Gupta',       'sunil.gupta@example.com',    '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'client', '9600000003'),
('Lalitha Krishnan',  'lalitha.k@example.com',      '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'client', '9600000004'),
('Manoj Tiwari',      'manoj.tiwari@example.com',   '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'client', '9600000005');

-- =============================================
-- ADD MORE CASES
-- =============================================

INSERT INTO cases (case_number, title, description, category, client_id, lawyer_id, status, priority)
VALUES

-- Ravi Kumar's cases
('CASE-2024-001', 'Property Dispute with Neighbour',
 'My neighbour has encroached on 2 feet of my land by constructing a compound wall. I need legal help to reclaim the land and get compensation.',
 'Property Law',
 (SELECT id FROM users WHERE email='ravi.kumar@example.com'),
 (SELECT id FROM users WHERE email='arjun.mehta@hirelawyer.com'),
 'active', 'high'),

('CASE-2024-002', 'Employment Termination Without Notice',
 'I was terminated from my job without the required 30-day notice or compensation. I want to file a case for wrongful termination.',
 'Labour Law',
 (SELECT id FROM users WHERE email='ravi.kumar@example.com'),
 (SELECT id FROM users WHERE email='kavya.reddy@hirelawyer.com'),
 'pending', 'medium'),

-- Amit Sharma's cases
('CASE-2024-003', 'GST Notice from Income Tax Department',
 'Received a notice from income tax regarding undisclosed GST returns for FY 2022-23. Need urgent legal assistance.',
 'Tax Law',
 (SELECT id FROM users WHERE email='amit.sharma@example.com'),
 (SELECT id FROM users WHERE email='suresh.patel@hirelawyer.com'),
 'active', 'urgent'),

('CASE-2024-004', 'Divorce and Child Custody Petition',
 'Seeking legal help for filing divorce petition and claiming custody of my 6-year-old child. My spouse is contesting.',
 'Family Law',
 (SELECT id FROM users WHERE email='amit.sharma@example.com'),
 (SELECT id FROM users WHERE email='priya.sharma@hirelawyer.com'),
 'active', 'high'),

-- Preethi Rao's cases
('CASE-2024-005', 'Trademark Infringement for My Brand',
 'A competitor is using my registered brand name for similar products. Need help filing trademark infringement case.',
 'Intellectual Property',
 (SELECT id FROM users WHERE email='preethi.rao@example.com'),
 (SELECT id FROM users WHERE email='rohit.joshi@hirelawyer.com'),
 'open', 'medium'),

('CASE-2024-006', 'Consumer Complaint Against Builder',
 'Builder has not delivered my flat 2 years after promised date. Need to file a consumer forum complaint.',
 'Consumer Law',
 (SELECT id FROM users WHERE email='preethi.rao@example.com'),
 (SELECT id FROM users WHERE email='pooja.kulkarni@hirelawyer.com'),
 'pending', 'high'),

-- Sunil Gupta's cases
('CASE-2024-007', 'Criminal Case — Cheque Bounce',
 'A business partner issued a cheque that bounced. I want to file a case under Section 138 of the Negotiable Instruments Act.',
 'Criminal Law',
 (SELECT id FROM users WHERE email='sunil.gupta@example.com'),
 (SELECT id FROM users WHERE email='rahul.verma@hirelawyer.com'),
 'active', 'urgent'),

('CASE-2024-008', 'Visa Rejection Appeal for UK',
 'My UK student visa was rejected without proper reason. Need help filing an appeal and re-application.',
 'Immigration Law',
 (SELECT id FROM users WHERE email='sunil.gupta@example.com'),
 (SELECT id FROM users WHERE email='deepa.nambiar@hirelawyer.com'),
 'open', 'medium'),

-- Lalitha Krishnan's cases
('CASE-2024-009', 'Company Incorporation Dispute',
 'A co-founder is trying to remove me from the company I helped build. Need corporate legal help urgently.',
 'Corporate Law',
 (SELECT id FROM users WHERE email='lalitha.k@example.com'),
 (SELECT id FROM users WHERE email='sita.nair@hirelawyer.com'),
 'active', 'urgent'),

('CASE-2024-010', 'Civil Suit Against Contractor',
 'The contractor I hired for home renovation absconded with 4 lakhs and did incomplete work. Need civil remedy.',
 'Civil Law',
 (SELECT id FROM users WHERE email='lalitha.k@example.com'),
 (SELECT id FROM users WHERE email='meera.iyer@hirelawyer.com'),
 'pending', 'medium'),

-- Manoj Tiwari's cases
('CASE-2024-011', 'Land Acquisition Compensation Dispute',
 'Government acquired my agricultural land for a highway project. The compensation offered is far below market value.',
 'Property Law',
 (SELECT id FROM users WHERE email='manoj.tiwari@example.com'),
 (SELECT id FROM users WHERE email='arjun.mehta@hirelawyer.com'),
 'open', 'high'),

('CASE-2024-012', 'Bail Application — Fraud Case',
 'My brother was arrested under Section 420 IPC. Need immediate bail application filed in High Court.',
 'Criminal Law',
 (SELECT id FROM users WHERE email='manoj.tiwari@example.com'),
 (SELECT id FROM users WHERE email='vikram.singh@hirelawyer.com'),
 'active', 'urgent');

-- =============================================
-- ADD CASE STATUS HISTORY for the new cases
-- =============================================

INSERT INTO case_status_history (case_id, new_status, changed_by, note)
SELECT c.id, c.status,
  (SELECT id FROM users WHERE email='admin@hirelawyer.com'),
  'Case created and assigned to lawyer'
FROM cases c
WHERE c.case_number IN (
  'CASE-2024-001','CASE-2024-002','CASE-2024-003','CASE-2024-004',
  'CASE-2024-005','CASE-2024-006','CASE-2024-007','CASE-2024-008',
  'CASE-2024-009','CASE-2024-010','CASE-2024-011','CASE-2024-012'
);

-- =============================================
-- ADD SAMPLE APPOINTMENTS
-- =============================================

INSERT INTO appointments 
  (client_id, lawyer_id, case_id, title, description, appointment_date, appointment_time, duration_minutes, meeting_type, status)
VALUES
(
  (SELECT id FROM users WHERE email='ravi.kumar@example.com'),
  (SELECT id FROM users WHERE email='arjun.mehta@hirelawyer.com'),
  (SELECT id FROM cases WHERE case_number='CASE-2024-001'),
  'Initial Consultation — Property Dispute',
  'Discuss evidence and strategy for the land encroachment case.',
  DATE_ADD(CURDATE(), INTERVAL 2 DAY), '10:00:00', 60, 'in_person', 'confirmed'
),
(
  (SELECT id FROM users WHERE email='amit.sharma@example.com'),
  (SELECT id FROM users WHERE email='suresh.patel@hirelawyer.com'),
  (SELECT id FROM cases WHERE case_number='CASE-2024-003'),
  'GST Notice Review Session',
  'Go through the income tax notice and plan response strategy.',
  DATE_ADD(CURDATE(), INTERVAL 3 DAY), '11:30:00', 90, 'video_call', 'confirmed'
),
(
  (SELECT id FROM users WHERE email='preethi.rao@example.com'),
  (SELECT id FROM users WHERE email='rohit.joshi@hirelawyer.com'),
  (SELECT id FROM cases WHERE case_number='CASE-2024-005'),
  'Trademark Case Filing Discussion',
  'Review trademark registration documents and plan infringement case.',
  DATE_ADD(CURDATE(), INTERVAL 1 DAY), '14:00:00', 60, 'video_call', 'pending'
),
(
  (SELECT id FROM users WHERE email='sunil.gupta@example.com'),
  (SELECT id FROM users WHERE email='rahul.verma@hirelawyer.com'),
  (SELECT id FROM cases WHERE case_number='CASE-2024-007'),
  'Cheque Bounce — Section 138 Filing',
  'Prepare complaint and gather required documents for Section 138 case.',
  DATE_ADD(CURDATE(), INTERVAL 4 DAY), '09:30:00', 60, 'in_person', 'confirmed'
),
(
  (SELECT id FROM users WHERE email='lalitha.k@example.com'),
  (SELECT id FROM users WHERE email='sita.nair@hirelawyer.com'),
  (SELECT id FROM cases WHERE case_number='CASE-2024-009'),
  'Urgent Meeting — Co-founder Dispute',
  'Review shareholder agreement and discuss legal options.',
  DATE_ADD(CURDATE(), INTERVAL 1 DAY), '16:00:00', 120, 'phone_call', 'confirmed'
);

-- =============================================
-- ADD SAMPLE REVIEWS for existing lawyers
-- =============================================

INSERT IGNORE INTO reviews (lawyer_id, client_id, rating, comment)
VALUES
(
  (SELECT id FROM users WHERE email='arjun.mehta@hirelawyer.com'),
  (SELECT id FROM users WHERE email='ravi.kumar@example.com'),
  5, 'Excellent lawyer! Handled my property case very professionally. Highly recommended.'
),
(
  (SELECT id FROM users WHERE email='suresh.patel@hirelawyer.com'),
  (SELECT id FROM users WHERE email='amit.sharma@example.com'),
  5, 'Brilliant tax lawyer. Got my notice resolved in just 2 hearings. Very knowledgeable.'
),
(
  (SELECT id FROM users WHERE email='kavya.reddy@hirelawyer.com'),
  (SELECT id FROM users WHERE email='ravi.kumar@example.com'),
  4, 'Good understanding of labour laws. Helped me get my dues from my employer.'
),
(
  (SELECT id FROM users WHERE email='vikram.singh@hirelawyer.com'),
  (SELECT id FROM users WHERE email='manoj.tiwari@example.com'),
  5, 'Got bail within 24 hours. Extremely competent and reliable criminal lawyer.'
);

-- =============================================
-- VERIFY — Check counts
-- =============================================

SELECT 'Users' as TableName, COUNT(*) as Total FROM users
UNION ALL SELECT 'Lawyers', COUNT(*) FROM users WHERE role='lawyer'
UNION ALL SELECT 'Clients', COUNT(*) FROM users WHERE role='client'
UNION ALL SELECT 'Cases', COUNT(*) FROM cases
UNION ALL SELECT 'Appointments', COUNT(*) FROM appointments
UNION ALL SELECT 'Reviews', COUNT(*) FROM reviews
UNION ALL SELECT 'Lawyer Profiles', COUNT(*) FROM lawyer_profiles;
