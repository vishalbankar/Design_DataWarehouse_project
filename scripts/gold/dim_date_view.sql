
create table gold.dim_date(
    date  DATE,
	year  nvarchar(50),
	month nvarchar(50),
	quarter nvarchar(50)
);



insert into gold.dim_date(
	date,
	year,
	month,
	quarter
)

select 
	distinct order_date as date,
	year(order_date) as year, 
	month(order_date) as month,
	--uarter(order_date) as quarter
	case 
		when month(order_date) >= 4 and month(order_date) <= 6 Then 'Q2'
		when month(order_date) >=7 and month(order_date) <= 9 Then 'Q3'
		when month(order_date) >=10 and month(order_date) <= 12 Then 'Q3'
		else 'Q1'
	end as Quarter
from gold.fact_sales
where order_date is not null
order by order_date;

