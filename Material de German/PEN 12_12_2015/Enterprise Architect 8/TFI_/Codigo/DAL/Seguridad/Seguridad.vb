Imports System.IO
Imports System.Xml.Serialization
Imports System.Data.SqlClient
Imports System
Imports Microsoft.VisualBasic

Public Class Seguridad

#Region "Singleton"

    Dim context As New EdicionesFuturoDataContext

    Private Shared instancia As DAL.Seguridad

    Public Shared Function GetInstance() As DAL.Seguridad

        If instancia Is Nothing Then
            instancia = New DAL.Seguridad
        End If

        Return instancia

    End Function
#End Region

#Region "Ayuda"
    'Ayuda
    Public Shared Function ConsultarHelp() As BE.Seguridad
        Try
            Dim xmlSer As XmlSerializer = New XmlSerializer(GetType(BE.Seguridad))
            Dim fs As FileStream = New FileStream(AppDomain.CurrentDomain.BaseDirectory & "Help_Ediciones_Futuro.xml", FileMode.Open)
            Try
                Dim pe As New BE.Seguridad
                pe = CType(xmlSer.Deserialize(fs), BE.Seguridad)
                Return pe
            Catch ex As Exception
                Throw ex
            Finally
                fs.Close()
            End Try

        Catch io As System.IO.IOException
            Throw io
        Catch ex As Exception
            Throw ex
        End Try

    End Function
    Public Shared Sub Crear(ByVal pe As BE.Seguridad)

        Try

            Dim xmlSer As XmlSerializer = New XmlSerializer(GetType(BE.Seguridad))
            Dim fs As FileStream = New FileStream(AppDomain.CurrentDomain.BaseDirectory & "\PE_ElectroList.xml", FileMode.Create)

            Try
                xmlSer.Serialize(fs, pe)
            Catch ex As Exception
                Throw ex
            Finally
                fs.Close()
            End Try

        Catch ex As Exception
            Throw ex
        End Try

    End Sub
#End Region

