CREATE TABLE a_t (
    cliente_id  NUMBER NOT NULL,
    tema_id     NUMBER NOT NULL
);

ALTER TABLE a_t ADD CONSTRAINT a_t_pk PRIMARY KEY ( cliente_id,
                                                    tema_id );

CREATE TABLE agente_campo (
    id               NUMBER NOT NULL,
    agente_campo_id  NUMBER NOT NULL
);

ALTER TABLE agente_campo ADD CONSTRAINT agente_campo_pk PRIMARY KEY ( agente_campo_id );

CREATE TABLE analistas_temas (
    empleado_inteligencia_id  NUMBER NOT NULL,
    tema_id                   NUMBER NOT NULL
);

ALTER TABLE analistas_temas ADD CONSTRAINT analistas_temas_pk PRIMARY KEY ( empleado_inteligencia_id,
                                                                            tema_id );

CREATE TABLE ciudad (
    id       NUMBER NOT NULL,
    nombre   VARCHAR2 (20)

     NOT NULL,
    pais_id  NUMBER NOT NULL
);

ALTER TABLE ciudad ADD CONSTRAINT ciudad_pk PRIMARY KEY ( id,
                                                          pais_id );

CREATE TABLE cliente (
    id                NUMBER NOT NULL,
    nombre            VARCHAR2 (20)
     NOT NULL,
    contacto_empresa  VARCHAR2 (20)
     NOT NULL,
    tipo_cliente      NUMBER NOT NULL,
    ciudad_id         NUMBER NOT NULL,
    ciudad_pais_id    NUMBER NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id );

CREATE TABLE empleado_inteligencia (
    id                            NUMBER NOT NULL,
    documento_identidad           NUMBER NOT NULL,
    datos_personales              unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    tipoeseguridad                unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    licencia                      unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    caracteristicas               unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    telefono                      NUMBER NOT NULL,
    alias                         unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
    ,
    calle                         unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    idiomas                       unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    nivel_educativo               VARCHAR2 (20)
     NOT NULL,
    ciudad_id                     NUMBER NOT NULL,
    ciudad_id1                    NUMBER NOT NULL,
    agente_campo_agente_campo_id  NUMBER NOT NULL
);

ALTER TABLE empleado_inteligencia ADD CONSTRAINT empleado_inteligencia_pk PRIMARY KEY ( id );

CREATE TABLE empleado_jefe (
    id                NUMBER NOT NULL,
    nombre            VARCHAR2 (20)
     NOT NULL,
    apellido          VARCHAR2 (20)
     NOT NULL,
    tipo              unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    empleado_jefe_id  NUMBER NOT NULL
);

ALTER TABLE empleado_jefe ADD CONSTRAINT empleado_jefe_pk PRIMARY KEY ( id );

CREATE TABLE estacion (
    id                            NUMBER NOT NULL,
    nombre                        VARCHAR2 (20)
     NOT NULL,
    presupuesto_anual             NUMBER NOT NULL,
    empleado_jefe_id              NUMBER NOT NULL,
    ciudad_id                     NUMBER NOT NULL,
    ciudad_id1                    NUMBER NOT NULL,
    oficina_principal_id_oficina  NUMBER NOT NULL
);

CREATE UNIQUE INDEX estacion__idx ON
    estacion (
        empleado_jefe_id
    ASC );

ALTER TABLE estacion ADD CONSTRAINT estacion_pk PRIMARY KEY ( id,
                                                              oficina_principal_id_oficina );

CREATE TABLE hecho_crudo (
    id                           NUMBER NOT NULL,
    resumen                      VARCHAR2 (20)

     NOT NULL,
    fuente                       unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    informacion                  VARCHAR2 (20)

     NOT NULL,
    nivel_confiabilidad_inicial  unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    fecha_obtencion              DATE NOT NULL,
    nivel_confiabilidad_final    unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
    ,
    fecha_final_cierre           DATE,
    cantidad_analistas           NUMBER NOT NULL,
    historico_pago_id            NUMBER,
    historico_pago_id2           NUMBER
);

CREATE UNIQUE INDEX hecho_crudo__idx ON
    hecho_crudo (
        historico_pago_id
    ASC,
        historico_pago_id2
    ASC );

ALTER TABLE hecho_crudo ADD CONSTRAINT hecho_crudo_pk PRIMARY KEY ( id );

