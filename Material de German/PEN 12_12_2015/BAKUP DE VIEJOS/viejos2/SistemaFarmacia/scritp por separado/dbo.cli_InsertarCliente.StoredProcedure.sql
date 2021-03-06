USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[cli_InsertarCliente]    Script Date: 16/11/2015 17:05:04 ******/
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
