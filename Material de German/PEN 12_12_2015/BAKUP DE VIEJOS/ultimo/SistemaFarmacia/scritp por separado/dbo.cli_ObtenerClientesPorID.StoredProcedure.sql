USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientesPorID]    Script Date: 16/11/2015 17:05:04 ******/
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
