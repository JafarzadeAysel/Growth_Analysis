
WITH
paid_users as
(
	SELECT
		p.user_id,
        i.date_registered,
        MIN(p.date_purchased) as first_order_date,
        CASE
			WHEN p.purchase_type = 0 THEN "Monthly"
            WHEN p.purchase_type = 1 THEN "Quarterly"
            WHEN p.purchase_type = 2 THEN "Annual"
            WHEN p.purchase_type = 3 THEN "Lifetime"
		END as plan
	FROM
		student_purchases as p
        LEFT JOIN
        student_info as i ON p.user_id = i.user_id
	WHERE
		p.purchase_type IN (0,1,2,3)
	GROUP BY p.user_id
),
count_direct as
(
	SELECT
		CAST(first_order_date as DATE) as date_paid,
        plan,
        COUNT(*) as count_direct_paid
	FROM paid_users
    WHERE TIMESTAMPDIFF(minute, date_registered, first_order_date) <= 30
    GROUP BY date_paid, plan
),
count_converted as
(
	SELECT
		CAST(first_order_date as DATE) as date_paid,
        plan,
        COUNT(*) as count_converted_paid
	FROM paid_users
    WHERE TIMESTAMPDIFF(minute, date_registered, first_order_date) > 30
    GROUP BY date_paid, plan
)
SELECT
	d.date_paid,
    d.plan,
    d.count_direct_paid,
    IFNULL(c.count_converted_paid, 0) as count_converted_paid
FROM
	count_direct as d
    LEFT JOIN
    count_converted as c ON d.date_paid = c.date_paid AND d.plan = c.plan

UNION

SELECT
	c.date_paid,
    c.plan,
    IFNULL(d.count_direct_paid, 0) as count_direct_paid,
    c.count_converted_paid
FROM
	count_converted as c
    LEFT JOIN
    count_direct as d ON d.date_paid = c.date_paid AND d.plan = c.plan
ORDER BY date_paid DESC;