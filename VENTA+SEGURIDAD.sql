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
Create or replace trigger venta_trigger
before insert on hist_venta

for each row
DECLARE ns number;

begin 
    Select NIVEL_SEGURIDAD into ns from pieza_inteligencia where id = :new.PIEZA_INTELIGENCIA_ID ;
    if ns < Nivel_acceso() then
        raise_application_error(-20001,'El analista no tiene el clearance necesario para realizar la venta');
    end if;
end;
/

 -- triger q revisa si el cliente es exclusivo 
Create or replace trigger venta_exclusiva_trigger
after insert on hist_venta

for each row
DECLARE ns number;

begin 
    Select exclusivo into ns from CLIENTE where id = :new.CLIENTE_ID ;
    if ns = 1 then
      -- aqui se ponen los delete cascades

    end if;
end;
/

-- vista q muestra todas las piezas de inteligencia a las que el analista tiene acceso
create view VER_PIEZAS 
AS SELECT id, NIVEL_SEGURIDAD,NIVEL_CONFIABILIDAD,PRECIO_APROXIMADO,FECHA_CONSTRUCCION
FROM pieza_inteligencia 
WHERE pieza_inteligencia.nivel_seguridad >= Nivel_acceso();

Create or replace trigger venta_ex_trigger
after insert on hist_venta
for each row
begin
  
end;
/