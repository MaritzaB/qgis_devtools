-- RENOMBRA COLUMNAS

alter table denue_inegi_09_  rename column nom_estab to nombre_establecimiento;
alter table denue_inegi_09_  rename column raz_social to razon_social;
alter table denue_inegi_09_  rename column codigo_act to codigo_actividad;
alter table denue_inegi_09_  rename column nombre_act to nombre_actividad;
alter table denue_inegi_09_  rename column per_ocu to personas_ocupadas;
alter table denue_inegi_09_  rename column tipo_vial to tipo_vialidad;
alter table denue_inegi_09_  rename column numero_ext to numero_exterior;
alter table denue_inegi_09_  rename column letra_ext to letra_exterior;
alter table denue_inegi_09_  rename column numero_int to numero_interior;
alter table denue_inegi_09_  rename column letra_int to letra_interior;
alter table denue_inegi_09_  rename column tipo_asent to tipo_asentamiento;
alter table denue_inegi_09_  rename column nomb_asent to nombre_asentamiento;
alter table denue_inegi_09_  rename column tipocencom to tipo_centro_comercial;
alter table denue_inegi_09_  rename column nom_cencom to nombre_centro_comercial;
alter table denue_inegi_09_  rename column num_local to numero_local;
alter table denue_inegi_09_  rename column cod_postal to codigo_postal;
alter table denue_inegi_09_  rename column cve_ent to clave_entidad;
alter table denue_inegi_09_  rename column cve_mun to clave_municipio;
alter table denue_inegi_09_  rename column cve_loc to clave_localidad;
alter table denue_inegi_09_  rename column correoelec to correo_electronico;
alter table denue_inegi_09_  rename column www to pagina_web;
alter table denue_inegi_09_  rename column tipounieco to tipo_unidad_economica;


-- CREACION DE CATALOGOS

-- 01 CATALOGO DE MUNICIPIOS
create table if not exists municipios(
	id_municipio integer not null primary key,
	municipio varchar(25) not null
);

insert into municipios(id_municipio, municipio)
select
	distinct cast(clave_municipio as integer), 
	 municipio 
from denue_inegi_09_ di 
order by clave_municipio;

-- UPDATE TABLE
alter table denue_inegi_09_ rename column clave_municipio to id_municipio;
alter table denue_inegi_09_ drop column municipio;

-- Sustituye el valor con los datos de la nueva tabla
update denue_inegi_09_ di  
	set id_municipio = m.id_municipio
	from municipios m
	where di.id_municipio = m.municipio;
	
-- Cambia el tipo de datos de esa columna
alter table denue_inegi_09_ alter column id_municipio type int using id_municipio::int;

-----------------------------------------------

-- 02 CATALOGO DE ACTIVIDADES
create table if not exists actividades(
	id_actividad integer not null primary key,
	nombre_actividad varchar(250) not null
);

insert into actividades(id_actividad, nombre_actividad)
select 
	distinct 
		cast(codigo_actividad as integer),
		nombre_actividad 
from denue_inegi_09_ di 
order by codigo_actividad;

-- UPDATE TABLE
alter table denue_inegi_09_ rename column codigo_actividad to id_actividad;
alter table denue_inegi_09_ drop column nombre_actividad;


-- Sustituye el valor con los datos de la nueva tabla
update denue_inegi_09_ di 
	set id_actividad = a.id_actividad 
	from actividades a
	where cast(di.id_actividad as integer) = a.id_actividad;
	
-- Cambia el tipo de datos de esa columna
alter table denue_inegi_09_ alter column id_actividad type int using id_actividad::int;


-----------------------------------------------

-- 03 CATÁLOGO DE VIALIDADES
create table if not exists tipos_vialidades(
	id_vialidad serial primary key,
	tipo_vialidad varchar(25) not null
);

insert into tipos_vialidades(tipo_vialidad)
select
	distinct tipo_vialidad 
from denue_inegi_09_ di
where tipo_vialidad is not null 
order by tipo_vialidad;

-- Sustituye el valor con los datos de la nueva tabla
update denue_inegi_09_ di 
	set tipo_vialidad  = v.id_vialidad 
	from tipos_vialidades v
	where v.tipo_vialidad  = di.tipo_vialidad ;
	
-- Cambia el tipo de datos de esa columna
alter table denue_inegi_09_ alter column tipo_vialidad type int using tipo_vialidad::int;

-----------------------------------------------

-- 04 TIPOS DE ASENTAMIENTOS
create table if not exists tipos_asentamientos(
	id_asentamiento serial primary key,
	tipo_asentamiento varchar(25) not null
);

insert into tipos_asentamientos(tipo_asentamiento)
select
	distinct tipo_asentamiento 
from denue_inegi_09_ di
where tipo_asentamiento  is not null 
order by tipo_asentamiento;
-----------------------------------------------

-- 05 TIPOS DE CENTROS COMERCIALES
create table if not exists tipos_centros_comerciales(
	id_centros_comerciales serial primary key,
	tipo_centro_comercial varchar(50) not null
);

insert into tipos_centros_comerciales(tipo_centro_comercial)
select
	distinct tipo_centro_comercial 
from denue_inegi_09_ di
where tipo_centro_comercial is not null 
order by tipo_centro_comercial ;
-----------------------------------------------

-- 06 DATOS DE CONTACTO DE ESTABLECIMIENTO
create table if not exists datos_de_contacto(
	id_clee varchar(50) not null primary key,
	telefono varchar(20),
	correo_electronico varchar(80),
	pagina_web varchar(100)
);

insert into datos_de_contacto(id_clee, telefono, correo_electronico, pagina_web)
select 
	clee,
	telefono,
	correo_electronico,
	pagina_web 
from denue_inegi_09_ di 
where
	telefono is not null or correo_electronico is not null or pagina_web is not null
order by clee
-----------------------------------------------



select distinct clave_municipio , municipio
from denue_inegi_09_ di 

drop table municipios 

select 
	distinct 
		cast(codigo_actividad as integer),
		nombre_actividad 
from denue_inegi_09_ di 
order by codigo_actividad;

select count(distinct nombre_actividad) from denue_inegi_09_ di 
