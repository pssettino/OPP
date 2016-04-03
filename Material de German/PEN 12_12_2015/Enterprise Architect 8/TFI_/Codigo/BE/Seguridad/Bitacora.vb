Public Class Bitacora

#Region "Constructores"

    Sub New()
        Me._usu_id = New Usuario()
        Me._crit_id = New Criticidad
    End Sub

    Sub New(ByVal id As Integer, ByVal fecha As Date, ByVal desc As String,
            ByVal bit_usu_log As String, ByVal dvh As Integer,
            ByVal usu_id As Integer, ByVal criticidad As String)
        Me.bit_id = id
        Me.bit_fecha = fecha
        Me.bit_desc = desc
        Me.bit_usu_log = bit_usu_log
        Me.bit_dvh = dvh
        Me._usu_id = New Usuario
        Me.bit_usu_id._id = usu_id
        Me._crit_id = New Criticidad
        Me._crit_id._desc = criticidad
    End Sub

#End Region

#Region "Propiedades"
    Private bit_crit_id As BE.Criticidad

    Private bit_id As Integer
    Public Property _id() As Integer
        Get
            Return bit_id
        End Get
        Set(ByVal value As Integer)
            bit_id = value
        End Set
    End Property

    Private bit_fecha As Date
    Public Property _fecha() As Date
        Get
            Return bit_fecha
        End Get
        Set(ByVal value As Date)
            bit_fecha = value
        End Set
    End Property

    Private bit_desc As String
    Public Property _desc() As String
        Get
            Return bit_desc
        End Get
        Set(ByVal value As String)
            bit_desc = value
        End Set
    End Property

    Private bit_usu_log As String
    Public Property _usu_log() As String
        Get
            Return bit_usu_log
        End Get
        Set(ByVal value As String)
            bit_usu_log = value
        End Set
    End Property

    Private bit_dvh As Integer
    Public Property _dvh() As Integer
        Get
            Return bit_dvh
        End Get
        Set(ByVal value As Integer)
            bit_dvh = value
        End Set
    End Property

    Public Property _crit_id() As BE.Criticidad
        Get
            Return bit_crit_id
        End Get
        Set(ByVal value As BE.Criticidad)
            bit_crit_id = value
        End Set
    End Property

    Private bit_usu_id As BE.Usuario
    Public Property _usu_id() As BE.Usuario
        Get
            Return bit_usu_id
        End Get
        Set(ByVal value As BE.Usuario)
            bit_usu_id = value
        End Set
    End Property

    Private ffin As Date
    Public Property _ffin() As Date
        Get
            Return ffin
        End Get
        Set(ByVal value As Date)
            ffin = value
        End Set
    End Property

#End Region

End Class
