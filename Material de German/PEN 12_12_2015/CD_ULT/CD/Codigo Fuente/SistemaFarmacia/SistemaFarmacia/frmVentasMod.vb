Public Class frmVentasMod
    Dim venta As New BE.Venta
    Dim BitacoraBE As New BE.Bitacora
    Dim TraduccionBLL As BLL.Traduccion
    Dim SeguridadBLL As New BLL.Seguridad
    Dim MenuUI As UI.frmMenu

    Private _id As String
    Public medicamentos As New List(Of BE.VentaMedicamento)

    Public Sub New(Optional idParameter As Integer = 0)
        InitializeComponent()
        _id = idParameter
        venta.ventaId = _id
    End Sub
    Public Sub frmVentasMod_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        MenuUI = Me.Owner
        TraduccionBLL = New BLL.Traduccion(MenuUI.GetIdioma)
        Dim PatenteBE As New BE.Patente
        PatenteBE.Nombre = "Venta"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If (BLL.Usuario.GetInstance.VerificarPatente(MenuUI.GetUsuario, PatenteBE) = False) Then
            MsgBox(TraduccionBLL.TraducirTexto("Sus permisos han sido modificados, por favor inicie sesion nuevamente"), MsgBoxStyle.Critical, TraduccionBLL.TraducirTexto("Error"))
            Application.Exit()
        End If
        TraduccionBLL.TraducirForm(Me)
        MostrarDatos()
        If _id > 0 Then
            ObtenerMedicamentosPorVenta()
        Else
            txtFechaHora.Text = DateTime.Now
            txtNroVenta.Text = BLL.Venta.GetInstance.ObtenerMaxId() + 1
        End If
    End Sub

    Public Sub MostrarDatos()
        Dim SeguridadBLL As New BLL.Seguridad
        If _id = 0 Then
            Dim clientesLista As New Dictionary(Of Integer, String)
            clientesLista.Add(0, TraduccionBLL.TraducirTexto("Seleccione el cliente"))
            For Each ClienteBE In BLL.Cliente.GetInstance.ObtenerClientesDisponibles()
                clientesLista.Add(ClienteBE.clienteId, ClienteBE.NombreCompleto)
            Next
            cmbCliente.DisplayMember = "Value"
            cmbCliente.ValueMember = "Key"
            cmbCliente.DataSource = New BindingSource(clientesLista, Nothing)
        End If

        Dim medicamentoLista As New Dictionary(Of Integer, String)
        medicamentoLista.Add(0, TraduccionBLL.TraducirTexto("Seleccione el medicamento"))
        For Each MedicamentoBE In BLL.Medicamento.GetInstance.ObtenerMedicamentosDisponibles(SeguridadBLL.EncriptarRSA("0"))
            medicamentoLista.Add(MedicamentoBE.medicamentoId, MedicamentoBE.descripcion)
        Next
        cmbMedicamento.DisplayMember = "Value"
        cmbMedicamento.ValueMember = "Key"
        cmbMedicamento.DataSource = New BindingSource(medicamentoLista, Nothing)
    End Sub


    Private Sub dgMedicamentosPorVenta_CellContentClick(sender As Object, e As DataGridViewCellEventArgs) Handles dgMedicamentosPorVenta.CellContentClick
        Dim id As String = Convert.ToString(dgMedicamentosPorVenta.CurrentRow.Cells("NroMedicamento").Value)
        Dim eliminado As Boolean = dgMedicamentosPorVenta.CurrentRow.Cells("Eliminado").Value
        Dim nombreMedicamento As String = Convert.ToString(dgMedicamentosPorVenta.CurrentRow.Cells("Medicamento").Value)
        Dim result As Integer
        Dim venta_medicamento_id As String = Convert.ToString(dgMedicamentosPorVenta.CurrentRow.Cells("venta_medicamento_id").Value)

        Dim ventaElegida = BLL.Venta.GetInstance().ListarVentaById(venta)
        medicamentos.Clear()
        For Each item In ventaElegida.medicamentos
            medicamentos.Add(item)
        Next



        If e.ColumnIndex = 6 Then 'Nro Columna del datagriew
            result = MessageBox.Show("¿Esta seguro que desea sacar el medicamento: " & nombreMedicamento & "?", "Medicamento por Venta", MessageBoxButtons.OKCancel, MessageBoxIcon.Question)
            If result = DialogResult.OK Then
                For i = medicamentos.Count - 1 To 0 Step -1
                    If medicamentos(i).ventaMedicamentoId = venta_medicamento_id Then
                        medicamentos.RemoveAt(i)
                        RegistrarVenta(False, True)
                        Exit For
                    End If
                Next
            End If
        End If
        dgMedicamentosPorVenta.Rows.Clear()
        ObtenerMedicamentosPorVenta()
    End Sub

    Public Sub ObtenerMedicamentosPorVenta()
        MostrarDatos()
        txtImporteTotal.Text = 0
        venta.ventaId = _id
        Dim ventaBE = BLL.Venta.GetInstance().ListarVentaById(venta)
        For Each item In ventaBE.medicamentos
            Dim ventaMedicamento As New BE.VentaMedicamento
            Dim n As Integer = dgMedicamentosPorVenta.Rows.Add()
            dgMedicamentosPorVenta.Rows.Item(n).Cells("gvBtnEliminarMedicamento").Value = TraduccionBLL.TraducirTexto("Quitar Medicamento")
            dgMedicamentosPorVenta.Rows.Item(n).Cells("venta_medicamento_id").Value = item.ventaMedicamentoId
            dgMedicamentosPorVenta.Rows.Item(n).Cells("NroMedicamento").Value = item.Medicamento.medicamentoId
            dgMedicamentosPorVenta.Rows.Item(n).Cells("Medicamento").Value = item.Medicamento.descripcion
            dgMedicamentosPorVenta.Rows.Item(n).Cells("Receta").Value = IIf(item.Medicamento.Receta, "SI", "NO")
            dgMedicamentosPorVenta.Rows.Item(n).Cells("CantVenta").Value = SeguridadBLL.DesencriptarRSA(item.CantidadVenta)
            dgMedicamentosPorVenta.Rows.Item(n).Cells("PrecioVenta").Value = SeguridadBLL.DesencriptarRSA(item.PrecioVenta)
            txtImporteTotal.Text = CDbl(txtImporteTotal.Text) + (CInt(SeguridadBLL.DesencriptarRSA(item.CantidadVenta)) * CDbl(SeguridadBLL.DesencriptarRSA(item.PrecioVenta)))
        Next
    End Sub

    Public Sub AgregarMedicamentosPorVenta()
        dgMedicamentosPorVenta.Rows.Clear()
        Dim medicamento As New BE.Medicamento

        medicamento.medicamentoId = cmbMedicamento.SelectedValue
        medicamento.descripcion = DirectCast(cmbMedicamento.SelectedItem, System.Collections.Generic.KeyValuePair(Of Integer, String)).Value

        Dim ventaMedicamento As New BE.VentaMedicamento
        ventaMedicamento.ventaMedicamentoId = BLL.Venta.GetInstance.ObtenerMaxIdVenta_Medicamento
        ventaMedicamento.Medicamento = medicamento
        ventaMedicamento.PrecioVenta = SeguridadBLL.EncriptarRSA(txtPrecio.Text)
        ventaMedicamento.CantidadVenta = SeguridadBLL.EncriptarRSA(txtCantidad.Text)
        ventaMedicamento.Venta = venta
        medicamentos.Add(ventaMedicamento)
        RegistrarVenta(False)
        ObtenerMedicamentosPorVenta()
    End Sub

    Private Sub btnAgregarMedicamento_Click(sender As Object, e As EventArgs) Handles btnAgregarMedicamento.Click
        If ValidarAgregarMedicamento() Then
            If ValidarStockPrecio() Then
                AgregarMedicamentosPorVenta()


            End If
        End If
    End Sub

    Private Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click
        If ValidarVenta() Then
            RegistrarVenta(True)
        End If
    End Sub

    Private Sub RegistrarVenta(Optional ByVal var As Boolean = True, Optional ByVal eliminar As Boolean = False)
        Dim clienteBE As New BE.Cliente
        clienteBE.clienteId = cmbCliente.SelectedValue
        clienteBE.NombreCompleto = DirectCast(cmbCliente.SelectedItem, System.Collections.Generic.KeyValuePair(Of Integer, String)).Value

        venta.cliente = clienteBE
        venta.fechaVenta = txtFechaHora.Text
        venta.activo = True
        venta.medicamentos = medicamentos

        If _id = 0 Then
            BLL.Venta.GetInstance.RegistrarVenta(venta)
            ActualizarStock(True)
            MessageBox.Show(TraduccionBLL.TraducirTexto("Se generó una nueva venta") & ": " & txtNroVenta.Text, TraduccionBLL.TraducirTexto("Registra Venta"), MessageBoxButtons.OK, MessageBoxIcon.Information)
            RegistrarBitacora("Registrar Venta: " & txtNroVenta.Text, "Baja")
            _id = BLL.Venta.GetInstance.ObtenerMaxId
        Else
            venta.ventaId = _id
            BLL.Venta.GetInstance.ModificarVenta(venta)
            If var = False Then
                If eliminar = False Then
                    ActualizarStock(True)
                Else
                    ActualizarStock(False)
                End If
            End If
            MessageBox.Show(TraduccionBLL.TraducirTexto("Se Modifico la venta") & ": " & txtNroVenta.Text, TraduccionBLL.TraducirTexto("Modificar Venta"), MessageBoxButtons.OK, MessageBoxIcon.Information)
            RegistrarBitacora("Modificar Venta: " & txtNroVenta.Text, "Baja")
            End If
            txtPrecioLista.Text = ""
            txtDisponible.Text = ""
            txtDisponible.Text = SeguridadBLL.DesencriptarRSA(ObtenerMedicamento.cantidad)
            txtPrecioLista.Text = SeguridadBLL.DesencriptarRSA(ObtenerMedicamento.precio)

            If var Then
                Me.DialogResult = Windows.Forms.DialogResult.OK
                Me.Close()
            End If
    End Sub

    Public Sub ActualizarStock(operador As Boolean)
        Dim MedicamantoStock As New BE.Medicamento
        Dim cantidadStock As Integer
        If operador Then
            cantidadStock = SeguridadBLL.DesencriptarRSA(ObtenerMedicamento.cantidad) - CInt(txtCantidad.Text)
            MedicamantoStock.medicamentoId = cmbMedicamento.SelectedValue
        Else
            Dim CantidadVenta As Integer = dgMedicamentosPorVenta.CurrentRow.Cells("CantVenta").Value
            Dim id As Integer = dgMedicamentosPorVenta.CurrentRow.Cells("NroMedicamento").Value
            cantidadStock = SeguridadBLL.DesencriptarRSA(ObtenerMedicamento(id).cantidad) + CInt(CantidadVenta)
            MedicamantoStock.medicamentoId = dgMedicamentosPorVenta.CurrentRow.Cells("NroMedicamento").Value
        End If

        MedicamantoStock.cantidad = SeguridadBLL.EncriptarRSA(cantidadStock)
        BLL.Medicamento.GetInstance.ActualizarStock(MedicamantoStock)
    End Sub

    Private Function ValidarAgregarMedicamento() As Boolean
        Dim valido = True
        lblclienteE.Visible = False
        If cmbCliente.SelectedValue = 0 Then
            valido = False
            lblclienteE.Visible = True
            lblclienteE.Text = TraduccionBLL.TraducirTexto("Seleccione el Cliente")
        End If
        lblmedicamentoE.Visible = False
        If cmbMedicamento.SelectedValue = 0 Then
            valido = False
            lblmedicamentoE.Visible = True
            lblmedicamentoE.Text = TraduccionBLL.TraducirTexto("Seleccione el Medicamento")
        End If
        lblPrecioE.Visible = False
        If txtPrecio.Text = "" Then
            valido = False
            lblPrecioE.Visible = True
            lblPrecioE.Text = TraduccionBLL.TraducirTexto("Campo requerido")
        End If
        Return valido
    End Function

    Private Function ValidarStockPrecio() As Boolean
        Dim valido = True
        Dim cantStock As Integer = SeguridadBLL.DesencriptarRSA(ObtenerMedicamento.cantidad)
        Dim preStock As Double = SeguridadBLL.DesencriptarRSA(ObtenerMedicamento.precio)
        If cantStock < CInt(txtCantidad.Text) Then
            valido = False
            MsgBox(TraduccionBLL.TraducirTexto("No hay Stock sufiente en el almacen de medicamentos."), MsgBoxStyle.Critical, "Error")
        End If
        If CDbl(txtPrecio.Text) < (preStock) Then
            valido = False
            MsgBox(TraduccionBLL.TraducirTexto("El Precio de venta es menor al medicamento que se requiere vender."), MsgBoxStyle.Critical, "Error")
        End If
        Return valido
    End Function

    Private Function ValidarVenta() As Boolean
        Dim valido = True
        lblclienteE.Visible = False
        If cmbCliente.SelectedValue = 0 Then
            valido = False
            lblclienteE.Visible = True
            lblclienteE.Text = TraduccionBLL.TraducirTexto("Seleccione el Cliente")
        End If
        If medicamentos.Count = 0 Then
            valido = False
            MsgBox(TraduccionBLL.TraducirTexto("Debe ingresar por lo menos un medicamento a la venta."), MsgBoxStyle.Critical, "Error")
        End If
        Return valido
    End Function

    Private Sub cmbMedicamento_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cmbMedicamento.SelectedIndexChanged
        txtPrecioLista.Text = ""
        txtDisponible.Text = ""
        txtDisponible.Text = SeguridadBLL.DesencriptarRSA(ObtenerMedicamento.cantidad)
        txtPrecioLista.Text = SeguridadBLL.DesencriptarRSA(ObtenerMedicamento.precio)
    End Sub

    Private Function ObtenerMedicamento(Optional ByVal _medicamentoId As Integer = 0) As BE.Medicamento
        Dim MedicamentoBE As New BE.Medicamento
        If _medicamentoId = 0 Then
            MedicamentoBE.medicamentoId = cmbMedicamento.SelectedValue
        Else
            MedicamentoBE.medicamentoId = _medicamentoId
        End If

        MedicamentoBE = BLL.Medicamento.GetInstance.ListById(MedicamentoBE)
        Return MedicamentoBE
    End Function

    Public Sub RegistrarBitacora(evento As String, nivel As String)
        Dim SeguridadBLL As New BLL.Seguridad
        BitacoraBE.Descripcion = SeguridadBLL.EncriptarRSA(evento)
        BitacoraBE.usuario = MenuUI.GetUsuario
        BitacoraBE.criticidad = nivel
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE)
    End Sub

    Private Sub txtPrecio_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtPrecio.KeyPress
        Dim Cont As Integer
        For i As Integer = 1 To Len(txtPrecio.Text)
            If Mid(txtPrecio.Text, i, 1) = "," Then Cont = Cont + 1
        Next
        Dim Cadena = ""
        If Cont >= 1 Then Cadena = "1234567980" Else Cadena = "1234567890,"
        If InStr(Cadena, e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsControl(e.KeyChar) Then
            e.Handled = False
        Else
            e.Handled = True
        End If
    End Sub
 

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        If _id > 0 Then
            If ValidarVenta() = False Then
                MsgBox(TraduccionBLL.TraducirTexto("La venta ya fue generada!"), MsgBoxStyle.Critical, "Error")
            Else
                Me.DialogResult = Windows.Forms.DialogResult.OK
                Me.Close()
            End If
        Else
            Me.Close()
        End If
    End Sub
End Class