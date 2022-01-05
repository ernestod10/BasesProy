--Creacion objetos
create or replace type LIC as object
(Pais varchar2(15),
Numero Number); 

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
    -- Falta atributo tabla anidada para los familiares
); 

 
create or replace type IDIOM as varray(6) of varchar2(10); 

create or replace type INFORMAC as object
(Pais varchar2(15),
Numero Number); 

create or replace type CONTACT as object
(Nombre varchar2(15),
apellido varchar2(15),
apellido2 varchar2(15),
telefono Number(10),
email varchar2(15)); 



--Creacion tablas

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
    id_ciudad     NUMBER NOT NULL,
    nombre        VARCHAR2 (22) NOT NULL,
    pais_id       NUMBER NOT NULL,
    CONSTRAINT ciudad_pk PRIMARY KEY ( id_ciudad,pais_id )
);


CREATE TABLE cliente (
    id                   NUMBER NOT NULL PRIMARY KEY,
    nombre               VARCHAR2 (22)NOT NULL,
    contacto_empresa     CONTACT NOT NULL,
    exclusivo            NUMBER NOT NULL,
    ciudad_id_ciudad     NUMBER NOT NULL,
    ciudad_pais_id NUMBER NOT NULL
);
-------------------------------------------------

CREATE TABLE empleado_inteligencia (
    id_emp_int           NUMBER NOT NULL PRIMARY KEY,
    doc_identidad        NUMBER NOT NULL,
    fec_nac              DATE NOT NULL,
    nombre_pila          VARCHAR2(30) NOT NULL,
    segundo_nombre       VARCHAR2(25),
    apellido1            VARCHAR2(30) NOT NULL,
    apellido2            VARCHAR2(25) NOT NULL,
    claseseguridad       VARCHAR2(1) NOT NULL,
    licencia             LIC NOT NULL,
    caracteristicas      CARACT NOT NULL,
    telefono             NUMBER NOT NULL,
    ali                  ALIAS_ ,
    calle                VARCHAR2(30) NOT NULL,
    idiomas              IDIOM NOT NULL,
    nivel_educativo      VARCHAR2 (22) NOT NULL,
    ciudad_id_ciudad     NUMBER NOT NULL,
    ciudad_pais_id_pais  NUMBER NOT NULL
);


CREATE TABLE empleado_jefe (
    id                NUMBER NOT NULL,
    nombre            VARCHAR2 (22) NOT NULL,
    apellido          VARCHAR2 (22) NOT NULL,
    tipo              VARCHAR2(10) NOT NULL,
    empleado_jefe_id  NUMBER NOT NULL
);

ALTER TABLE empleado_jefe ADD CONSTRAINT empleado_jefe_pk PRIMARY KEY ( id );

CREATE TABLE estacion (
    id_estacion                   NUMBER NOT NULL,
    nombre                        VARCHAR2 (22) NOT NULL,
    presupuesto_anual             NUMBER NOT NULL,
    empleado_jefe_id              NUMBER NOT NULL,
    ciudad_id_ciudad              NUMBER NOT NULL,
    ciudad_pais_id_pais           NUMBER NOT NULL,
    oficina_principal_id_oficina  NUMBER NOT NULL
);

CREATE UNIQUE INDEX estacion__idx ON
    estacion (
        empleado_jefe_id
    ASC );

ALTER TABLE estacion ADD CONSTRAINT estacion_pk PRIMARY KEY ( id_estacion,oficina_principal_id_oficina );

