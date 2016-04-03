<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmCliente
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
        Me.btnClieAlta = New System.Windows.Forms.Button()
        Me.btnCliebaja = New System.Windows.Forms.Button()
        Me.btnClieMod = New System.Windows.Forms.Button()
        Me.btnClieList = New System.Windows.Forms.Button()
        Me.dgclie = New System.Windows.Forms.DataGridView()
        Me.lblListadoClientes = New System.Windows.Forms.Label()
        Me.txtnom = New System.Windows.Forms.TextBox()
        Me.txtape = New System.Windows.Forms.TextBox()
        Me.txtdni = New System.Windows.Forms.TextBox()
        Me.txttel = New System.Windows.Forms.TextBox()
        Me.txtdir = New System.Windows.Forms.TextBox()
        Me.lblNom = New System.Windows.Forms.Label()
        Me.lblApe = New System.Windows.Forms.Label()
        Me.lblDni = New System.Windows.Forms.Label()
        Me.lbltel = New System.Windows.Forms.Label()
        Me.lbldir = New System.Windows.Forms.Label()
        Me.lblfec = New System.Windows.Forms.Label()
        Me.lblemail = New System.Windows.Forms.Label()
        Me.txtemail = New System.Windows.Forms.TextBox()
        Me.dtp = New System.Windows.Forms.DateTimePicker()
        CType(Me.dgclie, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'btnClieAlta
        '
        Me.btnClieAlta.Location = New System.Drawing.Point(21, 159)
        Me.btnClieAlta.Name = "btnClieAlta"
        Me.btnClieAlta.Size = New System.Drawing.Size(75, 23)
        Me.btnClieAlta.TabIndex = 0
        Me.btnClieAlta.Text = "Alta"
        Me.btnClieAlta.UseVisualStyleBackColor = True
        '
        'btnCliebaja
        '
        Me.btnCliebaja.Location = New System.Drawing.Point(129, 159)
        Me.btnCliebaja.Name = "btnCliebaja"
        Me.btnCliebaja.Size = New System.Drawing.Size(75, 23)
        Me.btnCliebaja.TabIndex = 1
        Me.btnCliebaja.Text = "Baja"
        Me.btnCliebaja.UseVisualStyleBackColor = True
        '
        'btnClieMod
        '
        Me.btnClieMod.Location = New System.Drawing.Point(231, 159)
        Me.btnClieMod.Name = "btnClieMod"
        Me.btnClieMod.Size = New System.Drawing.Size(75, 23)
        Me.btnClieMod.TabIndex = 2
        Me.btnClieMod.Text = "Modificar"
        Me.btnClieMod.UseVisualStyleBackColor = True
        '
        'btnClieList
        '
        Me.btnClieList.Location = New System.Drawing.Point(330, 159)
        Me.btnClieList.Name = "btnClieList"
        Me.btnClieList.Size = New System.Drawing.Size(75, 23)
        Me.btnClieList.TabIndex = 3
        Me.btnClieList.Text = "Listar"
        Me.btnClieList.UseVisualStyleBackColor = True
        '
        'dgclie
        '
        Me.dgclie.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill
        Me.dgclie.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgclie.Location = New System.Drawing.Point(23, 231)
        Me.dgclie.Name = "dgclie"
        Me.dgclie.RowTemplate.Resizable = System.Windows.Forms.DataGridViewTriState.[True]
        Me.dgclie.Size = New System.Drawing.Size(1084, 467)
        Me.dgclie.TabIndex = 4
        '
        'lblListadoClientes
        '
        Me.lblListadoClientes.AutoSize = True
        Me.lblListadoClientes.Location = New System.Drawing.Point(20, 203)
        Me.lblListadoClientes.Name = "lblListadoClientes"
        Me.lblListadoClientes.Size = New System.Drawing.Size(81, 13)
        Me.lblListadoClientes.TabIndex = 5
        Me.lblListadoClientes.Text = "Listado Clientes"
        '
        'txtnom
        '
        Me.txtnom.Location = New System.Drawing.Point(90, 12)
        Me.txtnom.Name = "txtnom"
        Me.txtnom.Size = New System.Drawing.Size(75, 20)
        Me.txtnom.TabIndex = 6
        '
        'txtape
        '
        Me.txtape.Location = New System.Drawing.Point(90, 38)
        Me.txtape.Name = "txtape"
        Me.txtape.Size = New System.Drawing.Size(75, 20)
        Me.txtape.TabIndex = 7
        '
        'txtdni
        '
        Me.txtdni.Location = New System.Drawing.Point(90, 64)
        Me.txtdni.Name = "txtdni"
        Me.txtdni.Size = New System.Drawing.Size(75, 20)
        Me.txtdni.TabIndex = 8
        '
        'txttel
        '
        Me.txttel.Location = New System.Drawing.Point(90, 90)
        Me.txttel.Name = "txttel"
        Me.txttel.Size = New System.Drawing.Size(75, 20)
        Me.txttel.TabIndex = 9
        '
        'txtdir
        '
        Me.txtdir.Location = New System.Drawing.Point(90, 116)
        Me.txtdir.Name = "txtdir"
        Me.txtdir.Size = New System.Drawing.Size(75, 20)
        Me.txtdir.TabIndex = 10
        '
        'lblNom
        '
        Me.lblNom.AutoSize = True
        Me.lblNom.Location = New System.Drawing.Point(22, 17)
        Me.lblNom.Name = "lblNom"
        Me.lblNom.Size = New System.Drawing.Size(44, 13)
        Me.lblNom.TabIndex = 11
        Me.lblNom.Text = "Nombre"
        '
        'lblApe
        '
        Me.lblApe.AutoSize = True
        Me.lblApe.Location = New System.Drawing.Point(24, 45)
        Me.lblApe.Name = "lblApe"
        Me.lblApe.Size = New System.Drawing.Size(44, 13)
        Me.lblApe.TabIndex = 12
        Me.lblApe.Text = "Apellido"
        '
        'lblDni
        '
        Me.lblDni.AutoSize = True
        Me.lblDni.Location = New System.Drawing.Point(24, 71)
        Me.lblDni.Name = "lblDni"
        Me.lblDni.Size = New System.Drawing.Size(23, 13)
        Me.lblDni.TabIndex = 13
        Me.lblDni.Text = "Dni"
        '
        'lbltel
        '
        Me.lbltel.AutoSize = True
        Me.lbltel.Location = New System.Drawing.Point(24, 97)
        Me.lbltel.Name = "lbltel"
        Me.lbltel.Size = New System.Drawing.Size(49, 13)
        Me.lbltel.TabIndex = 14
        Me.lbltel.Text = "Telefono"
        '
        'lbldir
        '
        Me.lbldir.AutoSize = True
        Me.lbldir.Location = New System.Drawing.Point(27, 122)
        Me.lbldir.Name = "lbldir"
        Me.lbldir.Size = New System.Drawing.Size(52, 13)
        Me.lbldir.TabIndex = 15
        Me.lbldir.Text = "Direccion"
        '
        'lblfec
        '
        Me.lblfec.AutoSize = True
        Me.lblfec.Location = New System.Drawing.Point(228, 17)
        Me.lblfec.Name = "lblfec"
        Me.lblfec.Size = New System.Drawing.Size(37, 13)
        Me.lblfec.TabIndex = 16
        Me.lblfec.Text = "Fecha"
        '
        'lblemail
        '
        Me.lblemail.AutoSize = True
        Me.lblemail.Location = New System.Drawing.Point(228, 45)
        Me.lblemail.Name = "lblemail"
        Me.lblemail.Size = New System.Drawing.Size(32, 13)
        Me.lblemail.TabIndex = 17
        Me.lblemail.Text = "Email"
        '
        'txtemail
        '
        Me.txtemail.Location = New System.Drawing.Point(271, 42)
        Me.txtemail.Name = "txtemail"
        Me.txtemail.Size = New System.Drawing.Size(75, 20)
        Me.txtemail.TabIndex = 18
        '
        'dtp
        '
        Me.dtp.Location = New System.Drawing.Point(271, 12)
        Me.dtp.Name = "dtp"
        Me.dtp.Size = New System.Drawing.Size(200, 20)
        Me.dtp.TabIndex = 24
        '
        'frmCliente
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(1008, 710)
        Me.Controls.Add(Me.dtp)
        Me.Controls.Add(Me.txtemail)
        Me.Controls.Add(Me.lblemail)
        Me.Controls.Add(Me.lblfec)
        Me.Controls.Add(Me.lbldir)
        Me.Controls.Add(Me.lbltel)
        Me.Controls.Add(Me.lblDni)
        Me.Controls.Add(Me.lblApe)
        Me.Controls.Add(Me.lblNom)
        Me.Controls.Add(Me.txtdir)
        Me.Controls.Add(Me.txttel)
        Me.Controls.Add(Me.txtdni)
        Me.Controls.Add(Me.txtape)
        Me.Controls.Add(Me.txtnom)
        Me.Controls.Add(Me.lblListadoClientes)
        Me.Controls.Add(Me.dgclie)
        Me.Controls.Add(Me.btnClieList)
        Me.Controls.Add(Me.btnClieMod)
        Me.Controls.Add(Me.btnCliebaja)
        Me.Controls.Add(Me.btnClieAlta)
        Me.KeyPreview = True
        Me.Name = "frmCliente"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.WindowsDefaultBounds
        Me.Text = "Modulo Clientes"
        Me.WindowState = System.Windows.Forms.FormWindowState.Maximized
        CType(Me.dgclie, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents btnClieAlta As System.Windows.Forms.Button
    Friend WithEvents btnCliebaja As System.Windows.Forms.Button
    Friend WithEvents btnClieMod As System.Windows.Forms.Button
    Friend WithEvents btnClieList As System.Windows.Forms.Button
    Friend WithEvents dgclie As System.Windows.Forms.DataGridView
    Friend WithEvents lblListadoClientes As System.Windows.Forms.Label
    Friend WithEvents txtnom As System.Windows.Forms.TextBox
    Friend WithEvents txtape As System.Windows.Forms.TextBox
    Friend WithEvents txtdni As System.Windows.Forms.TextBox
    Friend WithEvents txttel As System.Windows.Forms.TextBox
    Friend WithEvents txtdir As System.Windows.Forms.TextBox
    Friend WithEvents lblNom As System.Windows.Forms.Label
    Friend WithEvents lblApe As System.Windows.Forms.Label
    Friend WithEvents lblDni As System.Windows.Forms.Label
    Friend WithEvents lbltel As System.Windows.Forms.Label
    Friend WithEvents lbldir As System.Windows.Forms.Label
    Friend WithEvents lblfec As System.Windows.Forms.Label
    Friend WithEvents lblemail As System.Windows.Forms.Label
    Friend WithEvents txtemail As System.Windows.Forms.TextBox
    Friend WithEvents dtp As System.Windows.Forms.DateTimePicker
End Class
