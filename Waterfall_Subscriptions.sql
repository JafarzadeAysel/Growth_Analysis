
SELECT
	user_id,
    subscription_id,
    CASE
		WHEN subscription_type = 0 THEN "Monthly"
        WHEN subscription_type = 1 THEN "Quarterly"
        WHEN subscription_type = 2 THEN "Annual"
	END as plan
FROM
	student_subscriptions
WHERE
	subscription_type != 3
ORDER BY user_id, date_start;