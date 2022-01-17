--Creacion objetos
create or replace type LIC as object
(
    Pais VARCHAR2(15),
    Numero NUMBER
); 
/

create or replace type CARACT as object
(   
    fotografia BFILE,
    huella_digital BFILE, -- observacion pudiera ser un archivo 
    huella_retina BFILE, -- observacion
    altura_cm NUMBER(3),
    peso NUMBER(5,2),
    color_ojos VARCHAR2(15),
    vision VARCHAR2(15)
); 
/
create or replace type FAMILIAR as object
(   
    nombre VARCHAR2(25), 
    fec_nac DATE, 
    parentesco VARCHAR2(15), 
    tel_contacto NUMBER(10)
); 
/
create or replace type IDIOM as varray(6) of VARCHAR2(10); 
/
create or replace type ALIAS_ as object
(
    nombre VARCHAR2(25),
    foto BFILE,
    fec_nac DATE,
    pais VARCHAR2(30),
    doc_inden VARCHAR2(10),
    color_ojos VARCHAR2(15),
    direccion VARCHAR2(50),
    ult_fec_uso DATE
);
create or replace type alias_nt as table of ALIAS_; 
/
 
create or replace type IDIOM as varray(6) of VARCHAR2(10); 
/
create or replace type INFORMAC as object
(
    Pais VARCHAR2(15),
    Numero NUMBER
); 
/
create or replace type CONTACT as object
(
    Nombre VARCHAR2(15),
    apellido VARCHAR2(15),
    apellido2 VARCHAR2(15),
    telefono VARCHAR2(14),
    email VARCHAR2(15)
); 

/
---------------------------------------------------------------------------                TABLAS                ------------------------------------------------------------------------------- 


CREATE TABLE analistas_temas ( 
    emp_int_id               NUMBER NOT NULL,
    tema_id                  NUMBER NOT NULL,
    CONSTRAINT analistas_temas_pk PRIMARY KEY ( emp_int_id,tema_id )
);


CREATE TABLE area_interes (
    cliente_id  NUMBER NOT NULL,
    tema_id     NUMBER NOT NULL,
    CONSTRAINT area_interes_pk PRIMARY KEY ( cliente_id,tema_id )
);


CREATE TABLE ciudad (
    id_ciudad     NUMBER GENERATED ALWAYS as IDENTITY(START with 10 INCREMENT by 1),
    nombre        VARCHAR2 (22) NOT NULL,
    pais_id       NUMBER NOT NULL,
    CONSTRAINT ciudad_pk PRIMARY KEY ( id_ciudad,pais_id )
);

CREATE TABLE pais (
    id_pais  NUMBER GENERATED ALWAYS as IDENTITY(START with 100 INCREMENT by 1) PRIMARY KEY,
    nombre   VARCHAR2 (22)NOT NULL,
    region   VARCHAR2(10) NOT NULL,
    CONSTRAINT ck_region CHECK( region IN ('Eu','As','AmN', 'AmC', 'AmS', 'Af', 'Oc'))
);

CREATE TABLE cliente (
    id                   NUMBER NOT NULL PRIMARY KEY,
    nombre               VARCHAR2 (22)NOT NULL,
    contacto_empresa     CONTACT NOT NULL,
    exclusivo            NUMBER NOT NULL,
    ciudad_id            NUMBER NOT NULL,
    ciudad_pais_id       NUMBER NOT NULL
);


