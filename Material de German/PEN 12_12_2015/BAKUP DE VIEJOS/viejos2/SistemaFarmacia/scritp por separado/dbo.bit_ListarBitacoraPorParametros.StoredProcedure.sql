USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[bit_ListarBitacoraPorParametros]    Script Date: 16/11/2015 17:05:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[bit_ListarBitacoraPorParametros]
@usuario_id as int,
@fecha_desde as datetime,
@fecha_hasta as datetime,
@criticidad as nvarchar(50)
AS
begin
SELECT 
 B.bitacora_id,
 B.usuario_fk,
 U.nombre_usuario,
 B.descripcion,
 B.fecha_hora,
 B.criticidad
FROM [farmacia].[dbo].[Bitacora] AS B
INNER JOIN Usuario AS U ON B.usuario_fk = U.usuario_id
WHERE (B.usuario_fk =  @usuario_id or  @usuario_id = 0)
and  (B.fecha_hora >= @fecha_desde and fecha_hora <= @fecha_hasta)
and (B.criticidad = @criticidad or @criticidad = 'Todos los niveles')
end
GO
