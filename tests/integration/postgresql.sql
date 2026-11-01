
\set ON_ERROR_STOP on

BEGIN;

CREATE TABLE integration_test (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO integration_test (title)
VALUES ('TorqYard PostgreSQL integration test');

DO $$
BEGIN
    IF (
        SELECT COUNT(*)
        FROM integration_test
        WHERE title = 'TorqYard PostgreSQL integration test'
    ) <> 1 THEN
        RAISE EXCEPTION 'Insert/read verification failed';
    END IF;
END;
$$;

UPDATE integration_test
SET title = 'TorqYard updated test'
WHERE id = 1;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM integration_test
        WHERE id = 1
          AND title = 'TorqYard updated test'
    ) THEN
        RAISE EXCEPTION 'Update verification failed';
    END IF;
END;
$$;

DELETE FROM integration_test WHERE id = 1;

DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM integration_test) THEN
        RAISE EXCEPTION 'Delete verification failed';
    END IF;
END;
$$;

ROLLBACK;
