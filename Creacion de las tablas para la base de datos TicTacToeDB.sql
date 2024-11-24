-- Crear la tabla 'Configuraciones'
CREATE TABLE `Configuraciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `color_tablero` varchar(20) DEFAULT NULL,
  `color_simbolos` varchar(20) DEFAULT NULL,
  `numero_rondas` int DEFAULT NULL,
  `tiempo_turno` int DEFAULT '60',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Crear la tabla 'Historial'
CREATE TABLE `Historial` (
  `id` int NOT NULL AUTO_INCREMENT,
  `partida_id` int NOT NULL,
  `detalle` text,
  PRIMARY KEY (`id`),
  KEY `partida_id` (`partida_id`),
  CONSTRAINT `Historial_ibfk_1` FOREIGN KEY (`partida_id`) REFERENCES `Partidas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Crear la tabla 'Jugadores'
CREATE TABLE `Jugadores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Crear la tabla 'Partidas'
CREATE TABLE `Partidas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha_hora` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `configuracion_id` int DEFAULT NULL,
  `ganador_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `configuracion_id` (`configuracion_id`),
  KEY `ganador_id` (`ganador_id`),
  CONSTRAINT `Partidas_ibfk_1` FOREIGN KEY (`configuracion_id`) REFERENCES `Configuraciones` (`id`),
  CONSTRAINT `Partidas_ibfk_2` FOREIGN KEY (`ganador_id`) REFERENCES `Jugadores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Crear la tabla 'Rondas'
CREATE TABLE `Rondas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `partida_id` int NOT NULL,
  `numero_ronda` int DEFAULT NULL,
  `ganador_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `partida_id` (`partida_id`),
  KEY `ganador_id` (`ganador_id`),
  CONSTRAINT `Rondas_ibfk_1` FOREIGN KEY (`partida_id`) REFERENCES `Partidas` (`id`),
  CONSTRAINT `Rondas_ibfk_2` FOREIGN KEY (`ganador_id`) REFERENCES `Jugadores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
