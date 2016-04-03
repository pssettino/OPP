Public Class Pat_Fam

#Region "Constructores"

    Sub New()
        Me.pat_id = New Patente
        Me._permiso = New Familia
        Me.DVH = DVH
    End Sub

    Sub New(ByVal patid As Integer, ByVal famid As Integer, ByVal dvh As Integer)
        Me.pat_id = New Patente
        Me.pat_id = pat_id
        Me._permiso = New Familia
        Me._permiso._id = famid
        Me._dvh = dvh
    End Sub

#End Region

#Region "Propiedades"


    Private pat_id As BE.Patente
    Public Property patente_id() As BE.Patente
        Get
            Return pat_id
        End Get
        Set(ByVal value As BE.Patente)
            pat_id = value
        End Set
    End Property

    'Private fam_id As BE.Familia
    'Public Property familia_id() As BE.Familia
    '    Get
    '        Return fam_id
    '    End Get
    '    Set(ByVal value As BE.Familia)
    '        fam_id = value
    '    End Set
    'End Property

    Private pat_permiso As BE.Familia
    Public Property _permiso() As BE.Familia
        Get
            Return pat_permiso
        End Get
        Set(ByVal value As BE.Familia)
            pat_permiso = value
        End Set
    End Property

    Private pat_nom As String
    Public Property _nom() As String
        Get
            Return pat_nom
        End Get
        Set(ByVal value As String)
            pat_nom = value
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


    Private DVH As Integer
    Public Property _dvh() As Integer
        Get
            Return DVH
        End Get
        Set(ByVal value As Integer)
            DVH = value
        End Set
    End Property

#End Region

End Class
