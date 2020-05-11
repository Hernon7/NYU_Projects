select * from hl2_stage
--create a sequence to generate primarty key
create sequence seq_object
select * from HL2_state
-------------------------------order_priority---------------------------------

create sequence orderpk
select * from hl2_order_priority
--delete  from Hl2_order_priority
insert into hl2_order_priority(order_priority_pk,priority_name)

select orderpk.nextval pk, order_priority
from (
select distinct trim(order_priority) order_priority from hl2_stage
order by 1
)
---------------------------------customer---------------------------------------
select * from hl2_customer
insert into hl2_customer(customer_pk,customer_name)
select distinct customer_id, customer_name from hl2_stage
order by 1
-------------------------------segment-----------------------------------------

delete from hl2_segment
select * from hl2_segment
insert into hl2_segment(segment_pk,segment_name)
select rownum pk, customer_segment from (
select distinct trim(customer_segment) customer_segment from hl2_stage
order by 1
)
--------------------------customer_segement------------------------------------
insert into hl2_customer_segment( customer_segment_pk, customer_fk,segment_fk)
select rownum pk, customer_id,
(select segment_pk from HL2_segment where segment_name = customer_segment)segment_fk
from(
select distinct customer_id, customer_segment
from HL2_stage
order by 1
)
--------------------------ship_mode----------------------------------------------
insert into HL2_SHIP_MODE(SHIP_MODE_PK,SHIP_MODE_NAME)

select rownum pk, ship_mode from (
select distinct trim(ship_mode) ship_mode from hl2_stage
order by 1
)

--------------------------product_category-----------------
select * from HL2_product_category
--delete from HL2_product_category
insert into HL2_product_category(CATEGORY_PK, category_name)
select rownum pk, product_category
from(
select distinct trim(product_category ) product_category
from HL2_stage
order by 1
)
create sequence subcate start with 4
drop sequence subcate
insert into HL2_product_category(category_pk,category_name,category_rfk)
select subcate.nextval pk, product_sub_category,
(select category_pk from HL2_PRODUCT_CATEGORY
where category_name = product_category) category_rfk from(
select distinct trim(product_category) product_category, trim(product_sub_category) product_sub_category
 
from HL2_stage order by 1
)
-------------------------product_container--------------------

insert into HL2_PRODUCT_CONTAINER(CONTAINER_PK,CONTAINER_NAME)

select rownum pk, product_container from (
select distinct trim(product_container) product_container 
from HL2_stage
order by 1
)

------------------------prodcut--------------------------------
delete from hl2_product
insert into hl2_PRODUCT(PRODUCT_PK, PRODUCT_NAME, BASE_MARGIN, CATEGORY_FK, CONTAINER_FK)
select rownum pk, product_name,product_base_margin,
(select category_pk from HL2_PRODUCT_CATEGORY where category_name = product_sub_category) category_fk,
(select CONTAINER_PK from hl2_PRODUCT_CONTAINER where CONTAINER_NAME = product_container) CONTAINER_fk
from (
select distinct trim(product_name) product_name, product_base_margin,
product_sub_category, product_container
from HL2_stage order by 1
)
select * from hl2_stage
select * from hl2_stage where product_base_margin is NULL 

update hl2_stage
set product_base_margin = 0.49
where product_base_margin is null
---------------------------country-------------------------------

insert into hl2_COUNTRY(COUNTRY_PK,COUNTRY_NAME)

select rownum pk, COUNTRY from (
 
select distinct trim(COUNTRY ) COUNTRY from Hl2_stage
order by 1
)

--------------------------region----------------------------------
insert into HL2_REGION(REGION_PK,REGION_NAME,COUNTRY_FK)

select rownum pk, region,
(select country_pk from HL2_COUNTRY where country_name = COUNTRY) COUNTRY_fk from (
select distinct trim(COUNTRY ) COUNTRY,trim(region ) region from HL2_stage
order by 1
)

-------------------------manager-------------------------------
insert into HL2_MANAGER(MANAGER_PK,MANAGER_NAME,REGION_FK)
select rownum pk, manager,region_fk from(
select trim(manager) manager,
(select region_pk from HL2_region where region_name = region) region_fk from HL2_STAGE_USER
order by manager
)

--------------------------state----------------------------
select * from hl2_state
insert into HL2_STATE (state_pk, state_name, region_fk) select rownum pk, state_or_province,
(select region_pk from HL2_region where region_name = region) region_fk from (
select distinct trim(state_or_province) state_or_province, region from HL2_stage
order by 1
) 


-------------------------address--------------------------------
delete from hl2_address
truncate table hl2_address
insert into HL2_address(ADDRESS_PK,CITY,STATE_FK, POSTAL_CODE,CUSTOMER_FK)

