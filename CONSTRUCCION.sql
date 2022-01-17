CREATE or replace function CREA_PIEZA
return NUMBER
is id NUMBER;
(
  )
BEGIN
    INSERT INTO pieza_inteligencia (hist_cg_fec_ini,hist_cg_emp_int_id,hist_cg_est_id,hist_cg_ofic_id,pieza_int_id,tema_id,p_t_id,p_h_id,hecho_cdo_id,v_hecho_cdo_id)
    VALUES (_hist_cg_fec_ini,_hist_cg_emp_int_id,_hist_cg_est_id,_hist_cg_ofic_id,_pieza_int_id,_tema_id,_p_t_id,_p_h_id,_hecho_cdo_id,_v_hecho_cdo_id);
END;



CREATE or replace procedure agregar_hecho (
    id_hecho in Number,
    id_pieza in Number,
)
begin
  insert into P_H (HECHO_CDO_ID,PIEZA_INT_ID)
  values (id_hecho,id_pieza)
end;

Create or Replace procedure PIERZA_CREACION (

)