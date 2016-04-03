create procedure dbo.EliminarUsuario
	@usuario_id as int
AS
begin
delete from [dbo].[Usuario] WHERE [usuario_id] = @usuario_id

end