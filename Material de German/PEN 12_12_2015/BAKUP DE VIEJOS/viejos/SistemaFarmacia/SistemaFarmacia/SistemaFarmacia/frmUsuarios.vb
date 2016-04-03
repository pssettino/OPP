Public Class frmUsuarios

    Dim BitacoraBE As New BE.Bitacora
    Dim CriticidadBE As New BE.Criticidad
    Dim unUsuario As New BE.Usuario
    Dim MenuUI As UI.frmMenu
    Dim TraduccionBLL As BLL.Traduccion

    Private Sub btnRegistrar_Click(sender As Object, e As EventArgs) Handles btnRegistrar.Click
        Dim UsuarioRegistrar As New frmUsuariosMod()
        UsuarioRegistrar.btnRestablecer.Enabled = False
        If UsuarioRegistrar.ShowDialog(Me) = Windows.Forms.DialogResult.OK Then
            ObtenerUsuarios()
        End If
    End Sub

    Private Sub frmUsuarios_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        MenuUI = Me.MdiParent
        TraduccionBLL = New BLL.Traduccion(MenuUI.GetIdioma)
        TraduccionBLL.TraducirForm(Me)
        ObtenerUsuarios()
    End Sub

    Public Sub ObtenerUsuarios()
        Dim SeguridadBLL As New BLL.Seguridad
        Dim UsuarioBE As New BE.Usuario
        dgUsuarios.Rows.Clear()
        For Each UsuarioBE In BLL.Usuario.GetInstance.ListAll()
            Dim n As Integer = dgUsuarios.Rows.Add()
            dgUsuarios.Rows.Item(n).Cells("id").Value = UsuarioBE.UsuarioId
            dgUsuarios.Rows.Item(n).Cells("Nombre_Usuario").Value = SeguridadBLL.DesencriptarRSA(UsuarioBE.NombreUsuario)
            dgUsuarios.Rows.Item(n).Cells("Apellido_Nombre").Value = UsuarioBE.Apellido & ", " & UsuarioBE.Nombre
            dgUsuarios.Rows.Item(n).Cells("eliminado").Value = UsuarioBE.Eliminado
            dgUsuarios.Rows.Item(n).Cells("bloqueado").Value = UsuarioBE.Bloqueado

            Dim dgUsuarioBtnModificar = New DataGridViewButtonCell
            dgUsuarioBtnModificar.Value = "Modificar"
            dgUsuarios.Rows.Item(n).Cells("dgUsuarioBtnModificar") = dgUsuarioBtnModificar

            Dim dgUsuarioBtnEliminado = New DataGridViewButtonCell()
            If UsuarioBE.Eliminado = True Then
                dgUsuarioBtnEliminado.Value = "Activar"
                dgUsuarioBtnModificar.ReadOnly = True
            Else
                dgUsuarioBtnEliminado.Value = "Eliminar"
                dgUsuarioBtnModificar.ReadOnly = False
            End If
            dgUsuarios.Rows.Item(n).Cells("dgUsuarioBtnEliminado") = dgUsuarioBtnEliminado

            Dim dgUsuarioBtnBloqueado = New DataGridViewButtonCell()
            If UsuarioBE.Bloqueado = True Then
                dgUsuarioBtnBloqueado.Value = "Desbloquear"
            Else
                dgUsuarioBtnBloqueado.Value = "Bloquear"
            End If
            dgUsuarios.Rows.Item(n).Cells("dgUsuarioBtnBloqueado") = dgUsuarioBtnBloqueado
        Next
    End Sub

    Private Sub dgUsuarios_CellContentClick(sender As Object, e As DataGridViewCellEventArgs) Handles dgUsuarios.CellContentClick
        Dim id As String = Convert.ToString(dgUsuarios.CurrentRow.Cells("id").Value)
        Dim bloqueado As Boolean = dgUsuarios.CurrentRow.Cells("bloqueado").Value
        Dim eliminado As Boolean = dgUsuarios.CurrentRow.Cells("eliminado").Value
        Dim NombreUsuario As String = Convert.ToString(dgUsuarios.CurrentRow.Cells("Nombre_Usuario").Value)
        Dim Nombre As String
        Dim Descr As String
        Dim result As Integer

        If e.ColumnIndex = 4 Then 'Nro Columna del datagriew
            Dim UsuarioModificar As New frmUsuariosMod(id)
            Dim SeguridadBLL As New BLL.Seguridad

            UsuarioModificar.txtuser.Focus()

            unUsuario.UsuarioId = id
            unUsuario = BLL.Usuario.GetInstance().ListById(unUsuario)

            UsuarioModificar.btnRestablecer.Enabled = True
            UsuarioModificar.txtuser.Text = SeguridadBLL.DesencriptarRSA(unUsuario.NombreUsuario)
            UsuarioModificar.txtapellido.Text = unUsuario.Apellido
            UsuarioModificar.txtnombre.Text = unUsuario.Nombre
            UsuarioModificar.txtdni.Text = unUsuario.Dni
            UsuarioModificar.txtmail.Text = unUsuario.Mail
            UsuarioModificar.lblcontraseña.Text = unUsuario.Contraseña
            If UsuarioModificar.ShowDialog(Me) = Windows.Forms.DialogResult.OK Then
                ObtenerUsuarios()
            End If
        End If

        If e.ColumnIndex = 5 Then 'Nro Columna del datagriew
            unUsuario.UsuarioId = id
            unUsuario.Eliminado = eliminado
            If id = MenuUI.GetUsuario.UsuarioId Then
                MsgBox("No se puede eliminar el mismo usuario", MsgBoxStyle.Critical, "Error")
            Else
                If eliminado = True Then
                    eliminado = False
                    Descr = "Activar"
                    Nombre = "Se activo el Usuario: " & NombreUsuario
                Else
                    eliminado = True
                    Descr = "Eliminar"
                    Nombre = "Elimino Usuario: " & NombreUsuario
                End If
                If BLL.Usuario.GetInstance.ValidarEliminarUsuario(BLL.Usuario.GetInstance.ListById(unUsuario)) Then
                    result = MessageBox.Show("¿Esta seguro que desea " & Descr & " el usuario: " & NombreUsuario & "?", Descr & "Usuario", MessageBoxButtons.OKCancel, MessageBoxIcon.Question)
                    If result = DialogResult.OK Then
                        BLL.Usuario.GetInstance.Delete(unUsuario)
                        MessageBox.Show(Nombre, Descr & "Usuario", MessageBoxButtons.OK, MessageBoxIcon.Information)
                        RegistrarBitacora(Nombre, "Alta")
                    End If
                Else
                    MsgBox("No se puede eliminar el usuario ya que quedarian patentes de asignacion obligatoria sin asignar", MsgBoxStyle.Critical, "Error")
                End If
            End If
        End If

        If e.ColumnIndex = 6 Then 'Nro Columna del datagriew
            unUsuario.UsuarioId = id
            unUsuario.Bloqueado = bloqueado
            If id = MenuUI.GetUsuario.UsuarioId Then
                MsgBox("No se puede bloquear el mismo usuario", MsgBoxStyle.Critical, "Error")
            Else
                If bloqueado = True Then 'Bloqueado = True /Usuario Bloqueado
                    bloqueado = False
                    Nombre = "Se Desbloqueo el Usuario: " & NombreUsuario
                    Descr = "Desbloquear"
                Else
                    bloqueado = True
                    Nombre = "Se Bloqueo el Usuario: " & NombreUsuario
                    Descr = "Bloquear"
                End If
                If BLL.Usuario.GetInstance.ValidarEliminarUsuario(BLL.Usuario.GetInstance.ListById(unUsuario)) Then
                    result = MessageBox.Show("¿Esta seguro que desea " & Descr & " el usuario: " & NombreUsuario & "?", Descr & "Usuario", MessageBoxButtons.OKCancel, MessageBoxIcon.Question)
                    If result = DialogResult.OK Then
                        BLL.Usuario.GetInstance.BloquearDesbloquearUsuario(unUsuario)
                        RegistrarBitacora(Nombre, "Alta")
                    End If
                Else
                    MsgBox("No se puede bloquear el usuario ya que quedarian patentes de asignacion obligatoria sin asignar", MsgBoxStyle.Critical, "Error")
                End If
            End If
        End If

        ObtenerUsuarios()
    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Me.Close()
    End Sub

    Public Sub RegistrarBitacora(evento As String, nivel As String)
        Dim SeguridadBLL As New BLL.Seguridad
        BitacoraBE.descripcion = SeguridadBLL.EncriptarRSA(evento)
        BitacoraBE.usuario = MenuUI.GetUsuario
        CriticidadBE.nombre = nivel
        BitacoraBE.criticidad = CriticidadBE
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE)
    End Sub

End Class