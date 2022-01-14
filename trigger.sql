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


--VALIDAR FECHA DE PIEZA DE INTELIGENCIA (QUE NO SEA MAYOR A LA FECHA ACTUAL) 
create or replace TRIGGER VALIDA_FECHA_PZ_INT
BEFORE INSERT ON pieza_inteligencia FOR EACH ROW
DECLARE 

BEGIN
    IF (:NEW.fecha_construccion > SYSDATE) THEN
        raise_application_error(-20900,'La fecha de creación de pieza de inteligencia no puede ser mayor a la fecha actual');
    END IF;
    
END;

--VALIDAR FECHA DE PIEZA DE INTELIGENCIA (QUE NO SEA MAYOR A LA FECHA ACTUAL) 
create or replace TRIGGER VALIDA_FECHA_PZ_INT
BEFORE INSERT ON pieza_inteligencia FOR EACH ROW
DECLARE 

BEGIN
    IF (:NEW.fecha_construccion > SYSDATE) THEN
        raise_application_error(-20900,'La fecha de creación de pieza de inteligencia no puede ser mayor a la fecha actual');
    END IF;
    
END;


--VALIDAR FECHA DE HECHO CRUDO (QUE NO SEA MAYOR A LA FECHA ACTUAL) 
create or replace TRIGGER VALIDA_FECHA_HECHO
BEFORE INSERT ON hecho_crudo FOR EACH ROW
DECLARE 

BEGIN
    IF ((:NEW.fec_obten > SYSDATE) OR (:NEW.fec_fin_cierre > SYSDATE)) THEN
        raise_application_error(-20900,'La fecha de creación de HECHO CRUDO no puede ser mayor a la fecha actual');
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
