-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 22-03-2025 a las 02:36:29
-- Versión del servidor: 9.1.0
-- Versión de PHP: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `inventario`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
CREATE TABLE IF NOT EXISTS `authtoken_token` (
  `key` varchar(40) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_spanish2_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

--
-- Volcado de datos para la tabla `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(1, 'Operadores');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

--
-- Volcado de datos para la tabla `auth_group_permissions`
--

INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES
(1, 1, 32),
(2, 1, 28),
(3, 1, 29),
(4, 1, 31);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_spanish2_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add producto', 7, 'add_producto'),
(26, 'Can change producto', 7, 'change_producto'),
(27, 'Can delete producto', 7, 'delete_producto'),
(28, 'Can view producto', 7, 'view_producto'),
(29, 'Can add movimiento inventario', 8, 'add_movimientoinventario'),
(30, 'Can change movimiento inventario', 8, 'change_movimientoinventario'),
(31, 'Can delete movimiento inventario', 8, 'delete_movimientoinventario'),
(32, 'Can view movimiento inventario', 8, 'view_movimientoinventario'),
(33, 'Can add Token', 9, 'add_token'),
(34, 'Can change Token', 9, 'change_token'),
(35, 'Can delete Token', 9, 'delete_token'),
(36, 'Can view Token', 9, 'view_token'),
(37, 'Can add Token', 10, 'add_tokenproxy'),
(38, 'Can change Token', 10, 'change_tokenproxy'),
(39, 'Can delete Token', 10, 'delete_tokenproxy'),
(40, 'Can view Token', 10, 'view_tokenproxy');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

--
-- Volcado de datos para la tabla `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$870000$GuSuMeJyioRMb3T4o31qJw$qEZnYVEEedni3AIjNiI7Z+9GH8RDmfo8z9Z61cIt/oA=', '2024-12-06 22:39:03.694170', 1, 'admin', '', '', '', 1, 1, '2024-12-06 21:14:57.171091'),
(2, 'pbkdf2_sha256$870000$wbcmjmjIQ0vKDbtioTxbpW$LxAjglY1N9ym9hx97HsCoVzvtyZ2G4mx1/AtWBgmuak=', '2024-12-06 22:29:13.629222', 0, 'Operador', 'Sebastian', 'Morales', '', 0, 1, '2024-12-06 22:05:00.000000'),
(3, 'pbkdf2_sha256$870000$Inl8St1UGZwBeXfqIOZNO4$6nWiKTEPrJhDbv4u9c2df3in+Gef1uTSSRlp93PtYBw=', '2024-12-19 22:13:03.663477', 0, 'Criss', '', '', '', 0, 1, '2024-12-06 22:32:17.866183'),
(4, 'pbkdf2_sha256$870000$0wxNA66FnFunpCiIftltpu$6sUvopeE+NSmBgji85WAAlkFaNWmW4qV2d5joy6lHdQ=', '2024-12-13 21:43:06.396696', 1, 'Cristian', '', '', '', 1, 1, '2024-12-13 21:42:50.958905'),
(5, 'pbkdf2_sha256$870000$VPAnaO2EPGTV6nQ78cRNY5$8iwcGzPPo97sEhub4I2EJDT7qtZ3DQ8n62pcX9aMOwo=', '2025-03-22 02:35:08.012069', 1, 'seba', '', '', '', 1, 1, '2025-03-22 02:34:47.218032');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_user_id_6a12ed8b` (`user_id`),
  KEY `auth_user_groups_group_id_97559544` (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

--
-- Volcado de datos para la tabla `auth_user_groups`
--

INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES
(1, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_user_id_a95ead1b` (`user_id`),
  KEY `auth_user_user_permissions_permission_id_1fbb5f2c` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_spanish2_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext COLLATE utf8mb4_spanish2_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ;

--
-- Volcado de datos para la tabla `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2024-12-06 22:04:40.313152', '1', 'Operadores', 1, '[{\"added\": {}}]', 3, 1),
(2, '2024-12-06 22:05:01.661714', '2', 'Operador', 1, '[{\"added\": {}}]', 4, 1),
(3, '2024-12-06 22:05:17.218417', '2', 'Operador', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Groups\"]}}]', 4, 1),
(4, '2024-12-06 22:32:18.686290', '3', 'Criss', 1, '[{\"added\": {}}]', 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_spanish2_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'permission'),
(3, 'auth', 'group'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(7, 'inventario', 'producto'),
(8, 'inventario', 'movimientoinventario'),
(9, 'authtoken', 'token'),
(10, 'authtoken', 'tokenproxy');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-12-06 20:56:32.420866'),
(2, 'auth', '0001_initial', '2024-12-06 20:56:32.668407'),
(3, 'admin', '0001_initial', '2024-12-06 20:56:32.751814'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-12-06 20:56:32.756650'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-12-06 20:56:32.762007'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-12-06 20:56:32.796847'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-12-06 20:56:32.816006'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-12-06 20:56:32.835350'),
(9, 'auth', '0004_alter_user_username_opts', '2024-12-06 20:56:32.842635'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-12-06 20:56:32.860753'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-12-06 20:56:32.861623'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-12-06 20:56:32.866884'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-12-06 20:56:32.884932'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-12-06 20:56:32.904865'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-12-06 20:56:32.924012'),
(16, 'auth', '0011_update_proxy_permissions', '2024-12-06 20:56:32.930172'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-12-06 20:56:32.948222'),
(18, 'authtoken', '0001_initial', '2024-12-06 20:56:32.969795'),
(19, 'authtoken', '0002_auto_20160226_1747', '2024-12-06 20:56:32.988906'),
(20, 'authtoken', '0003_tokenproxy', '2024-12-06 20:56:32.990406'),
(21, 'authtoken', '0004_alter_tokenproxy_options', '2024-12-06 20:56:32.993941'),
(22, 'inventario', '0001_initial', '2024-12-06 20:56:33.079041'),
(23, 'sessions', '0001_initial', '2024-12-06 20:56:33.098419');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_spanish2_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

--
-- Volcado de datos para la tabla `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('vqor4sh03g565ts8x9thfa496p8nn1u5', '.eJxVjDsOwjAQRO_iGln-xR9K-pzBWnvXOIAcKU4qxN1JpBTQTDHvzbxZhG2tceu0xAnZlSl2-e0S5Ce1A-AD2n3meW7rMiV-KPyknY8z0ut2un8HFXrd1wlK0CSxWC2M9UYYsIB7AmYrsi9S-2J0cdqTBJ2DK4q8EoNL1gQ5sM8X7h03og:1tJgZd:B5zycE1rMUwTrfyFXGJUwdeWiT1JDilKip9sEpteiJs', '2024-12-20 22:13:21.847534'),
('9hjmoeezu6ha5edongg902q6qlyl7ln9', '.eJxVjDsOwjAQBe_iGln-rmNKes5g7fqDA8iW4qRC3B0ipYD2zcx7sYDbWsM28hLmxM5MstPvRhgfue0g3bHdOo-9rctMfFf4QQe_9pSfl8P9O6g46rcGtMJnNaHOKgmy6Dx4o0xUOiIUTUB2AklJaOOgFOmxZJ_QRnJGasneH9qPN84:1tJgAv:hSj9uV9R6mnx_dQBLpJXs65SmpSKcsXI2H8qu2DXPn0', '2024-12-20 21:47:49.076148'),
('v8c1jy016xhxozk6c247go6ib5nvaoje', '.eJxVjDsOwjAQBe_iGln-rmNKes5g7fqDA8iW4qRC3B0ipYD2zcx7sYDbWsM28hLmxM5MstPvRhgfue0g3bHdOo-9rctMfFf4QQe_9pSfl8P9O6g46rcGtMJnNaHOKgmy6Dx4o0xUOiIUTUB2AklJaOOgFOmxZJ_QRnJGasneH9qPN84:1tJgBN:dU9njIE0dCTBhLKtG4irzIEFeqmXM43-buoEqkqTVwg', '2024-12-20 21:48:17.325288'),
('audglbqb6lssdnuwewz8nptu1ao9ca1y', '.eJxVjDsOwjAQBe_iGln-rmNKes5g7fqDA8iW4qRC3B0ipYD2zcx7sYDbWsM28hLmxM5MstPvRhgfue0g3bHdOo-9rctMfFf4QQe_9pSfl8P9O6g46rcGtMJnNaHOKgmy6Dx4o0xUOiIUTUB2AklJaOOgFOmxZJ_QRnJGasneH9qPN84:1tJgLL:GX9reFz3Wv4IhbJk7QGgw-on8CfE-sRTNXKr5oqnv2I', '2024-12-20 21:58:35.970934'),
('1036c18n9ig7ixqbildrxtjvom76z6tc', '.eJxVjEEOwiAQRe_C2hCGoQVcuvcMZBhAqoYmpV0Z765NutDtf-_9lwi0rTVsPS9hSuIsUJx-t0j8yG0H6U7tNkue27pMUe6KPGiX1znl5-Vw_w4q9fqtIyf22Xpn1Qigh6IGgBE0okETlTIRyRN5hJIZVKKii0N0XBhsAS_eH8bVN14:1tJh0C:zq7wMbLjbHoNsuKwvnIJnalP5RWxTjo9Y9hPFc1lWz8', '2024-12-20 22:40:48.496326'),
('s27i280psbvq09gz61zojah4rumt5q2e', '.eJxVjDsOwjAQBe_iGln-rmNKes5g7fqDA8iW4qRC3B0ipYD2zcx7sYDbWsM28hLmxM5MstPvRhgfue0g3bHdOo-9rctMfFf4QQe_9pSfl8P9O6g46rcGtMJnNaHOKgmy6Dx4o0xUOiIUTUB2AklJaOOgFOmxZJ_QRnJGasneH9qPN84:1tJgeo:7lP2m4azA6tFXq1KOho9g9bDnEGfbQyyIlou6b7NF2A', '2024-12-20 22:18:42.153038'),
('78rx4cbu8ygl0fqhwou01iz1l6oj4b8g', '.eJxVjDsOwjAQBe_iGln-rmNKes5g7fqDA8iW4qRC3B0ipYD2zcx7sYDbWsM28hLmxM5MstPvRhgfue0g3bHdOo-9rctMfFf4QQe_9pSfl8P9O6g46rcGtMJnNaHOKgmy6Dx4o0xUOiIUTUB2AklJaOOgFOmxZJ_QRnJGasneH9qPN84:1tJgfp:MS0pD6tFkUU8nYtSUAMJf4CbcHhJYPdWzzTh1YNZops', '2024-12-20 22:19:45.367239'),
('vbmlgqduon5c94idkuvawe9s7vbwy6x0', '.eJxVjDsOwjAQBe_iGln-rmNKes5g7fqDA8iW4qRC3B0ipYD2zcx7sYDbWsM28hLmxM5MstPvRhgfue0g3bHdOo-9rctMfFf4QQe_9pSfl8P9O6g46rcGtMJnNaHOKgmy6Dx4o0xUOiIUTUB2AklJaOOgFOmxZJ_QRnJGasneH9qPN84:1tJgla:-Y3jeCVcbvzVUvYCkx5eXcGywdX7mIVuYXlpWcsgcfY', '2024-12-20 22:25:42.267773'),
('0l050vpka4z6cmjcttqqgtooi8nsu45i', '.eJxVjDsOwjAQBe_iGln-rmNKes5g7fqDA8iW4qRC3B0ipYD2zcx7sYDbWsM28hLmxM5MstPvRhgfue0g3bHdOo-9rctMfFf4QQe_9pSfl8P9O6g46rcGtMJnNaHOKgmy6Dx4o0xUOiIUTUB2AklJaOOgFOmxZJ_QRnJGasneH9qPN84:1tJgm5:SzJd6Gdw2JfdVeIu02G1ndRLFU_2ItMo0CXaFp_ykr0', '2024-12-20 22:26:13.181880'),
('d6lxd8drqpf2nafdiiadjino96zkv6wp', '.eJxVjDsOwjAQRO_iGln-xR9K-pzBWnvXOIAcKU4qxN1JpBTQTDHvzbxZhG2tceu0xAnZlSl2-e0S5Ce1A-AD2n3meW7rMiV-KPyknY8z0ut2un8HFXrd1wlK0CSxWC2M9UYYsIB7AmYrsi9S-2J0cdqTBJ2DK4q8EoNL1gQ5sM8X7h03og:1tJgn8:cXYotEa4VL60ktMdysZeO7CKpCfvLAqPXchFRLC0Zr4', '2024-12-20 22:27:18.353678'),
('v51is3je29qc6abxerumywt5qm6iw5z8', '.eJxVjDsOwjAQRO_iGln-xR9K-pzBWnvXOIAcKU4qxN1JpBTQTDHvzbxZhG2tceu0xAnZlSl2-e0S5Ce1A-AD2n3meW7rMiV-KPyknY8z0ut2un8HFXrd1wlK0CSxWC2M9UYYsIB7AmYrsi9S-2J0cdqTBJ2DK4q8EoNL1gQ5sM8X7h03og:1tJgoz:Re0JSB2sg4cI31Awd8ovVlaaWmqLfIqRcEhwaCvrdr4', '2024-12-20 22:29:13.630046'),
('ikno03emrap2fbpc1lazdfz205wh3a8m', '.eJxVjDsOwjAQBe_iGln-rmNKes5g7fqDA8iW4qRC3B0ipYD2zcx7sYDbWsM28hLmxM5MstPvRhgfue0g3bHdOo-9rctMfFf4QQe_9pSfl8P9O6g46rcGtMJnNaHOKgmy6Dx4o0xUOiIUTUB2AklJaOOgFOmxZJ_QRnJGasneH9qPN84:1tJgqD:3ptnqEy_C8YOmR0TqS74M7wCR2V0AF7WG1DfNtsyusA', '2024-12-20 22:30:29.303500'),
('rklpbvl8gtz3z5ccnfd9cfdhk18hft71', '.eJxVjDsOwjAQBe_iGln-rmNKes5g7fqDA8iW4qRC3B0ipYD2zcx7sYDbWsM28hLmxM5MstPvRhgfue0g3bHdOo-9rctMfFf4QQe_9pSfl8P9O6g46rcGtMJnNaHOKgmy6Dx4o0xUOiIUTUB2AklJaOOgFOmxZJ_QRnJGasneH9qPN84:1tJgqw:1AX4VI4wCRRW8vVZLZXlUbxPmnlfuIGPvfPWNtYGH_4', '2024-12-20 22:31:14.422221'),
('v1s535xj4dtl1x0pvg2dlwyurck0kavl', '.eJxVjDsOwjAQBe_iGln-rmNKes5g7fqDA8iW4qRC3B0ipYD2zcx7sYDbWsM28hLmxM5MstPvRhgfue0g3bHdOo-9rctMfFf4QQe_9pSfl8P9O6g46rcGtMJnNaHOKgmy6Dx4o0xUOiIUTUB2AklJaOOgFOmxZJ_QRnJGasneH9qPN84:1tJgqx:iLj8ts53RvDqMWgdqLGLaZKb5LanPG9exi4ke9SQuLA', '2024-12-20 22:31:15.206425'),
('16o1qculzuznvi32ppynktzkqspzbh5h', '.eJxVjEEOwiAQRe_C2hCGoQVcuvcMZBhAqoYmpV0Z765NutDtf-_9lwi0rTVsPS9hSuIsUJx-t0j8yG0H6U7tNkue27pMUe6KPGiX1znl5-Vw_w4q9fqtIyf22Xpn1Qigh6IGgBE0okETlTIRyRN5hJIZVKKii0N0XBhsAS_eH8bVN14:1tJgsH:P5SIRdUPc6DhAN85sbrgHjKnLUYwX1r0qpBNqCVI66o', '2024-12-20 22:32:37.798982'),
('t96rekqxavhel4h40p8o12z64efoi6nn', '.eJxVjEEOwiAQRe_C2hCGoQVcuvcMZBhAqoYmpV0Z765NutDtf-_9lwi0rTVsPS9hSuIsUJx-t0j8yG0H6U7tNkue27pMUe6KPGiX1znl5-Vw_w4q9fqtIyf22Xpn1Qigh6IGgBE0okETlTIRyRN5hJIZVKKii0N0XBhsAS_eH8bVN14:1tJh0F:ZK6qnZ-Z2wGUAwMrzWzO6hlk8xWjtjzoJvFtaWnn_r4', '2024-12-20 22:40:51.067488'),
('u42xp6u9a5y2y2x5qsb4fuvfqnvcbirg', '.eJxVjEEOwiAQRe_C2hCYFgSX7j0DmRlAqgaS0q6Md7dNutDtf-_9twi4LiWsPc1hiuIiRnH63Qj5meoO4gPrvUludZknkrsiD9rlrcX0uh7u30HBXrbakz9HYOSBAcE6nwHSiEZph8pa2JADawZAUpGNUi6yNZQ1aaCcB_H5AuAMN-M:1tMDRC:upEKlWBKyNCpT3gBsBfGR3J8Wt56uQcbpZvk-pn0EJo', '2024-12-27 21:43:06.399560'),
('g6k8lx5vg2ghgl2b27qcdbkcnwix6f88', '.eJxVjEEOwiAQRe_C2hCGoQVcuvcMZBhAqoYmpV0Z765NutDtf-_9lwi0rTVsPS9hSuIsUJx-t0j8yG0H6U7tNkue27pMUe6KPGiX1znl5-Vw_w4q9fqtIyf22Xpn1Qigh6IGgBE0okETlTIRyRN5hJIZVKKii0N0XBhsAS_eH8bVN14:1tOOlT:oL6oLM71nKswUjdFUstxxvnLJxZJ0BNfwSExK-baclg', '2025-01-02 22:13:03.673769'),
('zcjddskmsg6yswy54iqivd9gus8bshqz', '.eJxVjMsOwiAQRf-FtSFAKQ-X7v0GMgMzUjU0Ke3K-O_apAvd3nPOfYkE21rT1mlJUxFnMYrT74aQH9R2UO7QbrPMc1uXCeWuyIN2eZ0LPS-H-3dQoddvDbZEy-jAlByy0kMJpJgQvVYmsFLg2BPTkGNA75mMA-tHjaQ1RAfi_QEM2zjA:1tvohY:MoTzeogrbeOiyeZ0-j7A8btZgWUAzrVu8xhPPZmp_YA', '2025-04-05 02:35:08.014419');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_movimientoinventario`
--

DROP TABLE IF EXISTS `inventario_movimientoinventario`;
CREATE TABLE IF NOT EXISTS `inventario_movimientoinventario` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tipo` varchar(7) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `cantidad` int UNSIGNED NOT NULL,
  `fecha` datetime(6) NOT NULL,
  `stock_despues` int UNSIGNED NOT NULL,
  `responsable_id` int DEFAULT NULL,
  `producto_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `inventario_movimientoinventario_responsable_id_c7f20447` (`responsable_id`),
  KEY `inventario_movimientoinventario_producto_id_cec1a696` (`producto_id`)
) ;

--
-- Volcado de datos para la tabla `inventario_movimientoinventario`
--

INSERT INTO `inventario_movimientoinventario` (`id`, `tipo`, `cantidad`, `fecha`, `stock_despues`, `responsable_id`, `producto_id`) VALUES
(1, 'SALIDA', 3, '2024-12-06 22:10:39.294085', 22, 1, 1),
(2, 'SALIDA', 3, '2024-12-06 22:12:15.527866', 97, 1, 2),
(3, 'ENTRADA', 25, '2024-12-06 22:12:47.873039', 10025, 1, 4),
(4, 'ENTRADA', 5, '2024-12-06 22:37:52.293073', 27, 3, 1),
(5, 'SALIDA', 26, '2024-12-06 22:38:14.928560', 1, 3, 1),
(6, 'ENTRADA', 6, '2025-03-22 02:35:29.325364', 7, 5, 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_producto`
--

DROP TABLE IF EXISTS `inventario_producto`;
CREATE TABLE IF NOT EXISTS `inventario_producto` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `descripcion` longtext COLLATE utf8mb4_spanish2_ci NOT NULL,
  `cantidad` int UNSIGNED NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `imagen` varchar(100) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ;

--
-- Volcado de datos para la tabla `inventario_producto`
--

INSERT INTO `inventario_producto` (`id`, `nombre`, `descripcion`, `cantidad`, `precio`, `imagen`, `is_active`) VALUES
(1, 'Martillo', 'Martillo de profesor alex', 1, 12990.00, '', 1),
(2, 'Serrucho', 'Serrucho de madera clasico', 97, 12500.00, 'productos/serrucho.jpg', 1),
(3, 'Malla Rachel', 'Malla para proteger cercos', 1000, 5000.00, 'productos/mallarachel.jpg', 1),
(4, 'Clavos', 'Clavos Galvanizados', 10025, 200.00, 'productos/clavo.jpeg', 1),
(5, 'cristian', 'comparito', 5, 64000.00, '', 1),
(6, 'profesoralex', 'taller', 25, 10000000.00, '', 1),
(7, 'profesor', 'profesor de taller', 200, 24.00, '', 1),
(8, 'Diego', 'Diego el más sutro', 20, 30.00, '', 1),
(9, 'Prueba2023', 'asdasdasd', 7, 12345.00, '', 1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
