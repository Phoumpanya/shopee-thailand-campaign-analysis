-- โจทย์ที่ 2 (Campaign vs. Organic AOV): ค่าเฉลี่ยต่อบิล (Average Order Value) ในช่วงที่มีการจัดแคมเปญโปรโมชั่น สูงหรือต่ำกว่าการซื้อขายในวันธรรมดา? (ลูกค้าอัดอั้นมาตุนของช่วงเซลจริงไหม)

SELECT 
     COALESCE(c.campaign_name, "Normal Day") AS campaign_name,
     COUNT(DISTINCT o.order_id) AS Total_Order,
     SUM(i.quantity) AS Total_unit_sold,
     ROUND(SUM(i.line_total),2) AS Total_Revenue,
     ROUND(SUM(i.line_total) / COUNT(DISTINCT o.order_id),2) AS Average_Order_Value
FROM shopee_orders_thailand AS o
INNER JOIN shopee_order_items_thailand  AS i
    ON o.order_id = i.order_id 
LEFT JOIN shopee_campaigns_thailand AS c
    ON o.campaign_id = c.campaign_id 
    
WHERE i.item_status = 'Completed'
GROUP BY c.campaign_name, c.campaign_type
ORDER BY Total_Revenue DESC
    
