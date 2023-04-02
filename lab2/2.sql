----------TASK 2----------
DROP SEQUENCE STUDENTS_SEQUENCE;
DROP SEQUENCE GROUPS_SEQUENCE;

CREATE SEQUENCE students_sequence
    START WITH 1    
    INCREMENT BY 1
    NOMAXVALUE;

CREATE SEQUENCE groups_sequence
    START WITH 1    
    INCREMENT BY 1
    NOMAXVALUE;

CREATE OR REPLACE TRIGGER check_unique_id_at_students_trigger
    BEFORE
    INSERT ON STUDENTS
    FOR EACH ROW
    DECLARE
        id_ NUMBER;
        exists_ EXCEPTION;
    BEGIN
        SELECT STUDENTS.ID INTO id_ FROM STUDENTS WHERE STUDENTS.ID = :NEW.ID;
            DBMS_OUTPUT.PUT_LINE('The id already exists' || :NEW.ID);
            raise exists_;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Successfully inserted!');
    END;

CREATE OR REPLACE TRIGGER check_unique_id_at_groups_trigger
    BEFORE
    INSERT ON GROUPS
    FOR EACH ROW
    DECLARE
        id_ NUMBER;
        exists_ EXCEPTION;
    BEGIN
        SELECT GROUPS.ID INTO id_ FROM GROUPS WHERE GROUPS.ID = :NEW.ID;
            DBMS_OUTPUT.PUT_LINE('The id already exists' || :NEW.ID);
            raise exists_;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Successfully inserted!');
    END;

CREATE OR REPLACE TRIGGER generate_students_id_trigger
    BEFORE
    INSERT ON STUDENTS 
    FOR EACH ROW
    BEGIN
        SELECT students_sequence.NEXTVAL
        INTO :new.id
        FROM DUAL;
    END;

CREATE OR REPLACE TRIGGER generate_groups_id_trigger
    BEFORE
    INSERT ON GROUPS
    FOR EACH ROW
    BEGIN
        SELECT groups_sequence.NEXTVAL
        INTO :new.id
        FROM DUAL;
    END;

CREATE OR REPLACE TRIGGER check_unique_student_name_at_groups_trigger
    BEFORE
    UPDATE OR INSERT ON GROUPS
    FOR EACH ROW
    DECLARE
        id_ NUMBER;
        exists_ EXCEPTION;
    BEGIN
        SELECT GROUPS.ID INTO id_ FROM GROUPS WHERE GROUPS.GROUP_name = :NEW.GROUP_name;
            DBMS_OUTPUT.PUT_LINE('The student_name already exists' || :NEW.GROUP_name);
            raise exists_;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Successfully inserted!');
    END;
