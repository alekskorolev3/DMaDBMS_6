CREATE OR REPLACE TRIGGER c_val_update
    AFTER INSERT OR UPDATE OR DELETE
    ON STUDENTS
    FOR EACH ROW
DECLARE
    pragma autonomous_transaction;
BEGIN
    IF INSERTING THEN
        UPDATE GROUPS SET C_VAL = C_VAL + 1 WHERE id = :new.group_id;
        commit;
    END IF;
    IF UPDATING THEN
        UPDATE GROUPS SET C_VAL = C_VAL - 1 WHERE id = :old.group_id;
        commit;
        UPDATE GROUPS SET C_VAL = C_VAL + 1 WHERE id = :new.group_id;
        commit;
    END IF;
    IF DELETING THEN
        UPDATE GROUPS SET C_VAL = C_VAL - 1 WHERE id = :old.group_id;
        commit;
    END IF;
END;
