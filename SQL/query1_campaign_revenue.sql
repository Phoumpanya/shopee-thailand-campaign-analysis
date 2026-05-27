-- โจทย์ที่ 1 (Campaign Revenue & Volume): แคมเปญไหนในประเทศไทย (เช่น 11.11, 12.12, Songkran Sale) ทำรายได้รวม (SUM(line_total)) และยอดสั่งซื้อสูงที่สุด?

SELECT 
    COALESCE(c.campaign_name, 'Normal Day') AS campaign_name, -- ถ้าวันไหนไม่มีแคมเปญ ให้ขึ้นว่าวันธรรมดา
    COUNT(DISTINCT o.order_id) AS total_orders,                       -- นับจำนวนออร์เดอร์ทั้งหมดในแคมเปญนั้น
    SUM(i.quantity) AS total_units_sold,                              -- รวมจำนวนชิ้นสินค้าที่ขายได้
    ROUND(SUM(i.line_total),2) AS total_revenue                                -- รวมรายได้ทั้งหมดเป็นบาท
FROM shopee_orders_thailand AS o
INNER JOIN shopee_order_items_thailand AS i 
    ON o.order_id = i.order_id 
LEFT JOIN shopee_campaigns_thailand AS c 
    ON o.campaign_id = c.campaign_id 
WHERE i.item_status = 'Completed'
GROUP BY c.campaign_name                            -- ยุบรวมข้อมูลตามชื่อและประเภทแคมเปญ
ORDER BY total_revenue DESC;                                          -- เรียงจากแคมเปญที่ทำเงินสูงสุดลงไป
    
