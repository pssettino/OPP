Imports System.Text
Imports System
Imports Microsoft.VisualBasic
Imports System.Data.SqlClient

Public Class Seguridad

#Region "Singleton"
    Private Sub New()

    End Sub
    Public Shared Function GetInstance() As BLL.Seguridad


        If instancia Is Nothing Then

            instancia = New BLL.Seguridad

        End If

        Return instancia

    End Function
    Private Shared instancia As BLL.Seguridad
    Shared Property Idioma As String
#End Region

#Region "Encripcion"
    Public Function Desencriptar() As System.Collections.Generic.List(Of BE.Cliente)
        Return DAL.Cliente.GetInstance.Listar()
    End Function
#End Region

#Region "Calculos DVH"
    Public Function CalcularDVHCliente(ByVal registro As Object) As Integer
        Dim retorno As Integer
        Try
            retorno = DAL.Seguridad.GetInstance.CalcularDVHCliente(registro)
        Catch ex As Exception
            Throw ex
        End Try
        Return retorno
    End Function
    Public Function CalcularDVHVentas(ByVal registro As Object) As Integer
        Dim retorno As Integer
        Try
            retorno = DAL.Seguridad.GetInstance.CalcularDVHVentas(registro)
        Catch ex As Exception
            Throw ex
        End Try
        Return retorno
    End Function
    Public Function CalcularDVHUsuario(ByVal registro As Object) As Integer
        Dim retorno As Integer
        Try
            retorno = DAL.Seguridad.GetInstance.CalcularDVHUsuario(registro)
        Catch ex As Exception
            Throw ex
        End Try
        Return retorno
    End Function
    Public Function CalcularDVHBitacora(ByVal registro As Object) As Integer
        Dim retorno As Integer
        Try
            retorno = DAL.Seguridad.GetInstance.CalcularDVHBitacora(registro)
        Catch ex As Exception
            Throw ex
        End Try
        Return retorno
    End Function
    Public Function CalcularDVHPatente(ByVal registro As Object) As Integer
        Dim retorno As Integer
        Try
            retorno = DAL.Seguridad.GetInstance.CalcularDVHPatente(registro)
        Catch ex As Exception
            Throw ex
        End Try
        Return retorno
    End Function
    Public Function CalcularDVHFamilia(ByVal registro As Object) As Integer
        Dim retorno As Integer
        Try
            retorno = DAL.Seguridad.GetInstance.CalcularDVHFamilia(registro)
        Catch ex As Exception
            Throw ex
        End Try
        Return retorno
    End Function
    Public Function CalcularDVH_PatFam(ByVal registro As Object) As Integer
        Dim retorno As Integer
        Try
            retorno = DAL.Seguridad.GetInstance.CalcularDVH_PatFam(registro)
        Catch ex As Exception
            Throw ex
        End Try
        Return retorno
    End Function
    Public Function CalcularDVH_UsuPat(ByVal registro As Object) As Integer
        Dim retorno As Integer
        Try
            retorno = DAL.Seguridad.GetInstance.CalcularDVH_UsuPat(registro)
        Catch ex As Exception
            Throw ex
        End Try
        Return retorno
    End Function
    Public Function CalcularDVH_UsuFam(ByVal registro As Object) As Integer
        Dim retorno As Integer
        Try
            retorno = DAL.Seguridad.GetInstance.CalcularDVH_UsuFam(registro)
        Catch ex As Exception
            Throw ex
        End Try
        Return retorno
    End Function
#End Region

