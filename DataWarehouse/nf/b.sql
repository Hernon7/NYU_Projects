select * from nf_stage2
------nf_state-----------------------------

DELETE from nf_stage1 where trim(state) = 'Riverside'

insert into nf_state( state_pk, state_name)
select rownum state_pk, state from (
select distinct trim(state)state 
from nf_stage1
order by 1
)

------nf_location-----------------------------
insert into nf_location(location_pk, state_fk,location_name)
select rownum location_pk, 
(select state_pk from nf_state a where a.state_name = b.state ) state_fk,
location 
from (
select distinct trim(state)state, trim(location)location
from nf_stage1
order by 2
)b

------nf_company-----------------------------

insert into nf_company( company_pk, company_name)
select rownum company_pk, company from (
select distinct trim(company)company 
from nf_stage1
order by 1
)


------nf_company_location-----------------------------

insert into nf_company_location( company_location_pk, company_fk, location_fk)
select rownum company_location_pk, 
(select company_pk from nf_company d where d.company_name = c.company ) company_fk, location_pk
from (
select distinct trim(b.company)company, location_pk from nf_location a, nf_stage1 b where a.location_name = b.location 
order by 1
)c

---------------------------nf_user----------------------------
select * from nf_user
insert into nf_user( user_pk, user_profile_name , company_fk, user_id)
select rownum user_pk, user_profile_name, 
(select company_pk from nf_company where company_name = 'amazon') company_fk,
user_id from (
select distinct trim(profilename)user_profile_name, trim(userid)user_id
from nf_stage2
order by 2
)

---------------------------nf_category-----------------------------

insert into nf_category( category_pk, category_name) 
select rownum category_pk, category from (
select distinct trim(category)category 
from nf_stage2
order by 1
)

---------------------------nf_product-----------------------------
select * from nf_product
insert into nf_product( product_pk, company_fk, category_fk, asin,price)
select rownum product_pk,  
(select company_pk from nf_company where company_name = 'amazon') company_fk,
(select category_pk from nf_category a where a.category_name = b.category) category_fk,
asin,price from (
select distinct trim(asin)asin,trim(category)category, to_number(price)price
from nf_stage2
order by 1
)b
delete from nf_product
---nf_product_review 
delete from nf_product_review
select * from nf_product_review
insert into nf_product_review (product_review_pk, product_fk, user_fk, helpfulness_numerator,helpfulness_denominator,score)
select rownum product_review_pk,
product_pk,
(select user_pk from nf_user a where a.user_id = d.userid) user_fk,
helpfulnessnumerator,helpfulnessdenominator,score
from 
(select userid,product_pk,helpfulnessnumerator,helpfulnessdenominator,score 
from nf_product c,nf_stage2 b 
where c.asin = b.asin
order by 2) d

select count(*) from nf_product c,nf_stage2 b
where c.asin = b.asin --and c.price = b.price
-------------------------nf_employee_job-------------------------

insert into nf_employee_job(job_pk, job_name)
select rownum job_pk, job_title
from (
select distinct trim(job_title)job_title
from nf_stage1
order by 1
)

-------------------------nf_working_condition-------------------------

insert into nf_working_condition(condition_pk, condition_state)
select rownum condition_pk,working_condition
from 
(select distinct trim(working_condition)working_condition from nf_stage1 order by 1)

-------------------------company_employee-------------------------

insert into nf_company_employee(employee_id, job_fk, company_fk,working_condition_fk)
select id, 
(select job_pk from nf_employee_job where job_name = trim(job_title))job_fk,
(select company_pk from nf_company where company_name = company)company_fk,
(select condition_pk from nf_working_condition where condition_state = trim(working_condition))working_condition_fk
from nf_stage1
order by 1

------------------------employee_review-------------------------------

insert into nf_employee_review(review_pk,review_date,summary, employee_fk)
select rownum review_pk,
to_date(dates,'mm/dd/yyyy','NLS_DATE_LANGUAGE = American'),
trim(summary)summary,
(select employee_id from nf_company_employee where employee_id = id )employee_fk
from nf_stage1

-----------------------score_list-------------------------------------

insert into nf_score_list(score_list_pk,work_balance_stars,culture_values_stars, carrer_opportunities_stars,comp_benefit_stars,senior_mangement_stars,overall_ratings,employee_review_fk,helpful_count)
select rownum score_list_pk, 
work_balance_stars,
culture_values_stars, 
carrer_opportunities_stars,
comp_benefit_stars,
senior_mangement_stars,
overall_ratings,
(select review_pk from nf_employee_review where employee_fk = id )employee_review_fk,
helpful_count
from nf_stage1


--nf_stock
delete from nf_stock
insert into nf_stock(stock_pk,stock_number,product_fk)
select rownum stock_pk, stock,product_pk
from 
(select product_pk,stock from nf_product a,nf_stage2 b where a.asin = b.asin order by 1)

--------------------------------------------------------------------------------------------




