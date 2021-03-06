USE [master]
GO
/****** Object:  Database [farmacia]    Script Date: 02/11/2015 17:57:46 ******/
CREATE DATABASE [farmacia]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'farmacia', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\farmacia.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
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
/****** Object:  StoredProcedure [dbo].[bit_InsertarBitacora]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[bit_ListarBitacoraPorID]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[bit_ListarBitacoraPorParametros]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[cli_EliminarCliente]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[cli_InsertarCliente]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[cli_ModificarCliente]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientes]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientesPorID]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[cli_VerificarExistencia]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[cri_ObtenerCriticidades]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_EliminarFamilia]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_InsertarFamilia]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_ModificarFamilia]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_ObtenerFamilias]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_ObtenerFamiliasPorID]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_VerificarExistencia]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[idi_ObtenerIdiomas]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[idi_ObtenerTraduccion]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[lab_ObtenerLaboratorioPorID]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[lab_ObtenerLaboratorios]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[loc_ObtenerLocalidades]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[loc_ObtenerLocalidadPorID]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[med_EliminarMedicamento]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[med_InsertarMedicamento]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[med_ModificarMedicamento]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentos]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentosPorID]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[med_VerificarExistencia]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[pat_ObtenerPatentes]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[prov_ObtenerProvinciaPorID]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[prov_ObtenerProvincias]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarFamilia]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarFamiliaPatente]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarFamiliaUsuario]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarUsuario]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarUsuarioPatente]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarUsuarioPatenteNegacion]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_VerificarPatente]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_BloquearDesbloquerUsuario]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_EliminarUsuario]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_InsertarUsuario]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_ModificarUsuario]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_ObtenerUsuarios]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_ObtenerUsuariosPorID]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_ValidarContraseña]    Script Date: 02/11/2015 17:57:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usu_ValidarContraseña]
	@nombre_usuario as nvarchar(50),
	@contraseña as nvarchar(50)
AS
BEGIN

	select * from Usuario u
	where u.nombre_usuario = @nombre_usuario and u.contraseña = @contraseña
END

GO
/****** Object:  StoredProcedure [dbo].[usu_VerificarExistencia]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  Table [dbo].[Bitacora]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  Table [dbo].[Cliente]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  Table [dbo].[Criticidad]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  Table [dbo].[DVV]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  Table [dbo].[Familia]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  Table [dbo].[Familia_Usuario]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  Table [dbo].[Idioma]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  Table [dbo].[Laboratorio]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  Table [dbo].[Localidad]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  Table [dbo].[Medicamento]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  Table [dbo].[Patente]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  Table [dbo].[Patente_Familia]    Script Date: 02/11/2015 17:57:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patente_Familia](
	[familia_id] [int] NOT NULL,
	[patente_id] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Provincia]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  Table [dbo].[Traduccion]    Script Date: 02/11/2015 17:57:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Traduccion](
	[traduccion_id] [int] IDENTITY(1,1) NOT NULL,
	[idioma_fk] [int] NOT NULL,
	[texto] [nvarchar](256) NULL,
	[traduccion] [nvarchar](256) NULL,
 CONSTRAINT [PK_Traduccion] PRIMARY KEY CLUSTERED 
(
	[traduccion_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  Table [dbo].[Usuario_Patente]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  Table [dbo].[Venta]    Script Date: 02/11/2015 17:57:46 ******/
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
/****** Object:  Table [dbo].[Venta_Medicamento]    Script Date: 02/11/2015 17:57:46 ******/
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
SET IDENTITY_INSERT [dbo].[Bitacora] OFF
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (4, 33333332, N'settino', N'German', N'4635-1267', N'german.settino@gmail.com', N'manuel artigas 5391', 1, 1, CAST(0x813A0B00 AS Date), 0, N'377517')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (5, 33633265, N'Settino', N'German', N'4651235', N'German.settino@gmail.com', N'manuel artigas 5555', 25, 1, CAST(0x813A0B00 AS Date), 0, N'367680')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (8, 21312312, N'landgrabe', N'charly', N'44444444444', N'german.settin@ada.com', N'manuel artigas 5391', 6, 24, CAST(0x983A0B00 AS Date), 0, N'386852')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (9, 33333333, N'german', N'settino', N'1111111111', N'gemerna@gmail.com', N'asdasd', 6, 24, CAST(0x9B3A0B00 AS Date), 0, N'247649')
SET IDENTITY_INSERT [dbo].[Cliente] OFF
INSERT [dbo].[Criticidad] ([criticidad_id], [descripcion]) VALUES (1, N'Baja')
INSERT [dbo].[Criticidad] ([criticidad_id], [descripcion]) VALUES (2, N'Media')
INSERT [dbo].[Criticidad] ([criticidad_id], [descripcion]) VALUES (3, N'Alta')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (1, N'Bitacora            ', N'21553627')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (2, N'Usuario             ', N'977695')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (3, N'Familia             ', N'124624')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (4, N'Venta               ', N'0')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (5, N'Venta_Medicamento   ', N'0')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (6, N'Medicamento         ', N'435588')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (7, N'Cliente             ', N'1379698')
SET IDENTITY_INSERT [dbo].[Familia] ON 

