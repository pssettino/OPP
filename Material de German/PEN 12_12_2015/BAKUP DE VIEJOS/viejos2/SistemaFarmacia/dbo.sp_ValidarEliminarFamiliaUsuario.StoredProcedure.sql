USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarFamiliaUsuario]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery10.sql|7|0|C:\Users\PC\AppData\Local\Temp\~vs62A1.sql
CREATE PROCEDURE [dbo].[sp_ValidarEliminarFamiliaUsuario] 
	@familia_id AS Int,
	@usuario_id AS Int
AS

Declare @patente_id int
Declare @result bit
Declare cur cursor For SELECT Patente.patente_id FROM Patente WHERE Patente.obligatoria = 1 

SET @result = 1
OPEN cur 
	FETCH NEXT FROM cur Into @patente_id
		While @@Fetch_Status = 0 Begin
			IF NOT EXISTS (
				select *
				from Usuario_Patente up 
				inner join Usuario u
				on u.usuario_id = up.usuario_id
				where up.patente_id = @patente_id
				and up.Negado = 0
				and u.bloqueado = 0
				and u.eliminado = 0
	/*	) AND NOT EXISTS (
				select *
				from Patente_Familia pf,
					 Familia_Usuario fu,
					 usuario u 
				where u.usuario_id = fu.usuario_id
				  AND fu.familia_id != pf.familia_id
				  AND pf.patente_id = @patente_id
				  AND ((u.usuario_id = @usuario_id
				   AND u.usuario_id = fu.usuario_id
				   AND fu.familia_id != @familia_id)
				  OR (u.usuario_id != @usuario_id))
				and u.bloqueado = 0
				and u.eliminado = 0
				AND pf.patente_id NOT in (
					select up.patente_id 
					from Usuario_Patente up 
					where up.usuario_id = @usuario_id
					and up.negado = 1)
			) SET @result = 0*/

						) AND NOT EXISTS (
				select *
				from Patente_Familia pf 
				inner join Familia_Usuario fu 
				on fu.familia_id = pf.familia_id 
				inner join Usuario u
				on u.usuario_id = fu.usuario_id
				AND pf.patente_id NOT in (
					select up.patente_id 
					from Usuario_Patente up 
					where up.usuario_id = @usuario_id
					and up.negado = 1)
				and pf.patente_id = @patente_id
				and (pf.familia_id != @familia_id or fu.usuario_id != @usuario_id)
				and u.bloqueado = 0
				and u.eliminado = 0
			) SET @result = 0

		FETCH NEXT FROM cur Into @patente_id
	END
CLOSE cur
DEALLOCATE cur

SELECT @result AS Valido







GO
