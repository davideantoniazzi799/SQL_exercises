/*
Insert:
-sintassi
-inserire la prima riga
-senza campi
-auto increment
-inserimenti multipli
*/

/*
SINTASSI
INSERT INTO nome_tabella(colonna1, colonna2, ....)
VALUES (valore1, valore2, ....);

INSERT INTO clienti
VALUES (0, "Abc Casa", "1218567813","Viale Liberazione, Roma", "2343212666")
*/

INSERT INTO clienti(denominazione, p_iva, indirizzo, telefono)
VALUES ("Abc Casa", "1218567813","Viale Liberazione, Roma", "2343212666");

/*
MULTIPLI
*/
INSERT INTO clienti(denominazione, p_iva, indirizzo, citta, telefono)
VALUES 
("Luce Casa", "1218563453","Viale Padova", "Roma", "2323212666"),
("Muro Bianco", "2318563453","Viale Vesuvio", "Schio", "2318212666"),
("Vernici S.r.L.", "1218523453","Viale Bologna", "Torino", "2321812666"),
("Acciaio S.r.L.", "3218563743","Via Tevere", "Roma", "2338912689"),
("Il pizzaiolo", "1218563345","Via Lanterna", "Genoa", "2453212689"),
("Pane e Birra", "1218563743","Via Torino", "Genoa", "2323212689"),
("Scarpe e Borse", "1218612743","Via Stadio", "Roma", "2323202189");

INSERT INTO dipendenti(cognome, nome, data_assunzione, stipendio, telefono, mansione, id_ufficio)
VALUES 
("Rossi", "Luca","2020-01-07", 1400, "3667165788", "impiegato", 1),
("Verdi", "Mario","2019-01-07", 1700, "3667188788", "commerciale", 2),
("Bianchi", "Iginio","2018-06-04", 1800, "3717165788", "commerciale", 3),
("Antonelli", "Gianluca","2018-05-15", 1560, "3662131888", "commerciale", 4),
("Lanaro", "Andrea","2020-03-10", 1650, "3662135788", "magazziniere", 4),
("Scalzi", "Tobia","2021-06-07", 1360, "3662135001", "impiegato", 5),
("Torri", "Matteo","2020-09-23", 1700, "3882135705", "magazziniere", 5);

INSERT INTO uffici
VALUES 
(1, "Amministrazione"),
(2, "Servizio Clienti"),
(3, "Risorse Umane"),
(4, "Vendite"),
(5, "Produzione")