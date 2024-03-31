set echo on ; 

alter session set "_oracle_script" = true ; 

conn sys/123456 as sysdba ; 

create role Student ; 

grant select on qlhs.Course to Student ; 
grant select on qlhs.Prerequisite to Student ; 

-- chuyen vien dao tao 

create role training_specialist ; 
grant insert on Course to training_specialist ; 
grant update on Course to training_specialist; 
grant delete on Course to training_specialist; 
 
grant insert on Prerequisite to training_specialist ; 
grant update on Prerequisite to training_specialist; 
grant delete on Prerequisite to training_specialist; 

grant insert on SECTION to training_specialist ; 
grant update on SECTION to training_specialist; 
grant delete on SECTION to training_specialist; 

grant update (Major) on Student to training_specialist;

-- nhan vien khao thi 

create role exam_staff ; 

grant update (Grade) on Grade_report to exam_staff ; 

-- Chuyen vien cong tac sinh vien 
create role student_services_specialist ; 
grant insert on Student to student_services_specialist;

-- giao vu

create role academics ; 
grant select on Student to academics; 
grant select on Section to academics; 
grant select on Course to academics; 
grant select on Grade to academics; 
grant select on GRADE_REPORT to academics; 
grant select on Prerequisite to academics

