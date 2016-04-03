Public Class frmUsuarios

    Dim BitacoraBE As New BE.Bitacora
    Dim unUsuario As New BE.Usuario
    Dim MenuUI As UI.frmMenu
    Dim TraduccionBLL As BLL.Traduccion


    Private Sub frmUsuarios_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        MenuUI = Me.MdiParent
        TraduccionBLL = New BLL.Traduccion(MenuUI.GetIdioma)
        Dim PatenteBE As New BE.Patente
        PatenteBE.Nombre = "Usuario"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If (BLL.Usuario.GetInstance.VerificarPatente(MenuUI.GetUsuario, PatenteBE) = False) Then
            MsgBox(TraduccionBLL.TraducirTexto("Sus permisos han sido modificados, por favor inicie sesion nuevamente"), MsgBoxStyle.Critical, TraduccionBLL.TraducirTexto("Error"))
            Application.Exit()
        End If
        TraduccionBLL.TraducirForm(Me)
        ObtenerUsuarios()
    End Sub

    Private Sub btnRegistrar_Click(sender As Object, e As EventArgs) Handles btnRegistrar.Click
        Dim UsuarioRegistrar As New frmUsuariosMod()
        UsuarioRegistrar.btnRestablecer.Enabled = False
        If UsuarioRegistrar.ShowDialog(Me) = Windows.Forms.DialogResult.OK Then
            ObtenerUsuarios()
        End If
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
            Dim dgUsuarioBtnEliminado = New DataGridViewButtonCell()
            If UsuarioBE.Eliminado = True Then
                dgUsuarioBtnEliminado.Value = TraduccionBLL.TraducirTexto("Activar")
                dgUsuarioBtnEliminado.Style.ForeColor = Color.Aquamarine
             Else
                dgUsuarioBtnEliminado.Value = TraduccionBLL.TraducirTexto("Eliminar")
             End If
            dgUsuarios.Rows.Item(n).Cells("dgUsuarioBtnEliminado") = dgUsuarioBtnEliminado

            Dim dgUsuarioBtnBloqueado = New DataGridViewButtonCell()
            If UsuarioBE.Bloqueado = True Then
                dgUsuarioBtnBloqueado.Value = TraduccionBLL.TraducirTexto("Desbloquear")
            Else
                dgUsuarioBtnBloqueado.Value = TraduccionBLL.TraducirTexto("Bloquear")
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
                MsgBox(TraduccionBLL.TraducirTexto("No se puede eliminar el mismo usuario"), MsgBoxStyle.Critical, TraduccionBLL.TraducirTexto("Error"))
            Else
                If BLL.Usuario.GetInstance.ValidarEliminarUsuario(BLL.Usuario.GetInstance.ListById(unUsuario)) Then
                    If eliminado = True Then
                        eliminado = False
                        Descr = "Activar"
                        Nombre = "Se activo el Usuario: " & NombreUsuario
                    Else
                        eliminado = True
                        Descr = "Eliminar"
                        Nombre = "Elimino Usuario: " & NombreUsuario
                    End If
                    result = MessageBox.Show(TraduccionBLL.TraducirTexto("¿Esta seguro que desea " & Descr & " el usuario") & ": " & NombreUsuario & "?", TraduccionBLL.TraducirTexto(Descr & " Usuario"), MessageBoxButtons.OKCancel, MessageBoxIcon.Question)
                    If result = DialogResult.OK Then
                        unUsuario.Eliminado = eliminado
                        BLL.Usuario.GetInstance.Delete(unUsuario)
                        RegistrarBitacora(Nombre, "Alta")
                    End If
                Else
                    MsgBox(TraduccionBLL.TraducirTexto("No se puede eliminar el usuario porque quedarian patentes esenciales sin asignar"), MsgBoxStyle.Critical, TraduccionBLL.TraducirTexto("Error"))
                End If
            End If
        End If

        If e.ColumnIndex = 6 Then 'Nro Columna del datagriew
            unUsuario.UsuarioId = id
            unUsuario.Bloqueado = bloqueado
            If id = MenuUI.GetUsuario.UsuarioId Then
                MsgBox(TraduccionBLL.TraducirTexto("No se puede bloquear el mismo usuario"), MsgBoxStyle.Critical, TraduccionBLL.TraducirTexto("Error"))
            Else
                If BLL.Usuario.GetInstance.ValidarEliminarUsuario(BLL.Usuario.GetInstance.ListById(unUsuario)) Then
                    If bloqueado = True Then 'Bloqueado = True /Usuario Bloqueado
                        bloqueado = False
                        Nombre = "Se Desbloqueo el Usuario: " & NombreUsuario
                        Descr = "Desbloquear"
                    Else
                        bloqueado = True
                        Nombre = "Se Bloqueo el Usuario: " & NombreUsuario
                        Descr = "Bloquear"
                    End If
                    result = MessageBox.Show(TraduccionBLL.TraducirTexto("¿Esta seguro que desea " & Descr & " el usuario") & ": " & NombreUsuario & "?", TraduccionBLL.TraducirTexto(Descr & " Usuario"), MessageBoxButtons.OKCancel, MessageBoxIcon.Question)
                    If result = DialogResult.OK Then
                        unUsuario.Bloqueado = bloqueado
                        BLL.Usuario.GetInstance.BloquearDesbloquearUsuario(unUsuario)
                        RegistrarBitacora(Nombre, "Alta")
                    End If
                Else
                    MsgBox(TraduccionBLL.TraducirTexto("No se puede bloquear el usuario porque quedarian patentes esenciales sin asignar"), MsgBoxStyle.Critical, TraduccionBLL.TraducirTexto("Error"))
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
        BitacoraBE.criticidad = nivel
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE)
    End Sub

End Class