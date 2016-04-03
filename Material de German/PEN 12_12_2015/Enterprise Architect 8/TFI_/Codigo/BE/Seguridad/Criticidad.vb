Public Class Criticidad

#Region "Constructores"
    Sub New()

    End Sub

    Sub New(ByVal desc As String)
        Me.crit_desc = desc
    End Sub

    Sub New(ByVal id As Integer, ByVal desc As String)
        Me.crit_id = id
        Me.crit_desc = desc
    End Sub

#End Region

#Region "Propiedades"
    Private crit_id As Integer
    Public Property _id() As Integer
        Get
            Return crit_id
        End Get
        Set(ByVal value As Integer)
            crit_id = value
        End Set
    End Property

    Private crit_desc As String
    Public Property _desc() As String
        Get
            Return crit_desc
        End Get
        Set(ByVal value As String)
            crit_desc = value
        End Set
    End Property

    Private crit_dvh As Integer
    Public Property _dvh() As Integer
        Get
            Return crit_dvh
        End Get
        Set(ByVal value As Integer)
            crit_dvh = value
        End Set
    End Property

#End Region

    'Sobrescribo el metodo to string
    Public Overrides Function ToString() As String
        Return String.Format("{0} ", Me.crit_desc)
    End Function

End Class
