-- Baseline integrity checks

SELECT 'users_without_email' AS check_name, COUNT(*) AS invalid_rows
FROM users
WHERE email IS NULL;

SELECT 'duplicate_emails' AS check_name, COUNT(*) AS invalid_rows
FROM (
    SELECT email
    FROM users
    GROUP BY email
    HAVING COUNT(*) > 1
) AS duplicates;

SELECT 'orphan_courses' AS check_name, COUNT(*) AS invalid_rows
FROM courses c
LEFT JOIN categories ca ON ca.category_id = c.category_id
WHERE ca.category_id IS NULL;

SELECT 'orphan_enrollments' AS check_name, COUNT(*) AS invalid_rows
FROM enrollments e
LEFT JOIN users u ON u.user_id = e.user_id
LEFT JOIN courses c ON c.course_id = e.course_id
WHERE u.user_id IS NULL OR c.course_id IS NULL;

SELECT 'courses_without_level' AS check_name, COUNT(*) AS invalid_rows
FROM courses
WHERE level IS NULL;