CREATE TABLE empleado_inteligencia (
    id_emp_int           NUMBER NOT NULL PRIMARY KEY,
    doc_identidad        NUMBER NOT NULL,
    fec_nac              DATE NOT NULL,
    nombre_pila          VARCHAR2(30) NOT NULL,
    segundo_nombre       VARCHAR2(25),
    apellido1            VARCHAR2(30) NOT NULL,
    apellido2            VARCHAR2(25) NOT NULL,
    nivel_seguridad      INT NOT NULL,
    licencia             LIC NOT NULL,
    caract               CARACT NOT NULL,
    telefono             NUMBER NOT NULL,
    alias_agente         alias_nt,
    calle                VARCHAR2(30) NOT NULL,
    idiomas              IDIOM NOT NULL,
    nivel_educativo      VARCHAR2 (22) NOT NULL,
    ciudad_id            NUMBER NOT NULL,
    ciudad_pais_id       NUMBER NOT NULL,
    familiar1            FAMILIAR,
    familiar2            FAMILIAR,
    CONSTRAINT ck_caract_peso CHECK (caract.peso > 0),
    CONSTRAINT ck_caract_altura CHECK (caract.altura_cm > 0),
    CONSTRAINT ck_emp_nivel_seguridad CHECK (nivel_seguridad > 0 and nivel_seguridad < 4)
) nested table alias_agente store as alias_nt_2;


CREATE TABLE empleado_jefe (
    id                NUMBER NOT NULL PRIMARY KEY,
    nombre            VARCHAR2 (22) NOT NULL,
    apellido          VARCHAR2 (22) NOT NULL,
    tipo              VARCHAR2(10) NOT NULL,
    empleado_jefe_id  NUMBER,
    CONSTRAINT ck_tipo_jefe CHECK( tipo IN ('Area','Estacion','CEO'))
);

CREATE TABLE estacion (
    id_estacion                   NUMBER NOT NULL,
    nombre                        VARCHAR2 (22) NOT NULL,
    presupuesto_anual             NUMBER NOT NULL,
    empleado_jefe_id              NUMBER NOT NULL UNIQUE,
    ciudad_id                     NUMBER NOT NULL,
    ciudad_pais_id                NUMBER NOT NULL,
    oficina_principal_id          NUMBER NOT NULL,
    CONSTRAINT estacion_pk PRIMARY KEY (id_estacion,oficina_principal_id),
    CONSTRAINT ck_presupuesto_anual CHECK (presupuesto_anual >= 0)
);

CREATE UNIQUE INDEX estacion__idx ON
    estacion (
        empleado_jefe_id
    ASC );


CREATE TABLE oficina_principal (
    id_oficina           NUMBER NOT NULL PRIMARY KEY,
    nombre               VARCHAR2 (22) NOT NULL,
    sede                 NUMBER NOT NULL,
    empleado_jefe_id     NUMBER NOT NULL,
    ciudad_id            NUMBER NOT NULL,
    ciudad_pais_id       NUMBER NOT NULL
);

CREATE UNIQUE INDEX oficina_principal__idx ON
    oficina_principal (
        empleado_jefe_id
    ASC );

--CREATE UNIQUE INDEX oficina_principal__idxv1 ON
--  oficina_principal (
--        ciudad_id_ciudad
--    ASC,
--        ciudad_pais_id_pais
--    ASC );


CREATE TABLE historico_cargo (
    fec_inicio                           DATE NOT NULL,
    fec_fin                              DATE,
    cargo                                Varchar(15) NOT NULL, 
    emp_int_id                           NUMBER NOT NULL,
    estacion_id                          NUMBER NOT NULL, 
    est_ofic_prin_id                     NUMBER NOT NULL,
    CONSTRAINT historico_cargo_pk PRIMARY KEY ( fec_inicio,emp_int_id,estacion_id,est_ofic_prin_id),
    CONSTRAINT ck_fec_hist_cargo CHECK (fec_fin >= fec_inicio)
);

