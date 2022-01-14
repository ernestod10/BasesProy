
-- Director_Area
create role D_area NOT IDENTIFIED;
grant UPDATE(presupuesto_anual) on estacion to D_area; -- Para que el director de una estacion pueda actualizar (Debe existir un trigger que valide que dirige dicha estacion)
grant select on estacion to D_area;
grant select on empleado_inteligencia to D_area;

--Analista
create role Analista NOT IDENTIFIED;;
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

