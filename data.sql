use hospital_management_system;

-- Department data

insert into Departments(department_id, name) 
Values 
	(1, 'Cardiology'),
	(2, 'Neurology'),
    (3, 'Orthopedics'),
    (4, 'Pediatrics'),
    (5, 'General Medicines');
    
-- Doctors data

insert into Doctors(doctor_id, name, specialization, department_id, phone) 
Values 
	(101, 'Dr. Arjun Mehta', 'Cardiologist', 1, '9876543210'),
	(102, 'Dr. Neha Sharma', 'Neurologist', 2, '9876543211'),
	(103, 'Dr. Rahul Kapoor', 'Orthopedic Surgeon', 3, '9876543212'),
	(104, 'Dr. Ayesha Khan', 'Pediatrician', 4, '9876543213'),
	(105, 'Dr. Rakesh Nair', 'General Physician', 5, '9876543214');
    
-- Patients data

insert into Patients(patient_id, name, gender, birth_date, phone, address) 
Values 
	(201, 'Karan Malhotra', 'Male', '1985-06-15', '9998887771', 'Delhi'),
	(202, 'Pooja Verma', 'Female', '1990-12-22', '9998887772', 'Mumbai'),
	(203, 'Ali Khan', 'Male', '2005-08-10', '9998887773', 'Hyderabad'),
	(204, 'Meena Joshi', 'Female', '1978-03-30', '9998887774', 'Pune'),
	(205, 'Rahul Jain', 'Male', '1995-01-01', '9998887775', 'Kolkata');
    
-- Appointment data

insert into Appointment(appointment_id, doctor_id, patient_id, appointment_date, appointment_time, status) 
Values 
	(301, 101, 201, '2024-04-01', '10:00:00', 'Completed'),
	(302, 102, 202, '2024-04-02', '11:00:00', 'Completed'),
	(303, 103, 203, '2024-04-03', '12:30:00', 'Completed'),
	(304, 104, 204, '2024-04-04', '09:00:00', 'Scheduled'),
	(305, 105, 205, '2024-04-05', '14:00:00', 'Scheduled');
    
-- Medical Records data

insert into Medical_Records(record_id, appointment_id, diagnosis, prescription, notes) 
Values 
	(401, 301, 'High BP', 'Amlodipine 5mg', 'Monitor BP daily'),
	(402, 302, 'Migraine', 'Sumatriptan', 'Avoid stress triggers'),
	(403, 303, 'Fracture', 'Paracetamol + Cast', '6 weeks rest');
    
-- Billing data

insert into Billing(bill_id, appointment_id, total_amount, status) 
Values 
	(501, 301, 1500.00, 'Paid'),
	(502, 302, 1200.00, 'Paid'),
	(503, 303, 2500.00, 'Unpaid');
    
-- Payments data

insert into Payments(payment_id, bill_id, amount_paid, payment_date) 
Values 
	(601, 501, 1500.00, '2024-04-01'),
	(602, 502, 1200.00, '2024-04-02');