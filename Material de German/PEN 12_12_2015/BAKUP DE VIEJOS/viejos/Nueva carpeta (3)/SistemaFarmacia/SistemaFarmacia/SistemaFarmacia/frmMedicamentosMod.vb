Public Class frmMedicamentosMod
    Dim BitacoraBE As New BE.Bitacora
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
        Dim PatenteBE As New BE.Patente
        PatenteBE.Nombre = "Medicamento"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If (BLL.Usuario.GetInstance.VerificarPatente(MenuUI.GetUsuario, PatenteBE) = False) Then
            MsgBox(TraduccionBLL.TraducirTexto("Sus permisos han sido modificados, por favor inicie sesion nuevamente"), MsgBoxStyle.Critical, TraduccionBLL.TraducirTexto("Error"))
            Application.Exit()
        End If
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
                MessageBox.Show(TraduccionBLL.TraducirTexto("Se Registro el Medicamento") & ": " & nombre, TraduccionBLL.TraducirTexto("Registrar Medicamento"), MessageBoxButtons.OK, MessageBoxIcon.Information)
                RegistrarBitacora("Registro Medicamento: " & nombre, "Alta")
            Else
                unMedicamento.medicamentoId = _id
                BLL.Medicamento.GetInstance.Update(unMedicamento)
                MessageBox.Show(TraduccionBLL.TraducirTexto("Se Modifico el Medicamento") & ": " & nombre, TraduccionBLL.TraducirTexto("Modificar Medicamento"), MessageBoxButtons.OK, MessageBoxIcon.Information)
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
            lblnombreE.Text = TraduccionBLL.TraducirTexto("Campo requerido")
        End If
        lbllaboratorioE.Visible = False
        If cmbLaboratorio.SelectedValue = 0 Then
            valido = False
            lbllaboratorioE.Visible = True
            lbllaboratorioE.Text = TraduccionBLL.TraducirTexto("Campo requerido")
        End If
        lblCantidadE.Visible = False
        If txtcantidad.Text = "" Then
            valido = False
            lblCantidadE.Visible = True
            lblCantidadE.Text = TraduccionBLL.TraducirTexto("Campo requerido")
        End If
        lblPrecioE.Visible = False
        If txtprecio.Text = "" Then
            valido = False
            lblPrecioE.Visible = True
            lblPrecioE.Text = TraduccionBLL.TraducirTexto("Campo requerido")
        End If
        Return valido
    End Function

    Public Sub RegistrarBitacora(evento As String, nivel As String)
        Dim SeguridadBLL As New BLL.Seguridad
        BitacoraBE.Descripcion = SeguridadBLL.EncriptarRSA(evento)
        BitacoraBE.usuario = MenuUI.GetUsuario
        BitacoraBE.criticidad = nivel
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE)
    End Sub

End Class