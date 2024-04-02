set echo on ;
alter session set "_oracle_script" = true ; 
drop user qlhs cascade ; 
/
create user qlhs identified by 123456 quota 20M on users ;
grant all privileges to qlhs ; 
/
