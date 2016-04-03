<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class RepLibros
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
        Dim ReportDataSource1 As Microsoft.Reporting.WinForms.ReportDataSource = New Microsoft.Reporting.WinForms.ReportDataSource()
        Me.LibroBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.EdicionesDataSet = New UI.EdicionesDataSet()
        Me.ClienteBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.ReportViewer1 = New Microsoft.Reporting.WinForms.ReportViewer()
        Me.ClienteTableAdapter = New UI.EdicionesDataSetTableAdapters.ClienteTableAdapter()
        Me.LibroTableAdapter = New UI.EdicionesDataSetTableAdapters.LibroTableAdapter()
        CType(Me.LibroBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.EdicionesDataSet, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ClienteBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'LibroBindingSource
        '
        Me.LibroBindingSource.DataMember = "Libro"
        Me.LibroBindingSource.DataSource = Me.EdicionesDataSet
        '
        'EdicionesDataSet
        '
        Me.EdicionesDataSet.DataSetName = "EdicionesDataSet"
        Me.EdicionesDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'ClienteBindingSource
        '
        Me.ClienteBindingSource.DataMember = "Cliente"
        Me.ClienteBindingSource.DataSource = Me.EdicionesDataSet
        '
        'ReportViewer1
        '
        Me.ReportViewer1.AutoSize = True
        ReportDataSource1.Name = "DataSet1"
        ReportDataSource1.Value = Me.LibroBindingSource
        Me.ReportViewer1.LocalReport.DataSources.Add(ReportDataSource1)
        Me.ReportViewer1.LocalReport.ReportEmbeddedResource = "UI.RepLibros.rdlc"
        Me.ReportViewer1.Location = New System.Drawing.Point(25, 28)
        Me.ReportViewer1.Name = "ReportViewer1"
        Me.ReportViewer1.Size = New System.Drawing.Size(668, 398)
        Me.ReportViewer1.TabIndex = 0
        '
        'ClienteTableAdapter
        '
        Me.ClienteTableAdapter.ClearBeforeFill = True
        '
        'LibroTableAdapter
        '
        Me.LibroTableAdapter.ClearBeforeFill = True
        '
        'RepLibros
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(705, 510)
        Me.Controls.Add(Me.ReportViewer1)
        Me.Name = "RepLibros"
        Me.Text = "RepVentas"
        CType(Me.LibroBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.EdicionesDataSet, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ClienteBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents ReportViewer1 As Microsoft.Reporting.WinForms.ReportViewer
    Friend WithEvents ClienteBindingSource As System.Windows.Forms.BindingSource
    Friend WithEvents EdicionesDataSet As UI.EdicionesDataSet
    Friend WithEvents ClienteTableAdapter As UI.EdicionesDataSetTableAdapters.ClienteTableAdapter
    Friend WithEvents LibroBindingSource As System.Windows.Forms.BindingSource
    Friend WithEvents LibroTableAdapter As UI.EdicionesDataSetTableAdapters.LibroTableAdapter

End Class
