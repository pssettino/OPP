Imports System.IO


Public Class frmLogin
    Dim UsuarioBLL As New BLL.Usuario
    Dim SeguridadBLL As New BLL.Seguridad
    Dim IdiomaBLL As New BLL.Idioma
    Dim DVH_BLL As New BLL.DVH
    Dim BitacoraBE As New BE.Bitacora
    Dim UsuarioBE As New BE.Usuario
    Dim IdiomaBE As New BE.Idioma

    Private Shared worker As System.ComponentModel.BackgroundWorker

    Private Shared workerIntegridad As System.ComponentModel.BackgroundWorker
    Private Delegate Sub LoginDelegate()

    Private Sub btnAceptar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAceptar.Click
        Progress.Show()

        If (worker Is Nothing) Then
            worker = New System.ComponentModel.BackgroundWorker()
            AddHandler worker.DoWork, AddressOf LogIn
            worker.WorkerSupportsCancellation = True
        End If
        worker.RunWorkerAsync() 'pasarle parametros
    End Sub

    Public Sub LogIn()
            If Validar() Then
                UsuarioBE.NombreUsuario = SeguridadBLL.EncriptarRSA(Trim(txtUsuario.Text))
                UsuarioBE = BLL.Usuario.GetInstance.ValidarContraseña(UsuarioBE)
            If UsuarioBE.UsuarioId = 0 Then
                RegistrarBitacora("Ingreso Incorrecto: " & txtUsuario.Text, "Media")
                limpiarTxt()
                MsgBox("Ingreso incorrecto a la apliacion, por favor intentelo de nuevo!", MsgBoxStyle.Critical, "Error")
            Else
                If UsuarioBE.Eliminado = True Then
                    MsgBox("El usuario se encuentra eliminado. Contacte al Administrador.", MsgBoxStyle.Critical, "Error")
                    txtUsuario.Text = ""
                    txtContraseña.Text = ""
                    txtUsuario.Focus()
                Else
                    If UsuarioBE.Bloqueado = True Then
                        MsgBox("El usuario se encuentra bloqueado. Contacte al Administrador.", MsgBoxStyle.Critical, "Error")
                        txtUsuario.Text = ""
                        txtContraseña.Text = ""
                        txtUsuario.Focus()
                    Else
                        If UsuarioBE.Contraseña = SeguridadBLL.EncriptarMD5(Trim(txtContraseña.Text)) Then
                            If UsuarioBE.Eliminado = False Then
                                If (DVH_BLL.VerificarDVH(UsuarioBE) = False) Then
                                    Dim PatenteBE As New BE.Patente
                                    PatenteBE.Nombre = "RecalcularDV"
                                    PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
                                    If UsuarioBLL.VerificarPatente(UsuarioBE, PatenteBE) Then
                                        If MsgBox("Error al verificar la integridad de la Base de Datos. ¿Desea Recalcular los Digitos Verificadores? ", MsgBoxStyle.YesNo, "Confirmacion") = MsgBoxResult.Yes Then
                                            DVH_BLL.RecalcularDVH()
                                        Else
                                            Application.Exit()
                                        End If
                                    Else
                                        MsgBox("Error al verificar la integridad de la Base de Datos. Por favor a contacte al Administrador del sistema.", MsgBoxStyle.Critical, "Error")
                                        Application.Exit()
                                    End If
                                End If
                                UsuarioBE.Cci = 0
                                BLL.Usuario.GetInstance.Update(UsuarioBE)
                                RegistrarBitacora("LogIn", "Baja")
                                limpiarForm()
                            End If
                        Else
                            UsuarioBE.Cci = UsuarioBE.Cci + 1
                            BLL.Usuario.GetInstance.Update(UsuarioBE)
                            If UsuarioBE.Cci >= 3 Then
                                If UsuarioBLL.ValidarEliminarUsuario(UsuarioBE) Then
                                    UsuarioBE.Bloqueado = True
                                    BLL.Usuario.GetInstance.BloquearDesbloquearUsuario(UsuarioBE)
                                    MsgBox("Contraseña incorrecta. El usuario ha sido bloqueado!", MsgBoxStyle.Critical, "Error")
                                    RegistrarBitacora("Se bloqueo el usuario:" & txtUsuario.Text, "Alta")
                                Else
                                    UsuarioBE.Contraseña = SeguridadBLL.EncriptarMD5(Trim(SeguridadBLL.AutoGenerarContraseña(UsuarioBE, True)))
                                    UsuarioBE.Cci = 0
                                    BLL.Usuario.GetInstance.Update(UsuarioBE)
                                    RegistrarBitacora("Modifico Usuario (restablecio la contraseña): " & txtUsuario.Text, "Alta")
                                    MsgBox("Contraseña incorrecta, Como el usuario contiene patentes esenciales se restableció la contraseña!", MsgBoxStyle.Critical, "Error")
                                    RegistrarBitacora("Ingreso incorrecto contraseña:" & txtUsuario.Text, "Media")
                                End If
                            Else
                                MsgBox("Contraseña incorrecta", MsgBoxStyle.Critical, "Error")
                                RegistrarBitacora("Ingreso incorrecto contraseña:" & txtUsuario.Text, "Media")
                                limpiarTxt()
                            End If
                        End If
                    End If
                End If
            End If
            End If
    End Sub

    Public Sub limpiarForm()
        If (Me.InvokeRequired) Then
            Dim t As New LoginDelegate(AddressOf LogIn)
            Me.Invoke(t)
        Else
            txtUsuario.Text = ""
            txtContraseña.Text = ""
            IdiomaBE.IdiomaId = cmbIdioma.SelectedValue
            Dim MenuUI As New frmMenu(UsuarioBE, IdiomaBE)
            Progress.Hide()
            MenuUI.Show()
            Me.Hide()
        End If
    End Sub

    Public Sub limpiarTxt()
        If (Me.InvokeRequired) Then
            Dim t As New LoginDelegate(AddressOf LogIn)
            Me.Invoke(t)
        Else
            txtContraseña.Text = ""
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
            ObtenerIdioma()
        Catch ex As Exception
            MsgBox("Error Inesperado, contacte al administrador")
        End Try
    End Sub

    Public Sub RegistrarBitacora(evento As String, nivel As String)
        Dim SeguridadBLL As New BLL.Seguridad
        BitacoraBE.Descripcion = SeguridadBLL.EncriptarRSA(evento)
        BitacoraBE.usuario = UsuarioBE
        BitacoraBE.criticidad = nivel
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
