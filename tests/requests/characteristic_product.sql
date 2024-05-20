SELECT product.forename AS name, characteristic.forename AS type, AVG(mark)
FROM marketplace.product
         JOIN marketplace.characteristic ON product.id = characteristic.product_id
         JOIN marketplace.review ON product.id = review.product_id
WHERE characteristic.forename LIKE '1%'
GROUP BY product.forename, characteristic.forename
HAVING AVG(mark) > 3;
