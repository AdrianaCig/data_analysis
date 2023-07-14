/* ---------------------------
   KPIs for Video Game Dataset
   ---------------------------

In this project I will use SQL to calculate KPIs like Daily Active Users, Daily Average Revenue per User and Retention for a Mineblocks video game. */


/* 1. Daily Active Users */

SELECT date(created_at), 
	count(distinct user_id) as dau
FROM gameplays
GROUP BY 1
ORDER BY 1;


/* 2. Daily Active Users per Platform */

SELECT date(created_at), 
	platform
	count(distinct user_id) as dau
FROM gameplays
GROUP BY 1, 2
ORDER BY 1, 2;


/* 3. Daily Average Revenue per Purchasing User */

SELECT date(created_at), 
	round (sum(price) / 
	count(distinct user_id), 2) as arppu
FROM purchases
WHERE refunded_at is null
GROUP BY 1
ORDER BY 1;


/* 4. Daily Average Revenue per User 
	4.1. Daily Revenue */

WITH daily_revenue as(
SELECT 
	date(created_at) as dt,
	round(sum(price), 2) as rev
FROM purchases
WHERE refunded_at IS NULL
GROUP BY 1),

/* 4.2. Daily Players */

daily_players as(
SELECT 
	date(created_at) as dt,
	count(distinct user_id) as players
FROM gameplays
GROUP BY 1)
SELECT *
FROM daily_players
ORDER BY dt;

/* 4.3. Join them and calculate ARPU */

WITH daily_revenue AS(
SELECT 
	date(created_at) as dt,
	round(sum(price), 2) as rev
FROM purchases
WHERE refunded_at is null
GROUP BY 1),
daily_players as(
SELECT 
	date(created_at) as dt,
	count(distinct user_id) as players
FROM gameplays
GROUP BY 1)
SELECT daily_revenue.dt,
daily_revenue.rev / daily_players.players
FROM daily_revenue
JOIN daily_players
USING dt;


/* 5. 1 Day Retention */

SELECT 
	date(created_at) as dt,
	user_id
FROM gameplays as g1
ORDER BY 1
LIMIT 100;


SELECT 
	date(g1.created_at) as dt,
	g1.user_id
FROM gameplays as g1
JOIN gameplays as g2 ON
	g1.user_id = g2.user_id 
ORDER BY 1
LIMIT 100;


SELECT 
	date(g1.created_at) as dt,
	g1.user_id
	g2.user_id
FROM gameplays as g1
JOIN gameplays as g2 ON
	g1.user_id = g2.user_id 
	AND date(g1.created_at) = 
	date(datetime(g2.created_at, '-1 day'))
ORDER BY 1
LIMIT 100;


SELECT 
	date(g1.created_at) as dt,
	count(distinct g1.user_id) as total_users,
	count(distinct g2.user_id) as retained_users
FROM gameplays as g1
JOIN gameplays as g2 ON
	g1.user_id = g2.user_id 
	AND date(g1.created_at) = 
	date(datetime(g2.created_at, '-1 day'))
GROUP BY 1
ORDER BY 1
LIMIT 100;


SELECT 
	date(g1.created_at) as dt,
	round(100 * count(distinct g2.user_id) /
	count(distinct g1.user_id)) as retention
FROM gameplays as g1
LEFT JOIN gameplays as g2 ON
	g1.user_id = g2.user_id 
	AND date(g1.created_at) = 
	date(datetime(g2.created_at, '-1 day'))
GROUP BY 1
ORDER BY 1
LIMIT 100;
