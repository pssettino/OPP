USE [master]
GO
/****** Object:  Database [farmacia]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[bit_InsertarBitacora]    Script Date: 06/11/2015 23:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bit_InsertarBitacora]
	@usuario_fk as int,
    @descripcion as nvarchar(255),
	@fecha_hora as datetime,
	@criticidad_desc  as nvarchar(50)
AS
BEGIN

INSERT INTO [dbo].[Bitacora]
(
  [usuario_fk]
 ,[descripcion]
 ,[fecha_hora]
 ,[criticidad_fk]
 )
Select 
@usuario_fk,
@descripcion,
@fecha_hora,
(select criticidad_id from Criticidad where descripcion=@criticidad_desc)

END

GO
/****** Object:  StoredProcedure [dbo].[bit_ListarBitacoraPorID]    Script Date: 06/11/2015 23:20:02 ******/
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
      ,[criticidad_fk]
FROM [farmacia].[dbo].[Bitacora] 
WHERE [bitacora_id] =  @bitacora_id  
end
GO
/****** Object:  StoredProcedure [dbo].[bit_ListarBitacoraPorParametros]    Script Date: 06/11/2015 23:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[bit_ListarBitacoraPorParametros]
@usuario_id as int,
@fecha_desde as datetime,
@fecha_hasta as datetime,
@criticidad as integer
AS
begin
SELECT 
 B.bitacora_id,
 B.usuario_fk,
 U.nombre_usuario,
 B.descripcion,
 B.fecha_hora,
 C.criticidad_id,
 C.descripcion as nivel
FROM [farmacia].[dbo].[Bitacora] AS B
INNER JOIN Usuario AS U ON B.usuario_fk = U.usuario_id
INNER JOIN Criticidad AS C ON B.criticidad_fk = C.criticidad_id
WHERE (B.usuario_fk =  @usuario_id or  @usuario_id = 0)
and  (B.fecha_hora >= @fecha_desde and fecha_hora <= @fecha_hasta)
and C.criticidad_id = @criticidad
end
GO
/****** Object:  StoredProcedure [dbo].[cli_EliminarCliente]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[cli_InsertarCliente]    Script Date: 06/11/2015 23:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cli_InsertarCliente]
	@dni as integer,
	@apellido as nvarchar(80),
	@nombre as nvarchar(80),
	@email as nvarchar(100),
	@telefono as nvarchar(50),
    @direccion as nvarchar(255),
    @localidad_fk as integer,
    @provincia_fk as integer
AS
begin

INSERT INTO [dbo].[Cliente]
           ([direccion]
           ,[nombre]
           ,[apellido]
           ,[telefono]
           ,[fecha_alta]
           ,eliminado
           ,[dni]
           ,[email]
           ,[dvh]
           ,[localidad_fk]
           ,[provincia_fk])
     VALUES
           (
		    @direccion
		   ,@nombre
		   ,@apellido
		   ,@telefono
		   ,GETDATE()
		   ,0
		   ,@dni
		   ,@email
		   ,0
		   ,@localidad_fk
		   ,@provincia_fk
		   )
		   

end
GO
/****** Object:  StoredProcedure [dbo].[cli_ModificarCliente]    Script Date: 06/11/2015 23:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[cli_ModificarCliente]
	@cliente_id as int,
	@apellido as nvarchar(80),
	@nombre as nvarchar(80),
    @telefono as nvarchar(50),
	@email as nvarchar(100),
    @direccion as nvarchar(255),
	@localidad_fk as int,
	@provincia_fk as int

AS
begin
UPDATE [dbo].Cliente
   SET apellido = @apellido
	  ,nombre = @nombre
      ,telefono = @telefono
	  ,email = @email
      ,direccion = @direccion
	  ,localidad_fk = @localidad_fk
	  ,provincia_fk = @provincia_fk
 WHERE 
		cliente_id = @cliente_id
end
GO
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientes]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientesPorID]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[cli_VerificarExistencia]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[cri_ObtenerCriticidades]    Script Date: 06/11/2015 23:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[cri_ObtenerCriticidades]
AS
begin
SELECT *  FROM [farmacia].[dbo].Criticidad order by criticidad_id desc
end
GO
/****** Object:  StoredProcedure [dbo].[fam_EliminarFamilia]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_InsertarFamilia]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_ModificarFamilia]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_ObtenerFamilias]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_ObtenerFamiliasPorID]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_VerificarExistencia]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[idi_ObtenerIdiomas]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[idi_ObtenerTraduccion]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[lab_ObtenerLaboratorioPorID]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[lab_ObtenerLaboratorios]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[loc_ObtenerLocalidades]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[loc_ObtenerLocalidadPorID]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[med_EliminarMedicamento]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[med_InsertarMedicamento]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[med_ModificarMedicamento]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentos]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentosPorID]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[med_VerificarExistencia]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[pat_ObtenerPatentes]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[prov_ObtenerProvinciaPorID]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[prov_ObtenerProvincias]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarFamilia]    Script Date: 06/11/2015 23:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[sp_ValidarEliminarFamilia] 
	@familia_id AS Int
AS

Declare @patente_id int
Declare @result bit
Declare cur cursor For SELECT Patente.patente_id FROM farmacia.dbo.Patente /*  WHERE Patente.obligatoria = 1*/

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
				and up.negado = 0
				and u.bloqueado = 0
				and u.eliminado = 0
			) AND NOT EXISTS (
				select *
				from farmacia.dbo.Patente_Familia pf 
				inner join farmacia.dbo.Familia_Usuario fu 
				on fu.familia_id = pf.familia_id 
				inner join Usuario u
				on u.usuario_id = fu.usuario_id
				where pf.patente_id not in (
				select up.patente_id 
				from  farmacia.dbo.Usuario_Patente up 
				where up.usuario_id = fu.usuario_id
				and up.negado = 0
				)
				and (pf.patente_id = @patente_id and pf.familia_id != @familia_id)
				and u.bloqueado = 0
				and u.eliminado = 0
			) SET @result = 0
		FETCH NEXT FROM cur Into @patente_id
	END
CLOSE cur
DEALLOCATE cur

SELECT @result AS Valido







GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarFamiliaPatente]    Script Date: 06/11/2015 23:20:02 ******/
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
	where p.patente_id = @patente_id
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
	where pf.patente_id not in (
		select up.patente_id 
		from Usuario_Patente up 
		where up.usuario_id = fu.usuario_id
		and up.negado = 0
	)
	and pf.patente_id = @patente_id
	and pf.familia_id != @familia_id
	and u.bloqueado = 0
	and u.eliminado = 0
) SET @result = 0

SELECT @result AS Valido

GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarFamiliaUsuario]    Script Date: 06/11/2015 23:20:02 ******/
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
Declare cur cursor For SELECT Patente.patente_id FROM Patente  

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
			) AND NOT EXISTS (
				select *
				from Patente_Familia pf 
				inner join Familia_Usuario fu 
				on fu.familia_id = pf.familia_id
				inner join Usuario u
				on u.usuario_id = fu.usuario_id
				where pf.patente_id not in (
					select up.patente_id 
					from Usuario_Patente up 
					where up.usuario_id = fu.usuario_id
					and up.negado = 0
				)
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
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarUsuario]    Script Date: 06/11/2015 23:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[sp_ValidarEliminarUsuario] 
	@usuario_id AS Int
AS

Declare @patente_id int
Declare @result bit
Declare cur cursor For SELECT patente_id FROM Patente  

SET @result = 1
OPEN cur 
	FETCH NEXT FROM cur Into @patente_id
		While @@Fetch_Status = 0 Begin
			IF NOT EXISTS (
				select *
				from Usuario_Patente up 
				inner join Usuario u
				on u.usuario_id = up.usuario_id
				where (up.patente_id = @patente_id and up.usuario_id != @usuario_id)
				and up.negado = 0
				and u.bloqueado = 0
				and u.eliminado = 0
			) AND NOT EXISTS (
				select *
				from Patente_Familia pf 
				inner join Familia_Usuario fu 
				on fu.familia_id = pf.familia_id
				inner join Usuario u
				on u.usuario_id = fu.usuario_id
				where pf.patente_id not in (
										select up.patente_id 
										from Usuario_Patente up 
										where up.usuario_id = fu.usuario_id
								        and up.negado = 0
										)
				and (pf.patente_id = @patente_id and fu.usuario_id != @usuario_id)
				and u.bloqueado = 0
				and u.eliminado = 0
			) SET @result = 0
		FETCH NEXT FROM cur Into @patente_id
	END
CLOSE cur
DEALLOCATE cur

SELECT @result AS Valido


GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarUsuarioPatente]    Script Date: 06/11/2015 23:20:02 ******/
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
	where  p.patente_id = @patente_id
) AND NOT EXISTS (
	select *
	from Usuario_Patente up 
	inner join Usuario u
	on u.usuario_id = up.usuario_id
	where (up.patente_id= @patente_id and up.usuario_id != @usuario_id)
	and up.negado = 0
	and u.bloqueado = 0
	and u.eliminado = 0
) AND NOT EXISTS (
	select *
	from Patente_Familia pf 
	inner join Familia_Usuario fu 
	on fu.familia_id = pf.familia_id
	inner join Usuario u
	on u.usuario_id = fu.usuario_id
	where pf.patente_id not in (
		select up.patente_id 
		from Usuario_Patente up 
		where up.usuario_id = fu.usuario_id
		  and up.negado = 0
	)
	and pf.patente_id= @patente_id
	and u.bloqueado = 0
	and u.eliminado = 0
) SET @result = 0

SELECT @result AS Valido







GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarUsuarioPatenteNegacion]    Script Date: 06/11/2015 23:20:02 ******/
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
	where p.patente_id = @patente_id
) AND NOT EXISTS (
	select *
	from Usuario_Patente up 
	inner join Usuario u
	on u.usuario_id = up.usuario_id
	where up.negado = 0
	and (up.patente_id = @patente_id and up.usuario_id != @usuario_id)
	and u.bloqueado = 0
	and u.eliminado = 0
) AND NOT EXISTS (
	select *
	from Patente_Familia pf 
	inner join Familia_Usuario fu 
	on fu.familia_id = pf.familia_id
	inner join Usuario u
	on u.usuario_id = fu.usuario_id
	where pf.patente_id not in (
		select up.patente_id 
		from Usuario_Patente up 
		where up.usuario_id = fu.usuario_id
		and up.negado = 0
	)
	and (pf.patente_id = @patente_id and fu.usuario_id != @usuario_id)
	and u.bloqueado = 0
	and u.eliminado = 0
) SET @result = 0

SELECT @result AS Valido


GO
/****** Object:  StoredProcedure [dbo].[sp_VerificarPatente]    Script Date: 06/11/2015 23:20:02 ******/
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
	from farmacia.dbo.Usuario_Patente up 
	inner join Usuario u
	on u.usuario_id = up.usuario_id
	where up.negado = 0
	and up.patente_id = @patente_id
	and u.usuario_id = @usuario_id
) OR EXISTS (
	select *
	from Patente_Familia pf 
	inner join Familia_Usuario fu 
	on fu.familia_id = pf.familia_id
	inner join Usuario u
	on u.usuario_id = fu.usuario_id
	where pf.patente_id not in (
		select up.patente_id 
		from Usuario_Patente up 
		where up.usuario_id = fu.usuario_id
		and up.negado = 0
	)
	and pf.patente_id = @patente_id
	and u.usuario_id = @usuario_id
) SET @result = 1

SELECT @result AS Valido


GO
/****** Object:  StoredProcedure [dbo].[usu_BloquearDesbloquerUsuario]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_EliminarUsuario]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_InsertarUsuario]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_ModificarUsuario]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_ObtenerUsuarios]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_ObtenerUsuariosPorID]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_ValidarContraseña]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_VerificarExistencia]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  Table [dbo].[Bitacora]    Script Date: 06/11/2015 23:20:02 ******/
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
	[criticidad_fk] [int] NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Bitacora] PRIMARY KEY CLUSTERED 
