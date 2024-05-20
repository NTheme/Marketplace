SELECT forename as name,
       surname
FROM marketplace.customer
WHERE date_part('year', birthday) = 1899
ORDER BY name;
