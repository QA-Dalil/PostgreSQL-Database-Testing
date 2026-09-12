-- TC-DB-001: users.email must not accept NULL.
DO $$
BEGIN
    BEGIN
        INSERT INTO users (full_name, birth_date, role_id)
        VALUES ('Ali Ahmad', '2000-05-10', 1);
        RAISE EXCEPTION 'TC-DB-001 FAIL: NULL email was accepted';
    EXCEPTION
        WHEN not_null_violation THEN
            RAISE NOTICE 'TC-DB-001 PASS: NULL email was rejected';
    END;
END $$;

-- TC-DB-002: users.full_name must not accept NULL.
DO $$
BEGIN
    BEGIN
        INSERT INTO users (email, birth_date, role_id)
        VALUES ('null-name-test@example.com', '2000-05-10', 1);
        RAISE EXCEPTION 'TC-DB-002 FAIL: NULL full_name was accepted';
    EXCEPTION
        WHEN not_null_violation THEN
            RAISE NOTICE 'TC-DB-002 PASS: NULL full_name was rejected';
    END;
END $$;

-- TC-DB-003: existing users must all have email values.
DO $$
DECLARE invalid_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO invalid_count FROM users WHERE email IS NULL;
    IF invalid_count = 0 THEN
        RAISE NOTICE 'TC-DB-003 PASS: no users have NULL email';
    ELSE
        RAISE EXCEPTION 'TC-DB-003 FAIL: % users have NULL email', invalid_count;
    END IF;
END $$;
