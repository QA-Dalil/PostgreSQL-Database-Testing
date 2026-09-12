-- Q1: Display the full name and email of all users.
SELECT full_name, email
FROM users
ORDER BY full_name;

-- Q2: Display course titles and prices from highest to lowest.
SELECT title, price
FROM courses
ORDER BY price DESC;

-- Q3: Display the cheapest course.
SELECT title, price
FROM courses
ORDER BY price ASC
LIMIT 1;

-- Q4: Display every student and the courses in which they are enrolled.
SELECT u.full_name AS student, c.title AS course
FROM users u
JOIN roles r ON r.role_id = u.role_id
JOIN enrollments e ON e.user_id = u.user_id
JOIN courses c ON c.course_id = e.course_id
WHERE r.role_name = 'Student'
ORDER BY u.full_name, c.title;

-- Q5: Count enrolled students in each course, highest count first.
SELECT c.title AS course, COUNT(e.user_id) AS student_count
FROM courses c
LEFT JOIN enrollments e ON e.course_id = c.course_id
GROUP BY c.course_id, c.title
ORDER BY student_count DESC, c.title;

-- Q6: Display the average assignment score for each student.
SELECT u.full_name AS student, ROUND(AVG(s.score), 2) AS average_score
FROM users u
JOIN roles r ON r.role_id = u.role_id
LEFT JOIN submissions s ON s.user_id = u.user_id
WHERE r.role_name = 'Student'
GROUP BY u.user_id, u.full_name
ORDER BY u.full_name;

-- Q7: Calculate total revenue for every course.
-- Revenue = course price multiplied by enrolled-student count.
SELECT
    c.title AS course,
    c.price * COUNT(e.user_id) AS revenue
FROM courses c
LEFT JOIN enrollments e ON e.course_id = c.course_id
GROUP BY c.course_id, c.title, c.price
ORDER BY revenue DESC, c.title;

-- Q8: Display users who have never submitted an assignment.
SELECT u.full_name, u.email
FROM users u
WHERE NOT EXISTS (
    SELECT 1
    FROM submissions s
    WHERE s.user_id = u.user_id
)
ORDER BY u.full_name;
