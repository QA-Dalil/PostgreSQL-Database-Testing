-- TC-DB-004: duplicate email must be rejected.
DO $$
BEGIN
    BEGIN
        INSERT INTO users (full_name, email, birth_date, role_id)
        VALUES ('Duplicate Email Test', 'ahmad@example.com', '2000-05-10', 1);
        RAISE EXCEPTION 'TC-DB-004 FAIL: duplicate email was accepted';
    EXCEPTION
        WHEN unique_violation THEN
            RAISE NOTICE 'TC-DB-004 PASS: duplicate email was rejected';
    END;
END $$;

-- TC-DB-005: a unique email must be accepted without persisting test data.
DO $$
DECLARE new_user_id INTEGER;
BEGIN
    INSERT INTO users (full_name, email, birth_date, role_id)
    VALUES ('Unique Email Test', 'unique-test@example.com', '2000-05-10', 1)
    RETURNING user_id INTO new_user_id;

    DELETE FROM users WHERE user_id = new_user_id;
    RAISE NOTICE 'TC-DB-005 PASS: unique email was accepted';
END $$;

-- TC-DB-006: stored email values must contain no duplicates.
DO $$
DECLARE duplicate_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO duplicate_count
    FROM (SELECT email FROM users GROUP BY email HAVING COUNT(*) > 1) d;
    IF duplicate_count = 0 THEN
        RAISE NOTICE 'TC-DB-006 PASS: no duplicate emails found';
    ELSE
        RAISE EXCEPTION 'TC-DB-006 FAIL: duplicate emails found';
    END IF;
END $$;
