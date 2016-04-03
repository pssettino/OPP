Public Class Usu_Fam

#Region "Constructores"

    Sub New()
        Me.usu_id = New Usuario()
        Me.fam_id = New Familia()
    End Sub
    Sub New(ByVal usu_id As Integer, ByVal famid As Integer, ByVal dvh As Integer)
        Me.usu_id = New Usuario
        Me.usuario_id._id = usu_id
        Me.fam_id = New Familia
        Me.familia_id._id = famid
        Me.dvh = dvh
    End Sub

#End Region

#Region "Propiedades"

    Private usu_id As BE.Usuario
    Public Property usuario_id() As BE.Usuario
        Get
            Return usu_id
        End Get
        Set(ByVal value As BE.Usuario)
            usu_id = value
        End Set
    End Property

    Private fam_id As BE.Familia
    Public Property familia_id() As BE.Familia
        Get
            Return fam_id
        End Get
        Set(ByVal value As BE.Familia)
            fam_id = value
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

End Class
