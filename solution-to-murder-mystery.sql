-- my solution for SQL murder mystery

-- Find Crime scene report for 15 of jan 2018 for murder in SQL City
select * 
from crime_scene_report 
where date = 20180115 and
city = "SQL City" and 
type = "murder";

/*
Security footage shows that there were 2 witnesses. The first 
witness lives at the last house on "Northwestern Dr". The 
second witness, named Annabel, lives somewhere on "Franklin Ave".
*/

-- Witness 1
select * 
from interview i
join person p on i.person_id = p.id
where address_street_name = "Northwestern Dr"
order by address_number desc
limit 1;
              
/*
I heard a gunshot and then saw a man run out. He had a 
"Get Fit Now Gym" bag. The membership number on the bag started 
with "48Z". Only gold members have those bags. The man got into 
a car with a plate that included "H42W".
*/

-- Witness 2
select * 
from interview i
join person p on i.person_id = p.id
where address_street_name = "Franklin Ave" and 
name like "Annabel%"
limit 10;

/*
I saw the murder happen, and I recognized the killer from my 
gym when I was working out last week on January the 9th.
*/

-- guy wit 1 saw
select * 
from get_fit_now_member g
join person p on g.person_id = p.id
join drivers_license d on p.license_id = d.id
where membership_status = "gold"
and gender = "male"
and g.id like "48Z%"
limit 10;

-- Jeremy Bowers

-- Interview
select * 
from interview i
join person p on i.person_id = p.id
where
name like "Jeremy Bowers"
limit 10;

/*
I was hired by a woman with a lot of money. I don't know 
her name but I know she's around 5'5" (65") or 5'7" (67"). 
She has red hair and she drives a Tesla Model S. I know 
that she attended the SQL Symphony Concert 3 times in December 2017. 
*/

-- suspects
select *
from person p
join drivers_license d on p.license_id = d.id
where gender = "female"
and hair_color = "red"
and car_make = "Tesla";

/*
Red Korb
Regina George
Miranda Priestly
*/

-- who whent 3 times to SQL SYmphony Concert 3 times in december 2017
select name, event_name, count() as c
from facebook_event_checkin f
join person p on f.person_id = p.id
where date < 20180101 and date >= 20171201
and event_name like "SQL Symphony Concert%"
and name in (select name
              from person p
              join drivers_license d on p.license_id = d.id
              where gender = "female"
              and hair_color = "red"
              and car_make = "Tesla")
group by name, event_name
having c = 3;

/*
Miranda is the only one who fits de secription and whent to SQL symphony! 
We have our murderer!!!
*/

