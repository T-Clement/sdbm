SELECT COUNT(id_article) AS nb_references
FROM article;

-- 3922

SELECT article_name, MAX(purchase_price)
FROM article;


SELECT article_name, purchase_price
FROM article
GROUP BY id_article
ORDER BY purchase_price DESC
LIMIT 1;

SELECT article_name, purchase_price
FROM article
WHERE purchase_price= (
    SELECT MAX(purchase_price)
    FROM article
);

-- das Echte Märzen / 5.00


SELECT continent_name, COUNT(id_country) AS total
FROM continent 
JOIN country USING(id_continent)
GROUP BY id_continent
ORDER BY total DESC
LIMIT 1;

-- Europe 18

SELECT country_name, brand_name
FROM country
    JOIN brand USING (id_country)
WHERE brand_name LIKE '%heineken%';

-- PAYS-BAS

-- Combien de bières ont été vendues lors de chaque transaction ? Afficher les numéros de
-- ticket, la date de ticket, et le nombre de bières.

SELECT id_ticket, ticket_date, SUM(quantity) AS total
FROM sale
    JOIN ticket USING(id_ticket)
GROUP BY id_ticket;

-- Quel est le nombre total de bières vendues jusqu'à présent ?

 SELECT SUM(quantity) AS total_bears_sold
 FROM sale;

-- 3500044

-- Quelle est la marque de bière la plus vendue (en termes de quantité) ?

SELECT brand_name, SUM(quantity) AS qty
FROM sale
JOIN article USING (id_article)
JOIN brand USING (id_brand)
GROUP BY id_brand
ORDER BY qty DESC
LIMIT 1;

-- 57869 BrewDog


-- 1/ Afficher la liste des articles avec leur nom, prix d'achat et quantité totale 
-- vendue (en nombre de bière).
SELECT article_name, purchase_price, SUM(quantity) AS total
FROM article 
    JOIN sale USING(id_article)
GROUP BY id_article


-- 2/ Afficher le nombre de bières vendues par pays, en affichant le nom du pays.

SELECT SUM(quantity) AS total, country_name
FROM sale
    JOIN article USING(id_article)
    JOIN brand USING(id_brand)
    JOIN country USING(id_country)
GROUP BY id_country


-- 3/ Afficher la quantité totale de bières vendues par marque, avec le nom 
-- de chaque marque, triée par ordre décroissant.

SELECT SUM(quantity) AS total, brand_name
FROM sale
    JOIN article USING(id_article)
    JOIN brand USING(id_brand)
GROUP BY id_brand
ORDER BY total DESC


-- 4/ Afficher la quantité totale de bières vendues par continent, en affichant le nom du continent.



-- 5/ Afficher la moyenne des prix d'achat des articles par type, en indiquant le nom du type et la moyenne des prix d'achat.


-- 6/ Afficher la somme des quantités vendues pour chaque couleur de bière, en affichant le nom de la couleur et la somme des quantités.


-- 7/ Afficher le volume total des ventes réalisées pour chaque marque, trié par ordre décroissant.


-- 8/ Afficher le prix d'achat moyen des articles pour chaque pays, en indiquant le nom du pays et le prix d'achat moyen.


-- 9/ Afficher le prix d'achat le plus élevé et le prix d'achat le plus bas par continent, en précisant le nom du continent.


-- 10/ Afficher le nombre total d'articles vendus pour chaque type de bière, en affichant le nom du type et le nombre total d'articles vendus.