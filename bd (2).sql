-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-05-2025 a las 13:32:13
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_categoria` (IN `p_id_categoria` INT, IN `p_nombre` VARCHAR(50))   BEGIN
  UPDATE categorias
  SET nombre = p_nombre
  WHERE id_categoria = p_id_categoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_cliente` (IN `p_id_cliente` INT, IN `p_nombres` VARCHAR(50), IN `p_apellidos` VARCHAR(50), IN `p_direccion` VARCHAR(50), IN `p_telefono` VARCHAR(50))   BEGIN
    UPDATE clientes
    SET nombres = p_nombres,
        apellidos = p_apellidos,
        direccion = p_direccion,
        telefono = p_telefono
    WHERE id_cliente = p_id_cliente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_producto` (IN `p_id_producto` INT, IN `p_nombre` VARCHAR(100), IN `p_descripcion` VARCHAR(255), IN `p_precio` DECIMAL(10,2), IN `p_stock` INT, IN `p_id_categoria` INT, IN `p_id_proveedor` INT)   BEGIN
    UPDATE productos 
    SET nombre = p_nombre,
        descripcion = p_descripcion,
        precio = p_precio,
        stock = p_stock,
        id_categoria = p_id_categoria,
        id_proveedor = p_id_proveedor
    WHERE id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_proveedor` (IN `p_id_proveedor` INT, IN `p_razonsocial` VARCHAR(50), IN `p_direccion` VARCHAR(50), IN `p_telefono` VARCHAR(50))   BEGIN
  UPDATE proveedores
  SET razonsocial = p_razonsocial,
      direccion = p_direccion,
      telefono = p_telefono
  WHERE id_proveedor = p_id_proveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_venta` (IN `p_id_venta` INT)   BEGIN
  SELECT dv.id_detventa, p.descripcion AS producto, dv.cantidad, p.precio, (dv.cantidad * p.precio) AS subtotal
  FROM detalle_ventas dv
  INNER JOIN productos p ON dv.id_producto = p.id_producto
  WHERE dv.id_venta = p_id_venta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_categoria` (IN `p_id` INT, IN `p_descripcion` VARCHAR(255))   BEGIN
  UPDATE categorias
  SET descripcion = p_descripcion
  WHERE id_categoria = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_categoria` (IN `p_id_categoria` INT)   BEGIN
  DELETE FROM categorias WHERE id_categoria = p_id_categoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_cliente` (IN `p_id_cliente` INT)   BEGIN
    DELETE FROM clientes
    WHERE id_cliente = p_id_cliente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_producto` (IN `p_id_producto` INT)   BEGIN
  DELETE FROM productos WHERE id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_proveedor` (IN `p_id_proveedor` INT)   BEGIN
  DELETE FROM proveedores
  WHERE id_proveedor = p_id_proveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_venta` (IN `p_id_venta` INT)   BEGIN
  DELETE FROM ventas WHERE id_venta = p_id_venta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_categoria` (IN `p_nombre` VARCHAR(50))   BEGIN
  INSERT INTO categorias (nombre) VALUES (p_nombre);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_clientes` (IN `p_nombres` VARCHAR(50), IN `p_apellidos` VARCHAR(50), IN `p_direccion` VARCHAR(50), IN `p_telefono` VARCHAR(50))   BEGIN
    INSERT INTO clientes (nombres, apellidos, direccion, telefono)
    VALUES (p_nombres, p_apellidos, p_direccion, p_telefono);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_detalle_venta` (IN `p_id_venta` INT, IN `p_id_producto` INT, IN `p_cantidad` INT)   BEGIN
    INSERT INTO detalle_ventas (id_venta, id_producto, cantidad)
    VALUES (p_id_venta, p_id_producto, p_cantidad);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_productos` (IN `p_nombre` VARCHAR(100), IN `p_descripcion` VARCHAR(255), IN `p_precio` DECIMAL(10,2), IN `p_stock` INT, IN `p_id_categoria` INT, IN `p_id_proveedor` INT)   BEGIN
    INSERT INTO productos (nombre, descripcion, precio, stock, id_categoria, id_proveedor)
    VALUES (p_nombre, p_descripcion, p_precio, p_stock, p_id_categoria, p_id_proveedor);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_proveedor` (IN `p_razonsocial` VARCHAR(50), IN `p_direccion` VARCHAR(50), IN `p_telefono` VARCHAR(50))   BEGIN
  INSERT INTO proveedores (razonsocial, direccion, telefono)
  VALUES (p_razonsocial, p_direccion, p_telefono);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_venta` (IN `p_fecha` DATETIME, IN `p_id_cliente` INT, IN `p_total` DECIMAL(10,2))   BEGIN
    INSERT INTO ventas(fecha, id_cliente, total) VALUES (p_fecha, p_id_cliente, p_total);
    SELECT LAST_INSERT_ID() AS id_venta_nueva;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_categorias` ()   BEGIN
  SELECT id_categoria, descripcion FROM categorias ORDER BY id_categoria DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_clientes` ()   BEGIN
    SELECT * FROM clientes ORDER BY id_cliente DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_detalle_venta` (IN `p_id_venta` INT)   BEGIN
  SELECT dv.id_detventa, dv.id_producto, p.descripcion, dv.cantidad
  FROM detalle_ventas dv
  JOIN productos p ON dv.id_producto = p.id_producto
  WHERE dv.id_venta = p_id_venta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_productos` ()   BEGIN
  SELECT 
    p.id_producto,
    p.nombre, -- 👈 AGREGA ESTA LÍNEA
    p.descripcion,
    p.precio,
    p.stock,
    p.id_categoria,
    c.descripcion AS nombre_categoria,
    p.id_proveedor,
    pr.razonsocial AS nombre_proveedor
  FROM productos p
  JOIN categorias c ON p.id_categoria = c.id_categoria
  JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_proveedores` ()   BEGIN
  SELECT * FROM proveedores ORDER BY id_proveedor DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_ventas` ()   BEGIN
  SELECT v.id_venta, v.fecha, v.id_cliente, CONCAT(c.nombres, ' ', c.apellidos) AS nombre_cliente
  FROM ventas v
  JOIN clientes c ON v.id_cliente = c.id_cliente
  ORDER BY v.fecha DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_detalle_venta` (IN `p_id_venta` INT)   BEGIN
    SELECT dv.cantidad, p.nombre, p.precio
    FROM detalle_ventas dv
    INNER JOIN productos p ON dv.id_producto = p.id_producto
    WHERE dv.id_venta = p_id_venta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_id_cliente` (IN `p_nombres` VARCHAR(50), IN `p_apellidos` VARCHAR(50))   BEGIN
  SELECT id_cliente
  FROM clientes
  WHERE nombres = p_nombres AND apellidos = p_apellidos
  LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_precio_producto` (IN `p_id_producto` INT)   BEGIN
    SELECT precio FROM productos WHERE id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_proveedor` (IN `p_id_proveedor` INT)   BEGIN
  SELECT * FROM proveedores
  WHERE id_proveedor = p_id_proveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_venta` (IN `p_id_venta` INT)   BEGIN
    SELECT 
        v.id_venta, 
        v.fecha, 
        v.id_cliente, 
        CONCAT(c.nombres, ' ', c.apellidos) AS nombre_cliente
    FROM ventas v
    INNER JOIN clientes c ON v.id_cliente = c.id_cliente
    WHERE v.id_venta = p_id_venta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_categoria` (IN `_descripcion` VARCHAR(100))   BEGIN
    IF LENGTH(TRIM(_descripcion)) = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La descripción es obligatoria';
    ELSE
        INSERT INTO categorias (descripcion) VALUES (_descripcion);
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reporte_ventas` ()   BEGIN
  SELECT v.id_venta, v.fecha, c.nombre AS cliente
  FROM ventas v
  INNER JOIN clientes c ON v.id_cliente = c.id_cliente
  ORDER BY v.fecha DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reporte_ventas_completo` ()   BEGIN
  SELECT 
    v.id_venta,
    v.fecha,
    c.nombre AS cliente,
    p.descripcion AS producto,
    dv.cantidad,
    p.precio,
    (dv.cantidad * p.precio) AS subtotal
  FROM ventas v
  INNER JOIN clientes c ON v.id_cliente = c.id_cliente
  INNER JOIN detalle_ventas dv ON dv.id_venta = v.id_venta
  INNER JOIN productos p ON dv.id_producto = p.id_producto
  ORDER BY v.id_venta, dv.id_detventa;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `descripcion`) VALUES
(6, 'Electrónica'),
(7, 'Ropa y moda'),
(8, 'Alimentos y bebidas'),
(9, 'Hogar y cocina'),
(10, 'Salud y belleza'),
(11, 'Deportes y aire libre'),
(12, 'Juguetes y bebés'),
(13, 'Automotriz'),
(14, 'Libros y papelería'),
(15, 'Tecnología y software');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nombres` varchar(50) NOT NULL,
  `apellidos` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nombres`, `apellidos`, `direccion`, `telefono`) VALUES
(13, 'Alex Oliver', 'Bautista Ferruga', 'zarumilla Barr_los_olivos lote_34 Perú ', '977665565'),
(14, 'Jhampier Jhordch', 'Ortiz Vento', 'Río Negro, Junín, Perú', '968351575'),
(17, 'Luis Alberto', 'Utos Ceras', 'Río Negro, SENATI, Junín, Perú', '977443345');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ventas`
--

