/*
ALTER TABLE

- spiegazione
- aggiungere nuova colonna
- cambiare posizione della colonna
- aggiungere constraint
- rimuovere una colonna
- cambiare tipo di dato di una colonna
- rinominare tabella
*/

/*
aggiungere nuova colonna
ALTER TABLE table_name ADD column_name data_type contraints;
*/
ALTER TABLE rapporto_clienti ADD prova varchar(50) NOT NULL;

/*
cambiare posizione della colonna
ALTER TABLE table_name
MODIFY column_name column_definition AFTER column_name;
*/
ALTER TABLE rapporto_clienti
MODIFY prova varchar(50) AFTER id_rapporto;

/*
aggiungere constraint (per tutti i contraint)
ALTER TABLE table_name ADD UNIQUE (column_name....);
*/
ALTER TABLE rapporto_clienti ADD UNIQUE (prova);

/*
rimuovere una colonna
ALTER TABLE table_name 
DROP COLUMN column_name;
*/
ALTER TABLE rapporto_clienti
DROP COLUMN prova;

/*
cambiare tipo di dato di una colonna
ALTER TABLE table_name MODIFY column_name new_data_type;
*/
ALTER TABLE rapporto_clienti MODIFY prova int;

/*
rinominare tabella
ALTER TABLE current_table_name RENAME new_column_name;
*/
ALTER TABLE rapporto_clienti RENAME miao;