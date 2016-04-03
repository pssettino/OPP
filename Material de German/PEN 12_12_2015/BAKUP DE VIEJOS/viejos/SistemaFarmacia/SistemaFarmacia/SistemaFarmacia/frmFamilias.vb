Public Class frmFamilias
    Dim BitacoraBE As New BE.Bitacora
    Dim CriticidadBE As New BE.Criticidad
    Dim unaFamilia As New BE.Familia
    Dim MenuUI As UI.frmMenu
    Dim TraduccionBLL As BLL.Traduccion
    Dim SeguridadBLL As New BLL.Seguridad

    Public Sub ObtenerFamilias()
        dgFamilias.Rows.Clear()
        For Each FamiliaBE In BLL.Familia.GetInstance.ListAll()
            Dim n As Integer = dgFamilias.Rows.Add()
            dgFamilias.Rows.Item(n).Cells("id").Value = FamiliaBE.familiaId
            dgFamilias.Rows.Item(n).Cells("Nombre").Value = SeguridadBLL.DesencriptarRSA(FamiliaBE.nombre)
            dgFamilias.Rows.Item(n).Cells("Descripcion").Value = FamiliaBE.descripcion
            Dim dgBtnModificar = New DataGridViewButtonCell
            Dim dgBtnEliminar = New DataGridViewButtonCell
            dgBtnModificar.Value = "Modificar"
            dgBtnEliminar.Value = "Eliminar"
            dgFamilias.Rows.Item(n).Cells("dgBtnModificar") = dgBtnModificar
            dgFamilias.Rows.Item(n).Cells("dgBtnEliminar") = dgBtnEliminar
        Next
    End Sub

    Private Sub frmFamilias_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        MenuUI = Me.MdiParent
        TraduccionBLL = New BLL.Traduccion(MenuUI.GetIdioma)
        If (BLL.Usuario.GetInstance.VerificarPatente(MenuUI.GetUsuario, New BE.Patente With {.PatenteId = 2}) = False) Then
            MsgBox("Sus permisos han sido modificados, por favor inicie sesion nuevamente", MsgBoxStyle.Critical, "Error")
            Application.Exit()
        End If
        TraduccionBLL.TraducirForm(Me)
        ObtenerFamilias()
    End Sub
    Private Sub btnRegistrar_Click(sender As Object, e As EventArgs) Handles btnRegistrar.Click
        Dim FamiliaRegistrar As New frmFamiliasMod()
        If FamiliaRegistrar.ShowDialog(Me) = Windows.Forms.DialogResult.OK Then
            ObtenerFamilias()
        End If
    End Sub

    Private Sub dgFamilias_CellContentClick(sender As Object, e As DataGridViewCellEventArgs) Handles dgFamilias.CellContentClick
        Dim id As String = Convert.ToString(dgFamilias.CurrentRow.Cells("id").Value)
        Dim nombre As String = Convert.ToString(dgFamilias.CurrentRow.Cells("Nombre").Value)
        Dim result As Integer

        unaFamilia.familiaId = id
        'MODIFICAR
        If e.ColumnIndex = 3 Then 'Nro Columna del datagriew
            Dim FamiliaModificar As New frmFamiliasMod(id)
            Dim SeguridadBLL As New BLL.Seguridad
            FamiliaModificar.txtnombre.Focus()

            unaFamilia.familiaId = id
            unaFamilia = BLL.Familia.GetInstance().ListById(unaFamilia)

            FamiliaModificar.txtnombre.Text = SeguridadBLL.DesencriptarRSA(unaFamilia.nombre)
            FamiliaModificar.txtdescripcion.Text = unaFamilia.descripcion

            If FamiliaModificar.ShowDialog(Me) = Windows.Forms.DialogResult.OK Then
                ObtenerFamilias()
            End If
        End If
        'ELIMINAR
        If e.ColumnIndex = 4 Then 'Nro Columna del datagriew
            unaFamilia.familiaId = id
            If BLL.Familia.GetInstance.ValidarEliminarFamilia(BLL.Familia.GetInstance.ListById(unaFamilia)) Then
                result = MessageBox.Show("¿Esta seguro que desea eliminar la familia: " & nombre & "?", "Familia", MessageBoxButtons.OKCancel, MessageBoxIcon.Question)
                If result = DialogResult.OK Then
                    BLL.Familia.GetInstance.Delete(unaFamilia)
                    MessageBox.Show(nombre, "Familia", MessageBoxButtons.OK, MessageBoxIcon.Information)
                    RegistrarBitacora(nombre, "Alta")
                End If
            Else
                MsgBox("No se puede eliminar la familia ya que quedarian patentes de asignacion obligatoria sin asignar", MsgBoxStyle.Critical, "Error")
                RegistrarBitacora(nombre, "Alta")
            End If
        End If
            ObtenerFamilias()
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