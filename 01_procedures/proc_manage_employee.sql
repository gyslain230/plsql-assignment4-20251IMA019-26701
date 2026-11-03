CREATE OR REPLACE PROCEDURE proc_update_employee_salary (
    p_emp_id IN NUMBER,
    p_new_salary IN NUMBER
) IS
    -- User-defined Record
    TYPE emp_audit_rec IS RECORD (
        emp_id employees.emp_id%TYPE,
        old_salary employees.salary%TYPE,
        new_salary employees.salary%TYPE
    );
    v_audit emp_audit_rec;
    
    v_current_emp employees%ROWTYPE; -- %ROWTYPE demonstration
BEGIN
    -- Fetch current data
    SELECT * INTO v_current_emp FROM employees WHERE emp_id = p_emp_id;
    
    v_audit.emp_id := p_emp_id;
    v_audit.old_salary := v_current_emp.salary;
    v_audit.new_salary := p_new_salary;
    
    -- Implicit Cursor usage
    UPDATE employees 
    SET salary = p_new_salary 
    WHERE emp_id = p_emp_id;
    
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Updated salary for ' || v_current_emp.first_name || '. Rows affected: ' || SQL%ROWCOUNT);
    END IF;
    
    COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Employee ID ' || p_emp_id || ' does not exist.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/