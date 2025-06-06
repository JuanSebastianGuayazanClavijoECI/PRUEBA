--(Package Body) ESTUDIANTE
CREATE OR REPLACE PACKAGE BODY PKG_ESTUDIANTE
IS
PROCEDURE consultarHistorialAcademico(C_HISTORIAL OUT SYS_REFCURSOR) IS
BEGIN
  OPEN C_HISTORIAL FOR SELECT * FROM HISTORIAL_ACADEMICO;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    Raise_application_error(-20101, SQLERRM);
END consultarHistorialAcademico;

PROCEDURE consultarInscripciones(C_INSCRIPCIONES OUT SYS_REFCURSOR) IS
BEGIN
  OPEN C_INSCRIPCIONES FOR SELECT * FROM INSCRIPCIONES;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    Raise_application_error(-20102, SQLERRM);
END consultarInscripciones;

PROCEDURE consultarHorario(C_HORARIO OUT SYS_REFCURSOR) IS
BEGIN
  OPEN C_HORARIO FOR SELECT * FROM HORARIOS;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    Raise_application_error(-20103, SQLERRM);
END consultarHorario;

PROCEDURE inscribirMateria(idEstudiante VARCHAR, idMateria VARCHAR, idGrupo VARCHAR) IS
BEGIN
  INSERT INTO INSCRIPCIONES VALUES (idEstudiante, idMateria, idGrupo, SYSDATE);
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    Raise_application_error(-20104, SQLERRM);
END inscribirMateria;
END;
/

--(Package Body) PROFESOR
CREATE OR REPLACE PACKAGE BODY PKG_PROFESOR
IS
PROCEDURE consultarEstudiantesMateria(C_ESTUDIANTES OUT SYS_REFCURSOR, idMateria VARCHAR, idGrupo VARCHAR) IS
BEGIN
  OPEN C_ESTUDIANTES FOR SELECT * FROM ESTUDIANTES_MATERIA WHERE ID_MATERIA = idMateria AND ID_GRUPO = idGrupo;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    Raise_application_error(-20201, SQLERRM);
END consultarEstudiantesMateria;

PROCEDURE consultarNotasMateria(C_NOTAS OUT SYS_REFCURSOR, idMateria VARCHAR, idGrupo VARCHAR) IS
BEGIN
  OPEN C_NOTAS FOR SELECT * FROM NOTAS WHERE ID_MATERIA = idMateria AND ID_GRUPO = idGrupo;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    Raise_application_error(-20202, SQLERRM);
END consultarNotasMateria;

PROCEDURE registrarNota(idEstudiante VARCHAR, idMateria VARCHAR, valorNota NUMBER, tipoEvaluacion VARCHAR) IS
BEGIN
  INSERT INTO NOTAS VALUES (idEstudiante, idMateria, valorNota, tipoEvaluacion, SYSDATE);
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    Raise_application_error(-20203, SQLERRM);
END registrarNota;

PROCEDURE consultarHorarioProfesor(C_HORARIO OUT SYS_REFCURSOR, idProfesor VARCHAR) IS
BEGIN
  OPEN C_HORARIO FOR SELECT * FROM HORARIOS_PROFESOR WHERE ID_PROFESOR = idProfesor;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    Raise_application_error(-20204, SQLERRM);
END consultarHorarioProfesor;
END;
/

--(Package Body) DIRECTOR
CREATE OR REPLACE PACKAGE BODY PKG_DIRECTOR
IS
PROCEDURE consultarEstadisticasAprobacion(C_ESTADISTICAS OUT SYS_REFCURSOR, idDepartamento VARCHAR) IS
BEGIN
  OPEN C_ESTADISTICAS FOR SELECT * FROM ESTADISTICAS_APROBACION WHERE ID_DEPARTAMENTO = idDepartamento;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    Raise_application_error(-20301, SQLERRM);
END consultarEstadisticasAprobacion;

PROCEDURE consultarCargaDocente(C_CARGA OUT SYS_REFCURSOR, idDepartamento VARCHAR) IS
BEGIN
  OPEN C_CARGA FOR SELECT * FROM CARGA_DOCENTE WHERE ID_DEPARTAMENTO = idDepartamento;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    Raise_application_error(-20302, SQLERRM);
END consultarCargaDocente;

PROCEDURE consultarInformeRendimiento(C_RENDIMIENTO OUT SYS_REFCURSOR, semestre VARCHAR) IS
BEGIN
  OPEN C_RENDIMIENTO FOR SELECT * FROM INFORME_RENDIMIENTO WHERE SEMESTRE = semestre;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    Raise_application_error(-20303, SQLERRM);
END consultarInformeRendimiento;

PROCEDURE asignarCargaDocente(idProfesor VARCHAR, idMateria VARCHAR, idGrupo VARCHAR) IS
BEGIN
  INSERT INTO ASIGNACION_DOCENTE VALUES (idProfesor, idMateria, idGrupo, SYSDATE);
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    Raise_application_error(-20304, SQLERRM);
END asignarCargaDocente;
END;
/
