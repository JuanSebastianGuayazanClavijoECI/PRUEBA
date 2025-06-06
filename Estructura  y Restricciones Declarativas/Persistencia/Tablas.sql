--CICLO 1

CREATE TABLE DIRECTORES(
    idUsuario VARCHAR2(25) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    correo VARCHAR2(50),
    contrasena VARCHAR2(50) NOT NULL,
    telefono VARCHAR2(10),
    direccion VARCHAR2(100) NOT NULL,
    fechaRegistro DATE NOT NULL,
    fechaNombramiento DATE NOT NULL,
    nivelJerarquico VARCHAR2(10) NOT NULL,
    informesGenerados VARCHAR2(100) NOT NULL,
    presupuestoAsignados number(10,2) NOT NULL
);

CREATE TABLE PROFESORES (
    idUsuario VARCHAR2(25) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    correo VARCHAR2(50),
    contrasena VARCHAR2(50) NOT NULL,
    telefono VARCHAR2(10),
    direccion VARCHAR2(100) NOT NULL,
    fechaRegistro DATE NOT NULL,
    experienciaAnos INTEGER NOT NULL,
    tipoContrato VARCHAR2(10) NOT NULL
);

CREATE TABLE ESTUDIANTES (
    idUsuario VARCHAR2(25) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    correo VARCHAR2(50),
    contrasena VARCHAR2(50) NOT NULL,
    telefono VARCHAR2(10),
    direccion VARCHAR2(100) NOT NULL,
    fechaRegistro DATE NOT NULL,
    fechaIngreso DATE NOT NULL,
    documentoIdentidad CHAR(12) NOT NULL,
    estadoAcademico VARCHAR2(3) NOT NULL
);

CREATE TABLE MATERIASPORESTUDIANTE (
    idEstudiante VARCHAR2(25) NOT NULL,
    idMateria VARCHAR2(25) NOT NULL
);

CREATE TABLE DEPARTAMENTOS (
    idDepartamento VARCHAR2(25) NOT NULL,
    nombre VARCHAR2(35),
    idDirector VARCHAR2(25) NOT NULL
);

CREATE TABLE GRUPOS (
    idGrupo VARCHAR2(25) NOT NULL,
    numero INTEGER,
    cupoMaximo INTEGER NOT NULL,
    horario VARCHAR2(20) NOT NULL,
    idMateria VARCHAR2(25) NOT NULL,
    idProfesor VARCHAR2(25) NOT NULL
);

CREATE TABLE PREINSCRIPCIONES (
    idPreinscripcion VARCHAR2(25) NOT NULL,
    fecha DATE NOT NULL,
    estado VARCHAR2(10) NOT NULL,
    idEstudiante VARCHAR2(25) NOT NULL,
    idMateria VARCHAR2(25) NOT NULL
);

CREATE TABLE AREAS (
    idArea VARCHAR2(25) NOT NULL,
    nombre VARCHAR2(35),
    idDepartamento VARCHAR2(25) NOT NULL,
    idDirector VARCHAR2(25) NOT NULL
);

CREATE TABLE MATERIAS (
    idMateria VARCHAR2(25) NOT NULL,
    nombre VARCHAR2(100),
    creditos INTEGER NOT NULL,
    horasTeoricas INTEGER NOT NULL,
    horasPracticas INTEGER NOT NULL,
    nivel INTEGER NOT NULL,
    modalidad VARCHAR2(10) NOT NULL,
    idArea VARCHAR2(25),
    idCentroDeEstudios VARCHAR2(25),
    idNucleoDeFormacion VARCHAR2(25) NOT NULL
);

CREATE TABLE NOTAS (
    idNota VARCHAR2(25) NOT NULL,
    valor NUMBER(3,1) NOT NULL,
    fechaRegistro DATE NOT NULL,
    tipoDeEvaluacion VARCHAR2(15) NOT NULL,
    idMateria VARCHAR2(25) NOT NULL,
    idEstudiante VARCHAR2(25) NOT NULL
);

CREATE TABLE PREREQUISITOSMATERIAS (
    idMateria VARCHAR2(25) NOT NULL,
    idMateriaRequisito VARCHAR2(25) NOT NULL
);

CREATE TABLE CENTROSDEESTUDIOS (
    idCentroEstudios VARCHAR2(25) NOT NULL,
    nombre VARCHAR2(50),
    idDirector VARCHAR2(25) NOT NULL,
    idProgramaAcademico VARCHAR2(25) NOT NULL
);

CREATE TABLE NUCLEOSDEFORMACION (
    idNucleoFormacion VARCHAR2(25) NOT NULL,
    nombre VARCHAR2(35)
);


CREATE TABLE PROGRAMASACADEMICOS (
    idPrograma VARCHAR2(25) NOT NULL,
    nombre VARCHAR2(50),
    duracionSemestres INTEGER NOT NULL
);

CREATE TABLE PROGRAMASPORESTUDIANTES (
    idPrograma VARCHAR2(25) NOT NULL,
    idEstudiante VARCHAR2(25) NOT NULL
);

CREATE TABLE TITULOS (
    titulo VARCHAR2(60) NOT NULL,
    idProfesor VARCHAR2(25) NOT NULL
);

-- CICLO 2

CREATE TABLE NOTIFICACIONES (
    idNotificacion VARCHAR2(25) NOT NULL,
    mensaje VARCHAR2(100) NOT NULL,
    fecha DATE NOT NULL,
    estado VARCHAR2(10) NOT NULL
);

CREATE TABLE CANCELACIONES (
    idCancelacion VARCHAR2(25) NOT NULL,
    fecha DATE NOT NULL,
    motivo VARCHAR2(100),
    estado VARCHAR2(10) NOT NULL,
    asesoria CHAR(1) NOT NULL,
    idMateria VARCHAR2(25) NOT NULL,
    idNotificacion VARCHAR2(25) NOT NULL,
    idEstudiante VARCHAR2(25) NOT NULL
);