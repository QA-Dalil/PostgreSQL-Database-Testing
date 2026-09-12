\set ON_ERROR_STOP on
\echo 'Running NOT NULL constraint tests'
\ir 01-not-null-tests.sql
\echo 'Running UNIQUE constraint tests'
\ir 02-unique-tests.sql
\echo 'Running PRIMARY KEY constraint tests'
\ir 03-primary-key-tests.sql
\echo 'Running FOREIGN KEY constraint tests'
\ir 04-foreign-key-tests.sql
\echo 'Running DEFAULT constraint tests'
\ir 05-default-tests.sql
\echo 'All database tests completed successfully'
