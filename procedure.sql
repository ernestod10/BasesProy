-- PROMEDIAR NIVEL DE CONFIANZA PIEZA DE INTELIGENCIA

CREATE OR REPLACE PROCEDURE P_NIVEL_CONF_PZ (
    ID_HC IN NUMBER,
    ID_PI IN NUMBER
) 
IS 
    ID_PI_SELECT NUMBER; 
    ID_HC_SELECT NUMBER;
    PROM_CONFI NUMBER;
    PROMEDIO_PI NUMBER;  
    CONF_HC NUMBER;
    COUNT_HC NUMBER;
    PROM_CONFI_LOOP NUMBER;
    FINCONF NUMBER;
BEGIN

    IF ((ID_HC IS NULL) OR (ID_PI IS NULL)) THEN
        RAISE_APPLICATION_ERROR(-20001, 'A OCURRIDO UN ERROR AL INSERTAR - ' || SQLCODE || ' -ERROR- ' || SQLERRM);    
    ELSE
        SELECT id INTO ID_PI_SELECT FROM pieza_inteligencia WHERE id = ID_PI;
        SELECT id_hecho_cdo INTO ID_HC_SELECT FROM hecho_crudo WHERE id_hecho_cdo = ID_HC;

        INSERT INTO p_h VALUES (ID_HC_SELECT, ID_PI_SELECT);

        -- SACAR PROMEDIO AQUI
        SELECT nivel_confiabilidad INTO PROMEDIO_PI FROM pieza_inteligencia WHERE id = ID_PI_SELECT;
        SELECT nivel_confi_fin INTO PROM_CONFI FROM hecho_crudo WHERE id_hecho_cdo = ID_HC_SELECT;

        IF PROMEDIO_PI IS NULL THEN
            UPDATE pieza_inteligencia set nivel_confiabilidad = PROM_CONFI where id = ID_PI_SELECT;
        ELSE
            PROM_CONFI_LOOP := 0;
            COUNT_HC := 0;
            FOR PROM IN (select hecho_cdo_id from p_h where pieza_int_id = ID_PI_SELECT)
            LOOP
                SELECT nivel_confi_fin INTO CONF_HC FROM hecho_crudo WHERE id_hecho_cdo = PROM.hecho_cdo_id;
                PROM_CONFI_LOOP := PROM_CONFI_LOOP + CONF_HC;
                COUNT_HC := COUNT_HC + 1;
            END LOOP;

            FINCONF := PROM_CONFI_LOOP / COUNT_HC;
            UPDATE pieza_inteligencia set nivel_confiabilidad = FINCONF where id = ID_PI_SELECT;
        END IF;
    
    END IF;

    COMMIT;

    EXCEPTION WHEN OTHERS THEN  
        RAISE_APPLICATION_ERROR(-20001, 'A OCURRIDO UN ERROR AL INSERTAR - ' || SQLCODE || ' -ERROR- ' || SQLERRM);
END;


-- USAR PROCEDURE P_NIVEL_CONF_PZ
BEGIN
   P_NIVEL_CONF_PZ (#,#); -- # ES EL ID DEL HC Y LA PI
   COMMIT;
END;