#Region "Verificar Integridad"

    Public Function VerificarIntegridad(ByVal Tabla As String) As Integer
        Dim DVV As Integer = 0
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("Select [dvv_dvv] from [DVV] where [dvv_tabla_nom] = '{0}'", Tabla))
        DVV = SQLHelper.DameInstancia.ExecuteScalar
        Return DVV
    End Function

    Public Function BuscarRegistroConError(ByVal Tabla) As Boolean
        Dim DVHRegistro As Integer
        Dim DVHActualizado As Integer
        Dim ErrorIntegridad As Boolean
        Dim campo As String

        Dim Clientes As New List(Of BE.Cliente)

        For Each clie In context.Cliente
            Clientes.Add(New BE.Cliente(clie.clie_id, clie.clie_nom, BE.Seguridad.Desencriptar(clie.clie_ape), clie.clie_dir, clie.clie_dni, clie.clie_activo, _
            clie.clie_email, clie.clie_saldo, clie.clie_fec_alta, clie.clie_dvh, clie.clie_tel))
        Next

        For I As Integer = 0 To Clientes.Count

            For Each Registro In context.DVV
                DVHActualizado = 0
                For Each clie In Clientes
                    'paso a una variable el dvh de cada cliente, que recorro con el for each
                    campo = clie._activo.ToString + clie._ape.ToString + clie._nom.ToString _
                    + clie._dni.ToString + clie._email.ToString + CDbl(clie._saldo).ToString
                    'DVHRegistro = 
                    DVHRegistro = BE.Seguridad.CalcularDVH(campo)
                    If clie._dvh <> DVHRegistro Then
                        MsgBox("Problemas en el registro:  " & clie.ID & vbNewLine & "De la tabla: Clientes")
                        MsgBox("Solo un usuario con privilegios puede reparar el sistema  ", MsgBoxStyle.Critical)
                    End If


                    DVHActualizado = DVHActualizado + DVHRegistro

                Next

                'Ya verifique registro por registro arriba, ahora tengo que 
                'acumular para verificar el dvv respecto de la tabla DVV CLiente

                If DVHActualizado <> Tabla Then
                    MsgBox("Error de Integridad en el registro en la tabla cliente")
                    ErrorIntegridad = True
                End If

                '' ErrorIntegridad = True
                Return ErrorIntegridad

            Next
        Next

    End Function

    Public Function ObtenerTablasDVV() As List(Of BE.DVV)
        Dim TablasDVV As New List(Of BE.DVV)
        Try
            For Each dvv In context.DVV
                TablasDVV.Add(New BE.DVV(dvv.iddvv, dvv.dvv_tabla_nom, dvv.dvv_dvv))
            Next
        Catch ex As Exception
        End Try
        Return TablasDVV
    End Function

    Public Function RepararIntegridad() As Boolean
        Dim DVHRegistro As Integer
        Dim DVHActualizado As Integer
        Dim ErrorIntegridad As Boolean
        Dim campo As String

        Dim Clientes As New List(Of BE.Cliente)

        Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 0 Select dvv
        Dim modActDVV As New DAL.DVV
        Dim acumdvh As New DVV

        acumdvh.dvv_dvv = 0
        For Each clie In context.Cliente
            Clientes.Add(New BE.Cliente(clie.clie_id, clie.clie_nom, BE.Seguridad.Desencriptar(clie.clie_ape), clie.clie_dir, clie.clie_dni, clie.clie_activo, _
            clie.clie_email, clie.clie_saldo, clie.clie_fec_alta, clie.clie_dvh, clie.clie_tel))
        Next

        For I As Integer = 0 To Clientes.Count

            For Each Registro In context.DVV
                DVHActualizado = 0

                For Each clie In context.Cliente
                    'paso a una variable el dvh de cada cliente, que recorro con el for each
                    campo = clie.clie_activo.ToString + clie.clie_ape.ToString + clie.clie_nom.ToString + clie.clie_dni.ToString + clie.clie_email.ToString + CDbl(clie.clie_saldo).ToString
                    'DVHRegistro = 
                    clie.clie_dvh = BE.Seguridad.CalcularDVH(campo)
                    modActDVV = modDVV.First
                    acumdvh.dvv_dvv = acumdvh.dvv_dvv + clie.clie_dvh
                    modActDVV.dvv_dvv = acumdvh.dvv_dvv
                    context.SubmitChanges()
                Next

            Next
        Next


        Return ErrorIntegridad

    End Function

#End Region

#Region "VerificarPermisos"
    Public Function VerificarPermisosUsuFamPat(ByVal patente As BE.Patente, ByVal usuario As BE.Usuario) As Boolean
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("select [pat-id] from [pat-fam] cross join [fam-usu] where ([fam-usu].[usu-id] = {0}) and ([pat-fam].[pat-id] = {1}) and ([fam-usu].[fam-id] = [pat-fam].[fam-id])", usuario._id, patente._id))
        If SQLHelper.DameInstancia.ExecuteScalar = patente._id Then
            Return True
        Else
            Return False
        End If
    End Function


    Public Function VerificarPermisosNegUsuPat(ByVal patente As BE.Patente, ByVal usuario As BE.Usuario) As Boolean
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("Select COUNT (*) from [usu-pat] where tipo = 'False' and [pat-id] = {0} and [usu-id] = {1}", patente._id, usuario._id))
        If SQLHelper.DameInstancia.ExecuteScalar = 1 Then
            Return False
        Else
            Return True
        End If
    End Function
    Public Function VerificarPermisosUsuPat(ByVal patente As BE.Patente, ByVal usuario As BE.Usuario) As Boolean
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("Select COUNT (*) from [usu-pat] where tipo = 'TRUE' and [pat-id] = {0} and [usu-id] = {1}", patente._id, usuario._id))
        If SQLHelper.DameInstancia.ExecuteScalar = 1 Then
            Return True
        Else
            Return False
        End If
    End Function

#End Region

#Region "Recalculo DVV"
    Public Function ReCalcularDVV(ByVal suma As Double, ByVal tabla As String) As Boolean
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("UPDATE [DVV] set [dvv_dvv] = {0} where [dvv_tabla_nom] = '{1}'", suma, tabla))
        SQLHelper.DameInstancia.ExecuteNonQuery()
        Return True
    End Function
#End Region

