-- funciones  para obtener los datos para crear una pieza 
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

CREATE OR REPLACE TRIGGER promedio_hecho
    after INSERT ON verificacion_hecho
    FOR EACH ROW 
BEGIN
    UPDATE hecho_crudo 
    SET NIVEL_CONFI_FIN = (get_suma_h(:new.HECHO_CDO_ID)/get_cont_h(:new.HECHO_CDO_ID)) 
    where ID_HECHO_CDO=:new.HECHO_CDO_ID;

END;
/




--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--informates aqui abajo--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Create or replace trigger informante_edit_trigger
before update or delete on informante
for each row
begin
  if :OLD.HIST_CG_EMP_INT_ID != emp_id then
        raise_application_error(-20001,'El agente no tiene el clearance necesario para realizar la operacion');
    end if;
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