Public Class Criticidad

    Private _criticidad_fk As Integer
    Private _nombre As String

    Public Property criticidad_fk() As Integer
        Get
            Return _criticidad_fk
        End Get
        Set(ByVal value As Integer)
            _criticidad_fk = value
        End Set
    End Property

    Public Property nombre() As String
        Get
            Return _nombre
        End Get
        Set(ByVal Value As String)
            _nombre = Value
        End Set
    End Property

End Class