/*
ALIAS

- introduzione
- alias per tabelle
- alias per colonne

*/

-- Tabella
SELECT x.id_dipendente, x.cognome, x.nome, x.data_assunzione, y.nome_ufficio
FROM dipendenti AS x
INNER JOIN uffici AS y 
ON x.id_ufficio = y.id_ufficio;

-- Colonna
SELECT nome, DATE_FORMAT(data_assunzione, '%e %M, %Y') 
AS data_assunzione 
FROM dipendenti;





