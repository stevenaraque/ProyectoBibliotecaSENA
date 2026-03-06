USE biblioteca_db;
-- Listar todos los libros con su editorial
SELECT libro.titulo, editorial.nombre
FROM libro
INNER JOIN editorial ON libro.id_editorial = editorial.id_editorial;

-- listar libros con sus autores
SELECT libro.titulo , autor.nombres, autor.apellidos
FROM libro 
INNER JOIN libro_autor ON libro.id_libro=libro_autor.id_libro
INNER JOIN autor ON libro_autor.id_autor=autor.id_autor;

-- contar libros por categoria

SELECT categoria.nombre, COUNT(libro.id_libro) AS total_libros
FROM categoria
INNER JOIN libro ON categoria.id_categoria = libro.id_categoria
GROUP BY categoria.nombre;

-- Listar prestamos vencidos 

SELECT prestamo.id_prestamo, usuario.nombres, usuario.apellidos, libro.titulo,prestamo.fecha_devolucion_esperada
FROM prestamo
INNER JOIN usuario ON prestamo.id_usuario= usuario.id_usuario
INNER JOIN libro ON prestamo.id_libro = libro.id_libro
WHERE prestamo.id_estado_prestamo = 3;

-- calcular total de multas por usuario 
SELECT usuario.nombres, usuario.apellidos,
SUM(multa.monto) AS total_multas
FROM multa
INNER JOIN prestamo ON multa.id_prestamo = prestamo.id_prestamo
INNER JOIN  USUARIO ON prestamo.id_usuario = usuario.id_usuario
GROUP BY usuario.id_usuario, usuario.nombres, usuario.apellidos;

-- buscar libros por un titulo o autor
SELECT libro.titulo, autor.nombres, autor.apellidos
FROM libro
INNER JOIN libro_autor ON libro.id_libro = libro_autor.id_autor
INNER JOIN autor ON libro_autor.id_autor = autor.id_autor
WHERE libro.titulo LIKE '%mar%'
OR autor.apellidos LIKE '%mar%';

-- listar usuarios con prestamos activos

SELECT usuario.nombres, usuario.apellidos, usuario.email
FROM usuario 
WHERE EXISTS(
SELECT 'resultado'
FROM prestamo
WHERE prestamo.id_usuario = usuario.id_usuario
AND prestamo.id_estado_prestamo= 1 
);

-- top 10 libros mas prestados 
SELECT libro.titulo, COUNT(prestamo.id_prestamo) as veces_prestado
FROM libro
INNER JOIN prestamo ON libro.id_libro = prestamo.id_libro 
GROUP BY libro.id_libro , libro.titulo
ORDER BY veces_prestado DESC LIMIT 10;

-- Libros publicados en un rango de años
SELECT titulo, anio_publicacion 
FROM libro 
WHERE anio_publicacion BETWEEN 2000 AND 2025
ORDER BY anio_publicacion DESC;
-- Usuarios que nunca han realizado un préstamo
SELECT nombres, apellidos 
FROM usuario 
WHERE id_usuario NOT IN (SELECT id_usuario FROM prestamo);

-- Promedio de páginas de libros por categoría
SELECT c.nombre AS categoria, AVG(l.num_paginas) AS promedio_paginas
FROM categoria c
JOIN libro l ON c.id_categoria = l.id_categoria
GROUP BY c.nombre;
-- Autores y cuántos libros tienen registrados
SELECT a.nombres, a.apellidos, COUNT(la.id_libro) AS total_libros
FROM autor a
JOIN libro_autor la ON a.id_autor = la.id_autor
GROUP BY a.id_autor
HAVING total_libros > 1;
-- Prestamos realizados en el último mes
SELECT * FROM prestamo 
WHERE fecha_prestamo >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- Editorial con el libro más antiguo
SELECT e.nombre AS editorial, l.titulo, l.anio_publicacion
FROM editorial e
JOIN libro l ON e.id_editorial = l.id_editorial
WHERE l.anio_publicacion = (SELECT MIN(anio_publicacion) FROM libro);
-- Cantidad de libros disponibles por estado
SELECT disponible, COUNT(*) AS cantidad 
FROM libro 
GROUP BY disponible;