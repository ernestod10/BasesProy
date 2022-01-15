-- Top secret 
create role ACCESO_1 NOT IDENTIFIED;

--confidencial 
create role ACCESO_2 NOT IDENTIFIED;

--Normal 
create role ACCESO_3 NOT IDENTIFIED;

-- Query para ver que rol tiene el usuario haciendo la consulta
select SUBSTR(GRANTED_ROLE, -1) from USER_ROLE_PRIVS where USERNAME=USER and GRANTED_ROLE like  'ACCESO%';

-- en modo trigger 


--se le asignan los roles, y en programas o triggers donde se tenga q verificar se hace ese query//
-- hay que estar pendiente que los programas o los triggers traigan el user del invoker y no del creator