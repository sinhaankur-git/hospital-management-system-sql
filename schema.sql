create database hospital_management_system;
use hospital_management_system;

-- Department table --

create table Departments(
	department_id int primary key,
    name varchar (100) not null
    );

-- Doctors table --
    
create table Doctors(
	doctor_id int primary key,
    name varchar (100) not null,
    specialization varchar (100),
    department_id int,
    phone varchar(15),
    foreign key (department_id) references Departments(department_id)
    );
    
-- Patients table --
    
create table Patients(
	patient_id int primary key,
    name varchar (100) not null,
    gender ENUM('Male', 'Female', 'Others'),
    birth_date date,
    phone varchar(15),
    address varchar (200)
	);
    
-- Appointment table --
    
create table Appointment(
	appointment_id int primary key,
    doctor_id int,
    patient_id int,
    appointment_date date,
    appointment_time time,
    status ENUM('Scheduled', 'Completed', 'Cancelled') Default 'Scheduled',
    foreign key (doctor_id) references Doctors(doctor_id),
    foreign key (patient_id) references Patients(patient_id)
    );
    
-- Medical Records table --
    
create table Medical_Records(
	record_id int primary key,
    appointment_id int,
    diagnosis text,
    prescription text,
    notes text,
    foreign key (appointment_id) references Appointment(appointment_id)
    );
    
-- Billing table --
    
create table Billing(
	bill_id int primary key,
    appointment_id int,
    total_amount decimal(10,2),
    status ENUM('Unpaid', 'Paid') default 'Unpaid',
    foreign key (appointment_id) references Appointment(appointment_id)
    );
    
-- Payments table --
    
create table Payments(
	payment_id int primary key,
    bill_id int,
    amount_paid decimal(10,2),
    payment_date date,
    foreign key (bill_id) references Billing(bill_id)
    );
    
create table Deleted_Patients_log(
	log_id int auto_increment primary key,
    patient_id int,
    name varchar (100),
    gender ENUM('Male', 'Female', 'Other'),
    birth_date date,
    phone varchar (15),
    address varchar(200),
    deleted_at timestamp default current_timestamp	
    );
   