CREATE OR REPLACE PROCEDURE proc_apply_bulk_bonus (
    p_rating_threshold IN NUMBER,
    p_bonus_percentage IN NUMBER
) IS
    -- Collection definition
    TYPE emp_id_list IS TABLE OF employees.emp_id%TYPE;
    v_eligible_emps emp_id_list;
    
    -- User-defined exception
    ex_invalid_percentage EXCEPTION;
    
BEGIN
    IF p_bonus_percentage <= 0 OR p_bonus_percentage > 50 THEN
        RAISE ex_invalid_percentage;
    END IF;

    -- Bulk Collect to retrieve multiple rows into a collection
    SELECT e.emp_id 
    BULK COLLECT INTO v_eligible_emps
    FROM employees e
    JOIN performance_reviews p ON e.emp_id = p.emp_id
    WHERE p.rating >= p_rating_threshold;

    -- Bulk Processing for performance
    IF v_eligible_emps.COUNT > 0 THEN
        FORALL i IN 1..v_eligible_emps.COUNT
            UPDATE employees
            SET salary = salary + (salary * (p_bonus_percentage / 100))
            WHERE emp_id = v_eligible_emps(i);
            
        DBMS_OUTPUT.PUT_LINE('Bonus applied to ' || SQL%ROWCOUNT || ' employees.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No employees met the threshold.');
    END IF;
    
    COMMIT;

EXCEPTION
    WHEN ex_invalid_percentage THEN
        RAISE_APPLICATION_ERROR(-20001, 'Bonus percentage must be between 1 and 50.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'An unexpected error occurred during bulk processing: ' || SQLERRM);
END;
/