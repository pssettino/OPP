USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientesPorDNI]    Script Date: 16/11/2015 17:05:04 ******/
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
