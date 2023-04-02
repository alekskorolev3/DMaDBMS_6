DROP TABLE students_logging;

CREATE TABLE students_logging
(
    id NUMBER PRIMARY KEY,
    operation VARCHAR2(10) NOT NULL,
    date_exec TIMESTAMP NOT NULL,
    new_student_id NUMBER,
    new_student_name VARCHAR2(100),
    new_studenr_group_id NUMBER,
    old_student_id NUMBER,
    old_student_name VARCHAR2(100),
    old_studenr_group_id NUMBER
);

CREATE OR REPLACE TRIGGER student_logger 
AFTER INSERT OR UPDATE OR DELETE 
ON STUDENTS FOR EACH ROW
DECLARE
    TEMP_ID NUMBER;
BEGIN
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM students_logging' INTO TEMP_ID;
    CASE
    WHEN INSERTING THEN
        INSERT INTO students_logging VALUES(TEMP_ID+1, 'INSERT', SYSTIMESTAMP, :new.id, :new.student_name, :new.group_id, NULL, NULL, NULL);
    WHEN UPDATING THEN
        INSERT INTO students_logging VALUES(TEMP_ID+1, 'UPDATE', SYSTIMESTAMP, :new.id, :new.student_name, :new.group_id, :old.id, :old.student_name, :old.group_id);
    WHEN DELETING THEN
        INSERT INTO students_logging VALUES(TEMP_ID+1, 'DELETE', SYSTIMESTAMP, NULL, NULL, NULL, :old.id, :old.student_name, :old.group_id);
    END CASE;
END;
