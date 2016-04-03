Public Class Localidad

#Region "Constructor"

    Sub New()

    End Sub

#End Region

#Region "Propiedades"
    Private localidad_id As Integer
    Public Property _id() As Integer
        Get
            Return localidad_id
        End Get
        Set(ByVal value As Integer)
            localidad_id = value
        End Set
    End Property

    Private localidad_desc As String
    Public Property _desc() As String
        Get
            Return localidad_desc
        End Get
        Set(ByVal value As String)
            localidad_desc = value
        End Set
    End Property

#End Region

End Class
