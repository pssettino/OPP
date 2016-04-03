USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[ValidarContraseña]    Script Date: 12/09/2015 13:40:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[InsertarUsuario]
	@nombre_usuario as nvarchar(50),
    @contraseña as nvarchar(50),
    @nombre as nvarchar(80),
    @apellido as nvarchar(80),
    @email as nvarchar(100),
    @dni as int,
    @activo as char(1),
    @cci as int,
    @dvh as int
AS
BEGIN
INSERT INTO [dbo].[Usuario]
           (
		    [usuario_id]
           ,[nombre_usuario]
           ,[contraseña]
           ,[nombre]
           ,[apellido]
           ,[email]
           ,[dni]
           ,[activo]
           ,[cci]
           ,[dvh]
		   )
     VALUES
           (@@identity
		   ,@nombre_usuario
           ,@contraseña
           ,@nombre
           ,@apellido
           ,@email
           ,@dni
           ,@activo
           ,@cci
           ,@dvh)
END
