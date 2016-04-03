'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''DAL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Venta


    Private ventaId As Integer
	Private cliente As Cliente
	Private fecha_venta As date
	Private activo As boolean
    Private dvh As Integer
    Private medicamentos As List(Of Medicamento)

	Public Sub RegistrarVenta()

	End Sub

	Public Function ModificarVenta() As Venta
		ModificarVenta = Nothing
	End Function

	Public Sub EliminarVenta()

	End Sub

	Public Sub ValidarVenta()

	End Sub

    Public Function ObtenerVentaPorFiltro() As List(Of Venta)
        ObtenerVentaPorFiltro = Nothing
    End Function

    Public Function ObtenerMedicamentos() As List(Of Medicamento)
        ObtenerMedicamentos = Nothing
    End Function

	Public Sub ObtenerVentas()

	End Sub

	Public Sub ExcecuteNonQuery()

	End Sub

	Public Sub ExcecuteQuery()

	End Sub


End Class ' Venta