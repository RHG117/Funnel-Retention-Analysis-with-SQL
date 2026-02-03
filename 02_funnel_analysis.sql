/* =========================================================
   02. FUNNEL ANALYSIS – USER JOURNEY
   Project: Funnel & Retention Analysis – MercadoLibre
   Date range: 2025-01-01 to 2025-08-31
   ========================================================= */

/* ---------------------------------------------------------
   1. FUNNEL CTEs – USERS PER EVENT
   Objective:
   Create one CTE per funnel stage with unique users
--------------------------------------------------------- */

WITH first_visit AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'first_visit'
      AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),

select_item AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name IN ('select_item', 'select_promotion')
      AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),

add_to_cart AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'add_to_cart'
      AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),

begin_checkout AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'begin_checkout'
      AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),

add_shipping_info AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'add_shipping_info'
      AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),

add_payment_info AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'add_payment_info'
      AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
),

purchase AS (
    SELECT DISTINCT user_id
    FROM mercadolibre_funnel
    WHERE event_name = 'purchase'
      AND event_date BETWEEN '2025-01-01' AND '2025-08-31'
)

SELECT
    COUNT(fv.user_id)  AS usuarios_first_visit,
    COUNT(si.user_id)  AS usuarios_select_item,
    COUNT(atc.user_id) AS usuarios_add_to_cart,
    COUNT(bc.user_id)  AS usuarios_begin_checkout,
    COUNT(asi.user_id) AS usuarios_add_shipping_info,
    COUNT(api.user_id) AS usuarios_add_payment_info,
    COUNT(p.user_id)   AS usuarios_purchase
FROM first_visit fv
LEFT JOIN select_item si
    ON fv.user_id = si.user_id
LEFT JOIN add_to_cart atc
    ON fv.user_id = atc.user_id
LEFT JOIN begin_checkout bc
    ON fv.user_id = bc.user_id
LEFT JOIN add_shipping_info asi
    ON fv.user_id = asi.user_id
LEFT JOIN add_payment_info api
    ON fv.user_id = api.user_id
LEFT JOIN purchase p
    ON fv.user_id = p.user_id;

/* ---------------------------------------------------------
   2. FUNNEL CONVERSION RATES
--------------------------------------------------------- */

WITH funnel_counts AS (
    SELECT
        COUNT(fv.user_id)  AS usuarios_first_visit,
        COUNT(si.user_id)  AS usuarios_select_item,
        COUNT(atc.user_id) AS usuarios_add_to_cart,
        COUNT(bc.user_id)  AS usuarios_begin_checkout,
        COUNT(asi.user_id) AS usuarios_add_shipping_info,
        COUNT(api.user_id) AS usuarios_add_payment_info,
        COUNT(p.user_id)   AS usuarios_purchase
    FROM first_visit fv
    LEFT JOIN select_item si        ON fv.user_id = si.user_id
    LEFT JOIN add_to_cart atc       ON fv.user_id = atc.user_id
    LEFT JOIN begin_checkout bc     ON fv.user_id = bc.user_id
    LEFT JOIN add_shipping_info asi ON fv.user_id = asi.user_id
    LEFT JOIN add_payment_info api  ON fv.user_id = api.user_id
    LEFT JOIN purchase p            ON fv.user_id = p.user_id
)

SELECT
    ROUND(usuarios_select_item       * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_select_item,
    ROUND(usuarios_add_to_cart       * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_add_to_cart,
    ROUND(usuarios_begin_checkout    * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_begin_checkout,
    ROUND(usuarios_add_shipping_info * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_add_shipping_info,
    ROUND(usuarios_add_payment_info  * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_add_payment_info,
    ROUND(usuarios_purchase          * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_purchase
FROM funnel_counts;

/* ---------------------------------------------------------
   3. FUNNEL CONVERSION BY COUNTRY
--------------------------------------------------------- */

WITH first_visit AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'first_visit'
      AND event_time BETWEEN '2025-01-01' AND '2025-08-31'
),

select_item AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'select_item'
      AND event_time BETWEEN '2025-01-01' AND '2025-08-31'
),

add_to_cart AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'add_to_cart'
      AND event_time BETWEEN '2025-01-01' AND '2025-08-31'
),

begin_checkout AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'begin_checkout'
      AND event_time BETWEEN '2025-01-01' AND '2025-08-31'
),

add_shipping_info AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'add_shipping_info'
      AND event_time BETWEEN '2025-01-01' AND '2025-08-31'
),

add_payment_info AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'add_payment_info'
      AND event_time BETWEEN '2025-01-01' AND '2025-08-31'
),

purchase AS (
    SELECT DISTINCT user_id, country
    FROM mercadolibre_funnel
    WHERE event_name = 'purchase'
      AND event_time BETWEEN '2025-01-01' AND '2025-08-31'
),

funnel_counts AS (
    SELECT
        fv.country,
        COUNT(DISTINCT fv.user_id)  AS usuarios_first_visit,
        COUNT(DISTINCT si.user_id)  AS usuarios_select_item,
        COUNT(DISTINCT atc.user_id) AS usuarios_add_to_cart,
        COUNT(DISTINCT bc.user_id)  AS usuarios_begin_checkout,
        COUNT(DISTINCT asi.user_id) AS usuarios_add_shipping_info,
        COUNT(DISTINCT api.user_id) AS usuarios_add_payment_info,
        COUNT(DISTINCT p.user_id)   AS usuarios_purchase
    FROM first_visit fv
    LEFT JOIN select_item si
        ON fv.user_id = si.user_id AND fv.country = si.country
    LEFT JOIN add_to_cart atc
        ON fv.user_id = atc.user_id AND fv.country = atc.country
    LEFT JOIN begin_checkout bc
        ON fv.user_id = bc.user_id AND fv.country = bc.country
    LEFT JOIN add_shipping_info asi
        ON fv.user_id = asi.user_id AND fv.country = asi.country
    LEFT JOIN add_payment_info api
        ON fv.user_id = api.user_id AND fv.country = api.country
    LEFT JOIN purchase p
        ON fv.user_id = p.user_id AND fv.country = p.country
    GROUP BY fv.country
)
-- Calculate conversion (%) for usuarios_first_visits per country
SELECT
    country,
    ROUND(usuarios_select_item       * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_select_item,
    ROUND(usuarios_add_to_cart       * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_add_to_cart,
    ROUND(usuarios_begin_checkout    * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_begin_checkout,
    ROUND(usuarios_add_shipping_info * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_add_shipping_info,
    ROUND(usuarios_add_payment_info  * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_add_payment_info,
    ROUND(usuarios_purchase          * 100.0 / NULLIF(usuarios_first_visit, 0), 2) AS conversion_purchase
FROM funnel_counts
ORDER BY conversion_purchase DESC;

