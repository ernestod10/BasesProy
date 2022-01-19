-- Inserts de la aplicacion 

-- Incremento pais
CREATE SEQUENCE incremento_id_pais
INCREMENT BY 1
START WITH 100;

-- Incremento ciudad
CREATE SEQUENCE incremento_id_ciudad INCREMENT BY 1 START WITH 10;

-- Incremento hecho crudo
CREATE SEQUENCE incr_hc INCREMENT BY 1 START WITH 1;

-- Incremento Pieza inteligencia
CREATE SEQUENCE incr_pi INCREMENT BY 1 START WITH 1;

-- Pais --
INSERT INTO pais VALUES (incremento_id_pais.nextval,'Suiza','Eu'); -- Sede Central
INSERT INTO pais VALUES (incremento_id_pais.nextval,'Grecia','Eu');
INSERT INTO pais VALUES (incremento_id_pais.nextval,'Portugal','Eu');
INSERT INTO pais VALUES (incremento_id_pais.nextval,'Singapur','As'); -- Oficina de area
INSERT INTO pais VALUES (incremento_id_pais.nextval,'Qatar','As');
INSERT INTO pais VALUES (incremento_id_pais.nextval,'Indonesia','As');
INSERT INTO pais VALUES (incremento_id_pais.nextval,'Estados Unidos','AmN'); -- Oficina de area
INSERT INTO pais VALUES (incremento_id_pais.nextval,'Costa Rica','AmN');
INSERT INTO pais VALUES (incremento_id_pais.nextval,'Argentina','AmS');-- Oficina de area
INSERT INTO pais VALUES (incremento_id_pais.nextval,'Ecuador','AmS');
INSERT INTO pais VALUES (incremento_id_pais.nextval,'Egipto','Af');-- Oficina de area
INSERT INTO pais VALUES (incremento_id_pais.nextval,'Marruecos','Af');
INSERT INTO pais VALUES (incremento_id_pais.nextval,'Cabo Verde','Af');
INSERT INTO pais VALUES (incremento_id_pais.nextval,'Australia','Oc');-- Oficina de area
INSERT INTO pais VALUES (incremento_id_pais.nextval,'Nueva Zelanda','Oc');

-- Ciudad --
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Ginebra',100); -- central
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Atenas',101);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Oya',101);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Argos',101);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Lisboa',102);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Amadora',102);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Esposende',102);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Ciudad de Singapur',103); -- Central
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Doha',104);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Dukhan',104);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Lusail',104);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Yakarta',105);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Surabaya',105);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Medan',105);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Washington D. C.',106); -- Central
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Heredia',107);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Escazú',107);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Puntarenas',107);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Buenos Aires',108);-- Central
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Machala',109);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Quito',109);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Salinas',109);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'El Cairo',110);-- Central
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Casablanca',111);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Fez',111);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Salé',111);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Praia',112);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Mindelo',112);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Santa Maria',112);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Sydney',113);-- Central
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Auckland',114);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Wellington',114);
INSERT INTO ciudad VALUES(incremento_id_ciudad.nextval,'Hamilton',114);

-- Empleado Jefe --

INSERT INTO empleado_jefe VALUES (1,'Dannel','Conring','CEO',NULL);
INSERT INTO empleado_jefe VALUES (2,'Wilmar','Cisland','Area',NULL);
INSERT INTO empleado_jefe VALUES (3,'Kile','Smith','Area',NULL);
INSERT INTO empleado_jefe VALUES (4,'Leon','Rodriguez','Area',NULL);
INSERT INTO empleado_jefe VALUES (5,'Mirabelle','Braley','Area',NULL);
INSERT INTO empleado_jefe VALUES (6,'Andrew','Jordan','Area',NULL);

-- Oficina Principal -- 

INSERT INTO oficina_principal VALUES (1,'Director AII',true,1,10,100);
INSERT INTO oficina_principal VALUES (2,'Denesik',false,2,17,103);
INSERT INTO oficina_principal VALUES (3,'Hexagono',false,3,24,106);
INSERT INTO oficina_principal VALUES (4,'Latina',false,4,28,108);
INSERT INTO oficina_principal VALUES (5,'Effertz',false,5,32,110);
INSERT INTO oficina_principal VALUES (6,'Bechtelar',false,6,39,113);

-- Vista de Oficina_principal con jefe y localizacion

create or replace view detalle_oficina(Oficina,Nombre,Ciudad,Pais,Director)
As SELECT ofi.id_oficina,ofi.nombre,ci.nombre,pa.nombre,e.nombre ||' '|| e.apellido 
from oficina_principal ofi, ciudad ci, pais pa, empleado_jefe e
where ofi.ciudad_id=ci.id_ciudad and ofi.ciudad_pais_id = pa.id_pais and ofi.empleado_jefe_id = e.id;



