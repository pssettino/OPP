USE [master]
GO
/****** Object:  Database [farmacia]    Script Date: 10/11/2015 17:45:56 ******/
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
/****** Object:  StoredProcedure [dbo].[bit_InsertarBitacora]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[bit_ListarBitacoraPorID]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[bit_ListarBitacoraPorParametros]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[cli_EliminarCliente]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[cli_InsertarCliente]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[cli_ModificarCliente]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientes]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientesPorApellido_Nombre]    Script Date: 10/11/2015 17:45:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[cli_ObtenerClientesPorApellido_Nombre]
@Apellido_Nombre as nvarchar(255)
AS
begin
SELECT *  FROM [farmacia].[dbo].Cliente  
where apellido like '%' + @Apellido_Nombre + '%' or nombre like '%' + @Apellido_Nombre + '%' 
end
GO
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientesPorDNI]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientesPorID]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[cli_VerificarExistencia]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_EliminarFamilia]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_InsertarFamilia]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_ModificarFamilia]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_ObtenerFamilias]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_ObtenerFamiliasPorID]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_VerificarExistencia]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[idi_ObtenerIdiomas]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[idi_ObtenerTraduccion]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[lab_ObtenerLaboratorioPorID]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[lab_ObtenerLaboratorios]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[loc_ObtenerLocalidades]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[loc_ObtenerLocalidadPorID]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[med_EliminarMedicamento]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[med_InsertarMedicamento]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[med_ModificarMedicamento]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentos]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentosPorDescripcion]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentosPorID]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentosPorLaboratorio]    Script Date: 10/11/2015 17:45:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[med_ObtenerMedicamentosPorLaboratorio]
@laboratorio_id as int
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento as m inner join farmacia.dbo.Laboratorio as l on m.laboratorio_fk = l.laboratorio_id
  where laboratorio_id  = @laboratorio_id
end
GO
/****** Object:  StoredProcedure [dbo].[med_VerificarExistencia]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[pat_ObtenerPatentes]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[prov_ObtenerProvinciaPorID]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[prov_ObtenerProvincias]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarFamilia]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarFamiliaPatente]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarFamiliaUsuario]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarUsuario]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarUsuarioPatente]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarUsuarioPatenteNegacion]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_VerificarPatente]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_BloquearDesbloquerUsuario]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_EliminarUsuario]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_InsertarUsuario]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_ModificarUsuario]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_ObtenerUsuarios]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_ObtenerUsuariosPorID]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_ValidarContraseña]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_VerificarExistencia]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  Table [dbo].[Bitacora]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  Table [dbo].[Cliente]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  Table [dbo].[DVV]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  Table [dbo].[Familia]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  Table [dbo].[Familia_Usuario]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  Table [dbo].[Idioma]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  Table [dbo].[Laboratorio]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  Table [dbo].[Localidad]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  Table [dbo].[Medicamento]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  Table [dbo].[Patente]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  Table [dbo].[Patente_Familia]    Script Date: 10/11/2015 17:45:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patente_Familia](
	[familia_id] [int] NOT NULL,
	[patente_id] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Provincia]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  Table [dbo].[Traduccion]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  Table [dbo].[Usuario_Patente]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  Table [dbo].[Venta]    Script Date: 10/11/2015 17:45:57 ******/
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
/****** Object:  Table [dbo].[Venta_Medicamento]    Script Date: 10/11/2015 17:45:57 ******/
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

INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1108, 9, N'Hr0XOV5HjzngmrrJKPMGoWC/pvDRAUwrlth+yjyDAV0=', CAST(0x0000A54A015E2B53 AS DateTime), N'Baja', N'189423')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1109, 26, N'Wq8/zx6olyomtPFJc4rbbivwNLejuFvpcdVaJVKEpAU=', CAST(0x0000A54A015E3F8C AS DateTime), N'Baja', N'198976')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1127, 9, N'Hr0XOV5HjzngmrrJKPMGoWC/pvDRAUwrlth+yjyDAV0=', CAST(0x0000A54A017B871E AS DateTime), N'Baja', N'189495')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1128, 9, N'Wq8/zx6olyomtPFJc4rbbh+RdMvjhzEb3OZ+CWkoK4o=', CAST(0x0000A54A017BE9E1 AS DateTime), N'Baja', N'187704')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1129, 9, N'Hr0XOV5HjzngmrrJKPMGoWC/pvDRAUwrlth+yjyDAV0=', CAST(0x0000A54A017C0D56 AS DateTime), N'Baja', N'189225')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1130, 9, N'20PfjtwIALyGkJC7vyVHn1R9Rd5/9HLxl6h4snzQPCY=', CAST(0x0000A54A017C930D AS DateTime), N'Alta', N'185271')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1131, 9, N'38OnCwvDUpu7s8p0qqbdJZFHGiOXBcU+uxXIE9C6eyM=', CAST(0x0000A54A017CDCDC AS DateTime), N'Alta', N'185581')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1134, 9, N'7SEbSfqwAYy3awy9MA4zxLH4bhfLtJ4uzyaXpWr0IIc=', CAST(0x0000A54A017D7102 AS DateTime), N'Alta', N'192361')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1135, 9, N'Wq8/zx6olyomtPFJc4rbbh+RdMvjhzEb3OZ+CWkoK4o=', CAST(0x0000A54A017D7FED AS DateTime), N'Baja', N'188696')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1136, 9, N'Hr0XOV5HjzngmrrJKPMGoWC/pvDRAUwrlth+yjyDAV0=', CAST(0x0000A54A017D9735 AS DateTime), N'Baja', N'189813')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1137, 9, N'Wq8/zx6olyomtPFJc4rbbh+RdMvjhzEb3OZ+CWkoK4o=', CAST(0x0000A54B00CCC73F AS DateTime), N'Baja', N'188091')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1138, 9, N'Hr0XOV5HjzngmrrJKPMGoWC/pvDRAUwrlth+yjyDAV0=', CAST(0x0000A54B00CCCE05 AS DateTime), N'Baja', N'189206')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1139, 9, N'Wq8/zx6olyomtPFJc4rbbh+RdMvjhzEb3OZ+CWkoK4o=', CAST(0x0000A54B00CD1E32 AS DateTime), N'Baja', N'188503')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1140, 9, N'Hr0XOV5HjzngmrrJKPMGoWC/pvDRAUwrlth+yjyDAV0=', CAST(0x0000A54B00D20C37 AS DateTime), N'Baja', N'189580')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1141, 9, N'Wq8/zx6olyomtPFJc4rbbh+RdMvjhzEb3OZ+CWkoK4o=', CAST(0x0000A54B0128744D AS DateTime), N'Baja', N'188561')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1142, 9, N'elPQ1X7abxgcTs65DGdEufQhmJmD6PyYeoEcsBNtjcQ=', CAST(0x0000A54B01288EA7 AS DateTime), N'Alta', N'193117')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1143, 9, N'elPQ1X7abxgcTs65DGdEuRTevZwkX/iR0dQlw3auWGc=', CAST(0x0000A54B012891E8 AS DateTime), N'Alta', N'191805')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1144, 9, N'Hr0XOV5HjzngmrrJKPMGoWC/pvDRAUwrlth+yjyDAV0=', CAST(0x0000A54B0128D6DD AS DateTime), N'Baja', N'189452')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1145, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B013BF893 AS DateTime), N'Baja', N'89621')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1146, 9, N'UYahIg+g0WKndK4p/20+pg==', CAST(0x0000A54B013CD3CD AS DateTime), N'Alta', N'89346')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1147, 9, N'UYahIg+g0WKndK4p/20+pg==', CAST(0x0000A54B013CD5EC AS DateTime), N'Alta', N'89446')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1148, 9, N'AguINniBEFNkqkZBzpMOOBkdekUhsXsev8lMyac2/ps=', CAST(0x0000A54B013D6268 AS DateTime), N'Alta', N'195820')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1149, 9, N'VPKIonfX6HMAjouizTOhQwBtYykvP9kSP1c63L6c29MW9GIfjM3EtlM/8ZXeFKin', CAST(0x0000A54B013D67CA AS DateTime), N'Alta', N'311618')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1150, 9, N'MVdb5psLDtHAIrEJkSjDWAvLCGwFY3gfe0BWYIf2yLU=', CAST(0x0000A54B013D75EF AS DateTime), N'Alta', N'185085')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1151, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54B013E4017 AS DateTime), N'Baja', N'87266')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1152, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B014025F3 AS DateTime), N'Baja', N'90072')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1153, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54B014039E5 AS DateTime), N'Baja', N'87326')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1154, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B0140555A AS DateTime), N'Baja', N'90031')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1155, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54B0140646F AS DateTime), N'Baja', N'87093')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1156, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B0140C1D5 AS DateTime), N'Baja', N'89936')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1157, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B0141B298 AS DateTime), N'Baja', N'89766')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1158, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B01472A98 AS DateTime), N'Baja', N'89618')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1159, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B01476B5B AS DateTime), N'Baja', N'89860')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1160, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B014814FA AS DateTime), N'Baja', N'89818')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1161, 9, N'LntEkJTXoA+LvkNo39N1Bt+qU8uKs1sWWZLx0L4HLPw=', CAST(0x0000A54B0148345B AS DateTime), N'Alta', N'184388')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1162, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Xgggdr853CFT/IuGYBiF1jIPniI0x+Km4dH4xBDIMAQ==', CAST(0x0000A54B01484E33 AS DateTime), N'Alta', N'495783')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1163, 9, N'LntEkJTXoA+LvkNo39N1Bt+qU8uKs1sWWZLx0L4HLPw=', CAST(0x0000A54B014855A9 AS DateTime), N'Alta', N'184124')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1164, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54B014858E7 AS DateTime), N'Baja', N'87516')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1165, 26, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B01487B52 AS DateTime), N'Baja', N'93924')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1166, 26, N'eAuF+/yWqQ5r1KZIWIxfgx4gt55JOx76fD1N0yv6EmE=', CAST(0x0000A54B01489110 AS DateTime), N'Alta', N'188200')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1167, 26, N'UYahIg+g0WKndK4p/20+pg==', CAST(0x0000A54B0148A1CC AS DateTime), N'Alta', N'93132')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1168, 26, N'ei8eB9akhdtYhJmiABriX1U1mpTO80fmJUkDejOcA50=', CAST(0x0000A54B01492360 AS DateTime), N'Alta', N'190472')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1169, 26, N'LntEkJTXoA+LvkNo39N1Bt+qU8uKs1sWWZLx0L4HLPw=', CAST(0x0000A54B0149586D AS DateTime), N'Alta', N'189642')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1170, 26, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54B0149EB4C AS DateTime), N'Baja', N'89788')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1171, 26, N'PNM6/fGO4jai0qC/OnkP7Kl+l9TYerYNKLTT7IgMQYyPW0e2E8FaK117vmKOkGLP', CAST(0x0000A54B014BF276 AS DateTime), N'Media', N'318649')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1172, 26, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B014C04A0 AS DateTime), N'Baja', N'93140')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1173, 26, N'i5se1CE0t28zXe54qgf7IfRLdzbf4lAoNAdzWp78+jNMYzc6LSf6IU08QqwGwnG1', CAST(0x0000A54B014C198D AS DateTime), N'Alta', N'319624')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1174, 26, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B014DCB61 AS DateTime), N'Baja', N'93255')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1175, 26, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54B01504EE4 AS DateTime), N'Baja', N'90378')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1176, 26, N'PNM6/fGO4jai0qC/OnkP7Kl+l9TYerYNKLTT7IgMQYyPW0e2E8FaK117vmKOkGLP', CAST(0x0000A54B01525DB5 AS DateTime), N'Media', N'318765')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1177, 26, N'PNM6/fGO4jai0qC/OnkP7Kl+l9TYerYNKLTT7IgMQYyPW0e2E8FaK117vmKOkGLP', CAST(0x0000A54B015261B8 AS DateTime), N'Media', N'317792')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1178, 26, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Xgggdr853CFT/IuGYBiF1jIPniI0x+Km4dH4xBDIMAQ==', CAST(0x0000A54B01526587 AS DateTime), N'Alta', N'502557')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1179, 26, N'PNM6/fGO4jai0qC/OnkP7Kl+l9TYerYNKLTT7IgMQYyPW0e2E8FaK117vmKOkGLP', CAST(0x0000A54B015269BA AS DateTime), N'Media', N'318423')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1180, 26, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B01527E39 AS DateTime), N'Baja', N'93046')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1181, 26, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54B0158FAAE AS DateTime), N'Baja', N'90202')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1182, 26, N'PNM6/fGO4jai0qC/OnkP7Kl+l9TYerYNKLTT7IgMQYyPW0e2E8FaK117vmKOkGLP', CAST(0x0000A54B015C0681 AS DateTime), N'Media', N'318656')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1183, 26, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B015CB133 AS DateTime), N'Baja', N'93238')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1184, 26, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54B015CBB3D AS DateTime), N'Baja', N'90362')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1185, 26, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B015D7561 AS DateTime), N'Baja', N'92823')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1186, 26, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54B015D7CE7 AS DateTime), N'Baja', N'90242')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1187, 26, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B01618578 AS DateTime), N'Baja', N'93353')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1188, 26, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B01622DE3 AS DateTime), N'Baja', N'93299')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1189, 26, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B0162B195 AS DateTime), N'Baja', N'93079')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1190, 26, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B0162B72C AS DateTime), N'Baja', N'93242')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1191, 26, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54B0162C20C AS DateTime), N'Baja', N'90415')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1192, 26, N'PNM6/fGO4jai0qC/OnkP7Kl+l9TYerYNKLTT7IgMQYyPW0e2E8FaK117vmKOkGLP', CAST(0x0000A54B0162D541 AS DateTime), N'Media', N'318571')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1193, 26, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B01656D3F AS DateTime), N'Baja', N'92956')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1194, 26, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B01657303 AS DateTime), N'Baja', N'93156')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1195, 26, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54B01659664 AS DateTime), N'Baja', N'90474')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1196, 26, N'PNM6/fGO4jai0qC/OnkP7Kl+l9TYerYNKLTT7IgMQYyPW0e2E8FaK117vmKOkGLP', CAST(0x0000A54B0165A5FC AS DateTime), N'Media', N'318763')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1197, 26, N'PNM6/fGO4jai0qC/OnkP7Kl+l9TYerYNKLTT7IgMQYyPW0e2E8FaK117vmKOkGLP', CAST(0x0000A54B0165A9C5 AS DateTime), N'Media', N'318232')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1198, 26, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Xgggdr853CFT/IuGYBiF1jIPniI0x+Km4dH4xBDIMAQ==', CAST(0x0000A54B0165B2DB AS DateTime), N'Alta', N'502664')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1199, 26, N'PNM6/fGO4jai0qC/OnkP7Kl+l9TYerYNKLTT7IgMQYyPW0e2E8FaK117vmKOkGLP', CAST(0x0000A54B0165B546 AS DateTime), N'Media', N'318328')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1200, 26, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B01673DE9 AS DateTime), N'Baja', N'93633')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1201, 26, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A54B016743EF AS DateTime), N'Baja', N'93198')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1202, 26, N'gxQsG58SSu/UxdVieObSCM8G7cupt6tEnnGsOWPkrmw=', CAST(0x0000A54B01686715 AS DateTime), N'Alta', N'199858')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1203, 26, N'gxQsG58SSu/UxdVieObSCC8OieOTa3wnbnWV8ZZcRxM=', CAST(0x0000A54B01686B48 AS DateTime), N'Alta', N'195494')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1204, 26, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A54B01699964 AS DateTime), N'Baja', N'90428')
SET IDENTITY_INSERT [dbo].[Bitacora] OFF
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (4, 33333332, N'settino', N'German', N'4635-1267', N'german.settino@gmail.com', N'manuel artigas 5391', 6, 24, CAST(0x813A0B00 AS Date), 0, N'383341')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (5, 33633265, N'Settino', N'German', N'4651235', N'German.settino@gmail.com', N'manuel artigas 5555', 25, 1, CAST(0x813A0B00 AS Date), 0, N'367680')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (8, 21312312, N'landgrabe', N'charly', N'44444444444', N'german.settin@ada.com', N'manuel artigas 5391', 6, 24, CAST(0x983A0B00 AS Date), 0, N'386852')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (9, 33333333, N'german', N'settino', N'1111111111', N'gemerna@gmail.com', N'asdasd', 6, 24, CAST(0x9B3A0B00 AS Date), 0, N'247649')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (10, 32423242, N'asdasd', N'asdasd', N'123123123', N'qweqwe@sdasd', N'asdasd', 6, 24, CAST(0xA03A0B00 AS Date), 1, N'203792')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (11, 123123, N'pablo', N'pablo', N'1231231', N'adasdasd@asda', N'asdasd', 6, 24, CAST(0xA03A0B00 AS Date), 1, N'175954')
SET IDENTITY_INSERT [dbo].[Cliente] OFF
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (1, N'Bitacora            ', N'13493846')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (2, N'Usuario             ', N'1382824')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (3, N'Familia             ', N'72400')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (4, N'Venta               ', N'0')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (5, N'Venta_Medicamento   ', N'0')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (6, N'Medicamento         ', N'874909')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (7, N'Cliente             ', N'1765268')
SET IDENTITY_INSERT [dbo].[Familia] ON 

