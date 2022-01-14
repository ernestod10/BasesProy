
-- Director_Area
create role D_area NOT IDENTIFIED;
grant UPDATE(presupuesto_anual) on estacion to D_area; -- Para que el director de una estacion pueda actualizar (Debe existir un trigger que valide que dirige dicha estacion)
grant select on estacion to D_area;
grant select on empleado_inteligencia to D_area;