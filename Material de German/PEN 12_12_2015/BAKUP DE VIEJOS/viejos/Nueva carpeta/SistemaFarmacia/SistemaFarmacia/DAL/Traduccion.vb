'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''DAL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Traduccion
    Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("ConnString").ConnectionString
    Dim sqlConn As New SqlClient.SqlConnection(connString)
    Public Function CargarTraduccion(ByVal Texto As String, ByVal IdiomaBE As BE.Idioma) As String

        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim returnValue As Boolean = False
        Dim idioma_fk As New SqlClient.SqlParameter
        Dim txt As New SqlClient.SqlParameter

        Dim ds As New DataSet
        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure

        comm.CommandText = "idi_ObtenerTraduccion"

        idioma_fk.DbType = DbType.Int32
        idioma_fk.ParameterName = "@idioma_fk"
        idioma_fk.Value = IdiomaBE.IdiomaId

        txt.DbType = DbType.String
        txt.ParameterName = "@texto"
        txt.Value = Trim(Texto)

        comm.Parameters.Add(idioma_fk)
        comm.Parameters.Add(txt)
        Dim traduccion As New BE.Traduccion

        Try
            sqlDa.SelectCommand = comm

            sqlDa.SelectCommand.Connection.Open()

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim TraduccionBE As New BE.Traduccion
                Dim Idioma As New BE.Idioma
                TraduccionBE.traduccion_id = CInt(fila("traduccion_id"))
                Idioma.IdiomaId = CInt(fila("idioma_fk"))
                TraduccionBE.idioma = Idioma
                TraduccionBE.texto = CStr(fila("texto"))
                TraduccionBE.traduccion = CStr(fila("traduccion"))
                traduccion = TraduccionBE
            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        If traduccion.traduccion Is Nothing Then
            InsertarTexto(Texto)
            Return "//" + Texto + "//"
        Else
            Return traduccion.traduccion
        End If

    End Function


    Function InsertarTexto(Texto As String) As Boolean
        Dim SqlComm As New SqlClient.SqlCommand
        Dim returnValue As Boolean = False

        Try
            sqlConn.Open()
            SqlComm.CommandText = String.Format("insert into [farmacia].dbo.[Traduccion] (idioma_fk,texto,traduccion) values (2,'" & Texto & "','" & Texto & "')")
            SqlComm.Connection = sqlConn
            SqlComm.ExecuteNonQuery()
            sqlConn.Close()
            returnValue = True
        Catch ex As Exception
            Throw ex
        End Try
        Return returnValue
    End Function
 
End Class ' Traduccion