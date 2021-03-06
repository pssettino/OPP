USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarUsuarioPatenteNegacion]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ValidarEliminarUsuarioPatenteNegacion] 
	@usuario_id AS Int,
	@patente_id AS Int
AS

Declare @result bit

SET @result = 1

IF EXISTS (
	select *
	from Patente p 
	where  p.obligatoria = 1 and p.patente_id = @patente_id
) AND NOT EXISTS (
	select *
	from Usuario_Patente up,
	     Usuario u
	where u.usuario_id != @usuario_id
	  and u.usuario_id = up.usuario_id
	  and up.Negado = 0
	  and up.patente_id = @patente_id
	  and u.bloqueado = 0
	  and u.eliminado = 0
) AND NOT EXISTS (
	select *
	from Patente_Familia pf,
	     Familia_Usuario fu,
		 usuario u
	WHERE u.usuario_id != @usuario_id
	  and u.usuario_id = fu.usuario_id
	  AND fu.familia_id = pf.familia_id
	  AND pf.patente_id = @patente_id
	  AND pf.patente_id NOT in (
		select up.patente_id 
		from Usuario_Patente up 
		where up.usuario_id = u.usuario_id
		and up.negado = 1)
	and u.bloqueado = 0
	and u.eliminado = 0
) SET @result = 0

SELECT @result AS Valido


GO
