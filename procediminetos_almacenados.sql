USE biblioteca_db;
DELIMITER //

-- registrar prestamo
CREATE PROCEDURE sp_registrar_prestamo(
    IN p_id_libro INT,
    IN p_id_usuario INT,
    IN p_dias INT
)
BEGIN
    DECLARE v_disponible BOOLEAN;

    SELECT disponible INTO v_disponible
    FROM libro
    WHERE id_libro = p_id_libro;

    IF v_disponible = 1 THEN
        INSERT INTO prestamo(id_libro, id_usuario, fecha_prestamo, fecha_devolucion_esperada, id_estado_prestamo)
        VALUES(p_id_libro, p_id_usuario, CURDATE(), DATE_ADD(CURDATE(), INTERVAL p_dias DAY), 1);

        UPDATE libro SET disponible = 0
        WHERE id_libro = p_id_libro;

        SELECT 'Prestamo registrado exitosamente' AS mensaje;
    ELSE
        SELECT 'El libro no esta disponible' AS mensaje;
    END IF;
END //

DELIMITER ;

CALL sp_registrar_prestamo(3, 5, 10);
-- calcular multa

DELIMITER //

CREATE PROCEDURE sp_calcular_multa(
    IN p_id_prestamo INT
)
BEGIN
    DECLARE v_fecha_esperada DATE;
    DECLARE v_dias_retraso INT;
    DECLARE v_monto DECIMAL(10,2);

    SELECT fecha_devolucion_esperada INTO v_fecha_esperada
    FROM prestamo
    WHERE id_prestamo = p_id_prestamo;

    SET v_dias_retraso = DATEDIFF(CURDATE(), v_fecha_esperada);

    IF v_dias_retraso > 0 THEN
        SET v_monto = v_dias_retraso * 1000;

        INSERT INTO multa(id_prestamo, monto, fecha_generacion, id_estado_multa)
        VALUES(p_id_prestamo, v_monto, CURDATE(), 1);

        UPDATE prestamo SET id_estado_prestamo = 3
        WHERE id_prestamo = p_id_prestamo;

        SELECT v_dias_retraso AS dias_retraso, v_monto AS monto_multa;
    ELSE
        SELECT 'El prestamo no tiene retraso' AS mensaje;
    END IF;
END //

DELIMITER ;

CALL sp_calcular_multa(25);

-- historial de prestamo

DELIMITER //

CREATE PROCEDURE sp_historial_usuario(
    IN p_id_usuario INT
)
BEGIN
    SELECT libro.titulo,
           prestamo.fecha_prestamo,
           prestamo.fecha_devolucion_esperada,
           prestamo.fecha_devolucion_real,
           estado_prestamo.nombre AS estado
    FROM prestamo
    INNER JOIN libro ON prestamo.id_libro = libro.id_libro
    INNER JOIN estado_prestamo ON prestamo.id_estado_prestamo = estado_prestamo.id_estado_prestamo
    WHERE prestamo.id_usuario = p_id_usuario
    ORDER BY prestamo.fecha_prestamo DESC;
END //

DELIMITER ;

CALL sp_historial_usuario(2);