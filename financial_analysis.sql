-- NovaMart Consumer Products Pvt. Ltd.
-- CFO Financial Performance & Profitability Analysis
-- Period: Apr 2025 - Mar 2026
-- Tool: MySQL
-- Source table: financialdata

USE novamart_financial_analysis;

-- 1. Data validation
SELECT COUNT(*) AS Total_Rows
FROM financialdata;

-- 2. Overall financial performance
SELECT
    SUM(Revenue) AS Total_Revenue,
    SUM(COGS) AS Total_COGS,
    SUM(Gross_Profit) AS Gross_Profit,
    SUM(Operating_Expense) AS Operating_Expense,
    SUM(EBITDA) AS EBITDA,
    SUM(Tax) AS Tax,
    SUM(Net_Profit) AS Net_Profit
FROM financialdata;

-- 3. Regional profitability
SELECT
    Region,
    SUM(Revenue) AS Total_Revenue,
    SUM(Gross_Profit) AS Gross_Profit,
    SUM(Net_Profit) AS Net_Profit,
    ROUND(SUM(Net_Profit) / SUM(Revenue) * 100, 2) AS Net_Profit_Margin
FROM financialdata
GROUP BY Region
ORDER BY Net_Profit_Margin DESC;

-- 4. Category profitability
SELECT
    Category,
    SUM(Revenue) AS Total_Revenue,
    SUM(COGS) AS Total_COGS,
    SUM(Gross_Profit) AS Gross_Profit,
    SUM(Net_Profit) AS Net_Profit,
    ROUND(SUM(Net_Profit) / SUM(Revenue) * 100, 2) AS Net_Profit_Margin
FROM financialdata
GROUP BY Category
ORDER BY Net_Profit_Margin DESC;

-- 5. Maharashtra category profitability
SELECT
    Category,
    SUM(Revenue) AS Total_Revenue,
    SUM(COGS) AS Total_COGS,
    SUM(Gross_Profit) AS Gross_Profit,
    SUM(Net_Profit) AS Net_Profit,
    ROUND(SUM(Net_Profit) / SUM(Revenue) * 100, 2) AS Net_Profit_Margin
FROM financialdata
WHERE Region = 'Maharashtra'
GROUP BY Category
ORDER BY Net_Profit_Margin DESC;

-- 6. Maharashtra Electronics Accessories product analysis
SELECT
    Product,
    SUM(Revenue) AS Total_Revenue,
    SUM(COGS) AS Total_COGS,
    SUM(Gross_Profit) AS Gross_Profit,
    SUM(Net_Profit) AS Net_Profit,
    ROUND(SUM(Net_Profit) / SUM(Revenue) * 100, 2) AS Net_Profit_Margin
FROM financialdata
WHERE Region = 'Maharashtra'
  AND Category = 'Electronics Accessories'
GROUP BY Product
ORDER BY Net_Profit_Margin ASC;

-- 7. Monthly performance
SELECT
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    SUM(Revenue) AS Total_Revenue,
    SUM(Net_Profit) AS Net_Profit,
    ROUND(SUM(Net_Profit) / SUM(Revenue) * 100, 2) AS Net_Profit_Margin
FROM financialdata
GROUP BY DATE_FORMAT(Date, '%Y-%m')
ORDER BY Month;

-- 8. Revenue budget variance
SELECT
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    SUM(Revenue) AS Actual_Revenue,
    SUM(Budget_Revenue) AS Budget_Revenue,
    ROUND(SUM(Revenue) - SUM(Budget_Revenue), 2) AS Revenue_Variance,
    ROUND(
        (SUM(Revenue) - SUM(Budget_Revenue))
        / SUM(Budget_Revenue) * 100,
        2
    ) AS Variance_Percentage
FROM financialdata
GROUP BY DATE_FORMAT(Date, '%Y-%m')
ORDER BY Month;

-- 9. Expense budget variance
SELECT
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    SUM(Operating_Expense) AS Actual_Expense,
    SUM(Budget_Expense) AS Budget_Expense,
    ROUND(SUM(Operating_Expense) - SUM(Budget_Expense), 2) AS Expense_Variance,
    ROUND(
        (SUM(Operating_Expense) - SUM(Budget_Expense))
        / SUM(Budget_Expense) * 100,
        2
    ) AS Variance_Percentage
FROM financialdata
GROUP BY DATE_FORMAT(Date, '%Y-%m')
ORDER BY Month;
