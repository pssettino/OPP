USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[fam_ObtenerFamiliasPorID]    Script Date: 16/11/2015 17:05:04 ******/
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
