Public Class Libro

#Region "Constructores"
    Sub New()

    End Sub

    Sub New(ByVal id As Integer, ByVal activo As Boolean, ByVal cant As Integer, ByVal precio As Decimal, _
            ByVal desc As String, ByVal editorial As String, ByVal lib_usu_id As Integer)
        Me.lib_id = id
        Me.lib_activo = activo
        Me.lib_cant = cant
        Me.lib_desc = desc
        Me.lib_precio = precio
        Me.lib_editorial = editorial
    End Sub
#End Region

#Region "Propiedades"
    Private lib_id As Integer
    Public Property _id() As Integer
        Get
            Return lib_id
        End Get
        Set(ByVal value As Integer)
            lib_id = value
        End Set
    End Property

    Private lib_activo As Boolean
    Public Property _activo() As Boolean
        Get
            Return lib_activo
        End Get
        Set(ByVal value As Boolean)
            lib_activo = value
        End Set
    End Property

    Private lib_cant As Integer
    Public Property _cant() As Integer
        Get
            Return lib_cant
        End Get
        Set(ByVal value As Integer)
            lib_cant = value
        End Set
    End Property

    Private lib_desc As String
    Public Property _desc() As String
        Get
            Return lib_desc
        End Get
        Set(ByVal value As String)
            lib_desc = value
        End Set
    End Property

    Private lib_precio As Decimal
    Public Property _precio() As Decimal
        Get
            Return lib_precio
        End Get
        Set(ByVal value As Decimal)
            lib_precio = value
        End Set
    End Property

    Private lib_editorial As String
    Public Property _editorial() As String
        Get
            Return lib_editorial
        End Get
        Set(ByVal value As String)
            lib_editorial = value
        End Set
    End Property

    Private lib_vend_id As BE.Vendedor
    Public Property _vend_id() As BE.Vendedor
        Get
            Return lib_vend_id
        End Get
        Set(ByVal value As BE.Vendedor)
            lib_vend_id = value
        End Set
    End Property

#End Region

    'Sobreescribo el tostring
    Public Overrides Function ToString() As String
        Return String.Format("{0}", Me.lib_id)
    End Function


End Class