#Region "Calculos DVH"
    Public Function CalcularDVHCliente(ByVal registro As Object) As Integer

        registro = DirectCast(registro, BE.Cliente)._dni.ToString + _
        DirectCast(registro, BE.Cliente)._ape.ToString + _
        DirectCast(registro, BE.Cliente)._nom.ToString + _
        DirectCast(registro, BE.Cliente)._email.ToString + _
        DirectCast(registro, BE.Cliente)._dir.ToString + _
        DirectCast(registro, BE.Cliente)._fec_alta.ToString + _
        DirectCast(registro, BE.Cliente)._tel.ToString()

        Dim i As Integer
        Dim sumatoriaaux As Long = 0
        For i = 1 To registro.Length
            sumatoriaaux = sumatoriaaux + (Asc(registro.Substring(i - 1, 1)) * i)
        Next
        Return sumatoriaaux

    End Function

    Public Function CalcularDVHUsuario(ByVal registro As Object) As Integer

        registro = DirectCast(registro, BE.Usuario)._ape.ToString + DirectCast(registro, BE.Usuario)._pass.ToString

        Dim i As Integer
        Dim sumatoriaaux As Long = 0
        For i = 1 To registro.Length
            sumatoriaaux = sumatoriaaux + (Asc(registro.Substring(i - 1, 1)) * i)
        Next
        Return sumatoriaaux

    End Function
    Public Function CalcularDVHPatente(ByVal registro As Object) As Integer

        registro = DirectCast(registro, BE.Patente)._id.ToString + DirectCast(registro, BE.Patente)._desc.ToString + DirectCast(registro, BE.Patente)._permiso.ToString

        Dim i As Integer
        Dim sumatoriaaux As Long = 0
        For i = 1 To registro.Length
            sumatoriaaux = sumatoriaaux + (Asc(registro.Substring(i - 1, 1)) * i)
        Next
        Return sumatoriaaux

    End Function

    Public Function CalcularDVHFamilia(ByVal registro As Object) As Integer

        registro = DirectCast(registro, BE.Familia)._id.ToString + DirectCast(registro, BE.Familia)._desc.ToString


        Dim i As Integer
        Dim sumatoriaaux As Long = 0
        For i = 1 To registro.Length
            sumatoriaaux = sumatoriaaux + (Asc(registro.Substring(i - 1, 1)) * i)
        Next
        Return sumatoriaaux

    End Function

    Public Function CalcularDVHBitacora(ByVal registro As Object) As Integer


        If registro._usu_log Is Nothing Then
            registro._usu_log = BE.Seguridad.Encriptar("lcontino")
        End If

        registro = DirectCast(registro, BE.Bitacora)._desc.ToString + DirectCast(registro, BE.Bitacora)._fecha +
        DirectCast(registro, BE.Bitacora)._usu_log.ToString + _
        DirectCast(registro, BE.Bitacora)._crit_id.ToString + _
        DirectCast(registro, BE.Bitacora)._ffin.ToString

        Dim i As Integer
        Dim sumatoriaaux As Long = 0
        For i = 1 To registro.Length
            sumatoriaaux = sumatoriaaux + (Asc(registro.Substring(i - 1, 1)) * i)
        Next
        Return sumatoriaaux

    End Function

    Public Function CalcularDVH_PatFam(ByVal registro As Object) As Integer

        registro = DirectCast(registro, BE.Pat_Fam)._permiso._id.ToString + DirectCast(registro, BE.Pat_Fam).patente_id._id.ToString

        Dim i As Integer
        Dim sumatoriaaux As Long = 0
        For i = 1 To registro.Length
            sumatoriaaux = sumatoriaaux + (Asc(registro.Substring(i - 1, 1)) * i)
        Next
        Return sumatoriaaux


    End Function
    Public Function CalcularDVH_UsuFam(ByVal registro As Object) As Integer

        registro = DirectCast(registro, BE.Usu_Fam).usuario_id._id.ToString + DirectCast(registro, BE.Usu_Fam).familia_id._id.ToString

        Dim i As Integer
        Dim sumatoriaaux As Long = 0
        For i = 1 To registro.Length
            sumatoriaaux = sumatoriaaux + (Asc(registro.Substring(i - 1, 1)) * i)
        Next
        Return sumatoriaaux

    End Function
    Public Function CalcularDVH_UsuPat(ByVal registro As Object) As Integer

        registro = DirectCast(registro, BE.Usu_Pat).patente_id._id.ToString + DirectCast(registro, BE.Usu_Pat).usuario_id._id.ToString

        Dim i As Integer
        Dim sumatoriaaux As Long = 0
        For i = 1 To registro.Length
            sumatoriaaux = sumatoriaaux + (Asc(registro.Substring(i - 1, 1)) * i)
        Next
        Return sumatoriaaux


    End Function

    Public Function CalcularDVHVentas(ByVal registro As Object) As Integer

        registro = DirectCast(registro, BE.Venta)._lib_id.ToString + _
              DirectCast(registro, BE.Venta)._clie_id.ToString + _
        BE.Seguridad.EncriptarDecimal(DirectCast(registro, BE.Venta)._cuotas).ToString + _
        BE.Seguridad.EncriptarDecimal(DirectCast(registro, BE.Venta)._importe).ToString + _
        DirectCast(registro, BE.Venta)._fecha.ToString + _
                DirectCast(registro, BE.Venta)._usu_id._id.ToString

        Dim i As Integer
        Dim sumatoriaaux As Long = 0
        For i = 1 To registro.Length
            sumatoriaaux = sumatoriaaux + (Asc(registro.Substring(i - 1, 1)) * i)
        Next
        Return sumatoriaaux

    End Function

