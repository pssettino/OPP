USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[cli_ModificarCliente]    Script Date: 16/11/2015 17:05:04 ******/
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
