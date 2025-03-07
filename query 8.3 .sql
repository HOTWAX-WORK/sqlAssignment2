-- 8.3 Retrieve the Current Facility (Physical or Virtual) of Open Orders
-- Business Problem:
-- The business wants to know where open orders are currently assigned, whether in a physical store or a virtual facility (e.g., a distribution center or online fulfillment location).

-- Fields to Retrieve:

-- ORDER_ID
-- ORDER_STATUS
-- FACILITY_ID
-- FACILITY_NAME
-- FACILITY_TYPE_ID

select
	oh.ORDER_ID ,
	oh.STATUS_ID ,
	f.FACILITY_ID ,
	f.FACILITY_NAME ,
	f.FACILITY_TYPE_ID,
	ft.PARENT_TYPE_ID
from
	order_header oh
join order_shipment os on
	oh.ORDER_ID = os.ORDER_ID
	and oh.STATUS_ID not in ('ORDER_COMPLETED', 'ORDER_CANCELLED')
join shipment s on
	os.SHIPMENT_ID = s.SHIPMENT_ID
join facility f on
	f.FACILITY_ID = s.ORIGIN_FACILITY_ID
join facility_type ft on
	f.FACILITY_TYPE_ID = ft.FACILITY_TYPE_ID