select rownum pk, city, state_fk, postal_code, customer_id
from(
select distinct trim(city) city, 
(select state_pk from HL2_state where state_name = trim(hl2_stage.state_or_province)) state_fk,
trim(state_or_province) state_or_province, lpad(postal_code,5,0) postal_code, 
(select customer_pk from hl2_customer where customer_name = hl2_stage.customer_name)customer_id
from HL2_stage order by 1
)
select * from hl2_address
-------------------------------order-----------------------------
insert into HL2_ORDER(ORDER_PK,order_date,customer_fk,order_id) 
select rownum pk,order_date,customer_id,order_id
from (
select  to_date(order_date,'mm/dd/yyyy') order_date, customer_id,order_id
from HL2_stage
order by 1
)
select * from hl2_order
-------------------------shipment--------------------
insert into HL2_SHIPMENT(SHIPMENT_PK,SHIP_DATE,ADDRESS_FK,SHIPPING_COST, ORDER_PRIORITY_FK,SHIP_MODE_FK,ORDER_FK)

select rownum pk, to_date(ship_date,'mm/dd/yyyy') ship_date,
(select address_pk from HL2_address a where customer_fk = customer_id and a.postal_code
= lpad(postal_code,5,0) ) address_fk, shipping_cost,
(select order_priority_pk from HL2_order_priority where priority_name = trim(order_priority)) order_priority_fk,
(select ship_mode_pk from HL2_ship_mode where ship_mode_name = ship_mode) ship_mode_fk, rownum order_fk

from HL2_stage
------------------------order_information-----------------------------
select * from HL2_order_info
insert into hl2_order_info(info_pk,customer_fk,address_fk,product_fk,ship_date,shipping_cost,ship_mode_fk,order_id,order_date,
order_priority_fk,quantity,discount,unit_price,segment_fk)
select rownum PK, customer_id, address_fk, product_fk, ship_date, shipping_cost,
ship_mode_fk, order_id,order_date,order_priority_fk,quantity_ordered_new,discount,unit_price,segment_fk
from(
select customer_id, (select address_pk from HL2_address a where customer_fk = customer_id and a.postal_code
= lpad(postal_code,5,0) ) address_fk, 

(select product_pk from HL2_product pr
where pr.product_name	= trim(hl2_stage.product_name) 

and NVL(pr.BASE_MARGIN,-1) = NVL(TRIM(PRODUCT_BASE_MARGIN),-1)
) product_fk,

to_date(ship_date,'mm/dd/yyyy') ship_date,
shipping_cost,(select ship_mode_pk from HL2_ship_mode where ship_mode_name = ship_mode) ship_mode_fk,
order_id, to_date(order_date,'mm/dd/yyyy') order_date,
(select order_priority_pk from HL2_order_priority where priority_name = trim(order_priority)) order_priority_fk,
quantity_ordered_new,discount,unit_price,
(select segment_pk from hl2_segment where segment_name = hl2_stage.customer_segment)segment_fk
from HL2_stage
)
delete from hl2_order_info
-----------------------------------create new table-------------------------------------
------------------------------sales by region-------------------------------------------
--create table HL2_1 as
--drop table HL2_1
select region_name,region_sales,(region_sales/total_sales)region_share
from(
select  HL2_region.region_name,
        sum( HL2_order_info.quantity *  HL2_order_info.unit_price) region_sales,
        sum(sum( HL2_order_info.quantity *  HL2_order_info.unit_price))over()total_sales
from HL2_region,
     HL2_state,
     HL2_address,
     HL2_order_info
   
 where HL2_region.region_pk =  HL2_State.region_fk
 and  HL2_State.state_pk =  HL2_address.state_fk
 and  HL2_address.address_pk =  HL2_order_info.address_fk
 group by  HL2_region.region_name
 )
 

-----------------------------top_5_customer-----------------------------

select*
from(
select  HL2_customer.customer_name,
        sum( HL2_order_info.quantity *  HL2_order_info.unit_price) customer_sales
        
from HL2_customer,
     HL2_order_info
 where HL2_customer.customer_pk =  HL2_order_info.customer_fk
 
group by  HL2_customer.customer_name
order by 2 desc
)
where rownum < 6


--------------------top 5 products have the worse shipment delay--------
select *
from (select HL2_product.product_name,
    avg (HL2_order_info.ship_date - HL2_order_info.order_date) average_shipment_processing
    from HL2_product,
         HL2_order_info
    where HL2_product.product_pk = HL2_order_info.product_fk
    group by HL2_product.product_name
    order by 2 desc)
    where rownum < 6
    
------------------------------sales by state-------------------------------------------
--create table HL2_1 as
--drop table HL2_1
select state_name,state_sales,(state_sales/total_sales)state_share
from(
select  HL2_state.state_name,
        sum( HL2_order_info.quantity *  HL2_order_info.unit_price) state_sales,
        sum(sum( HL2_order_info.quantity *  HL2_order_info.unit_price))over()total_sales
from HL2_state,
     HL2_address,
     HL2_order_info
   
 where HL2_State.state_pk =  HL2_address.state_fk
 and  HL2_address.address_pk =  HL2_order_info.address_fk
 group by  hl2_state.state_name
 )
    
----------------------------sales by month--------------------------
 
select order_date, ( HL2_order_info.quantity *  HL2_order_info.unit_price)sales
from hl2_order_info



