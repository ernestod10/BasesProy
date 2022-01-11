
-- Trigger de confirmacion de jerarquia de jefe de estacion y director de area

CREATE OR REPLACE TRIGGER jefe_director_correspondientes
BEFORE INSERT or update of 




CREATE OR REPLACE TRIGGER oficina_estacion_region
AFTER INSERT ON estacion
DECLARE 
    lugar_incorrecto EXCEPTION;
    E_region VARCHAR2(3);
    O_region VARCHAR2(3);
BEGIN
    SELECT e.region,o.region into E_region,O_region from detalle_estacion e, detalle_oficina o, estacion es where es.oficina_principal_id = o.oficina;
    if E_region <> O_region then
        rollback;
        raise lugar_incorrecto;
    end if;

    EXCEPTION
    when lugar_incorrecto THEN  
    dbms_output.put_line('Oficina ubicada en la direccion de area equivocado');
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