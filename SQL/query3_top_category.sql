-- โจทย์ที่ 3 (Top Product Categories per Campaign): ในแต่ละแคมเปญ สินค้าหมวดหมู่ไหน (category) เป็นแชมป์ขายดีที่สุด?
-- เช่น ช่วง Songkran Sale หมวด Fashion (เสื้อลายดอก/ปืนฉีดน้ำ) พุ่งแซง Electronics จริงไหม?

SELECT 
     COALESCE(c.campaign_name, "Normal Day") AS campaign_name,
     p.category AS Product_Category,
     SUM(i.quantity) AS Total_unit_sold,
     ROUND(SUM(i.line_total),2) AS Total_Revenue
FROM shopee_orders_thailand AS o
INNER JOIN shopee_order_items_thailand  AS i
    ON o.order_id = i.order_id 
INNER JOIN shopee_products_thailand p
    ON i.product_id = p.product_id 
LEFT JOIN shopee_campaigns_thailand AS c
    ON o.campaign_id = c.campaign_id 
    
WHERE i.item_status = 'Completed'
GROUP BY c.campaign_name, c.campaign_type,p.category
ORDER BY c.campaign_name ASC, Total_Revenue DESC
    
