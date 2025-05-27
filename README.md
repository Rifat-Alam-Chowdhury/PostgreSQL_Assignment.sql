#What is PostgreSQL?
PostgreSQL is a sql based database system. it stores data in table formate.

#What is the purpose of a database schema in PostgreSQL?
A schema is like a blue print of  the database.
it prevents errors of structures of the database.
It pre defines the fields before execution,so that the data fields stays valid not null or by using it the database structure remains same as it should be

#What are the LIMIT and OFFSET clauses used for?
Limit and Offsets are keywords or operator of postgressql;
These are used when  to show only a part of the results.
LIMIT OPERATOR: it difinds  how many rows to show in the result.
OFFSET: IT is used for where to start from.
 these are mostly use in pagination





 #How can you modify data using UPDATE statements?
The UPDATE command make  changes in the existing data in a table.
UPDATE rangers
SET region = 'Jungle Zone'
WHERE name = 'Bob White';


#What is the significance of the JOIN operation, and how does it work in PostgreSQL?
A JOIN is used to connect data from two or more tables that share something in common.
if apple is common in tree table then the operation would be done like aggregation and make a new result after working with many tables.
