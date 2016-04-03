Imports BE
Imports System.Resources
Imports System.Globalization
Imports System.Text.RegularExpressions
Public Class frmCliente

    Dim cliente As New BE.Cliente
    Dim campo As String

#Region "ABM CLIENTES"

    Private Sub Alta(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClieAlta.Click
        Dim ObjBitacora As New BE.Bitacora
        Dim cliente As New BE.Cliente
        Dim dvh As Long = 0
        Try
            'Validacion de campos en el formularo cliente
            If txtnom.Text = "" Or txtnom.TextLength > 30 Then
                If txtnom.Text = "" Then
                    MsgBox("Debe completar el campo Nombre", MsgBoxStyle.Information, "Clientes")
                ElseIf txtnom.TextLength > 30 Then
                    MsgBox("El Nombre Ingresado tiene demasiados caracteres", MsgBoxStyle.Information, "Clientes")
                End If
                Exit Sub
            ElseIf txtape.Text = "" Or txtape.TextLength > 30 Then
                If txtape.Text = "" Then
                    MsgBox("Debe completar el campo Apellido", MsgBoxStyle.Information, "Clientes")
                ElseIf txtape.TextLength > 30 Then
                    MsgBox("El Apellido Ingresado tiene demasiados caracteres", MsgBoxStyle.Information, "Clientes")
                End If
                Exit Sub
            ElseIf txtdni.Text = "" Or txtdni.TextLength < 7 Or txtdni.TextLength > 8 Then
                If txtdni.Text = "" Then
                    MsgBox("Debe completar el campo DNI", MsgBoxStyle.Information, "Clientes")
                ElseIf txtdni.TextLength < 7 Or txtdni.TextLength > 8 Then
                    MsgBox("La cantidad de digitos del DNI es incorrecta", MsgBoxStyle.Information, "Clientes")
                End If
                Exit Sub
            ElseIf txttel.Text = "" Then
                MsgBox("Debe completar el campo Telefono", MsgBoxStyle.Information, "Clientes")
                Exit Sub
            ElseIf txtdir.Text = "" Or txtdir.TextLength > 30 Then
                If txtdir.Text = "" Then
                    MsgBox("Debe completar el campo Direccion", MsgBoxStyle.Information, "Clientes")
                ElseIf txtdir.TextLength > 30 Then
                    MsgBox("La Direccion Ingresado tiene demasiados caracteres", MsgBoxStyle.Information, "Clientes")
                End If
                Exit Sub
                'ElseIf txtsaldo.Text = "" Then
                '    MsgBox("Debe completar el campo Saldo", MsgBoxStyle.Information, "Clientes")
                '    Exit Sub
                'ElseIf CMBLib.SelectedItem Is Nothing Then
                '    MsgBox("Debe Seleccionar un libro", MsgBoxStyle.Information, "Clientes")
                '    Exit Sub
            ElseIf dtp.Text > Date.Now Then
                MsgBox("La fecha no puede ser mayor al dia de hoy", MsgBoxStyle.Information, "Clientes")
                Exit Sub
            End If
            If txtemail.Text = "" Or txtemail.TextLength > 50 Then
                If txtemail.Text = "" Then
                    MsgBox("Debe completar el campo Email", MsgBoxStyle.Information, "Clientes")
                ElseIf txtemail.TextLength > 30 Then
                    MsgBox("La direccion de correo ingresada tiene demasiados caracteres", MsgBoxStyle.Information, "Clientes")
                End If
                Exit Sub
            End If
            'Empiezo a armar el objeto cliente
            cliente._nom = txtnom.Text
            cliente._ape = txtape.Text
            cliente._dir = txtdir.Text
            cliente._dni = txtdni.Text
            cliente._email = txtemail.Text
            cliente._fec_alta = dtp.Text
            'cliente._saldo = txtsaldo.Text
            cliente._tel = txttel.Text
            'cliente.lib_id = CMBLib.SelectedItem
            cliente._activo = True
            'Calculo el DVH CLiente
            cliente._dvh = BLL.Seguridad.GetInstance.CalcularDVHCliente(cliente)
            'Valido si existe el Cliente
            If BLL.Cliente.GetInstance.ValidarExistencia(cliente) = False Then
                Exit Sub
            ElseIf BLL.Cliente.GetInstance.ValidarExistencia(cliente) = True Then
                'Doy de alta el Cliente
                BLL.Cliente.GetInstance.Alta(cliente)
                'Doy de alta el usuairo y grabo en bitacora
                ObjBitacora._desc = "Alta Cliente"
                ObjBitacora._fecha = Now
                ObjBitacora._usu_id._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
                ObjBitacora._crit_id._id = BLL.Criticidad.GetInstance.RecuperarId(New BE.Criticidad("Bajo"))
                ObjBitacora._usu_log = frmlogin.TextBox1.Text
                ObjBitacora._dvh = BLL.Seguridad.GetInstance.CalcularDVHBitacora(ObjBitacora)
                BLL.Bitacora.GetInstance.RegistrarBitacora(ObjBitacora)
                'Recalculo DVV Luego de los movimientos que hice
                BLL.Seguridad.GetInstance.ReCalcularDVV("BITACORA")
                cliente._activo = True
                'Idioma
                If frmlogin.RadioButton1.Checked = True Then
                    MsgBox("Create Ok", MsgBoxStyle.Information, "Client")
                End If
                'Idioma
                If frmlogin.RadioButton1.Checked = False Then
                    MsgBox("Alta Exitosa", MsgBoxStyle.Information, "Clientes")
                    Exit Sub
                End If
            End If

        Catch ex As Exception
            MsgBox(ex)
            If frmlogin.RadioButton1.Checked = True Then
                MsgBox("Error in Create Client", MsgBoxStyle.Information, "Client")
            End If
            'Vuelvo al Espanol
            If frmlogin.RadioButton1.Checked = False Then
                MsgBox("Error en Alta Cliente", MsgBoxStyle.Information, "Clientes")
            End If
        End Try
    End Sub

    Private Sub Listar(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClieList.Click

        Dim cliente As New BE.Cliente
        Dim objdesenc As New BE.Cliente

        'Liso clientes Muestro u oculto lo que necesito
        dgclie.DataSource = BLL.Cliente.GetInstance.Listar
        dgclie.Columns(0).Visible = False
        dgclie.Columns(11).Visible = False
        dgclie.Columns(2).Visible = False
        dgclie.Columns(12).Visible = False
        dgclie.Columns(6).Visible = False
        dgclie.Columns(1).HeaderText = "Numero de Cliente"
        dgclie.Columns(3).HeaderText = "Nombre"
        dgclie.Columns(4).HeaderText = "Apellido"
        dgclie.Columns(5).HeaderText = "Direccion"
        dgclie.Columns(7).HeaderText = "Telefono"
        dgclie.Columns(8).HeaderText = "Saldo"
        dgclie.Columns(9).HeaderText = "Fecha de Alta"
        dgclie.Columns(10).HeaderText = "Dni"


    End Sub

    Private Sub btModificar(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClieMod.Click
        Dim cliente As New BE.Cliente
        Dim objbitacora As New BE.Bitacora


        'cliente.lib_id._id = DirectCast(dgclie.CurrentRow.Cells(2).Value, BE.Libro)._id
        cliente.ID = dgclie.CurrentRow.Cells(1).Value
        cliente._nom = dgclie.CurrentRow.Cells(3).Value
        cliente._ape = dgclie.CurrentRow.Cells(4).Value
        cliente._dir = dgclie.CurrentRow.Cells(5).Value
        cliente._saldo = dgclie.CurrentRow.Cells(6).Value
        cliente._dni = dgclie.CurrentRow.Cells(8).Value

        cliente._fec_alta = dgclie.CurrentRow.Cells(9).Value
        cliente._tel = dgclie.CurrentRow.Cells(7).Value
        cliente._email = dgclie.CurrentRow.Cells(10).Value



        cliente._dvh = BLL.Seguridad.GetInstance.CalcularDVHCliente(cliente)

        'Bajo el obj a la BLL
        BLL.Cliente.GetInstance.Modificar(cliente)

        'Comienzo a armar el obj para grabar en bitacora
        objbitacora._desc = "Cliente Modificado"
        objbitacora._fecha = Now
        objbitacora._dvh = 5
        objbitacora._usu_id._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
        objbitacora._crit_id._id = BLL.Criticidad.GetInstance.RecuperarId(New BE.Criticidad("Medio"))
        objbitacora._usu_log = frmlogin.TextBox1.Text
        objbitacora._dvh = BLL.Seguridad.GetInstance.CalcularDVHBitacora(objbitacora)
        BLL.Bitacora.GetInstance.RegistrarBitacora(objbitacora)
        BLL.Seguridad.GetInstance.ReCalcularDVV("BITACORA")
        MsgBox("Se guardaron los cambios Correctamente", MsgBoxStyle.Information, "Clientes")

    End Sub

    Private Sub btnbaja_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCliebaja.Click
        Dim cliente As New BE.Cliente
        Dim objbitacora As New BE.Bitacora
        Try

            cliente.ID = dgclie.CurrentRow.Cells(1).Value
            'cliente.lib_id = dgclie.CurrentRow.Cells(2).Value
            cliente._nom = dgclie.CurrentRow.Cells(3).Value
            cliente._ape = dgclie.CurrentRow.Cells(4).Value
            cliente._dir = dgclie.CurrentRow.Cells(5).Value
            cliente._tel = dgclie.CurrentRow.Cells(6).Value
            cliente._saldo = dgclie.CurrentRow.Cells(7).Value
            cliente._fec_alta = dgclie.CurrentRow.Cells(8).Value
            cliente._dni = dgclie.CurrentRow.Cells(9).Value
            cliente._email = dgclie.CurrentRow.Cells(10).Value

            'Calculo DVH Cliente
            cliente._dvh = BLL.Seguridad.GetInstance.CalcularDVHCliente(cliente)

            'Paso el obj a la bll para dar de baja
            If BLL.Cliente.GetInstance.Baja(cliente) Then
                txtape.Text = cliente._activo
            End If
            'Grabo en bitacora
            objbitacora._desc = "Baja Cliente"
            objbitacora._fecha = Now
            objbitacora._dvh = 5
            objbitacora._usu_id._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
            objbitacora._crit_id._id = BLL.Criticidad.GetInstance.RecuperarId(New BE.Criticidad("Alto"))
            objbitacora._usu_log = frmlogin.TextBox1.Text
            objbitacora._dvh = BLL.Seguridad.GetInstance.CalcularDVHBitacora(objbitacora)
            BLL.Bitacora.GetInstance.RegistrarBitacora(objbitacora)
            BLL.Seguridad.GetInstance.ReCalcularDVV("BITACORA")
        Catch ex As Exception
            MsgBox("Error en Borrado", MsgBoxStyle.Information, "Clientes")
        End Try
        MsgBox("Borrado Exitoso", MsgBoxStyle.Information, "Clientes")
    End Sub
#End Region

#Region "Validar Campos"

    Private Sub txtnom_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtnom.KeyPress
        If Char.IsLetter(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsControl(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsSeparator(e.KeyChar) Then
            e.Handled = False
        Else
            e.Handled = True
            MsgBox("El caracter ingresado no es valido", MsgBoxStyle.Critical, "Clientes")
        End If

        Me.txtnom.Text = Trim(Replace(Me.txtnom.Text, " ", ""))
        txtnom.Select(txtnom.Text.Length, 0)
    End Sub

    Private Sub txtape_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtape.KeyPress
        If Char.IsLetter(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsControl(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsSeparator(e.KeyChar) Then
            e.Handled = False
        Else
            e.Handled = True
            MsgBox("El caracter ingresado no es valido", MsgBoxStyle.Critical, "Clientes")
        End If

        Me.txtape.Text = Trim(Replace(Me.txtape.Text, " ", ""))
        txtape.Select(txtape.Text.Length, 0)
    End Sub

    Private Sub txtdni_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtdni.KeyPress
        If Char.IsNumber(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsControl(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsSeparator(e.KeyChar) Then
            e.Handled = False
        Else
            e.Handled = True
            MsgBox("El caracter ingresado no es valido", MsgBoxStyle.Critical, "Clientes")
        End If

        Me.txtdni.Text = Trim(Replace(Me.txtdni.Text, " ", ""))
        txtdni.Select(txtdni.Text.Length, 0)
    End Sub

    Private Sub txttel_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txttel.KeyPress
        If Char.IsNumber(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsControl(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsSeparator(e.KeyChar) Then
            e.Handled = False
        Else
            e.Handled = True
            MsgBox("El caracter ingresado no es valido", MsgBoxStyle.Critical, "Clientes")
        End If

        Me.txttel.Text = Trim(Replace(Me.txttel.Text, " ", ""))
        txttel.Select(txttel.Text.Length, 0)
    End Sub

    Private Sub txtdir_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtdir.KeyPress
        If Char.IsNumber(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsNumber(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsControl(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsSeparator(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsWhiteSpace(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsLetter(e.KeyChar) Then
            e.Handled = False
        Else
            e.Handled = True
            MsgBox("El caracter ingresado no es valido", MsgBoxStyle.Critical, "Clientes")
        End If

        Me.txtdir.Text = Trim(Replace(Me.txtdir.Text, " ", " "))
        txtdir.Select(txtdir.Text.Length, 0)
    End Sub

    'Private Sub cmblib_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs)
    '    If Char.IsNumber(e.KeyChar) Then
    '        e.Handled = False
    '    ElseIf Char.IsControl(e.KeyChar) Then
    '        e.Handled = False
    '    ElseIf Char.IsSeparator(e.KeyChar) Then
    '        e.Handled = False
    '    Else
    '        e.Handled = True
    '        MsgBox("El caracter ingresado no es valido", MsgBoxStyle.Critical, "Clientes")
    '    End If

    '    Me.txtdni.Text = Trim(Replace(Me.CMBLib.Text, " ", ""))
    '    CMBLib.Select(CMBLib.Text.Length, 0)
    'End Sub

    'Private Sub txtsaldo_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs)
    '    If Char.IsNumber(e.KeyChar) Then
    '        e.Handled = False
    '    ElseIf Char.IsControl(e.KeyChar) Then
    '        e.Handled = False
    '    ElseIf Char.IsSeparator(e.KeyChar) Then
    '        e.Handled = False
    '    Else
    '        e.Handled = True
    '        MsgBox("El caracter ingresado no es valido", MsgBoxStyle.Critical, "Clientes")
    '    End If

    '    Me.txtsaldo.Text = Trim(Replace(Me.txtsaldo.Text, " ", ""))
    '    txtsaldo.Select(txtsaldo.Text.Length, 0)
    'End Sub

    Private Sub txtemail_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtemail.KeyPress
        If Char.IsNumber(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsNumber(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsControl(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsSeparator(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsWhiteSpace(e.KeyChar) Then
            e.Handled = False
        ElseIf Char.IsLetter(e.KeyChar) Then
            e.Handled = False
        ElseIf e.KeyChar = "@" Or e.KeyChar = "." Then
            e.Handled = False
        Else
            e.Handled = True
            MsgBox("El caracter ingresado no es valido", MsgBoxStyle.Critical, "Clientes")
        End If

        Me.txtemail.Text = Trim(Replace(Me.txtemail.Text, " ", ""))
        txtemail.Select(txtemail.Text.Length, 0)
    End Sub

#End Region

#Region "Load"

    Private Sub frmCliente_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Tooltip Modulo Clientes
        Dim toolTip1 As New ToolTip()
        toolTip1.ShowAlways = True
        'traduccion formulario
        If frmlogin.RadioButton1.Checked = False Then
            '*************************************Botones**************************************************************************
            toolTip1.SetToolTip(btnClieAlta, "Presionar para Agregar un cliente")
            toolTip1.SetToolTip(btnCliebaja, "Presionar para Eliminar un cliente")
            toolTip1.SetToolTip(btnClieList, "Presionar para Listar clientes")
            toolTip1.SetToolTip(btnClieMod, "Presionar para Modificar un cliente")
            '*************************************Textbox**************************************************************************
            toolTip1.SetToolTip(txtape, "Ingrese Apellido del Cliente")
            toolTip1.SetToolTip(txtnom, "Ingrese Nombre del Cliente")
            toolTip1.SetToolTip(txtdni, "Ingrese DNI del Cliente")
            toolTip1.SetToolTip(txtemail, "Ingrese Email del Cliente")
            'toolTip1.SetToolTip(txtsaldo, "Ingrese Saldo del Cliente")
            toolTip1.SetToolTip(txttel, "Ingrese Telefono del Cliente")
            'toolTip1.SetToolTip(CMBLib, "Seleccione Libro")
            toolTip1.SetToolTip(dtp, "Seleccione Fecha")
            toolTip1.SetToolTip(txtdir, "Ingrese Direccion del Cliente")
            '**********************************************************************************************************************
        ElseIf frmlogin.RadioButton1.Checked = True Then
            '*************************************Botones**************************************************************************
            toolTip1.SetToolTip(btnClieAlta, "Press to Add Client")
            toolTip1.SetToolTip(btnCliebaja, "Press to Delete Client")
            toolTip1.SetToolTip(btnClieList, "Press to List Client")
            toolTip1.SetToolTip(btnClieMod, "Press to Modify Client")
            '*************************************Textbox**************************************************************************
            toolTip1.SetToolTip(txtape, "Enter LastName of Client")
            toolTip1.SetToolTip(txtnom, "Enter FirstName of Client")
            toolTip1.SetToolTip(txtdni, "Enter DNI of Client")
            toolTip1.SetToolTip(txtemail, "Enter Email of Client")
            'toolTip1.SetToolTip(txtsaldo, "Enter Balance of Client")
            toolTip1.SetToolTip(txttel, "Enter Phone Number of Client")
            toolTip1.SetToolTip(txtdir, "Enter Address of Cliente")
            'toolTip1.SetToolTip(CMBLib, "Select Book")
            toolTip1.SetToolTip(dtp, "Select Date")
            '**********************************************************************************************************************

        End If

        '-- Idioma

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
        ''PATENTES
        ''Verifico permisos para habilitar o deshabilitar controles.
        Dim objPat As New BE.Patente
        Dim usu As New BE.Usuario


        objPat._id = 1
        usu._id = BLL.Usuario.GetInstance.RecuperarID(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
        objPat._desc = "Alta Cliente"
        If BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = True Then
            If BLL.Seguridad.GetInstance.VerificarPermisosNegUsuPat(objPat, usu) = False Then
                btnClieAlta.Enabled = False
            Else
                btnClieAlta.Enabled = True
            End If
        ElseIf BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = False Then
            If BLL.Seguridad.GetInstance.VerificarPermisosUsuPat(objPat, usu) = True Then
                btnClieAlta.Enabled = True
            Else
                btnClieAlta.Enabled = False
            End If
        End If

        objPat._id = 2
        objPat._desc = "Baja Cliente"
        If BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = True Then
            If BLL.Seguridad.GetInstance.VerificarPermisosNegUsuPat(objPat, usu) = False Then
                btnCliebaja.Enabled = False
            Else
                btnCliebaja.Enabled = True
            End If
        ElseIf BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = False Then
            If BLL.Seguridad.GetInstance.VerificarPermisosUsuPat(objPat, usu) = True Then
                btnCliebaja.Enabled = True
            Else
                btnCliebaja.Enabled = False
            End If
        End If

        objPat._id = 3
        objPat._desc = "Modificar Clie"
        If BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = True Then
            If BLL.Seguridad.GetInstance.VerificarPermisosNegUsuPat(objPat, usu) = False Then
                btnClieMod.Enabled = False
            Else
                btnClieMod.Enabled = True
            End If
        ElseIf BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = False Then
            If BLL.Seguridad.GetInstance.VerificarPermisosUsuPat(objPat, usu) = True Then
                btnClieMod.Enabled = True
            Else
                btnClieMod.Enabled = False
            End If
        End If

    End Sub
    'Ayuda
    Private Sub frmCliente_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        If e.KeyCode = 112 Then
            Help.ShowHelp(Me, BLL.Seguridad.ConsultarHelp().HelpFile, HelpNavigator.TopicId, "1")
        End If
    End Sub

    Private Function Right(ByVal p1 As String, ByVal p2 As Integer) As String
        Throw New NotImplementedException
    End Function

#End Region

End Class