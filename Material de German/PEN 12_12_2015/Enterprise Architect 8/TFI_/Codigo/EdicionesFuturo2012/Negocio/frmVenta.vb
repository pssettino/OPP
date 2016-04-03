Imports System.Globalization

Public Class frmVenta
    Dim objbitacora As New BE.Bitacora

    Private Sub frmVenta_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        If e.KeyCode = 112 Then
            Help.ShowHelp(Me, BLL.Seguridad.ConsultarHelp().HelpFile, HelpNavigator.TopicId, "2")
        End If
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAlta.Click
        Dim oventa As New BE.Venta

        'Alta Venta
        oventa._clie_id = cmbcliente.SelectedItem
        oventa._lib_id._id = DirectCast(cmblibro.SelectedItem, BE.Libro)._id
        oventa._importe = txtImporte.Text
        oventa._cuotas = txtCuotas.Text
        oventa._fecha = dtpFecha.Text
        oventa._vend_id._id = 10
        oventa._usu_id._log = frmlogin.TextBox1.Text
        oventa._activo = True
        oventa._dvh = BLL.Seguridad.GetInstance.CalcularDVHVentas(oventa)
        oventa._valorcuota = txtvalorcuota.Text

        Dim oLibro As New BE.Libro
        oLibro._id = DirectCast(cmblibro.SelectedItem, BE.Libro)._id


        BLL.Libro.GetInstance.DescontarStock(oLibro)

        'Alta Venta
        If BLL.Venta.GetInstance.Alta(oventa) = False Then
            MsgBox("Alta Exitosa", MsgBoxStyle.Information, "Ventas")
        Else
            MsgBox("Error en Alta", MsgBoxStyle.Information, "Ventas")
        End If

        'Bitacora
        objbitacora._desc = "Alta Venta"
        objbitacora._fecha = Now
        objbitacora._dvh = 5
        objbitacora._usu_id._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
        objbitacora._crit_id._id = BLL.Criticidad.GetInstance.RecuperarId(New BE.Criticidad("Alto"))
        objbitacora._usu_log = frmlogin.TextBox1.Text
        objbitacora._dvh = BLL.Seguridad.GetInstance.CalcularDVHBitacora(objbitacora)
        BLL.Bitacora.GetInstance.RegistrarBitacora(objbitacora)
        BLL.Seguridad.GetInstance.ReCalcularDVV("BITACORA")

    End Sub

    Private Sub cmbcliente_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmbcliente.DropDown
        cmbcliente.DataSource = BLL.Cliente.GetInstance.Listar
    End Sub


    Private Sub cmblibro_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmblibro.DropDown
        cmblibro.DataSource = BLL.Libro.GetInstance.Listar
    End Sub
    Private Sub cmblibro_SelectedIndexChanged1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmblibro.SelectedIndexChanged
        txtvalorcuota.Text = txtImporte.Text / txtCuotas.Text
    End Sub
    Private Sub cmblibro_SelectedIndexChanged_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmblibro.SelectedIndexChanged
        txtImporte.Text = DirectCast(cmblibro.SelectedValue, BE.Libro)._precio
    End Sub

    Private Sub frmVenta_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Idioma
        If frmlogin.RadioButton1.Checked = False Then
            frmlogin.culture = CultureInfo.CreateSpecificCulture("es-AR")
            BLL.Seguridad.Idioma = "es-AR"
            frmlogin.cambiarIdioma()
        End If
        If frmlogin.RadioButton1.Checked = True Then
            frmlogin.culture = CultureInfo.CreateSpecificCulture("")
            BLL.Seguridad.Idioma = ""
            frmlogin.cambiarIdioma()
        End If

        Dim objPat As New BE.Patente
        Dim usu As New BE.Usuario

        ' Permisos del form

        objPat._id = 7
        usu._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
        objPat._desc = "Alta Libro"
        If BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = True Then
            If BLL.Seguridad.GetInstance.VerificarPermisosNegUsuPat(objPat, usu) = False Then
                btnAlta.Enabled = False
            Else
                btnAlta.Enabled = True
            End If
        ElseIf BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = False Then
            If BLL.Seguridad.GetInstance.VerificarPermisosUsuPat(objPat, usu) = True Then
                btnAlta.Enabled = True
            Else
                btnAlta.Enabled = False
            End If
        End If

        objPat._id = 8
        objPat._desc = "Baja Venta"
        If BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = True Then
            If BLL.Seguridad.GetInstance.VerificarPermisosNegUsuPat(objPat, usu) = False Then
                btnBaja.Enabled = False
            Else
                btnBaja.Enabled = True
            End If
        ElseIf BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = False Then
            If BLL.Seguridad.GetInstance.VerificarPermisosUsuPat(objPat, usu) = True Then
                btnBaja.Enabled = True
            Else
                btnBaja.Enabled = False
            End If
        End If

        objPat._id = 9
        objPat._desc = "Modificar Venta"
        If BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = True Then
            If BLL.Seguridad.GetInstance.VerificarPermisosNegUsuPat(objPat, usu) = False Then
                btnModificar.Enabled = False
            Else
                btnModificar.Enabled = True
            End If
        ElseIf BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = False Then
            If BLL.Seguridad.GetInstance.VerificarPermisosUsuPat(objPat, usu) = True Then
                btnModificar.Enabled = True
            Else
                btnModificar.Enabled = False
            End If
        End If

    End Sub

    Private Sub btnListar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnListar.Click
        DataGridView1.DataSource = BLL.Venta.GetInstance.Listar
        'Seteo
        DataGridView1.Columns(0).HeaderText = "Numero de Venta"
        DataGridView1.Columns(8).HeaderText = "Estado"
        DataGridView1.Columns(5).HeaderText = "Cuotas"
        DataGridView1.Columns(1).HeaderText = "Numero de Cliente"
        DataGridView1.Columns(7).HeaderText = "Fecha de Venta"
        DataGridView1.Columns(4).HeaderText = "Importe de Venta"
        DataGridView1.Columns(3).HeaderText = "Numero de Libro"
        DataGridView1.Columns(2).Visible = False
        DataGridView1.Columns(9).Visible = False
        DataGridView1.Columns(10).HeaderText = "Valor de Cuota"
        DataGridView1.Columns(6).Visible = False
    End Sub

    Private Sub btnBaja_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnBaja.Click
        Dim venta As New BE.Venta

        Try

            venta._id = DataGridView1.CurrentRow.Cells(0).Value
            'venta._activo = False
            venta._cuotas = DataGridView1.CurrentRow.Cells(5).Value
            venta._clie_id = DataGridView1.CurrentRow.Cells(1).Value
            venta._fecha = DataGridView1.CurrentRow.Cells(7).Value
            venta._importe = DataGridView1.CurrentRow.Cells(4).Value
            venta._lib_id = DataGridView1.CurrentRow.Cells(3).Value
            venta._vend_id = DataGridView1.CurrentRow.Cells(2).Value
            venta._usu_id = DataGridView1.CurrentRow.Cells(6).Value
            venta._valorcuota = DataGridView1.CurrentRow.Cells(10).Value

            ''Calculo DVH
            venta._dvh = BLL.Seguridad.GetInstance.CalcularDVHVentas(venta)

            If BLL.Venta.GetInstance.Baja(venta) = False Then
                MsgBox("Baja Exitosa", MsgBoxStyle.Information, "Ventas")
            Else
                MsgBox("Error en Baja", MsgBoxStyle.Information, "Ventas")
            End If


            'Bitacora
            objbitacora._desc = "Baja Venta"
            objbitacora._fecha = Now
            objbitacora._dvh = 5
            objbitacora._usu_id._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
            objbitacora._crit_id._id = BLL.Criticidad.GetInstance.RecuperarId(New BE.Criticidad("Alto"))
            objbitacora._usu_log = frmlogin.TextBox1.Text
            objbitacora._dvh = BLL.Seguridad.GetInstance.CalcularDVHBitacora(objbitacora)
            BLL.Bitacora.GetInstance.RegistrarBitacora(objbitacora)
            BLL.Seguridad.GetInstance.ReCalcularDVV("BITACORA")

        Catch ex As Exception

            MsgBox(ex)

        End Try

    End Sub

    Private Sub btnModificar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnModificar.Click
        Dim venta As New BE.Venta
        Dim objbitacora As New BE.Bitacora

        Try

            'Pasaje al obj
            venta._id = DataGridView1.CurrentRow.Cells(0).Value
            'venta._activo = False
            venta._activo = True
            venta._cuotas = DataGridView1.CurrentRow.Cells(5).Value
            venta._clie_id = DataGridView1.CurrentRow.Cells(1).Value
            venta._fecha = DataGridView1.CurrentRow.Cells(7).Value
            venta._importe = DataGridView1.CurrentRow.Cells(4).Value
            venta._lib_id = DataGridView1.CurrentRow.Cells(3).Value
            venta._vend_id = DataGridView1.CurrentRow.Cells(2).Value
            venta._usu_id = DataGridView1.CurrentRow.Cells(6).Value
            venta._valorcuota = DataGridView1.CurrentRow.Cells(10).Value
            venta._dvh = BLL.Seguridad.GetInstance.CalcularDVHVentas(venta)



            If BLL.Venta.GetInstance.Modificar(venta) = False Then
                MsgBox("Modificacion Exitosa", MsgBoxStyle.Information, "Ventas")
            Else
                MsgBox("Error en Modificacion", MsgBoxStyle.Information, "Ventas")
            End If

            'Bitacora
            objbitacora._desc = "Venta Modificada"
            objbitacora._fecha = Now
            objbitacora._dvh = 5
            objbitacora._usu_id._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
            objbitacora._crit_id._id = BLL.Criticidad.GetInstance.RecuperarId(New BE.Criticidad("Medio"))
            objbitacora._usu_log = frmlogin.TextBox1.Text
            objbitacora._dvh = BLL.Seguridad.GetInstance.CalcularDVHBitacora(objbitacora)
            BLL.Bitacora.GetInstance.RegistrarBitacora(objbitacora)
            BLL.Seguridad.GetInstance.ReCalcularDVV("BITACORA")

        Catch ex As Exception
            MsgBox(ex)
        End Try

    End Sub

   
End Class