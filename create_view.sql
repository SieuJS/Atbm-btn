set echo on ; /
alter session set current_schema = QLHS;
alter session set  "_oracle_script" = true; 
set pause off; 

drop view vw_student_infor_17 ;
drop view  vw_student_info_8 ;
drop view vw_student_section_infor  ;

-- xem thong tin ban than

create  view vw_student_infor_17 
as select * from qlhs.Student where Student_number = '17';

create view vw_student_info_8 
as select * from qlhs.Student where Student_number = '8';

-- xem thong tin section 

create view vw_student_section_infor 
as select Section_identifier , Course_number , Semester, Year from Section ;

