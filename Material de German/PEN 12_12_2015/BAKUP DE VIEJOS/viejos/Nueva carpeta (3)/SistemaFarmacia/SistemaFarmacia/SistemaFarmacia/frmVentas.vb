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


        cmbCliente.DisplayMember = "nombreCompleto"
        cmbCliente.ValueMember = "clienteId"
        cmbCliente.DataSource = BLL.Cliente.GetInstance.ListAll()

        'cmbMedicamento.DisplayMember = "descripcion"
        'cmbMedicamento.ValueMember = "medicamentoId"
        'cmbMedicamento.DataSource = BLL.Medicamento.GetInstance.ListAll

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
            ObtenerVentas()
        End If
    End Sub

    Public Sub ObtenerVentas()
        Dim SeguridadBLL As New BLL.Seguridad
        Dim VentaBE As New BE.Venta
        Dim fechaDesde = New DateTime(dtpFechaDesde.Value.Year, dtpFechaDesde.Value.Month, dtpFechaDesde.Value.Day, 0, 0, 0)
        Dim fechaHasta = New DateTime(dtpFechaHasta.Value.Year, dtpFechaHasta.Value.Month, dtpFechaHasta.Value.Day, 23, 59, 59)

        dgVentas.Rows.Clear()

        For Each Venta In BLL.Venta.GetInstance.ListarVentasPorParametros(fechaDesde, fechaHasta, cmbCliente.SelectedValue)
            Dim n As Integer = dgVentas.Rows.Add()
            dgVentas.Rows.Item(n).Cells("dgBtnModificarVenta").Value = TraduccionBLL.TraducirTexto("Ver Detalle")
            dgVentas.Rows.Item(n).Cells("NroVenta").Value = VentaBE.ventaId
            dgVentas.Rows.Item(n).Cells("Cliente").Value = VentaBE.cliente.NombreCompleto
            dgVentas.Rows.Item(n).Cells("Fecha_Venta").Value = VentaBE.fechaVenta
        Next

    End Sub

    Private Sub dgVentas_CellContentClick(sender As Object, e As DataGridViewCellEventArgs) Handles dgVentas.CellContentClick

        If e.ColumnIndex = 4 Then 'Nro Columna del datagriew
            Dim id As String = Convert.ToString(dgVentas.CurrentRow.Cells("NroVenta").Value)
            Dim VentaRegistrar As New frmVentasMod(id)
            'VentaRegistrar.frmVentasMod_Load(sender, e)
            Dim venta As New BE.Venta

            venta.ventaId = id
            venta = BLL.Venta.GetInstance.ListarVentasById(venta)

            VentaRegistrar.txtNroVenta.Text = venta.ventaId

            For Each opcionCliente As BE.Cliente In VentaRegistrar.cmbCliente.Items
                'If opcionCliente.dni = venta.cliente.dni Then
                VentaRegistrar.cmbCliente.SelectedItem = opcionCliente
                'End If
            Next

            For Each ventaMedicamento As BE.VentaMedicamento In venta.medicamentos
                Dim n As Integer = VentaRegistrar.dgMedicamentosPorVenta.Rows.Add()
                VentaRegistrar.dgMedicamentosPorVenta.Rows.Item(n).Cells("gvBtnEliminarMedicamento").Value = TraduccionBLL.TraducirTexto("Quitar Medicamento")
                VentaRegistrar.dgMedicamentosPorVenta.Rows.Item(n).Cells("NroMedicamento").Value = ventaMedicamento.Medicamento.medicamentoId
                VentaRegistrar.dgMedicamentosPorVenta.Rows.Item(n).Cells("Medicamento").Value = ventaMedicamento.Medicamento.descripcion
                VentaRegistrar.dgMedicamentosPorVenta.Rows.Item(n).Cells("Receta").Value = IIf(ventaMedicamento.Medicamento.Receta, "SI", "NO")
                VentaRegistrar.dgMedicamentosPorVenta.Rows.Item(n).Cells("CantVenta").Value = ventaMedicamento.CantidadVenta
                VentaRegistrar.dgMedicamentosPorVenta.Rows.Item(n).Cells("PrecioVenta").Value = ventaMedicamento.PrecioVenta
            Next

            VentaRegistrar.medicamentos = venta.medicamentos
            If VentaRegistrar.ShowDialog(Me) = Windows.Forms.DialogResult.OK Then
                ObtenerVentas()
            End If
        End If


    End Sub
End Class