Public Class Bitacora
    Private Shared instancia As BLL.Bitacora

#Region "Singleton"


    Public Shared Function GetInstance() As BLL.Bitacora


        If instancia Is Nothing Then

            instancia = New BLL.Bitacora

        End If

        Return instancia

    End Function
#End Region

#Region "Metodos"
    'Guardo un evento en la bitacora
    Function RegistrarBitacora(ByVal objbitacora)
        Try
            Return DAL.Bitacora.GetInstance.RegistrarBitacora(objbitacora)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listo Bitacora
    Function ListarBitacora()
        Try
            Return DAL.Bitacora.GetInstance.Listar()
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listo Bitacora por fecha
    Function ListarxFecha(ByVal objbit As BE.Bitacora)
        Try
            Return DAL.Bitacora.GetInstance.ListarxFecha(objbit)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listo Bitacora por Usuario y Criticidad
    Function ListarBitacoraxUsuyCrit(ByVal objbit As BE.Bitacora)
        Try
            Return DAL.Bitacora.GetInstance.ListarxUsuyCrit(objbit)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listo Bitacora por Usuario y fecha
    Function ListarBitacoraxUsuyFecha(ByVal objbit As BE.Bitacora)
        Try
            Return DAL.Bitacora.GetInstance.ListarxUsuyFecha(objbit)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listo Bitacora por Criticdad y Fecha
    Function ListarBitacoraxCrityFech(ByVal objbit As BE.Bitacora)
        Try
            Return DAL.Bitacora.GetInstance.ListarBitacoraxCrityFech(objbit)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listo Bitacora por Criticidad
    Function ListarBitacoraxCrit(ByVal objbit As BE.Bitacora)
        Try
            Return DAL.Bitacora.GetInstance.ListarxCrit(objbit)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listo Bitacora por Criticidad Fecha y Usuario
    Function ListarBitacoraxCrityFechyUsu(ByVal objbit As BE.Bitacora)
        Try
            Return DAL.Bitacora.GetInstance.ListarBitacoraxCrityFechyUsu(objbit)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region

End Class