CREATE TABLE hist_venta (
    id                     NUMBER NOT NULL,
    fecha_venta            DATE NOT NULL,
    precio_final           NUMBER NOT NULL,
    pieza_inteligencia_id  NUMBER NOT NULL,
    cliente_id             NUMBER NOT NULL
);

ALTER TABLE hist_venta
    ADD CONSTRAINT hist_venta_pk PRIMARY KEY ( id,
                                               pieza_inteligencia_id,
                                               cliente_id );

CREATE TABLE historico_cargo (
    fecha_inicio              DATE NOT NULL,
    fecha_fin                 DATE,
    cargo                     unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    empleado_inteligencia_id  NUMBER NOT NULL,
    estacion_id               NUMBER NOT NULL,
    estacion_id_oficina       NUMBER NOT NULL
);

ALTER TABLE historico_cargo
    ADD CONSTRAINT historico_cargo_pk PRIMARY KEY ( fecha_inicio,
                                                    empleado_inteligencia_id,
                                                    estacion_id,
                                                    estacion_id_oficina );

CREATE TABLE historico_pago (
    id                   NUMBER NOT NULL,
    fecha                DATE NOT NULL,
    pago                 NUMBER NOT NULL,
    hecho_crudo_id       NUMBER,
    informante_id        NUMBER NOT NULL,
    estacion_id          NUMBER NOT NULL,
    estacion_id_oficina  NUMBER NOT NULL
);

CREATE UNIQUE INDEX historico_pago__idx ON
    historico_pago (
        hecho_crudo_id
    ASC );

ALTER TABLE historico_pago ADD CONSTRAINT historico_pago_pk PRIMARY KEY ( id,
                                                                          informante_id );

CREATE TABLE historico_seguridad (
    id           NUMBER NOT NULL,
    id_empleado  NUMBER NOT NULL,
    id_pieza     NUMBER NOT NULL
);

ALTER TABLE historico_seguridad ADD CONSTRAINT historico_seguridad_pk PRIMARY KEY ( id );

CREATE TABLE informante (
    id                                        NUMBER NOT NULL,
    nombre_clave                              VARCHAR2 (20)

     NOT NULL,
    empleado_jefe_id                          NUMBER,
    historico_cargo_fecha_inicio              DATE, 

         hist_car_emp_int_id  NUMBER,
    historico_cargo_estacion_id               NUMBER, 
         hist_carg_est_id_ofic       NUMBER,
    agente_campo_agente_campo_id              NUMBER NOT NULL
);

ALTER TABLE informante
    ADD CONSTRAINT arc_1 CHECK ( ( ( historico_cargo_fecha_inicio IS NOT NULL )
                                   AND ( hist_car_emp_int_id IS NOT NULL )
                                   AND ( historico_cargo_estacion_id IS NOT NULL )
                                   AND ( hist_carg_est_id_ofic IS NOT NULL )
                                   AND ( empleado_jefe_id IS NULL ) )
                                 OR ( ( empleado_jefe_id IS NOT NULL )
                                      AND ( historico_cargo_fecha_inicio IS NULL )
                                      AND ( hist_car_emp_int_id IS NULL )
                                      AND ( historico_cargo_estacion_id IS NULL )
                                      AND ( hist_carg_est_id_ofic IS NULL ) ) );

ALTER TABLE informante ADD CONSTRAINT informante_pk PRIMARY KEY ( id );

CREATE TABLE oficina_principal (
    id_oficina        NUMBER NOT NULL,
    nombre            VARCHAR2 (20)

     NOT NULL,
    tipooficina       unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    empleado_jefe_id  NUMBER NOT NULL
);

CREATE UNIQUE INDEX oficina_principal__idx ON
    oficina_principal (
        empleado_jefe_id
    ASC );

ALTER TABLE oficina_principal ADD CONSTRAINT oficina_principal_pk PRIMARY KEY ( id_oficina );

CREATE TABLE p_h (
    hecho_crudo_id  NUMBER NOT NULL,
    cliente_id      NUMBER NOT NULL
);

ALTER TABLE p_h ADD CONSTRAINT p_h_pk PRIMARY KEY ( hecho_crudo_id,
                                                    cliente_id );

CREATE TABLE p_t (
    pieza_inteligencia_id  NUMBER NOT NULL,
    tema_id                NUMBER NOT NULL
);

ALTER TABLE p_t ADD CONSTRAINT p_t_pk PRIMARY KEY ( pieza_inteligencia_id,
                                                    tema_id );

