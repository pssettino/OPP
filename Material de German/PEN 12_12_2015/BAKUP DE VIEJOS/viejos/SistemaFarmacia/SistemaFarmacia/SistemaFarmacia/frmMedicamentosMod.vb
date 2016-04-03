Public Class frmMedicamentosMod
    Dim BitacoraBE As New BE.Bitacora
    Dim CriticidadBE As New BE.Criticidad
    Dim LaboratorioBLL As New BLL.Laboratorio

    Dim TraduccionBLL As BLL.Traduccion
    Dim SeguridadBLL As New BLL.Seguridad

    Dim unMedicamento As New BE.Medicamento
    Dim MenuUI As UI.frmMenu
    Private _id As String

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Me.Close()
    End Sub

    Public Sub New(Optional idParameter As Integer = 0)
        InitializeComponent()
        _id = idParameter
    End Sub
    Private Sub frmMedicamentosMod_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        MenuUI = Me.Owner
        TraduccionBLL = New BLL.Traduccion(MenuUI.GetIdioma)
        TraduccionBLL.TraducirForm(Me)

        If _id = 0 Then
            cmbLaboratorio.DataSource = LaboratorioBLL.ObtenerLaboratorios
            cmbLaboratorio.ValueMember = "laboratorioId"
            cmbLaboratorio.DisplayMember = "razonSocial"
        End If
    End Sub

    Private Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click

        If Validar() Then
            Dim nombre As String = Trim(txtnombre.Text)
            Dim laboratorioSEL As Integer = cmbLaboratorio.SelectedValue
            Dim laboratorioBE As New BE.Laboratorio

            unMedicamento.descripcion = nombre

            laboratorioBE.laboratorioId = laboratorioSEL
            unMedicamento.laboratorio = laboratorioBE
            unMedicamento.Receta = CheckReceta.CheckState
            unMedicamento.cantidad = SeguridadBLL.EncriptarRSA(Trim(txtcantidad.Text))
            unMedicamento.precio = SeguridadBLL.EncriptarRSA(Trim(txtprecio.Text))

            If _id = 0 Then
                BLL.Medicamento.GetInstance.Add(unMedicamento)
                MessageBox.Show("Se Registro el Medicamento: " & nombre, "Registrar Medicamento", MessageBoxButtons.OK, MessageBoxIcon.Information)
                RegistrarBitacora("Registro Medicamento: " & nombre, "Alta")
            Else
                unMedicamento.medicamentoId = _id
                BLL.Medicamento.GetInstance.Update(unMedicamento)
                MessageBox.Show("Se Modifico el Medicamento: " & nombre, "Modificar Medicamento", MessageBoxButtons.OK, MessageBoxIcon.Information)
                RegistrarBitacora("Modifico Medicamento: " & nombre, "Alta")
            End If

            Me.DialogResult = Windows.Forms.DialogResult.OK
            Me.Close()
        End If
    End Sub


    Private Function Validar() As Boolean
        Dim valido = True
        lblnombreE.Visible = False
        If txtnombre.Text = "" Then
            valido = False
            lblnombreE.Visible = True
            'lblnombreE.Text = TraduccionBLL.TraducirTexto("Campo requerido")
            lblnombreE.Text = "Campo requerido"
        End If
        'lbllaboratorioE.Visible = False
        'If cmbLaboratorio.SelectedItem = 0 Then
        '    valido = False
        '    lbllaboratorioE.Visible = True
        '    'lbllaboratorioE.Text = TraduccionBLL.TraducirTexto("Campo requerido")
        '    lbllaboratorioE.Text = "Campo requerido"
        'End If
        lblCantidadE.Visible = False
        If txtcantidad.Text = "" Then
            valido = False
            lblCantidadE.Visible = True
            'lblNombreError.Text = TraduccionBLL.TraducirTexto("Campo requerido")
            lblCantidadE.Text = "Campo requerido"
        End If
        lblPrecioE.Visible = False
        If txtprecio.Text = "" Then
            valido = False
            lblPrecioE.Visible = True
            'lblPrecioE.Text = TraduccionBLL.TraducirTexto("Campo requerido")
            lblPrecioE.Text = "Campo requerido"
        End If
        Return valido
    End Function


    Public Sub RegistrarBitacora(evento As String, nivel As String)
        Dim SeguridadBLL As New BLL.Seguridad
        BitacoraBE.Descripcion = SeguridadBLL.EncriptarRSA(evento)
        BitacoraBE.usuario = MenuUI.GetUsuario
        CriticidadBE.nombre = nivel
        BitacoraBE.criticidad = CriticidadBE
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE)
    End Sub

End Class