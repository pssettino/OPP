create procedure dbo.ModificarUsuario
	@usuario_id as int,
	@nombre_usuario as nvarchar(50),
    @contraseña as nvarchar(50),
    @nombre as nvarchar(80),
    @apellido as nvarchar(80),
    @email as nvarchar(100),
    @dni as int,
    @activo as char(1),
    @cci as int,
    @dvh as int
AS
begin
UPDATE [dbo].[Usuario]
   SET [nombre_usuario] = @nombre_usuario
      ,[contraseña] = @contraseña
      ,[nombre] = @nombre
      ,[apellido] = @apellido
      ,[email] = @email
      ,[dni] = @dni
      ,[activo] = @activo
      ,[cci] = @cci
      ,[dvh] =  @dvh
 WHERE 
		[usuario_id] = @usuario_id

end