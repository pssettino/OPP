USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarUsuarioPatente]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ValidarEliminarUsuarioPatente] 
	@usuario_id AS Int,
	@patente_id AS Int
AS

Declare @result bit

SET @result = 1

IF EXISTS (
	select *
	from Patente p 
	where   p.obligatoria = 1 and p.patente_id = @patente_id
) AND NOT EXISTS (
	select *
	from dbo.Usuario_Patente up,
	     dbo.Usuario u
	WHERE  up.patente_id = @patente_id 
	   and up.usuario_id = u.usuario_id
	   and u.usuario_id != @usuario_id
	   and u.bloqueado = 0
	   and u.eliminado = 0
	   AND up.negado = 0
) AND NOT EXISTS (
	select * 
	  from dbo.Patente_Familia pf,
		   dbo.Familia_Usuario fu,	
		   dbo.Usuario u,
		   dbo.Usuario_Patente up
	 where pf.patente_id = @patente_id 
 	   and pf.familia_id = fu.familia_id
	   and fu.usuario_id = u.usuario_id
	   and u.usuario_id = @usuario_id
	   and u.bloqueado = 0
	   and u.eliminado = 0
) AND NOT EXISTS (
	select * 
	  from dbo.Patente_Familia pf,
		   dbo.Familia_Usuario fu,	
		   dbo.Usuario u,
		   dbo.Usuario_Patente up
	 where pf.patente_id = @patente_id 
 	   and pf.familia_id = fu.familia_id
	   and fu.usuario_id = u.usuario_id
	   and u.usuario_id != @usuario_id
	   and u.bloqueado = 0
	   and u.eliminado = 0
	   AND pf.patente_id NOT in (
		select up.patente_id 
		from Usuario_Patente up 
		where up.usuario_id = u.usuario_id
		and up.negado = 1)
) SET @result = 0

SELECT @result AS Valido

GO
