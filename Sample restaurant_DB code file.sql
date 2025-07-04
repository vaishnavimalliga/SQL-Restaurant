use restaurant_db;

-- OBJECTIVE 1: EXPLORE THE ITEMS TABLE


  -- 1. View the menu_items table.
  select * from menu_items;
  
  -- 2. Find the no.of.items on menu.
  select count(*) as no_of_items 
  from menu_items;
  
  -- 3. What are least and most expensive items on menu.
  select min(price) as least_price, max(price) as Max_price
  from menu_items;
  
  -- 4. How many Italian dishes are on menu.
  select count(*) as no_of_Italian_dishes 
  from menu_items
  where category = 'Italian';
  
  -- 5. What are least and most expensive Italian dishes on menu.
  select min(price) as min_Italian_dishes, max(price) as max_Italian_dishes 
  from menu_items
  where category = 'Italian';
  
  -- 6. How many dishes are in each category.
  select category,count(*) as no_of_dishes
  from menu_items 
  group by category;
  
  -- 7. What is average dish price within each category.
  select category,avg(price) as avg_price 
  from menu_items
  group by category;




-- OBJECTIVE 2: EXPLORE THE ORDERS TABLE



 -- 1. View order_details table
 select * from order_details;
 
 -- 2. what is data range of table
 select min(order_date) as min_date , max(order_date) as max_date 
 from order_details;
 
 -- 3. how may orders were made within this date range
 select count(distinct order_id) from order_details;
 
 -- 4. how many items were added within this data range
 select count(*) from order_details;
 -- 5. which orders had most no.of.items
 select order_id,count(item_id) as no_of_items
 from order_details
 group by order_id
 order by no_of_items desc;
 
 -- 6. How many orders had morethan 12 items
 select count(*) as num_orders from
 (select order_id,count(item_id) as no_of_items
 from order_details
 group by order_id
 having no_of_items > 12) as x;




-- OBJECTIVE 3: ANALYZE CUSTOMER BEHAVIOR



-- 1. Combine menu_items and order_details table into single table
select * from 
order_details od
left join menu_items mi on od.item_id = mi.menu_item_id;

-- 2. What were least and most ordered items? what categories were they in?
select item_name,category,count(order_details_id) as num_purchases
from order_details od
left join menu_items mi on od.item_id = mi.menu_item_id
group by item_name,category
order by num_purchases desc;

-- (((I got answer for most question , Chicken Tacos of Mexicon category menu is not doing well
								-- Hamburger of American category menu is doing well)))

-- 3.What were top 5 orders that spent most money?
select order_id,sum(price) as total_spend
from order_details od
left join menu_items mi on od.item_id = mi.menu_item_id
group by order_id
order by total_spend desc
limit 5;

-- 4. View details of highest spend order.what insights can u gather from results?
select category,count(item_id) as num_items from 
order_details od
left join menu_items mi on od.item_id = mi.menu_item_id
where order_id = 440  -- becoz u done previous top 5 so u know first high spend (i.e. 440)
group by category;  

-- 5. View details of top 5 highest spend order.what insights can u gather from results?
select order_id,category,count(item_id) as num_items from 
order_details od
left join menu_items mi on od.item_id = mi.menu_item_id
where order_id in (440,2075,1957,330,2675)  -- becoz u done previous top 5 so u know first high spend (i.e. 440)
group by order_id,category;  


/*440  	192.15
  2075	191.05
  1957	190.10
  330	189.70
  2675	185.10*/


-- We have seen that these highest spent orders they tend to be spending a lot on italian food
--   so the insight that we've gathered here , we should keep these expensive italian dishes on our menu , 
--   becoz people seem to be ordering them a lot 