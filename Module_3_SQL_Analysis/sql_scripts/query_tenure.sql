-- Max tenure
select max(tenure) as LongestTenure from customers;
-- Customers with max tenure
select count(*) as NumberOfCustomers from customers
where tenure = (select max(tenure) from customers);

-- Min tenure
select min(tenure) as ShortestTenure from customers;
-- Customers with min tenure
select count(*) as NumberOfCustomers from customers
where tenure = (select min(tenure) from customers);

-- Customers with less than, equal to, and more than 1 year
select count(*) as Customers1Year from customers where tenure = 12;
select count(*) as CustomersLessThan1Year from customers where tenure < 12;
select count(*) as CustomersMoreThan1Year from customers where tenure > 12;

-- Average tenure
select avg(tenure) as AverageTenure from customers;

-- Grouping customers per tenure
select tenure, count(*) as NumberOfCustomers from customers
group by tenure
order by tenure;

-- Tenure Statistics
select 
	avg(tenure) as AverageTenure,
	max(tenure) as MaxTenure,
	min(tenure) as MinTenure,
	stddev(tenure) as STDDEVTenure
from customers;

-- Customers with Max tenure predicted to churn
select count(*) as MaxTenurePredictedChurn from customers c
join churn_predictions cp on c.customer_id = cp.customer_id
where c.tenure = (select max(tenure) from customers) and cp.churn_prediction = true;


-- Customers with Min tenure predicted to churn
select count(*) as MinTenurePredictedChurn from customers c
join churn_predictions cp on c.customer_id = cp.customer_id
where c.tenure = (select min(tenure) from customers) and cp.churn_prediction = true;

-- Customers predicted to churn with tenure of less than 1 year
select count(*) as PredictedChurnLessThan1Year from customers c
join churn_predictions cp on c.customer_id = cp.customer_id
where c.tenure < 12 and cp.churn_prediction = true;
