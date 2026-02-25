/*
UPDATE

- sintassi
- modificare una colonna
- modificare più colonne
- modificare righe insieme
- attenzione a non mettere where
*/

/*
SINTASSI

UPDATE tabella
SET colonna1 = valore1
WHERE condizione;
*/

-- Una colonna
UPDATE clienti
SET indirizzo = "Viale Giulio Cesare"
WHERE id_cliente = 1;

-- Più righe
UPDATE clienti
SET indirizzo = "Viale Augusto"
WHERE citta = "Roma";

-- Più colonne
UPDATE clienti
SET indirizzo = "Via Adriatico", citta = "Trieste"
WHERE id_cliente = 1;

/*
Se si omette where, si va a selezionare tutti i dati.
Quindi è molto importante metterelo,
specialemente se abbiamo una mole di dati consistente.
METTETELO E NON DIMENTICATELO!
*/