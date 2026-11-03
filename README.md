# Employee Performance & Payroll Management System

**Course:** Database Development with PL/SQL (INSY 8311)  
**Institution:** Adventist University of Central Africa (AUCA)  

## Group Members
* **Student 1:** Rugira Gyslain (ID: [Insert ID])
* **Student 2:** [Insert Name] (ID: [Insert ID])

## Application Description
This Oracle PL/SQL application manages employee records, department payrolls, and performance-based bonuses. It demonstrates advanced database programming techniques, including:
* **Records:** User-defined records and `%ROWTYPE` for data structuring.
* **Collections:** Nested tables for bulk data manipulation.
* **Cursors:** Implicit cursors for DML tracking and Explicit cursors for multi-row fetches.
* **Bulk Processing:** `BULK COLLECT` and `FORALL` for optimized performance during bonus applications.
* **Exception Handling:** Predefined, user-defined, and application errors.

## How to Run
1. Execute `00_schema/01_create_tables.sql`
2. Execute `00_schema/02_insert_sample_data.sql`
3. Compile `01_procedures/proc_apply_bulk_bonus.sql` and `proc_manage_employee.sql`
4. Compile `02_functions/func_get_dept_payroll.sql`
5. Run the test scripts in `03_tests/` and verify the outputs.