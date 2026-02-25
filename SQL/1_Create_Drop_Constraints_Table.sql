CREATE TABLE IF NOT EXISTS dipendenti(
  id_dipendente int unsigned not null AUTO_INCREMENT, -- Questo per associare il dipendente A con il cliente B,
  cognome varchar(255) not null,
  nome varchar(255) not null,
  data_assunzione date not null,
  stipendio decimal(6,2) not null check (stipendio >= 1200 AND stipendio <= 5000),
  telefono varchar(10) not null unique, -- Non può avere il telefono di un altro
  mansione varchar(255) not null default 'impiegato', -- di default avrà valore impiegato, ma può essere modificato quando creo l'elemento
  id_ufficio int,
  PRIMARY KEY(id_dipendente)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS clienti(
  id_cliente int unsigned not null AUTO_INCREMENT,
  denominazione varchar(255) not null unique,
  p_iva varchar(16) not null unique,
  indirizzo varchar(255) not null,
  citta varchar(255) not null,
  telefono varchar(16) not null unique,
  PRIMARY KEY(id_cliente)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS rapporto_clienti(
  id_rapporto int unsigned NOT null AUTO_INCREMENT,
  id_cliente int unsigned NOT null,
  id_dipendente int unsigned NOT null,
  PRIMARY KEY(id_rapporto),
  CONSTRAINT fk_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES clienti(id_cliente),
  CONSTRAINT fk_dipendente
    FOREIGN KEY (id_dipendente)
    REFERENCES dipendenti(id_dipendente)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS uffici(
  id_ufficio int unsigned NOT NULL,
  nome_ufficio varchar(50) NOT NULL,
  PRIMARY KEY(id_ufficio)
)ENGINE=InnoDB;

/*
DROP TABLE rapporto_clienti;
DROP TABLE clienti;
DROP TABLE dipendenti;
DROP TABLE uffici;
*/