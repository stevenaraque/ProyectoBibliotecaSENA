USE biblioteca_db;

INSERT INTO tipo_usuario (nombre, descripcion) VALUES
('estudiante',     'Estudiante universitario'),
('docente',        'Profesor de la universidad'),
('administrativo', 'Personal administrativo');

INSERT INTO estado_usuario (nombre, descripcion) VALUES
('activo',   'Usuario habilitado para préstamos'),
('inactivo', 'Usuario sin acceso al sistema');

INSERT INTO estado_prestamo (nombre, descripcion) VALUES
('activo',   'Préstamo en curso'),
('devuelto', 'Libro devuelto a tiempo'),
('vencido',  'Préstamo no devuelto a tiempo');

INSERT INTO estado_multa (nombre, descripcion) VALUES
('pendiente', 'Multa sin pagar'),
('pagada',    'Multa cancelada');

INSERT INTO editorial (nombre, pais, sitio_web) VALUES
('Alfaguara',        'España',    'www.alfaguara.com'),
('Planeta',          'España',    'www.planeta.es'),
('Norma',            'Colombia',  'www.norma.com'),
('Panamericana',     'Colombia',  'www.panamericana.com.co'),
('McGraw-Hill',      'USA',       'www.mcgrawhill.com'),
('Pearson',          'USA',       'www.pearson.com'),
('Santillana',       'España',    'www.santillana.com'),
('Anagrama',         'España',    'www.anagrama-ed.es'),
('Fondo de Cultura', 'México',    'www.fondodeculturaeconomica.com'),
('Siglo XXI',        'México',    'www.sigloxxieditores.com');

INSERT INTO categoria (nombre, descripcion) VALUES
('Novela',           'Ficción narrativa larga'),
('Ciencia',          'Libros de ciencias naturales y exactas'),
('Historia',         'Libros de eventos históricos'),
('Tecnología',       'Libros de informática y sistemas'),
('Filosofía',        'Libros de pensamiento y filosofía'),
('Derecho',          'Libros jurídicos y legales'),
('Economía',         'Libros de economía y finanzas'),
('Arte',             'Libros de arte y cultura'),
('Matemáticas',      'Libros de matemáticas y estadística'),
('Ingeniería',       'Libros técnicos de ingeniería');

INSERT INTO autor (nombres, apellidos, nacionalidad, fecha_nacimiento) VALUES
('Gabriel',   'García Márquez', 'Colombiana',  '1927-03-06'),
('Jorge Luis', 'Borges',        'Argentina',   '1899-08-24'),
('Isabel',    'Allende',        'Chilena',     '1942-08-02'),
('Mario',     'Vargas Llosa',   'Peruana',     '1936-03-28'),
('Tomás',     'González',       'Colombiana',  '1950-06-15'),
('Stephen',   'Hawking',        'Británica',   '1942-01-08'),
('Carl',      'Sagan',          'Estadounidense','1934-11-09'),
('Yuval',     'Harari',         'Israelí',     '1976-02-24'),
('Robert',    'Martin',         'Estadounidense','1952-12-05'),
('Andrew',    'Tanenbaum',      'Estadounidense','1944-03-16'),
('Edgar',     'Codd',           'Británica',   '1923-08-19'),
('Donald',    'Knuth',          'Estadounidense','1938-01-10'),
('Platón',    '',               'Griega',      '0428-01-01'),
('Friedrich', 'Nietzsche',      'Alemana',     '1844-10-15'),
('Immanuel',  'Kant',           'Alemana',     '1724-04-22');

ALTER TABLE libro 
MODIFY COLUMN anio_publicacion SMALLINT;
INSERT INTO libro (titulo, isbn, anio_publicacion, num_paginas, id_editorial, id_categoria, disponible) VALUES
('Cien años de soledad',        '978-0307474728', 1967, 471,  1,  1,  TRUE),
('El amor en los tiempos del cólera', '978-0307389732', 1985, 348, 1, 1, TRUE),
('Ficciones',                   '978-8420633138', 1944, 224,  8,  1,  TRUE),
('El aleph',                    '978-8420674414', 1949, 208,  8,  1,  TRUE),
('La casa de los espíritus',    '978-8401352836', 1982, 433,  2,  1,  TRUE),
('La ciudad y los perros',      '978-8420634050', 1963, 384,  1,  1,  TRUE),
('Breve historia del tiempo',   '978-0553380163', 1988, 212,  5,  2,  TRUE),
('Cosmos',                      '978-0345539434', 1980, 365,  5,  2,  TRUE),
('Sapiens',                     '978-0062316097', 2011, 443,  6,  3,  TRUE),
('Código limpio',               '978-0132350884', 2008, 431,  5,  4,  TRUE),
('Redes de computadoras',       '978-0132126953', 2010, 960,  6,  4,  TRUE),
('El modelo relacional',        '978-0201141924', 1990, 538,  6,  4,  TRUE),
('El arte de la programación',  '978-0201485417', 1968, 650,  5,  4,  TRUE),
('La república',         '978-8420678726', NULL, 368, 7, 5, TRUE),
('Así habló Zaratustra',        '978-8420674780', 1883, 352,  7,  5,  TRUE),
('Crítica de la razón pura', '978-8420674803', NULL, 694, 7, 5, TRUE),
('Matemáticas discretas',       '978-9701062937', 2005, 615,  6,  9,  TRUE),
('Cálculo diferencial',         '978-9701062944', 2007, 900,  6,  9,  TRUE),
('Fundamentos de economía',     '978-9701062951', 2010, 480,  3,  7,  TRUE),
('Derecho constitucional',      '978-9701062968', 2015, 520,  4,  6,  TRUE);

