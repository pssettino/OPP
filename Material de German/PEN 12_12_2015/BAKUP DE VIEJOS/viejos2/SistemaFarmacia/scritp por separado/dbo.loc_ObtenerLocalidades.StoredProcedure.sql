USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[loc_ObtenerLocalidades]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[loc_ObtenerLocalidades]
AS
begin
SELECT *  FROM [farmacia].[dbo].[Localidad] order by descripcion

end
GO
