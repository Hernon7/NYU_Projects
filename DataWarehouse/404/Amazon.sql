----------------------------Henanli-------------------------------
select * from nf_stage_1
update nf_stage_1
set senior_mangement_stars = null
where senior_mangement_stars = 'none'

set comp_benefit_stars = null
where comp_benefit_stars = 'none'
set carrer_opportunities_stars = null
where carrer_opportunities_stars = 'none'

set work_balance_stars = null
where work_balance_stars = 'none'

set culture_values_stars = null
where work_balance_stars = 'none'
---------------------------nf_company-----------------------------
insert into nf_company( company_pk, company_name)
select rownum pk, company from (
select distinct trim(company)company 
from nf_stage_1
order by 1
)
-------------------------company_employee-------------------------
select * from nf_company_employee
insert into nf_company_employee(employee_id, employee_job, company_fk)
select ID, trim(job_title)job_title,
(select company_pk from nf_company where company_name = nf_stage_1.company)company_fk
from nf_stage_1
order by 1
--delete from nf_company_employee
------------------------employee_review-------------------------------
insert into nf_employee_review(review_pk, review_date, summary, advice, employee_fk)
select rownum pk, --to_date(dates,'Month dd,yyyy','NLS_DATE_LANGUAGE = American')
dates,
summary, advice_to_mgmt,(select employee_id from nf_company_employee where employee_id = ID )employee_fk
from nf_stage_1

alter session set nls_date_language='american';  
-----------------------score_list-------------------------------------
insert into nf_score_list(score_list_pk,work_balance_stars,culture_values_stars, carrer_opportunities_stars,comp_benefit_stars,senior_mangement_stars,
overall_ratings,employee_review_fk,helpful_count)
select rownum pk, work_balance_stars,culture_values_stars, carrer_opportunities_stars,comp_benefit_stars,senior_mangement_stars,
overall_ratings,(select review_pk from nf_employee_review where employee_fk = ID )employee_review_fk,helpful_count
from nf_stage_1

