'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BE
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Bitacora
    Private _bicatora_id As Integer
    Private _usuario As Usuario
    Private _fecha As DateTime
    Private _descripcion As String
    Private _criticidad As Criticidad
    Private _dvh As Integer


    Public Property bitacora_id() As Integer
        Get
            Return _bicatora_id
        End Get
        Set(ByVal value As Integer)
            _bicatora_id = value
        End Set
    End Property

 
    Public Property fecha() As Date
        Get
            Return _fecha
        End Get
        Set(ByVal Value As Date)
            _fecha = Value
        End Set
    End Property

    Public Property Descripcion() As String
        Get
            Return _descripcion
        End Get
        Set(ByVal Value As String)
            _descripcion = Value
        End Set
    End Property

    Public Property usuario() As Usuario
        Get
            Return _usuario
        End Get
        Set(ByVal Value As Usuario)
            _usuario = Value
        End Set
    End Property

    Public Property criticidad() As Criticidad
        Get
            Return _criticidad
        End Get
        Set(ByVal value As Criticidad)
            _criticidad = value
        End Set
    End Property

    Public Property dvh() As Integer
        Get
            Return _dvh
        End Get
        Set(ByVal value As Integer)
            _dvh = value
        End Set
    End Property


End Class ' Bitacora