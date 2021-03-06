USE [master]
GO
/****** Object:  Database [farmacia]    Script Date: 16/11/2015 13:13:00 ******/
CREATE DATABASE [farmacia]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'farmacia', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\farmacia.mdf' , SIZE = 6144KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'farmacia_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\farmacia_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [farmacia] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [farmacia].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [farmacia] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [farmacia] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [farmacia] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [farmacia] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [farmacia] SET ARITHABORT OFF 
GO
ALTER DATABASE [farmacia] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [farmacia] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [farmacia] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [farmacia] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [farmacia] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [farmacia] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [farmacia] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [farmacia] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [farmacia] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [farmacia] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [farmacia] SET  DISABLE_BROKER 
GO
ALTER DATABASE [farmacia] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [farmacia] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [farmacia] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [farmacia] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [farmacia] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [farmacia] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [farmacia] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [farmacia] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [farmacia] SET  MULTI_USER 
GO
ALTER DATABASE [farmacia] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [farmacia] SET DB_CHAINING OFF 
GO
ALTER DATABASE [farmacia] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [farmacia] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[bit_InsertarBitacora]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bit_InsertarBitacora]
	@usuario_fk as int,
    @descripcion as nvarchar(255),
	@fecha_hora as datetime,
	@criticidad  as nvarchar(50)
AS
BEGIN

INSERT INTO [dbo].[Bitacora]
(
  [usuario_fk]
 ,[descripcion]
 ,[fecha_hora]
 ,[criticidad]
 )
Values (
@usuario_fk,
@descripcion,
@fecha_hora,
@criticidad
)

END

