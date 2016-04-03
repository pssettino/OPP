<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmVentasMod
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
        Me.txtPrecioLista = New System.Windows.Forms.TextBox()
        Me.txtDisponible = New System.Windows.Forms.TextBox()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.txtCantidad = New System.Windows.Forms.NumericUpDown()
        Me.txtImporteTotal = New System.Windows.Forms.TextBox()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.dgMedicamentosPorVenta = New System.Windows.Forms.DataGridView()
        Me.NroMedicamento = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Medicamento = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Receta = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.CantVenta = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.PrecioVenta = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.gvBtnEliminarMedicamento = New System.Windows.Forms.DataGridViewButtonColumn()
        Me.Eliminado = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.lblPrecioE = New System.Windows.Forms.Label()
        Me.btnCancelar = New System.Windows.Forms.Button()
        Me.lblclienteE = New System.Windows.Forms.Label()
        Me.lblmedicamentoE = New System.Windows.Forms.Label()
        Me.btnAceptar = New System.Windows.Forms.Button()
        Me.btnAgregarMedicamento = New System.Windows.Forms.Button()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.lblFechaHora = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.cmbMedicamento = New System.Windows.Forms.ComboBox()
        Me.cmbCliente = New System.Windows.Forms.ComboBox()
        Me.txtPrecio = New System.Windows.Forms.TextBox()
        Me.txtFechaHora = New System.Windows.Forms.TextBox()
        Me.txtNroVenta = New System.Windows.Forms.TextBox()
        Me.HelpProvider1 = New System.Windows.Forms.HelpProvider()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.Label10 = New System.Windows.Forms.Label()
        Me.GroupBox.SuspendLayout()
        CType(Me.txtCantidad, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.dgMedicamentosPorVenta, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'GroupBox
        '
        Me.GroupBox.Controls.Add(Me.txtPrecioLista)
        Me.GroupBox.Controls.Add(Me.txtDisponible)
        Me.GroupBox.Controls.Add(Me.Label7)
        Me.GroupBox.Controls.Add(Me.Label8)
        Me.GroupBox.Controls.Add(Me.txtCantidad)
        Me.GroupBox.Controls.Add(Me.txtImporteTotal)
        Me.GroupBox.Controls.Add(Me.Label9)
        Me.GroupBox.Controls.Add(Me.dgMedicamentosPorVenta)
        Me.GroupBox.Controls.Add(Me.lblPrecioE)
        Me.GroupBox.Controls.Add(Me.btnCancelar)
        Me.GroupBox.Controls.Add(Me.lblclienteE)
        Me.GroupBox.Controls.Add(Me.lblmedicamentoE)
        Me.GroupBox.Controls.Add(Me.btnAceptar)
        Me.GroupBox.Controls.Add(Me.btnAgregarMedicamento)
        Me.GroupBox.Controls.Add(Me.Label10)
        Me.GroupBox.Controls.Add(Me.Label6)
        Me.GroupBox.Controls.Add(Me.Label5)
        Me.GroupBox.Controls.Add(Me.Label4)
        Me.GroupBox.Controls.Add(Me.Label3)
        Me.GroupBox.Controls.Add(Me.Label2)
        Me.GroupBox.Controls.Add(Me.lblFechaHora)
        Me.GroupBox.Controls.Add(Me.Label1)
        Me.GroupBox.Controls.Add(Me.cmbMedicamento)
        Me.GroupBox.Controls.Add(Me.cmbCliente)
        Me.GroupBox.Controls.Add(Me.txtPrecio)
        Me.GroupBox.Controls.Add(Me.txtFechaHora)
        Me.GroupBox.Controls.Add(Me.txtNroVenta)
        Me.GroupBox.Location = New System.Drawing.Point(12, 4)
        Me.GroupBox.Name = "GroupBox"
        Me.GroupBox.Size = New System.Drawing.Size(590, 491)
        Me.GroupBox.TabIndex = 8
        Me.GroupBox.TabStop = False
        '
        'txtPrecioLista
        '
        Me.txtPrecioLista.Enabled = False
        Me.txtPrecioLista.Location = New System.Drawing.Point(315, 138)
        Me.txtPrecioLista.Name = "txtPrecioLista"
        Me.txtPrecioLista.ReadOnly = True
        Me.txtPrecioLista.Size = New System.Drawing.Size(111, 20)
        Me.txtPrecioLista.TabIndex = 116
        Me.txtPrecioLista.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        '
        'txtDisponible
        '
        Me.txtDisponible.Enabled = False
        Me.txtDisponible.Location = New System.Drawing.Point(117, 138)
        Me.txtDisponible.Name = "txtDisponible"
        Me.txtDisponible.ReadOnly = True
        Me.txtDisponible.Size = New System.Drawing.Size(90, 20)
        Me.txtDisponible.TabIndex = 117
        '
        'Label7
        '
        Me.Label7.Location = New System.Drawing.Point(213, 138)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(96, 20)
        Me.Label7.TabIndex = 114
        Me.Label7.Text = "Precio de Lista"
        Me.Label7.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'Label8
        '
        Me.Label8.Location = New System.Drawing.Point(28, 137)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(83, 21)
        Me.Label8.TabIndex = 115
        Me.Label8.Text = "Disponible"
        Me.Label8.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'txtCantidad
        '
        Me.txtCantidad.Location = New System.Drawing.Point(117, 176)
        Me.txtCantidad.Margin = New System.Windows.Forms.Padding(2)
        Me.txtCantidad.Maximum = New Decimal(New Integer() {32767, 0, 0, 0})
        Me.txtCantidad.Minimum = New Decimal(New Integer() {1, 0, 0, 0})
        Me.txtCantidad.Name = "txtCantidad"
        Me.txtCantidad.Size = New System.Drawing.Size(90, 20)
        Me.txtCantidad.TabIndex = 113
        Me.txtCantidad.Value = New Decimal(New Integer() {1, 0, 0, 0})
        '
        'txtImporteTotal
        '
        Me.txtImporteTotal.Enabled = False
        Me.txtImporteTotal.Location = New System.Drawing.Point(447, 411)
        Me.txtImporteTotal.Margin = New System.Windows.Forms.Padding(2)
        Me.txtImporteTotal.Name = "txtImporteTotal"
        Me.txtImporteTotal.ReadOnly = True
        Me.txtImporteTotal.Size = New System.Drawing.Size(127, 20)
        Me.txtImporteTotal.TabIndex = 112
        Me.txtImporteTotal.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Location = New System.Drawing.Point(378, 414)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(64, 13)
        Me.Label9.TabIndex = 111
        Me.Label9.Text = "Precio Total"
        '
        'dgMedicamentosPorVenta
        '
        Me.dgMedicamentosPorVenta.AllowUserToAddRows = False
        Me.dgMedicamentosPorVenta.AllowUserToDeleteRows = False
        Me.dgMedicamentosPorVenta.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill
        Me.dgMedicamentosPorVenta.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgMedicamentosPorVenta.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.NroMedicamento, Me.Medicamento, Me.Receta, Me.CantVenta, Me.PrecioVenta, Me.gvBtnEliminarMedicamento, Me.Eliminado})
        Me.dgMedicamentosPorVenta.Location = New System.Drawing.Point(15, 219)
        Me.dgMedicamentosPorVenta.Name = "dgMedicamentosPorVenta"
        Me.dgMedicamentosPorVenta.ReadOnly = True
        Me.dgMedicamentosPorVenta.RowHeadersVisible = False
        Me.dgMedicamentosPorVenta.Size = New System.Drawing.Size(560, 180)
        Me.dgMedicamentosPorVenta.TabIndex = 110
        '
        'NroMedicamento
        '
        Me.NroMedicamento.FillWeight = 50.0!
        Me.NroMedicamento.HeaderText = "Nro"
        Me.NroMedicamento.Name = "NroMedicamento"
        Me.NroMedicamento.ReadOnly = True
        '
        'Medicamento
        '
        Me.Medicamento.HeaderText = "Medicamento"
        Me.Medicamento.Name = "Medicamento"
        Me.Medicamento.ReadOnly = True
        '
        'Receta
        '
        Me.Receta.FillWeight = 50.0!
        Me.Receta.HeaderText = "Receta"
        Me.Receta.Name = "Receta"
        Me.Receta.ReadOnly = True
        '
        'CantVenta
        '
        Me.CantVenta.HeaderText = "Cantidad"
        Me.CantVenta.Name = "CantVenta"
        Me.CantVenta.ReadOnly = True
        '
        'PrecioVenta
        '
        Me.PrecioVenta.HeaderText = "Precio"
        Me.PrecioVenta.Name = "PrecioVenta"
        Me.PrecioVenta.ReadOnly = True
        '
        'gvBtnEliminarMedicamento
        '
        Me.gvBtnEliminarMedicamento.FillWeight = 150.0!
        Me.gvBtnEliminarMedicamento.HeaderText = ""
        Me.gvBtnEliminarMedicamento.Name = "gvBtnEliminarMedicamento"
        Me.gvBtnEliminarMedicamento.ReadOnly = True
        Me.gvBtnEliminarMedicamento.Resizable = System.Windows.Forms.DataGridViewTriState.[False]
        Me.gvBtnEliminarMedicamento.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic
        Me.gvBtnEliminarMedicamento.Text = "Eliminar"
        '
        'Eliminado
        '
        Me.Eliminado.HeaderText = ""
        Me.Eliminado.Name = "Eliminado"
        Me.Eliminado.ReadOnly = True
        Me.Eliminado.Visible = False
        '
        'lblPrecioE
        '
        Me.lblPrecioE.AutoSize = True
        Me.lblPrecioE.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblPrecioE.ForeColor = System.Drawing.Color.Red
        Me.lblPrecioE.Location = New System.Drawing.Point(316, 200)
        Me.lblPrecioE.Name = "lblPrecioE"
        Me.lblPrecioE.Size = New System.Drawing.Size(24, 12)
        Me.lblPrecioE.TabIndex = 109
        Me.lblPrecioE.Text = "error"
        Me.lblPrecioE.Visible = False
        '
        'btnCancelar
        '
        Me.btnCancelar.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.btnCancelar.Location = New System.Drawing.Point(448, 448)
        Me.btnCancelar.Name = "btnCancelar"
        Me.btnCancelar.Size = New System.Drawing.Size(127, 27)
        Me.btnCancelar.TabIndex = 7
        Me.btnCancelar.Text = "&Cancelar"
        '
        'lblclienteE
        '
        Me.lblclienteE.AutoSize = True
        Me.lblclienteE.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblclienteE.ForeColor = System.Drawing.Color.Red
        Me.lblclienteE.Location = New System.Drawing.Point(118, 79)
        Me.lblclienteE.Name = "lblclienteE"
        Me.lblclienteE.Size = New System.Drawing.Size(24, 12)
        Me.lblclienteE.TabIndex = 106
        Me.lblclienteE.Text = "error"
        Me.lblclienteE.Visible = False
        '
        'lblmedicamentoE
        '
        Me.lblmedicamentoE.AutoSize = True
        Me.lblmedicamentoE.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblmedicamentoE.ForeColor = System.Drawing.Color.Red
        Me.lblmedicamentoE.Location = New System.Drawing.Point(118, 120)
        Me.lblmedicamentoE.Name = "lblmedicamentoE"
        Me.lblmedicamentoE.Size = New System.Drawing.Size(24, 12)
        Me.lblmedicamentoE.TabIndex = 107
        Me.lblmedicamentoE.Text = "error"
        Me.lblmedicamentoE.Visible = False
        '
        'btnAceptar
        '
        Me.btnAceptar.Location = New System.Drawing.Point(315, 448)
        Me.btnAceptar.Name = "btnAceptar"
        Me.btnAceptar.Size = New System.Drawing.Size(127, 27)
        Me.btnAceptar.TabIndex = 6
        Me.btnAceptar.Text = "&Aceptar"
        '
        'btnAgregarMedicamento
        '
        Me.btnAgregarMedicamento.Location = New System.Drawing.Point(432, 92)
        Me.btnAgregarMedicamento.Name = "btnAgregarMedicamento"
        Me.btnAgregarMedicamento.Size = New System.Drawing.Size(142, 27)
        Me.btnAgregarMedicamento.TabIndex = 3
        Me.btnAgregarMedicamento.Text = "Agregar Medicamento"
        Me.btnAgregarMedicamento.UseVisualStyleBackColor = True
        '
        'Label5
        '
        Me.Label5.Location = New System.Drawing.Point(213, 176)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(96, 21)
        Me.Label5.TabIndex = 2
        Me.Label5.Text = "Precio de Venta"
        Me.Label5.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'Label4
        '
        Me.Label4.Location = New System.Drawing.Point(48, 176)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(63, 20)
        Me.Label4.TabIndex = 2
        Me.Label4.Text = "Cantidad"
        Me.Label4.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'Label3
        '
        Me.Label3.Location = New System.Drawing.Point(19, 92)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(92, 24)
        Me.Label3.TabIndex = 2
        Me.Label3.Text = "Medicamento"
        Me.Label3.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'Label2
        '
        Me.Label2.Location = New System.Drawing.Point(12, 54)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(99, 22)
        Me.Label2.TabIndex = 2
        Me.Label2.Text = "Clientes activos"
        Me.Label2.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lblFechaHora
        '
        Me.lblFechaHora.Location = New System.Drawing.Point(216, 18)
        Me.lblFechaHora.Name = "lblFechaHora"
        Me.lblFechaHora.Size = New System.Drawing.Size(93, 21)
        Me.lblFechaHora.TabIndex = 2
        Me.lblFechaHora.Text = "Fecha y Hora"
        Me.lblFechaHora.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'Label1
        '
        Me.Label1.Location = New System.Drawing.Point(33, 18)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(78, 20)
        Me.Label1.TabIndex = 2
        Me.Label1.Text = "Nro Venta"
        Me.Label1.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'cmbMedicamento
        '
        Me.cmbMedicamento.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbMedicamento.FormattingEnabled = True
        Me.cmbMedicamento.Location = New System.Drawing.Point(117, 95)
        Me.cmbMedicamento.Name = "cmbMedicamento"
        Me.cmbMedicamento.Size = New System.Drawing.Size(309, 21)
        Me.cmbMedicamento.TabIndex = 2
        '
        'cmbCliente
        '
        Me.cmbCliente.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbCliente.FormattingEnabled = True
        Me.cmbCliente.Location = New System.Drawing.Point(117, 55)
        Me.cmbCliente.Name = "cmbCliente"
        Me.cmbCliente.Size = New System.Drawing.Size(309, 21)
        Me.cmbCliente.TabIndex = 1
        '
        'txtPrecio
        '
        Me.txtPrecio.Location = New System.Drawing.Point(315, 177)
        Me.txtPrecio.Name = "txtPrecio"
        Me.txtPrecio.Size = New System.Drawing.Size(111, 20)
        Me.txtPrecio.TabIndex = 5
        Me.txtPrecio.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        '
        'txtFechaHora
        '
        Me.txtFechaHora.Enabled = False
        Me.txtFechaHora.Location = New System.Drawing.Point(315, 19)
        Me.txtFechaHora.Name = "txtFechaHora"
        Me.txtFechaHora.ReadOnly = True
        Me.txtFechaHora.Size = New System.Drawing.Size(111, 20)
        Me.txtFechaHora.TabIndex = 0
        '
        'txtNroVenta
        '
        Me.txtNroVenta.Enabled = False
        Me.txtNroVenta.Location = New System.Drawing.Point(117, 18)
        Me.txtNroVenta.Name = "txtNroVenta"
        Me.txtNroVenta.ReadOnly = True
        Me.txtNroVenta.Size = New System.Drawing.Size(76, 20)
        Me.txtNroVenta.TabIndex = 0
        '
        'HelpProvider1
        '
        Me.HelpProvider1.HelpNamespace = "C:\Users\Navegador\Desktop\SistemaFarmacia\SistemaFarmacia\farmacia.chm"
        '
        'Label6
        '
        Me.Label6.Location = New System.Drawing.Point(432, 176)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(96, 21)
        Me.Label6.TabIndex = 2
        Me.Label6.Text = "Por unidad"
        Me.Label6.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'Label10
        '
        Me.Label10.Location = New System.Drawing.Point(432, 137)
        Me.Label10.Name = "Label10"
        Me.Label10.Size = New System.Drawing.Size(96, 21)
        Me.Label10.TabIndex = 2
        Me.Label10.Text = "Por unidad"
        Me.Label10.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'frmVentasMod
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(611, 500)
        Me.ControlBox = False
        Me.Controls.Add(Me.GroupBox)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.HelpProvider1.SetHelpNavigator(Me, System.Windows.Forms.HelpNavigator.Index)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "frmVentasMod"
        Me.HelpProvider1.SetShowHelp(Me, True)
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Ventas"
        Me.GroupBox.ResumeLayout(False)
        Me.GroupBox.PerformLayout()
        CType(Me.txtCantidad, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.dgMedicamentosPorVenta, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents GroupBox As System.Windows.Forms.GroupBox
    Friend WithEvents btnCancelar As System.Windows.Forms.Button
    Friend WithEvents btnAceptar As System.Windows.Forms.Button
    Friend WithEvents btnAgregarMedicamento As System.Windows.Forms.Button
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents cmbMedicamento As System.Windows.Forms.ComboBox
    Friend WithEvents cmbCliente As System.Windows.Forms.ComboBox
    Friend WithEvents txtPrecio As System.Windows.Forms.TextBox
    Friend WithEvents txtNroVenta As System.Windows.Forms.TextBox
    Friend WithEvents HelpProvider1 As System.Windows.Forms.HelpProvider
    Friend WithEvents lblPrecioE As System.Windows.Forms.Label
    Friend WithEvents lblclienteE As System.Windows.Forms.Label
    Friend WithEvents lblmedicamentoE As System.Windows.Forms.Label
    Friend WithEvents txtImporteTotal As System.Windows.Forms.TextBox
    Friend WithEvents Label9 As System.Windows.Forms.Label
    Friend WithEvents dgMedicamentosPorVenta As System.Windows.Forms.DataGridView
    Friend WithEvents NroMedicamento As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Medicamento As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Receta As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents CantVenta As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents PrecioVenta As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents gvBtnEliminarMedicamento As System.Windows.Forms.DataGridViewButtonColumn
    Friend WithEvents Eliminado As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents txtCantidad As System.Windows.Forms.NumericUpDown
    Friend WithEvents lblFechaHora As System.Windows.Forms.Label
    Friend WithEvents txtFechaHora As System.Windows.Forms.TextBox
    Friend WithEvents txtPrecioLista As System.Windows.Forms.TextBox
    Friend WithEvents txtDisponible As System.Windows.Forms.TextBox
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents Label10 As System.Windows.Forms.Label
    Friend WithEvents Label6 As System.Windows.Forms.Label
End Class
