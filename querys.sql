SELECT COUNT(id_article)
FROM article;

-- 3922

SELECT article_name, MAX(purchase_price)
FROM article;

-- das Echte Märzen / 5.00


SELECT continent_name, COUNT(id_country) AS total
FROM continent 
JOIN country USING(id_continent)
GROUP BY id_continent
ORDER BY total DESC
LIMIT 1

-- Europe 18

SELECT country_name, brand_name
FROM country
    JOIN brand USING (id_country)
WHERE brand_name LIKE '%heineken%';

-- PAYS-BAS

-- Combien de bières ont été vendues lors de chaque transaction ? Afficher les numéros de
-- ticket, la date de ticket, et le nombre de bières.

SELECT id_ticket, ticket_date, SUM(quantity)
FROM sale
    JOIN ticket USING(id_ticket)
GROUP BY id_ticket


