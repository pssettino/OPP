USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[lab_ObtenerLaboratorios]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[lab_ObtenerLaboratorios]
AS
begin
SELECT *  FROM farmacia.dbo.Laboratorio order by razon_social
end
GO