GO
/****** Object:  StoredProcedure [dbo].[bit_ListarBitacoraPorID]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[bit_ListarBitacoraPorID]
@bitacora_id as int
AS
begin
SELECT 
	   [bitacora_id]
	  ,[usuario_fk]
      ,[descripcion]
      ,[fecha_hora]
      ,[criticidad]
FROM [farmacia].[dbo].[Bitacora] 
WHERE [bitacora_id] =  @bitacora_id  
end
GO
/****** Object:  StoredProcedure [dbo].[bit_ListarBitacoraPorParametros]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[bit_ListarBitacoraPorParametros]
@usuario_id as int,
@fecha_desde as datetime,
@fecha_hasta as datetime,
@criticidad as nvarchar(50)
AS
begin
SELECT 
 B.bitacora_id,
 B.usuario_fk,
 U.nombre_usuario,
 B.descripcion,
 B.fecha_hora,
 B.criticidad
FROM [farmacia].[dbo].[Bitacora] AS B
INNER JOIN Usuario AS U ON B.usuario_fk = U.usuario_id
WHERE (B.usuario_fk =  @usuario_id or  @usuario_id = 0)
and  (B.fecha_hora >= @fecha_desde and fecha_hora <= @fecha_hasta)
and (B.criticidad = @criticidad or @criticidad = 'Todos los niveles')
end
GO
/****** Object:  StoredProcedure [dbo].[cli_EliminarCliente]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cli_EliminarCliente]
	@cliente_id as int,
	@eliminado as bit
AS
begin
UPDATE [dbo].Cliente
   SET eliminado = @eliminado
 WHERE 
		cliente_id = @cliente_id

end 
GO
/****** Object:  StoredProcedure [dbo].[cli_InsertarCliente]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cli_InsertarCliente]
	@dni as integer,
	@apellido as nvarchar(80),
	@nombre as nvarchar(80),
	@nombreCompleto as nvarchar(160),
	@email as nvarchar(100),
	@telefono as nvarchar(50),
	@fecha_alta as datetime,
    @direccion as nvarchar(255),
    @localidad_fk as integer,
    @provincia_fk as integer
AS
begin

INSERT INTO [dbo].[Cliente]
           ([direccion]
           ,[nombre]
           ,[apellido]
		   ,[nombreCompleto]
           ,[telefono]
           ,[fecha_alta]
           ,eliminado
           ,[dni]
           ,[email]
           ,[dvh]
           ,[localidad_fk]
           ,[provincia_fk]
		   )
     VALUES
           (
		    @direccion
		   ,@nombre
		   ,@apellido
		   ,@nombreCompleto
		   ,@telefono
		   ,@fecha_alta
		   ,0
		   ,@dni
		   ,@email
		   ,0
		   ,@localidad_fk
		   ,@provincia_fk
		   )
		   

end
GO
/****** Object:  StoredProcedure [dbo].[cli_ModificarCliente]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[cli_ModificarCliente]
	@cliente_id as int,
	@apellido as nvarchar(80),
	@nombre as nvarchar(80),
	@nombreCompleto as nvarchar(160),
    @telefono as nvarchar(50),
	@dni as integer,
	@email as nvarchar(100),
    @direccion as nvarchar(255),
	@localidad_fk as int,
	@provincia_fk as int

AS

 
begin
UPDATE [dbo].Cliente
   SET apellido = ltrim(@apellido)
	  ,nombre = ltrim(@nombre)
	  ,nombreCompleto  = @nombreCompleto 
      ,telefono = @telefono
	  ,email = @email
	  ,dni = @dni
      ,direccion = @direccion
	  ,localidad_fk = @localidad_fk
	  ,provincia_fk = @provincia_fk
 WHERE 
		cliente_id = @cliente_id
end
GO
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientes]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[cli_ObtenerClientes]
AS
begin
SELECT *  FROM [farmacia].[dbo].Cliente 
end
GO
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientesPorApellido_Nombre]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[cli_ObtenerClientesPorApellido_Nombre]
@Apellido_Nombre as nvarchar(255)
AS
begin
SELECT *  FROM [farmacia].[dbo].Cliente  
where nombreCompleto like '%' + @Apellido_Nombre + '%'  
end
GO
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientesPorDNI]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[cli_ObtenerClientesPorDNI]
@dni as nvarchar(255)
AS
begin
SELECT *  FROM [farmacia].[dbo].Cliente  where cast(dni as nvarchar(50)) like '%' + @dni + '%' 
end
GO
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientesPorID]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[cli_ObtenerClientesPorID]
@cliente_id as int
AS
begin
SELECT *  FROM [farmacia].[dbo].Cliente  where cliente_id = @cliente_id  
end
GO
/****** Object:  StoredProcedure [dbo].[cli_VerificarExistencia]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[cli_VerificarExistencia]
@dni as integer
AS
begin
SELECT *  FROM [farmacia].[dbo].Cliente  where dni = @dni 
end 
GO
/****** Object:  StoredProcedure [dbo].[fam_EliminarFamilia]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fam_EliminarFamilia]
	@familia_id as int
AS
begin
delete from [dbo].[Familia] WHERE [familia_id] = @familia_id

end
GO
/****** Object:  StoredProcedure [dbo].[fam_InsertarFamilia]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fam_InsertarFamilia]
    @nombre_familia as nvarchar(50),
    @descripcion as nvarchar(50)
AS
begin

INSERT INTO [dbo].[Familia]
           (
           nombre
           ,descripcion,dvh)
     VALUES
           (
            @nombre_familia
           ,@descripcion,0)

		   end 
GO
/****** Object:  StoredProcedure [dbo].[fam_ModificarFamilia]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[fam_ModificarFamilia]
	@familia_id as int,
	@nombre_familia as nvarchar(50),
    @descripcion as nvarchar(50) 
AS
begin
UPDATE [dbo].Familia
   SET nombre = @nombre_familia
      ,descripcion = @descripcion
 WHERE 
		familia_id = @familia_id
end

GO
/****** Object:  StoredProcedure [dbo].[fam_ObtenerFamilias]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[fam_ObtenerFamilias]
AS
begin
SELECT [familia_id]
      ,[nombre]
      ,[descripcion]
      ,[dvh]
  FROM [dbo].[Familia]

end
GO
/****** Object:  StoredProcedure [dbo].[fam_ObtenerFamiliasPorID]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[fam_ObtenerFamiliasPorID]
@familia_id as int
AS
begin
SELECT f.familia_id,pf.patente_id,f.descripcion,f.nombre 
FROM [farmacia].[dbo].Familia as f inner join farmacia.dbo.Patente_Familia as pf on f.familia_id = pf.familia_id  
 where f.familia_id = @familia_id
end
GO
/****** Object:  StoredProcedure [dbo].[fam_VerificarExistencia]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fam_VerificarExistencia]
	@nombre as nvarchar(50)
AS
BEGIN

	select * from Familia  where nombre = @nombre
END

GO
/****** Object:  StoredProcedure [dbo].[idi_ObtenerIdiomas]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[idi_ObtenerIdiomas]
AS
begin
SELECT *  FROM [farmacia].[dbo].Idioma order by idioma_id 
end
GO
/****** Object:  StoredProcedure [dbo].[idi_ObtenerTraduccion]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[idi_ObtenerTraduccion]
 @idioma_fk as int,
 @texto as nvarchar(256)
AS
begin
SELECT *  FROM [farmacia].[dbo].Traduccion where idioma_fk = @idioma_fk and texto = @texto
end
GO
/****** Object:  StoredProcedure [dbo].[lab_ObtenerLaboratorioPorID]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[lab_ObtenerLaboratorioPorID]
@laboratorio_id as integer
AS
begin
SELECT *  FROM farmacia.dbo.Laboratorio
where laboratorio_id = @laboratorio_id 
end
GO
/****** Object:  StoredProcedure [dbo].[lab_ObtenerLaboratorios]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[lab_ObtenerLaboratorios]
AS
begin
SELECT *  FROM farmacia.dbo.Laboratorio order by razon_social
end
GO
/****** Object:  StoredProcedure [dbo].[loc_ObtenerLocalidades]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[loc_ObtenerLocalidades]
AS
begin
SELECT *  FROM [farmacia].[dbo].[Localidad] order by descripcion

end
GO
/****** Object:  StoredProcedure [dbo].[loc_ObtenerLocalidadPorID]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[loc_ObtenerLocalidadPorID]
@localidad_id as int
AS
begin
SELECT *
  FROM [farmacia].[dbo].[Localidad]
  where localidad_id = @localidad_id  
  order by descripcion
end
GO
/****** Object:  StoredProcedure [dbo].[med_EliminarMedicamento]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[med_EliminarMedicamento]
	@medicamento_id as int,
	@eliminado as bit
AS
begin
update Medicamento 
 SET  eliminado = @eliminado
 WHERE medicamento_id = @medicamento_id

end
GO
/****** Object:  StoredProcedure [dbo].[med_InsertarMedicamento]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[med_InsertarMedicamento]
    @descripcion as nvarchar(50),
    @laboratorio_id as integer,
    @precio as nvarchar(50),
	@cantidad as nvarchar(50),
	@receta as bit
AS
begin

INSERT INTO [dbo].Medicamento
           (
           descripcion
           ,laboratorio_fk
		   ,cantidad
		   ,precio
		   ,eliminado
		   ,receta
		   )
     VALUES
           (
            @descripcion
           ,@laboratorio_id
           ,@cantidad
		   ,@precio
		   ,0
		   ,@receta
		   )

end
GO
/****** Object:  StoredProcedure [dbo].[med_ModificarMedicamento]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[med_ModificarMedicamento]
	@medicamento_id as int,
	@descripcion as nvarchar(50),
	@laboratorio_id as integer,
    @precio as nvarchar(50),
    @cantidad as nvarchar(50),
	@receta as bit
AS
begin
UPDATE [dbo].Medicamento
   SET descripcion = @descripcion
	  ,laboratorio_fk = @laboratorio_id
      ,cantidad = @cantidad
      ,precio = @precio
	  ,receta = @receta
 WHERE 
	  medicamento_id = @medicamento_id
end

GO
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentos]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[med_ObtenerMedicamentos]
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento as m inner join farmacia.dbo.Laboratorio as l on m.laboratorio_fk = l.laboratorio_id
end
GO
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentosDisponibles]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[med_ObtenerMedicamentosDisponibles]
@cantidad as nvarchar(50)
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento as m 
inner join 
farmacia.dbo.Laboratorio as l on m.laboratorio_fk = l.laboratorio_id
where cantidad > @cantidad
end
GO
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentosPorDescripcion]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[med_ObtenerMedicamentosPorDescripcion]
@descripcion as nvarchar(255)
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento as m inner join farmacia.dbo.Laboratorio as l on m.laboratorio_fk = l.laboratorio_id
  where descripcion  LIKE '%' + @descripcion + '%'
end
GO
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentosPorID]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[med_ObtenerMedicamentosPorID]
@medicamento_id as int
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento as m inner join farmacia.dbo.Laboratorio as l on m.laboratorio_fk = l.laboratorio_id
  where medicamento_id = @medicamento_id 
end
GO
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentosPorLaboratorio]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[med_ObtenerMedicamentosPorLaboratorio]
@laboratorio_id as int
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento as m inner join farmacia.dbo.Laboratorio as l on m.laboratorio_fk = l.laboratorio_id
  where laboratorio_id  = @laboratorio_id or @laboratorio_id = 0
end
GO
/****** Object:  StoredProcedure [dbo].[med_VerificarExistencia]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[med_VerificarExistencia]
@descripcion as nvarchar(50)
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento  where descripcion = @descripcion 
end
GO
/****** Object:  StoredProcedure [dbo].[pat_ObtenerPatentes]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[pat_ObtenerPatentes]
AS
begin
SELECT [patente_id]
      ,[nombre]
       
  FROM [farmacia].[dbo].[Patente]
end
GO
/****** Object:  StoredProcedure [dbo].[prov_ObtenerProvinciaPorID]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[prov_ObtenerProvinciaPorID]
@provincia_id as int
AS
begin
SELECT *
  FROM [farmacia].[dbo].[Provincia]
  where provincia_id = @provincia_id  
  order by descripcion
end
GO
/****** Object:  StoredProcedure [dbo].[prov_ObtenerProvincias]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[prov_ObtenerProvincias]
AS
begin
SELECT *
  FROM [farmacia].[dbo].[Provincia]

end
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarFamilia]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_ValidarEliminarFamilia] 
	@familia_id AS Int
AS

Declare @patente_id int
Declare @result bit
Declare cur cursor For SELECT Patente.patente_id FROM farmacia.dbo.Patente WHERE Patente.obligatoria = 1

SET @result = 1
OPEN cur 
	FETCH NEXT FROM cur Into @patente_id
		While @@Fetch_Status = 0 Begin
 			IF NOT EXISTS (
				select *
				from farmacia.dbo.Usuario_Patente up 
				inner join farmacia.dbo.Usuario u
				on u.usuario_id = up.usuario_id
				where up.patente_id = @patente_id
				AND up.negado = 0
				AND u.bloqueado = 0
				AND u.eliminado = 0
    		) AND NOT EXISTS (
				select *
				from farmacia.dbo.Patente_Familia pf 
				inner join farmacia.dbo.Familia_Usuario fu 
				on fu.familia_id = pf.familia_id 
				inner join Usuario u
				on u.usuario_id = fu.usuario_id
				where 
				      fu.familia_id != @familia_id
				  AND pf.patente_id = @patente_id
				  AND u.bloqueado = 0
				  AND u.eliminado = 0
				  AND pf.patente_id 
				not in (
				select up.patente_id 
				from  farmacia.dbo.Usuario_Patente up 
				where up.usuario_id = u.usuario_id
				AND up.negado = 1)
				) SET @result = 0
				   
		FETCH NEXT FROM cur Into @patente_id
	END
CLOSE cur
DEALLOCATE cur

SELECT @result AS Valido

GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarFamiliaPatente]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ValidarEliminarFamiliaPatente] 
	@familia_id AS Int,
	@patente_id AS Int
AS

Declare @result bit

SET @result = 1

IF EXISTS (
	select p.patente_id
	from Patente p 
	where  p.obligatoria = 1 and p.patente_id = @patente_id
) AND NOT EXISTS (
	select up.patente_id, up.patente_id
	from Usuario_Patente up 
	inner join Usuario u
	on u.usuario_id = up.usuario_id
	where(up.patente_id = @patente_id)
	and up.negado = 0
	and u.bloqueado = 0
	and u.eliminado = 0
) AND NOT EXISTS (
	select fu.familia_id, pf.patente_id
	from Patente_Familia pf 
	inner join Familia_Usuario fu 
	on fu.familia_id = pf.familia_id 
	inner join Usuario u
	on u.usuario_id = fu.usuario_id
	where 
	    pf.patente_id = @patente_id
	and pf.familia_id != @familia_id
	and u.bloqueado = 0
	and u.eliminado = 0
	AND pf.patente_id
	 not in (
		select up.patente_id 
		from Usuario_Patente up 
		where up.usuario_id = fu.usuario_id
		and up.negado = 1
	)
 
) SET @result = 0

SELECT @result AS Valido

GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarFamiliaUsuario]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery10.sql|7|0|C:\Users\PC\AppData\Local\Temp\~vs62A1.sql
CREATE PROCEDURE [dbo].[sp_ValidarEliminarFamiliaUsuario] 
	@familia_id AS Int,
	@usuario_id AS Int
AS

Declare @patente_id int
Declare @result bit
Declare cur cursor For SELECT Patente.patente_id FROM Patente WHERE Patente.obligatoria = 1 

SET @result = 1
OPEN cur 
	FETCH NEXT FROM cur Into @patente_id
		While @@Fetch_Status = 0 Begin
			IF NOT EXISTS (
				select *
				from Usuario_Patente up 
				inner join Usuario u
				on u.usuario_id = up.usuario_id
				where up.patente_id = @patente_id
				and up.Negado = 0
				and u.bloqueado = 0
				and u.eliminado = 0
	/*	) AND NOT EXISTS (
				select *
				from Patente_Familia pf,
					 Familia_Usuario fu,
					 usuario u 
				where u.usuario_id = fu.usuario_id
				  AND fu.familia_id != pf.familia_id
				  AND pf.patente_id = @patente_id
				  AND ((u.usuario_id = @usuario_id
				   AND u.usuario_id = fu.usuario_id
				   AND fu.familia_id != @familia_id)
				  OR (u.usuario_id != @usuario_id))
				and u.bloqueado = 0
				and u.eliminado = 0
				AND pf.patente_id NOT in (
					select up.patente_id 
					from Usuario_Patente up 
					where up.usuario_id = @usuario_id
					and up.negado = 1)
			) SET @result = 0*/

						) AND NOT EXISTS (
				select *
				from Patente_Familia pf 
				inner join Familia_Usuario fu 
				on fu.familia_id = pf.familia_id 
				inner join Usuario u
				on u.usuario_id = fu.usuario_id
				AND pf.patente_id NOT in (
					select up.patente_id 
					from Usuario_Patente up 
					where up.usuario_id = @usuario_id
					and up.negado = 1)
				and pf.patente_id = @patente_id
				and (pf.familia_id != @familia_id or fu.usuario_id != @usuario_id)
				and u.bloqueado = 0
				and u.eliminado = 0
			) SET @result = 0

		FETCH NEXT FROM cur Into @patente_id
	END