#Region "Verificar integridad TABLAS"
    Public Function VerificarIntegridad() As List(Of String)
        Dim tablasAfectadas As New List(Of String)
        Dim registroafec As String

        Dim DVH As Integer = 0
        Dim DVV As Integer = 0


        Dim TablaList As New List(Of String)

        TablaList.Add("CLIENTE")
        TablaList.Add("USUARIO")
        TablaList.Add("BITACORA")
        TablaList.Add("PAT-FAM")
        TablaList.Add("VENTA")
        TablaList.Add("USU-PAT")
        TablaList.Add("USU-FAM")
        TablaList.Add("PATENTE")
        TablaList.Add("FAMILIA")


        For Each Tabla In TablaList
            Select Case Tabla
                Case "CLIENTE"
                    DVH = 0
                    DVV = DAL.Seguridad.GetInstance.VerificarIntegridad("CLIENTE")
                    For Each Cliente In DAL.Cliente.GetInstance.Listar
                        DVH = DVH + Seguridad.GetInstance.CalcularDVHCliente(Cliente)
                    Next
                    If DVH <> DVV Then
                        tablasAfectadas.Add("CLIENTE")
                    End If
                Case "USUARIO"
                    DVH = 0
                    DVV = DAL.Seguridad.GetInstance.VerificarIntegridad("USUARIO")
                    For Each usuario In DAL.Usuario.GetInstance.Listar
                        'Voy calculando el dvh de cada registro de la tabla y acumulando el rdo en la variable DVH
                        DVH = DVH + Seguridad.GetInstance.CalcularDVHUsuario(usuario)
                    Next
                    'Comparo el rdo acumulado de la variable DVH con el dato de SUMA para la tabla que tengo guardado en la tabla DVV
                    If DVH <> DVV Then
                        tablasAfectadas.Add("USUARIO")
                    End If
                Case "BITACORA"
                    DVH = 0
                    DVV = DAL.Seguridad.GetInstance.VerificarIntegridad("BITACORA")
                    For Each bit In DAL.Bitacora.GetInstance.Listar
                        'Voy calculando el dvh de cada registro de la tabla y acumulando el rdo en la variable DVH
                        DVH = DVH + Seguridad.GetInstance.CalcularDVHBitacora(bit)
                    Next
                    'Comparo el rdo acumulado de la variable DVH con el dato de SUMA para la tabla que tengo guardado en la tabla DVV
                    If DVH <> DVV Then
                        tablasAfectadas.Add("BITACORA")
                    End If
                Case "PAT-FAM"
                    DVH = 0
                    DVV = DAL.Seguridad.GetInstance.VerificarIntegridad("PAT-FAM")
                    For Each fam In DAL.pat_fam.GetInstance.Listar
                        DVH = DVH + Seguridad.GetInstance.CalcularDVH_PatFam(fam)
                    Next
                    If DVH <> DVV Then
                        tablasAfectadas.Add("PAT-FAM")
                    End If
                Case "USU-PAT"
                    DVH = 0
                    DVV = DAL.Seguridad.GetInstance.VerificarIntegridad("USU-PAT")
                    For Each usupat In DAL.usu_pat.GetInstance.Listar
                        DVH = DVH + Seguridad.GetInstance.CalcularDVH_UsuPat(usupat)
                    Next
                    If DVH <> DVV Then
                        tablasAfectadas.Add("USU-PAT")
                    End If
                Case "USU-FAM"
                    DVH = 0
                    DVV = DAL.Seguridad.GetInstance.VerificarIntegridad("USU-FAM")
                    For Each usufam In DAL.Usu_fam.GetInstance.Listar
                        DVH = DVH + Seguridad.GetInstance.CalcularDVH_UsuFam(usufam)
                    Next
                    If DVH <> DVV Then
                        tablasAfectadas.Add("USU-FAM")
                    End If
                Case "VENTA"
                    DVH = 0
                    DVV = DAL.Seguridad.GetInstance.VerificarIntegridad("VENTA")
                    For Each venta In DAL.Venta.GetInstance.Listar
                        DVH = DVH + Seguridad.GetInstance.CalcularDVHVentas(venta)
                    Next
                    If DVH <> DVV Then
                        tablasAfectadas.Add("VENTA")
                    End If
                Case "PATENTE"
                    DVH = 0
                    DVV = DAL.Seguridad.GetInstance.VerificarIntegridad("PATENTE")
                    For Each patente In DAL.Patente.GetInstance.Listar
                        DVH = DVH + Seguridad.GetInstance.CalcularDVHPatente(patente)
                    Next
                    If DVH <> DVV Then
                        tablasAfectadas.Add("PATENTE")
                    End If
                Case "FAMILIA"
                    DVH = 0
                    DVV = DAL.Seguridad.GetInstance.VerificarIntegridad("FAMILIA")
                    For Each familia In DAL.Familia.GetInstance.Listar
                        DVH = DVH + Seguridad.GetInstance.CalcularDVHFamilia(familia)
                    Next
                    If DVH <> DVV Then
                        tablasAfectadas.Add("FAMILIA")
                    End If
            End Select
        Next
        If tablasAfectadas.Count = 0 Then
            Return Nothing
        Else
            Return tablasAfectadas
        End If
    End Function

    Public Shared IntegridadBaseDeDatos As Boolean

    Public Shared Sub CargaErrorIntegridad(ByVal EstadoIntegridad As Boolean)
        IntegridadBaseDeDatos = EstadoIntegridad
    End Sub

    Public Shared Function EstadoIntegridadBaseDeDatos() As Boolean
        Return IntegridadBaseDeDatos
    End Function