CREATE TABLE informante (
    id_informante                                      NUMBER NOT NULL PRIMARY KEY,
    nombre_clave                                       VARCHAR2 (22) NOT NULL,
    empleado_jefe_id_A                                 NUMBER,
    hist_cg_fec_ini_A                                  DATE, 
    hist_cg_emp_int_id_A                               NUMBER, 
    hist_cg_est_id_A                                   NUMBER, 
    hist_cg_ofic_id_A                                  NUMBER,
    hist_cg_fec_ini                                    DATE NOT NULL, 
    hist_cg_emp_int_id                                 NUMBER NOT NULL, 
    hist_cg_est_id                                     NUMBER NOT NULL, 
    hist_cg_ofic_id                                    NUMBER NOT NULL,
    CONSTRAINT arc_1 CHECK ( ( ( hist_cg_fec_ini_A IS NOT NULL )AND ( hist_cg_emp_int_id IS NOT NULL )AND ( hist_cg_est_id_A IS NOT NULL )AND ( hist_cg_ofic_id_A IS NOT NULL )AND ( empleado_jefe_id_A IS NULL ) )
                                 OR ( ( empleado_jefe_id_A IS NOT NULL )AND ( hist_cg_fec_ini_A IS NULL )AND ( hist_cg_emp_int_id_A IS NULL )AND ( hist_cg_est_id_A IS NULL )AND ( hist_cg_ofic_id_A IS NULL ) ) )
);

CREATE TABLE historico_pago (
    id_pago_infor                          NUMBER NOT NULL,
    fecha                                  DATE NOT NULL,
    pago                                   NUMBER NOT NULL,
    hecho_crudo_id                         NUMBER,
    informante_id                          NUMBER NOT NULL,
    CONSTRAINT historico_pago_pk PRIMARY KEY ( id_pago_infor,informante_id),
    CONSTRAINT ck_pago CHECK (pago >= 0)
);

CREATE UNIQUE INDEX historico_pago__idx ON
    historico_pago (
        hecho_crudo_id
    ASC );


CREATE TABLE pieza_inteligencia (
    id                                                NUMBER NOT NULL PRIMARY KEY,
    precio_aproximado                                 NUMBER,
    fecha_construccion                                DATE,
    nivel_confiabilidad                               NUMBER,
    nivel_seguridad                                   INT NOT NULL,
    tema_id                                           NUMBER NOT NULL,
    hist_cg_fec_ini                                   DATE NOT NULL, 
    hist_cg_emp_int_id                                NUMBER NOT NULL, 
    hist_cg_est_id                                    NUMBER NOT NULL, 
    hist_cg_ofic_id                                   NUMBER NOT NULL,
    CONSTRAINT ck_precio_aproximado CHECK (precio_aproximado >= 0),
    CONSTRAINT ck_nivel_confiabilidad CHECK (nivel_confiabilidad >= 0 and nivel_confiabilidad <= 100),
    CONSTRAINT ck_pz_nivel_seguridad CHECK (nivel_seguridad > 0 and nivel_seguridad < 4)
);


CREATE TABLE hist_venta (
    id                     NUMBER NOT NULL,
    fecha_venta            DATE NOT NULL,
    total_precio_final     NUMBER NOT NULL,
    pieza_inteligencia_id  NUMBER NOT NULL,
    cliente_id             NUMBER NOT NULL,
    CONSTRAINT hist_venta_pk PRIMARY KEY ( id,pieza_inteligencia_id,cliente_id ),
    CONSTRAINT ck_total_precio_final CHECK (total_precio_final >= 0)
);

CREATE TABLE tema (
    id           NUMBER NOT NULL PRIMARY KEY,
    nombre       VARCHAR2 (22) NOT NULL,
    descripcion  VARCHAR2 (22) NOT NULL,
    topico       VARCHAR2 (22) NOT NULL
);

CREATE TABLE historico_seguridad (
    id           NUMBER NOT NULL PRIMARY KEY,
    emp_int_id   NUMBER NOT NULL,
    pieza_int_id     NUMBER NOT NULL
);

CREATE TABLE p_h (
    hecho_cdo_id                NUMBER NOT NULL,
    pieza_int_id                NUMBER NOT NULL,
    CONSTRAINT p_h_pk PRIMARY KEY ( hecho_cdo_id ,pieza_int_id)
);

CREATE TABLE p_t (
    pieza_int_id  NUMBER NOT NULL,
    tema_id       NUMBER NOT NULL,
    CONSTRAINT p_t_pk PRIMARY KEY ( pieza_int_id,tema_id )
);