CLOSE cur
DEALLOCATE cur

SELECT @result AS Valido







GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarUsuario]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ValidarEliminarUsuario] 
	@usuario_id AS Int
AS

Declare @patente_id int
Declare @result bit
Declare cur cursor For SELECT patente_id FROM Patente  WHERE Patente.obligatoria = 1


SET @result = 1
OPEN cur 
	FETCH NEXT FROM cur Into @patente_id
		While @@Fetch_Status = 0 Begin
			IF NOT EXISTS (
				select *
				from Usuario_Patente up,
				     usuario u
				WHERE u.usuario_id != @usuario_id
				  AND u.usuario_id = up.usuario_id
				  AND up.patente_id = @patente_id
				and up.negado = 0
				and u.bloqueado = 0
				and u.eliminado = 0
			) AND NOT EXISTS (
				select *
				from Patente_Familia pf,
				     Familia_Usuario fu,
					 usuario u
				WHERE u.usuario_id != @usuario_id
				  AND u.usuario_id = fu.usuario_id
				  AND fu.familia_id = pf.familia_id
				  AND pf.patente_id = @patente_id
				  AND pf.patente_id NOT in (
					select up.patente_id 
					from Usuario_Patente up 
					where up.usuario_id = u.usuario_id
					and up.negado = 1)
				  and u.bloqueado = 0
				  and u.eliminado = 0	
			) SET @result = 0
		FETCH NEXT FROM cur Into @patente_id
	END
CLOSE cur
DEALLOCATE cur

SELECT @result AS Valido




GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarUsuarioPatente]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ValidarEliminarUsuarioPatente] 
	@usuario_id AS Int,
	@patente_id AS Int
AS

Declare @result bit

SET @result = 1

IF EXISTS (
	select *
	from Patente p 
	where   p.obligatoria = 1 and p.patente_id = @patente_id
) AND NOT EXISTS (
	select *
	from dbo.Usuario_Patente up,
	     dbo.Usuario u
	WHERE  up.patente_id = @patente_id 
	   and up.usuario_id = u.usuario_id
	   and u.usuario_id != @usuario_id
	   and u.bloqueado = 0
	   and u.eliminado = 0
	   AND up.negado = 0
) AND NOT EXISTS (
	select * 
	  from dbo.Patente_Familia pf,
		   dbo.Familia_Usuario fu,	
		   dbo.Usuario u,
		   dbo.Usuario_Patente up
	 where pf.patente_id = @patente_id 
 	   and pf.familia_id = fu.familia_id
	   and fu.usuario_id = u.usuario_id
	   and u.usuario_id = @usuario_id
	   and u.bloqueado = 0
	   and u.eliminado = 0
) AND NOT EXISTS (
	select * 
	  from dbo.Patente_Familia pf,
		   dbo.Familia_Usuario fu,	
		   dbo.Usuario u,
		   dbo.Usuario_Patente up
	 where pf.patente_id = @patente_id 
 	   and pf.familia_id = fu.familia_id
	   and fu.usuario_id = u.usuario_id
	   and u.usuario_id != @usuario_id
	   and u.bloqueado = 0
	   and u.eliminado = 0
	   AND pf.patente_id NOT in (
		select up.patente_id 
		from Usuario_Patente up 
		where up.usuario_id = u.usuario_id
		and up.negado = 1)
) SET @result = 0

SELECT @result AS Valido

GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarUsuarioPatenteNegacion]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ValidarEliminarUsuarioPatenteNegacion] 
	@usuario_id AS Int,
	@patente_id AS Int
AS

Declare @result bit

SET @result = 1

IF EXISTS (
	select *
	from Patente p 
	where  p.obligatoria = 1 and p.patente_id = @patente_id
) AND NOT EXISTS (
	select *
	from Usuario_Patente up,
	     Usuario u
	where u.usuario_id != @usuario_id
	  and u.usuario_id = up.usuario_id
	  and up.Negado = 0
	  and up.patente_id = @patente_id
	  and u.bloqueado = 0
	  and u.eliminado = 0
) AND NOT EXISTS (
	select *
	from Patente_Familia pf,
	     Familia_Usuario fu,
		 usuario u
	WHERE u.usuario_id != @usuario_id
	  and u.usuario_id = fu.usuario_id
	  AND fu.familia_id = pf.familia_id
	  AND pf.patente_id = @patente_id
	  AND pf.patente_id NOT in (
		select up.patente_id 
		from Usuario_Patente up 
		where up.usuario_id = u.usuario_id
		and up.negado = 1)
	and u.bloqueado = 0
	and u.eliminado = 0
) SET @result = 0

SELECT @result AS Valido


