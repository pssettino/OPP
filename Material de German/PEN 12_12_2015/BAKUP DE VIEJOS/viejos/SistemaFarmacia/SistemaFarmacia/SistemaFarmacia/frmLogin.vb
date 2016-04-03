Public Class frmLogin
    Dim UsuarioBE As New BE.Usuario
    Dim IdiomaBE As New BE.Idioma
    Dim MenuUI As New frmMenu(UsuarioBE, IdiomaBE)

    Private Sub btnAceptar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAceptar.Click
        Try
            'Dim unUsuario As New BE.Usuario With {.NombreUsuario = UsernameTextBox.Text, .Contraseña = PasswordTextBox.Text}

            'If BLL.Usuario.GetInstance().ValidarContraseña(unUsuario) Then
            UsuarioBE.UsuarioId = 9
            UsuarioBE.Nombre = "Administrador"
            IdiomaBE.IdiomaId = cmbIdioma.SelectedValue
            MenuUI.GetUsuario()
            MenuUI.GetIdioma()
            MenuUI.Show()
            Me.Hide()
            'Else
            'Application.Exit()
            'End If
        Catch ex As Exception
            MsgBox("Error Inesperado, contacte al administrador")
        End Try
    End Sub

    Private Sub btnCancelar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancelar.Click
        Application.Exit()
    End Sub

    Private Sub frmLogin_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Try
            Dim IdiomaBLL As New BLL.Idioma
            cmbIdioma.Items.Clear()
            Dim Idioma = IdiomaBLL.ObtenerIdiomas()
            cmbIdioma.DataSource = Idioma
            cmbIdioma.DisplayMember = "Nombre"
            cmbIdioma.ValueMember = "IdiomaId"
        Catch ex As Exception
            MsgBox("Error Inesperado, contacte al administrador")
        End Try
    End Sub
End Class
