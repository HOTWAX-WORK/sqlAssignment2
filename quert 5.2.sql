-- 5.2 Orders from New York
-- Business Problem:
-- Companies often want region-specific analysis to plan local marketing, staffing, or promotions in certain areas—here, specifically, New York.

-- Fields to Retrieve:

-- ORDER_ID
-- CUSTOMER_NAME
-- STREET_ADDRESS (or shipping address detail)
-- CITY
-- STATE_PROVINCE
-- POSTAL_CODE
-- TOTAL_AMOUNT
-- ORDER_DATE
-- ORDER_STATUS

select
    oh.ORDER_ID,
    oh.ENTRY_DATE ,
    oh.ORDER_DATE,
    oh.STATUS_ID,
    oh.GRAND_TOTAL,
    p.FIRST_NAME,
    p.LAST_NAME,
    pa.ADDRESS1,
    pa.ADDRESS2,
    pa.CITY,
    pa.STATE_PROVINCE_GEO_ID,
    pa.POSTAL_CODE
from
    order_header oh
join order_role or2 on
    or2.ORDER_ID = oh.ORDER_ID
    and or2.ROLE_TYPE_ID like '%customer'
join person p on
    p.PARTY_ID = or2.PARTY_ID
join order_contact_mech ocm on
    ocm.order_id = oh.ORDER_ID
join contact_mech cm on
    cm.CONTACT_MECH_ID = ocm.CONTACT_MECH_ID
join postal_address pa on
    pa.CONTACT_MECH_ID = cm.CONTACT_MECH_ID
where
    pa.STATE_PROVINCE_GEO_ID = 'NY'
group by
    oh.order_id
;
