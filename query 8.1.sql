-- 8. Inventory Management & Transfers
-- 8.1 Lost and Damaged Inventory
-- Business Problem:
-- Warehouse managers need to track “shrinkage” such as lost or damaged inventory to reconcile physical vs. system counts.

-- Fields to Retrieve:

-- INVENTORY_ITEM_ID
-- PRODUCT_ID
-- FACILITY_ID
-- QUANTITY_LOST_OR_DAMAGED
-- REASON_CODE (Lost, Damaged, Expired, etc.)
-- TRANSACTION_DATE


select
	ii.PRODUCT_ID ,
	ii.INVENTORY_ITEM_ID ,
	ii.FACILITY_ID ,
	ABS(iiv.QUANTITY_ON_HAND_VAR),
	iiv.VARIANCE_REASON_ID as REASON_CODE ,
	iid.EFFECTIVE_DATE
from
	inventory_item_detail iid
join
inventory_item ii on
	iid.INVENTORY_ITEM_ID = ii.INVENTORY_ITEM_ID
	and iid.REASON_ENUM_ID is not null
join
inventory_item_variance iiv
on
	iiv.INVENTORY_ITEM_ID = ii.INVENTORY_ITEM_ID
order by
	ii.PRODUCT_ID

It starts with the inventory_item_detail (iid) table, which logs inventory changes, and joins with inventory_item (ii) to retrieve PRODUCT_ID, 
INVENTORY_ITEM_ID, and FACILITY_ID. The inventory_item_variance (iiv) table is included to capture quantity changes, using ABS(iiv.QUANTITY_ON_HAND_VAR) 
to ensure values are positive.

