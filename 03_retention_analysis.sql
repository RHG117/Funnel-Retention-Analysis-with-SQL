/* =========================================================
   03. RETENTION ANALYSIS – USER COHORTS
   Project: Funnel & Retention Analysis – MercadoLibre
   ========================================================= */

/* =========================================================
   TASK 1 – Accumulated Active Users by Country
========================================================= */

SELECT
    country,

  -- Active users_d7
    COUNT(DISTINCT CASE 
        WHEN day_after_signup >= 7 
         AND active = 1 
        THEN user_id END) AS users_d7,
  
-- Active users_d14
    COUNT(DISTINCT CASE 
        WHEN day_after_signup >= 14 
         AND active = 1 
        THEN user_id END) AS users_d14,

  -- Active users_d21
    COUNT(DISTINCT CASE 
        WHEN day_after_signup >= 21 
         AND active = 1 
        THEN user_id END) AS users_d21,

  -- Active users_d28
    COUNT(DISTINCT CASE 
        WHEN day_after_signup >= 28 
         AND active = 1 
        THEN user_id END) AS users_d28

FROM mercadolibre_retention
WHERE activity_date BETWEEN '2025-01-01' AND '2025-08-31'
GROUP BY country
ORDER BY country;

/* =========================================================
   TASK 2 – Retention % by Country
========================================================= */

SELECT
    country,

    ROUND(
        COUNT(DISTINCT CASE 
            WHEN day_after_signup >= 7 AND active = 1 
            THEN user_id END) * 100.0
        / NULLIF(COUNT(DISTINCT user_id), 0)
    ,1) AS retention_d7_pct,

    ROUND(
        COUNT(DISTINCT CASE 
            WHEN day_after_signup >= 14 AND active = 1 
            THEN user_id END) * 100.0
        / NULLIF(COUNT(DISTINCT user_id), 0)
    ,1) AS retention_d14_pct,

    ROUND(
        COUNT(DISTINCT CASE 
            WHEN day_after_signup >= 21 AND active = 1 
            THEN user_id END) * 100.0
        / NULLIF(COUNT(DISTINCT user_id), 0)
    ,1) AS retention_d21_pct,

    ROUND(
        COUNT(DISTINCT CASE 
            WHEN day_after_signup >= 28 AND active = 1 
            THEN user_id END) * 100.0
        / NULLIF(COUNT(DISTINCT user_id), 0)
    ,1) AS retention_d28_pct

FROM mercadolibre_retention
WHERE activity_date BETWEEN '2025-01-01' AND '2025-08-31'
GROUP BY country
ORDER BY country;

/* =========================================================
   TASK 3 – User Cohort Definition
========================================================= */

SELECT
    user_id,
    MIN(signup_date) AS signup_date,
    TO_CHAR(
        DATE_TRUNC('month', MIN(signup_date)),
        'YYYY-MM'
    ) AS cohort
FROM mercadolibre_retention
GROUP BY user_id
LIMIT 5;

/* =========================================================
   TASK 4 – Retention by Cohort
========================================================= */

--CTE cohort
WITH cohort AS (
    SELECT
        user_id,
        TO_CHAR(
            DATE_TRUNC('month', MIN(signup_date)),
            'YYYY-MM'
        ) AS cohort
    FROM mercadolibre_retention
    GROUP BY user_id
),

activity AS (
    SELECT
        r.user_id,
        c.cohort,
        r.day_after_signup,
        r.active
    FROM mercadolibre_retention r
    LEFT JOIN cohort c
        ON r.user_id = c.user_id
    WHERE r.activity_date BETWEEN '2025-01-01' AND '2025-08-31'
)

SELECT
    cohort,

    ROUND(
        100.0 * COUNT(DISTINCT CASE 
            WHEN day_after_signup >= 7 AND active = 1 
            THEN user_id END)
        / NULLIF(COUNT(DISTINCT user_id), 0)
    ,1) AS retention_d7_pct,

    ROUND(
        100.0 * COUNT(DISTINCT CASE 
            WHEN day_after_signup >= 14 AND active = 1 
            THEN user_id END)
        / NULLIF(COUNT(DISTINCT user_id), 0)
    ,1) AS retention_d14_pct,

    ROUND(
        100.0 * COUNT(DISTINCT CASE 
            WHEN day_after_signup >= 21 AND active = 1 
            THEN user_id END)
        / NULLIF(COUNT(DISTINCT user_id), 0)
    ,1) AS retention_d21_pct,

    ROUND(
        100.0 * COUNT(DISTINCT CASE 
            WHEN day_after_signup >= 28 AND active = 1 
            THEN user_id END)
        / NULLIF(COUNT(DISTINCT user_id), 0)
    ,1) AS retention_d28_pct

FROM activity
GROUP BY cohort
ORDER BY cohort;

