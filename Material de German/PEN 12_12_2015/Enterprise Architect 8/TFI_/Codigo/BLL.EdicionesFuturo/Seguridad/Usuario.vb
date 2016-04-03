
Public Class Usuario

    Implements BE.ICRUD(Of BE.Usuario)

#Region "Singleton"
    Private Sub New()

    End Sub

    Private Shared instancia As BLL.Usuario

    Public Shared Function GetInstance() As BLL.Usuario

        If instancia Is Nothing Then
            instancia = New BLL.Usuario
        End If

        Return instancia

    End Function

#End Region

#Region "Metodos"
    'Valido si esta bloqueado
    Function ValidarUsuario(ByVal objusu As BE.Usuario)
        Try
            'Encripto Log y pass
            BE.Seguridad.Encriptar(objusu._pass)
            BE.Seguridad.Encriptar(objusu._log)
            Return DAL.Usuario.GetInstance.ValidarUsuario(objusu)
        Catch ex As Exception
            Throw ex
        End Try
        Return 0
    End Function
    'Recupero el ID del usuario
    Public Function RecuperarID(ByVal ObjUsuario As BE.Usuario) As Integer
        Try
            Return DAL.Usuario.GetInstance.RecuperarId(ObjUsuario)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Modifico un usuario
    Public Function Modificar(ByVal objAct As BE.Usuario) As Boolean Implements BE.ICRUD(Of BE.Usuario).Modificar
        Try
            Return DAL.Usuario.GetInstance.Modificar(objAct)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Doy de alta un usuario
    Public Function Alta(ByVal objAlta As BE.Usuario) As Boolean Implements BE.ICRUD(Of BE.Usuario).Alta
        Try
            Return DAL.Usuario.GetInstance.Alta(objAlta)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Doy de baja un usuario
    Public Function Baja(ByVal objBaja As BE.Usuario) As Boolean Implements BE.ICRUD(Of BE.Usuario).Baja
        Try
            Return DAL.Usuario.GetInstance.Baja(objBaja)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Desbloqueo un usuario
    Public Function Desbloquear(ByVal unusuario As BE.Usuario) As Boolean
        Try
            Return DAL.Usuario.GetInstance.Desbloquear(unusuario)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listado de usuarios
    Public Function Listar() As System.Collections.Generic.List(Of BE.Usuario) Implements BE.ICRUD(Of BE.Usuario).Listar
        Try
            Return DAL.Usuario.GetInstance.Listar
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Valido permisos del usuario
    Public Function ValidarPermisos(ByVal usuid As BE.Usu_Pat, ByVal usupat As BE.Usu_Pat) As Boolean
        Try
            Return DAL.Usuario.GetInstance.VerificarPermisos((usuid), (usupat))
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Login Usuario
    Public Sub Login(ByVal usr As BE.Usuario)
        Try
            Dim oUsr As New BE.Usuario
            oUsr._id = usr._id
            oUsr._pass = usr._pass
            'Se carga el usuario de sesión
            BE.Sesion.Obtener_Instancia.Usuario = usr
        Catch de As DataException
            Throw de
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    'Validaciones sobre permisos
    Public Shared Function Consultar(ByVal usr As BE.Usuario, Optional ByVal noLog As Boolean = False) As BE.Usuario
        Try
            usr._pat_id.Clear()
            If Not BLL.Usu_Pat.Consultar(usr) Is Nothing Then
                usr._pat_id = BLL.Usu_Pat.Consultar(usr)
            End If
            usr.PatentesNegadas.Clear()
            Return usr
        Catch se As SqlClient.SqlException
            Throw se
        Catch de As DataException
            Throw de
        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region

End Class
