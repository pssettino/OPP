USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[med_ModificarMedicamento]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[med_ModificarMedicamento]
	@medicamento_id as int,
	@descripcion as nvarchar(50),
	@laboratorio_id as integer,
    @precio as nvarchar(50),
    @cantidad as nvarchar(50),
	@receta as bit
AS
begin
UPDATE [dbo].Medicamento
   SET descripcion = @descripcion
	  ,laboratorio_fk = @laboratorio_id
      ,cantidad = @cantidad
      ,precio = @precio
	  ,receta = @receta
 WHERE 
	  medicamento_id = @medicamento_id
end

GO
