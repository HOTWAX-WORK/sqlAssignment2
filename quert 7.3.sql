-- 7.3 Store-Specific (Facility-Wise) Revenue
-- Business Problem:
-- Different physical or online stores (facilities) may have varying levels of performance. The business wants to compare revenue across facilities for sales planning and budgeting.

-- Fields to Retrieve:

-- FACILITY_ID
-- FACILITY_NAME
-- TOTAL_ORDERS
-- TOTAL_REVENUE
-- DATE_RANGE



select
	s.ORIGIN_FACILITY_ID ,
	f.FACILITY_NAME ,
	count(os.ORDER_ID),
	sum(oi.UNIT_PRICE * oi.QUANTITY),
	concat(min(date(oh.order_date)),'to',max(date(oh.order_date))) as DATE_RANGE
from
order_item oi
join order_shipment os  on
	os.ORDER_ITEM_SEQ_ID = oi.ORDER_ITEM_SEQ_ID and os.ORDER_ID =oi.ORDER_ID 
join shipment s on
	os.SHIPMENT_ID = s.SHIPMENT_ID
join facility f on
	f.FACILITY_ID = s.ORIGIN_FACILITY_ID
left join order_header oh on oh.ORDER_ID = oi.ORDER_ID 
group by
	s.ORIGIN_FACILITY_ID




EXPLANATION
-- The query starts with the order_item table because it contains key details about products sold, including ORDER_ID, UNIT_PRICE, and QUANTITY,
-- which are necessary to compute revenue. The order_shipment table is joined to link each order item with its shipment details, ensuring accurate 
-- tracking of which facility fulfilled the order.
-- Next, the shipment table is joined to retrieve the ORIGIN_FACILITY_ID, identifying which facility was responsible for dispatching the order. 
-- A LEFT JOIN with order_header is used to extract ORDER_DATE, which allows the calculation of a sales date range for each facility. The MIN(order_date) 
-- and MAX(order_date) functions determine the earliest and latest order dates, and CONCAT() is used to format the DATE_RANGE.
-- Aggregations are performed using COUNT(os.ORDER_ID) to determine TOTAL_ORDERS and SUM(oi.UNIT_PRICE * oi.QUANTITY) to calculate TOTAL_REVENUE.
-- The query groups data by s.ORIGIN_FACILITY_ID so that all orders and revenue from the same facility are combined into a single summary.
