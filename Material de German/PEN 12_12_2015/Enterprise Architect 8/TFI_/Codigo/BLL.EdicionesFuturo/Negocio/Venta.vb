Public Class Venta

    Implements BE.ICRUD(Of BE.Venta)

#Region "Singleton"

    Private Sub New()

    End Sub

    Private Shared instancia As BLL.Venta

    Public Shared Function GetInstance() As BLL.Venta


        If instancia Is Nothing Then

            instancia = New BLL.Venta

        End If

        Return instancia

    End Function

#End Region

#Region "Metodos"
    'Modifico una venta
    Public Function Modificar(ByVal objAct As BE.Venta) As Boolean Implements BE.ICRUD(Of BE.Venta).Modificar
        Try
            Return DAL.Venta.GetInstance.Actualizar(objAct)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Genero una nueva venta
    Public Function Alta(ByVal objAlta As BE.Venta) As Boolean Implements BE.ICRUD(Of BE.Venta).Alta
        Try
            Return DAL.Venta.GetInstance.Alta(objAlta)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Baja logica venta
    Public Function Baja(ByVal objBaja As BE.Venta) As Boolean Implements BE.ICRUD(Of BE.Venta).Baja
        Try
            Return DAL.Venta.GetInstance.Baja(objBaja)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listado de ventas
    Public Function Listar() As System.Collections.Generic.List(Of BE.Venta) Implements BE.ICRUD(Of BE.Venta).Listar
        Try
            Return DAL.Venta.GetInstance.Listar
        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region

End Class
