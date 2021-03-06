﻿Public Class frmMedicamentos
    Dim BitacoraBE As New BE.Bitacora
    Dim CriticidadBE As New BE.Criticidad
    Dim unMedicamento As New BE.Medicamento
    Dim MenuUI As UI.frmMenu
    Dim TraduccionBLL As BLL.Traduccion
    Dim SeguridadBLL As New BLL.Seguridad

    Private Sub frmMedicamentos_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        MenuUI = Me.MdiParent
        TraduccionBLL = New BLL.Traduccion(MenuUI.GetIdioma)
        TraduccionBLL.TraducirForm(Me)
        ObtenerMedicamentos()
    End Sub
    Private Sub btnResgistrar_Click(sender As Object, e As EventArgs) Handles btnResgistrar.Click
        Dim MedicamentoRegistrar As New frmMedicamentosMod()
        If MedicamentoRegistrar.ShowDialog(Me) = Windows.Forms.DialogResult.OK Then
            ObtenerMedicamentos()
        End If
    End Sub

    Public Sub ObtenerMedicamentos()
        dgMedicamentos.Rows.Clear()
        For Each MedicamentoBE In BLL.Medicamento.GetInstance.ListAll()
            Dim n As Integer = dgMedicamentos.Rows.Add()
            Dim LaboratorioBE As New BE.Laboratorio
            dgMedicamentos.Rows.Item(n).Cells("id").Value = MedicamentoBE.medicamentoId
            dgMedicamentos.Rows.Item(n).Cells("descripcion").Value = MedicamentoBE.descripcion
            dgMedicamentos.Rows.Item(n).Cells("laboratorio").Value = MedicamentoBE.laboratorio.razonSocial
            dgMedicamentos.Rows.Item(n).Cells("cantidad").Value = SeguridadBLL.DesencriptarRSA(MedicamentoBE.cantidad)
            dgMedicamentos.Rows.Item(n).Cells("precio").Value = SeguridadBLL.DesencriptarRSA(MedicamentoBE.precio)
            dgMedicamentos.Rows.Item(n).Cells("eliminado").Value = MedicamentoBE.eliminado
            dgMedicamentos.Rows.Item(n).Cells("Receta").Value = IIf(MedicamentoBE.Receta, "SI", "NO")
            Dim dgBtnEliminar = New DataGridViewButtonCell()
            If MedicamentoBE.eliminado = True Then
                dgBtnEliminar.Value = TraduccionBLL.TraducirTexto("Activar")
            Else
                dgBtnEliminar.Value = TraduccionBLL.TraducirTexto("Eliminar")
            End If
            dgMedicamentos.Rows.Item(n).Cells("dgBtnEliminar") = dgBtnEliminar
        Next
    End Sub


    Private Sub dgMedicamentos_CellContentClick(sender As Object, e As DataGridViewCellEventArgs) Handles dgMedicamentos.CellContentClick
        Dim id As String = Convert.ToString(dgMedicamentos.CurrentRow.Cells("id").Value)
        Dim eliminado As Boolean = dgMedicamentos.CurrentRow.Cells("Eliminado").Value
        Dim NombreMedicamento As String = Convert.ToString(dgMedicamentos.CurrentRow.Cells("Descripcion").Value)
        Dim Nombre As String
        Dim Descr As String
        Dim result As Integer

        'MODIFICAR
        If e.ColumnIndex = 6 Then 'Nro Columna del datagriew
            Dim MedicamentoModificar As New frmMedicamentosMod(id)
            Dim SeguridadBLL As New BLL.Seguridad
            Dim LaboratorioBLL As New BLL.Laboratorio
            MedicamentoModificar.txtnombre.Focus()

            unMedicamento.medicamentoId = id
            unMedicamento = BLL.Medicamento.GetInstance().ListById(unMedicamento)

            MedicamentoModificar.cmbLaboratorio.DataSource = LaboratorioBLL.ObtenerLaboratorios
            MedicamentoModificar.cmbLaboratorio.ValueMember = "laboratorioId"
            MedicamentoModificar.cmbLaboratorio.DisplayMember = "razonSocial"

            MedicamentoModificar.cmbLaboratorio.SelectedItem = unMedicamento.laboratorio.laboratorioId

            MedicamentoModificar.txtnombre.Text = unMedicamento.descripcion
            MedicamentoModificar.cmbLaboratorio.Text = unMedicamento.laboratorio.razonSocial
            MedicamentoModificar.CheckReceta.Checked = unMedicamento.Receta
            MedicamentoModificar.txtcantidad.Text = SeguridadBLL.DesencriptarRSA(unMedicamento.cantidad)
            MedicamentoModificar.txtprecio.Text = SeguridadBLL.DesencriptarRSA(unMedicamento.precio)

            If MedicamentoModificar.ShowDialog(Me) = Windows.Forms.DialogResult.OK Then
                ObtenerMedicamentos()
            End If
        End If
        'ELIMINAR
        If e.ColumnIndex = 7 Then 'Nro Columna del datagriew
            If eliminado = True Then
                eliminado = False
                Descr = "Activar"
                Nombre = "Se activo el Medicamento: " & NombreMedicamento
            Else
                eliminado = True
                Descr = "Eliminar"
                Nombre = "Elimino Medicamento: " & NombreMedicamento
            End If
            result = MessageBox.Show(TraduccionBLL.TraducirTexto("¿Esta seguro que desea " & Descr & " el Medicamento") & ": " & NombreMedicamento & "?", TraduccionBLL.TraducirTexto(Descr & " Medicamento"), MessageBoxButtons.OKCancel, MessageBoxIcon.Question)
            If result = DialogResult.OK Then
                unMedicamento.medicamentoId = id
                unMedicamento.eliminado = eliminado
                BLL.Medicamento.GetInstance.Delete(unMedicamento)
                RegistrarBitacora(Nombre, "Alta")
            End If
        End If
        ObtenerMedicamentos()
    End Sub
    Public Sub RegistrarBitacora(evento As String, nivel As String)
        Dim SeguridadBLL As New BLL.Seguridad
        BitacoraBE.descripcion = SeguridadBLL.EncriptarRSA(evento)
        BitacoraBE.usuario = MenuUI.GetUsuario
        CriticidadBE.nombre = nivel
        BitacoraBE.criticidad = CriticidadBE
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE)
    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Me.Close()
    End Sub
End Class