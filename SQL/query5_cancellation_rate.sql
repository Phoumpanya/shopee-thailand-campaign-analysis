โจทย์ที่ 5 (Cancellation Rate During Flash Sales): ออร์เดอร์ที่เกิดขึ้นในช่วงแคมเปญประเภท flash-sale มีอัตราการ
       กดยกเลิกออร์เดอร์ (item_status = 'Cancelled') สูงกว่าช่วงปกติหรือไม่? (พฤติกรรมลูกค้าแย่งกันกดชำระเงินแต่มาเปลี่ยนใจทิ้งทีหลัง)

SELECT 
     COALESCE(c.campaign_name, "Normal Day") AS campaign_name,
     COALESCE(c.campaign_type, "Normal Day") AS campaign_type,
     COUNT(DISTINCT o.order_id) Total_order,
     -- 🌟 1. นับเฉพาะบิลที่โดนยกเลิก (Cancelled)
     COUNT(DISTINCT CASE WHEN i.item_status = 'Cancelled' THEN o.order_id END) AS Cancelled_order,
     -- 🌟 2. คำนวณหาอัตราการยกเลิกออกมาเป็นเปอร์เซ็นต์ (%)
     (COUNT(DISTINCT CASE WHEN i.item_status = 'Cancelled' THEN o.order_id END) / COUNT(DISTINCT o.order_id)) * 100 AS Cancelled_Rate_Percent
FROM shopee_orders_thailand AS o
INNER JOIN shopee_order_items_thailand  AS i
    ON o.order_id = i.order_id 
LEFT JOIN shopee_campaigns_thailand AS c
    ON o.campaign_id = c.campaign_id 
    
GROUP BY c.campaign_name, c.campaign_type
ORDER BY Cancelled_Rate_Percent DESC
    
Answer: yes in flash-sale have a highest Cancelled more than normal