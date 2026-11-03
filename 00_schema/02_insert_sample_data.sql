INSERT INTO departments VALUES (10, 'IT & Development');
INSERT INTO departments VALUES (20, 'Human Resources');
INSERT INTO departments VALUES (30, 'Finance');

INSERT INTO employees VALUES (101, 'Rugira', 'Gyslain', 1200000, 10);
INSERT INTO employees VALUES (102, 'Alice', 'Umutoni', 950000, 10);
INSERT INTO employees VALUES (103, 'John', 'Doe', 800000, 20);
INSERT INTO employees VALUES (104, 'Jane', 'Smith', 1500000, 30);

INSERT INTO performance_reviews VALUES (1, 101, 5, SYSDATE);
INSERT INTO performance_reviews VALUES (2, 102, 4, SYSDATE);
INSERT INTO performance_reviews VALUES (3, 103, 2, SYSDATE);

COMMIT;