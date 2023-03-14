-- CREACION DE CATALOGOS

-- 01 CATALOGO DE MUNICIPIOS
create table if not exists municipios(
	id_municipio serial primary key,
	municipio varchar(25) not null
);

insert into municipios(municipio)
select
	distinct municipio 
from denue_inegi_09_ di 
order by municipio;
-----------------------------------------------

-- 02 CATALOGO DE ACTIVIDADES
create table if not exists actividades(
	id_actividad integer not null primary key,
	nombre_actividad varchar(250) not null
);

insert into actividades(id_actividad, nombre_actividad)
select distinct cast(codigo_actividad as integer), nombre_actividad 
from denue_inegi_09_ di 
order by codigo_actividad;
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
	telefono varchar(20) not null,
	correo_electronico varchar(80) not null,
	pagina_web varchar(100) not null
);

insert into datos_de_contacto(id_clee, telefono, correo_electronico, pagina_web)
select 
	clee,
	telefono,
	correo_electronico,
	pagina_web 
from denue_inegi_09_ di 
where
	telefono is not null and correo_electronico is not null and pagina_web is not null
order by clee
-----------------------------------------------


-- Seleccionar atributos de tabla con solo id de los catálogos

select
id                     ,
geom                   ,
clee                   ,
nombre_establecimiento ,
razon_social           ,
codigo_actividad       ,
nombre_actividad       ,
personas_ocupadas      ,
tipo_vialidad          ,
nombre_vialidad        ,
tipo_v_e_1             ,
nom_v_e_1              ,
tipo_v_e_2             ,
nom_v_e_2              ,
tipo_v_e_3             ,
nom_v_e_3              ,
numero_exterior        ,
letra_exterior         ,
edificio               ,
edificio_exterior      ,
numero_interior        ,
letra_interior         ,
tipo_asentamiento      ,
nombre_asentamiento    ,
tipo_centro_comercial  ,
nombre_centro_comercial,
num_local              ,
codigo_postal          ,
clave_entidad          ,
entidad                ,
clave_municipio        ,
t2.id_municipio,
clave_localidad        ,
localidad              ,
ageb                   ,
manzana                ,
telefono               ,
correo_electronico     ,
pagina_web             ,
tipounieco             ,
latitud                ,
longitud               ,
fecha_alta
from denue_inegi_09_ di
join municipios t2 on di.municipio = t2.municipio;

--
select 
 clee, 
 cast(replace(telefono, ' ', '') as numeric), 
 correo_electronico, 
 pagina_web 
from denue_inegi_09_ di 
where
telefono is not null and correo_electronico is not null and pagina_web is not null


drop table datos_de_contacto 
