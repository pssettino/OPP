Imports Microsoft.Reporting.WinForms

Public Class frmBitacora

    Dim SeguridadBLL As New BLL.Seguridad
    Dim MenuUI As UI.frmMenu
    Dim TraduccionBLL As BLL.Traduccion
    Private Sub frmBitacora_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        MenuUI = Me.MdiParent
        TraduccionBLL = New BLL.Traduccion(MenuUI.GetIdioma)
        TraduccionBLL.TraducirForm(Me)
        MuestraCamposBitacora()
    End Sub

    Public Sub MuestraCamposBitacora()
        cmbUsuario.Items.Clear()

        Dim myList As New Dictionary(Of Integer, String)
        myList.Add(0, TraduccionBLL.TraducirTexto("Todos los Usuarios"))
        For Each UsuarioBE In BLL.Usuario.GetInstance.ListAll()
            myList.Add(UsuarioBE.UsuarioId, SeguridadBLL.DesencriptarRSA(UsuarioBE.NombreUsuario))
        Next
        cmbUsuario.DisplayMember = "Value"
        cmbUsuario.ValueMember = "Key"
        cmbUsuario.DataSource = New BindingSource(myList, Nothing)

        Dim myListNivel As New Dictionary(Of String, String)
        myListNivel.Add("Todos los niveles", TraduccionBLL.TraducirTexto("Todos los niveles"))
        myListNivel.Add("Alta", "Alta")
        myListNivel.Add("Media", "Media")
        myListNivel.Add("Baja", "Baja")
        cmbCriticidad.DisplayMember = "Value"
        cmbCriticidad.ValueMember = "Key"

        cmbCriticidad.DataSource = New BindingSource(myListNivel, Nothing)

    End Sub
    Private Sub btnbuscar_Click(sender As Object, e As EventArgs) Handles btnbuscar.Click
        dgBitacora.Rows.Clear()
        ListarBitacoras()
    End Sub

    Public Function ListarBitacoras()
        Dim fechaDesde = New DateTime(dtpFechaDesde.Value.Year, dtpFechaDesde.Value.Month, dtpFechaDesde.Value.Day, 0, 0, 0)
        Dim fechaHasta = New DateTime(dtpFechaHasta.Value.Year, dtpFechaHasta.Value.Month, dtpFechaHasta.Value.Day, 23, 59, 59)
        Dim BitacorasBE As New BE.Bitacora
        Dim bitacoras As New List(Of BE.Bitacora)

        bitacoras = BLL.Bitacora.GetInstance.ListarBitacoraPorParametros(cmbUsuario.SelectedValue, fechaDesde, fechaHasta, cmbCriticidad.SelectedValue)
        For Each BitacorasBE In bitacoras
            Dim n As Integer = dgBitacora.Rows.Add()
            dgBitacora.Rows.Item(n).Cells("Id").Value = BitacorasBE.bitacora_id
            dgBitacora.Rows.Item(n).Cells("Usuario").Value = SeguridadBLL.DesencriptarRSA(BitacorasBE.usuario.NombreUsuario)
            dgBitacora.Rows.Item(n).Cells("Descripcion").Value = SeguridadBLL.DesencriptarRSA(BitacorasBE.Descripcion)
            dgBitacora.Rows.Item(n).Cells("Fecha_Hora").Value = BitacorasBE.fecha.ToString("yyyy/MM/dd HH:mm:ss")
            dgBitacora.Rows.Item(n).Cells("Criticidad").Value = BitacorasBE.criticidad
        Next
        Return bitacoras
    End Function

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Me.Close()
    End Sub

    Private Sub btnExportar_Click(sender As Object, e As EventArgs) Handles btnExportar.Click
        Dim BitacoraReporteUI As New UI.frmBitacoraReporte(ListarBitacoras(), "Reporte de bitacora desde " + dtpFechaDesde.Value.Day.ToString + "/" + dtpFechaDesde.Value.Month.ToString + "/" + dtpFechaDesde.Value.Year.ToString + " hasta " + dtpFechaHasta.Value.Day.ToString + "/" + dtpFechaHasta.Value.Month.ToString + "/" + dtpFechaHasta.Value.Year.ToString)
        BitacoraReporteUI.Show()
    End Sub

End Class