CREATE TABLE `detalle_ventas` (
  `id_detventa` int(11) NOT NULL,
  `id_venta` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `detalle_ventas`
--

INSERT INTO `detalle_ventas` (`id_detventa`, `id_venta`, `id_producto`, `cantidad`) VALUES
(23, 23, 6, 1),
(24, 24, 9, 1),
(25, 25, 8, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `precio` decimal(18,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_proveedor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_proveedor`) VALUES
(6, 'WH-1000XM6-B', 'Los WH-1000XM6 tienen noise cancelling avanzado con el procesador HD QN3, sonido premium afinado por ingenieros expertos, y llamadas claras gracias a seis micrófonos con formación de haces y tecnología de reducción de ruido.', 1699.00, 34453, 15, 26),
(7, 'Parlante Bluetooth Sony SRS-XB33', 'Parlante portátil inalámbrico con tecnología Extra Bass para graves profundos, resistente al agua y polvo (certificación IP67), batería de larga duración hasta 24 horas, ideal para fiestas al aire libre y uso diario.', 120.00, 35, 15, 26),
(8, 'Auriculares inalámbricos Apple AirPods Pro', 'Auriculares inalámbricos con cancelación activa de ruido, modo transparencia para escuchar el entorno, resistencia al sudor y agua IPX4, diseño ergonómico y cómodo para uso prolongado, sonido de alta calidad con ajuste dinámico.', 249.99, 40, 15, 27),
(9, 'Monitor LG UltraGear 27GL850', 'Monitor gaming de 27” con resolución QHD 2560x1440, tasa de refresco de 144Hz, tiempo de respuesta ultra rápido de 1ms, compatible con NVIDIA G-Sync y AMD FreeSync, diseño elegante y base ajustable en altura para mayor comodidad.', 450.00, 20, 6, 28),
(10, 'Teclado mecánico Logitech G513', 'Teclado mecánico con retroiluminación RGB personalizable, switches táctiles y silenciosos para escritura y gaming, estructura de aluminio resistente, software para configurar macros y perfiles personalizados, puerto USB pasante.', 130.00, 25, 15, 28),
(11, 'Disco duro externo Seagate 2TB', 'Disco duro portátil con gran capacidad de 2TB, conexión USB 3.0 para transferencias rápidas, compatible con Windows y Mac, diseño compacto y durable, ideal para almacenar archivos multimedia, copias de seguridad y documentos importantes.', 80.00, 45, 15, 29);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `razonsocial` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `razonsocial`, `direccion`, `telefono`) VALUES
(11, 'Proveedor Tecnología S.A.', 'Av. Tecnológica 123, Lima', '01-555-4321'),
(12, 'Distribuciones Globales', 'Jr. Comercio 456, Arequipa', '054-987-654'),
(13, 'Importadora Central', 'Calle Central 789, Cusco', '084-321-987'),
(14, 'Soluciones Industriales', 'Av. Industrial 101, Trujillo', '044-765-432'),
(15, 'Servicios y Equipos SAC', 'Jr. Servicios 202, Chiclayo', '074-555-678'),
(16, 'TecnoSupply Perú', 'Av. Innovación 500, Lima', '01-444-5678'),
(17, 'Electromundo SAC', 'Calle Electricidad 234, Arequipa', '054-222-3344'),
(18, 'Mega Importaciones', 'Jr. Comercio Exterior 876, Lima', '01-333-9876'),
(19, 'Industrial Proveedores SAC', 'Av. Industria 321, Trujillo', '044-555-1234'),
(20, 'Soluciones Técnicas SAC', 'Calle Soluciones 432, Cusco', '084-777-3456'),
(21, 'Equipos y Servicios Globales', 'Jr. Servicios 999, Chiclayo', '074-888-4567'),
(22, 'Innovatec SAC', 'Av. Innovación 111, Lima', '01-555-2222'),
(23, 'Comercializadora Andina', 'Calle Andina 45, Arequipa', '054-666-7788'),
(24, 'Tecnología Avanzada SAC', 'Av. Avanzada 678, Lima', '01-777-8899'),
(25, 'Proveedora Industrial SAC', 'Jr. Industrial 321, Trujillo', '044-999-1011'),
(26, 'Sony Corporation', 'Minato-ku, Tokyo, Japón', '+81 3-6748-2111'),
(27, 'Apple Inc.', 'Calle Innovación 456, Santiago, Chile', '+56 912345678'),
(28, 'Logitech Peru SAC', 'Jr. Electrónica 789, Lima, Perú', '+51 912345678'),
(29, 'Seagate Technology', 'Av. Almacenamiento 101, México DF, México', '+52 5551234567'),
(30, 'Samsung Electronics', 'Calle Tecnología 555, Buenos Aires, Argentina', '+54 91123456789');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `rol` enum('admin','vendedor') NOT NULL DEFAULT 'vendedor',
  `estado` enum('activo','inactivo') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `clave`, `rol`, `estado`) VALUES
(1, 'admin', 'admin123', 'admin', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id_venta`, `fecha`, `id_cliente`, `total`) VALUES
(23, '2025-05-30 03:27:00', 14, 1699.00),
(24, '2025-05-30 03:59:00', 17, 450.00),
(25, '2025-05-30 06:14:00', 13, 749.97);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD PRIMARY KEY (`id_detventa`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_venta` (`id_venta`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario` (`usuario`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  MODIFY `id_detventa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD CONSTRAINT `detalle_ventas_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_ventas_ibfk_2` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
