Public Class Usu_Fam

#Region "Singleton"


    Private Shared instancia As BLL.Usu_Fam

    Public Shared Function GetInstance() As BLL.Usu_Fam


        If instancia Is Nothing Then

            instancia = New BLL.Usu_Fam

        End If

        Return instancia

    End Function

#End Region

#Region "Metodos"
    'Asigno una familia a un usuario
    Public Function AsignarFamilia(ByVal objusufam As BE.Usu_Fam)
        Try
            Return DAL.Usu_fam.GetInstance.AsignarFamilia(objusufam)
        Catch ex As Exception
            MsgBox(ex)
        End Try
    End Function
    'Quito una familia a un usuario
    Public Function QuitarFamilia(ByVal objusufam As BE.Usu_Fam)
        Try
            Return DAL.Usu_fam.GetInstance.QuitarFamilia(objusufam)
        Catch ex As Exception
            MsgBox(ex)
        End Try
    End Function
    'Verifico Asignaciones
    Public Shared Function Consultar(ByVal usr As BE.Usuario) As List(Of BE.Familia)
        Try
            'Consulta la lista de patentes a partir de una familia
            Dim mLstFam As List(Of BE.Familia) = DAL.Usu_fam.GetInstance.Consultar(usr)
            'Si no se obtienen datos se devuelve Nothing
            If mLstFam Is Nothing Then
                Return Nothing
            End If
            Return mLstFam
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