#End Region

#Region "Reparar Integridad"
    Shared Function RepararIntegridad() As Boolean
        Return DAL.Seguridad.GetInstance.RepararIntegridad()
    End Function

    'Recalculo DVV Tablas
    Public Sub ReCalcularDVV(ByVal tabla As String)
        Dim DVH As Integer = 0


        Select Case tabla
            Case "CLIENTE"
                For Each cliente In DAL.Cliente.GetInstance.Listar
                    ''Voy calculando el dvh de cada registro de la tabla y acumulando el rdo en la variable DVH
                    DVH = DVH + Me.CalcularDVHCliente(cliente)
                    cliente._dvh = Me.CalcularDVHCliente(cliente)
                    DAL.Cliente.GetInstance.Modificar(cliente)
                Next
                DAL.Seguridad.GetInstance.ReCalcularDVV(DVH, tabla)
            Case "USUARIO"
                For Each usuario In DAL.Usuario.GetInstance.Listar
                    ''Voy calculando el dvh de cada registro de la tabla y acumulando el rdo en la variable DVH
                    DVH = DVH + Me.CalcularDVHUsuario(usuario)
                    usuario._dvh = Me.CalcularDVHUsuario(usuario)
                    DAL.Usuario.GetInstance.Modificar(usuario)
                Next
                DAL.Seguridad.GetInstance.ReCalcularDVV(DVH, tabla)
            Case "BITACORA"
                For Each bit In DAL.Bitacora.GetInstance.Listar
                    ''Voy calculando el dvh de cada registro de la tabla y acumulando el rdo en la variable DVH
                    DVH = DVH + Me.CalcularDVHBitacora(bit)
                    'DVH = DVH + cliente._dvh
                Next
                DAL.Seguridad.GetInstance.ReCalcularDVV(DVH, tabla)
            Case "PAT-FAM"
                For Each fam In DAL.pat_fam.GetInstance.Listar
                    ''Voy calculando el dvh de cada registro de la tabla y acumulando el rdo en la variable DVH
                    DVH = DVH + Me.CalcularDVH_PatFam(fam)
                    fam._dvh = Me.CalcularDVH_PatFam(fam)
                    DAL.pat_fam.GetInstance.Actualizar(fam)
                Next
                DAL.Seguridad.GetInstance.ReCalcularDVV(DVH, tabla)
            Case "USU-PAT"
                For Each up In DAL.usu_pat.GetInstance.Listar
                    ''Voy calculando el dvh de cada registro de la tabla y acumulando el rdo en la variable DVH
                    DVH = DVH + Me.CalcularDVH_UsuPat(up)
                    up._dvh = Me.CalcularDVH_UsuPat(up)
                    DAL.usu_pat.GetInstance.Actualizar(up)
                Next
                DAL.Seguridad.GetInstance.ReCalcularDVV(DVH, tabla)
            Case "USU-FAM"
                DVH = 0
                For Each uf In DAL.Usu_fam.GetInstance.Listar

                    ''Voy calculando el dvh de cada registro de la tabla y acumulando el rdo en la variable DVH
                    DVH = DVH + Me.CalcularDVH_UsuFam(uf)
                    uf._dvh = Me.CalcularDVH_UsuFam(uf)
                    DAL.Usu_fam.GetInstance.Actualizar(uf)
                Next
                DAL.Seguridad.GetInstance.ReCalcularDVV(DVH, tabla)
            Case "VENTA"
                For Each ventas In DAL.Venta.GetInstance.Listar
                    ''Voy calculando el dvh de cada registro de la tabla y acumulando el rdo en la variable DVH
                    DVH = DVH + Me.CalcularDVHVentas(ventas)
                    ventas._dvh = Me.CalcularDVHVentas(ventas)
                    DAL.Venta.GetInstance.Actualizar(ventas)
                Next
                DAL.Seguridad.GetInstance.ReCalcularDVV(DVH, tabla)
            Case "PATENTE"
                For Each patente In DAL.Patente.GetInstance.Listar
                    ''Voy calculando el dvh de cada registro de la tabla y acumulando el rdo en la variable DVH
                    DVH = DVH + Me.CalcularDVHPatente(patente)
                    patente._dvh = Me.CalcularDVHPatente(patente)
                    DAL.Patente.GetInstance.Actualizar(patente)
                Next
                DAL.Seguridad.GetInstance.ReCalcularDVV(DVH, tabla)
            Case "FAMILIA"
                For Each familia In DAL.Familia.GetInstance.Listar
                    ''Voy calculando el dvh de cada registro de la tabla y acumulando el rdo en la variable DVH
                    DVH = DVH + Me.CalcularDVHFamilia(familia)
                    familia._dvh = Me.CalcularDVHFamilia(familia)
                    DAL.Familia.GetInstance.Actualizar(familia)
                Next
                DAL.Seguridad.GetInstance.ReCalcularDVV(DVH, tabla)
        End Select
    End Sub
