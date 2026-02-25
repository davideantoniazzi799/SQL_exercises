/*
LIKE

- spiegazione
- sintassi
- pattern
- comincia con 'C%'
- finisce con '%C'
- contiene '%C%'
- caratteri fissi e comincia con 'C_'
- caratteri fissi e finisce con '_C'
- caratteri fissi e contiene '_C_'
- contiene stringa e finisce con un '%C_'
- contiene stringa e inizia con un '_C%'
*/

/*
SINTASSI
SELECT colonne FROM tabella
WHERE campo LIKE pattern;

*/

-- comincia con 'C%'
SELECT * FROM clienti
WHERE denominazione LIKE 'I%';

-- finisce con '%C'
SELECT * FROM clienti
WHERE denominazione LIKE '%o';

-- contiene '%C%'
SELECT * FROM clienti
WHERE denominazione LIKE '%o%';

-- caratteri fissi e comincia con 'C_'
SELECT * FROM clienti
WHERE denominazione LIKE 'I___________';

-- caratteri fissi e finisce con '_C'
SELECT * FROM clienti
WHERE denominazione LIKE '%_____L.';

-- caratteri fissi e contiene '_C_'
SELECT * FROM clienti
WHERE denominazione LIKE '____izz_____';

-- contiene stringa e finisce con un '%C_'
SELECT * FROM clienti
WHERE denominazione LIKE '%_Cas_';

-- contiene stringa e inizia con un '_C%'
SELECT * FROM clienti
WHERE denominazione LIKE '_ane%';