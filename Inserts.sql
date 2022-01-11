-- Inserts de la aplicacion 

CREATE SEQUENCE incremento_id_pais
INCREMENT BY 1
START WITH 100;

CREATE SEQUENCE incremento_id_ciudad
INCREMENT BY 1
START WITH 10;


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
