Imports System.Collections.Generic

Public Class Libro
    Implements BE.ICRUD(Of BE.Libro)

#Region "Singleton"

    Dim context As New EdicionesFuturoDataContext


    Private Shared instancia As DAL.Libro

    Public Shared Function GetInstance() As DAL.Libro


        If instancia Is Nothing Then

            instancia = New DAL.Libro

        End If

        Return instancia

    End Function

#End Region

#Region "Metodos"
    'Modifico un Libro
    Public Function Modificar(ByVal objAct As BE.Libro) As Boolean Implements BE.ICRUD(Of BE.Libro).Modificar
        Return Nothing
    End Function
    'Alta nuevo Libro
    Public Function Alta(ByVal objAlta As BE.Libro) As Boolean Implements BE.ICRUD(Of BE.Libro).Alta
        Dim resultvalue As Boolean = False
        Dim a As New Libro
        Try
            a.lib_activo = False
            a.lib_cant = objAlta._cant
            a.lib_desc = objAlta._desc
            a.lib_editorial = objAlta._editorial
            a.lib_precio = objAlta._precio
            a.lib_usu_id = 5

            context.Libro.InsertOnSubmit(a)
            context.SubmitChanges()
            resultvalue = True

        Catch ex As Exception
            Throw ex

        End Try

        Return resultvalue
    End Function
    'Baja Libro
    Public Function Baja(ByVal objBaja As BE.Libro) As Boolean Implements BE.ICRUD(Of BE.Libro).Baja
        Return Nothing
    End Function
    'Listado Libro
    Public Function Listar() As System.Collections.Generic.List(Of BE.Libro) Implements BE.ICRUD(Of BE.Libro).Listar
        Dim Libros As New List(Of BE.Libro)
        Dim reader As SqlClient.SqlDataReader
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("select * from [Libro]"))
        reader = SQLHelper.DameInstancia.ExecuteReader
        While reader.Read
            Dim unlibro As New BE.Libro
            unlibro._id = reader("lib_id")
            unlibro._cant = reader("lib_cant")
            unlibro._desc = reader("lib_desc")
            unlibro._editorial = reader("lib_editorial")
            unlibro._precio = reader("lib_precio")
            Libros.Add(unlibro)
        End While
        Return Libros
    End Function
    'Agregado por codigo
    Private Sub Onlib_usu_idChanging(ByVal value As BE.Usuario)
        Throw New NotImplementedException
    End Sub
    'Cuando realizo una venta bajo 1 libro del stock
    Public Function DescontarStock(ByVal oLibro As BE.Libro) As System.Collections.Generic.List(Of BE.Libro)
        Try


            Dim Libros As New List(Of BE.Libro)
            Dim reader As SqlClient.SqlDataReader
            SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
            SQLHelper.DameInstancia.SetCommandText(String.Format("select * from [Libro]"))
            reader = SQLHelper.DameInstancia.ExecuteReader
            Try
                While reader.Read
                    Dim unlibro As New BE.Libro
                    unlibro._id = reader("lib_id")
                    unlibro._cant = reader("lib_cant")


                    Libros.Add(unlibro)


                End While


                For Each Libro In Libros

                    If Libro._id = oLibro._id Then
                        oLibro._cant = Libro._cant - 1

                        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
                        SQLHelper.DameInstancia.SetCommandText(String.Format("UPDATE [Libro] set [lib_cant] = {0} where [lib_id] = '{1}'", oLibro._cant, oLibro._id))
                        SQLHelper.DameInstancia.ExecuteNonQuery()
                    End If

                Next


            Catch ex As Exception
                Throw ex
            End Try



        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region

End Class
