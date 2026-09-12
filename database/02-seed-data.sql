-- Reproducible project fixtures

INSERT INTO roles (role_id, role_name) VALUES
    (1, 'Student'),
    (2, 'Instructor'),
    (3, 'Administrator');

INSERT INTO categories (category_id, category_name) VALUES
    (1, 'Software Testing'),
    (2, 'Database'),
    (3, 'Web Development');

INSERT INTO users (user_id, full_name, email, birth_date, role_id) VALUES
    (1, 'Ahmad Saleh', 'ahmad@example.com', '1998-03-12', 1),
    (2, 'Sara Khaled', 'sara@example.com', '2000-07-25', 1),
    (3, 'Lina Omar', 'lina@example.com', '1999-11-08', 1),
    (4, 'Omar Nasser', 'omar@example.com', '1988-01-19', 2),
    (5, 'Noor Ali', 'noor@example.com', '2001-05-14', 1);

INSERT INTO courses (course_id, title, price, category_id, level) VALUES
    (1, 'Manual Testing', 150.00, 1, 'Beginner'),
    (2, 'PostgreSQL Fundamentals', 220.00, 2, 'Beginner'),
    (3, 'Frontend Fundamentals', 180.00, 3, 'Beginner'),
    (4, 'Advanced SQL', 300.00, 2, 'Advanced');

INSERT INTO enrollments (enrollment_id, user_id, course_id, enrolled_at) VALUES
    (1, 1, 1, '2026-08-01'),
    (2, 1, 2, '2026-08-02'),
    (3, 2, 1, '2026-08-03'),
    (4, 2, 3, '2026-08-04'),
    (5, 3, 2, '2026-08-05'),
    (6, 3, 4, '2026-08-06'),
    (7, 5, 1, '2026-08-07');

INSERT INTO assignments (assignment_id, course_id, title, max_score) VALUES
    (1, 1, 'Test Case Design', 100),
    (2, 1, 'Bug Report', 100),
    (3, 2, 'SQL Queries', 100),
    (4, 3, 'Responsive Page', 100),
    (5, 4, 'Advanced Joins', 100);

INSERT INTO submissions (submission_id, assignment_id, user_id, score, submitted_at) VALUES
    (1, 1, 1, 88, '2026-08-10 10:00:00'),
    (2, 2, 1, 92, '2026-08-12 11:00:00'),
    (3, 3, 1, 85, '2026-08-15 09:30:00'),
    (4, 1, 2, 95, '2026-08-10 12:00:00'),
    (5, 4, 2, 90, '2026-08-18 14:00:00'),
    (6, 3, 3, 78, '2026-08-15 15:00:00'),
    (7, 5, 3, 82, '2026-08-20 16:00:00');

SELECT setval(pg_get_serial_sequence('roles', 'role_id'), (SELECT MAX(role_id) FROM roles));
SELECT setval(pg_get_serial_sequence('categories', 'category_id'), (SELECT MAX(category_id) FROM categories));
SELECT setval(pg_get_serial_sequence('users', 'user_id'), (SELECT MAX(user_id) FROM users));
SELECT setval(pg_get_serial_sequence('courses', 'course_id'), (SELECT MAX(course_id) FROM courses));
SELECT setval(pg_get_serial_sequence('enrollments', 'enrollment_id'), (SELECT MAX(enrollment_id) FROM enrollments));
SELECT setval(pg_get_serial_sequence('assignments', 'assignment_id'), (SELECT MAX(assignment_id) FROM assignments));
SELECT setval(pg_get_serial_sequence('submissions', 'submission_id'), (SELECT MAX(submission_id) FROM submissions));
