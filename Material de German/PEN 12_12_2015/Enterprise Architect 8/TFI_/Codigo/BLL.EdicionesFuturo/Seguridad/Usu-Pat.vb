Public Class Usu_Pat

#Region "Singleton"

    Private Shared instancia As BLL.Usu_Pat

    Public Shared Function GetInstance() As BLL.Usu_Pat


        If instancia Is Nothing Then

            instancia = New BLL.Usu_Pat

        End If

        Return instancia

    End Function

#End Region

#Region "Metodos"
    'Asigno una patente a un usuario
    Public Function AsignarPAtente(ByVal objusupat As BE.Usu_Pat)
        Try
            Return DAL.usu_pat.GetInstance.PermitirPatente(objusupat)
        Catch ex As Exception
            MsgBox(ex)
        End Try
    End Function
    'Niego una patente a un usuario
    Public Function NegarPatente(ByVal objusupat As BE.Usu_Pat)
        Try
            Return DAL.usu_pat.GetInstance.NegarPatente(objusupat)
        Catch ex As Exception
            MsgBox(ex)
        End Try
    End Function
    'Quito patente a un usuario "Fisica"
    Public Function QuitarPatenteVeridica(ByVal objusupat As BE.Usu_Pat)
        Try
            Return DAL.usu_pat.GetInstance.QuitarPatente(objusupat)
        Catch ex As Exception
            MsgBox(ex)
        End Try
    End Function
    'Quito la negacion de la patente
    Public Function QuitarPatenteNegada(ByVal objusupat As BE.Usu_Pat)
        Try
            Return DAL.usu_pat.GetInstance.QuitarPatenteNegada(objusupat)
        Catch ex As Exception
            MsgBox(ex)
        End Try
    End Function
    'Quito la asignacion de la patente
    Public Function QuitarPatenteAsignada(ByVal objusupat As BE.Usu_Pat)
        Try
            Return DAL.usu_pat.GetInstance.QuitarPatenteAsignada(objusupat)
        Catch ex As Exception
            MsgBox(ex)
        End Try
    End Function
    'Verificaciones
    Public Shared Function Consultar(ByVal usr As BE.Usuario) As List(Of BE.Patente)
        Try
            'Consulto la lista de patentes a partir de una familia
            Dim mLstPat As List(Of BE.Patente) = DAL.usu_pat.GetInstance.Consultar(usr)
            '--> Si no se obtienen datos se devuelve Nothing
            If mLstPat Is Nothing Then
                Return Nothing
            End If
            Return mLstPat
        Catch se As SqlClient.SqlException
            Throw se
        Catch de As DataException
            Throw de
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Consulto por las patentes negadas del usuario
    Public Shared Function ConsultaNegadas(ByVal usr As BE.Usuario) As List(Of BE.Patente)
        Try
            'consulta la lista de patentes a partir de una familia
            Dim mLstPat As List(Of BE.Patente) = DAL.usu_pat.GetInstance.ConsultarNegadas(usr)
            'Si no se obtienen datos se devuelve Nothing
            If mLstPat Is Nothing Then
                Return Nothing
            End If
            Return mLstPat
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