#End Region

#Region "Backup"
    Public Sub GenerarBKP(ByVal destino As String)
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("BACKUP DATABASE Ediciones TO DISK=N'{0}'", destino))
        SQLHelper.DameInstancia.ExecuteNonQuery()
    End Sub

    Public Sub GenerarBKPMulti(ByVal destino As String, ByVal destino2 As String)
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("BACKUP DATABASE Ediciones TO DISK = N'{0}', DISK = N'{1}'", destino, destino2))
        SQLHelper.DameInstancia.ExecuteNonQuery()
    End Sub

    Public Sub GenerarBKPMulti2(ByVal destino As String, ByVal destino2 As String, ByVal destino3 As String)
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("BACKUP DATABASE Ediciones TO DISK = N'{0}', DISK = N'{1}', DISK = N'{2}'", destino, destino2, destino3))
        SQLHelper.DameInstancia.ExecuteNonQuery()
    End Sub

#End Region

#Region "Restore"
    Public Sub HacerRestore(ByVal origen As String)
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("ALTER DATABASE Ediciones SET SINGLE_USER with ROLLBACK IMMEDIATE"))
        SQLHelper.DameInstancia.ExecuteNonQuery()
        SQLHelper.DameInstancia.SetCommandText(String.Format("USE master RESTORE DATABASE Ediciones FROM  DISK = N'{0}' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10", origen))
        SQLHelper.DameInstancia.ExecuteNonQuery()



    End Sub

    Public Sub HacerMultiRestore(ByVal origen As String, ByVal origen2 As String)
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("ALTER DATABASE Ediciones SET SINGLE_USER with ROLLBACK IMMEDIATE"))
        SQLHelper.DameInstancia.ExecuteNonQuery()
        SQLHelper.DameInstancia.SetCommandText(String.Format("USE master RESTORE DATABASE Ediciones FROM DISK=N'{0}', DISK=N'{1}' WITH REPLACE", origen, origen2))
        SQLHelper.DameInstancia.ExecuteNonQuery()
    End Sub

    Public Sub HacerMultiRestore2(ByVal origen As String, ByVal origen2 As String, ByVal origen3 As String)
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("ALTER DATABASE Ediciones SET SINGLE_USER with ROLLBACK IMMEDIATE"))
        SQLHelper.DameInstancia.ExecuteNonQuery()
        SQLHelper.DameInstancia.SetCommandText(String.Format("USE master RESTORE DATABASE Ediciones FROM DISK=N'{0}', DISK=N'{1}', DISK=N'{2}' WITH REPLACE", origen, origen2, origen3))
        SQLHelper.DameInstancia.ExecuteNonQuery()
    End Sub

#End Region

End Class
