SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- ERROR TEST 1: Invalid Employee ID (NO_DATA_FOUND) ---');
    proc_update_employee_salary(999, 500000);
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- ERROR TEST 2: Invalid Bonus Percentage (RAISE_APPLICATION_ERROR) ---');
    BEGIN
        proc_apply_bulk_bonus(4, 150); -- 150% is over the 50% limit
    EXCEPTION 
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Caught Exception: ' || SQLERRM);
    END;
END;
/