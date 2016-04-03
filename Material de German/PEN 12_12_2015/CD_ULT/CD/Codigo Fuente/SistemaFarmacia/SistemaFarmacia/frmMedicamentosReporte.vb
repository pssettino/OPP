Imports Microsoft.Reporting.WinForms

Public Class frmMedicamentosReporte
    Dim SeguridadBLL As New BLL.Seguridad

    Public MedicamentosBE As New List(Of BE.Medicamento)
    Public Titulo As String

    Public Sub New(ByVal MedicamentosBEParam As List(Of BE.Medicamento), ByVal TituloParam As String)
        InitializeComponent()
        MedicamentosBE = MedicamentosBEParam
        For Each MedicamentoBE In MedicamentosBE
            MedicamentoBE.cantidad = SeguridadBLL.DesencriptarRSA(MedicamentoBE.cantidad)
            MedicamentoBE.precio = SeguridadBLL.DesencriptarRSA(MedicamentoBE.precio)
            MedicamentoBE.NombreLaboratorio = MedicamentoBE.laboratorio.razonSocial
        Next
        Titulo = TituloParam
    End Sub


    Private Sub frmMedicamentosReporte_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        ReportViewer1.LocalReport.DataSources.Clear()
        Dim parameters As ReportParameter() = New ReportParameter(0) {}
        parameters(0) = New ReportParameter("titulo", Titulo)
        ReportViewer1.LocalReport.SetParameters(parameters)
        ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("Medicamento", MedicamentosBE))
        ReportViewer1.RefreshReport()
        Me.ReportViewer1.RefreshReport()
    End Sub
End Class