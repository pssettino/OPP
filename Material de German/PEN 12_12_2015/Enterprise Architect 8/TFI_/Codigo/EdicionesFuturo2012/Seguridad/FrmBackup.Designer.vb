<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FrmBackup
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
        Me.txtDestino = New System.Windows.Forms.TextBox()
        Me.btnExaminar = New System.Windows.Forms.Button()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.btnGenerarBKP = New System.Windows.Forms.Button()
        Me.lblDestino3 = New System.Windows.Forms.Label()
        Me.lblDestino2 = New System.Windows.Forms.Label()
        Me.checkMultivolumen = New System.Windows.Forms.CheckBox()
        Me.checkMulti = New System.Windows.Forms.Label()
        Me.txtDestino2 = New System.Windows.Forms.TextBox()
        Me.txtDestino3 = New System.Windows.Forms.TextBox()
        Me.btnExaminar2 = New System.Windows.Forms.Button()
        Me.btnExaminar3 = New System.Windows.Forms.Button()
        Me.PictureBox1 = New System.Windows.Forms.PictureBox()
        Me.lblvol1 = New System.Windows.Forms.Label()
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'txtDestino
        '
        Me.txtDestino.Location = New System.Drawing.Point(95, 35)
        Me.txtDestino.Name = "txtDestino"
        Me.txtDestino.Size = New System.Drawing.Size(178, 20)
        Me.txtDestino.TabIndex = 0
        '
        'btnExaminar
        '
        Me.btnExaminar.Location = New System.Drawing.Point(279, 32)
        Me.btnExaminar.Name = "btnExaminar"
        Me.btnExaminar.Size = New System.Drawing.Size(75, 23)
        Me.btnExaminar.TabIndex = 1
        Me.btnExaminar.Text = "Seleccionar"
        Me.btnExaminar.UseVisualStyleBackColor = True
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.Location = New System.Drawing.Point(12, 9)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(188, 13)
        Me.Label1.TabIndex = 2
        Me.Label1.Text = "Seleccione Destinos de Backup"
        '
        'btnGenerarBKP
        '
        Me.btnGenerarBKP.Location = New System.Drawing.Point(95, 147)
        Me.btnGenerarBKP.Name = "btnGenerarBKP"
        Me.btnGenerarBKP.Size = New System.Drawing.Size(75, 23)
        Me.btnGenerarBKP.TabIndex = 3
        Me.btnGenerarBKP.Text = "Realizar Backup"
        Me.btnGenerarBKP.UseVisualStyleBackColor = True
        '
        'lblDestino3
        '
        Me.lblDestino3.AutoSize = True
        Me.lblDestino3.Location = New System.Drawing.Point(29, 107)
        Me.lblDestino3.Name = "lblDestino3"
        Me.lblDestino3.Size = New System.Drawing.Size(60, 13)
        Me.lblDestino3.TabIndex = 18
        Me.lblDestino3.Text = "Volumen 3:"
        Me.lblDestino3.Visible = False
        '
        'lblDestino2
        '
        Me.lblDestino2.AutoSize = True
        Me.lblDestino2.Location = New System.Drawing.Point(29, 73)
        Me.lblDestino2.Name = "lblDestino2"
        Me.lblDestino2.Size = New System.Drawing.Size(60, 13)
        Me.lblDestino2.TabIndex = 15
        Me.lblDestino2.Text = "Volumen 2:"
        Me.lblDestino2.Visible = False
        '
        'checkMultivolumen
        '
        Me.checkMultivolumen.AutoSize = True
        Me.checkMultivolumen.Location = New System.Drawing.Point(264, 151)
        Me.checkMultivolumen.Name = "checkMultivolumen"
        Me.checkMultivolumen.Size = New System.Drawing.Size(15, 14)
        Me.checkMultivolumen.TabIndex = 14
        Me.checkMultivolumen.UseVisualStyleBackColor = True
        '
        'checkMulti
        '
        Me.checkMulti.AutoSize = True
        Me.checkMulti.Location = New System.Drawing.Point(285, 152)
        Me.checkMulti.Name = "checkMulti"
        Me.checkMulti.Size = New System.Drawing.Size(69, 13)
        Me.checkMulti.TabIndex = 13
        Me.checkMulti.Text = "Multivolumen"
        '
        'txtDestino2
        '
        Me.txtDestino2.Location = New System.Drawing.Point(96, 66)
        Me.txtDestino2.Name = "txtDestino2"
        Me.txtDestino2.Size = New System.Drawing.Size(177, 20)
        Me.txtDestino2.TabIndex = 23
        '
        'txtDestino3
        '
        Me.txtDestino3.Location = New System.Drawing.Point(95, 100)
        Me.txtDestino3.Name = "txtDestino3"
        Me.txtDestino3.Size = New System.Drawing.Size(177, 20)
        Me.txtDestino3.TabIndex = 24
        '
        'btnExaminar2
        '
        Me.btnExaminar2.Location = New System.Drawing.Point(279, 66)
        Me.btnExaminar2.Name = "btnExaminar2"
        Me.btnExaminar2.Size = New System.Drawing.Size(75, 23)
        Me.btnExaminar2.TabIndex = 25
        Me.btnExaminar2.Text = "Seleccionar"
        Me.btnExaminar2.UseVisualStyleBackColor = True
        '
        'btnExaminar3
        '
        Me.btnExaminar3.Location = New System.Drawing.Point(281, 97)
        Me.btnExaminar3.Name = "btnExaminar3"
        Me.btnExaminar3.Size = New System.Drawing.Size(75, 23)
        Me.btnExaminar3.TabIndex = 26
        Me.btnExaminar3.Text = "Seleccionar"
        Me.btnExaminar3.UseVisualStyleBackColor = True
        '
        'PictureBox1
        '
        Me.PictureBox1.Image = Global.UI.My.Resources.Resources.Backup
        Me.PictureBox1.Location = New System.Drawing.Point(395, 18)
        Me.PictureBox1.Name = "PictureBox1"
        Me.PictureBox1.Size = New System.Drawing.Size(139, 153)
        Me.PictureBox1.TabIndex = 27
        Me.PictureBox1.TabStop = False
        '
        'lblvol1
        '
        Me.lblvol1.AutoSize = True
        Me.lblvol1.Location = New System.Drawing.Point(32, 41)
        Me.lblvol1.Name = "lblvol1"
        Me.lblvol1.Size = New System.Drawing.Size(60, 13)
        Me.lblvol1.TabIndex = 28
        Me.lblvol1.Text = "Volumen 1:"
        '
        'FrmBackup
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(546, 186)
        Me.Controls.Add(Me.lblvol1)
        Me.Controls.Add(Me.PictureBox1)
        Me.Controls.Add(Me.btnExaminar3)
        Me.Controls.Add(Me.btnExaminar2)
        Me.Controls.Add(Me.txtDestino3)
        Me.Controls.Add(Me.txtDestino2)
        Me.Controls.Add(Me.lblDestino3)
        Me.Controls.Add(Me.lblDestino2)
        Me.Controls.Add(Me.checkMultivolumen)
        Me.Controls.Add(Me.checkMulti)
        Me.Controls.Add(Me.btnGenerarBKP)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.btnExaminar)
        Me.Controls.Add(Me.txtDestino)
        Me.KeyPreview = True
        Me.Name = "FrmBackup"
        Me.Text = "Backup"
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents txtDestino As System.Windows.Forms.TextBox
    Friend WithEvents btnExaminar As System.Windows.Forms.Button
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents btnGenerarBKP As System.Windows.Forms.Button
    Friend WithEvents lblDestino3 As System.Windows.Forms.Label
    Friend WithEvents lblDestino2 As System.Windows.Forms.Label
    Friend WithEvents checkMultivolumen As System.Windows.Forms.CheckBox
    Friend WithEvents checkMulti As System.Windows.Forms.Label
    Friend WithEvents txtDestino2 As System.Windows.Forms.TextBox
    Friend WithEvents txtDestino3 As System.Windows.Forms.TextBox
    Friend WithEvents btnExaminar2 As System.Windows.Forms.Button
    Friend WithEvents btnExaminar3 As System.Windows.Forms.Button
    Friend WithEvents PictureBox1 As System.Windows.Forms.PictureBox
    Friend WithEvents lblvol1 As System.Windows.Forms.Label
End Class