----------------------------data warehouse-------------------------------
---------------------------customer-------------------------------------
select * from hl3_customer
insert into hl3_customer(customer_pk,customer_name,state,city,postal)
select rownum customer_pk,customer_name, state_name, city,postal_code
from(
select customer_name,state_name, city, postal_code
from hl2_customer  a, hl2_address  b, hl2_state c
where a.customer_pk = b.customer_fk 
and b.state_fk=c.state_pk
)
delete FROM HL3_CUSTOMER
SELECT * FROM HL2_ADDRESS
SELECT * FROM HL2_STATE
--------------------------category---------------------------------
insert into hl3_category 
select * from hl2_product_category
select * from hl3_category

------------------------segment------------------------------------
insert into hl3_segment
select * from hl2_segment
select * from hl3_segment

-----------------------product--------------------------------------
insert into hl3_product(product_pk, product_name, product_container,base_margin)
select rownum pk, product_name, container_name, base_margin
from(
select product_name, container_name, base_margin
from hl2_product a, hl2_product_container b
where a.container_fk = b.container_pk
)
select * from hl3_product 
delete from hl3_product 
delete from hl3_data
----------------------period--------------------------------------
insert into hl3_period(period_pk, month, quarter, year)
select rownum pk, order_month,order_quarter,order_year
from(
select distinct to_char(order_date,'yyyymm')order_month,
to_char(order_date,'yyyy "q"q')order_quarter,
to_char(order_date,'yyyy')order_year
from hl2_order_info
order by 1
)
select * from hl3_product
----------------------fact---------------------------

--select sysdate from dual


select seg_object.nextval pk,
(select segment_pk from hl3_segment hl3
where data.segment_name = hl3.segment_name) segment_fk,
from(
    select segment_name,
from hl2_segment seg,
hl2_order_info ord
where seg.segment_pk = ord.segment_fk
group by segment_name


-----------------------------------------------
select *
from dual connect by level < 100001

create table temp_index
as 
select rownum id,
dbms_random.string('u',30) col1
from dual 
connect by level<100001

select* from temp_index
where id =1

create index indx_temp_index_id on temp_index
(
id
)
-------------------------------------------------------------
create table temp_index  --CTAS
as
SELECT rownum id,dbms_random.string('U',30)coll from dual connect by level <100001

select rowid, a.* from temp_index a where id = 1

create index indx_temp_index_id on temp_index(id)

select segment_name, bytes/1024/1024 mb from user_segments where segment_name like '%temp_index%'

delete from temp_index


select count(*) from temp_index
----------------------------------------------------------------------------------------------------------
insert into hl3_data(data_pk, QUANTITY, UNIT_PRICE, DISCOUNT, 
SHIPPING_COST, SALES, PROFIT, period_fk, PRODUCT_fk, CATEGORY_fk, CUSTOMER_fk, SEGMENT_fk)

select 
seq_object.nextval, 
quantity,
unit_price,
DISCOUNT, 
SHIPPING_COST,
SALES,
PROFIT_CALCULATED,
(select period_pk from hl3_period t where t.month =  to_char(x.order_date, 'yyyymm'))period_fk,
(select product_pk from hl3_product pr where pr.product_name = x.product_name and pr.base_margin = x.base_margin)PRODUCT_fk,
(select category_pk from hl3_category ct where ct.category_name = x.category_name)CATEGORY_fk, 
(select customer_pk from hl3_customer cu where cu.customer_name = x.customer_name)CUSTOMER_fk,
(select segment_pk from hl3_segment se where se.segment_name = x.segment_name)SEGMENT_fk
from(
select segment_name, customer_name, 
product_name,
category_name, 
hl2_product.base_margin,
hl2_order_info.order_date,
sum(hl2_order_info.QUANTITY) QUANTITY,
NULL unit_price,
sum(hl2_order_info.DISCOUNT * unit_price * quantity)DISCOUNT,
sum(hl2_order_info.SHIPPING_COST)SHIPPING_COST,
sum(unit_price * quantity)SALES,
sum(unit_price * quantity*base_margin)PROFIT_CALCULATED
from 
hl2_segment,
hl2_product,
hl2_product_category,
hl2_customer,
hl2_order_info 
where hl2_customer.customer_pk = hl2_order_info.customer_fk
and hl2_segment.segment_pk = hl2_order_info.segment_fk
and hl2_product.product_pk = hl2_order_info.product_fk
and hl2_product_category.category_pk = hl2_product.category_fk
group by segment_name, customer_name, product_name,category_name,hl2_product.base_margin,hl2_order_info.order_date
)x
select * from hl3_data




--Setup
create table mb_linear(x number,y number);
insert into mb_linear(x,y) values(1,1);
insert into mb_linear(x,y) values(2,3);
insert into mb_linear(x,y) values(3,2);
insert into mb_linear(x,y) values(4,3);
insert into mb_linear(x,y) values(5,5);

--Get B0 and B1
SELECT REGR_INTERCEPT( y, x ) AS b0_intercept,
       REGR_SLOPE( y, x ) AS b1_slope
FROM   mb_linear;

--Predict x =10  -> 8.4
SELECT REGR_INTERCEPT( y, x ) + REGR_SLOPE( y, x ) * 10 prediction
FROM   mb_linear