CREATE TABLE hecho_crudo (
    id_hecho_cdo                                      NUMBER NOT NULL,
    resumen                                           VARCHAR2 (22) NOT NULL,
    fuente                                            VARCHAR(1) NOT NULL,
    tipo_contenido                                    VARCHAR2 (12) NOT NULL,
    contenido                                         VARCHAR2 (80) NOT NULL,
    nivel_confiabilidad_inicial                       Number NOT NULL,
    fecha_obtencion                                   DATE NOT NULL,
    nivel_confiabilidad_final                         NUMBER,
    fecha_final_cierre                                DATE,
    cantidad_analistas                                NUMBER NOT NULL,
    historico_pago_id_pago_infor                      NUMBER, 
    hist_pag_inf_id_inf                               NUMBER,
    historico_cargo_fecha_inicio                      DATE NOT NULL, 
    hist_cg_emp_int_id_emp_int                        NUMBER NOT NULL, 
    hist_carg_est_id_est                              NUMBER NOT NULL, 
    hist_carg_est_id_ofic                             NUMBER NOT NULL
);

CREATE UNIQUE INDEX hecho_crudo__idx ON
    hecho_crudo (
        historico_pago_id_pago_infor
    ASC,
        hist_pag_inf_id_inf
    ASC );

ALTER TABLE hecho_crudo ADD CONSTRAINT hecho_crudo_pk PRIMARY KEY ( id_hecho_cdo );

CREATE TABLE hist_venta (
    id                     NUMBER NOT NULL,
    fecha_venta            DATE NOT NULL,
    total_precio_final     NUMBER NOT NULL,
    pieza_inteligencia_id  NUMBER NOT NULL,
    cliente_id             NUMBER NOT NULL
);

ALTER TABLE hist_venta
    ADD CONSTRAINT hist_venta_pk PRIMARY KEY ( id,
                                               pieza_inteligencia_id,
                                               cliente_id );

CREATE TABLE historico_cargo (
    fecha_inicio                           DATE NOT NULL,
    fecha_fin                              DATE,
    cargo                                  Varchar(1) NOT NULL, 
    emp_int_id_emp_int                     NUMBER NOT NULL,
    estacion_id_estacion                   NUMBER NOT NULL, 
    est_ofic_prin_id_ofic  NUMBER NOT NULL
);

ALTER TABLE historico_cargo
    ADD CONSTRAINT historico_cargo_pk PRIMARY KEY ( fecha_inicio,
                                                    emp_int_id_emp_int,
                                                    estacion_id_estacion,
                                                    est_ofic_prin_id_ofic );

CREATE TABLE historico_pago (
    id_pago_infor                          NUMBER NOT NULL,
    fecha                                  DATE NOT NULL,
    pago                                   NUMBER NOT NULL,
    hecho_crudo_id_hecho_cdo               NUMBER,
    informante_id_informante               NUMBER NOT NULL,

);

CREATE UNIQUE INDEX historico_pago__idx ON
    historico_pago (
        hecho_crudo_id_hecho_cdo
    ASC );

ALTER TABLE historico_pago ADD CONSTRAINT historico_pago_pk PRIMARY KEY ( id_pago_infor,
                                                                          informante_id_informante );

CREATE TABLE historico_seguridad (
    id           NUMBER NOT NULL,
    id_empleado  NUMBER NOT NULL,
    id_pieza     NUMBER NOT NULL
);

ALTER TABLE historico_seguridad ADD CONSTRAINT historico_seguridad_pk PRIMARY KEY ( id );

CREATE TABLE informante (
    id_informante                                      NUMBER NOT NULL,
    nombre_clave                                       VARCHAR2 (22) NOT NULL,
    empleado_jefe_id                                   NUMBER,
    historico_cargo_fecha_inicio                       DATE, 
    hist_cg_emp_int_id_emp_int                         NUMBER, 
    hist_carg_est_id_est                               NUMBER, 
    hist_carg_est_id_ofic                              NUMBER,
    historico_cargo_fecha_inicio1                      DATE NOT NULL, 
    hist_cg_emp_int_id_emp_int1                        NUMBER NOT NULL, 
    hist_carg_est_id_est1                              NUMBER NOT NULL, 
    hist_carg_est_id_ofic1                             NUMBER NOT NULL
);

