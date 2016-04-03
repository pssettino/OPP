Public Class VentaMedicamento

    Private _venta As BE.Venta
    Private _medicamento As BE.Medicamento
    Private _cantidadVenta As Integer
    Private _precioVenta As Double
    Private _venta_medicamento_id As Integer
    Public Property ventaMedicamentoId() As Integer
        Get
            Return _venta_medicamento_id
        End Get
        Set(ByVal value As Integer)
            _venta_medicamento_id = value
        End Set
    End Property


    Public Property Venta() As BE.Venta
        Get
            Return _venta
        End Get
        Set(ByVal value As BE.Venta)
            _venta = value
        End Set
    End Property

    Public Property Medicamento() As BE.Medicamento
        Get
            Return _medicamento
        End Get
        Set(ByVal value As BE.Medicamento)
            _medicamento = value
        End Set
    End Property

    Public Property CantidadVenta() As Integer
        Get
            Return _cantidadVenta
        End Get
        Set(ByVal value As Integer)
            _cantidadVenta = value
        End Set
    End Property


    Public Property PrecioVenta() As Double
        Get
            Return _precioVenta
        End Get
        Set(ByVal value As Double)
            _precioVenta = value
        End Set
    End Property
End Class
