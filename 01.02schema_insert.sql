INSERT INTO users (first_name, last_name, email, created_at, country) VALUES
('Carlos', 'Silva', 'carlos@email.com', '2022-01-15', 'Brazil'),
('John', 'Doe', 'john@email.com', '2023-05-20', 'USA'),
('Mariana', 'Costa', 'mariana@email.com', '2021-11-10', 'Brazil'),
('Jane', 'Smith', 'jane@email.com', '2024-02-01', 'USA'),
('Pedro', 'Santos', 'pedro@email.com', '2023-08-05', 'Brazil');


INSERT INTO products (category, product_name) VALUES
('Electronics', 'Smartphone X'),
('Electronics', 'Wireless Mouse'),
('Apparel', 'Cotton T-Shirt'),
('Apparel', 'Jeans'),
('Books', 'SQL for Data Engineering');


INSERT INTO orders (user_id, order_date, status, payment_method) VALUES
(1, date('now', '-10 days'), 'completed', 'credit_card'),
(1, date('now', '-5 days'), 'completed', 'pix'),
(2, date('now', '-120 days'), 'completed', 'credit_card'),
(3, date('now', '-15 days'), 'completed', 'credit_card'),
(3, date('now', '-14 days'), 'cancelled', 'pix'),
(4, date('now', '-45 days'), 'completed', 'paypal'),
(5, date('now', '-200 days'), 'completed', 'credit_card'),
(5, date('now', '-190 days'), 'refunded', 'credit_card');


INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1200.00), 
(1, 2, 2, 50.00),   
(2, 1, 1, 1200.00), 
(3, 5, 3, 40.00),  
(4, 3, 5, 30.00),   
(4, 4, 2, 80.00),  
(5, 1, 1, 1200.00), 
(6, 3, 4, 30.00),   
(6, 4, 3, 80.00),   
(7, 2, 1, 50.00),   
(8, 1, 1, 1200.00); 