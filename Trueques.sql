

DROP SEQUENCE idauditoria;
CREATE SEQUENCE idauditoria
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE;

CREATE TABLE evaluaciones (
    a_omes VARCHAR2(6) NOT NULL,
    tid VARCHAR2(2) NOT NULL,
    nid VARCHAR2(10) NOT NULL,
    fecha DATE,
    descripcion XMLTYPE,
    reporte VARCHAR2(100) NOT NULL,
    resultado VARCHAR2(2) NOT NULL 
);

CREATE TABLE respuestas (
    a_omes VARCHAR2(6) NOT NULL,
    respuesta VARCHAR2(50) NOT NULL
);



-- CICLO 1: CRUDE EVALUACIONES

CREATE OR REPLACE PACKAGE PK_EVALUACIONES AS
    -- Procedimiento para agregar una nueva evaluación
    PROCEDURE agregar_evaluacion(
        p_a_omes IN VARCHAR2,
        p_tid IN VARCHAR2,
        p_nid IN VARCHAR2,
        p_descripcion IN VARCHAR2,
        p_reporte IN VARCHAR2,
        p_resultado IN VARCHAR2
    );

    -- Función para obtener cosultas de una evaluación por ID
    FUNCTION obtener_evaluacion_por_id(
        p_a_omes IN VARCHAR2,
        p_tid IN VARCHAR2,
        p_nid IN VARCHAR2)
    RETURN evaluaciones%ROWTYPE;

    -- Procedimiento para actualizar una evaluación existente
    PROCEDURE actualizar_evaluacion(
        p_resultado IN VARCHAR2,
        p_a_omes IN VARCHAR2
    );

    -- Procedimiento para eliminar una evaluación
    PROCEDURE eliminar_evaluacion(
        p_a_omes IN VARCHAR2
    ); 
END;
/

CREATE OR REPLACE PACKAGE PK_RESPUESTAS AS
    PROCEDURE adicionar(respuesta IN VARCHAR2);
    PROCEDURE consultar(a_omes IN VARCHAR2, respuesta IN VARCHAR2);
    PROCEDURE modificar;
    PROCEDURE eliminar(a_omes IN VARCHAR2);
END PK_RESPUESTAS;
/

CREATE OR REPLACE PACKAGE PK_AUDITORIAS AS
    PROCEDURE adicionar(accion IN VARCHAR2, nombre IN VARCHAR2);
    PROCEDURE consultar(id OUT NUMBER, fecha OUT DATE, accion OUT VARCHAR2, nombre OUT VARCHAR2, evaluacion OUT VARCHAR2, categoria OUT VARCHAR2);
    PROCEDURE modificar(resultado IN VARCHAR2);
    PROCEDURE eliminar(id IN NUMBER);
END PK_AUDITORIAS;
/



-- CICLO 1: CRUDI EVALUACIONES

