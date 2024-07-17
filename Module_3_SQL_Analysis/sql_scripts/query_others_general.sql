-- Contracts in relation to Customers, monthly and total charges, and predicted churned customers
select b.contract, count(c.customer_id) as TotalCustomers, avg(monthly_charges) as AverageMonthlyCharges, avg(total_charges) as AverageTotalCharges,
       sum(case when cp.churn_prediction = true then 1 else 0 end) as ChurnedCustomers,
       (sum(case when cp.churn_prediction = true then 1 else 0 end) * 100.0 / count(c.customer_id)) as ChurnRate
from customers c
join billing b on c.customer_id = b.customer_id
join churn_predictions cp on c.customer_id = cp.customer_id
group by b.contract
order by b.contract;

-- Payment methods in relation to Customers, monthly and total charges, and predicted churned customers
select b.payment_method, count(c.customer_id) as TotalCustomers, avg(b.monthly_charges) as AverageMonthlyCharges, avg(b.total_charges) as AverageTotalCharges,
	sum(case when cp.churn_prediction = true then 1 else 0 end) as ChurnedCustomers,
	(sum(case when cp.churn_prediction = true then 1 else 0 end) * 100.0 / count(c.customer_id)) as ChurnRate
from customers as c
join billing b on c.customer_id = b.customer_id
join churn_predictions cp on c.customer_id = cp.customer_id
group by b.payment_method
order by b.payment_method;

-- Internet Services in relation to Customers, monthly and total charges, and predicted churned customers
select s.internet_service, count(s.customer_id) as TotalCustomers, avg(b.monthly_charges) as AverageMonthlyCharges, avg(b.total_charges) as AverageTotalCharges, 
	count(case when cp.churn_prediction = true then 1 end) as ChurnPredictions,
	(count(case when cp.churn_prediction = true then 1 end) *100.0 / count(*)) as ChurnRate
from services s
join billing b on s.customer_id = b.customer_id
join churn_predictions cp on s.customer_id = cp.customer_id
group by s.internet_service
order by s.internet_service;

-- Total Revenue
select sum(total_charges) as TotalRevenue from billing;

-- Total Revenue from Predicted Churned Customers
select sum(b.total_charges) as TotalRevenueFromChurned from billing b
join churn_predictions cp on b.customer_id = cp.customer_id where cp.churn = true;

-- Predicted Churned average monthly and total charges
select cp.churn_prediction, count(cp.churn_prediction) as TotalCustomers, avg(b.monthly_charges) as AverageMonthlyCharges, avg(b.total_charges) as AverageTotalCharges from billing b
join churn_predictions cp on b.customer_id = cp.customer_id
group by cp.churn_prediction
order by cp.churn_prediction;
