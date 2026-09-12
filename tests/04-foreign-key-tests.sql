-- TC-DB-010: course with missing category must be rejected.
DO $$
BEGIN
    BEGIN
        INSERT INTO courses (title, price, category_id)
        VALUES ('Invalid Category Test', 250, 999);
        RAISE EXCEPTION 'TC-DB-010 FAIL: invalid category_id was accepted';
    EXCEPTION
        WHEN foreign_key_violation THEN
            RAISE NOTICE 'TC-DB-010 PASS: invalid category_id was rejected';
    END;
END $$;

-- TC-DB-011: enrollment with missing user must be rejected.
DO $$
BEGIN
    BEGIN
        INSERT INTO enrollments (user_id, course_id)
        VALUES (999, 1);
        RAISE EXCEPTION 'TC-DB-011 FAIL: invalid user_id was accepted';
    EXCEPTION
        WHEN foreign_key_violation THEN
            RAISE NOTICE 'TC-DB-011 PASS: invalid user_id was rejected';
    END;
END $$;

-- TC-DB-012: no stored courses may have invalid categories.
DO $$
DECLARE invalid_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO invalid_count
    FROM courses c
    LEFT JOIN categories ca ON ca.category_id = c.category_id
    WHERE ca.category_id IS NULL;
    IF invalid_count = 0 THEN
        RAISE NOTICE 'TC-DB-012 PASS: no orphan courses found';
    ELSE
        RAISE EXCEPTION 'TC-DB-012 FAIL: % orphan courses found', invalid_count;
    END IF;
END $$;

-- TC-DB-013: no stored enrollments may have invalid users.
DO $$
DECLARE invalid_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO invalid_count
    FROM enrollments e
    LEFT JOIN users u ON u.user_id = e.user_id
    WHERE u.user_id IS NULL;
    IF invalid_count = 0 THEN
        RAISE NOTICE 'TC-DB-013 PASS: no orphan enrollments found';
    ELSE
        RAISE EXCEPTION 'TC-DB-013 FAIL: % orphan enrollments found', invalid_count;
    END IF;
END $$;
