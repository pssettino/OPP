<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmBitacora
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
        Me.dtgBitacora = New System.Windows.Forms.DataGridView()
        Me.btnListarTodos = New System.Windows.Forms.Button()
        Me.cmbUsu = New System.Windows.Forms.ComboBox()
        Me.lblUsuario = New System.Windows.Forms.Label()
        Me.lblDesde = New System.Windows.Forms.Label()
        Me.dtpdesde = New System.Windows.Forms.DateTimePicker()
        Me.lblHasta = New System.Windows.Forms.Label()
        Me.dtphasta = New System.Windows.Forms.DateTimePicker()
        Me.lblSeleccionarFec = New System.Windows.Forms.Label()
        Me.lblSeleccionarUsuario = New System.Windows.Forms.Label()
        Me.lblSeleccionarCrit = New System.Windows.Forms.Label()
        Me.lblNivel = New System.Windows.Forms.Label()
        Me.cmbcrit = New System.Windows.Forms.ComboBox()
        Me.Button1 = New System.Windows.Forms.Button()
        CType(Me.dtgBitacora, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'dtgBitacora
        '
        Me.dtgBitacora.AllowUserToOrderColumns = True
        Me.dtgBitacora.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill
        Me.dtgBitacora.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dtgBitacora.Location = New System.Drawing.Point(21, 92)
        Me.dtgBitacora.Name = "dtgBitacora"
        Me.dtgBitacora.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.CellSelect
        Me.dtgBitacora.Size = New System.Drawing.Size(793, 195)
        Me.dtgBitacora.TabIndex = 0
        '
        'btnListarTodos
        '
        Me.btnListarTodos.Location = New System.Drawing.Point(21, 307)
        Me.btnListarTodos.Name = "btnListarTodos"
        Me.btnListarTodos.Size = New System.Drawing.Size(143, 49)
        Me.btnListarTodos.TabIndex = 1
        Me.btnListarTodos.Text = "Consultar"
        Me.btnListarTodos.UseVisualStyleBackColor = True
        '
        'cmbUsu
        '
        Me.cmbUsu.FormattingEnabled = True
        Me.cmbUsu.Location = New System.Drawing.Point(76, 33)
        Me.cmbUsu.Name = "cmbUsu"
        Me.cmbUsu.Size = New System.Drawing.Size(121, 21)
        Me.cmbUsu.TabIndex = 2
        '
        'lblUsuario
        '
        Me.lblUsuario.AutoSize = True
        Me.lblUsuario.Location = New System.Drawing.Point(27, 36)
        Me.lblUsuario.Name = "lblUsuario"
        Me.lblUsuario.Size = New System.Drawing.Size(43, 13)
        Me.lblUsuario.TabIndex = 3
        Me.lblUsuario.Text = "Usuario"
        '
        'lblDesde
        '
        Me.lblDesde.AutoSize = True
        Me.lblDesde.Location = New System.Drawing.Point(487, 36)
        Me.lblDesde.Name = "lblDesde"
        Me.lblDesde.Size = New System.Drawing.Size(38, 13)
        Me.lblDesde.TabIndex = 4
        Me.lblDesde.Text = "Desde"
        '
        'dtpdesde
        '
        Me.dtpdesde.Location = New System.Drawing.Point(527, 33)
        Me.dtpdesde.Name = "dtpdesde"
        Me.dtpdesde.Size = New System.Drawing.Size(200, 20)
        Me.dtpdesde.TabIndex = 5
        Me.dtpdesde.Value = New Date(2012, 11, 1, 0, 0, 0, 0)
        '
        'lblHasta
        '
        Me.lblHasta.AutoSize = True
        Me.lblHasta.Location = New System.Drawing.Point(487, 66)
        Me.lblHasta.Name = "lblHasta"
        Me.lblHasta.Size = New System.Drawing.Size(35, 13)
        Me.lblHasta.TabIndex = 8
        Me.lblHasta.Text = "Hasta"
        '
        'dtphasta
        '
        Me.dtphasta.Location = New System.Drawing.Point(527, 66)
        Me.dtphasta.Name = "dtphasta"
        Me.dtphasta.Size = New System.Drawing.Size(200, 20)
        Me.dtphasta.TabIndex = 9
        '
        'lblSeleccionarFec
        '
        Me.lblSeleccionarFec.AutoSize = True
        Me.lblSeleccionarFec.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblSeleccionarFec.Location = New System.Drawing.Point(487, 9)
        Me.lblSeleccionarFec.Name = "lblSeleccionarFec"
        Me.lblSeleccionarFec.Size = New System.Drawing.Size(133, 15)
        Me.lblSeleccionarFec.TabIndex = 10
        Me.lblSeleccionarFec.Text = "Seleccionar Fechas"
        '
        'lblSeleccionarUsuario
        '
        Me.lblSeleccionarUsuario.AutoSize = True
        Me.lblSeleccionarUsuario.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblSeleccionarUsuario.Location = New System.Drawing.Point(27, 9)
        Me.lblSeleccionarUsuario.Name = "lblSeleccionarUsuario"
        Me.lblSeleccionarUsuario.Size = New System.Drawing.Size(137, 15)
        Me.lblSeleccionarUsuario.TabIndex = 11
        Me.lblSeleccionarUsuario.Text = "Seleccionar Usuario"
        '
        'lblSeleccionarCrit
        '
        Me.lblSeleccionarCrit.AutoSize = True
        Me.lblSeleccionarCrit.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblSeleccionarCrit.Location = New System.Drawing.Point(241, 9)
        Me.lblSeleccionarCrit.Name = "lblSeleccionarCrit"
        Me.lblSeleccionarCrit.Size = New System.Drawing.Size(148, 15)
        Me.lblSeleccionarCrit.TabIndex = 14
        Me.lblSeleccionarCrit.Text = "Seleccionar Criticidad"
        '
        'lblNivel
        '
        Me.lblNivel.AutoSize = True
        Me.lblNivel.Location = New System.Drawing.Point(241, 36)
        Me.lblNivel.Name = "lblNivel"
        Me.lblNivel.Size = New System.Drawing.Size(31, 13)
        Me.lblNivel.TabIndex = 13
        Me.lblNivel.Text = "Nivel"
        '
        'cmbcrit
        '
        Me.cmbcrit.FormattingEnabled = True
        Me.cmbcrit.Location = New System.Drawing.Point(290, 33)
        Me.cmbcrit.Name = "cmbcrit"
        Me.cmbcrit.Size = New System.Drawing.Size(121, 21)
        Me.cmbcrit.TabIndex = 12
        '
        'Button1
        '
        Me.Button1.Image = Global.UI.My.Resources.Resources.Bitacora
        Me.Button1.Location = New System.Drawing.Point(733, 30)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(48, 56)
        Me.Button1.TabIndex = 6
        Me.Button1.UseVisualStyleBackColor = True
        '
        'frmBitacora
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(826, 380)
        Me.Controls.Add(Me.lblSeleccionarCrit)
        Me.Controls.Add(Me.lblNivel)
        Me.Controls.Add(Me.cmbcrit)
        Me.Controls.Add(Me.lblSeleccionarUsuario)
        Me.Controls.Add(Me.lblSeleccionarFec)
        Me.Controls.Add(Me.dtphasta)
        Me.Controls.Add(Me.lblHasta)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.dtpdesde)
        Me.Controls.Add(Me.lblDesde)
        Me.Controls.Add(Me.lblUsuario)
        Me.Controls.Add(Me.cmbUsu)
        Me.Controls.Add(Me.btnListarTodos)
        Me.Controls.Add(Me.dtgBitacora)
        Me.KeyPreview = True
        Me.Name = "frmBitacora"
        Me.Text = "Bitacora"
        CType(Me.dtgBitacora, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents dtgBitacora As System.Windows.Forms.DataGridView
    Friend WithEvents btnListarTodos As System.Windows.Forms.Button
    Friend WithEvents cmbUsu As System.Windows.Forms.ComboBox
    Friend WithEvents lblUsuario As System.Windows.Forms.Label
    Friend WithEvents lblDesde As System.Windows.Forms.Label
    Friend WithEvents dtpdesde As System.Windows.Forms.DateTimePicker
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents lblHasta As System.Windows.Forms.Label
    Friend WithEvents dtphasta As System.Windows.Forms.DateTimePicker
    Friend WithEvents lblSeleccionarFec As System.Windows.Forms.Label
    Friend WithEvents lblSeleccionarUsuario As System.Windows.Forms.Label
    Friend WithEvents lblSeleccionarCrit As System.Windows.Forms.Label
    Friend WithEvents lblNivel As System.Windows.Forms.Label
    Friend WithEvents cmbcrit As System.Windows.Forms.ComboBox
End Class
