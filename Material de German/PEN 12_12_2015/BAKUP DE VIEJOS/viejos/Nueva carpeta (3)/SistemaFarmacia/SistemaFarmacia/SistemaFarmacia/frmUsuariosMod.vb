Public Class frmUsuariosMod
    Dim BitacoraBE As New BE.Bitacora
    Dim TraduccionBLL As BLL.Traduccion
    Dim SeguridadBLL As New BLL.Seguridad
    Dim unUsuario As New BE.Usuario
    Dim MenuUI As UI.frmMenu
    Private _id As String

    Public Sub New(Optional idParameter As Integer = 0)
        InitializeComponent()
        _id = idParameter
    End Sub

    Private Sub frmUsuariosMod_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        MenuUI = Me.Owner
        TraduccionBLL = New BLL.Traduccion(MenuUI.GetIdioma)
        Dim PatenteBE As New BE.Patente
        PatenteBE.Nombre = "Usuario"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If (BLL.Usuario.GetInstance.VerificarPatente(MenuUI.GetUsuario, PatenteBE) = False) Then
            MsgBox(TraduccionBLL.TraducirTexto("Sus permisos han sido modificados, por favor inicie sesion nuevamente"), MsgBoxStyle.Critical, TraduccionBLL.TraducirTexto("Error"))
            Application.Exit()
        End If
        TraduccionBLL.TraducirForm(Me)
        ObtenerDatos()
        txtuser.Focus()
    End Sub

    Public Sub ObtenerDatos()

        dgFamilias.Rows.Clear()
        For Each FamiliaBE In BLL.Familia.GetInstance().ListAll
            Dim n As Integer = dgFamilias.Rows.Add()
            dgFamilias.Rows.Item(n).Cells("familia_id").Value = FamiliaBE.familiaId
            dgFamilias.Rows.Item(n).Cells("dgAsignarFamilia").Value = False
            dgFamilias.Rows.Item(n).Cells("Nombre_Familia").Value = SeguridadBLL.DesencriptarRSA(FamiliaBE.nombre)
        Next

        dgPatentes.Rows.Clear()
        For Each PatenteBE In BLL.Patente.GetInstance().ListAll
            Dim n As Integer = dgPatentes.Rows.Add()
            dgPatentes.Rows.Item(n).Cells("patente_id").Value = PatenteBE.PatenteId
            dgPatentes.Rows.Item(n).Cells("Nombre").Value = PatenteBE.Nombre
            dgPatentes.Rows.Item(n).Cells("dgAsignarPatente").Value = False
            dgPatentes.Rows.Item(n).Cells("dgPatenteNegada").Value = False
        Next

        If _id > 0 Then
            unUsuario.UsuarioId = _id
            Dim UsuarioBE = BLL.Usuario.GetInstance().ListById(unUsuario)
            txtuser.Text = SeguridadBLL.DesencriptarRSA(UsuarioBE.NombreUsuario)
            txtapellido.Text = UsuarioBE.Apellido
            txtnombre.Text = UsuarioBE.Nombre
            txtdni.Text = UsuarioBE.Dni
            txtmail.Text = UsuarioBE.Mail

            For Each FamiliaBE In UsuarioBE.familias
                For i = 0 To dgFamilias.Rows.Count - 1
                    If dgFamilias.Rows.Item(i).Cells("familia_id").Value = FamiliaBE.familiaId Then
                        dgFamilias.Rows.Item(i).Cells("dgAsignarFamilia").Value = True
                    End If
                Next
            Next

            For Each PatenteBE In UsuarioBE.patentes
                For i = 0 To dgPatentes.Rows.Count - 1
                    If dgPatentes.Rows.Item(i).Cells("patente_id").Value = PatenteBE.PatenteId Then
                        If PatenteBE.negado = False Then
                            dgPatentes.Rows.Item(i).Cells("dgAsignarPatente").Value = True
                        Else
                            dgPatentes.Rows.Item(i).Cells("dgPatenteNegada").Value = True
                        End If
                    End If
                Next
            Next
        End If
    End Sub


    Public Sub CargarObjetos()
        unUsuario.NombreUsuario = SeguridadBLL.EncriptarRSA(Trim(txtuser.Text))
        unUsuario.Apellido = Trim(txtapellido.Text)
        unUsuario.Nombre = Trim(txtnombre.Text)
        unUsuario.Dni = Trim(txtdni.Text)
        unUsuario.Mail = Trim(txtmail.Text)

        unUsuario.familias.Clear()
        For i = 0 To dgFamilias.Rows.Count - 1
            If dgFamilias.Rows.Item(i).Cells("dgAsignarFamilia").Value = True Then
                Dim FamiliaBE As New BE.Familia
                FamiliaBE.familiaId = dgFamilias.Rows.Item(i).Cells("familia_id").Value
                FamiliaBE.nombre = SeguridadBLL.EncriptarRSA(dgFamilias.Rows.Item(i).Cells("Nombre_Familia").Value)
                unUsuario.familias.Add(FamiliaBE)
            End If
        Next

        unUsuario.patentes.Clear()
        For i = 0 To dgPatentes.Rows.Count - 1
            If dgPatentes.Rows.Item(i).Cells("dgAsignarPatente").Value = True Then
                Dim PatenteBE As New BE.Patente
                PatenteBE.PatenteId = dgPatentes.Rows.Item(i).Cells("patente_id").Value
                PatenteBE.Nombre = dgPatentes.Rows.Item(i).Cells("Nombre").Value
                unUsuario.patentes.Add(PatenteBE)
            End If
        Next

        For i = 0 To dgPatentes.Rows.Count - 1
            If dgPatentes.Rows.Item(i).Cells("dgPatenteNegada").Value = True Then
                Dim PatenteBE As New BE.Patente
                PatenteBE.PatenteId = dgPatentes.Rows.Item(i).Cells("patente_id").Value
                PatenteBE.Nombre = dgPatentes.Rows.Item(i).Cells("Nombre").Value
                PatenteBE.negado = True
                unUsuario.patentes.Add(PatenteBE)
            End If
        Next
    End Sub

    Private Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click
        If Validar() Then
            RegistrarUsuario(True)
        End If
    End Sub

    Private Sub RegistrarUsuario(Optional ByVal var As Boolean = True)
        Dim nombre As String = Trim(txtuser.Text)
        CargarObjetos()
        If _id = 0 Then
            unUsuario.Contraseña = SeguridadBLL.EncriptarMD5(Trim(SeguridadBLL.AutoGenerarContraseña(unUsuario, True)))
            BLL.Usuario.GetInstance.Add(unUsuario)
            MessageBox.Show(TraduccionBLL.TraducirTexto("Se Registro el Usuario") & ": " & nombre, TraduccionBLL.TraducirTexto("Registrar Usuario"), MessageBoxButtons.OK, MessageBoxIcon.Information)
            RegistrarBitacora("Registro Usuario: " & nombre, "Alta")
        Else
            unUsuario.Contraseña = lblcontraseña.Text
            unUsuario.UsuarioId = _id
            BLL.Usuario.GetInstance.Update(unUsuario)
            MessageBox.Show(TraduccionBLL.TraducirTexto("Se Modifico el Usuario") & ": " & nombre, TraduccionBLL.TraducirTexto("Modificar Usuario"), MessageBoxButtons.OK, MessageBoxIcon.Information)
            RegistrarBitacora("Modifico Usuario: " & nombre, "Alta")
        End If
        If var Then
            Me.DialogResult = Windows.Forms.DialogResult.OK
            Me.Close()
        End If
    End Sub

    Private Sub btnRestablecer_Click(sender As Object, e As EventArgs) Handles btnRestablecer.Click
        Dim nombre As String = Trim(txtuser.Text)
        CargarObjetos()
        unUsuario.Contraseña = SeguridadBLL.EncriptarMD5(Trim(SeguridadBLL.AutoGenerarContraseña(unUsuario, True)))
        lblcontraseña.Text = unUsuario.Contraseña
        unUsuario.UsuarioId = _id
        BLL.Usuario.GetInstance.Update(unUsuario)
        MessageBox.Show(TraduccionBLL.TraducirTexto("Se restablecio la contraseña Usuario") & ": " & nombre, TraduccionBLL.TraducirTexto("Modificar Usuario"), MessageBoxButtons.OK, MessageBoxIcon.Information)
        RegistrarBitacora("Modifico Usuario (restablecio la contraseña): " & nombre, "Alta")
    End Sub


    Public Sub RegistrarBitacora(evento As String, nivel As String)
        Dim SeguridadBLL As New BLL.Seguridad
        BitacoraBE.Descripcion = SeguridadBLL.EncriptarRSA(evento)
        BitacoraBE.usuario = MenuUI.GetUsuario
        BitacoraBE.criticidad = nivel
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE)
    End Sub

    Private Function Validar() As Boolean
        Dim valido = True
        lblnombreusuario.Visible = False
        If txtuser.Text = "" Then
            valido = False
            lblnombreusuario.Visible = True
            lblNombreError.Text = TraduccionBLL.TraducirTexto("Campo requerido")
            lblnombreusuario.Text = "Campo requerido"
        Else
            unUsuario.NombreUsuario = SeguridadBLL.EncriptarRSA(Trim(txtuser.Text))
            If BLL.Usuario.GetInstance.VerificarExistencia(unUsuario) And _id = 0 Then
                MsgBox(TraduccionBLL.TraducirTexto("El nombre ingresado ya esta en uso, por favor ingrese otro nombre"), MsgBoxStyle.Critical, TraduccionBLL.TraducirTexto("Error"))
                Return False
            End If
        End If
        lblNombreError.Visible = False
        If txtnombre.Text = "" Then
            valido = False
            lblNombreError.Visible = True
            lblNombreError.Text = TraduccionBLL.TraducirTexto("Campo requerido")
        End If
        lblApellidoError.Visible = False
        If txtapellido.Text = "" Then
            valido = False
            lblApellidoError.Visible = True
            lblApellidoError.Text = TraduccionBLL.TraducirTexto("Campo requerido")
        End If
        lblEmailError.Visible = False
        If txtmail.Text = "" Then
            valido = False
            lblEmailError.Visible = True
            lblEmailError.Text = TraduccionBLL.TraducirTexto("Campo requerido")
        ElseIf SeguridadBLL.ValidarEmail(txtmail.Text) = False Then
            valido = False
            lblEmailError.Visible = True
            lblEmailError.Text = TraduccionBLL.TraducirTexto("Mail incorrecto")
        End If
        lbldniError.Visible = False
        If txtdni.Text = "" Then
            valido = False
            lbldniError.Visible = True
            lbldniError.Text = TraduccionBLL.TraducirTexto("Campo requerido")
        End If
        Return valido
    End Function
    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Me.Close()
    End Sub

    Private Sub dgfamilias_CellValueChanged(sender As Object, e As DataGridViewCellEventArgs) Handles dgFamilias.CellContentClick
        If _id > 0 Then
            If (e.RowIndex >= 0 And e.ColumnIndex = 2) Then
                dgFamilias.CommitEdit(DataGridViewDataErrorContexts.Commit)
                If (dgFamilias.Rows(e.RowIndex).Cells("dgAsignarFamilia").Value = False And BLL.Familia.GetInstance.ValidarEliminarFamiliaUsuario(New BE.Familia With {.familiaId = dgFamilias.Rows(e.RowIndex).Cells("familia_id").Value}, BLL.Usuario.GetInstance.ListById(unUsuario)) = False) Then            '                   
                    MsgBox(TraduccionBLL.TraducirTexto("No se puede quitar la familia al usuario porque contiene patentes esenciales y quedaria sin asignar"), MsgBoxStyle.Critical, TraduccionBLL.TraducirTexto("Error"))
                    ObtenerDatos()
                Else
                    RegistrarUsuario(False)
                End If
            End If
        End If
    End Sub


    Private Sub dgPatentes_CellValueChanged(sender As Object, e As DataGridViewCellEventArgs) Handles dgPatentes.CellContentClick
        If _id > 0 Then
            If (e.RowIndex >= 0 And e.ColumnIndex = 1) Then
                dgPatentes.CommitEdit(DataGridViewDataErrorContexts.Commit)
                If (dgPatentes.Rows(e.RowIndex).Cells("dgAsignarPatente").Value = False And
                     BLL.Usuario.GetInstance.ValidarEliminarUsuarioPatente(BLL.Usuario.GetInstance.ListById(unUsuario), New BE.Patente With {.PatenteId = dgPatentes.Rows(e.RowIndex).Cells("patente_id").Value}) = False) Then            '                   
                    MsgBox(TraduccionBLL.TraducirTexto("No se puede quitar la patente al usuario porque la patente quedaria sin asignacion"), MsgBoxStyle.Critical, TraduccionBLL.TraducirTexto("Error"))
                    ObtenerDatos()
                Else
                    dgPatentes.Rows(e.RowIndex).Cells("dgPatenteNegada").Value = False
                    RegistrarUsuario(False)
                End If
            End If
            If (e.RowIndex >= 0 And e.ColumnIndex = 2) Then
                dgPatentes.CommitEdit(DataGridViewDataErrorContexts.Commit)
                If (dgPatentes.Rows(e.RowIndex).Cells("dgPatenteNegada").Value = True And
                     BLL.Usuario.GetInstance.ValidarEliminarUsuarioPatenteNegacion(BLL.Usuario.GetInstance.ListById(unUsuario), New BE.Patente With {.PatenteId = dgPatentes.Rows(e.RowIndex).Cells("patente_id").Value}) = False) Then            '                   
                    MsgBox(TraduccionBLL.TraducirTexto("No se puede negar la patente al usuario porque la patente quedaria sin asignacion"), MsgBoxStyle.Critical, TraduccionBLL.TraducirTexto("Error"))
                    ObtenerDatos()
                Else
                    dgPatentes.Rows(e.RowIndex).Cells("dgAsignarPatente").Value = False
                    RegistrarUsuario(False)
                End If
            End If
        Else
            If (e.RowIndex >= 0 And e.ColumnIndex = 1) Then
                dgPatentes.Rows(e.RowIndex).Cells("dgPatenteNegada").Value = False
            End If
            If (e.RowIndex >= 0 And e.ColumnIndex = 2) Then
                dgPatentes.Rows(e.RowIndex).Cells("dgAsignarPatente").Value = False
            End If
        End If
    End Sub
End Class