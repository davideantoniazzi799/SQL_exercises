/*
IN e BETWEEN

- sintassi IN
- IN e NOT IN
- sintassi BETWEEN
- BETWEEN e NOT BETWEEN
*/

/*
SINTASSI
SELECT colonna1, colonna2, ...,
FROM table_name
WHERE colonna_nome BETWEEN min_value AND max_value;
*/

SELECT *
FROM dipendenti
WHERE mansione IN ("impiegato", "commerciale");

SELECT *
FROM dipendenti
WHERE data_assunzione NOT BETWEEN "2020-01-01" AND "2020-12-31";
