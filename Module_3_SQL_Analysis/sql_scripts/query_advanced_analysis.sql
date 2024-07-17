-- Predicted Churn Patterns by Tenure
select c.tenure, count(cp.customer_id) as ChurnCount from customers c
join churn_predictions cp on c.customer_id = cp.customer_id
where cp.churn_prediction = true
group by c.tenure order by ChurnCount desc limit 5;

-- Customer segments by contract type and churn status
select b.contract, cp.churn_prediction, count(c.customer_id) as CustomerCount from customers c
join billing b on c.customer_id = b.customer_id
join churn_predictions cp on c.customer_id = cp.customer_id
group by b.contract, cp.churn_prediction
order by b.contract, cp.churn_prediction;

-- Running Total Monthly Charges
select b.customer_id, b.monthly_charges, sum(b.monthly_charges) over (order by b.customer_id rows between unbounded preceding and current row) as RunningTotalMonthly
from billing b order by b.customer_id;

-- Moving Average of Monthly Charges
select b.customer_id, b.monthly_charges, avg(b.monthly_charges) over (order by b.customer_id rows between unbounded preceding and current row) as MovingAverageMonthly
from billing b order by b.customer_id;

-- Running Total Total Charges
select b.customer_id, b.total_charges, sum(b.total_charges) over (order by b.customer_id rows between unbounded preceding and current row) as RunningTotal
from billing b order by b.customer_id;

-- Moving Average Total Charges
select b.customer_id, b.total_charges, avg(b.total_charges) over (order by b.customer_id rows between unbounded preceding and current row) as MovingAverageTotal
from billing b order by b.customer_id;
