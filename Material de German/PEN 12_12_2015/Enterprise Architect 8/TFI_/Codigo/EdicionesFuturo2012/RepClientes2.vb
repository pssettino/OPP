Public Class RepClientes2

    Private Sub RepClientes2_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'TODO: esta línea de código carga datos en la tabla 'EdicionesDataSet.Cliente' Puede moverla o quitarla según sea necesario.
        Me.ClienteTableAdapter.Fill(Me.EdicionesDataSet.Cliente)

        Me.ReportViewer1.RefreshReport()
    End Sub
End Class