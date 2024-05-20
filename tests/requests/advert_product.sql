SELECT forename AS name, product_id, seller_id
FROM marketplace.product
         JOIN marketplace.advert ON product.id = marketplace.advert.product_id
WHERE forename LIKE '4%';