#End Region

#Region "Ayuda"
    Public Shared Function ConsultarHelp() As BE.Seguridad
        Return DAL.Seguridad.ConsultarHelp
    End Function
#End Region

#Region "Permisos"
    Public Function VerificarPermisosUsuFamPat(ByVal patente As BE.Patente, ByVal usuario As BE.Usuario) As Boolean
        Try
            Return DAL.Seguridad.GetInstance.VerificarPermisosUsuFamPat(patente, usuario)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function VerificarPermisosNegUsuPat(ByVal patente As BE.Patente, ByVal usuario As BE.Usuario) As Boolean
        Try
            Return DAL.Seguridad.GetInstance.VerificarPermisosNegUsuPat(patente, usuario)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function VerificarPermisosUsuPat(ByVal patente As BE.Patente, ByVal usuario As BE.Usuario) As Boolean
        Try
            Return DAL.Seguridad.GetInstance.VerificarPermisosUsuPat(patente, usuario)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Shared Function VerificarPatentes(ByRef o As Object, ByVal usr As BE.Usuario) As Boolean

        Dim autorizado As Boolean = False
        Try

            '--> Se verifica si el usuario está autorizado para el control recibido
            For Each usra As BE.Patente In ObtenerPermisos(usr)

                If DirectCast(o.text, String) = usra._desc Then

                    autorizado = True
                End If
            Next

            Return autorizado

        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Shared Function ObtenerPermisos(ByVal usr As BE.Usuario) As List(Of BE.Patente)

        Dim mlstpat As New List(Of BE.Patente)
        Dim mlstpat1 As New List(Of BE.Patente)
        Dim mlstFam As New List(Of BE.Familia)
        Dim mlsPatFam As New List(Of BE.Pat_Fam)

        Try

            '--> Se cargan las patentes individuales del usuario
            mlstpat.AddRange(DAL.usu_pat.GetInstance.Consultar(usr))

            ''Listado de FAmilias asignadas al usuario
            mlstFam.AddRange(DAL.Usu_fam.GetInstance.Consultar(usr))
            usr._fam_id = BLL.Usu_Fam.Consultar(usr)
            '--> Se cargan las patentes correspondientes a familias ligadas al usuario
            For Each fam As BE.Familia In usr._fam_id
                If Not fam._patente Is Nothing Then
                    mlstpat.AddRange(fam._patente)
                End If
            Next

            For Each patn As BE.Patente In usr.PatentesNegadas
                For Each pat As BE.Patente In mlstpat
                    If patn._id = pat._id Then
                        mlstpat1.Contains(pat)
                    End If
                Next
            Next

            '--> Se copia la lista de patentes para poder eliminar las que están negadas
            mlstpat1.AddRange(mlstpat)
            '--> Se busca cada patentes negada en la lista a devolver y si existe se la elimina
            For Each patn As BE.Patente In usr.PatentesNegadas
                For Each pat As BE.Patente In mlstpat
                    If patn._id = pat._id Then
                        mlstpat1.Remove(pat)
                    End If
                Next
            Next

            '--> Se retorna la lista de patentes (con las patentes negadas eliminadas)
            Return mlstpat1

        Catch de As DataException
            Throw de
        Catch ex As Exception
            Throw ex
        End Try

    End Function
