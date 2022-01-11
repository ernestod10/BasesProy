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