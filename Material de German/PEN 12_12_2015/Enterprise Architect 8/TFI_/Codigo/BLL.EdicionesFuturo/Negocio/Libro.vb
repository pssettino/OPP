Public Class Libro
    Implements BE.ICRUD(Of BE.Libro)

#Region "Singleton"
    Private Sub New()

    End Sub

    Private Shared instancia As BLL.Libro

    Public Shared Function GetInstance() As BLL.Libro


        If instancia Is Nothing Then

            instancia = New BLL.Libro

        End If

        Return instancia

    End Function

#End Region

#Region "Metodos"
    'Modifico Libro
    Public Function Modificar(ByVal objAct As BE.Libro) As Boolean Implements BE.ICRUD(Of BE.Libro).Modificar
        Return Nothing
    End Function
    'Nuevo Libro
    Public Function Alta(ByVal objAlta As BE.Libro) As Boolean Implements BE.ICRUD(Of BE.Libro).Alta
        Try
            Return DAL.Libro.GetInstance.Alta(objAlta)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Baja Logica Libro
    Public Function Baja(ByVal objBaja As BE.Libro) As Boolean Implements BE.ICRUD(Of BE.Libro).Baja
        Return Nothing
    End Function
    'Listo Libros
    Public Function Listar() As System.Collections.Generic.List(Of BE.Libro) Implements BE.ICRUD(Of BE.Libro).Listar
        Try
            Return DAL.Libro.GetInstance.Listar()
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Descuento del stock a medida que voy vendiendo libros
    Public Function DescontarStock(ByVal oLibro As BE.Libro)
        Try
            Return DAL.Libro.GetInstance.DescontarStock(oLibro)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region

End Class
