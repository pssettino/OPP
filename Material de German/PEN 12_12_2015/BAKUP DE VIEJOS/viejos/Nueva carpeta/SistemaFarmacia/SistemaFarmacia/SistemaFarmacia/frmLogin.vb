Imports System.IO

Public Class frmLogin
    Dim UsuarioBLL As New BLL.Usuario
    Dim SeguridadBLL As New BLL.Seguridad
    Dim IdiomaBLL As New BLL.Idioma
    Dim DVH_BLL As New BLL.DVH
    Dim BitacoraBE As New BE.Bitacora
    Dim CriticidadBE As New BE.Criticidad
    Dim UsuarioBE As New BE.Usuario
    Dim IdiomaBE As New BE.Idioma

    Private Sub btnAceptar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAceptar.Click
        If Validar() Then
            UsuarioBE.NombreUsuario = SeguridadBLL.EncriptarRSA(Trim(txtUsuario.Text))
            UsuarioBE = BLL.Usuario.GetInstance.ValidarContraseña(UsuarioBE)
            If UsuarioBE.UsuarioId = 0 Then
                RegistrarBitacora("Ingreso Incorrecto: " & txtUsuario.Text, "Media")
                txtContraseña.Text = ""
                MsgBox("Ingreso incorrecto a la apliacion, por favor intentelo de nuevo!", MsgBoxStyle.Critical, "Error")
            Else
                If UsuarioBE.Bloqueado = True Then
                    MsgBox("El usuario se encuentra bloqueado. Contacte al Administrador.", MsgBoxStyle.Critical, "Error")
                    txtUsuario.Text = ""
                    txtContraseña.Text = ""
                Else
                    If UsuarioBE.Contraseña <> SeguridadBLL.EncriptarMD5(txtContraseña.Text) Then
                        If UsuarioBE.Eliminado = True Then
                            'ModificarContraseña(UsuarioBE.UsuarioId, txtpass.Text)
                        Else
                            If (DVH_BLL.VerificarDVH = False) Then
                                Dim PatenteBE As New BE.Patente
                                PatenteBE.Nombre = "RecalcularDV"
                                PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
                                If UsuarioBLL.VerificarPatente(UsuarioBE, PatenteBE) Then
                                    If MsgBox("Error en la integridad de la Base de Datos. Es necesario Recalcular los Digitos Verificadores,¿Desea Realizarlo?", MsgBoxStyle.YesNo, "Confirmacion") = MsgBoxResult.Yes Then
                                        DVH_BLL.RecalcularDVH()
                                    Else
                                        Application.Exit()
                                    End If
                                Else
                                    MsgBox("Error en la integridad de la Base de Datos y el usuario no contienen los permisos necesarios.Por favor a contacte al Administrador del sistema.", MsgBoxStyle.Critical, "Error")
                                    Application.Exit()
                                End If
                            End If
                            UsuarioBE.Cci = 0
                            BLL.Usuario.GetInstance.Update(UsuarioBE)
                            RegistrarBitacora("Inicio de Sesion:" & txtUsuario.Text, "Baja")
                            txtUsuario.Text = ""
                            txtContraseña.Text = ""
                            IdiomaBE.IdiomaId = cmbIdioma.SelectedValue
                            Dim MenuUI As New frmMenu(UsuarioBE, IdiomaBE)
                            MenuUI.Show()
                            Me.Hide()
                        End If
                    Else
                        UsuarioBE.Cci = UsuarioBE.Cci + 1
                        BLL.Usuario.GetInstance.Update(UsuarioBE)
                        If UsuarioBE.Cci >= 3 Then
                            If UsuarioBLL.ValidarEliminarUsuario(UsuarioBE) Then
                                UsuarioBE.Bloqueado = True
                                BLL.Usuario.GetInstance.BloquearDesbloquearUsuario(UsuarioBE)
                                MsgBox("Contraseña incorrecta. El usuario ha sido bloqueado", MsgBoxStyle.Critical, "Error")
                                RegistrarBitacora("Se bloqueo el usuario:" & txtUsuario.Text, "Media")
                            Else
                                MsgBox("Contraseña incorrecta", MsgBoxStyle.Critical, "Error")
                                RegistrarBitacora("Ingreso incorrecto contraseña:" & txtUsuario.Text, "Media")
                                txtContraseña.Text = ""
                            End If
                        Else
                            MsgBox("Contraseña incorrecta", MsgBoxStyle.Critical, "Error")
                            RegistrarBitacora("Ingreso incorrecto contraseña:" & txtUsuario.Text, "Media")
                            txtContraseña.Text = ""
                        End If
                    End If
                End If
            End If
        End If
    End Sub

    Private Function Validar() As Boolean
        Dim valido = True
  
        If txtUsuario.Text = "" Then
            valido = False
            MsgBox("Ingrese un mail")
        End If

        If txtContraseña.Text = "" Then
            valido = False
            MsgBox("Ingrese el password")
        End If

        Return valido
    End Function


    Private Sub btnCancelar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancelar.Click
        Application.Exit()
    End Sub

    Private Sub frmLogin_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Try
            Dim returnValue As Boolean = False
            returnValue = True

            If (File.Exists("Servidor.txt") = True) Then
                'If (SeguridadBLL.ValidarServidor(File.ReadAllText("Servidor.txt")) = False) Then
                returnValue = True
                'End If
            Else
                'If frmServidor.ShowDialog() <> Windows.Forms.DialogResult.OK Then
                '    Application.Exit()
                'End If
            End If
            ObtenerIdioma()
        Catch ex As Exception
            MsgBox("Error Inesperado, contacte al administrador")
        End Try
    End Sub

    Public Sub RegistrarBitacora(evento As String, nivel As String)
        Dim SeguridadBLL As New BLL.Seguridad
        BitacoraBE.Descripcion = SeguridadBLL.EncriptarRSA(evento)
        BitacoraBE.usuario = UsuarioBE
        CriticidadBE.nombre = nivel
        BitacoraBE.criticidad = CriticidadBE
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE)
    End Sub


    Public Sub ObtenerIdioma()
        Dim IdiomaBLL As New BLL.Idioma
        cmbIdioma.Items.Clear()
        Dim Idioma = IdiomaBLL.ObtenerIdiomas()
        cmbIdioma.DataSource = Idioma
        cmbIdioma.DisplayMember = "Nombre"
        cmbIdioma.ValueMember = "IdiomaId"
    End Sub
End Class
