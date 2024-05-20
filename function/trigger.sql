CREATE OR REPLACE FUNCTION CLEAR_USER_DATA()
    RETURNS TRIGGER AS
$$
BEGIN
    DELETE
    FROM marketplace.favourite
    WHERE customer_id = OLD.id;

    DELETE
    FROM marketplace.review
    WHERE customer_id = OLD.id;

    RETURN OLD;
END;
$$
    LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION CLEAR_SELLER_DATA()
    RETURNS TRIGGER AS
$$
BEGIN
    DELETE
    FROM marketplace.price_history
    WHERE (SELECT true FROM marketplace.advert WHERE advert.seller_id = OLD.id AND advert.id = price_history.advert_id);

    DELETE
    FROM marketplace.advert
    WHERE seller_id = OLD.id;

    RETURN OLD;
END;
$$
    LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION CLEAR_PRODUCT_DATA()
    RETURNS TRIGGER AS
$$
BEGIN
    DELETE
    FROM marketplace.price_history
    WHERE (SELECT true
           FROM marketplace.advert
           WHERE advert.product_id = OLD.id AND advert.id = price_history.advert_id);

    DELETE
    FROM marketplace.advert
    WHERE product_id = OLD.id;

    DELETE
    FROM marketplace.review
    WHERE product_id = OLD.id;

    DELETE
    FROM marketplace.favourite
    WHERE product_id = OLD.id;

    DELETE
    FROM marketplace.characteristic
    WHERE product_id = OLD.id;

    RETURN OLD;
END;
$$
    LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION EVALUATE_HISTORY()
    RETURNS TRIGGER AS
$$
BEGIN
    IF OLD.price IS NULL OR NEW.price <> OLD.price THEN
        INSERT INTO marketplace.price_history
        VALUES (NEW.id, NEW.price, NEW.publication_date);
    END IF;

    RETURN NEW;
END;
$$
    LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION EVALUATE_ADVERT()
    RETURNS TRIGGER AS
$$
BEGIN
    UPDATE marketplace.advert
    SET price = NEW.price
    WHERE id = NEW.advert_id;

    RETURN NEW;
END;
$$
    LANGUAGE 'plpgsql';
