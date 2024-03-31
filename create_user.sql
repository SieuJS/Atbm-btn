set echo on ; 
show user ;
alter session set "_oracle_script" = true ;

create user Smith identified by 123 quota 2M on users ; /
create user Brown identified by 123 quota 2M on users; /

grant connect to Smith ;/
grant connect to Brown; /

grant select on qlhs.vw_student_personal to Smith;/
grant update on qlhs.vw_student_personal to Smith;/