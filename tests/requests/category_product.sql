SELECT forename                         AS name,
       (SELECT category.forename
        FROM marketplace.category
        WHERE product.category_id = id) AS cat_name
FROM marketplace.product
WHERE category_id = 2
   OR category_id = 20
ORDER BY cat_name;
