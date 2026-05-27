-- โจทย์ที่ 4 (Discount & Maintenance Cost Burden): ดึงค่า discount_percent และค่า maintenance_amount (ค่าบำรุงรักษาระบบหลังบ้านช่วงคนถล่มแอป) แยกตามรายแคมเปญ 

SELECT 
     COALESCE(c.campaign_name, "Normal Day") AS campaign_name,
     COUNT(DISTINCT o.order_id) AS Total_order,
     SUM(i.line_total) AS Total_Revenue,
     ROUND(AVG(i.discount_percent),2) AS Avg_Discount_Percent,
     ROUND(SUM(o.maintenance_total),2) AS Total_maintenance_cost,
     ROUND(SUM(o.maintenance_total) / SUM(i.line_total)*100,2) AS Maintenance_Percent_of_Revenue
FROM shopee_orders_thailand AS o
INNER JOIN shopee_order_items_thailand  AS i
    ON o.order_id = i.order_id 
LEFT JOIN shopee_campaigns_thailand AS c
    ON o.campaign_id = c.campaign_id 
    
WHERE i.item_status = 'Completed'
GROUP BY c.campaign_name
ORDER BY Total_Revenue DESC
    

