CREATE DATABASE biblioteca_curso;

USE biblioteca_curso;

CREATE TABLE autor (
	autor_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(20) NOT NULL,
    nationality VARCHAR(20),
    birth DATE
);

ALTER TABLE autor
ADD PRIMARY KEY (autor_id);

CREATE TABLE libro (
	libro_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(10),
    literary_genre VARCHAR(10),
    year_of_publication DATE,
    number_pages INT,
    isbn VARCHAR(10),
	autor_id VARCHAR(10),
    FOREIGN KEY (autor_id)
    REFERENCES autor(autor_id)
);

CREATE TABLE socio (
	email VARCHAR(10) NOT NULL,
    phone_number INT,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 1 Añadir columna id_socio como PK auto-incremental
ALTER TABLE socio
ADD COLUMN id_socio INT AUTO_INCREMENT PRIMARY KEY FIRST;

-- 2 Añadir columna reading_partner
ALTER TABLE socio
ADD COLUMN reading_partner INT UNIQUE;

-- 3 Crear la FK autorreferencial
ALTER TABLE socio
ADD CONSTRAINT reading_partner_fk
FOREIGN KEY (reading_partner) REFERENCES socio(id_socio);

CREATE TABLE prestamo (
	id_prestamo VARCHAR(10) PRIMARY KEY,
    id_socio INT NOT NULL,
    libro_id VARCHAR(10),
    FOREIGN KEY (id_socio) REFERENCES socio(id_socio),
    FOREIGN KEY (libro_id) REFERENCES libro(libro_id)
);

ALTER TABLE socio
ADD COLUMN estado VARCHAR(10) DEFAULT "activo";

ALTER TABLE socio
RENAME COLUMN phone_number TO telefono_contacto;

ALTER TABLE libro
ADD COLUMN num_paginas INT;

ALTER TABLE socio
MODIFY COLUMN registration_date SMALLINT;

ALTER TABLE libro
ADD COLUMN title VARCHAR(10),
ADD COLUMN literary_genre VARCHAR(10),
ADD COLUMN year_of_publication DATE,
ADD COLUMN number_pages INT,
ADD COLUMN isbn VARCHAR(10);

ALTER TABLE libro
ADD UNIQUE (libro_id);


ALTER TABLE libro
MODIFY COLUMN title VARCHAR(10) FIRST;  

ALTER TABLE socio
ADD CONSTRAINT email_uq UNIQUE (email);

ALTER TABLE autor
DROP COLUMN nationality;

ALTER TABLE libro
MODIFY COLUMN title VARCHAR(10) NOT NULL;

ALTER TABLE libro
DROP FOREIGN KEY libro_ibfk_1;

ALTER TABLE libro
ADD CONSTRAINT libro_autor_fk
FOREIGN KEY (autor_id)
REFERENCES autor(autor_id);

ALTER TABLE libro
ADD CONSTRAINT isbn_uq UNIQUE (isbn);

ALTER TABLE socio
COMMENT = 'Table that stores the main information of  the library members.';

SHOW TABLE STATUS LIKE 'socio';

ALTER TABLE socio
MODIFY COLUMN telefono_contacto INT COMMENT 'Optional phone number of  the member.';

SHOW FULL COLUMNS FROM socio;

ALTER TABLE socio
COMMENT = 'Table of library members that  includes personal data, contact information, and special relationships such as  the reading partner.';

SHOW TABLE STATUS LIKE 'socio';

ALTER TABLE socio
MODIFY COLUMN telefono_contacto INT 
COMMENT 'Updated phone number of the member; optional field for notifications.';

SHOW FULL COLUMNS FROM socio;
