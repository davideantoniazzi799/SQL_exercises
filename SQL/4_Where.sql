/*
WHERE

- sintassi
- prima condizione
- operatori logici

*/

/*
SINTASSI
SELECT column_list FROM table_nome WHERE condition;

SELECT * FROM clienti WHERE id_cliente = 1;
*/

SELECT denominazione, telefono FROM clienti WHERE id_cliente = 1;

/*
Operatori logici
*/
SELECT denominazione, telefono FROM clienti WHERE id_cliente != 1;

SELECT * FROM dipendenti WHERE stipendio <= 1400;
