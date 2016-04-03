<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmPrincipal
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
        Me.MenuStrip1 = New System.Windows.Forms.MenuStrip()
        Me.ModuloClientesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ModuloVentasToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ModuloLibrosToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ModuloVendedoresToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ModuloReportesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ModuloSeguridadToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ContextMenuStrip1 = New System.Windows.Forms.ContextMenuStrip(Me.components)
        Me.ToolStripComboBox1 = New System.Windows.Forms.ToolStripComboBox()
        Me.MenuStrip1.SuspendLayout()
        Me.ContextMenuStrip1.SuspendLayout()
        Me.SuspendLayout()
        '
        'MenuStrip1
        '
        Me.MenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ModuloClientesToolStripMenuItem, Me.ModuloVentasToolStripMenuItem, Me.ModuloLibrosToolStripMenuItem, Me.ModuloVendedoresToolStripMenuItem, Me.ModuloReportesToolStripMenuItem, Me.ModuloSeguridadToolStripMenuItem})
        Me.MenuStrip1.Location = New System.Drawing.Point(0, 0)
        Me.MenuStrip1.Name = "MenuStrip1"
        Me.MenuStrip1.Size = New System.Drawing.Size(663, 24)
        Me.MenuStrip1.TabIndex = 0
        Me.MenuStrip1.Text = "MenuStrip1"
        '
        'ModuloClientesToolStripMenuItem
        '
        Me.ModuloClientesToolStripMenuItem.Name = "ModuloClientesToolStripMenuItem"
        Me.ModuloClientesToolStripMenuItem.Size = New System.Drawing.Size(106, 20)
        Me.ModuloClientesToolStripMenuItem.Text = "Modulo Clientes"
        '
        'ModuloVentasToolStripMenuItem
        '
        Me.ModuloVentasToolStripMenuItem.Name = "ModuloVentasToolStripMenuItem"
        Me.ModuloVentasToolStripMenuItem.Size = New System.Drawing.Size(99, 20)
        Me.ModuloVentasToolStripMenuItem.Text = "Modulo Ventas"
        '
        'ModuloLibrosToolStripMenuItem
        '
        Me.ModuloLibrosToolStripMenuItem.Name = "ModuloLibrosToolStripMenuItem"
        Me.ModuloLibrosToolStripMenuItem.Size = New System.Drawing.Size(96, 20)
        Me.ModuloLibrosToolStripMenuItem.Text = "Modulo Libros"
        '
        'ModuloVendedoresToolStripMenuItem
        '
        Me.ModuloVendedoresToolStripMenuItem.Name = "ModuloVendedoresToolStripMenuItem"
        Me.ModuloVendedoresToolStripMenuItem.Size = New System.Drawing.Size(126, 20)
        Me.ModuloVendedoresToolStripMenuItem.Text = "Modulo Vendedores"
        '
        'ModuloReportesToolStripMenuItem
        '
        Me.ModuloReportesToolStripMenuItem.Name = "ModuloReportesToolStripMenuItem"
        Me.ModuloReportesToolStripMenuItem.Size = New System.Drawing.Size(110, 20)
        Me.ModuloReportesToolStripMenuItem.Text = "Modulo Reportes"
        '
        'ModuloSeguridadToolStripMenuItem
        '
        Me.ModuloSeguridadToolStripMenuItem.Name = "ModuloSeguridadToolStripMenuItem"
        Me.ModuloSeguridadToolStripMenuItem.Size = New System.Drawing.Size(117, 20)
        Me.ModuloSeguridadToolStripMenuItem.Text = "Modulo Seguridad"
        '
        'ContextMenuStrip1
        '
        Me.ContextMenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolStripComboBox1})
        Me.ContextMenuStrip1.Name = "ContextMenuStrip1"
        Me.ContextMenuStrip1.Size = New System.Drawing.Size(182, 31)
        '
        'ToolStripComboBox1
        '
        Me.ToolStripComboBox1.Name = "ToolStripComboBox1"
        Me.ToolStripComboBox1.Size = New System.Drawing.Size(121, 23)
        '
        'frmPrincipal
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(663, 369)
        Me.Controls.Add(Me.MenuStrip1)
        Me.MainMenuStrip = Me.MenuStrip1
        Me.Name = "frmPrincipal"
        Me.Text = "EDICIONES FUTURO"
        Me.MenuStrip1.ResumeLayout(False)
        Me.MenuStrip1.PerformLayout()
        Me.ContextMenuStrip1.ResumeLayout(False)
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents MenuStrip1 As System.Windows.Forms.MenuStrip
    Friend WithEvents ModuloClientesToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ModuloVentasToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ModuloLibrosToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ModuloVendedoresToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ModuloReportesToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ModuloSeguridadToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ContextMenuStrip1 As System.Windows.Forms.ContextMenuStrip
    Friend WithEvents ToolStripComboBox1 As System.Windows.Forms.ToolStripComboBox
End Class
