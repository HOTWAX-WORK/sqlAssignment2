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