CREATE TABLE pais (
    id      NUMBER NOT NULL,
    nombre  VARCHAR2 (20)

     NOT NULL,
    region  unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL
);

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( id );

CREATE TABLE pieza_inteligencia (
    id                                        NUMBER NOT NULL,
    precio_aproximado                         NUMBER,
    fecha_construccion                        DATE,
    nivel_confiabilidad                       NUMBER,
    nivel_clasificado                         unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    tema_id                                   NUMBER NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
         anl_temas_emp_int_id  NUMBER NOT NULL,
    analistas_temas_tema_id                   NUMBER NOT NULL
);

ALTER TABLE pieza_inteligencia ADD CONSTRAINT pieza_inteligencia_pk PRIMARY KEY ( id );

CREATE TABLE tema (
    id           NUMBER NOT NULL,
    nombre       VARCHAR2 (20)

     NOT NULL,
    descripcion  VARCHAR2 (20) 

     NOT NULL,
    topico       VARCHAR2 (20)

     NOT NULL
);

ALTER TABLE tema ADD CONSTRAINT tema_pk PRIMARY KEY ( id );

CREATE TABLE verificacion (
    id                        NUMBER NOT NULL,
    fecha                     DATE NOT NULL,
    niv_confiabilidad         NUMBER NOT NULL,
    empleado_inteligencia_id  NUMBER NOT NULL,
    hecho_crudo_id            NUMBER NOT NULL
);

ALTER TABLE verificacion
    ADD CONSTRAINT verificacion_pk PRIMARY KEY ( id,
                                                 empleado_inteligencia_id,
                                                 hecho_crudo_id );

ALTER TABLE a_t
    ADD CONSTRAINT a_t_cliente_fk FOREIGN KEY ( cliente_id )
        REFERENCES cliente ( id );

ALTER TABLE a_t
    ADD CONSTRAINT a_t_tema_fk FOREIGN KEY ( tema_id )
        REFERENCES tema ( id );


ALTER TABLE analistas_temas
    ADD CONSTRAINT ana_temas_emp_int_fk FOREIGN KEY ( empleado_inteligencia_id )
        REFERENCES empleado_inteligencia ( id );

ALTER TABLE analistas_temas
    ADD CONSTRAINT analistas_temas_tema_fk FOREIGN KEY ( tema_id )
        REFERENCES tema ( id );

ALTER TABLE ciudad
    ADD CONSTRAINT ciudad_pais_fk FOREIGN KEY ( pais_id )
        REFERENCES pais ( id );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_ciudad_fk FOREIGN KEY ( ciudad_id,
                                                   ciudad_pais_id )
        REFERENCES ciudad ( id,
                            pais_id );


ALTER TABLE empleado_inteligencia
    ADD CONSTRAINT emp_int_ag_campo_fk FOREIGN KEY ( agente_campo_agente_campo_id )
        REFERENCES agente_campo ( agente_campo_id );

ALTER TABLE empleado_inteligencia
    ADD CONSTRAINT emp_int_ciudad_fk FOREIGN KEY ( ciudad_id,
                                                                 ciudad_id1 )
        REFERENCES ciudad ( id,
                            pais_id );

ALTER TABLE empleado_jefe
    ADD CONSTRAINT empleado_jefe_empleado_jefe_fk FOREIGN KEY ( empleado_jefe_id )
        REFERENCES empleado_jefe ( id );

ALTER TABLE estacion
    ADD CONSTRAINT estacion_ciudad_fk FOREIGN KEY ( ciudad_id,
                                                    ciudad_id1 )
        REFERENCES ciudad ( id,
                            pais_id );

ALTER TABLE estacion
    ADD CONSTRAINT estacion_empleado_jefe_fk FOREIGN KEY ( empleado_jefe_id )
        REFERENCES empleado_jefe ( id );

ALTER TABLE estacion
    ADD CONSTRAINT estacion_oficina_principal_fk FOREIGN KEY ( oficina_principal_id_oficina )
        REFERENCES oficina_principal ( id_oficina );

ALTER TABLE hecho_crudo
    ADD CONSTRAINT hecho_crudo_historico_pago_fk FOREIGN KEY ( historico_pago_id,
                                                               historico_pago_id2 )
        REFERENCES historico_pago ( id,
                                    informante_id );

ALTER TABLE hist_venta
    ADD CONSTRAINT hist_venta_cliente_fk FOREIGN KEY ( cliente_id )
        REFERENCES cliente ( id );


