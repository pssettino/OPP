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
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmUsuarios))
        Me.GroupBox_List = New System.Windows.Forms.GroupBox()
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
        Me.epError = New System.Windows.Forms.ErrorProvider(Me.components)
        Me.epOK = New System.Windows.Forms.ErrorProvider(Me.components)
        Me.GroupBox_List.SuspendLayout()
        CType(Me.dgUsuarios, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.epError, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.epOK, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'GroupBox_List
        '
        Me.GroupBox_List.Controls.Add(Me.btnCancelar)
        Me.GroupBox_List.Controls.Add(Me.dgUsuarios)
        Me.GroupBox_List.Controls.Add(Me.btnRegistrar)
        Me.GroupBox_List.Location = New System.Drawing.Point(12, 4)
        Me.GroupBox_List.Name = "GroupBox_List"
        Me.GroupBox_List.Size = New System.Drawing.Size(626, 343)
        Me.GroupBox_List.TabIndex = 89
        Me.GroupBox_List.TabStop = False
        '
        'btnCancelar
        '
        Me.btnCancelar.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.btnCancelar.Location = New System.Drawing.Point(474, 297)
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
        Me.dgUsuarios.Location = New System.Drawing.Point(15, 23)
        Me.dgUsuarios.Name = "dgUsuarios"
        Me.dgUsuarios.ReadOnly = True
        Me.dgUsuarios.RowHeadersVisible = False
        Me.dgUsuarios.Size = New System.Drawing.Size(586, 256)
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
        '
        'dgUsuarioBtnEliminado
        '
        Me.dgUsuarioBtnEliminado.HeaderText = ""
        Me.dgUsuarioBtnEliminado.Name = "dgUsuarioBtnEliminado"
        Me.dgUsuarioBtnEliminado.ReadOnly = True
        Me.dgUsuarioBtnEliminado.Resizable = System.Windows.Forms.DataGridViewTriState.[True]
        '
        'dgUsuarioBtnBloqueado
        '
        Me.dgUsuarioBtnBloqueado.HeaderText = ""
        Me.dgUsuarioBtnBloqueado.Name = "dgUsuarioBtnBloqueado"
        Me.dgUsuarioBtnBloqueado.ReadOnly = True
        Me.dgUsuarioBtnBloqueado.Text = ""
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
        Me.btnRegistrar.Location = New System.Drawing.Point(341, 297)
        Me.btnRegistrar.Name = "btnRegistrar"
        Me.btnRegistrar.Size = New System.Drawing.Size(127, 27)
        Me.btnRegistrar.TabIndex = 91
        Me.btnRegistrar.Text = "&Registrar"
        Me.btnRegistrar.UseVisualStyleBackColor = True
        '
        'epError
        '
        Me.epError.ContainerControl = Me
        '
        'epOK
        '
        Me.epOK.ContainerControl = Me
        Me.epOK.Icon = CType(resources.GetObject("epOK.Icon"), System.Drawing.Icon)
        '
        'frmUsuarios
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.AutoSize = True
        Me.ClientSize = New System.Drawing.Size(650, 360)
        Me.ControlBox = False
        Me.Controls.Add(Me.GroupBox_List)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.MaximizeBox = False
        Me.Name = "frmUsuarios"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Usuarios"
        Me.GroupBox_List.ResumeLayout(False)
        CType(Me.dgUsuarios, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.epError, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.epOK, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents GroupBox_List As System.Windows.Forms.GroupBox
    Friend WithEvents dgUsuarios As System.Windows.Forms.DataGridView
    Friend WithEvents btnRegistrar As System.Windows.Forms.Button
    Friend WithEvents epError As System.Windows.Forms.ErrorProvider
    Friend WithEvents epOK As System.Windows.Forms.ErrorProvider
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
End Class
