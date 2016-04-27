Public Class Usuario
    Private _apellidoYNombre As String
    Public Property ApellidoYNombre() As String
        Get
            Return _apellidoYNombre
        End Get
        Set(ByVal value As String)
            _apellidoYNombre = value
        End Set
    End Property

    Private _email As String
    Public Property Email() As String
        Get
            Return _email
        End Get
        Set(ByVal value As String)
            _email = value
        End Set
    End Property

    Private _tipoUsuario As String
    Public Property TipoUsuario() As String
        Get
            Return _tipoUsuario
        End Get
        Set(ByVal value As String)
            _tipoUsuario = value
        End Set
    End Property





End Class
