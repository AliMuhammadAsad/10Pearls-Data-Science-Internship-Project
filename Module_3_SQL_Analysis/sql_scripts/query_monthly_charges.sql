-- Maximum Monthly Charges
select max(monthly_charges) as HighestMonthlyCharges from billing;
-- Customers with the maximum monthly charges
select count(*) as NumberOfCustomers from billing
where monthly_charges = (select max(monthly_charges) from billing);

-- Minimum Monthly Charges
select min(monthly_charges) as LowestMonthlyCharges from billing;
-- Customers with the minimum monthly charges
select count(*) as NumberOfCustomers from billing
where monthly_charges = (select min(monthly_charges) from billing);

-- Average Monthly Charges
select avg(monthly_charges) as AverageMonthlyCharges from billing;

-- Customers with more or less than average charges
select
	case
		when monthly_charges < 65 then '<$65 (Average)'
		else '>$65 (More than Average)'
	end as mcr,
	count(*) as NumberOfCustomers
from billing
group by mcr
order by mcr;

-- Monthly Charges Statistics
select 
    avg(monthly_charges) as average_monthly_charges,
    max(monthly_charges) as max_monthly_charges,
    min(monthly_charges) as min_monthly_charges,
    stddev(monthly_charges) as stddev_monthly_charges
from billing;

-- Total Services being used by customers with the highest monthly charges
select sum(
    (case when phone_service then 1 else 0 end) +
    (case when multiple_lines then 1 else 0 end) +
    (case when internet_service != 'False' then 1 else 0 end) +
    (case when online_security then 1 else 0 end) +
    (case when online_backup then 1 else 0 end) +
    (case when device_protection then 1 else 0 end) +
    (case when tech_support then 1 else 0 end) +
    (case when streaming_tv then 1 else 0 end) +
    (case when streaming_movies then 1 else 0 end)
) as total_services
from public.services
where customer_id in (
    select customer_id
    from public.billing
    where monthly_charges = (select max(monthly_charges) from public.billing)
);

-- Services being used by customers with the lowest monthly charges
select sum(
    (case when phone_service then 1 else 0 end) +
    (case when multiple_lines then 1 else 0 end) +
    (case when internet_service != 'False' then 1 else 0 end) +
    (case when online_security then 1 else 0 end) +
    (case when online_backup then 1 else 0 end) +
    (case when device_protection then 1 else 0 end) +
    (case when tech_support then 1 else 0 end) +
    (case when streaming_tv then 1 else 0 end) +
    (case when streaming_movies then 1 else 0 end)
) as total_services
from public.services
where customer_id in (
    select customer_id
    from public.billing
    where monthly_charges = (select min(monthly_charges) from public.billing)
);

-- Displaying those services
select s.customer_id, s.phone_service, s.multiple_lines, s.internet_service, s.online_security, s.online_backup, s.device_protection, s.tech_support, s.streaming_tv, s.streaming_movies,
       (
           (case when s.phone_service then 1 else 0 end) +
           (case when s.multiple_lines then 1 else 0 end) +
           (case when s.internet_service != 'False' then 1 else 0 end) +
           (case when s.online_security then 1 else 0 end) +
           (case when s.online_backup then 1 else 0 end) +
           (case when s.device_protection then 1 else 0 end) +
           (case when s.tech_support then 1 else 0 end) +
           (case when s.streaming_tv then 1 else 0 end) +
           (case when s.streaming_movies then 1 else 0 end)
       ) as total_services
from public.services s
where s.customer_id in (
    select customer_id
    from public.billing
    where monthly_charges = (select min(monthly_charges) from public.billing)
);

-- Internet Services Grouped by customers
select internet_service, count(customer_id) as Customers from services
group by internet_service
order by internet_service;