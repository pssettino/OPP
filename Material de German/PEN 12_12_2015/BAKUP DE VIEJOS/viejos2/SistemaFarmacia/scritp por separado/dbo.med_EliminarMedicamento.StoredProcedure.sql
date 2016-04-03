USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[med_EliminarMedicamento]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[med_EliminarMedicamento]
	@medicamento_id as int,
	@eliminado as bit
AS
begin
update Medicamento 
 SET  eliminado = @eliminado
 WHERE medicamento_id = @medicamento_id

end
GO
