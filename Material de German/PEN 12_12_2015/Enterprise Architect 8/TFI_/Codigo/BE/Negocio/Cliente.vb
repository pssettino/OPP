
Public Class Cliente

#Region "Constructores"
    Sub New(ByVal dvh)
        Me.clie_dvh = dvh
    End Sub
    Sub New()

    End Sub

    'Sub New()
    '    Me.lib_id = New Libro()
    'End Sub

    Public Sub New(ByVal id As Int16, ByVal nombre As String, ByVal apellido As String, ByVal direccion As String, _
            ByVal dni As Integer, ByVal activo As Boolean, ByVal email As String, ByVal saldo As Decimal, _
            ByVal fecha As Date, ByVal dvh As Integer, ByVal telefono As Integer)
        Me.clie_id = id
        Me.clie_nom = nombre
        Me.clie_ape = apellido
        Me.clie_dir = direccion
        Me.clie_dni = dni
        Me.clie_email = email
        Me.clie_saldo = saldo
        Me.clie_fec_alta = fecha
        Me.clie_tel = telefono
        Me.clie_activo = activo
        Me.clie_dvh = dvh
        'Me.lib_id = New Libro
        'Me.clie_lib_id._id = lib_id
    End Sub
#End Region

#Region "Propiedades"
    Private clie_activo As Boolean

    Public Property _activo() As String
        Get

            If clie_activo = True Then
                Return "Cliente Activo"
            ElseIf clie_activo = False Then
                Return "Cliente Borrado"
            End If
            Return clie_activo

        End Get
        Set(ByVal value As String)
            clie_activo = value
        End Set
    End Property

    Private clie_id As Integer
    Public Property ID() As Integer
        Get
            Return clie_id
        End Get
        Set(ByVal value As Integer)
            clie_id = value
        End Set
    End Property


    Private usu_id As BE.Usuario
    Public Property _id() As BE.Usuario
        Get
            Return usu_id
        End Get
        Set(ByVal value As BE.Usuario)
            usu_id = value
        End Set
    End Property

    Private clie_nom As String
    Public Property _nom() As String
        Get
            Return clie_nom
        End Get
        Set(ByVal value As String)
            clie_nom = value
        End Set
    End Property
    Private clie_ape As String
    Public Property _ape() As String
        Get
            Return clie_ape
        End Get
        Set(ByVal value As String)
            clie_ape = value
        End Set
    End Property
    Private clie_dir As String
    Public Property _dir() As String
        Get
            Return clie_dir
        End Get
        Set(ByVal value As String)
            clie_dir = value
        End Set
    End Property


    Private clie_dir_id As BE.Direccion
    Public Property _dir_id() As BE.Direccion
        Get
            Return clie_dir_id
        End Get
        Set(ByVal value As BE.Direccion)
            clie_dir_id = value
        End Set
    End Property


    Private clie_tel As Integer
    Public Property _tel() As Integer
        Get
            Return clie_tel
        End Get
        Set(ByVal value As Integer)
            clie_tel = value
        End Set
    End Property
    Private clie_saldo As Decimal
    Public Property _saldo() As String
        Get
            Return clie_saldo
        End Get
        Set(ByVal value As String)
            clie_saldo = value

        End Set
    End Property
    Private clie_fec_alta As Date
    Public Property _fec_alta() As Date
        Get
            Return clie_fec_alta
        End Get
        Set(ByVal value As Date)
            clie_fec_alta = value
        End Set
    End Property
    Private clie_dni As Integer
    Public Property _dni() As String
        Get
            Return clie_dni
        End Get
        Set(ByVal value As String)
            clie_dni = value
        End Set
    End Property
    Private clie_email As String
    Public Property _email() As String
        Get
            Return clie_email
        End Get
        Set(ByVal value As String)
            clie_email = value
        End Set
    End Property
    Private clie_dvh As Integer
    Public Property _dvh() As Integer
        Get
            Return clie_dvh
        End Get
        Set(ByVal value As Integer)
            clie_dvh = value
        End Set
    End Property
#End Region

    'Sobrescribo el ToString
    Public Overrides Function ToString() As String
        Return String.Format("{0}", Me.clie_id)
    End Function

End Class
