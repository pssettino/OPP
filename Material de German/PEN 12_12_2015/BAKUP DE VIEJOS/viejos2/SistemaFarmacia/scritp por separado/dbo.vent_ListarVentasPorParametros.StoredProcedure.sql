USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[vent_ListarVentasPorParametros]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[vent_ListarVentasPorParametros]
@fecha_desde as datetime,
@fecha_hasta as datetime,
@cliente_fk as int 
AS
begin
SELECT 
V.venta_id,V.fecha_venta,C.cliente_id,C.nombreCompleto 
FROM [farmacia].[dbo].[Venta] AS V
INNER JOIN Cliente AS C ON C.cliente_id = V.cliente_fk
INNER JOIN Venta_Medicamento AS VM ON VM.venta_id = V.venta_id
INNER JOIN Medicamento AS M ON M.medicamento_id = VM.medicamento_id
WHERE 
  (V.fecha_venta >= @fecha_desde and V.fecha_venta <= @fecha_hasta)
and  (V.cliente_fk = @cliente_fk or @cliente_fk = 0)
 
group by V.venta_id, V.fecha_venta,C.cliente_id,C.nombreCompleto 
end



GO
