Public Class UISQLConfig


    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click

        Dim Setconecction As String

        Setconecction = "Data Source=" + txtServidor.Text + ";Initial Catalog=" + txtBaseDatos.Text + ";Trusted_Connection=True"

        Dim file As System.IO.StreamWriter = System.IO.File.CreateText("c:\Ediciones\Ediciones.txt")
        file.WriteLine(BE.Seguridad.Encriptar(Setconecction))
        file.Close()

        frmlogin.Show()


    End Sub

    Private Sub btnClose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClose.Click
        Me.Close()
    End Sub

End Class