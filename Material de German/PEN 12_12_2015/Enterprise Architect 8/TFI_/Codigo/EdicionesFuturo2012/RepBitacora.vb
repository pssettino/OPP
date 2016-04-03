Public Class RepBitacora

    Private Sub RepBitacora_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'TODO: esta línea de código carga datos en la tabla 'EdicionesDataSet.Bitacora' Puede moverla o quitarla según sea necesario.

        ''Habilito o deshabilito form segun permisos
        Dim objPat As New BE.Patente
        Dim usu As New BE.Usuario
        objPat._id = 12

        usu._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
        objPat._desc = "Reportes"
        If BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = True Then
            If BLL.Seguridad.GetInstance.VerificarPermisosNegUsuPat(objPat, usu) = False Then
                MsgBox("No posee permisos para realizar esta accion", MsgBoxStyle.Information)
                Me.Close()
            Else
                Me.Enabled = True
            End If
        ElseIf BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = False Then
            If BLL.Seguridad.GetInstance.VerificarPermisosUsuPat(objPat, usu) = True Then
                Me.Enabled = True
            Else
                MsgBox("No posee permisos para realizar esta accion", MsgBoxStyle.Information)
                Me.Close()

            End If
        End If
        Me.BitacoraTableAdapter.Fill(Me.EdicionesDataSet.Bitacora)

        Me.ReportViewer1.RefreshReport()
    End Sub
End Class