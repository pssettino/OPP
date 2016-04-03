Public Class Patente

#Region "Singleton"

    Private Shared instancia As BLL.Patente

    Public Shared Function GetInstance() As BLL.Patente


        If instancia Is Nothing Then

            instancia = New BLL.Patente

        End If

        Return instancia

    End Function

#End Region

#Region "Metodos"
    'Listado de Patentes
    Public Function Listar() As System.Collections.Generic.List(Of BE.Patente)
        Try
            Return DAL.Patente.GetInstance.Listar()
        Catch ex As Exception
            MsgBox(ex)
        End Try
    End Function
    'Listado de Patentes Asignadas
    Public Shared Function Consultar(ByVal pat As BE.Patente) As BE.Patente
        Try
            pat = DAL.Patente.GetInstance.ListarPatAsig(pat)
            Return pat
        Catch se As SqlClient.SqlException
            Throw se
        Catch de As DataException
            Throw de
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listado de Pantentes x Familia
    Public Function ListarPatentesxFam(ByVal unaFamilia As BE.Familia) As List(Of BE.Patente)
        Try
            Return DAL.Patente.GetInstance.ListarPatentesxFam(unaFamilia)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listado de Pantentes x Usuario
    Public Function ListarPatentesxUsu(ByVal unaPatente As BE.Patente) As List(Of BE.Patente)
        Try
            Return DAL.Patente.GetInstance.ListarPatAsig(unaPatente)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Asigno una patente a una familia
    Public Sub AsignarPatenteFamilia(ByVal patfam As BE.Pat_Fam)
        Dim registro As New BE.Pat_Fam
        Dim dvh As Integer
        registro.patente_id._id = patfam.patente_id._id
        registro._permiso._id = patfam._permiso._id
        dvh = BLL.Seguridad.GetInstance.CalcularDVH_PatFam(registro)
        Try
            DAL.Patente.GetInstance.AsignarPatenteFamilia(patfam)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    'Quito una patente de una familia
    Public Sub QuitarPatenteFamilia(ByVal patfam)
        Try
            DAL.Patente.GetInstance.QuitarPatenteFamilia(patfam)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    'Verificar de nuevo este metodo
    Public Function ListarPatentesxFamilia(ByVal oPatFam) As List(Of BE.Patente)
        Try
            Return DAL.Patente.GetInstance.ListarPatentesxFamilia(oPatFam)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region

End Class
