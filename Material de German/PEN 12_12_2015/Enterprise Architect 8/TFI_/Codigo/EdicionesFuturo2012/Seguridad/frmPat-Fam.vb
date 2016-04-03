Public Class frmPatFam


    Private Sub frmPatFam_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        'Ayuda
        If e.KeyCode = 112 Then
            Help.ShowHelp(Me, BLL.Seguridad.ConsultarHelp().HelpFile, HelpNavigator.TopicId, "8")
        End If
    End Sub

    Private Sub lstDisponibles_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lstFamDisponibles.SelectedIndexChanged
        lstPatDisponibles.DataSource = BLL.Patente.GetInstance.Listar
    End Sub

    Private Sub lstAsignadas_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lstFamDisponibles.Click
        ''Traigo patentes asignadas a la familia que consulto
        Dim oPatFam As New BE.Familia
        oPatFam._id = DirectCast(lstFamDisponibles.SelectedItem, BE.Familia)._id
        lstPatAsignadas.DataSource = BLL.Patente.GetInstance.ListarPatentesxFamilia(oPatFam)
    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click
        lstPatDisponibles.DataSource = BLL.Patente.GetInstance.Listar
        lstFamDisponibles.DataSource = BLL.Familia.GetInstance.Listar
    End Sub
    Dim unaPatente As New BE.Patente
    Dim unaFamilia As New BE.Familia
    Dim tabla As String = "PAT-FAM"
    Dim usu As New BE.Usuario
    Private Sub Button5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button5.Click

        Dim unaPatente As New BE.Patente
        Dim unaFamilia As New BE.Familia
        'Dim tabla As String
        'tabla = "PAT_FAM"

        Dim patfam As New BE.Pat_Fam

        patfam.patente_id._id = DirectCast(lstPatDisponibles.SelectedItem, BE.Patente)._id
        patfam._permiso._id = DirectCast(lstFamDisponibles.SelectedItem, BE.Familia)._id


        patfam._dvh = BLL.Seguridad.GetInstance.CalcularDVH_PatFam(patfam)


        Try


            For Each patente In BLL.Patente.GetInstance.ListarPatentesxFam(patfam._permiso)
                'comparo si esta..
                If patfam.patente_id._id = patente._id Then
                    MsgBox("La patente seleccionada ya está asignada.", MsgBoxStyle.Information, "Permisos")
                    Exit Sub
                End If
            Next
            'Le asigno la patente a la familia
            BLL.Patente.GetInstance.AsignarPatenteFamilia(patfam)
            'BLL.Seguridad.GetInstance.ReCalcularDVV("PAT-FAM")
        Catch ex As Exception
            MsgBox(ex)
        End Try



    End Sub

    Private Sub lstPatAsignadas_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lstPatAsignadas.SelectedIndexChanged

    End Sub

    Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button4.Click
        Dim unaPatente As New BE.Patente
        Dim unaFamilia As New BE.Familia
        'Dim tabla As String
        'tabla = "PAT_FAM"

        Dim patfam As New BE.Pat_Fam

        patfam.patente_id._id = DirectCast(lstPatAsignadas.SelectedItem, BE.Patente)._id
        patfam._permiso._id = DirectCast(lstFamDisponibles.SelectedItem, BE.Familia)._id

       
        patfam._dvh = BLL.Seguridad.GetInstance.CalcularDVH_PatFam(patfam)

        Try
            BLL.Patente.GetInstance.QuitarPatenteFamilia(patfam)
            lstPatAsignadas.DataSource = BLL.Patente.GetInstance.ListarPatentesxFam(unaFamilia)
            'BLL.Seguridad.GetInstance.ReCalcularDVV("PAT-FAM")
    
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try

    End Sub
End Class