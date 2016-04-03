USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientesPorApellido_Nombre]    Script Date: 16/11/2015 17:05:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[cli_ObtenerClientesPorApellido_Nombre]
@Apellido_Nombre as nvarchar(255)
AS
begin
SELECT *  FROM [farmacia].[dbo].Cliente  
where nombreCompleto like '%' + @Apellido_Nombre + '%'  
end
GO
