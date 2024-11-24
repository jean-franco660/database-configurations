-- Cambiar al esquema de base de datos donde se creará la tabla y los triggers.
USE TicTacToeDB;

-- Crear la tabla 'Auditoria' para registrar las operaciones realizadas en las tablas relevantes.
-- Esta tabla almacenará la información sobre las inserciones, actualizaciones y eliminaciones de las demás tablas.
CREATE TABLE Auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,        -- Identificador único de auditoría
    tabla_afectada VARCHAR(50),               -- Nombre de la tabla afectada (por ejemplo, 'Jugadores')
    operacion VARCHAR(10),                    -- Tipo de operación (INSERT, UPDATE, DELETE)
    usuario VARCHAR(50),                      -- Usuario que realizó la operación
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora en que se realizó la operación
    detalles TEXT                             -- Detalles específicos de la operación (por ejemplo, cambios de datos)
);

-- Trigger que se ejecuta después de insertar un registro en la tabla 'Jugadores'.
-- Registra la operación de inserción en la tabla 'Auditoria' para la tabla 'Jugadores'.
DELIMITER $$

CREATE TRIGGER AuditoriaJugadoresInsert
AFTER INSERT ON Jugadores
FOR EACH ROW
BEGIN
    -- Insertar un nuevo registro en la tabla Auditoria con los detalles de la inserción.
    INSERT INTO Auditoria (tabla_afectada, operacion, usuario, detalles)
    VALUES ('Jugadores', 'INSERT', USER(),
            CONCAT('Nombre: ', NEW.nombre, ', fecha_registro: ', NEW.fecha_registro));
END$$

DELIMITER ;

-- Trigger que se ejecuta después de insertar un registro en la tabla 'Configuraciones'.
-- Registra la operación de inserción en la tabla 'Auditoria' para la tabla 'Configuraciones'.
DELIMITER $$

CREATE TRIGGER AuditoriaConfiguracionesInsert
AFTER INSERT ON Configuraciones
FOR EACH ROW
BEGIN
    -- Insertar un nuevo registro en la tabla Auditoria con los detalles de la inserción.
    INSERT INTO Auditoria (tabla_afectada, operacion, usuario, detalles)
    VALUES ('Configuraciones', 'INSERT', USER(),
            CONCAT('color_tablero: ', NEW.color_tablero, 
                   ', color_simbolos: ', NEW.color_simbolos, 
                   ', numero_rondas: ', NEW.numero_rondas, 
                   ', tiempo_turno: ', NEW.tiempo_turno));
END$$

DELIMITER ;

-- Trigger que se ejecuta después de insertar un registro en la tabla 'Historial'.
-- Registra la operación de inserción en la tabla 'Auditoria' para la tabla 'Historial'.
DELIMITER $$

CREATE TRIGGER AuditoriaHistorialInsert
AFTER INSERT ON Historial
FOR EACH ROW
BEGIN
    -- Insertar un nuevo registro en la tabla Auditoria con los detalles de la inserción.
    INSERT INTO Auditoria (tabla_afectada, operacion, usuario, detalles)
    VALUES ('Historial', 'INSERT', USER(),
            CONCAT('partida_id: ', NEW.partida_id, ', detalle: ', NEW.detalle));
END$$

DELIMITER ;

-- Trigger que se ejecuta después de insertar un registro en la tabla 'Partidas'.
-- Registra la operación de inserción en la tabla 'Auditoria' para la tabla 'Partidas'.
DELIMITER $$

CREATE TRIGGER AuditoriaPartidasInsert
AFTER INSERT ON Partidas
FOR EACH ROW
BEGIN
    -- Insertar un nuevo registro en la tabla Auditoria con los detalles de la inserción.
    INSERT INTO Auditoria (tabla_afectada, operacion, usuario, detalles)
    VALUES ('Partidas', 'INSERT', USER(),
            CONCAT('fecha_hora: ', NEW.fecha_hora, 
                   ', configuracion_id: ', NEW.configuracion_id, 
                   ', ganador_id: ', NEW.ganador_id));
END$$

DELIMITER ;

-- Trigger que se ejecuta después de insertar un registro en la tabla 'Rondas'.
-- Registra la operación de inserción en la tabla 'Auditoria' para la tabla 'Rondas'.
DELIMITER $$

CREATE TRIGGER AuditoriaRondasInsert
AFTER INSERT ON Rondas
FOR EACH ROW
BEGIN
    -- Insertar un nuevo registro en la tabla Auditoria con los detalles de la inserción.
    INSERT INTO Auditoria (tabla_afectada, operacion, usuario, detalles)
    VALUES ('Rondas', 'INSERT', USER(),
            CONCAT('partida_id: ', NEW.partida_id, 
                   ', numero_ronda: ', NEW.numero_ronda, 
                   ', ganador_id: ', NEW.ganador_id));
