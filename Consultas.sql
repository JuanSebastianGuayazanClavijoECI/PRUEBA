---------- CODE START ----------

-- Consultas XPath en SQL

-- 1. Los productos de un extra específico. (Con toda la información)

SELECT XMLQuery('/Extras/extra[@extra_id="5001"]/producto'
               PASSING columna_xml
               RETURNING CONTENT)
FROM tabla_xml;

-- 2. Los extras que lograron propinas mayores a un valor dado.

SELECT XMLQuery('/Extras/extra[propina > 50.00]'
               PASSING columna_xml
               RETURNING CONTENT)
FROM tabla_xml;

-- 3. El número de extras por ubicación.

SELECT ubicacion, COUNT(XMLQuery('count(/Extras/extra/producto[ubicacion="comedor"])'
                        PASSING columna_xml RETURNING CONTENT)) AS cantidad_extras
FROM tabla_xml
GROUP BY ubicacion;

-- 4. Obtener la lista de extras y sus productos en formato XML.ALTER

SELECT dbms_xmlgen.getxmltype(
           'SELECT extra_id, reserva_id,
                   XMLQuery('XMLFOREST(nombre AS "nombre",
                                        cantidad AS "cantidad",
                                        precio AS "precio",
                                        propina AS "propina",
                                        ubicacion AS "ubicacion")''
                            PASSING PRODUCTOS
                            COLUMNS nombre VARCHAR2(50),
                                    cantidad NUMBER,
                                    precio NUMBER,
                                    propina NUMBER,
                                    ubicacion VARCHAR2(50)) AS xml_data
FROM Extras;

-- 5. Obtener la suma total de propinas por ubicación en formato XML.

SELECT dbms_xmlgen.getxmltype(
           'SELECT ubicacion, SUM(propina) AS total_propinas
            FROM Extras
            GROUP BY ubicacion') AS xml_data
FROM dual;

---------- CODE END ----------