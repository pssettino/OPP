﻿<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmBitacora))
        Me.btnlimpiar = New System.Windows.Forms.Button()
        Me.lblUsuario = New System.Windows.Forms.Label()
        Me.lblFechaHasta = New System.Windows.Forms.Label()
        Me.lblFechaDesde = New System.Windows.Forms.Label()
        Me.cmbUsuario = New System.Windows.Forms.ComboBox()
        Me.btnbuscar = New System.Windows.Forms.Button()
        Me.dgBitacora = New System.Windows.Forms.DataGridView()
        Me.id = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.usuario = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.descripcion = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.fecha_hora = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Criticidad = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.GroupBox = New System.Windows.Forms.GroupBox()
        Me.dtpFechaDesde = New System.Windows.Forms.DateTimePicker()
        Me.dtpFechaHasta = New System.Windows.Forms.DateTimePicker()
        Me.btnCancelar = New System.Windows.Forms.Button()
        Me.btnExportar = New System.Windows.Forms.Button()
        Me.cmbCriticidad = New System.Windows.Forms.ComboBox()
        Me.lblCriticidad = New System.Windows.Forms.Label()
        Me.HelpProvider1 = New System.Windows.Forms.HelpProvider()
        CType(Me.dgBitacora, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox.SuspendLayout()
        Me.SuspendLayout()
        '
        'btnlimpiar
        '
        Me.btnlimpiar.Location = New System.Drawing.Point(754, 22)
        Me.btnlimpiar.Name = "btnlimpiar"
        Me.btnlimpiar.Size = New System.Drawing.Size(127, 27)
        Me.btnlimpiar.TabIndex = 5
        Me.btnlimpiar.Text = "&Limpiar"
        Me.btnlimpiar.UseVisualStyleBackColor = True
        '
        'lblUsuario
        '
        Me.lblUsuario.Location = New System.Drawing.Point(20, 29)
        Me.lblUsuario.Name = "lblUsuario"
        Me.lblUsuario.Size = New System.Drawing.Size(67, 17)
        Me.lblUsuario.TabIndex = 25
        Me.lblUsuario.Text = "Usuario"
        Me.lblUsuario.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'lblFechaHasta
        '
        Me.lblFechaHasta.Location = New System.Drawing.Point(407, 57)
        Me.lblFechaHasta.Name = "lblFechaHasta"
        Me.lblFechaHasta.Size = New System.Drawing.Size(69, 17)
        Me.lblFechaHasta.TabIndex = 24
        Me.lblFechaHasta.Text = "Fecha hasta"
        Me.lblFechaHasta.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'lblFechaDesde
        '
        Me.lblFechaDesde.Location = New System.Drawing.Point(401, 29)
        Me.lblFechaDesde.Name = "lblFechaDesde"
        Me.lblFechaDesde.Size = New System.Drawing.Size(75, 18)
        Me.lblFechaDesde.TabIndex = 23
        Me.lblFechaDesde.Text = "Fecha desde"
        Me.lblFechaDesde.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'cmbUsuario
        '
        Me.cmbUsuario.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbUsuario.FormattingEnabled = True
        Me.cmbUsuario.Location = New System.Drawing.Point(93, 28)
        Me.cmbUsuario.Name = "cmbUsuario"
        Me.cmbUsuario.Size = New System.Drawing.Size(282, 21)
        Me.cmbUsuario.TabIndex = 0
        '
        'btnbuscar
        '
        Me.btnbuscar.Location = New System.Drawing.Point(621, 22)
        Me.btnbuscar.Name = "btnbuscar"
        Me.btnbuscar.Size = New System.Drawing.Size(127, 27)
        Me.btnbuscar.TabIndex = 4
        Me.btnbuscar.Text = "&Buscar"
        Me.btnbuscar.UseVisualStyleBackColor = True
        '
        'dgBitacora
        '
        Me.dgBitacora.AllowUserToAddRows = False
        Me.dgBitacora.AllowUserToDeleteRows = False
        Me.dgBitacora.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill
        Me.dgBitacora.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgBitacora.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.id, Me.usuario, Me.descripcion, Me.fecha_hora, Me.Criticidad})
        Me.dgBitacora.Location = New System.Drawing.Point(15, 94)
        Me.dgBitacora.Name = "dgBitacora"
        Me.dgBitacora.ReadOnly = True
        Me.dgBitacora.RowHeadersVisible = False
        Me.dgBitacora.Size = New System.Drawing.Size(866, 375)
        Me.dgBitacora.TabIndex = 19
        '
        'id
        '
        Me.id.HeaderText = "Id"
        Me.id.Name = "id"
        Me.id.ReadOnly = True
        '
        'usuario
        '
        Me.usuario.HeaderText = "Usuario"
        Me.usuario.Name = "usuario"
        Me.usuario.ReadOnly = True
        '
        'descripcion
        '
        Me.descripcion.FillWeight = 200.0!
        Me.descripcion.HeaderText = "Descripcion"
        Me.descripcion.Name = "descripcion"
        Me.descripcion.ReadOnly = True
        '
        'fecha_hora
        '
        Me.fecha_hora.FillWeight = 150.0!
        Me.fecha_hora.HeaderText = "Fecha y Hora"
        Me.fecha_hora.Name = "fecha_hora"
        Me.fecha_hora.ReadOnly = True
        '
        'Criticidad
        '
        Me.Criticidad.HeaderText = "Criticidad"
        Me.Criticidad.Name = "Criticidad"
        Me.Criticidad.ReadOnly = True
        '
        'GroupBox
        '
        Me.GroupBox.Controls.Add(Me.dtpFechaDesde)
        Me.GroupBox.Controls.Add(Me.dtpFechaHasta)
        Me.GroupBox.Controls.Add(Me.btnlimpiar)
        Me.GroupBox.Controls.Add(Me.dgBitacora)
        Me.GroupBox.Controls.Add(Me.btnCancelar)
        Me.GroupBox.Controls.Add(Me.btnExportar)
        Me.GroupBox.Controls.Add(Me.btnbuscar)
        Me.GroupBox.Controls.Add(Me.cmbCriticidad)
        Me.GroupBox.Controls.Add(Me.lblCriticidad)
        Me.GroupBox.Controls.Add(Me.cmbUsuario)
        Me.GroupBox.Controls.Add(Me.lblUsuario)
        Me.GroupBox.Controls.Add(Me.lblFechaDesde)
        Me.GroupBox.Controls.Add(Me.lblFechaHasta)
        Me.GroupBox.Location = New System.Drawing.Point(12, 12)
        Me.GroupBox.Name = "GroupBox"
        Me.GroupBox.Size = New System.Drawing.Size(903, 485)
        Me.GroupBox.TabIndex = 35
        Me.GroupBox.TabStop = False
        '
        'dtpFechaDesde
        '
        Me.dtpFechaDesde.Format = System.Windows.Forms.DateTimePickerFormat.[Short]
        Me.dtpFechaDesde.Location = New System.Drawing.Point(488, 28)
        Me.dtpFechaDesde.Name = "dtpFechaDesde"
        Me.dtpFechaDesde.Size = New System.Drawing.Size(117, 20)
        Me.dtpFechaDesde.TabIndex = 29
        '
        'dtpFechaHasta
        '
        Me.dtpFechaHasta.Format = System.Windows.Forms.DateTimePickerFormat.[Short]
        Me.dtpFechaHasta.Location = New System.Drawing.Point(488, 57)
        Me.dtpFechaHasta.Name = "dtpFechaHasta"
        Me.dtpFechaHasta.Size = New System.Drawing.Size(117, 20)
        Me.dtpFechaHasta.TabIndex = 28
        '
        'btnCancelar
        '
        Me.btnCancelar.Location = New System.Drawing.Point(754, 54)
        Me.btnCancelar.Name = "btnCancelar"
        Me.btnCancelar.Size = New System.Drawing.Size(127, 27)
        Me.btnCancelar.TabIndex = 4
        Me.btnCancelar.Text = "&Cancelar"
        Me.btnCancelar.UseVisualStyleBackColor = True
        '
        'btnExportar
        '
        Me.btnExportar.Location = New System.Drawing.Point(621, 55)
        Me.btnExportar.Name = "btnExportar"
        Me.btnExportar.Size = New System.Drawing.Size(127, 27)
        Me.btnExportar.TabIndex = 4
        Me.btnExportar.Text = "&Exportar"
        Me.btnExportar.UseVisualStyleBackColor = True
        '
        'cmbCriticidad
        '
        Me.cmbCriticidad.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbCriticidad.FormattingEnabled = True
        Me.cmbCriticidad.Location = New System.Drawing.Point(93, 56)
        Me.cmbCriticidad.Name = "cmbCriticidad"
        Me.cmbCriticidad.Size = New System.Drawing.Size(282, 21)
        Me.cmbCriticidad.TabIndex = 0
        '
        'lblCriticidad
        '
        Me.lblCriticidad.Location = New System.Drawing.Point(20, 55)
        Me.lblCriticidad.Name = "lblCriticidad"
        Me.lblCriticidad.Size = New System.Drawing.Size(62, 18)
        Me.lblCriticidad.TabIndex = 25
        Me.lblCriticidad.Text = "Criticidad"
        Me.lblCriticidad.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'HelpProvider1
        '
        Me.HelpProvider1.HelpNamespace = "C:\Users\Navegador\Desktop\SistemaFarmacia\SistemaFarmacia\farmacia.chm"
        '
        'frmBitacora
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.AutoSize = True
        Me.ClientSize = New System.Drawing.Size(921, 508)
        Me.ControlBox = False
        Me.Controls.Add(Me.GroupBox)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.HelpButton = True
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "frmBitacora"
        Me.HelpProvider1.SetShowHelp(Me, True)
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Bitacora"
        CType(Me.dgBitacora, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents btnlimpiar As System.Windows.Forms.Button
    Friend WithEvents lblUsuario As System.Windows.Forms.Label
    Friend WithEvents lblFechaHasta As System.Windows.Forms.Label
    Friend WithEvents lblFechaDesde As System.Windows.Forms.Label
    Friend WithEvents cmbUsuario As System.Windows.Forms.ComboBox
    Friend WithEvents btnbuscar As System.Windows.Forms.Button
    Friend WithEvents dgBitacora As System.Windows.Forms.DataGridView
    Friend WithEvents GroupBox As System.Windows.Forms.GroupBox
    Friend WithEvents btnCancelar As System.Windows.Forms.Button
    Friend WithEvents btnExportar As System.Windows.Forms.Button
    Friend WithEvents dtpFechaDesde As System.Windows.Forms.DateTimePicker
    Friend WithEvents dtpFechaHasta As System.Windows.Forms.DateTimePicker
    Friend WithEvents id As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents usuario As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents descripcion As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents fecha_hora As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Criticidad As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents cmbCriticidad As System.Windows.Forms.ComboBox
    Friend WithEvents lblCriticidad As System.Windows.Forms.Label
    Friend WithEvents HelpProvider1 As System.Windows.Forms.HelpProvider
End Class
