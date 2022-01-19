create or replace view informantes_ver 
AS SELECT id, NIVEL_SEGURIDAD,NIVEL_CONFIABILIDAD,PRECIO_APROXIMADO,FECHA_CONSTRUCCION
FROM pieza_inteligencia 
WHERE pieza_inteligencia.nivel_seguridad >= Nivel_acceso();

Create or replace trigger venta_ex_trigger
after insert on hist_venta
for each row
begin
  
end;
/

create or replace function agente_id(usuario in varchar2)
return number
is
  v_agente_id number;
begin
  v_agente_id:=TO_NUMBER(SUBSTR(usuario, INSTR(usuario, '_') + 2));
  return v_agente_id;
end;
/

create role Agente NOT IDENTIFIED;
grant execute on agente agente_id to agente;

