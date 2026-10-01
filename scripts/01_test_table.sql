CREATE SCHEMA IF NOT EXISTS DEMO;

CREATE TABLE IF NOT EXISTS DEMO.CORE_SAMPLE_TEST (
    id INT,
    item_name VARCHAR(50),
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Idempotent insert
MERGE INTO DEMO.CORE_SAMPLE_TEST target
USING (
    SELECT 101 AS id, 'ALPHA' AS item_name UNION ALL
    SELECT 102 AS id, 'BETA' AS item_name
) source
ON target.id = source.id
WHEN NOT MATCHED THEN
    INSERT (id, item_name) VALUES (source.id, source.item_name);
