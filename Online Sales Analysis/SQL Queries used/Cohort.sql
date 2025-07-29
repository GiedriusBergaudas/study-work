--- assigned each transaction to a quarter index
WITH filtered AS (
  SELECT *,
    CASE
      WHEN DATE(InvoiceDate) BETWEEN '2010-12-01' AND '2011-02-28' THEN 1
      WHEN DATE(InvoiceDate) BETWEEN '2011-03-01' AND '2011-05-31' THEN 2
      WHEN DATE(InvoiceDate) BETWEEN '2011-06-01' AND '2011-08-31' THEN 3
      WHEN DATE(InvoiceDate) BETWEEN '2011-09-01' AND '2011-11-30' THEN 4
    END AS quarter_index,
    Quantity * UnitPrice AS revenue
  FROM `retail-465908.online_retail.retail`
  WHERE InvoiceDate >= '2010-12-01' AND InvoiceDate < '2011-12-01'
    AND Quantity > 0 
    AND UnitPrice > 0 
    AND CustomerID IS NOT NULL
),
--- got the first purchase quarter for each customer
first_quarter AS (
  SELECT
    CustomerID,
    MIN(quarter_index) AS cohort_quarter
  FROM filtered
  GROUP BY CustomerID
),
--- counted how many customers are in each cohort
cohort_sizes AS (
  SELECT
    cohort_quarter,
    COUNT(DISTINCT CustomerID) AS cohort_size
  FROM first_quarter
  GROUP BY cohort_quarter
)
--- retention and revenue metrics per cohort
SELECT
  CONCAT('Q', fq.cohort_quarter, ' cohort') AS cohort_label,          
  f.quarter_index - fq.cohort_quarter AS period_label,               
  cs.cohort_size,                                                    
  COUNT(DISTINCT f.CustomerID) AS users,                              
  SAFE_DIVIDE(COUNT(DISTINCT f.CustomerID), cs.cohort_size)  AS retention_pct,                                  
  ROUND(SAFE_DIVIDE(SUM(f.revenue), COUNT(DISTINCT f.CustomerID)), 2) AS avg_revenue_per_user  
FROM filtered f
JOIN first_quarter fq ON f.CustomerID = fq.CustomerID
JOIN cohort_sizes cs ON fq.cohort_quarter = cs.cohort_quarter
GROUP BY fq.cohort_quarter, cs.cohort_size, period_label
ORDER BY fq.cohort_quarter, period_label
