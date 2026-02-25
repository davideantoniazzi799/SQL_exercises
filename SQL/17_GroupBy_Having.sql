/*
GROUP BY + HAVING

SELECT colonna, count(elemento_da_contare) AS alias
FROM tabella1 AS x
LEFT JOIN tabella2 AS y
ON tabella1.colonna = tabella2.colonna
GROUP BY tabella1.colonna;
*/

SELECT x.nome_ufficio
FROM uffici AS x
LEFT JOIN dipendenti AS y
ON x.id_ufficio = y.id_ufficio
GROUP BY x.nome_ufficio;

SELECT x.nome_ufficio, count(y.id_dipendente) AS totale_dipendenti
FROM uffici AS x
LEFT JOIN dipendenti AS y
ON x.id_ufficio = y.id_ufficio
GROUP BY x.nome_ufficio;

-- HAVING: simile a WHERE, applicato all'aggregato di righe
SELECT x.nome_ufficio, count(y.id_dipendente) AS totale_dipendenti
FROM uffici AS x
LEFT JOIN dipendenti AS y
ON x.id_ufficio = y.id_ufficio
GROUP BY x.nome_ufficio
HAVING totale_dipendenti = 2;
