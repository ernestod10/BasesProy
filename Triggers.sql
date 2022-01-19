
-- VALIDAR QUE LA ESTACION TENGA 1 SOLO JEFE  

CREATE OR REPLACE TRIGGER jefe_estacion_uno
BEFORE INSERT ON estacion
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE
e_nombre estacion.nombre%type;
e_jefe estacion.empleado_jefe_id%type;
BEGIN

select nombre,empleado_jefe_id into e_nombre, e_jefe
from estacion
where nombre = :new.nombre;

if e_jefe <> :new.empleado_jefe_id then
raise_application_error( -20010,'La estacion ya tiene jefe asignado');
end if;

 EXCEPTION
        WHEN NO_DATA_FOUND THEN
            hola('Diego');
 END;

create or replace NONEDITIONABLE procedure hola(nombre in varchar2) is begin DBMS_OUTPUT.PUT_LINE('Hola '||nombre); end hola;


-- Trigger para validar que al insertar una estacion su oficina pertenezca a la misma region 

CREATE OR REPLACE TRIGGER oficina_estacion_region
BEFORE INSERT ON estacion
REFERENCING NEW AS NEW OLD AS OLD

FOR EACH ROW
DECLARE 
    lugar_incorrecto EXCEPTION;
    O_region VARCHAR2(3);
    nueva_region VARCHAR(3);
BEGIN

    SELECT pa.region into O_region 
    from ciudad ci, pais pa, oficina_principal ofi
    WHERE ofi.ciudad_id = ci.id_ciudad AND pa.id_pais = ofi.ciudad_pais_id AND ofi.id_oficina = :new.oficina_principal_id;

    SELECT pa.region into nueva_region
    FROM ciudad ci, pais pa, detalle_oficina ofi
    where :new.ciudad_id = ci.id_ciudad AND pa.id_pais = :new.ciudad_pais_id AND ofi.oficina = :new.oficina_principal_id;
    if nueva_region <> O_region then
        raise lugar_incorrecto;
    end if;

    EXCEPTION
    when lugar_incorrecto THEN  
    RAISE_APPLICATION_ERROR(-20008,'Oficina ubicada en la direccion de area equivocado');
END;


--VALIDAR FECHA DE NACIMIENTO DE FAMILIAR DEL EMPLEADO
create or replace TRIGGER VALIDA_FECHA_FAMILIAR
BEFORE INSERT ON empleado_inteligencia FOR EACH ROW
DECLARE 

BEGIN
    IF ((:NEW.familiar1.fec_nac > SYSDATE) OR (:NEW.familiar2.fec_nac > SYSDATE)) THEN
        raise_application_error(-20900,'El familiar debe ser mayor de edad');
    END IF;
    
    IF ((trunc(months_between((SYSDATE), :NEW.familiar1.fec_nac)/12) < 18) OR (trunc(months_between((SYSDATE), :NEW.familiar2.fec_nac)/12) < 18)) THEN
        raise_application_error(-20900,'El familiar debe ser mayor de edad');
    END IF;
    
END;

--VALIDAR EDAD MAYOR QUE 26 AÑOS DE ANALISTA Y AGENTE DE CAMPO
create or replace TRIGGER VALIDA_EDAD_26
BEFORE INSERT ON empleado_inteligencia FOR EACH ROW
DECLARE 

BEGIN
    IF (trunc(months_between((SYSDATE), :NEW.familiar1.fec_nac)/12) < 26) THEN
        raise_application_error(-20900,'Debe ser mayor de 26 años');
    END IF;
    
END;


--VALIDAR FUENTE HECHO CRUDO 
create or replace TRIGGER VALIDA_FUENTE_SECRETA
BEFORE INSERT ON hecho_crudo FOR EACH ROW
DECLARE 

BEGIN
    IF ((:new.fuente=='s') and (:new.inf_id is null)) THEN
        raise_application_error(-20900,'No se puede registrar un hecho crudo sin una fuente');
    END IF;
END;

