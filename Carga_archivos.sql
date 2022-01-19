
-- Directorio de Diego 
CREATE OR REPLACE DIRECTORY media_dir AS 'C:\Users\diego\Desktop\7mo Semestre\Sistemas de bases de datos II\Proyecto\Entrega II\img_proy';


-- DBMS_LOB BFILE functionality

create or replace procedure cargar_archivos(archivo in varchar2) is l_bfile BFILE := BFILENAME('MEDIA_DIR', archivo);
    BEGIN
     DBMS_OUTPUT.PUT_LINE('Existe? ' || DBMS_LOB.FILEEXISTs(l_bfile));
     DBMS_OUTPUT.PUT_LINE('Esta Abierto antes de abrir '|| DBMS_LOB.fileisopen(l_bfile));
     DBMS_LOB.fileopen(l_bfile);
     DBMS_OUTPUT.PUT_LINE('Esta Abierto despues de abrir '|| DBMS_LOB.fileisopen(l_bfile));
     DBMS_LOB.fileclose(l_bfile);
     DBMS_OUTPUT.PUT_LINE('Esta Abierto despues de cerrar '|| DBMS_LOB.fileisopen(l_bfile));
     END cargar_archivos;

execute cargar_archivos('mountains.png');



CREATE OR REPLACE PROCEDURE verificar_archivo IS
    fil BFILE;
BEGIN    
    SELECT photo INTO fil FROM prueba_bfile WHERE id_p_b = 1;
    IF (dbms_lob.fileexists(fil)) 
    THEN
        DBMS_OUTPUT.PUT_LINE('EXISTE'); -- file exists code
    ELSE
        DBMS_OUTPUT.PUT_LINE('NO EXISTE');; -- file does not exist code
    END IF;
    EXCEPTION
        WHEN some_exception
        THEN handle_exception;
END;




alter table empleado_inteligencia add alias_agente alias_nt nested table alias_agente store as alias_nt_2;

alter table empleado_inteligencia drop column alias_agente; 

alter table empleado_inteligencia MODIFY alias_agente  ;

alter table empleado_inteligencia add familiar2 FAMILIAR;

alter table prueba_bfile add photo2 BLOB;

update prueba_bfile set photo = BFILENAME('MEDIA_DIR', 'mountains.png') where id_p_b = 1;

Create table prueba_bfile(
    id_p_b number primary key,
    photo Bfile not null
);
   


