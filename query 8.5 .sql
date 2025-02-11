SELECT
    os.ORDER_ID,
    os.ORDER_ITEM_SEQ_ID,
    s.STATUS_ID,
    ss.STATUS_DATE,
    ss.CHANGE_BY_USER_LOGIN_ID
FROM
    order_shipment os
JOIN shipment s ON os.SHIPMENT_ID = s.SHIPMENT_ID
JOIN shipment_status ss ON s.SHIPMENT_ID = ss.SHIPMENT_ID
WHERE
    ss.STATUS_DATE = (
        SELECT MAX(ss2.STATUS_DATE)
        FROM shipment_status ss2
        WHERE ss2.SHIPMENT_ID = ss.SHIPMENT_ID
    )
ORDER BY
    os.ORDER_ID, os.ORDER_ITEM_SEQ_ID;

