CREATE OR REPLACE FUNCTION func_get_dept_payroll (
    p_dept_id IN NUMBER
) RETURN NUMBER IS
    v_total_payroll NUMBER := 0;
    v_emp_salary employees.salary%TYPE;
    
    -- Explicit Cursor
    CURSOR c_emp_salaries IS
        SELECT salary FROM employees WHERE dept_id = p_dept_id;
BEGIN
    OPEN c_emp_salaries;
    LOOP
        FETCH c_emp_salaries INTO v_emp_salary;
        EXIT WHEN c_emp_salaries%NOTFOUND;
        
        v_total_payroll := v_total_payroll + v_emp_salary;
    END LOOP;
    CLOSE c_emp_salaries;
    
    IF v_total_payroll = 0 THEN
        -- Using predefined exception logic intentionally for demonstration
        RAISE NO_DATA_FOUND;
    END IF;

    RETURN v_total_payroll;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employees found in Department ' || p_dept_id);
        RETURN 0;
    WHEN OTHERS THEN
        IF c_emp_salaries%ISOPEN THEN
            CLOSE c_emp_salaries;
        END IF;
        RAISE_APPLICATION_ERROR(-20003, 'Error calculating payroll: ' || SQLERRM);
END;
/