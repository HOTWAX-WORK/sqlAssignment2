-- Mixed Party + Order Queries
-- 5.1 Shipping Addresses for October 2023 Orders
-- Business Problem:
-- Customer Service might need to verify addresses for orders placed or completed in October 2023. This helps ensure shipments are delivered correctly and prevents address-related issues.

-- Fields to Retrieve:

-- ORDER_ID
-- PARTY_ID (Customer ID)
-- CUSTOMER_NAME (or FIRST_NAME / LAST_NAME)
-- STREET_ADDRESS
-- CITY
-- STATE_PROVINCE
-- POSTAL_CODE
-- COUNTRY_CODE
-- ORDER_STATUS
-- ORDER_DATE



select oh.ORDER_ID ,COALESCE(pG.PARTY_ID, p.PARTY_ID) AS PARTY_ID,COALESCE(pg.GROUP_NAME, p.FIRST_NAME) AS CUSTOMER_NAME_FIRST_NAME,p.LAST_NAME
,pa.ADDRESS1 as STREET_ADDRESS,pa.CITY ,pa.STATE_PROVINCE_GEO_ID as STATE_PROVINCE,pa.POSTAL_CODE ,
pa.COUNTRY_GEO_ID as COUNTRY_CODE
,oh.STATUS_ID as ORDER_STATUS,oh.ORDER_DATE 
from order_header oh 
join order_role or2 on oh.ORDER_ID = or2.ORDER_ID and or2.ROLE_TYPE_ID = 'BILL_TO_CUSTOMER' and oh.STATUS_ID != 'ORDER_CANCELLED'
left join party_group pg on or2.PARTY_ID = pg.PARTY_ID 
left join person p on p.PARTY_ID =or2.PARTY_ID 
join order_contact_mech ocm on ocm.ORDER_ID = oh.ORDER_ID and ocm.CONTACT_MECH_PURPOSE_TYPE_ID = 'SHIPPING_LOCATION'
left join postal_address pa on pa.CONTACT_MECH_ID = ocm.CONTACT_MECH_ID
where oh.ORDER_DATE between '2023-10-01' and '2023-10-31'



-- EXPLANATION (APPROACH)
-- The approach involves querying tables such as order_header for order details, order_role to connect each order with the customer 
--(identified as BILL_TO_CUSTOMER), and party_group or person for customer names, depending on whether the customer is a group or individual. 
--The query also joins with the order_contact_mech table to identify shipping locations and the postal_address table to extract address details
--like street, city, state, postal code, and country. Filtering is applied to select orders within the specified date range and exclude canceled orders. 
--Using COALESCE, the query ensures proper retrieval of customer names and returns all relevant fields, including ORDER_ID, customer details, address,
--ORDER_STATUS, and ORDER_DATE, providing a comprehensive view of shipping addresses for customer service to verify
