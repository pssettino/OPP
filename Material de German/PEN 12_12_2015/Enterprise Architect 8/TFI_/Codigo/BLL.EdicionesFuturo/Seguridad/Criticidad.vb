Public Class Criticidad

#Region "Singleton"


    Private Shared instancia As BLL.Criticidad

    Public Shared Function GetInstance() As BLL.Criticidad


        If instancia Is Nothing Then

            instancia = New BLL.Criticidad

        End If

        Return instancia

    End Function

#End Region

#Region "Metodos"
    'Recupero el ID de una criticidad
    Public Function RecuperarId(ByVal objcrit As BE.Criticidad) As Integer
        Try
            Return DAL.Criticidad.GetInstance.RecuperarId(objcrit)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listado de criticidades
    Function ListarCriticidad()
        Try
            Return DAL.Criticidad.GetInstance.Listar()
        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region

End Class
