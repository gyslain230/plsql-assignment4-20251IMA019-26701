SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- TEST 1: Calculate Department Payroll (Explicit Cursor) ---');
    DBMS_OUTPUT.PUT_LINE('Total Payroll for IT (Dept 10): ' || func_get_dept_payroll(10));
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- TEST 2: Update Employee Salary (Implicit Cursor & Records) ---');
    proc_update_employee_salary(101, 1350000);
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- TEST 3: Apply Bulk Bonus (Bulk Collect & FORALL) ---');
    -- Apply 10% bonus to anyone with a rating of 4 or higher
    proc_apply_bulk_bonus(4, 10);
END;
/