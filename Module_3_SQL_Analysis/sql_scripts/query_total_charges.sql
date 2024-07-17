-- Max total charges
select max(total_charges) as HighestTotalCharges from billing;

-- Services being used by those with max total charges
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
    where total_charges = (select max(total_charges) from public.billing)
);

-- Min total Charges
select min(total_charges) as LowestTotalCharges from billing;
-- Services being used by those
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
    where total_charges = (select min(total_charges) from public.billing)
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
    where total_charges = (select min(total_charges) from public.billing)
);

-- Average total Charges
select avg(total_charges) as AverageCharges from billing;

-- Customers with less than or more than average total charges
select 
	case
		when total_charges < 2300 then '<=$2300 (Less then equal to Average)'
		else '>$2300 (More than Average)'
	end as tcr,
	count(*) as NumberOfCustomers
from billing
group by tcr
order by tcr;

-- Total charges statistics
select
	avg(total_charges) as AverageTotalCharges,
	max(total_charges) as HighestTotalCharges,
	min(total_charges) as LowestTotalCharges,
	stddev(total_charges) as StddevTotalCharges
from billing;