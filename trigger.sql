--  Useful Triggers for Hospital Management System

-- 1. Auto-update Billing status to 'Paid' when full payment is made

DELIMITER $$

create trigger trg_update_billing_status
after insert on payments
for each row
begin
	declare total decimal(10,2);
    declare paid decimal(10,2);
    
-- Get total bill amount
select total_amount into total
from billing
where bill_id = new.bill_id;

-- get total paid so far
select sum(amount_paid) into paid
from payments
where bill_id = new.bill_id;

-- If full paid, update status
if paid >= total then
		update billing
        set	status = 'Paid'
        where bill_id = new.bill_id;
	end if;
end $$

DELIMITER ;

-- 2. Prevent inserting a medical record if the appointment isn’t completed

DELIMITER $$

create trigger trg_prevent_early_medical_records
before insert on medical_records
for each row
begin
	declare appt_status ENUM('Scheduled', 'Completed', 'Cancelled');
        
select status into appt_status
from appointment
where appointment_id = new.appointment_id;

if appt_status <> 'Completed' then
		signal sqlstate '45000'
        set	message_text = 'Cannot insert medical record: Appointment not completed yet';
	end if;
end $$

DELIMITER ;

-- 3. Create Trigger to Log Deleted Patients

DELIMITER $$

create trigger trg_log_delete_patients
before delete on patients
for each row
begin
	insert into Deleted_Patients_Log (
		patient_id, name, gender, birth_date, phone, address
	) Values (
		old.patient_id,
        old.name,
        old.gender,
        old.birth_date,
        old.phone,
        old.address
        );

end $$

DELIMITER ;