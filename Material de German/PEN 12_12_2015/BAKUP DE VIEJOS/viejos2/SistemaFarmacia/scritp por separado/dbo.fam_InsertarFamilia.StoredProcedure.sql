USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[fam_InsertarFamilia]    Script Date: 16/11/2015 17:05:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fam_InsertarFamilia]
    @nombre_familia as nvarchar(50),
    @descripcion as nvarchar(50)
AS
begin

INSERT INTO [dbo].[Familia]
           (
           nombre
           ,descripcion,dvh)
     VALUES
           (
            @nombre_familia
           ,@descripcion,0)

		   end 
GO
