USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[med_InsertarMedicamento]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[med_InsertarMedicamento]
    @descripcion as nvarchar(50),
    @laboratorio_id as integer,
    @precio as nvarchar(50),
	@cantidad as nvarchar(50),
	@receta as bit
AS
begin

INSERT INTO [dbo].Medicamento
           (
           descripcion
           ,laboratorio_fk
		   ,cantidad
		   ,precio
		   ,eliminado
		   ,receta
		   )
     VALUES
           (
            @descripcion
           ,@laboratorio_id
           ,@cantidad
		   ,@precio
		   ,0
		   ,@receta
		   )

end
GO
