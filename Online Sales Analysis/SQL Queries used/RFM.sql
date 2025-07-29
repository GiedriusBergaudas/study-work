---calculated monetary,frequency and recenecy and cleaned negative price data
WITH rfm AS (
SELECT
    CustomerID,
    SUM(Quantity * UnitPrice) AS monetary,
    COUNT(DISTINCT InvoiceNo) AS frequency,
    DATE_DIFF(DATE '2011-12-01', DATE(MAX(InvoiceDate)), DAY) AS recency
FROM
     `retail-465908.online_retail.retail`
WHERE
    InvoiceDate BETWEEN '2010-12-01' AND '2011-12-01'
    AND UnitPrice > 0
    AND Quantity > 0
    AND CustomerID IS NOT NULL
GROUP BY
    CustomerID
),
--- set quantiles 
quant AS (
SELECT
    APPROX_QUANTILES(frequency, 100) AS f_q,
    APPROX_QUANTILES(recency, 100) AS r_q,
    APPROX_QUANTILES(monetary, 100) AS m_q
FROM
    rfm
),
--- divided to 4 equal parts  
percent AS (
SELECT
    m_q[OFFSET(25)] AS m25, m_q[OFFSET(50)] AS m50, m_q[OFFSET(75)] AS m75,
    f_q[OFFSET(25)] AS f25, f_q[OFFSET(50)] AS f50, f_q[OFFSET(75)] AS f75,
    r_q[OFFSET(25)] AS r25, r_q[OFFSET(50)] AS r50, r_q[OFFSET(75)] AS r75
FROM
    quant
),
--- cross joined percents and set rfm scores   
scored AS (
SELECT
    rfm.*,
    CASE
    WHEN monetary <= m25 THEN 1
    WHEN monetary <= m50 THEN 2
    WHEN monetary <= m75 THEN 3
    ELSE 4
    END AS m_score,
    CASE
    WHEN frequency <= f25 THEN 1
    WHEN frequency <= f50 THEN 2
    WHEN frequency <= f75 THEN 3
    ELSE 4
    END AS f_score,
    CASE
    WHEN recency <= r25 THEN 4
    WHEN recency <= r50 THEN 3
    WHEN recency <= r75 THEN 2
    ELSE 1
    END AS r_score
FROM
    rfm
CROSS JOIN
    percent
),
fm_score_cte AS (
SELECT
    *,
    CAST(ROUND((f_score + m_score) / 2) AS INT64) AS fm_score
FROM
   scored
)
--- set customer segemnts by thei rfm scores
SELECT 
    CustomerID,
    recency,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    fm_score,
    CASE
    WHEN r_score = 4 AND fm_score = 4 THEN 'Best Customers'
    WHEN (r_score = 4 AND fm_score = 3) OR (r_score = 3 AND fm_score = 4) THEN 'Loyal Customers'
    WHEN (r_score = 4 AND fm_score = 2) OR (r_score = 3 AND fm_score = 3) THEN 'Potential Loyalists'
    WHEN r_score = 4 AND fm_score = 1 THEN 'Recent Customers'
    WHEN r_score = 3 AND fm_score = 2 THEN 'Promising'
    WHEN r_score = 2 AND fm_score = 4 THEN 'At Risk'
    WHEN (r_score = 2 AND fm_score = 3) OR (r_score = 2 AND fm_score = 2) THEN 'Customers Needing Attention'
    WHEN (r_score = 1 AND fm_score = 4) OR (r_score = 1 AND fm_score = 3) THEN 'Cant Lose Them'
    WHEN r_score in (1, 2) AND fm_score  in (1,2) THEN 'Lost Customers'
    END AS rfm_segment
FROM
   fm_score_cte
ORDER BY
   fm_score DESC, r_score DESC