CREATE TABLE hecho_crudo (
    id_hecho_cdo                                      NUMBER NOT NULL PRIMARY KEY,
    resumen                                           VARCHAR2 (50) NOT NULL,
    fuente                                            VARCHAR(25) NOT NULL,
    tipo_contenido                                    VARCHAR2 (12) NOT NULL,
    contenido                                         VARCHAR2 (80) NOT NULL,
    nivel_confi_ini                                   NUMBER NOT NULL,
    fec_obten                                         DATE NOT NULL,
    nivel_confi_fin                                   NUMBER,
    fec_fin_cierre                                    DATE,
    cantidad_analistas                                NUMBER NOT NULL, 
    hist_pago_id                                      NUMBER, -- Este es el id del pago
    inf_id                                            NUMBER, -- Este es el id del informante
    hist_cg_fec_ini                                   DATE NOT NULL, 
    hist_cg_emp_int_id                                NUMBER NOT NULL, 
    hist_carg_est_id                                  NUMBER NOT NULL, 
    hist_carg_ofic_id                                 NUMBER NOT NULL,
    CONSTRAINT ck_fec_ini_fin CHECK (fec_fin_cierre >= fec_obten),
    CONSTRAINT ck_nivel_confi_ini CHECK (nivel_confi_ini >= 0 and nivel_confi_ini <= 100),
    CONSTRAINT ck_nivel_confi_fin CHECK (nivel_confi_fin >= 0 and nivel_confi_fin <= 100)
);

CREATE UNIQUE INDEX hecho_crudo__idx ON
    hecho_crudo (
        historico_pago_id_pago_infor
    ASC,
        hist_pag_inf_id_inf
    ASC );

CREATE TABLE verificacion_hecho (
    id                                            NUMBER NOT NULL,
    fecha                                         DATE NOT NULL,
    niv_confi                                     NUMBER NOT NULL,
    hecho_cdo_id                                  NUMBER NOT NULL,
    hist_cg_fec_ini                               DATE NOT NULL, 
    hist_cg_emp_int_id                            NUMBER NOT NULL, 
    hist_cg_est_id                                NUMBER NOT NULL, 
    hist_cg_ofic_id                               NUMBER NOT NULL,
    CONSTRAINT verificacion_hecho_pk PRIMARY KEY ( id,hecho_cdo_id,hist_cg_fec_ini,hist_cg_emp_int_id,hist_cg_est_id,hist_cg_ofic_id),
    CONSTRAINT ck_niv_confi CHECK (niv_confi >= 0 and niv_confi <= 100)
);



-----------------------------------------------------------------------                RELACIONES                 ------------------------------------------------------------------------------- 


-- Relacion de Tabla Analista Temas
ALTER TABLE analistas_temas
    ADD CONSTRAINT ana_temas_emp_int_fk FOREIGN KEY ( emp_int_id )
        REFERENCES empleado_inteligencia ( id_emp_int );

ALTER TABLE analistas_temas
    ADD CONSTRAINT analistas_temas_tema_fk FOREIGN KEY ( tema_id )
        REFERENCES tema ( id );

-- Relacion de Tabla Areas de Interes
ALTER TABLE area_interes
    ADD CONSTRAINT area_interes_cliente_fk FOREIGN KEY ( cliente_id )
        REFERENCES cliente ( id );

ALTER TABLE area_interes
    ADD CONSTRAINT area_interes_tema_fk FOREIGN KEY ( tema_id )
        REFERENCES tema ( id );

-- Relacion de Tabla ciudad 
ALTER TABLE ciudad
    ADD CONSTRAINT ciudad_pais_fk FOREIGN KEY ( pais_id )
        REFERENCES pais ( id_pais );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_ciudad_fk FOREIGN KEY ( ciudad_id,ciudad_pais_id )
        REFERENCES ciudad ( id_ciudad,pais_id );


