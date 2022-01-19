-- Inserts de la aplicacion 

CREATE SEQUENCE incremento_id_pais
INCREMENT BY 1
START WITH 100;

CREATE SEQUENCE incremento_id_ciudad
INCREMENT BY 1
START WITH 10;

CREATE SEQUENCE incremento_id_estacion
INCREMENT BY 1
START WITH 300;

-- Incremento hecho crudo
CREATE SEQUENCE incr_hc INCREMENT BY 1 START WITH 1;

-- Incremento Pieza inteligencia
CREATE SEQUENCE incr_pi INCREMENT BY 1 START WITH 1;


-- Pais --
INSERT INTO pais VALUES (100,'Suiza','Eu'); -- Sede Central
INSERT INTO pais VALUES (101,'Grecia','Eu');
INSERT INTO pais VALUES (102,'Portugal','Eu');
INSERT INTO pais VALUES (103,'Singapur','As'); -- Oficina de area
INSERT INTO pais VALUES (104,'Qatar','As');
INSERT INTO pais VALUES (105,'Indonesia','As');
INSERT INTO pais VALUES (106,'Estados Unidos','AmN'); -- Oficina de area
INSERT INTO pais VALUES (107,'Costa Rica','AmN');
INSERT INTO pais VALUES (108,'Argentina','AmS');-- Oficina de area
INSERT INTO pais VALUES (109,'Ecuador','AmS');
INSERT INTO pais VALUES (110,'Egipto','Af');-- Oficina de area
INSERT INTO pais VALUES (111,'Marruecos','Af');
INSERT INTO pais VALUES (112,'Cabo Verde','Af');
INSERT INTO pais VALUES (113,'Australia','Oc');-- Oficina de area
INSERT INTO pais VALUES (114,'Nueva Zelanda','Oc');

-- Ciudad --
INSERT INTO ciudad VALUES(10,'Ginebra',100); -- central
INSERT INTO ciudad VALUES(11,'Atenas',101);
INSERT INTO ciudad VALUES(12,'Oya',101);
INSERT INTO ciudad VALUES(13,'Argos',101);
INSERT INTO ciudad VALUES(14,'Lisboa',102);
INSERT INTO ciudad VALUES(15,'Amadora',102);
INSERT INTO ciudad VALUES(16,'Esposende',102);
INSERT INTO ciudad VALUES(17,'Ciudad de Singapur',103); -- Central
INSERT INTO ciudad VALUES(18,'Doha',104);
INSERT INTO ciudad VALUES(19,'Dukhan',104);
INSERT INTO ciudad VALUES(20,'Lusail',104);
INSERT INTO ciudad VALUES(21,'Yakarta',105);
INSERT INTO ciudad VALUES(22,'Surabaya',105);
INSERT INTO ciudad VALUES(23,'Medan',105);
INSERT INTO ciudad VALUES(24,'Washington D. C.',106); -- Central
INSERT INTO ciudad VALUES(25,'Heredia',107);
INSERT INTO ciudad VALUES(26,'Escazú',107);
INSERT INTO ciudad VALUES(27,'Puntarenas',107);
INSERT INTO ciudad VALUES(28,'Buenos Aires',108);-- Central
INSERT INTO ciudad VALUES(29,'Machala',109);
INSERT INTO ciudad VALUES(30,'Quito',109);
INSERT INTO ciudad VALUES(31,'Salinas',109);
INSERT INTO ciudad VALUES(32,'El Cairo',110);-- Central
INSERT INTO ciudad VALUES(33,'Casablanca',111);
INSERT INTO ciudad VALUES(34,'Fez',111);
INSERT INTO ciudad VALUES(35,'Salé',111);
INSERT INTO ciudad VALUES(36,'Praia',112);
INSERT INTO ciudad VALUES(37,'Mindelo',112);
INSERT INTO ciudad VALUES(38,'Santa Maria',112);
INSERT INTO ciudad VALUES(39,'Sydney',113);-- Central
INSERT INTO ciudad VALUES(40,'Auckland',114);
INSERT INTO ciudad VALUES(41,'Wellington',114);
INSERT INTO ciudad VALUES(42,'Hamilton',114);

-- Empleado Jefe --

