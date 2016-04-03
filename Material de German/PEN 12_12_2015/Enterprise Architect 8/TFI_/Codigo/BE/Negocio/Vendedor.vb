Public Class Vendedor

#Region "Constructores"
    Sub New()

    End Sub


    Sub New(ByVal id As Integer)
        Me.vend_id = id
    End Sub
#End Region

#Region "Propiedades"
    Private vend_id As Integer

    Public Property _id() As Integer
        Get
            Return vend_id
        End Get
        Set(ByVal value As Integer)
            vend_id = value
        End Set
    End Property

    Private vend_nom As String
    Public Property _nom() As String
        Get
            Return vend_nom
        End Get
        Set(ByVal value As String)
            vend_nom = value
        End Set
    End Property

    Private vend_ape As String
    Public Property _ape() As String
        Get
            Return vend_ape
        End Get
        Set(ByVal value As String)
            vend_ape = value
        End Set
    End Property

    Private vend_leg As Integer
    Public Property _leg() As Integer
        Get
            Return vend_leg
        End Get
        Set(ByVal value As Integer)
            vend_leg = value
        End Set
    End Property

    Private vend_activo As Boolean
    Public Property _activo() As Boolean
        Get
            Return vend_activo
        End Get
        Set(ByVal value As Boolean)
            vend_activo = value
        End Set
    End Property

    Private vend_tel As Integer
    Public Property _tel() As Integer
        Get
            Return vend_tel
        End Get
        Set(ByVal value As Integer)
            vend_tel = value
        End Set
    End Property

    Private vend_email As String
    Public Property _email() As String
        Get
            Return vend_email
        End Get
        Set(ByVal value As String)
            vend_email = value
        End Set
    End Property


#End Region

    'Sobreescribo el tostring
    Public Overrides Function ToString() As String
        Return String.Format("{0}", Me._id)
    End Function

End Class
