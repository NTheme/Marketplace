SELECT RANK() OVER (ORDER BY cnt DESC) AS rank, forename, cnt
FROM (SELECT forename, COUNT(*) AS cnt
      FROM marketplace.product,
           marketplace.favourite
      WHERE marketplace.product.id = marketplace.favourite.product_id
      GROUP BY forename) AS db
GROUP BY forename, cnt
ORDER BY rank, forename;
