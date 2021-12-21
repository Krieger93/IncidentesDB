CREATE DATABASE IncidentesDB;

USE IncidentesDB;

CREATE TABLE Usuarios(
id_user INT PRIMARY KEY NOT NULL,
user VARCHAR(50) NOT NULL,
pass_user VARCHAR(25) NOT NULL,
mail_user VARCHAR(50) NOT NULL,
nivel_user INT NOT NULL,
id_grupo INT NOT NULL,
FOREIGN KEY (id_grupo) REFERENCES Grupos(id_grupo)
);

CREATE TABLE Categorias(
id_categoria INT PRIMARY KEY NOT NULL,
titulo_categoria VARCHAR(50) NOT NULL
);

CREATE TABLE Grupos(
id_grupo INT PRIMARY KEY NOT NULL,
nombre_grupo VARCHAR(30) NOT NULL,
descripcion_grupo VARCHAR(50) NOT NULL
);

CREATE TABLE KPIS(
id_kpi INT PRIMARY KEY NOT NULL,
id_incidente INT NOT NULL,
tiempo_resolucion DATE NOT NULL,
primera_respuesta DATE NOT NULL,
puntaje_usuario INT NOT NULL,
FOREIGN KEY (id_incidente) REFERENCES Incidentes(id_incidente)
);

CREATE TABLE Incidentes(
id_incidente INT PRIMARY KEY NOT NULL,
titulo_incidente VARCHAR(50) NOT NULL,
descripcion VARCHAR(50) NOT NULL,
id_owner INT NOT NULL,
id_asignatario INT NOT NULL,
id_kpi INT NOT NULL,
fecha_creacion DATE NOT NULL,
fecha_cierre DATE NOT NULL
);

ALTER TABLE Incidentes
ADD FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria),
ADD FOREIGN KEY (id_kpi) REFERENCES KPIS(id_kpi),
ADD FOREIGN KEY (id_owner) REFERENCES Usuarios(id_user),
ADD FOREIGN KEY (id_asignatario) REFERENCES Usuarios(id_user);


