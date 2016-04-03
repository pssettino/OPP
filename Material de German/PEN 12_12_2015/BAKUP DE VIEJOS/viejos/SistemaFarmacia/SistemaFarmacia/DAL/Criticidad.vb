Public Class Criticidad
    Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("ConnString").ConnectionString
    Dim sqlConn As New SqlClient.SqlConnection(connString)

    Public Function ObtenerCriticidades() As List(Of BE.Criticidad)
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim ds As New DataSet

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "cri_ObtenerCriticidades"

        Dim Criticidades As New List(Of BE.Criticidad)
        Try
            sqlDa.SelectCommand = comm

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim CriticidadBE As New BE.Criticidad
                CriticidadBE.criticidad_fk = CInt(fila(0))
                CriticidadBE.nombre = CStr(fila(1))
                Criticidades.Add(CriticidadBE)
            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return Criticidades
    End Function

End Class