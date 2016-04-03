Public Class Familia

#Region "Singleton"
    Private Shared instancia As BLL.Familia

    Public Shared Function GetInstance() As BLL.Familia


        If instancia Is Nothing Then

            instancia = New BLL.Familia

        End If

        Return instancia

    End Function

#End Region

#Region "Metodos"
    'Listo Familias
    Public Function Listar() As System.Collections.Generic.List(Of BE.Familia)
        Try
            Return DAL.Familia.GetInstance.Listar()
        Catch ex As Exception
            MsgBox(ex)
        End Try
    End Function
    'Asigno Patente a Familia
    Public Function AsignarPataFAm(ByVal objpatfam As BE.Pat_Fam)
        Return DAL.pat_fam.GetInstance.AsignarPataFam(objpatfam)
    End Function
#End Region

End Class
