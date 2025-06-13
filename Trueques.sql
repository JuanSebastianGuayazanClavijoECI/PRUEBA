
-- 4. El auditor trata de modificar datos en la tabla de Árticulos y eliminar datos de la tabla Categorías,
--    pero la BD le indica que no tiene los permisos suficientes:

INSERT INTO articulos (id, descripcion, estado, foto, precio, disponible, categoria, usuario)
VALUES (1234567890123456, 'Laptop', 'U', 'https://example.com/laptop.jpg', 200, 'TRUE', 'C01', 'USR001');

DELETE FROM categorias WHERE codigo = 'C03';

-- NOTA: El administrador es notificado del intento de la alteración de la BD y envía 
--       una orden de arresto para el auditor (Ficción)  

-- 5. El auditor registra sus resultados en la tabla Evaluaciones y Respuestas.

CALL PK_AUDITOR.adicionarEvaluacion('202204', 'TID01', 'NID1234567890', 'Descripción de la evaluación', 'Reporte de la evaluación', 'OK');
CALL PK_AUDITOR.consultarEvaluacion('202204', 'TID01', 'NID1234567890');
CALL PK_AUDITOR.modificarEvaluacion('Resultado modificado', '202204');
CALL PK_AUDITOR.adicionarRespuesta('Respuesta de ejemplo');
CALL PK_AUDITOR.consultarRespuesta('202204');

-- 6. El auditor termina su trabajo y el administrador le retira sus privilegios sobre la BD:

-- 7. El auditor y administrador cierran sus sesiones:

SELECT sid, serial#
FROM v$session
WHERE username IN ('Daniel_Rodriguez', 'Jesus_Pinzon');

ALTER SYSTEM KILL SESSION '123,456' IMMEDIATE;
ALTER SYSTEM KILL SESSION '789,012' IMMEDIATE;

---------- CODE END ----------
