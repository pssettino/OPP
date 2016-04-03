Imports System.IO

Public Class frmBackup
    Dim MenuUI As UI.frmMenu
    Dim UsuarioBLL As New BLL.Usuario
    Dim BackupBLL As New BLL.Backup
    Dim SeguridadBLL As New BLL.Seguridad
    Dim BitacoraBE As New BE.Bitacora
    Dim TraduccionBLL As BLL.Traduccion

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Me.Close()
    End Sub

    Protected Overrides Sub OnLoad(e As EventArgs)
        MenuUI = Me.MdiParent
        TraduccionBLL = New BLL.Traduccion(MenuUI.GetIdioma)
        Dim PatenteBE As New BE.Patente
        PatenteBE.Nombre = "Backup"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If (BLL.Usuario.GetInstance.VerificarPatente(MenuUI.GetUsuario, PatenteBE) = False) Then
            MsgBox(TraduccionBLL.TraducirTexto("Sus permisos han sido modificados, por favor inicie sesion nuevamente"), MsgBoxStyle.Critical, TraduccionBLL.TraducirTexto("Error"))
            Application.Exit()
        End If
        TraduccionBLL.TraducirForm(Me)
    End Sub

    Private Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click
        If Validar() Then
            DescargarRar()
        End If
    End Sub

    Private Sub btnCarpeta_Click(sender As Object, e As EventArgs) Handles btnCarpeta.Click
        If FolderBrowserDialog1.ShowDialog() = DialogResult.OK Then
            txtruta.Text = FolderBrowserDialog1.SelectedPath
        End If
    End Sub

    Public Sub DescargarRar()
        If txtruta.Text.Trim <> "" Then
            Dim BackupBE As New BE.Backup
            BackupBE.ubicacion = txtruta.Text
            Dim valor = 0
            BackupBE.cantidad = nudValor.Value.ToString
            valor = nudValor.Value.ToString
            If (BackupBLL.GenerarRar(BackupBE)) Then
                RegistrarBitacora("Se hizo un backup del sistema", "Media")
                MsgBox(TraduccionBLL.TraducirTexto("El backup fue hecho con exito"), MsgBoxStyle.DefaultButton1, TraduccionBLL.TraducirTexto("Backup"))
            Else
                MsgBox(TraduccionBLL.TraducirTexto("El backup no puede realizarse en el directorio indicado, por favor seleccione otro"), MsgBoxStyle.Critical, TraduccionBLL.TraducirTexto("Error"))
            End If
        End If
    End Sub

    Private Function Validar() As Boolean
        Dim valido = True
        If Directory.Exists(txtruta.Text) = False Then
            valido = False
            MsgBox(TraduccionBLL.TraducirTexto("La Ruta no existe!"), MsgBoxStyle.Critical, "Error")
        End If
        If txtruta.Text = "" Then
            valido = False
            MsgBox(TraduccionBLL.TraducirTexto("Ingrese la Ruta"), MsgBoxStyle.Critical, "Error")
        End If
        Return valido
    End Function

    Public Sub RegistrarBitacora(evento As String, nivel As String)
        BitacoraBE.descripcion = SeguridadBLL.EncriptarRSA(evento)
        BitacoraBE.usuario = MenuUI.GetUsuario
        BitacoraBE.criticidad = nivel
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE)
    End Sub
End Class