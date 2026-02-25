/*
TRUNCATE

- sintassi
- puliamo la tabella
- truncate vs delete:
  truncate ricrea la tabella aggiornando anche l'autoincrement,
  delete permette di filtrare le righe da cancellare
  truncate è un comando di DDL(Data Definition Language)
  delete è un comando di DML(Data Manipulation Language)
  truncate è più veloce perchè cancella a prescindere mentre delete scansiona ogni riga
*/

/*
SINTASSI

TRUNCATE TABLE tabella;

*/

TRUNCATE TABLE clienti;