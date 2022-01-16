create or replace procedure Venta( 
Precio_final in number ,
pieza_inteligencia_id in NUMBER ,
cliente_id in NUMBER
)
is
begin
    insert into hist_venta (fecha_venta,total_precio_final,pieza_inteligencia_id,cliente_id)
    values(SYSDATE,Precio_final,pieza_inteligencia_id,cliente_id);
end;

--funcion que devuelve el nivel de acceso del usuaio 
create or replace function Nivel_acceso
return NUMBER
is nivel number;   
begin
SELECT TO_NUMBER(SUBSTR(GRANTED_ROLE, -1)) into nivel from USER_ROLE_PRIVS where USERNAME=user and GRANTED_ROLE like  'ACCESO%';
    return nivel;
end;
/
--Trigger venta revisa si el analista tiene el clearance 
create or replace trigger venta_trigger
before insert on hist_venta
REFERENCING OLD AS OLD NEW AS NEW
for each row
begin 
    if :NEW.NIVEL_SEGURIDAD < Nivel_acceso() then
        raise_application_error(-20001,'El analista no tiene el clearance necesario para realizar la venta');
    end if;
end;
/
-- No entiendo xq el trigger no funciona :C


-- vista q muestra todas las piezas de inteligencia a las que el analista tiene acceso
create view VER_PIEZAS 
AS SELECT id, NIVEL_SEGURIDAD,NIVEL_CONFIABILIDAD,PRECIO_APROXIMADO,FECHA_CONSTRUCCION
FROM pieza_inteligencia 
WHERE pieza_inteligencia.nivel_seguridad >= Nivel_acceso();

