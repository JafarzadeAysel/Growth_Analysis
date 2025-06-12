WITH
visitors as
(
	SELECT
        s.session_date,
		s.visitor_id,
		IFNULL(s.utm_source, "Organic") as channel,
		CASE
			WHEN DATE_FORMAT(s.session_date, "%Y-%m") = DATE_FORMAT(v.first_visit_date, "%Y-%m") 
				AND (i.date_registered IS NULL OR i.date_registered > v.first_visit_date) THEN "new"
			ELSE "returning"
		END as status,
        DATE_FORMAT(s.session_date, "%Y-%m") as date_bracket
	FROM
		front_sessions as s
		LEFT JOIN
		front_visitors as v ON s.visitor_id = v.visitor_id
        LEFT JOIN
        student_info as i ON i.user_id = v.user_id
	WHERE s.session_date >= '2022-07-01'
	GROUP BY visitor_id, date_bracket
)
SELECT
	session_date,
    channel,
    status,
    COUNT(*) as count_visitors
FROM visitors
GROUP BY session_date, channel, status
ORDER BY session_date DESC, status, count_visitors DESC, channel