DO
$do$
    DECLARE
        index   INT;
        num_min INT := 30;
        num_mid INT := 300;
        num_max INT := 3000;
        num_lrg INT := 10000;
    BEGIN
        index := (SELECT COUNT(*) FROM marketplace.category);
        WHILE index < num_min
            LOOP
                INSERT INTO marketplace.category
                VALUES (index + 1,
                        RANDOM_STRING(10),
                        RANDOM_STRING(30))
                ON CONFLICT DO NOTHING;
                index := (SELECT COUNT(*) FROM marketplace.category);
            END LOOP;

        index := (SELECT COUNT(*) FROM marketplace.product);
        WHILE index < num_mid
            LOOP
                INSERT INTO marketplace.product
                VALUES (index + 1,
                        RANDOM_INT(1, num_min),
                        RANDOM_STRING(10),
                        RANDOM_STRING(30))
                ON CONFLICT DO NOTHING;
                index := (SELECT COUNT(*) FROM marketplace.product);
            END LOOP;

        index := (SELECT COUNT(*) FROM marketplace.characteristic);
        WHILE index < num_min
            LOOP
                INSERT INTO marketplace.characteristic
                VALUES (RANDOM_INT(1, num_mid),
                        RANDOM_STRING(10),
                        RANDOM_STRING(30))
                ON CONFLICT DO NOTHING;
                index := (SELECT COUNT(*) FROM marketplace.characteristic);
            END LOOP;

        index := (SELECT COUNT(*) FROM marketplace.seller);
        WHILE index < num_mid
            LOOP
                INSERT INTO marketplace.seller
                VALUES (index + 1,
                        RANDOM_STRING(10),
                        RANDOM_STRING(30),
                        RANDOM_TIMESTAMP('1000-01-01', '2024-12-31'))
                ON CONFLICT DO NOTHING;
                index := (SELECT COUNT(*) FROM marketplace.seller);
            END LOOP;

        index := (SELECT COUNT(*) FROM marketplace.advert);
        WHILE index < num_max
            LOOP
                INSERT INTO marketplace.advert
                VALUES (index + 1,
                        RANDOM_INT(1, num_mid),
                        RANDOM_INT(1, num_mid),
                        RANDOM_NUMERIC(1, num_lrg),
                        RANDOM_INT(1, 5),
                        RANDOM_TIMESTAMP('1000-01-01', '2024-12-31'))
                ON CONFLICT DO NOTHING;
                index := (SELECT COUNT(*) FROM marketplace.advert);
            END LOOP;

        index := (SELECT COUNT(*) FROM marketplace.price_history);
        WHILE index < num_lrg
            LOOP
                INSERT INTO marketplace.price_history
                VALUES (RANDOM_INT(1, num_max),
                        RANDOM_NUMERIC(1, num_lrg),
                        RANDOM_TIMESTAMP('1000-01-01', '2024-12-31'))
                ON CONFLICT DO NOTHING;
                index := (SELECT COUNT(*) FROM marketplace.price_history);
            END LOOP;

        index := (SELECT COUNT(*) FROM marketplace.customer);
        WHILE index < num_mid
            LOOP
                INSERT INTO marketplace.customer
                VALUES (index + 1,
                        RANDOM_STRING(10),
                        RANDOM_STRING(10),
                        RANDOM_TIMESTAMP('1000-01-01', '2024-12-31'),
                        RANDOM_INT(70000000000, 79999999999),
                        RANDOM_STRING(12),
                        RANDOM_INT(1000000000000000, 9999999999999999))
                ON CONFLICT DO NOTHING;
                index := (SELECT COUNT(*) FROM marketplace.customer);
            END LOOP;

        index := (SELECT COUNT(*) FROM marketplace.review);
        WHILE index < num_max
            LOOP
                INSERT INTO marketplace.review
                VALUES (RANDOM_INT(1, num_mid),
                        RANDOM_INT(1, num_mid),
                        RANDOM_INT(1, 5),
                        RANDOM_STRING(30),
                        RANDOM_TIMESTAMP('1000-01-01', '2024-12-31'))
                ON CONFLICT DO NOTHING;
                index := (SELECT COUNT(*) FROM marketplace.review);
            END LOOP;

        index := (SELECT COUNT(*) FROM marketplace.favourite);
        WHILE index < num_max
            LOOP
                INSERT INTO marketplace.favourite
                VALUES (RANDOM_INT(1, num_mid),
                        RANDOM_INT(1, num_mid))
                ON CONFLICT DO NOTHING;
                index := (SELECT COUNT(*) FROM marketplace.favourite);
            END LOOP;
    END
$do$;
