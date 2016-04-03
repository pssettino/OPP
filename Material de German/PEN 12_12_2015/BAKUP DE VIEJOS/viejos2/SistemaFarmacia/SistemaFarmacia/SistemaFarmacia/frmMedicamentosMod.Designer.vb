<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmMedicamentosMod
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmMedicamentosMod))
        Me.GroupBox_FrmMed = New System.Windows.Forms.GroupBox()
        Me.CheckReceta = New System.Windows.Forms.CheckBox()
        Me.lblPrecioE = New System.Windows.Forms.Label()
        Me.btnCancelar = New System.Windows.Forms.Button()
        Me.lblnombreE = New System.Windows.Forms.Label()
        Me.lbllaboratorioE = New System.Windows.Forms.Label()
        Me.btnAceptar = New System.Windows.Forms.Button()
        Me.lblPrecio = New System.Windows.Forms.Label()
        Me.lblCantidad = New System.Windows.Forms.Label()
        Me.lblLaboratorio = New System.Windows.Forms.Label()
        Me.lblNombre = New System.Windows.Forms.Label()
        Me.cmbLaboratorio = New System.Windows.Forms.ComboBox()
        Me.txtprecio = New System.Windows.Forms.TextBox()
        Me.txtnombre = New System.Windows.Forms.TextBox()
        Me.HelpProvider1 = New System.Windows.Forms.HelpProvider()
        Me.txtCantidad = New System.Windows.Forms.NumericUpDown()
        Me.GroupBox_FrmMed.SuspendLayout()
        CType(Me.txtCantidad, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'GroupBox_FrmMed
        '
        Me.GroupBox_FrmMed.Controls.Add(Me.txtCantidad)
        Me.GroupBox_FrmMed.Controls.Add(Me.CheckReceta)
        Me.GroupBox_FrmMed.Controls.Add(Me.lblPrecioE)
        Me.GroupBox_FrmMed.Controls.Add(Me.btnCancelar)
        Me.GroupBox_FrmMed.Controls.Add(Me.lblnombreE)
        Me.GroupBox_FrmMed.Controls.Add(Me.lbllaboratorioE)
        Me.GroupBox_FrmMed.Controls.Add(Me.btnAceptar)
        Me.GroupBox_FrmMed.Controls.Add(Me.lblPrecio)
        Me.GroupBox_FrmMed.Controls.Add(Me.lblCantidad)
        Me.GroupBox_FrmMed.Controls.Add(Me.lblLaboratorio)
        Me.GroupBox_FrmMed.Controls.Add(Me.lblNombre)
        Me.GroupBox_FrmMed.Controls.Add(Me.cmbLaboratorio)
        Me.GroupBox_FrmMed.Controls.Add(Me.txtprecio)
        Me.GroupBox_FrmMed.Controls.Add(Me.txtnombre)
        Me.GroupBox_FrmMed.Location = New System.Drawing.Point(12, 12)
        Me.GroupBox_FrmMed.Name = "GroupBox_FrmMed"
        Me.GroupBox_FrmMed.Size = New System.Drawing.Size(353, 244)
        Me.GroupBox_FrmMed.TabIndex = 8
        Me.GroupBox_FrmMed.TabStop = False
        '
        'CheckReceta
        '
        Me.CheckReceta.AutoSize = True
        Me.CheckReceta.Location = New System.Drawing.Point(215, 106)
        Me.CheckReceta.Name = "CheckReceta"
        Me.CheckReceta.Size = New System.Drawing.Size(61, 17)
        Me.CheckReceta.TabIndex = 90
        Me.CheckReceta.Text = "Receta"
        Me.CheckReceta.UseVisualStyleBackColor = True
        '
        'lblPrecioE
        '
        Me.lblPrecioE.AutoSize = True
        Me.lblPrecioE.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblPrecioE.ForeColor = System.Drawing.Color.Red
        Me.lblPrecioE.Location = New System.Drawing.Point(87, 166)
        Me.lblPrecioE.Name = "lblPrecioE"
        Me.lblPrecioE.Size = New System.Drawing.Size(24, 12)
        Me.lblPrecioE.TabIndex = 89
        Me.lblPrecioE.Text = "error"
        Me.lblPrecioE.Visible = False
        '
        'btnCancelar
        '
        Me.btnCancelar.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.btnCancelar.Location = New System.Drawing.Point(198, 203)
        Me.btnCancelar.Name = "btnCancelar"
        Me.btnCancelar.Size = New System.Drawing.Size(127, 27)
        Me.btnCancelar.TabIndex = 5
        Me.btnCancelar.Text = "&Cancelar"
        '
        'lblnombreE
        '
        Me.lblnombreE.AutoSize = True
        Me.lblnombreE.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblnombreE.ForeColor = System.Drawing.Color.Red
        Me.lblnombreE.Location = New System.Drawing.Point(87, 51)
        Me.lblnombreE.Name = "lblnombreE"
        Me.lblnombreE.Size = New System.Drawing.Size(24, 12)
        Me.lblnombreE.TabIndex = 87
        Me.lblnombreE.Text = "error"
        Me.lblnombreE.Visible = False
        '
        'lbllaboratorioE
        '
        Me.lbllaboratorioE.AutoSize = True
        Me.lbllaboratorioE.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lbllaboratorioE.ForeColor = System.Drawing.Color.Red
        Me.lbllaboratorioE.Location = New System.Drawing.Point(87, 89)
        Me.lbllaboratorioE.Name = "lbllaboratorioE"
        Me.lbllaboratorioE.Size = New System.Drawing.Size(24, 12)
        Me.lbllaboratorioE.TabIndex = 88
        Me.lbllaboratorioE.Text = "error"
        Me.lbllaboratorioE.Visible = False
        '
        'btnAceptar
        '
        Me.btnAceptar.Location = New System.Drawing.Point(65, 203)
        Me.btnAceptar.Name = "btnAceptar"
        Me.btnAceptar.Size = New System.Drawing.Size(127, 27)
        Me.btnAceptar.TabIndex = 4
        Me.btnAceptar.Text = "&Aceptar"
        '
        'lblPrecio
        '
        Me.lblPrecio.AutoSize = True
        Me.lblPrecio.Location = New System.Drawing.Point(41, 146)
        Me.lblPrecio.Name = "lblPrecio"
        Me.lblPrecio.Size = New System.Drawing.Size(37, 13)
        Me.lblPrecio.TabIndex = 2
        Me.lblPrecio.Text = "Precio"
        Me.lblPrecio.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lblCantidad
        '
        Me.lblCantidad.AutoSize = True
        Me.lblCantidad.Location = New System.Drawing.Point(29, 107)
        Me.lblCantidad.Name = "lblCantidad"
        Me.lblCantidad.Size = New System.Drawing.Size(49, 13)
        Me.lblCantidad.TabIndex = 2
        Me.lblCantidad.Text = "Cantidad"
        Me.lblCantidad.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lblLaboratorio
        '
        Me.lblLaboratorio.AutoSize = True
        Me.lblLaboratorio.Location = New System.Drawing.Point(18, 70)
        Me.lblLaboratorio.Name = "lblLaboratorio"
        Me.lblLaboratorio.Size = New System.Drawing.Size(60, 13)
        Me.lblLaboratorio.TabIndex = 2
        Me.lblLaboratorio.Text = "Laboratorio"
        Me.lblLaboratorio.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lblNombre
        '
        Me.lblNombre.AutoSize = True
        Me.lblNombre.Location = New System.Drawing.Point(31, 31)
        Me.lblNombre.Name = "lblNombre"
        Me.lblNombre.Size = New System.Drawing.Size(44, 13)
        Me.lblNombre.TabIndex = 2
        Me.lblNombre.Text = "Nombre"
        Me.lblNombre.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'cmbLaboratorio
        '
        Me.cmbLaboratorio.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbLaboratorio.FormattingEnabled = True
        Me.cmbLaboratorio.Location = New System.Drawing.Point(84, 67)
        Me.cmbLaboratorio.Name = "cmbLaboratorio"
        Me.cmbLaboratorio.Size = New System.Drawing.Size(241, 21)
        Me.cmbLaboratorio.TabIndex = 1
        '
        'txtprecio
        '
        Me.txtprecio.Location = New System.Drawing.Point(84, 143)
        Me.txtprecio.Name = "txtprecio"
        Me.txtprecio.Size = New System.Drawing.Size(109, 20)
        Me.txtprecio.TabIndex = 3
        Me.txtprecio.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        '
        'txtnombre
        '
        Me.txtnombre.Location = New System.Drawing.Point(84, 28)
        Me.txtnombre.Name = "txtnombre"
        Me.txtnombre.Size = New System.Drawing.Size(241, 20)
        Me.txtnombre.TabIndex = 0
        '
        'HelpProvider1
        '
        Me.HelpProvider1.HelpNamespace = "C:\Users\German\Desktop\SistemaFarmacia\SistemaFarmacia\farmacia.chm"
        '
        'txtCantidad
        '
        Me.txtCantidad.Location = New System.Drawing.Point(83, 107)
        Me.txtCantidad.Margin = New System.Windows.Forms.Padding(2)
        Me.txtCantidad.Maximum = New Decimal(New Integer() {32767, 0, 0, 0})
        Me.txtCantidad.Minimum = New Decimal(New Integer() {1, 0, 0, 0})
        Me.txtCantidad.Name = "txtCantidad"
        Me.txtCantidad.Size = New System.Drawing.Size(110, 20)
        Me.txtCantidad.TabIndex = 114
        Me.txtCantidad.Value = New Decimal(New Integer() {1, 0, 0, 0})
        '
        'frmMedicamentosMod
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(381, 268)
        Me.ControlBox = False
        Me.Controls.Add(Me.GroupBox_FrmMed)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "frmMedicamentosMod"
        Me.HelpProvider1.SetShowHelp(Me, True)
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Medicamentos"
        Me.GroupBox_FrmMed.ResumeLayout(False)
        Me.GroupBox_FrmMed.PerformLayout()
        CType(Me.txtCantidad, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents GroupBox_FrmMed As System.Windows.Forms.GroupBox
    Friend WithEvents btnCancelar As System.Windows.Forms.Button
    Friend WithEvents btnAceptar As System.Windows.Forms.Button
    Friend WithEvents lblPrecio As System.Windows.Forms.Label
    Friend WithEvents lblCantidad As System.Windows.Forms.Label
    Friend WithEvents lblLaboratorio As System.Windows.Forms.Label
    Friend WithEvents lblNombre As System.Windows.Forms.Label
    Friend WithEvents cmbLaboratorio As System.Windows.Forms.ComboBox
    Friend WithEvents txtprecio As System.Windows.Forms.TextBox
    Friend WithEvents txtnombre As System.Windows.Forms.TextBox
    Friend WithEvents lblPrecioE As System.Windows.Forms.Label
    Friend WithEvents lblnombreE As System.Windows.Forms.Label
    Friend WithEvents lbllaboratorioE As System.Windows.Forms.Label
    Friend WithEvents CheckReceta As System.Windows.Forms.CheckBox
    Friend WithEvents HelpProvider1 As System.Windows.Forms.HelpProvider
    Friend WithEvents txtCantidad As System.Windows.Forms.NumericUpDown
End Class
