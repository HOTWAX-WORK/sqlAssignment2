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

