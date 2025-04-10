-- 1. view_upcoming_appointments
-- Show upcoming appointments with doctor & patient details.

select* from appointment, doctors, patients;
create view view_upcoming_appointments as
select
	a.appointment_id,
    a.appointment_date,
    a.appointment_time,
    d.name as doctor_name,
    p.name as patient_name,
    a.status
from appointment a
join doctors d on a.doctor_id = d.doctor_id
join patients p on a.patient_id = p.patient_id
where a.status = 'scheduled';

-- 2. view_patient_bills
select* from billing, patients,appointment;
create view view_patient_bill as
select 
	p.name as patient_name,
    b.bill_id,
    b.total_amount,
    b.status
from billing b
join appointment a on b.appointment_id = a.appointment_id
join patients p on a.patient_id = p.patient_id;

-- 3. view_doctor_summary
-- Summarized doctor info with department and total appointments.

create view view_doctor_summary as 
select
	d.doctor_id,
    d.name as doctor_name,
    dept.name as department,
    count(a.appointment_id) as total_appointments
from doctors d 
join departments dept on d.department_id = dept.department_id
left join appointment a on a.doctor_id = d.doctor_id
group by d.doctor_id, d.name, dept.name;

-- 4. view_paid_bills
-- Quick access to all paid bills with patient name.

select* from billing, patients;
create view view_paid_bills as
select
	b.bill_id,
    p.name as patient_name,
    b.total_amount,
    b.status
from billing b 
join appointment a on b.appointment_id = a.appointment_id
join patients p on a.patient_id = p.patient_id
where b.status = 'paid';

		