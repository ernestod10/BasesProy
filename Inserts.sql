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
null, 1, 1, TO_DATE('2032/02/14 17:20:15', 'yyyy/mm/dd hh24:mi:ss'), 0, 0, 0);

-- Relacion  Pieza Hecho
INSERT INTO p_h VALUES (1,1);
INSERT INTO p_h VALUES (2,1);
INSERT INTO p_h VALUES (3,1);

-- Tema Pieza Inteligencia
INSERT INTO tema VALUES (1,'Biología', 'El estudio de la vida es una fuente inagotable de misterios y la curiosidad una fuente sin fin de interrogantes que continuamente nos obliga a hacernos numerosas preguntas, y en el momento que tienes una resuelta, su respuesta te lleva inmediatamente a otras.',
'Serpientes');

-- Relacion  Tema
INSERT INTO p_t VALUES (1,1);

-- cliente
INSERT INTO cliente VALUES (1,'Sociedad Bióloga de América', CONTACT('José Miguel', 'Monsalve', 'Barrios', '0414212222', 'N', ),
'Serpientes', 29, 108);