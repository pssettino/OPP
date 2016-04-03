USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[vent_InsertarVentaMedicamento]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[vent_InsertarVentaMedicamento]
@venta_id as int,
@medicamento_id as int,
@cantidad_venta as int,
@precio_venta as float

AS
begin


insert into	 
Venta_Medicamento (venta_id,medicamento_id,cantidad_venta,precio_venta,dvh)
values (@venta_id,@medicamento_id,@cantidad_venta,@precio_venta,	0)

end



GO
