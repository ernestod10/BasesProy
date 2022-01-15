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
INSERT INTO empleado_jefe VALUES (34,'Cristiano','Ronald0','Estacion',6); -- Jefe de prueba

-- Oficina Principal -- 

INSERT INTO oficina_principal VALUES (1,'Director AII',true,1,10,100);
INSERT INTO oficina_principal VALUES (2,'Denesik',false,2,17,103);
INSERT INTO oficina_principal VALUES (3,'Hexagono',false,3,24,106);
INSERT INTO oficina_principal VALUES (4,'Latina',false,4,28,108);
INSERT INTO oficina_principal VALUES (5,'Effertz',false,5,32,110);
INSERT INTO oficina_principal VALUES (6,'Bechtelar',false,6,39,113);


-- Estacion -- 
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Parrot',50000,7,11,101,1);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Monkey',20000,8,12,101,1); 
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Eagle',30000,9,13,101,1);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Wolf',35000,10,14,102,1);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'bear',40000,11,15,102,1);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Buffalo',20000,12,16,102,1);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Lizard',60000,13,18,104,2);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Lemur',60000,14,19,104,2);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Seal',30000,15,20,104,2);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'fox',30000,16,21,105,2);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Bird',20000,17,22,105,2);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Goose',50000,18,23,105,2);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Winterfel',50000,19,25,107,3);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Koala',40000,20,26,107,3);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Orca',300000,21,27,107,3);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Vulture',30000,22,29,109,4);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Duck',10000,23,30,109,4);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Cat',60000,24,31,109,4);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Pelican',70000,25,33,111,5);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Jaguar',80000,26,34,111,5); 
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Armadillo',90000,27,35,111,5); 
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Armadillo',90000,28,36,112,5); 
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Oasis',9000,29,37,112,5);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Fisher',60000,30,38,112,5);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Crane',50000,31,40,114,6);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Gecko',50000,32,41,114,6);
INSERT INTO estacion VALUES (incremento_id_estacion.nextval,'Capuchin',50000,33,42,114,6);


-- Empleado_inteligencia --

