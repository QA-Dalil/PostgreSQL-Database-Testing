# Database Test Cases

## TC-DB-001 Reject user without email

- Constraint: NOT NULL
- SQL operation: Insert a user while omitting `email`.
- Expected result: PostgreSQL rejects the record with a not-null violation.
- Assignment execution: PASS.

## TC-DB-002 Reject user without full name

- Constraint: NOT NULL
- SQL operation: Insert a user while omitting `full_name`.
- Expected result: PostgreSQL rejects the record with a not-null violation.
- Assignment execution: PASS.

## TC-DB-003 Verify existing users have emails

- Constraint: NOT NULL
- SQL operation: Search for users where `email IS NULL`.
- Expected result: Zero rows.
- Assignment execution: PASS.

## TC-DB-004 Reject duplicate email

- Constraint: UNIQUE
- SQL operation: Insert a user with `ahmad@example.com`.
- Expected result: PostgreSQL rejects the duplicate email.
- Assignment execution: PASS.

## TC-DB-005 Accept unique email

- Constraint: UNIQUE
- SQL operation: Insert a user with a new email address.
- Expected result: One row is inserted.
- Assignment execution: PASS.

## TC-DB-006 Verify stored emails are unique

- Constraint: UNIQUE
- SQL operation: Group users by email and return counts greater than one.
- Expected result: Zero rows.
- Assignment execution: PASS.

## TC-DB-007 Reject duplicate course primary key

- Constraint: PRIMARY KEY
- SQL operation: Insert a course using existing `course_id = 1`.
- Expected result: PostgreSQL rejects the duplicate key.
- Assignment execution: PASS.

## TC-DB-008 Reject NULL course primary key

- Constraint: PRIMARY KEY
- SQL operation: Insert a course using `course_id = NULL`.
- Expected result: PostgreSQL rejects the NULL primary key.
- Assignment execution: PASS.

## TC-DB-009 Verify course primary keys are unique

- Constraint: PRIMARY KEY
- SQL operation: Group courses by `course_id` and return counts greater than one.
- Expected result: Zero rows.
- Assignment execution: PASS.

## TC-DB-010 Reject course with missing category

- Constraint: FOREIGN KEY
- SQL operation: Insert a course using `category_id = 999`.
- Expected result: PostgreSQL rejects the invalid category reference.
- Assignment execution: PASS.

## TC-DB-011 Reject enrollment with missing user

- Constraint: FOREIGN KEY
- SQL operation: Insert an enrollment using `user_id = 999`.
- Expected result: PostgreSQL rejects the invalid user reference.
- Assignment execution: PASS.

## TC-DB-012 Verify courses have valid categories

- Constraint: FOREIGN KEY
- SQL operation: Left join courses to categories and search for unmatched rows.
- Expected result: Zero rows.
- Assignment execution: PASS.

## TC-DB-013 Verify enrollments have valid users

- Constraint: FOREIGN KEY
- SQL operation: Left join enrollments to users and search for unmatched rows.
- Expected result: Zero rows.
- Assignment execution: PASS.

## TC-DB-014 Apply default course level

- Constraint: DEFAULT
- SQL operation: Insert a course without specifying `level`.
- Expected result: The stored level is `Beginner`.
- Assignment execution: FAIL; the supplied report recorded `NULL`.
- Repository regression test: Verifies the corrected schema returns `Beginner`.

## TC-DB-015 Verify courses have no missing level

- Constraint: DEFAULT and NOT NULL
- SQL operation: Search for courses where `level IS NULL`.
- Expected result: Zero rows.
- Assignment execution: FAIL; one course with a NULL level was reported.
- Repository regression test: Verifies the corrected schema prevents NULL levels.
