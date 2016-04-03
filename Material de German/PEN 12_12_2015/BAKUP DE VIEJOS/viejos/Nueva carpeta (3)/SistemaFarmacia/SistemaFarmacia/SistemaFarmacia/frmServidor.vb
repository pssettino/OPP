Imports System.IO

Public Class frmServidor
    Dim SeguridadBLL As New BLL.Seguridad

    Public Sub New()
        InitializeComponent()
    End Sub

    Private Function Validar() As Boolean
        Dim valido = True
        lblServidorError.Visible = False
        If txtServidor.Text = "" Then
            valido = False
            lblServidorError.Visible = True
            lblServidorError.Text = "Campo requerido"
        ElseIf (SeguridadBLL.ValidarServidor(txtServidor.Text)) = False Then
            valido = False
            lblServidorError.Visible = True
            lblServidorError.Text = "Servidor SQL incorrecto"
        End If
        Return valido
    End Function

    Private Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click
        If Validar() Then
            File.WriteAllText("AccederServidorSQL.txt", txtServidor.Text)
            Me.DialogResult = Windows.Forms.DialogResult.OK
            Me.Close()
        End If
    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Application.Exit()
    End Sub

 
End Class