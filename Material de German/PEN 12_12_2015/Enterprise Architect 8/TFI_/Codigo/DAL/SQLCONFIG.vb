Public Class DALSQLConfig

#Region "Singleton"
    Private Shared instancia As DAL.DALSQLConfig
    Public Shared Function DameInstancia() As DAL.DALSQLConfig
        If instancia Is Nothing Then
            instancia = New DAL.DALSQLConfig
        End If
        Return instancia
    End Function
#End Region

#Region "Connection String"
    Public Function CheckSQLConn() As Boolean
        Static conn As New SqlClient.SqlConnection
        Try
            conn.Close()
            conn.ConnectionString = LeerTexto("Data Source")
            conn.Open()
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Function LeerTexto(ByVal dato As String) As String
        Dim sconfig As String = ""
        Static conn As New SqlClient.SqlConnection
        Try
            Dim reader As IO.StreamReader = IO.File.OpenText("c:\Ediciones\Ediciones.txt")
            Do
                sconfig = BE.Seguridad.Desencriptar(reader.ReadLine)
                If sconfig.Contains(dato) = True Then
                    Exit Do
                Else
                    sconfig = Nothing
                End If
            Loop Until reader.EndOfStream = True
            reader.Close()
            conn.ConnectionString = sconfig
            If conn.State = ConnectionState.Open Then
                Return sconfig
            End If
        Catch ex As Exception
            Return "Error"
        End Try
        Return sconfig
    End Function
#End Region

End Class
