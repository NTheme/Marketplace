UPDATE marketplace.customer
SET email = 'info@mipt.ru'
WHERE surname LIKE '%11%';

SELECT forename AS name, email
FROM marketplace.customer
WHERE email = 'info@mipt.ru';
