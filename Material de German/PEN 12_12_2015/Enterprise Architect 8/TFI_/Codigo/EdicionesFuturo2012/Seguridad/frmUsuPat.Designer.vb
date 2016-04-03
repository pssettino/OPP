<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmUsuPat
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
        Me.lstPatAsignadas = New System.Windows.Forms.ListBox()
        Me.lstPatDisponibles = New System.Windows.Forms.ListBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.cmbUsu = New System.Windows.Forms.ComboBox()
        Me.Button4 = New System.Windows.Forms.Button()
        Me.lstPatNegadas = New System.Windows.Forms.ListBox()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.btnAsignarAsig = New System.Windows.Forms.Button()
        Me.btnNegar = New System.Windows.Forms.Button()
        Me.lstFamDisp = New System.Windows.Forms.ListBox()
        Me.lstFamAsig = New System.Windows.Forms.ListBox()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.Button3 = New System.Windows.Forms.Button()
        Me.Button5 = New System.Windows.Forms.Button()
        Me.QuitarPatNeg = New System.Windows.Forms.Button()
        Me.QuitarPatAsi = New System.Windows.Forms.Button()
        Me.SuspendLayout()
        '
        'lstPatAsignadas
        '
        Me.lstPatAsignadas.FormattingEnabled = True
        Me.lstPatAsignadas.Location = New System.Drawing.Point(589, 47)
        Me.lstPatAsignadas.Name = "lstPatAsignadas"
        Me.lstPatAsignadas.Size = New System.Drawing.Size(120, 225)
        Me.lstPatAsignadas.TabIndex = 15
        '
        'lstPatDisponibles
        '
        Me.lstPatDisponibles.FormattingEnabled = True
        Me.lstPatDisponibles.Location = New System.Drawing.Point(401, 47)
        Me.lstPatDisponibles.Name = "lstPatDisponibles"
        Me.lstPatDisponibles.Size = New System.Drawing.Size(120, 225)
        Me.lstPatDisponibles.TabIndex = 14
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.Location = New System.Drawing.Point(588, 25)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(121, 15)
        Me.Label2.TabIndex = 13
        Me.Label2.Text = "Patentes Asignadas"
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.Location = New System.Drawing.Point(32, 16)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(51, 18)
        Me.Label1.TabIndex = 12
        Me.Label1.Text = "Usuario"
        Me.Label1.UseCompatibleTextRendering = True
        '
        'Button2
        '
        Me.Button2.Location = New System.Drawing.Point(34, 113)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(126, 40)
        Me.Button2.TabIndex = 10
        Me.Button2.Text = "Familias - Patentes"
        Me.Button2.UseVisualStyleBackColor = True
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.Location = New System.Drawing.Point(398, 24)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(127, 15)
        Me.Label3.TabIndex = 16
        Me.Label3.Text = "Patentes Disponibles"
        '
        'cmbUsu
        '
        Me.cmbUsu.FormattingEnabled = True
        Me.cmbUsu.Location = New System.Drawing.Point(34, 38)
        Me.cmbUsu.Name = "cmbUsu"
        Me.cmbUsu.Size = New System.Drawing.Size(126, 21)
        Me.cmbUsu.TabIndex = 17
        '
        'Button4
        '
        Me.Button4.Location = New System.Drawing.Point(34, 65)
        Me.Button4.Name = "Button4"
        Me.Button4.Size = New System.Drawing.Size(126, 42)
        Me.Button4.TabIndex = 18
        Me.Button4.Text = "Presionar para verificar Asignaciones"
        Me.Button4.UseVisualStyleBackColor = True
        '
        'lstPatNegadas
        '
        Me.lstPatNegadas.FormattingEnabled = True
        Me.lstPatNegadas.Location = New System.Drawing.Point(199, 47)
        Me.lstPatNegadas.Name = "lstPatNegadas"
        Me.lstPatNegadas.Size = New System.Drawing.Size(120, 225)
        Me.lstPatNegadas.TabIndex = 19
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label4.Location = New System.Drawing.Point(196, 26)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(111, 15)
        Me.Label4.TabIndex = 20
        Me.Label4.Text = "Patentes Negadas"
        '
        'btnAsignarAsig
        '
        Me.btnAsignarAsig.Location = New System.Drawing.Point(529, 102)
        Me.btnAsignarAsig.Name = "btnAsignarAsig"
        Me.btnAsignarAsig.Size = New System.Drawing.Size(50, 23)
        Me.btnAsignarAsig.TabIndex = 21
        Me.btnAsignarAsig.Text = "->"
        Me.btnAsignarAsig.UseVisualStyleBackColor = True
        '
        'btnNegar
        '
        Me.btnNegar.Location = New System.Drawing.Point(335, 101)
        Me.btnNegar.Name = "btnNegar"
        Me.btnNegar.Size = New System.Drawing.Size(50, 23)
        Me.btnNegar.TabIndex = 24
        Me.btnNegar.Text = "<-"
        Me.btnNegar.UseVisualStyleBackColor = True
        '
        'lstFamDisp
        '
        Me.lstFamDisp.FormattingEnabled = True
        Me.lstFamDisp.Location = New System.Drawing.Point(199, 311)
        Me.lstFamDisp.Name = "lstFamDisp"
        Me.lstFamDisp.Size = New System.Drawing.Size(120, 121)
        Me.lstFamDisp.TabIndex = 25
        '
        'lstFamAsig
        '
        Me.lstFamAsig.FormattingEnabled = True
        Me.lstFamAsig.Location = New System.Drawing.Point(401, 311)
        Me.lstFamAsig.Name = "lstFamAsig"
        Me.lstFamAsig.Size = New System.Drawing.Size(120, 121)
        Me.lstFamAsig.TabIndex = 26
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label6.Location = New System.Drawing.Point(196, 286)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(123, 15)
        Me.Label6.TabIndex = 27
        Me.Label6.Text = "Familias Disponibles"
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label7.Location = New System.Drawing.Point(402, 286)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(117, 15)
        Me.Label7.TabIndex = 28
        Me.Label7.Text = "Familias Asignadas"
        '
        'Button3
        '
        Me.Button3.Location = New System.Drawing.Point(339, 336)
        Me.Button3.Name = "Button3"
        Me.Button3.Size = New System.Drawing.Size(49, 23)
        Me.Button3.TabIndex = 29
        Me.Button3.Text = "->"
        Me.Button3.UseVisualStyleBackColor = True
        '
        'Button5
        '
        Me.Button5.Location = New System.Drawing.Point(339, 366)
        Me.Button5.Name = "Button5"
        Me.Button5.Size = New System.Drawing.Size(49, 23)
        Me.Button5.TabIndex = 30
        Me.Button5.Text = "<-"
        Me.Button5.UseVisualStyleBackColor = True
        '
        'QuitarPatNeg
        '
        Me.QuitarPatNeg.Location = New System.Drawing.Point(335, 140)
        Me.QuitarPatNeg.Name = "QuitarPatNeg"
        Me.QuitarPatNeg.Size = New System.Drawing.Size(50, 23)
        Me.QuitarPatNeg.TabIndex = 31
        Me.QuitarPatNeg.Text = "->"
        Me.QuitarPatNeg.UseVisualStyleBackColor = True
        '
        'QuitarPatAsi
        '
        Me.QuitarPatAsi.Location = New System.Drawing.Point(529, 141)
        Me.QuitarPatAsi.Name = "QuitarPatAsi"
        Me.QuitarPatAsi.Size = New System.Drawing.Size(50, 23)
        Me.QuitarPatAsi.TabIndex = 32
        Me.QuitarPatAsi.Text = "<-"
        Me.QuitarPatAsi.UseVisualStyleBackColor = True
        '
        'frmUsuPat
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None
        Me.ClientSize = New System.Drawing.Size(767, 501)
        Me.Controls.Add(Me.QuitarPatAsi)
        Me.Controls.Add(Me.QuitarPatNeg)
        Me.Controls.Add(Me.Button5)
        Me.Controls.Add(Me.Button3)
        Me.Controls.Add(Me.Label7)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.lstFamAsig)
        Me.Controls.Add(Me.lstFamDisp)
        Me.Controls.Add(Me.btnNegar)
        Me.Controls.Add(Me.btnAsignarAsig)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.lstPatNegadas)
        Me.Controls.Add(Me.Button4)
        Me.Controls.Add(Me.cmbUsu)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.lstPatAsignadas)
        Me.Controls.Add(Me.lstPatDisponibles)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.Button2)
        Me.ForeColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.HelpButton = True
        Me.ImeMode = System.Windows.Forms.ImeMode.[On]
        Me.KeyPreview = True
        Me.Name = "frmUsuPat"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
        Me.Text = "Patentes"
        Me.TransparencyKey = System.Drawing.SystemColors.ActiveBorder
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents lstPatAsignadas As System.Windows.Forms.ListBox
    Friend WithEvents lstPatDisponibles As System.Windows.Forms.ListBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Button2 As System.Windows.Forms.Button
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents cmbUsu As System.Windows.Forms.ComboBox
    Friend WithEvents Button4 As System.Windows.Forms.Button
    Friend WithEvents lstPatNegadas As System.Windows.Forms.ListBox
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents btnAsignarAsig As System.Windows.Forms.Button
    Friend WithEvents btnNegar As System.Windows.Forms.Button
    Friend WithEvents lstFamDisp As System.Windows.Forms.ListBox
    Friend WithEvents lstFamAsig As System.Windows.Forms.ListBox
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents Button3 As System.Windows.Forms.Button
    Friend WithEvents Button5 As System.Windows.Forms.Button
    Friend WithEvents QuitarPatNeg As System.Windows.Forms.Button
    Friend WithEvents QuitarPatAsi As System.Windows.Forms.Button
End Class
