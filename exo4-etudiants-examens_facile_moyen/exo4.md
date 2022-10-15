# partie 1 - facile

- 6.  récupérer tous les livres de la table lpecom_livres à l'exception de celui portant la valeur pour la colonne isbn_10 : 2092589547 ?

```sql
SELECT *
FROM lpecom_livres
WHERE isbn_10 != 2092589547;
```

- 7. récupérer le prix du livre le moins élevé de la table lpecom_livres en renommant la colonne dans les résultats par minus ?

```sql
SELECT MIN(prix) as minus
FROM lpecom_livres;
```

- 8. sélectionner uniquement les 3 premiers résultats sans le tout premier de la table lpecom_livres ?

```sql
SELECT *
FROM lpecom_livres
LIMIT 3 OFFSET 1;
```


# partie 2 - facile / moyen

- 3.  calculer la moyenne de l'examen portant l'id : 45 ?

```sql
SELECT AVG(note)
FROM lpecom_examens
WHERE id_examen = 45;
```


- 4. pour récupérer la meilleure note de l'examen portant l'id : 87 ?

```sql
SELECT MAX(note)
FROM lpecom_examens
WHERE id_examen = 87;
```


- 6. afficher tous les enregistrement de la table lpecom_examens avec en plus, si c'est possible, le prenom et le nom de l'étudiant ?

```sql
SELECT ex.*, et.prenom, et.nom
FROM lpecom_examens ex
LEFT JOIN lpecom_etudiants et ON ex.id_etudiant = et.id_etudiant;
```


- 7. afficher les enregistrement de la table lpecom_examens avec le prenom et le nom de l'étudiant, uniquement quand les étudiants sont présents dans la table lpecom_etudiants ?

```sql
SELECT ex.*, et.prenom, et.nom
FROM lpecom_examens ex
INNER JOIN lpecom_etudiants et ON ex.id_etudiant = et.id_etudiant;
```

- 8. afficher uniquement le nom et le prenom de l'étudiant avec l'id : 30 avec la moyenne de ses deux examens dans une colonne moyenne ? 

```sql
SELECT et.prenom, et.nom, AVG(ex.note) as moyenne
FROM lpecom_examens ex
INNER JOIN lpecom_etudiants et ON ex.id_etudiant = et.id_etudiant
WHERE et.id_etudiant = 30;
```


- 9. afficher les 3 meilleures examens, du meilleur au moins bon, avec le prenom et le nom de l'étudiant associé ?

```sql
SELECT *
FROM lpecom_examens ex
INNER JOIN lpecom_etudiants et ON ex.id_etudiant = et.id_etudiant
ORDER BY ex.note DESC
LIMIT 3;
```

# partie 4 - moyen

- 3. Sans jointure, quelle requête utiliser pour calculer le nombre de villes en Île-de-France se terminant par "-le-Roi" ?

```sql
SELECT COUNT(*) FROM lpecom_cities WHERE name LIKE "%-le-Roi";
```


- 7. quelles sont les deux villes de Seine-et-Marne à avoir le code postal (zip_code) le plus grand ?

```sql
SELECT * FROM lpecom_cities WHERE department_code = 77 ORDER BY zip_code DESC LIMIT 2;
```


- 9. Avec un seul WHERE et aucun OR, quelle est la requête permettant d'afficher les départements des régions ayant le code suivant : 75, 27, 53, 84 et 93 ? 
- Le résultat doit afficher le nom du département ainsi que le nom et le slug de la région associée.

```sql
SELECT d.name AS departement, r.name AS region, d.slug
FROM lpecom_departments d
INNER JOIN lpecom_regions r ON (d.region_code = r.code)
WHERE d.region_code IN (75, 27, 53, 84, 93);
```


- 10. Quelle requête utiliser pour obtenir en résultat, les noms de la région, du département et de chaque ville du département ayant pour code 77 ?

```sql
SELECT r.name as reg, d.name as dep, c.name as ville
FROM lpecom_cities c
INNER JOIN lpecom_departments d ON (c.department_code = d.code)
INNER JOIN lpecom_regions r ON (d.region_code = r.code)
WHERE d.code = 77;
```

# partie 5 - moyen

- 2. afficher toutes les données de vaccination uniquement pour le 1er avril 2021 avec le nom de la région concernée ?

```sql
SELECT r.name, c.*
FROM lpecom_covid c
INNER JOIN lpecom_regions r ON c.id_region = r.code
WHERE jour = '2021-04-01';
```


- afficher le nombre au cumulé de vaccination première dose toutes régions en 2020 ? 

```sql
SELECT SUM(n_dose1)
FROM lpecom_covid c
WHERE jour <= '2020-12-31';
```


- afficher le nombre au cumulé de vaccination première dose pour la région avec le code 93 uniquement pour le mois de mars 2021 ?

```sql
SELECT SUM(n_dose1)
FROM lpecom_covid c
WHERE id_region = '93'
AND jour BETWEEN '2021-03-01' AND '2021-03-31';
```


- 9. afficher le nom de la région qui a le plus faible taux de couverture de vaccination avec une dose ? Vous aurez besoin de 2 requêtes pour répondre à la question.

```sql
SELECT MIN(c.couv_dose1)
FROM lpecom_covid c
WHERE c.jour = '2021-04-06';

SELECT c.*, r.name
FROM lpecom_covid c
INNER JOIN lpecom_regions r ON c.id_region = r.code
WHERE c.jour = '2021-04-06'
AND c.couv_dose1 <= 2.80;
```


- calculer la couverture moyenne entre les différentes régions à la date la plus récente, pour les vaccinations une et deux doses ? 
- Vous renommez les colonnes de résultats : couverture_dose1_avg et couverture_dose2_avg

```sql
SELECT AVG(c.couv_dose1) AS couverture_dose1_avg, AVG(c.couv_dose2) AS couverture_dose2_avg
FROM lpecom_covid c
WHERE c.jour = '2021-04-06';
```

# partie 6 - moyen

- quel département possède le plus grand nombre d'injections première dose pour le vaccin AstraZeneka ?

```sql
SELECT MAX(v.n_cum_dose1)
FROM lpecom_covid_vaccin v
INNER JOIN lpecom_covid_vaccin_type t ON t.id = v.vaccin
INNER JOIN lpecom_departments d ON d.code = v.dep_code
WHERE jour = '2021-04-06'
AND v.vaccin = 3;
```


- 9. la moyenne de vaccinations première dose dans tous les départements pour le vaccin Moderna ? 
- Renommer la colonne de résultat avec avg_moderna.

```sql
SELECT AVG(n_cum_dose1) AS avg_moderna
FROM lpecom_covid_vaccin v
INNER JOIN lpecom_covid_vaccin_type t ON t.id = v.vaccin
INNER JOIN lpecom_departments d ON d.code = v.dep_code
WHERE v.jour = '2021-04-06'
AND v.vaccin = 2;
```