ALTER TABLE informante
    ADD CONSTRAINT arc_1 CHECK ( ( ( historico_cargo_fecha_inicio IS NOT NULL )
                                   AND ( hist_cg_emp_int_id_emp_int IS NOT NULL )
                                   AND ( hist_carg_est_id_est IS NOT NULL )
                                   AND ( hist_carg_est_id_ofic IS NOT NULL )
                                   AND ( empleado_jefe_id IS NULL ) )
                                 OR ( ( empleado_jefe_id IS NOT NULL )
                                      AND ( historico_cargo_fecha_inicio IS NULL )
                                      AND ( hist_cg_emp_int_id_emp_int IS NULL )
                                      AND ( hist_carg_est_id_est IS NULL )
                                      AND ( hist_carg_est_id_ofic IS NULL ) ) );

ALTER TABLE informante ADD CONSTRAINT informante_pk PRIMARY KEY ( id_informante );

CREATE TABLE oficina_principal (
    id_oficina           NUMBER NOT NULL,
    nombre               VARCHAR2 (22) NOT NULL,
    sede                 NUMBER NOT NULL,
    empleado_jefe_id     NUMBER NOT NULL,
    ciudad_id_ciudad     NUMBER NOT NULL,
    ciudad_pais_id_pais  NUMBER NOT NULL
);

CREATE UNIQUE INDEX oficina_principal__idx ON
    oficina_principal (
        empleado_jefe_id
    ASC );

CREATE UNIQUE INDEX oficina_principal__idxv1 ON
    oficina_principal (
        ciudad_id_ciudad
    ASC,
        ciudad_pais_id_pais
    ASC );

ALTER TABLE oficina_principal ADD CONSTRAINT oficina_principal_pk PRIMARY KEY ( id_oficina );

CREATE TABLE p_h (
    hecho_crudo_id_hecho_cdo  NUMBER NOT NULL,
    cliente_id                NUMBER NOT NULL
);

ALTER TABLE p_h ADD CONSTRAINT p_h_pk PRIMARY KEY ( hecho_crudo_id_hecho_cdo,
                                                    cliente_id );

CREATE TABLE p_t (
    pieza_inteligencia_id  NUMBER NOT NULL,
    tema_id                NUMBER NOT NULL
);

ALTER TABLE p_t ADD CONSTRAINT p_t_pk PRIMARY KEY ( pieza_inteligencia_id,
                                                    tema_id );

CREATE TABLE pais (
    id_pais  NUMBER NOT NULL,
    nombre   VARCHAR2 (22)

     NOT NULL,
    region   VARCHAR2(10) NOT NULL
);

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( id_pais );

CREATE TABLE pieza_inteligencia (
    id                                                NUMBER NOT NULL,
    precio_aproximado                                 NUMBER,
    fecha_construccion                                DATE,
    nivel_confiabilidad                               NUMBER,
    nivel_clasificado                                 NUMBER NOT NULL,
    tema_id                                           NUMBER NOT NULL,
    historico_cargo_fecha_inicio                      DATE NOT NULL, 
    hist_cg_emp_int_id_emp_int                        NUMBER NOT NULL, 
    hist_carg_est_id_est                              NUMBER NOT NULL, 
    hist_carg_est_id_ofic                             NUMBER NOT NULL
);

ALTER TABLE pieza_inteligencia ADD CONSTRAINT pieza_inteligencia_pk PRIMARY KEY ( id );

CREATE TABLE tema (
    id           NUMBER NOT NULL PRIMARY KEY,
    nombre       VARCHAR2 (22) NOT NULL,
    descripcion  VARCHAR2 (22) NOT NULL,
    topico       VARCHAR2 (22) NOT NULL
);


CREATE TABLE verificacion_hecho (
    id                                                NUMBER NOT NULL,
    fecha                                             DATE NOT NULL,
    niv_confiabilidad                                 NUMBER NOT NULL,
    hecho_crudo_id_hecho_cdo                          NUMBER NOT NULL,
    historico_cargo_fecha_inicio                      DATE NOT NULL, 
    hist_cg_emp_int_id_emp_int                        NUMBER NOT NULL, 
    hist_carg_est_id_est                              NUMBER NOT NULL, 
    hist_carg_est_id_ofic                             NUMBER NOT NULL
);

