Public Class Sesion

    'Utilizo la clase para mantener el usuario con el que navego la aplicacion y desde la be puedo compartirlo en los demas form.
#Region "Propiedades"

    Private mUsuario As BE.Usuario
    Public Property Usuario() As BE.Usuario
        Get
            Return mUsuario
        End Get
        Set(ByVal value As BE.Usuario)
            mUsuario = value
        End Set
    End Property

    Private mFecha As DateTime
    Public Property FechaSistema() As Date
        Get
            Return mFecha
        End Get
        Set(ByVal value As Date)
            mFecha = value
        End Set
    End Property

    Private Shared sesion As BE.Sesion
    Public Shared Function Obtener_Instancia() As BE.Sesion
        If sesion Is Nothing Then
            sesion = New BE.Sesion
        End If

        Return sesion
    End Function

#End Region

#Region "Constructores"

    Private Sub New()

    End Sub

#End Region

End Class
