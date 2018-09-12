select first_name, last_name
from actor;

select UPPER(CONCAT(first_name, ' ', last_name)) as `Actor Name`
from actor;

select first_name, last_name, actor_id
from actor
where first_name = "Joe";

select first_name, last_name, actor_id
from actor
where last_name like '%GEN%';

select first_name, last_name, actor_id
from actor
where last_name like '%LI%'
order by last_name, first_name; 

select country_id, country
from country
where country;

alter table actor
add column middle_name varchar(40) after first_name;

alter table actor
modify column middle_name blob;

alter table actor
drop column middle_name;

select last_name, count(last_name) as 'last_name_frequency'
from actor
group by last_name
having `last_name_frequency` >= 2;

select last_name, count(last_name) as 'last_name_frequency'
from actor
group by last_name
having `last_name_frequency` >= 2;

update actor
set first_name = 'HARPO'
where first_name = 'GROUCHO'
and last_name = 'WILLIAMS';

update actor
set first_name =
case
when first_name = 'HARPO'
then 'GROUCHO'
else 'MUCHO GROUCHO'
end
where actor_id = 172;

show create table address;
  
select s.first_name, s.last_name, a.address
from staff s
inner join address a
on (s.address_id = a.address_id);

select s.first_name, s.last_name, sum(p.amount)
from staff as s
inner join payment as p
on p.staff_id = s.staff_id
where month(p.payment_date) = 08 and year(p.payment_date) = 2005
group by s.staff_id;

select f.title, count(fa.actor_id) as 'Actors'
from film_actor as fa
inner join film as f
on f.film_id = fa.film_id
group by f.title
order by Actors desc;

select title, count(inventory_id) as '# of copies'
from film
inner join inventory
using (film_id)
where title = 'Hunchback Impossible'
group by title;

select c.first_name, c.last_name, sum(p.amount) as 'Total Amount Paid'
from payment as p 
join customer as c
on p.customer_id = c.customer_id
group by c.customer_id
order by c.last_name;

select title
from film
where title like 'K%'
or title like 'Q%'
and language_id in
  (
select language_id
from language
where name = 'English'
  );

select first_name, last_name
from actor 
where actor_id in 
  (
select actor_id
from film_actor
where film_id = 
    (
select film_id
       from film
       where title = 'Alone Trip'
      )
   );

select first_name, last_name, email, country
from customer cus
join address a
on (cus.address_id = a.address_id)
join city cit
on (a.city_id = cit.city_id)
join country ctr
on (cit.country_id = ctr.country_id)
where ctr.country = 'canada';

select title, c.name
from film f
join film_category fc
on (f.film_id = fc.film_id)
join category c
on (c.category_id = fc.category_id)
where name = 'family';

select title, count (title) as 'Rentals'
from film
join inventory
on (film.film_id = inventory.film_id)
join rental
on (inventory.inventory_id = rental.inventory_id)
group by title
order by rentals desc;

select s.store_id, sum(amount) as Gross
from payment p
join rental r
on (p.rental_id = r.rental_id)
join inventory i
on (i.inventory_id = r.inventory_id)
join store s
on (s.store_id = i.store_id)
group by s.store_id;  

select store_id, city, country
from store s
join address a
on (s.address_id = a.address_id)
join city cit
on (cit.city_id = a.city_id)
join country ctr
on(cit.country_id = ctr.country_id);  

select sum (amount) as 'Total Sales', c.name as 'Genre'
from payment p
join rental r
on (p.rental_id = r.rental_id)
join inventory i
on (r.inventory_id = i.inventory_id)
join film_category fc
on (i.film_id = fc.film_id)
join category c
on (fc.category_id = c.category_id)
group by c.name
order by sum (amount) desc;

create view top_five_genres as
select sum(amount) as 'Total Sales', c.name as 'Genre'
from payment p
join rental r
on (p.rental_id = r.rental_id)
join inventory i
on (r.inventory_id = i.inventory_id)
join film_category fc
on (i.film_id = fc.film_id)
join category c
on (fc.category_id = c.category_id)
group by c.name
order by sum(amount) desc
limit 5;

select * 
from top_five_genres;

drop view top_five_genres;