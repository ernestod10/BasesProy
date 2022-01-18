
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

--DESPIDO DE AGENTE -- ## EN DESARROLLO ------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER DESPIDO_AGENTE
BEFORE DELETE ON empleado_inteligencia 
REFERENCING NEW AS NEW OLD AS OLD

FOR EACH ROW

BEGIN
    -- Insertar los datos del agente que se despidio 
  
    INSERT INTO agente_despedido select  cag.emp_int_id,:OLD.nombre_pila ||' '|| :OLD.apellido1, :OLD.doc_identidad, :OLD.telefono, sysdate
    from historico_cargo cag where  :OLD.id_emp_int = cag.emp_int_id;
   
    -- Insertar los datos de los informantes del agente despedido

    INSERT INTO informante_agente_despedido select inf.id_informante, inf.nombre_clave,cag.emp_int_id 
    from informante inf, historico_cargo cag where :OLD.id_emp_int = cag.emp_int_id and :OLD.id_emp_int = inf.hist_cg_emp_int_id;                    
    
    -- Insertar los datos de los pagos a informantes del agente despedido
   
    INSERT INTO pago_informante_despedido select pg.id_pago_infor, pg.fecha,pg.pago, hc.resumen, inf.id_informante
    from informante inf, historico_cargo cag,historico_pago pg, hecho_crudo hc 
    where :OLD.id_emp_int = cag.emp_int_id and :OLD.id_emp_int = inf.hist_cg_emp_int_id and inf.id_informante = pg.informante_id and hc.id_hecho_cdo = pg.hecho_crudo_id; 
   

    -- Insertar Los hechos crudos Proporcionados por los informantes del agente despedido
    INSERT INTO hechos_informante_despedido select hc.id_hecho_cdo, hc.resumen,hc.tipo_contenido,hc.contenido,hc.nivel_confi_ini,hc.fec_obten, pg.id_pago_infor 
    from informante inf, historico_cargo cag,historico_pago pg, hecho_crudo hc 
    where :OLD.id_emp_int = cag.emp_int_id and :OLD.id_emp_int = inf.hist_cg_emp_int_id and inf.id_informante = pg.informante_id and hc.id_hecho_cdo = pg.hecho_crudo_id; 
    
END;


-- Procedimiento de eliminacion de datos
create or replace procedure DESPEDIR_AGENTE (id_informante IN NUMBER) 
IS
BEGIN
    DELETE from historico_pago where id_informante = informante_id ; 
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
    resumen_hc  varchar2(1000) not null,
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


-- insert de prueba
INSERT INTO agente_despedido select  cag.emp_int_id,emp.nombre_pila ||' '|| emp.apellido1, emp.doc_identidad, emp.telefono, cag.fec_fin
    from empleado_inteligencia emp,historico_cargo cag where  emp.id_emp_int =1;
    

insert into informante_agente_despedido select inf.id_informante, inf.nombre_clave,cag.emp_int_id 
 from informante inf, historico_cargo cag,empleado_inteligencia emp where emp.id_emp_int = cag.emp_int_id and emp.id_emp_int = inf.hist_cg_emp_int_id and emp.id_emp_int = 1;     

select pg.id_pago_infor, pg.fecha,pg.pago, hc.resumen, inf.id_informante
    from informante inf, historico_cargo cag,historico_pago pg, hecho_crudo hc,empleado_inteligencia emp where emp.id_emp_int=1 and emp.id_emp_int = cag.emp_int_id and emp.id_emp_int = inf.hist_cg_emp_int_id and inf.id_informante = pg.informante_id and hc.id_hecho_cdo = pg.hecho_crudo_id; 

insert into hechos_informante_despedido select hc.id_hecho_cdo, hc.resumen,hc.tipo_contenido,hc.contenido,hc.nivel_confi_ini,hc.fec_obten,pg.id_pago_infor 
from informante inf, historico_cargo cag,historico_pago pg, hecho_crudo hc,empleado_inteligencia emp where emp.id_emp_int=1 and emp.id_emp_int = cag.emp_int_id and emp.id_emp_int = inf.hist_cg_emp_int_id and inf.id_informante = pg.informante_id and hc.id_hecho_cdo = pg.hecho_crudo_id; 


-- Vista de detalles sobre agentes despedidos

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------