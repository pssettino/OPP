Public Class Familia

#Region "Constructores"

    Sub New()

    End Sub
    Sub New(ByVal id As Integer, ByVal desc As String, ByVal dvh As Integer)
        Me.fam_dvh = dvh
        Me.fam_id = id
        Me.fam_desc = desc

    End Sub
#End Region

#Region "Propiedades"
    Private fam_id As Integer
    Public Property _id() As String
        Get
            Return fam_id
        End Get
        Set(ByVal value As String)
            fam_id = value
        End Set
    End Property

    Private fam_desc As String
    Public Property _desc() As String
        Get
            Return fam_desc
        End Get
        Set(ByVal value As String)
            fam_desc = value
        End Set
    End Property

    Private fam_dvh As Integer
    Public Property _dvh() As Integer
        Get
            Return fam_dvh
        End Get
        Set(ByVal value As Integer)
            fam_dvh = value
        End Set
    End Property

    Private fam_nom As String
    Public Property _nom() As String
        Get
            Return fam_nom
        End Get
        Set(ByVal value As String)
            fam_nom = value
        End Set
    End Property

    Private fam_patente As New List(Of BE.Patente)
    Public Property _patente() As List(Of BE.Patente)
        Get
            Return fam_patente
        End Get
        Set(ByVal value As List(Of BE.Patente))
            fam_patente = value
        End Set
    End Property

    Public Overrides Function ToString() As String
        Return String.Format("{0} ", Me.fam_desc)
    End Function

#End Region

End Class
