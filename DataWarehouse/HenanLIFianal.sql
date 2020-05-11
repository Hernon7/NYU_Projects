-------------import stage table--------------------
select * from hlfin_stage
select count(*)from hlfin_data

------------------address-------------------------
insert into hlfin_address(address_pk,zip,street,city,state,country)
select rownum pk,zip,street, city,state,country 
from(
select distinct trim(zip)zip, trim(street)street,trim(city)city,trim(state)state,trim(country)country
from hlfin_stage
)

---------------------customer-------------------
insert into hlfin_customer(customer_pk,customer_name,phone)
select distinct to_number(customerid)customer_pk, trim(customer_name) customer_name,trim(phone)phone
from hlfin_stage

--------------------product---------------------------
select * from hlfin_product
delete from  hlfin_product
insert into hlfin_product(product_pk,stockcode,description)
select rownum pk,stockcode,description
from(
select stockcode,description
from  hlfin_stage
group by stockcode,description)
-------------------invoice---------------------------------
insert into hlfin_invoice(invoice_pk,invoice_date,invoice_week)
select pk,invoicedate,to_char(invoicedate,'yyyy''ww')invoiceweek
from(
select distinct to_number(InvoiceNo)pk,to_date(invoicedate,'mm/dd/yyyy')invoicedate
from hlfin_stage)

-------------------------------------------------------------data---------------------------------------------------------
create sequence seq_final
select * from hlfin_product
------------------------product-------------------------------------
insert into hlfin_data(data_pk,unit_price,product_fk,quantity,sales,profit)
select seq_final.nextval data_pk,null unit_price,fk,quantity,sales,profit
from(
select (select product_pk from hlfin_product p where p.description = a.description)fk,
trim(stockcode)stockcode,trim(description)description, sum(quantity)quantity, sum(a.quantity*a.unitprice)sales, (0.3*sum(a.quantity*a.unitprice))profit
from  hlfin_stage a
group by stockcode,description
)

-------------------------address---------------------------------------


insert into hlfin_data(data_pk,unit_price,address_fk,quantity,sales,profit)
select seq_final.nextval data_pk,null unit_price,fk,quantity,sales,profit
from(
select (select address_pk from hlfin_address ad where ad.zip = trim(a.zip))fk,
zip, sum(quantity)quantity, sum(a.quantity*a.unitprice)sales, (0.3*sum(a.quantity*a.unitprice))profit
from  hlfin_stage a
group by zip
)

----------------------------customer--------------------------------------------------
insert into hlfin_data(data_pk,unit_price,customer_fk,quantity,sales,profit)
select seq_final.nextval data_pk,null unit_price,fk,quantity,sales,profit
from(
select (select customer_pk from hlfin_customer c where c.customer_name = trim(a.customer_name))fk,
customer_name, sum(quantity)quantity, sum(a.quantity*a.unitprice)sales, (0.3*sum(a.quantity*a.unitprice))profit
from  hlfin_stage a
group by customer_name
)

--------------------------invoice------------------------

insert into hlfin_data(data_pk,unit_price,invoice_fk,quantity,sales,profit)
select seq_final.nextval data_pk,null unit_price,fk,quantity,sales,profit
from(
select (select invoice_pk from hlfin_invoice i where i.invoice_pk = to_number(a.invoiceno))fk,
invoiceno, sum(quantity)quantity, sum(a.quantity*a.unitprice)sales, (0.3*sum(a.quantity*a.unitprice))profit
from  hlfin_stage a
group by invoiceno
)


----------------------top 5 most popular products--------------
select * from(
select description,quantity
from hlfin_data a,hlfin_product b
where a.product_fk = product_pk
order by 2 desc) where rownum <6

--------------------top 5 customer---------------------------
select * from(
select customer_name,sales
from hlfin_data a,hlfin_customer b
where a.customer_fk = b.customer_pk
order by 2 desc) where rownum <6

----------------------profit for each state in US ------------------

select state,sum(profit)profit
from  hlfin_data a,hlfin_address b
where a.address_fk = b.address_pk and country='US'
group by state

-----------------------weekly sales-------------------
select invoice_week,sum(sales)sales
from  hlfin_data a,hlfin_invoice b
where a.invoice_fk = b.invoice_pk 
group by invoice_week 
order by 1

-------------------profit for two country-------------
select country,profit,round(profit/total_profit,2)country_share
from(
select country,sum(profit)profit,sum(sum(profit))over()total_profit
from  hlfin_data a,hlfin_address b
where a.address_fk = b.address_pk 
group by country)

select country,quantity,round(quantity/total_quantity,2)country_share
from(
select country,sum(quantity)quantity,sum(sum(quantity))over()total_quantity
from  hlfin_data a,hlfin_address b
where a.address_fk = b.address_pk 
group by country)

select user_pk,category_name,max(score)max_score
from nf_user a, nf_product_review b,nf_product c, nf_category d
where a.user_pk = b.user_fk
and c.product_pk = b.product_fk
and c.category_fk = d.category_pk
group by user_pk,category_name
order by user_pk



