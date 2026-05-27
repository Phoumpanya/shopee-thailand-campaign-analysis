-- โจทย์ที่ 6 (Delivery Efficiency Preparation): ดึงข้อมูล estimated_delivery_start, estimated_delivery_end 
-- แยกกลุ่มระหว่างออร์เดอร์ช่วงแคมเปญยักษ์ใหญ่ กับวันธรรมดา เพื่อส่งให้ Python ไปเช็กดูว่าขนส่งไทยค้างส่งคอขวดช่วงเทศกาลไหม

SELECT 
     o.order_id,
     o.order_date,
     COALESCE(c.campaign_name, "Normal Day") AS campaign_name,
     i.estimated_delivery_start,
     i.estimated_delivery_end
FROM shopee_orders_thailand AS o
INNER JOIN shopee_order_items_thailand  AS i
    ON o.order_id = i.order_id 
LEFT JOIN shopee_campaigns_thailand AS c
    ON o.campaign_id = c.campaign_id 
WHERE i.item_status = 'Completed'
LIMIT  100
    
