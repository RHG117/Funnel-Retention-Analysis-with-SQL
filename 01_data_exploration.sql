/* =========================================================
   01. DATA EXPLORATION
   Project: Funnel & Retention Analysis – MercadoLibre
   Description:
   Initial exploration of funnel and retention datasets
   to understand structure, event types, user behavior,
   and data quality before analysis.
   ========================================================= */

/* ---------------------------------------------------------
   1. TABLE OVERVIEW – mercadolibre_funnel
   Objective: Review table structure and sample records
--------------------------------------------------------- */

SELECT *
FROM mercadolibre_funnel
LIMIT 5;


/* ---------------------------------------------------------
   2. TABLE OVERVIEW – mercadolibre_retention
   Objective: Review retention table structure and fields
--------------------------------------------------------- */

SELECT *
FROM mercadolibre_retention
LIMIT 5;


/* ---------------------------------------------------------
   3. COLUMN IDENTIFICATION – FUNNEL TABLE
   Objective: Identify key columns for funnel analysis
--------------------------------------------------------- */

-- Key fields expected:
-- user_id       : unique user identifier
-- session_id    : session-level grouping
-- event_name    : user action
-- event_time    : timestamp of the event
-- country       : user location
-- device_category : device type (mobile, desktop)
-- platform      : operating system or web/app

SELECT DISTINCT event_name
FROM mercadolibre_funnel
ORDER BY event_name;


/* ---------------------------------------------------------
   4. EVENT DISTRIBUTION
   Objective: Understand frequency of events in the funnel
--------------------------------------------------------- */

SELECT
    event_name,
    COUNT(*) AS event_count
FROM mercadolibre_funnel
GROUP BY event_name
ORDER BY event_count DESC;


/* ---------------------------------------------------------
   5. USER & SESSION EXPLORATION
   Objective: Identify number of users and sessions
--------------------------------------------------------- */

SELECT
    COUNT(DISTINCT user_id) AS total_users,
    COUNT(DISTINCT session_id) AS total_sessions
FROM mercadolibre_funnel;


/* ---------------------------------------------------------
   6. EVENTS PER SESSION
   Objective: Understand engagement per session
--------------------------------------------------------- */

SELECT
    session_id,
    COUNT(*) AS events_per_session
FROM mercadolibre_funnel
GROUP BY session_id
ORDER BY events_per_session DESC
LIMIT 10;


/* ---------------------------------------------------------
   7. GEOGRAPHIC DISTRIBUTION
   Objective: Identify main countries in the dataset
--------------------------------------------------------- */

SELECT
    country,
    COUNT(DISTINCT user_id) AS users
FROM mercadolibre_funnel
GROUP BY country
ORDER BY users DESC;


/* ---------------------------------------------------------
   8. DEVICE & PLATFORM DISTRIBUTION
   Objective: Analyze device and platform usage
--------------------------------------------------------- */

SELECT
    device_category,
    platform,
    COUNT(DISTINCT user_id) AS users
FROM mercadolibre_funnel
GROUP BY device_category, platform
ORDER BY users DESC;
