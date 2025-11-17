WITH base AS (
    SELECT
        
        saledate,
        TRY_TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS') AS sale_ts,

        -- Time Periods
        TO_CHAR(TRY_TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'), 'YYYY') AS sale_year,
        TO_CHAR(TRY_TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'), 'YYYY-MM') AS sale_month,
        TO_CHAR(
            DATE_TRUNC('quarter', TRY_TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS')),
            'YYYY-"Q"Q'
        ) AS sale_quarter,

       
        make,
        model,
        year AS year_manufactured,
        state,
        odometer,
        sellingprice,
        cost_price,
        units_sold,

        
        (sellingprice * units_sold) AS total_revenue,
        (sellingprice - cost_price) AS profit_amount,
        ((sellingprice - cost_price) / NULLIF(sellingprice, 0)) * 100 AS profit_margin,

        CASE
            WHEN sellingprice >= 50000 THEN 'High Price'
            WHEN sellingprice BETWEEN 20000 AND 49999 THEN 'Medium Price'
            ELSE 'Low Price'
        END AS price_category
    FROM "CARSALES"."STUDY"."FINAL"
)

SELECT
    
    saledate,
    sale_year,
    sale_month,
    sale_quarter,
    make,
    model,
    year_manufactured,
    state,
    odometer,
    sellingprice,
    cost_price,
    units_sold,
    total_revenue,
    profit_margin,
    profit_amount,
    price_category
FROM base
ORDER BY sale_year, sale_month, make, model;
