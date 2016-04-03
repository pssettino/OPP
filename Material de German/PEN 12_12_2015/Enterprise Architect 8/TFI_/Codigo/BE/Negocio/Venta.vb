Public Class Venta

#Region "Constructores"
    Sub New()
        Me.venta_lib_id = New Libro
        Me._clie_id = New Cliente()
        Me._vend_id = New Vendedor()
        Me._usu_id = New Usuario()
    End Sub


    Sub New(ByVal id, ByVal clie_id, ByVal vend_id, ByVal importe, ByVal cuotas, ByVal fecha, ByVal usu_id, ByVal lib_id, ByVal dvh, ByVal estado, ByVal valorcuota)
        Me.venta_id = id
        Me.venta_lib_id = New Libro
        Me._lib_id._id = lib_id
        Me._clie_id = New Cliente()
        Me._clie_id.ID = clie_id
        Me.venta_cuotas = cuotas
        Me._vend_id = New Vendedor()
        Me._vend_id._id = vend_id
        Me.venta_importe = importe
        Me.venta_fecha = fecha
        Me._usu_id = New Usuario()
        Me._usu_id._id = usu_id
        Me.vent_dvh = dvh
        Me.venta_activo = estado
        Me.vent_valorCuota = valorcuota
    End Sub
#End Region

#Region "Propiedades"
    Private venta_id As Integer
    Public Property _id() As Integer
        Get
            Return venta_id
        End Get
        Set(ByVal value As Integer)
            venta_id = value
        End Set
    End Property

    Private venta_clie_id As BE.Cliente
    Public Property _clie_id() As BE.Cliente
        Get
            Return venta_clie_id
        End Get
        Set(ByVal value As BE.Cliente)
            venta_clie_id = value
        End Set
    End Property

    Private venta_vend_id As BE.Vendedor
    Public Property _vend_id() As BE.Vendedor
        Get
            Return venta_vend_id
        End Get
        Set(ByVal value As BE.Vendedor)
            venta_vend_id = value
        End Set
    End Property

    Private venta_lib_id As BE.Libro
    Public Property _lib_id() As BE.Libro
        Get
            Return venta_lib_id
        End Get
        Set(ByVal value As BE.Libro)
            venta_lib_id = value
        End Set
    End Property

    Private venta_importe As Decimal
    Public Property _importe() As Decimal
        Get
            Return venta_importe
        End Get
        Set(ByVal value As Decimal)
            venta_importe = value
        End Set
    End Property

    Private venta_cuotas As Integer
    Public Property _cuotas() As Integer
        Get
            Return venta_cuotas
        End Get
        Set(ByVal value As Integer)
            venta_cuotas = value
        End Set
    End Property

    Private venta_usu_id As BE.Usuario
    Public Property _usu_id() As BE.Usuario
        Get
            Return venta_usu_id
        End Get
        Set(ByVal value As BE.Usuario)
            venta_usu_id = value
        End Set
    End Property

    Private venta_fecha As Date
    Public Property _fecha() As Date
        Get
            Return venta_fecha
        End Get
        Set(ByVal value As Date)
            venta_fecha = value
        End Set
    End Property

    Private venta_activo As Boolean
    Public Property _activo() As String
        Get
            If venta_activo = True Then
                Return "Venta Activo"
            ElseIf venta_activo = False Then
                Return "Venta Borrada"
            End If
            Return venta_activo

        End Get
        Set(ByVal value As String)
            venta_activo = value
        End Set
    End Property

    Private vent_dvh As Integer
    Public Property _dvh() As Integer
        Get
            Return vent_dvh
        End Get
        Set(ByVal value As Integer)
            vent_dvh = value
        End Set
    End Property

    Private vent_valorCuota As Integer
    Public Property _valorcuota() As Integer
        Get
            Return vent_valorCuota
        End Get
        Set(ByVal value As Integer)
            vent_valorCuota = value
        End Set
    End Property

#End Region

End Class
