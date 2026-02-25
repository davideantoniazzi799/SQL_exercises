/*
CLONARE TABELLE

- introduzione
- copiare struttura e dati tabella
  CREATE TABLE nuova_tabella LIKE tabella_originale;
  INSERT INTO nuova_tabella SELECT * FROM tabella_originale;
- copiare solo dati
  CREATE TABLE nuova_tabella SELECT * FROM tabella_originale;
*/

CREATE TABLE tabella_clonata_1 LIKE prova;
INSERT INTO tabella_clonata_1 SELECT * FROM prova;

CREATE TABLE tabella_clonata_semplice SELECT * FROM prova; -- no constraints