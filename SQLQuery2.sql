create database sqlhandson

use sqlhandson

Create table salesman
(
  salesman_id numeric(10) primary key,
  name varchar(100),
  city varchar(1000),
  commission decimal(5,2)
)

select * from salesman

insert into salesman values(5001,'james Hoong','New York',0.15)

insert into salesman values(5002,'Nail Knite','Paris',0.13)

insert into salesman values(5005,'Pit Alex','Landon',0.11)
insert into salesman values(5006,'Mc Lyon','Paris',0.14)
insert into salesman values(5007,'Paul Adam','Rome',0.13)
insert into salesman values(5003,'Lauson Hen','San Jose',0.12)


create table customer
(
customer_id numeric(10) primary key,
cust_name varchar(100),
city varchar(100),
grade numeric(10),
salesman_id numeric(10)
)

insert into customer values(3002,'Nick Rimando','New York',100,5001)

insert into customer values(3007,'Brad Davis','New York',200,5001)

insert into customer values(3005,'Graham Zusi','California',200,5002)

insert into customer values(3008,'Julian Green','London',300,5002)

insert into customer values(3004,'Fabian Johnson','Paris',300,5006)

insert into customer values(3009,'Geoff Cameron','Berlin',100,5003)

insert into customer values(3003,'Jozy Altidor','Moscow',200,5007)
insert into customer values(3001,'Brad Guzan','London',200,5005)




create table orders
(
ord_no numeric(10) primary key,
purch_amt decimal(8,2),
ord_date date,
customer_id numeric(10) foreign key references customer(customer_id),
salesman_id numeric(10) foreign key references salesman(salesman_id)
)

insert into orders values(70001,150.5,'2012-10-05',3005,5002)
insert into orders values(70009,270.65,'2012-09-10',3001,5005)
insert into orders values(70002,65.26,'2012-10-05',3002,5001)
insert into orders values(70004,110.5,'2012-08-17',3009,5003)
insert into orders values(70007,948.5,'2012-09-10',3005,5002)
insert into orders values(70005,2400.6,'2012-07-27',3007,5001)
insert into orders values(70008,5760,'2012-09-10',3002,5001)

--Write a query to display the columns in a specific order like order date, salesman id, order number and purchase amount from for all the orders
SELECT ord_date,salesman_id,ord_no,purch_amt
FROM orders; 

-- write a SQL query to find the unique salespeople ID. Return salesman_id.
SELECT DISTINCT salesman_id
FROM orders;

--write a SQL query to find the salespeople who lives in the City of 'Paris'. Return salesperson's name, city
SELECT name,city
FROM salesman
WHERE city='Paris';

--write a SQL query to find the orders, which are delivered by a salesperson of ID. 5001. Return ord_no, ord_date, purch_amt
SELECT ord_no, ord_date, purch_amt
FROM orders
WHERE salesman_id = 5001;

--write a SQL query to find all the customers in �New York� city who have a grade value above 100. Return customer_id, cust_name, city, grade, and salesman_id.

SELECT *
FROM customer
WHERE city = 'New York' OR NOT grade > 100;

--write a SQL query to find the details of those salespeople whose commissions range from 0.10 to0.12. Return salesman_id, name, city, and commission
SELECT salesman_id, name, city, commission
FROM salesman
WHERE commission between 0.10 AND 0.12;

--write a SQL query to calculate total purchase amount of all orders. Return total purchase amount.
SELECT SUM (purch_amt)
FROM orders;

--write a SQL query to calculate average purchase amount of all orders. Return average purchase amount.
SELECT AVG (purch_amt)
FROM orders;

--write a SQL query to count the number of unique salespeople. Return number of salespeople.
SELECT COUNT (DISTINCT salesman_id)
FROM orders;

--write a SQL query to find the highest purchase amount ordered by each customer. Return customer ID, maximum purchase amount
SELECT customer_id, MAX(purch_amt)
FROM orders
GROUP BY customer_id;

--write a SQL query to find the highest purchase amount ordered by each customer on a particular date. Return, order date and highest purchase amounT
SELECT customer_id, ord_date, MAX(purch_amt)
FROM orders
GROUP BY customer_id, ord_date;

--write a SQL query to find the highest purchase amount on '2012-08-17' by each salesperson. Return salesperson ID, purchase amount

SELECT salesman_id, MAX(purch_amt)
FROM orders
WHERE ord_date = '2012-08-17'
GROUP BY salesman_id;

--write a SQL query to find the salesperson and customer who belongs to same city. Return Salesman, cust_name and city.
SELECT S.cust_name S.name S.city
FROM salesman AS S customer AS C
WHERE S.city = C.city


