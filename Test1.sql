-- Given the following data definition, write a query that returns the number of students whose first name is John.
--
-- TABLE students
--    id INTEGER PRIMARY KEY,
--    firstName VARCHAR(30) NOT NULL,
--    lastName VARCHAR(30) NOT NULL

select count(*) from students where firstName = 'John';


-- A table containing the students enrolled in a yearly course has incorrect data in records with ids between 20 and 100 (inclusive).
--
-- TABLE enrollments
--   id INTEGER NOT NULL PRIMARY KEY
--   year INTEGER NOT NULL
--   studentId INTEGER NOT NULL
--
-- Write a query that updates the field 'year' of every faulty record to 2015.

update  enrollments set year = 2015 where id >= 20 and id <= 100;


-- A table containing the students enrolled in a yearly course has incorrect data in records with ids between 20 and 100 (inclusive).
--
-- TABLE enrollments
--   id INTEGER NOT NULL PRIMARY KEY
--   year INTEGER NOT NULL
--   studentId INTEGER NOT NULL
--
-- Write a query that updates the field 'year' of every faulty record to 2015.

update  enrollments set year = 2015 where id >= 20 and id <= 100;


-- Information about pets is kept in two separate tables:
--
-- TABLE dogs
--   id INTEGER NOT NULL PRIMARY KEY,
--   name VARCHAR(50) NOT NULL
--
-- TABLE cats
--   id INTEGER NOT NULL PRIMARY KEY,
--   name VARCHAR(50) NOT NULL
--
-- Write a query that select all distinct pet names.
--
-- Suggested testing environment:
-- http://sqlite.online/

-- Example case create statement:
-- CREATE TABLE dogs (
--   id INTEGER NOT NULL PRIMARY KEY,
--   name VARCHAR(50) NOT NULL
-- );
--
-- CREATE TABLE cats (
--   id INTEGER NOT NULL PRIMARY KEY,
--   name VARCHAR(50) NOT NULL
-- );
--
-- INSERT INTO dogs(id, name) values(1, 'Lola');
-- INSERT INTO dogs(id, name) values(2, 'Bella');
-- INSERT INTO cats(id, name) values(1, 'Lola');
-- INSERT INTO cats(id, name) values(2, 'Kitty');
--
-- Expected output (in any order):
-- name
-- -----
-- Bella
-- Kitty
-- Lola

select name from dogs
union
select name from cats;


-- App usage data are kept in the following table:
--
-- TABLE sessions
--   id INTEGER PRIMARY KEY,
--   userId INTEGER NOT NULL,
--   duration DECIMAL NOT NULL
--
-- Write a query that selects userId and average session duration for each user who has more than one session.

-- Suggested testing environment:
-- http://sqlite.online/

-- Example case create statement:
-- CREATE TABLE sessions (
--   id INTEGER NOT NULL PRIMARY KEY,
--   userId INTEGER NOT NULL,
--   duration DECIMAL NOT NULL
-- );
--
-- INSERT INTO sessions(id, userId, duration) VALUES(1, 1, 10);
-- INSERT INTO sessions(id, userId, duration) VALUES(2, 2, 18);
-- INSERT INTO sessions(id, userId, duration) VALUES(3, 1, 14);
--
-- Expected output:
-- UserId  AverageDuration
-- -----------------------
-- 1       12

select userId, avg (duration) from sessions group by userId having count(userId) > 1;


-- Each item in a web shop belongs to a seller. To ensure service quality, each seller has a rating.
--
-- The data are kept in the following two tables:
--
-- TABLE sellers
--   id INTEGER PRIMARY KEY,
--   name VARCHAR(30) NOT NULL,
--   rating INTEGER NOT NULL
--
-- TABLE items
--   id INTEGER PRIMARY KEY,
--   name VARCHAR(30) NOT NULL,
--   sellerId INTEGER REFERENCES sellers(id)
--
-- Write a query that selects the item name and the name of its seller for each item that belongs to a seller with a rating greater than 4.
--
-- Suggested testing environment:
-- http://sqlite.online/

-- Example case create statement:
-- CREATE TABLE sellers (
--   id INTEGER NOT NULL PRIMARY KEY,
--   name VARCHAR(30) NOT NULL,
--   rating INTEGER NOT NULL
-- );
--
-- CREATE TABLE items (
--   id INTEGER NOT NULL PRIMARY KEY,
--   name VARCHAR(30) NOT NULL,
--   sellerId INTEGER REFERENCES sellers(id)
-- );
--
-- INSERT INTO sellers(id, name, rating) VALUES(1, 'TRoger', 3);
-- INSERT INTO sellers(id, name, rating) VALUES(2, 'Scout', 5);
--
-- INSERT INTO items(id, name, sellerId) VALUES(1, 'Notebook', 2);
-- INSERT INTO items(id, name, sellerId) VALUES(2, 'Stapler', 1);
-- INSERT INTO items(id, name, sellerId) VALUES(3, 'Pencil', 2);
--
-- Expected output (in any order):
-- Item      Seller
-- ----------------
-- Notebook  Scout
-- Pencil    Scout

select items.name, sellers.name from items
join sellers on items.sellerId = sellers.id
where sellers.rating > 4;