-- ////////////////////// PIEZA DE INTELIGENCIA 1 ///////////////////////////////

-- Hecho Crudo -- 
INSERT INTO hecho_crudo VALUES (1,'Comprobación experimental de los efectos enzimáticos del veneno de serpiente cascabel',
'abierta', 'individuos',
'Cientos de personas a nivel mundial, sobre todo en los países selváticos o desérticos, perecen al año por mordeduras de serpientes de cascabel (Crotalus sp.), una de las más venenosas del continente americano. Se estima que en pocas horas luego de la mordedura, el efecto neurotóxico de la serpiente acaba con la vida de un hombre adulto. Muchos laboratorios locales emprenden la manufactura de antídotos, pero es costoso y toma mucho tiempo de elaboración. Un estudio más intensivo de la naturaleza de estos venenos sería la clave para poder emprender soluciones a corto plazo más efectivas ante la mordedura de estas serpientes.'
91, TO_DATE('2031/12/24 14:31:05', 'yyyy/mm/dd hh24:mi:ss'), 90, TO_DATE('2032/01/09 11:20:04', 'yyyy/mm/dd hh24:mi:ss'),
2, null, null, TO_DATE('2032/01/24 14:31:05', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

INSERT INTO hecho_crudo VALUES (2,'El veneno de la serpiente Cascabel es una proteína y por lo tanto puede ser neutralizado a través de variaciones de temperatura',
'abierta', 'individuos',
'Se contará con un equipo de laboratorio completo, así como con los reactivos necesarios (bases y ácidos, veneno de cascabel en estado puro), además de medidores de pH, termómetros, un mechero y hielo seco. Además, se emplearán para ello ratones de laboratorio (12 aprox). El experimento consistirá en inyectar el veneno a un primer ratón (control) y medir el tiempo que toma en surtir efecto. Luego someter el veneno a la acción de un agente (temperatura o pH) en distintos grados e inyectarlo a otros ratones y medir el tiempo de efectividad del veneno para tomar nota de las variaciones (lentitud o inefectividad).'
78, TO_DATE('2031/12/28 04:31:05', 'yyyy/mm/dd hh24:mi:ss'), 79, TO_DATE('2032/01/19 12:20:04', 'yyyy/mm/dd hh24:mi:ss'),
2, null, null, TO_DATE('2031/12/28 04:31:05', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

INSERT INTO hecho_crudo VALUES (3,'Los venenos en la naturaleza no son más que enzimas modificadas para una función defensiva o depredadora',
'abierta', 'individuos',
'El veneno de las serpientes, en ese sentido, es una enzima digestiva que hace letal su mordedura, y por eso puede ser estudiada como si fuera una proteína cualquiera, y responder por lo tanto al calor y al pH como lo hacen estos compuestos. Un análisis bioquímico de esta naturaleza permitiría hallar debilidades en el veneno explotables en la elaboración de un antídoto o de tratamientos alternativos para los mordidos.'
89, TO_DATE('2031/12/30 10:22:05', 'yyyy/mm/dd hh24:mi:ss'), 87, TO_DATE('2032/02/01 10:14:04', 'yyyy/mm/dd hh24:mi:ss'),
2, null, null, TO_DATE('2031/12/30 10:22:05', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

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
INSERT INTO cliente VALUES (1,'Sociedad Bióloga de América', CONTACT('José Miguel', 'Monsalve', 'Barrios', '0414212222', 'N') , 29, 108);

-- historico de venta
INSERT INTO hist_venta VALUES (1, TO_DATE('2032/02/27 11:20:15', 'yyyy/mm/dd hh24:mi:ss'), 150.12, 1, 1);



-- ////////////////////// PIEZA DE INTELIGENCIA 2 ///////////////////////////////

-- Hecho Crudo -- 
INSERT INTO hecho_crudo VALUES (4,'Todo sobre los hombres que vendieron la Copa del Mundo a Qatar',
'secreta', 'países',
'En los últimos años, numerosos escándalos de corrupción, sospechas de sobornos y posibles extorsiones han rodeado muchas de las decisiones anunciadas por la FIFA. En diciembre de 2010, la mayor institución del fútbol mundial protagonizó uno de los episodios que más controversia ha generado en la historia de la FIFA al anunciar la elección de Qatar como país anfitrión de la edición de 2022 de la Copa del Mundo. ¿Cómo es posible que un país con un clima tan cálido como para no poder albergar la competición en verano al finalizar la temporada regular de fútbol, cuya afición al fútbol es residual, pero que está regido por mandatarios ricos y poderosos, sea el mejor candidato posible?'
97, TO_DATE('2032/01/14 07:00:22', 'yyyy/mm/dd hh24:mi:ss'), 100, TO_DATE('2032/03/19 17:20:04', 'yyyy/mm/dd hh24:mi:ss'),
3, null, null, TO_DATE('2032/01/14 07:00:22', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

INSERT INTO hecho_crudo VALUES (5,'Cómo se adjudicó el Mundial de Qatar y la corrupción en la FIFA',
'secreta', 'países',
'En diciembre de 2010 la mayor institución del fútbol mundial protagonizó uno de los episodios que más controversia ha generado en su centenaria historia al anunciar la elección de Qatar. ¿Cómo es posible que un país con un clima tan tórrido como para no poder albergar la competición en verano al finalizar la temporada regular de fútbol, cuya afición al fútbol es residual, pero que está regido por mandatarios poderosos, sea el mejor candidato posible?'
80, TO_DATE('2032/02/18 00:31:05', 'yyyy/mm/dd hh24:mi:ss'), 79, TO_DATE('2032/03/02 20:50:14', 'yyyy/mm/dd hh24:mi:ss'),
3, null, null, TO_DATE('2032/02/18 00:31:05', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

INSERT INTO hecho_crudo VALUES (6,'El puro negocio: un Mundial cada dos años sí, una SuperLiga no',
'secreta', 'países',
'Infantino dice que el prestigio del Mundial no depende de su frecuencia. Claro, no depende de que sea cada dos años, pero queremos que sea cada dos años. Los que mandan en el fútbol, los que dicen que el fútbol es del pueblo, hablan de que los ingresos aumentarían de 3,9 mil millones de euros a más de 10 mil millones en los próximos cuatro años. Esto lo tenéis claro, ¿no? El negocio. El puro negocio. Un Mundial cada dos años sí, una SuperLiga no. Las incongruencias de los corbatas que rigen el fútbol y que no comprenden la importancia de cuidar el deporte y no solo ganar dinero con el fútbol. La diferencia es abismal.'
100, TO_DATE('2032/03/30 13:27:15', 'yyyy/mm/dd hh24:mi:ss'), 91, TO_DATE('2032/03/12 05:18:22', 'yyyy/mm/dd hh24:mi:ss'),
3, null, null, TO_DATE('2032/03/30 13:27:15', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

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
INSERT INTO hecho_crudo VALUES (7,'Qué dice el mensaje oculto en el paracaídas del robot espacial de la NASA',
'técnica', 'eventos',
'La Nasa logró el pasado jueves un importante avance en la exploración espacial. El robot explorador Perseverance de la agencia espacial estadounidense llegó a Marte, tras un viaje de cerca de 480 millones de kilómetros que inició en julio de 2020. Se trata del robot más sofisticado jamás enviado al espacio y tendrá como objetivo buscar evidencia para responder grandes preguntas como si hay señales concretas de vida microbiana pasada en Marte.'
75, TO_DATE('2032/07/24 17:00:22', 'yyyy/mm/dd hh24:mi:ss'), 80, TO_DATE('2032/08/01 23:00:00', 'yyyy/mm/dd hh24:mi:ss'),
2, null, null, TO_DATE('2032/07/24 17:00:22', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

INSERT INTO hecho_crudo VALUES (8,'Descubren el mensaje secreto de la NASA en el Perseverance que llegó a Marte',
'técnica', 'eventos',
'Hasta la fecha, nunca antes la NASA había sido capaz de conseguir emitir en directo el momento exacto en el que el 'rover' se posaba sobre la superficie de ningún planeta y, por ello, el logro técnico conseguido en esta ocasión era sobresaliente: poder emitir en perfecto 'streaming' el gran momento de la misión era fundamental. Y, por esta razón, la NASA incluyó un guiño en la misión solo al alcance de los ojos más avezados'
89, TO_DATE('2032/07/28 10:31:05', 'yyyy/mm/dd hh24:mi:ss'), 100, TO_DATE('2032/09/09 09:09:14', 'yyyy/mm/dd hh24:mi:ss'),
2, null, null, TO_DATE('2032/07/28 10:31:05', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

INSERT INTO hecho_crudo VALUES (9,'El enorme paracaídas que utilizó el rover para posarse sobre suelo marciano',
'técnica', 'eventos',
'Clark usó un código binario oculto en las tiras naranjas y blancas del paracaídas para deletrear la famosa frase del vigesimosexto presidente de los Estados Unidos, que también es una suerte de mantra para la agencia espacial estadounidense y puede leerse en muchas de sus instalaciones.'
100, TO_DATE('2032/08/30 11:46:51', 'yyyy/mm/dd hh24:mi:ss'), 99, TO_DATE('2032/09/05 15:04:07', 'yyyy/mm/dd hh24:mi:ss'),
2, null, null, TO_DATE('2032/08/30 11:46:51', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

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
