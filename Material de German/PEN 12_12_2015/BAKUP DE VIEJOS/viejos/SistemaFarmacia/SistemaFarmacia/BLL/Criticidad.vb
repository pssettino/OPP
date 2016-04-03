Public Class Criticidad

    Dim CriticidadDAL As New DAL.Criticidad

    Public Function ObtenerCriticidades() As List(Of BE.Criticidad)
        Return CriticidadDAL.ObtenerCriticidades()
    End Function

End Class