--  VALIDAR DESPIDO DE AGENTE   Se descompone en 4 triggers--
  --1
        CREATE OR REPLACE TRIGGER DESPIDO_AGENTE
        BEFORE DELETE ON empleado_inteligencia 
        REFERENCING NEW AS NEW OLD AS OLD

        FOR EACH ROW
        DECLARE
        v_username varchar2(10);
        
        BEGIN
            -- Insertar los datos del agente que se despidio 
            select user into v_username from dual;
            
            INSERT INTO agente_despedido(id_antiguo,nombre,doc_identidad,telefono,fecha_despido) 
            VALUES (:OLD.id_emp_int,:OLD.nombre_pila ||' '|| :OLD.apellido1, :OLD.doc_identidad, :OLD.telefono, sysdate);
        END;
  --2
        CREATE OR REPLACE TRIGGER DESPIDO_AGENTE_INFORMANTE
        BEFORE DELETE ON informante
        REFERENCING NEW AS NEW OLD AS OLD

        FOR EACH ROW
        DECLARE
        v_username varchar2(10);
        agente number;
        BEGIN
            -- Insertar los datos de informantes del agente despedido 
            select user into v_username from dual;
            
            select id_antiguo into agente from agente_despedido where id_antiguo = :OLD.hist_cg_emp_int_id;
            
            if agente = :OLD.hist_cg_emp_int_id then
            INSERT INTO informante_agente_despedido(id_inf_antiguo,nombre_clave,agente)
            VALUES (:OLD.id_informante,:OLD.nombre_clave , :OLD.hist_cg_emp_int_id);
            end if;
            
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    hola('Diego');
        END;

   --3
        CREATE OR REPLACE TRIGGER PAGO_INFORMANTE_DESPIDO
        BEFORE DELETE ON historico_pago
        REFERENCING NEW AS NEW OLD AS OLD

        FOR EACH ROW
        DECLARE
        v_username varchar2(10);
        informante number;
        
        BEGIN
            -- Insertar los datos de informantes del agente despedido 
            select user into v_username from dual;
            
            select id_inf_antiguo into informante from informante_agente_despedido where id_inf_antiguo = :OLD.informante_ID;
            
            if informante = :OLD.informante_ID then
            INSERT INTO pago_informante_despedido( id_pago,fecha,pago,informante)
            VALUES (:OLD.id_pago_infor,:OLD.fecha , :OLD.pago,:OLD.informante_ID);
            end if;
            
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    hola('Diego');
        END;

   --4
    CREATE OR REPLACE TRIGGER HECHO_INFORMANTE_DESPIDO
    BEFORE DELETE ON hecho_crudo
    REFERENCING NEW AS NEW OLD AS OLD

    FOR EACH ROW
    DECLARE
    v_username varchar2(10);
    hecho number;
    
    BEGIN
        -- Insertar los datos de informantes del agente despedido 
        select user into v_username from dual;
        
        select id_pago into hecho from pago_informante_despedido where id_pago = :OLD.hist_pago_id;
        
        if hecho = :OLD.hist_pago_id then
        INSERT INTO hechos_informante_despedido( id_hecho_Eliminado,resumen,tipo_contenido,contenido,nivel_confi_ini,fec_obten,id_pago)
        VALUES (:OLD.id_hecho_cdo,:OLD.resumen , :OLD.tipo_contenido,:OLD.contenido,:OLD.nivel_confi_ini,:OLD.fec_obten,:OLD.hist_pago_id);
        end if;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                hola('Diego');
    END;

-- Tablas paralelas Restringidas -- 

create table agente_despedido(
    id_antiguo          number primary key,
    nombre              varchar2(25) not null,
    doc_identidad       number not null,
    telefono            number not null,
    fecha_despido       date   not null
);

create table informante_agente_despedido(
    id_inf_antiguo      number not null primary key,
    nombre_clave        varchar2(25) not null,
    agente              number not null
  
);


ALTER TABLE informante_agente_despedido ADD CONSTRAINT inf_despedido_fk FOREIGN KEY (agente) REFERENCES agente_despedido (id_antiguo);


create table pago_informante_despedido(
    id_pago number primary key,
    fecha   date not null,
    pago    number not null,
    informante number not null
    
);

alter table  pago_informante_despedido add constraint fk_pg_despido_inf FOREIGN KEY (informante) references informante_agente_despedido (id_inf_antiguo);

create table hechos_informante_despedido(
    id_hecho_Eliminado                  NUMBER NOT NULL PRIMARY KEY,
    resumen                             VARCHAR2(1000) NOT NULL,
    tipo_contenido                      VARCHAR2 (12) NOT NULL,
    contenido                           VARCHAR2 (1000) NOT NULL,
    nivel_confi_ini                     NUMBER NOT NULL,
    fec_obten                           DATE NOT NULL,
    id_pago                             NUMBER NOT NULL
);

alter table hechos_informante_despedido add constraint fk_hc_despido_inf FOREIGN KEY (id_pago ) REFERENCES pago_informante_despedido(id_pago);


-- VALIDAR CAMBIO DE ROL AGENTE/ANALISTA





