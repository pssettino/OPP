Public Class frmClientesMod
    Dim BitacoraBE As New BE.Bitacora
    Dim CriticidadBE As New BE.Criticidad

    Dim TraduccionBLL As BLL.Traduccion
    Dim SeguridadBLL As New BLL.Seguridad

    Dim unCliente As New BE.Cliente
    Dim MenuUI As UI.frmMenu
    Private _id As String

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Me.Close()
    End Sub

    Public Sub New(Optional idParameter As Integer = 0)
        InitializeComponent()
        _id = idParameter
    End Sub
    Private Sub frmClientesMod_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        MenuUI = Me.Owner
        TraduccionBLL = New BLL.Traduccion(MenuUI.GetIdioma)
        TraduccionBLL.TraducirForm(Me)

        If _id = 0 Then
            Dim localidad = BLL.Localidad.GetInstance.ListAll
            cmbLocalidad.DataSource = localidad
            cmbLocalidad.DisplayMember = "descripcion"
            cmbLocalidad.ValueMember = "localidadId"
            Dim provincia = BLL.Provincia.GetInstance.ListAll
            cmbProvincia.DataSource = provincia
            cmbProvincia.DisplayMember = "descripcion"
            cmbProvincia.ValueMember = "provinciaId"
        End If
    End Sub

    Private Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click

        If Validar() Then
            Dim dni As String = Trim(txtdni.Text)
            Dim localidadBE As New BE.Localidad
            Dim provinciaBE As New BE.Provincia

            unCliente.dni = dni

            provinciaBE.provinciaId = cmbProvincia.SelectedValue
            localidadBE.LocalidadId = cmbLocalidad.SelectedValue
            localidadBE.Provincia = provinciaBE
            unCliente.localidad = localidadBE
            unCliente.apellido = Trim(txtapellido.Text)
            unCliente.nombre = Trim(txtnombre.Text)
            unCliente.email = Trim(txtemail.Text)
            unCliente.telefono = Trim(txttelefono.Text)
            unCliente.direccion = Trim(txtdireccion.Text)
 

            If _id = 0 Then
                BLL.Cliente.GetInstance.Add(unCliente)
                MessageBox.Show(TraduccionBLL.TraducirTexto("Se Registro el Cliente") & ": " & dni, TraduccionBLL.TraducirTexto("Registrar Cliente"), MessageBoxButtons.OK, MessageBoxIcon.Information)
                RegistrarBitacora("Registro Cliente: " & dni, "Alta")
            Else
                unCliente.clienteId = _id
                BLL.Cliente.GetInstance.Update(unCliente)
                MessageBox.Show(TraduccionBLL.TraducirTexto("Se Modifico el Cliente") & ": " & dni, TraduccionBLL.TraducirTexto("Modificar Cliente"), MessageBoxButtons.OK, MessageBoxIcon.Information)
                RegistrarBitacora("Modifico Cliente: " & dni, "Alta")
            End If

            Me.DialogResult = Windows.Forms.DialogResult.OK
            Me.Close()
        End If
    End Sub


    Private Function Validar() As Boolean
        Dim valido = True
        lblapellidoError.Visible = False
        If txtapellido.Text = "" Then
            valido = False
            lblapellidoError.Visible = True
            lblapellidoError.Text = "Campo requerido"
        End If
        lblmailError.Visible = False
        If txtemail.Text = "" Then
            valido = False
            lblmailError.Visible = True
            lblmailError.Text = "Campo requerido"
        Else
            If SeguridadBLL.ValidarEmail(txtemail.Text) = False Then
                valido = False
                lblmailError.Visible = True
                lblmailError.Text = "Mail incorrecto"
            End If
        End If
        lbldnierror.Visible = False
        If txtdni.Text = "" Then
            valido = False
            lbldnierror.Visible = True
            lbldnierror.Text = "Campo requerido"
        Else
            If SeguridadBLL.ValidarDNI(txtdni.Text) = False Then
                valido = False
                lbldnierror.Visible = True
                lbldnierror.Text = "DNI incorrecto"
            End If
        End If
        Lblnombreerror.Visible = False
        If txtnombre.Text = "" Then
            valido = False
            Lblnombreerror.Visible = True
            Lblnombreerror.Text = "Campo requerido"
        End If
        lbltelerror.Visible = False
        If txttelefono.Text = "" Then
            valido = False
            lbltelerror.Visible = True
            lbltelerror.Text = "Campo requerido"
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