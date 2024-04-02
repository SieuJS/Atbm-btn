set echo on ; /

CONN QLHS/123456 ; 

alter session set current_schema = QLHS;
alter session set  "_oracle_script" = true; 
set pause off; 

-- SET VIEW FOR STUDENT ; 

-- XEM BANG SECION TRU TRUONG INSTRUCTOR ; 

CREATE OR REPLACE VIEW VW_STUDENT_ON_SECTION 
AS
SELECT SECTION_IDENTIFIER , COURSE_NUMBER , SEMESTER , YEAR FROM SECTION ; 
/

-- XEM BANG COURSE, PREREQUISITE 

CREATE OR REPLACE VIEW VW_STUDENT_ON_COURSE 
AS 
SELECT * FROM COURSE ; 
/

CREATE OR REPLACE VIEW VW_STUDENT_ON_PREREQUISITE 
AS 
SELECT * FROM PREREQUISITE ; 
/

--XEM THONG TIN LIEN QUAN DEN BAN THAN TREN BANG STUDENT ; 

CREATE OR REPLACE VIEW VW_STUDENT_ON_STUDENT 
AS 
SELECT * FROM STUDENT WHERE 
'RL_QLHS_STUDENT_' || STUDENT_NUMBER = SYS_CONTEXT('USERENV' , 'SESSION_USER');
/

-- XEM DONG DU LIEU LIEN QUAN TOI BAN THAN GRADE_REPORT ; 
CREATE OR REPLACE VIEW VW_STUDENT_ON_GRADE_REPORT 
AS 
SELECT * FROM GRADE_REPORT WHERE 
'RL_QLHS_STUDENT_' || STUDENT_NUMBER = SYS_CONTEXT('USERENV' , 'SESSION_USER');

-- THEM THONG TIN TREN GRADE_REPORT 
CREATE OR REPLACE NONEDITIONABLE TRIGGER TRG_STUDENT_INSERT_ON_GRADE_REPORT
    INSTEAD OF INSERT ON VW_STUDENT_ON_GRADE_REPORT
    FOR EACH ROW 
DECLARE 
    STUDENT_USER NUMBER ;
    TXT EXCEPTION ; 
    ERR_MSG VARCHAR(200);
    START_ENROLL DATE ; 
    END_ENROLL DATE ; 
    CUR_DATE_ENROLL DATE ;
    STRSQL VARCHAR(200);
BEGIN 
    STRSQL := 'ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE' ; 
    EXECUTE IMMEDIATE (STRSQL) ; 
    STUDENT_USER := TO_NUMBER (REPLACE (SYS_CONTEXT('USERENV' , 'SESSION_USER'), 'RL_QLHS_STUDENT_', ''),'999');
    INSERT INTO GRADE_REPORT (STUDENT_NUMBER , SECTION_IDENTIFIER, GRADE)
    VALUES (STUDENT_USER, :NEW.SECTION_IDENTIFIER, NULL);
END ;
        
-- XEM THONG TIN TREN BANG SESSION CUA GIAO VIEN 
CREATE OR REPLACE VIEW VW_INSTRUCTOR_ON_SECTION 
AS 
SELECT * FROM SECTION WHERE 
'RL_QLHS_INSTRUCTOR_' || INSTRUCTOR =  SYS_CONTEXT('USERENV' , 'SESSION_USER');

-- XEM THONG TIN  TREN BANG GRADE CUA GIAO VIEN 
CREATE OR REPLACE VIEW VW_INSTRUCTOR_ON_GRADE 
AS 
SELECT * FROM GRADE_REPORT WHERE 
SECTION_IDENTIFIER IN (
    SELECT SECTION_IDENTIFIER FROM SECTION WHERE 
'RL_QLHS_INSTRUCTOR_' || INSTRUCTOR =  SYS_CONTEXT('USERENV' , 'SESSION_USER'));