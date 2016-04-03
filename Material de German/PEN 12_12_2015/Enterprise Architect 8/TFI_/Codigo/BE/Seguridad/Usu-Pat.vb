Public Class Usu_Pat

#Region "Constructores"

    Sub New()
        Me.usu_id = New Usuario()
        Me.pat_id = New Patente()
    End Sub
    Sub New(ByVal usu_id As Integer, ByVal patid As Integer, ByVal dvh As Integer, ByVal tipo As Boolean)
        Me.usu_id = New Usuario
        Me.usuario_id._id = usu_id
        Me.pat_id = New Patente
        Me.patente_id = pat_id
        Me.dvh = dvh
        Me.tipo = tipo
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
    Private usu_id As BE.Usuario
    Public Property usuario_id() As BE.Usuario
        Get
            Return usu_id
        End Get
        Set(ByVal value As BE.Usuario)
            usu_id = value
        End Set
    End Property

    Private tipo As Boolean
    Public Property _tipo() As Boolean
        Get
            Return tipo
        End Get
        Set(ByVal value As Boolean)
            tipo = value
        End Set
    End Property

    Private dvh As Integer
    Public Property _dvh() As Integer
        Get
            Return dvh
        End Get
        Set(ByVal value As Integer)
            dvh = value
        End Set
    End Property

#End Region

    'Sobreescribo el metodo To String
    Public Overrides Function ToString() As String
        Return String.Format("{0} ", Me.patente_id)
    End Function

End Class
