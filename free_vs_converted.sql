SET GLOBAL sql_mode='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO'; 
SET SESSION sql_mode='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO'; 

WITH
free_users as
(
	SELECT
		i.user_id,
		i.date_registered,
		MIN(p.date_purchased) as first_order_date,
        p.purchase_type
	FROM
		student_info as i
        LEFT JOIN
        student_purchases as p ON i.user_id = p.user_id
	WHERE 
		(p.purchase_type IN (0,1,2,3) OR p.purchase_type IS NULL)
	GROUP BY i.user_id
    HAVING
        (first_order_date IS NULL OR TIMESTAMPDIFF(minute, date_registered, first_order_date) > 30)
	
),
count_free as
(
	SELECT
		CAST(date_registered as DATE) as date,
        COUNT(*) as count_total_free
	FROM free_users
    GROUP BY date
),
count_converted as
(
	SELECT
		CAST(date_registered as DATE) as date,
        COUNT(*) as count_converted
	FROM free_users
    WHERE first_order_date IS NOT NULL
    GROUP BY date
)
SELECT
	f.date  "Date Registered",
    f.count_total_free "Count Total Free",
    IFNULL(c.count_converted, 0)   "Count Converted"
FROM
	count_free as f
    LEFT JOIN
    count_converted as c ON f.date = c.date
ORDER BY f.date DESC