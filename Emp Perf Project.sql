create database employee;

use employee;

-- 1

alter table emp_record_table
modify column emp_id varchar(20);
alter table emp_record_table
add primary key(emp_id);

alter table proj_table
modify column project_id varchar(20);
alter table proj_table
add primary key(project_id);


select * from emp_record_table ;
update emp_record_table
set proj_id=null
where proj_id='NA';

alter table emp_record_table
modify column proj_id varchar(20);
alter table emp_record_table
add foreign key(proj_id) references proj_table(project_id);

-- 2

alter table data_science_team
modify column emp_id varchar(20);
alter table data_science_team
add foreign key(emp_id) references emp_record_table(emp_id);

-- 3
SELECT emp_id,first_name,last_name,gender,dept from emp_record_table;

-- 4

SELECT emp_id,first_name,last_name,gender,dept,emp_rating from emp_record_table
where emp_rating between 2 and 4;

SELECT emp_id,first_name,last_name,gender,dept,emp_rating from emp_record_table
where emp_rating <2;

SELECT emp_id,first_name,last_name,gender,dept,emp_rating from emp_record_table
where emp_rating >4;


-- 5
select concat(first_name, ' ', last_name) AS Names from emp_record_table
where dept='Finance';

-- 6

select * from emp_record_table;

select concat(first_name, ' ',last_name) as ENAme, cnt from emp_record_table as t1
inner join 
(select manager_id, count(*) as cnt from emp_record_table 
group by manager_id) as t2
on t1.emp_id=t2.manager_id
;


-- 7

select * from emp_record_table where dept='Finance'
union
select * from emp_record_table where dept='HealthCare';

-- 8

select *, max(emp_rating) over(partition by dept order by emp_rating desc)
from emp_record_table;

-- 9

select role,
    MIN(salary) as minimum_salary,
    MAX(salary) as maximum_salary
from emp_record_table
group by role;

-- 10
select first_name, last_name, exp, rank() over (order by exp desc) as experience_rank
from emp_record_table;

select concat(first_name, ' ',last_name) as ENAme, exp, rank() over (order by exp desc) as experience_rank
from emp_record_table;

--
select * from emp_record_table;
-- 11

CREATE VIEW EMPLOYEES_BY_COUNTRY 
AS
select salary, first_name, country from emp_record_table
WHERE SALARY > 6000;

select * from EMPLOYEES_BY_COUNTRY;

-- 12

select * from (
select * from emp_record_table
where exp>10) as t;

-- 13 
-- Stored procedure -- 

delimiter //
create procedure sp_high_exp_emps()
begin
select * from emp_record_table where exp > 3;
end //
delimiter ;

call sp_high_exp_emps;


-- 14

select * , case
				when exp <=2 then 'JUNIOR DATA SCIENTIST'
				when exp <=5 then 'ASSOCIATE DATA SCIENTIST'
				when exp <=10 then 'SENIOR DATA SCIENTIST'
				when exp <=12 then 'LEAD DATA SCIENTIST'
				when exp <=16 then 'MANAGER'
end as task from emp_record_table;


-- 15

alter table emp_record_table
modify column FIRST_NAME varchar(20);

create index ix_fname on emp_record_table(first_name);


-- 16

select *, salary*0.05 as bonus from emp_record_table;


-- 17

select continent,country, avg(salary) AS Avg from emp_record_table
group by continent ,country;





    
    

