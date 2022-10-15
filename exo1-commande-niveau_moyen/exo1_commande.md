https://sql.sh/exercices-sql#google_vignette

# COMMANDES - NIVEAU MOYEN

- 1 Obtenir l’utilisateur ayant le prénom “Muriel” et le mot de passe “test11”, sachant que l’encodage du mot de passe est effectué avec l’algorithme Sha1.
- 2 Obtenir la liste de tous les produits qui sont présent sur plusieurs commandes.
- 3 Obtenir la liste de tous les produits qui sont présent sur plusieurs commandes et y ajouter une colonne qui liste les identifiants des commandes associées.
- 4 Enregistrer le prix total à l’intérieur de chaque ligne des commandes, en fonction du prix unitaire et de la quantité
- 5 Obtenir le montant total pour chaque commande et y voir facilement la date associée à cette commande ainsi que le prénom et nom du client associé
- 6 (difficulté très haute) Enregistrer le montant total de chaque commande dans le champ intitulé “cache_prix_total”
- 7 Obtenir le montant global de toutes les commandes, pour chaque mois
- 8 Obtenir la liste des 10 clients qui ont effectué le plus grand montant de commandes, et obtenir ce montant total pour chaque client.
- 9 Obtenir le montant total des commandes pour chaque date
- 10 Ajouter une colonne intitulée “category” à la table contenant les commandes. Cette colonne contiendra une valeur numérique
- 11 Enregistrer la valeur de la catégorie, en suivant les règles suivantes :
    - “1” pour les commandes de moins de 200€
    - “2” pour les commandes entre 200€ et 500€
    - “3” pour les commandes entre 500€ et 1.000€
    - “4” pour les commandes supérieures à 1.000€
- 12 Créer une table intitulée “commande_category” qui contiendra le descriptif de ces catégories
- 13 Insérer les 4 descriptifs de chaque catégorie au sein de la table précédemment créée
- 14 Supprimer toutes les commandes (et les lignes des commandes) inférieur au 1er février 2019. Cela doit être effectué en 2 requêtes maximum

# SOLUTIONS

```sql
1

SELECT * 
FROM `client` 
WHERE `prenom` = 'Muriel'
AND `password` = SHA1("test11")

2

SELECT nom, COUNT(*) AS nbr_items 
FROM `commande_ligne` 
GROUP BY nom 
HAVING nbr_items > 1
ORDER BY nbr_items DESC

3

SELECT nom, COUNT(*) AS nbr_items , GROUP_CONCAT(`commande_id`) AS liste_commandes
FROM `commande_ligne` 
GROUP BY nom 
HAVING nbr_items > 1
ORDER BY nbr_items DESC

4

UPDATE `commande_ligne` 
SET  `prix_total` = (`quantite` * `prix_unitaire`)

5

SELECT client.prenom, client.nom, commande.date_achat, commande_id, SUM(prix_total) AS prix_commande 
FROM `commande_ligne` 
LEFT JOIN commande ON commande.id = commande_ligne.commande_id
LEFT JOIN client ON client.id = commande.client_id
GROUP BY `commande_id`

SELECT SUM(cl.prix_total), c.date_achat, cli.nom FROM commande_ligne cl, commande c, client cli
WHERE cl.commande_id = c.id AND c.client_id = cli.id
GROUP BY cl.commande_id;

6

UPDATE commande AS t1 
INNER JOIN 
    ( SELECT commande_id, SUM(commande_ligne.prix_total) AS p_total 
      FROM commande_ligne 
      GROUP BY commande_id ) t2 
          ON  t1.id = t2.commande_id 
SET t1.cache_prix_total = t2.p_total

7

// sans utiliser la colonne : cache_prix_total
SELECT YEAR(`date_achat`), MONTH(`date_achat`), SUM(`prix_total`) 
FROM commande c, commande_ligne cl
WHERE c.id = cl.commande_id
GROUP BY YEAR(`date_achat`), MONTH(`date_achat`)
ORDER BY YEAR(`date_achat`), MONTH(`date_achat`);

// en utilisant la colonne : cache_prix_total
SELECT YEAR(`date_achat`), MONTH(`date_achat`), SUM(`cache_prix_total`) 
FROM `commande` 
GROUP BY YEAR(`date_achat`), MONTH(`date_achat`)
ORDER BY YEAR(`date_achat`), MONTH(`date_achat`)

8

// en utilisant la colonne : cache_prix_total
SELECT client.nom, client.prenom, SUM(commande.cache_prix_total) AS client_montant
FROM `commande` 
LEFT JOIN client ON client.id = commande.client_id
GROUP BY commande.client_id
ORDER BY client_montant DESC
LIMIT 10

// sans utiliser la colonne : cache_prix_total
SELECT cli.nom, SUM(cl.prix_total) as total
FROM commande_ligne cl, commande c
LEFT JOIN client cli ON cli.id = c.client_id 
WHERE cl.commande_id = c.id
GROUP BY cli.id
ORDER BY total DESC
LIMIT 10;

9

SELECT `date_achat`, SUM(`cache_prix_total`) 
FROM `commande` 
GROUP BY `date_achat`

10

ALTER TABLE `commande` ADD `category` TINYINT UNSIGNED NOT NULL AFTER `cache_prix_total`;

11

UPDATE `commande` 
SET `category` = (
  CASE 
     WHEN cache_prix_total<200 THEN 1
     WHEN cache_prix_total<500 THEN 2
     WHEN cache_prix_total<1000 THEN 3
     ELSE 4
  END )

12

CREATE TABLE `commande_category` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

13

INSERT INTO `commande_category` (`id`, `nom`) VALUES (1, 'commandes de moins de 200€');
INSERT INTO `commande_category` (`id`, `nom`) VALUES (2, 'commandes entre 200€ et 500€');
INSERT INTO `commande_category` (`id`, `nom`) VALUES (3, 'commandes entre 500€ et 1.000€');
INSERT INTO `commande_category` (`id`, `nom`) VALUES (4, 'commandes supérieures à 1.000€');

14

DELETE FROM `commande_ligne` 
WHERE `commande_id` IN ( SELECT id FROM commande WHERE date_achat < '2019-02-01' );
DELETE FROM `commande` WHERE date_achat < '2019-02-01';
```