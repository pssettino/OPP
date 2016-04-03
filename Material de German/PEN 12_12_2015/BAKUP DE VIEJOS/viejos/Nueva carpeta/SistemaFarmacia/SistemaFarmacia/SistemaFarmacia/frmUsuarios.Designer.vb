<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmUsuarios
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
        Me.GroupBox = New System.Windows.Forms.GroupBox()
        Me.btnCancelar = New System.Windows.Forms.Button()
        Me.dgUsuarios = New System.Windows.Forms.DataGridView()
        Me.id = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Nombre_Usuario = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Apellido_Nombre = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Email = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.dgUsuarioBtnModificar = New System.Windows.Forms.DataGridViewButtonColumn()
        Me.dgUsuarioBtnEliminado = New System.Windows.Forms.DataGridViewButtonColumn()
        Me.dgUsuarioBtnBloqueado = New System.Windows.Forms.DataGridViewButtonColumn()
        Me.bloqueado = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Eliminado = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.btnRegistrar = New System.Windows.Forms.Button()
        Me.HelpProvider1 = New System.Windows.Forms.HelpProvider()
        Me.GroupBox.SuspendLayout()
        CType(Me.dgUsuarios, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'GroupBox
        '
        Me.GroupBox.Controls.Add(Me.btnCancelar)
        Me.GroupBox.Controls.Add(Me.dgUsuarios)
        Me.GroupBox.Controls.Add(Me.btnRegistrar)
        Me.GroupBox.Location = New System.Drawing.Point(12, 4)
        Me.GroupBox.Name = "GroupBox"
        Me.GroupBox.Size = New System.Drawing.Size(773, 343)
        Me.GroupBox.TabIndex = 89
        Me.GroupBox.TabStop = False
        '
        'btnCancelar
        '
        Me.btnCancelar.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.btnCancelar.Location = New System.Drawing.Point(623, 296)
        Me.btnCancelar.Name = "btnCancelar"
        Me.btnCancelar.Size = New System.Drawing.Size(127, 27)
        Me.btnCancelar.TabIndex = 92
        Me.btnCancelar.Text = "&Cancelar"
        '
        'dgUsuarios
        '
        Me.dgUsuarios.AllowUserToAddRows = False
        Me.dgUsuarios.AllowUserToDeleteRows = False
        Me.dgUsuarios.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill
        Me.dgUsuarios.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgUsuarios.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.id, Me.Nombre_Usuario, Me.Apellido_Nombre, Me.Email, Me.dgUsuarioBtnModificar, Me.dgUsuarioBtnEliminado, Me.dgUsuarioBtnBloqueado, Me.bloqueado, Me.Eliminado})
        Me.dgUsuarios.Location = New System.Drawing.Point(15, 19)
        Me.dgUsuarios.Name = "dgUsuarios"
        Me.dgUsuarios.ReadOnly = True
        Me.dgUsuarios.RowHeadersVisible = False
        Me.dgUsuarios.Size = New System.Drawing.Size(735, 256)
        Me.dgUsuarios.TabIndex = 0
        '
        'id
        '
        Me.id.HeaderText = "id"
        Me.id.Name = "id"
        Me.id.ReadOnly = True
        Me.id.Visible = False
        '
        'Nombre_Usuario
        '
        Me.Nombre_Usuario.HeaderText = "Usuario"
        Me.Nombre_Usuario.Name = "Nombre_Usuario"
        Me.Nombre_Usuario.ReadOnly = True
        '
        'Apellido_Nombre
        '
        Me.Apellido_Nombre.FillWeight = 200.0!
        Me.Apellido_Nombre.HeaderText = "Apellido y Nombre"
        Me.Apellido_Nombre.Name = "Apellido_Nombre"
        Me.Apellido_Nombre.ReadOnly = True
        '
        'Email
        '
        Me.Email.HeaderText = "Email"
        Me.Email.Name = "Email"
        Me.Email.ReadOnly = True
        Me.Email.Visible = False
        '
        'dgUsuarioBtnModificar
        '
        Me.dgUsuarioBtnModificar.HeaderText = ""
        Me.dgUsuarioBtnModificar.Name = "dgUsuarioBtnModificar"
        Me.dgUsuarioBtnModificar.ReadOnly = True
        Me.dgUsuarioBtnModificar.Text = "Modificar"
        Me.dgUsuarioBtnModificar.UseColumnTextForButtonValue = True
        '
        'dgUsuarioBtnEliminado
        '
        Me.dgUsuarioBtnEliminado.HeaderText = ""
        Me.dgUsuarioBtnEliminado.Name = "dgUsuarioBtnEliminado"
        Me.dgUsuarioBtnEliminado.ReadOnly = True
        Me.dgUsuarioBtnEliminado.Resizable = System.Windows.Forms.DataGridViewTriState.[True]
        Me.dgUsuarioBtnEliminado.Text = "Eliminar"
        Me.dgUsuarioBtnEliminado.UseColumnTextForButtonValue = True
        '
        'dgUsuarioBtnBloqueado
        '
        Me.dgUsuarioBtnBloqueado.HeaderText = ""
        Me.dgUsuarioBtnBloqueado.Name = "dgUsuarioBtnBloqueado"
        Me.dgUsuarioBtnBloqueado.ReadOnly = True
        Me.dgUsuarioBtnBloqueado.Text = "Bloquear"
        Me.dgUsuarioBtnBloqueado.UseColumnTextForButtonValue = True
        '
        'bloqueado
        '
        Me.bloqueado.HeaderText = ""
        Me.bloqueado.Name = "bloqueado"
        Me.bloqueado.ReadOnly = True
        Me.bloqueado.Visible = False
        '
        'Eliminado
        '
        Me.Eliminado.HeaderText = ""
        Me.Eliminado.Name = "Eliminado"
        Me.Eliminado.ReadOnly = True
        Me.Eliminado.Visible = False
        '
        'btnRegistrar
        '
        Me.btnRegistrar.Location = New System.Drawing.Point(490, 296)
        Me.btnRegistrar.Name = "btnRegistrar"
        Me.btnRegistrar.Size = New System.Drawing.Size(127, 27)
        Me.btnRegistrar.TabIndex = 91
        Me.btnRegistrar.Text = "&Registrar"
        Me.btnRegistrar.UseVisualStyleBackColor = True
        '
        'HelpProvider1
        '
        Me.HelpProvider1.HelpNamespace = "C:\Users\German\Desktop\SistemaFarmacia\SistemaFarmacia\farmacia.chm"
        '
        'frmUsuarios
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.AutoSize = True
        Me.ClientSize = New System.Drawing.Size(797, 357)
        Me.ControlBox = False
        Me.Controls.Add(Me.GroupBox)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.HelpProvider1.SetHelpKeyword(Me, "10")
        Me.HelpProvider1.SetHelpNavigator(Me, System.Windows.Forms.HelpNavigator.TopicId)
        Me.MaximizeBox = False
        Me.Name = "frmUsuarios"
        Me.HelpProvider1.SetShowHelp(Me, True)
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Usuarios"
        Me.GroupBox.ResumeLayout(False)
        CType(Me.dgUsuarios, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents GroupBox As System.Windows.Forms.GroupBox
    Friend WithEvents dgUsuarios As System.Windows.Forms.DataGridView
    Friend WithEvents btnRegistrar As System.Windows.Forms.Button
    Friend WithEvents btnCancelar As System.Windows.Forms.Button
    Friend WithEvents id As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Nombre_Usuario As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Apellido_Nombre As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Email As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents dgUsuarioBtnModificar As System.Windows.Forms.DataGridViewButtonColumn
    Friend WithEvents dgUsuarioBtnEliminado As System.Windows.Forms.DataGridViewButtonColumn
    Friend WithEvents dgUsuarioBtnBloqueado As System.Windows.Forms.DataGridViewButtonColumn
    Friend WithEvents bloqueado As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Eliminado As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents HelpProvider1 As System.Windows.Forms.HelpProvider
End Class
