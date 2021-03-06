USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentosDisponibles]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[med_ObtenerMedicamentosDisponibles]
@cantidad as nvarchar(50)
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento as m 
inner join 
farmacia.dbo.Laboratorio as l on m.laboratorio_fk = l.laboratorio_id
where cantidad > @cantidad
end
GO
