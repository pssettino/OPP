USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[fam_EliminarFamilia]    Script Date: 16/11/2015 17:05:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fam_EliminarFamilia]
	@familia_id as int
AS
begin
delete from [dbo].[Familia] WHERE [familia_id] = @familia_id

end
GO
