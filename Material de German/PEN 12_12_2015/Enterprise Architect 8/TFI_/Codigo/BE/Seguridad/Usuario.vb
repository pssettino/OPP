
Public Class Usuario

#Region "Constructores"
    Sub New()

    End Sub
    Sub New(ByVal id)
        Me.usu_id = id
    End Sub
    Sub New(ByVal log As String, ByVal pass As String)
        Me.usu_log = log
        Me.usu_pass = pass
    End Sub
    Sub New(ByVal id As Integer, ByVal bloqueado As Boolean, ByVal Nombre As String, ByVal Apellido As String, ByVal log As String, ByVal pass As String, ByVal email As String, ByVal activo As Boolean)
        Me.usu_id = id
        Me.usu_log = log
        Me.usu_pass = pass
        Me.usu_nom = Nombre
        Me.usu_bloqueado = bloqueado
        Me.usu_ape = Apellido
        Me.usu_dni = usu_dni
        Me.usu_email = email
        Me.usu_dvh = usu_dvh
        Me.ACTIVO = activo
    End Sub

#End Region

#Region "Propiedades"
    Private usu_nom As String
    Public Property _nom() As String
        Get
            Return usu_nom
        End Get
        Set(ByVal value As String)
            usu_nom = value
        End Set
    End Property
    Private usu_ape As String
    Public Property _ape() As String
        Get
            Return usu_ape
        End Get
        Set(ByVal value As String)
            usu_ape = value
        End Set
    End Property
    Private usu_id As Integer
    Public Property _id() As Integer
        Get
            Return usu_id
        End Get
        Set(ByVal value As Integer)
            usu_id = value
        End Set
    End Property
    Private usu_log As String
    Public Property _log() As String
        Get
            Return usu_log
        End Get
        Set(ByVal value As String)
            usu_log = value
        End Set
    End Property
    Private usu_pass As String
    Public Property _pass() As String
        Get
            Return usu_pass
        End Get
        Set(ByVal value As String)
            usu_pass = value
        End Set
    End Property
    Private usu_email As String
    Public Property _email() As String
        Get
            Return usu_email
        End Get
        Set(ByVal value As String)
            usu_email = value
        End Set
    End Property
    Private usu_dni As Integer
    Public Property _dni() As Integer
        Get
            Return usu_dni
        End Get
        Set(ByVal value As Integer)
            usu_dni = value
        End Set
    End Property
    Private usu_activo As Boolean
    Public Property ACTIVO() As String
        Get

            If usu_activo = True Then
                Return "Usuario Activo"
            ElseIf usu_activo = False Then
                'Return "Usuario Borrado"
                Return "Usuario Borrado"
            End If

            Return usu_activo

        End Get
        Set(ByVal value As String)
            usu_activo = value
        End Set
    End Property
    Private usu_bloqueado As Boolean
    Public Property _bloqueado() As String
        Get

            If usu_bloqueado = False Then
                Return "Usuario Activo"
            ElseIf usu_bloqueado = True Then
                Return "Usuario Bloqueado"
            End If

            Return usu_bloqueado

        End Get
        Set(ByVal value As String)
            usu_bloqueado = value
        End Set

    End Property
    Private usu_dvh As Integer
    Public Property _dvh() As Integer
        Get
            Return usu_dvh
        End Get
        Set(ByVal value As Integer)
            usu_dvh = value
        End Set
    End Property
    Private usu_ciii As Integer
    Public Property _ciii() As Integer
        Get
            Return usu_ciii
        End Get
        Set(ByVal value As Integer)
            usu_ciii = value
        End Set
    End Property
    Private usu_fam_id As New List(Of BE.Familia)
    Public Property _fam_id() As List(Of BE.Familia)
        Get
            Return usu_fam_id
        End Get
        Set(ByVal value As List(Of BE.Familia))
            usu_fam_id = value
        End Set
    End Property
    Private usu_pat_id As New List(Of BE.Patente)
    Public Property _pat_id() As List(Of BE.Patente)
        Get
            Return usu_pat_id
        End Get
        Set(ByVal value As List(Of BE.Patente))
            usu_pat_id = value
        End Set
    End Property
    Private mLstPatNeg As New List(Of BE.Patente)
    Public Property PatentesNegadas() As List(Of BE.Patente)
        Get
            Return mLstPatNeg
        End Get
        Set(ByVal value As List(Of BE.Patente))
            mLstPatNeg = value
        End Set
    End Property

#End Region

    'Sobreescribo el metodo To String
    Public Overrides Function ToString() As String
        Return String.Format("{0}", Me.usu_log)
    End Function

End Class
