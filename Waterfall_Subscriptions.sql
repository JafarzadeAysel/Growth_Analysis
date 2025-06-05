
SELECT
	user_id,
    subscription_id,
    CASE
		WHEN subscription_type = 0 THEN "Monthly"
        WHEN subscription_type = 1 THEN "Quarterly"
        WHEN subscription_type = 2 THEN "Annual"
	END as plan,
    subscription_status as status,
    CAST(date_start as DATE) as sub_strart,
    CAST(date_deactivated as DATE) as sub_end,
    CAST(date_deactivated AS DATE) as sub_end
FROM
	student_subscriptions
WHERE
	subscription_type != 3
ORDER BY user_id, date_start;