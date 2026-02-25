/*
SELECT DISTINCT

- perchè usarlo
- sintassi
- abbiniamolo al count

Forse in una colonna ci sono valori ripetuti, 
ma noi vogliamo i singolo valori
*/

/*
SINTASSI
SELECT DISTINCT colonne FROM tabella;
*/

SELECT DISTINCT citta FROM clienti;

-- CON COUNT
SELECT count(DISTINCT citta) FROM clienti;