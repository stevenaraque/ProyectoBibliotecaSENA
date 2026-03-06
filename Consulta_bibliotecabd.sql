CREATE DATABASE biblioteca_db;
 

USE biblioteca_db;

CREATE TABLE tipo_usuario (
  id_tipo_usuario INT          AUTO_INCREMENT PRIMARY KEY,
  nombre          VARCHAR(50)  NOT NULL UNIQUE,
  descripcion     VARCHAR(100)
);

CREATE TABLE estado_usuario (
  id_estado_usuario INT          AUTO_INCREMENT PRIMARY KEY,
  nombre            VARCHAR(50)  NOT NULL UNIQUE,
  descripcion       VARCHAR(100)
);

CREATE TABLE estado_prestamo (
  id_estado_prestamo INT          AUTO_INCREMENT PRIMARY KEY,
  nombre             VARCHAR(50)  NOT NULL UNIQUE,
  descripcion        VARCHAR(100)
);

CREATE TABLE estado_multa (
  id_estado_multa INT          AUTO_INCREMENT PRIMARY KEY,
  nombre          VARCHAR(50)  NOT NULL UNIQUE,
  descripcion     VARCHAR(100)
);

CREATE TABLE editorial (
  id_editorial INT          AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(100) NOT NULL,
  pais         VARCHAR(50),
  sitio_web    VARCHAR(200)
);

CREATE TABLE categoria (
  id_categoria INT         AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(80) NOT NULL,
  descripcion  TEXT
);

CREATE TABLE autor (
  id_autor         INT         AUTO_INCREMENT PRIMARY KEY,
  nombres          VARCHAR(80) NOT NULL,
  apellidos        VARCHAR(80) NOT NULL,
  nacionalidad     VARCHAR(50),
  fecha_nacimiento DATE
);

CREATE TABLE libro (
  id_libro         INT          AUTO_INCREMENT PRIMARY KEY,
  titulo           VARCHAR(200) NOT NULL,
  isbn             VARCHAR(20)  UNIQUE,
  anio_publicacion YEAR,
  num_paginas      INT          CHECK (num_paginas > 0),
  id_editorial     INT,
  id_categoria     INT,
  disponible       BOOLEAN      DEFAULT TRUE,
  FOREIGN KEY (id_editorial) REFERENCES editorial(id_editorial),
  FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE libro_autor (
  id_libro INT NOT NULL,
  id_autor INT NOT NULL,
  PRIMARY KEY (id_libro, id_autor),
  FOREIGN KEY (id_libro) REFERENCES libro(id_libro),
  FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
);

CREATE TABLE usuario (
  id_usuario        INT          AUTO_INCREMENT PRIMARY KEY,
  documento         VARCHAR(20)  NOT NULL UNIQUE,
  nombres           VARCHAR(80)  NOT NULL,
  apellidos         VARCHAR(80)  NOT NULL,
  email             VARCHAR(100) NOT NULL UNIQUE,
  telefono          VARCHAR(20),
  id_tipo_usuario   INT          NOT NULL,
  id_estado_usuario INT          NOT NULL DEFAULT 1,
  FOREIGN KEY (id_tipo_usuario)   REFERENCES tipo_usuario(id_tipo_usuario),
  FOREIGN KEY (id_estado_usuario) REFERENCES estado_usuario(id_estado_usuario)
);

CREATE TABLE prestamo (
  id_prestamo               INT  AUTO_INCREMENT PRIMARY KEY,
  id_libro                  INT  NOT NULL,
  id_usuario                INT  NOT NULL,
  fecha_prestamo            DATE NOT NULL DEFAULT (CURDATE()),
  fecha_devolucion_esperada DATE NOT NULL,
  fecha_devolucion_real     DATE,
  id_estado_prestamo        INT  NOT NULL DEFAULT 1,
  FOREIGN KEY (id_libro)           REFERENCES libro(id_libro),
  FOREIGN KEY (id_usuario)         REFERENCES usuario(id_usuario),
  FOREIGN KEY (id_estado_prestamo) REFERENCES estado_prestamo(id_estado_prestamo)
);

CREATE TABLE multa (
  id_multa         INT           AUTO_INCREMENT PRIMARY KEY,
  id_prestamo      INT           NOT NULL UNIQUE,
  monto            DECIMAL(10,2) NOT NULL CHECK (monto > 0),
  fecha_generacion DATE          NOT NULL DEFAULT (CURDATE()),
  fecha_pago       DATE,
  id_estado_multa  INT           NOT NULL DEFAULT 1,
  FOREIGN KEY (id_prestamo)     REFERENCES prestamo(id_prestamo),
  FOREIGN KEY (id_estado_multa) REFERENCES estado_multa(id_estado_multa)
);