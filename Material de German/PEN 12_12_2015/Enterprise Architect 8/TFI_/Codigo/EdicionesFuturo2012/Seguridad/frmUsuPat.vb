Public Class frmUsuPat

    Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button4.Click

        Dim objusuario As New BE.Usuario

        Try
            objusuario._id = DirectCast(cmbUsu.SelectedItem, BE.Usuario)._id
        Catch ex As Exception
            MsgBox("Debe seleccionar un usuario", MsgBoxStyle.Information)
        End Try

        ''ver xq no me almancena los valores que traigo de la consutlade la dal,
        lstPatAsignadas.DataSource = BLL.Usu_Pat.Consultar(objusuario)
        lstPatNegadas.DataSource = BLL.Usu_Pat.ConsultaNegadas(objusuario)
        lstFamAsig.DataSource = BLL.Usu_Fam.Consultar(objusuario)
        lstFamDisp.DataSource = BLL.Familia.GetInstance.Listar
        lstPatDisponibles.DataSource = BLL.Patente.GetInstance.Listar
        lstPatDisponibles.DataSource = BLL.Patente.GetInstance.Listar
    End Sub

    Private Sub ComboBox1_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmbUsu.DropDown
        ' lstPatAsignadas.Items.Clear()
        cmbUsu.DataSource = BLL.Usuario.GetInstance.Listar()
    End Sub


    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        frmPatFam.Show()
    End Sub

    Private Sub btnAsignar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAsignarAsig.Click
        Dim objusupat As New BE.Usu_Pat

        'Le asigno una patente a un usuario

        objusupat.patente_id = lstPatDisponibles.SelectedItem
        objusupat.usuario_id = cmbUsu.SelectedItem
        objusupat._dvh = BLL.Seguridad.GetInstance.CalcularDVH_UsuPat(objusupat)
        BLL.Usu_Pat.GetInstance.AsignarPAtente(objusupat)

        'verifico si ya esta asignada
        For Each pat In lstPatAsignadas.DataSource
            If pat.ToString = lstPatDisponibles.SelectedItem.ToString Then
                MsgBox("El usuario ya posee la patente seleccionada ", MsgBoxStyle.Information, "Permisos")
                Exit Sub
            End If
        Next



        MsgBox("Patente Permitida", MsgBoxStyle.Information)




    End Sub

    Private Sub btnNegar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnNegar.Click
        Dim objusupat As New BE.Usu_Pat

        'Deniego una patente a un usuario
        'Try
        objusupat.patente_id = lstPatDisponibles.SelectedItem
        objusupat.usuario_id = cmbUsu.SelectedItem
        objusupat._dvh = BLL.Seguridad.GetInstance.CalcularDVH_UsuPat(objusupat)
        BLL.Usu_Pat.GetInstance.NegarPatente(objusupat)

        'verifico si ya esta asignada
        For Each pat In lstPatNegadas.DataSource
            If pat.ToString = lstPatDisponibles.SelectedItem.ToString Then
                MsgBox("El usuario ya posee la patante negada que ha seleccionado ", MsgBoxStyle.Information, "Permisos")
                Exit Sub
            End If
        Next
        MsgBox("Patente Denagada", MsgBoxStyle.Information)
        'Catch ex As Exception
        '    MsgBox("Error de asignacion", MsgBoxStyle.Information)
        'End Try
    End Sub

    Private Sub btnQuitarAsig_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Dim objusupat As New BE.Usu_Pat

        objusupat.patente_id = lstPatDisponibles.SelectedItem
        objusupat.usuario_id = cmbUsu.SelectedItem

        '' BLL.Usu_Pat.GetInstance.QuitarPatente(objusupat)

        MsgBox("Operacion Exitosa", MsgBoxStyle.Information)
    End Sub

    Private Sub btnQuitarNeg_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Dim objusupat As New BE.Usu_Pat
        objusupat.patente_id = lstPatNegadas.SelectedItem
        objusupat.usuario_id = cmbUsu.SelectedItem

        ''    BLL.Usu_Pat.GetInstance.QuitarPatente(objusupat)

        MsgBox("Operacion Exitosa", MsgBoxStyle.Information)
    End Sub


    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click
        Dim objusufam As New BE.Usu_Fam
        objusufam.familia_id = lstFamDisp.SelectedItem
        objusufam.usuario_id = cmbUsu.SelectedItem
        objusufam._dvh = BLL.Seguridad.GetInstance.CalcularDVH_UsuFam(objusufam)
        'verifico si ya esta asignada
        For Each fam In lstFamAsig.DataSource
            If fam.ToString = lstFamDisp.SelectedItem.ToString Then
                MsgBox("La Familia ya se encuentra asignada ", MsgBoxStyle.Information, "Permisos")
                Exit Sub
            End If
        Next
        BLL.Usu_Fam.GetInstance.AsignarFamilia(objusufam)
        MsgBox("Familia Asignada", MsgBoxStyle.Information)
    End Sub

    Private Sub Button5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button5.Click

        Dim objusufam As New BE.Usu_Fam
        objusufam.familia_id = lstFamAsig.SelectedItem
        objusufam.usuario_id = cmbUsu.SelectedItem
        objusufam._dvh = BLL.Seguridad.GetInstance.CalcularDVH_UsuFam(objusufam)
        BLL.Usu_Fam.GetInstance.QuitarFamilia(objusufam)
        MsgBox("Operacion Exitosa", MsgBoxStyle.Information)

    End Sub

    Private Sub QuitarPatNeg_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles QuitarPatNeg.Click
        Dim objusupat As New BE.Usu_Pat

        'Quito la negacion de una patente a un usuario
        Try
            objusupat.patente_id = lstPatNegadas.SelectedItem
            objusupat.usuario_id = cmbUsu.SelectedItem
            objusupat._dvh = BLL.Seguridad.GetInstance.CalcularDVH_UsuPat(objusupat)
            BLL.Usu_Pat.GetInstance.QuitarPatenteNegada(objusupat)
            MsgBox("Operacion Exitosa", MsgBoxStyle.Information)
        Catch ex As Exception
            MsgBox("Error de asignacion", MsgBoxStyle.Information)
        End Try

    End Sub

    Private Sub QuitarPatAsi_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles QuitarPatAsi.Click
        Dim objusupat As New BE.Usu_Pat

        'Le quito la patente asignada al usuario
        Try
            objusupat.patente_id = lstPatAsignadas.SelectedItem
            objusupat.usuario_id = cmbUsu.SelectedItem
            objusupat._dvh = BLL.Seguridad.GetInstance.CalcularDVH_UsuPat(objusupat)
            BLL.Usu_Pat.GetInstance.QuitarPatenteAsignada(objusupat)

            MsgBox("Operacion Exitosa", MsgBoxStyle.Information)

        Catch ex As Exception
            MsgBox("Error de asignacion", MsgBoxStyle.Information)
        End Try

        Dim objBitacora As New BE.Bitacora
        objBitacora._desc = "Quitar Patente a Usuario"
        objBitacora._fecha = Now
        objBitacora._usu_id._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
        objBitacora._crit_id._id = BLL.Criticidad.GetInstance.RecuperarId(New BE.Criticidad("Medio"))
        objBitacora._usu_log = frmlogin.TextBox1.Text
        objBitacora._dvh = BLL.Seguridad.GetInstance.CalcularDVHBitacora(objBitacora)
        BLL.Bitacora.GetInstance.RegistrarBitacora(objBitacora)
        BLL.Seguridad.GetInstance.ReCalcularDVV("BITACORA")

    End Sub

    Private Sub frmUsuPat_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        'Ayuda
        If e.KeyCode = 112 Then
            Help.ShowHelp(Me, BLL.Seguridad.ConsultarHelp().HelpFile, HelpNavigator.TopicId, "8")
        End If
    End Sub

    Private Sub frmUsuPat_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.FormClosed

        'Efectivizo los permisos que no tienen un formulario atado al cerrar el 

        'Reparar Integridad
        Dim objPat As New BE.Patente
        Dim usu As New BE.Usuario
        objPat._id = 15

        usu._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
        objPat._desc = "Reparar Int."
        If BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = True Then
            If BLL.Seguridad.GetInstance.VerificarPermisosNegUsuPat(objPat, usu) = False Then
                frmPrincipal.RecuperarIntegridadToolStripMenuItem.Enabled = False
            Else
                frmPrincipal.RecuperarIntegridadToolStripMenuItem.Enabled = True
            End If
        ElseIf BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = False Then
            If BLL.Seguridad.GetInstance.VerificarPermisosUsuPat(objPat, usu) = True Then
                frmPrincipal.RecuperarIntegridadToolStripMenuItem.Enabled = True
            Else
                frmPrincipal.RecuperarIntegridadToolStripMenuItem.Enabled = False
            End If
        End If

        'Permisos Usu-Fam_pat
        objPat._id = 13
        usu._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
        objPat._desc = "Permisos"
        If BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = True Then
            If BLL.Seguridad.GetInstance.VerificarPermisosNegUsuPat(objPat, usu) = False Then
                frmPrincipal.UsuariosToolStripMenuItem1.Enabled = False
                frmPrincipal.FamilaPatenteToolStripMenuItem.Enabled = False
            Else
                frmPrincipal.UsuariosToolStripMenuItem1.Enabled = True
                frmPrincipal.FamilaPatenteToolStripMenuItem.Enabled = True
            End If
        ElseIf BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = False Then
            If BLL.Seguridad.GetInstance.VerificarPermisosUsuPat(objPat, usu) = True Then
                frmPrincipal.UsuariosToolStripMenuItem1.Enabled = True
                frmPrincipal.FamilaPatenteToolStripMenuItem.Enabled = True
            Else
                frmPrincipal.UsuariosToolStripMenuItem1.Enabled = False
                frmPrincipal.FamilaPatenteToolStripMenuItem.Enabled = False
            End If
        End If

        'Bitacora
        objPat._id = 16
        usu._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
        objPat._desc = "Bitacora"
        If BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = True Then
            If BLL.Seguridad.GetInstance.VerificarPermisosNegUsuPat(objPat, usu) = False Then
                frmBitacora.Enabled = False
            Else
                frmBitacora.Enabled = True
            End If
        ElseIf BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = False Then
            If BLL.Seguridad.GetInstance.VerificarPermisosUsuPat(objPat, usu) = True Then
                frmBitacora.Enabled = True
            Else
                frmBitacora.Enabled = False
            End If
        End If

    End Sub

    Private Sub frmUsuPat_Load_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub
End Class