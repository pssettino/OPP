Public Class SQLHelper
    Private conn As New SqlClient.SqlConnection
    Private comm As New SqlClient.SqlCommand

#Region "Singleton"
    Private Sub New()
        conn.ConnectionString = DALSQLConfig.DameInstancia.LeerTexto("Data Source")
        comm.Connection = conn
    End Sub

    Private Shared instancia As DAL.SQLHelper
    Public Shared Function DameInstancia() As DAL.SQLHelper
        If instancia Is Nothing Then
            instancia = New DAL.SQLHelper
        End If
        Return instancia
    End Function
#End Region

#Region "Metodos para acceso a datos"
    Private Sub Conectar()
        If conn.State = ConnectionState.Open Then
            conn.Close()
        End If
        conn.Open()
    End Sub

    Private Sub Desconectar()
        conn.Close()
    End Sub

    Public Sub SetConnectionString(ByVal constr As String)
        Desconectar()
        conn.ConnectionString = constr
    End Sub

    Public Sub SetCommandType(ByVal tipo As Data.CommandType)
        comm.CommandType = tipo
    End Sub

    Public Sub SetCommandText(ByVal texto As String)
        comm.CommandText = texto
    End Sub

    Public Function EjecutarQuery(ByVal Query As String) As String
        Dim n As String = ""
        comm.CommandText = Query
        Conectar()
        comm.Connection = conn
        n = comm.ExecuteScalar()
        comm.Dispose()
        Desconectar()
        Return n
    End Function

    Public Function ExecuteNonQuery() As Integer
        Dim result As Integer
        Conectar()
        Try
            result = comm.ExecuteNonQuery
        Catch ex As Exception
            Throw ex
        End Try
        Return result
        Desconectar()
    End Function

    Public Function DataReader() As SqlClient.SqlDataReader
        Conectar()
        Dim reader As SqlClient.SqlDataReader

        reader = comm.ExecuteReader()
        Return reader
    End Function

    Public Function ExecuteScalar() As Decimal
        Dim result As Decimal
        Conectar()
        Try
            result = comm.ExecuteScalar
        Catch ex As Exception
            Throw ex
        End Try
        Return result
        Desconectar()
    End Function

    Public Function ExecuteReader() As SqlClient.SqlDataReader
        Conectar()
        Try
            Return comm.ExecuteReader
        Catch ex As Exception
            Throw ex
        End Try
        Desconectar()
    End Function
#End Region

End Class