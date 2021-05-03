#1 Show movies that fit into a budget ordered by their release date
select title, budget, release_date from movie
where budget between 1000 and 50000
order by release_date;

#2 Show the companies for each movie
select title as 'Movie Tile', company_name as 'Company'
from movie, production_company, movie_company
where movie.movie_id = movie_company.movie_id
and production_company.company_id=movie_company.company_id;

#3 Show the number of movies made in each country
select  country_name as "Country", count(title) as "Number of movies made"
from movie, production_country, country
where production_country.movie_id=movie.movie_id and
      production_country.country_id=country.country_id
group by country_name;

#4 Show all women cast members of the "Star wars" movies
select distinct person_name, character_name, m.title
from person join movie_cast mc on person.person_id = mc.person_id
join gender g on mc.gender_id = g.gender_id
join movie m on mc.movie_id = m.movie_id
where m.title like '%Star Wars%' and gender like 'Female';

#5 Show number of crew members for each department (only include
#departments with more than 5 crew members) and display them in descending order
select d.department_name, count(p.person_id)
from movie join  movie_crew mc on movie.movie_id = mc.movie_id
join department d on mc.department_id = d.department_id
join person p on mc.person_id = p.person_id
group by department_name
having count(p.person_id) >  5
order by count(p.person_id) desc;

#6 Show the movies and their homepages of the top 5 most popular action movies in 2015
select title, homepage, release_date, popularity from movie
join movie_genres mg on movie.movie_id = mg.movie_id
join genre g on mg.genre_id = g.genre_id
where g.genre_name like '%action%'
and release_date like '%2015%'
order by movie.popularity desc limit 5;

#7 Top most popular movies starring "Brad Pitt" with a revenue of more than 50k
select title, popularity, revenue from movie join movie_cast mc on movie.movie_id = mc.movie_id
join person p on mc.person_id = p.person_id
where p.person_name like '%Brad Pitt%'
and revenue > 50000
order by popularity desc;

#8 Show male actors who played in at least 5 movies.
select person_name, count(m.movie_id) from person p join movie_cast mc on p.person_id = mc.person_id
join movie m on mc.movie_id = m.movie_id
join gender g on mc.gender_id = g.gender_id
where gender like 'Male'
group by p.person_name
having count(distinct m.movie_id) > 5;

#9 Show the top 10 italian movies with the most revenue
select title, revenue from movie join production_country pc on movie.movie_id = pc.movie_id
join country c on c.country_id = pc.country_id
where country_name like '%Italy%'
order by revenue desc limit 10;

#10 Show all original english movies starring "Johnny Depp" or "Bruce Willis"
select distinct title, person_name from movie join movie_languages ml on movie.movie_id = ml.movie_id
join language l on l.language_id = ml.language_id
join language_role lr on ml.language_role_id = lr.role_id
join movie_cast mc on movie.movie_id = mc.movie_id
join person p on mc.person_id = p.person_id
where language_role like 'Original'
and language_name like 'English'
and person_name like 'Johnny Depp' or
      person_name like 'Bruce Willis';

#11 Show actors from the movie with most number of votes
select person_name, title from person join movie_cast mc on person.person_id = mc.person_id
join movie m on mc.movie_id = m.movie_id
where title in (select title from movie where vote_count = (select max(vote_count) from movie));

#12 Display the average popularity of movies in english
select avg(popularity)  as 'Average popularity' from movie join movie_languages ml on movie.movie_id = ml.movie_id
join language l on ml.language_id = l.language_id
where language_name like '%English%';

#13 Display details of the action movie with the most revenue
select * from movie join movie_genres mg on movie.movie_id = mg.movie_id
join genre g on mg.genre_id = g.genre_id
where revenue = (select max(revenue) from movie)
and genre_name like '%Action%';

#14 Show the most popular movie walt disney ever produced
select title, popularity from movie
where popularity = (select max(popularity)
from movie join movie_company mc on movie.movie_id = mc.movie_id
join production_company pc on mc.company_id = pc.company_id
where company_name like '%Disney%')
and title in (select title
from movie join movie_company mc on movie.movie_id = mc.movie_id
join production_company pc on mc.company_id = pc.company_id
where company_name like '%Disney%');

#15 Display the number of people who worked in 2003 in the movie industry
select count(*) as 'People who worked in 2003' from person join movie_crew mc on person.person_id = mc.person_id
join movie m on mc.movie_id = m.movie_id
join movie_cast c on person.person_id = c.person_id
where EXTRACT(YEAR FROM release_date) = 2003;

#16 Show the company that produced the most movies
select company_name, count(title) from production_company
join movie_company mc on production_company.company_id = mc.company_id
join movie m on mc.movie_id = m.movie_id
group by company_name
order by count(title) desc
limit 1;

#17 Show keywords used in english movies ordered by their popularity
select title, keyword_name from keyword join movie_keywords mk on keyword.keyword_id = mk.keyword_id
join movie m on mk.movie_id = m.movie_id
join movie_languages ml on m.movie_id = ml.movie_id
join language l on ml.language_id = l.language_id
where language_name like '%english%'
order by popularity desc;

#18 List the actors who played in american movies that start with 'a' and end in 's' that have min 3 characters
select person_name, title from person join movie_crew mc on person.person_id = mc.person_id
join movie m on mc.movie_id = m.movie_id
join production_country pc on m.movie_id = pc.movie_id
join country c on pc.country_id = c.country_id
where title like 'm%s'
and country_name like '%america%';

#19 List the top 10 most voted american movies made before 2000
select title, release_date, vote_average from movie m join production_country pc on m.movie_id = pc.movie_id
join country c on pc.country_id = c.country_id
where title = any (select title from movie where release_date < '2000-01-01')
and country_name like '%America%'  order by m.vote_average desc
limit 10;

#20 Show the actors who were cast in all Pirates of the Carribean movies
select person_name from person join movie_cast mc on person.person_id = mc.person_id
join movie m on mc.movie_id = m.movie_id
where title like '%Pirates of the Caribbean%'
group by person_name
having count(m.movie_id) = (select count(title) from movie where title like '%Pirates of the Caribbean%')
order by person_name;