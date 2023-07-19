select * from WalmartSales.dbo.[WalmartSalesData.csv]
-- Feature Engineering
-- Time_of_Date

Select time ,
case 
when time  between '00:00:00' and '12:00:00' then 'Morning'
when time  between '12:00:01' and '16:00:00' then 'Afternoon'
Else 'Evening'
end as Time_of_Date
from WalmartSales.dbo.[WalmartSalesData.csv]


Alter table WalmartSales.dbo.[WalmartSalesData.csv]
add Time_of_Day varchar(20)

update WalmartSales.dbo.[WalmartSalesData.csv]
set Time_of_day=case 
when time  between '00:00:00' and '12:00:00' then 'Morning'
when time  between '12:00:01' and '16:00:00' then 'Afternoon'
Else 'Evening'
end 

select * from WalmartSales.dbo.[WalmartSalesData.csv]


--Day_Name---------------------------------------------------------------------------------------------------------------

select Date, datename(weekday , date) as Day_Name
from WalmartSales.dbo.[WalmartSalesData.csv]

Alter table WalmartSales.dbo.[WalmartSalesData.csv]
add Day_Name varchar(20)

update WalmartSales.dbo.[WalmartSalesData.csv]
set Day_Name= datename(weekday , date) 
from WalmartSales.dbo.[WalmartSalesData.csv]


Select * from WalmartSales.dbo.[WalmartSalesData.csv]

--Month_Name---------------------------------------------------------------------------------------------------------------

select Date , datename(month,date) as Month_Name
from WalmartSales.dbo.[WalmartSalesData.csv]

Alter table WalmartSales.dbo.[WalmartSalesData.csv]
add Month_Name varchar(20)

update WalmartSales.dbo.[WalmartSalesData.csv]
set Month_Name=datename(month,date)
from WalmartSales.dbo.[WalmartSalesData.csv]


select * from WalmartSales.dbo.[WalmartSalesData.csv]

--Generic Questions
--How many unique cities does the data have ?

select distinct(city)
from WalmartSales.dbo.[WalmartSalesData.csv]

select distinct(Branch) 
from WalmartSales.dbo.[WalmartSalesData.csv]

--In which city each branch is ?

select distinct(city) , branch 
from WalmartSales.dbo.[WalmartSalesData.csv]

---------------------------------------------------Product---------------------------------------------------------------
--How many unique product line does the data have ?

select count(distinct Product_line) 
from WalmartSales.dbo.[WalmartSalesData.csv]

--What is the most common payment method?

select distinct(Payment), count(payment)
from WalmartSales.dbo.[WalmartSalesData.csv]
group by payment

--What is the most selling product line?

select Product_line, COUNT(product_line) 
from WalmartSales.dbo.[WalmartSalesData.csv]
group by Product_line
order by Product_line DESC

--Total revenue by month ?

select Month_name as Month ,
round(sum(total),2) as Revenue
from WalmartSales.dbo.[WalmartSalesData.csv]
group by month_name 
order by Revenue desc

--What month have the largest cogs

select  month_name , sum(cogs) as cogs
from WalmartSales.dbo.[WalmartSalesData.csv]
group by Month_name 
order by cogs desc

--What product line has the largest revenue?

select 
distinct(product_line),
sum(total) as Revenue
from WalmartSales.dbo.[WalmartSalesData.csv] 
group by Product_line
order by Revenue desc

--Which is the city with the largest revenue

select  Branch, city , sum(total) as Revenue
from WalmartSales.dbo.[WalmartSalesData.csv]
group by City , Branch
order by Revenue desc

--What product line has the largest VAT

select Product_line , Avg(Tax_5) as Avg_TAX 
from WalmartSales.dbo.[WalmartSalesData.csv]
Group by Product_line
order by Avg_TAX desc

--Fetch each product line and add a column to those product line showing'Good , 'Bad', where 'Good' if it is greater than average sales 

select * from WalmartSales.dbo.[WalmartSalesData.csv]








--Which brand sold more products than average product sold ?

select 
Branch , sum(Quantity) as QTY
from WalmartSales.dbo.[WalmartSalesData.csv]
group by Branch
having Sum(quantity)>(select avg(quantity) from WalmartSales.dbo.[WalmartSalesData.csv]) 

--Which is the most common product line by gender

select Gender ,product_line, count(Gender) as Total_count
from WalmartSales.dbo.[WalmartSalesData.csv]
group by Gender, Product_line 
order by Total_count desc


--What is the average rating of each product line

select Product_line,round(avg(Rating),2) Avg_rating
from WalmartSales.dbo.[WalmartSalesData.csv]
group by Product_line
order by Avg_rating desc