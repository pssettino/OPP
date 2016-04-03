Imports Microsoft.Reporting.WinForms

Public Class frmVentasReporte

    Dim SeguridadBLL As New BLL.Seguridad

    Public VentasBE As New List(Of BE.Venta)
    Public Titulo As String

    Public Sub New(ByVal VentasBEParam As List(Of BE.Venta), ByVal TituloParam As String)
        InitializeComponent()
        VentasBE = VentasBEParam
        Titulo = TituloParam
    End Sub

    Private Sub frmBitacoraReporte_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        ReportViewer1.LocalReport.DataSources.Clear()
        Dim parameters As ReportParameter() = New ReportParameter(0) {}
        parameters(0) = New ReportParameter("titulo", Titulo)
        ReportViewer1.LocalReport.SetParameters(parameters)
        ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("Ventas", VentasBE))
        ReportViewer1.RefreshReport()
        Me.ReportViewer1.RefreshReport()
    End Sub
End Class