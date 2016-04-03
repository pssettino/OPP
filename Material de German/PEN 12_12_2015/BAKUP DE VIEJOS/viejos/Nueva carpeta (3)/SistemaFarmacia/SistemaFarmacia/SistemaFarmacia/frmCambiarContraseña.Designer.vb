<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmCambiarContraseña
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmCambiarContraseña))
        Me.lblNuevaContraseña = New System.Windows.Forms.Label()
        Me.lblContraseñaAnterior = New System.Windows.Forms.Label()
        Me.txtContraseñaNueva = New System.Windows.Forms.TextBox()
        Me.txtContraseñaAnterior = New System.Windows.Forms.TextBox()
        Me.txtContraseñaConfirmar = New System.Windows.Forms.TextBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.lblConfirmarContraseña = New System.Windows.Forms.Label()
        Me.btnCancelar = New System.Windows.Forms.Button()
        Me.btnAceptar = New System.Windows.Forms.Button()
        Me.GroupBox = New System.Windows.Forms.GroupBox()
        Me.lblConfirmarContresañaE = New System.Windows.Forms.Label()
        Me.lblContraseñaNuevaE = New System.Windows.Forms.Label()
        Me.lblContraseñaAnteriorE = New System.Windows.Forms.Label()
        Me.HelpProvider1 = New System.Windows.Forms.HelpProvider()
        Me.GroupBox.SuspendLayout()
        Me.SuspendLayout()
        '
        'lblNuevaContraseña
        '
        resources.ApplyResources(Me.lblNuevaContraseña, "lblNuevaContraseña")
        Me.lblNuevaContraseña.Name = "lblNuevaContraseña"
        '
        'lblContraseñaAnterior
        '
        resources.ApplyResources(Me.lblContraseñaAnterior, "lblContraseñaAnterior")
        Me.lblContraseñaAnterior.Name = "lblContraseñaAnterior"
        '
        'txtContraseñaNueva
        '
        resources.ApplyResources(Me.txtContraseñaNueva, "txtContraseñaNueva")
        Me.txtContraseñaNueva.Name = "txtContraseñaNueva"
        '
        'txtContraseñaAnterior
        '
        resources.ApplyResources(Me.txtContraseñaAnterior, "txtContraseñaAnterior")
        Me.txtContraseñaAnterior.Name = "txtContraseñaAnterior"
        '
        'txtContraseñaConfirmar
        '
        resources.ApplyResources(Me.txtContraseñaConfirmar, "txtContraseñaConfirmar")
        Me.txtContraseñaConfirmar.Name = "txtContraseñaConfirmar"
        '
        'Label3
        '
        resources.ApplyResources(Me.Label3, "Label3")
        Me.Label3.Name = "Label3"
        '
        'lblConfirmarContraseña
        '
        resources.ApplyResources(Me.lblConfirmarContraseña, "lblConfirmarContraseña")
        Me.lblConfirmarContraseña.Name = "lblConfirmarContraseña"
        '
        'btnCancelar
        '
        Me.btnCancelar.DialogResult = System.Windows.Forms.DialogResult.Cancel
        resources.ApplyResources(Me.btnCancelar, "btnCancelar")
        Me.btnCancelar.Name = "btnCancelar"
        '
        'btnAceptar
        '
        resources.ApplyResources(Me.btnAceptar, "btnAceptar")
        Me.btnAceptar.Name = "btnAceptar"
        '
        'GroupBox
        '
        Me.GroupBox.Controls.Add(Me.lblConfirmarContresañaE)
        Me.GroupBox.Controls.Add(Me.lblContraseñaNuevaE)
        Me.GroupBox.Controls.Add(Me.lblContraseñaAnteriorE)
        Me.GroupBox.Controls.Add(Me.txtContraseñaAnterior)
        Me.GroupBox.Controls.Add(Me.btnCancelar)
        Me.GroupBox.Controls.Add(Me.txtContraseñaNueva)
        Me.GroupBox.Controls.Add(Me.btnAceptar)
        Me.GroupBox.Controls.Add(Me.txtContraseñaConfirmar)
        Me.GroupBox.Controls.Add(Me.Label3)
        Me.GroupBox.Controls.Add(Me.lblContraseñaAnterior)
        Me.GroupBox.Controls.Add(Me.lblConfirmarContraseña)
        Me.GroupBox.Controls.Add(Me.lblNuevaContraseña)
        resources.ApplyResources(Me.GroupBox, "GroupBox")
        Me.GroupBox.Name = "GroupBox"
        Me.GroupBox.TabStop = False
        '
        'lblConfirmarContresañaE
        '
        resources.ApplyResources(Me.lblConfirmarContresañaE, "lblConfirmarContresañaE")
        Me.lblConfirmarContresañaE.ForeColor = System.Drawing.Color.Red
        Me.lblConfirmarContresañaE.Name = "lblConfirmarContresañaE"
        '
        'lblContraseñaNuevaE
        '
        resources.ApplyResources(Me.lblContraseñaNuevaE, "lblContraseñaNuevaE")
        Me.lblContraseñaNuevaE.ForeColor = System.Drawing.Color.Red
        Me.lblContraseñaNuevaE.Name = "lblContraseñaNuevaE"
        '
        'lblContraseñaAnteriorE
        '
        resources.ApplyResources(Me.lblContraseñaAnteriorE, "lblContraseñaAnteriorE")
        Me.lblContraseñaAnteriorE.ForeColor = System.Drawing.Color.Red
        Me.lblContraseñaAnteriorE.Name = "lblContraseñaAnteriorE"
        Me.HelpProvider1.SetShowHelp(Me.lblContraseñaAnteriorE, CType(resources.GetObject("lblContraseñaAnteriorE.ShowHelp"), Boolean))
        '
        'HelpProvider1
        '
        resources.ApplyResources(Me.HelpProvider1, "HelpProvider1")
        '
        'frmCambiarContraseña
        '
        resources.ApplyResources(Me, "$this")
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ControlBox = False
        Me.Controls.Add(Me.GroupBox)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "frmCambiarContraseña"
        Me.HelpProvider1.SetShowHelp(Me, CType(resources.GetObject("$this.ShowHelp"), Boolean))
        Me.GroupBox.ResumeLayout(False)
        Me.GroupBox.PerformLayout()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents lblNuevaContraseña As System.Windows.Forms.Label
    Friend WithEvents lblContraseñaAnterior As System.Windows.Forms.Label
    Friend WithEvents txtContraseñaNueva As System.Windows.Forms.TextBox
    Friend WithEvents txtContraseñaAnterior As System.Windows.Forms.TextBox
    Friend WithEvents txtContraseñaConfirmar As System.Windows.Forms.TextBox
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents lblConfirmarContraseña As System.Windows.Forms.Label
    Friend WithEvents btnCancelar As System.Windows.Forms.Button
    Friend WithEvents btnAceptar As System.Windows.Forms.Button
    Friend WithEvents GroupBox As System.Windows.Forms.GroupBox
    Friend WithEvents HelpProvider1 As System.Windows.Forms.HelpProvider
    Friend WithEvents lblConfirmarContresañaE As System.Windows.Forms.Label
    Friend WithEvents lblContraseñaNuevaE As System.Windows.Forms.Label
    Friend WithEvents lblContraseñaAnteriorE As System.Windows.Forms.Label
End Class
