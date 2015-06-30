
PROJECT #3



1.

select 
 a.driver_id as "Driver ID",
 b.name as "Driver Name",
 a.id as "Accident ID",
 a.datetime as "Date of Accident",
 a.severity as "Severity",
 cc.make as "Car Make",
 cc.model as "Car Model"
from accident a
join borrower b on a.driver_id = b.id
join car c on c.id=a.car_id
join carCatalog cc on cc.id = c.car_catalog_id
where a.details LIKE "%Alcohol%";



2. 

select
 a.driver_id,
 count(*) as accidents,
 b.name,
 timestampdiff(year,b.birthdate,CURDATE())
from accident a
join borrower b on b.id = a.driver_id
group by a.driver_id
having accidents > 1
order by accidents desc;



3.

select
   cc.color as Color
 , tbl.car_count as "Number of Cars"
 , count(*) as "Number of Accidents"
 , min(a.severity) as "Min severity"
 , max(a.severity) as "Max Severity"
 , avg (a.severity) as "Average Severity"
from car c
join accident a on a.car_id = c.id
join carcatalog cc on cc.id = c.car_catalog_id
join ( select 
          cc.color color
	, count(*) car_count
       from carcatalog cc
       join car c on c.car_catalog_id = cc.id
       group by cc.color
     ) tbl on  tbl.color = cc.color
group by cc.color;



4.
create view CompBorrowCount as
select
  b.id as ID
, b.name as Name
, b.email as Email
, b.count as StoredBC
, count(*) as ComputedBC
from borrower b
join offer o on o.offerer_id = b.id
join deal d on d.id = o.id
group by b.id;

select 
   id
 , name
 , email
 , storedbc
 , computedbc
from compborrowcount
where computedbc = 
(
 select
   max(computedbc)
 from compborrowcount
);



5.
select 
  cc.model
, count(cc.model) as Count 
from lendpost lp
join offer o on o.lend_post_id = lp.id
join deal d on d.id = o.id
join car c on c.id = lp.car_id 
join carcatalog cc on cc.id = c.car_catalog_id
where year(lp.pickup_datetime) = 2014
group by cc.model;



6.
select tbl2.make, r_year, maxcar
from 
(
 select tbl1.make, r_year, max(tbl1.carCnt) as maxcar
 from
(
 select cc.make, count(cc.make) as carCnt, year(lp.pickup_datetime) as r_year
 from car c
    , carcatalog cc
    , deal d
    , offer o
    , lendpost lp
 where d.id = o.id 
 and o.lend_post_id = lp.id 
 and lp.car_id = c.id 
 and c.car_catalog_id = cc.id
 group by cc.make
)tbl1
 group by r_year
)tbl2
 group by r_year 
 order BY r_year desc



