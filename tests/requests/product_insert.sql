INSERT INTO marketplace.product
VALUES ((SELECT COUNT(*)
         FROM marketplace.product) + 1,
         21,
        'computer',
        'Not used, fast and furious') ON CONFLICT DO NOTHING;

SELECT *
FROM marketplace.product
WHERE forename = 'computer';
