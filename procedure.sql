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
--funciones generales 
create or replace function emp_id2(usuario in varchar2)
return number
is
  v_agente_id number;
begin
  v_agente_id:=TO_NUMBER(SUBSTR(usuario, INSTR(usuario, '_') + 1));
  return v_agente_id;
end;
/
create or replace function emp_id
return number
is
  v_agente_id number;
begin
  v_agente_id:=TO_NUMBER(SUBSTR(user, INSTR(user, '_') + 1));
  return v_agente_id;
end;
/

create or replace function get_estacion_id(usuario in varchar2)
return number
is
  v_estacion_id number;
begin
  select ESTacion_ID into v_estacion_id from historico_cargo where emp_int_id = emp_id2(usuario) and fec_fin=null;
  return v_estacion_id;
end;
/
create or replace function get_fecha_inicio(usuario in varchar2)
return date
is
  v_fecha_inic date;
begin
  select FEC_INICIO into v_fecha_inic from historico_cargo where emp_int_id = emp_id2(usuario) and fec_fin=null;
  return v_fecha_inic;
end;
/
create or replace function get_oficina(usuario in varchar2)
return number
is
  v_oficina number;
begin
  select EST_OFIC_PRIN_ID into v_oficina from historico_cargo where emp_int_id = emp_id2(usuario) and fec_fin=null;
  return v_oficina;
end;
/

create or replace function get_suma_h(id_hecho in number) RETURN number
is
  v_suma number;
begin
    select SUM(NIV_CONFI) into v_suma from verificacion_hecho where  HECHO_CDO_ID = id_hecho; 
  return v_suma;
end;
/


create or replace function get_cont_h(id_hecho in number) RETURN number
is
  v_connt number;
begin
    select count(NIV_CONFI) into v_connt from verificacion_hecho where  HECHO_CDO_ID = id_hecho ; 
  return v_connt;
end;
/

--funciones para el manejo de informantes 
create or replace view informantes_ver as
select id_informante, nombre_clave, HIST_CG_EMP_INT_ID_A id_empleado_contacto 
from informante 
where HIST_CG_EMP_INT_ID = emp_id;

create or replace procedure nuevo_informante (p_nombre_clave in varchar2, p_id_empleado_contacto in number)
is
  begin
    insert into informante (NOMBRE_CLAVE, HIST_CG_FEC_INI_A, HIST_CG_EMP_INT_ID_A, HIST_CG_EST_ID_A, HIST_CG_OFIC_ID_A, HIST_CG_FEC_INI, HIST_CG_EMP_INT_ID, HIST_CG_EST_ID, HIST_CG_OFIC_ID)
    values(p_nombre_clave,get_fecha_inicio(p_id_empleado_contacto),p_id_empleado_contacto,get_estacion_id(p_id_empleado_contacto),get_oficina(p_id_empleado_contacto),get_fecha_inicio(user),emp_id,get_estacion_id(user),get_oficina(user));
  end;
/
-- funciones para el manejo de hechos crudos


CREATE or replace procedure CREA_Hecho(
resumen in varchar2,
fuente in varchar2,
tipo_contenido in varchar2,
contenido in varchar2,
nivel_confi_in in number,
fec_obten in date,
id_inform in number,
numero_analistas in number

)is
begin
    insert into hecho_crudo (CANTIDAD_ANALISTAS,resumen,fuente,tipo_contenido,contenido,nivel_confi_ini,fec_obten,inf_id,hist_cg_fec_ini,hist_cg_emp_int_id,hist_carg_est_id,hist_carg_ofic_id) 
values (numero_analistas,resumen,fuente,tipo_contenido,contenido,nivel_confi_in,fec_obten,id_inform,get_fecha_inicio(user),emp_id,get_estacion_id(user),get_oficina(user));
END;
/
--synonym
 
--verifica si es el hecho final 
create or replace function final (id_hecho in number) 
return BOOLEAN
is 
v_final boolean;
v_total number;
v_actual number;
begin
    select count(*)into v_actual from verificacion_hecho where HECHO_CDO_ID = id_hecho;
    select CANTIDAD_ANALISTAS into v_total from hecho_crudo where ID_HECHO_CDO = id_hecho;
    if v_actual = v_total then
        v_final:=true;
    else
        v_final:=false;
    end if;
    return v_final;
END;
/
create or replace procedure Verificar_hecho(
  id_hecho in number, 
  niv_confi in number
)is
begin
  Insert into verificacion_hecho (FECHA,NIV_CONFI,HECHO_CDO_ID,HIST_CG_EMP_INT_ID,HIST_CG_FEC_INI,HIST_CG_EST_ID,HIST_CG_OFIC_ID) 
  values (sysdate,niv_confi,id_hecho,emp_id,get_fecha_inicio(user),get_estacion_id(user),get_oficina(user));
  if final_h(id_hecho) then
    update hecho_crudo set FEC_FIN_CIERRE=sysdate where ID_HECHO_CDO=id_hecho;
  end if;
end;
/