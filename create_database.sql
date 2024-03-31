set echo on ;
alter session set "_oracle_script" = true ; 

create user qlhs identified by 123456 quota 20M on users ; /
grant connect, resource to qlhs ; /

grant create table to qlhs ;

grant create view to qlhs ; 
