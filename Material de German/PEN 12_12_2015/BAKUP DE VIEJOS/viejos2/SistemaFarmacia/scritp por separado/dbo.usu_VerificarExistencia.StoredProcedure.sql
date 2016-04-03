USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[usu_VerificarExistencia]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usu_VerificarExistencia]
	@nombre_usuario as nvarchar(50)
AS
BEGIN

	select * from Usuario u where u.nombre_usuario = @nombre_usuario
END

GO
