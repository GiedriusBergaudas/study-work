--- calculated revenue column
WITH revenue_by_country AS (
SELECT
    *,
    SUM(UnitPrice * Quantity) AS total_revenue
FROM
    `retail-465908.online_retail.retail`
WHERE
    InvoiceDate BETWEEN '2010-12-01' AND '2011-12-01'
    AND Quantity > 0
    AND UnitPrice > 0
    AND CustomerID IS NOT NULL
GROUP BY
   ALL
)
--- seperated top 5 countries by revenue
SELECT
    *,
    CASE
    WHEN Country IN (
    SELECT Country FROM revenue_by_country
    ORDER BY total_revenue DESC LIMIT 5
    ) THEN Country
    ELSE 'Other countries'
  END AS Region_Group
FROM revenue_by_country
ORDER BY total_revenue DESC