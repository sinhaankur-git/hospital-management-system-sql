use hospital_management_system;
-- 1. Stored Procedure to Delete Patient --

DELIMITER $$

create procedure delete_patient(in pid int)
begin
	declare done int default 0;
    
-- Delete payments related to the patient
	delete from payments
	where bill_id in (
		select bill_id from billing
		where appointment_id in(
			select appointment_id from appointment 
			where patient_id = pid
			)
);

-- Delete billing records

	delete from billing
	where appointment_id in (
		select appointment_id from appointment
		where patient_id = pid
);

-- Delete medical records

delete from medical_records
	where appointment_id in (
		select appointment_id from appointment
		where patient_id = pid
);

-- delete appointment
	delete from appointment
	where patient_id = pid;

-- delete from patients table (this will trigger the audit log)

	delete from patients
    where patient_id = pid;
end $$

DELIMITER ;

-- 2. schedule_appointment
-- Schedules an appointment between a patient and a doctor, setting status to 'Scheduled' 

DELIMITER $$

create procedure schedule_appointment(
	in pid int,
    in did int,
    in appt_date date,
    in appt_time time
)
begin
	insert into appointment( patient_id, doctor_id, appointment_id, appointment_time, status)
	values( pid, did, appt_date, appt_time, 'Scheduled' );
end $$

DELIMITER ;

-- 3.mark_appointment_completed
-- Updates an appointment status to 'Completed'.

DELIMITER $$

create procedure mar_appointment_completed(
	in appt_id int
)
begin
	update appointment
    set status = 'Completed'
    where appointment_id = appt_id;
end $$

DELIMITER ;

-- 4. generate_bill_for_appointment
-- Generates a billing record for a completed appointment.

DELIMITER $$

create procedure generate_bill_for_appointment(
	in appt_id int,
    in total_amt decimal(10,2)
)
begin
	declare appt_status ENUM('Scheduled', 'Completed', 'Cancelled');
    
	select status into appt_status
	from appointment
    where appointment_id = appt_id;

	if appt_status = 'Completed' then
		insert into billing(appointment_id, total_amount, status)
        values(appt_id, total_amt, 'Unpaid');
	else
		signal sqlstate '45000'
        set message_text = 'Cannot generate bill : appointment is not completed.';
	end if;
end $$

DELIMITER ;

-- 5. make_payment
-- Insert a payment against a bill — automatically triggers the status update if bill is fully paid.

 DELIMITER $$

create procedure make_payment(
	in bid int,
    in amount decimal(10,2)
)
begin
	insert into payments(bill_id, amount_paid, payment_date)
    values(bid, amount, current_date());
end $$

DELIMITER ;
