SELECT * FROM project_netflix.imdb_scores;
SELECT * FROM project_netflix.netflix_movies;

-- Looking at IMDB scores coloumn
-- To find average score by title
SELECT title, round (AVG(IMDB_Score), 2) AS 'Average IMDBScore' FROM project_netflix.imdb_scores
order by title;

-- To find by with highest score
SELECT title, round (sum(Imdb_Score), 2) AS 'Sum IMDBScore' FROM project_netflix.imdb_scores
group  by title
ORDER BY 2 Desc; 

-- Use of where clause
SELECT * FROM project_netflix.imdb_scores
WHERE imdb_score = 4.1;

-- To find the maximum IMDB score
SELECT MAX(imdb_score) FROM project_netflix.imdb_scores;

-- To find the minimum IMDB score
SELECT Min(imdb_score) FROM project_netflix.imdb_scores;

-- To find the maximum IMDB score by Title
SELECT title
FROM project_netflix.imdb_scores
WHERE IMDB_Score = (SELECT max(IMDB_Score) FROM project_netflix.imdb_scores);

-- To find the minimum IMDB score by Title
select title FROM project_netflix.imdb_scores
where IMDB_Score = (select min(IMDB_Score) from project_netflix.imdb_scores);

-- Looking at Netflix Movies coloumn

-- 	To find which Movie has the highest and lowest runtime per Genre
SELECT MAX(imdb_score) FROM project_netflix.imdb_scores;

SELECT * FROM project_netflix.netflix_movies;
-- to find genre with highest runtime
SELECT Genre, runtime FROM project_netflix.netflix_movies
WHERE Runtime = (SELECT max(Runtime) FROM project_netflix.netflix_movies);

-- to find genre with lowest runtime
SELECT Genre, runtime FROM project_netflix.netflix_movies
WHERE Runtime = (SELECT min(Runtime) FROM project_netflix.netflix_movies);

-- Use of where clause
SELECT * FROM project_netflix.netflix_movies
WHERE Language ='English';

-- Top 5 titles for library database
SELECT * FROM project_netflix.netflix_movies
ORDER BY Runtime DESC
LIMIT 5;

-- Bottom 5 titles for library database
SELECT * FROM project_netflix.netflix_movies
ORDER BY Runtime asc
LIMIT 5;

-- Joining datasets base on Title
SELECT * FROM project_netflix.imdb_scores ni
INNER JOIN project_netflix.netflix_movies nm 
ON ni.title = nm.title;

SELECT ni.Title, ni.IMDB_Score, nm.Genre, nm.Premiere, nm.Runtime,
nm.Language 
FROM project_netflix.imdb_scores ni
INNER JOIN project_netflix.netflix_movies nm 
ON ni.title = nm.title;


-- To count how many languages are there
select count(language) from project_netflix.netflix_movies;

-- Most common film language
select max(language) from project_netflix.netflix_movies; 

-- Highest rated movie v lower rated movie
select max(title) as 'max title' FROM project_netflix.imdb_scores;
select min(title) as 'min title' FROM project_netflix.imdb_scores;

-- How does runtime differ across genres and languages
SELECT  nm.Runtime, nm.Genre, nm.Language 
FROM project_netflix.imdb_scores ni
INNER JOIN project_netflix.netflix_movies nm 
ON ni.title = nm.title
group by genre
order by genre;

-- find the average runtime by the language 
select language, avg(runtime) As ' Average Runtime' FROM project_netflix.netflix_movies
group by language
order by runtime desc
LIMIT 5;

-- find the average runtime by the genre
select Genre, avg(runtime) As ' Average Runtime' FROM project_netflix.netflix_movies
group by Genre
order by runtime desc
LIMIT 5;

-- when runtime is more than avg AND Imdb score is less than avg then worse value 
select ni.imdb_score, nm.runtime, case
WHEN ni.imdb_score < (SELECT avg(imdb_score) FROM project_netflix.imdb_scores ) AND 
nm.runtime > (SELECT avg(runtime) FROM project_netflix.netflix_movies) THEN 'Best Value'

-- when premium is more than avg AND library size is less than avg then worse value 
WHEN ni.imdb_score > (SELECT avg(imdb_score) FROM project_netflix.imdb_scores ) AND 
nm.runtime > (SELECT avg(runtime) FROM project_netflix.netflix_movies) THEN 'Best Value'
ELSE 'Other' END AS 'Title';


-- If movie titles has the following languages then put them in title language
SELECT Title, Language, CASE 
WHEN language IN ('English' , 'spanish' , 'Hindi', 'Turkish') THEN 'Title Language'
ELSE 'Other' END AS 'Movies'
FROM project_netflix.netflix_movies;

-- Is there a relationship between runtime and the IMDB score?
select nm.runtime, ni.imdb_score, genre
FROM project_netflix.imdb_scores ni
INNER JOIN project_netflix.netflix_movies nm 
ON ni.title = nm.title
group by genre
order by imdb_score
limit 6;
-- In this case the higher the rumtime the higher the Imdb score



