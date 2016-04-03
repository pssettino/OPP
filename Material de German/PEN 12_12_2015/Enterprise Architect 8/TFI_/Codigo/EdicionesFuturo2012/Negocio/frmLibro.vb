Public Class frmLibro

#Region "ABM LIBROS"

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnalta.Click

        Dim objlib As New BE.Libro
        objlib._cant = txtCant.Text
        objlib._desc = txtDesc.Text
        objlib._editorial = txtEdit.Text
        objlib._precio = txtPrecio.Text
        BLL.Libro.GetInstance.Alta(objlib)

    End Sub

    Private Sub Button1_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnListar.Click
        DataGridView1.DataSource = BLL.Libro.GetInstance.Listar()

        DataGridView1.Columns(2).HeaderText = "Cantidad"
        DataGridView1.Columns(3).HeaderText = "Descripcion"
        DataGridView1.Columns(4).HeaderText = "Precio"
        DataGridView1.Columns(0).HeaderText = "Numero Volumen"
        DataGridView1.Columns(5).HeaderText = "Editorial"
        DataGridView1.Columns(1).Visible = False
        DataGridView1.Columns(1).Visible = False
        DataGridView1.Columns(1).HeaderText = "Estado"

        For i = 0 To DataGridView1.Rows.Count - 1
            If DataGridView1.Item(2, i).Value < 0 Then
                DataGridView1.Rows(i).Cells(2).Style.BackColor = Color.Red
            End If
        Next







    End Sub

    'Ayuda
    Private Sub frmLibro_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        If e.KeyCode = 112 Then
            Help.ShowHelp(Me, BLL.Seguridad.ConsultarHelp().HelpFile, HelpNavigator.TopicId, "5")
        End If
    End Sub
#End Region

#Region "Load"
    Private Sub frmLibro_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        Dim objPat As New BE.Patente
        Dim usu As New BE.Usuario

        ' Permisos del form
        objPat._id = 4
        usu._id = BLL.Usuario.GetInstance.RecuperarID(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
        objPat._desc = "Alta Libro"
        If BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = True Then
            If BLL.Seguridad.GetInstance.VerificarPermisosNegUsuPat(objPat, usu) = False Then
                btnalta.Enabled = False
            Else
                btnalta.Enabled = True
            End If
        ElseIf BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = False Then
            If BLL.Seguridad.GetInstance.VerificarPermisosUsuPat(objPat, usu) = True Then
                btnalta.Enabled = True
            Else
                btnalta.Enabled = False
            End If
        End If

        objPat._id = 5
        objPat._desc = "Baja Libro"
        If BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = True Then
            If BLL.Seguridad.GetInstance.VerificarPermisosNegUsuPat(objPat, usu) = False Then
                btnBaja.Enabled = False
            Else
                btnBaja.Enabled = True
            End If
        ElseIf BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = False Then
            If BLL.Seguridad.GetInstance.VerificarPermisosUsuPat(objPat, usu) = True Then
                btnBaja.Enabled = True
            Else
                btnBaja.Enabled = False
            End If
        End If

        objPat._id = 6
        objPat._desc = "Modificar Libro"
        If BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = True Then
            If BLL.Seguridad.GetInstance.VerificarPermisosNegUsuPat(objPat, usu) = False Then
                btnModificar.Enabled = False
            Else
                btnModificar.Enabled = True
            End If
        ElseIf BLL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(objPat, usu) = False Then
            If BLL.Seguridad.GetInstance.VerificarPermisosUsuPat(objPat, usu) = True Then
                btnModificar.Enabled = True
            Else
                btnModificar.Enabled = False
            End If
        End If
    End Sub
#End Region

End Class