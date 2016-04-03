USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[fam_ObtenerFamilias]    Script Date: 16/11/2015 17:05:04 ******/
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