GO
/****** Object:  StoredProcedure [dbo].[sp_VerificarPatente]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[sp_VerificarPatente] 
	@usuario_id AS Int,
	@patente_id AS Int
AS

Declare @result bit
SET @result = 0

IF EXISTS (
	select *
	from Usuario_Patente up,
	     usuario u
    WHERE u.usuario_id = @usuario_id
	  AND u.usuario_id = up.usuario_id
	  AND up.patente_id = @patente_id
	  AND up.negado = 0
) OR EXISTS (
	select *
	from Patente_Familia pf,
	     Familia_Usuario fu,
		 usuario u
	WHERE u.usuario_id = @usuario_id
	  AND u.usuario_id = fu.usuario_id
	  AND fu.familia_id = pf.familia_id
	  AND pf.patente_id = @patente_id
	  AND pf.patente_id NOT in (
		select up.patente_id 
		from Usuario_Patente up 
		where up.usuario_id = @usuario_id
		and up.negado = 1)
) SET @result = 1

SELECT @result AS Valido



GO
/****** Object:  StoredProcedure [dbo].[usu_BloquearDesbloquerUsuario]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usu_BloquearDesbloquerUsuario]
	@usuario_id as int,
	@bloqueado as bit
AS
begin
UPDATE [dbo].[Usuario]
   SET  bloqueado = @bloqueado
 WHERE 
		[usuario_id] = @usuario_id
end
GO
/****** Object:  StoredProcedure [dbo].[usu_EliminarUsuario]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usu_EliminarUsuario]
	@usuario_id as int,
	@eliminado as bit
AS
begin
UPDATE [dbo].[Usuario]
   SET  eliminado = @eliminado
 WHERE 
		[usuario_id] = @usuario_id
end
GO
/****** Object:  StoredProcedure [dbo].[usu_InsertarUsuario]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usu_InsertarUsuario]
	@nombre_usuario as nvarchar(50),
    @contraseña as nvarchar(50),
    @apellido as nvarchar(80),
    @nombre as nvarchar(80),
    @dni as int,
	@email as nvarchar(100),
    @bloqueado as bit,
	@eliminado as bit,
    @cci as int
AS
BEGIN
INSERT INTO [dbo].[Usuario]
           (		
            [nombre_usuario]
           ,[contraseña]
           ,[nombre]
           ,[apellido]
           ,[email]
           ,[dni]
           ,bloqueado
		   ,eliminado
           ,[cci]
		   ,dvh)
     VALUES
           (
		    @nombre_usuario
           ,@contraseña
           ,@nombre
           ,@apellido
           ,@email
           ,@dni
           ,@bloqueado
		   ,@eliminado
           ,@cci
           ,0 )
END

GO
/****** Object:  StoredProcedure [dbo].[usu_ModificarUsuario]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usu_ModificarUsuario]
	@usuario_id as int,
	@nombre_usuario as nvarchar(50),
    @contraseña as nvarchar(50),
    @nombre as nvarchar(80),
    @apellido as nvarchar(80),
    @email as nvarchar(100),
    @dni as int,
    @bloqueado as bit,
    @cci as int
AS
begin
UPDATE [dbo].[Usuario]
   SET [nombre_usuario] = @nombre_usuario
      ,[contraseña] = @contraseña
      ,[nombre] = @nombre
      ,[apellido] = @apellido
      ,[email] = @email
      ,[dni] = @dni
      ,bloqueado = @bloqueado
      ,[cci] = @cci
 WHERE 
	   [usuario_id] = @usuario_id

end
GO
/****** Object:  StoredProcedure [dbo].[usu_ObtenerUsuarios]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[usu_ObtenerUsuarios]
AS
begin
SELECT [usuario_id]
      ,[nombre_usuario]
      ,[contraseña]
      ,[nombre]
      ,[apellido]
      ,[email]
      ,[dni]
	  ,eliminado
      ,bloqueado
      ,[cci]
  FROM [farmacia].[dbo].[Usuario]
  order by eliminado


end
GO
/****** Object:  StoredProcedure [dbo].[usu_ObtenerUsuariosPorID]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usu_ObtenerUsuariosPorID]
@usuario_id as int
AS
begin
SELECT [usuario_id]
      ,[nombre_usuario]
      ,[contraseña]
      ,[nombre]
      ,[apellido]
      ,[email]
      ,[dni]
      ,bloqueado,eliminado
      ,[cci]
  FROM [farmacia].[dbo].[Usuario]
  where usuario_id = @usuario_id 
end
GO
/****** Object:  StoredProcedure [dbo].[usu_ValidarContraseña]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usu_ValidarContraseña]
	@nombre_usuario as nvarchar(50) 
AS
BEGIN

	select  [usuario_id]
      ,[nombre_usuario]
      ,[contraseña]
      ,[nombre]
      ,[apellido]
      ,[email]
      ,[dni]
      ,[bloqueado]
      ,[eliminado]
      ,[cci]
	   from Usuario u
	where u.nombre_usuario = @nombre_usuario 
END

GO
/****** Object:  StoredProcedure [dbo].[usu_VerificarExistencia]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usu_VerificarExistencia]
	@nombre_usuario as nvarchar(50)
AS
BEGIN

	select * from Usuario u where u.nombre_usuario = @nombre_usuario
END

GO
/****** Object:  StoredProcedure [dbo].[vent_EliminarVentasMedicamentosByVentaId]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[vent_EliminarVentasMedicamentosByVentaId]
@venta_id as int

AS
begin
delete from [dbo].[Venta_Medicamento] where Venta_Medicamento.venta_id = @venta_id;

end



GO
/****** Object:  StoredProcedure [dbo].[vent_InsertarVenta]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[vent_InsertarVenta]
@fecha_venta as datetime,
@cliente_fk as int,
@dvh as int

AS
begin


insert into	 
Venta (fecha_venta,cliente_fk,eliminado,dvh)
values (@fecha_venta,@cliente_fk,0,@dvh);
select SCOPE_IDENTITY();

end



GO
/****** Object:  StoredProcedure [dbo].[vent_InsertarVentaMedicamento]    Script Date: 16/11/2015 13:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[vent_InsertarVentaMedicamento]
@venta_id as int,
@medicamento_id as int,
@cantidad_venta as int,
@precio_venta as float

AS
begin


insert into	 
Venta_Medicamento (venta_id,medicamento_id,cantidad_venta,precio_venta,dvh)
values (@venta_id,@medicamento_id,@cantidad_venta,@precio_venta,	0)

end



GO
/****** Object:  StoredProcedure [dbo].[vent_ListarVentasById]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[vent_ListarVentasById]
@venta_id as int
AS
begin
SELECT 
V.venta_id,V.fecha_venta,C.cliente_id,C.nombreCompleto
FROM [farmacia].[dbo].[Venta] AS V
INNER JOIN Cliente AS C ON C.cliente_id = V.cliente_fk
WHERE 
V.venta_id = @venta_id
end



GO
/****** Object:  StoredProcedure [dbo].[vent_ListarVentasMedicamentosByVentaId]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[vent_ListarVentasMedicamentosByVentaId]
@venta_id as int
AS
begin
SELECT 
*
FROM [farmacia].[dbo].[Venta_Medicamento] AS VM
INNER JOIN Medicamento AS M ON VM.medicamento_id = M.medicamento_id
WHERE 
VM.venta_id = @venta_id
end



GO
/****** Object:  StoredProcedure [dbo].[vent_ListarVentasPorParametros]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[vent_ListarVentasPorParametros]
@fecha_desde as datetime,
@fecha_hasta as datetime,
@cliente_fk as int 
AS
begin
SELECT 
V.venta_id,V.fecha_venta,C.cliente_id,C.nombreCompleto
FROM [farmacia].[dbo].[Venta] AS V
INNER JOIN Cliente AS C ON C.cliente_id = V.cliente_fk
INNER JOIN Venta_Medicamento AS VM ON VM.venta_id = V.venta_id
INNER JOIN Medicamento AS M ON M.medicamento_id = VM.medicamento_id
WHERE 
  (V.fecha_venta >= @fecha_desde and V.fecha_venta <= @fecha_desde)
and  (V.cliente_fk = @cliente_fk or @cliente_fk = 0)
 
group by V.venta_id, V.fecha_venta,C.cliente_id,C.nombreCompleto
end



GO
/****** Object:  Table [dbo].[Bitacora]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bitacora](
	[bitacora_id] [int] IDENTITY(1,1) NOT NULL,
	[usuario_fk] [int] NULL,
	[descripcion] [nvarchar](255) NULL,
	[fecha_hora] [datetime] NULL,
	[criticidad] [nvarchar](50) NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Bitacora] PRIMARY KEY CLUSTERED 
(
	[bitacora_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente](
	[cliente_id] [int] IDENTITY(1,1) NOT NULL,
	[dni] [nvarchar](50) NULL,
	[apellido] [nvarchar](80) NULL,
	[nombre] [nvarchar](80) NULL,
	[nombreCompleto] [nvarchar](160) NULL,
	[telefono] [nvarchar](50) NULL,
	[email] [nvarchar](100) NULL,
	[direccion] [nvarchar](255) NULL,
	[localidad_fk] [int] NULL,
	[provincia_fk] [int] NULL,
	[fecha_alta] [date] NULL,
	[eliminado] [bit] NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DVV]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DVV](
	[tabla_id] [int] NOT NULL,
	[nombre] [nchar](20) NULL,
	[dvv] [varchar](256) NULL,
 CONSTRAINT [PK_DVV] PRIMARY KEY CLUSTERED 
(
	[tabla_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Familia]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Familia](
	[familia_id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[descripcion] [nvarchar](50) NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Familia] PRIMARY KEY CLUSTERED 
(
	[familia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Familia_Usuario]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Familia_Usuario](
	[familia_id] [int] NOT NULL,
	[usuario_id] [int] NOT NULL,
 CONSTRAINT [PK_Familia_Usuario] PRIMARY KEY CLUSTERED 
(
	[familia_id] ASC,
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Idioma]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Idioma](
	[idioma_id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NULL,
 CONSTRAINT [PK_Idioma] PRIMARY KEY CLUSTERED 
(
	[idioma_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Laboratorio]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Laboratorio](
	[laboratorio_id] [int] IDENTITY(1,1) NOT NULL,
	[telefono] [nvarchar](50) NULL,
	[razon_social] [nvarchar](50) NULL,
	[cuit] [nvarchar](50) NULL,
 CONSTRAINT [PK_Laboratorio] PRIMARY KEY CLUSTERED 
(
	[laboratorio_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Localidad]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Localidad](
	[localidad_id] [int] NOT NULL,
	[descripcion] [nvarchar](100) NULL,
	[provincia_fk] [int] NOT NULL,
 CONSTRAINT [PK_Localidad] PRIMARY KEY CLUSTERED 
(
	[localidad_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Medicamento]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Medicamento](
	[medicamento_id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [nvarchar](50) NOT NULL,
	[laboratorio_fk] [int] NULL,
	[cantidad] [nvarchar](50) NULL,
	[precio] [nvarchar](50) NULL,
	[eliminado] [bit] NULL,
	[receta] [bit] NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Medicamento] PRIMARY KEY CLUSTERED 
(
	[medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Patente]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patente](
	[patente_id] [int] NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[obligatoria] [bit] NULL,
 CONSTRAINT [PK_Patente] PRIMARY KEY CLUSTERED 
(
	[patente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Patente_Familia]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patente_Familia](
	[familia_id] [int] NOT NULL,
	[patente_id] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Provincia]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provincia](
	[provincia_id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [nvarchar](100) NULL,
 CONSTRAINT [PK_Provincia] PRIMARY KEY CLUSTERED 
(
	[provincia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Traduccion]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Traduccion](
	[traduccion_id] [int] IDENTITY(1,1) NOT NULL,
	[idioma_fk] [int] NULL,
	[texto] [nvarchar](256) NULL,
	[traduccion] [nvarchar](256) NULL,
 CONSTRAINT [PK_Traduccion] PRIMARY KEY CLUSTERED 
(
	[traduccion_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[usuario_id] [int] IDENTITY(1,1) NOT NULL,
	[nombre_usuario] [nvarchar](50) NOT NULL,
	[contraseña] [nvarchar](50) NOT NULL,
	[nombre] [nvarchar](80) NULL,
	[apellido] [nvarchar](80) NULL,
	[email] [nvarchar](100) NULL,
	[dni] [nvarchar](50) NULL,
	[bloqueado] [bit] NULL,
	[eliminado] [bit] NULL,
	[cci] [int] NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario_Patente]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario_Patente](
	[patente_id] [int] NOT NULL,
	[usuario_id] [int] NOT NULL,
	[negado] [bit] NULL,
 CONSTRAINT [PK_Usuario_Patente] PRIMARY KEY CLUSTERED 
(
	[patente_id] ASC,
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Venta]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venta](
	[venta_id] [int] IDENTITY(1,1) NOT NULL,
	[cliente_fk] [int] NOT NULL,
	[eliminado] [bit] NULL,
	[fecha_venta] [datetime] NULL,
	[dvh] [int] NULL,
 CONSTRAINT [PK_Venta] PRIMARY KEY CLUSTERED 
(
	[venta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Venta_Medicamento]    Script Date: 16/11/2015 13:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Venta_Medicamento](
	[venta_medicamento_id] [int] IDENTITY(1,1) NOT NULL,
	[venta_id] [int] NULL,
	[medicamento_id] [int] NULL,
	[cantidad_venta] [int] NULL,
	[precio_venta] [float] NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Venta_Medicamento] PRIMARY KEY CLUSTERED 
(
	[venta_medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Bitacora] ON 

INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1490, 29, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A551017F5CC7 AS DateTime), N'Baja', N'90468')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1491, 29, N'7SEbSfqwAYy3awy9MA4zxLH4bhfLtJ4uzyaXpWr0IIc=', CAST(0x0000A551017FA469 AS DateTime), N'Alta', N'197762')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1492, 29, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A551018073D0 AS DateTime), N'Baja', N'93441')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1493, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55101819687 AS DateTime), N'Baja', N'89553')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1494, 9, N'eAuF+/yWqQ5r1KZIWIxfg2nu6CJWyeGTZontVRqNjPY=', CAST(0x0000A5510181A4C6 AS DateTime), N'Alta', N'191601')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1495, 9, N'uDkgXNw+7CHUFvWnn33LNaFiVsmXrwZoO31hdD8HGos=', CAST(0x0000A5510181A75A AS DateTime), N'Alta', N'188105')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1496, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A5510184A193 AS DateTime), N'Media', N'332247')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1497, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5510184A6C3 AS DateTime), N'Baja', N'89468')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1498, 29, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55101855D88 AS DateTime), N'Baja', N'93611')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1499, 29, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A551018565E1 AS DateTime), N'Baja', N'90637')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1500, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A551018576AE AS DateTime), N'Baja', N'90076')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1501, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5510185B52D AS DateTime), N'Baja', N'89789')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1502, 29, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55101865836 AS DateTime), N'Baja', N'92941')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1503, 29, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5510186638F AS DateTime), N'Baja', N'90065')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1504, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55101867E2B AS DateTime), N'Baja', N'89579')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1505, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5510186DAB6 AS DateTime), N'Baja', N'89437')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1506, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5510189EA98 AS DateTime), N'Baja', N'89529')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1507, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5520000AD7C AS DateTime), N'Baja', N'86679')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1508, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5520000C54E AS DateTime), N'Baja', N'84075')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1509, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5520001B6B8 AS DateTime), N'Baja', N'86629')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1510, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5520001DF4D AS DateTime), N'Baja', N'84269')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1511, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5520003023F AS DateTime), N'Baja', N'86704')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1512, 9, N'92xR8E9lVFvZ+l193m52qLcRpEHJ/KDzbnv6Q+vsx8Q=', CAST(0x0000A55200032164 AS DateTime), N'Media', N'186354')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1513, 9, N'1rvroHdeQqHsdhwiHirv7g==', CAST(0x0000A55200033114 AS DateTime), N'Alta', N'93666')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1514, 9, N'UYahIg+g0WKndK4p/20+pg==', CAST(0x0000A552000333B1 AS DateTime), N'Alta', N'86425')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1515, 9, N'AguINniBEFNkqkZBzpMOOBkdekUhsXsev8lMyac2/ps=', CAST(0x0000A5520003419D AS DateTime), N'Alta', N'191145')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1516, 9, N'mGqAmOwBQ2Sm4XzpbMgE7f+N9KV6nkgm1pRkGdXa54c=', CAST(0x0000A55200037945 AS DateTime), N'Alta', N'181240')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1517, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5520003E625 AS DateTime), N'Baja', N'83738')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1518, 9, N'wpBfWofrcXUGdvLEsEj50CiFHOuOjoX3qsJD96E3AYM=', CAST(0x0000A5520004DA7B AS DateTime), N'Alta', N'178114')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1519, 9, N'7SEbSfqwAYy3awy9MA4zxLH4bhfLtJ4uzyaXpWr0IIc=', CAST(0x0000A5520004DBE4 AS DateTime), N'Alta', N'187931')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1520, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5520004E8A3 AS DateTime), N'Baja', N'86776')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1521, 9, N'mGqAmOwBQ2Sm4XzpbMgE7f+N9KV6nkgm1pRkGdXa54c=', CAST(0x0000A5520004FE29 AS DateTime), N'Alta', N'180939')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1522, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200068B86 AS DateTime), N'Baja', N'86934')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1523, 9, N'mGqAmOwBQ2Sm4XzpbMgE7f+N9KV6nkgm1pRkGdXa54c=', CAST(0x0000A5520006A831 AS DateTime), N'Alta', N'181022')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1524, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5520006E656 AS DateTime), N'Baja', N'86752')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1525, 9, N'mGqAmOwBQ2Sm4XzpbMgE7f+N9KV6nkgm1pRkGdXa54c=', CAST(0x0000A5520006F8B1 AS DateTime), N'Alta', N'181026')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1526, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200081953 AS DateTime), N'Baja', N'84422')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1527, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A552000A8182 AS DateTime), N'Baja', N'86891')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1528, 9, N'mGqAmOwBQ2Sm4XzpbMgE7f+N9KV6nkgm1pRkGdXa54c=', CAST(0x0000A552000AC3D0 AS DateTime), N'Alta', N'181224')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1529, 9, N'ei8eB9akhdtYhJmiABriX/+yTXq+uDzs/hpP3M71ago=', CAST(0x0000A552000BE142 AS DateTime), N'Alta', N'183912')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1530, 9, N'92xR8E9lVFvZ+l193m52qLcRpEHJ/KDzbnv6Q+vsx8Q=', CAST(0x0000A552000C0845 AS DateTime), N'Media', N'187136')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1531, 9, N'mGqAmOwBQ2Sm4XzpbMgE7f+N9KV6nkgm1pRkGdXa54c=', CAST(0x0000A552000D320F AS DateTime), N'Alta', N'181199')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1532, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200A00725 AS DateTime), N'Baja', N'87255')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1533, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200BB5257 AS DateTime), N'Baja', N'89115')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1534, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200BB6038 AS DateTime), N'Baja', N'86514')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1535, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200BD256D AS DateTime), N'Baja', N'89918')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1536, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200BD296D AS DateTime), N'Baja', N'86981')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1537, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200BD8016 AS DateTime), N'Baja', N'89921')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1538, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200BD86F3 AS DateTime), N'Baja', N'86437')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1539, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200BE9EA0 AS DateTime), N'Baja', N'89273')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1540, 9, N'VPKIonfX6HMAjouizTOhQwBtYykvP9kSP1c63L6c29MW9GIfjM3EtlM/8ZXeFKin', CAST(0x0000A55200BF01F9 AS DateTime), N'Alta', N'310696')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1541, 9, N'eAuF+/yWqQ5r1KZIWIxfg2nu6CJWyeGTZontVRqNjPY=', CAST(0x0000A55200BF0613 AS DateTime), N'Alta', N'191977')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1542, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200BF12A8 AS DateTime), N'Baja', N'86733')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1543, 9, N'YcTo6gq4CNndMjb+QZLBiHJdbUD9e0xENHabbR8ex2Y=', CAST(0x0000A55200BF656E AS DateTime), N'Alta', N'184609')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1544, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200BF78A5 AS DateTime), N'Baja', N'89679')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1545, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200BF99FD AS DateTime), N'Baja', N'87028')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1546, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200C06D0C AS DateTime), N'Baja', N'89509')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1547, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A55200C08981 AS DateTime), N'Alta', N'182134')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1548, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A55200C08E0F AS DateTime), N'Alta', N'182410')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1549, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200C39624 AS DateTime), N'Baja', N'89514')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1550, 9, N'MVdb5psLDtHAIrEJkSjDWK6J1KYjPtVkkKY5er52Spo=', CAST(0x0000A55200C3B258 AS DateTime), N'Alta', N'186305')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1551, 9, N'MVdb5psLDtHAIrEJkSjDWK6J1KYjPtVkkKY5er52Spo=', CAST(0x0000A55200C3B5C8 AS DateTime), N'Alta', N'186513')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1552, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200C40D29 AS DateTime), N'Baja', N'89818')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1553, 9, N'MVdb5psLDtHAIrEJkSjDWK6J1KYjPtVkkKY5er52Spo=', CAST(0x0000A55200C41A1B AS DateTime), N'Alta', N'187128')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1554, 9, N'MVdb5psLDtHAIrEJkSjDWK6J1KYjPtVkkKY5er52Spo=', CAST(0x0000A55200C41C2C AS DateTime), N'Alta', N'186250')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1555, 9, N'ei8eB9akhdtYhJmiABriX1U1mpTO80fmJUkDejOcA50=', CAST(0x0000A55200C433A5 AS DateTime), N'Alta', N'184147')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1556, 9, N'UYahIg+g0WKndK4p/20+pg==', CAST(0x0000A55200C4DFB6 AS DateTime), N'Alta', N'89604')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1557, 9, N'bCs5TEGHWUHqr3uw0/J+Pg==', CAST(0x0000A55200C4E763 AS DateTime), N'Alta', N'90296')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1558, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200C53A15 AS DateTime), N'Baja', N'86987')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1559, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200C741ED AS DateTime), N'Baja', N'89664')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1560, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200C839A5 AS DateTime), N'Baja', N'89955')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1561, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200C8EC45 AS DateTime), N'Baja', N'89258')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1562, 0, N'uFAIrnFQ4ZJ5jF/k6mSuBzkWjXTmNsiS8NJj7m4UI/k=', CAST(0x0000A55200C93BC6 AS DateTime), N'Media', N'191827')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1563, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200CC56F3 AS DateTime), N'Baja', N'89782')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1564, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200CEC31B AS DateTime), N'Baja', N'89690')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1565, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200CFB022 AS DateTime), N'Baja', N'86697')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1566, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200D00577 AS DateTime), N'Baja', N'89589')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1567, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200D18645 AS DateTime), N'Baja', N'89505')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1568, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200D20663 AS DateTime), N'Baja', N'86804')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1569, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200D38981 AS DateTime), N'Baja', N'89231')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1570, 9, N'J6OXvfoWimq/nVaXFZ+s3MRr2+3tZ8VjYZEkm7xjLOs=', CAST(0x0000A55200D3A669 AS DateTime), N'Media', N'194656')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1571, 9, N'J6OXvfoWimq/nVaXFZ+s3MRr2+3tZ8VjYZEkm7xjLOs=', CAST(0x0000A55200D4F440 AS DateTime), N'Media', N'194578')
SET IDENTITY_INSERT [dbo].[Bitacora] OFF
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [nombreCompleto], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (3, N'33333332', N'settino', N'german', N'settino, german', N'46351267', N'german@gramn.com', N'asdasd', 6, 24, CAST(0xAB3A0B00 AS Date), 0, N'337461')
SET IDENTITY_INSERT [dbo].[Cliente] OFF
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (1, N'Bitacora            ', N'10371498')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (2, N'Usuario             ', N'1298639')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (3, N'Familia             ', N'0')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (4, N'Venta               ', N'211769')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (5, N'Venta_Medicamento   ', N'52290')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (6, N'Medicamento         ', N'874909')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (7, N'Cliente             ', N'337461')
SET IDENTITY_INSERT [dbo].[Idioma] ON 

INSERT [dbo].[Idioma] ([idioma_id], [nombre]) VALUES (1, N'Español')
INSERT [dbo].[Idioma] ([idioma_id], [nombre]) VALUES (2, N'Ingles')
SET IDENTITY_INSERT [dbo].[Idioma] OFF
SET IDENTITY_INSERT [dbo].[Laboratorio] ON 

INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (1, N'954-196-125', N'BAXTER ARG.', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (2, N'945-638-712', N'BAUSCH & LOMB', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (3, N'932-330-230', N'LOMB', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (4, N'928-346-635', N'BACON', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (5, N'977-624-082', N'B-Life S.A.', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (6, N'960-541-777', N'BA', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (7, N'953-731-612', N'BAYER', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (8, N'967-751-963', N'BAYER (BSP)', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (9, N'932-472-344', N'RAFFO', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (10, N'950-689-140', N'IVAX', N'30-51684266-7')
SET IDENTITY_INSERT [dbo].[Laboratorio] OFF
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (1, N'Villa delina', 24)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (2, N'Boulogne', 24)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (3, N'Munro', 24)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (4, N'Villa Maria', 42)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (5, N'Castilla y León', 42)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (6, N'Andalucía', 42)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (7, N'Merlo', 30)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (8, N'Carpinteria', 30)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (9, N'Potrero de los funes', 30)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (10, N'Cordoba capital', 42)
SET IDENTITY_INSERT [dbo].[Medicamento] ON 

INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (10, N'ibuprofeno', 10, N'SZrFcO3dbNwLssEDVscEqQ==', N'SZrFcO3dbNwLssEDVscEqQ==', 0, 1, N'232050')
INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (11, N'armonil', 10, N'+xvtVhnD3ZpIQxi2DYTavg==', N'l+7GAbE2aEWExP3+uHcD9Q==', 1, 0, N'198136')
INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (12, N'adasdasd', 2, N'YSITDcKLEgcfV+qFz8klnQ==', N'JZNPADvBBdzwzN55xhQHUA==', 1, 1, N'201578')
INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (13, N'medicamento1', 7, N'XeKalQmBBdJujrYcKsYiJA==', N'foC1PgHNtIUQbPnpiNnbzw==', 0, 1, N'243145')
SET IDENTITY_INSERT [dbo].[Medicamento] OFF
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (1, N'Usuario', 1)
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (2, N'Familia', 1)
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (3, N'Backup', 1)
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (4, N'Restore', 1)
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (5, N'Bitacora', 1)
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (6, N'RecalcularDV', 1)
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (7, N'Venta', 0)
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (8, N'Cliente', 0)
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (9, N'Medicamento', 0)
SET IDENTITY_INSERT [dbo].[Provincia] ON 

INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (24, N'Buenos Aires')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (25, N'Formosa')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (26, N'Chaco')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (27, N'Santa Cruz')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (28, N'Mendoza')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (29, N'Tierra del Fuego')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (30, N'San Luis')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (31, N'San Juan')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (32, N'Misiones')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (33, N'Jujuy')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (34, N'Salta')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (35, N'Chubut')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (36, N'Capital Federal')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (37, N'La Rioja')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (38, N'Tucuman')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (39, N'Corrientes')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (40, N'Entre Rios')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (41, N'Santa Fe')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (42, N'Cordoba')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (43, N'La Pampa')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (44, N'Rio Negro')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (45, N'Santiago del Estero')
SET IDENTITY_INSERT [dbo].[Provincia] OFF
SET IDENTITY_INSERT [dbo].[Traduccion] ON 

INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (1, 2, N'&Aceptar', N'&Accept')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (2, 2, N'&Activar', N'&Active')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (3, 2, N'&Buscar', N'&Search')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (4, 2, N'&Cancelar', N'&Cancel')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (5, 2, N'&Contraseña', N'&Password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (6, 2, N'&Exportar', N'&Export')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (7, 2, N'&Limpiar', N'C&lean')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (8, 2, N'&Registrar', N'&New')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (9, 2, N'&Restablecer Contraseña', N'&Reset Password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (10, 2, N'&Salir', N'&Exit')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (11, 2, N'Acerca de Sistema de Gestion Farmacia', N'About Sistema de Gestion Farmacia')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (12, 2, N'Apellido', N'Lastname')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (13, 2, N'Apellido y Nombre', N'Lastname and Name')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (14, 2, N'Archivo', N'File')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (15, 2, N'Asignada', N'Assigned')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (16, 2, N'Ayuda', N'Help')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (17, 2, N'Backup', N'Backup')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (18, 2, N'Bitacora', N'Log')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (19, 2, N'Bitacora', N'Logs')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (20, 2, N'Bloquear', N'Block')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (21, 2, N'Campo Requerido', N'Campo Requerido')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (22, 2, N'Cantidad', N'Amount')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (23, 2, N'Clientes', N'Customers')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (24, 2, N'Criticidad', N'Criticality')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (25, 2, N'Desbloquear', N'Unlock')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (26, 2, N'Descripcion', N'Description')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (27, 2, N'Direccion', N'Address')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (28, 2, N'DNI', N'DNI')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (29, 2, N'Eliminar', N'Delete')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (30, 2, N'E-Mail', N'E-Mail')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (31, 2, N'Error', N'Error')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (32, 2, N'Español', N'Spanish')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (33, 2, N'Exportar informe', N'Export inform')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (34, 2, N'Familia', N'Family')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (35, 2, N'Familias', N'Families')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (36, 2, N'Fecha', N'Date')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (37, 2, N'Fecha desde', N'Date from')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (38, 2, N'Fecha hasta', N'Date to')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (39, 2, N'Generar informe', N'Generate inform')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (40, 2, N'Generar nuevo', N'Generate new')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (41, 2, N'Id', N'Id')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (42, 2, N'Idioma', N'Language')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (43, 2, N'Informes', N'Reports')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (44, 2, N'Laboratorio', N'Laboratory')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (45, 2, N'Limpiar', N'Clean')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (46, 2, N'Localidad', N'Location')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (47, 2, N'Medicamentos', N'Medicines')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (48, 2, N'Mensaje', N'Message')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (49, 2, N'Modificar', N'Modify')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (50, 2, N'Negada', N'Denied')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (51, 2, N'Nombre', N'Name')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (52, 2, N'Patente', N'Role')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (53, 2, N'Patentes', N'Roles')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (54, 2, N'Patentes negacion', N'Denied roles')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (55, 2, N'Permisos', N'Permissions')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (56, 2, N'Precio', N'Price')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (57, 2, N'Provincia', N'Province')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (58, 2, N'Receta', N'Prescription')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (59, 2, N'Reporte Clientes Por Compra', N'Customers For Purchase Report')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (60, 2, N'Reporte Stock de Medicamentos', N'Stock Medicines Report')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (61, 2, N'Reporte Ventas Por Medicamentos', N'Sales Report On Medicines')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (62, 2, N'Restaurar', N'Restore')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (63, 2, N'Ruta', N'Path')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (64, 2, N'Salir', N'Exit')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (65, 2, N'Seguridad', N'Security')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (66, 2, N'Sistema de Gestion Farmacia', N'Pharmacy Management System')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (67, 2, N'Telefono', N'Phone')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (68, 2, N'Todos', N'All')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (69, 2, N'Usuario', N'User')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (70, 2, N'Usuarios', N'Users')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (71, 2, N'Ventas', N'Sales')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (72, 2, N'Ver la Ayuda', N'View Help')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (73, 2, N'Activar', N'Activate')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (74, 2, N'No se puede eliminar el usuario porque quedarian patentes esenciales sin asignar', N'You can not delete the user because it would be essential patents unassigned')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (75, 2, N'¿Esta seguro que desea Activar el usuario', N'Are you sure you want to enable user')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (76, 2, N'No se puede bloquear el usuario porque quedarian patentes esenciales sin asignar', N'You can not block the user because essential patents would unassigned')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (77, 2, N'¿Esta seguro que desea Bloquear el usuario', N'
Are you sure you want to block user')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (78, 2, N'¿Esta seguro que desea Desbloquear el usuario', N'Are you sure you want to unlock the user')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (79, 2, N'¿Esta seguro que desea Eliminar el usuario', N'
Are you sure you want to delete the user')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (80, 2, N'Cambiar Contraseña', N'Change Password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (81, 2, N'Email', N'Email')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (82, 2, N'Fecha y Hora', N'Date and Time')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (83, 2, N'lblcontraseña', N'lblcontraseña')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (84, 2, N'Se Modifico el Usuario', N'User changed')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (85, 2, N'Modificar Usuario', N'
Change User')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (86, 2, N'No se puede eliminar el mismo usuario', N'
You can not remove the same user')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (87, 2, N'No se puede bloquear el mismo usuario', N'You can not lock the same user')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (88, 2, N'Se Registro el Usuario', N'
The User Registration')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (89, 2, N'Registrar Usuario', N'
User Registration')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (90, 2, N'Eliminar Usuario', N'
Remove User')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (92, 2, N'Activar Usuario', N'
Enable User')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (93, 2, N'Bloquear Usuario', N'
Block user')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (94, 2, N'Desbloquear Usuario', N'Unblock user')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (95, 2, N'Se restablecio la contraseña Usuario', N'User password reset')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (96, 2, N'No se puede quitar la patente al usuario porque la patente quedaria sin asignacion', N'You can not remove the patent to the user because the patent would be unallocated')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (97, 2, N'¿Esta seguro que desea Activar el Cliente', N'Are you sure you want to activate the client')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (98, 2, N'Activar Cliente', N'
Enable Customer')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (100, 2, N'¿Esta seguro que desea Eliminar el Cliente', N'¿Esta seguro que desea Eliminar el Cliente')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (101, 2, N'Eliminar Cliente', N'Delete Customer')
GO
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (102, 2, N'Se Modifico el Cliente', N'It changes the Customer')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (103, 2, N'Modificar Cliente', N'Modificar Cliente')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (104, 2, N'Se Registro el Cliente', N'He Customer Registration')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (105, 2, N'Registrar Cliente', N'
Customer register')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (106, 2, N'¿Esta seguro que desea Activar el Medicamento', N'Are you sure you want to activate the medication')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (107, 2, N'Activar Medicamento', N'Active Medicines')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (109, 2, N'¿Esta seguro que desea Eliminar el Medicamento', N'Are you sure you want to delete Medication')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (110, 2, N'Eliminar Medicamento', N'Remove Medicines')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (112, 2, N'Se Modifico el Medicamento', N'Medication modified')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (113, 2, N'Modificar Medicamento', N'Modify Medicines')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (114, 2, N'Se Registro el Medicamento', N'Medication recorded')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (115, 2, N'Registrar Medicamento', N'Register Medicines')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (116, 2, N'Todos los Usuarios', N'All Users')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (117, 2, N'...', N'...')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (118, 2, N'¿Esta seguro que desea salir?', N'
Are you sure you want to quit?')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (119, 2, N'Sus permisos han sido modificados, por favor inicie sesion nuevamente', N'Permissions have been changed, please log in again')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (120, 2, N'Reporte Clientes Por Venta', N'Report Customers For Sale')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (122, 2, N'Contraseña Anterior', N'
Old Password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (123, 2, N'Confirmar Contraseña', N'Confirm Password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (124, 2, N'Nueva Contraseña', N'New Password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (125, 2, N'Se Cambio la Contraseña', N'He changed the password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (126, 2, N'Todos los niveles', N'All levels')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (128, 2, N'Reportes', N'Reports')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (129, 2, N'Stock Medicamentos', N'
Stock Medications')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (130, 2, N'Agregar Medicamento', N'Add Medication')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (131, 2, N'Medicamento', N'Medicine')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (132, 2, N'Cliente', N'
Customer')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (133, 2, N'Nro Venta', N'No. Sale')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (134, 2, N'NroVenta', N'NoSale')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (135, 2, N'Total', N'Total')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (136, 2, N'Ver Detalle', N'See detail')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (138, 2, N'Precio Total', N'
Total Price')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (139, 2, N'Nro', N'No.')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (140, 2, N'Quitar Medicamento', N'Remove Medicines')
SET IDENTITY_INSERT [dbo].[Traduccion] OFF
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (9, N'UYahIg+g0WKndK4p/20+pg==', N'81dc9bdb52d04dc20036dbd8313ed055', N'administrador', N'administrador', N'administrador@administrador.com', N'12345678', 0, 0, 0, N'813425')
INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (29, N'ffJMRvWqtW+IBm25OTHrsA==', N'81dc9bdb52d04dc20036dbd8313ed055', N'german', N'settino', N'german@german.com', N'33333333', 0, 1, 0, N'485214')
SET IDENTITY_INSERT [dbo].[Usuario] OFF
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (1, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (2, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (3, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (3, 29, 1)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (4, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (4, 29, 1)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (5, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (6, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (7, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (7, 29, 0)
SET IDENTITY_INSERT [dbo].[Venta] ON 

INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (1, 3, 0, CAST(0x0000A55000000000 AS DateTime), 17257)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (2, 3, 0, CAST(0x0000A55000000000 AS DateTime), 17258)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (3, 3, 0, CAST(0x0000A55000000000 AS DateTime), 17259)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (4, 3, 0, CAST(0x0000A55000000000 AS DateTime), 17260)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (5, 3, 0, CAST(0x0000A55000000000 AS DateTime), 17261)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (6, 3, 0, CAST(0x0000A55100000000 AS DateTime), 17271)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (7, 3, 0, CAST(0x0000A55100000000 AS DateTime), 17272)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (8, 3, 0, CAST(0x0000A55100000000 AS DateTime), 17273)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (9, 3, 0, CAST(0x0000A55100000000 AS DateTime), 17274)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (10, 3, 0, CAST(0x0000A55100000000 AS DateTime), 18786)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (11, 3, 0, CAST(0x0000A55200000000 AS DateTime), 18798)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (12, 3, 0, CAST(0x0000A55200000000 AS DateTime), 18800)
SET IDENTITY_INSERT [dbo].[Venta] OFF
SET IDENTITY_INSERT [dbo].[Venta_Medicamento] ON 

INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (1, 3, 10, 12, 12, N'1778')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (2, 3, 10, 12, 12, N'1779')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (3, 3, 10, 12, 12, N'1780')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (4, 3, 10, 12, 12, N'1781')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (5, 3, 10, 12, 12, N'1782')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (9, 4, 10, 12, 12, N'1788')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (10, 4, 10, 12, 12, N'2223')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (11, 4, 10, 12, 12, N'2225')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (12, 6, 10, 12, 12, N'2233')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (13, 6, 10, 12, 12, N'2235')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (14, 6, 10, 12, 12, N'2237')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (15, 7, 10, 12, 12, N'2242')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (16, 7, 10, 12, 122, N'2744')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (17, 7, 10, 12, 122, N'2746')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (18, 8, 12, 1, 1, N'1412')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (19, 8, 13, 1, 1, N'1419')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (20, 9, 10, 12, 12, N'2239')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (21, 10, 10, 12, 123, N'3265')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (22, 10, 10, 12, 123, N'3267')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (23, 11, 10, 1, 10, N'2195')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (24, 11, 10, 1, 10, N'2197')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (25, 12, 10, 2, 13, N'2237')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (26, 12, 10, 2, 13, N'2239')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (27, 12, 11, 2, 13, N'2247')
SET IDENTITY_INSERT [dbo].[Venta_Medicamento] OFF
/****** Object:  Index [UQ_Bitacora_bitacora_id]    Script Date: 16/11/2015 13:13:01 ******/
ALTER TABLE [dbo].[Bitacora] ADD  CONSTRAINT [UQ_Bitacora_bitacora_id] UNIQUE NONCLUSTERED 
(
	[bitacora_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Cliente_cliente_id]    Script Date: 16/11/2015 13:13:01 ******/
ALTER TABLE [dbo].[Cliente] ADD  CONSTRAINT [UQ_Cliente_cliente_id] UNIQUE NONCLUSTERED 
(
	[cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_DVV_tabla_id]    Script Date: 16/11/2015 13:13:01 ******/
ALTER TABLE [dbo].[DVV] ADD  CONSTRAINT [UQ_DVV_tabla_id] UNIQUE NONCLUSTERED 
(
	[tabla_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Familia_familia_id]    Script Date: 16/11/2015 13:13:01 ******/
ALTER TABLE [dbo].[Familia] ADD  CONSTRAINT [UQ_Familia_familia_id] UNIQUE NONCLUSTERED 
(
	[familia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Idioma_idioma_id]    Script Date: 16/11/2015 13:13:01 ******/
ALTER TABLE [dbo].[Idioma] ADD  CONSTRAINT [UQ_Idioma_idioma_id] UNIQUE NONCLUSTERED 
(
	[idioma_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Laboratorio_laboratorio_id]    Script Date: 16/11/2015 13:13:01 ******/
ALTER TABLE [dbo].[Laboratorio] ADD  CONSTRAINT [UQ_Laboratorio_laboratorio_id] UNIQUE NONCLUSTERED 
(
	[laboratorio_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Localidad_localidad_id]    Script Date: 16/11/2015 13:13:01 ******/
ALTER TABLE [dbo].[Localidad] ADD  CONSTRAINT [UQ_Localidad_localidad_id] UNIQUE NONCLUSTERED 
(
	[localidad_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Medicamento_medicamento_id]    Script Date: 16/11/2015 13:13:01 ******/
ALTER TABLE [dbo].[Medicamento] ADD  CONSTRAINT [UQ_Medicamento_medicamento_id] UNIQUE NONCLUSTERED 
(
	[medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Patente_patente_id]    Script Date: 16/11/2015 13:13:01 ******/
ALTER TABLE [dbo].[Patente] ADD  CONSTRAINT [UQ_Patente_patente_id] UNIQUE NONCLUSTERED 
(
	[patente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Provincia_provincia_id]    Script Date: 16/11/2015 13:13:01 ******/
ALTER TABLE [dbo].[Provincia] ADD  CONSTRAINT [UQ_Provincia_provincia_id] UNIQUE NONCLUSTERED 
(
	[provincia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Usuario_usuario_id]    Script Date: 16/11/2015 13:13:01 ******/
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [UQ_Usuario_usuario_id] UNIQUE NONCLUSTERED 
(
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [farmacia] SET  READ_WRITE 
GO
