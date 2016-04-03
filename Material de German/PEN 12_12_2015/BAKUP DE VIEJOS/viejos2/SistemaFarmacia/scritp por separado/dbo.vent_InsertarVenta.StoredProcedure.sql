USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[vent_InsertarVenta]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[vent_InsertarVenta]
@fecha_venta as datetime,
@cliente_fk as int,
@dvh as int

AS
begin


insert into	 
Venta (fecha_venta,cliente_fk,eliminado,dvh)
values (@fecha_venta,@cliente_fk,0,@dvh);
select SCOPE_IDENTITY();

end



GO
