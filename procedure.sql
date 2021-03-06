-- PROMEDIAR NIVEL DE CONFIANZA PIEZA DE INTELIGENCIA

CREATE OR REPLACE PROCEDURE P_NIVEL_CONF_PZ (
    ID_HC IN NUMBER,
    ID_PI IN NUMBER,
    PROM_CONFI_LOOP OUT NUMBER,
    COUNT_HC OUT NUMBER,
) 
IS  
    PROMEDIO_PI NUMBER;  
    CONF_HC NUMBER;
    FINCONF NUMBER;
BEGIN

        PROM_CONFI_LOOP := 0;
        COUNT_HC := 0;
        FOR PROM IN (select hecho_cdo_id from p_h where pieza_int_id = ID_PI)
        LOOP
            SELECT nivel_confi_fin INTO CONF_HC FROM hecho_crudo WHERE id_hecho_cdo = PROM.hecho_cdo_id;
            PROM_CONFI_LOOP := PROM_CONFI_LOOP + CONF_HC;
            COUNT_HC := COUNT_HC + 1;
        END LOOP;

    EXCEPTION WHEN OTHERS THEN  
        RAISE_APPLICATION_ERROR(-20001, 'A OCURRIDO UN ERROR AL INSERTAR - ' || SQLCODE || ' -ERROR- ' || SQLERRM);
END;