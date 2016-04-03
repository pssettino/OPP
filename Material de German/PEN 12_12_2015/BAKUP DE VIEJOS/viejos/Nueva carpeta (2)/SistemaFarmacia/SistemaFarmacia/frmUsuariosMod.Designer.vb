<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmUsuariosMod
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmUsuariosMod))
        Me.GroupBox_frmUsu = New System.Windows.Forms.GroupBox()
        Me.dgPatentes = New System.Windows.Forms.DataGridView()
        Me.Nombre = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.dgAsignarPatente = New System.Windows.Forms.DataGridViewCheckBoxColumn()
        Me.dgPatenteNegada = New System.Windows.Forms.DataGridViewCheckBoxColumn()
        Me.patente_id = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.lblcontraseña = New System.Windows.Forms.Label()
        Me.dgFamilias = New System.Windows.Forms.DataGridView()
        Me.Nombre_Familia = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.familia_id = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.dgAsignarFamilia = New System.Windows.Forms.DataGridViewCheckBoxColumn()
        Me.btnCancelar = New System.Windows.Forms.Button()
        Me.btnAceptar = New System.Windows.Forms.Button()
        Me.btnRestablecer = New System.Windows.Forms.Button()
        Me.lbldniError = New System.Windows.Forms.Label()
        Me.lblEmailError = New System.Windows.Forms.Label()
        Me.lblnombreusuario = New System.Windows.Forms.Label()
        Me.lblApellidoError = New System.Windows.Forms.Label()
        Me.lblNombreError = New System.Windows.Forms.Label()
        Me.lblusuario = New System.Windows.Forms.Label()
        Me.txtnombre = New System.Windows.Forms.TextBox()
        Me.txtapellido = New System.Windows.Forms.TextBox()
        Me.txtdni = New System.Windows.Forms.TextBox()
        Me.txtmail = New System.Windows.Forms.TextBox()
        Me.lblPatentes = New System.Windows.Forms.Label()
        Me.lblFamilias = New System.Windows.Forms.Label()
        Me.lblNombre = New System.Windows.Forms.Label()
        Me.lblApellido = New System.Windows.Forms.Label()
        Me.lblDni = New System.Windows.Forms.Label()
        Me.Label12 = New System.Windows.Forms.Label()
        Me.txtuser = New System.Windows.Forms.TextBox()
        Me.HelpProvider1 = New System.Windows.Forms.HelpProvider()
        Me.GroupBox_frmUsu.SuspendLayout()
        CType(Me.dgPatentes, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.dgFamilias, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'GroupBox_frmUsu
        '
        Me.GroupBox_frmUsu.Controls.Add(Me.dgPatentes)
        Me.GroupBox_frmUsu.Controls.Add(Me.lblcontraseña)
        Me.GroupBox_frmUsu.Controls.Add(Me.dgFamilias)
        Me.GroupBox_frmUsu.Controls.Add(Me.btnCancelar)
        Me.GroupBox_frmUsu.Controls.Add(Me.btnAceptar)
        Me.GroupBox_frmUsu.Controls.Add(Me.btnRestablecer)
        Me.GroupBox_frmUsu.Controls.Add(Me.lbldniError)
        Me.GroupBox_frmUsu.Controls.Add(Me.lblEmailError)
        Me.GroupBox_frmUsu.Controls.Add(Me.lblnombreusuario)
        Me.GroupBox_frmUsu.Controls.Add(Me.lblApellidoError)
        Me.GroupBox_frmUsu.Controls.Add(Me.lblNombreError)
        Me.GroupBox_frmUsu.Controls.Add(Me.lblusuario)
        Me.GroupBox_frmUsu.Controls.Add(Me.txtnombre)
        Me.GroupBox_frmUsu.Controls.Add(Me.txtapellido)
        Me.GroupBox_frmUsu.Controls.Add(Me.txtdni)
        Me.GroupBox_frmUsu.Controls.Add(Me.txtmail)
        Me.GroupBox_frmUsu.Controls.Add(Me.lblPatentes)
        Me.GroupBox_frmUsu.Controls.Add(Me.lblFamilias)
        Me.GroupBox_frmUsu.Controls.Add(Me.lblNombre)
        Me.GroupBox_frmUsu.Controls.Add(Me.lblApellido)
        Me.GroupBox_frmUsu.Controls.Add(Me.lblDni)
        Me.GroupBox_frmUsu.Controls.Add(Me.Label12)
        Me.GroupBox_frmUsu.Controls.Add(Me.txtuser)
        Me.GroupBox_frmUsu.Location = New System.Drawing.Point(6, -1)
        Me.GroupBox_frmUsu.Name = "GroupBox_frmUsu"
        Me.GroupBox_frmUsu.Size = New System.Drawing.Size(539, 568)
        Me.GroupBox_frmUsu.TabIndex = 91
        Me.GroupBox_frmUsu.TabStop = False
        '
        'dgPatentes
        '
        Me.dgPatentes.AllowUserToAddRows = False
        Me.dgPatentes.AllowUserToDeleteRows = False
        Me.dgPatentes.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill
        Me.dgPatentes.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgPatentes.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.Nombre, Me.dgAsignarPatente, Me.dgPatenteNegada, Me.patente_id})
        Me.dgPatentes.Location = New System.Drawing.Point(60, 292)
        Me.dgPatentes.Margin = New System.Windows.Forms.Padding(2)
        Me.dgPatentes.Name = "dgPatentes"
        Me.dgPatentes.RowHeadersVisible = False
        Me.dgPatentes.RowTemplate.Height = 24
        Me.dgPatentes.Size = New System.Drawing.Size(464, 219)
        Me.dgPatentes.TabIndex = 96
        '
        'Nombre
        '
        Me.Nombre.FillWeight = 140.0!
        Me.Nombre.HeaderText = "Nombre"
        Me.Nombre.Name = "Nombre"
        Me.Nombre.ReadOnly = True
        '
        'dgAsignarPatente
        '
        Me.dgAsignarPatente.FillWeight = 70.0!
        Me.dgAsignarPatente.HeaderText = "Asignada"
        Me.dgAsignarPatente.Name = "dgAsignarPatente"
        '
        'dgPatenteNegada
        '
        Me.dgPatenteNegada.FillWeight = 70.0!
        Me.dgPatenteNegada.HeaderText = "Negada"
        Me.dgPatenteNegada.Name = "dgPatenteNegada"
        '
        'patente_id
        '
        Me.patente_id.HeaderText = ""
        Me.patente_id.Name = "patente_id"
        Me.patente_id.Visible = False
        '
        'lblcontraseña
        '
        Me.lblcontraseña.AutoSize = True
        Me.lblcontraseña.Location = New System.Drawing.Point(323, 53)
        Me.lblcontraseña.Name = "lblcontraseña"
        Me.lblcontraseña.Size = New System.Drawing.Size(70, 13)
        Me.lblcontraseña.TabIndex = 102
        Me.lblcontraseña.Text = "lblcontraseña"
        Me.lblcontraseña.Visible = False
        '
        'dgFamilias
        '
        Me.dgFamilias.AllowUserToAddRows = False
        Me.dgFamilias.AllowUserToDeleteRows = False
        Me.dgFamilias.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill
        Me.dgFamilias.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgFamilias.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.Nombre_Familia, Me.familia_id, Me.dgAsignarFamilia})
        Me.dgFamilias.Location = New System.Drawing.Point(60, 146)
        Me.dgFamilias.Margin = New System.Windows.Forms.Padding(2)
        Me.dgFamilias.Name = "dgFamilias"
        Me.dgFamilias.RowHeadersVisible = False
        Me.dgFamilias.RowTemplate.Height = 24
        Me.dgFamilias.Size = New System.Drawing.Size(464, 122)
        Me.dgFamilias.TabIndex = 97
        '
        'Nombre_Familia
        '
        Me.Nombre_Familia.FillWeight = 140.0!
        Me.Nombre_Familia.HeaderText = "Nombre"
        Me.Nombre_Familia.Name = "Nombre_Familia"
        Me.Nombre_Familia.ReadOnly = True
        '
        'familia_id
        '
        Me.familia_id.HeaderText = ""
        Me.familia_id.Name = "familia_id"
        Me.familia_id.Visible = False
        '
        'dgAsignarFamilia
        '
        Me.dgAsignarFamilia.FillWeight = 140.0!
        Me.dgAsignarFamilia.HeaderText = "Asignada"
        Me.dgAsignarFamilia.Name = "dgAsignarFamilia"
        '
        'btnCancelar
        '
        Me.btnCancelar.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.btnCancelar.Location = New System.Drawing.Point(397, 528)
        Me.btnCancelar.Name = "btnCancelar"
        Me.btnCancelar.Size = New System.Drawing.Size(127, 27)
        Me.btnCancelar.TabIndex = 99
        Me.btnCancelar.Text = "&Cancelar"
        '
        'btnAceptar
        '
        Me.btnAceptar.Location = New System.Drawing.Point(264, 528)
        Me.btnAceptar.Name = "btnAceptar"
        Me.btnAceptar.Size = New System.Drawing.Size(127, 27)
        Me.btnAceptar.TabIndex = 98
        Me.btnAceptar.Text = "&Aceptar"
        '
        'btnRestablecer
        '
        Me.btnRestablecer.Location = New System.Drawing.Point(323, 23)
        Me.btnRestablecer.Name = "btnRestablecer"
        Me.btnRestablecer.Size = New System.Drawing.Size(201, 27)
        Me.btnRestablecer.TabIndex = 93
        Me.btnRestablecer.Text = "&Restablecer Contraseña"
        '
        'lbldniError
        '
        Me.lbldniError.AutoSize = True
        Me.lbldniError.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lbldniError.ForeColor = System.Drawing.Color.Red
        Me.lbldniError.Location = New System.Drawing.Point(324, 84)
        Me.lbldniError.Name = "lbldniError"
        Me.lbldniError.Size = New System.Drawing.Size(24, 12)
        Me.lbldniError.TabIndex = 85
        Me.lbldniError.Text = "error"
        Me.lbldniError.Visible = False
        '
        'lblEmailError
        '
        Me.lblEmailError.AutoSize = True
        Me.lblEmailError.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblEmailError.ForeColor = System.Drawing.Color.Red
        Me.lblEmailError.Location = New System.Drawing.Point(323, 120)
        Me.lblEmailError.Name = "lblEmailError"
        Me.lblEmailError.Size = New System.Drawing.Size(24, 12)
        Me.lblEmailError.TabIndex = 84
        Me.lblEmailError.Text = "error"
        Me.lblEmailError.Visible = False
        '
        'lblnombreusuario
        '
        Me.lblnombreusuario.AutoSize = True
        Me.lblnombreusuario.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblnombreusuario.ForeColor = System.Drawing.Color.Red
        Me.lblnombreusuario.Location = New System.Drawing.Point(59, 47)
        Me.lblnombreusuario.Name = "lblnombreusuario"
        Me.lblnombreusuario.Size = New System.Drawing.Size(24, 12)
        Me.lblnombreusuario.TabIndex = 82
        Me.lblnombreusuario.Text = "error"
        Me.lblnombreusuario.Visible = False
        '
        'lblApellidoError
        '
        Me.lblApellidoError.AutoSize = True
        Me.lblApellidoError.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblApellidoError.ForeColor = System.Drawing.Color.Red
        Me.lblApellidoError.Location = New System.Drawing.Point(59, 85)
        Me.lblApellidoError.Name = "lblApellidoError"
        Me.lblApellidoError.Size = New System.Drawing.Size(24, 12)
        Me.lblApellidoError.TabIndex = 82
        Me.lblApellidoError.Text = "error"
        Me.lblApellidoError.Visible = False
        '
        'lblNombreError
        '
        Me.lblNombreError.AutoSize = True
        Me.lblNombreError.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblNombreError.ForeColor = System.Drawing.Color.Red
        Me.lblNombreError.Location = New System.Drawing.Point(59, 123)
        Me.lblNombreError.Name = "lblNombreError"
        Me.lblNombreError.Size = New System.Drawing.Size(24, 12)
        Me.lblNombreError.TabIndex = 81
        Me.lblNombreError.Text = "error"
        Me.lblNombreError.Visible = False
        '
        'lblusuario
        '
        Me.lblusuario.AutoSize = True
        Me.lblusuario.Location = New System.Drawing.Point(10, 30)
        Me.lblusuario.Name = "lblusuario"
        Me.lblusuario.Size = New System.Drawing.Size(43, 13)
        Me.lblusuario.TabIndex = 69
        Me.lblusuario.Text = "Usuario"
        Me.lblusuario.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'txtnombre
        '
        Me.txtnombre.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtnombre.Location = New System.Drawing.Point(60, 100)
        Me.txtnombre.Name = "txtnombre"
        Me.txtnombre.Size = New System.Drawing.Size(206, 20)
        Me.txtnombre.TabIndex = 2
        '
        'txtapellido
        '
        Me.txtapellido.Location = New System.Drawing.Point(60, 64)
        Me.txtapellido.Name = "txtapellido"
        Me.txtapellido.Size = New System.Drawing.Size(206, 20)
        Me.txtapellido.TabIndex = 1
        '
        'txtdni
        '
        Me.txtdni.Location = New System.Drawing.Point(323, 64)
        Me.txtdni.MaxLength = 8
        Me.txtdni.Name = "txtdni"
        Me.txtdni.Size = New System.Drawing.Size(201, 20)
        Me.txtdni.TabIndex = 3
        '
        'txtmail
        '
        Me.txtmail.Location = New System.Drawing.Point(323, 100)
        Me.txtmail.Name = "txtmail"
        Me.txtmail.Size = New System.Drawing.Size(201, 20)
        Me.txtmail.TabIndex = 4
        '
        'lblPatentes
        '
        Me.lblPatentes.AutoSize = True
        Me.lblPatentes.Location = New System.Drawing.Point(9, 292)
        Me.lblPatentes.Name = "lblPatentes"
        Me.lblPatentes.Size = New System.Drawing.Size(49, 13)
        Me.lblPatentes.TabIndex = 66
        Me.lblPatentes.Text = "Patentes"
        '
        'lblFamilias
        '
        Me.lblFamilias.AutoSize = True
        Me.lblFamilias.Location = New System.Drawing.Point(9, 146)
        Me.lblFamilias.Name = "lblFamilias"
        Me.lblFamilias.Size = New System.Drawing.Size(44, 13)
        Me.lblFamilias.TabIndex = 66
        Me.lblFamilias.Text = "Familias"
        '
        'lblNombre
        '
        Me.lblNombre.AutoSize = True
        Me.lblNombre.Location = New System.Drawing.Point(10, 103)
        Me.lblNombre.Name = "lblNombre"
        Me.lblNombre.Size = New System.Drawing.Size(44, 13)
        Me.lblNombre.TabIndex = 66
        Me.lblNombre.Text = "Nombre"
        Me.lblNombre.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'lblApellido
        '
        Me.lblApellido.AutoSize = True
        Me.lblApellido.Location = New System.Drawing.Point(10, 67)
        Me.lblApellido.Name = "lblApellido"
        Me.lblApellido.Size = New System.Drawing.Size(44, 13)
        Me.lblApellido.TabIndex = 67
        Me.lblApellido.Text = "Apellido"
        Me.lblApellido.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'lblDni
        '
        Me.lblDni.AutoSize = True
        Me.lblDni.Location = New System.Drawing.Point(291, 67)
        Me.lblDni.Name = "lblDni"
        Me.lblDni.Size = New System.Drawing.Size(26, 13)
        Me.lblDni.TabIndex = 68
        Me.lblDni.Text = "DNI"
        Me.lblDni.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'Label12
        '
        Me.Label12.AutoSize = True
        Me.Label12.Location = New System.Drawing.Point(281, 103)
        Me.Label12.Name = "Label12"
        Me.Label12.Size = New System.Drawing.Size(36, 13)
        Me.Label12.TabIndex = 80
        Me.Label12.Text = "E-Mail"
        Me.Label12.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'txtuser
        '
        Me.txtuser.Location = New System.Drawing.Point(60, 27)
        Me.txtuser.Name = "txtuser"
        Me.txtuser.Size = New System.Drawing.Size(206, 20)
        Me.txtuser.TabIndex = 0
        '
        'HelpProvider1
        '
        Me.HelpProvider1.HelpNamespace = "C:\Users\German\Desktop\SistemaFarmacia\SistemaFarmacia\farmacia.chm"
        '
        'frmUsuariosMod
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(550, 573)
        Me.ControlBox = False
        Me.Controls.Add(Me.GroupBox_frmUsu)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "frmUsuariosMod"
        Me.HelpProvider1.SetShowHelp(Me, True)
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Usuarios"
        Me.GroupBox_frmUsu.ResumeLayout(False)
        Me.GroupBox_frmUsu.PerformLayout()
        CType(Me.dgPatentes, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.dgFamilias, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents GroupBox_frmUsu As System.Windows.Forms.GroupBox
    Friend WithEvents lblusuario As System.Windows.Forms.Label
    Friend WithEvents txtnombre As System.Windows.Forms.TextBox
    Friend WithEvents txtapellido As System.Windows.Forms.TextBox
    Friend WithEvents txtdni As System.Windows.Forms.TextBox
    Friend WithEvents txtmail As System.Windows.Forms.TextBox
    Friend WithEvents lblNombre As System.Windows.Forms.Label
    Friend WithEvents lblApellido As System.Windows.Forms.Label
    Friend WithEvents lblDni As System.Windows.Forms.Label
    Friend WithEvents Label12 As System.Windows.Forms.Label
    Friend WithEvents txtuser As System.Windows.Forms.TextBox
    Friend WithEvents lbldniError As System.Windows.Forms.Label
    Friend WithEvents lblEmailError As System.Windows.Forms.Label
    Friend WithEvents lblApellidoError As System.Windows.Forms.Label
    Friend WithEvents lblNombreError As System.Windows.Forms.Label
    Friend WithEvents lblnombreusuario As System.Windows.Forms.Label
    Friend WithEvents btnCancelar As System.Windows.Forms.Button
    Friend WithEvents btnAceptar As System.Windows.Forms.Button
    Friend WithEvents dgPatentes As System.Windows.Forms.DataGridView
    Friend WithEvents dgFamilias As System.Windows.Forms.DataGridView
    Friend WithEvents btnRestablecer As System.Windows.Forms.Button
    Friend WithEvents lblcontraseña As System.Windows.Forms.Label
    Friend WithEvents Nombre As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents dgAsignarPatente As System.Windows.Forms.DataGridViewCheckBoxColumn
    Friend WithEvents dgPatenteNegada As System.Windows.Forms.DataGridViewCheckBoxColumn
    Friend WithEvents patente_id As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Nombre_Familia As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents familia_id As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents dgAsignarFamilia As System.Windows.Forms.DataGridViewCheckBoxColumn
    Friend WithEvents lblPatentes As System.Windows.Forms.Label
    Friend WithEvents lblFamilias As System.Windows.Forms.Label
    Friend WithEvents HelpProvider1 As System.Windows.Forms.HelpProvider
End Class
