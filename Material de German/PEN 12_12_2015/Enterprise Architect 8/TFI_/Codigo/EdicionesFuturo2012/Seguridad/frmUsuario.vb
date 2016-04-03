Public Class frmUsuario

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click

        dtgusu.DataSource = BLL.Usuario.GetInstance.Listar()
        dtgusu.Columns(1).Visible = False
        dtgusu.Columns(7).Visible = False
        dtgusu.Columns(10).Visible = False
        dtgusu.Columns(0).HeaderText = "Nombre"
        dtgusu.Columns(2).HeaderText = "Apellido"
        dtgusu.Columns(3).HeaderText = "ID"
        dtgusu.Columns(4).HeaderText = "Logon"
        dtgusu.Columns(5).HeaderText = "Password"
        dtgusu.Columns(6).HeaderText = "Email"
        dtgusu.Columns(9).HeaderText = "Estado Logico"
        dtgusu.Columns(8).HeaderText = "Estado de Bloqueo"

    End Sub

    Private Sub btnDblq_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDblq.Click
        Dim unusuario As New BE.Usuario
        'Se desbloquea el usuario
        unusuario._log = dtgusu.CurrentRow.Cells(4).Value.ToString
        If BLL.Usuario.GetInstance.Desbloquear(unusuario) = True Then
            MsgBox("Usuario Desbloqueado", MsgBoxStyle.Information, "Usuarios")
        End If

    End Sub


    Private Sub btnAlta_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAlta.Click
        Dim usu As New BE.Usuario
        Dim objbitacora As New BE.Bitacora


        Try

            usu._ape = txtape.Text
            usu._nom = txtnom.Text
            usu._dni = txtdni.Text
            usu._email = txtemail.Text
            usu._log = txtlog.Text
            usu._pass = txtpass.Text
            'Calculo DVH
            usu._dvh = BLL.Seguridad.GetInstance.CalcularDVHUsuario(usu)

            If BLL.Usuario.GetInstance.Alta(usu) Then

                objbitacora._desc = "Alta Usuario"
                objbitacora._fecha = Now
                objbitacora._dvh = 5
                objbitacora._usu_id._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
                objbitacora._crit_id._id = BLL.Criticidad.GetInstance.RecuperarId(New BE.Criticidad("Bajo"))
                BLL.Bitacora.GetInstance.RegistrarBitacora(objbitacora)
                usu.ACTIVO = True

            End If


        Catch ex As Exception

            MsgBox("Error en Alta Cliente")


        End Try

        MsgBox("Alta Exitosa", MsgBoxStyle.OkCancel, "Usuarios")


    End Sub



    Private Sub cmbFam_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        ''   cmbFam.DataSource = BLL.Familia.GetInstance.Listar()
    End Sub

    Private Sub frmUsuario_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        'Ayuda
        If e.KeyCode = 112 Then
            Help.ShowHelp(Me, BLL.Seguridad.ConsultarHelp().HelpFile, HelpNavigator.TopicId, "6")
        End If
    End Sub


    Private Sub frmUsuario_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim objPat As New BE.Patente
        Dim usu As New BE.Usuario
        objPat._id = 14

        usu._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
        objPat._desc = "ABM Usuarios"
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
    End Sub

    Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button4.Click
        frmUsuPat.Show()
    End Sub

    Private Sub btnBaja_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnBaja.Click
        Dim usuario As New BE.Usuario
        Dim objbitacora As New BE.Bitacora
        Try

            usuario._id = dtgusu.CurrentRow.Cells(3).Value
            usuario._email = dtgusu.CurrentRow.Cells(6).Value
            usuario._nom = dtgusu.CurrentRow.Cells(0).Value
            usuario._ape = dtgusu.CurrentRow.Cells(2).Value
            usuario._ciii = dtgusu.CurrentRow.Cells(11).Value
            usuario._log = dtgusu.CurrentRow.Cells(4).Value
            usuario._pass = dtgusu.CurrentRow.Cells(5).Value
            usuario._bloqueado = False
            usuario.ACTIVO = False

            ''Calculo DVH
            usuario._dvh = BLL.Seguridad.GetInstance.CalcularDVHUsuario(usuario)

            BLL.Usuario.GetInstance.Baja(usuario)


            objbitacora._desc = "Baja Usuario"
            objbitacora._fecha = Now
            objbitacora._dvh = 5
            objbitacora._usu_id._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
            objbitacora._crit_id._id = BLL.Criticidad.GetInstance.RecuperarId(New BE.Criticidad("Alto"))
            objbitacora._usu_log = frmlogin.TextBox1.Text
            objbitacora._dvh = BLL.Seguridad.GetInstance.CalcularDVHBitacora(objbitacora)
            BLL.Bitacora.GetInstance.RegistrarBitacora(objbitacora)
            BLL.Seguridad.GetInstance.ReCalcularDVV("BITACORA")

        Catch ex As Exception

            MsgBox("Error en Borrado", MsgBoxStyle.Information, "Clientes")

        End Try

        MsgBox("Borrado Exitoso", MsgBoxStyle.Information, "Clientes")
    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        Dim usuario As New BE.Usuario
        Dim objbitacora As New BE.Bitacora
        'Try

        usuario._id = dtgusu.CurrentRow.Cells(3).Value
        usuario._email = dtgusu.CurrentRow.Cells(6).Value
        usuario._nom = dtgusu.CurrentRow.Cells(0).Value
        usuario._ape = dtgusu.CurrentRow.Cells(2).Value
        usuario._ciii = dtgusu.CurrentRow.Cells(11).Value
        usuario._log = dtgusu.CurrentRow.Cells(4).Value
        usuario._pass = dtgusu.CurrentRow.Cells(5).Value
        usuario._bloqueado = False
        usuario.ACTIVO = False

        ''Calculo DVH
        usuario._dvh = BLL.Seguridad.GetInstance.CalcularDVHUsuario(usuario)

        BLL.Usuario.GetInstance.Modificar(usuario)

        objbitacora._desc = "Modificacion de Usuario"
        objbitacora._fecha = Now
        objbitacora._dvh = 5
        objbitacora._usu_id._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
        objbitacora._crit_id._id = BLL.Criticidad.GetInstance.RecuperarId(New BE.Criticidad("Medio"))
        objbitacora._usu_log = frmlogin.TextBox1.Text
        objbitacora._dvh = BLL.Seguridad.GetInstance.CalcularDVHBitacora(objbitacora)
        BLL.Bitacora.GetInstance.RegistrarBitacora(objbitacora)
        BLL.Seguridad.GetInstance.ReCalcularDVV("BITACORA")

    End Sub
End Class