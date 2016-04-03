Public Class Patente

#Region "Singleton"

    Dim context As New EdicionesFuturoDataContext

    Private Shared instancia As DAL.Patente

    Public Shared Function GetInstance() As DAL.Patente


        If instancia Is Nothing Then

            instancia = New DAL.Patente

        End If

        Return instancia

    End Function
#End Region

#Region "Metodos"
    'Actualizo una Patente
    Public Function Actualizar(ByVal objAct As BE.Patente) As Boolean
        Dim resultvalue As Boolean = False
        'apareo con el ID que traigo de la UI y la bll
        Dim modPat = From pat In context.Patente Where pat.pat_id = objAct._id Select pat
        Dim modPatente As New DAL.Patente
        'Parametros a modificar del modCliente
        modPatente = modPat.First
        modPatente.pat_dvh = objAct._dvh

        'Updateo la base.
        context.SubmitChanges()

        'Actualizo DVV
        Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 7 Select dvv
        Dim modActDVV As New DAL.DVV
        Dim acumdvh As New DVV

        Dim Patentes As New List(Of BE.Patente)

        For Each oPatente In context.Patente
            Patentes.Add(New BE.Patente(oPatente.pat_id, oPatente.pat_desc, oPatente.pat_dvh))

            modActDVV = modDVV.First
            acumdvh.dvv_dvv = acumdvh.dvv_dvv + oPatente.pat_dvh
            modActDVV.dvv_dvv = acumdvh.dvv_dvv

        Next

        context.SubmitChanges()

        Return resultvalue
    End Function
    'Listo las patentes
    Public Function Listar() As System.Collections.Generic.List(Of BE.Patente)
        Try
            Dim Patentes As New List(Of BE.Patente)

            For Each pat In context.Patente
                Patentes.Add(New BE.Patente(pat.pat_id, pat.pat_desc))
            Next

            Return Patentes
        Catch ex As Exception
            MsgBox(ex)
        End Try
    End Function
    'Listo las patentes asignadas
    Public Function ListarPatAsig(ByVal objusuario As BE.Patente)
        Try
            Dim mUsuario = From s In context.usu_pat Where s.usu_id = objusuario._id
            Dim colpat As New List(Of BE.Patente)

            For Each m In mUsuario
                Dim objpat As New BE.Patente
                objpat._desc = m.Patente.pat_desc
                colpat.Add(objpat)
            Next

            Return colpat

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listo las patentes asignadas a las Familias
    Public Function ListarPatentesxFam(ByVal unaFamilia As BE.Familia) As List(Of BE.Patente)
        Dim Patentes As New List(Of BE.Patente)
        Dim reader As SqlClient.SqlDataReader
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("select * from [pat-fam] where [fam-id] = {0}", unaFamilia._id))
        reader = SQLHelper.DameInstancia.ExecuteReader
        Try
            While reader.Read
                Dim unaPatente As New BE.Patente
                unaPatente._id = reader("pat-id")
                Patentes.Add(unaPatente)
            End While
        Catch ex As Exception
            Throw ex
        End Try
        Return Patentes
    End Function
    'Asigno una patente a una familia
    Public Sub AsignarPatenteFamilia(ByVal patfam As BE.Pat_Fam)
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("INSERT into [pat-fam] ([pat-id], [fam-id], [dvh]) VALUES ({0}, {1},{2})", patfam.patente_id._id, patfam._permiso._id, patfam._dvh))
        SQLHelper.DameInstancia.ExecuteNonQuery()

        Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 3 Select dvv
        Dim modActDVV As New DAL.DVV
        Dim acumdvh As New DVV

        Dim PatFams As New List(Of BE.Pat_Fam)

        For Each fp In context.pat_fam
            PatFams.Add(New BE.Pat_Fam(fp.Patente.pat_id, fp.Familia.fam_id, fp.dvh))
            modActDVV = modDVV.First
            acumdvh.dvv_dvv = acumdvh.dvv_dvv + fp.dvh
            modActDVV.dvv_dvv = acumdvh.dvv_dvv
            context.SubmitChanges()
        Next

        If PatFams.Count = 0 Then
            modActDVV = modDVV.First
            modActDVV.dvv_dvv = 0

        End If
        Try

        Catch ex As Exception
            MsgBox(ex)
        End Try
    End Sub
    'Especifico la familia a listar con las patentes asignadas
    Public Function ListarPatentesxFamilia(ByVal oPatFam As BE.Familia) As List(Of BE.Patente)
        Dim Patentes As New List(Of BE.Patente)
        Dim reader As SqlClient.SqlDataReader
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("select * from Patente where pat_id in (select [pat-id] from [pat-fam] where [fam-id]  = {0})", oPatFam._id))
        reader = SQLHelper.DameInstancia.ExecuteReader
        Try
            While reader.Read
                Dim unaPatente As New BE.Patente
                unaPatente._id = reader("pat_id")
                unaPatente._desc = reader("pat_desc")

                Patentes.Add(unaPatente)
            End While
        Catch ex As Exception
            Throw ex
        End Try
        Return Patentes
    End Function
    'Quito una patente de una familia
    Public Sub QuitarPatenteFamilia(ByVal patfam As BE.Pat_Fam)
        Dim resultvalue As Boolean = False
        Dim modClie = From usupat In context.pat_fam
              Where usupat.pat_id = patfam.patente_id._id And usupat.fam_id = patfam._permiso._id
              Select usupat
        'Niego una patente a un usuario la pongo en false el campo tipo
        Dim modCliente As New DAL.pat_fam
        Try

            modCliente = modClie.First
            modCliente.pat_id = patfam.patente_id._id
            modCliente.fam_id = patfam._permiso._id
            modCliente.dvh = patfam._dvh

            'context.usu_pat.InsertOnSubmit(a)
            context.pat_fam.DeleteOnSubmit(modCliente)
            context.SubmitChanges()
            resultvalue = False

            'Agrego parte dvv
            Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 3 Select dvv
            Dim modActDVV As New DAL.DVV
            Dim acumdvh As New DVV
            Dim PatFams As New List(Of BE.Pat_Fam)

            For Each fp In context.pat_fam
                PatFams.Add(New BE.Pat_Fam(fp.Patente.pat_id, fp.Familia.fam_id, fp.dvh))
                modActDVV = modDVV.First
                acumdvh.dvv_dvv = acumdvh.dvv_dvv + fp.dvh
                modActDVV.dvv_dvv = acumdvh.dvv_dvv
            Next

            If PatFams.Count = 0 Then
                modActDVV = modDVV.First
                modActDVV.dvv_dvv = 0
            End If

            context.SubmitChanges()


        Catch ex As Exception
            Throw ex

        End Try










        'SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        'SQLHelper.DameInstancia.SetCommandText(String.Format("DELETE from [pat-fam] where [pat-id] = {0} and [fam-id] = {1}", patfam.patente_id._id, patfam.familia_id._id, patfam._dvh))
        'SQLHelper.DameInstancia.ExecuteNonQuery()


        ' ''Actualizar DVV pasar a metodo Unificado
        'Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 3 Select dvv
        'Dim modActDVV As New DAL.DVV
        'Dim acumdvh As New DVV

        'Dim PatFams As New List(Of BE.Pat_Fam)

        'For Each fp In context.pat_fam
        '    PatFams.Add(New BE.Pat_Fam(fp.Patente.pat_id, fp.Familia.fam_id, fp.dvh))
        '    modActDVV = modDVV.First
        '    acumdvh.dvv_dvv = acumdvh.dvv_dvv + fp.dvh
        '    modActDVV.dvv_dvv = acumdvh.dvv_dvv
        'Next

        'If PatFams.Count = 0 Then
        '    modActDVV = modDVV.First
        '    modActDVV.dvv_dvv = 0

        'End If
        'Try
        '    context.SubmitChanges()
        'Catch ex As Exception
        '    MsgBox(ex)
        'End Try


    End Sub
#End Region

End Class
