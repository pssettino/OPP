Public Class Patente

#Region "Construcores"

    Sub New()

    End Sub
    Sub New(ByVal id As Integer, ByVal desc As String)

        Me.pat_id = id
        Me.pat_desc = desc

    End Sub
    Sub New(ByVal id As Integer, ByVal desc As String, ByVal dvh As Integer)

        Me.pat_id = id
        Me.pat_desc = desc
        Me._dvh = dvh
    End Sub

#End Region

#Region "Propiedades"
    Private pat_id As Integer
    Public Property _id() As Integer
        Get
            Return pat_id
        End Get
        Set(ByVal value As Integer)
            pat_id = value
        End Set
    End Property
    Private pat_desc As String
    Public Property _desc() As String
        Get
            Return pat_desc
        End Get
        Set(ByVal value As String)
            pat_desc = value
        End Set
    End Property
    Private pat_dvh As Integer
    Public Property _dvh() As Integer
        Get
            Return pat_dvh
        End Get
        Set(ByVal value As Integer)
            pat_dvh = value
        End Set
    End Property
    Private pat_permiso As Boolean
    Public Property _permiso() As String
        Get
            Return pat_permiso
        End Get
        Set(ByVal value As String)
            pat_permiso = value
        End Set
    End Property

    Public Overrides Function ToString() As String
        Return String.Format("{0} ", Me.pat_desc)
    End Function
#End Region

End Class
