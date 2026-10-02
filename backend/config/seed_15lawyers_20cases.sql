-- =============================================
-- ADD 15 LAWYERS + 20 CASES — Hire A Lawyer
-- Run this in MySQL Workbench
-- All accounts password: Admin@123
-- =============================================

USE hire_a_lawyer;

-- =============================================
-- 15 NEW LAWYERS
-- =============================================

INSERT IGNORE INTO users (name, email, password, role, phone) VALUES
('Adv. Rajesh Kumar Pandey',  'rajesh.pandey@hirelawyer.com',   '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9700000001'),
('Adv. Sunita Malhotra',      'sunita.malhotra@hirelawyer.com',  '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9700000002'),
('Adv. Mohammed Farooq',      'mohammed.farooq@hirelawyer.com',  '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9700000003'),
('Adv. Sneha Chatterjee',     'sneha.chatterjee@hirelawyer.com', '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9700000004'),
('Adv. Harish Babu Gowda',   'harish.gowda@hirelawyer.com',     '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9700000005'),
('Adv. Nisha Agarwal',        'nisha.agarwal@hirelawyer.com',    '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9700000006'),
('Adv. Sanjay Bhattacharya',  'sanjay.bhat@hirelawyer.com',      '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9700000007'),
('Adv. Divya Menon',          'divya.menon@hirelawyer.com',      '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9700000008'),
('Adv. Aakash Tripathi',      'aakash.tripathi@hirelawyer.com',  '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9700000009'),
('Adv. Rekha Pillai',         'rekha.pillai@hirelawyer.com',     '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9700000010'),
('Adv. Gaurav Saxena',        'gaurav.saxena@hirelawyer.com',    '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9700000011'),
('Adv. Lakshmi Venkatesh',    'lakshmi.venkatesh@hirelawyer.com','$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9700000012'),
('Adv. Imran Siddiqui',       'imran.siddiqui@hirelawyer.com',   '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9700000013'),
('Adv. Preeti Choudhary',     'preeti.choudhary@hirelawyer.com', '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9700000014'),
('Adv. Naresh Murthy',        'naresh.murthy@hirelawyer.com',    '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'lawyer', '9700000015');

-- =============================================
-- 15 LAWYER PROFILES
-- =============================================

INSERT IGNORE INTO lawyer_profiles
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Criminal Law', 'BAR-2009-301', 16,
  'Senior criminal lawyer with 16+ years handling murder, rape, narcotics, and financial crimes. Former additional sessions judge.',
  5000.00, 4.9, 132, 'Lucknow, Uttar Pradesh', 'available'
FROM users u WHERE u.email = 'rajesh.pandey@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Family Law', 'BAR-2013-302', 12,
  'Family law specialist helping clients navigate divorce, alimony, domestic violence protection, and inheritance disputes with empathy.',
  2600.00, 4.7, 88, 'Chandigarh, Punjab', 'available'
FROM users u WHERE u.email = 'sunita.malhotra@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Civil Law', 'BAR-2011-303', 14,
  'Expert in civil disputes including property suits, injunctions, specific performance, and declaratory decrees across Karnataka and Andhra courts.',
  3000.00, 4.6, 74, 'Hyderabad, Telangana', 'available'
FROM users u WHERE u.email = 'mohammed.farooq@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Corporate Law', 'BAR-2016-304', 9,
  'Corporate lawyer assisting startups and mid-size companies with incorporation, shareholder agreements, ESOP structuring, and compliance.',
  3200.00, 4.8, 51, 'Kolkata, West Bengal', 'available'
FROM users u WHERE u.email = 'sneha.chatterjee@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Property Law', 'BAR-2012-305', 13,
  'Property and real estate lawyer with deep expertise in RERA compliance, title verification, and land acquisition matters in South India.',
  2800.00, 4.7, 96, 'Bengaluru, Karnataka', 'available'
FROM users u WHERE u.email = 'harish.gowda@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Tax Law', 'BAR-2014-306', 11,
  'Chartered accountant turned tax lawyer. Handles direct/indirect tax disputes, GST audits, transfer pricing, and FEMA violations.',
  3800.00, 4.9, 109, 'New Delhi', 'available'
FROM users u WHERE u.email = 'nisha.agarwal@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Labour Law', 'BAR-2010-307', 15,
  'Labour and employment law expert representing both employers and employees in industrial disputes, PF/ESI matters, and wrongful dismissal.',
  3200.00, 4.5, 63, 'Kolkata, West Bengal', 'available'
FROM users u WHERE u.email = 'sanjay.bhat@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Immigration Law', 'BAR-2017-308', 8,
  'Immigration law specialist with extensive experience in overseas employment visas, PR applications, OCI/PIO cards, and NRI property matters.',
  2200.00, 4.6, 42, 'Thiruvananthapuram, Kerala', 'available'
FROM users u WHERE u.email = 'divya.menon@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Consumer Law', 'BAR-2018-309', 7,
  'Consumer rights advocate fighting against defective products, insurance claim rejections, e-commerce fraud, and builder defaults.',
  1900.00, 4.4, 35, 'Varanasi, Uttar Pradesh', 'available'
FROM users u WHERE u.email = 'aakash.tripathi@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Family Law', 'BAR-2015-310', 10,
  'Compassionate family lawyer helping women and children in divorce, domestic abuse, maintenance, and guardianship proceedings.',
  2000.00, 4.8, 77, 'Kochi, Kerala', 'available'
FROM users u WHERE u.email = 'rekha.pillai@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Intellectual Property', 'BAR-2013-311', 12,
  'IP attorney specializing in patent prosecution, copyright registration, trade secret protection, and technology licensing agreements.',
  4200.00, 4.9, 85, 'Noida, Uttar Pradesh', 'available'
FROM users u WHERE u.email = 'gaurav.saxena@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Civil Law', 'BAR-2008-312', 17,
  'High Court advocate with 17 years of experience in civil appeals, writ petitions, and constitutional matters in Madras High Court.',
  4500.00, 4.8, 148, 'Chennai, Tamil Nadu', 'available'
FROM users u WHERE u.email = 'lakshmi.venkatesh@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Criminal Law', 'BAR-2016-313', 9,
  'Criminal defense specialist known for bail arguments, anticipatory bails, and white-collar crime defense in sessions and high courts.',
  3000.00, 4.5, 56, 'Mumbai, Maharashtra', 'available'
FROM users u WHERE u.email = 'imran.siddiqui@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Property Law', 'BAR-2019-314', 6,
  'Young and dynamic property lawyer helping first-time home buyers with due diligence, RERA complaints, and builder-buyer disputes.',
  1700.00, 4.3, 24, 'Jaipur, Rajasthan', 'available'
FROM users u WHERE u.email = 'preeti.choudhary@hirelawyer.com';

INSERT IGNORE INTO lawyer_profiles
  (user_id, specialization, bar_number, experience_years, bio, hourly_rate, rating, total_reviews, location, availability_status)
SELECT u.id, 'Corporate Law', 'BAR-2007-315', 18,
  'Veteran corporate lawyer with 18 years in M&A, joint ventures, private equity deals, and cross-border transactions across India and Southeast Asia.',
  6000.00, 5.0, 201, 'Bengaluru, Karnataka', 'available'
FROM users u WHERE u.email = 'naresh.murthy@hirelawyer.com';

-- =============================================
-- 8 MORE CLIENTS
-- =============================================

INSERT IGNORE INTO users (name, email, password, role, phone) VALUES
('Bharat Nair',         'bharat.nair@example.com',     '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'client', '9800000001'),
('Chandana Prakash',    'chandana.p@example.com',       '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'client', '9800000002'),
('Dinesh Rawat',        'dinesh.rawat@example.com',     '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'client', '9800000003'),
('Farida Begum',        'farida.begum@example.com',     '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'client', '9800000004'),
('Ganesh Subramanian',  'ganesh.sub@example.com',       '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'client', '9800000005'),
('Hema Nandakumar',     'hema.nanda@example.com',       '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'client', '9800000006'),
('Ishaan Oberoi',       'ishaan.oberoi@example.com',    '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'client', '9800000007'),
('Jasmine D''Souza',    'jasmine.dsouza@example.com',   '$2b$10$rKJ4XSRGmFxGJ5B1eHqOCOMR4DREX8ZNrFsZBbS4WiWxhGpJvF3Xm', 'client', '9800000008');

-- =============================================
-- 20 NEW CASES
-- =============================================

INSERT INTO cases
  (case_number, title, description, category, client_id, lawyer_id, status, priority)
VALUES

-- Case 1
('CASE-2025-001',
 'Murder Defence — Bail Application',
 'My brother has been falsely accused of murder in a neighbourhood dispute. Police arrested him based on circumstantial evidence. Need urgent bail application and defence counsel.',
 'Criminal Law',
 (SELECT id FROM users WHERE email='ravi.kumar@example.com'),
 (SELECT id FROM users WHERE email='rajesh.pandey@hirelawyer.com'),
 'active', 'urgent'),

-- Case 2
('CASE-2025-002',
 'Divorce and Alimony Settlement',
 'Seeking divorce from spouse after 8 years due to irretrievable breakdown of marriage. Need help with alimony negotiation and asset division including a jointly owned flat.',
 'Family Law',
 (SELECT id FROM users WHERE email='bharat.nair@example.com'),
 (SELECT id FROM users WHERE email='sunita.malhotra@hirelawyer.com'),
 'active', 'high'),

-- Case 3
('CASE-2025-003',
 'Civil Suit — Money Recovery from Business Partner',
 'My business partner owes me ₹18 lakhs from a dissolved partnership. He refuses to pay despite written agreement. Need civil suit filed for money recovery with interest.',
 'Civil Law',
 (SELECT id FROM users WHERE email='chandana.p@example.com'),
 (SELECT id FROM users WHERE email='mohammed.farooq@hirelawyer.com'),
 'pending', 'high'),

-- Case 4
('CASE-2025-004',
 'Startup Equity Dispute — Co-founder Removal',
 'One of our co-founders is attempting to dilute my equity stake without board approval. Need urgent legal intervention to protect shareholding rights per shareholder agreement.',
 'Corporate Law',
 (SELECT id FROM users WHERE email='dinesh.rawat@example.com'),
 (SELECT id FROM users WHERE email='sneha.chatterjee@hirelawyer.com'),
 'active', 'urgent'),

-- Case 5
('CASE-2025-005',
 'RERA Complaint — Delayed Possession',
 'Builder promised possession in December 2022 but construction is still ongoing. Paid ₹55 lakhs. Want RERA complaint filed and compensation for rental losses.',
 'Property Law',
 (SELECT id FROM users WHERE email='farida.begum@example.com'),
 (SELECT id FROM users WHERE email='harish.gowda@hirelawyer.com'),
 'active', 'high'),

-- Case 6
('CASE-2025-006',
 'Income Tax Scrutiny — AY 2023-24',
 'Received income tax scrutiny notice for AY 2023-24 asking for justification of large cash deposits during COVID period. Need tax lawyer to respond and represent in hearings.',
 'Tax Law',
 (SELECT id FROM users WHERE email='ganesh.sub@example.com'),
 (SELECT id FROM users WHERE email='nisha.agarwal@hirelawyer.com'),
 'active', 'urgent'),

-- Case 7
('CASE-2025-007',
 'Wrongful Termination — IT Company',
 'I was terminated from an IT MNC without cause and denied 90-day notice period pay. Company also revoked my ESOPs before vesting. Need labour law remedy.',
 'Labour Law',
 (SELECT id FROM users WHERE email='hema.nanda@example.com'),
 (SELECT id FROM users WHERE email='sanjay.bhat@hirelawyer.com'),
 'pending', 'medium'),

-- Case 8
('CASE-2025-008',
 'Canada PR Application — Visa Refusal Appeal',
 'Canada Express Entry PR application was refused citing misrepresentation. I have all supporting documents. Need help filing reconsideration request and alternate immigration route.',
 'Immigration Law',
 (SELECT id FROM users WHERE email='ishaan.oberoi@example.com'),
 (SELECT id FROM users WHERE email='divya.menon@hirelawyer.com'),
 'open', 'medium'),

-- Case 9
('CASE-2025-009',
 'Insurance Claim Rejection — Mediclaim Policy',
 'My ₹8 lakh hospitalization claim was rejected by insurance company citing pre-existing condition clause fraudulently. Want consumer forum complaint and claim recovery.',
 'Consumer Law',
 (SELECT id FROM users WHERE email='jasmine.dsouza@example.com'),
 (SELECT id FROM users WHERE email='aakash.tripathi@hirelawyer.com'),
 'pending', 'high'),

-- Case 10
('CASE-2025-010',
 'Domestic Violence — Protection Order',
 'Facing continuous physical and mental abuse from husband and in-laws. Need protection order under Domestic Violence Act and legal separation with child custody.',
 'Family Law',
 (SELECT id FROM users WHERE email='bharat.nair@example.com'),
 (SELECT id FROM users WHERE email='rekha.pillai@hirelawyer.com'),
 'active', 'urgent'),

-- Case 11
('CASE-2025-011',
 'Patent Filing for Mobile App Technology',
 'I have developed a unique AI-based recommendation algorithm for my mobile app. Need to file patent application in India and PCT international patent.',
 'Intellectual Property',
 (SELECT id FROM users WHERE email='chandana.p@example.com'),
 (SELECT id FROM users WHERE email='gaurav.saxena@hirelawyer.com'),
 'open', 'medium'),

-- Case 12
('CASE-2025-012',
 'High Court Appeal — Civil Decree Challenge',
 'Lower court ruled against me in a civil property suit. The judgment is erroneous as key evidence was ignored. Need to file appeal in High Court within limitation period.',
 'Civil Law',
 (SELECT id FROM users WHERE email='dinesh.rawat@example.com'),
 (SELECT id FROM users WHERE email='lakshmi.venkatesh@hirelawyer.com'),
 'active', 'high'),

-- Case 13
('CASE-2025-013',
 'Anticipatory Bail — Cybercrime Case',
 'Police are likely to arrest me in a cybercrime case filed by an ex-employee. The complaint is false and motivated. Need anticipatory bail immediately.',
 'Criminal Law',
 (SELECT id FROM users WHERE email='farida.begum@example.com'),
 (SELECT id FROM users WHERE email='imran.siddiqui@hirelawyer.com'),
 'active', 'urgent'),

-- Case 14
('CASE-2025-014',
 'Plot Registration Dispute — Forged Documents',
 'Someone forged my signature and transferred my ancestral plot to another person. I have original title documents. Need to cancel the fraudulent registration.',
 'Property Law',
 (SELECT id FROM users WHERE email='ganesh.sub@example.com'),
 (SELECT id FROM users WHERE email='preeti.choudhary@hirelawyer.com'),
 'pending', 'urgent'),

-- Case 15
('CASE-2025-015',
 'Venture Capital Agreement — Term Sheet Review',
 'Received term sheet from Series A VC investor for ₹12 Cr investment. Need expert review of liquidation preference, anti-dilution clauses, and board composition rights.',
 'Corporate Law',
 (SELECT id FROM users WHERE email='hema.nanda@example.com'),
 (SELECT id FROM users WHERE email='naresh.murthy@hirelawyer.com'),
 'open', 'high'),

-- Case 16
('CASE-2025-016',
 'GST Refund Claim Rejection',
 'Export refund of ₹3.2 lakhs under GST IGST route was rejected by department. All documents are in order. Need legal representation at GST appellate authority.',
 'Tax Law',
 (SELECT id FROM users WHERE email='ishaan.oberoi@example.com'),
 (SELECT id FROM users WHERE email='nisha.agarwal@hirelawyer.com'),
 'pending', 'medium'),

-- Case 17
('CASE-2025-017',
 'Employee PF Withdrawal Dispute',
 'My ex-employer is blocking my EPF withdrawal by submitting wrong exit date to EPFO. It has been 6 months and ₹4.8 lakhs is stuck. Need urgent legal resolution.',
 'Labour Law',
 (SELECT id FROM users WHERE email='jasmine.dsouza@example.com'),
 (SELECT id FROM users WHERE email='sanjay.bhat@hirelawyer.com'),
 'active', 'high'),

-- Case 18
('CASE-2025-018',
 'Online Shopping Fraud — Counterfeit Goods',
 'Paid ₹45,000 for a branded laptop on an e-commerce platform. Received a counterfeit product. Seller account is suspended. Need consumer case for full refund and damages.',
 'Consumer Law',
 (SELECT id FROM users WHERE email='bharat.nair@example.com'),
 (SELECT id FROM users WHERE email='aakash.tripathi@hirelawyer.com'),
 'closed', 'low'),

-- Case 19
('CASE-2025-019',
 'Inheritance Dispute — Ancestral Property',
 'My uncles are claiming equal share in property left by my grandfather. The will clearly states property goes to my father. Need to establish validity of will in court.',
 'Civil Law',
 (SELECT id FROM users WHERE email='chandana.p@example.com'),
 (SELECT id FROM users WHERE email='mohammed.farooq@hirelawyer.com'),
 'active', 'medium'),

-- Case 20
('CASE-2025-020',
 'Copyright Violation — Stolen Book Content',
 'A publisher copied 3 chapters of my published book verbatim without permission and published it under a different title. Need copyright infringement case and injunction.',
 'Intellectual Property',
 (SELECT id FROM users WHERE email='dinesh.rawat@example.com'),
 (SELECT id FROM users WHERE email='gaurav.saxena@hirelawyer.com'),
 'pending', 'medium');

-- =============================================
-- STATUS HISTORY FOR ALL 20 CASES
-- =============================================

INSERT INTO case_status_history (case_id, new_status, changed_by, note)
SELECT c.id, 'open',
  (SELECT id FROM users WHERE email = 'admin@hirelawyer.com'),
  'Case created by client'
FROM cases c
WHERE c.case_number LIKE 'CASE-2025-%';

-- Additional history for active cases
INSERT INTO case_status_history (case_id, old_status, new_status, changed_by, note)
SELECT c.id, 'open', 'active',
  (SELECT id FROM users WHERE email = 'admin@hirelawyer.com'),
  'Lawyer accepted and started working on the case'
FROM cases c
WHERE c.case_number IN (
  'CASE-2025-001','CASE-2025-002','CASE-2025-004',
  'CASE-2025-005','CASE-2025-006','CASE-2025-010',
  'CASE-2025-012','CASE-2025-013','CASE-2025-017',
  'CASE-2025-019'
);

-- Closed case history
INSERT INTO case_status_history (case_id, old_status, new_status, changed_by, note)
SELECT c.id, 'active', 'closed',
  (SELECT id FROM users WHERE email = 'admin@hirelawyer.com'),
  'Case resolved. Consumer forum ruled in favour of client. Full refund obtained.'
FROM cases c WHERE c.case_number = 'CASE-2025-018';

-- =============================================
-- SAMPLE APPOINTMENTS FOR NEW CASES
-- =============================================

INSERT INTO appointments
  (client_id, lawyer_id, case_id, title, description, appointment_date, appointment_time, duration_minutes, meeting_type, status)
VALUES
(
  (SELECT id FROM users WHERE email='ravi.kumar@example.com'),
  (SELECT id FROM users WHERE email='rajesh.pandey@hirelawyer.com'),
  (SELECT id FROM cases WHERE case_number='CASE-2025-001'),
  'Bail Application Strategy Meeting',
  'Discuss evidence, witnesses, and bail grounds for the murder defence case.',
  DATE_ADD(CURDATE(), INTERVAL 1 DAY), '09:00:00', 120, 'in_person', 'confirmed'
),
(
  (SELECT id FROM users WHERE email='bharat.nair@example.com'),
  (SELECT id FROM users WHERE email='sunita.malhotra@hirelawyer.com'),
  (SELECT id FROM cases WHERE case_number='CASE-2025-002'),
  'Divorce Petition Filing — Document Review',
  'Review all required documents for divorce petition and alimony calculation.',
  DATE_ADD(CURDATE(), INTERVAL 2 DAY), '11:00:00', 90, 'in_person', 'confirmed'
),
(
  (SELECT id FROM users WHERE email='dinesh.rawat@example.com'),
  (SELECT id FROM users WHERE email='sneha.chatterjee@hirelawyer.com'),
  (SELECT id FROM cases WHERE case_number='CASE-2025-004'),
  'Emergency — Shareholder Agreement Review',
  'Review SHA clauses and plan injunction to stop equity dilution.',
  DATE_ADD(CURDATE(), INTERVAL 1 DAY), '15:00:00', 60, 'video_call', 'confirmed'
),
(
  (SELECT id FROM users WHERE email='farida.begum@example.com'),
  (SELECT id FROM users WHERE email='harish.gowda@hirelawyer.com'),
  (SELECT id FROM cases WHERE case_number='CASE-2025-005'),
  'RERA Complaint Preparation',
  'Gather all payment receipts, agreement documents, and delay letters for RERA filing.',
  DATE_ADD(CURDATE(), INTERVAL 3 DAY), '10:30:00', 90, 'in_person', 'pending'
),
(
  (SELECT id FROM users WHERE email='ganesh.sub@example.com'),
  (SELECT id FROM users WHERE email='nisha.agarwal@hirelawyer.com'),
  (SELECT id FROM cases WHERE case_number='CASE-2025-006'),
  'Income Tax Notice Response Planning',
  'Prepare written submission for scrutiny notice and gather bank statements.',
  DATE_ADD(CURDATE(), INTERVAL 2 DAY), '14:00:00', 120, 'video_call', 'confirmed'
),
(
  (SELECT id FROM users WHERE email='farida.begum@example.com'),
  (SELECT id FROM users WHERE email='imran.siddiqui@hirelawyer.com'),
  (SELECT id FROM cases WHERE case_number='CASE-2025-013'),
  'Anticipatory Bail — Urgent Hearing Prep',
  'Review FIR, collect alibi evidence, prepare anticipatory bail petition for sessions court.',
  DATE_ADD(CURDATE(), INTERVAL 1 DAY), '08:00:00', 60, 'phone_call', 'confirmed'
),
(
  (SELECT id FROM users WHERE email='hema.nanda@example.com'),
  (SELECT id FROM users WHERE email='naresh.murthy@hirelawyer.com'),
  (SELECT id FROM cases WHERE case_number='CASE-2025-015'),
  'VC Term Sheet Detailed Review',
  'Clause-by-clause review of Series A term sheet focusing on founder protections.',
  DATE_ADD(CURDATE(), INTERVAL 4 DAY), '13:00:00', 180, 'video_call', 'pending'
),
(
  (SELECT id FROM users WHERE email='chandana.p@example.com'),
  (SELECT id FROM users WHERE email='gaurav.saxena@hirelawyer.com'),
  (SELECT id FROM cases WHERE case_number='CASE-2025-011'),
  'Patent Filing Consultation',
  'Explain the patent process, perform prior art search, and begin provisional application.',
  DATE_ADD(CURDATE(), INTERVAL 5 DAY), '11:00:00', 90, 'in_person', 'pending'
);

-- =============================================
-- REVIEWS FOR NEW LAWYERS
-- =============================================

INSERT IGNORE INTO reviews (lawyer_id, client_id, rating, comment)
VALUES
(
  (SELECT id FROM users WHERE email='rajesh.pandey@hirelawyer.com'),
  (SELECT id FROM users WHERE email='ravi.kumar@example.com'),
  5, 'Outstanding criminal lawyer. Got bail in a very complex murder case. His courtroom presence is commanding.'
),
(
  (SELECT id FROM users WHERE email='sunita.malhotra@hirelawyer.com'),
  (SELECT id FROM users WHERE email='bharat.nair@example.com'),
  5, 'Very compassionate and professional. Handled my divorce case with sensitivity and got excellent alimony terms.'
),
(
  (SELECT id FROM users WHERE email='nisha.agarwal@hirelawyer.com'),
  (SELECT id FROM users WHERE email='ganesh.sub@example.com'),
  5, 'Brilliant tax lawyer. Resolved a 3-year old tax dispute in just 2 hearings. Highly knowledgeable.'
),
(
  (SELECT id FROM users WHERE email='naresh.murthy@hirelawyer.com'),
  (SELECT id FROM users WHERE email='hema.nanda@example.com'),
  5, 'The best corporate lawyer I have dealt with. Saved our startup from a very unfair VC deal. Worth every rupee.'
),
(
  (SELECT id FROM users WHERE email='gaurav.saxena@hirelawyer.com'),
  (SELECT id FROM users WHERE email='chandana.p@example.com'),
  4, 'Very thorough with IP matters. Patent filing process was smooth and well-explained. Highly recommend.'
),
(
  (SELECT id FROM users WHERE email='harish.gowda@hirelawyer.com'),
  (SELECT id FROM users WHERE email='farida.begum@example.com'),
  4, 'Got our RERA case filed quickly. Fighting builder delays effectively. Good knowledge of property laws.'
),
(
  (SELECT id FROM users WHERE email='lakshmi.venkatesh@hirelawyer.com'),
  (SELECT id FROM users WHERE email='dinesh.rawat@example.com'),
  5, 'Exceptional High Court advocate. Her arguments in the appeal were sharp and convincing. Case won!'
),
(
  (SELECT id FROM users WHERE email='rekha.pillai@hirelawyer.com'),
  (SELECT id FROM users WHERE email='bharat.nair@example.com'),
  5, 'Helped me get a protection order in 48 hours. Very caring and efficient. Exactly what I needed in a crisis.'
);

-- =============================================
-- FINAL VERIFICATION — Check all counts
-- =============================================

SELECT 'Total Users'        AS Item, COUNT(*) AS Count FROM users
UNION ALL
SELECT 'Total Lawyers',      COUNT(*) FROM users WHERE role = 'lawyer'
UNION ALL
SELECT 'Total Clients',      COUNT(*) FROM users WHERE role = 'client'
UNION ALL
SELECT 'Lawyer Profiles',    COUNT(*) FROM lawyer_profiles
UNION ALL
SELECT 'Total Cases',        COUNT(*) FROM cases
UNION ALL
SELECT 'Open Cases',         COUNT(*) FROM cases WHERE status = 'open'
UNION ALL
SELECT 'Pending Cases',      COUNT(*) FROM cases WHERE status = 'pending'
UNION ALL
SELECT 'Active Cases',       COUNT(*) FROM cases WHERE status = 'active'
UNION ALL
SELECT 'Closed Cases',       COUNT(*) FROM cases WHERE status = 'closed'
UNION ALL
SELECT 'Total Appointments', COUNT(*) FROM appointments
UNION ALL
SELECT 'Total Reviews',      COUNT(*) FROM reviews;
