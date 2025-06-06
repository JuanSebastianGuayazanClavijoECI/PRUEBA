--Paquete ESTUDIANTE
CREATE OR REPLACE PACKAGE PKG_ESTUDIANTE
IS
    PROCEDURE consultarHistorialAcademico(C_HISTORIAL OUT SYS_REFCURSOR);
    PROCEDURE consultarInscripciones(C_INSCRIPCIONES OUT SYS_REFCURSOR);
    PROCEDURE consultarHorario(C_HORARIO OUT SYS_REFCURSOR);
    PROCEDURE inscribirMateria(idEstudiante VARCHAR, idMateria VARCHAR, idGrupo VARCHAR);
END;
/

--Paquete PROFESOR
CREATE OR REPLACE PACKAGE PKG_PROFESOR
IS
    PROCEDURE consultarEstudiantesMateria(C_ESTUDIANTES OUT SYS_REFCURSOR, idMateria VARCHAR, idGrupo VARCHAR);
    PROCEDURE consultarNotasMateria(C_NOTAS OUT SYS_REFCURSOR, idMateria VARCHAR, idGrupo VARCHAR);
    PROCEDURE registrarNota(idEstudiante VARCHAR, idMateria VARCHAR, valorNota NUMBER, tipoEvaluacion VARCHAR);
    PROCEDURE consultarHorarioProfesor(C_HORARIO OUT SYS_REFCURSOR, idProfesor VARCHAR);
END;
/

--Paquete DIRECTOR
CREATE OR REPLACE PACKAGE PKG_DIRECTOR
IS
    PROCEDURE consultarEstadisticasAprobacion(C_ESTADISTICAS OUT SYS_REFCURSOR, idDepartamento VARCHAR);
    PROCEDURE consultarCargaDocente(C_CARGA OUT SYS_REFCURSOR, idDepartamento VARCHAR);
    PROCEDURE consultarInformeRendimiento(C_RENDIMIENTO OUT SYS_REFCURSOR, semestre VARCHAR);
    PROCEDURE asignarCargaDocente(idProfesor VARCHAR, idMateria VARCHAR, idGrupo VARCHAR);
END;
/
--Paquete VICERRECTORIA
CREATE OR REPLACE PACKAGE PKG_VICERRECTORIA
IS
    PROCEDURE consultarProgramas(C_PROGRAMAS OUT SYS_REFCURSOR);
    PROCEDURE consultarMaterias(C_MATERIAS OUT SYS_REFCURSOR);
    PROCEDURE consultarEstudiantes(C_ESTUDIANTES OUT SYS_REFCURSOR);
    PROCEDURE consultarProfesores(C_PROFESORES OUT SYS_REFCURSOR);
END;
/
