
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