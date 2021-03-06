USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarFamiliaPatente]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ValidarEliminarFamiliaPatente] 
	@familia_id AS Int,
	@patente_id AS Int
AS

Declare @result bit

SET @result = 1

IF EXISTS (
	select p.patente_id
	from Patente p 
	where  p.obligatoria = 1 and p.patente_id = @patente_id
) AND NOT EXISTS (
	select up.patente_id, up.patente_id
	from Usuario_Patente up 
	inner join Usuario u
	on u.usuario_id = up.usuario_id
	where(up.patente_id = @patente_id)
	and up.negado = 0
	and u.bloqueado = 0
	and u.eliminado = 0
) AND NOT EXISTS (
	select fu.familia_id, pf.patente_id
	from Patente_Familia pf 
	inner join Familia_Usuario fu 
	on fu.familia_id = pf.familia_id 
	inner join Usuario u
	on u.usuario_id = fu.usuario_id
	where 
	    pf.patente_id = @patente_id
	and pf.familia_id != @familia_id
	and u.bloqueado = 0
	and u.eliminado = 0
	AND pf.patente_id
	 not in (
		select up.patente_id 
		from Usuario_Patente up 
		where up.usuario_id = fu.usuario_id
		and up.negado = 1
	)
 
) SET @result = 0

SELECT @result AS Valido

GO
