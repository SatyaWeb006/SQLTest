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



-- The following data definition defines an organization's employee hierarchy.
--
-- An employee is a manager if any other employee has their managerId set to the first employees id. An employee who is a manager may or may not also have a manager.
--
-- TABLE employees
--   id INTEGER NOT NULL PRIMARY KEY
--   managerId INTEGER REFERENCES employees(id)
--   name VARCHAR(30) NOT NULL
--
-- Write a query that selects the names of employees who are not managers.
--
-- Suggested testing environment:
-- http://sqlite.online/

-- Example case create statement:
-- CREATE TABLE employees (
--   id INTEGER NOT NULL PRIMARY KEY,
--   managerId INTEGER REFERENCES employees(id),
--   name VARCHAR(30) NOT NULL
-- );
--
-- INSERT INTO employees(id, managerId, name) VALUES(1, NULL, 'John');
-- INSERT INTO employees(id, managerId, name) VALUES(2, 1, 'Mike');
--
-- Expected output (in any order):
-- name
-- ----
-- Mike

-- Explanation:
-- In this example.
-- John is Mike's manager. Mike does not manage anyone.
-- Mike is the only employee who does not manage anyone.

select name from employees
where id not in (
    select e1.id from employees as e1 join employees as e2 on e1.id = e2.managerId
);


-- The following two tables are used to define users and their respective roles:
--
-- TABLE users
--   id INTEGER NOT NULL PRIMARY KEY,
--   userName VARCHAR(50) NOT NULL
--
-- TABLE roles
--   id INTEGER NOT NULL PRIMARY KEY,
--   role VARCHAR(20) NOT NULL
--
-- The users_roles table should contain the mapping between each user and their roles. Each user can have many roles, and each role can have many users.
--
-- Modify the provided SQLite create table statement so that:
--
--     Only users from the users table can exist within users_roles.
--     Only roles from the roles table can exist within users_roles.
--     A user can only have a specific role once.
--
--     See the example case for more details.
--
-- Suggested testing environment:
-- http://sqlite.online/
-- PRAGMA foreign_keys = ON; -- Enable foreign key support in SQLite.
--
-- -- Example case create statement:
-- CREATE TABLE users (
--   id INTEGER NOT NULL PRIMARY KEY,
--   userName VARCHAR(50) NOT NULL
-- );
--
-- CREATE TABLE roles (
--   id INTEGER NOT NULL PRIMARY KEY,
--   role VARCHAR(20) NOT NULL
-- );
--
-- INSERT INTO users(id, userName) VALUES(1, 'Steven Smith');
-- INSERT INTO users(id, userName) VALUES(2, 'Brian Burns');
--
-- INSERT INTO roles(id, role) VALUES(1, 'Project Manager');
-- INSERT INTO roles(id, role) VALUES(2, 'Solution Architect');
--
-- -- Improve the create table statement below:
-- CREATE TABLE users_roles (
--   userId INTEGER,
--   roleId INTEGER
-- );
--
-- -- The statements below should pass.
-- INSERT INTO users_roles(userId, roleId) VALUES(1, 1);
-- INSERT INTO users_roles(userId, roleId) VALUES(1, 2);
-- INSERT INTO users_roles(userId, roleId) VALUES(2, 2);
--
-- -- The statement below should fail.
-- INSERT INTO users_roles(userId, roleId) VALUES(2, NULL);

CREATE TABLE users_roles (
  userId INTEGER not null,
  roleId INTEGER not null,
  foreign key (userId) references users(id),
  foreign key (roleId) references roles(id),
  unique (userId, roleId)
);

