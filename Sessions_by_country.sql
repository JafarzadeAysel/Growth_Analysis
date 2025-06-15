

WITH
sessions as
(
	SELECT
		s.session_date,
        s.session_country as country,
        IFNULL(REPLACE(s.utm_source, ',', ';'), "Organic") as channel,
		CASE
			WHEN s.session_OS LIKE ('Win%') THEN "PC"
			WHEN s.session_OS LIKE ('Android%') THEN "Mobile"
			WHEN s.session_OS LIKE ('OS%') THEN "PC"
			WHEN s.session_OS LIKE ('iOS%') THEN "Mobile"
			WHEN s.session_OS LIKE ('Linux%') THEN "PC"
			WHEN s.session_OS LIKE ('Ubuntu%') THEN "PC"
			WHEN s.session_OS LIKE ('Chrome%') THEN "PC"
			WHEN s.session_OS LIKE ('Fedora%') THEN "PC"
			WHEN s.session_OS LIKE ('FreeBSD%') THEN "PC"
			Else "Unknown"
		END as device
	FROM front_sessions as s
    WHERE s.session_date >= '2022-07-01' AND session_country IS NOT NULL
)
SELECT
	session_date,
    country,
    channel,
    COUNT(IF(device = "PC", 1, NULL)) as count_pc,
    COUNT(IF(device = "Mobile", 1, NULL)) as count_mobile,
    COUNT(IF(device = "Unknown", 1, NULL)) as count_unknown,
    COUNT(*) as count_sessions
FROM sessions
GROUP BY session_date, country, channel
ORDER BY session_date DESC, country, channel;

