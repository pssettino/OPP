USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentosPorDescripcion]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[med_ObtenerMedicamentosPorDescripcion]
@descripcion as nvarchar(255)
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento as m inner join farmacia.dbo.Laboratorio as l on m.laboratorio_fk = l.laboratorio_id
  where descripcion  LIKE '%' + @descripcion + '%'
end
GO
