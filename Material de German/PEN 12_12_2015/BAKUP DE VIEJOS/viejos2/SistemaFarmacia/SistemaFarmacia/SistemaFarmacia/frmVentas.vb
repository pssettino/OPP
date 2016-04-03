Public Class frmVentas
    Dim BitacoraBE As New BE.Bitacora
    Dim MenuUI As UI.frmMenu
    Dim TraduccionBLL As BLL.Traduccion

    Private Sub frmVentas_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        MenuUI = Me.MdiParent
        TraduccionBLL = New BLL.Traduccion(MenuUI.GetIdioma)
        Dim PatenteBE As New BE.Patente
        PatenteBE.Nombre = "Venta"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If (BLL.Usuario.GetInstance.VerificarPatente(MenuUI.GetUsuario, PatenteBE) = False) Then
            MsgBox(TraduccionBLL.TraducirTexto("Sus permisos han sido modificados, por favor inicie sesion nuevamente"), MsgBoxStyle.Critical, TraduccionBLL.TraducirTexto("Error"))
            Application.Exit()
        End If
        TraduccionBLL.TraducirForm(Me)

        cmbCliente.DisplayMember = "nombreCompleto"
        cmbCliente.ValueMember = "clienteId"
        cmbCliente.DataSource = BLL.Cliente.GetInstance.ListAll()

        ListarVentas()
    End Sub

    Private Sub btnbuscar_Click(sender As Object, e As EventArgs) Handles btnbuscar.Click
        dgVentas.Rows.Clear()
        ListarVentas()
    End Sub

    Public Sub ListarVentas()
        Dim fechaDesde = New DateTime(dtpFechaDesde.Value.Year, dtpFechaDesde.Value.Month, dtpFechaDesde.Value.Day, 0, 0, 0)
        Dim fechaHasta = New DateTime(dtpFechaHasta.Value.Year, dtpFechaHasta.Value.Month, dtpFechaHasta.Value.Day, 23, 59, 59)
        Dim VentasBE As New BE.Venta

        For Each item In BLL.Venta.GetInstance.ListarVentasPorParametros(fechaDesde, fechaHasta, cmbCliente.SelectedValue)
            Dim n As Integer = dgVentas.Rows.Add()
            dgVentas.Rows.Item(n).Cells("dgBtnModificarVenta").Value = TraduccionBLL.TraducirTexto("Ver Detalle")
            dgVentas.Rows.Item(n).Cells("NroVenta").Value = item.ventaId
            dgVentas.Rows.Item(n).Cells("Cliente").Value = item.cliente.NombreCompleto
            dgVentas.Rows.Item(n).Cells("Fecha_Venta").Value = item.fechaVenta
        Next
    End Sub

    Private Sub btnlimpiar_Click(sender As Object, e As EventArgs) Handles btnlimpiar.Click
        dgVentas.Rows.Clear()
    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Me.Close()
    End Sub

    Private Sub btnRegistrar_Click(sender As Object, e As EventArgs) Handles btnRegistrar.Click
        Dim VentaRegistrar As New frmVentasMod
        If VentaRegistrar.ShowDialog(Me) = Windows.Forms.DialogResult.OK Then
            ListarVentas()
        End If
    End Sub

    Private Sub dgVentas_CellContentClick(sender As Object, e As DataGridViewCellEventArgs) Handles dgVentas.CellContentClick

        If e.ColumnIndex = 4 Then 'Nro Columna del datagriew
            Dim id As String = Convert.ToString(dgVentas.CurrentRow.Cells("NroVenta").Value)
            Dim VentaRegistrar As New frmVentasMod(id)
            Dim venta As New BE.Venta

            venta.ventaId = id
            venta = BLL.Venta.GetInstance.ListarVentasById(venta)

            VentaRegistrar.txtFechaHora.Text = venta.fechaVenta
            VentaRegistrar.txtNroVenta.Text = venta.ventaId
            VentaRegistrar.medicamentos = venta.medicamentos

            If VentaRegistrar.ShowDialog(Me) = Windows.Forms.DialogResult.OK Then
                ListarVentas()
            End If
        End If
    End Sub
End Class