USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[prov_ObtenerProvincias]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[prov_ObtenerProvincias]
AS
begin
SELECT *
  FROM [farmacia].[dbo].[Provincia]

end
GO