-- Relacion de empleado inteligencia

ALTER TABLE empleado_inteligencia
    ADD CONSTRAINT emp_int_ciudad_fk FOREIGN KEY ( ciudad_id,ciudad_pais_id)
        REFERENCES ciudad ( id_ciudad,pais_id );


-- Relacion de empleado_jefe
ALTER TABLE empleado_jefe
    ADD CONSTRAINT empleado_jefe_empleado_jefe_fk FOREIGN KEY ( empleado_jefe_id )
        REFERENCES empleado_jefe ( id );

-- Relacion de Estacion

ALTER TABLE estacion
    ADD CONSTRAINT estacion_ciudad_fk FOREIGN KEY ( ciudad_id,ciudad_pais_id )
        REFERENCES ciudad ( id_ciudad,pais_id );

ALTER TABLE estacion
    ADD CONSTRAINT estacion_empleado_jefe_fk FOREIGN KEY ( empleado_jefe_id )
        REFERENCES empleado_jefe ( id );

ALTER TABLE estacion
    ADD CONSTRAINT estacion_oficina_principal_fk FOREIGN KEY ( oficina_principal_id )
        REFERENCES oficina_principal ( id_oficina );

-- Relacion de Historico de Venta

ALTER TABLE hist_venta
    ADD CONSTRAINT hist_venta_cliente_fk FOREIGN KEY ( cliente_id )
        REFERENCES cliente ( id );

ALTER TABLE hist_venta
    ADD CONSTRAINT hist_venta_pieza_int_fk FOREIGN KEY ( pieza_inteligencia_id )
        REFERENCES pieza_inteligencia ( id );

-- Relacion de Historico de Cargo

ALTER TABLE historico_cargo
    ADD CONSTRAINT hist_cargo_emp_int_fk FOREIGN KEY ( emp_int_id )
        REFERENCES empleado_inteligencia ( id_emp_int );

ALTER TABLE historico_cargo
    ADD CONSTRAINT historico_cargo_estacion_fk FOREIGN KEY ( estacion_id,est_ofic_prin_id )
        REFERENCES estacion ( id_estacion,oficina_principal_id);

-- Relacion de Historico de Pago

ALTER TABLE historico_pago
    ADD CONSTRAINT historico_pago_informante_fk FOREIGN KEY ( informante_id )
        REFERENCES informante ( id_informante );


-- Relacion de Informante

ALTER TABLE informante
    ADD CONSTRAINT informante_empleado_jefe_fk FOREIGN KEY ( empleado_jefe_id_A )
        REFERENCES empleado_jefe ( id );

ALTER TABLE informante
    ADD CONSTRAINT Acceso_Infor_fk FOREIGN KEY ( hist_cg_fec_ini_A, hist_cg_emp_int_id_A,hist_cg_est_id_A,hist_cg_ofic_id_A )
        REFERENCES historico_cargo ( fec_inicio,emp_int_id,estacion_id,est_ofic_prin_id);

ALTER TABLE informante
    ADD CONSTRAINT Agente_fkv1 FOREIGN KEY ( hist_cg_fec_ini,hist_cg_emp_int_id,hist_cg_est_id,hist_cg_ofic_id )
        REFERENCES historico_cargo ( fec_inicio,emp_int_id,estacion_id,est_ofic_prin_id);


-- Relaciones de Oficina Principal

ALTER TABLE oficina_principal
    ADD CONSTRAINT oficina_principal_ciudad_fk FOREIGN KEY ( ciudad_id,ciudad_pais_id)
        REFERENCES ciudad ( id_ciudad,pais_id );

ALTER TABLE oficina_principal
    ADD CONSTRAINT ofi_p_emp_jefe_fk FOREIGN KEY ( empleado_jefe_id )
        REFERENCES empleado_jefe ( id );

-- Relaciones de Pieza de Inteligencia

