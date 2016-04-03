Public Class Familia

#Region "Singleton"

    Dim context As New EdicionesFuturoDataContext

    Private Shared instancia As DAL.Familia

    Public Shared Function GetInstance() As DAL.Familia


        If instancia Is Nothing Then

            instancia = New DAL.Familia

        End If

        Return instancia

    End Function

#End Region

#Region "Metodos"
    'Actualizo la familia
    Public Function Actualizar(ByVal objAct As BE.Familia) As Boolean
        Dim resultvalue As Boolean = False
        Dim modFam = From fam In context.Familia Where fam.fam_id = objAct._id Select fam
        Dim modFamilia As New DAL.Familia
        modFamilia = modFam.First
        modFamilia.fam_dvh = objAct._dvh
        context.SubmitChanges()

        'Actualizo DVV
        Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 8 Select dvv
        Dim modActDVV As New DAL.DVV
        Dim acumdvh As New DVV
        Dim Familias As New List(Of BE.Familia)
        For Each oFamilia In context.Familia
            Familias.Add(New BE.Familia(oFamilia.fam_id, oFamilia.fam_desc, oFamilia.fam_dvh))

            modActDVV = modDVV.First
            acumdvh.dvv_dvv = acumdvh.dvv_dvv + oFamilia.fam_dvh
            modActDVV.dvv_dvv = acumdvh.dvv_dvv

        Next

        context.SubmitChanges()

        Return resultvalue
    End Function
    'Listo las Familias
    Public Function Listar() As System.Collections.Generic.List(Of BE.Familia)
        Dim Familias As New List(Of BE.Familia)
        Try
            For Each fam In context.Familia

                Familias.Add(New BE.Familia(fam.fam_id, fam.fam_desc, fam.fam_dvh))

            Next

            Return Familias
        Catch ex As Exception
            MsgBox(ex)
        End Try
    End Function
#End Region

End Class
