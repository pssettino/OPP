Public Class Pat_Fam

#Region "Singleton"

    Dim context As New EdicionesFuturoDataContext

    Private Shared instancia As DAL.pat_fam

    Public Shared Function GetInstance() As DAL.pat_fam


        If instancia Is Nothing Then

            instancia = New DAL.pat_fam

        End If

        Return instancia

    End Function

#End Region

#Region "Metodos"
    'Actualizo una Patente - Familia
    Public Function Actualizar(ByVal objusupat As BE.Pat_Fam)
        Dim resultvalue As Boolean = False
        Try
            SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
            SQLHelper.DameInstancia.SetCommandText(String.Format("UPDATE [pat-fam] set [dvh] = {0} where [pat-id] = '{1}' and [fam-id] = '{2}'", objusupat._dvh, objusupat.patente_id._id, objusupat._permiso._id))
            SQLHelper.DameInstancia.ExecuteNonQuery()
            Return True
        Catch ex As Exception
            MsgBox(ex)
        End Try
        Return resultvalue
    End Function
    'Asignar Patente a Familia
    Public Function AsignarPataFam(ByVal objpatfam As BE.Pat_Fam)
        Dim resultvalue As Boolean = False

        Dim a As New pat_fam
        Dim UsrActivos As Integer
        Try
            For Each patfam In context.pat_fam
                If patfam.fam_id = objpatfam._permiso._id And patfam.pat_id = objpatfam.patente_id._id Then
                    UsrActivos = UsrActivos + 1
                End If
            Next
            a.fam_id = objpatfam._permiso._id
            a.pat_id = objpatfam.patente_id._id
            context.pat_fam.InsertOnSubmit(a)
            context.SubmitChanges()
            resultvalue = True

        Catch ex As Exception
            Throw ex

        End Try

        Return resultvalue
    End Function
    'Listado de Patentes - Familias
    Public Function Listar() As System.Collections.Generic.List(Of BE.Pat_Fam)
        Dim PateFam As New List(Of BE.Pat_Fam)
        Dim reader As SqlClient.SqlDataReader
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("select * from [pat-fam]"))
        reader = SQLHelper.DameInstancia.ExecuteReader
        Try
            While reader.Read
                Dim unaPatenteFam As New BE.Pat_Fam
                unaPatenteFam._permiso._id = reader("fam-id")
                unaPatenteFam.patente_id._id = reader("pat-id")
                unaPatenteFam._dvh = reader("dvh")

                PateFam.Add(unaPatenteFam)
            End While
        Catch ex As Exception
            Throw ex
        End Try
        Return PateFam
    End Function
#End Region

End Class
