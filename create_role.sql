set echo on ; 

alter session set "_oracle_script" = true ; 

conn sys/123456 as sysdba ; 

create role Student ; 

grant select on qlhs.Course to Student ; 
grant select on qlhs.Prerequisite to Student ; 

create role 