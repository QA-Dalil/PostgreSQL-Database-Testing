-- TC-DB-007: duplicate course_id must be rejected.
DO $$
BEGIN
    BEGIN
        INSERT INTO courses (course_id, title, price, category_id)
        VALUES (1, 'Duplicate Primary Key Test', 250, 1);
        RAISE EXCEPTION 'TC-DB-007 FAIL: duplicate course_id was accepted';
    EXCEPTION
        WHEN unique_violation THEN
            RAISE NOTICE 'TC-DB-007 PASS: duplicate course_id was rejected';
    END;
END $$;

-- TC-DB-008: NULL course_id must be rejected.
DO $$
BEGIN
    BEGIN
        INSERT INTO courses (course_id, title, price, category_id)
        VALUES (NULL, 'Null Primary Key Test', 250, 1);
        RAISE EXCEPTION 'TC-DB-008 FAIL: NULL course_id was accepted';
    EXCEPTION
        WHEN not_null_violation THEN
            RAISE NOTICE 'TC-DB-008 PASS: NULL course_id was rejected';
    END;
END $$;

-- TC-DB-009: stored course_id values must be unique.
DO $$
DECLARE duplicate_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO duplicate_count
    FROM (SELECT course_id FROM courses GROUP BY course_id HAVING COUNT(*) > 1) d;
    IF duplicate_count = 0 THEN
        RAISE NOTICE 'TC-DB-009 PASS: course primary keys are unique';
    ELSE
        RAISE EXCEPTION 'TC-DB-009 FAIL: duplicate course_id values found';
    END IF;
END $$;
