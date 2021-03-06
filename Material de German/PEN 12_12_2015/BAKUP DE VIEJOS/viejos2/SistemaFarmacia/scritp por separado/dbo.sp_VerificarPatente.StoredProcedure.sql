USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[sp_VerificarPatente]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[sp_VerificarPatente] 
	@usuario_id AS Int,
	@patente_id AS Int
AS

Declare @result bit
SET @result = 0

IF EXISTS (
	select *
	from Usuario_Patente up,
	     usuario u
    WHERE u.usuario_id = @usuario_id
	  AND u.usuario_id = up.usuario_id
	  AND up.patente_id = @patente_id
	  AND up.negado = 0
) OR EXISTS (
	select *
	from Patente_Familia pf,
	     Familia_Usuario fu,
		 usuario u
	WHERE u.usuario_id = @usuario_id
	  AND u.usuario_id = fu.usuario_id
	  AND fu.familia_id = pf.familia_id
	  AND pf.patente_id = @patente_id
	  AND pf.patente_id NOT in (
		select up.patente_id 
		from Usuario_Patente up 
		where up.usuario_id = @usuario_id
		and up.negado = 1)
) SET @result = 1

SELECT @result AS Valido



GO
