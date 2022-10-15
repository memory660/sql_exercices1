- 1 Donnez la liste des employés ayant une commission

```sql
SELECT e.nom FROM `employe` e WHERE e.commission > 0;
```

- 2 Donnez les noms, emplois et salaires des employés par emploi croissant, et pour chaque emploi, par salaire décroissant

```sql
SELECT e.nom, e.profession, e.salaire FROM `employe` e ORDER BY e.profession, e.salaire DESC;
```

- 3 Donnez le salaire moyen du département Production

```sql
select AVG(e.salaire) from employe e, departement d WHERE d.id = e.dep_id AND d.nom = 'production';
```

- 4 Donnes les numéros de département et leur salaire maximum

```sql
SELECT d.nom, MAX(e.salaire) FROM `employe` e 
INNER JOIN departement d ON d.id = e.dep_id
GROUP BY d.nom;
```

- 5 Donnez les noms des employés ayant le salaire maximum dans chaque département

```sql
SELECT  MAX(e.salaire) FROM `employe` e 
INNER JOIN departement d ON d.id = e.dep_id
GROUP BY d.nom;
```
err: sur e.nom (utilisation de GROUP BY)

```sql
SELECT e.nom, MAX(e.salaire) FROM `employe` e 
INNER JOIN departement d ON d.id = e.dep_id
GROUP BY d.nom;
```

- 6 Donnez les différentes professions et leur salaire moyen

```sql
SELECT e.profession, AVG(e.salaire) FROM `employe` e 
GROUP BY e.profession;
```

- 7 Donnez le ou les emplois ayant le salaire moyen le plus bas, ainsi que ce salaire moyen

```sql
SELECT e.profession, AVG(e.salaire) as moyenne FROM `employe` e 
GROUP BY e.profession
HAVING AVG(e.salaire) = (SELECT AVG(e.salaire) as moy FROM `employe` e GROUP BY e.profession ORDER BY moy limit 1 );
```