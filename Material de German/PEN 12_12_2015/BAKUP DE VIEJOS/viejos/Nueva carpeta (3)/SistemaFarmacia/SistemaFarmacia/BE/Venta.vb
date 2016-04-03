'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BE
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On
Public Class Venta
    Private _ventaId As Integer
    Public Property ventaId() As Integer
        Get
            Return _ventaId
        End Get
        Set(ByVal value As Integer)
            _ventaId = value
        End Set
    End Property

    Private _fechaVenta As Date
    Public Property fechaVenta() As Date
        Get
            Return _fechaVenta
        End Get
        Set(ByVal value As Date)
            _fechaVenta = value
        End Set
    End Property

    Private _activo As Boolean
    Public Property activo() As Boolean
        Get
            Return _activo
        End Get
        Set(ByVal value As Boolean)
            _activo = value
        End Set
    End Property

    Private _dvh As Integer
    Public Property dvh() As Integer
        Get
            Return _dvh
        End Get
        Set(ByVal value As Integer)
            _dvh = value
        End Set
    End Property

    Private _medicamentos As List(Of VentaMedicamento)
    Public Property medicamentos() As List(Of VentaMedicamento)
        Get
            Return _medicamentos
        End Get
        Set(ByVal value As List(Of VentaMedicamento))
            _medicamentos = value
        End Set
    End Property

    Private _cliente As Cliente
    Public Property cliente() As Cliente
        Get
            Return _cliente
        End Get
        Set(ByVal value As Cliente)
            _cliente = value
        End Set
    End Property


    Private _eliminado As Boolean
    Public Property eliminado() As Boolean
        Get
            Return _eliminado
        End Get
        Set(ByVal value As Boolean)
            _eliminado = value
        End Set
    End Property
End Class ' Venta