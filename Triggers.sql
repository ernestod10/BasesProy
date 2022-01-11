
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
    SELECT ofi.ciudad_pais_id, es.ciudad_pais_id, pa.region FROM oficina_principal ofi, estacion es,Pais pa where pa.id_pais = ofi.ciudad_pais_id AND pa.id_pais = es.ciudad_pais_id 
END;