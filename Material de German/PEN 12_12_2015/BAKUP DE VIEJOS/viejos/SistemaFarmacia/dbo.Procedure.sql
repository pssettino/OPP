CREATE PROCEDURE [dbo].[ValidarContraseña] 
	-- Add the parameters for the stored procedure here
	@usuario as nvarchar(50),
	@contraseña as nvarchar(50)
AS
BEGIN
	
	select * from Usuario u
	where u.nombre_usuario = @usuario and u.contraseña = @contraseña
END