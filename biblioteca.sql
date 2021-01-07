-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-12-2020 a las 06:11:18
-- Versión del servidor: 10.4.16-MariaDB
-- Versión de PHP: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `biblioteca`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `nombre`) VALUES
(1, 'Ciencia Ficcion'),
(2, 'Novela Policial'),
(3, 'Novela Romantica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libro`
--

CREATE TABLE `libro` (
  `id` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  `persona_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `libro`
--

INSERT INTO `libro` (`id`, `nombre`, `descripcion`, `categoria_id`, `persona_id`) VALUES
(1, 'La maquina del tiempo', 'G.H. Wells (1985) Retrata de una sociedad futura dividida entre gente hipersensible y mostrencos monstruosos. ', 1, 1),
(2, '1984', 'G. Orwell (1949) La guerra perpetua, la vigilancia gubernamental y el negacionismo histórico son los temas centrales de esta novela que nunca pierde vigencia', 1, 3),
(3, 'Fahrenheit 451', 'R. Bradbury (1953) Presenta un futuro en el que los bomberos no apagan fuegos, sino que los generan, quemando los libros, que están prohibidos. Uno de estos bomberos se une a un grupo de resistencia que memoriza los clásicos de la literatura para evitar que se pierdan.', 1, 8),
(4, 'Soy leyenda', 'R. Matheson (1954) El superviviente a un apocalipsis en forma de plaga, un tropo que aquí se ve acentuado por la angustia del protagonista de desconocer por qué él ha sobrevivido', 1, 1),
(5, 'El fin de la eternidad', 'I. Asimov (1955) Una asociación, Eternidad, se asegura de que Todo Lo Que Sucede, Sucede Como Tiene Que Suceder, y a través de ella Asimov explora todas las convenciones del subgénero, de los loops a las paradojas, pasando por los tópicos de las máquinas o la Policía del Tiempo', 1, 2),
(6, 'Las estrellas, mi destino', 'A. Bester (1956) Cuenta una apasionante historia de venganza con personajes absolutamente amorales, robos y piratas espaciales, cicatrices faciales y todos los planetas del sistema solar enfrentados entre sí. Y en el contexto de un siglo XXV donde la posibilidad de materializarse en cualquier destino con solo pensarlo es una realidad.', 1, 4),
(7, 'Solaris', 'S. Lem (1961) La investigación de un planeta cubierto por un mar que podría ser una inteligencia extraterrestre, y que pronto comienza a manipular las mentes de la tripulación que intenta entender su naturaleza', 1, NULL),
(8, 'Dune ', 'F. Herbert (1965) 20.000 años en el futuro, el universo se rige por dinámicas feudales y en el planeta desértico Arrakis crece la sustancia más valiosa del universo, la Especia, famosa por su capacidad para expandir la mente.', 1, 9),
(9, 'Matadero Cinco', 'K. Vonnegut (1969)  Seguiremos la vida de Billy Pilgrim, desde sus experiencias en la 2ª Guerra Mundial a sus viajes en el tiempo después del conflicto, con visitas al planeta Trafaldamore, donde sus habitantes ven las cuatro dimensiones.', 1, NULL),
(10, 'Ubik ', 'P. K. Dick (1969) El punto de partida de \'Ubik\' es el de un técnico implicado en una enrevesada trama de espionaje corporativo y poderes psíquicos que entra en contacto con una sustancia que puede revertir las alteraciones en la realidad.', 1, 7),
(11, 'Los crímenes de la calle Morgue', 'E.A. Poe (1841) Auguste Dupin tiene que resolver el asesinato de una madre y una hija cuyos cuerpos aparecen en un departamento en París', 2, NULL),
(12, 'Estudio en escarlata', 'A.C. Doyle (1887)  Esta historia tiene dos partes. En una se narra cómo se conocen y quiénes son los protagonistas, el investigador excéntrico (Sherlock Holmes) y su secuaz (Watson). En la otra, se relata el primer enigma a resolver: un hombre asesinado en una habitación repleta de sangre, pero sin ninguna herida.', 2, 8),
(13, 'El misterioso caso de Styles', 'A. Christie (1920)  La novela plantea el enigma de una millonaria encontrada muerta en su habitación, de un infarto o por envenenamiento. Todos los habitantes de la mansión tienen un motivo para querer matarla, ¿quién fue?', 2, NULL),
(14, 'El halcón maltés', 'D. Hammett (1930) Sucede en San Francisco, donde un puñado de delincuentes busca una estatuilla cara, una joya perdida o robada, y es una lucha de bestialidades inteligentes. El detective privado Sam Spade se mueve en ese mundo hostil con pericia, a pedido de una cliente tan sensual como misteriosa.', 2, 10),
(15, 'El talento de Mr. Ripley', 'P. Highsmith (1950) Ripley es un ladrón encantador, un estafador inteligentísimo y, ocasionalmente, si no tiene más remedio, un asesino. Tiene su propio sistema de valores y es fácil entrar en su lógica, encariñarse, acompañar la trama desde su punto de vista. Por primera vez en la literatura policial, el público palpita página a página para que no atrapen al criminal ', 2, NULL),
(16, 'El espía que surgió del frío', 'J. le Carré (1963) El protagonista es un espía inglés, Alec Leamas, que tiene que llevar adelante una operación contra el jefe del contraespionaje de Alemania Oriental', 2, NULL),
(17, 'Los perros de Riga', 'H. Mankell (1992) En esta, la segunda novela de la saga, Wallander viaja a Letonia, en medio de un pico de estrés por problemas personales, para investigar el asesinato de dos hombres, que llegaron muertos en un bote a la costa sueca. Su diatriba es cómo develar este crimen mientras todavía le duele su divorcio, cuando siente que abandonó a su padre anciano, cuando no entiende el mal del mundo.', 2, NULL),
(18, 'La princesa de hielo', 'C. Lackberg (2002) Erica, una joven, vuelve después de muchos años y termina envuelta en una historia truculenta, en donde los sospechosos son sus compañeros de juegos de la infancia y la víctima, su amiga Alex.', 2, 5),
(19, 'Tatuaje', 'M. Vazquez Montalban (2013) Un gallego escéptico y ácido, que no se priva, de todos modos, de placeres mundanos, sexo y gastronomía sobre todo. El caso a resolver es el de un cadáver con el rostro desfigurado, pero un tatuaje que permite reconocerlo, que aparece en una playa de Barcelona. Es misterio y crónica social. ', 2, NULL),
(20, 'Triste, solitario y final', 'O. Soriano (1973)  La historia tiene una interesante combinación de épica con sentido del humor: un Soriano convertido en personaje, enredado en una trama que incluye a Stan Laurel  contratando los servicios de Philip Marlowe, el detective privado, para que averigüe por qué Hollywood lo condenó al olvido', 2, NULL),
(21, 'Orgullo y prejuicio ', 'J. Austen (1813) Describe de una manera magistral la sociedad de Inglaterra del siglo XIX en una historia con mucho sentimiento y amor de desarrollo personal, en la que las dos figuras principales, Elizabeth Bennet y Fitzwilliam Darcy, deben madurar para superar algunas crisis y aprender de sus errores para poder encarar el futuro en común', 3, 3),
(22, 'El amor en los tiempos del cólera ', 'G.Garcia Marquez (1985) La historia de un amor imposible que se sobrepone a las décadas, a una sociedad clasista y tradicional. Con una narración impecable, de formas que superan al relato, como sólo Gabo podría manifestar, esta novela es una de esas historias que no se olvidan jamás', 3, NULL),
(23, 'Cumbres borrascosas ', 'E. Bronte (1847) Una compilación de historias llenas de tragedia, tristeza y pasión y mucho mas que muestran cuán retorcidos pueden ser los lazos románticos', 3, NULL),
(24, 'Jane Eyre', 'C. Bronte (1847) En los confines más remotos de los campos caballerezcos de una Inglaterra olvidada encontrarás a Jane Ayre. Junto a ella odiarás, perdonarás, gritarás, clamarás, y amarás tan profundamente al punto de hacer realidad la leyenda de las almas gemelas', 3, 6),
(25, 'Como agua para chocolate ', 'L. Esquivel (1989)  Esquivel narra con gran destreza la historia de amor de Pedro y Tita, frustrado por un tradicionalismo muy real en Latinoamérica, costumbres ancestrales y formas léxicas pícaras, además del contexto de batallas civiles', 3, 5),
(26, 'Madame Bovary ', 'G. Flaubert (1852) Un libro muy controvertido en su época por los temas que aborda: cuestiona instituciones como la del matrimonio nunca antes hecho de esa forma y además hace una descripción de la burguesía de las provincias bastante descarnada. ', 3, NULL),
(27, 'Sentido y sensibilidad ', 'J. Austen (1811) Una narrativa maravillosa para mostrar lo confusas que pueden ser las emociones contrastadas con el pensamiento. A pesar de que nunca se ponen de acuerdo, siempre se puede encontrar el equilibrio entre ambas', 3, 7),
(28, 'El cuaderno de Noah ', 'N. Sparks (1996) Un torrente de emociones incontrolables. Recomendable si estás buscando una historia de amor desenfrenado', 3, NULL),
(29, 'María ', 'J. Isaacs (1867) Narra la relación de los desdichados amores de dos adolescentes: Efraín, hacendado en la región del Cauca, y su hermana adoptiva, María. Este idilio va a tener como marco el bucólico ambiente natural de esa región colombiana', 3, 2),
(30, 'La dama de las camelias ', 'A. Dumas (1848) Marguerite es una de las grandes heroínas de la literatura romántica, aunque sea solo por conocer este personaje vale la pena leer esta novela', 3, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `alias` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`id`, `nombre`, `apellido`, `email`, `alias`) VALUES
(1, 'Emiliano', 'Bajamon', 'emilianobajamon@gmail.com', 'Colo'),
(2, 'Katia', 'Fragazzini', 'kfescuela@gmail.com', 'Kat'),
(3, 'Andres', 'Leonangeli', 'andresleonangeli@gmail.com', 'Andy'),
(4, 'Marcos', 'Galperin', 'marcosgalperin@gmail.com', 'Galpe'),
(5, 'Ada', 'Lovelace', 'adalovelace@yahoo.com', 'Adita'),
(6, 'Steve', 'Wozniak', 'adalovelace@hotmail.com', 'Woz'),
(7, 'Grace', 'Hopper', 'gracehopper71@hotmail.com', 'Hop'),
(8, 'Larry', 'Page', 'larrypage@gmail.com', 'Lar'),
(9, 'Karen', 'Sparck Jones', 'sparckjones@hotmail.com', 'Kary'),
(10, 'Isis', 'Wenger', 'isiswenger@hotmail.com', 'Isita');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `libro`
--
ALTER TABLE `libro`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoria_id` (`categoria_id`),
  ADD KEY `persona_id` (`persona_id`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `libro`
--
ALTER TABLE `libro`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `libro`
--
ALTER TABLE `libro`
  ADD CONSTRAINT `libro_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`),
  ADD CONSTRAINT `libro_ibfk_2` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
