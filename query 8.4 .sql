-- 8.4 Items Where QOH and ATP Differ
-- Business Problem:
-- Sometimes the Quantity on Hand (QOH) doesn’t match the Available to Promise (ATP) due to pending orders, reservations, or data discrepancies. This needs review for accurate fulfillment planning.

-- Fields to Retrieve:

-- PRODUCT_ID
-- FACILITY_ID
-- QOH (Quantity on Hand)
-- ATP (Available to Promise)
-- DIFFERENCE (QOH - ATP)

select
	ii.PRODUCT_ID ,
	ii.FACILITY_ID ,
	ii.QUANTITY_ON_HAND_TOTAL ,
	ii.AVAILABLE_TO_PROMISE_TOTAL,
	(ii.QUANTITY_ON_HAND_TOTAL -ii.AVAILABLE_TO_PROMISE_TOTAL) as DIFFERENCE
from
	inventory_item ii ;
