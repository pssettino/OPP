Public Class frmCambiarContraseña
    Dim BitacoraBE As New BE.Bitacora
    Dim MenuUI As UI.frmMenu
    Dim TraduccionBLL As BLL.Traduccion
    Dim SeguridadBLL As New BLL.Seguridad

    Private Function Validar() As Boolean
        Dim valido = True
        lblContraseñaAnteriorE.Visible = False
        If txtContraseñaAnterior.Text = "" Then
            valido = False
            lblContraseñaAnteriorE.Visible = True
            lblContraseñaAnteriorE.Text = "Ingrese la Contraseña Anterior"
        Else
            If SeguridadBLL.EncriptarMD5(Trim(txtContraseñaAnterior.Text)) <> ObtenerContraseña() Then
                valido = False
                MsgBox("La Contraseña Anterior es invalida!", MsgBoxStyle.Critical, "Error")
                limpiar()
            End If
        End If
        lblContraseñaNuevaE.Visible = False
        If txtContraseñaNueva.Text = "" Then
            valido = False
            lblContraseñaNuevaE.Visible = True
            lblContraseñaNuevaE.Text = "Ingrese la Contraseña Nueva"
        End If
        lblConfirmarContresañaE.Visible = False
        If txtContraseñaConfirmar.Text = "" Then
            valido = False
            lblConfirmarContresañaE.Visible = True
            lblConfirmarContresañaE.Text = "Ingrese la Contraseña Nueva"
        Else
            If Trim(txtContraseñaNueva.Text) <> Trim(txtContraseñaConfirmar.Text) Then
                valido = False
                MsgBox("No coinciden las contraseñas!", MsgBoxStyle.Critical, "Error")
                limpiar()
            End If
        End If
        Return valido
    End Function

    Private Sub limpiar()
        txtContraseñaAnterior.Text = ""
        txtContraseñaConfirmar.Text = ""
        txtContraseñaNueva.Text = ""
    End Sub
    Private Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click
        If Validar() Then
            Dim UsuarioBE As New BE.Usuario
            UsuarioBE = BLL.Usuario.GetInstance.ListById(MenuUI.GetUsuario)
            UsuarioBE.Contraseña = SeguridadBLL.EncriptarMD5(Trim(txtContraseñaConfirmar.Text))
            BLL.Usuario.GetInstance.Update(UsuarioBE)
            Dim nombreUsuario As String = SeguridadBLL.DesencriptarRSA(UsuarioBE.NombreUsuario)
            MessageBox.Show(TraduccionBLL.TraducirTexto("Se Cambio la Contraseña") & ": " & nombreUsuario, TraduccionBLL.TraducirTexto("Cambiar Contraseña"), MessageBoxButtons.OK, MessageBoxIcon.Information)
            RegistrarBitacora("Se Cambio la Contraseña: " & nombreUsuario, "Alta")
            Me.DialogResult = Windows.Forms.DialogResult.OK
            Me.Close()
        End If
    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Me.Close()
    End Sub

    Private Function ObtenerContraseña() As String
        Try
            Dim UsuarioBE As New BE.Usuario
            UsuarioBE = BLL.Usuario.GetInstance.ValidarContraseña(MenuUI.GetUsuario)
            Return UsuarioBE.Contraseña
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Sub RegistrarBitacora(evento As String, nivel As String)
        Dim SeguridadBLL As New BLL.Seguridad
        BitacoraBE.Descripcion = SeguridadBLL.EncriptarRSA(evento)
        BitacoraBE.usuario = MenuUI.GetUsuario
        BitacoraBE.criticidad = nivel
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE)
    End Sub

    Private Sub frmCambiarContraseña_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        MenuUI = Me.MdiParent
        TraduccionBLL = New BLL.Traduccion(MenuUI.GetIdioma)
        TraduccionBLL.TraducirForm(Me)
    End Sub
End Class