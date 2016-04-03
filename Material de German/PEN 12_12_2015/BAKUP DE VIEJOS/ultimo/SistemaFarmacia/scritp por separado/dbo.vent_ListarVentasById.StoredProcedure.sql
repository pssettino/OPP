USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[vent_ListarVentasById]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[vent_ListarVentasById]
@venta_id as int
AS
begin
SELECT 
V.venta_id,V.fecha_venta,C.cliente_id,C.nombreCompleto
FROM [farmacia].[dbo].[Venta] AS V
INNER JOIN Cliente AS C ON C.cliente_id = V.cliente_fk
WHERE 
V.venta_id = @venta_id
end



GO
