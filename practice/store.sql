DROP TABLE IF EXISTS Store;

CREATE TABLE Store (
    id INT PRIMARY KEY,
    name VARCHAR(50),         -- store name
    product_name VARCHAR(50), -- product sold
    quantity INT,
    price NUMERIC(10,2)
);

INSERT INTO Store (id, name, product_name, quantity, price)
VALUES
(1, 'MegaMart', 'Laptop', 3, 55000.00),
(2, 'TechWorld', 'Mouse', 10, 500.00),
(3, 'ShopEase', 'Keyboard', 5, 1200.00),
(4, 'MegaMart', 'Monitor', 2, 9500.00),
(5, 'ShopEase', 'Laptop', 1, 58000.00),
(6, 'GadgetHub', 'Headphones', 4, 2500.00),
(7, 'MegaMart', 'Mouse', 6, 550.00),
(8, 'TechWorld', 'Keyboard', 3, 1300.00),
(9, 'GadgetHub', 'Laptop', 2, 56000.00),
(10, 'ShopEase', 'Monitor', 1, 9000.00),
(11, 'TechWorld', 'Headphones', 3, 2400.00),
(12, 'MegaMart', 'Keyboard', 2, 1100.00),
(13, 'ShopEase', 'Mouse', 7, 600.00),
(14, 'GadgetHub', 'Monitor', 2, 9100.00),
(15, 'TechWorld', 'Laptop', 1, 57000.00);

SELECT * FROM Store;

-- Find stores whose sales are better than avg sales accross all stores
SELECT name,
    SUM(quantity * price) AS total_sales
FROM store
GROUP BY name
HAVING SUM(quantity * price)  > (
        SELECT AVG(avg_sale)
        FROM (
                SELECT AVG(quantity * price) AS avg_sale
                FROM Store
                GROUP BY name
            )
);

-- find avg sale accross each store
SELECT name, AVG(quantity * price)
FROM Store
GROUP BY name;


SELECT AVG(avg_sale) 
FROM (
    SELECT AVG(quantity * price) AS avg_sale
    FROM Store
    GROUP BY name
);

