﻿Imports System.IO
Public Class Conexion

    Public Shared Function getConexionFarmacia() As String
        Dim DataSource As String = File.ReadAllText("AccederServidorSQL.txt")
        Return "Data Source=" & DataSource & ";Initial Catalog=farmacia;Integrated Security=True"
    End Function

    Public Shared Function getConexionMaster() As String
        Dim DataSource As String = File.ReadAllText("AccederServidorSQL.txt")
        Return "Data Source=" & DataSource & ";Initial Catalog=master;Integrated Security=True"
    End Function

End Class