ALTER TABLE verificacion_hecho
    ADD CONSTRAINT verificacion_hecho_pk PRIMARY KEY ( id,
                                                       hecho_crudo_id_hecho_cdo,
                                                       historico_cargo_fecha_inicio,
                                                       hist_cg_emp_int_id_emp_int,
                                                       hist_carg_est_id_est,
                                                       hist_carg_est_id_ofic );
 

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
    ADD CONSTRAINT ciudad_pais_fk FOREIGN KEY ( pais_id_pais )
        REFERENCES pais ( id_pais );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_ciudad_fk FOREIGN KEY ( ciudad_id_ciudad,ciudad_pais_id )
        REFERENCES ciudad ( id_ciudad,pais_id );


-- Relacion de empleado inteilgencia

ALTER TABLE empleado_inteligencia
    ADD CONSTRAINT emp_int_ciudad_fk FOREIGN KEY ( ciudad_id_ciudad,
                                                                 ciudad_pais_id_pais )
        REFERENCES ciudad ( id_ciudad,
                            pais_id );

ALTER TABLE empleado_jefe
    ADD CONSTRAINT empleado_jefe_empleado_jefe_fk FOREIGN KEY ( empleado_jefe_id )
        REFERENCES empleado_jefe ( id );

ALTER TABLE estacion
    ADD CONSTRAINT estacion_ciudad_fk FOREIGN KEY ( ciudad_id_ciudad,
                                                    ciudad_pais_id_pais )
        REFERENCES ciudad ( id_ciudad,
                            pais_id );

ALTER TABLE estacion
    ADD CONSTRAINT estacion_empleado_jefe_fk FOREIGN KEY ( empleado_jefe_id )
        REFERENCES empleado_jefe ( id );

ALTER TABLE estacion
    ADD CONSTRAINT estacion_oficina_principal_fk FOREIGN KEY ( oficina_principal_id_oficina )
        REFERENCES oficina_principal ( id_oficina );

ALTER TABLE hecho_crudo
    ADD CONSTRAINT hecho_crudo_historico_cargo_fk FOREIGN KEY ( historico_cargo_fecha_inicio,
                                                                hist_cg_emp_int_id_emp_int,
                                                                hist_carg_est_id_est,
                                                                hist_carg_est_id_ofic )
        REFERENCES historico_cargo ( fecha_inicio,
                                     emp_int_id_emp_int,
                                     estacion_id_estacion,
                                     est_ofic_prin_id_ofic );

ALTER TABLE hist_venta
    ADD CONSTRAINT hist_venta_cliente_fk FOREIGN KEY ( cliente_id )
        REFERENCES cliente ( id );

ALTER TABLE hist_venta
    ADD CONSTRAINT hist_venta_pieza_int_fk FOREIGN KEY ( pieza_inteligencia_id )
        REFERENCES pieza_inteligencia ( id );

ALTER TABLE historico_cargo
    ADD CONSTRAINT hist_cargo_emp_int_fk FOREIGN KEY ( emp_int_id_emp_int )
        REFERENCES empleado_inteligencia ( id_emp_int );

ALTER TABLE historico_cargo
    ADD CONSTRAINT historico_cargo_estacion_fk FOREIGN KEY ( estacion_id_estacion,
                                                             est_ofic_prin_id_ofic )
        REFERENCES estacion ( id_estacion,
                              oficina_principal_id_oficina );


ALTER TABLE historico_pago
    ADD CONSTRAINT historico_pago_informante_fk FOREIGN KEY ( informante_id_informante )
        REFERENCES informante ( id_informante );

