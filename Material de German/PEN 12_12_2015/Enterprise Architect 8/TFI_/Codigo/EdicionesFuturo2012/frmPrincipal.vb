Imports System.Globalization
Imports System.Resources


Public Class frmPrincipal

    Private Sub ModuloClientesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ModuloClientesToolStripMenuItem.Click
        frmCliente.Show()
    End Sub

    Private Sub frmPrincipal_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        If e.KeyCode = 112 Then
            Help.ShowHelp(Me, BLL.Seguridad.ConsultarHelp().HelpFile, HelpNavigator.TopicId, "Principal")
        End If
    End Sub

    Private Sub ModuloLibrosToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ModuloLibrosToolStripMenuItem.Click
        frmLibro.Show()
    End Sub

    Private Sub BitacoraToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BitacoraToolStripMenuItem.Click

        frmBitacora.Show()
    End Sub

    Private Sub ABMToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ABMToolStripMenuItem.Click
        frmUsuario.Show()
    End Sub

    Private Sub SalirToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SalirToolStripMenuItem.Click

        'Grabo en bitacora al salir del sistema
        Dim objbitacora As New BE.Bitacora
        objbitacora._desc = "Logout Usuario"
        objbitacora._usu_log = frmlogin.TextBox1.Text
        objbitacora._fecha = Now
        objbitacora._usu_id._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
        objbitacora._crit_id._id = BLL.Criticidad.GetInstance.RecuperarId(New BE.Criticidad("Bajo"))
        objbitacora._dvh = BLL.Seguridad.GetInstance.CalcularDVHBitacora(objbitacora)
        BLL.Bitacora.GetInstance.RegistrarBitacora(objbitacora)
        BLL.Seguridad.GetInstance.ReCalcularDVV("BITACORA")
        Me.Close()




    End Sub

    Private Sub AsignarFamiliaToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        frmPatFam.Show()
    End Sub

    Private Sub AsignarQuitarPatenteToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        frmUsuPat.Show()
    End Sub

    Private Sub InglesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles InglesToolStripMenuItem.Click
        frmlogin.RadioButton1.Checked = True
    End Sub

    Private Sub EspanolToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles EspanolToolStripMenuItem.Click
        frmlogin.RadioButton1.Checked = False
        Me.Show()
    End Sub


    Private Sub RecuperarIntegridadToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles RecuperarIntegridadToolStripMenuItem.Click

        Dim TablaList As New List(Of String)
        TablaList.Add("CLIENTE")
        TablaList.Add("USUARIO")
        TablaList.Add("BITACORA")
        TablaList.Add("VENTA")
        TablaList.Add("PAT-FAM")
        TablaList.Add("USU-PAT")
        TablaList.Add("USU-FAM")
        TablaList.Add("PATENTE")
        TablaList.Add("FAMILIA")

        For Each Tabla In TablaList
            BLL.Seguridad.GetInstance.ReCalcularDVV(Tabla)
        Next

        Try
            'Grabo la recuperacion
            Dim objbitacora As New BE.Bitacora
            objbitacora._desc = "Integridad Recuperada"
            objbitacora._usu_log = frmlogin.TextBox1.Text
            objbitacora._fecha = Now
            objbitacora._usu_id._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(frmlogin.TextBox1.Text), BE.Seguridad.Encriptar(frmlogin.TextBox2.Text)))
            objbitacora._crit_id._id = BLL.Criticidad.GetInstance.RecuperarId(New BE.Criticidad("Alto"))
            objbitacora._dvh = BLL.Seguridad.GetInstance.CalcularDVHBitacora(objbitacora)
            BLL.Bitacora.GetInstance.RegistrarBitacora(objbitacora)
            BLL.Seguridad.GetInstance.ReCalcularDVV("BITACORA")
        Catch ex As Exception
            MsgBox(ex)
        End Try

        MsgBox("La Base de Datos se Recupero Correctamente", MsgBoxStyle.Information)

    End Sub

    Private Sub UsuariosToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles UsuariosToolStripMenuItem1.Click
        frmUsuPat.Show()
    End Sub

    Private Sub FamilaPatenteToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles FamilaPatenteToolStripMenuItem.Click
        frmPatFam.Show()
    End Sub

    Private Sub BackupToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BackupToolStripMenuItem.Click
        FrmBackup.Show()
    End Sub

    Private Sub ToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToolStripMenuItem1.Click
        frmRestore.Show()
    End Sub

    Private Sub CriticidadAltaToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CriticidadAltaToolStripMenuItem.Click
        RepBitacora.Show()
    End Sub

    Private Sub SaldoSumatoriaToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SaldoSumatoriaToolStripMenuItem.Click
        RepClientes.Show()
    End Sub

    Private Sub ModuloVentasToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ModuloVentasToolStripMenuItem.Click
        frmVenta.Show()
    End Sub

    Private Sub ModuloSeguridadToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ModuloSeguridadToolStripMenuItem.Click
        If frmlogin.RadioButton1.Checked = False Then
            frmlogin.culture = CultureInfo.CreateSpecificCulture("es-AR")
            BLL.Seguridad.Idioma = "es-AR"
            frmlogin.cambiarIdioma()
        End If
        If frmlogin.RadioButton1.Checked = True Then
            frmlogin.culture = CultureInfo.CreateSpecificCulture("")
            BLL.Seguridad.Idioma = ""
            frmlogin.cambiarIdioma()
        End If
    End Sub


    Private Sub ClientesBorradosToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ClientesBorradosToolStripMenuItem.Click
        RepClientes2.Show()
    End Sub

    Private Sub frmPrincipal_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub

    Private Sub ReporteVentasToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ReporteVentasToolStripMenuItem.Click
        RepLibros.Show()
    End Sub

    Private Sub MenuStrip1_ItemClicked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.ToolStripItemClickedEventArgs) Handles MenuStrip1.ItemClicked

    End Sub
End Class