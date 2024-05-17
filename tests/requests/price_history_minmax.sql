SELECT forename   AS name,
       AVG(price) AS average,
       MIN(price) AS minimum,
       MAX(price) AS maximum
FROM marketplace.price_history
         JOIN marketplace.product on product.id = price_history.advert_id
GROUP BY name
ORDER BY name;
