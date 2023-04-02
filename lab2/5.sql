CREATE OR REPLACE PROCEDURE restore_students(time_back TIMESTAMP) IS
BEGIN
    execute immediate 'alter trigger c_val_update disable';
    execute immediate 'alter trigger student_logger disable';
    execute immediate 'alter trigger generate_groups_id_trigger disable';
    execute immediate 'alter trigger generate_students_id_trigger disable';
    execute immediate 'alter trigger check_unique_id_at_groups_trigger disable';
    execute immediate 'alter trigger check_unique_id_at_students_trigger disable';
    FOR action IN (SELECT * FROM students_logging WHERE time_back < date_exec ORDER BY id DESC) 
    LOOP
        IF action.operation = 'INSERT' THEN
            DELETE FROM STUDENTS WHERE id = action.new_student_id;
        END IF;
        IF action.operation = 'UPDATE' THEN
            UPDATE STUDENTS SET
            id = action.old_student_id,
            name = action.old_student_name,
            group_id = action.old_studenr_group_id
            WHERE id = action.new_student_id;
        END IF;
        IF action.operation = 'DELETE' THEN
            INSERT INTO students VALUES (action.old_student_id, action.old_student_name, action.old_studenr_group_id);
        END IF;
    END LOOP;
    execute immediate 'alter trigger c_val_update enable';
    execute immediate 'alter trigger student_logger enable';
    execute immediate 'alter trigger generate_groups_id_trigger enable';
    execute immediate 'alter trigger generate_students_id_trigger enable';
    execute immediate 'alter trigger check_unique_id_at_groups_trigger enable';
    execute immediate 'alter trigger check_unique_id_at_students_trigger enable';
END;

--restore_students(TO_TIMESTAMP('09-Feb-02 01.19.05.0000000 PM'));
