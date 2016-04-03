Imports System.ComponentModel

Public Class frmBitacora

    Private Sub btnBitacora_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnListarTodos.Click
        Dim objusu As BE.Usuario
        Dim objbit As New BE.Bitacora

        Dim i As Integer

   

        If cmbUsu.SelectedItem Is Nothing Then
            If cmbcrit.SelectedItem Is Nothing Then
                objbit._fecha = dtpdesde.Text
                objbit._ffin = dtphasta.Text
                'Listo x fecha si no selecione los combos

                dtgBitacora.DataSource = BLL.Bitacora.GetInstance.ListarxFecha(objbit)
                dtgBitacora.SelectionMode = DataGridViewSelectionMode.RowHeaderSelect


                'Tuning Datagriedview
                dtgBitacora.Columns(0).HeaderText = "Ïd"
                dtgBitacora.Columns(1).HeaderText = "Fecha Evento"
                dtgBitacora.Columns(2).HeaderText = "Evento"
                dtgBitacora.Columns(3).HeaderText = "Usuario"
                dtgBitacora.Columns(4).Visible = False
                dtgBitacora.Columns(5).HeaderText = "Criticidad"
                dtgBitacora.Columns(6).Visible = False
                dtgBitacora.Columns(7).Visible = False
                If dtgBitacora.RowCount = 0 Then
                    MsgBox("Los parametros seleccionados no arrojan resultados", MsgBoxStyle.Information, "Bitacora")
                End If
            Else
                objbit._crit_id = cmbcrit.SelectedItem
                objbit._fecha = dtpdesde.Text
                objbit._ffin = dtphasta.Text
                'Listo x Criticidad y fecha
                dtgBitacora.DataSource = BLL.Bitacora.GetInstance.ListarBitacoraxCrityFech(objbit)
                dtgBitacora.Columns(0).HeaderText = "Ïd"
                dtgBitacora.Columns(1).HeaderText = "Fecha Evento"
                dtgBitacora.Columns(2).HeaderText = "Evento"
                dtgBitacora.Columns(3).HeaderText = "Usuario"
                dtgBitacora.Columns(4).Visible = False
                dtgBitacora.Columns(5).HeaderText = "Criticidad"
                dtgBitacora.Columns(6).Visible = False
                dtgBitacora.Columns(7).Visible = False
                If dtgBitacora.RowCount = 0 Then
                    MsgBox("Los parametros seleccionados no arrojan resultados", MsgBoxStyle.Information, "Bitacora")
                End If
            End If
        ElseIf cmbcrit.SelectedItem Is Nothing Then
            objbit._usu_log = DirectCast(cmbUsu.SelectedItem, BE.Usuario)._log
            objbit._fecha = dtpdesde.Value
            objbit._ffin = dtphasta.Value
            'Listo x usuario y fecha
            dtgBitacora.DataSource = BLL.Bitacora.GetInstance.ListarBitacoraxUsuyFecha(objbit)
            dtgBitacora.Columns(0).HeaderText = "Ïd"
            dtgBitacora.Columns(1).HeaderText = "Fecha Evento"
            dtgBitacora.Columns(2).HeaderText = "Evento"
            dtgBitacora.Columns(3).HeaderText = "Usuario"
            dtgBitacora.Columns(4).Visible = False
            dtgBitacora.Columns(5).HeaderText = "Criticidad"
            dtgBitacora.Columns(6).Visible = False
            dtgBitacora.Columns(7).Visible = False
            If dtgBitacora.RowCount = 0 Then
                MsgBox("Los parametros seleccionados no arrojan resultados", MsgBoxStyle.Information, "Bitacora")
            End If
        Else
            objbit._usu_log = DirectCast(cmbUsu.SelectedItem, BE.Usuario)._log
            objbit._crit_id = cmbcrit.SelectedItem
            objbit._fecha = dtpdesde.Value
            objbit._ffin = dtphasta.Value
            'Listo x usuario y fecha y criticidad
            dtgBitacora.DataSource = BLL.Bitacora.GetInstance.ListarBitacoraxCrityFechyUsu(objbit)
            dtgBitacora.Columns(0).HeaderText = "Ïd"
            dtgBitacora.Columns(1).HeaderText = "Fecha Evento"
            dtgBitacora.Columns(2).HeaderText = "Evento"
            dtgBitacora.Columns(3).HeaderText = "Usuario"
            dtgBitacora.Columns(4).Visible = False
            dtgBitacora.Columns(5).HeaderText = "Criticidad"
            dtgBitacora.Columns(6).Visible = False
            dtgBitacora.Columns(7).Visible = False

            If cmbcrit.SelectedItem Is Nothing Then
                objbit._usu_log = DirectCast(cmbUsu.SelectedItem, BE.Usuario)._log
                'Listo x usuario y Criticidad
                dtgBitacora.DataSource = BLL.Bitacora.GetInstance.ListarBitacoraxUsuyCrit(objbit)
                dtgBitacora.Columns(0).HeaderText = "Ïd"
                dtgBitacora.Columns(1).HeaderText = "Fecha Evento"
                dtgBitacora.Columns(2).HeaderText = "Evento"
                dtgBitacora.Columns(3).HeaderText = "Usuario"
                dtgBitacora.Columns(4).Visible = False
                dtgBitacora.Columns(5).HeaderText = "Criticidad"
                dtgBitacora.Columns(6).Visible = False
                dtgBitacora.Columns(7).Visible = False
                If dtgBitacora.RowCount = 0 Then
                    MsgBox("Los parametros seleccionados no arrojan resultados", MsgBoxStyle.Information, "Bitacora")
                End If
            End If

            If dtgBitacora.RowCount = 0 Then
                MsgBox("Los parametros seleccionados no arrojan resultados", MsgBoxStyle.Information, "Bitacora")
            End If

        End If

    End Sub


    Private Sub ComboBox1_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmbUsu.DropDown

        'Listo los usuarios
        cmbUsu.DataSource = BLL.Usuario.GetInstance.Listar

    End Sub



    Private Sub Cmbcriticidad_Dropdown(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmbcrit.DropDown

        'Listo la Criticidad
        cmbcrit.DataSource = BLL.Criticidad.GetInstance.ListarCriticidad()

    End Sub

    Private Sub frmBitacora_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        'Ayuda
        If e.KeyCode = 112 Then
            Help.ShowHelp(Me, BLL.Seguridad.ConsultarHelp().HelpFile, HelpNavigator.TopicId, "7")
        End If
    End Sub

    Private Sub frmBitacora_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Verifico permisos para el formulario Bitacora
        Dim objPat As New BE.Patente
        Dim usu As New BE.Usuario
        objPat._id = 16

        usu._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
        objPat._desc = "Bitacora"
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


    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Me.dtgBitacora.Columns(5).SortMode =
        DataGridViewColumnSortMode.Programmatic
    End Sub

End Class