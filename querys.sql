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


-- 4/ Afficher la quantité totale de bières vendues par continent, en affichant 
-- le nom du continent.

SELECT SUM(quantity) AS total, continent_name
FROM sale
    JOIN article USING(id_article)
    JOIN brand USING(id_brand)
    JOIN country USING(id_country)
    JOIN continent USING(id_continent)
GROUP BY id_continent

-- 5/ Afficher la moyenne des prix d'achat des articles par type, en indiquant 
-- le nom du type et la moyenne des prix d'achat.

SELECT type_name, AVG(purchase_price) AS avg_price
FROM article
    JOIN type USING(id_type)
GROUP BY id_type

-- 6/ Afficher la somme des quantités vendues pour chaque couleur de bière, 
-- en affichant le nom de la couleur et la somme des quantités.

SELECT SUM(quantity) AS total, color_name
FROM sale
    JOIN article USING(id_article)
    JOIN color USING(id_color)
GROUP BY id_color


-- 7/ Afficher le volume total des ventes réalisées pour chaque marque, 
-- trié par ordre décroissant.

SELECT SUM(volume * quantity) AS vol, brand_name
FROM sale
    JOIN article USING(id_article)
    JOIN brand USING(id_brand)
GROUP BY id_brand
ORDER BY vol DESC

-- 3130491 BrewDog

-- 8/ Afficher le prix d'achat moyen des articles pour chaque pays, en indiquant 
-- le nom du pays et le prix d'achat moyen.

SELECT country_name, AVG(purchase_price) AS avg_price
FROM article
    JOIN brand USING(id_brand)
    JOIN country USING(id_country)
GROUP BY id_country


-- 9/ Afficher le prix d'achat le plus élevé et le prix d'achat le plus bas par 
-- continent, en précisant le nom du continent.

SELECT MAX(purchase_price) AS max, MIN(purchase_price) AS min, continent_name
FROM article
    JOIN brand USING(id_brand)
    JOIN country USING(id_country)
    JOIN continent USING(id_continent)
GROUP BY id_continent



-- 10/ Afficher le nombre total d'articles vendus pour chaque type de bière, 
-- en affichant le nom du type et le nombre total d'articles vendus.

SELECT type_name, SUM(quantity) AS total
FROM sale
    JOIN article USING(id_article)
    JOIN type USING(id_type)
GROUP BY id_type

--Ale 471382

-- 1/ Quels sont les tickets qui comportent l'article d'ID 500 ?
-- Afficher le numéro de ticket uniquement.

SELECT id_ticket
FROM sale
WHERE id_article = 500



-- 2/ Quels sont les tickets du 15/01/2017 ?
-- Afficher le numéro de ticket et la date.

SELECT ticket_date, id_ticket
FROM ticket
WHERE ticket_date = "2017-01-15"


-- 3/ Quels sont les tickets émis du 15/01/2017 au 17/01/2017 ?
-- Afficher le numéro de ticket et la date.

SELECT ticket_date, id_ticket
    FROM ticket
WHERE ticket_date BETWEEN "2017-01-15" AND "2017-01-17"


-- 4/ Quels sont les articles (Code et nom uniquement) apparaissant sur un 
-- ticket à au moins 95 exemplaires.

SELECT id_article, article_name, SUM(quantity) AS total
    FROM sale
    JOIN article USING(id_article)
GROUP BY id_article
HAVING total >= 95

-- 5/ Quels sont les tickets émis au mois de mars 2017 ?
-- Afficher le numéro de ticket et la date.

SELECT ticket_date, id_ticket
FROM ticket
WHERE ticket_date LIKE "2017-03%"

-- 6/ Quels sont les tickets émis au deuxième trimestre 2017 ?
-- Afficher le numéro de ticket et la date.

SELECT ticket_date, id_ticket
FROM ticket
WHERE ticket_date BETWEEN "2017-04-01" AND "2017-06-30"

-- 7/ Quels sont les tickets émis au mois de mars et juillet 2017 ?
-- Afficher le numéro de ticket et la date.

SELECT ticket_date, id_ticket
FROM ticket
WHERE ticket_date LIKE "2017-03%" OR 
    ticket_date LIKE "2017-07%"

-- 8/ Afficher la liste de toutes les bières classée par couleur.
-- Afficher code et nom de bière, nom de la couleur

SELECT  id_article, article_name, color_name
FROM article
    JOIN color USING(id_color)
GROUP BY id_article, id_color
ORDER BY color_name



-- 9/ Afficher la liste des bières n'ayant pas de couleur. 
-- Afficher le code et le nom

SELECT color_name, article_name
FROM article
    LEFT JOIN color USING(id_color) 
WHERE color_name IS NULL



-- 10/ Lister pour chaque ticket la quantité totale d'articles vendus (en nombre).
-- Classer par quantité décroissante

SELECT id_ticket, SUM(quantity)
FROM article
    JOIN sale USING(id_article)
    JOIN ticket USING(id_ticket)
GROUP BY id_ticket


-- 11/ Lister chaque ticket pour lequel la quantité totale d'articles vendus est inférieure à 50.
-- Classer par quantité croissante




-- 12/ Lister chaque ticket pour lequel la quantité totale d'articles vendus est supérieure à 500.
-- Classer par quantité décroissante



-- 13/ Lister chaque ticket pour lequel la quantité totale d'articles vendus est supérieure à 500. On exclura du total, les ventes de 50 articles et plus.
-- classer par quantité décroissante



-- 14/ Lister les bières de type ‘Trappiste'.
-- Afficher id, nom de la bière, volume et titrage


-- 15/ Lister les marques du continent ‘Afrique'.
-- Afficher id et nom de marque, nom du continent


-- 16/ Lister les bières du continent ‘Afrique'.
-- Afficher ID, Nom et volume


-- 17/ Lister les tickets classés par montant décroissant.
-- Afficher l'année, numéro de ticket, montant total à payer
--     En sachant que l'on applique un taux de TVA de 20% au montant total hors taxe de chaque ticket.


-- 18/ Donner le C.A. par année.
-- Afficher les années et Total HT


-- 19/ Lister les quantités vendues de chaque article pour l'année 2017.
-- Afficher id et nom de l'article, quantité vendue