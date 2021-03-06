﻿BEGIN TRANSACTION;

--
-- Roles dentro del sistema
--
DROP TABLE IF EXISTS roles CASCADE;
CREATE TABLE roles (
    pk serial NOT NULL,
    rol varchar(255) NOT NULL, -- nombre del rol
    descripcion text, -- descripción del rol
    UNIQUE (rol),
    PRIMARY KEY(pk)
);

--
-- Usuarios que se loguearán en el sistema
-- 
DROP TABLE IF EXISTS usuarios CASCADE;
CREATE TABLE usuarios (
    id serial NOT NULL,
    username int NOT NULL, --rut
    password varchar(40) NOT NULL, -- SHA1
    salt varchar(32) NOT NULL,
    roles int NOT NULL DEFAULT '0', -- Mapa de Bits con los roles del sistema
    UNIQUE (username),
    PRIMARY KEY(id)
);

--
-- Registro de los últimos accesos junto con sus IPs
--
DROP TABLE IF EXISTS accesos CASCADE;
CREATE TABLE accesos (
    pk bigserial NOT NULL,
    rut int NOT NULL,
    fecha timestamptz NOT NULL DEFAULT NOW(),
    ip varchar(255) DEFAULT '127.0.0.1',
    PRIMARY KEY (pk)
);

-- 
-- Tabla de regiones, almacena las regiones de nuestro país (Chile).
-- 
DROP TABLE IF EXISTS regiones CASCADE;
CREATE TABLE regiones (
        pk serial NOT NULL,
        nombre varchar(255) NOT NULL,
        zona_corfo varchar(255) NOT NULL,
        codigo varchar(5) NOT NULL,
        numero smallint NOT NULL,
        UNIQUE(nombre),
        UNIQUE(codigo),
        UNIQUE(numero),
        PRIMARY KEY(pk)
);


