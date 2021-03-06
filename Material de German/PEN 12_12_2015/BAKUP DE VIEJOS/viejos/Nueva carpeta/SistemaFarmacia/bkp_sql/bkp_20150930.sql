USE [master]
GO
/****** Object:  Database [farmacia]    Script Date: 30/09/2015 23:49:40 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_EliminarFamilia]    Script Date: 30/09/2015 23:49:40 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_InsertarFamilia]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fam_InsertarFamilia]
    @nombre_familia as nvarchar(50),
    @descripcion as nvarchar(50),
    @dvh as int
AS
begin

INSERT INTO [dbo].[Familia]
           (
           nombre
           ,descripcion
           ,dvh)
     VALUES
           (
            @nombre_familia
           ,@descripcion
           ,@dvh)

		   end 
GO
/****** Object:  StoredProcedure [dbo].[fam_ModificarFamilia]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[fam_ModificarFamilia]
	@familia_id as int,
	@nombre_familia as nvarchar(50),
    @descripcion as nvarchar(50),
    @dvh as int
AS
begin
UPDATE [dbo].Familia
   SET nombre = @nombre_familia
      ,descripcion = @descripcion
      ,dvh = @dvh
 WHERE 
		familia_id = @familia_id
end

GO
/****** Object:  StoredProcedure [dbo].[fam_ObtenerFamilias]    Script Date: 30/09/2015 23:49:40 ******/
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
/****** Object:  StoredProcedure [dbo].[fam_ObtenerFamiliasPorID]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[fam_ObtenerFamiliasPorID]
@familia_id as int
AS
begin
SELECT * FROM [farmacia].[dbo].Familia  where familia_id = @familia_id
end
GO
/****** Object:  StoredProcedure [dbo].[fam_VerificarExistencia]    Script Date: 30/09/2015 23:49:40 ******/
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
/****** Object:  StoredProcedure [dbo].[med_EliminarMedicamento]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[med_EliminarMedicamento]
	@medicamento_id as int
AS
begin
delete from [dbo].Medicamento WHERE medicamento_id = @medicamento_id

end
GO
/****** Object:  StoredProcedure [dbo].[med_InsertarMedicamento]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[med_InsertarMedicamento]
    @descripcion as nvarchar(50),
    @laboratorio_id as nvarchar(50),
    @precio as float,
	@cantidad as integer
AS
begin

INSERT INTO [dbo].Medicamento
           (
           descripcion
           ,laboratorio_fk
           ,cantidad,precio,activo)
     VALUES
           (
            @descripcion
           ,@laboratorio_id
           ,@cantidad
		   ,@precio,1)


end
GO
/****** Object:  StoredProcedure [dbo].[med_ModificarMedicamento]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[med_ModificarMedicamento]
	@medicamento_id as int,
	@descripcion as nvarchar(50),
	@laboratorio_id as integer,
    @precio as float,
    @cantidad as int
AS
begin
UPDATE [dbo].Medicamento
   SET descripcion = @descripcion
		,laboratorio_fk = @laboratorio_id
      ,cantidad = @cantidad
      ,precio = @precio
 WHERE 
		medicamento_id = @medicamento_id
end

GO
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentos]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[med_ObtenerMedicamentos]
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento
end
GO
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentosPorID]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[med_ObtenerMedicamentosPorID]
@medicamento_id as int
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento  where medicamento_id = @medicamento_id 
end
GO
/****** Object:  StoredProcedure [dbo].[med_VerificarExistencia]    Script Date: 30/09/2015 23:49:40 ******/
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
/****** Object:  StoredProcedure [dbo].[pat_ObtenerPatentes]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[pat_ObtenerPatentes]
AS
begin
SELECT [patente_id]
      ,[nombre]
      ,[descripcion]
      ,[dvh]
  FROM [farmacia].[dbo].[Patente]
end
GO
/****** Object:  StoredProcedure [dbo].[pat_ObtenerPatentesPorFamiliaID]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[pat_ObtenerPatentesPorFamiliaID]
@Familia_id int
AS
begin
SELECT P.patente_id,F.familia_id,[nombre],[descripcion],[dvh]
  FROM [farmacia].[dbo].[Patente] as P inner join Patente_Familia as F on P.patente_id = F.patente_id
  where F.familia_id = @Familia_id
end
GO
/****** Object:  StoredProcedure [dbo].[pat_ObtenerPatentesPorUsuarioID]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[pat_ObtenerPatentesPorUsuarioID]
@usuario_id as int
AS
begin
SELECT *  FROM [farmacia].[dbo].[Usuario] as U inner join Usuario_Patente as P on U.usuario_id = P.usuario_id
  where U.usuario_id = @usuario_id
end
GO
/****** Object:  StoredProcedure [dbo].[usu_BloquearDesbloquerUsuario]    Script Date: 30/09/2015 23:49:40 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_EliminarUsuario]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usu_EliminarUsuario]
	@usuario_id as int
AS
begin
UPDATE [dbo].[Usuario]
   SET eliminado = 1
 WHERE 
		[usuario_id] = @usuario_id
end
GO
/****** Object:  StoredProcedure [dbo].[usu_InsertarUsuario]    Script Date: 30/09/2015 23:49:40 ******/
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
    @cci as int,
    @dvh as int
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
           ,[dvh]
		   )
     VALUES
           (
		   @nombre_usuario
           ,@contraseña
           ,@nombre
           ,@apellido
           ,@email
           ,@dni
           ,@bloqueado,
		   @eliminado
           ,@cci
           ,@dvh)
