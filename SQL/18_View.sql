/*
VIEW

- cosa sono le view
- perchè usarle
- esempio pratico:
  creare view: CREATE VIEW nome_view AS
  chiamare view: SELECT * FROM nome_view;

- sostituire una view esistente
  CREATE OR REPLACE VIEW nome_view AS

- aggiornare dati attraverso view (saltiamo)
- rimuovere view: DROP VIEW nome_view;
*/

/*
CREATE VIEW prova AS
SELECT x.id_dipendente, x.nome, y.id_ufficio
FROM dipendenti AS x
LEFT JOIN uffici AS y
ON x.id_ufficio = y.id_ufficio;
*/

SELECT * FROM prova;

-- sostituire una view esistente
CREATE OR REPLACE VIEW prova AS
SELECT * FROM dipendenti;

-- rimuovere view
DROP VIEW prova;