--
-- Tabla de provincias
--
DROP TABLE IF EXISTS provincias CASCADE;
CREATE TABLE provincias (
    pk serial NOT NULL,
    region_fk int NOT NULL REFERENCES regiones(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    nombre varchar(255) NOT NULL,
    UNIQUE (region_fk, nombre),
    PRIMARY KEY (pk)
);


-- 
-- Comunas
--
DROP TABLE IF EXISTS comunas CASCADE;
CREATE TABLE comunas (
    pk serial NOT NULL,
    provincia_fk int NOT NULL REFERENCES provincias(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    nombre varchar(255) NOT NULL,
    UNIQUE (provincia_fk, nombre),
    PRIMARY KEY (pk)
);

--
-- Estados Civiles
-- 
DROP TABLE IF EXISTS estados_civiles CASCADE;
CREATE TABLE estados_civiles (
    pk serial NOT NULL,
    estado varchar(255),
    descripcion text,
    UNIQUE (estado),
    PRIMARY KEY (pk)
);

--
-- Estados en que se encuentra un estudiante
--
DROP TABLE IF EXISTS estados CASCADE;
CREATE TABLE estados (
    pk serial NOT NULL,
    nombre varchar(255) NOT NULL,
    descripcion text,
    PRIMARY KEY(pk)
);

--
-- Tabla almacena carrera de la Universidad
--
DROP TABLE IF EXISTS carreras CASCADE;
CREATE TABLE carreras (
    pk serial NOT NULL,
    cod_carrera int NOT NULL,
    nombre_carrera varchar(255) NOT NULL,
    UNIQUE(cod_carrera),
    UNIQUE(nombre_carrera),
    PRIMARY KEY(pk)
);
   

--
-- Estudiante
-- 
DROP TABLE IF EXISTS estudiantes CASCADE;
CREATE TABLE estudiantes (
    pk serial NOT NULL,
    nombres varchar(255) NOT NULL,
    apellidos varchar(255) NOT NULL,
    rut int NOT NULL,
    fecha_nacimiento date NOT NULL,
    genero char(1) NOT NULL DEFAULT 'F', -- M: Masculino -- F: Femenino
    direccion varchar(255) NOT NULL,
    comuna_id int NOT NULL REFERENCES comunas(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    ec_fk int NOT NULL REFERENCES estados_civiles(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    carrera_fk int NOT NULL REFERENCES carreras(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    telefono varchar(50),
    celular varchar(50),
    email varchar(255),
    estado int NOT NULL REFERENCES estados(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    busqueda boolean NOT NULL DEFAULT FALSE, -- Si se encuentra o no buscando trabajo (solicitado por docentes y adm)
    archivo_curriculum varchar(255), -- ubicación del curriculum (dirección archivo) (solicitado por adm actual)
    UNIQUE (rut),
    UNIQUE(email),
    UNIQUE(archivo_curriculum),
    PRIMARY KEY (pk)
);


-- 
-- Tabla almacena las facultades de la Universidad.
-- 
DROP TABLE IF EXISTS facultades CASCADE;
CREATE TABLE facultades (
        pk serial NOT NULL,
        facultad varchar(255) NOT NULL,
        descripcion text,
        UNIQUE(facultad),
        PRIMARY KEY(pk)
);

-- 
-- Tabla almacena los departamentos de las Facultades
-- 
DROP TABLE IF EXISTS departamentos CASCADE;
CREATE TABLE departamentos (
        pk serial NOT NULL,
        facultad_fk int NOT NULL REFERENCES facultades(pk) ON UPDATE CASCADE ON DELETE CASCADE,
        departamento varchar(255) NOT NULL,
        descripcion text,
        UNIQUE(departamento),
        PRIMARY KEY(pk)
);

-- 
-- Esta tabla almacena las escuelas de los departamentos.
-- 
DROP TABLE IF EXISTS escuelas CASCADE;
CREATE TABLE escuelas (
        escuela_id serial NOT NULL,
        departamento_fk int NOT NULL REFERENCES departamentos(pk) ON UPDATE CASCADE ON DELETE CASCADE,
        escuela varchar(255) NOT NULL,
        descripcion text,
        UNIQUE(escuela),
        PRIMARY KEY(escuela_id)
);


-- 
-- Docente
--
DROP TABLE IF EXISTS docentes CASCADE;
CREATE TABLE docentes (
    pk serial NOT NULL,
    nombres varchar(255) NOT NULL,
    apellidos varchar(255) NOT NULL,
    rut int NOT NULL,
    fecha_nacimiento date NOT NULL,
    genero char(1) NOT NULL DEFAULT 'F', -- M: Masculino -- F: Femenino
    direccion varchar(255) NOT NULL,
    comuna_id int NOT NULL REFERENCES comunas(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    ec_fk int NOT NULL REFERENCES estados_civiles(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    departamento_fk int NOT NULL REFERENCES departamentos(pk) ON UPDATE CASCADE ON DELETE CASCADE,
  --usuario_fk int NOT NULL REFERENCES usuarios(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    telefono varchar(50),
    celular varchar(50),
    email varchar(255),
    UNIQUE (rut),
    UNIQUE(email),
    PRIMARY KEY (pk)
);


-- 
--  Tabla que almacenará los docentes que cumplen un cago administrativo en la universidad.
--

DROP TABLE IF EXISTS cargos_adm CASCADE;
CREATE TABLE cargos_adm (
    pk serial NOT NULL,
    nombre_cargo varchar(255) NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    docente_fk bigint NOT NULL REFERENCES docentes(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    descripcion text,
    UNIQUE(nombre_cargo),
    PRIMARY KEY (pk)
);

--
-- Tabla que almacena las empresas que ofreceran ofertas
--
DROP TABLE IF EXISTS empresas CASCADE;
CREATE TABLE empresas (
    pk serial NOT NULL,
    rut int NOT NULL,
    nombre varchar(255) NOT NULL,
    nombre_represen_legal VARCHAR(255),
    direccion varchar(255) NOT NULL,
    comuna_fk int NOT NULL REFERENCES comunas(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    codigo_postal int NOT NULL,
    telefono varchar(50) NOT NULL,  
    email varchar(255), 
    actividad varchar(255) NOT NULL,  
    descripcion_negocio varchar(255) NOT NULL,
    web varchar(255) NOT NULL DEFAULT '',
    PRIMARY KEY(pk)
);

--
-- Encargado de las ofertas Laborales por las empresas
-- 
DROP TABLE IF EXISTS encargados_empresas CASCADE;
CREATE TABLE encargados_empresas (
    pk bigserial NOT NULL,
    empresa_fk int NOT NULL REFERENCES empresas(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    nombre varchar(255) NOT NULL,
    apellidos varchar(255) NOT NULL,
    genero char(1) NOT NULL DEFAULT 'F', -- M: Masculino -- F: Femenino
    email varchar(255) NOT NULL,
    telefono varchar(50) NOT NULL,
    UNIQUE (empresa_fk, email),
    PRIMARY KEY (pk)
);

--
-- Tabla que almacena las jornadas de trabajo
--
DROP TABLE IF EXISTS jornadas CASCADE;
CREATE TABLE jornadas (
    pk serial NOT NULL,
    jornada varchar(255) NOT NULL,
    descripcion text,
    UNIQUE(jornada),
    PRIMARY KEY(pk)
);

--
-- Tabla que almacena los tipo_contratos de trabajo
--
DROP TABLE IF EXISTS tipos_contratos CASCADE;
CREATE TABLE tipos_contratos (
    pk serial NOT NULL,
    contrato varchar(255) NOT NULL,
    descripcion text,
    UNIQUE (contrato),
    PRIMARY KEY(pk)
);


--
-- Rubros
-- industria -- informatica -- gestion -- etc
--
DROP TABLE IF EXISTS rubros CASCADE;
CREATE TABLE rubros (
    pk serial NOT NULL,
    rubro varchar(255) NOT NULL,
    descripcion text,
    UNIQUE (rubro),
    PRIMARY KEY (pk)
);


DROP TABLE IF EXISTS niveles_estudios CASCADE;
CREATE TABLE niveles_estudios (
    pk serial NOT NULL,
    estudios varchar(255) NOT NULL,
    descripcion text,
    UNIQUE(estudios),
    PRIMARY KEY (pk)
);

--
-- oferta laboral de la empresa, ésta la verán las empresas para saber a quien contratar o qué perfil corresponde
-- para el trabajo ofrecido
DROP TABLE IF EXISTS ofertas_laborales CASCADE;
CREATE TABLE ofertas_laborales (
    pk serial NOT NULL,
    empresa_fk int NOT NULL REFERENCES empresas(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    rubro_fk int NOT NULL REFERENCES rubros(pk) ON UPDATE CASCADE ON DELETE CASCADE, 
    nivel_estudio_fk int NOT NULL REFERENCES niveles_estudios(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    renta numeric NOT NULL,
    vacantes smallint NOT NULL,
    plazo date,
    descripcion VARCHAR(255) NOT NULL,
    ubicacion VARCHAR(255) NOT NULL DEFAULT '', 
    cargo VARCHAR(255) NOT NULL,
    fecha_publicacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    beneficios VARCHAR(255) NOT NULL DEFAULT '', 
    nivel_estudios VARCHAR(255) NOT NULL, 
    jornada_fk int NOT NULL REFERENCES jornadas(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    contrato_fk int NOT NULL REFERENCES tipos_contratos(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    activo smallint NOT NULL DEFAULT '1', -- 0: Inactivo / 1: Activo
    PRIMARY KEY (pk)
);

--
-- Sugerencia trabajo, algunos academicos pidieron que se pudiera sugerir trabajos a alumnos que estuvieran siguiendo
-- 

DROP TABLE IF EXISTS sugerencias_trabajo CASCADE;
CREATE TABLE sugerencias_trabajo (
        pk bigserial NOT NULL,
        estudiante_fk int NOT NULL REFERENCES estudiantes(pk) ON UPDATE CASCADE ON DELETE CASCADE,
        oferta_laboral_fk int NOT NULL REFERENCES ofertas_laborales(pk) ON UPDATE CASCADE ON DELETE CASCADE,
        docente_fk int NOT NULL REFERENCES docentes(pk) ON UPDATE CASCADE ON DELETE CASCADE,
        fecha_sugerencia timestamptz NOT NULL DEFAULT NOW(),
        fecha_fin date NOT NULL,
        PRIMARY KEY (pk)
);



--
-- Tabla ofertas - alumnos 
--
DROP TABLE IF EXISTS postulaciones CASCADE;
CREATE TABLE postulaciones (
    pk bigserial NOT NULL,
    oferta_laboral_fk int NOT NULL REFERENCES ofertas_laborales(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    estudiante_fk int NOT NULL REFERENCES estudiantes(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    fecha timestamptz NOT NULL DEFAULT NOW(),
    UNIQUE (oferta_laboral_fk, estudiante_fk),
    PRIMARY KEY (pk)
);

--
-- Tabla que almacena los conocimientos de los postulantes
--
DROP TABLE IF EXISTS conocimientos  CASCADE;
CREATE TABLE conocimientos(
    pk bigserial NOT NULL, 
    conocimiento varchar(255) NOT NULL,
    descripcion text,
    UNIQUE (conocimiento),
    PRIMARY KEY(pk)
);

--
-- Tabla que almacena la experiencia laboral  
--
DROP TABLE IF EXISTS experiencias CASCADE;
CREATE TABLE experiencias (
    pk bigserial NOT NULL, 
    descripcion varchar(255) NOT NULL,
    referencia varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    inicio date NOT NULL,
    fin date,
    PRIMARY KEY(pk)
);

--
-- Tabla de curriculums
--

DROP TABLE IF EXISTS curriculums CASCADE;
CREATE TABLE curriculums (
    pk int NOT NULL, -- hay que definir que debe llevar el curriculum
    estudiante_fk bigint NOT NULL REFERENCES estudiantes(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY(pk)
);

--
-- Tabla de practicas
--

DROP TABLE IF EXISTS practicas CASCADE;
CREATE TABLE practicas (
    pk serial NOT NULL,
    empresa_fk int NOT NULL REFERENCES empresas(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    area_practica varchar(255),
    inicio_practica date NOT NULL,
    fin_practica date NOT NULL,
    remuneracion int,
    PRIMARY KEY(pk)
);

COMMIT;
