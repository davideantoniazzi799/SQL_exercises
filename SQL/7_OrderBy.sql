/*
ORDER BY

- sintassi
- ordinare una sola colonna
- ordinare per multiple colonne

*/

/*
SINTASSI
SELECT column_list 
FROM table_name
ORDER BY column_name ASC|DESC;
*/

SELECT * 
FROM dipendenti
ORDER BY nome DESC;

-- Più colonne
SELECT * 
FROM dipendenti
ORDER BY cognome, nome ASC;