-- Создадим представление на профиль пользователя без его личных данных
-- (оставим имя, фамилию, дату регистрации и частично почту и телефон)
CREATE OR REPLACE VIEW user_private AS
SELECT id,
       forename,
       surname,
       registration_date::date,
       part_phone(phone::text) AS phone,
       part_email(email::text) AS email
FROM marketplace.customer;
.00
-- Создадим представление на объявление на товар и его текущую цену
CREATE OR REPLACE VIEW price_current AS
SELECT advert.id AS advert_id, product.id AS product_id, product.forename AS product_name, advert.price
FROM marketplace.advert
         JOIN marketplace.product ON product.id = advert.product_id;

-- Создадим представление на продавца и все его объявления с текущей ценой
CREATE OR REPLACE VIEW seller_adverts AS
SELECT advert.id        AS advert_id,
       seller.id        AS seller_id,
       seller.forename  AS seller_name,
       product.id       AS product_id,
       product.forename AS product_name,
       advert.price
FROM marketplace.advert
         JOIN marketplace.seller ON seller.id = advert.seller_id
         JOIN marketplace.product ON advert.product_id = product.id;

-- Создадим представление на товар, минимальную текущую цену на него и предлагающего за нее продавца
CREATE OR REPLACE VIEW product_price_min AS
SELECT DISTINCT ON (seller_adverts.product_id) seller_adverts.product_id,
                                               product_name,
                                               seller_id,
                                               seller_name,
                                               advert_id,
                                               db.price
FROM seller_adverts
         INNER JOIN (SELECT product_id, MIN(price) AS price
                     FROM price_current
                     GROUP BY product_id) AS db ON seller_adverts.price = db.price;

-- Создадим представление на пользователя и написанные им отзывы
CREATE OR REPLACE VIEW customer_review AS
SELECT customer.id,
       product_id,
       product.forename AS product_name,
       mark,
       review.description,
       publication_date::date
FROM marketplace.customer
         JOIN marketplace.review ON review.customer_id = customer.id
         JOIN marketplace.product ON product.id = review.product_id;
