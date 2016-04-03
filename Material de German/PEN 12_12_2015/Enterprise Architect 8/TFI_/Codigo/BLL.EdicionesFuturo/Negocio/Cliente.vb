Public Class Cliente

    Implements BE.ICRUD(Of BE.Cliente)

#Region "Singleton"

    Private Sub New()

    End Sub

    Private Shared instancia As BLL.Cliente

    Public Shared Function GetInstance() As BLL.Cliente


        If instancia Is Nothing Then

            instancia = New BLL.Cliente

        End If

        Return instancia

    End Function

#End Region

#Region "Metodos"
    'Modifico un cliente
    Public Function Modificar(ByVal objAct As BE.Cliente) As Boolean Implements BE.ICRUD(Of BE.Cliente).Modificar
        Return DAL.Cliente.GetInstance.Modificar(objAct)
    End Function
    'Alta cliente
    Public Function Alta(ByVal objAlta As BE.Cliente) As Boolean Implements BE.ICRUD(Of BE.Cliente).Alta
        Try
            Return DAL.Cliente.GetInstance.Alta(objAlta)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Baja Cliente
    Public Function Baja(ByVal objBaja As BE.Cliente) As Boolean Implements BE.ICRUD(Of BE.Cliente).Baja
        Try
            Return DAL.Cliente.GetInstance.baja(objBaja)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listado de Clientes
    Public Function Listar() As System.Collections.Generic.List(Of BE.Cliente) Implements BE.ICRUD(Of BE.Cliente).Listar
        Try
            Return DAL.Cliente.GetInstance.Listar
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Valido la existencia de un cliente
    Public Function ValidarExistencia(ByVal cliente As BE.Cliente) As Boolean
        Try
            Return DAL.Cliente.GetInstance.ValidarExistencia(cliente)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region

 
End Class