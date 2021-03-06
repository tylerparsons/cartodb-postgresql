WITH data AS (
    SELECT array_agg(x::numeric) s FROM generate_series(1,100) x
        WHERE x % 5 != 0 AND x % 7 != 0
    ) 
SELECT unnest(CDB_QuantileBins(s, 7)) FROM data;

WITH data_nulls AS (
    SELECT array_agg(CASE WHEN x % 2 != 0 THEN x ELSE NULL END::numeric) s FROM generate_series(1,100) x
        WHERE x % 5 != 0 AND x % 7 != 0
    )
SELECT unnest(CDB_QuantileBins(s, 7)) FROM data_nulls;
