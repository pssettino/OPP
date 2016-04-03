Imports Microsoft.Reporting.WinForms

Public Class frmBitacoraReporte

    Dim SeguridadBLL As New BLL.Seguridad

    Public BitacorasBE As New List(Of BE.Bitacora)
    Public Titulo As String

    Public Sub New(ByVal BitacorasBEParam As List(Of BE.Bitacora), ByVal TituloParam As String)
        InitializeComponent()
        BitacorasBE = BitacorasBEParam
        For Each BitacoraBE In BitacorasBE
            BitacoraBE.usuario.NombreUsuario = SeguridadBLL.DesencriptarRSA(BitacoraBE.usuario.NombreUsuario)
            BitacoraBE.descripcion = SeguridadBLL.DesencriptarRSA(BitacoraBE.descripcion)
        Next
        Titulo = TituloParam
    End Sub

    Private Sub frmBitacoraReporte_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        ReportViewer1.LocalReport.DataSources.Clear()
        Dim parameters As ReportParameter() = New ReportParameter(0) {}
        parameters(0) = New ReportParameter("titulo", Titulo)
        ReportViewer1.LocalReport.SetParameters(parameters)
        ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("Bitacora", BitacorasBE))
        ReportViewer1.RefreshReport()
    End Sub

End Class