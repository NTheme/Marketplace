SELECT forename AS name, COUNT(*) AS product_cnt
FROM marketplace.seller
         JOIN marketplace.advert ON seller.id = marketplace.advert.seller_id
GROUP BY forename
HAVING COUNT(*) > 10
ORDER BY product_cnt DESC;
