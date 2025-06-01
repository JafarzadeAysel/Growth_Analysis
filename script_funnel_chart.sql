WITH visitors_info as (
	SELECT vi.visitor_id, 
vi.user_id,
vi.first_visit_date,
IFNULL(REPLACE(se.utm_source,',',';'),'Organic') as channel, 
si.date_registered,
si.first_watch_date,
MIN(su.date_purchased) AS first_purchase_date
	FROM front_visitors vi
INNER JOIN front_sessions se 
on vi.visitor_id = se.visitor_id
LEFT JOIN student_info si
on vi.user_id = si.user_id
LEFT JOIN student_purchases su
on si.user_id = su.user_id
WHERE vi.first_visit_date >= '2022-07-01' AND (vi.first_visit_date < si.date_registered OR si.date_registered IS NULL)
group by vi.visitor_id
),
count_all AS(
SELECT COUNT(*) as count_visitors,
first_visit_date,
channel
FROM visitors_info
GROUP BY first_visit_date, channel),

count_free AS (

SELECT COUNT(*) as count_free,
first_visit_date,
channel
FROM visitors_info
WHERE date_registered IS NOT NULL 
	AND
    (first_purchase_date IS NULL OR TIMESTAMPDIFF(minute, date_registered, first_purchase_date) > 30)
GROUP BY first_visit_date, channel),

count_watched AS (
SELECT COUNT(*) as count_watched,
first_visit_date,
channel
FROM visitors_info
WHERE first_watch_date IS NOT NULL AND (first_purchase_date IS NULL OR first_watch_date < first_purchase_date)
GROUP BY first_visit_date, channel ),

count_paid AS (
SELECT COUNT(*) as count_paid,
first_visit_date,
channel
FROM visitors_info
WHERE first_purchase_date IS NOT NULL
GROUP BY first_visit_date, channel )

SELECT
	a.first_visit_date,
    a.channel,
    a.count_visitors,
    IFNULL(f.count_free, 0) as count_free,
    IFNULL(w.count_watched, 0) as count_watched,
    IFNULL(p.count_paid, 0) as count_paid
FROM
	count_all as a
    LEFT JOIN
    count_free as f ON a.first_visit_date = f.first_visit_date AND a.channel = f.channel
    LEFT JOIN
    count_watched as w ON a.first_visit_date = w.first_visit_date AND a.channel = w.channel
    LEFT JOIN
    count_paid as p ON a.first_visit_date = p.first_visit_date AND a.channel = p.channel
ORDER BY first_visit_date, count_visitors DESC; 