INSERT INTO empleado_jefe VALUES (1,'Dannel','Conring','CEO',NULL);
INSERT INTO empleado_jefe VALUES (2,'Wilmar','Cisland','Area',NULL);
INSERT INTO empleado_jefe VALUES (3,'Kile','Smith','Area',NULL);
INSERT INTO empleado_jefe VALUES (4,'Leon','Rodriguez','Area',NULL);
INSERT INTO empleado_jefe VALUES (5,'Mirabelle','Braley','Area',NULL);
INSERT INTO empleado_jefe VALUES (6,'Andrew','Jordan','Area',NULL);
INSERT INTO empleado_jefe VALUES (7,'Luis','Jurado','Estacion',1);
INSERT INTO empleado_jefe VALUES (8,'Marcos','Perez','Estacion',1);
INSERT INTO empleado_jefe VALUES (9,'Juan', 'Castro','Estacion',1);
INSERT INTO empleado_jefe VALUES (10,'Diego', 'Jurado','Estacion',1); 
INSERT INTO empleado_jefe VALUES (11,'Kevin', 'Sibila','Estacion',1);
INSERT INTO empleado_jefe VALUES (12,'Pablo', 'Martinez','Estacion',1);
INSERT INTO empleado_jefe VALUES (13,'Marlen', 'Ramirez','Estacion',2);
INSERT INTO empleado_jefe VALUES (14,'Massimo','Piccioni','Estacion',2);
INSERT INTO empleado_jefe VALUES (15,'Carl','Toderi','Estacion',2); 
INSERT INTO empleado_jefe VALUES (16,'Brok','Biggin','Estacion',2);
INSERT INTO empleado_jefe VALUES (17,'Don','Hardern','Estacion',2);
INSERT INTO empleado_jefe VALUES (18,'Bryan','Fearne','Estacion',2);
INSERT INTO empleado_jefe VALUES (19,'John','Snow','Estacion',3);
INSERT INTO empleado_jefe VALUES (20,'Pippa','Kears','Estacion',3);
INSERT INTO empleado_jefe VALUES (21,'Paulo','Haker','Estacion',3);
INSERT INTO empleado_jefe VALUES (22,'Carlos','Contreras','Estacion',4);
INSERT INTO empleado_jefe VALUES (23,'Luciano','Sanchez','Estacion',4);
INSERT INTO empleado_jefe VALUES (24,'Ursala','Doulton','Estacion',4);
INSERT INTO empleado_jefe VALUES (25,'Kameko','Spriggin','Estacion',5);
INSERT INTO empleado_jefe VALUES (26,'Umbaku','Karoto','Estacion',5); 
INSERT INTO empleado_jefe VALUES (27,'Quinton','Blades','Estacion',5);
INSERT INTO empleado_jefe VALUES (28,'Benito','Martinez','Estacion',5);
INSERT INTO empleado_jefe VALUES (29,'Jose','Balvin','Estacion',5);
INSERT INTO empleado_jefe VALUES (30,'Fredia','Charke','Estacion',5);
INSERT INTO empleado_jefe VALUES (31,'Renato','Torella','Estacion',6);
INSERT INTO empleado_jefe VALUES (32,'Carolina','Gomez','Estacion',6);
INSERT INTO empleado_jefe VALUES (33,'Valentina','Bautizta','Estacion',6);

-- Oficina Principal -- 

INSERT INTO oficina_principal VALUES (1,'Director AII',true,1,10,100);
INSERT INTO oficina_principal VALUES (2,'Denesik',false,2,17,103);
INSERT INTO oficina_principal VALUES (3,'Hexagono',false,3,24,106);
INSERT INTO oficina_principal VALUES (4,'Latina',false,4,28,108);
INSERT INTO oficina_principal VALUES (5,'Effertz',false,5,32,110);
INSERT INTO oficina_principal VALUES (6,'Bechtelar',false,6,39,113);


