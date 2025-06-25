	-- Create the diagnostic_system database
CREATE DATABASE diagnostic_system;
USE diagnostic_system;

-- Create users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create doctors table
CREATE TABLE doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    photo VARCHAR(255) NOT NULL,
    description TEXT,
    specialization VARCHAR(255) NOT NULL,
    education VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create tests table
CREATE TABLE tests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    duration VARCHAR(50) NOT NULL,
    preparation VARCHAR(255),
    doctor_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);

-- Create bookings table
CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    test_id INT NOT NULL,
    test_name VARCHAR(255) NOT NULL,
    patient_name VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    address TEXT NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL,
    booking_date DATETIME NOT NULL,
    additional_notes TEXT,
    status ENUM('Pending', 'Confirmed', 'Completed', 'Cancelled') DEFAULT 'Pending',
    results TEXT,
    results_date DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (test_id) REFERENCES tests(id)
);

-- Create reports table
CREATE TABLE reports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE
);

-- Create appointments table
CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Pending', 'Confirmed', 'Cancelled') DEFAULT 'Pending',
    additional_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE
);

-- Insert predefined doctors
INSERT INTO doctors (name, photo, description, specialization, education) VALUES
('Dr. Ramesh Sharma', '/images/doctors/ramesh_sharma.jpg', 'Experienced pathologist with over 15 years in diagnostic medicine.', 'Pathology', 'MD, Pathology'),
('Dr. Priya Patel', '/images/doctors/priya_patel.jpg', 'Expert in microbiology and infectious disease diagnostics.', 'Microbiology', 'PhD, Microbiology'),
('Dr. Arun Kumar', '/images/doctors/arun_kumar.jpg', 'Specializes in hematology and blood-related diagnostics.', 'Hematology', 'MD, Hematology'),
('Dr. Neha Gupta', '/images/doctors/neha_gupta.jpg', 'Skilled in clinical biochemistry and metabolic disorders.', 'Clinical Biochemistry', 'MD, Biochemistry');

-- Insert sample tests
INSERT INTO tests (name, description, price, duration, preparation, doctor_id) VALUES
('Complete Blood Count (CBC)', 'Measures different components of blood to assess overall health.', 500.00, '1 hour', 'Fasting not required', 1),
('Blood Glucose Test', 'Checks blood sugar levels to diagnose diabetes.', 300.00, '30 minutes', 'Fasting for 8 hours required', 2),
('Lipid Profile', 'Evaluates cholesterol and triglyceride levels.', 800.00, '1 hour', 'Fasting for 12 hours required', 3),
('Microbiology Culture Test', 'Identifies bacterial infections in blood or tissue.', 1200.00, '2 hours', 'No special preparation', 2),
('Thyroid Function Test', 'Assesses thyroid hormone levels for metabolic health.', 700.00, '45 minutes', 'No special preparation', 4),
('Liver Function Test', 'Evaluates liver health through enzyme and protein levels.', 600.00, '1 hour', 'Fasting for 8 hours recommended', 4);


SELECT * FROM USERS;
SELECT * FROM BOOKINGS;	
SELECT * FROM APPOINTMENTS;
SELECT * FROM REPORTS;
SELECT * FROM TESTS;
INSERT INTO bookings (user_id, test_id, test_name, patient_name, age, gender, address, phone, email, booking_date, status) VALUES
(2, 1, 'Blood Test', 'John Doe', 30, 'Male', '123 Main St', '1234567890', 'user@example.com', '2025-05-12 10:00:00', 'Pending');

DELETE FROM bookings WHERE user_id > 0;
DELETE FROM users WHERE id > 0;
DELETE FROM APPOINTMENTS WHERE ID>0;
DELETE FROM REPORTS;
