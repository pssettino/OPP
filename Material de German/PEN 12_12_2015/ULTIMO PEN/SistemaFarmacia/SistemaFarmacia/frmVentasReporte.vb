Imports Microsoft.Reporting.WinForms

Public Class frmVentasReporte
    Dim SeguridadBLL As New BLL.Seguridad

    Public VentasMedicamentoBE As New List(Of BE.VentaMedicamento)
    Public VentasBE As New List(Of BE.Venta)

    Public Titulo As String

    Public TotalImporte As Double
    Public Sub New(ByVal VentasBEParam As List(Of BE.Venta), ByVal TituloParam As String)
        InitializeComponent()
        VentasBE = VentasBEParam
        For Each VentaBE In VentasBE
            VentaBE.ClienteRpt = VentaBE.cliente.NombreCompleto
            For Each itemMedicamento In VentaBE.medicamentos
                itemMedicamento.Venta_Id = itemMedicamento.Venta.ventaId
                itemMedicamento.CantidadVenta = SeguridadBLL.DesencriptarRSA(itemMedicamento.CantidadVenta)
                itemMedicamento.PrecioVenta = SeguridadBLL.DesencriptarRSA(itemMedicamento.PrecioVenta)
                TotalImporte = TotalImporte + (itemMedicamento.CantidadVenta * itemMedicamento.PrecioVenta)
                VentasMedicamentoBE.Add(itemMedicamento)
            Next
            VentaBE.TotalImporte = TotalImporte
            TotalImporte = 0
        Next
        Titulo = TituloParam
    End Sub

    Private Sub frmVentasReporte_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        ReportViewer1.LocalReport.DataSources.Clear()
        Dim parameters As ReportParameter() = New ReportParameter(0) {}
        parameters(0) = New ReportParameter("titulo", Titulo)
        ReportViewer1.LocalReport.SetParameters(parameters)
        ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("Ventas", VentasBE))
        ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("VentasMedicamento", VentasMedicamentoBE))
        ReportViewer1.RefreshReport()
        Me.ReportViewer1.RefreshReport()
    End Sub

End Class