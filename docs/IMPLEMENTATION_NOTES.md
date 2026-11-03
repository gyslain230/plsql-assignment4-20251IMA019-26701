# Implementation and Performance Notes

## 1. Collections & Bulk Processing
Row-by-row processing (context switching between the PL/SQL engine and the SQL engine) is notoriously slow for large datasets. In `proc_apply_bulk_bonus.sql`, we implemented `BULK COLLECT` to fetch all eligible employee IDs in a single context switch and populate a nested table collection. 

We then utilized the `FORALL` statement to bind the entire collection array to the `UPDATE` DML statement. This bulk DML drastically reduces context switching overhead, heavily optimizing performance compared to a standard `CURSOR FOR` loop.

## 2. Records Integration
In `proc_manage_employee.sql`, we utilized both a user-defined record (`emp_audit_rec`) to group logically related variables together for tracking changes, and a `%ROWTYPE` record to instantly map to the structure of the `employees` table without hardcoding data types. 

## 3. Exception Handling Strategy
- **Predefined Exceptions:** Used `NO_DATA_FOUND` to gracefully handle queries that return empty sets, preventing the application from crashing.
- **User-Defined Exceptions:** Created `ex_invalid_percentage` to enforce business logic (bonus cannot exceed 50%).
- **RAISE_APPLICATION_ERROR:** Utilized to pass meaningful, custom error codes (e.g., `-20001`) and messages back to the calling environment.