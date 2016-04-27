<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class ObtenerUsuarios
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
        Me.DataGridView1 = New System.Windows.Forms.DataGridView()
        Me.Usuarios = New System.Windows.Forms.GroupBox()
        Me.Usuario = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.ApeNom = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Email = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.ModificarUsuario = New System.Windows.Forms.DataGridViewButtonColumn()
        Me.Eliminar = New System.Windows.Forms.DataGridViewButtonColumn()
        Me.Bloquear = New System.Windows.Forms.DataGridViewButtonColumn()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Usuarios.SuspendLayout()
        Me.SuspendLayout()
        '
        'DataGridView1
        '
        Me.DataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridView1.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.Usuario, Me.ApeNom, Me.Email, Me.ModificarUsuario, Me.Eliminar, Me.Bloquear})
        Me.DataGridView1.Location = New System.Drawing.Point(17, 30)
        Me.DataGridView1.Name = "DataGridView1"
        Me.DataGridView1.Size = New System.Drawing.Size(739, 205)
        Me.DataGridView1.TabIndex = 0
        '
        'Usuarios
        '
        Me.Usuarios.Controls.Add(Me.DataGridView1)
        Me.Usuarios.Location = New System.Drawing.Point(12, 3)
        Me.Usuarios.Name = "Usuarios"
        Me.Usuarios.Size = New System.Drawing.Size(762, 260)
        Me.Usuarios.TabIndex = 1
        Me.Usuarios.TabStop = False
        Me.Usuarios.Text = "Usuarios"
        '
        'Usuario
        '
        Me.Usuario.HeaderText = "Usuario"
        Me.Usuario.Name = "Usuario"
        '
        'ApeNom
        '
        Me.ApeNom.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill
        Me.ApeNom.HeaderText = "Apellido y Nombre"
        Me.ApeNom.Name = "ApeNom"
        '
        'Email
        '
        Me.Email.HeaderText = "Email"
        Me.Email.Name = "Email"
        '
        'ModificarUsuario
        '
        Me.ModificarUsuario.HeaderText = ""
        Me.ModificarUsuario.Name = "ModificarUsuario"
        '
        'Eliminar
        '
        Me.Eliminar.HeaderText = ""
        Me.Eliminar.Name = "Eliminar"
        '
        'Bloquear
        '
        Me.Bloquear.HeaderText = ""
        Me.Bloquear.Name = "Bloquear"
        Me.Bloquear.Text = ""
        '
        'ObtenerUsuarios
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(780, 275)
        Me.Controls.Add(Me.Usuarios)
        Me.Name = "ObtenerUsuarios"
        Me.Text = "Usuarios"
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Usuarios.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents DataGridView1 As System.Windows.Forms.DataGridView
    Friend WithEvents Usuario As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents ApeNom As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Email As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents ModificarUsuario As System.Windows.Forms.DataGridViewButtonColumn
    Friend WithEvents Eliminar As System.Windows.Forms.DataGridViewButtonColumn
    Friend WithEvents Bloquear As System.Windows.Forms.DataGridViewButtonColumn
    Friend WithEvents Usuarios As System.Windows.Forms.GroupBox
End Class
