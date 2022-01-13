
-- Director_Area
create role Director_Area;
grant UPDATE(presupuesto_anual) on estacion to Director_Area; -- Para que el director de una estacion pueda actualizar (Debe existir un trigger que valide que dirige dicha estacion)