END

GO
/****** Object:  StoredProcedure [dbo].[usu_ModificarUsuario]    Script Date: 30/09/2015 23:49:40 ******/
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
    @cci as int,
    @dvh as int
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
      ,[dvh] =  @dvh
 WHERE 
		[usuario_id] = @usuario_id

end
GO
/****** Object:  StoredProcedure [dbo].[usu_ObtenerUsuarios]    Script Date: 30/09/2015 23:49:40 ******/
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
      ,bloqueado
      ,[cci]
      ,[dvh]
  FROM [farmacia].[dbo].[Usuario]
  where eliminado <> 1

end
GO
/****** Object:  StoredProcedure [dbo].[usu_ObtenerUsuariosPorID]    Script Date: 30/09/2015 23:49:40 ******/
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
      ,[dvh]
  FROM [farmacia].[dbo].[Usuario]
  where usuario_id = @usuario_id and eliminado <> 1
end
GO
/****** Object:  StoredProcedure [dbo].[usu_ValidarContraseña]    Script Date: 30/09/2015 23:49:40 ******/
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
/****** Object:  StoredProcedure [dbo].[usu_VerificarExistencia]    Script Date: 30/09/2015 23:49:40 ******/
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
/****** Object:  Table [dbo].[Bitacora]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bitacora](
	[bitacora_id] [int] NOT NULL,
	[fecha] [timestamp] NOT NULL,
	[descripcion] [nvarchar](255) NULL,
	[usuario_fk] [int] NULL,
	[dvh] [int] NULL,
 CONSTRAINT [PK_Bitacora] PRIMARY KEY CLUSTERED 
(
	[bitacora_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Bitacora_bitacora_id] UNIQUE NONCLUSTERED 
(
	[bitacora_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[cliente_id] [int] IDENTITY(1,1) NOT NULL,
	[direccion] [nvarchar](255) NOT NULL,
	[nombre] [nvarchar](80) NULL,
	[apellido] [nvarchar](80) NULL,
	[telefono] [int] NULL,
	[fecha_alta] [date] NULL,
	[activo] [bit] NULL,
	[dni] [int] NULL,
	[email] [nvarchar](100) NULL,
	[dvh] [int] NULL,
	[localidad_fk] [int] NULL,
	[provincia_fk] [int] NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Cliente_cliente_id] UNIQUE NONCLUSTERED 
(
	[cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Criticidad]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Criticidad](
	[criticidad_id] [int] NOT NULL,
	[bitacora_fk] [int] NOT NULL,
	[descripcion] [nvarchar](50) NULL,
	[dvh] [int] NULL,
 CONSTRAINT [PK_Criticidad] PRIMARY KEY CLUSTERED 
(
	[criticidad_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Criticidad_criticidad_id] UNIQUE NONCLUSTERED 
(
	[criticidad_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DVV]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DVV](
	[tabla_id] [int] NOT NULL,
	[dvv] [int] NULL,
 CONSTRAINT [PK_DVV] PRIMARY KEY CLUSTERED 
(
	[tabla_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_DVV_tabla_id] UNIQUE NONCLUSTERED 
(
	[tabla_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Familia]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Familia](
	[familia_id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[descripcion] [nvarchar](50) NULL,
	[dvh] [int] NULL,
 CONSTRAINT [PK_Familia] PRIMARY KEY CLUSTERED 
(
	[familia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Familia_familia_id] UNIQUE NONCLUSTERED 
(
	[familia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Familia_Usuario]    Script Date: 30/09/2015 23:49:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Familia_Usuario_familia_id] UNIQUE NONCLUSTERED 
(
	[familia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Familia_Usuario_usuario_id] UNIQUE NONCLUSTERED 
(
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Idioma]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Idioma](
	[idioma_id] [int] NOT NULL,
	[idioma] [nvarchar](50) NULL,
 CONSTRAINT [PK_Idioma] PRIMARY KEY CLUSTERED 
(
	[idioma_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Idioma_idioma_id] UNIQUE NONCLUSTERED 
(
	[idioma_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Laboratorio]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Laboratorio](
	[laboratorio_id] [int] NOT NULL,
	[razon_social] [nvarchar](50) NULL,
	[cuit] [int] NULL,
	[telefono] [int] NULL,
 CONSTRAINT [PK_Laboratorio] PRIMARY KEY CLUSTERED 
(
	[laboratorio_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Laboratorio_laboratorio_id] UNIQUE NONCLUSTERED 
(
	[laboratorio_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Localidad]    Script Date: 30/09/2015 23:49:40 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Localidad_localidad_id] UNIQUE NONCLUSTERED 
(
	[localidad_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Medicamento]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medicamento](
	[medicamento_id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [nvarchar](50) NOT NULL,
	[laboratorio_fk] [int] NULL,
	[cantidad] [int] NULL,
	[precio] [float] NULL,
	[activo] [bit] NULL,
 CONSTRAINT [PK_Medicamento] PRIMARY KEY CLUSTERED 
(
	[medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Medicamento_medicamento_id] UNIQUE NONCLUSTERED 
(
	[medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Patente]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patente](
	[patente_id] [int] NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[descripcion] [nvarchar](50) NULL,
	[dvh] [int] NULL,
 CONSTRAINT [PK_Patente] PRIMARY KEY CLUSTERED 
(
	[patente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Patente_patente_id] UNIQUE NONCLUSTERED 
(
	[patente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Patente_Familia]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patente_Familia](
	[familia_id] [int] NOT NULL,
	[patente_id] [int] NOT NULL,
 CONSTRAINT [PK_Patente_Familia] PRIMARY KEY CLUSTERED 
(
	[familia_id] ASC,
	[patente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Patente_Familia_familia_id] UNIQUE NONCLUSTERED 
(
	[familia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Patente_Familia_patente_id] UNIQUE NONCLUSTERED 
(
	[patente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Provincia]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provincia](
	[provincia_id] [int] NOT NULL,
	[descripcion] [nvarchar](100) NULL,
 CONSTRAINT [PK_Provincia] PRIMARY KEY CLUSTERED 
(
	[provincia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Provincia_provincia_id] UNIQUE NONCLUSTERED 
(
	[provincia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Traduccion]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Traduccion](
	[idioma_fk] [int] NOT NULL,
	[descripcion] [nvarchar](256) NULL,
	[control] [nvarchar](256) NULL,
 CONSTRAINT [PK_Traduccion] PRIMARY KEY CLUSTERED 
(
	[idioma_fk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Traduccion_idioma_fk] UNIQUE NONCLUSTERED 
(
	[idioma_fk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[usuario_id] [int] IDENTITY(1,1) NOT NULL,
	[nombre_usuario] [nvarchar](50) NOT NULL,
	[contraseña] [nvarchar](50) NOT NULL,
	[nombre] [nvarchar](80) NULL,
	[apellido] [nvarchar](80) NULL,
	[email] [nvarchar](100) NULL,
	[dni] [int] NULL,
	[bloqueado] [bit] NULL,
	[eliminado] [bit] NULL,
	[cci] [int] NOT NULL,
	[dvh] [int] NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Usuario_usuario_id] UNIQUE NONCLUSTERED 
(
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usuario_Patente]    Script Date: 30/09/2015 23:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario_Patente](
	[patente_id] [int] NOT NULL,
	[usuario_id] [int] NOT NULL,
	[negado] [char](1) NULL,
 CONSTRAINT [PK_Usuario_Patente] PRIMARY KEY CLUSTERED 
(
	[patente_id] ASC,
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Usuario_Patente_patente_id] UNIQUE NONCLUSTERED 
(
	[patente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Usuario_Patente_usuario_id] UNIQUE NONCLUSTERED 
(
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Venta]    Script Date: 30/09/2015 23:49:40 ******/
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
	[dvh] [int] NULL,
	[fecha_venta] [date] NULL,
	[receta] [char](1) NULL,
	[activo] [char](1) NULL,
 CONSTRAINT [PK_Venta] PRIMARY KEY CLUSTERED 
(
	[venta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Venta_venta_id] UNIQUE NONCLUSTERED 
(
	[venta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Venta_Medicamento]    Script Date: 30/09/2015 23:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venta_Medicamento](
	[venta_id] [int] NOT NULL,
	[medicamento_id] [int] NOT NULL,
	[cantidad_venta] [int] NULL,
	[precio_venta] [float] NULL,
	[dvh] [int] NULL,
 CONSTRAINT [PK_Venta_Medicamento] PRIMARY KEY CLUSTERED 
(
	[venta_id] ASC,
	[medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Venta_Medicamento_medicamento_id] UNIQUE NONCLUSTERED 
(
	[medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Venta_Medicamento_venta_id] UNIQUE NONCLUSTERED 
(
	[venta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
USE [master]
GO
ALTER DATABASE [farmacia] SET  READ_WRITE 
GO
