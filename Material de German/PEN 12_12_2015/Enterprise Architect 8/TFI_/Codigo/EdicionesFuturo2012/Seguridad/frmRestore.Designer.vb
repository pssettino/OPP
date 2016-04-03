<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmRestore
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
        Me.btnExaminar3 = New System.Windows.Forms.Button()
        Me.txtOrigen3 = New System.Windows.Forms.TextBox()
        Me.lblTerceraParte = New System.Windows.Forms.Label()
        Me.btnExaminar2 = New System.Windows.Forms.Button()
        Me.txtOrigen2 = New System.Windows.Forms.TextBox()
        Me.lblSegundaParte = New System.Windows.Forms.Label()
        Me.checkMultivolumen = New System.Windows.Forms.CheckBox()
        Me.btnRestaurar = New System.Windows.Forms.Button()
        Me.btnExaminar = New System.Windows.Forms.Button()
        Me.txtOrigenRestore = New System.Windows.Forms.TextBox()
        Me.lblPrimeraParte = New System.Windows.Forms.Label()
        Me.PictureBox1 = New System.Windows.Forms.PictureBox()
        Me.Label1 = New System.Windows.Forms.Label()
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'btnExaminar3
        '
        Me.btnExaminar3.Location = New System.Drawing.Point(319, 128)
        Me.btnExaminar3.Name = "btnExaminar3"
        Me.btnExaminar3.Size = New System.Drawing.Size(95, 23)
        Me.btnExaminar3.TabIndex = 24
        Me.btnExaminar3.Text = "Examinar"
        Me.btnExaminar3.UseVisualStyleBackColor = True
        Me.btnExaminar3.Visible = False
        '
        'txtOrigen3
        '
        Me.txtOrigen3.Enabled = False
        Me.txtOrigen3.Location = New System.Drawing.Point(154, 128)
        Me.txtOrigen3.Name = "txtOrigen3"
        Me.txtOrigen3.Size = New System.Drawing.Size(144, 20)
        Me.txtOrigen3.TabIndex = 23
        Me.txtOrigen3.Visible = False
        '
        'lblTerceraParte
        '
        Me.lblTerceraParte.AutoSize = True
        Me.lblTerceraParte.Location = New System.Drawing.Point(47, 136)
        Me.lblTerceraParte.Name = "lblTerceraParte"
        Me.lblTerceraParte.Size = New System.Drawing.Size(88, 13)
        Me.lblTerceraParte.TabIndex = 22
        Me.lblTerceraParte.Text = "OrigenVolumen 3"
        Me.lblTerceraParte.Visible = False
        '
        'btnExaminar2
        '
        Me.btnExaminar2.Location = New System.Drawing.Point(319, 92)
        Me.btnExaminar2.Name = "btnExaminar2"
        Me.btnExaminar2.Size = New System.Drawing.Size(95, 23)
        Me.btnExaminar2.TabIndex = 21
        Me.btnExaminar2.Text = "Examinar"
        Me.btnExaminar2.UseVisualStyleBackColor = True
        Me.btnExaminar2.Visible = False
        '
        'txtOrigen2
        '
        Me.txtOrigen2.Enabled = False
        Me.txtOrigen2.Location = New System.Drawing.Point(153, 92)
        Me.txtOrigen2.Name = "txtOrigen2"
        Me.txtOrigen2.Size = New System.Drawing.Size(144, 20)
        Me.txtOrigen2.TabIndex = 20
        Me.txtOrigen2.Visible = False
        '
        'lblSegundaParte
        '
        Me.lblSegundaParte.AutoSize = True
        Me.lblSegundaParte.Location = New System.Drawing.Point(46, 100)
        Me.lblSegundaParte.Name = "lblSegundaParte"
        Me.lblSegundaParte.Size = New System.Drawing.Size(88, 13)
        Me.lblSegundaParte.TabIndex = 19
        Me.lblSegundaParte.Text = "OrigenVolumen 2"
        Me.lblSegundaParte.Visible = False
        '
        'checkMultivolumen
        '
        Me.checkMultivolumen.AutoSize = True
        Me.checkMultivolumen.Location = New System.Drawing.Point(319, 175)
        Me.checkMultivolumen.Name = "checkMultivolumen"
        Me.checkMultivolumen.Size = New System.Drawing.Size(88, 17)
        Me.checkMultivolumen.TabIndex = 18
        Me.checkMultivolumen.Text = "Multivolumen"
        Me.checkMultivolumen.UseVisualStyleBackColor = True
        '
        'btnRestaurar
        '
        Me.btnRestaurar.Location = New System.Drawing.Point(45, 169)
        Me.btnRestaurar.Name = "btnRestaurar"
        Me.btnRestaurar.Size = New System.Drawing.Size(95, 23)
        Me.btnRestaurar.TabIndex = 16
        Me.btnRestaurar.Text = "Realizar Restore"
        Me.btnRestaurar.UseVisualStyleBackColor = True
        '
        'btnExaminar
        '
        Me.btnExaminar.Location = New System.Drawing.Point(319, 58)
        Me.btnExaminar.Name = "btnExaminar"
        Me.btnExaminar.Size = New System.Drawing.Size(95, 23)
        Me.btnExaminar.TabIndex = 15
        Me.btnExaminar.Text = "Examinar"
        Me.btnExaminar.UseVisualStyleBackColor = True
        '
        'txtOrigenRestore
        '
        Me.txtOrigenRestore.Enabled = False
        Me.txtOrigenRestore.Location = New System.Drawing.Point(153, 58)
        Me.txtOrigenRestore.Name = "txtOrigenRestore"
        Me.txtOrigenRestore.Size = New System.Drawing.Size(144, 20)
        Me.txtOrigenRestore.TabIndex = 14
        '
        'lblPrimeraParte
        '
        Me.lblPrimeraParte.AutoSize = True
        Me.lblPrimeraParte.Location = New System.Drawing.Point(46, 64)
        Me.lblPrimeraParte.Name = "lblPrimeraParte"
        Me.lblPrimeraParte.Size = New System.Drawing.Size(88, 13)
        Me.lblPrimeraParte.TabIndex = 13
        Me.lblPrimeraParte.Text = "OrigenVolumen 1"
        '
        'PictureBox1
        '
        Me.PictureBox1.Image = Global.UI.My.Resources.Resources.Restore
        Me.PictureBox1.Location = New System.Drawing.Point(456, 31)
        Me.PictureBox1.Name = "PictureBox1"
        Me.PictureBox1.Size = New System.Drawing.Size(140, 150)
        Me.PictureBox1.TabIndex = 26
        Me.PictureBox1.TabStop = False
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.Location = New System.Drawing.Point(44, 31)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(268, 13)
        Me.Label1.TabIndex = 27
        Me.Label1.Text = "Seleccionar Origen de Backup para Restaurar"
        '
        'frmRestore
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(608, 219)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.PictureBox1)
        Me.Controls.Add(Me.btnExaminar3)
        Me.Controls.Add(Me.txtOrigen3)
        Me.Controls.Add(Me.lblTerceraParte)
        Me.Controls.Add(Me.btnExaminar2)
        Me.Controls.Add(Me.txtOrigen2)
        Me.Controls.Add(Me.lblSegundaParte)
        Me.Controls.Add(Me.checkMultivolumen)
        Me.Controls.Add(Me.btnRestaurar)
        Me.Controls.Add(Me.btnExaminar)
        Me.Controls.Add(Me.txtOrigenRestore)
        Me.Controls.Add(Me.lblPrimeraParte)
        Me.KeyPreview = True
        Me.Name = "frmRestore"
        Me.Text = "frmRestore"
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents btnExaminar3 As System.Windows.Forms.Button
    Friend WithEvents txtOrigen3 As System.Windows.Forms.TextBox
    Friend WithEvents lblTerceraParte As System.Windows.Forms.Label
    Friend WithEvents btnExaminar2 As System.Windows.Forms.Button
    Friend WithEvents txtOrigen2 As System.Windows.Forms.TextBox
    Friend WithEvents lblSegundaParte As System.Windows.Forms.Label
    Friend WithEvents checkMultivolumen As System.Windows.Forms.CheckBox
    Friend WithEvents btnRestaurar As System.Windows.Forms.Button
    Friend WithEvents btnExaminar As System.Windows.Forms.Button
    Friend WithEvents txtOrigenRestore As System.Windows.Forms.TextBox
    Friend WithEvents lblPrimeraParte As System.Windows.Forms.Label
    Friend WithEvents PictureBox1 As System.Windows.Forms.PictureBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
End Class