CREATE OR REPLACE PACKAGE BODY PK_EVALUACIONES AS
    -- Procedimiento para agregar una nueva evaluación
    PROCEDURE agregar_evaluacion(
        p_a_omes IN VARCHAR2,
        p_tid IN VARCHAR2,
        p_nid IN VARCHAR2,
        p_descripcion IN VARCHAR2,
        p_reporte IN VARCHAR2,
        p_resultado IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO evaluaciones(a_omes, tid, nid, descripcion, reporte, resultado)
        VALUES (p_a_omes, p_tid, p_nid, p_descripcion, p_reporte, p_resultado);
    END agregar_evaluacion;

    -- Función para obtener información de una evaluación por ID
    FUNCTION obtener_evaluacion_por_id(
        p_a_omes VARCHAR2
    ) RETURN evaluaciones%ROWTYPE IS
        evaluacion_row evaluaciones%ROWTYPE;
    BEGIN
        SELECT * INTO evaluacion_row
        FROM evaluaciones
        WHERE a_omes = p_a_omes;
        
        RETURN;
    END obtener_evaluacion_por_id;

    -- Procedimiento para actualizar una evaluación existente
    PROCEDURE actualizar_evaluacion(
        p_a_omes VARCHAR2,
        p_resultado VARCHAR2
    ) IS
    BEGIN
        UPDATE evaluaciones
        SET resultado = p_resultado
        WHERE a_omes = p_a_omes;
    END actualizar_evaluacion;

    -- Procedimiento para eliminar una evaluación
    PROCEDURE eliminar_evaluacion(
        p_a_omes VARCHAR2
    ) IS
    BEGIN
        DELETE FROM evaluaciones
        WHERE a_omes = p_a_omes;
    END eliminar_evaluacion;
END PC_EVALUACIONES;
/

CREATE OR REPLACE PACKAGE BODY PK_RESPUESTAS AS
    PROCEDURE adicionar(respuesta IN VARCHAR2) AS
    BEGIN
        -- Procedimiento para añadir una nueva respuesta
        INSERT INTO respuestas (respuesta, fecha)
        VALUES (respuesta, SYSDATE);
    END adicionar;

    PROCEDURE consultar(a_omes IN VARCHAR2, respuesta IN VARCHAR2) AS
    BEGIN
        -- Procedimiento para consultar una respuesta
        SELECT respuesta
        FROM respuestas r
        WHERE a_omes = r.a_omes AND respuesta = respuesta;
    END consultar;

    PROCEDURE modificar AS
    BEGIN
        -- Procedimiento para modificar una respuesta
        NULL;
    END modificar;

    PROCEDURE eliminar(a_omes IN VARCHAR2) IS
    BEGIN
        -- Procedimiento para eliminar una respuesta
        DELETE FROM respuestas r
        WHERE a_omes = r.a_omes;
    END eliminar;
END PK_RESPUESTAS;
/

CREATE OR REPLACE PACKAGE BODY PK_AUDITORIAS AS
    PROCEDURE adicionar(accion IN VARCHAR2, nombre IN VARCHAR2) AS
    BEGIN
        -- Procedimiento para añadir una nueva auditoría
        INSERT INTO auditorias (accion, nombre, fecha)
        VALUES (accion, nombre, SYSDATE);
    END adicionar;

    PROCEDURE consultar(id OUT NUMBER, fecha OUT DATE, accion OUT VARCHAR2, nombre OUT VARCHAR2, evaluacion OUT VARCHAR2, categoria OUT VARCHAR2) AS
    BEGIN
        -- Procedimiento para consultar una auditoría
        SELECT id, fecha, accion, nombre, evaluacion, categoria
        INTO id, fecha, accion, nombre, evaluacion, categoria
        FROM auditorias;
    END consultar;

    PROCEDURE modificar(resultado IN VARCHAR2) AS
    BEGIN
        -- Procedimiento para modificar una auditoría
        UPDATE auditorias a
        SET resultado = a.resultado;
    END modificar;

    PROCEDURE eliminar(id IN NUMBER) IS
    BEGIN
        -- Procedimiento para eliminar una auditoría
        DELETE FROM auditorias a
        WHERE id = a.id;
    END eliminar;
END PK_AUDITORIAS;
/


-- CICLO 1: XCRUD
/*
DROP PACKAGE PK_EVALUACIONES;
DROP PACKAGE PK_AUDITORIAS;
DROP PACKAGE PK_RESPUESTAS;
*/


-- CICLO 1: ActoresE

CREATE PACKAGE PK_ADMINISTRADOR AS
    PROCEDURE adicionarAuditoria(accion IN VARCHAR2, nombre IN VARCHAR2);
    PROCEDURE consultarAuditoria(id OUT NUMBER, fecha OUT DATE, accion OUT VARCHAR2, nombre OUT VARCHAR2, evaluacion OUT VARCHAR2, categoria OUT VARCHAR2);
    PROCEDURE modificarAuditoria(resultado IN VARCHAR2);
END PK_ADMINISTRADOR;
/

CREATE PACKAGE PK_AUDITOR AS
    PROCEDURE adicionarEvaluacion(p_a_omes IN VARCHAR2, p_tid IN VARCHAR2, p_nid IN VARCHAR2, p_descripcio IN VARCHAR2, p_reporte IN ARCHAR2, p_resultado IN VARCHAR2);
    PROCEDURE consultarEvaluacion(p_a_omes IN VARCHAR2, p_tid IN  VARCHAR2, p_nid IN VARCHAR2);
    PROCEDURE modificarEvaluacion(p_resultado IN VARCHAR2, p_a_omes IN VARCHAR2);
    PROCEDURE eliminarEvaluacion(p_a_omes IN VARCHAR2); 
    PROCEDURE adicionarRespuesta(respuesta IN VARCHAR2);
    PROCEDURE consultarRespuesta(a_omes IN VARCHAR2, respuesta IN VARCHAR2);
END PK_AUDITOR;
/



-- CICLO 1: ActoresI

CREATE PACKAGE BODY PK_ADMINISTRADOR AS
    PROCEDURE adicionarAuditoria(accion IN VARCHAR2, nombre IN VARCHAR2) IS
    BEGIN
        PK_AUDITOR.adicionarEvaluacion(accion, nombre);
    END adicionarAuditoria;

    PROCEDURE consultarAuditoria(id OUT NUMBER, fecha OUT DATE, accion OUT VARCHAR2, nombre OUT VARCHAR2, evaluacion OUT VARCHAR2, categoria OUT VARCHAR2) IS
    BEGIN
        PK_AUDITOR.consultarEvaluacion('A01', accion, nombre);
    END consultarAuditoria;

    PROCEDURE modificarAuditoria(resultado IN VARCHAR2) IS
    BEGIN
        PK_AUDITOR.modificarEvaluacion(resultado, 'A01');
    END modificarAuditoria;
END PK_ADMINISTRADOR;
/


CREATE PACKAGE BODY PK_AUDITOR AS
    PROCEDURE adicionarEvaluacion(p_a_omes IN VARCHAR2, p_tid IN VARCHAR2, p_nid IN VARCHAR2, p_descripcio IN VARCHAR2, p_reporte IN VARCHAR2, p_resultado IN VARCHAR2) IS
    BEGIN
        PK_EVALUACIONES.adicionar(p_tid, p_nid, p_descripcio, p_reporte, p_resultado);
    END adicionarEvaluacion;

    PROCEDURE consultarEvaluacion(p_a_omes IN VARCHAR2, p_tid IN  VARCHAR2, p_nid IN VARCHAR2) IS
    BEGIN
        PK_EVALUACIONES.consultar(p_a_omes, SYSDATE, p_descripcion, p_reporte, p_resultado);
    END consultarEvaluacion;

    PROCEDURE modificarEvaluacion(p_resultado IN VARCHAR2, p_a_omes IN VARCHAR2) IS
    BEGIN
        PK_EVALUACIONES.modificar(p_descripcion);
    END modificarEvaluacion;

    PROCEDURE eliminarEvaluacion(p_a_omes IN VARCHAR2) IS
    BEGIN
        PK_EVALUACIONES.eliminar(p_a_omes);
    END eliminarEvaluacion;

    PROCEDURE adicionarRespuesta(respuesta IN VARCHAR2) IS
    BEGIN
        PK_RESPUESTAS.adicionar(respuesta);
    END adicionarRespuesta;

    PROCEDURE consultarRespuesta(a_omes IN VARCHAR2, respuesta IN VARCHAR2) IS
    BEGIN
        PK_RESPUESTAS.consultar(a_omes, respuesta);
    END consultarRespuesta;
END PK_AUDITOR;
/

-- CICLO 1: Seguridad

-- 1. Creación de roles

CREATE ROLE Administrador;
CREATE ROLE Auditor;

-- 2. Creación de usuarios

CREATE USER Daniel_Rodriguez
IDENTIFIED BY 1000076386;
CREATE USER Jesus_Pinzon
IDENTIFIED BY 1000095859;


-- 2. Otoragción de permisos

-- 2.1. Administrador

GRANT INSERT(accion, nombre), SELECT, UPDATE(resultado), DELETE
ON auditorias
TO Administrador, Daniel_Rodriguez;

-- 2.2. Auditor

GRANT INSERT(tid, nid, descripcion, reporte, resultado), SELECT, UPDATE(descripcion), DELETE
ON evaluaciones
TO Auditor, Jesus_Pinzon;

GRANT INSERT(respuesta), SELECT
ON repuestas
TO Auditor, Jesus_Pinzon;



-- CICLO 1: XSeguridad
/*
DROP PACKAGE PK_ADMINISTRADOR;
DROP PACKAGE PK_AUDITOR;

-- Eliminar permisos del Administrador
REVOKE INSERT(accion, nombre), SELECT, UPDATE(resultado), DELETE
ON auditorias
FROM Administrador;

-- Eliminar permisos del Auditor
REVOKE INSERT(tid, nid, descripcion, reporte, resultado), SELECT, UPDATE(descripcion), DELETE
ON evaluaciones
FROM Auditor;

REVOKE INSERT(respuesta), SELECT
ON repuestas
FROM Auditor;

-- Eliminar roles y usuarios
DROP ROLE Administrador;
DROP ROLE Auditor;
DROP USER Daniel_Rodriguez;
DROP USER Jesus_Pinzon;
*/


-- CICLO 1: Pruebas

-- Prueba de aceptación para el Administrador
/*
YO Jesus Pinzon,
COMO auditor,
QUIERO realizar una evaluación de los artículos y categorías de la plataforma Trueques,
PARA PODER validar su funcionamiento bajo los más altos estándares de calidad.
*/

-- 1. El auditor puede acceder a la BD por su rol o usuario:

CONNECT / AS (Auditor);
CONNECT Jesus_Pinzon/1000095859;

-- 2. Ya que el auditor no tiene acceso completo a la BD de Trueques,
--    le pide al administrador que le conceda los permisos neccesarios para su evaluación:

-- 2.1.  El administrador ingresa a la BD:

CONNECT / AS (Administrador);
CONNECT Daniel_Rodriguez/1000076386;

-- 2.2. El administrador le da acceso restringido al auditor a las tablas de Artículos, Categorías y Calificaciones:

GRANT SELECT(id, descripcion, estado, foto, precio, disponible, categoria)
ON articulos
TO Jesus_Pinzon;

GRANT SELECT
ON categorias
TO Jesus_Pinzon;

GRANT SELECT(articulo, estrella)
ON calificaciones
TO Jesus_Pinzon;

-- 3. El auditor consulta las tablas Artículos, Categorías y Calificaciones a través de sus vistas:

SELECT *
FROM VTRUEQUES_EXITOSOS;

SELECT *
FROM VCATEGORIAS;

SELECT *
FROM VCALIFICACIONES;

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
