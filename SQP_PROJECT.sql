Create database ecommerce_project;
use ecommerce_project;

---CUSTOMERS TABLE
create table customers(customer_id int,
                       customer_name varchar(30),
					   city varchar(30));
alter table customers  add constraint pk  primary key (customer_id);
alter table customers alter COLUMN customer_id int  not null
INSERT INTO customers VALUES
(1, 'Amit Sharma', 'Hyderabad'),
(2, 'Priya Reddy', 'Bangalore'),
(3, 'Rahul Verma', 'Mumbai'),
(4, 'Sneha Iyer', 'Chennai'),
(5, 'Arjun Patel', 'Ahmedabad'),
(6, 'Neha Singh', 'Delhi'),
(7, 'Kiran Kumar', 'Hyderabad'),
(8, 'Pooja Mehta', 'Pune'),
(9, 'Ravi Teja', 'Hyderabad'),
(10, 'Anjali Das', 'Kolkata'),
(11, 'Vikram Rao', 'Bangalore'),
(12, 'Divya Nair', 'Chennai'),
(13, 'Suresh Babu', NULL),
(14, 'Meena Gupta', 'Delhi'),
(15, 'Raj Malhotra', 'Mumbai');

--ORDERS TABLE
create table orders(order_id int primary key,
                    customer_id int,order_date DATE,
					amount int,
					foreign key(customer_id)references customers(customer_id));
INSERT INTO orders VALUES
(101, 1, '2024-01-10', 5000),
(102, 2, '2024-01-12', 3000),
(103, 3, '2024-01-15', 7000),
(104, 1, '2024-02-01', 2000),
(105, 4, '2024-02-05', 4500),
(106, 5, '2024-02-10', 6000),
(107, 6, '2024-02-12', NULL),
(108, 7, '2024-03-01', 3500),
(109, 8, '2024-03-05', 4000),
(110, 9, '2024-03-10', 2500),
(111, 10, '2024-03-15', 8000),
(112, 2, '2024-03-18', 3000),
(113, 3, '2024-03-20', 7000),  -- duplicate amount
(114, 11, '2024-04-01', 9000),
(115, 12, '2024-04-05', 1000),
(116, 13, '2024-04-08', 2000),
(117, 14, '2024-04-10', 7500),
(118, 15, '2024-04-12', 5000),
(119, 1, '2024-04-15', 5000), -- repeat customer
(120, 5, '2024-04-18', 6000);

---PRODUCTS TABLE
create table products(product_id int primary key,
                       product_name varchar(30),
					   product_price int);
INSERT INTO products VALUES
(201, 'Laptop', 60000),
(202, 'Mobile', 20000),
(203, 'Headphones', 2000),
(204, 'Keyboard', 1500),
(205, 'Mouse', 800),
(206, 'Monitor', 12000),
(207, 'Tablet', 25000),
(208, 'Printer', 10000),
(209, 'Speaker', NULL),
(210, 'Camera', 45000);

select * from customers;
select * from orders;
select * from products;
-- Hyderabad customers or chennai customers;
select * from customers where city in('Hyderabad' , 'Chennai')
-- Orders with NULL amount
select *from orders where amount is null;
-- Customer name + order amount (JOIN)
select c.customer_name,o.amount from customers c join  orders o on c.customer_id=o.customer_id;
 
---- SQL PROJECT – PRACTICE QUERIES
select * from customers;
select *from orders;
select * from products;

--- BASIC LEVEL
--Show customers where city is NULL
select customer_name from customers where city is null;
---Show orders where amount is greater than 5000
select * from orders where amount>5000;
--Show orders where amount is NULL
select * from orders where amount is null;
--Show products with price greater than 20000
select product_name from products where product_price >20000;
---Show products where price is NULL
select* from products where product_price is null;
---Sort customers by name in ascending order
select * from customers order by customer_name asc;

select * from customers;
select *from orders;
select * from products;

