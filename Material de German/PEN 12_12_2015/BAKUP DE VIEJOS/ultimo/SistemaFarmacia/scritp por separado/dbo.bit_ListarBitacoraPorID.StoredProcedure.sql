USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[bit_ListarBitacoraPorID]    Script Date: 16/11/2015 17:05:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[bit_ListarBitacoraPorID]
@bitacora_id as int
AS
begin
SELECT 
	   [bitacora_id]
	  ,[usuario_fk]
      ,[descripcion]
      ,[fecha_hora]
      ,[criticidad]
FROM [farmacia].[dbo].[Bitacora] 
WHERE [bitacora_id] =  @bitacora_id  
end
GO
