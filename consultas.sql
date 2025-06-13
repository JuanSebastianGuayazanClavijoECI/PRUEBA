DECLARE
    v_xml XMLTYPE := XMLTYPE(q'~<?xml version="1.0" encoding="UTF-8"?>
<sistema_academico>
  <directores>
    <director id_usuario="DIRE1000000563">
      <nombre>Nancy Torres Castellanos</nombre>
      <correo>nancy.torres@escuelaing.edu.co</correo>
      <telefono>3158765432</telefono>
      <direccion>Carrera 106 #35-48</direccion>
      <fecha_registro>2020-04-20</fecha_registro>
      <fecha_nombramiento>2022-06-15</fecha_nombramiento>
      <nivel_jerarquico>1</nivel_jerarquico>
      <informes_generados>Informe de gestión académica 2024</informes_generados>
      <presupuesto>95000.00</presupuesto>
    </director>
  </directores>
</sistema_academico>~');

    v_result CLOB;
BEGIN
    -- Mostrar parte del contenido del XML
    DBMS_OUTPUT.PUT_LINE('XML cargado correctamente.');

    -- Ejemplo de consulta XPath desde el XML en PL/SQL
    SELECT XMLQuery('/sistema_academico/directores/director/nombre/text()'
                    PASSING v_xml
                    RETURNING CONTENT)
    INTO v_result
    FROM dual;

    DBMS_OUTPUT.PUT_LINE('Nombre del director: ' || v_result);
END;
/
