Public Class frmClientes
    Dim BitacoraBE As New BE.Bitacora
    Dim CriticidadBE As New BE.Criticidad
    Dim unCliente As New BE.Cliente
    Dim MenuUI As UI.frmMenu
    Dim TraduccionBLL As BLL.Traduccion
    Dim SeguridadBLL As New BLL.Seguridad

    Private Sub frmClientes_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        MenuUI = Me.MdiParent
        TraduccionBLL = New BLL.Traduccion(MenuUI.GetIdioma)
        TraduccionBLL.TraducirForm(Me)
        ObtenerClientes()
    End Sub
    Private Sub btnRegistrar_Click(sender As Object, e As EventArgs) Handles btnRegistrar.Click
        Dim ClienteRegistrar As New frmClientesMod()
        If ClienteRegistrar.ShowDialog(Me) = Windows.Forms.DialogResult.OK Then
            ObtenerClientes()
        End If
    End Sub

    Public Sub ObtenerClientes()
        dgClientes.Rows.Clear()
        For Each ClienteBE In BLL.Cliente.GetInstance.ListAll()
            Dim n As Integer = dgClientes.Rows.Add()
            dgClientes.Rows.Item(n).Cells("id").Value = ClienteBE.clienteId
            dgClientes.Rows.Item(n).Cells("dni").Value = ClienteBE.dni
            dgClientes.Rows.Item(n).Cells("apellido_nombre").Value = ClienteBE.apellido & ", " & ClienteBE.nombre
            dgClientes.Rows.Item(n).Cells("telefono").Value = ClienteBE.telefono
            dgClientes.Rows.Item(n).Cells("eliminado").Value = ClienteBE.eliminado
            Dim dgModificar = New DataGridViewButtonCell
            dgModificar.Value = "Modificar"
            dgClientes.Rows.Item(n).Cells("dgModificar") = dgModificar
            Dim dgEliminar = New DataGridViewButtonCell()
            If ClienteBE.eliminado = True Then
                dgEliminar.Value = "Activar"
            Else
                dgEliminar.Value = "Eliminar"
            End If
            dgClientes.Rows.Item(n).Cells("dgEliminar") = dgEliminar
        Next
    End Sub


    Private Sub dgClientes_CellContentClick(sender As Object, e As DataGridViewCellEventArgs) Handles dgClientes.CellContentClick
        Dim id As String = Convert.ToString(dgClientes.CurrentRow.Cells("id").Value)
        Dim eliminado As Boolean = dgClientes.CurrentRow.Cells("eliminado").Value
        Dim dni As Integer = Convert.ToString(dgClientes.CurrentRow.Cells("dni").Value)
        Dim Nombre As String
        Dim Descr As String
        Dim result As Integer

        'MODIFICAR
        If e.ColumnIndex = 4 Then 'Nro Columna del datagriew
            Dim ClienteModificar As New frmClientesMod(id)
            Dim SeguridadBLL As New BLL.Seguridad
            ClienteModificar.txtnombre.Focus()

            unCliente.clienteId = id
            unCliente = BLL.Cliente.GetInstance().ListById(unCliente)

            Dim localidad = BLL.Localidad.GetInstance.ListAll
            ClienteModificar.cmbLocalidad.DataSource = localidad
            ClienteModificar.cmbLocalidad.DisplayMember = "descripcion"
            ClienteModificar.cmbLocalidad.ValueMember = "localidadId"
            Dim provincia = BLL.Provincia.GetInstance.ListAll
            ClienteModificar.cmbProvincia.DataSource = provincia
            ClienteModificar.cmbProvincia.DisplayMember = "descripcion"
            ClienteModificar.cmbProvincia.ValueMember = "provinciaId"

            ClienteModificar.cmbLocalidad.SelectedItem = unCliente.localidad.LocalidadId
            ClienteModificar.cmbProvincia.SelectedItem = unCliente.localidad.Provincia.provinciaId

            ClienteModificar.txtnombre.Text = unCliente.nombre
            ClienteModificar.txtdni.Text = unCliente.dni
            ClienteModificar.txtapellido.Text = unCliente.apellido
            ClienteModificar.txtnombre.Text = unCliente.nombre
            ClienteModificar.txtemail.Text = unCliente.email
            ClienteModificar.txttelefono.Text = unCliente.telefono
            ClienteModificar.txtdireccion.Text = unCliente.direccion


            If ClienteModificar.ShowDialog(Me) = Windows.Forms.DialogResult.OK Then
                ObtenerClientes()
            End If
        End If
        'ELIMINAR
        If e.ColumnIndex = 5 Then 'Nro Columna del datagriew
            If eliminado = True Then
                eliminado = False
                Descr = "Activar"
                Nombre = "Se activo el Cliente: " & dni
            Else
                eliminado = True
                Descr = "Eliminar"
                Nombre = "Elimino Cliente: " & dni
            End If
            result = MessageBox.Show("¿Esta seguro que desea " & Descr & " el Cliente: " & dni & "?", Descr & "Cliente", MessageBoxButtons.OKCancel, MessageBoxIcon.Question)
            If result = DialogResult.OK Then
                unCliente.clienteId = id
                unCliente.eliminado = eliminado
                BLL.Cliente.GetInstance.Delete(unCliente)
                MessageBox.Show(Nombre, Descr & "Cliente", MessageBoxButtons.OK, MessageBoxIcon.Information)
                RegistrarBitacora(Nombre, "Alta")
            End If
        End If
        ObtenerClientes()
    End Sub
    Public Sub RegistrarBitacora(evento As String, nivel As String)
        Dim SeguridadBLL As New BLL.Seguridad
        BitacoraBE.descripcion = SeguridadBLL.EncriptarRSA(evento)
        BitacoraBE.usuario = MenuUI.GetUsuario
        CriticidadBE.nombre = nivel
        BitacoraBE.criticidad = CriticidadBE
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE)
    End Sub


    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Me.Close()
    End Sub


End Class