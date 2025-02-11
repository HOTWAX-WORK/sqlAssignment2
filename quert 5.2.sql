select
	oh.ORDER_ID,
	coalesce(pg.GROUP_NAME, p.FIRST_NAME) as CUSTOMER_NAME_FIRST_NAME,
	p.LAST_NAME
,
	pa.ADDRESS1 as STREET_ADDRESS,
	pa.CITY ,
	pa.STATE_PROVINCE_GEO_ID as STATE_PROVINCE,
	pa.POSTAL_CODE ,
	pa.COUNTRY_GEO_ID as COUNTRY_CODE
,
	oh.STATUS_ID as ORDER_STATUS,
	oh.ORDER_DATE
from
	order_header oh
join order_role or2 on
	oh.ORDER_ID = or2.ORDER_ID
	and or2.ROLE_TYPE_ID = 'BILL_TO_CUSTOMER'
left join party_group pg on
	or2.PARTY_ID = pg.PARTY_ID
left join person p on
	p.PARTY_ID = or2.PARTY_ID
join order_contact_mech ocm on
	ocm.ORDER_ID = oh.ORDER_ID
	and ocm.CONTACT_MECH_PURPOSE_TYPE_ID = 'SHIPPING_LOCATION'
join postal_address pa on
	pa.CONTACT_MECH_ID = ocm.CONTACT_MECH_ID
	and pa.STATE_PROVINCE_GEO_ID = 'NY'
	and pa.CITY = 'New York'
	
	
	--contact mech data is not redudant items can be delivered at different locations
