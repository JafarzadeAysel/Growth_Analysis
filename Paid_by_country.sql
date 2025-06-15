WITH 
paid_users as
	(
		SELECT
			p.user_id,
			MIN(p.date_purchased) as first_sub_date,
			i.user_country as country,
            IFNULL(s.utm_source, "Organic") as channel
		FROM
			student_purchases as p
			LEFT JOIN
			student_info as i ON p.user_id = i.user_id
            LEFT JOIN
            front_visitors as v ON p.user_id = v.user_id
            LEFT JOIN
            front_sessions as s ON v.visitor_id = s.visitor_id
		WHERE 
			i.user_country IS NOT NULL
        GROUP BY p.user_id
	)
SELECT
	CAST(first_sub_date as DATE) as date_paid,
    country,
    channel,
    COUNT(*) as count_paid
FROM paid_users
GROUP BY date_paid, country, channel
ORDER BY date_paid DESC, country, count_paid DESC;

