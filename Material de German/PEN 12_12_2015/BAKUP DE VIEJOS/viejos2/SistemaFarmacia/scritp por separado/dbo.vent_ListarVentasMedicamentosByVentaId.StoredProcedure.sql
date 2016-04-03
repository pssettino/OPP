USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[vent_ListarVentasMedicamentosByVentaId]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[vent_ListarVentasMedicamentosByVentaId]
@venta_id as int
AS
begin
SELECT 
*
FROM [farmacia].[dbo].[Venta_Medicamento] AS VM
INNER JOIN Medicamento AS M ON VM.medicamento_id = M.medicamento_id
WHERE 
VM.venta_id = @venta_id
end



GO
