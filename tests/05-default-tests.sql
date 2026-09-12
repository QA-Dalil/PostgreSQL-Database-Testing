-- TC-DB-014: omitted course level must default to Beginner.
DO $$
DECLARE new_course_id INTEGER;
DECLARE actual_level VARCHAR(30);
BEGIN
    INSERT INTO courses (title, price, category_id)
    VALUES ('Default Level Regression Test', 250, 1)
    RETURNING course_id, level INTO new_course_id, actual_level;

    IF actual_level = 'Beginner' THEN
        DELETE FROM courses WHERE course_id = new_course_id;
        RAISE NOTICE 'TC-DB-014 PASS: default level is Beginner';
    ELSE
        DELETE FROM courses WHERE course_id = new_course_id;
        RAISE EXCEPTION 'TC-DB-014 FAIL: expected Beginner, received %', actual_level;
    END IF;
END $$;

-- TC-DB-015: no stored course may have a missing level.
DO $$
DECLARE invalid_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO invalid_count FROM courses WHERE level IS NULL;
    IF invalid_count = 0 THEN
        RAISE NOTICE 'TC-DB-015 PASS: no courses have NULL level';
    ELSE
        RAISE EXCEPTION 'TC-DB-015 FAIL: % courses have NULL level', invalid_count;
    END IF;
END $$;
