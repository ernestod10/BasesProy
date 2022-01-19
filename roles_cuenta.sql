------------------------------------------------------      Roles       ----------------------------------------------------------------------

-- Director CEO 
create role D_CEO NOT IDENTIFIED;
grant select any table to D_CEO;


-- Director_Area
create role D_area NOT IDENTIFIED;
grant UPDATE(presupuesto_anual) on estacion to D_area; -- Para que el director de una estacion pueda actualizar (Debe existir un trigger que valide que dirige dicha estacion)
grant select,insert,update on estacion to D_area;
grant select on empleado_inteligencia to D_area;
grant delete on empleado_inteligencia to D_area;
grant select on hecho_crudo to D_area;
grant select on agente_despedido to D_area;
grant select on informante_agente_despedido to D_area;
grant select on pago_informante_despedido to D_area;
grant select on hechos_informante_despedido to D_area;
grant select on hist_venta to D_area;
grant select, delete on historico_seguridad to D_area;
grant select on historico_cargo;

-- Jefe_Estacion
create role D_estacion NOT IDENTIFIED;
grant select, update,insert on historico_cargo to D_estacion;
grant select on estacion to D_estacion;
grant select on ciudad to D_estacion;
grant select on pais to D_estacion;




-- Analista
create role Analista NOT IDENTIFIED;
grant select on hecho_crudo to Analista;
grant update on hecho_crudo to Analista;
grant select on pieza_inteligencia to Analista;
grant update on pieza_inteligencia to Analista;
grant select on p_h to Analista;
grant update on p_h to Analista;
grant select on p_t to Analista;
grant update on p_t to Analista;
grant select on verificacion_hecho to Analista;
grant update on verificacion_hecho to Analista;
grant select on empleado_jefe to Analista;

-- Agente 
create role Agente NOT IDENTIFIED;
grant select, delete, update,insert on informante to Agente;
grant select,update,insert on hecho_crudo to Agente;
grant insert,select on verificacion_hecho to Agente;
grant select, insert, update on historico_pago to Agente;
grant select on empleado_jefe to Agente;

-- Cliente 

create role cliente NOT IDENTIFIED;
grant select on hist_venta to cliente;

---------------------------------------------------      Cuentas        -------------------------------------------------------------------------------