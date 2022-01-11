-- Pais --
INSERT INTO pais (nombre, region) VALUES ('Suiza','Eu'); -- Sede Central
INSERT INTO pais (nombre, region) VALUES ('Grecia','Eu');
INSERT INTO pais (nombre, region) VALUES ('Portugal','Eu');
INSERT INTO pais (nombre, region) VALUES ('Singapur','As'); -- Oficina de area
INSERT INTO pais (nombre, region) VALUES ('Qatar','As');
INSERT INTO pais (nombre, region) VALUES ('Indonesia','As');
INSERT INTO pais (nombre, region) VALUES ('Estados Unidos','AmN'); -- Oficina de area
INSERT INTO pais (nombre, region) VALUES ('Costa Rica','AmN');
INSERT INTO pais (nombre, region) VALUES ('Argentina','AmS');-- Oficina de area
INSERT INTO pais (nombre, region) VALUES ('Ecuador','AmS');
INSERT INTO pais (nombre, region) VALUES ('Egipto','Af');-- Oficina de area
INSERT INTO pais (nombre, region) VALUES ('Marruecos','Af');
INSERT INTO pais (nombre, region) VALUES ('Cabo Verde','Af');
INSERT INTO pais (nombre, region) VALUES ('Australia','Oc');-- Oficina de area
INSERT INTO pais (nombre, region) VALUES ('Nueva Zelanda','Oc');

-- Ciudad --
INSERT INTO ciudad (nombre,pais_id) VALUES ('Ginebra',100); -- central
INSERT INTO ciudad (nombre,pais_id) VALUES('Atenas',101);
INSERT INTO ciudad (nombre,pais_id) VALUES('Oya',101);
INSERT INTO ciudad (nombre,pais_id) VALUES('Argos',101);
INSERT INTO ciudad (nombre,pais_id) VALUES('Lisboa',102);
INSERT INTO ciudad (nombre,pais_id) VALUES('Amadora',102);
INSERT INTO ciudad (nombre,pais_id) VALUES('Esposende',102);
INSERT INTO ciudad (nombre,pais_id) VALUES('Ciudad de Singapur',103); -- Central
INSERT INTO ciudad (nombre,pais_id) VALUES('Doha',104);
INSERT INTO ciudad (nombre,pais_id) VALUES('Dukhan',104);
INSERT INTO ciudad (nombre,pais_id) VALUES('Lusail',104);
INSERT INTO ciudad (nombre,pais_id) VALUES('Yakarta',105);
INSERT INTO ciudad (nombre,pais_id) VALUES('Surabaya',105);
INSERT INTO ciudad (nombre,pais_id) VALUES('Medan',105);
INSERT INTO ciudad (nombre,pais_id) VALUES('Washington D. C.',106); -- Central
INSERT INTO ciudad (nombre,pais_id) VALUES('Heredia',107);
INSERT INTO ciudad (nombre,pais_id) VALUES('Escazú',107);
INSERT INTO ciudad (nombre,pais_id) VALUES('Puntarenas',107);
INSERT INTO ciudad (nombre,pais_id) VALUES('Buenos Aires',108);-- Central
INSERT INTO ciudad (nombre,pais_id) VALUES('Machala',109);
INSERT INTO ciudad (nombre,pais_id) VALUES('Quito',109);
INSERT INTO ciudad (nombre,pais_id) VALUES('Salinas',109);
INSERT INTO ciudad (nombre,pais_id) VALUES('El Cairo',110);-- Central
INSERT INTO ciudad (nombre,pais_id) VALUES('Casablanca',111);
INSERT INTO ciudad (nombre,pais_id) VALUES('Fez',111);
INSERT INTO ciudad (nombre,pais_id) VALUES('Salé',111);
INSERT INTO ciudad (nombre,pais_id) VALUES('Praia',112);
INSERT INTO ciudad (nombre,pais_id) VALUES('Mindelo',112);
INSERT INTO ciudad (nombre,pais_id) VALUES('Santa Maria',112);
INSERT INTO ciudad (nombre,pais_id) VALUES('Sydney',113);-- Central
INSERT INTO ciudad (nombre,pais_id) VALUES('Auckland',114);
INSERT INTO ciudad (nombre,pais_id) VALUES('Wellington',114);
INSERT INTO ciudad (nombre,pais_id) VALUES('Hamilton',114);

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

Create view 
detalle_oficina AS
SELECT oficina_principal.nombre,oficina_principal.ciudad_id,oficina_principal.ciudad_pais_id,oficina_principal.empleado_jefe_id
p.nombre as 'Pais',
ci.nombre as 'Ciudad',
e.nombre || e.apellido as 'Director',
e.tipo 'Rango'
FROM oficina_principal
JOIN pais p ON id_pais = oficina_principal.ciudad_pais_id
JOIN ciudad ci ON id_ciudad = oficina_principal.ciudad_id
JOIN empleado_jefe e ON id = oficina_principal.empleado_jefe_id
