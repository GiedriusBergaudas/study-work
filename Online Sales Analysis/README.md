# Project Goal
The main goal was to **evaluate annual sales** by identifying valuable customer segments and tracking revenue and retention trends, helping **define strategic focus areas for the next financial year**.

## Tools Used
- **SQL** for data filtering, RFM analysis, cohort analysis, and retention metrics  
- **Power BI** for data visualization

## Data set
[Online Retail](https://archive.ics.uci.edu/dataset/352/online+retail)

This is a transactional data set which contains all the transactions occurring between 01/12/2010 and 09/12/2011 for a UK-based non-store online retail.The company mainly sells unique all-occasion gifts. Many customers of the company are wholesalers.

The dataset contains over 500,000 transactions, including customer IDs, countries, timestamps, quantities, and prices.

## Key Insights & Results
### RFM Analysis

RFM segmentation was done using SQL by assigning scores based on quantiles:

**Recency**: Calculated as days since the last purchase.

**Frequency**: Number of orders per customer.

**Monetary**: Total spend per customer.

| Segment Name            | Recency Score | Frequency/Monetary Score | Description                                     |
| ----------------------- | ------------- | ------------------------ | ----------------------------------------------- |
| **Best Customers**      | 4             | 4                        | Most loyal and valuable customers.              |
| **Loyal Customers**     | 4 or 3        | 3 or 4                   | Frequent and consistent buyers.                 |
| **Potential Loyalists** | 4 or 3        | 2 or 3                   | Growing loyalty, good potential.                |
| **Recent Customers**    | 4             | 1                        | New customers with only one purchase.           |
| **Promising**           | 3             | 2                        | Recently active but not yet fully engaged.      |
| **At Risk**             | 2             | 4                        | High past value but haven’t purchased recently. |
| **Need Attention**      | 2             | 2 or 3                   | Average customers who need re-engagement.       |
| **Can't Lose Them**     | 1             | 3 or 4                   | Previously loyal, now inactive.                 |
| **Lost Customers**      | 1 or 2        | 1 or 2                   | Low recent activity and value.                  |

**Insights :**
1. **Best Customers, Loyal Customers, and Potential Loyalists** – together they **make up 41% of all customers** but bring in around **77% of total revenue**.
  These are our most valuable groups and should stay a top priority for retention and loyalty efforts.

2. **Lost Customers** are the **largest group, at 26%**, but they only generate about **4% of revenue**.
  This group isn’t bringing much value anymore – they could be excluded from most marketing or included in low-cost reactivation emails.

3. **At Risk and Can’t Lose Them** segments account for **10% of customers** but have contributed close to **12% of revenue**.
  These customers used to spend a lot — it is worth trying to win them back before they are completely lost.

4. **Customers Needing Attention and Promising** represent **22% of customers** and have **moderate value**.
They are not top spenders yet, but with some targeted offers, some could turn into loyal buyers.


### Cohort Analysis

For the cohort analysis, since purchases are infrequent, I used a quarterly approach to better capture customer behavior over time.
I calculated the following metrics for each cohort:

- Total Users

- Retention Rate

- Average Revenue Per User

- Total Revenue
 
**Insights :**
1. The **Q1 cohort is largest with 1,682 users and £1.6M revenue**. Despite retention dropping to 63%, total revenue grows to nearly £1.9M by period 3, showing loyal customers spend more over time.

2. The **Q2 cohort begins with 1,036 users and £0.56M revenue**. Retention falls sharply to 40.5% after one quarter but rebounds to nearly 50%, with revenue following the same trend.

3. The **Q3 cohort is smaller, starting at 599 users and £0.33M revenue**. Retention drops to 49% after one quarter, and revenue declines despite an increase in average spend per user.

4. **All cohorts start with a strong average revenue per user £545–£945**, indicating solid early spending. Improving retention should be a priority to capture more long-term value.

5. Predicted average **CLV is around £2,355 per user**.
This was calculated by taking the weighted average CLV from Q1, Q2, and Q3 cohorts based on their user counts and average spend over time.

## Strategic Recommendations for the Next Fiscal Year

1. **Double down on high-value segments**
Focus loyalty programs, personalized campaigns, and exclusive offers on Best Customers, Loyal Customers, and Potential Loyalists.

    **Target:** Increase retention in these segments by 5–10%, potentially driving +£300K in additional annual revenue.

2. **Reduce focus on Lost Customers**
Reallocate budget away from this low-value group, limit actions to automated reactivation emails only.

    **Target:** Cut marketing costs for this group by up to 80%, reinvest savings in higher ROI segments.

3. **Invest in win-back campaigns** for At Risk and Can’t Lose segments.
Launch targeted re-engagement using tailored messaging and purchase reminders.

    **Target:** Recover 25% of these users, potential uplift: £100K+ in revenue based on past ARPU levels.

4. **Maintain CAC Below £800** to Sustain Profitability

    **Target**: With a predicted Customer Lifetime Value of £2,355, to ensure a healthy LTV:CAC ratio of 3:1. CAC has to be £800 or less.
