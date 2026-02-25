/*
DATE E TEMPO

- introduzione
- tipi di dati relativi al tempo
- now()
- proprietà di aggiornamento automatico:
    DEFAULT CURRENT TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP
- estrarre solo certe parti della data
    YEAR(), MONTH(), DAYOFMONTH(), MONTHNAME(), DAYNAME(), HOUR(), MINUTE(), SECOND()
- formattazione date
  DATE_FORMAT(bith_date, '%M %e %Y')
*/

CREATE TABLE IF NOT EXISTS prova(
  id int(4) NOT NULL PRIMARY KEY auto_increment,
  nome varchar(50) not null unique,
  data_nascita date not null,
  data_inserimento datetime default current_timestamp,
  data_modifica timestamp default current_timestamp on update current_timestamp
);

/*
-- NOW()
INSERT INTO prova(nome, data_nascita, data_inserimento)
VALUES ("Luca", "1995-06-06", NOW())
*/

-- Default current timestamp
INSERT INTO prova(nome, data_nascita)
VALUES ("Marco", "1999-06-16")

-- ON UPDATE current timestamp
update prova set nome = "Antonio"
where id = 1;

-- parti data
SELECT nome, year(data_nascita) from prova;
SELECT nome, month(data_nascita) from prova;
SELECT nome, monthname(data_nascita) from prova;

-- formattazione data
SELECT nome, date_format(data_nascita, '%M %e %Y') as data_nascita 
from prova;