--- INTERMEDIATE LEVEL
--Display customer name and their order amount
select c.customer_name,o.amount from customers c left join orders o on c.customer_id=o.customer_id;
--Show all orders with customer city
select o.order_id,c.city from orders o left join customers c on o.customer_id=c.customer_id;
--Count total number of customers
select count(*)from customers;
--Count total number of orders
select count(order_id) from orders;
select count(*) from orders ;
---Find total revenue (sum of amount)
select sum(amount) from orders;
--Find average order amount
select avg(amount)as avg_order_amount from orders;
--Find highest order amount
select top 1 * from orders order by amount desc;
--Find lowest order amount
select min(amount)from orders;
---Show total orders per customer
select c.customer_name,sum(o.order_id)as total_orders_percustomer from customers c inner join orders o on c.customer_id=o.customer_id group by c.customer_name;
--Show total amount spent by each customer
select c.customer_name,sum(o.amount)as total_amount_spentby_customer from customers c left join orders o on c.customer_id=o.customer_id group by c.customer_name;
--Show customers who placed more than 1 order
--select c.customer_name from customers c left join orders o on c.customer_id=o.customer_id where o.order_id>1
select c.customer_name,count(o.order_id)from customers c left join orders o on c.customer_id=o.customer_id group by c.customer_name having count(o.order_id)>1;
--Show customers who never placed any order
select c.customer_name from customers c  join orders o on c.customer_id=o.customer_id where o.order_id is null;
--Show orders placed in March 2024
select * from orders where month(order_date)=3 and year(order_date)=2024;
select * from orders where order_date between '2024-3-1' and '2024-3-31';
--Show customers whose name starts with 'A'
select * from customers where  customer_name like 'A%'
--Show customers whose name ends with 'a'
select * from customers where customer_name like '%a'

select * from customers;
select *from orders;
select * from products;

----- ADVANCED LEVEL 🔥
--Find top 5 highest spending customers
select top 5 * from orders order by amount desc;
--Find second highest order amount
select max(amount)from orders where amount<(select max(amount)from orders);
select c.customer_name,o.amount from customers c left join orders o on c.customer_id=o.customer_id where o.amount=(select max(o.amount)from orders o where o.amount<(select max(o.amount)from orders o));
--Find duplicate order amounts
select amount,count(*) from orders group by amount having count(*)>1;
--Find customers with same city----
select city,count(*)from customers group by city having count(*)>1;
select customer_name,city from customers where city in (select city from customers    group by city  having count(*)>1);
--Find month-wise total sales----
select year(order_date)as year, month(order_date)as month, sum(amount)as total_sales from orders group by year(order_date),month(order_date) order by year,month;
--Find city-wise customer count
select city,count(customer_name)from customers group by city;
--Find customers who placed orders worth more than 10000 total---
select c.customer_name,sum(o.amount) from customers c  join orders o on c.customer_id=o.customer_id group by c.customer_name having sum(o.amount)>10000;
--Find customers whose average order amount is greater than 4000
select c.customer_name,avg(o.amount)from customers c join orders o on c.customer_id=o.customer_id group by customer_name having avg(o.amount)>4000;
---Find customers who have NULL city but placed orders---
select c.customer_name from customers c join orders o on c.customer_id=o.customer_id where city is null;
--Find customers who have city but never placed any order---
select c.customer_name from customers c join orders o on c.customer_id=o.customer_id where c.city is not null and o.customer_id is null;
--Find customers who placed orders on consecutive dates--------
SELECT DISTINCT c.customer_name FROM ( SELECT customer_id, order_date, LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_date FROM orders) t
JOIN customers c ON t.customer_id = c.customer_id
WHERE DATEDIFF(day, prev_date, order_date) = 1;

select * from customers;
select *from orders;
select * from products;
 
---- REAL-TIME BUSINESS QUESTIONS
---Which customer generated highest revenue?
select top 1 c.customer_name,sum(o.amount) as total_revenue from customers c join orders o on c.customer_id=o.customer_id group by customer_name order by total_revenue desc;
--Which city has highest number of customers?
select top 1 customer_name,count(city)as counting_city from customers group by customer_name order by counting_city desc;
--Which month has highest sales?
select top 1 year(order_date),month(order_date),sum(amount)as total_sales from orders group by year(order_date),month(order_date) order by total_sales desc;
--How many repeat customers are there----
select count(*)as repeated_customers from (select customer_id from orders group by customer_id having count(*)>1)t;
select 
--How many repeat customers are there--
select avg(amount)as avg_spending from orders;