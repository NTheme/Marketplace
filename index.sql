-- Создадим индекс по id пользователя, чтобы быстрее получать группу избранных им товаров
CREATE INDEX IF NOT EXISTS favourite_user ON marketplace.favourite (customer_id);

-- Создадим индекс, поддерживающий сортировку имен продавцов в алфавитном порядке, чтобы быстрее искать
CREATE INDEX IF NOT EXISTS seller_alphabetical ON marketplace.seller (forename);

-- Создадим индекс, поддерживающий сортировку фамилий и имен пользователей в алфавитном
-- порядке, что позволит быстрее искать человека
CREATE INDEX IF NOT EXISTS customer_alphabetical ON marketplace.customer (surname, forename);

-- Создадим индекс по названию товара в нижнем регистре, чтобы быстрее работал не зависящий от регистра поиск
CREATE INDEX IF NOT EXISTS product_lower ON marketplace.product (lower(forename));

-- Создадим индекс по категории товара, чтобы быстрее искать похожие
CREATE INDEX IF NOT EXISTS product_category ON marketplace.product (category_id);