INSERT [dbo].[Familia] ([familia_id], [nombre], [descripcion], [dvh]) VALUES (58, N'UYahIg+g0WKndK4p/20+pg==', N'administrador', N'72415')
INSERT [dbo].[Familia] ([familia_id], [nombre], [descripcion], [dvh]) VALUES (59, N'hhIw8ixnaZj96I8HJbCj8A==', N'Vendedor', N'52209')
SET IDENTITY_INSERT [dbo].[Familia] OFF
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
SET IDENTITY_INSERT [dbo].[Medicamento] OFF
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (1, N'Usuario')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (2, N'Familia')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (3, N'Backup')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (4, N'Restore')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (5, N'Recalcular_Digitos_Verificadores')
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
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (59, 6)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (59, 7)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (59, 8)
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

INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (4, 2, N'Usuario', N'User')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (5, 2, N'&Registrar', N'&New')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (6, 2, N'&Modificar', N'&Modify')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (7, 2, N'&Eliminar', N'&Delete')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (8, 2, N'&Contraseña', N'&Password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (9, 2, N'&Aceptar', N'&Accept')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (10, 2, N'&Cancelar', N'&Cancel')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (14, 2, N'&Activar', N'&Active')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (16, 2, N'&Salir', N'&Exit')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (17, 2, N'Acerca de Sistema de Gestion Farmacia', N'About Sistema de Gestion Farmacia')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (18, 2, N'Ayuda', N'Help')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (19, 2, N'Backup', N'Backup')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (21, 2, N'Restaurar', N'Restore')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (23, 2, N'Bloquear', N'Block')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (25, 2, N'Desbloquear', N'Unlock')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (27, 2, N'Nombre', N'Name')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (28, 2, N'Apellido', N'Lastname')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (29, 2, N'Telefono', N'Phone')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (30, 2, N'Patente', N'Role')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (31, 2, N'Patentes', N'Roles')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (32, 2, N'Familia', N'Family')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (33, 2, N'Familias', N'Families')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (34, 2, N'Patente', N'Role')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (35, 2, N'Patentes', N'Roles')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (36, 2, N'Patentes negacion', N'Denied roles')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (37, 2, N'Generar nuevo', N'Generate new')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (38, 2, N'Archivo', N'File')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (39, 2, N'Salir', N'Exit')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (40, 2, N'Informes', N'Reports')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (41, 2, N'Usuarios', N'Users')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (42, 2, N'Permisos', N'Permissions')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (43, 2, N'Bitacora', N'Log')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (44, 2, N'Idioma', N'Language')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (45, 2, N'Fecha desde', N'Date from')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (46, 2, N'Fecha hasta', N'Date to')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (47, 2, N'Limpiar', N'Clean')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (48, 2, N'Generar informe', N'Generate inform')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (49, 2, N'Id', N'Id')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (50, 2, N'Descripcion', N'Description')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (51, 2, N'Todos', N'All')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (52, 2, N'Español', N'Spanish')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (53, 2, N'Exportar informe', N'Export inform')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (54, 2, N'Fecha', N'Date')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (56, 2, N'Mensaje', N'Message')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (57, 2, N'Criticidad', N'Criticality')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (62, 2, N'Bitacora', N'Logs')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (70, 2, N'Ventas', N'Sales')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (71, 2, N'Medicamentos', N'Medicines')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (72, 2, N'Clientes', N'Customers')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (73, 2, N'Reporte Clientes Por Compra', N'Customers For Purchase Report')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (74, 2, N'Reporte Stock de Medicamentos', N'Stock Medicines Report')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (75, 2, N'Reporte Ventas Por Medicamentos', N'Sales Report On Medicines')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (76, 2, N'Sistema de Gestion Farmacia', N'Pharmacy Management System')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (77, 2, N'Seguridad', N'Security')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (80, 2, N'Error', N'Error')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (82, 2, N'Campo Requerido', N'Campo Requerido')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (84, 2, N'Ruta', N'Path')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (86, 2, N'Cantidad', N'Amount')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (88, 2, N'DNI', N'DNI')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (89, 2, N'E-Mail', N'E-Mail')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (91, 2, N'Direccion', N'Address')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (92, 2, N'Localidad', N'Location')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (93, 2, N'Provincia', N'Province')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (94, 2, N'Apellido y Nombre', N'Lastname and Name')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (95, 2, N'Ver la Ayuda', N'View Help')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (96, 2, N'&Restablecer Contraseña', N'&Reset Password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (97, 2, N'Laboratorio', N'Laboratory')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (99, 2, N'Precio', N'Price')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (100, 2, N'Receta', N'Prescription')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (101, 2, N'Fecha desde', N'Date from')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (102, 2, N'Fecha hasta', N'Date to')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (105, 2, N'&Buscar', N'&Search')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (106, 2, N'&Exportar', N'&Export')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (107, 2, N'&Limpiar', N'C&lean')
SET IDENTITY_INSERT [dbo].[Traduccion] OFF
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (9, N'55Tf7iNfPHQGbFWsx6oGmw==', N'ab5c3200a72501ed8a0dbcd74ad31f15', N'administrador2', N'administrador2', N'administrador@administrador.com', N'33633265', 0, 0, 0, N'500518')
INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (20, N'dSBT0iYkSaOdxr99Gabljw==', N'', N'adasdas', N'adasdas', N'asdas@adad', N'34223423', 0, 0, 0, N'211934')
INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (21, N'iCZgwg0Xe+WPHWfhsSvx1A==', N'', N'vvvvvvvvvvv', N'vvvvvvvvv', N'srfsf@sdfsd', N'555555', 0, 0, 0, N'265243')
SET IDENTITY_INSERT [dbo].[Usuario] OFF
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (1, 21, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (2, 21, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (3, 20, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (4, 20, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (5, 20, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (6, 20, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (7, 20, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (8, 20, 0)
/****** Object:  Index [UQ_Bitacora_bitacora_id]    Script Date: 02/11/2015 17:57:46 ******/
ALTER TABLE [dbo].[Bitacora] ADD  CONSTRAINT [UQ_Bitacora_bitacora_id] UNIQUE NONCLUSTERED 
(
	[bitacora_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Cliente_cliente_id]    Script Date: 02/11/2015 17:57:46 ******/
ALTER TABLE [dbo].[Cliente] ADD  CONSTRAINT [UQ_Cliente_cliente_id] UNIQUE NONCLUSTERED 
(
	[cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Criticidad_criticidad_id]    Script Date: 02/11/2015 17:57:46 ******/
ALTER TABLE [dbo].[Criticidad] ADD  CONSTRAINT [UQ_Criticidad_criticidad_id] UNIQUE NONCLUSTERED 
(
	[criticidad_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_DVV_tabla_id]    Script Date: 02/11/2015 17:57:46 ******/
ALTER TABLE [dbo].[DVV] ADD  CONSTRAINT [UQ_DVV_tabla_id] UNIQUE NONCLUSTERED 
(
	[tabla_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Familia_familia_id]    Script Date: 02/11/2015 17:57:46 ******/
ALTER TABLE [dbo].[Familia] ADD  CONSTRAINT [UQ_Familia_familia_id] UNIQUE NONCLUSTERED 
(
	[familia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Idioma_idioma_id]    Script Date: 02/11/2015 17:57:46 ******/
ALTER TABLE [dbo].[Idioma] ADD  CONSTRAINT [UQ_Idioma_idioma_id] UNIQUE NONCLUSTERED 
(
	[idioma_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Laboratorio_laboratorio_id]    Script Date: 02/11/2015 17:57:46 ******/
ALTER TABLE [dbo].[Laboratorio] ADD  CONSTRAINT [UQ_Laboratorio_laboratorio_id] UNIQUE NONCLUSTERED 
(
	[laboratorio_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Localidad_localidad_id]    Script Date: 02/11/2015 17:57:46 ******/
ALTER TABLE [dbo].[Localidad] ADD  CONSTRAINT [UQ_Localidad_localidad_id] UNIQUE NONCLUSTERED 
(
	[localidad_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Medicamento_medicamento_id]    Script Date: 02/11/2015 17:57:46 ******/
ALTER TABLE [dbo].[Medicamento] ADD  CONSTRAINT [UQ_Medicamento_medicamento_id] UNIQUE NONCLUSTERED 
(
	[medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Patente_patente_id]    Script Date: 02/11/2015 17:57:46 ******/
ALTER TABLE [dbo].[Patente] ADD  CONSTRAINT [UQ_Patente_patente_id] UNIQUE NONCLUSTERED 
(
	[patente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Provincia_provincia_id]    Script Date: 02/11/2015 17:57:46 ******/
ALTER TABLE [dbo].[Provincia] ADD  CONSTRAINT [UQ_Provincia_provincia_id] UNIQUE NONCLUSTERED 
(
	[provincia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Traduccion_idioma_fk]    Script Date: 02/11/2015 17:57:46 ******/
ALTER TABLE [dbo].[Traduccion] ADD  CONSTRAINT [UQ_Traduccion_idioma_fk] UNIQUE NONCLUSTERED 
(
	[idioma_fk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER INDEX [UQ_Traduccion_idioma_fk] ON [dbo].[Traduccion] DISABLE
GO
/****** Object:  Index [UQ_Usuario_usuario_id]    Script Date: 02/11/2015 17:57:46 ******/
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [UQ_Usuario_usuario_id] UNIQUE NONCLUSTERED 
(
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Venta_venta_id]    Script Date: 02/11/2015 17:57:46 ******/
ALTER TABLE [dbo].[Venta] ADD  CONSTRAINT [UQ_Venta_venta_id] UNIQUE NONCLUSTERED 
(
	[venta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Venta_Medicamento_medicamento_id]    Script Date: 02/11/2015 17:57:46 ******/
ALTER TABLE [dbo].[Venta_Medicamento] ADD  CONSTRAINT [UQ_Venta_Medicamento_medicamento_id] UNIQUE NONCLUSTERED 
(
	[medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Venta_Medicamento_venta_id]    Script Date: 02/11/2015 17:57:46 ******/
ALTER TABLE [dbo].[Venta_Medicamento] ADD  CONSTRAINT [UQ_Venta_Medicamento_venta_id] UNIQUE NONCLUSTERED 
(
	[venta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [farmacia] SET  READ_WRITE 
GO
