Imports System.Globalization
Imports System.Resources

Public Class frmlogin
    Dim objusu As New BE.Usuario
    ''Lo defino globalmente para poder accederlo desde otras UI
    Public Shared oUsr As New BE.Usuario()

    Public Shared culture As CultureInfo
    'Idioma
    Public Sub New()
        InitializeComponent()
        culture = CultureInfo.CurrentCulture
    End Sub

    'Verificaciones Login
    Public Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click

        Dim objcrit As New BE.Criticidad
        Dim objbitacora As New BE.Bitacora
        Me.Timer1.Start()

        Dim usupat As New BE.Usu_Pat

        oUsr._id = 1

        If BLL.Usuario.GetInstance.ValidarUsuario(New BE.Usuario(BE.Seguridad.Encriptar(Me.TextBox1.Text), BE.Seguridad.Encriptar(Me.TextBox2.Text))) Then
            objusu._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(Me.TextBox1.Text), BE.Seguridad.Encriptar(Me.TextBox2.Text)))
            objusu._log = Me.TextBox1.Text
            objusu._pass = Me.TextBox2.Text
            objbitacora._usu_log = Me.TextBox1.Text
            objbitacora._desc = "Login Usuario"
            objbitacora._fecha = Now
            objbitacora._usu_id._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(TextBox1.Text), BE.Seguridad.Encriptar(TextBox2.Text)))
            objbitacora._crit_id._id = BLL.Criticidad.GetInstance.RecuperarId(New BE.Criticidad("Bajo"))
            objbitacora._dvh = BLL.Seguridad.GetInstance.CalcularDVHBitacora(objbitacora)
            BLL.Bitacora.GetInstance.RegistrarBitacora(objbitacora)
            BLL.Seguridad.GetInstance.ReCalcularDVV("BITACORA")

            If objusu.ACTIVO = "Usuario Activo" Then
                objusu._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(Me.TextBox1.Text), BE.Seguridad.Encriptar(Me.TextBox2.Text)))
                objusu._log = Me.TextBox1.Text
                objusu._pass = Me.TextBox2.Text
                ''revisar
                ''  objbitacora._desc = "Usuario Bloqueado"
                objbitacora._fecha = Now
                objbitacora._usu_id._id = BLL.Usuario.GetInstance.RecuperarId(New BE.Usuario(BE.Seguridad.Encriptar(TextBox1.Text), BE.Seguridad.Encriptar(TextBox2.Text)))
                objbitacora._crit_id._id = BLL.Criticidad.GetInstance.RecuperarId(New BE.Criticidad("Alto"))
                objbitacora._dvh = BLL.Seguridad.GetInstance.CalcularDVHBitacora(objbitacora)
                BLL.Bitacora.GetInstance.RegistrarBitacora(objbitacora)
                BLL.Seguridad.GetInstance.ReCalcularDVV("BITACORA")
            End If

            oUsr = BLL.Usuario.Consultar(oUsr, True)

            If Not BLL.Usu_Fam.Consultar(oUsr) Is Nothing Then
                oUsr._fam_id = BLL.Usu_Fam.Consultar(oUsr)
            End If


            BLL.Usuario.GetInstance.Login(objusu)

            frmPrincipal.Show()

            Me.Hide()

        End If

    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click
        Me.Close()
    End Sub

    Private Sub RadioButton1_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles RadioButton1.CheckedChanged
        ''Idioma Ingles
        If RadioButton1.Checked = True Then
            culture = CultureInfo.CreateSpecificCulture("")
            BLL.Seguridad.Idioma = ""
            cambiarIdioma()
        End If
        
        ''Vuelvo al Espanol
        If RadioButton1.Checked = False Then
            culture = CultureInfo.CreateSpecificCulture("es-AR")
            BLL.Seguridad.Idioma = "es-AR"
            cambiarIdioma()
        End If

    End Sub

    Shared Sub cambiarIdioma()

        ''Parametros para Ingles
        If BLL.Seguridad.Idioma = "" Then
            Dim rm As New ResourceManager("UI.idioma", GetType(frmlogin).Assembly)

            ' Tomo valores de recursos
            frmPrincipal.ModuloLibrosToolStripMenuItem.Text = rm.GetString("ModuloLibrosToolStripMenuItem", culture)
            frmPrincipal.ModuloVendedoresToolStripMenuItem.Text = rm.GetString("ModuloVendedoresToolStripMenuItem", culture)
            frmPrincipal.ModuloVentasToolStripMenuItem.Text = rm.GetString("ModuloVentasToolStripMenuItem", culture)
            frmPrincipal.ModuloSeguridadToolStripMenuItem.Text = rm.GetString("ModuloSeguridadToolStripMenuItem", culture)
            frmPrincipal.ModuloReportesToolStripMenuItem.Text = rm.GetString("ModuloReportesToolStripMenuItem", culture)
            frmPrincipal.SalirToolStripMenuItem.Text = rm.GetString("SalirToolStripMenuItem", culture)
            ''-----------------------------------------MODULO CLIENTES------------------------------------------------------
            frmPrincipal.ModuloClientesToolStripMenuItem.Text = rm.GetString("ModuloClientesToolStripMenuItem", culture)
            frmCliente.btnClieAlta.Text = rm.GetString("btnClieAlta", culture)
            frmCliente.btnCliebaja.Text = rm.GetString("btnCliebaja", culture)
            frmCliente.btnClieMod.Text = rm.GetString("btnClieMod", culture)
            frmCliente.btnClieList.Text = rm.GetString("btnClieList", culture)
            frmCliente.lblNom.Text = rm.GetString("lblNom", culture)
            frmCliente.lblemail.Text = rm.GetString("lblemail", culture)
            frmCliente.lblApe.Text = rm.GetString("lblApe", culture)
            frmCliente.lblDni.Text = rm.GetString("lblDni", culture)
            'frmCliente.lblsaldo.Text = rm.GetString("lblsaldo", culture)
            frmCliente.lblfec.Text = rm.GetString("lblfec", culture)
            frmCliente.lbldir.Text = rm.GetString("lbldir", culture)
            frmCliente.lblListadoClientes.Text = rm.GetString("lblListadoClientes", culture)
            frmCliente.lbltel.Text = rm.GetString("lbltel", culture)
            'frmCliente.lblLib.Text = rm.GetString("lblLib", culture)
            frmCliente.Text = rm.GetString("frmcliente", culture)
            ''-----------------------------------------MODULO VENTAS------------------------------------------------------
            frmVenta.lblCliente.Text = rm.GetString("lblCliente", culture)
            frmVenta.lblCuotas.Text = rm.GetString("lblCuotas", culture)
            frmVenta.lblFecha.Text = rm.GetString("lblFecha", culture)
            frmVenta.lblImporte.Text = rm.GetString("lblImporte", culture)
            frmVenta.lblLibro.Text = rm.GetString("lblLibro", culture)
            frmVenta.lblVendedor.Text = rm.GetString("lblVendedor", culture)
            frmVenta.btnAlta.Text = rm.GetString("btnalta", culture)
            frmVenta.btnBaja.Text = rm.GetString("btnBaja", culture)
            frmVenta.btnListar.Text = rm.GetString("btnListar", culture)
            frmVenta.btnModificar.Text = rm.GetString("btnModificar", culture)
            '-----------------------------------------MODULO LIBROS--------------------------------------------------------
            frmLibro.lblcantidad.Text = rm.GetString("lblcantidad", culture)
            frmLibro.lbldesc.Text = rm.GetString("lbldesc", culture)
            frmLibro.lbleditorial.Text = rm.GetString("lbleditorial", culture)
            frmLibro.lblprecio.Text = rm.GetString("lblprecio", culture)
            frmLibro.btnalta.Text = rm.GetString("btnalta", culture)
            frmLibro.btnBaja.Text = rm.GetString("btnBaja", culture)
            frmLibro.btnModificar.Text = rm.GetString("btnModificar", culture)
            frmLibro.btnListar.Text = rm.GetString("btnListar", culture)
            '-----------------------------------------MODULO BITACORA--------------------------------------------------------
            frmBitacora.lblDesde.Text = rm.GetString("lblDesde", culture)
            frmBitacora.lblHasta.Text = rm.GetString("lblHasta", culture)
            frmBitacora.lblNivel.Text = rm.GetString("lblNivel", culture)
            frmBitacora.lblSeleccionarCrit.Text = rm.GetString("lblSeleccionarCrit", culture)
            frmBitacora.lblSeleccionarFec.Text = rm.GetString("lblSeleccionarFec", culture)
            frmBitacora.lblSeleccionarUsuario.Text = rm.GetString("lblSeleccionarUsuario", culture)
            frmBitacora.lblUsuario.Text = rm.GetString("lblUsuario", culture)
            frmBitacora.btnListarTodos.Text = rm.GetString("btnListarTodos", culture)
            '-----------------------------------------MODULO SEGURIDAD------------------------------------------------------
            frmPrincipal.UsuariosToolStripMenuItem.Text = rm.GetString("UsuariosToolStripMenuItem", culture)
            frmPrincipal.CambiarClaveToolStripMenuItem.Text = rm.GetString("CambiarClaveToolStripMenuItem", culture)
            frmPrincipal.BitacoraToolStripMenuItem.Text = rm.GetString("BitacoraToolStripMenuItem", culture)
            frmPrincipal.FamiliaToolStripMenuItem.Text = rm.GetString("FamiliaToolStripMenuItem", culture)
            frmPrincipal.UsuariosToolStripMenuItem1.Text = rm.GetString("UsuariosToolStripMenuItem", culture)
            frmPrincipal.FamilaPatenteToolStripMenuItem.Text = rm.GetString("FamilaPatenteToolStripMenuItem", culture)
            frmPrincipal.CambiarIdiomaToolStripMenuItem.Text = rm.GetString("CambiarIdiomaToolStripMenuItem", culture)
            frmPrincipal.RecuperarIntegridadToolStripMenuItem.Text = rm.GetString("RecuperarIntegridadToolStripMenuItem", culture)
            frmPrincipal.ClientesToolStripMenuItem.Text = rm.GetString("ClientesToolStripMenuItem", culture)
            frmPrincipal.BitacoraToolStripMenuItem1.Text = rm.GetString("BitacoraToolStripMenuItem1", culture)
            frmPrincipal.SaldoSumatoriaToolStripMenuItem.Text = rm.GetString("SaldoSumatoriaToolStripMenuItem", culture)
            frmPrincipal.CriticidadAltaToolStripMenuItem.Text = rm.GetString("CriticidadAltaToolStripMenuItem", culture)

        End If

        ''Parametros para espanol
        If BLL.Seguridad.Idioma = "es-AR" Then
            Dim rm As New ResourceManager("UI.Espanol", GetType(frmlogin).Assembly)
            ' Tomo valores de recursos

            frmPrincipal.ModuloClientesToolStripMenuItem.Text = rm.GetString("ModuloClientesToolStripMenuItem", culture)
            frmPrincipal.ModuloLibrosToolStripMenuItem.Text = rm.GetString("ModuloLibrosToolStripMenuItem", culture)
            frmPrincipal.ModuloVendedoresToolStripMenuItem.Text = rm.GetString("ModuloVendedoresToolStripMenuItem", culture)
            frmPrincipal.ModuloVentasToolStripMenuItem.Text = rm.GetString("ModuloVentasToolStripMenuItem", culture)
            frmPrincipal.ModuloSeguridadToolStripMenuItem.Text = rm.GetString("ModuloSeguridadToolStripMenuItem", culture)
            frmPrincipal.ModuloReportesToolStripMenuItem.Text = rm.GetString("ModuloReportesToolStripMenuItem", culture)
            frmPrincipal.SalirToolStripMenuItem.Text = rm.GetString("SalirToolStripMenuItem", culture)

            '-----------------------------------------MODULO CLIENTES------------------------------------------------------
            frmPrincipal.ModuloClientesToolStripMenuItem.Text = rm.GetString("ModuloClientesToolStripMenuItem", culture)
            frmCliente.btnClieAlta.Text = rm.GetString("btnClieAlta", culture)
            frmCliente.btnCliebaja.Text = rm.GetString("btnCliebaja", culture)
            frmCliente.btnClieMod.Text = rm.GetString("btnClieMod", culture)
            frmCliente.btnClieList.Text = rm.GetString("btnClieList", culture)
            frmCliente.lblNom.Text = rm.GetString("lblNom", culture)
            frmCliente.lblemail.Text = rm.GetString("lblemail", culture)
            frmCliente.lblApe.Text = rm.GetString("lblApe", culture)
            frmCliente.lblDni.Text = rm.GetString("lblDni", culture)
            'frmCliente.lblsaldo.Text = rm.GetString("lblsaldo", culture)
            frmCliente.lblfec.Text = rm.GetString("lblfec", culture)
            frmCliente.lbldir.Text = rm.GetString("lbldir", culture)
            frmCliente.lblListadoClientes.Text = rm.GetString("lblListadoClientes", culture)
            frmCliente.lbltel.Text = rm.GetString("lbltel", culture)
            'frmCliente.lblLib.Text = rm.GetString("lblLib", culture)
            frmCliente.Text = rm.GetString("frmcliente", culture)
            '-----------------------------------------MODULO VENTAS------------------------------------------------------
            frmVenta.lblCliente.Text = rm.GetString("lblCliente", culture)
            frmVenta.lblCuotas.Text = rm.GetString("lblCuotas", culture)
            frmVenta.lblFecha.Text = rm.GetString("lblFecha", culture)
            frmVenta.lblImporte.Text = rm.GetString("lblImporte", culture)
            frmVenta.lblLibro.Text = rm.GetString("lblLibro", culture)
            frmVenta.lblVendedor.Text = rm.GetString("lblVendedor", culture)
            frmVenta.btnAlta.Text = rm.GetString("btnalta", culture)
            frmVenta.btnBaja.Text = rm.GetString("btnBaja", culture)
            frmVenta.btnListar.Text = rm.GetString("btnListar", culture)
            frmVenta.btnModificar.Text = rm.GetString("btnModificar", culture)
            '-----------------------------------------MODULO LIBROS--------------------------------------------------------
            frmLibro.lblcantidad.Text = rm.GetString("lblcantidad", culture)
            frmLibro.lbldesc.Text = rm.GetString("lbldesc", culture)
            frmLibro.lbleditorial.Text = rm.GetString("lbleditorial", culture)
            frmLibro.lblprecio.Text = rm.GetString("lblprecio", culture)
            frmLibro.btnalta.Text = rm.GetString("btnalta", culture)
            frmLibro.btnBaja.Text = rm.GetString("btnBaja", culture)
            frmLibro.btnModificar.Text = rm.GetString("btnModificar", culture)
            frmLibro.btnListar.Text = rm.GetString("btnListar", culture)
            '-----------------------------------------MODULO BITACORA--------------------------------------------------------
            frmBitacora.lblDesde.Text = rm.GetString("lblDesde", culture)
            frmBitacora.lblHasta.Text = rm.GetString("lblHasta", culture)
            frmBitacora.lblNivel.Text = rm.GetString("lblNivel", culture)
            frmBitacora.lblSeleccionarCrit.Text = rm.GetString("lblSeleccionarCrit", culture)
            frmBitacora.lblSeleccionarFec.Text = rm.GetString("lblSeleccionarFec", culture)
            frmBitacora.lblSeleccionarUsuario.Text = rm.GetString("lblSeleccionarUsuario", culture)
            frmBitacora.lblUsuario.Text = rm.GetString("lblUsuario", culture)
            frmBitacora.btnListarTodos.Text = rm.GetString("btnListarTodos", culture)
            '-----------------------------------------MODULO SEGURIDAD------------------------------------------------------
            frmPrincipal.UsuariosToolStripMenuItem.Text = rm.GetString("UsuariosToolStripMenuItem", culture)
            frmPrincipal.CambiarClaveToolStripMenuItem.Text = rm.GetString("CambiarClaveToolStripMenuItem", culture)
            frmPrincipal.BitacoraToolStripMenuItem.Text = rm.GetString("BitacoraToolStripMenuItem", culture)
            frmPrincipal.FamiliaToolStripMenuItem.Text = rm.GetString("FamiliaToolStripMenuItem", culture)
            frmPrincipal.UsuariosToolStripMenuItem1.Text = rm.GetString("UsuariosToolStripMenuItem", culture)
            frmPrincipal.FamilaPatenteToolStripMenuItem.Text = rm.GetString("FamilaPatenteToolStripMenuItem", culture)
            frmPrincipal.CambiarIdiomaToolStripMenuItem.Text = rm.GetString("CambiarIdiomaToolStripMenuItem", culture)
            frmPrincipal.RecuperarIntegridadToolStripMenuItem.Text = rm.GetString("RecuperarIntegridadToolStripMenuItem", culture)
            frmPrincipal.ClientesToolStripMenuItem.Text = rm.GetString("ClientesToolStripMenuItem", culture)
            frmPrincipal.BitacoraToolStripMenuItem1.Text = rm.GetString("BitacoraToolStripMenuItem1", culture)
            frmPrincipal.SaldoSumatoriaToolStripMenuItem.Text = rm.GetString("SaldoSumatoriaToolStripMenuItem", culture)
            frmPrincipal.CriticidadAltaToolStripMenuItem.Text = rm.GetString("CriticidadAltaToolStripMenuItem", culture)

        End If


    End Sub


    Private Sub frmlogin_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        TextBox1.Visible = False
        TextBox2.Visible = False
        Dim objbitacora As New BE.Bitacora

        'verifico integridad de la base
        Me.Timer1.Start()
        Timer1.Enabled = True


        If VerificarIntegridad() = True Then
            Dim regafectado As String = ""
            Dim tabla As String = ""

            For Each tabs In tablasAfectadas
                tabla = tabla + tabs + ","
            Next
            Try

            objbitacora._desc = "Error de Integridad en la Base"
            objbitacora._fecha = Now
                objbitacora._crit_id._id = BLL.Criticidad.GetInstance.RecuperarId(New BE.Criticidad("Alto"))
            BLL.Seguridad.GetInstance.CalcularDVHBitacora(objbitacora)
            BLL.Bitacora.GetInstance.RegistrarBitacora(objbitacora)
                BLL.Seguridad.GetInstance.ReCalcularDVV("BITACORA")
                'BLL.Bitacora.GetInstance.RegistrarBitacora(objbitacora)
            Catch ex As Exception
                MsgBox(ex)
            End Try

            MsgBox(String.Format("Se encontraron errores de integridad en las siguientes tablas: {0}", tabla), MsgBoxStyle.Critical)


            MsgBox("Por favor inicie sesión como Administrador del sistema para solucionar esta situación.", MsgBoxStyle.Critical)

            Me.TextBox1.Text = "lcontino"
            Me.TextBox1.Enabled = False
        Else
            Label3.Text = "........Puede comenzar a utilizar el Sistema"
            Exit Sub
        End If
    End Sub
    ''para verificacion de integraidad
    Dim tablasAfectadas As New List(Of String)
    Dim regafectado As New List(Of String)

    Private Function VerificarIntegridad() As Boolean
        tablasAfectadas = BLL.Seguridad.GetInstance.VerificarIntegridad
        If tablasAfectadas Is Nothing Then
            Return False
        Else
            Return True
        End If
    End Function
    Private Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Timer1.Tick

        Me.ProgressBar1.Maximum = 5

        ''Progess Bar
        Me.Timer1.Interval = 1000
        If ProgressBar1.Value < 5 Then
            ProgressBar1.Value = ProgressBar1.Value + 1

        ElseIf ProgressBar1.Value = 5 Then
            Timer1.Enabled = False
            'BLL.Seguridad.CargaErrorIntegridad(BLL.Seguridad.VerificarIntegridad())
            If BLL.Seguridad.EstadoIntegridadBaseDeDatos = False Then
                Label3.Text = "........Puede comenzar a utilizar el Sistema"
            ElseIf BLL.Seguridad.EstadoIntegridadBaseDeDatos = True Then
                Label3.Text = "........Se encontro una inconsistencia de datos en la base"
            End If
            TextBox1.Visible = True
            TextBox2.Visible = True
        End If
        
    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Me.Timer1.Start()
    End Sub

    Private Sub Button2_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs)
        UISQLConfig.Show()
    End Sub
End Class