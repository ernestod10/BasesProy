
-- Trigger de confirmacion de jerarquia de jefe de estacion y director de area

CREATE OR REPLACE TRIGGER jefe_director_correspondientes
BEFORE INSERT or update of 




CREATE OR REPLACE TRIGGER oficina_estacion_region
BEFORE INSERT ON estacion
DECLARE 
    lugar_incorrecto EXCEPTION;
    E_region VARCHAR2(3);
    O_region VARCHAR2(3);
BEGIN
    SELECT e.region into E_region, o.region into O_region from detalle_estacion e, detalle_oficina o where e.oficina = o.oficina;
    if :new.
END;