#End Region

#Region "Backup"
    Public Sub GenerarBKP(ByVal destino As String)
        Try
            DAL.Seguridad.GetInstance.GenerarBKP(destino)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub GenerarBKPMulti(ByVal destino As String, ByVal destino2 As String)
        Try
            DAL.Seguridad.GetInstance.GenerarBKPMulti(destino, destino2)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub GenerarBKPMulti2(ByVal destino As String, ByVal destino2 As String, ByVal destino3 As String)
        Try
            DAL.Seguridad.GetInstance.GenerarBKPMulti2(destino, destino2, destino3)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
#End Region

#Region "Restore"
    Public Sub HacerRestore(ByVal origen As String)
        DAL.SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        DAL.SQLHelper.DameInstancia.SetCommandText(String.Format("ALTER DATABASE Ediciones SET SINGLE_USER with ROLLBACK IMMEDIATE"))
        DAL.SQLHelper.DameInstancia.ExecuteNonQuery()
         DAL.SQLHelper.DameInstancia.SetCommandText(String.Format("USE master RESTORE DATABASE Ediciones FROM  DISK = N'{0}' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10", origen))
        DAL.SQLHelper.DameInstancia.ExecuteNonQuery()
    End Sub

    Public Sub HacerMultiRestore(ByVal origen As String, ByVal origen2 As String)
        DAL.SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        DAL.SQLHelper.DameInstancia.SetCommandText(String.Format("ALTER DATABASE Ediciones SET SINGLE_USER with ROLLBACK IMMEDIATE"))
        DAL.SQLHelper.DameInstancia.ExecuteNonQuery()
        DAL.SQLHelper.DameInstancia.SetCommandText(String.Format("USE master RESTORE DATABASE Ediciones FROM DISK=N'{0}', DISK=N'{1}' WITH REPLACE", origen, origen2))
        DAL.SQLHelper.DameInstancia.ExecuteNonQuery()
    End Sub

    Public Sub HacerMultiRestore2(ByVal origen As String, ByVal origen2 As String, ByVal origen3 As String)
        DAL.SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        DAL.SQLHelper.DameInstancia.SetCommandText(String.Format("ALTER DATABASE Ediciones SET SINGLE_USER with ROLLBACK IMMEDIATE"))
        DAL.SQLHelper.DameInstancia.ExecuteNonQuery()
        DAL.SQLHelper.DameInstancia.SetCommandText(String.Format("USE master RESTORE DATABASE Ediciones FROM DISK=N'{0}', DISK=N'{1}', DISK=N'{2}' WITH REPLACE", origen, origen2, origen3))
        DAL.SQLHelper.DameInstancia.ExecuteNonQuery()
    End Sub

#End Region

End Class