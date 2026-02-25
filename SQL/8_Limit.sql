/*
LIMIT

- sintassi limit
- limit offset
*/

/*
SINTASSI

SELECT colonne FROM tabella LIMIT numero;
*/

SELECT * FROM dipendenti ORDER BY stipendio DESC LIMIT 3;

SELECT * FROM dipendenti ORDER BY id_dipendente ASC LIMIT 1;

-- Last ID
SELECT * FROM dipendenti ORDER BY id_dipendente DESC LIMIT 1;

-- Limit offset
-- Quante righe salta prima di darci il limite
-- In questo esempio, salta una riga e prende le successive due
SELECT * FROM dipendenti ORDER BY id_dipendente ASC LIMIT 1, 2;
-- Esempio senza offset
SELECT * FROM dipendenti ORDER BY id_dipendente ASC LIMIT 2;

-- Penultimo ID aggiunto
SELECT * FROM dipendenti ORDER BY id_dipendente DESC LIMIT 1, 1;