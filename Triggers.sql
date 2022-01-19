
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

-- Trigger para que el director que actualiza presupuesto anual sea de una estacion de su area ## EN DESARROLLO ##

-- cuando se va a actualizar el presupuesto necesito que el director que lo actualice corresponda a las estaciones 
-- necesito el id del director o el nombre de la oficina que representa y segun el dato otorgado por el usuario es que se va a realizar la actualizacion

-- Otra forma pudiera ser mediante un procedimiento el cual va a realizar el update

CREATE OR REPLACE TRIGGER presupuesto_area_correcta
BEFORE UPDATE Of presupuesto_anual ON estacion
REFERENCING NEW AS NEW OLD AS OLD

FOR EACH ROW
DECLARE
    area_incorrecta EXCEPTION;
    Oficina NUMBER(1);
    E_oficina NUMBER(1);
BEGIN
    SELECT ofi.id_oficina into Oficina 
    FROM oficina_principal ofi, empleado_jefe emp
    WHERE ofi.id_oficina = :old.oficina_principal_id;

END;







---------------------------------------------------------------------------------------------
-- Trigger Para crear cuentas de usuario para directores de area ## EN DESARROLLO ##
CREATE OR REPLACE TRIGGER asignacion_cuenta_director
BEFORE INSERT ON empleado_jefe
REFERENCING NEW AS NEW OLD AS OLD

FOR EACH ROW
DECLARE
    Director empleado_jefe_id%TYPE;
    emp_nombre nombre%TYPE;
    error_cuenta_jefe EXCEPTION;

BEGIN
    
    Director := :new.empleado_jefe_id;
    emp_nombre := :new.nombre;
    if Director <> NULL THEN
        RAISE error_cuenta_jefe; -- por ahora arrojara un error 
    END if;
    
    EXECUTE creacion_cuenta(emp_nombre);

    EXCEPTION
    when error_cuenta_jefe THEN  
    RAISE_APPLICATION_ERROR(-20030,'No es un jefe de Area');
END;

-- Procedimiento Para crear Usuario 

CREATE OR REPLACE PROCEDURE creacion_cuenta(nombre in varchar2)
 IS
 v_sql  VARCHAR2 (32767);
 BEGIN
 v_sql := 'CREATE USER '||nombre|| ' IDENTIFIED BY '||nombre||';';
 DBMS_OUTPUT.PUT_LINE (v_sql);
 EXECUTE IMMEDIATE v_sql;
 END creacion_cuenta;




-----------------------------------------------------------------------------------------------------------
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

--DESPIDO DE AGENTE V1
create or replace TRIGGER DESPIDO_AGENTE
BEFORE DELETE ON empleado_inteligencia FOR EACH ROW
DECLARE 

BEGIN
    update historico_cargo set emp_int_id = 0 where emp_int_id = OLD.id;
END;

--DESPIDO DE AGENTE V2
create or replace TRIGGER DESPIDO_AGENTEv2
BEFORE DELETE ON empleado_inteligencia FOR EACH ROW
DECLARE 

BEGIN
    update historico_cargo set emp_int_id = 0 where emp_int_id = :OLD.id;
    update informante set hist_cg_emp_int_id_A  = 0 where hist_cg_emp_int_id_A  = :OLD.id;
    update informante set hist_cg_emp_int_id  = 0 where hist_cg_emp_int_id  = :OLD.id;
END;

-- PROMEDIAR PIEZA AL INSERTAR HC EN ELLA
create or replace TRIGGER T_PROMEDIO_PIEZA
BEFORE INSERT ON p_h FOR EACH ROW
DECLARE 
PROM_CONFI_LOOP NUMBER;
COUNT_HC NUMBER;
FINCONF NUMBER;
PROM_CONFI NUMBER;
PROMEDIO_PI NUMBER;
BEGIN
    SELECT nivel_confiabilidad INTO PROMEDIO_PI FROM pieza_inteligencia WHERE id = :NEW.pieza_int_id;
    SELECT nivel_confi_fin INTO PROM_CONFI FROM hecho_crudo WHERE id_hecho_cdo = :NEW.hecho_cdo_id;

    IF PROMEDIO_PI IS NULL THEN
        UPDATE pieza_inteligencia set nivel_confiabilidad = PROM_CONFI where id = :NEW.pieza_int_id;
    ELSE

    P_NIVEL_CONF_PZ (:NEW.hecho_cdo_id, :NEW.pieza_int_id, PROM_CONFI_LOOP, COUNT_HC); -- # ES EL ID DEL HC Y LA PI
    --COMMIT;
    FINCONF := (PROM_CONFI + PROM_CONFI_LOOP) / (COUNT_HC + 1);
    UPDATE pieza_inteligencia set nivel_confiabilidad = FINCONF where id = :NEW.pieza_int_id;
    
    END IF;
END;


-- AGREGAR AL AREA DE INTERES DESPUES DE VENDER
create or replace TRIGGER T_AREA_INT_VENTA
AFTER INSERT ON hist_venta FOR EACH ROW
DECLARE 
TEMA_PIEZA NUMBER;
BEGIN
    SELECT tema_id INTO TEMA_PIEZA FROM pieza_inteligencia WHERE id = :NEW.pieza_inteligencia_id;
    INSERT INTO area_interes VALUES (:NEW.cliente_id, TEMA_PIEZA);    
END;