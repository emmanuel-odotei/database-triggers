--1
SELECT *
FROM customers
ORDER BY customer_id;
 
SELECT *
FROM customers_log;
--2
CREATE TRIGGER customer_table_updated
BEFORE UPDATE ON customers
FOR EACH ROW
EXECUTE PROCEDURE log_customers_change();
--3
UPDATE customers
SET first_name = 'Bruno'
WHERE last_name = 'Lewis';

SELECT *
FROM customers
ORDER BY customer_id;
 
SELECT *
FROM customers_log;
--4
UPDATE customers
SET years_old = 15
WHERE last_name = 'Lewis';
 
SELECT *
FROM customers
ORDER BY customer_id;
 
SELECT *
FROM customers_log;
--5
CREATE TRIGGER customer_insert
AFTER INSERT ON customers
FOR EACH STATEMENT
EXECUTE PROCEDURE log_customers_change();
--6
INSERT INTO customers (first_name,last_name,years_old,city)
VALUES
  ('Jeffrey','Cook',66, 'New York'),
  ('Niel','Armstrong',35, 'Accra'),
  ('Bruce','Wellis',42, 'Tokyo');
 
SELECT *
FROM customers
ORDER BY customer_id;
 
SELECT *
FROM customers_log;
--7
CREATE TRIGGER customer_min_age
BEFORE UPDATE ON customers
FOR EACH ROW
WHEN (NEW.years_old < 13)
EXECUTE PROCEDURE override_with_min_age();
--8
UPDATE customers
SET years_old = 12
WHERE last_name = 'Campbell';
 
UPDATE customers
SET years_old = 24
WHERE last_name = 'Cook';
 
SELECT *
FROM customers
ORDER BY customer_id;
 
SELECT *
FROM customers_log;
--9
UPDATE customers
SET years_old = 9,
    first_name = 'Dennis'
WHERE last_name = 'Hall';
 
SELECT *
FROM customers
ORDER BY customer_id;
 
SELECT *
FROM customers_log;
--10
DROP TRIGGER IF EXISTS customer_min_age ON customers;
--11
SELECT * FROM information_schema.triggers;