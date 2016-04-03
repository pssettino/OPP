USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[med_VerificarExistencia]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[med_VerificarExistencia]
@descripcion as nvarchar(50)
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento  where descripcion = @descripcion 
end
GO
