use hospital_management_system;
-- 1. View all upcoming appointments (status = 'Scheduled')

select
	a.appointment_id,
    p.name as patient_name,
    d.name as doctor_name,
	a.appointment_date,
    a.appointment_time
from Appointment as a
join patients p on a.patient_id = p.patient_id
join doctors d on a.doctor_id = d.doctor_id
where a.status = 'Scheduled'
order by a.appointment_date, a.appointment_time;

-- 2. List all patients with their total number of appointments

select
	p.name as patient_name,
	count(a.appointment_id) as total_appointment
from patients as p
left join appointment a on p.patient_id = a.patient_id
group by p.patient_id, p.name;

-- 3. Total billing amount generated per department

select 
	dp.name as department,
    sum(b.total_amount) as total_billed
from billing b 
join appointment a on b.appointment_id = a.appointment_id
join doctors d on a.doctor_id = d.doctor_id
join departments dp on d.department_id = dp.department_id
group by dp.department_id, dp.name;

-- 4. Get list of unpaid bills with patient and doctor details



select
	b.bill_id,
    p.name as patients,
    d.name as doctors,
    b.total_amount,
    b.status
from billing b
join appointment a on b.appointment_id = a.appointment_id
join patients p on a.patient_id = p.patient_id
join doctors d on a.doctor_id = d.doctor_id
where b.status = 'unpaid';

--  5. Top 3 doctors with the most appointments

select 
	d.name as doctor_name,
    count(a.appointment_id) as total_appointment
from doctors d
join appointment a on d.doctor_id = a.doctor_id
group by d.doctor_id, d.name
order by total_appointment desc	
limit 3;

-- 6. Show total revenue (only for paid bills)

select
	sum(amount_paid) as total_revenue
from payments;

-- 7. Find patients who haven't had any appointments yet

select
	p.name as patient
from patients p
left join appointment a on p.patient_id = a.patient_id
where a.appointment_id is null;



