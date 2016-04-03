<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmPatFam
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
        Me.lstFamDisponibles = New System.Windows.Forms.ListBox()
        Me.Familia = New System.Windows.Forms.Label()
        Me.Button3 = New System.Windows.Forms.Button()
        Me.lstPatDisponibles = New System.Windows.Forms.ListBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Button4 = New System.Windows.Forms.Button()
        Me.Button5 = New System.Windows.Forms.Button()
        Me.lstPatAsignadas = New System.Windows.Forms.ListBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Quitar = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.SuspendLayout()
        '
        'lstFamDisponibles
        '
        Me.lstFamDisponibles.FormattingEnabled = True
        Me.lstFamDisponibles.Location = New System.Drawing.Point(15, 28)
        Me.lstFamDisponibles.Name = "lstFamDisponibles"
        Me.lstFamDisponibles.Size = New System.Drawing.Size(132, 238)
        Me.lstFamDisponibles.TabIndex = 22
        '
        'Familia
        '
        Me.Familia.AutoSize = True
        Me.Familia.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Familia.Location = New System.Drawing.Point(12, 9)
        Me.Familia.Name = "Familia"
        Me.Familia.Size = New System.Drawing.Size(135, 15)
        Me.Familia.TabIndex = 20
        Me.Familia.Text = "Familia Disponibles"
        '
        'Button3
        '
        Me.Button3.Location = New System.Drawing.Point(15, 279)
        Me.Button3.Name = "Button3"
        Me.Button3.Size = New System.Drawing.Size(132, 23)
        Me.Button3.TabIndex = 18
        Me.Button3.Text = "Listar"
        Me.Button3.UseVisualStyleBackColor = True
        '
        'lstPatDisponibles
        '
        Me.lstPatDisponibles.FormattingEnabled = True
        Me.lstPatDisponibles.Location = New System.Drawing.Point(464, 27)
        Me.lstPatDisponibles.Name = "lstPatDisponibles"
        Me.lstPatDisponibles.Size = New System.Drawing.Size(129, 238)
        Me.lstPatDisponibles.TabIndex = 25
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.Location = New System.Drawing.Point(235, 9)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(133, 15)
        Me.Label2.TabIndex = 24
        Me.Label2.Text = "Patentes Asignadas"
        '
        'Button4
        '
        Me.Button4.Location = New System.Drawing.Point(170, 134)
        Me.Button4.Name = "Button4"
        Me.Button4.Size = New System.Drawing.Size(41, 23)
        Me.Button4.TabIndex = 26
        Me.Button4.Text = "->"
        Me.Button4.UseVisualStyleBackColor = True
        '
        'Button5
        '
        Me.Button5.Location = New System.Drawing.Point(394, 128)
        Me.Button5.Name = "Button5"
        Me.Button5.Size = New System.Drawing.Size(41, 23)
        Me.Button5.TabIndex = 27
        Me.Button5.Text = "<-"
        Me.Button5.UseVisualStyleBackColor = True
        '
        'lstPatAsignadas
        '
        Me.lstPatAsignadas.FormattingEnabled = True
        Me.lstPatAsignadas.Location = New System.Drawing.Point(239, 27)
        Me.lstPatAsignadas.Name = "lstPatAsignadas"
        Me.lstPatAsignadas.Size = New System.Drawing.Size(129, 238)
        Me.lstPatAsignadas.TabIndex = 29
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.Location = New System.Drawing.Point(461, 9)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(143, 15)
        Me.Label1.TabIndex = 28
        Me.Label1.Text = "Patentes Disponibles"
        '
        'Quitar
        '
        Me.Quitar.AutoSize = True
        Me.Quitar.Location = New System.Drawing.Point(170, 115)
        Me.Quitar.Name = "Quitar"
        Me.Quitar.Size = New System.Drawing.Size(35, 13)
        Me.Quitar.TabIndex = 30
        Me.Quitar.Text = "Quitar"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(396, 112)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(42, 13)
        Me.Label3.TabIndex = 31
        Me.Label3.Text = "Asignar"
        '
        'frmPatFam
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(622, 320)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Quitar)
        Me.Controls.Add(Me.lstPatAsignadas)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.Button5)
        Me.Controls.Add(Me.Button4)
        Me.Controls.Add(Me.lstPatDisponibles)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.lstFamDisponibles)
        Me.Controls.Add(Me.Familia)
        Me.Controls.Add(Me.Button3)
        Me.KeyPreview = True
        Me.Name = "frmPatFam"
        Me.Text = "Familias"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents lstFamDisponibles As System.Windows.Forms.ListBox
    Friend WithEvents Familia As System.Windows.Forms.Label
    Friend WithEvents Button3 As System.Windows.Forms.Button
    Friend WithEvents lstPatDisponibles As System.Windows.Forms.ListBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Button4 As System.Windows.Forms.Button
    Friend WithEvents Button5 As System.Windows.Forms.Button
    Friend WithEvents lstPatAsignadas As System.Windows.Forms.ListBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Quitar As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
End Class