(
	[bitacora_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 06/11/2015 23:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente](
	[cliente_id] [int] IDENTITY(1,1) NOT NULL,
	[dni] [int] NULL,
	[apellido] [nvarchar](80) NULL,
	[nombre] [nvarchar](80) NULL,
	[telefono] [nvarchar](50) NULL,
	[email] [nvarchar](100) NULL,
	[direccion] [nvarchar](255) NOT NULL,
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
/****** Object:  Table [dbo].[Criticidad]    Script Date: 06/11/2015 23:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Criticidad](
	[criticidad_id] [int] NOT NULL,
	[descripcion] [nvarchar](50) NULL,
 CONSTRAINT [PK_Criticidad] PRIMARY KEY CLUSTERED 
(
	[criticidad_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DVV]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  Table [dbo].[Familia]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  Table [dbo].[Familia_Usuario]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  Table [dbo].[Idioma]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  Table [dbo].[Laboratorio]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  Table [dbo].[Localidad]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  Table [dbo].[Medicamento]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  Table [dbo].[Patente]    Script Date: 06/11/2015 23:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patente](
	[patente_id] [int] NOT NULL,
	[nombre] [nvarchar](50) NULL,
 CONSTRAINT [PK_Patente] PRIMARY KEY CLUSTERED 
(
	[patente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Patente_Familia]    Script Date: 06/11/2015 23:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patente_Familia](
	[familia_id] [int] NOT NULL,
	[patente_id] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Provincia]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  Table [dbo].[Traduccion]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  Table [dbo].[Usuario_Patente]    Script Date: 06/11/2015 23:20:02 ******/
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
/****** Object:  Table [dbo].[Venta]    Script Date: 06/11/2015 23:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Venta](
	[venta_id] [int] NOT NULL,
	[cliente_fk] [int] NOT NULL,
	[medicamento_fk] [int] NULL,
	[fecha_venta] [date] NULL,
	[sin_receta] [bit] NULL,
	[eliminado] [bit] NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Venta] PRIMARY KEY CLUSTERED 
(
	[venta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Venta_Medicamento]    Script Date: 06/11/2015 23:20:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Venta_Medicamento](
	[venta_id] [int] NOT NULL,
	[medicamento_id] [int] NOT NULL,
	[cantidad_venta] [nvarchar](50) NULL,
	[precio_venta] [nvarchar](50) NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Venta_Medicamento] PRIMARY KEY CLUSTERED 
(
	[venta_id] ASC,
	[medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Bitacora] ON 

INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (325, 9, N'Cmo9YO7/eY/bZXLNNGaXDryiJ3qBlR5BxsHiBv3+mcU=', CAST(0x0000A54001275442 AS DateTime), 3, N'157870')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (326, 9, N'elPQ1X7abxgcTs65DGdEuRTevZwkX/iR0dQlw3auWGc=', CAST(0x0000A54001275AC5 AS DateTime), 3, N'162242')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (327, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54001278D23 AS DateTime), 1, N'68008')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (328, 9, N'ei8eB9akhdtYhJmiABriX+vkvBnIWkm92R5Di4O8mE8=', CAST(0x0000A540014AF25D AS DateTime), 3, N'155059')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (329, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A540014C149A AS DateTime), 1, N'67684')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (330, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A540014D9B8B AS DateTime), 1, N'67761')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (331, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5400151A529 AS DateTime), 1, N'68029')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (332, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A540015E139F AS DateTime), 1, N'67714')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (333, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5400160BCB0 AS DateTime), 1, N'67715')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (334, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A540016BD71E AS DateTime), 1, N'67623')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (335, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A540016C609A AS DateTime), 1, N'67997')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (336, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5400187D281 AS DateTime), 1, N'67978')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (337, 9, N'ei8eB9akhdtYhJmiABriX7Sp1vLDQrS6oRUOS/oLmN8=', CAST(0x0000A54100CE37CA AS DateTime), 3, N'157097')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (338, 9, N'ei8eB9akhdtYhJmiABriX4MjyuTJdYgUE6Ypq3Oy7DsqWA/8uJCaLJgKWGS9CIbB', CAST(0x0000A54100D5428B AS DateTime), 3, N'274483')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (339, 9, N'ZxazUccfHi0Z33z7k5iZkg==', CAST(0x0000A54100D5F65A AS DateTime), 3, N'72344')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (340, 9, N'r6FeZsbE5+kVrNk7wcGWLw==', CAST(0x0000A54100D5F912 AS DateTime), 3, N'72654')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (341, 9, N'ei8eB9akhdtYhJmiABriX0T/SvUKHxdnm32uJbw4+g8=', CAST(0x0000A54100D6613C AS DateTime), 3, N'156594')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (342, 9, N'ei8eB9akhdtYhJmiABriX8pX3u39ef+yM+PMrSG1N2o=', CAST(0x0000A54100EC85F0 AS DateTime), 3, N'154074')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (343, 9, N'ei8eB9akhdtYhJmiABriXw/h+nKFdITxw8uoAkSPP7A=', CAST(0x0000A54100ECFFD6 AS DateTime), 3, N'159386')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (344, 9, N'YQ9rhvkgxg4hOM1FdcCEZQ==', CAST(0x0000A54100ED5F51 AS DateTime), 3, N'71403')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (345, 9, N'aE+uqLW8SJ63WtQCNyt2Fg==', CAST(0x0000A54100ED624D AS DateTime), 3, N'70764')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (346, 9, N'5KSKJ0AetdSaUIghB+nECg==', CAST(0x0000A54100ED653B AS DateTime), 3, N'70877')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (347, 9, N'pOx8ZMAREQKIl3U/WmD0bg==', CAST(0x0000A54100ED689E AS DateTime), 3, N'69559')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (348, 9, N'ei8eB9akhdtYhJmiABriXw/h+nKFdITxw8uoAkSPP7A=', CAST(0x0000A54100EDB7B9 AS DateTime), 3, N'159260')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (349, 9, N'YQ9rhvkgxg4hOM1FdcCEZQ==', CAST(0x0000A54100EDC71A AS DateTime), 3, N'71553')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (350, 9, N'ei8eB9akhdtYhJmiABriXw/h+nKFdITxw8uoAkSPP7A=', CAST(0x0000A54100EF42A4 AS DateTime), 3, N'159316')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (351, 9, N'ei8eB9akhdtYhJmiABriX8E16X+GdCfLXS6Fj9My0oU=', CAST(0x0000A54100F03863 AS DateTime), 3, N'153584')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (352, 9, N'ei8eB9akhdtYhJmiABriXyCzjfV0GRNgBg0QE7HLusg=', CAST(0x0000A54100F08755 AS DateTime), 3, N'159964')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (353, 9, N'JA7GJJLj2j23Q3QaoNpDEw==', CAST(0x0000A54100F08A66 AS DateTime), 3, N'70388')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (354, 9, N'ei8eB9akhdtYhJmiABriXw/h+nKFdITxw8uoAkSPP7A=', CAST(0x0000A54100F0A50F AS DateTime), 3, N'159782')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (355, 9, N'YQ9rhvkgxg4hOM1FdcCEZQ==', CAST(0x0000A54100F0B1F8 AS DateTime), 3, N'71397')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (356, 9, N'ei8eB9akhdtYhJmiABriX/DvhMOI9+rMiQOyQRwcGg4=', CAST(0x0000A54100F1C5A9 AS DateTime), 3, N'158946')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (357, 9, N'MVdb5psLDtHAIrEJkSjDWAvLCGwFY3gfe0BWYIf2yLU=', CAST(0x0000A5410105BB05 AS DateTime), 3, N'156187')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (358, 9, N'MVdb5psLDtHAIrEJkSjDWAvLCGwFY3gfe0BWYIf2yLU=', CAST(0x0000A5410105CB3F AS DateTime), 3, N'156192')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (359, 9, N'MVdb5psLDtHAIrEJkSjDWAvLCGwFY3gfe0BWYIf2yLU=', CAST(0x0000A5410105D808 AS DateTime), 3, N'155724')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (360, 9, N'MVdb5psLDtHAIrEJkSjDWAvLCGwFY3gfe0BWYIf2yLU=', CAST(0x0000A5410105DE66 AS DateTime), 3, N'156101')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (361, 9, N'ei8eB9akhdtYhJmiABriX8mof741gBNZH9neh89l4bA=', CAST(0x0000A541010A443C AS DateTime), 3, N'155225')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (362, 9, N'UYahIg+g0WKndK4p/20+pg==', CAST(0x0000A541010A4BDC AS DateTime), 3, N'69126')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (363, 9, N'MVdb5psLDtHAIrEJkSjDWFCW2wkuEUIniuJCISjtOMk=', CAST(0x0000A541010A5161 AS DateTime), 3, N'161626')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (364, 9, N'MVdb5psLDtHAIrEJkSjDWAvLCGwFY3gfe0BWYIf2yLU=', CAST(0x0000A541010A5BF4 AS DateTime), 3, N'156442')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (365, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A541010A6B6D AS DateTime), 1, N'67104')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (366, 9, N'UYahIg+g0WKndK4p/20+pg==', CAST(0x0000A5410111C52C AS DateTime), 3, N'69322')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (367, 9, N'eAuF+/yWqQ5r1KZIWIxfgx4gt55JOx76fD1N0yv6EmE=', CAST(0x0000A54101162342 AS DateTime), 3, N'153331')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (368, 9, N'AguINniBEFNkqkZBzpMOOLhNP8+PnlUmw8inozXFN7Ck1Z92FgWWqvJgtFgqNpUl', CAST(0x0000A54101162518 AS DateTime), 3, N'288073')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (369, 9, N'VPKIonfX6HMAjouizTOhQwXmjWwsakHOJv81q11JM+tTc/mbtG+cOJWdZwsCj67f', CAST(0x0000A54101162746 AS DateTime), 3, N'281441')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (370, 9, N'uDkgXNw+7CHUFvWnn33LNa5/IcoOaEzOgDCk9HZjoW+V97RgHZ/xnLyQDG1R4irn', CAST(0x0000A54101162A05 AS DateTime), 3, N'274211')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (371, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54101164412 AS DateTime), 3, N'280286')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (372, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54101165A59 AS DateTime), 1, N'67822')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (373, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5410121FD1B AS DateTime), 1, N'68007')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (374, 9, N'ei8eB9akhdtYhJmiABriX1U1mpTO80fmJUkDejOcA50=', CAST(0x0000A54101232A42 AS DateTime), 3, N'155378')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (375, 9, N'ei8eB9akhdtYhJmiABriX3C7Frw5EGrsJUlN0hkKfAk=', CAST(0x0000A54101234A74 AS DateTime), 3, N'159528')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (376, 9, N'ei8eB9akhdtYhJmiABriX7Ypox6tDJtCqgSrkY/hrqzy2yyXze8DDoxSoJikzXie', CAST(0x0000A54101236CDC AS DateTime), 3, N'303547')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (377, 9, N'ei8eB9akhdtYhJmiABriX4ZMNz/oKbfJIaVPzv5WrQw=', CAST(0x0000A541012382B2 AS DateTime), 3, N'163286')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (378, 9, N'MVdb5psLDtHAIrEJkSjDWAz1ZbytAShihOSkyHizCG0=', CAST(0x0000A5410123B11D AS DateTime), 3, N'161377')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (379, 9, N'dJdNAQ9yg0JG6W70stf7JI1VMg/K9DvzKtwhP9gymOw=', CAST(0x0000A5410124C4F1 AS DateTime), 3, N'160558')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (380, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5410128D652 AS DateTime), 1, N'67551')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (381, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A541012EF75D AS DateTime), 1, N'67494')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (382, 9, N'LntEkJTXoA+LvkNo39N1BqyCdZggoEL5PMx1eNQsbr0=', CAST(0x0000A541012F48CC AS DateTime), 3, N'157930')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (383, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Xgggdr853CFT/IuGYBiF1sjN5A9A+lRT0vh+pKxJ3EQ==', CAST(0x0000A5410130CA3D AS DateTime), 3, N'446939')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (384, 9, N'LntEkJTXoA+LvkNo39N1BqyCdZggoEL5PMx1eNQsbr0=', CAST(0x0000A541013314C9 AS DateTime), 3, N'158122')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (385, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Xgggdr853CFT/IuGYBiF1sjN5A9A+lRT0vh+pKxJ3EQ==', CAST(0x0000A54101331B79 AS DateTime), 3, N'447170')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (386, 9, N'dJdNAQ9yg0JG6W70stf7JFTdbrt8vBjYPlKMJ9vZjAg=', CAST(0x0000A5430156A43C AS DateTime), 3, N'158456')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (387, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Xgggdr853CFT/IuGYBiF1e8u+tXT0h/86+M8v5+8W5g==', CAST(0x0000A5430156ADA3 AS DateTime), 3, N'434387')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (388, 9, N'dJdNAQ9yg0JG6W70stf7JMBNVuBJGDnWlP4886gWYrs=', CAST(0x0000A54400B4D086 AS DateTime), 3, N'154063')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (389, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54400BB8129 AS DateTime), 1, N'67236')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (390, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54400BCB56F AS DateTime), 1, N'67435')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (391, 9, N'LntEkJTXoA+LvkNo39N1BqKi3SBWH8jtO3uuGNa0GS4=', CAST(0x0000A54400C2944C AS DateTime), 3, N'151913')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (392, 9, N'LntEkJTXoA+LvkNo39N1BqKi3SBWH8jtO3uuGNa0GS4=', CAST(0x0000A54400C29E0E AS DateTime), 3, N'151848')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (393, 9, N'LntEkJTXoA+LvkNo39N1BqKi3SBWH8jtO3uuGNa0GS4=', CAST(0x0000A54400C2A9E3 AS DateTime), 3, N'151917')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (394, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54400C2C839 AS DateTime), 3, N'279711')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (395, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54400C2CF38 AS DateTime), 3, N'280236')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (396, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54400C2D5DE AS DateTime), 3, N'279977')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (397, 9, N'eAuF+/yWqQ5r1KZIWIxfg3xEv71WiclshT5NisYwrcc=', CAST(0x0000A54400C3119D AS DateTime), 3, N'164119')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (398, 9, N'eAuF+/yWqQ5r1KZIWIxfg7jpRbDdFn7u2JIOZAQsbfs=', CAST(0x0000A54400C31687 AS DateTime), 3, N'159384')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (399, 9, N'AguINniBEFNkqkZBzpMOOIXb1hQ5H+1N98Pu+RE7jZg4wNJJ7GDHOn3PPGcOPYay', CAST(0x0000A54400C319FD AS DateTime), 3, N'266445')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (400, 9, N'AguINniBEFNkqkZBzpMOOCB0q6uEbnnNHfHo+Q4foN7fAUmprvekW+Kz65ceiNGj', CAST(0x0000A54400C31BF3 AS DateTime), 3, N'282797')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (401, 9, N'VPKIonfX6HMAjouizTOhQwMM9zF2qP3zspK+wiFk1y6xcSNSXLFTvmfu3tWJGJcz', CAST(0x0000A54400C31E7F AS DateTime), 3, N'288399')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (402, 9, N'VPKIonfX6HMAjouizTOhQyg6edMTHSlVF5g3SOGAFG0PUUkVj0h4bczpseuyaCv7', CAST(0x0000A54400C31FFF AS DateTime), 3, N'285089')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (403, 9, N'uDkgXNw+7CHUFvWnn33LNTb6jYMlx2Xv49YSn72ZQNU=', CAST(0x0000A54400C323CB AS DateTime), 3, N'153366')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (404, 9, N'eAuF+/yWqQ5r1KZIWIxfg7jpRbDdFn7u2JIOZAQsbfs=', CAST(0x0000A54400C326B8 AS DateTime), 3, N'159085')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (405, 9, N'uDkgXNw+7CHUFvWnn33LNbl1Z+kzalQMA9XZOziykRvL+Hm3Fiv276r6N6f1hyNs', CAST(0x0000A54400C32A65 AS DateTime), 3, N'276410')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (406, 9, N'uDkgXNw+7CHUFvWnn33LNTb6jYMlx2Xv49YSn72ZQNU=', CAST(0x0000A54400C32D4E AS DateTime), 3, N'153374')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (407, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54400C36F2C AS DateTime), 1, N'67395')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (408, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54400D42CD1 AS DateTime), 3, N'279454')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (409, 9, N'LntEkJTXoA+LvkNo39N1Bm/kZjJEADJ1BLDVbu77CGI=', CAST(0x0000A54400D44349 AS DateTime), 3, N'148147')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (410, 9, N'LntEkJTXoA+LvkNo39N1Bm/kZjJEADJ1BLDVbu77CGI=', CAST(0x0000A54400D4FD4A AS DateTime), 3, N'148115')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (411, 9, N'LntEkJTXoA+LvkNo39N1BqKi3SBWH8jtO3uuGNa0GS4=', CAST(0x0000A54400D50641 AS DateTime), 3, N'151829')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (412, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54400D51CC8 AS DateTime), 3, N'280297')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (413, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54400D8C4F4 AS DateTime), 3, N'279784')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (414, 9, N'eAuF+/yWqQ5r1KZIWIxfg7jpRbDdFn7u2JIOZAQsbfs=', CAST(0x0000A54400F0D6CE AS DateTime), 3, N'159727')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (415, 9, N'uDkgXNw+7CHUFvWnn33LNTb6jYMlx2Xv49YSn72ZQNU=', CAST(0x0000A54400F0ED9B AS DateTime), 3, N'153344')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (416, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54400F637D8 AS DateTime), 3, N'280471')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (417, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54400F64F0E AS DateTime), 3, N'280559')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (418, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54400FD13EC AS DateTime), 1, N'67483')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (419, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54400FE3EA1 AS DateTime), 3, N'279791')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (420, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54400FF3EE9 AS DateTime), 3, N'280627')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (421, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54400FF4CEF AS DateTime), 3, N'280106')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (422, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54400FF5738 AS DateTime), 3, N'280108')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (423, 9, N'MVdb5psLDtHAIrEJkSjDWAz1ZbytAShihOSkyHizCG0=', CAST(0x0000A54401062026 AS DateTime), 3, N'161627')
GO
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (424, 9, N'MVdb5psLDtHAIrEJkSjDWAz1ZbytAShihOSkyHizCG0=', CAST(0x0000A5440106318A AS DateTime), 3, N'162031')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (425, 9, N'MVdb5psLDtHAIrEJkSjDWAz1ZbytAShihOSkyHizCG0=', CAST(0x0000A54401084717 AS DateTime), 3, N'161185')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (426, 9, N'LntEkJTXoA+LvkNo39N1Bm/kZjJEADJ1BLDVbu77CGI=', CAST(0x0000A54401086C3C AS DateTime), 3, N'147736')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (427, 9, N'EF6F2XrSOnodgtoPjFDhJQ==', CAST(0x0000A544010A4D6E AS DateTime), 3, N'73060')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (428, 9, N'FlExZGaAQFd44+HvGWP5+g==', CAST(0x0000A544010A550D AS DateTime), 3, N'68352')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (429, 9, N'TG0Cs2oJGWLGje/AXqqigA==', CAST(0x0000A544010A57C0 AS DateTime), 3, N'71930')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (430, 9, N'hhIw8ixnaZj96I8HJbCj8A==', CAST(0x0000A544010A5A6A AS DateTime), 3, N'70134')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (431, 9, N'LntEkJTXoA+LvkNo39N1Bm/kZjJEADJ1BLDVbu77CGI=', CAST(0x0000A544010A7F51 AS DateTime), 3, N'147661')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (432, 9, N'eAuF+/yWqQ5r1KZIWIxfg7jpRbDdFn7u2JIOZAQsbfs=', CAST(0x0000A544010A8D4E AS DateTime), 3, N'159608')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (433, 9, N'eAuF+/yWqQ5r1KZIWIxfg3xEv71WiclshT5NisYwrcc=', CAST(0x0000A544010A90C4 AS DateTime), 3, N'164214')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (434, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A544010AB211 AS DateTime), 1, N'67146')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (435, 9, N'uDkgXNw+7CHUFvWnn33LNbl1Z+kzalQMA9XZOziykRvL+Hm3Fiv276r6N6f1hyNs', CAST(0x0000A544010CBBBF AS DateTime), 3, N'277162')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (436, 9, N'uDkgXNw+7CHUFvWnn33LNTb6jYMlx2Xv49YSn72ZQNU=', CAST(0x0000A544010CBF41 AS DateTime), 3, N'153946')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (437, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A544010CD073 AS DateTime), 3, N'280300')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (438, 9, N'LntEkJTXoA+LvkNo39N1Bm/kZjJEADJ1BLDVbu77CGI=', CAST(0x0000A544010CDD2D AS DateTime), 3, N'148257')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (439, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A544010CED0D AS DateTime), 3, N'280394')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (440, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A544010F9041 AS DateTime), 3, N'280364')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (441, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A544010FCD53 AS DateTime), 3, N'280626')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (442, 9, N'LntEkJTXoA+LvkNo39N1BqKi3SBWH8jtO3uuGNa0GS4=', CAST(0x0000A544010FDB29 AS DateTime), 3, N'152349')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (443, 9, N'LntEkJTXoA+LvkNo39N1Bm/kZjJEADJ1BLDVbu77CGI=', CAST(0x0000A544010FE8A7 AS DateTime), 3, N'148706')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (444, 9, N'ei8eB9akhdtYhJmiABriX1U1mpTO80fmJUkDejOcA50=', CAST(0x0000A5440110780C AS DateTime), 3, N'155115')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (445, 9, N'ei8eB9akhdtYhJmiABriX4ZMNz/oKbfJIaVPzv5WrQw=', CAST(0x0000A5440110AC3E AS DateTime), 3, N'163688')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (446, 9, N'elPQ1X7abxgcTs65DGdEufQhmJmD6PyYeoEcsBNtjcQ=', CAST(0x0000A54401115FC3 AS DateTime), 3, N'163624')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (447, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5440111B382 AS DateTime), 1, N'67601')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (448, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A544011576FE AS DateTime), 1, N'67475')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (449, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54401165114 AS DateTime), 1, N'67892')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (450, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5440117AA7D AS DateTime), 1, N'67805')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (451, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5440119A272 AS DateTime), 1, N'67595')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (452, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A544011DA940 AS DateTime), 1, N'67325')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (453, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A544011DBD08 AS DateTime), 1, N'67279')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (454, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54401219A82 AS DateTime), 1, N'67689')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (455, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A5440122A558 AS DateTime), 3, N'478839')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (456, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A544012798D2 AS DateTime), 1, N'67823')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (457, 9, N'LntEkJTXoA+LvkNo39N1Bm/kZjJEADJ1BLDVbu77CGI=', CAST(0x0000A544015A5596 AS DateTime), 3, N'147639')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (458, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A544015D46A0 AS DateTime), 1, N'67181')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (459, 9, N'dJdNAQ9yg0JG6W70stf7JI1VMg/K9DvzKtwhP9gymOw=', CAST(0x0000A5440168113F AS DateTime), 3, N'160065')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (460, 9, N'LntEkJTXoA+LvkNo39N1BqyCdZggoEL5PMx1eNQsbr0=', CAST(0x0000A544016BFB8F AS DateTime), 3, N'157559')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (461, 9, N'LntEkJTXoA+LvkNo39N1BqyCdZggoEL5PMx1eNQsbr0=', CAST(0x0000A544016C0818 AS DateTime), 3, N'157628')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (462, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A544016C0C67 AS DateTime), 1, N'67576')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (463, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A544016E4ED7 AS DateTime), 1, N'67344')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (464, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A544016FB33E AS DateTime), 1, N'67755')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (465, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54500BBB909 AS DateTime), 1, N'67579')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (466, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54500BBF711 AS DateTime), 1, N'67297')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (467, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54500BC151C AS DateTime), 1, N'67674')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (468, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54500BC7428 AS DateTime), 1, N'67628')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (469, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54500C13A6F AS DateTime), 1, N'67394')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (470, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54500C5ADF4 AS DateTime), 1, N'67816')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (471, 9, N'hhIw8ixnaZj96I8HJbCj8A==', CAST(0x0000A54500C709FC AS DateTime), 3, N'69556')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (472, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54500C70E45 AS DateTime), 1, N'67475')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (473, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54500C88A37 AS DateTime), 1, N'67349')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (474, 9, N'gxQsG58SSu/UxdVieObSCKrYy3ARzG7LT5tbppYMQQ0=', CAST(0x0000A54500C9F7B5 AS DateTime), 3, N'157110')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (475, 9, N'MksSqEmD0o2z6Eobk1rVAKiF43fwkFCUZX8T9snWlMM=', CAST(0x0000A54500CA1EDA AS DateTime), 3, N'156866')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (476, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54500CAEA4A AS DateTime), 1, N'67847')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (477, 9, N'AguINniBEFNkqkZBzpMOOMww+/IMCwy/5fhLgkiuC9Y=', CAST(0x0000A54500CB5FF6 AS DateTime), 3, N'159336')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (478, 9, N'AguINniBEFNkqkZBzpMOOIXb1hQ5H+1N98Pu+RE7jZg4wNJJ7GDHOn3PPGcOPYay', CAST(0x0000A54500CB6721 AS DateTime), 3, N'266775')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (479, 9, N'AguINniBEFNkqkZBzpMOOIXb1hQ5H+1N98Pu+RE7jZg4wNJJ7GDHOn3PPGcOPYay', CAST(0x0000A54500CB6D33 AS DateTime), 3, N'267213')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (480, 9, N'eAuF+/yWqQ5r1KZIWIxfg7jpRbDdFn7u2JIOZAQsbfs=', CAST(0x0000A54500CB71D6 AS DateTime), 3, N'159211')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (481, 9, N'elPQ1X7abxgcTs65DGdEuVAvuCqGfD90Y3YxNHsNdHg=', CAST(0x0000A54500CB7924 AS DateTime), 3, N'157556')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (482, 9, N'gxQsG58SSu/UxdVieObSCC14wLJSj//AdMphtwd1OXk=', CAST(0x0000A54500CB7C84 AS DateTime), 3, N'157457')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (483, 9, N'eAuF+/yWqQ5r1KZIWIxfgy2LYW84U7l6AnWSxuIYBHA=', CAST(0x0000A54500CBEF7D AS DateTime), 3, N'153839')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (484, 9, N'eAuF+/yWqQ5r1KZIWIxfgy2LYW84U7l6AnWSxuIYBHA=', CAST(0x0000A54500CD24EF AS DateTime), 3, N'154498')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (485, 9, N'uDkgXNw+7CHUFvWnn33LNZbgvhI7dECTfkvjau/IQfs=', CAST(0x0000A54500CD3288 AS DateTime), 3, N'161534')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (486, 9, N'eAuF+/yWqQ5r1KZIWIxfg7jpRbDdFn7u2JIOZAQsbfs=', CAST(0x0000A54500CD4529 AS DateTime), 3, N'159411')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (487, 9, N'eAuF+/yWqQ5r1KZIWIxfgy2LYW84U7l6AnWSxuIYBHA=', CAST(0x0000A54500CD5061 AS DateTime), 3, N'154238')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (488, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54500CD6AE7 AS DateTime), 1, N'67759')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (489, 9, N'AguINniBEFNkqkZBzpMOOIXb1hQ5H+1N98Pu+RE7jZg4wNJJ7GDHOn3PPGcOPYay', CAST(0x0000A54500CDC6FA AS DateTime), 3, N'267190')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (490, 9, N'AguINniBEFNkqkZBzpMOOMww+/IMCwy/5fhLgkiuC9Y=', CAST(0x0000A54500CDC9BC AS DateTime), 3, N'159695')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (491, 9, N'VPKIonfX6HMAjouizTOhQwMM9zF2qP3zspK+wiFk1y6xcSNSXLFTvmfu3tWJGJcz', CAST(0x0000A54500CE2627 AS DateTime), 3, N'288401')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (492, 9, N'VPKIonfX6HMAjouizTOhQ7wReevzF/6QniDMEwa57t8g51p0CfqrafSYiVvIciZ7', CAST(0x0000A54500CE2846 AS DateTime), 3, N'283913')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (493, 9, N'LntEkJTXoA+LvkNo39N1BqyCdZggoEL5PMx1eNQsbr0=', CAST(0x0000A54500CE3F69 AS DateTime), 3, N'157831')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (494, 9, N'uDkgXNw+7CHUFvWnn33LNZbgvhI7dECTfkvjau/IQfs=', CAST(0x0000A54500CE5215 AS DateTime), 3, N'160943')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (495, 9, N'uDkgXNw+7CHUFvWnn33LNTb6jYMlx2Xv49YSn72ZQNU=', CAST(0x0000A54500CE5BA5 AS DateTime), 3, N'153440')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (496, 9, N'LntEkJTXoA+LvkNo39N1Bm/kZjJEADJ1BLDVbu77CGI=', CAST(0x0000A54500CEC369 AS DateTime), 3, N'148013')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (497, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54500CF3A4A AS DateTime), 1, N'67766')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (498, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54500FCF356 AS DateTime), 1, N'67717')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (499, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A545010008A8 AS DateTime), 1, N'67385')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (500, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5450102DB44 AS DateTime), 1, N'67759')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (501, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A545010F7E9F AS DateTime), 1, N'67981')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (502, 9, N'AguINniBEFNkqkZBzpMOOIXb1hQ5H+1N98Pu+RE7jZg4wNJJ7GDHOn3PPGcOPYay', CAST(0x0000A5450110021B AS DateTime), 3, N'266804')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (503, 9, N'eAuF+/yWqQ5r1KZIWIxfg7jpRbDdFn7u2JIOZAQsbfs=', CAST(0x0000A54501101366 AS DateTime), 3, N'159580')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (504, 9, N'uDkgXNw+7CHUFvWnn33LNTb6jYMlx2Xv49YSn72ZQNU=', CAST(0x0000A54501102570 AS DateTime), 3, N'153328')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (505, 9, N'eAuF+/yWqQ5r1KZIWIxfg7jpRbDdFn7u2JIOZAQsbfs=', CAST(0x0000A54501108D86 AS DateTime), 3, N'159313')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (506, 9, N'uDkgXNw+7CHUFvWnn33LNTb6jYMlx2Xv49YSn72ZQNU=', CAST(0x0000A54501109284 AS DateTime), 3, N'153465')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (507, 9, N'VPKIonfX6HMAjouizTOhQwMM9zF2qP3zspK+wiFk1y6xcSNSXLFTvmfu3tWJGJcz', CAST(0x0000A54501109A78 AS DateTime), 3, N'288720')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (508, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Xgggdr853CFT/IuGYBiF1sjN5A9A+lRT0vh+pKxJ3EQ==', CAST(0x0000A54501145869 AS DateTime), 3, N'446946')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (509, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54501146DAB AS DateTime), 1, N'67909')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (510, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5450117589C AS DateTime), 1, N'67785')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (511, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5450117B76E AS DateTime), 1, N'67971')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (512, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A5450118408C AS DateTime), 3, N'279419')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (513, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54501185961 AS DateTime), 1, N'67449')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (514, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A545011CFA4E AS DateTime), 1, N'67804')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (515, 9, N'F4JiVkdNDsixHwk7QMPR1lkZrDLuHJz3Vhz7MmttPfhpYs+5rEpHwP2aX0WPoc9z', CAST(0x0000A545011D6522 AS DateTime), 3, N'287290')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (516, 9, N'UYahIg+g0WKndK4p/20+pg==', CAST(0x0000A545011E05C5 AS DateTime), 3, N'68848')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (517, 9, N'UYahIg+g0WKndK4p/20+pg==', CAST(0x0000A545011E0A1D AS DateTime), 3, N'69039')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (518, 9, N'UYahIg+g0WKndK4p/20+pg==', CAST(0x0000A545011E160E AS DateTime), 3, N'69088')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (519, 9, N'MksSqEmD0o2z6Eobk1rVAKiF43fwkFCUZX8T9snWlMM=', CAST(0x0000A545011E3AD0 AS DateTime), 3, N'156981')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (520, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Xgggdr853CFT/IuGYBiF1sjN5A9A+lRT0vh+pKxJ3EQ==', CAST(0x0000A545011FD68C AS DateTime), 3, N'447586')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (521, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A545012056CE AS DateTime), 1, N'68162')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (522, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54501277DD4 AS DateTime), 3, N'280427')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (523, 9, N'dJdNAQ9yg0JG6W70stf7JF9oqO1ZD3eM5iDP1hWw0G4=', CAST(0x0000A5450127CB61 AS DateTime), 3, N'149540')
GO
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (524, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A545016B7F55 AS DateTime), 1, N'67517')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (525, 9, N'uDkgXNw+7CHUFvWnn33LNdLDwkEB7UVLY2q4zj+n254=', CAST(0x0000A545016E7F05 AS DateTime), 3, N'150068')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (526, 9, N'AguINniBEFNkqkZBzpMOOOVRNH4urTZ9qaWNlTPKMHhkEJLuRtPKqmvnOtkvuMgl', CAST(0x0000A545016E8589 AS DateTime), 3, N'297280')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (527, 9, N'VPKIonfX6HMAjouizTOhQ7wReevzF/6QniDMEwa57t+18q0AwSjMzRBoQx2i1Jmb', CAST(0x0000A545016E8F3F AS DateTime), 3, N'279180')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (528, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Xgggdr853CFT/IuGYBiF16SWxxmI6an7vu2PqSZ9QIg==', CAST(0x0000A545016E9C80 AS DateTime), 3, N'460258')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (529, 9, N'AguINniBEFNkqkZBzpMOOOVRNH4urTZ9qaWNlTPKMHhkEJLuRtPKqmvnOtkvuMgl', CAST(0x0000A54501716197 AS DateTime), 3, N'297195')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (530, 9, N'eAuF+/yWqQ5r1KZIWIxfg6O2hzN+fw7D+jI/tVQ+DoQ=', CAST(0x0000A54501716A5D AS DateTime), 3, N'151991')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (531, 9, N'uDkgXNw+7CHUFvWnn33LNdLDwkEB7UVLY2q4zj+n254=', CAST(0x0000A54501716F26 AS DateTime), 3, N'150187')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (532, 9, N'eAuF+/yWqQ5r1KZIWIxfg7jpRbDdFn7u2JIOZAQsbfs=', CAST(0x0000A54501717B66 AS DateTime), 3, N'159457')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (533, 9, N'uDkgXNw+7CHUFvWnn33LNTb6jYMlx2Xv49YSn72ZQNU=', CAST(0x0000A545017180D3 AS DateTime), 3, N'153676')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (534, 9, N'LntEkJTXoA+LvkNo39N1Bu26MEcgCBDjK3EdlYI/jTo=', CAST(0x0000A54501719253 AS DateTime), 3, N'152649')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (535, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A54501719CF8 AS DateTime), 3, N'478519')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (536, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A5450171A1BB AS DateTime), 3, N'478966')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (537, 9, N'dJdNAQ9yg0JG6W70stf7JBRH56pE7D3ixM7F7uPlEG0=', CAST(0x0000A5450171C2C3 AS DateTime), 3, N'147671')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (538, 9, N'gxQsG58SSu/UxdVieObSCKrYy3ARzG7LT5tbppYMQQ0=', CAST(0x0000A5450171FAD5 AS DateTime), 3, N'157435')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (539, 9, N'elPQ1X7abxgcTs65DGdEuVAvuCqGfD90Y3YxNHsNdHg=', CAST(0x0000A54501720880 AS DateTime), 3, N'157546')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (540, 9, N'Y8egU4o66/wzYk4FPETZ+6VWZZ24ARrUlDe5eFMW9JM=', CAST(0x0000A545017219B6 AS DateTime), 3, N'150176')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (541, 9, N'Cmo9YO7/eY/bZXLNNGaXDklmgvWhfd3z5S0NIR8weLY=', CAST(0x0000A5450172478B AS DateTime), 3, N'158005')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (542, 9, N'F4JiVkdNDsixHwk7QMPR1lkZrDLuHJz3Vhz7MmttPfhpYs+5rEpHwP2aX0WPoc9z', CAST(0x0000A54501725714 AS DateTime), 3, N'286872')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (543, 9, N'MksSqEmD0o2z6Eobk1rVAKiF43fwkFCUZX8T9snWlMM=', CAST(0x0000A54501726636 AS DateTime), 3, N'157105')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (544, 9, N'FE2HCjTfVzdKVO8ngxErfRP0ccM3LX1SOT+ya6w7ab0=', CAST(0x0000A5450172716B AS DateTime), 3, N'154271')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (545, 9, N'cgoGwnWuzttKXvag9Z5Uz14wkDIo7QGvzFTHpZ5k/YY=', CAST(0x0000A54501728733 AS DateTime), 3, N'159414')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (546, 9, N'92xR8E9lVFvZ+l193m52qLcRpEHJ/KDzbnv6Q+vsx8Q=', CAST(0x0000A5450172DF8A AS DateTime), 2, N'155050')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (547, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5450172EECD AS DateTime), 1, N'67291')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (548, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54501750569 AS DateTime), 1, N'67790')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (549, 9, N'gxQsG58SSu/UxdVieObSCC8OieOTa3wnbnWV8ZZcRxM=', CAST(0x0000A54501762389 AS DateTime), 3, N'160683')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (550, 9, N'elPQ1X7abxgcTs65DGdEucfUg8kCmxwpW9ZQ5eqkr3Q=', CAST(0x0000A54501762803 AS DateTime), 3, N'161878')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (551, 9, N'Y8egU4o66/wzYk4FPETZ+3picDjwOu/DNX5LyFdhm7A=', CAST(0x0000A54501763AE2 AS DateTime), 3, N'154978')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (552, 9, N'gxQsG58SSu/UxdVieObSCFCqaKmgCxfK1ABtJVtAYeI=', CAST(0x0000A545017E9EC3 AS DateTime), 3, N'158392')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (553, 9, N'Y8egU4o66/wzYk4FPETZ++m1ppDsuC0jVxVgQgBOuTM=', CAST(0x0000A545017EACE0 AS DateTime), 3, N'157935')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (554, 9, N'Cmo9YO7/eY/bZXLNNGaXDoNJvqgKMYqKGAl5AA90xKM=', CAST(0x0000A545017EC708 AS DateTime), 3, N'152849')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (555, 9, N'F4JiVkdNDsixHwk7QMPR1lkZrDLuHJz3Vhz7MmttPfhpYs+5rEpHwP2aX0WPoc9z', CAST(0x0000A545017ED94D AS DateTime), 3, N'286893')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (556, 9, N'MksSqEmD0o2z6Eobk1rVAMuEGJEa7idGLy6Q5NiKxGo=', CAST(0x0000A545017EDC25 AS DateTime), 3, N'157053')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (557, 9, N'FE2HCjTfVzdKVO8ngxErfQp6GoI3v7POprAr72Sw1P4=', CAST(0x0000A545017EE2F5 AS DateTime), 3, N'154778')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (558, 9, N'cgoGwnWuzttKXvag9Z5UzxccDuOfv++YW4/thbyISzk=', CAST(0x0000A545017EF104 AS DateTime), 3, N'164549')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (559, 0, N'uFAIrnFQ4ZJ5jF/k6mSuBzZPnnpEEhD1KTsBjSv9DfY=', CAST(0x0000A54800C31931 AS DateTime), 2, N'158144')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (560, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB/6SkV+rJFHJv2UEUsV+dXN4FznIyO52h+Bs4ul6PHtT', CAST(0x0000A54800C47C53 AS DateTime), 2, N'269916')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (561, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB0+IEzV0reD6+0OseL4YpNc=', CAST(0x0000A54800C49B7B AS DateTime), 2, N'151928')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (562, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB0+IEzV0reD6+0OseL4YpNc=', CAST(0x0000A54800C4BDDD AS DateTime), 2, N'151730')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (563, 0, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54800C5BFAA AS DateTime), 1, N'158524')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (564, 0, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54800C77ED8 AS DateTime), 1, N'157347')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (565, 0, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54800C8B26C AS DateTime), 1, N'157295')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (566, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB7YquB0Vgsl6mfJ/N3/AqPU=', CAST(0x0000A54800D467F3 AS DateTime), 2, N'152742')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (567, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB/6SkV+rJFHJv2UEUsV+dXN4FznIyO52h+Bs4ul6PHtT', CAST(0x0000A54800DE322C AS DateTime), 2, N'270969')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (568, 0, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54800DF08A0 AS DateTime), 1, N'157355')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (569, 0, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54800DF4C20 AS DateTime), 1, N'157288')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (570, 0, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54800E349C2 AS DateTime), 1, N'157847')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (571, 0, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54800E37687 AS DateTime), 1, N'157715')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (572, 0, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54800E759EE AS DateTime), 1, N'157746')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (573, 0, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54800E7F7FB AS DateTime), 1, N'157674')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (574, 0, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54800E895AB AS DateTime), 1, N'158139')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (575, 0, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54800E8E608 AS DateTime), 1, N'67940')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (576, 0, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54800E99A46 AS DateTime), 1, N'157289')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (577, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB/6SkV+rJFHJv2UEUsV+dXN4FznIyO52h+Bs4ul6PHtT', CAST(0x0000A54800EA5870 AS DateTime), 2, N'269683')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (578, 0, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54800EAB9E8 AS DateTime), 1, N'157886')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (579, 0, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54800EB4A59 AS DateTime), 1, N'158218')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (580, 0, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54800EBBEDE AS DateTime), 1, N'67924')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (581, 0, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54800EF611E AS DateTime), 1, N'67515')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (582, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB4ddbViUBA2bvrM+WCYeAVyMyst1BvDruV5Tufr03b/s', CAST(0x0000A548010D4EA4 AS DateTime), 2, N'281043')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (583, 9, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A548010D8BB9 AS DateTime), 1, N'157635')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (584, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A548010DBA31 AS DateTime), 3, N'478249')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (585, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A548010DC478 AS DateTime), 3, N'478251')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (586, 9, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A548011188F2 AS DateTime), 1, N'158228')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (587, 9, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A5480113C4C2 AS DateTime), 1, N'157766')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (588, 9, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54801150429 AS DateTime), 1, N'158424')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (589, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A548011C2A1B AS DateTime), 3, N'280517')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (590, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A548011C3A69 AS DateTime), 3, N'280142')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (591, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A548011C432D AS DateTime), 3, N'280841')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (592, 9, N'LntEkJTXoA+LvkNo39N1Bm/kZjJEADJ1BLDVbu77CGI=', CAST(0x0000A548011FC830 AS DateTime), 3, N'148580')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (593, 9, N'LntEkJTXoA+LvkNo39N1Bm/kZjJEADJ1BLDVbu77CGI=', CAST(0x0000A548011FCFBF AS DateTime), 3, N'148448')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (594, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54801202CB3 AS DateTime), 1, N'67855')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (595, 9, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54801276F19 AS DateTime), 1, N'158550')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (596, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A548012920C7 AS DateTime), 3, N'479251')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (597, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A5480129267B AS DateTime), 3, N'280170')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (598, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkn55y/NUNUdNiuIocko1nUA==', CAST(0x0000A548012BE0E9 AS DateTime), 3, N'474923')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (599, 9, N'LntEkJTXoA+LvkNo39N1BilLXRXuscBweUk7mawK1PA=', CAST(0x0000A548012BE4B1 AS DateTime), 3, N'159213')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (600, 9, N'dJdNAQ9yg0JG6W70stf7JG2d4Je6nFW3FPZuBaE1LHo=', CAST(0x0000A548012C2143 AS DateTime), 3, N'150285')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (601, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Xgggdr853CFT/IuGYBiF1we9RCYc7cD19hMBf2eIbOA==', CAST(0x0000A548012C6EAA AS DateTime), 3, N'446565')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (602, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A548012CC4A1 AS DateTime), 1, N'67655')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (603, 9, N'aNFbVUl7nwV4DOarIFlxJ3Hpcdq28kmVGJTR6aq0AebPn/VJ6bNaWJlSn3z40mVLQfWWaBE89F8flnjWxvC9VA==', CAST(0x0000A548012D7B7E AS DateTime), 2, N'458435')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (604, 9, N'aNFbVUl7nwV4DOarIFlxJ3Hpcdq28kmVGJTR6aq0AebPn/VJ6bNaWJlSn3z40mVLQfWWaBE89F8flnjWxvC9VA==', CAST(0x0000A548012E0185 AS DateTime), 2, N'458099')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (605, 9, N'Np5vvxChZlscSbmF18dAM3EmddiMOphmOcJRDtnZWFh+M0+yINmo1V15rdg7wkhS', CAST(0x0000A548012EA0CE AS DateTime), 2, N'280732')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (606, 9, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A548012FE605 AS DateTime), 1, N'158339')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (607, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A548013027C8 AS DateTime), 3, N'479324')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (608, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54801303FF5 AS DateTime), 3, N'280827')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (609, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A548013073F9 AS DateTime), 3, N'479993')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (610, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A5480130B511 AS DateTime), 3, N'280801')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (611, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A54801314908 AS DateTime), 3, N'478544')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (612, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A54801314CEB AS DateTime), 3, N'478880')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (613, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54801315BFD AS DateTime), 3, N'280567')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (614, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A54801318766 AS DateTime), 3, N'478884')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (615, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54801320ABC AS DateTime), 3, N'280480')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (616, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A54801337EF3 AS DateTime), 3, N'479756')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (617, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A548013593D7 AS DateTime), 3, N'479875')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (618, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54801361D62 AS DateTime), 3, N'280906')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (619, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A5480137BD69 AS DateTime), 3, N'478884')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (620, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54801382325 AS DateTime), 3, N'281061')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (621, 9, N'aNFbVUl7nwV4DOarIFlxJ3Hpcdq28kmVGJTR6aq0AebPn/VJ6bNaWJlSn3z40mVLQfWWaBE89F8flnjWxvC9VA==', CAST(0x0000A5480139E3CB AS DateTime), 2, N'457112')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (622, 9, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A548013A024E AS DateTime), 1, N'157941')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (623, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A548013ABCD4 AS DateTime), 3, N'479543')
GO
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (624, 9, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A548013BB5CF AS DateTime), 1, N'158464')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (625, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A548013C4641 AS DateTime), 3, N'478560')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (626, 9, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54801417F7A AS DateTime), 1, N'157814')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (627, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A5480141E1C2 AS DateTime), 3, N'479555')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (628, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A548014234FF AS DateTime), 3, N'280576')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (629, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A5480142681D AS DateTime), 3, N'280400')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (630, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A54801427803 AS DateTime), 3, N'479088')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (631, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54801431565 AS DateTime), 3, N'280982')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (632, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54801432D3D AS DateTime), 3, N'281244')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (633, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A5480143440E AS DateTime), 3, N'281332')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (634, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54801434ABE AS DateTime), 3, N'280641')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (635, 9, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54801459C06 AS DateTime), 1, N'158062')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (636, 9, N'VPKIonfX6HMAjouizTOhQ7wReevzF/6QniDMEwa57t8g51p0CfqrafSYiVvIciZ7', CAST(0x0000A5480145B087 AS DateTime), 3, N'285455')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (637, 9, N'LntEkJTXoA+LvkNo39N1BqyCdZggoEL5PMx1eNQsbr0=', CAST(0x0000A5480145BEF8 AS DateTime), 3, N'158192')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (638, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A5480145D382 AS DateTime), 3, N'280999')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (639, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkX0jvnKMZe+Rzqj8kn6sMgQ==', CAST(0x0000A5480145F148 AS DateTime), 3, N'479767')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (640, 9, N'LntEkJTXoA+LvkNo39N1BnLet1Asr24wkFRDG6XAQKER79IBguJBQfwctRcegqtL', CAST(0x0000A54801460AED AS DateTime), 3, N'280801')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (641, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54801467211 AS DateTime), 1, N'68100')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (642, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB/6SkV+rJFHJv2UEUsV+dXN4FznIyO52h+Bs4ul6PHtT', CAST(0x0000A54801709F5C AS DateTime), 2, N'269755')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (643, 9, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A5480170B493 AS DateTime), 1, N'157575')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (644, 9, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54801715687 AS DateTime), 1, N'157771')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (645, 9, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A54801731BE3 AS DateTime), 1, N'157783')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (646, 9, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A5480173C9D2 AS DateTime), 1, N'158045')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (647, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5480174223A AS DateTime), 1, N'67744')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (648, 9, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A5480174D222 AS DateTime), 1, N'157906')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (649, 9, N'Wq8/zx6olyomtPFJc4rbbkimi251wcX8+mr8fCtjI98=', CAST(0x0000A548017EFFD3 AS DateTime), 1, N'157920')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad_fk], [dvh]) VALUES (650, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A548017F97F7 AS DateTime), 1, N'67864')
SET IDENTITY_INSERT [dbo].[Bitacora] OFF
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (4, 33333332, N'settino', N'German', N'4635-1267', N'german.settino@gmail.com', N'manuel artigas 5391', 6, 24, CAST(0x813A0B00 AS Date), 1, N'375730')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (5, 33633265, N'Settino', N'German', N'4651235', N'German.settino@gmail.com', N'manuel artigas 5555', 25, 1, CAST(0x813A0B00 AS Date), 0, N'367680')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (8, 21312312, N'landgrabe', N'charly', N'44444444444', N'german.settin@ada.com', N'manuel artigas 5391', 6, 24, CAST(0x983A0B00 AS Date), 0, N'386852')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (9, 33333333, N'german', N'settino', N'1111111111', N'gemerna@gmail.com', N'asdasd', 6, 24, CAST(0x9B3A0B00 AS Date), 0, N'247649')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (10, 32423242, N'asdasd', N'asdasd', N'123123123', N'qweqwe@sdasd', N'asdasd', 6, 24, CAST(0xA03A0B00 AS Date), 0, N'209528')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (11, 123123, N'zxz<x', N'asasd', N'1231231', N'adasdasd@asda', N'asdasd', 6, 24, CAST(0xA03A0B00 AS Date), 0, N'181405')
SET IDENTITY_INSERT [dbo].[Cliente] OFF
INSERT [dbo].[Criticidad] ([criticidad_id], [descripcion]) VALUES (1, N'Baja')
INSERT [dbo].[Criticidad] ([criticidad_id], [descripcion]) VALUES (2, N'Media')
INSERT [dbo].[Criticidad] ([criticidad_id], [descripcion]) VALUES (3, N'Alta')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (1, N'Bitacora            ', N'61506620')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (2, N'Usuario             ', N'3248323')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (3, N'Familia             ', N'72415')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (4, N'Venta               ', N'0')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (5, N'Venta_Medicamento   ', N'0')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (6, N'Medicamento         ', N'843269')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (7, N'Cliente             ', N'1768844')
SET IDENTITY_INSERT [dbo].[Familia] ON 

INSERT [dbo].[Familia] ([familia_id], [nombre], [descripcion], [dvh]) VALUES (58, N'UYahIg+g0WKndK4p/20+pg==', N'administrador', N'72415')
SET IDENTITY_INSERT [dbo].[Familia] OFF
INSERT [dbo].[Familia_Usuario] ([familia_id], [usuario_id]) VALUES (58, 9)
INSERT [dbo].[Familia_Usuario] ([familia_id], [usuario_id]) VALUES (58, 24)
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
INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (11, N'armonil', 10, N'+xvtVhnD3ZpIQxi2DYTavg==', N'l+7GAbE2aEWExP3+uHcD9Q==', 0, 0, N'203538')
INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (12, N'adasdasd', 2, N'YSITDcKLEgcfV+qFz8klnQ==', N'JZNPADvBBdzwzN55xhQHUA==', 1, 1, N'201578')
INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (13, N'aSDASD', 6, N'/0aaXecs5IQP+EbkTUrEPg==', N'foC1PgHNtIUQbPnpiNnbzw==', 0, 0, N'206103')
SET IDENTITY_INSERT [dbo].[Medicamento] OFF
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (1, N'Usuario')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (2, N'Familia')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (3, N'Backup')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (4, N'Restore')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (5, N'RecalcularDV')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (6, N'Venta')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (7, N'Cliente')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (8, N'Medicamento')
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (58, 1)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (58, 2)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (58, 3)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (58, 4)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (58, 5)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (58, 6)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (58, 7)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (58, 8)
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
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (75, 2, N'¿Esta seguro que desea Activar el usuario', N'
Are you sure you want to enable user')
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
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (96, 2, N'No se puede quitar la patente al usuario porque la patente quedaria sin asignacion', N'
You can not remove the patent to the user because the patent would be unallocated')
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
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (113, 2, N'Modificar Medicamento', N'
Modify Medicines')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (114, 2, N'Se Registro el Medicamento', N'
Medication recorded')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (115, 2, N'Registrar Medicamento', N'Register Medicines')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (116, 2, N'Todos los Usuarios', N'All Users')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (117, 2, N'...', N'...')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (118, 2, N'¿Esta seguro que desea salir?', N'
Are you sure you want to quit?')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (119, 2, N'Sus permisos han sido modificados, por favor inicie sesion nuevamente', N'Sus permisos han sido modificados, por favor inicie sesion nuevamente')
SET IDENTITY_INSERT [dbo].[Traduccion] OFF
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (9, N'55Tf7iNfPHQGbFWsx6oGmw==', N'9b17da47b1bd0bc0266250f6bbefeff7', N'administrador2', N'administrador2', N'administrador@administrador.com', N'33633265', 0, 0, 0, N'844171')
INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (20, N'dSBT0iYkSaOdxr99Gabljw==', N'9cba1f3898022c8986334c12ddcf1fb0', N'adasdas', N'adasdas', N'asdas@adad', N'34223423', 0, 0, 0, N'211934')
INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (21, N'iCZgwg0Xe+WPHWfhsSvx1A==', N'9cba1f3898022c8986334c12ddcf1fb0', N'vvvvvvvvvvv', N'vvvvvvvvv', N'srfsf@sdfsd', N'555555', 0, 0, 0, N'516581')
INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (22, N'YQ9rhvkgxg4hOM1FdcCEZQ==', N'9cba1f3898022c8986334c12ddcf1fb0', N'german', N'german', N'germansettino@gmail.com', N'33333333', 0, 0, 0, N'549097')
INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (23, N'2VKOh2ckW6fkqEZz792xSw==', N'9cba1f3898022c8986334c12ddcf1fb0', N'asd', N'geran', N'asdasd@asdasd', N'23434234', 0, 0, 0, N'403339')
INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (24, N'KhLMi5qCTO7j+8D9RaEVKg==', N'9cba1f3898022c8986334c12ddcf1fb0', N'asdasdasd', N'asdsada', N'asdasdas@aasd', N'12312312', 0, 0, 0, N'242316')
INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (25, N'2DkBre2h36uIbk1Wc36+EQ==', N'14714d0c0676d7fe7bfa4a6aa3379839', N'gabriel', N'gabriel', N'gasdasdas@asdasd', N'33333333', 0, 0, 0, N'480885')
SET IDENTITY_INSERT [dbo].[Usuario] OFF
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (1, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (1, 21, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (2, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (2, 21, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (3, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (3, 23, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (4, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (7, 20, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (7, 22, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (8, 20, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (8, 22, 0)
/****** Object:  Index [UQ_Bitacora_bitacora_id]    Script Date: 06/11/2015 23:20:02 ******/
ALTER TABLE [dbo].[Bitacora] ADD  CONSTRAINT [UQ_Bitacora_bitacora_id] UNIQUE NONCLUSTERED 
(
	[bitacora_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Cliente_cliente_id]    Script Date: 06/11/2015 23:20:02 ******/
ALTER TABLE [dbo].[Cliente] ADD  CONSTRAINT [UQ_Cliente_cliente_id] UNIQUE NONCLUSTERED 
(
	[cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Criticidad_criticidad_id]    Script Date: 06/11/2015 23:20:02 ******/
ALTER TABLE [dbo].[Criticidad] ADD  CONSTRAINT [UQ_Criticidad_criticidad_id] UNIQUE NONCLUSTERED 
(
	[criticidad_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_DVV_tabla_id]    Script Date: 06/11/2015 23:20:02 ******/
ALTER TABLE [dbo].[DVV] ADD  CONSTRAINT [UQ_DVV_tabla_id] UNIQUE NONCLUSTERED 
(
	[tabla_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Familia_familia_id]    Script Date: 06/11/2015 23:20:02 ******/
ALTER TABLE [dbo].[Familia] ADD  CONSTRAINT [UQ_Familia_familia_id] UNIQUE NONCLUSTERED 
(
	[familia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Idioma_idioma_id]    Script Date: 06/11/2015 23:20:02 ******/
ALTER TABLE [dbo].[Idioma] ADD  CONSTRAINT [UQ_Idioma_idioma_id] UNIQUE NONCLUSTERED 
(
	[idioma_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Laboratorio_laboratorio_id]    Script Date: 06/11/2015 23:20:02 ******/
ALTER TABLE [dbo].[Laboratorio] ADD  CONSTRAINT [UQ_Laboratorio_laboratorio_id] UNIQUE NONCLUSTERED 
(
	[laboratorio_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Localidad_localidad_id]    Script Date: 06/11/2015 23:20:02 ******/
ALTER TABLE [dbo].[Localidad] ADD  CONSTRAINT [UQ_Localidad_localidad_id] UNIQUE NONCLUSTERED 
(
	[localidad_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Medicamento_medicamento_id]    Script Date: 06/11/2015 23:20:02 ******/
ALTER TABLE [dbo].[Medicamento] ADD  CONSTRAINT [UQ_Medicamento_medicamento_id] UNIQUE NONCLUSTERED 
(
	[medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Patente_patente_id]    Script Date: 06/11/2015 23:20:02 ******/
ALTER TABLE [dbo].[Patente] ADD  CONSTRAINT [UQ_Patente_patente_id] UNIQUE NONCLUSTERED 
(
	[patente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Provincia_provincia_id]    Script Date: 06/11/2015 23:20:02 ******/
ALTER TABLE [dbo].[Provincia] ADD  CONSTRAINT [UQ_Provincia_provincia_id] UNIQUE NONCLUSTERED 
(
	[provincia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Usuario_usuario_id]    Script Date: 06/11/2015 23:20:02 ******/
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [UQ_Usuario_usuario_id] UNIQUE NONCLUSTERED 
(
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Venta_venta_id]    Script Date: 06/11/2015 23:20:02 ******/
ALTER TABLE [dbo].[Venta] ADD  CONSTRAINT [UQ_Venta_venta_id] UNIQUE NONCLUSTERED 
(
	[venta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Venta_Medicamento_medicamento_id]    Script Date: 06/11/2015 23:20:02 ******/
ALTER TABLE [dbo].[Venta_Medicamento] ADD  CONSTRAINT [UQ_Venta_Medicamento_medicamento_id] UNIQUE NONCLUSTERED 
(
	[medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Venta_Medicamento_venta_id]    Script Date: 06/11/2015 23:20:02 ******/
ALTER TABLE [dbo].[Venta_Medicamento] ADD  CONSTRAINT [UQ_Venta_Medicamento_venta_id] UNIQUE NONCLUSTERED 
(
	[venta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [farmacia] SET  READ_WRITE 
GO
