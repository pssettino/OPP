Imports System.IO

Public Class frmRestore
    Dim MenuUI As UI.frmMenu
    Dim UsuarioBLL As New BLL.Usuario
    Dim BackupBLL As New BLL.Backup
    Dim SeguridadBLL As New BLL.Seguridad
    Dim BitacoraBE As New BE.Bitacora
    Dim CriticidadBE As New BE.Criticidad
    Dim TraduccionBLL As BLL.Traduccion

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Me.Close()
    End Sub

    Private Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click
        If Validar() Then
            Dim BackupBE As New BE.Backup
            BackupBE.archivo = lstArchivo.SelectedItem.ToString
            RegistrarBitacora("Se hizo un restore del sistema", "Alta")
            BackupBLL.ImportarRar(BackupBE)
            MsgBox(TraduccionBLL.TraducirTexto("El restore fue hecho con exito"), MsgBoxStyle.DefaultButton1, TraduccionBLL.TraducirTexto("Restore"))
        End If
    End Sub


    Private Sub txtruta_TextChanged(sender As Object, e As EventArgs) Handles txtRuta.TextChanged
        If Directory.Exists(txtRuta.Text) Then
            Dim LfilesInDir As New List(Of String)
            For Each File In Directory.EnumerateFiles(txtRuta.Text)
                Dim sinExt = File.Substring(0, File.Length - 4)
                If sinExt.EndsWith(".dbk") Then LfilesInDir.Add(sinExt)
            Next
            LfilesInDir.Sort()
            lstArchivo.DataSource = Nothing
            lstArchivo.Items.Clear()
            lstArchivo.DataSource = LfilesInDir.Distinct().ToArray()
        End If
    End Sub

    Private Sub btnCarpeta_Click(sender As Object, e As EventArgs) Handles btnCarpeta.Click
        If FolderBrowserDialog1.ShowDialog() = DialogResult.OK Then
            txtRuta.Text = FolderBrowserDialog1.SelectedPath
        End If
    End Sub

    Private Function Validar() As Boolean
        Dim valido = True
        If txtRuta.Text = "" Then
            valido = False
            MsgBox("Campo requerido")
        End If
        Return valido
    End Function

    Public Sub RegistrarBitacora(evento As String, nivel As String)
        BitacoraBE.descripcion = SeguridadBLL.EncriptarRSA(evento)
        BitacoraBE.usuario = MenuUI.GetUsuario
        CriticidadBE.nombre = nivel
        BitacoraBE.criticidad = CriticidadBE
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE)
    End Sub

    Private Sub frmRestore_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        MenuUI = Me.MdiParent
        TraduccionBLL = New BLL.Traduccion(MenuUI.GetIdioma)
        TraduccionBLL.TraducirForm(Me)
    End Sub
End Class