END$$

DELIMITER ;

-- Trigger que se ejecuta después de actualizar un registro en la tabla 'Jugadores'.
-- Registra la operación de actualización en la tabla 'Auditoria' para la tabla 'Jugadores'.
DELIMITER $$

CREATE TRIGGER AuditoriaJugadoresUpdate
AFTER UPDATE ON Jugadores
FOR EACH ROW
BEGIN
    -- Insertar un nuevo registro en la tabla Auditoria con los detalles de la actualización.
    INSERT INTO Auditoria (tabla_afectada, operacion, usuario, detalles)
    VALUES ('Jugadores', 'UPDATE', USER(),
            CONCAT('Antes -> Nombre: ', OLD.nombre, ', fecha_registro: ', OLD.fecha_registro, 
                   ' | Ahora -> Nombre: ', NEW.nombre, ', fecha_registro: ', NEW.fecha_registro));
END$$

DELIMITER ;

-- Trigger que se ejecuta después de actualizar un registro en la tabla 'Configuraciones'.
-- Registra la operación de actualización en la tabla 'Auditoria' para la tabla 'Configuraciones'.
DELIMITER $$

CREATE TRIGGER AuditoriaConfiguracionesUpdate
AFTER UPDATE ON Configuraciones
FOR EACH ROW
BEGIN
    -- Insertar un nuevo registro en la tabla Auditoria con los detalles de la actualización.
    INSERT INTO Auditoria (tabla_afectada, operacion, usuario, detalles)
    VALUES ('Configuraciones', 'UPDATE', USER(),
            CONCAT('Antes -> color_tablero: ', OLD.color_tablero, 
                   ', color_simbolos: ', OLD.color_simbolos, 
                   ', numero_rondas: ', OLD.numero_rondas, 
                   ', tiempo_turno: ', OLD.tiempo_turno,
                   ' | Ahora -> color_tablero: ', NEW.color_tablero, 
                   ', color_simbolos: ', NEW.color_simbolos, 
                   ', numero_rondas: ', NEW.numero_rondas, 
                   ', tiempo_turno: ', NEW.tiempo_turno));
END$$

DELIMITER ;

-- Trigger que se ejecuta después de actualizar un registro en la tabla 'Historial'.
-- Registra la operación de actualización en la tabla 'Auditoria' para la tabla 'Historial'.
DELIMITER $$

CREATE TRIGGER AuditoriaHistorialUpdate
AFTER UPDATE ON Historial
FOR EACH ROW
BEGIN
    -- Insertar un nuevo registro en la tabla Auditoria con los detalles de la actualización.
    INSERT INTO Auditoria (tabla_afectada, operacion, usuario, detalles)
    VALUES ('Historial', 'UPDATE', USER(),
            CONCAT('Antes -> partida_id: ', OLD.partida_id, ', detalle: ', OLD.detalle,
                   ' | Ahora -> partida_id: ', NEW.partida_id, ', detalle: ', NEW.detalle));
END$$

DELIMITER ;

-- Trigger que se ejecuta después de actualizar un registro en la tabla 'Partidas'.
-- Registra la operación de actualización en la tabla 'Auditoria' para la tabla 'Partidas'.
DELIMITER $$

CREATE TRIGGER AuditoriaPartidasUpdate
AFTER UPDATE ON Partidas
FOR EACH ROW
BEGIN
    -- Insertar un nuevo registro en la tabla Auditoria con los detalles de la actualización.
    INSERT INTO Auditoria (tabla_afectada, operacion, usuario, detalles)
    VALUES ('Partidas', 'UPDATE', USER(),
            CONCAT('Antes -> fecha_hora: ', OLD.fecha_hora, 
                   ', configuracion_id: ', OLD.configuracion_id, 
                   ', ganador_id: ', OLD.ganador_id, 
                   ' | Ahora -> fecha_hora: ', NEW.fecha_hora, 
                   ', configuracion_id: ', NEW.configuracion_id, 
                   ', ganador_id: ', NEW.ganador_id));
END$$

DELIMITER ;

-- Trigger que se ejecuta después de actualizar un registro en la tabla 'Rondas'.
-- Registra la operación de actualización en la tabla 'Auditoria' para la tabla 'Rondas'.
DELIMITER $$

