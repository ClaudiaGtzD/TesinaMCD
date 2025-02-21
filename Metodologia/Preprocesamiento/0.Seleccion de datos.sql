/****************************
** Condiciones ambientales **
****************************/

/** Select principal ordenado por dia y hora**/
select h.dtHora, h.iNumHora, ca.* from CondicionesAmbientalesPdn ca
inner join Horas h
	on h.iCodHora = ca.iCodHora
where isnull(bReal, 0) = 0
and isnull(bEliminado, 0) = 0
and iCodCondAmbMunicipalHora = (select max(iCodCondAmbMunicipalHora)
	from CondicionesAmbientalesPdn vig
	where vig.iCodCiudad = ca.iCodCiudad
	and vig.iCodHora = ca.iCodHora
	and isnull(vig.bEliminado, 0) = 0
	and isnull(vig.bReal, 0) = 0)
order by ca.iCodDia, ca.iCodHora

/** Evaluación de nulos **/
select datos = count(1),
dtHora = sum(case when h.dtHora is not null then 1 else 0 end),
iNumHora = sum(case when h.iNumHora is not null then 1 else 0 end),
dtDia = sum(case when dtDia is not null then 1 else 0 end),
iCodCondAmbMunicipalHora = sum(case when iCodCondAmbMunicipalHora is not null then 1 else 0 end),
iCodCondAmbMunicipalDia	= sum(case when iCodCondAmbMunicipalDia is not null then 1 else 0 end),
iCodCiudad = sum(case when iCodCiudad is not null then 1 else 0 end),
iCodDia = sum(case when ca.iCodDia is not null then 1 else 0 end),
iCodHora = sum(case when ca.iCodHora is not null then 1 else 0 end),
iCodPeriodoAmbiental = sum(case when iCodPeriodoAmbiental is not null then 1 else 0 end),
iNumHora = sum(case when ca.iNumHora is not null then 1 else 0 end),
fltTemp = sum(case when fltTemp is not null then 1 else 0 end),
fltPresionAtmosferica = sum(case when fltPresionAtmosferica is not null then 1 else 0 end),
fltProbabilidadLluvia = sum(case when fltProbabilidadLluvia is not null then 1 else 0 end),
fltHumedadRelativa = sum(case when fltHumedadRelativa is not null then 1 else 0 end),
fltVelocidadViento = sum(case when fltVelocidadViento is not null then 1 else 0 end),
fltDireccionViento = sum(case when fltDireccionViento is not null then 1 else 0 end),
vchDireccionViento = sum(case when vchDireccionViento is not null then 1 else 0 end),
fltCoberturaNubes = sum(case when fltCoberturaNubes is not null then 1 else 0 end),
fltIndiceUV = sum(case when (fltIndiceUV is not null or (fltIndiceUV is null and ca.iNumHora in (19, 20, 21, 22, 23, 24, 1, 2, 3, 4, 5, 6, 7, 8))) then 1 else 0 end),
iCodCondCielo = sum(case when iCodCondCielo is not null then 1 else 0 end),
iCodDirViento = sum(case when iCodDirViento is not null then 1 else 0 end),
fltVelocidadRafaga = sum(case when fltVelocidadRafaga is not null then 1 else 0 end),
fltPrecipitacion = sum(case when fltPrecipitacion is not null then 1 else 0 end),
fltDPT = sum(case when fltDPT is not null then 1 else 0 end),
dtAplicacion = sum(case when dtAplicacion is not null then 1 else 0 end),
dtVigencia = sum(case when dtVigencia is not null then 1 else 0 end),
iCodUsuario = sum(case when iCodUsuario is not null then 1 else 0 end),
bEliminado = sum(case when bEliminado is not null then 1 else 0 end),
vchMensaje = sum(case when vchMensaje is not null then 1 else 0 end),
bReal = sum(case when bReal is not null then 1 else 0 end),
vchDescripcion = sum(case when vchDescripcion is not null then 1 else 0 end)
from CondicionesAmbientalesPdn ca
inner join Horas h
	on h.iCodHora = ca.iCodHora
where isnull(bReal, 0) = 0
and isnull(bEliminado, 0) = 0
and ca.iCodDia >= 6017
and iCodCondAmbMunicipalHora = (select max(iCodCondAmbMunicipalHora)
	from CondicionesAmbientalesPdn vig
	where vig.iCodCiudad = ca.iCodCiudad
	and vig.iCodHora = ca.iCodHora
	and isnull(vig.bEliminado, 0) = 0
	and isnull(vig.bReal, 0) = 0)

/** Selección final con variables no tan nulas **/
select h.dtHora, h.iNumHora,
ca.iCodDia,
ca.iCodHora,
ca.fltTemp,
ca.fltProbabilidadLluvia,
ca.fltHumedadRelativa,
ca.fltVelocidadViento,
ca.fltDireccionViento,
ca.fltCoberturaNubes,
fltIndiceUV = case when (ca.fltIndiceUV is null and ca.iNumHora in (19, 20, 21, 22, 23, 24, 1, 2, 3, 4, 5, 6, 7, 8)) then 0 else ca.fltIndiceUV end,
ca.iCodCondCielo,
ca.iCodDirViento,
ca.fltVelocidadRafaga,
ca.fltPrecipitacion,
ca.fltDPT
from CondicionesAmbientalesPdn ca
inner join Horas h
	on h.iCodHora = ca.iCodHora
where isnull(bReal, 0) = 0
and isnull(bEliminado, 0) = 0
and ca.iCodDia >= 6017
and iCodCondAmbMunicipalHora = (select max(iCodCondAmbMunicipalHora)
	from CondicionesAmbientalesPdn vig
	where vig.iCodCiudad = ca.iCodCiudad
	and vig.iCodHora = ca.iCodHora
	and isnull(vig.bEliminado, 0) = 0
	and isnull(vig.bReal, 0) = 0)
order by ca.iCodDia, ca.iCodHora

/**************************
** Generacion de energía **
**************************/
select dp.*
from DetPronosticos dp
where iCodDetPronostico = (select max(iCodDetPronostico)
	from DetPronosticos vig
	where vig.dtFecha = dp.dtFecha
	and vig.iHora = dp.iHora)
order by dp.dtFecha, iHora

/** Consideración de nulos **/
select count(1), sum(case when fltValPronostico is not null then 1 else 0 end)
from DetPronosticos dp
where iCodDetPronostico = (select max(iCodDetPronostico)
	from DetPronosticos vig
	where vig.dtFecha = dp.dtFecha
	and vig.iHora = dp.iHora)
and dtFecha >= '2021-06-22 00:00:00.000'

select d.iCodDia,
dp.dtFecha, dp.iHora,
dp.fltValPronostico
from DetPronosticos dp
inner join Dias d
	on d.dtDia = dp.dtFecha
where iCodDetPronostico = (select max(iCodDetPronostico)
	from DetPronosticos vig
	where vig.dtFecha = dp.dtFecha
	and vig.iHora = dp.iHora)
and dtFecha >= '2021-06-22 00:00:00.000'
order by dp.dtFecha, iHora

select * from horas where iCodDia >= 6017 and iCodDia <= 7215 and iCodZonaHoraria = 1
