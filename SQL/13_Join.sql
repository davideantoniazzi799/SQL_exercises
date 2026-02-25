/*
JOIN

- cosa sono
- inner join
- left join
- right join
- full join(non disponibile in MySQL -> union)
- cross join (saltiamo)
*/

/*
SINTASSI

SELECT tabella1.colonna1, tabella2.colonna1
FROM tabella1
INNER JOIN tabella2 ON tabella1.colonna_comune = tabella2.colonna_comune;

*/

-- INNER JOIN (la parte in comune)
SELECT dipendenti.id_dipendente, dipendenti.cognome, dipendenti.nome, uffici.nome_ufficio
FROM dipendenti
INNER JOIN uffici ON dipendenti.id_ufficio = uffici.id_ufficio;

-- LEFT JOIN (tutta la parte di sinistra e quello in comune con quella destra)
SELECT dipendenti.id_dipendente, dipendenti.cognome, dipendenti.nome, uffici.nome_ufficio
FROM dipendenti
LEFT JOIN uffici ON dipendenti.id_ufficio = uffici.id_ufficio;

-- RIGHT JOIN (tutta la parte di destra e quello in comune con quella sinistra)
SELECT dipendenti.id_dipendente, dipendenti.cognome, dipendenti.nome, uffici.nome_ufficio
FROM dipendenti
RIGHT JOIN uffici ON dipendenti.id_ufficio = uffici.id_ufficio;

