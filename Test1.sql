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
