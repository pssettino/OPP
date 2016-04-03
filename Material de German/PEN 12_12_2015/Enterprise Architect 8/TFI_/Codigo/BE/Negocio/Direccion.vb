Public Class Direccion

#Region "Constructores"
    Sub New()

    End Sub

#End Region

#Region "Propiedades"

    Private dir_id As Integer
    Public Property _id() As Integer
        Get
            Return dir_id
        End Get
        Set(ByVal value As Integer)
            dir_id = value
        End Set
    End Property


    Private dir_desc As String
    Public Property _desc() As String
        Get
            Return dir_desc
        End Get
        Set(ByVal value As String)
            dir_desc = value
        End Set
    End Property

    Private dir_loc_id As BE.Localidad
    Public Property _loc_id() As BE.Localidad
        Get
            Return dir_loc_id
        End Get
        Set(ByVal value As BE.Localidad)
            dir_loc_id = value
        End Set
    End Property


#End Region

End Class
