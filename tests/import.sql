COPY marketplace.category FROM '/home/ntheme/Homework/DB-Project/category.csv' DELIMITER ',' CSV HEADER;
COPY marketplace.product TO '/var/lib/postgres/data/product.csv' DELIMITER ',' CSV HEADER;
COPY marketplace.characteristic TO '/var/lib/postgres/data/characteristic.csv' DELIMITER ',' CSV HEADER;
COPY marketplace.seller TO '/var/lib/postgres/data/seller.csv' DELIMITER ',' CSV HEADER;
COPY marketplace.advert TO '/var/lib/postgres/data/advert.csv' DELIMITER ',' CSV HEADER;
COPY marketplace.price_history TO '/var/lib/postgres/data/price_history.csv' DELIMITER ',' CSV HEADER;
COPY marketplace.customer TO '/var/lib/postgres/data/customer.csv' DELIMITER ',' CSV HEADER;
COPY marketplace.review TO '/var/lib/postgres/data/review.csv' DELIMITER ',' CSV HEADER;
COPY marketplace.favourite TO '/var/lib/postgres/data/favourite.csv' DELIMITER ',' CSV HEADER;
