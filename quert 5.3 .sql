select
	p.PRODUCT_ID ,
	p.INTERNAL_NAME,
	sum(oi.QUANTITY),
	sum(oi.UNIT_PRICE),
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

