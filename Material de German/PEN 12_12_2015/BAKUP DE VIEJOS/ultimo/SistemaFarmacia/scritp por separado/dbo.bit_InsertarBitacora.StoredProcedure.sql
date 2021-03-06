USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[bit_InsertarBitacora]    Script Date: 16/11/2015 17:05:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bit_InsertarBitacora]
	@usuario_fk as int,
    @descripcion as nvarchar(255),
	@fecha_hora as datetime,
	@criticidad  as nvarchar(50)
AS
BEGIN

INSERT INTO [dbo].[Bitacora]
(
  [usuario_fk]
 ,[descripcion]
 ,[fecha_hora]
 ,[criticidad]
 )
Values (
@usuario_fk,
@descripcion,
@fecha_hora,
@criticidad
)

END

GO
