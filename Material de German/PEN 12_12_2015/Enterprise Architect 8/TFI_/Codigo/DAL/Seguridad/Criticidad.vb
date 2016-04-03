Public Class Criticidad

#Region "Singleton"

    Dim context As New EdicionesFuturoDataContext

    Private Shared instancia As DAL.Criticidad

    Public Shared Function GetInstance() As DAL.Criticidad


        If instancia Is Nothing Then

            instancia = New DAL.Criticidad

        End If

        Return instancia

    End Function

#End Region

#Region "Metodos"
    'Recorro en busca de una criticidad
    Public Function RecuperarId(ByVal objcrit As BE.Criticidad) As Integer
        Try
            Dim mCrit = From s In context.Criticidad Where s.crit_desc = objcrit._desc
            Return mCrit.First.crit_id
            context.SubmitChanges()
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listo las criticidades
    Public Function Listar() As System.Collections.Generic.List(Of BE.Criticidad)
        Try
            Dim ColCrit As New List(Of BE.Criticidad)
            For Each Crit In context.Criticidad
                Dim mCriticidad = From s In context.Criticidad Where s.crit_id = Crit.crit_id Select s
                Dim ObjCrit As New BE.Criticidad
                ObjCrit._id = Crit.crit_id
                ObjCrit._desc = Crit.crit_desc
                ObjCrit._dvh = 0
                ColCrit.Add(ObjCrit)
            Next
            Return ColCrit
        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region

End Class
