CREATE or replace procedure agregar_hecho (
    id_hecho in Number,
    id_pieza in Number
)is 
begin
  insert into P_H (HECHO_CDO_ID,PIEZA_INT_ID)
  values (id_hecho,id_pieza);
end;

-- funciones  para obtener los datos para crear una pieza 
create or replace function get_estacion_id
return number
is
  v_estacion_id number;
begin
  select ESTacion_ID into v_estacion_id from historico_cargo where emp_int_id = SUBSTR(user,-1) and fec_fin=null;
  return v_estacion_id;
end;
/
create or replace function get_fecha_inicio
return date
is
  v_fecha_inic date;
begin
  select FEC_INICIO into v_fecha_inic from historico_cargo where emp_int_id = SUBSTR(user,-1) and fec_fin=null;
  return v_fecha_inic;
end;
/
create or replace function get_oficina
return number
is
  v_oficina number;
begin
  select EST_OFIC_PRIN_ID into v_oficina from historico_cargo where emp_int_id = SUBSTR(user,-1) and fec_fin=null;
  return v_oficina;
end;
/
CREATE or replace procedure CREA_PIEZA(
PRECIO_APROXIMADO in number,
NIVEL_CONFIABILIDAD in number,
NIVEL_SEGURIDAD in number,
TEMA_ID in number
)is
begin
    insert into pieza_inteligencia (fecha_construccion,hist_cg_emp_int_id,hist_cg_est_id,hist_cg_fec_ini,hist_cg_ofic_id,nivel_confiabilidad,nivel_seguridad,precio_aproximado,tema_id)
VALUES(SYSDATE,(TO_NUMBER(SUBSTR(user, -1))), get_estacion_id,get_fecha_inicio,get_oficina,NIVEL_CONFIABILIDAD,NIVEL_SEGURIDAD,PRECIO_APROXIMADO,TEMA_ID);

END;


Create or replace trigger hecho_confi_trigger
before insert on P_H

for each row
DECLARE ns number;

begin 
    Select NIVEL_CONFI_FIN into ns from hecho_crudo where ID_HECHO_CDO = :new.HECHO_CDO_ID ;
    if ns <= 85 then
        raise_application_error(-20001,'El nivel de confiabilidad del hecho es menor a 85%');
    end if;
end;
/

Create or replace trigger seguridad_creacion_trigger
before insert on pieza_inteligencia

for each row


begin 

    if :new.NIVEL_SEGURIDAD < Nivel_acceso() then
        raise_application_error(-20001,'El analista no tiene el clearance necesario para realizar la operacion');
    end if;
end;
/