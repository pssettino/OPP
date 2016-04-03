Public Class frmRestore
    Dim origen, origen2, origen3 As String
    Dim usu As New BE.Usuario
    Private Sub checkMultivolumen_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles checkMultivolumen.CheckedChanged
        If checkMultivolumen.CheckState = CheckState.Checked Then
            'If usu.IdIdioma = 1 Then
            '    lblPrimeraParte.Text = "Primera Parte:"
            'Else
            '    lblPrimeraParte.Text = "First Part:"
            'End If
            lblSegundaParte.Visible = True
            lblTerceraParte.Visible = True
            txtOrigen2.Visible = True
            txtOrigen2.Enabled = False
            txtOrigen3.Visible = True
            txtOrigen3.Enabled = False
            btnExaminar2.Visible = True
            btnExaminar3.Visible = True
        Else
            lblSegundaParte.Visible = False
            lblTerceraParte.Visible = False
            txtOrigen2.Visible = False
            txtOrigen2.Enabled = True
            txtOrigen3.Visible = False
            txtOrigen3.Enabled = True
            btnExaminar2.Visible = False
            btnExaminar3.Visible = False
        End If
    End Sub

    Private Sub btnExaminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExaminar.Click
        Dim oa As New OpenFileDialog
        oa.ShowDialog()
        If oa.FileName = "" Then
            txtOrigenRestore.Enabled = False
        Else
            txtOrigenRestore.Enabled = True
            txtOrigenRestore.Text = oa.FileName
        End If
    End Sub

    Private Sub btnExaminar2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExaminar2.Click
        Dim oa As New OpenFileDialog
        oa.ShowDialog()
        If oa.FileName = "" Then
            txtOrigen2.Enabled = False
        Else
            txtOrigen2.Enabled = True
            txtOrigen2.Text = oa.FileName
        End If
    End Sub

    Private Sub btnExaminar3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExaminar3.Click
        Dim oa As New OpenFileDialog
        oa.ShowDialog()
        If oa.FileName = "" Then
            txtOrigen3.Enabled = False
        Else
            txtOrigen3.Enabled = True
            txtOrigen3.Text = oa.FileName
        End If
    End Sub

    Private Sub btnRestaurar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRestaurar.Click
        Dim restorebool As Boolean

        Try
            If txtOrigenRestore.Enabled = False Then
                'If usu.IdIdioma = 1 Then
                '    MsgBox("Por favor, seleccione primero el origen.", MsgBoxStyle.Exclamation, "Atención!")
                'Else
                '    MsgBox("Please, select the source first.", MsgBoxStyle.Exclamation, "Atention!")
                'End If
            ElseIf checkMultivolumen.CheckState = CheckState.Checked Then
                If txtOrigen3.Text = "" Then
                    origen = txtOrigenRestore.Text
                    origen2 = txtOrigen2.Text

                    BLL.Seguridad.GetInstance.HacerMultiRestore(origen, origen2)

                Else
                    origen = txtOrigenRestore.Text
                    origen2 = txtOrigen2.Text
                    origen3 = txtOrigen3.Text
                    BLL.Seguridad.GetInstance.HacerMultiRestore2(origen, origen2, origen3)
                    'BLL.BLLBitacora.DameInstancia.EscribirBitacora(BLL.BLLBitacora.DameInstancia.GenerarBitacora(usu.IdUsuario, 39, 2, Date.Now))
                    'If usu.IdIdioma = 1 Then
                    MsgBox("El Restore se ha realizado con éxito!", MsgBoxStyle.Information, "Restore del sistema")
                    'Else
                    '    MsgBox("The Restore has been successfully done!", MsgBoxStyle.Information, "System Restore")
                    'End If
                End If
            Else


                origen = txtOrigenRestore.Text

                'Registro BKP en la bitacora
                BLL.Seguridad.GetInstance.HacerRestore(origen)



                Dim objbitacora As New BE.Bitacora
                objbitacora._desc = "Restore"
                objbitacora._fecha = Now
                objbitacora._usu_id._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
                objbitacora._crit_id._id = BLL.Criticidad.GetInstance.RecuperarId(New BE.Criticidad("Alto"))
                objbitacora._usu_log = frmlogin.TextBox1.Text
                objbitacora._dvh = BLL.Seguridad.GetInstance.CalcularDVHBitacora(objbitacora)
                BLL.Bitacora.GetInstance.RegistrarBitacora(objbitacora)

                BLL.Seguridad.GetInstance.ReCalcularDVV("BITACORA")


                'BLL.BLLBitacora.DameInstancia.EscribirBitacora(BLL.BLLBitacora.DameInstancia.GenerarBitacora(usu.IdUsuario, 39, 2, Date.Now))
                'If usu.IdIdioma = 1 Then
                MsgBox("El Restore se ha realizado con éxito!", MsgBoxStyle.Information, "Restore del sistema")
            End If


            MsgBox("El Sistema debe ser reiniciado para efectuar los cambios !", MsgBoxStyle.Information, "Restore")
            UISQLConfig.Dispose()
            frmUsuario.Dispose()
            frmBitacora.Dispose()
            frmPrincipal.Close()


        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub btnCancelar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Me.Close()
    End Sub

    Private Sub frmRestore_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        'Ayuda
        If e.KeyCode = 112 Then
            Help.ShowHelp(Me, BLL.Seguridad.ConsultarHelp().HelpFile, HelpNavigator.TopicId, "9")
        End If
    End Sub


    Private Sub frmRestore_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim objPat As New BE.Patente
        Dim usu As New BE.Usuario
        objPat._id = 11

        usu._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
        objPat._desc = "Restore"
        If BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = True Then
            If BLL.Seguridad.GetInstance.VerificarPermisosNegUsuPat(objPat, usu) = False Then
                MsgBox("No posee permisos para realizar esta accion", MsgBoxStyle.Information, "Patentes")
                Me.Close()
            Else
                Me.Enabled = True
            End If
        ElseIf BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = False Then
            If BLL.Seguridad.GetInstance.VerificarPermisosUsuPat(objPat, usu) = True Then
                Me.Enabled = True
            Else
                MsgBox("No posee permisos para realizar esta accion", MsgBoxStyle.Information, "Patentes")
                Me.Close()

            End If
        End If
    End Sub
End Class