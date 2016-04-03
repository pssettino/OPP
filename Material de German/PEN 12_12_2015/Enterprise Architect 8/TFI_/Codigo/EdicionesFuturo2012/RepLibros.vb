Public Class RepLibros

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'TODO: esta línea de código carga datos en la tabla 'EdicionesDataSet.Libro' Puede moverla o quitarla según sea necesario.
        Me.LibroTableAdapter.Fill(Me.EdicionesDataSet.Libro)
        'TODO: esta línea de código carga datos en la tabla 'EdicionesDataSet.Cliente' Puede moverla o quitarla según sea necesario.
        Me.ClienteTableAdapter.Fill(Me.EdicionesDataSet.Cliente)
        'TODO: esta línea de código carga datos en la tabla 'EdicionesDataSet.Libro' Puede moverla o quitarla según sea necesario.
        Me.LibroTableAdapter.Fill(Me.EdicionesDataSet.Libro)

        'Me.ClienteTableAdapter.Fill(Me.EdicionesDataSet.Cliente)

        Me.ReportViewer1.RefreshReport()
    End Sub


    Private Sub ReportViewer1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)

    End Sub
End Class