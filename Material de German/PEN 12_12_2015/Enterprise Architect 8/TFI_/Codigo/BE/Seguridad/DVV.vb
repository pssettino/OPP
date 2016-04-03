Public Class DVV

#Region "Constructores"
    Sub New()

    End Sub
    Sub New(ByVal id As Integer, ByVal tabla As String, ByVal dvv_dvv As Integer)
        Me.dvv_id = id
        Me.dvv_dvv = dvv_dvv
        Me.dvv_tabla_nombre = tabla
    End Sub
#End Region

#Region "Propiedades"
    Private dvv_id As Integer
    Public Property _id() As String
        Get
            Return dvv_id
        End Get
        Set(ByVal value As String)
            dvv_id = value
        End Set
    End Property
    Private dvv_tabla_nombre As String
    Public Property _tabla_nombre() As String
        Get
            Return dvv_tabla_nombre
        End Get
        Set(ByVal value As String)
            dvv_tabla_nombre = value
        End Set
    End Property
    Private dvv_dvv As Integer
    Public Property _dvv() As Integer
        Get
            Return dvv_dvv
        End Get
        Set(ByVal value As Integer)
            dvv_dvv = value
        End Set
    End Property
#End Region

End Class
