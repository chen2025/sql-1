-- Your code here
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS coffee_orders;

CREATE TABLE customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(40) NOT NULL,
    phone INTEGER(10) UNIQUE,
    email VARCHAR(255) UNIQUE,
    points INTEGER NOT NULL DEFAULT 5,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE coffee_orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    is_redeemed BOOLEAN DEFAULT 0,
    ordered_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    customer_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES customers (id)
);

-- A new customer joined the loyalty program with the following customer information:
INSERT INTO customers (name, phone) VALUES ('Rachel', 1111111111);

-- Rachel purchases a coffee
UPDATE customers SET points = points + 1 WHERE id = 1;
INSERT INTO coffee_orders (customer_id) VALUES (1);

-- Two new customers joined the loyalty program with the following customer information
INSERT INTO customers (name, email, phone) VALUES ('Monica', 'monica@friends.show', 2222222222), ('Phoebe', 'phoebe@friends.show', 3333333333);

-- Phoebe purchases three coffees.
UPDATE customers SET points = points + 3 WHERE id = 3;
INSERT INTO coffee_orders (customer_id) VALUES (3), (3), (3);

-- Rachel and Monica each purchase four coffees.
UPDATE customers SET points = points + 4 WHERE id = 1;
UPDATE customers SET points = points + 4 WHERE id = 2;
INSERT INTO coffee_orders (customer_id) VALUES (1), (1), (1), (1);
INSERT INTO coffee_orders (customer_id) VALUES (2), (2), (2), (2);

-- Monica wants to know her new point total.
-- SELECT name, points FROM customers WHERE id = 2;

-- Rachel wants to check her total points. Redeem her points for a coffee if she has enough points. If she doesn't, she wants to purchase a coffee
UPDATE customers SET points = points - 10 WHERE id = 1;
INSERT INTO coffee_orders (is_redeemed, customer_id) VALUES (1, 1);

-- Three new customers joined the loyalty program with the following customer information:
INSERT INTO customers (name, email) VALUES ('Joey', 'joey@friends.show'), ('Chandler', 'chandler@friends.show'), ('Ross', 'ross@friends.show');

-- Ross purchases six coffees
UPDATE customers SET points = points + 6 WHERE id = 6;
INSERT INTO coffee_orders (customer_id) VALUES (6), (6), (6), (6), (6), (6);

-- Monica purchases three coffees
UPDATE customers SET points = points + 3 WHERE id = 2;
INSERT INTO coffee_orders (customer_id) VALUES (2), (2), (2);

-- Phoebe wants to check her total points. Redeem her points for a coffee if she has enough points. If she doesn't, she wants to purchase a coffee
UPDATE customers SET points = points + 1 WHERE id = 3;
INSERT INTO coffee_orders (customer_id) VALUES (3);

-- Ross demands a refund for the last two coffees that he ordered. (Make sure you delete Ross's coffee orders and not anyone else's. Update his points to reflect the returned purchases.)
DELETE FROM coffee_orders ORDER BY customer_id DESC LIMIT 1;
DELETE FROM coffee_orders ORDER BY customer_id DESC LIMIT 1;
UPDATE customers SET points = points - 2 WHERE id = 6;

-- Joey purchases two coffees
UPDATE customers SET points = points + 2 WHERE id = 4;
INSERT INTO coffee_orders (customer_id) VALUES (4), (4);

-- Monica wants to check her total points. Redeem her points for a coffee if she has enough points. If she doesn't, she wants to purchase a coffee
UPDATE customers SET points = points - 10 WHERE id = 2;
INSERT INTO coffee_orders (is_redeemed, customer_id) VALUES (1, 2);

-- Chandler wants to delete his loyalty program account
DELETE FROM customers WHERE id = 5;

-- Ross wants to check his total points. Redeem his points for a coffee if he has enough points. If he doesn't, he wants to purchase a coffee
UPDATE customers SET points = points + 1 WHERE id = 6;
INSERT INTO coffee_orders (customer_id) VALUES (6);

-- Joey wants to check his total points. Redeem his points for a coffee if he has enough points. If he doesn't, he wants to purchase a coffee
UPDATE customers SET points = points + 1 WHERE id = 4;
INSERT INTO coffee_orders (customer_id) VALUES (4);

-- Phoebe wants to change her email to p_as_in_phoebe@friends.show
UPDATE customers SET email = 'p_as_in_phoebe@friends.show' WHERE id = 3;

SELECT * FROM customers;
SELECT * FROM coffee_orders;
