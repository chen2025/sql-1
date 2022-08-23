-- Your code here
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS relationships;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS parties;

CREATE TABLE employees (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    department VARCHAR(40),
    role VARCHAR(40),
    vacation_days DEFAULT 26
);

CREATE TABLE relationships (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    boyfriend_id INTEGER,
    girlfriend_id INTEGER,
    FOREIGN KEY (boyfriend_id, girlfriend_id) REFERENCES employees (id, id)
);

CREATE TABLE reviews (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    subject_id INTEGER,
    score INTEGER,
    FOREIGN KEY (subject_id) REFERENCES employees (id)
);

CREATE TABLE parties (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    budget INTEGER,
    onsite BOOLEAN
);


-- Add "" to your list of employees in the "" department in the role of ""
INSERT INTO employees (first_name, last_name, department, role) VALUES ('Michael', 'Scott', 'Management', 'Regional Manager'),
                                                                       ('Dwight', 'Schrute', 'Sales', 'Assistant Regional Manager'),
                                                                       ('Jim', 'Halpert', 'Sales', 'Sales Representative'),
                                                                       ('Pam', 'Beesly', 'Reception', 'Receptionist'),
                                                                       ('Kelly', 'Kapoor', 'Product Oversight', 'Customer Service Representative'),
                                                                       ('Angela', 'Martin', 'Accounting', 'Head of Accounting'),
                                                                       ('Roy', 'Anderson', 'Warehouse', 'Warehouse Staff');

-- "Roy Anderson" and "Pam Beesly" are in a romantic relationship
INSERT INTO relationships (boyfriend_id, girlfriend_id) VALUES ((SELECT id FROM employees WHERE first_name = 'Roy'), (SELECT id FROM employees WHERE first_name = 'Pam'));

-- "Ryan Howard" is hired in the "Reception" department as a "Temp" role
INSERT INTO employees (first_name, last_name, department, role) VALUES ('Ryan', 'Howard', 'Reception', 'Temp');

-- An onsite office party is scheduled with a budget of $100.00.
INSERT INTO parties (budget, onsite) VALUES (100, 1);

-- "Dwight Schrute" gets a performance review with a score of 3.3.
INSERT INTO reviews (subject_id, score) VALUES ((SELECT id FROM employees WHERE first_name = 'Dwight'), 3.3);

-- "Jim Halpert" gets a performance review with a score of 4.2
INSERT INTO reviews (subject_id, score) VALUES ((SELECT id FROM employees WHERE first_name = 'Jim'), 4.2);

-- "Dwight Schrute"'s past performance review needs to be changed to a score of 9.0
UPDATE reviews SET score = 9 WHERE subject_id = (SELECT id FROM employees WHERE first_name = 'Dwight');

-- "Jim Halpert"'s past performance review needs to be changed to a score of 9.3
UPDATE reviews SET score = 9.3 WHERE subject_id = (SELECT id FROM employees WHERE first_name = 'Jim');

-- "Jim Halpert" is promoted to the role of "Assistant Regional Manager".
UPDATE employees SET role = 'Assistant Regional Manager' WHERE id = (SELECT id FROM employees WHERE first_name = 'Jim');

-- "Ryan Howard" is promoted to the "Sales" department as the role of "Sales Representative".
UPDATE employees SET department = 'Sales', role = 'Sales Representative' WHERE id = (SELECT id FROM employees WHERE first_name = 'Ryan');

-- An onsite office party is scheduled with a budget of $200.00.
INSERT INTO parties (budget, onsite) VALUES (200, 1);

-- "Angela Martin" and "Dwight Schrute" are in a romantic relationship.
INSERT INTO relationships (boyfriend_id, girlfriend_id) VALUES ((SELECT id FROM employees WHERE first_name = 'Angela'), (SELECT id FROM employees WHERE first_name = 'Dwight'));

-- "Angela Martin" gets a performance review score of 6.2.
INSERT INTO reviews (subject_id, score) VALUES ((SELECT id FROM employees WHERE first_name = 'Angela'), 6.2);

-- "Ryan Howard" and "Kelly Kapoor" are in a romantic relationship.
INSERT INTO relationships (boyfriend_id, girlfriend_id) VALUES ((SELECT id FROM employees WHERE first_name = 'Ryan'), (SELECT id FROM employees WHERE first_name = 'Kelly'));

-- An onsite office party is scheduled with a budget of $50.00.
INSERT INTO parties (budget, onsite) VALUES (50, 1);

-- "Jim Halpert" moves to another office branch (make sure to remove his relationships and performance reviews if he has any).
DELETE FROM employees WHERE id = (SELECT id FROM employees WHERE first_name = 'Jim');
DELETE FROM reviews WHERE subject_id = (SELECT id FROM employees WHERE first_name = 'Jim');
DELETE FROM relationships WHERE boyfriend_id = (SELECT id FROM employees WHERE first_name = 'Jim');

-- "Roy Anderson" and "Pam Beesly" are NO LONGER in a romantic relationship.
DELETE FROM relationships WHERE girlfriend_id = (SELECT id FROM employees WHERE first_name = 'Pam');

-- "Pam Beesly" gets a performance review score of 7.6.
INSERT INTO reviews (subject_id, score) VALUES ((SELECT id FROM employees WHERE first_name = 'Pam'), 7.6);

-- "Dwight Schrute" gets another performance review score of 8.7.
INSERT INTO reviews (subject_id, score) VALUES ((SELECT id FROM employees WHERE first_name = 'Dwight'), 8.7);

-- "Ryan Howard" quits the office (make sure to remove his relationships and performance reviews if he has any).
DELETE FROM employees WHERE id = (SELECT id FROM employees WHERE first_name = 'Ryan');
DELETE FROM reviews WHERE subject_id = (SELECT id FROM employees WHERE first_name = 'Ryan');
DELETE FROM relationships WHERE boyfriend_id = (SELECT id FROM employees WHERE first_name = 'Ryan');

-- "Jim Halpert" moves back to this office branch's "Sales" department in the role of "Sales Representative"
-- "Karen Filippelli" moves from a different office into this office's "Sales" department in the role of "Sales Representative"
INSERT INTO employees (first_name, last_name, department, role) VALUES ('Jim', 'Halpert', 'Sales', 'Sales Representative'),
                                                                       ('Karen', 'Filippelli', 'Sales', 'Sales Representative');

-- "Karen Filippelli" and "Jim Halpert" are in a romantic relationship.
INSERT INTO relationships (boyfriend_id, girlfriend_id) VALUES ((SELECT id FROM employees WHERE first_name = 'Jim'), (SELECT id FROM employees WHERE first_name = 'Karen'));

-- An onsite office party is scheduled with a budget of $120.00.
INSERT INTO parties (budget, onsite) VALUES (120, 1);

-- The onsite office party scheduled right before this is canceled, and an offsite office party is scheduled instead with a budget of $300.00.
DELETE FROM parties WHERE budget = 120;
INSERT INTO parties (budget, onsite) VALUES (300, 0);

-- "Karen Filippelli" and "Jim Halpert" are NO LONGER in a romantic relationship.
DELETE FROM relationships WHERE boyfriend_id = (SELECT id FROM employees WHERE first_name = 'Jim');

-- "Pam Beesly" and "Jim Halpert" are in a romantic relationship.
INSERT INTO relationships (boyfriend_id, girlfriend_id) VALUES ((SELECT id FROM employees WHERE first_name = 'Jim'), (SELECT id FROM employees WHERE first_name = 'Pam'));
