-- creo una tabla de auditoria para ver los prestamos 
CREATE TABLE auditoria_prestamo (
  id_auditoria  INT AUTO_INCREMENT PRIMARY KEY,
  id_prestamo   INT,
  id_usuario    INT,
  id_libro      INT,
  fecha_accion  DATETIME,
  accion        VARCHAR(50)
);
-- el trigger de la auditoria
DELIMITER //
CREATE TRIGGER tr_auditoria_prestamo
AFTER INSERT ON prestamo
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_prestamo(id_prestamo, id_usuario, id_libro, fecha_accion, accion)
    VALUES(NEW.id_prestamo, NEW.id_usuario, NEW.id_libro, NOW(), 'PRESTAMO REGISTRADO');
END //
DELIMITER ;
CALL sp_registrar_prestamo(5, 4, 10);
SELECT * FROM auditoria_prestamo;

-- el triguer para registrar una fecha de pago de multa
DELIMITER //
CREATE TRIGGER tr_pago_multa
AFTER UPDATE ON multa
FOR EACH ROW
BEGIN
    IF NEW.id_estado_multa = 2 AND OLD.id_estado_multa = 1 THEN
        UPDATE multa SET fecha_pago = CURDATE()
        WHERE id_multa = NEW.id_multa;
    END IF;
END //
DELIMITER ;

UPDATE multa SET id_estado_multa = 2 WHERE id_multa = 2;
SELECT * FROM multa WHERE id_multa = 2;