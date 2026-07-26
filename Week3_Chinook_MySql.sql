SHOW databases;
USE CHINOOK;
SHOW TABLES;

select * from customer;

select *from customer
where Country='Brazil'
order by state asc;

select count(*) from customer;

select country, count(*) as total_customer
from customer
group by country;

select country,count(*) as total_customers
from customer
group by country
having count(*)>4
order by total_customers desc;

select * from invoice;

select 
sum(Total) as total_revenue,
avg(Total) as average_value
from invoice;

select c.Firstname,c.Lastname,sum(i.total) as total
from customer c
join invoice i
on c.CustomerId= i.CustomerId
group by c.firstname,c.lastname
order by total desc;

select c.Firstname,c.Lastname
from customer c
left join invoice i
on c.customerid = i.customerid
where i.InvoiceId is null;

select firstname, lastname, country
from customer
where country = (
    SELECT country FROM customer WHERE customerid = 1
);

select firstname, lastname, country
from customer
where country = (
    SELECT country FROM customer WHERE customerid = 3
);

select customerid, SUM(total) AS total_spent
from invoice
group by customerid;

select AVG(total_spent) 
from (
    select customerid, SUM(total) AS total_spent
    from invoice
    group by customerid
) AS customer_totals;

select c.firstname, c.lastname, SUM(i.total) AS total_spent
from customer c
join invoice i ON c.customerid = i.customerid
group by c.firstname, c.lastname
having SUM(i.total) > (
    select AVG(total_spent)
    from (
        select customerid, SUM(total) AS total_spent
        from invoice
        group by customerid
    ) AS customer_totals
)
order by total_spent DESC;

select customerid, total, invoicedate,
    ROW_NUMBER() OVER (ORDER BY total DESC) AS rank_by_spend
from invoice
limit 15;

select customerid, SUM(total) AS total_spent
from invoice
group by customerid
order by total_spent DESC
LIMIT 10;


select customerid, total, invoicedate,
    ROW_NUMBER() OVER (PARTITION BY customerid ORDER BY total DESC) AS rank_within_customer
from invoice
order by customerid, rank_within_customer
LIMIT 20;

select * from (
    select customerid, total, invoicedate,
        ROW_NUMBER() OVER (PARTITION BY customerid ORDER BY total DESC) AS rank_within_customer
    from invoice
) AS ranked_invoices
where rank_within_customer = 1
order by customerid;

select customerid, total,
    RANK() OVER (ORDER BY total DESC) AS rank_by_spend
from invoice
limit 15;
CREATE INDEX idx_customer_id ON invoice(customerid);
















































 