CREATE TRIGGER AuditoriaRondasUpdate
AFTER UPDATE ON Rondas
FOR EACH ROW
BEGIN
    -- Insertar un nuevo registro en la tabla Auditoria con los detalles de la actualización.
    INSERT INTO Auditoria (tabla_afectada, operacion, usuario, detalles)
    VALUES ('Rondas', 'UPDATE', USER(),
            CONCAT('Antes -> partida_id: ', OLD.partida_id, 
                   ', numero_ronda: ', OLD.numero_ronda, 
                   ', ganador_id: ', OLD.ganador_id, 
                   ' | Ahora -> partida_id: ', NEW.partida_id, 
                   ', numero_ronda: ', NEW.numero_ronda, 
                   ', ganador_id: ', NEW.ganador_id));
END$$

DELIMITER ;

-- Trigger que se ejecuta después de eliminar un registro en la tabla 'Jugadores'.
-- Registra la operación de eliminación en la tabla 'Auditoria' para la tabla 'Jugadores'.
DELIMITER $$

CREATE TRIGGER AuditoriaJugadoresDelete
AFTER DELETE ON Jugadores
FOR EACH ROW
BEGIN
    -- Insertar un nuevo registro en la tabla Auditoria con los detalles de la eliminación.
    INSERT INTO Auditoria (tabla_afectada, operacion, usuario, detalles)
    VALUES ('Jugadores', 'DELETE', USER(),
            CONCAT('Nombre: ', OLD.nombre, ', fecha_registro: ', OLD.fecha_registro));
END$$

DELIMITER ;

-- Trigger que se ejecuta después de eliminar un registro en la tabla 'Configuraciones'.
-- Registra la operación de eliminación en la tabla 'Auditoria' para la tabla 'Configuraciones'.
DELIMITER $$

CREATE TRIGGER AuditoriaConfiguracionesDelete
AFTER DELETE ON Configuraciones
FOR EACH ROW
BEGIN
    -- Insertar un nuevo registro en la tabla Auditoria con los detalles de la eliminación.
    INSERT INTO Auditoria (tabla_afectada, operacion, usuario, detalles)
    VALUES ('Configuraciones', 'DELETE', USER(),
            CONCAT('color_tablero: ', OLD.color_tablero, 
                   ', color_simbolos: ', OLD.color_simbolos, 
                   ', numero_rondas: ', OLD.numero_rondas, 
                   ', tiempo_turno: ', OLD.tiempo_turno));
END$$

DELIMITER ;

-- Trigger que se ejecuta después de eliminar un registro en la tabla 'Historial'.
-- Registra la operación de eliminación en la tabla 'Auditoria' para la tabla 'Historial'.
DELIMITER $$

CREATE TRIGGER AuditoriaHistorialDelete
AFTER DELETE ON Historial
FOR EACH ROW
BEGIN
    -- Insertar un nuevo registro en la tabla Auditoria con los detalles de la eliminación.
    INSERT INTO Auditoria (tabla_afectada, operacion, usuario, detalles)
    VALUES ('Historial', 'DELETE', USER(),
            CONCAT('partida_id: ', OLD.partida_id, ', detalle: ', OLD.detalle));
END$$

DELIMITER ;

-- Trigger que se ejecuta después de eliminar un registro en la tabla 'Partidas'.
-- Registra la operación de eliminación en la tabla 'Auditoria' para la tabla 'Partidas'.
DELIMITER $$

CREATE TRIGGER AuditoriaPartidasDelete
AFTER DELETE ON Partidas
FOR EACH ROW
BEGIN
    -- Insertar un nuevo registro en la tabla Auditoria con los detalles de la eliminación.
    INSERT INTO Auditoria (tabla_afectada, operacion, usuario, detalles)
    VALUES ('Partidas', 'DELETE', USER(),
            CONCAT('fecha_hora: ', OLD.fecha_hora, 
                   ', configuracion_id: ', OLD.configuracion_id, 
                   ', ganador_id: ', OLD.ganador_id));
END$$

DELIMITER ;

-- Trigger que se ejecuta después de eliminar un registro en la tabla 'Rondas'.
-- Registra la operación de eliminación en la tabla 'Auditoria' para la tabla 'Rondas'.
DELIMITER $$

CREATE TRIGGER AuditoriaRondasDelete
AFTER DELETE ON Rondas
FOR EACH ROW
BEGIN
    -- Insertar un nuevo registro en la tabla Auditoria con los detalles de la eliminación.
    INSERT INTO Auditoria (tabla_afectada, operacion, usuario, detalles)
    VALUES ('Rondas', 'DELETE', USER(),
            CONCAT('partida_id: ', OLD.partida_id, 
                   ', numero_ronda: ', OLD.numero_ronda, 
                   ', ganador_id: ', OLD.ganador_id));
END$$

DELIMITER ;