-- Estacion -- 
--INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Capuchin',50000,33,42,114,6);
INSERT INTO estacion VALUES (300,'Parrot',50000,7,11,101,1);
INSERT INTO estacion VALUES (301,'Monkey',20000,8,12,101,1); 
INSERT INTO estacion VALUES (302,'Eagle',30000,9,13,101,1);
INSERT INTO estacion VALUES (303,'Wolf',35000,10,14,102,1);
INSERT INTO estacion VALUES (304,'bear',40000,11,15,102,1);
INSERT INTO estacion VALUES (305,'Buffalo',20000,12,16,102,1);
INSERT INTO estacion VALUES (306,'Lizard',60000,13,18,104,2);
INSERT INTO estacion VALUES (307,'Lemur',60000,14,19,104,2);
INSERT INTO estacion VALUES (308,'Seal',30000,15,20,104,2);
INSERT INTO estacion VALUES (309,'fox',30000,16,21,105,2);
INSERT INTO estacion VALUES (310,'Bird',20000,17,22,105,2);
INSERT INTO estacion VALUES (311,'Goose',50000,18,23,105,2);
INSERT INTO estacion VALUES (312,'Winterfel',50000,19,25,107,3);
INSERT INTO estacion VALUES (313,'Koala',40000,20,26,107,3);
INSERT INTO estacion VALUES (314,'Orca',300000,21,27,107,3);
INSERT INTO estacion VALUES (315,'Vulture',30000,22,29,109,4);
INSERT INTO estacion VALUES (316,'Duck',10000,23,30,109,4);
INSERT INTO estacion VALUES (317,'Cat',60000,24,31,109,4);
INSERT INTO estacion VALUES (318,'Pelican',70000,25,33,111,5);
INSERT INTO estacion VALUES (319,'Jaguar',80000,26,34,111,5); 
INSERT INTO estacion VALUES (320,'Armadillo',90000,27,35,111,5); 
INSERT INTO estacion VALUES (321,'Snake',90000,28,36,112,5); 
INSERT INTO estacion VALUES (322,'Oasis',9000,29,37,112,5);
INSERT INTO estacion VALUES (323,'Fisher',60000,30,38,112,5);
INSERT INTO estacion VALUES (324,'Crane',50000,31,40,114,6);
INSERT INTO estacion VALUES (325,'Gecko',50000,32,41,114,6);
INSERT INTO estacion VALUES (326,'Capuchin',50000,33,42,114,6);


-- Empleado_inteligencia --

insert into empleado_inteligencia VALUES (1,27948046,'09-JAN-1990','Diego','Miguel','Bastardo','Jurado',2,
LIC('Venezuela','5555'),
CARACT(bfilename('MEDIA_DIR','empleado_ing.jpg'),bfilename('MEDIA_DIR','huella_dactilar.jpg'),bfilename('MEDIA_DIR','huella_retina.jpg'),179,71,'Verdes','Buena'),
04248569544,
alias_nt(ALIAS_('Juan Luis Gomez',bfilename('MEDIA_DIR','alias1.jpg'),'21-OCT-1970','Rusia','2154879','Marron','AV Centuri prim 1234','30-SEP-2020')),
'AV ALitisis',
IDIOM('Español','Ingles','Arabe','Frances','Italiano','Ruso'),
'Universitario',11,101,
FAMILIAR('Miguel BAstardo','03-MAY-1970','Papa',0425841436),
FAMILIAR('Cristy Jurado','24-NOV-1971','Mama',0425841436)
);

insert into empleado_inteligencia VALUES (2,27234520,'09-JAN-1985','Anthony','Monsalve','BArrios','PEdrino',2,
LIC('Colombia','20555'),
CARACT(bfilename('MEDIA_DIR','empleado_ing.jpg'),bfilename('MEDIA_DIR','huella_dactilar.jpg'),bfilename('MEDIA_DIR','huella_retina.jpg'),165, 65,'Marrones','Regular'),
0424852544,
alias_nt(ALIAS_('PEdro Perez',bfilename('MEDIA_DIR','alias1.jpg'),'21-OCT-1960','Afganistan','55868','Verde','Avenida el cuartel','09-OCT-2021')),
'Catialamar',
IDIOM('Español','Ingles','Arabe','Frances','Italiano','Aleman'),
'Postgrado',16,102,
FAMILIAR('Pedro Infante','21-MAY-1981','Tio',0425841436),
FAMILIAR('Gabriel Concepcion','20-OCT-1990','Hermanastro',0425841436)
);

-- Historico_cargo --
INSERT into historico_cargo values ('02-DEC-2031',null,'Agente',1,300,1);
INSERT into historico_cargo values ('04-DEC-2031',null,'Agente',2,301,1);
INSERT into historico_cargo values ('08-DEC-2031',null,'Agente',3,314,3);
INSERT into historico_cargo values ('01-NOV-2031',null,'Agente',4,310,2);
INSERT into historico_cargo values ('19-NOV-2031',null,'Agente',5,320,5);
INSERT into historico_cargo values ('02-NOV-2032',null,'Agente',6,302,1);
INSERT into historico_cargo values ('12-NOV-2032',null,'Agente',7,305,1);
INSERT into historico_cargo values ('20-DEC-2031',null,'Agente',8,307,2);