ALTER TABLE pieza_inteligencia
    ADD CONSTRAINT pieza_int_hist_ca_fk FOREIGN KEY ( hist_cg_fec_ini,hist_cg_emp_int_id,hist_cg_est_id,hist_cg_ofic_id)
        REFERENCES historico_cargo ( fec_inicio ,emp_int_id ,estacion_id,est_ofic_prin_id);

ALTER TABLE pieza_inteligencia
    ADD CONSTRAINT pieza_inteligencia_tema_fk FOREIGN KEY ( tema_id )
        REFERENCES tema ( id );


-- Relaciones de tabla P_T

ALTER TABLE p_t
    ADD CONSTRAINT p_t_pieza_inteligencia_fk FOREIGN KEY ( pieza_int_id )
        REFERENCES pieza_inteligencia ( id );

ALTER TABLE p_t
    ADD CONSTRAINT p_t_tema_fk FOREIGN KEY ( tema_id )
        REFERENCES tema ( id );

-- Relacion de Hecho crudo

ALTER TABLE hecho_crudo
    ADD CONSTRAINT hecho_crudo_historico_cargo_fk FOREIGN KEY ( hist_cg_fec_ini, hist_cg_emp_int_id,hist_carg_est_id,hist_carg_ofic_id )
        REFERENCES historico_cargo ( fec_inicio,emp_int_id,estacion_id,est_ofic_prin_id);


-- Relacion de P_H

ALTER TABLE p_h
    ADD CONSTRAINT p_h_cliente_fk FOREIGN KEY ( pieza_int_id )
        REFERENCES pieza_inteligencia ( id );

ALTER TABLE p_h
    ADD CONSTRAINT p_h_hecho_crudo_fk FOREIGN KEY ( hecho_cdo_id )
        REFERENCES hecho_crudo ( id_hecho_cdo );

-- Relacion de Verificcion de Hecho crudo

ALTER TABLE verificacion_hecho
    ADD CONSTRAINT verf_hecho_hecho_crudo_fk FOREIGN KEY ( hecho_cdo_id )
        REFERENCES hecho_crudo ( id_hecho_cdo );


ALTER TABLE verificacion_hecho
    ADD CONSTRAINT verf_hecho_hist_cargo_fk FOREIGN KEY ( hist_cg_fec_ini,hist_cg_emp_int_id,hist_cg_est_id,hist_cg_ofic_id)
        REFERENCES historico_cargo (fec_inicio,emp_int_id,estacion_id,est_ofic_prin_id);




-----------------------------------------------------------------------                Vistas                 ------------------------------------------------------------------------------- 

-- Vista de Oficina_principal con jefe y localizacion

create or replace view detalle_oficina(Oficina,Nombre,Ciudad,Pais,Director)
As SELECT ofi.id_oficina,ofi.nombre,ci.nombre,pa.nombre,e.nombre ||' '|| e.apellido 
from oficina_principal ofi, ciudad ci, pais pa, empleado_jefe e
where ofi.ciudad_id=ci.id_ciudad and ofi.ciudad_pais_id = pa.id_pais and ofi.empleado_jefe_id = e.id;

-- Vista de las regiones de las ciudades
create or replace view detalle_ubicaciones(id_pais,id_ciudad, Ciudad, Pais, Region)
AS SELECT pa.id_pais,ci.id_ciudad,ci.nombre,pa.nombre,pa.region 
FROM pais pa, ciudad ci
WHERE pa.id_pais = ci.pais_id;

-- Vista de detalle_estacion
create or replace view detalle_estacion(Estacion, Nombre,Ciudad,Pais,Region, Jefe,Oficina)
AS SELECT es.id_estacion,es.nombre,ci.nombre,pa.nombre,pa.region, em.nombre || ' ' || em.apellido, es.oficina_principal_id
FROM estacion es, ciudad ci, pais pa, empleado_jefe em
where es.ciudad_id = ci.id_ciudad AND es.empleado_jefe_id = em.id AND pa.id_pais = es.ciudad_pais_id;
