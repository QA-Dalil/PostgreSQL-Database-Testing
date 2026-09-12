# PostgreSQL Database Testing

This repository demonstrates practical PostgreSQL querying and database QA testing for an online learning platform.

It converts two database assignments into a reproducible project containing a database schema, sample data, analytical queries, constraint tests, and execution documentation.

## Project Objectives

- Build and populate a relational PostgreSQL database.
- Write queries using sorting, aggregation, joins, and subqueries.
- Validate `NOT NULL`, `UNIQUE`, `PRIMARY KEY`, `FOREIGN KEY`, and `DEFAULT` constraints.
- Compare expected and actual database behavior.
- Document test results and database defects clearly.

## Repository Structure

```text
database/
  01-schema.sql          Database tables, keys, and constraints
  02-seed-data.sql       Reproducible sample data
  03-verification.sql    Initial data-integrity checks
queries/
  assignment-1-queries.sql
tests/
  01-not-null-tests.sql
  02-unique-tests.sql
  03-primary-key-tests.sql
  04-foreign-key-tests.sql
  05-default-tests.sql
  run-all-tests.sql
reports/
  database-test-cases.md
  execution-summary.md
docs/
  data-model.md
```

## Technologies

- PostgreSQL
- SQL
- pgAdmin
- Git
- GitHub

## Database Model

The project represents an online learning platform with roles, users, categories, courses, enrollments, assignments, and assignment submissions.

The table names, relationships, constraints, and query objectives are based on the supplied assignments. Additional supporting columns and sample records were added to make the project independently executable; they are project fixtures, not claimed as original assignment data.

## How to Run

Create a database named `learning_platform`, then run the files in this order:

```bash
psql -U postgres -d learning_platform -f database/01-schema.sql
psql -U postgres -d learning_platform -f database/02-seed-data.sql
psql -U postgres -d learning_platform -f database/03-verification.sql
psql -U postgres -d learning_platform -f queries/assignment-1-queries.sql
psql -U postgres -d learning_platform -f tests/run-all-tests.sql
```

In pgAdmin, open Query Tool and execute the same files in the same order.

## Query Coverage

The query set demonstrates:

- Selecting user names and emails
- Sorting courses by price
- Finding the cheapest course
- Joining students with enrolled courses
- Counting students per course
- Calculating average assignment scores
- Calculating course revenue
- Finding users with no assignment submissions

## Database QA Coverage

The test suite checks:

- Required user fields reject `NULL`
- Email values remain unique
- Primary keys reject duplicates and `NULL`
- Foreign keys preserve referential integrity
- Course level defaults to `Beginner`

Negative tests use PostgreSQL `DO` blocks and exception handling. A test passes only when the expected constraint violation occurs. Each test runs without leaving unwanted records in the database.

## Documented Finding

The supplied execution evidence reported that a course inserted without a level received `NULL` instead of `Beginner`. This was recorded as a failed `DEFAULT`-constraint test. The schema in this repository defines the expected default and includes a regression test to verify the corrected behavior.

## Author

Rahaf AlQura'an
