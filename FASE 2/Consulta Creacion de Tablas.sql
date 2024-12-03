CREATE DATABASE apt_db;

USE apt_db;

-- CREACIÓN DE TABLA USUARIOS
CREATE TABLE usuarios (
    id_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(120) NOT NULL UNIQUE,
    rol ENUM('ADMIN', 'USUARIO') NOT NULL DEFAULT 'USUARIO',
    password_hash VARCHAR(128) NOT NULL
);

-- CREACIÓN DE TABLA SUCURSALES
CREATE TABLE sucursales (
    id_sucursal INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_sucursal VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(200) NOT NULL
);

-- CREACIÓN DE TABLA HERRAMIENTAS
CREATE TABLE herramientas (
    id_herramienta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    estado ENUM('DISPONIBLE', 'EN_USO', 'MANTENIMIENTO') NOT NULL DEFAULT 'DISPONIBLE',
    cantidad_disponible INT NOT NULL,
    sucursal_id INT NOT NULL,
    FOREIGN KEY (sucursal_id) REFERENCES sucursales(id_sucursal) ON DELETE CASCADE
);

-- CREACIÓN DE TABLA REPORTE_ARRENDOS
CREATE TABLE reporte_arriendos (
    id_arriendo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_herramienta INT NOT NULL,
    fecha_inicio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_fin DATETIME,
    estado_arriendo ENUM('EN_PROCESO', 'FINALIZADO') NOT NULL DEFAULT 'EN_PROCESO',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_herramienta) REFERENCES herramientas(id_herramienta) ON DELETE CASCADE
);

-- CREACIÓN DE TABLA TRANSACCIONES
CREATE TABLE transacciones (
    id_transaccion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_herramienta INT NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cantidad INT NOT NULL DEFAULT 1,
    sucursal_origen INT,
    sucursal_destino INT,
    estado ENUM('DISPONIBLE', 'EN_USO', 'MANTENIMIENTO') NOT NULL,
    FOREIGN KEY (id_herramienta) REFERENCES herramientas(id_herramienta),
    FOREIGN KEY (sucursal_origen) REFERENCES sucursales(id_sucursal),
    FOREIGN KEY (sucursal_destino) REFERENCES sucursales(id_sucursal)
);

-- CREACIÓN DE TABLA HERRAMIENTA_SUCURSAL (Relación Muchos a Muchos)
CREATE TABLE herramienta_sucursal (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    herramienta_id INT NOT NULL,
    sucursal_id INT NOT NULL,
    cantidad_disponible INT NOT NULL,
    FOREIGN KEY (herramienta_id) REFERENCES herramientas(id_herramienta) ON DELETE CASCADE,
    FOREIGN KEY (sucursal_id) REFERENCES sucursales(id_sucursal) ON DELETE CASCADE
);
