# Data Model

```mermaid
erDiagram
    ROLES ||--o{ USERS : assigns
    CATEGORIES ||--o{ COURSES : classifies
    USERS ||--o{ ENROLLMENTS : creates
    COURSES ||--o{ ENROLLMENTS : receives
    COURSES ||--o{ ASSIGNMENTS : contains
    USERS ||--o{ SUBMISSIONS : submits
    ASSIGNMENTS ||--o{ SUBMISSIONS : receives

    ROLES {
        int role_id PK
        varchar role_name UK
    }
    USERS {
        int user_id PK
        varchar full_name
        varchar email UK
        date birth_date
        int role_id FK
    }
    CATEGORIES {
        int category_id PK
        varchar category_name UK
    }
    COURSES {
        int course_id PK
        varchar title
        numeric price
        int category_id FK
        varchar level
    }
    ENROLLMENTS {
        int enrollment_id PK
        int user_id FK
        int course_id FK
        date enrolled_at
    }
    ASSIGNMENTS {
        int assignment_id PK
        int course_id FK
        varchar title
        numeric max_score
    }
    SUBMISSIONS {
        int submission_id PK
        int assignment_id FK
        int user_id FK
        numeric score
        timestamp submitted_at
    }
```

## Design Notes

- `users.email` is mandatory and unique.
- Every user references an existing role.
- Every course references an existing category.
- `courses.level` is mandatory and defaults to `Beginner`.
- A user may enroll in a course only once.
- A user may submit each assignment only once.
- Submission scores cannot be negative.
