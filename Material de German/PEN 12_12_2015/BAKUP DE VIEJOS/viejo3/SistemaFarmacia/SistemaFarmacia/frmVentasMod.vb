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

        Dim clientesLista As New Dictionary(Of Integer, String)
        clientesLista.Add(0, TraduccionBLL.TraducirTexto("Seleccione el cliente"))
        For Each ClienteBE In BLL.Cliente.GetInstance.ObtenerClientesDisponibles()
            clientesLista.Add(ClienteBE.clienteId, ClienteBE.NombreCompleto)
        Next
        cmbCliente.DisplayMember = "Value"
        cmbCliente.ValueMember = "Key"
        cmbCliente.DataSource = New BindingSource(clientesLista, Nothing)
     
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

        If e.ColumnIndex = 5 Then 'Nro Columna del datagriew
            result = MessageBox.Show("¿Esta seguro que desea sacar el medicamento: " & nombreMedicamento & "?", "Medicamento por Venta", MessageBoxButtons.OKCancel, MessageBoxIcon.Question)
            If result = DialogResult.OK Then
                For Each item In medicamentos
                    If item.Medicamento.medicamentoId = id Then
                        medicamentos.Remove(item)
                        RegistrarVenta(False)
                        Exit For
                    End If
                Next
            End If
        End If
        dgMedicamentosPorVenta.Rows.Clear()
        ObtenerMedicamentosPorVenta()
    End Sub

    Public Sub ObtenerMedicamentosPorVenta()
        txtImporteTotal.Text = 0
        For Each item In medicamentos
            Dim n As Integer = dgMedicamentosPorVenta.Rows.Add()
            dgMedicamentosPorVenta.Rows.Item(n).Cells("gvBtnEliminarMedicamento").Value = TraduccionBLL.TraducirTexto("Quitar Medicamento")
            dgMedicamentosPorVenta.Rows.Item(n).Cells("NroMedicamento").Value = item.Medicamento.medicamentoId
            dgMedicamentosPorVenta.Rows.Item(n).Cells("Medicamento").Value = item.Medicamento.descripcion
            dgMedicamentosPorVenta.Rows.Item(n).Cells("Receta").Value = IIf(item.Medicamento.Receta, "SI", "NO")
            dgMedicamentosPorVenta.Rows.Item(n).Cells("CantVenta").Value = item.CantidadVenta
            dgMedicamentosPorVenta.Rows.Item(n).Cells("PrecioVenta").Value = item.PrecioVenta
            txtImporteTotal.Text = CDbl(txtImporteTotal.Text) + (CInt(item.CantidadVenta) * CDbl(item.PrecioVenta))
        Next
    End Sub

    Public Sub AgregarMedicamentosPorVenta()
        dgMedicamentosPorVenta.Rows.Clear()
        Dim medicamento As New BE.Medicamento

        medicamento.medicamentoId = cmbMedicamento.SelectedValue
        medicamento.descripcion = DirectCast(cmbMedicamento.SelectedItem, System.Collections.Generic.KeyValuePair(Of Integer, String)).Value

        Dim ventaMedicamento As New BE.VentaMedicamento
        ventaMedicamento.Medicamento = medicamento
        ventaMedicamento.PrecioVenta = CDbl(txtPrecio.Text)
        ventaMedicamento.CantidadVenta = CInt(txtCantidad.Text)
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

    Private Sub RegistrarVenta(Optional ByVal var As Boolean = True)
        Dim clienteBE As New BE.Cliente
        clienteBE.clienteId = cmbCliente.SelectedValue
        clienteBE.NombreCompleto = DirectCast(cmbCliente.SelectedItem, System.Collections.Generic.KeyValuePair(Of Integer, String)).Value

        venta.cliente = clienteBE
        venta.fechaVenta = Date.Now
        venta.activo = True
        venta.medicamentos = medicamentos

        If _id = 0 Then
            BLL.Venta.GetInstance.RegistrarVenta(venta)
            MessageBox.Show(TraduccionBLL.TraducirTexto("Se Registro la venta") & ": " & txtNroVenta.Text, TraduccionBLL.TraducirTexto("Registra Venta"), MessageBoxButtons.OK, MessageBoxIcon.Information)
            RegistrarBitacora("Registrar Venta: " & txtNroVenta.Text, "Baja")
        Else
            BLL.Venta.GetInstance.RegistrarVenta(venta)
            MessageBox.Show(TraduccionBLL.TraducirTexto("Se Modifico la venta") & ": " & txtNroVenta.Text, TraduccionBLL.TraducirTexto("Modificar Venta"), MessageBoxButtons.OK, MessageBoxIcon.Information)
            RegistrarBitacora("Modificar Venta: " & txtNroVenta.Text, "Baja")
        End If
        If var Then
            Me.DialogResult = Windows.Forms.DialogResult.OK
            Me.Close()
        End If
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
        If SeguridadBLL.DesencriptarRSA(ObtenerMedicamento.cantidad) < txtCantidad.Text Then
            valido = False
            MsgBox(TraduccionBLL.TraducirTexto("No hay Stock sufiente en el almacen de medicamentos."), MsgBoxStyle.Critical, "Error")
        End If
        If SeguridadBLL.DesencriptarRSA(ObtenerMedicamento.precio) > txtPrecio.Text Then
            valido = False
            MsgBox(TraduccionBLL.TraducirTexto("El Precio es menor al medicamento que se requiere vender."), MsgBoxStyle.Critical, "Error")
        End If
        Return valido
    End Function

    Private Function ValidarVenta() As Boolean
        Dim valido = True
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

    Private Function ObtenerMedicamento() As BE.Medicamento
        Dim MedicamentoBE As New BE.Medicamento
        MedicamentoBE.medicamentoId = cmbMedicamento.SelectedValue
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
End Class