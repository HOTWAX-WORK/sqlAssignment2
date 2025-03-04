
-- 5.3 Top-Selling Product in New York
-- Business Problem:
-- Merchandising teams need to identify the best-selling product(s) in a specific region (New York) for targeted restocking or promotions.

-- Fields to Retrieve:

-- PRODUCT_ID
-- INTERNAL_NAME
-- TOTAL_QUANTITY_SOLD
-- CITY / STATE (within New York region)
-- REVENUE (optionally, total sales amount)

select
	p.PRODUCT_ID ,
	p.INTERNAL_NAME,
	sum(oi.QUANTITY),
	sum(oi.UNIT_PRICE * oi.QUANTITY) AS TOTAL REVENUE,
	pa.CITY ,
	pa.STATE_PROVINCE_GEO_ID
from
	order_item oi
join order_contact_mech ocm on
	ocm.ORDER_ID = oi.ORDER_ID and OCM.CONTACT_MECH_PURPOSE_TYPE_ID like '%LOCATION'
join postal_address pa on
	pa.CONTACT_MECH_ID = ocm.CONTACT_MECH_ID
	and pa.STATE_PROVINCE_GEO_ID = 'NY'
join product p on
	p.PRODUCT_ID = oi.PRODUCT_ID
group by
	p.PRODUCT_ID,
	pa.city,
	pa.STATE_PROVINCE_GEO_ID
having
	SUM(oi.QUANTITY) = (
	select
		MAX(total_quantity)
	from
		(
		select
			SUM(oi2.QUANTITY) as total_quantity,
			pa2.CITY
		from
			order_item oi2
		join order_contact_mech ocm2 on
			ocm2.ORDER_ID = oi2.ORDER_ID
		join postal_address pa2 on
			pa2.CONTACT_MECH_ID = ocm2.CONTACT_MECH_ID
		where
			pa2.STATE_PROVINCE_GEO_ID = 'NY'
		group by
			pa2.CITY,
			oi2.PRODUCT_ID
    ) as city_sales
	where
		city_sales.CITY = pa.CITY
)


---------------------------------------------------------------------------------------------------------------------



SELECT p.PRODUCT_ID, 
       p.INTERNAL_NAME, 
       SUM(oi.QUANTITY) AS total_quantity, 
       SUM(oi.UNIT_PRICE * oi.QUANTITY) AS TOTAL REVENUEe, 
       pa.CITY, 
       pa.STATE_PROVINCE_GEO_ID
FROM order_item oi 
JOIN order_contact_mech ocm ON ocm.ORDER_ID = oi.ORDER_ID and OCM.CONTACT_MECH_PURPOSE_TYPE_ID like '%LOCATION'
JOIN postal_address pa ON pa.CONTACT_MECH_ID = ocm.CONTACT_MECH_ID 
                       AND pa.STATE_PROVINCE_GEO_ID = 'NY'
JOIN product p ON p.PRODUCT_ID = oi.PRODUCT_ID
WHERE pa.CITY = 'New York' 
GROUP BY p.PRODUCT_ID, p.INTERNAL_NAME, pa.CITY, pa.STATE_PROVINCE_GEO_ID
ORDER BY total_quantity DESC


