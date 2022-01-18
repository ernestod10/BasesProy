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


--
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