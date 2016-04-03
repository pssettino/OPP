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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmPrincipal))
        Me.MenuStrip1 = New System.Windows.Forms.MenuStrip()
        Me.ModuloClientesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ModuloVentasToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ModuloLibrosToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ModuloVendedoresToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ModuloReportesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ClientesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.SaldoSumatoriaToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ClientesBorradosToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.BitacoraToolStripMenuItem1 = New System.Windows.Forms.ToolStripMenuItem()
        Me.CriticidadAltaToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ReporteVentasToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.StockToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ModuloSeguridadToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.UsuariosToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ABMToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.CambiarClaveToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.BitacoraToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.FamiliaToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.UsuariosToolStripMenuItem1 = New System.Windows.Forms.ToolStripMenuItem()
        Me.FamilaPatenteToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.BackupRestoreToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.BackupToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItem1 = New System.Windows.Forms.ToolStripMenuItem()
        Me.CambiarIdiomaToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.EspanolToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.InglesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.RecuperarIntegridadToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.SalirToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ContextMenuStrip1 = New System.Windows.Forms.ContextMenuStrip(Me.components)
        Me.ToolStripComboBox1 = New System.Windows.Forms.ToolStripComboBox()
        Me.PrintPreviewDialog1 = New System.Windows.Forms.PrintPreviewDialog()
        Me.ErrorProvider1 = New System.Windows.Forms.ErrorProvider(Me.components)
        Me.MenuStrip1.SuspendLayout()
        Me.ContextMenuStrip1.SuspendLayout()
        CType(Me.ErrorProvider1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'MenuStrip1
        '
        Me.MenuStrip1.BackColor = System.Drawing.SystemColors.Control
        Me.MenuStrip1.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.MenuStrip1.ImeMode = System.Windows.Forms.ImeMode.NoControl
        Me.MenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ModuloClientesToolStripMenuItem, Me.ModuloVentasToolStripMenuItem, Me.ModuloLibrosToolStripMenuItem, Me.ModuloVendedoresToolStripMenuItem, Me.ModuloReportesToolStripMenuItem, Me.ModuloSeguridadToolStripMenuItem, Me.SalirToolStripMenuItem})
        Me.MenuStrip1.Location = New System.Drawing.Point(0, 0)
        Me.MenuStrip1.Name = "MenuStrip1"
        Me.MenuStrip1.Padding = New System.Windows.Forms.Padding(8, 2, 0, 2)
        Me.MenuStrip1.RenderMode = System.Windows.Forms.ToolStripRenderMode.Professional
        Me.MenuStrip1.Size = New System.Drawing.Size(1019, 24)
        Me.MenuStrip1.TabIndex = 0
        Me.MenuStrip1.Text = "MenuStrip1"
        '
        'ModuloClientesToolStripMenuItem
        '
        Me.ModuloClientesToolStripMenuItem.Image = Global.UI.My.Resources.Resources.desbloqeo1
        Me.ModuloClientesToolStripMenuItem.Name = "ModuloClientesToolStripMenuItem"
        Me.ModuloClientesToolStripMenuItem.ShortcutKeys = CType((System.Windows.Forms.Keys.Control Or System.Windows.Forms.Keys.C), System.Windows.Forms.Keys)
        Me.ModuloClientesToolStripMenuItem.Size = New System.Drawing.Size(125, 20)
        Me.ModuloClientesToolStripMenuItem.Text = "Modulo Clientes"
        '
        'ModuloVentasToolStripMenuItem
        '
        Me.ModuloVentasToolStripMenuItem.BackColor = System.Drawing.SystemColors.Control
        Me.ModuloVentasToolStripMenuItem.Name = "ModuloVentasToolStripMenuItem"
        Me.ModuloVentasToolStripMenuItem.ShortcutKeys = CType((System.Windows.Forms.Keys.Control Or System.Windows.Forms.Keys.V), System.Windows.Forms.Keys)
        Me.ModuloVentasToolStripMenuItem.Size = New System.Drawing.Size(101, 20)
        Me.ModuloVentasToolStripMenuItem.Text = "Modulo Ventas"
        '
        'ModuloLibrosToolStripMenuItem
        '
        Me.ModuloLibrosToolStripMenuItem.Checked = True
        Me.ModuloLibrosToolStripMenuItem.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ModuloLibrosToolStripMenuItem.Image = Global.UI.My.Resources.Resources.Bitacora
        Me.ModuloLibrosToolStripMenuItem.Name = "ModuloLibrosToolStripMenuItem"
        Me.ModuloLibrosToolStripMenuItem.Size = New System.Drawing.Size(115, 20)
        Me.ModuloLibrosToolStripMenuItem.Text = "Modulo Libros"
        '
        'ModuloVendedoresToolStripMenuItem
        '
        Me.ModuloVendedoresToolStripMenuItem.Name = "ModuloVendedoresToolStripMenuItem"
        Me.ModuloVendedoresToolStripMenuItem.Size = New System.Drawing.Size(131, 20)
        Me.ModuloVendedoresToolStripMenuItem.Text = "Modulo Vendedores"
        '
        'ModuloReportesToolStripMenuItem
        '
        Me.ModuloReportesToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ClientesToolStripMenuItem, Me.BitacoraToolStripMenuItem1, Me.ReporteVentasToolStripMenuItem})
        Me.ModuloReportesToolStripMenuItem.Name = "ModuloReportesToolStripMenuItem"
        Me.ModuloReportesToolStripMenuItem.Size = New System.Drawing.Size(114, 20)
        Me.ModuloReportesToolStripMenuItem.Text = "Modulo Reportes"
        '
        'ClientesToolStripMenuItem
        '
        Me.ClientesToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.SaldoSumatoriaToolStripMenuItem, Me.ClientesBorradosToolStripMenuItem})
        Me.ClientesToolStripMenuItem.Name = "ClientesToolStripMenuItem"
        Me.ClientesToolStripMenuItem.Size = New System.Drawing.Size(174, 22)
        Me.ClientesToolStripMenuItem.Text = "Reportes Clientes"
        '
        'SaldoSumatoriaToolStripMenuItem
        '
        Me.SaldoSumatoriaToolStripMenuItem.Name = "SaldoSumatoriaToolStripMenuItem"
        Me.SaldoSumatoriaToolStripMenuItem.Size = New System.Drawing.Size(174, 22)
        Me.SaldoSumatoriaToolStripMenuItem.Text = "Sumatoria Saldos"
        '
        'ClientesBorradosToolStripMenuItem
        '
        Me.ClientesBorradosToolStripMenuItem.Name = "ClientesBorradosToolStripMenuItem"
        Me.ClientesBorradosToolStripMenuItem.Size = New System.Drawing.Size(174, 22)
        Me.ClientesBorradosToolStripMenuItem.Text = "Clientes Borrados"
        '
        'BitacoraToolStripMenuItem1
        '
        Me.BitacoraToolStripMenuItem1.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.CriticidadAltaToolStripMenuItem})
        Me.BitacoraToolStripMenuItem1.Name = "BitacoraToolStripMenuItem1"
        Me.BitacoraToolStripMenuItem1.Size = New System.Drawing.Size(174, 22)
        Me.BitacoraToolStripMenuItem1.Text = "Reportes Bitacora"
        '
        'CriticidadAltaToolStripMenuItem
        '
        Me.CriticidadAltaToolStripMenuItem.Name = "CriticidadAltaToolStripMenuItem"
        Me.CriticidadAltaToolStripMenuItem.Size = New System.Drawing.Size(150, 22)
        Me.CriticidadAltaToolStripMenuItem.Text = "Criticidad Alta"
        '
        'ReporteVentasToolStripMenuItem
        '
        Me.ReporteVentasToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.StockToolStripMenuItem})
        Me.ReporteVentasToolStripMenuItem.Name = "ReporteVentasToolStripMenuItem"
        Me.ReporteVentasToolStripMenuItem.Size = New System.Drawing.Size(174, 22)
        Me.ReporteVentasToolStripMenuItem.Text = "Reporte Libros"
        '
        'StockToolStripMenuItem
        '
        Me.StockToolStripMenuItem.Name = "StockToolStripMenuItem"
        Me.StockToolStripMenuItem.Size = New System.Drawing.Size(105, 22)
        Me.StockToolStripMenuItem.Text = "Stock"
        '
        'ModuloSeguridadToolStripMenuItem
        '
        Me.ModuloSeguridadToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.UsuariosToolStripMenuItem, Me.BitacoraToolStripMenuItem, Me.FamiliaToolStripMenuItem, Me.BackupRestoreToolStripMenuItem, Me.CambiarIdiomaToolStripMenuItem, Me.RecuperarIntegridadToolStripMenuItem})
        Me.ModuloSeguridadToolStripMenuItem.Image = Global.UI.My.Resources.Resources.desbloqeo
        Me.ModuloSeguridadToolStripMenuItem.Name = "ModuloSeguridadToolStripMenuItem"
        Me.ModuloSeguridadToolStripMenuItem.Size = New System.Drawing.Size(135, 20)
        Me.ModuloSeguridadToolStripMenuItem.Text = "Modulo Seguridad"
        '
        'UsuariosToolStripMenuItem
        '
        Me.UsuariosToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ABMToolStripMenuItem, Me.CambiarClaveToolStripMenuItem})
        Me.UsuariosToolStripMenuItem.Name = "UsuariosToolStripMenuItem"
        Me.UsuariosToolStripMenuItem.Size = New System.Drawing.Size(190, 22)
        Me.UsuariosToolStripMenuItem.Text = "Usuarios"
        '
        'ABMToolStripMenuItem
        '
        Me.ABMToolStripMenuItem.Name = "ABMToolStripMenuItem"
        Me.ABMToolStripMenuItem.Size = New System.Drawing.Size(153, 22)
        Me.ABMToolStripMenuItem.Text = "ABM"
        '
        'CambiarClaveToolStripMenuItem
        '
        Me.CambiarClaveToolStripMenuItem.Name = "CambiarClaveToolStripMenuItem"
        Me.CambiarClaveToolStripMenuItem.Size = New System.Drawing.Size(153, 22)
        Me.CambiarClaveToolStripMenuItem.Text = "Cambiar Clave"
        '
        'BitacoraToolStripMenuItem
        '
        Me.BitacoraToolStripMenuItem.Name = "BitacoraToolStripMenuItem"
        Me.BitacoraToolStripMenuItem.Size = New System.Drawing.Size(190, 22)
        Me.BitacoraToolStripMenuItem.Text = "Bitacora"
        '
        'FamiliaToolStripMenuItem
        '
        Me.FamiliaToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.UsuariosToolStripMenuItem1, Me.FamilaPatenteToolStripMenuItem})
        Me.FamiliaToolStripMenuItem.Name = "FamiliaToolStripMenuItem"
        Me.FamiliaToolStripMenuItem.Size = New System.Drawing.Size(190, 22)
        Me.FamiliaToolStripMenuItem.Text = "Permisos"
        '
        'UsuariosToolStripMenuItem1
        '
        Me.UsuariosToolStripMenuItem1.Name = "UsuariosToolStripMenuItem1"
        Me.UsuariosToolStripMenuItem1.Size = New System.Drawing.Size(155, 22)
        Me.UsuariosToolStripMenuItem1.Text = "Usuarios"
        '
        'FamilaPatenteToolStripMenuItem
        '
        Me.FamilaPatenteToolStripMenuItem.Name = "FamilaPatenteToolStripMenuItem"
        Me.FamilaPatenteToolStripMenuItem.Size = New System.Drawing.Size(155, 22)
        Me.FamilaPatenteToolStripMenuItem.Text = "Famila-Patente"
        '
        'BackupRestoreToolStripMenuItem
        '
        Me.BackupRestoreToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.BackupToolStripMenuItem, Me.ToolStripMenuItem1})
        Me.BackupRestoreToolStripMenuItem.Name = "BackupRestoreToolStripMenuItem"
        Me.BackupRestoreToolStripMenuItem.Size = New System.Drawing.Size(190, 22)
        Me.BackupRestoreToolStripMenuItem.Text = "Backup and Restore"
        '
        'BackupToolStripMenuItem
        '
        Me.BackupToolStripMenuItem.Name = "BackupToolStripMenuItem"
        Me.BackupToolStripMenuItem.Size = New System.Drawing.Size(118, 22)
        Me.BackupToolStripMenuItem.Text = "Backup"
        '
        'ToolStripMenuItem1
        '
        Me.ToolStripMenuItem1.Name = "ToolStripMenuItem1"
        Me.ToolStripMenuItem1.Size = New System.Drawing.Size(118, 22)
        Me.ToolStripMenuItem1.Text = "Restore"
        '
        'CambiarIdiomaToolStripMenuItem
        '
        Me.CambiarIdiomaToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.EspanolToolStripMenuItem, Me.InglesToolStripMenuItem})
        Me.CambiarIdiomaToolStripMenuItem.Name = "CambiarIdiomaToolStripMenuItem"
        Me.CambiarIdiomaToolStripMenuItem.Size = New System.Drawing.Size(190, 22)
        Me.CambiarIdiomaToolStripMenuItem.Text = "Cambiar Idioma"
        '
        'EspanolToolStripMenuItem
        '
        Me.EspanolToolStripMenuItem.Name = "EspanolToolStripMenuItem"
        Me.EspanolToolStripMenuItem.Size = New System.Drawing.Size(117, 22)
        Me.EspanolToolStripMenuItem.Text = "Espanol"
        '
        'InglesToolStripMenuItem
        '
        Me.InglesToolStripMenuItem.Name = "InglesToolStripMenuItem"
        Me.InglesToolStripMenuItem.Size = New System.Drawing.Size(117, 22)
        Me.InglesToolStripMenuItem.Text = "Ingles"
        '
        'RecuperarIntegridadToolStripMenuItem
        '
        Me.RecuperarIntegridadToolStripMenuItem.Name = "RecuperarIntegridadToolStripMenuItem"
        Me.RecuperarIntegridadToolStripMenuItem.Size = New System.Drawing.Size(190, 22)
        Me.RecuperarIntegridadToolStripMenuItem.Text = "Recuperar Integridad"
        '
        'SalirToolStripMenuItem
        '
        Me.SalirToolStripMenuItem.Name = "SalirToolStripMenuItem"
        Me.SalirToolStripMenuItem.Size = New System.Drawing.Size(43, 20)
        Me.SalirToolStripMenuItem.Text = "Salir"
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
        'PrintPreviewDialog1
        '
        Me.PrintPreviewDialog1.AutoScrollMargin = New System.Drawing.Size(0, 0)
        Me.PrintPreviewDialog1.AutoScrollMinSize = New System.Drawing.Size(0, 0)
        Me.PrintPreviewDialog1.ClientSize = New System.Drawing.Size(400, 300)
        Me.PrintPreviewDialog1.Enabled = True
        Me.PrintPreviewDialog1.Icon = CType(resources.GetObject("PrintPreviewDialog1.Icon"), System.Drawing.Icon)
        Me.PrintPreviewDialog1.Name = "PrintPreviewDialog1"
        Me.PrintPreviewDialog1.Visible = False
        '
        'ErrorProvider1
        '
        Me.ErrorProvider1.ContainerControl = Me
        '
        'frmPrincipal
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Image)
        Me.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Zoom
        Me.ClientSize = New System.Drawing.Size(1019, 574)
        Me.Controls.Add(Me.MenuStrip1)
        Me.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.MainMenuStrip = Me.MenuStrip1
        Me.Margin = New System.Windows.Forms.Padding(4)
        Me.Name = "frmPrincipal"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Ediciones Futuro"
        Me.WindowState = System.Windows.Forms.FormWindowState.Maximized
        Me.MenuStrip1.ResumeLayout(False)
        Me.MenuStrip1.PerformLayout()
        Me.ContextMenuStrip1.ResumeLayout(False)
        CType(Me.ErrorProvider1, System.ComponentModel.ISupportInitialize).EndInit()
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
    Friend WithEvents PrintPreviewDialog1 As System.Windows.Forms.PrintPreviewDialog
    Friend WithEvents ErrorProvider1 As System.Windows.Forms.ErrorProvider
    Friend WithEvents UsuariosToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents BitacoraToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ABMToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents CambiarClaveToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents FamiliaToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents BackupRestoreToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents CambiarIdiomaToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents SalirToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents EspanolToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents InglesToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents RecuperarIntegridadToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ClientesToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents UsuariosToolStripMenuItem1 As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents FamilaPatenteToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents BackupToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ToolStripMenuItem1 As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents SaldoSumatoriaToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents BitacoraToolStripMenuItem1 As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents CriticidadAltaToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ClientesBorradosToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ReporteVentasToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents StockToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
End Class
