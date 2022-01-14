
-- Trigger de confirmacion de jerarquia de jefe de estacion y director de area ### EN DESARROLLO ##

CREATE OR REPLACE TRIGGER jefe_director_correspondientes
BEFORE INSERT ON empleado_jefe
REFERENCING NEW AS NEW OLD AS OLD

FOR EACH ROW
DECLARE 
    director_invalido EXCEPTION;
    R_Director VARCHAR2(3);
    O_region VARCHAR2(3);
BEGIN
    SELECT pa.region into O_region 
    from ciudad ci, pais pa, oficina_principal ofi
    WHERE ofi.ciudad_id = ci.id_ciudad AND pa.id_pais = ofi.ciudad_pais_id AND ofi.empleado_jefe_id  = :new.id;

    SELECT pa.region into R_Director
    FROM ciudad ci, pais pa, estacion es
    where es.ciudad_id = ci.id_ciudad AND pa.id_pais = es.ciudad_pais_id AND es.empleado_jefe_id = :new.id;

    if R_Director <> O_region then
        raise director_invalido;
    end if;

    EXCEPTION
    when director_invalido THEN  
    RAISE_APPLICATION_ERROR(-20009,'Director de Area incorrecto para el jefe de estacion');
END;



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

--DESPIDO DE AGENTE 
CREATE OR REPLACE TRIGGER DESPIDO_AGENTEv2
BEFORE DELETE ON empleado_inteligencia FOR EACH ROW
DECLARE 
    informante NUMBER;
BEGIN
    select inf.id_informante into informante from informante inf, historico_cargo cg where :OLD.id_emp_int = cg.emp_int_id AND cg.emp_int_id = inf.hist_cg_emp_int_id;
 

    update historico_cargo set emp_int_id = 0 where emp_int_id = :OLD.id;
    update informante set hist_cg_emp_int_id_A  = 0 where hist_cg_emp_int_id_A  = :OLD.id;
    update informante set hist_cg_emp_int_id  = 0 where hist_cg_emp_int_id  = :OLD.id;

    DESPEDIR_AGENTE(informante);
END;

create or replace procedure DESPEDIR_AGENTE (id_informante IN NUMBER) 
IS
BEGIN
    DELETE from historico_pago where id_informante = informante_id ; 
END; 