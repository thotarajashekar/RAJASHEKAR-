-- Sakila Sample Database Data
-- Version 1.5


-- Copyright (c) 2006, 2024, Oracle and/or its affiliates.

-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are
-- met:

-- * Redistributions of source code must retain the above copyright notice,
--   this list of conditions and the following disclaimer.
-- * Redistributions in binary form must reproduce the above copyright
--   notice, this list of conditions and the following disclaimer in the
--   documentation and/or other materials provided with the distribution.
-- * Neither the name of Oracle nor the names of its contributors may be used
--   to endorse or promote products derived from this software without
--   specific prior written permission.


-- PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

SET NAMES utf8mb4;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';
SET @old_autocommit=@@autocommit;

USE sakila;

--
-- Dumping data for table actor
--

SET AUTOCOMMIT=0;
INSERT INTO actor VALUES (1,'PENELOPE','GUINESS','2006-02-15 04:34:33'),
(2,'NICK','WAHLBERG','2006-02-15 04:34:33'),
(3,'ED','CHASE','2006-02-15 04:34:33'),
(4,'JENNIFER','DAVIS','2006-02-15 04:34:33'),
(5,'JOHNNY','LOLLOBRIGIDA','2006-02-15 04:34:33'),
(6,'BETTE','NICHOLSON','2006-02-15 04:34:33'),
(7,'GRACE','MOSTEL','2006-02-15 04:34:33'),
(8,'MATTHEW','JOHANSSON','2006-02-15 04:34:33'),
(9,'JOE','SWANK','2006-02-15 04:34:33'),
(10,'CHRISTIAN','GABLE','2006-02-15 04:34:33'),
(11,'ZERO','CAGE','2006-02-15 04:34:33'),
(12,'KARL','BERRY','2006-02-15 04:34:33'),
(13,'UMA','WOOD','2006-02-15 04:34:33'),
(14,'VIVIEN','BERGEN','2006-02-15 04:34:33'),
(15,'CUBA','OLIVIER','2006-02-15 04:34:33'),
(16,'FRED','COSTNER','2006-02-15 04:34:33'),
(17,'HELEN','VOIGHT','2006-02-15 04:34:33'),
(18,'DAN','TORN','2006-02-15 04:34:33'),
(19,'BOB','FAWCETT','2006-02-15 04:34:33'),
(20,'LUCILLE','TRACY','2006-02-15 04:34:33'),
(21,'KIRSTEN','PALTROW','2006-02-15 04:34:33'),
(22,'ELVIS','MARX','2006-02-15 04:34:33'),
(23,'SANDRA','KILMER','2006-02-15 04:34:33'),
(24,'CAMERON','STREEP','2006-02-15 04:34:33'),
(25,'KEVIN','BLOOM','2006-02-15 04:34:33'),
(26,'RIP','CRAWFORD','2006-02-15 04:34:33'),
(27,'JULIA','MCQUEEN','2006-02-15 04:34:33'),
(28,'WOODY','HOFFMAN','2006-02-15 04:34:33'),
(29,'ALEC','WAYNE','2006-02-15 04:34:33'),
(30,'SANDRA','PECK','2006-02-15 04:34:33'),
(31,'SISSY','SOBIESKI','2006-02-15 04:34:33'),
(32,'TIM','HACKMAN','2006-02-15 04:34:33'),
(33,'MILLA','PECK','2006-02-15 04:34:33'),
(34,'AUDREY','OLIVIER','2006-02-15 04:34:33'),
(35,'JUDY','DEAN','2006-02-15 04:34:33'),
(36,'BURT','DUKAKIS','2006-02-15 04:34:33'),
(37,'VAL','BOLGER','2006-02-15 04:34:33'),
(38,'TOM','MCKELLEN','2006-02-15 04:34:33'),
(39,'GOLDIE','BRODY','2006-02-15 04:34:33'),
(40,'JOHNNY','CAGE','2006-02-15 04:34:33'),
(41,'JODIE','DEGENERES','2006-02-15 04:34:33'),
(42,'TOM','MIRANDA','2006-02-15 04:34:33'),
(43,'KIRK','JOVOVICH','2006-02-15 04:34:33'),
(44,'NICK','STALLONE','2006-02-15 04:34:33'),
(45,'REESE','KILMER','2006-02-15 04:34:33'),
(46,'PARKER','GOLDBERG','2006-02-15 04:34:33'),
(47,'JULIA','BARRYMORE','2006-02-15 04:34:33'),
(48,'FRANCES','DAY-LEWIS','2006-02-15 04:34:33'),

-- task1 Task 1: Extract the data of customers who are inactive. Note: active=0 in the Customer table indicates inactive customers.

SELECT *
FROM Customer
WHERE active = 0;


-- task2
SELECT first_name, last_name, email
FROM customer
WHERE active = 0;
-- task3


SELECT store_id
FROM customer
WHERE active = 0
GROUP BY store_id
ORDER BY COUNT(*) DESC
LIMIT 1;
-- task4
SELECT title
FROM film
WHERE rating = 'PG-13';
-- task5
SELECT title, length
FROM film
WHERE rating = 'PG-13'
ORDER BY length DESC
LIMIT 3;
-- task 6
SELECT f.title, f.rental_duration
FROM film f
WHERE f.rating = 'PG-13'
ORDER BY f.rental_duration ASC
LIMIT 10;
-- task7
SELECT AVG(rental_rate) AS average_rental_cost
FROM film;
-- task8
SELECT SUM(replacement_cost) AS total_replacement_cost
FROM film;
-- task9
SELECT category_id, name
FROM category
WHERE name IN ('Animation', 'Children');
SELECT
    c.name AS category_name,
    COUNT(fc.film_id) AS film_count
FROM
    film_category fc
JOIN
    category c ON fc.category_id = c.category_id
WHERE
    c.name IN ('Animation', 'Children')
GROUP BY
    c.name;
-- Identify category_id for Animation and Children
SELECT category_id, name
FROM category
WHERE name IN ('Animation', 'Children');

-- Count films in Animation and Children categories
SELECT
    c.name AS category_name,
    COUNT(fc.film_id) AS film_count
FROM
    film_category fc
JOIN
    category c ON fc.category_id = c.category_id
WHERE
    c.name IN ('Animation', 'Children')
GROUP BY
    c.name;
-- Identify category_id for Animation and Children
SELECT category_id, name
FROM category
WHERE name IN ('Animation', 'Children');

-- Count films in Animation and Children categories
SELECT
    c.name AS category_name,
    COUNT(fc.film_id) AS film_count
FROM
    film_category fc
JOIN
    category c ON fc.category_id = c.category_id
WHERE
    c.name IN ('Animation', 'Children')
GROUP BY
    c.name;
-- Identify category_id for Animation and Children
SELECT category_id, name
FROM category
WHERE name IN ('Animation', 'Children');

-- Count films in Animation and Children categories
SELECT
    c.name AS category_name,
    COUNT(fc.film_id) AS film_count
FROM
    film_category fc
JOIN
    category c ON fc.category_id = c.category_id
WHERE
    c.name IN ('Animation', 'Children')
GROUP BY
    c.name;
-- Identify category_id for Animation and Children
SELECT category_id, name
FROM category
WHERE name IN ('Animation', 'Children');

-- Count films in Animation and Children categories
SELECT
    c.name AS category_name,
    COUNT(fc.film_id) AS film_count
FROM
    film_category fc
JOIN
    category c ON fc.category_id = c.category_id
WHERE
    c.name IN ('Animation', 'Children')
GROUP BY
    c.name;
