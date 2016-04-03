USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[prov_ObtenerProvinciaPorID]    Script Date: 16/11/2015 17:05:05 ******/
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
