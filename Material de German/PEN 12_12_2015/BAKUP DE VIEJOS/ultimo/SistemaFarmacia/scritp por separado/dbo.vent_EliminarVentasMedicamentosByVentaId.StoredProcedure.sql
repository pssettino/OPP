USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[vent_EliminarVentasMedicamentosByVentaId]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[vent_EliminarVentasMedicamentosByVentaId]
@venta_id as int

AS
begin
delete from [dbo].[Venta_Medicamento] where Venta_Medicamento.venta_id = @venta_id;

end



GO
