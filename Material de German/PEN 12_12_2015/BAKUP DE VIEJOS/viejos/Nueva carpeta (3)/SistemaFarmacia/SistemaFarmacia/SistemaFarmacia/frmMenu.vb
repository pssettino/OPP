Public Class frmMenu
    Dim UsuarioBE As BE.Usuario
    Dim IdiomaBE As BE.Idioma
    Dim BitacoraBE As New BE.Bitacora
    Dim TraduccionBLL As BLL.Traduccion
    Dim PatenteBE As New BE.Patente

    Public Sub New(ByVal _usuarioBE As BE.Usuario, ByVal _idiomaBE As BE.Idioma)
        InitializeComponent()
        UsuarioBE = _usuarioBE
        IdiomaBE = _idiomaBE
        ValidarMenu()
    End Sub

    Private Sub frmMenu_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        TraduccionBLL = New BLL.Traduccion(GetIdioma)
        TraduccionBLL.TraducirForm(Me)
        Me.WindowState = FormWindowState.Maximized
    End Sub

    Public Sub ValidarMenu()

        PatenteBE.Nombre = "Usuario"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) Then
            SeguridadToolStripMenuItem.Enabled = True
            UsuariosToolStripMenuItem.Enabled = True
        End If

        PatenteBE.Nombre = "Familia"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) Then
            SeguridadToolStripMenuItem.Enabled = True
            AdministrarFamiliasToolStripMenuItem.Enabled = True
        End If

        PatenteBE.Nombre = "Backup"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) Then
            SeguridadToolStripMenuItem.Enabled = True
            BackupToolStripMenuItem.Enabled = True
        End If

        PatenteBE.Nombre = "Restore"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) Then
            SeguridadToolStripMenuItem.Enabled = True
            RestoreToolStripMenuItem.Enabled = True
        End If

        PatenteBE.Nombre = "Bitacora"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) Then
            SeguridadToolStripMenuItem.Enabled = True
            BitacoraToolStripMenuItem.Enabled = True
        End If

        PatenteBE.Nombre = "Venta"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) Then
            VentasToolStripMenuItem.Enabled = True
        End If

        PatenteBE.Nombre = "Cliente"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) Then
            ClientesToolStripMenuItem.Enabled = True
        End If

        PatenteBE.Nombre = "Medicamento"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) Then
            MedicamentosToolStripMenuItem.Enabled = True
        End If

        SeguridadToolStripMenuItem.Enabled = True
        CambiarContraseñaToolStripMenuItem.Enabled = True
    End Sub

    Public Function GetUsuario() As BE.Usuario
        Return UsuarioBE
    End Function

    Public Function GetIdioma() As BE.Idioma
        Return IdiomaBE
    End Function

    Private Sub VentasToolStripMenuItem1_Click(sender As Object, e As EventArgs) Handles VentasToolStripMenuItem1.Click
        UI.frmVentas.MdiParent = Me
        UI.frmVentas.Show()
    End Sub

    Private Sub MedicamentosToolStripMenuItem1_Click(sender As Object, e As EventArgs) Handles MedicamentosToolStripMenuItem1.Click
        UI.frmMedicamentos.MdiParent = Me
        UI.frmMedicamentos.Show()
    End Sub

    Private Sub ClientesToolStripMenuItem1_Click(sender As Object, e As EventArgs) Handles ClientesToolStripMenuItem1.Click
        UI.frmClientes.MdiParent = Me
        UI.frmClientes.Show()
    End Sub

    Private Sub BackupToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles BackupToolStripMenuItem.Click
        UI.frmBackup.MdiParent = Me
        UI.frmBackup.Show()
    End Sub

    Private Sub BitacoraToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles BitacoraToolStripMenuItem.Click
        UI.frmBitacora.MdiParent = Me
        UI.frmBitacora.Show()
    End Sub

    Private Sub CambiarContraseñaToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles CambiarContraseñaToolStripMenuItem.Click
        UI.frmCambiarContraseña.MdiParent = Me
        UI.frmCambiarContraseña.Show()
    End Sub

    Private Sub UsuariosToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles UsuariosToolStripMenuItem.Click
        UI.frmUsuarios.MdiParent = Me
        UI.frmUsuarios.Show()
    End Sub


    Private Sub AdministrarFamiliasToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles AdministrarFamiliasToolStripMenuItem.Click
        UI.frmFamilias.MdiParent = Me
        UI.frmFamilias.Show()
    End Sub

    Private Sub SalirToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles SalirToolStripMenuItem.Click
        Dim result As Integer = MessageBox.Show(TraduccionBLL.TraducirTexto("¿Esta seguro que desea salir?"), TraduccionBLL.TraducirTexto("Salir"), MessageBoxButtons.OKCancel, MessageBoxIcon.Question)
        If result = DialogResult.OK Then
            Dim SeguridadBLL As New BLL.Seguridad
            RegistrarBitacora("LogOut", "Baja")
            Application.Exit()
        End If
    End Sub

    Private Sub RestoreToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles RestoreToolStripMenuItem.Click
        UI.frmRestore.MdiParent = Me
        UI.frmRestore.Show()
    End Sub

    Public Sub RegistrarBitacora(evento As String, nivel As String)
        Dim SeguridadBLL As New BLL.Seguridad
        BitacoraBE.descripcion = SeguridadBLL.EncriptarRSA(evento)
        BitacoraBE.usuario = GetUsuario()
        BitacoraBE.criticidad = nivel
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE)
    End Sub
 
    Private Sub VerLaAyudaToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles VerLaAyudaToolStripMenuItem.Click
        HelpProvider1.SetShowHelp(Me, True)
    End Sub
End Class