ALTER TABLE informante
    ADD CONSTRAINT informante_empleado_jefe_fk FOREIGN KEY ( empleado_jefe_id )
        REFERENCES empleado_jefe ( id );

ALTER TABLE informante
    ADD CONSTRAINT informante_historico_cargo_fk FOREIGN KEY ( historico_cargo_fecha_inicio,
                                                               hist_cg_emp_int_id_emp_int,
                                                               hist_carg_est_id_est,
                                                               hist_carg_est_id_ofic )
        REFERENCES historico_cargo ( fecha_inicio,
                                     emp_int_id_emp_int,
                                     estacion_id_estacion,
                                     est_ofic_prin_id_ofic );

ALTER TABLE informante
    ADD CONSTRAINT inf_hist_cargo_fkv1 FOREIGN KEY ( historico_cargo_fecha_inicio1,
                                                                 hist_cg_emp_int_id_emp_int1,
                                                                 hist_carg_est_id_est1,
                                                                 hist_carg_est_id_ofic1 )
        REFERENCES historico_cargo ( fecha_inicio,
                                     emp_int_id_emp_int,
                                     estacion_id_estacion,
                                     est_ofic_prin_id_ofic );

ALTER TABLE oficina_principal
    ADD CONSTRAINT oficina_principal_ciudad_fk FOREIGN KEY ( ciudad_id_ciudad,
                                                             ciudad_pais_id_pais )
        REFERENCES ciudad ( id_ciudad,
                            pais_id );

ALTER TABLE oficina_principal
    ADD CONSTRAINT ofi_p_emp_jefe_fk FOREIGN KEY ( empleado_jefe_id )
        REFERENCES empleado_jefe ( id );

ALTER TABLE p_h
    ADD CONSTRAINT p_h_cliente_fk FOREIGN KEY ( cliente_id )
        REFERENCES cliente ( id );

ALTER TABLE p_h
    ADD CONSTRAINT p_h_hecho_crudo_fk FOREIGN KEY ( hecho_crudo_id_hecho_cdo )
        REFERENCES hecho_crudo ( id_hecho_cdo );

ALTER TABLE p_t
    ADD CONSTRAINT p_t_pieza_inteligencia_fk FOREIGN KEY ( pieza_inteligencia_id )
        REFERENCES pieza_inteligencia ( id );

ALTER TABLE p_t
    ADD CONSTRAINT p_t_tema_fk FOREIGN KEY ( tema_id )
        REFERENCES tema ( id );

ALTER TABLE pieza_inteligencia
    ADD CONSTRAINT pieza_int_hist_ca_fk FOREIGN KEY ( historico_cargo_fecha_inicio,
                                                                       hist_cg_emp_int_id_emp_int,
                                                                       hist_carg_est_id_est,
                                                                       hist_carg_est_id_ofic )
        REFERENCES historico_cargo ( fecha_inicio,
                                     emp_int_id_emp_int,
                                     estacion_id_estacion,
                                     est_ofic_prin_id_ofic );

ALTER TABLE pieza_inteligencia
    ADD CONSTRAINT pieza_inteligencia_tema_fk FOREIGN KEY ( tema_id )
        REFERENCES tema ( id );

ALTER TABLE verificacion_hecho
    ADD CONSTRAINT verf_hecho_hecho_crudo_fk FOREIGN KEY ( hecho_crudo_id_hecho_cdo )
        REFERENCES hecho_crudo ( id_hecho_cdo );


ALTER TABLE verificacion_hecho
    ADD CONSTRAINT verf_hecho_hist_cargo_fk FOREIGN KEY ( historico_cargo_fecha_inicio,
                                                                       hist_cg_emp_int_id_emp_int,
                                                                       hist_carg_est_id_est,
                                                                       hist_carg_est_id_ofic )
        REFERENCES historico_cargo ( fecha_inicio,
                                     emp_int_id_emp_int,
                                     estacion_id_estacion,
                                     est_ofic_prin_id_ofic );


