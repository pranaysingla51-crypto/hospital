CREATE DATABASE hospital ;
USE hospital ;




CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    gender VARCHAR(10),
    phone VARCHAR(20),
    address TEXT
);

CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(50),
    phone VARCHAR(20)
);

CREATE TABLE Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    reason TEXT,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

CREATE TABLE Treatment (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT,
    description TEXT,
    cost DECIMAL(10,2),
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

CREATE TABLE Billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    total_amount DECIMAL(10,2),
    paid_amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    bill_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);
INSERT INTO Patient (first_name, last_name, dob, gender, phone, address)
VALUES
('John', 'Doe', '2025-05-10', 'Male', '9876543210', 'New York'),
('Mary', 'Smith', '1985-11-23', 'Female', '9123456780', 'California'),
('Alex', 'Brown', '2000-02-14', 'Male', '9988776655', 'Texas');

-- Doctors
INSERT INTO Doctor (name, specialization, phone)
VALUES
('Dr. Adams', 'Cardiologist', '9000011111'),
('Dr. Patel', 'Dermatologist', '9000022222'),
('Dr. Lee', 'Orthopedic', '9000033333');

-- Appointments
INSERT INTO Appointment (patient_id, doctor_id, appointment_date, reason, status)
VALUES
(1, 1, '2025-09-21 10:00:00', 'Chest Pain', 'Completed'),
(2, 2, '2025-09-19 14:30:00', 'Skin Rash', 'Scheduled'),
(3, 3, '2025-09-10 09:00:00', 'Knee Pain', 'Completed');

-- Treatments
INSERT INTO Treatment (appointment_id, description, cost)
VALUES
(1, 'ECG Test', 150.00),
(1, 'Medication', 50.00),
(3, 'X-Ray', 200.00);

-- Billing
INSERT INTO Billing (patient_id, total_amount, paid_amount, payment_status, bill_date)
VALUES
(1, 200.00, 200.00, 'Paid', '2025-09-21'),
(2, 500.00, 0.00, 'Pending', '2025-09-19'),
(3, 200.00, 100.00, 'Partial', '2025-09-10');



SELECT * FROM Patient;
SELECT * FROM Doctor;

SELECT * FROM Treatment ;
SELECT * FROM Billing ;



-- Sample Queries (At least 5 meaningful ones)
    
    
 -- List of patients admitted in the last 7 days
       SELECT first_name, last_name, appointment_date
       FROM Patient p
       JOIN Appointment a ON p.patient_id = a.patient_id
       WHERE appointment_date >= CURDATE() - INTERVAL 7 DAY;
 
 -- Find all appointments for a given doctor
       SELECT a.appointment_id, p.first_name, p.last_name, a.appointment_date, a.status
       FROM Appointment a
       JOIN Patient p ON a.patient_id = p.patient_id
       WHERE a.doctor_id = 1;

 -- Calculate total billing per patient
       SELECT p.first_name, p.last_name, SUM(b.total_amount) AS total_bill
       FROM Patient p
       JOIN Billing b ON p.patient_id = b.patient_id
       GROUP BY p.patient_id;

 -- Find patients with pending bills
      SELECT p.first_name, p.last_name, b.total_amount, b.paid_amount
      FROM Patient p
      JOIN Billing b ON p.patient_id = b.patient_id
      WHERE b.payment_status <> 'Paid';

 -- Top 2 most expensive treatments
      SELECT description, cost
      FROM Treatment
      ORDER BY cost DESC
      LIMIT 2;