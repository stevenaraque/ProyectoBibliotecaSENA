USE biblioteca_db;
-- Esta vista mostrará el libro con su categoría y editorial
CREATE OR REPLACE VIEW vw_libros_detallados AS
SELECT 
    l.id_libro, 
    l.titulo, 
    c.nombre AS categoria, 
    e.nombre AS editorial,
    l.disponible 
FROM libro l
INNER JOIN categoria c ON l.id_categoria = c.id_categoria
INNER JOIN editorial e ON l.id_editorial = e.id_editorial;

-- Ver todos los libros con sus nombres de categoría y editorial
SELECT * FROM vw_libros_detallados;

-- prueba con filtro
SELECT * FROM vw_libros_detallados 
WHERE categoria = 'Novela';

-- Muestra quién tiene qué libro ahora mismo.
CREATE VIEW vw_prestamos_activos AS
SELECT 
    p.id_prestamo,
    u.nombres AS nombre_usuario,
    u.apellidos AS apellido_usuario,
    l.titulo AS titulo_libro,
    p.fecha_prestamo,
    p.fecha_devolucion_esperada
FROM prestamo p
INNER JOIN usuario u ON p.id_usuario = u.id_usuario
INNER JOIN libro l ON p.id_libro = l.id_libro
WHERE p.id_estado_prestamo = 1; 

--  Ver todos los préstamos que no se han devuelto
SELECT * FROM vw_prestamos_activos;

-- Buscar si un usuario específico tiene libros pendientes
SELECT * FROM vw_prestamos_activos 
WHERE nombre_usuario = 'laura';

-- Suma cuánto debe cada usuario en total.
CREATE VIEW vw_resumen_multas AS
SELECT 
    u.nombres,
    u.apellidos,
    u.email,
    SUM(m.monto) AS total_deuda
FROM multa m
INNER JOIN prestamo p ON m.id_prestamo = p.id_prestamo
INNER JOIN usuario u ON p.id_usuario = u.id_usuario
WHERE m.id_estado_multa = 1 -- En tu script 1 es 'pendiente'
GROUP BY u.id_usuario;
-- Ver cuánto debe cada usuario en total
SELECT * FROM vw_resumen_multas;

-- Ver quiénes deben más de 20,000 pesos
SELECT * FROM vw_resumen_multas 
WHERE total_deuda > 20000;