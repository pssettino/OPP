<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmClientes
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
        Me.components = New System.ComponentModel.Container()
        Me.GroupBox = New System.Windows.Forms.GroupBox()
        Me.btnCancelar = New System.Windows.Forms.Button()
        Me.lblApellidoNombre = New System.Windows.Forms.Label()
        Me.lbldni = New System.Windows.Forms.Label()
        Me.txtBuscarApeNom = New System.Windows.Forms.TextBox()
        Me.txtBuscarDni = New System.Windows.Forms.TextBox()
        Me.btnRegistrar = New System.Windows.Forms.Button()
        Me.dgClientes = New System.Windows.Forms.DataGridView()
        Me.Id = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DNI = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Apellido_Nombre = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Telefono = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.dgModificar = New System.Windows.Forms.DataGridViewButtonColumn()
        Me.dgEliminar = New System.Windows.Forms.DataGridViewButtonColumn()
        Me.eliminado = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.epError = New System.Windows.Forms.ErrorProvider(Me.components)
        Me.epOK = New System.Windows.Forms.ErrorProvider(Me.components)
        Me.GroupBox.SuspendLayout()
        CType(Me.dgClientes, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.epError, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.epOK, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'GroupBox
        '
        Me.GroupBox.Controls.Add(Me.btnCancelar)
        Me.GroupBox.Controls.Add(Me.lblApellidoNombre)
        Me.GroupBox.Controls.Add(Me.lbldni)
        Me.GroupBox.Controls.Add(Me.txtBuscarApeNom)
        Me.GroupBox.Controls.Add(Me.txtBuscarDni)
        Me.GroupBox.Controls.Add(Me.btnRegistrar)
        Me.GroupBox.Controls.Add(Me.dgClientes)
        Me.GroupBox.Location = New System.Drawing.Point(12, 12)
        Me.GroupBox.Name = "GroupBox"
        Me.GroupBox.Size = New System.Drawing.Size(767, 400)
        Me.GroupBox.TabIndex = 10
        Me.GroupBox.TabStop = False
        '
        'btnCancelar
        '
        Me.btnCancelar.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.btnCancelar.Location = New System.Drawing.Point(614, 360)
        Me.btnCancelar.Name = "btnCancelar"
        Me.btnCancelar.Size = New System.Drawing.Size(127, 27)
        Me.btnCancelar.TabIndex = 5
        Me.btnCancelar.Text = "&Cancelar"
        '
        'lblApellidoNombre
        '
        Me.lblApellidoNombre.AutoSize = True
        Me.lblApellidoNombre.Location = New System.Drawing.Point(182, 32)
        Me.lblApellidoNombre.Name = "lblApellidoNombre"
        Me.lblApellidoNombre.Size = New System.Drawing.Size(92, 13)
        Me.lblApellidoNombre.TabIndex = 96
        Me.lblApellidoNombre.Text = "Apellido y Nombre"
        Me.lblApellidoNombre.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lbldni
        '
        Me.lbldni.AutoSize = True
        Me.lbldni.Location = New System.Drawing.Point(18, 32)
        Me.lbldni.Name = "lbldni"
        Me.lbldni.Size = New System.Drawing.Size(26, 13)
        Me.lbldni.TabIndex = 96
        Me.lbldni.Text = "DNI"
        Me.lbldni.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'txtBuscarApeNom
        '
        Me.txtBuscarApeNom.Location = New System.Drawing.Point(296, 29)
        Me.txtBuscarApeNom.MaxLength = 8
        Me.txtBuscarApeNom.Name = "txtBuscarApeNom"
        Me.txtBuscarApeNom.Size = New System.Drawing.Size(445, 20)
        Me.txtBuscarApeNom.TabIndex = 1
        '
        'txtBuscarDni
        '
        Me.txtBuscarDni.Location = New System.Drawing.Point(53, 29)
        Me.txtBuscarDni.MaxLength = 8
        Me.txtBuscarDni.Name = "txtBuscarDni"
        Me.txtBuscarDni.Size = New System.Drawing.Size(112, 20)
        Me.txtBuscarDni.TabIndex = 0
        '
        'btnRegistrar
        '
        Me.btnRegistrar.Location = New System.Drawing.Point(481, 360)
        Me.btnRegistrar.Name = "btnRegistrar"
        Me.btnRegistrar.Size = New System.Drawing.Size(127, 27)
        Me.btnRegistrar.TabIndex = 2
        Me.btnRegistrar.Text = "&Registrar"
        Me.btnRegistrar.UseVisualStyleBackColor = True
        '
        'dgClientes
        '
        Me.dgClientes.AllowUserToAddRows = False
        Me.dgClientes.AllowUserToDeleteRows = False
        Me.dgClientes.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill
        Me.dgClientes.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgClientes.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.Id, Me.DNI, Me.Apellido_Nombre, Me.Telefono, Me.dgModificar, Me.dgEliminar, Me.eliminado})
        Me.dgClientes.Location = New System.Drawing.Point(14, 63)
        Me.dgClientes.Name = "dgClientes"
        Me.dgClientes.ReadOnly = True
        Me.dgClientes.RowHeadersVisible = False
        Me.dgClientes.Size = New System.Drawing.Size(727, 280)
        Me.dgClientes.TabIndex = 0
        '
        'Id
        '
        Me.Id.FillWeight = 40.0!
        Me.Id.HeaderText = "Id"
        Me.Id.Name = "Id"
        Me.Id.ReadOnly = True
        '
        'DNI
        '
        Me.DNI.HeaderText = "DNI"
        Me.DNI.Name = "DNI"
        Me.DNI.ReadOnly = True
        '
        'Apellido_Nombre
        '
        Me.Apellido_Nombre.HeaderText = "Apellido y Nombre"
        Me.Apellido_Nombre.Name = "Apellido_Nombre"
        Me.Apellido_Nombre.ReadOnly = True
        '
        'Telefono
        '
        Me.Telefono.HeaderText = "Telefono"
        Me.Telefono.Name = "Telefono"
        Me.Telefono.ReadOnly = True
        '
        'dgModificar
        '
        Me.dgModificar.HeaderText = ""
        Me.dgModificar.Name = "dgModificar"
        Me.dgModificar.ReadOnly = True
        '
        'dgEliminar
        '
        Me.dgEliminar.HeaderText = ""
        Me.dgEliminar.Name = "dgEliminar"
        Me.dgEliminar.ReadOnly = True
        '
        'eliminado
        '
        Me.eliminado.HeaderText = ""
        Me.eliminado.Name = "eliminado"
        Me.eliminado.ReadOnly = True
        Me.eliminado.Visible = False
        '
        'epError
        '
        Me.epError.ContainerControl = Me
        '
        'epOK
        '
        Me.epOK.ContainerControl = Me
        '
        'frmClientes
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(794, 420)
        Me.ControlBox = False
        Me.Controls.Add(Me.GroupBox)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "frmClientes"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Clientes"
        Me.GroupBox.ResumeLayout(False)
        Me.GroupBox.PerformLayout()
        CType(Me.dgClientes, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.epError, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.epOK, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents GroupBox As System.Windows.Forms.GroupBox
    Friend WithEvents dgClientes As System.Windows.Forms.DataGridView
    Friend WithEvents btnRegistrar As System.Windows.Forms.Button
    Friend WithEvents lbldni As System.Windows.Forms.Label
    Friend WithEvents txtBuscarDni As System.Windows.Forms.TextBox
    Friend WithEvents btnCancelar As System.Windows.Forms.Button
    Friend WithEvents lblApellidoNombre As System.Windows.Forms.Label
    Friend WithEvents txtBuscarApeNom As System.Windows.Forms.TextBox
    Friend WithEvents epError As System.Windows.Forms.ErrorProvider
    Friend WithEvents epOK As System.Windows.Forms.ErrorProvider
    Friend WithEvents Id As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents DNI As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Apellido_Nombre As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Telefono As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents dgModificar As System.Windows.Forms.DataGridViewButtonColumn
    Friend WithEvents dgEliminar As System.Windows.Forms.DataGridViewButtonColumn
    Friend WithEvents eliminado As System.Windows.Forms.DataGridViewTextBoxColumn
End Class
