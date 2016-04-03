Imports Microsoft.Reporting.WinForms

Public Class frmMedicamentosReporteFiltro

    Dim BitacoraBE As New BE.Bitacora
    Dim unMedicamento As New BE.Medicamento
    Dim MenuUI As UI.frmMenu
    Dim TraduccionBLL As BLL.Traduccion
    Dim SeguridadBLL As New BLL.Seguridad
    Dim LaboratorioBLL As New BLL.Laboratorio

    Private Sub frmMedicamentos_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        MenuUI = Me.MdiParent
        TraduccionBLL = New BLL.Traduccion(MenuUI.GetIdioma)
        Dim PatenteBE As New BE.Patente
        PatenteBE.Nombre = "Medicamento"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If (BLL.Usuario.GetInstance.VerificarPatente(MenuUI.GetUsuario, PatenteBE) = False) Then
            MsgBox(TraduccionBLL.TraducirTexto("Sus permisos han sido modificados, por favor inicie sesion nuevamente"), MsgBoxStyle.Critical, TraduccionBLL.TraducirTexto("Error"))
            Application.Exit()
        End If
        TraduccionBLL.TraducirForm(Me)
        ObtenerLaboratorios()
    End Sub

    Public Sub ObtenerLaboratorios()
        Dim myList As New Dictionary(Of Integer, String)
        myList.Add(0, TraduccionBLL.TraducirTexto("Todos los Laboratorios"))
        For Each LaboratorioBE In LaboratorioBLL.ObtenerLaboratorios
            myList.Add(LaboratorioBE.laboratorioId, LaboratorioBE.razonSocial)
        Next
        cmbLaboratorio.DisplayMember = "Value"
        cmbLaboratorio.ValueMember = "Key"
        cmbLaboratorio.DataSource = New BindingSource(myList, Nothing)
    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Me.Close()
    End Sub

    Private Sub btnlimpiar_Click(sender As Object, e As EventArgs) Handles btnlimpiar.Click
        dgMedicamentos.Rows.Clear()
    End Sub

    Public Function ListarMedicamentos()
        dgMedicamentos.Rows.Clear()
        Dim LaboratorioBE As New BE.Laboratorio
        LaboratorioBE.laboratorioId = cmbLaboratorio.SelectedValue
        Dim medicamentos As New List(Of BE.Medicamento)

        medicamentos = BLL.Medicamento.GetInstance.ObtenerMedicamentoPorParametros(Trim(txtDescripcion.Text), LaboratorioBE, CheckReceta.CheckState)
        For Each MedicamentoBE In medicamentos
            Dim n As Integer = dgMedicamentos.Rows.Add()
            dgMedicamentos.Rows.Item(n).Cells("id").Value = MedicamentoBE.medicamentoId
            dgMedicamentos.Rows.Item(n).Cells("descripcion").Value = MedicamentoBE.descripcion
            dgMedicamentos.Rows.Item(n).Cells("laboratorio").Value = MedicamentoBE.laboratorio.razonSocial
            dgMedicamentos.Rows.Item(n).Cells("cantidad").Value = SeguridadBLL.DesencriptarRSA(MedicamentoBE.cantidad)
            dgMedicamentos.Rows.Item(n).Cells("precio").Value = SeguridadBLL.DesencriptarRSA(MedicamentoBE.precio)
            dgMedicamentos.Rows.Item(n).Cells("eliminado").Value = IIf(MedicamentoBE.eliminado, "SI", "NO")
            dgMedicamentos.Rows.Item(n).Cells("Receta").Value = IIf(MedicamentoBE.Receta, "SI", "NO")
        Next
        Return medicamentos
    End Function


    Private Sub btnExportar_Click(sender As Object, e As EventArgs) Handles btnExportar.Click
        Dim MedicamentoReporteUI As New UI.frmMedicamentosReporte(ListarMedicamentos(), "Reporte de Medicamentos ")
        MedicamentoReporteUI.Show()
    End Sub

    Private Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click
        ListarMedicamentos()
    End Sub
End Class