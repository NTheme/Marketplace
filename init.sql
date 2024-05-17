CREATE SCHEMA IF NOT EXISTS marketplace;

CREATE TABLE IF NOT EXISTS marketplace.category
(
    id          SERIAL       NOT NULL UNIQUE PRIMARY KEY,
    forename    VARCHAR(100) NOT NULL UNIQUE CHECK (LENGTH(forename) > 0),
    description VARCHAR(999)
);

CREATE TABLE IF NOT EXISTS marketplace.product
(
    id          SERIAL       NOT NULL UNIQUE PRIMARY KEY,
    category_id INT          NOT NULL REFERENCES marketplace.category (id),
    forename    VARCHAR(100) NOT NULL UNIQUE CHECK (LENGTH(forename) > 0),
    description VARCHAR(999)
);

CREATE TABLE IF NOT EXISTS marketplace.characteristic
(
    product_id  INT          NOT NULL REFERENCES marketplace.product (id),
    forename    VARCHAR(100) NOT NULL CHECK (LENGTH(forename) > 0),
    description VARCHAR(999),
    UNIQUE (product_id, forename)
);

CREATE TABLE IF NOT EXISTS marketplace.seller
(
    id                SERIAL       NOT NULL UNIQUE PRIMARY KEY,
    forename          VARCHAR(100) NOT NULL UNIQUE CHECK (LENGTH(forename) > 0),
    location          VARCHAR(100),
    registration_date TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS marketplace.advert
(
    id               SERIAL  NOT NULL UNIQUE PRIMARY KEY,
    product_id       INT     NOT NULL REFERENCES marketplace.product (id),
    seller_id        INT     NOT NULL REFERENCES marketplace.seller (id),
    price            NUMERIC NOT NULL CHECK (price > 0),
    delivery_term    INT     NOT NULL CHECK (delivery_term > 0),
    publication_date TIMESTAMP DEFAULT NOW(),
    UNIQUE (product_id, seller_id)
);

CREATE TABLE IF NOT EXISTS marketplace.price_history
(
    advert_id   INT     NOT NULL REFERENCES marketplace.advert (id),
    price       NUMERIC NOT NULL CHECK (price > 0),
    change_date TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS marketplace.customer
(
    id                SERIAL       NOT NULL UNIQUE PRIMARY KEY,
    forename          VARCHAR(100) NOT NULL CHECK (LENGTH(forename) > 0),
    surname           VARCHAR(100),
    birthday          TIMESTAMP,
    phone             VARCHAR(11)  NOT NULL UNIQUE,
    email             VARCHAR(100),
    card              VARCHAR(20),
    registration_date TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS marketplace.review
(
    product_id       INT NOT NULL REFERENCES marketplace.product (id),
    customer_id      INT NOT NULL REFERENCES marketplace.customer (id),
    mark             INT NOT NULL CHECK (0 <= mark AND mark <= 5),
    description      VARCHAR(999),
    publication_date TIMESTAMP DEFAULT NOW(),
    UNIQUE (product_id, customer_id)
);

CREATE TABLE IF NOT EXISTS marketplace.favourite
(
    product_id  INT NOT NULL REFERENCES marketplace.product (id),
    customer_id INT NOT NULL REFERENCES marketplace.customer (id),
    UNIQUE (product_id, customer_id)
);
