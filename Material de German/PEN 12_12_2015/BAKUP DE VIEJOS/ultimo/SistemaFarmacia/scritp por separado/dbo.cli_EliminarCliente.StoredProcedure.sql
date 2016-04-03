USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[cli_EliminarCliente]    Script Date: 16/11/2015 17:05:04 ******/
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