INSERT [dbo].[Familia] ([familia_id], [nombre], [descripcion], [dvh]) VALUES (60, N'UYahIg+g0WKndK4p/20+pg==', N'administrador', N'72400')
SET IDENTITY_INSERT [dbo].[Familia] OFF
INSERT [dbo].[Familia_Usuario] ([familia_id], [usuario_id]) VALUES (58, 9)
INSERT [dbo].[Familia_Usuario] ([familia_id], [usuario_id]) VALUES (60, 26)
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
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (1, N'Usuario')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (2, N'Familia')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (3, N'Backup')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (4, N'Restore')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (5, N'Bitacora')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (6, N'RecalcularDV')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (7, N'Venta')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (8, N'Cliente')
INSERT [dbo].[Patente] ([patente_id], [nombre]) VALUES (9, N'Medicamento')
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (60, 1)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (60, 2)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (60, 3)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (60, 4)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (60, 5)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (60, 6)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (60, 7)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (60, 8)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (60, 9)
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
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (119, 2, N'Sus permisos han sido modificados, por favor inicie sesion nuevamente', N'Permissions have been changed, please log in again')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (120, 2, N'Reporte Clientes Por Venta', N'
Report Customers For Sale')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (122, 2, N'Contraseña Anterior', N'
Old Password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (123, 2, N'Confirmar Contraseña', N'
Confirm Password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (124, 2, N'Nueva Contraseña', N'New Password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (125, 2, N'Se Cambio la Contraseña', N'He changed the password')
SET IDENTITY_INSERT [dbo].[Traduccion] OFF
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (9, N'UYahIg+g0WKndK4p/20+pg==', N'81dc9bdb52d04dc20036dbd8313ed055', N'administrador', N'administrador', N'administrador@administrador.com', N'12345678', 0, 1, 0, N'803366')
INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (26, N'ffJMRvWqtW+IBm25OTHrsA==', N'1ceb3ab5fb9ddd30c5e133293da382a7', N'settino', N'german2', N'german.settino@gmail.com', N'33633265', 0, 0, 0, N'579458')
SET IDENTITY_INSERT [dbo].[Usuario] OFF
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (1, 26, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (2, 26, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (3, 26, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (4, 26, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (5, 26, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (6, 26, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (7, 26, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (8, 26, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (9, 26, 0)
/****** Object:  Index [UQ_Bitacora_bitacora_id]    Script Date: 10/11/2015 17:45:57 ******/
ALTER TABLE [dbo].[Bitacora] ADD  CONSTRAINT [UQ_Bitacora_bitacora_id] UNIQUE NONCLUSTERED 
(
	[bitacora_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Cliente_cliente_id]    Script Date: 10/11/2015 17:45:57 ******/
ALTER TABLE [dbo].[Cliente] ADD  CONSTRAINT [UQ_Cliente_cliente_id] UNIQUE NONCLUSTERED 
(
	[cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_DVV_tabla_id]    Script Date: 10/11/2015 17:45:57 ******/
ALTER TABLE [dbo].[DVV] ADD  CONSTRAINT [UQ_DVV_tabla_id] UNIQUE NONCLUSTERED 
(
	[tabla_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Familia_familia_id]    Script Date: 10/11/2015 17:45:57 ******/
ALTER TABLE [dbo].[Familia] ADD  CONSTRAINT [UQ_Familia_familia_id] UNIQUE NONCLUSTERED 
(
	[familia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Idioma_idioma_id]    Script Date: 10/11/2015 17:45:57 ******/
ALTER TABLE [dbo].[Idioma] ADD  CONSTRAINT [UQ_Idioma_idioma_id] UNIQUE NONCLUSTERED 
(
	[idioma_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Laboratorio_laboratorio_id]    Script Date: 10/11/2015 17:45:57 ******/
ALTER TABLE [dbo].[Laboratorio] ADD  CONSTRAINT [UQ_Laboratorio_laboratorio_id] UNIQUE NONCLUSTERED 
(
	[laboratorio_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Localidad_localidad_id]    Script Date: 10/11/2015 17:45:57 ******/
ALTER TABLE [dbo].[Localidad] ADD  CONSTRAINT [UQ_Localidad_localidad_id] UNIQUE NONCLUSTERED 
(
	[localidad_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Medicamento_medicamento_id]    Script Date: 10/11/2015 17:45:57 ******/
ALTER TABLE [dbo].[Medicamento] ADD  CONSTRAINT [UQ_Medicamento_medicamento_id] UNIQUE NONCLUSTERED 
(
	[medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Patente_patente_id]    Script Date: 10/11/2015 17:45:57 ******/
ALTER TABLE [dbo].[Patente] ADD  CONSTRAINT [UQ_Patente_patente_id] UNIQUE NONCLUSTERED 
(
	[patente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Provincia_provincia_id]    Script Date: 10/11/2015 17:45:57 ******/
ALTER TABLE [dbo].[Provincia] ADD  CONSTRAINT [UQ_Provincia_provincia_id] UNIQUE NONCLUSTERED 
(
	[provincia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Usuario_usuario_id]    Script Date: 10/11/2015 17:45:57 ******/
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [UQ_Usuario_usuario_id] UNIQUE NONCLUSTERED 
(
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Venta_venta_id]    Script Date: 10/11/2015 17:45:57 ******/
ALTER TABLE [dbo].[Venta] ADD  CONSTRAINT [UQ_Venta_venta_id] UNIQUE NONCLUSTERED 
(
	[venta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Venta_Medicamento_medicamento_id]    Script Date: 10/11/2015 17:45:57 ******/
ALTER TABLE [dbo].[Venta_Medicamento] ADD  CONSTRAINT [UQ_Venta_Medicamento_medicamento_id] UNIQUE NONCLUSTERED 
(
	[medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Venta_Medicamento_venta_id]    Script Date: 10/11/2015 17:45:57 ******/
ALTER TABLE [dbo].[Venta_Medicamento] ADD  CONSTRAINT [UQ_Venta_Medicamento_venta_id] UNIQUE NONCLUSTERED 
(
	[venta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [farmacia] SET  READ_WRITE 
GO