ALTER TABLE hist_venta
    ADD CONSTRAINT hist_venta_pieza_int_fk FOREIGN KEY ( pieza_inteligencia_id )
        REFERENCES pieza_inteligencia ( id );


ALTER TABLE historico_cargo
    ADD CONSTRAINT hist_cargo_emp_inta_fk FOREIGN KEY ( empleado_inteligencia_id )
        REFERENCES empleado_inteligencia ( id );

ALTER TABLE historico_cargo
    ADD CONSTRAINT historico_cargo_estacion_fk FOREIGN KEY ( estacion_id,
                                                             estacion_id_oficina )
        REFERENCES estacion ( id,
                              oficina_principal_id_oficina );

ALTER TABLE historico_pago
    ADD CONSTRAINT historico_pago_estacion_fk FOREIGN KEY ( estacion_id,
                                                            estacion_id_oficina )
        REFERENCES estacion ( id,
                              oficina_principal_id_oficina );

ALTER TABLE historico_pago
    ADD CONSTRAINT historico_pago_hecho_crudo_fk FOREIGN KEY ( hecho_crudo_id )
        REFERENCES hecho_crudo ( id );

ALTER TABLE historico_pago
    ADD CONSTRAINT historico_pago_informante_fk FOREIGN KEY ( informante_id )
        REFERENCES informante ( id );

ALTER TABLE informante
    ADD CONSTRAINT informante_agente_campo_fk FOREIGN KEY ( agente_campo_agente_campo_id )
        REFERENCES agente_campo ( agente_campo_id );

ALTER TABLE informante
    ADD CONSTRAINT informante_empleado_jefe_fk FOREIGN KEY ( empleado_jefe_id )
        REFERENCES empleado_jefe ( id );

ALTER TABLE informante
    ADD CONSTRAINT informante_historico_cargo_fk FOREIGN KEY ( historico_cargo_fecha_inicio,
                                                               hist_car_emp_int_id,
                                                               historico_cargo_estacion_id,
                                                               hist_carg_est_id_ofic )
        REFERENCES historico_cargo ( fecha_inicio,
                                     empleado_inteligencia_id,
                                     estacion_id,
                                     estacion_id_oficina );


ALTER TABLE oficina_principal
    ADD CONSTRAINT ofic_principal_emp_jefe_fk FOREIGN KEY ( empleado_jefe_id )
        REFERENCES empleado_jefe ( id );

ALTER TABLE p_h
    ADD CONSTRAINT p_h_cliente_fk FOREIGN KEY ( cliente_id )
        REFERENCES cliente ( id );

ALTER TABLE p_h
    ADD CONSTRAINT p_h_hecho_crudo_fk FOREIGN KEY ( hecho_crudo_id )
        REFERENCES hecho_crudo ( id );

ALTER TABLE p_t
    ADD CONSTRAINT p_t_pieza_inteligencia_fk FOREIGN KEY ( pieza_inteligencia_id )
        REFERENCES pieza_inteligencia ( id );

ALTER TABLE p_t
    ADD CONSTRAINT p_t_tema_fk FOREIGN KEY ( tema_id )
        REFERENCES tema ( id );


ALTER TABLE pieza_inteligencia
    ADD CONSTRAINT pieza_int_ana_temas_fk FOREIGN KEY ( anl_temas_emp_int_id,
                                                                       analistas_temas_tema_id )
        REFERENCES analistas_temas ( empleado_inteligencia_id,
                                     tema_id );

ALTER TABLE pieza_inteligencia
    ADD CONSTRAINT pieza_inteligencia_tema_fk FOREIGN KEY ( tema_id )
        REFERENCES tema ( id );


ALTER TABLE verificacion
    ADD CONSTRAINT verif_emp_int_fk FOREIGN KEY ( empleado_inteligencia_id )
        REFERENCES empleado_inteligencia ( id );

ALTER TABLE verificacion
    ADD CONSTRAINT verificacion_hecho_crudo_fk FOREIGN KEY ( hecho_crudo_id )
        REFERENCES hecho_crudo ( id );

CREATE SEQUENCE agente_campo_agente_campo_id START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER agente_campo_agente_campo_id BEFORE
    INSERT ON agente_campo
    FOR EACH ROW
    WHEN ( new.agente_campo_id IS NULL )
BEGIN
    :new.agente_campo_id := agente_campo_agente_campo_id.nextval;
END;
/