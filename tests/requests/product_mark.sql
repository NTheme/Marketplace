SELECT forename                        AS name,
       (SELECT ROUND(AVG(mark), 1)
        FROM marketplace.review
        WHERE product.id = product_id) AS mark
FROM marketplace.product;
