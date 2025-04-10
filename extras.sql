
-- trigger testing ---

select* from patients;

delete from patients
where patient_id = 203;

select* from Deleted_Patients_Log;

-- this will give an error code of 1451 due to foreign key implementation, for bypass it you have to delete the child records first---
