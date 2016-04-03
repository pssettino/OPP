USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[lab_ObtenerLaboratorioPorID]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[lab_ObtenerLaboratorioPorID]
@laboratorio_id as integer
AS
begin
SELECT *  FROM farmacia.dbo.Laboratorio
where laboratorio_id = @laboratorio_id 
end
GO
