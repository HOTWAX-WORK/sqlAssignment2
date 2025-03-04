-- 8.6 Total Orders by Sales Channel
-- Business Problem:
-- Marketing and sales teams want to see how many orders come from each channel (e.g., web, mobile app, in-store POS, marketplace) to allocate resources effectively.

-- Fields to Retrieve:

-- SALES_CHANNEL
-- TOTAL_ORDERS
-- TOTAL_REVENUE
-- REPORTING_PERIOD

SELECT 
    oh.SALES_CHANNEL_ENUM_ID,
    COUNT(oh.ORDER_ID) AS TOTAL_ORDERS,
    SUM(oh.GRAND_TOTAL) AS TOTAL_REVENUE,
    DATE_FORMAT(oh.ORDER_DATE, '%Y-%m') AS REPORTING_PERIOD
FROM 
    order_header oh
GROUP BY 
    oh.SALES_CHANNEL_ENUM_ID,
    DATE_FORMAT(oh.ORDER_DATE, '%Y-%m')
ORDER BY 
    REPORTING_PERIOD ASC;