-- Informantes --
INSERT INTO informante VALUES(1,'Nepistedes',2,null,null,null,null,'02-DEC-2031',1,300,1);
INSERT INTO informante VALUES(2,'Proteo',3,null,null,null,null,'02-DEC-2031',1,300,1);
INSERT INTO informante VALUES (3,'Altair',2,null,null,null,null,'02-DEC-2031',1,300,1);
INSERT INTO informante VALUES (4,'Chuo',3,null,null,null,null,'02-DEC-2031',1,300,1); -- informante de segundo empleado de inteligencia 

-- Historico de Pago --

INSERT INTO historico_pago values (1,'02-DEC-2031',200,6,2);


-- Hechos crudos -- 

INSERT INTO hecho_crudo VALUES (1,'Comprobación experimental de los efectos enzimáticos del veneno de serpiente cascabel',
'abierta', 'individuos',
'Cientos de personas a nivel mundial, sobre todo en los países selváticos o desérticos, perecen al año por mordeduras de serpientes de cascabel (Crotalus sp.), una de las más venenosas del continente americano. Se estima que en pocas horas luego de la mordedura, el efecto neurotóxico de la serpiente acaba con la vida de un hombre adulto. Muchos laboratorios locales emprenden la manufactura de antídotos, pero es costoso y toma mucho tiempo de elaboración. Un estudio más intensivo de la naturaleza de estos venenos sería la clave para poder emprender soluciones a corto plazo más efectivas ante la mordedura de estas serpientes.',
91, TO_DATE('2031/12/24 14:31:05', 'yyyy/mm/dd hh24:mi:ss'), 90, TO_DATE('2032/01/09 11:20:04', 'yyyy/mm/dd hh24:mi:ss'),
2, null, null, TO_DATE('2032/01/24 14:31:05', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

INSERT INTO hecho_crudo VALUES (2,'El veneno de la serpiente Cascabel es una proteína y por lo tanto puede ser neutralizado a través de variaciones de temperatura',
'abierta', 'individuos',
'Se contará con un equipo de laboratorio completo, así como con los reactivos necesarios (bases y ácidos, veneno de cascabel en estado puro), además de medidores de pH, termómetros, un mechero y hielo seco. Además, se emplearán para ello ratones de laboratorio (12 aprox). El experimento consistirá en inyectar el veneno a un primer ratón (control) y medir el tiempo que toma en surtir efecto. Luego someter el veneno a la acción de un agente (temperatura o pH) en distintos grados e inyectarlo a otros ratones y medir el tiempo de efectividad del veneno para tomar nota de las variaciones (lentitud o inefectividad).',
78, TO_DATE('2031/12/28 04:31:05', 'yyyy/mm/dd hh24:mi:ss'), 79, TO_DATE('2032/01/19 12:20:04', 'yyyy/mm/dd hh24:mi:ss'),
2, null, null, TO_DATE('2031/12/28 04:31:05', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

INSERT INTO hecho_crudo VALUES (3,'Los venenos en la naturaleza no son más que enzimas modificadas para una función defensiva o depredadora',
'abierta', 'individuos',
'El veneno de las serpientes, en ese sentido, es una enzima digestiva que hace letal su mordedura, y por eso puede ser estudiada como si fuera una proteína cualquiera, y responder por lo tanto al calor y al pH como lo hacen estos compuestos. Un análisis bioquímico de esta naturaleza permitiría hallar debilidades en el veneno explotables en la elaboración de un antídoto o de tratamientos alternativos para los mordidos.',
89, TO_DATE('2031/12/30 10:22:05', 'yyyy/mm/dd hh24:mi:ss'), 87, TO_DATE('2032/02/01 10:14:04', 'yyyy/mm/dd hh24:mi:ss'),
2, null, null, TO_DATE('2031/12/30 10:22:05', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

INSERT INTO hecho_crudo VALUES (4,'Todo sobre los hombres que vendieron la Copa del Mundo a Qatar',
'secreta', 'países',
'En los últimos años, numerosos escándalos de corrupción, sospechas de sobornos y posibles extorsiones han rodeado muchas de las decisiones anunciadas por la FIFA. En diciembre de 2010, la mayor institución del fútbol mundial protagonizó uno de los episodios que más controversia ha generado en la historia de la FIFA al anunciar la elección de Qatar como país anfitrión de la edición de 2022 de la Copa del Mundo. ¿Cómo es posible que un país con un clima tan cálido como para no poder albergar la competición en verano al finalizar la temporada regular de fútbol, cuya afición al fútbol es residual, pero que está regido por mandatarios ricos y poderosos, sea el mejor candidato posible?',
97, TO_DATE('2032/01/14 07:00:22', 'yyyy/mm/dd hh24:mi:ss'), 100, TO_DATE('2032/03/19 17:20:04', 'yyyy/mm/dd hh24:mi:ss'),
3, null, null, TO_DATE('2032/01/14 07:00:22', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

INSERT INTO hecho_crudo VALUES (5,'Cómo se adjudicó el Mundial de Qatar y la corrupción en la FIFA',
'secreta', 'países',
'En diciembre de 2010 la mayor institución del fútbol mundial protagonizó uno de los episodios que más controversia ha generado en su centenaria historia al anunciar la elección de Qatar. ¿Cómo es posible que un país con un clima tan tórrido como para no poder albergar la competición en verano al finalizar la temporada regular de fútbol, cuya afición al fútbol es residual, pero que está regido por mandatarios poderosos, sea el mejor candidato posible?',
80, TO_DATE('2032/02/18 00:31:05', 'yyyy/mm/dd hh24:mi:ss'), 79, TO_DATE('2032/03/02 20:50:14', 'yyyy/mm/dd hh24:mi:ss'),
3, null, null, TO_DATE('2032/02/18 00:31:05', 'yyyy/mm/dd hh24:mi:ss'), 1, 300,1);

INSERT INTO hecho_crudo VALUES (6,'El puro negocio: un Mundial cada dos años sí, una SuperLiga no',
'secreta', 'países',
'Infantino dice que el prestigio del Mundial no depende de su frecuencia. Claro, no depende de que sea cada dos años, pero queremos que sea cada dos años. Los que mandan en el fútbol, los que dicen que el fútbol es del pueblo, hablan de que los ingresos aumentarían de 3,9 mil millones de euros a más de 10 mil millones en los próximos cuatro años. Esto lo tenéis claro, ¿no? El negocio. El puro negocio. Un Mundial cada dos años sí, una SuperLiga no. Las incongruencias de los corbatas que rigen el fútbol y que no comprenden la importancia de cuidar el deporte y no solo ganar dinero con el fútbol. La diferencia es abismal.',
100, TO_DATE('2032/03/30 13:27:15', 'yyyy/mm/dd hh24:mi:ss'), 91, TO_DATE('2032/03/31 05:18:22', 'yyyy/mm/dd hh24:mi:ss'),
3, null, null, TO_DATE('2032/03/30 13:27:15', 'yyyy/mm/dd hh24:mi:ss'), 1, 300,1);

INSERT INTO hecho_crudo VALUES (7,'Qué dice el mensaje oculto en el paracaídas del robot espacial de la NASA',
'técnica', 'eventos',
'La Nasa logró el pasado jueves un importante avance en la exploración espacial. El robot explorador Perseverance de la agencia espacial estadounidense llegó a Marte, tras un viaje de cerca de 480 millones de kilómetros que inició en julio de 2020. Se trata del robot más sofisticado jamás enviado al espacio y tendrá como objetivo buscar evidencia para responder grandes preguntas como si hay señales concretas de vida microbiana pasada en Marte.',
75, TO_DATE('2032/07/24 17:00:22', 'yyyy/mm/dd hh24:mi:ss'), 80, TO_DATE('2032/08/01 23:00:00', 'yyyy/mm/dd hh24:mi:ss'),
2, null, null, TO_DATE('2032/07/24 17:00:22', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

INSERT INTO hecho_crudo VALUES (8,'Descubren el mensaje secreto de la NASA en el Perseverance que llegó a Marte',
'técnica', 'eventos',
'Hasta la fecha, nunca antes la NASA había sido capaz de conseguir emitir en directo el momento exacto en el que el rover se posaba sobre la superficie de ningún planeta y, por ello, el logro técnico conseguido en esta ocasión era sobresaliente: poder emitir en perfecto streaming el gran momento de la misión era fundamental. Y, por esta razón, la NASA incluyó un guiño en la misión solo al alcance de los ojos más avezados',
89, TO_DATE('2032/07/28 10:31:05', 'yyyy/mm/dd hh24:mi:ss'), 100, TO_DATE('2032/09/09 09:09:14', 'yyyy/mm/dd hh24:mi:ss'),
2, null, null, TO_DATE('2032/07/28 10:31:05', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

INSERT INTO hecho_crudo VALUES (9,'El enorme paracaídas que utilizó el rover para posarse sobre suelo marciano',
'técnica', 'eventos',
'Clark usó un código binario oculto en las tiras naranjas y blancas del paracaídas para deletrear la famosa frase del vigesimosexto presidente de los Estados Unidos, que también es una suerte de mantra para la agencia espacial estadounidense y puede leerse en muchas de sus instalaciones.',
100, TO_DATE('2032/08/30 11:46:51', 'yyyy/mm/dd hh24:mi:ss'), 99, TO_DATE('2032/09/05 15:04:07', 'yyyy/mm/dd hh24:mi:ss'),
2, null, null, TO_DATE('2032/08/30 11:46:51', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

-- Pieza Inteligencia --
INSERT INTO pieza_inteligencia VALUES (1, 120.50, TO_DATE('2032/02/14 17:20:15', 'yyyy/mm/dd hh24:mi:ss'),
null, 2, 1, TO_DATE('2032/02/14 17:20:15', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);


-- Relacion  Pieza Hecho
INSERT INTO p_h VALUES (1,1);
INSERT INTO p_h VALUES (2,1);
INSERT INTO p_h VALUES (3,1);

-- Tema Pieza Inteligencia
INSERT INTO tema VALUES (1,'Biología', 'El estudio de la vida es una fuente inagotable de misterios y la curiosidad una fuente sin fin de interrogantes que continuamente nos obliga a hacernos numerosas preguntas, y en el momento que tienes una resuelta, su respuesta te lleva inmediatamente a otras.',
'Serpientes');

-- Relacion Tema
INSERT INTO p_t VALUES (1,1);

-- Cliente
INSERT INTO cliente VALUES (1,'Sociedad Bióloga de América', CONTACT('José Miguel', 'Monsalve', 'Barrios', '0414212222', 'N') , 28, 108);

-- historico de venta
INSERT INTO hist_venta VALUES (1, TO_DATE('2032/02/27 11:20:15', 'yyyy/mm/dd hh24:mi:ss'), 150.12, 1, 1);



-- ////////////////////// PIEZA DE INTELIGENCIA 2 ///////////////////////////////

-- Hecho Crudo -- 


-- Pieza Inteligencia --
INSERT INTO pieza_inteligencia VALUES (2, 1000.20, TO_DATE('2032/04/04 18:20:15', 'yyyy/mm/dd hh24:mi:ss'),
null, 3, 2, TO_DATE('2032/04/04 18:20:15', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

-- Relacion  Pieza Hecho
INSERT INTO p_h VALUES (4,2);
INSERT INTO p_h VALUES (5,2);
INSERT INTO p_h VALUES (6,2);

-- Tema Pieza Inteligencia
INSERT INTO tema VALUES (2,'Deportes', 'Investigaciones en la actualidad del mundo del deporte',
'Fútbol');

-- Relacion Tema
INSERT INTO p_t VALUES (2,2);

-- Cliente
INSERT INTO cliente VALUES (2,'DirecTV Sports', CONTACT('Pablo', 'Giralt', 'Total', '089445161'), 'N', 18, 104);

-- historico de venta
INSERT INTO hist_venta VALUES (2, TO_DATE('2032/04/04 18:20:15', 'yyyy/mm/dd hh24:mi:ss'), 1100, 2, 2);


-- ////////////////////// PIEZA DE INTELIGENCIA 3 ///////////////////////////////

-- Hecho Crudo -- 


-- Pieza Inteligencia --
INSERT INTO pieza_inteligencia VALUES (3, 9990, TO_DATE('2032/08/31 11:46:51', 'yyyy/mm/dd hh24:mi:ss'),
null, 2, 3, TO_DATE('2032/08/31 11:46:51', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

-- Relacion  Pieza Hecho
INSERT INTO p_h VALUES (7,3);
INSERT INTO p_h VALUES (8,3);
INSERT INTO p_h VALUES (9,3);

-- Tema Pieza Inteligencia
INSERT INTO tema VALUES (3,'Astronomía', 'el estudio del universo, las teorías cosmológicas y los diversos cuerpos celestes, entre otros',
'La NASA');

-- Relacion Tema
INSERT INTO p_t VALUES (3,3);

-- Cliente
INSERT INTO cliente VALUES (3,'SpaceX', CONTACT('Elon', 'Musk', 'Reeve', '189445161'), 'N', 24, 106);

-- historico de venta
INSERT INTO hist_venta VALUES (3, TO_DATE('2032/08/31 11:46:51', 'yyyy/mm/dd hh24:mi:ss'), 9991, 3, 3);
