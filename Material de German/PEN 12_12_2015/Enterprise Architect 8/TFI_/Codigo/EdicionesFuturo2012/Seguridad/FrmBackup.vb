Public Class FrmBackup
    Dim destino, destino2, destino3 As String
    Dim usu As New BE.Usuario
    Private Sub FrmBackup_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim objPat As New BE.Patente
        Dim usu As New BE.Usuario
        objPat._id = 10

        usu._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
        objPat._desc = "Backup"
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
        lblvol1.Visible = True
        lblDestino2.Visible = False
        lblDestino3.Visible = False
        txtDestino2.Visible = False
        txtDestino3.Visible = False
        btnExaminar2.Visible = False
        btnExaminar3.Visible = False

    End Sub


    Private Sub btnExaminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExaminar.Click
        Dim sa As New SaveFileDialog
        sa.ShowDialog()
        If sa.FileName = "" Then
            txtDestino.Enabled = False
        Else
            txtDestino.Enabled = True
            txtDestino.Text = sa.FileName
        End If
    End Sub
    Private Sub btnExaminar3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExaminar3.Click
        Dim sa3 As New SaveFileDialog
        sa3.ShowDialog()
        If sa3.FileName = "" Then
            txtDestino3.Enabled = False
        Else
            txtDestino3.Enabled = True
            txtDestino3.Text = sa3.FileName
        End If
    End Sub
    Private Sub btnExaminar2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExaminar2.Click
        Dim sa2 As New SaveFileDialog
        sa2.ShowDialog()
        If sa2.FileName = "" Then
            txtDestino2.Enabled = False
        Else
            txtDestino2.Enabled = True
            txtDestino2.Text = sa2.FileName
        End If
    End Sub
    Private Sub btnGenerarBKP_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnGenerarBKP.Click
        Try
            If txtDestino.Enabled = False Then

            ElseIf checkMultivolumen.CheckState = CheckState.Checked Then
                If txtDestino3.Text = "" Then
                    destino = txtDestino.Text
                    destino2 = txtDestino2.Text
                    BLL.Seguridad.GetInstance.GenerarBKPMulti(destino, destino2)
                Else
                    destino = txtDestino.Text
                    destino2 = txtDestino2.Text
                    destino3 = txtDestino3.Text
                    BLL.Seguridad.GetInstance.GenerarBKPMulti2(destino, destino2, destino3)
                End If
            Else
                destino = txtDestino.Text
                BLL.Seguridad.GetInstance.GenerarBKP(destino)

            End If
            MsgBox("Backup Exitoso!", MsgBoxStyle.Information)
        Catch ex As Exception
            Throw ex
        End Try

        'Registro BKP en la bitacora
        Dim objbitacora As New BE.Bitacora
        objbitacora._desc = "Backup"
        objbitacora._fecha = Now
        objbitacora._usu_id._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
        objbitacora._crit_id._id = BLL.Criticidad.GetInstance.RecuperarId(New BE.Criticidad("Alto"))
        objbitacora._usu_log = frmlogin.TextBox1.Text
        objbitacora._dvh = BLL.Seguridad.GetInstance.CalcularDVHBitacora(objbitacora)
        BLL.Bitacora.GetInstance.RegistrarBitacora(objbitacora)
        BLL.Seguridad.GetInstance.ReCalcularDVV("BITACORA")
    End Sub


    Private Sub checkMultivolumen_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles checkMultivolumen.CheckedChanged

        If checkMultivolumen.CheckState = CheckState.Checked Then
            lblDestino2.Visible = True
            lblDestino3.Visible = True
            txtDestino2.Visible = True
            txtDestino3.Visible = True
            btnExaminar2.Visible = True
            btnExaminar3.Visible = True
        Else
            lblDestino2.Visible = False
            lblDestino3.Visible = False
            txtDestino2.Visible = False
            txtDestino3.Visible = False
            btnExaminar2.Visible = False
            btnExaminar3.Visible = False
        End If

    End Sub

    Private Sub FrmBackup_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        'Ayuda
        If e.KeyCode = 112 Then
            Help.ShowHelp(Me, BLL.Seguridad.ConsultarHelp().HelpFile, HelpNavigator.TopicId, "9")
        End If
    End Sub

End Class