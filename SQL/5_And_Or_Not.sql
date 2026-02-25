/*
AND, OR, NOT

- sintassi AND
- sintassi OR
- sintassi NOT
- combinazione and, or, not

*/

/*
SELECT colonna1, colonna2,....
FROM tabella
WHERE condizione1 AND condizione2 AND ..... ;
*/

SELECT *
FROM dipendenti
WHERE stipendio >= 1800 AND mansione = "commerciale";

SELECT *
FROM dipendenti
WHERE stipendio >= 1800 OR mansione = "commerciale";

SELECT *
FROM dipendenti
WHERE NOT stipendio >= 1800;

SELECT *
FROM dipendenti
WHERE mansione = "impiegato" OR (stipendio > 1700 AND mansione = "commerciale");