# Database Test Execution Summary

## Assignment Execution

- Total documented test cases: 15
- Passed: 13
- Failed: 2
- Failed area: Course-level default behavior

## Observed Defect

**Title:** Course level default is not applied when level is omitted

**Expected behavior:** Inserting a course without a `level` value automatically stores `Beginner`.

**Observed behavior:** The assignment report recorded a successful insert with `level = NULL`. A follow-up query also returned the affected course.

**Impact:** Course records can be created without the required default classification, producing inconsistent data.

**Recommended correction:** Define the column as:

```sql
level VARCHAR(30) NOT NULL DEFAULT 'Beginner'
```

## Repository Regression Result

The repository schema includes the recommended constraint. Tests `TC-DB-014` and `TC-DB-015` verify that the default is applied and no course has a NULL level.

Run `tests/run-all-tests.sql` after loading the schema and fixtures to produce the current execution output in PostgreSQL.