INSERT INTO libro_autor (id_libro, id_autor) VALUES
(1,  1), (2,  1), (3,  2), (4,  2),
(5,  3), (6,  4), (7,  6), (8,  7),
(9,  8), (10, 9), (11, 10),(12, 11),
(13, 12),(14, 13),(15, 14),(16, 15),
(17, 12),(18, 12),(19, 8), (20, 4);

INSERT INTO usuario (documento, nombres, apellidos, email, telefono, id_tipo_usuario, id_estado_usuario) VALUES
('1000001', 'Carlos',    'Rodríguez',  'carlos.rodriguez@urb.edu.co',  '3101234567', 1, 1),
('1000002', 'María',     'González',   'maria.gonzalez@urb.edu.co',    '3112345678', 1, 1),
('1000003', 'Andrés',    'Martínez',   'andres.martinez@urb.edu.co',   '3123456789', 1, 1),
('1000004', 'Laura',     'Pérez',      'laura.perez@urb.edu.co',       '3134567890', 1, 1),
('1000005', 'Juliana',   'López',      'juliana.lopez@urb.edu.co',     '3145678901', 1, 1),
('1000006', 'Santiago',  'Ramírez',    'santiago.ramirez@urb.edu.co',  '3156789012', 1, 1),
('1000007', 'Valentina', 'Torres',     'valentina.torres@urb.edu.co',  '3167890123', 1, 1),
('1000008', 'David',     'Vargas',     'david.vargas@urb.edu.co',      '3178901234', 1, 1),
('1000009', 'Daniela',   'Castro',     'daniela.castro@urb.edu.co',    '3189012345', 1, 1),
('1000010', 'Felipe',    'Moreno',     'felipe.moreno@urb.edu.co',     '3190123456', 1, 1),
('2000001', 'Jorge',     'Hernández',  'jorge.hernandez@urb.edu.co',   '3201234567', 2, 1),
('2000002', 'Patricia',  'Díaz',       'patricia.diaz@urb.edu.co',     '3212345678', 2, 1),
('2000003', 'Ricardo',   'Muñoz',      'ricardo.munoz@urb.edu.co',     '3223456789', 2, 1),
('2000004', 'Claudia',   'Jiménez',    'claudia.jimenez@urb.edu.co',   '3234567890', 2, 1),
('2000005', 'Gustavo',   'Ruiz',       'gustavo.ruiz@urb.edu.co',      '3245678901', 2, 1),
('3000001', 'Mónica',    'Suárez',     'monica.suarez@urb.edu.co',     '3256789012', 3, 1),
('3000002', 'Hernando',  'Medina',     'hernando.medina@urb.edu.co',   '3267890123', 3, 1),
('3000003', 'Adriana',   'Rojas',      'adriana.rojas@urb.edu.co',     '3278901234', 3, 1),
('3000004', 'Camilo',    'Ortiz',      'camilo.ortiz@urb.edu.co',      '3289012345', 3, 1),
('3000005', 'Silvia',    'Reyes',      'silvia.reyes@urb.edu.co',      '3290123456', 3, 1);

INSERT INTO prestamo (id_libro, id_usuario, fecha_prestamo, fecha_devolucion_esperada, fecha_devolucion_real, id_estado_prestamo) VALUES
(1,  1,  '2025-01-05', '2025-01-19', '2025-01-18', 2),
(2,  2,  '2025-01-10', '2025-01-24', '2025-01-25', 3),
(3,  3,  '2025-01-15', '2025-01-29', '2025-01-29', 2),
(4,  4,  '2025-01-20', '2025-02-03', NULL,          1),
(5,  5,  '2025-01-22', '2025-02-05', NULL,          1),
(6,  6,  '2025-02-01', '2025-02-15', '2025-02-20', 3),
(7,  7,  '2025-02-05', '2025-02-19', '2025-02-18', 2),
(8,  8,  '2025-02-10', '2025-02-24', NULL,          1),
(9,  9,  '2025-02-12', '2025-02-26', '2025-03-01', 3),
(10, 10, '2025-02-15', '2025-03-01', '2025-03-01', 2),
(11, 11, '2025-02-20', '2025-03-06', NULL,          1),
(12, 12, '2025-02-22', '2025-03-08', '2025-03-05', 2),
(13, 13, '2025-03-01', '2025-03-15', NULL,          1),
(14, 14, '2025-03-05', '2025-03-19', '2025-03-25', 3),
(15, 15, '2025-03-10', '2025-03-24', NULL,          1),
(16, 16, '2025-03-12', '2025-03-26', '2025-03-26', 2),
(17, 17, '2025-03-15', '2025-03-29', NULL,          1),
(18, 18, '2025-03-18', '2025-04-01', NULL,          1),
(19, 19, '2025-03-20', '2025-04-03', '2025-04-10', 3),
(20, 20, '2025-03-22', '2025-04-05', NULL,          1);

INSERT INTO multa (id_prestamo, monto, fecha_generacion, fecha_pago, id_estado_multa) VALUES
(2,  15000, '2025-01-26', NULL,         1),
(6,  25000, '2025-02-21', '2025-02-25', 2),
(9,  10000, '2025-03-02', NULL,         1),
(14, 30000, '2025-03-26', NULL,         1),
(19, 35000, '2025-04-11', '2025-04-15', 2);