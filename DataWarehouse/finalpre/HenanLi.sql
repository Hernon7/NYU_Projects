
-------------------------job------------------------------------
select employee_pk,job,working_condition,em_work_balance_stars/5,
    em_culture_values_stars/5, 
    em_career_opportunities_stars/5,
    em_comp_benefit_stars/5,
    em_senior_management_stars/5,
    em_overall_ratings/5
    from nf3_data a,nf3_employee b
    where a.employee_fk = b.employee_pk
    
select 
    working_condition,job,
    em_work_balance_stars,
    em_culture_values_stars, 
    em_career_opportunities_stars,
    em_comp_benefit_stars,
    em_senior_management_stars,
    em_overall_ratings
    from nf3_data a,nf3_employee b
    where a.employee_fk = b.employee_pk
    
    
select 
    working_condition,
    em_work_balance_stars/5,
    em_culture_values_stars/5, 
    em_career_opportunities_stars/5,
    em_comp_benefit_stars/5,
    em_senior_management_stars/5,
    em_overall_ratings/5
    from nf3_data a,nf3_employee b
    where a.employee_fk = b.employee_pk
   
    
    
------------------company--------------    
select company,
    ROUND(avg(em_work_balance_stars),2)work_balance_stars,
    ROUND(avg(em_culture_values_stars),2)culture_values_stars, 
    ROUND(avg(em_career_opportunities_stars),2)career_opportunities_stars,
    ROUND(avg(em_comp_benefit_stars),2)comp_benefit_stars,
    ROUND(avg(em_senior_management_stars),2)senior_management_stars,
    ROUND(avg(em_overall_ratings),2)overall_ratings
    from nf3_data a,nf3_employee b
    where a.employee_fk = b.employee_pk
    group by company
    
-----------------------------state--------------------   
select state,
    ROUND(avg(em_work_balance_stars),2)work_balance_stars,
    ROUND(avg(em_culture_values_stars),2)culture_values_stars, 
    ROUND(avg(em_career_opportunities_stars),2)career_opportunities_stars,
    ROUND(avg(em_comp_benefit_stars),2)comp_benefit_stars,
    ROUND(avg(em_senior_management_stars),2)senior_management_stars,
    ROUND(avg(em_overall_ratings),2)overall_ratings
    from nf3_data a,nf3_location b, nf3_employee c
    where a.location_fk = b.location_pk 
    group by state
    order by overall_ratings desc
----------------------category----------------------------    
select category,
    prod_score,
    prod_helpfulness,
    prod_price
    from nf3_data a,nf3_product b
    where a.product_fk = b.product_pk
    
    
select * from(    
select category, ROUND(avg(prod_score),2)prod_score,
    ROUND(avg(prod_helpfulness),2)culture_values_helpfulness,
    ROUND(avg(prod_price),2)prod_price
     from nf3_data a,nf3_product b
    where a.product_fk = b.product_pk
    group by category
    order by prod_price desc
    )where rownum<11
    
    
select user_pk,category_name,max(score)max_score
from nf_user a, nf_product_review b,nf_product c, nf_category d
where a.user_pk = b.user_fk
and c.product_pk = b.product_fk
and c.category_fk = d.category_pk
group by user_pk,category_name
order by user_pk



