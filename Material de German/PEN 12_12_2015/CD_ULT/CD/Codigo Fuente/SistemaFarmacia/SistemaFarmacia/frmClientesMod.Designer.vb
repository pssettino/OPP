<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmClientesMod
    Inherits System.Windows.Forms.Form

    'Form reemplaza a Dispose para limpiar la lista de componentes.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Requerido por el Diseñador de Windows Forms
    Private components As System.ComponentModel.IContainer

    'NOTA: el Diseñador de Windows Forms necesita el siguiente procedimiento
    'Se puede modificar usando el Diseñador de Windows Forms.  
    'No lo modifique con el editor de código.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmClientesMod))
        Me.GroupBox_FrmCli = New System.Windows.Forms.GroupBox()
        Me.lbldnierror = New System.Windows.Forms.Label()
        Me.Lblnombreerror = New System.Windows.Forms.Label()
        Me.lblmailError = New System.Windows.Forms.Label()
        Me.lblapellidoError = New System.Windows.Forms.Label()
        Me.lbllocalidaderror = New System.Windows.Forms.Label()
        Me.lblprovinciaerror = New System.Windows.Forms.Label()
        Me.lblcalleerror = New System.Windows.Forms.Label()
        Me.lbltelerror = New System.Windows.Forms.Label()
        Me.btnCancelar = New System.Windows.Forms.Button()
        Me.btnAceptar = New System.Windows.Forms.Button()
        Me.lblEmail = New System.Windows.Forms.Label()
        Me.lblNombre = New System.Windows.Forms.Label()
        Me.txtemail = New System.Windows.Forms.TextBox()
        Me.txtnombre = New System.Windows.Forms.TextBox()
        Me.txtapellido = New System.Windows.Forms.TextBox()
        Me.txttelefono = New System.Windows.Forms.TextBox()
        Me.txtdni = New System.Windows.Forms.TextBox()
        Me.txtdireccion = New System.Windows.Forms.TextBox()
        Me.lblProvincia = New System.Windows.Forms.Label()
        Me.cmbProvincia = New System.Windows.Forms.ComboBox()
        Me.lblApellido = New System.Windows.Forms.Label()
        Me.cmbLocalidad = New System.Windows.Forms.ComboBox()
        Me.lblTelefono = New System.Windows.Forms.Label()
        Me.lbldni = New System.Windows.Forms.Label()
        Me.lblLocalidad = New System.Windows.Forms.Label()
        Me.lblDireccion = New System.Windows.Forms.Label()
        Me.HelpProvider1 = New System.Windows.Forms.HelpProvider()
        Me.GroupBox_FrmCli.SuspendLayout()
        Me.SuspendLayout()
        '
        'GroupBox_FrmCli
        '
        Me.GroupBox_FrmCli.Controls.Add(Me.lbldnierror)
        Me.GroupBox_FrmCli.Controls.Add(Me.Lblnombreerror)
        Me.GroupBox_FrmCli.Controls.Add(Me.lblmailError)
        Me.GroupBox_FrmCli.Controls.Add(Me.lblapellidoError)
        Me.GroupBox_FrmCli.Controls.Add(Me.lbllocalidaderror)
        Me.GroupBox_FrmCli.Controls.Add(Me.lblprovinciaerror)
        Me.GroupBox_FrmCli.Controls.Add(Me.lblcalleerror)
        Me.GroupBox_FrmCli.Controls.Add(Me.lbltelerror)
        Me.GroupBox_FrmCli.Controls.Add(Me.btnCancelar)
        Me.GroupBox_FrmCli.Controls.Add(Me.btnAceptar)
        Me.GroupBox_FrmCli.Controls.Add(Me.lblEmail)
        Me.GroupBox_FrmCli.Controls.Add(Me.lblNombre)
        Me.GroupBox_FrmCli.Controls.Add(Me.txtemail)
        Me.GroupBox_FrmCli.Controls.Add(Me.txtnombre)
        Me.GroupBox_FrmCli.Controls.Add(Me.txtapellido)
        Me.GroupBox_FrmCli.Controls.Add(Me.txttelefono)
        Me.GroupBox_FrmCli.Controls.Add(Me.txtdni)
        Me.GroupBox_FrmCli.Controls.Add(Me.txtdireccion)
        Me.GroupBox_FrmCli.Controls.Add(Me.lblProvincia)
        Me.GroupBox_FrmCli.Controls.Add(Me.cmbProvincia)
        Me.GroupBox_FrmCli.Controls.Add(Me.lblApellido)
        Me.GroupBox_FrmCli.Controls.Add(Me.cmbLocalidad)
        Me.GroupBox_FrmCli.Controls.Add(Me.lblTelefono)
        Me.GroupBox_FrmCli.Controls.Add(Me.lbldni)
        Me.GroupBox_FrmCli.Controls.Add(Me.lblLocalidad)
        Me.GroupBox_FrmCli.Controls.Add(Me.lblDireccion)
        Me.GroupBox_FrmCli.Location = New System.Drawing.Point(12, 12)
        Me.GroupBox_FrmCli.Name = "GroupBox_FrmCli"
        Me.GroupBox_FrmCli.Size = New System.Drawing.Size(374, 345)
        Me.GroupBox_FrmCli.TabIndex = 12
        Me.GroupBox_FrmCli.TabStop = False
        '
        'lbldnierror
        '
        Me.lbldnierror.AutoSize = True
        Me.lbldnierror.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lbldnierror.ForeColor = System.Drawing.Color.Red
        Me.lbldnierror.Location = New System.Drawing.Point(77, 118)
        Me.lbldnierror.Name = "lbldnierror"
        Me.lbldnierror.Size = New System.Drawing.Size(24, 12)
        Me.lbldnierror.TabIndex = 119
        Me.lbldnierror.Text = "error"
        Me.lbldnierror.Visible = False
        '
        'Lblnombreerror
        '
        Me.Lblnombreerror.AutoSize = True
        Me.Lblnombreerror.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Lblnombreerror.ForeColor = System.Drawing.Color.Red
        Me.Lblnombreerror.Location = New System.Drawing.Point(77, 79)
        Me.Lblnombreerror.Name = "Lblnombreerror"
        Me.Lblnombreerror.Size = New System.Drawing.Size(24, 12)
        Me.Lblnombreerror.TabIndex = 116
        Me.Lblnombreerror.Text = "error"
        Me.Lblnombreerror.Visible = False
        '
        'lblmailError
        '
        Me.lblmailError.AutoSize = True
        Me.lblmailError.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblmailError.ForeColor = System.Drawing.Color.Red
        Me.lblmailError.Location = New System.Drawing.Point(75, 158)
        Me.lblmailError.Name = "lblmailError"
        Me.lblmailError.Size = New System.Drawing.Size(24, 12)
        Me.lblmailError.TabIndex = 115
        Me.lblmailError.Text = "error"
        Me.lblmailError.Visible = False
        '
        'lblapellidoError
        '
        Me.lblapellidoError.AutoSize = True
        Me.lblapellidoError.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblapellidoError.ForeColor = System.Drawing.Color.Red
        Me.lblapellidoError.Location = New System.Drawing.Point(77, 41)
        Me.lblapellidoError.Name = "lblapellidoError"
        Me.lblapellidoError.Size = New System.Drawing.Size(24, 12)
        Me.lblapellidoError.TabIndex = 114
        Me.lblapellidoError.Text = "error"
        Me.lblapellidoError.Visible = False
        '
        'lbllocalidaderror
        '
        Me.lbllocalidaderror.AutoSize = True
        Me.lbllocalidaderror.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lbllocalidaderror.ForeColor = System.Drawing.Color.Red
        Me.lbllocalidaderror.Location = New System.Drawing.Point(77, 239)
        Me.lbllocalidaderror.Name = "lbllocalidaderror"
        Me.lbllocalidaderror.Size = New System.Drawing.Size(24, 12)
        Me.lbllocalidaderror.TabIndex = 121
        Me.lbllocalidaderror.Text = "error"
        Me.lbllocalidaderror.Visible = False
        '
        'lblprovinciaerror
        '
        Me.lblprovinciaerror.AutoSize = True
        Me.lblprovinciaerror.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblprovinciaerror.ForeColor = System.Drawing.Color.Red
        Me.lblprovinciaerror.Location = New System.Drawing.Point(75, 197)
        Me.lblprovinciaerror.Name = "lblprovinciaerror"
        Me.lblprovinciaerror.Size = New System.Drawing.Size(24, 12)
        Me.lblprovinciaerror.TabIndex = 120
        Me.lblprovinciaerror.Text = "error"
        Me.lblprovinciaerror.Visible = False
        '
        'lblcalleerror
        '
        Me.lblcalleerror.AutoSize = True
        Me.lblcalleerror.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblcalleerror.ForeColor = System.Drawing.Color.Red
        Me.lblcalleerror.Location = New System.Drawing.Point(77, 277)
        Me.lblcalleerror.Name = "lblcalleerror"
        Me.lblcalleerror.Size = New System.Drawing.Size(24, 12)
        Me.lblcalleerror.TabIndex = 117
        Me.lblcalleerror.Text = "error"
        Me.lblcalleerror.Visible = False
        '
        'lbltelerror
        '
        Me.lbltelerror.AutoSize = True
        Me.lbltelerror.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lbltelerror.ForeColor = System.Drawing.Color.Red
        Me.lbltelerror.Location = New System.Drawing.Point(244, 117)
        Me.lbltelerror.Name = "lbltelerror"
        Me.lbltelerror.Size = New System.Drawing.Size(24, 12)
        Me.lbltelerror.TabIndex = 118
        Me.lbltelerror.Text = "error"
        Me.lbltelerror.Visible = False
        '
        'btnCancelar
        '
        Me.btnCancelar.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.btnCancelar.Location = New System.Drawing.Point(231, 303)
        Me.btnCancelar.Name = "btnCancelar"
        Me.btnCancelar.Size = New System.Drawing.Size(127, 27)
        Me.btnCancelar.TabIndex = 9
        Me.btnCancelar.Text = "&Cancelar"
        '
        'btnAceptar
        '
        Me.btnAceptar.Location = New System.Drawing.Point(98, 303)
        Me.btnAceptar.Name = "btnAceptar"
        Me.btnAceptar.Size = New System.Drawing.Size(127, 27)
        Me.btnAceptar.TabIndex = 8
        Me.btnAceptar.Text = "&Aceptar"
        '
        'lblEmail
        '
        Me.lblEmail.AutoSize = True
        Me.lblEmail.Location = New System.Drawing.Point(29, 138)
        Me.lblEmail.Name = "lblEmail"
        Me.lblEmail.Size = New System.Drawing.Size(35, 13)
        Me.lblEmail.TabIndex = 1
        Me.lblEmail.Text = "E-mail"
        Me.lblEmail.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lblNombre
        '
        Me.lblNombre.AutoSize = True
        Me.lblNombre.Location = New System.Drawing.Point(20, 59)
        Me.lblNombre.Name = "lblNombre"
        Me.lblNombre.Size = New System.Drawing.Size(44, 13)
        Me.lblNombre.TabIndex = 1
        Me.lblNombre.Text = "Nombre"
        Me.lblNombre.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'txtemail
        '
        Me.txtemail.Location = New System.Drawing.Point(73, 135)
        Me.txtemail.MaxLength = 100
        Me.txtemail.Name = "txtemail"
        Me.txtemail.Size = New System.Drawing.Size(285, 20)
        Me.txtemail.TabIndex = 4
        '
        'txtnombre
        '
        Me.txtnombre.Location = New System.Drawing.Point(73, 56)
        Me.txtnombre.MaxLength = 80
        Me.txtnombre.Name = "txtnombre"
        Me.txtnombre.Size = New System.Drawing.Size(285, 20)
        Me.txtnombre.TabIndex = 1
        '
        'txtapellido
        '
        Me.txtapellido.Location = New System.Drawing.Point(73, 19)
        Me.txtapellido.MaxLength = 80
        Me.txtapellido.Name = "txtapellido"
        Me.txtapellido.Size = New System.Drawing.Size(285, 20)
        Me.txtapellido.TabIndex = 0
        '
        'txttelefono
        '
        Me.txttelefono.Location = New System.Drawing.Point(242, 95)
        Me.txttelefono.MaxLength = 50
        Me.txttelefono.Name = "txttelefono"
        Me.txttelefono.Size = New System.Drawing.Size(116, 20)
        Me.txttelefono.TabIndex = 3
        '
        'txtdni
        '
        Me.txtdni.Location = New System.Drawing.Point(73, 95)
        Me.txtdni.MaxLength = 8
        Me.txtdni.Name = "txtdni"
        Me.txtdni.Size = New System.Drawing.Size(109, 20)
        Me.txtdni.TabIndex = 2
        '
        'txtdireccion
        '
        Me.txtdireccion.Location = New System.Drawing.Point(73, 254)
        Me.txtdireccion.MaxLength = 255
        Me.txtdireccion.Name = "txtdireccion"
        Me.txtdireccion.Size = New System.Drawing.Size(285, 20)
        Me.txtdireccion.TabIndex = 5
        '
        'lblProvincia
        '
        Me.lblProvincia.AutoSize = True
        Me.lblProvincia.Location = New System.Drawing.Point(13, 176)
        Me.lblProvincia.Name = "lblProvincia"
        Me.lblProvincia.Size = New System.Drawing.Size(51, 13)
        Me.lblProvincia.TabIndex = 1
        Me.lblProvincia.Text = "Provincia"
        Me.lblProvincia.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'cmbProvincia
        '
        Me.cmbProvincia.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbProvincia.FormattingEnabled = True
        Me.cmbProvincia.Location = New System.Drawing.Point(73, 173)
        Me.cmbProvincia.Name = "cmbProvincia"
        Me.cmbProvincia.Size = New System.Drawing.Size(285, 21)
        Me.cmbProvincia.TabIndex = 7
        '
        'lblApellido
        '
        Me.lblApellido.AutoSize = True
        Me.lblApellido.Location = New System.Drawing.Point(20, 22)
        Me.lblApellido.Name = "lblApellido"
        Me.lblApellido.Size = New System.Drawing.Size(44, 13)
        Me.lblApellido.TabIndex = 1
        Me.lblApellido.Text = "Apellido"
        Me.lblApellido.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'cmbLocalidad
        '
        Me.cmbLocalidad.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbLocalidad.FormattingEnabled = True
        Me.cmbLocalidad.Location = New System.Drawing.Point(73, 215)
        Me.cmbLocalidad.Name = "cmbLocalidad"
        Me.cmbLocalidad.Size = New System.Drawing.Size(285, 21)
        Me.cmbLocalidad.TabIndex = 6
        '
        'lblTelefono
        '
        Me.lblTelefono.AutoSize = True
        Me.lblTelefono.Location = New System.Drawing.Point(188, 98)
        Me.lblTelefono.Name = "lblTelefono"
        Me.lblTelefono.Size = New System.Drawing.Size(49, 13)
        Me.lblTelefono.TabIndex = 1
        Me.lblTelefono.Text = "Telefono"
        Me.lblTelefono.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lbldni
        '
        Me.lbldni.AutoSize = True
        Me.lbldni.Location = New System.Drawing.Point(38, 98)
        Me.lbldni.Name = "lbldni"
        Me.lbldni.Size = New System.Drawing.Size(26, 13)
        Me.lbldni.TabIndex = 1
        Me.lbldni.Text = "DNI"
        Me.lbldni.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lblLocalidad
        '
        Me.lblLocalidad.AutoSize = True
        Me.lblLocalidad.Location = New System.Drawing.Point(13, 218)
        Me.lblLocalidad.Name = "lblLocalidad"
        Me.lblLocalidad.Size = New System.Drawing.Size(53, 13)
        Me.lblLocalidad.TabIndex = 1
        Me.lblLocalidad.Text = "Localidad"
        Me.lblLocalidad.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lblDireccion
        '
        Me.lblDireccion.AutoSize = True
        Me.lblDireccion.Location = New System.Drawing.Point(13, 257)
        Me.lblDireccion.Name = "lblDireccion"
        Me.lblDireccion.Size = New System.Drawing.Size(52, 13)
        Me.lblDireccion.TabIndex = 1
        Me.lblDireccion.Text = "Direccion"
        Me.lblDireccion.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'HelpProvider1
        '
        Me.HelpProvider1.HelpNamespace = "farmacia_help.chm"
        '
        'frmClientesMod
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(398, 364)
        Me.ControlBox = False
        Me.Controls.Add(Me.GroupBox_FrmCli)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.HelpProvider1.SetHelpKeyword(Me, "16")
        Me.HelpProvider1.SetHelpNavigator(Me, System.Windows.Forms.HelpNavigator.TopicId)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "frmClientesMod"
        Me.HelpProvider1.SetShowHelp(Me, True)
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Clientes"
        Me.GroupBox_FrmCli.ResumeLayout(False)
        Me.GroupBox_FrmCli.PerformLayout()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents GroupBox_FrmCli As System.Windows.Forms.GroupBox
    Friend WithEvents lblEmail As System.Windows.Forms.Label
    Friend WithEvents lblNombre As System.Windows.Forms.Label
    Friend WithEvents txtemail As System.Windows.Forms.TextBox
    Friend WithEvents txtnombre As System.Windows.Forms.TextBox
    Friend WithEvents txtapellido As System.Windows.Forms.TextBox
    Friend WithEvents txttelefono As System.Windows.Forms.TextBox
    Friend WithEvents txtdni As System.Windows.Forms.TextBox
    Friend WithEvents txtdireccion As System.Windows.Forms.TextBox
    Friend WithEvents lblProvincia As System.Windows.Forms.Label
    Friend WithEvents cmbProvincia As System.Windows.Forms.ComboBox
    Friend WithEvents lblApellido As System.Windows.Forms.Label
    Friend WithEvents cmbLocalidad As System.Windows.Forms.ComboBox
    Friend WithEvents lblTelefono As System.Windows.Forms.Label
    Friend WithEvents lbldni As System.Windows.Forms.Label
    Friend WithEvents lblLocalidad As System.Windows.Forms.Label
    Friend WithEvents lblDireccion As System.Windows.Forms.Label
    Friend WithEvents btnCancelar As System.Windows.Forms.Button
    Friend WithEvents btnAceptar As System.Windows.Forms.Button
    Friend WithEvents lbldnierror As System.Windows.Forms.Label
    Friend WithEvents Lblnombreerror As System.Windows.Forms.Label
    Friend WithEvents lblmailError As System.Windows.Forms.Label
    Friend WithEvents lblapellidoError As System.Windows.Forms.Label
    Friend WithEvents lbllocalidaderror As System.Windows.Forms.Label
    Friend WithEvents lblprovinciaerror As System.Windows.Forms.Label
    Friend WithEvents lblcalleerror As System.Windows.Forms.Label
    Friend WithEvents lbltelerror As System.Windows.Forms.Label
    Friend WithEvents HelpProvider1 As System.Windows.Forms.HelpProvider
End Class
