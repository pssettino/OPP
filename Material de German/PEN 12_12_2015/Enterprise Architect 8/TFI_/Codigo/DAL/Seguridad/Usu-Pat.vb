Public Class Usu_Pat

#Region "Singleton"
    Dim context As New EdicionesFuturoDataContext

    Private Shared instancia As DAL.usu_pat

    Public Shared Function GetInstance() As DAL.usu_pat


        If instancia Is Nothing Then

            instancia = New DAL.usu_pat

        End If

        Return instancia

    End Function

#End Region

#Region "Metodos"
    'Asigno una patente a un usuario
    Public Function AsignarPatente(ByVal objusupat As BE.Usu_Pat)
        Dim resultvalue As Boolean = False

        Dim a As New usu_pat

        Try

            a.usu_id = objusupat.usuario_id._id
            a.pat_id = objusupat.patente_id._id
            a._tipo = True
            context.usu_pat.InsertOnSubmit(a)

            context.SubmitChanges()
            resultvalue = True

        Catch ex As Exception
            Throw ex

        End Try

        Return resultvalue
    End Function
    'Actualizo Usu pat
    Public Function Actualizar(ByVal objusupat As BE.Usu_Pat)
        Dim resultvalue As Boolean = False
        Try
            SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
            SQLHelper.DameInstancia.SetCommandText(String.Format("UPDATE [usu-pat] set [dvh] = {0} where [pat-id] = '{1}' and [usu-id] = '{2}'", objusupat._dvh, objusupat.patente_id._id, objusupat.usuario_id._id))
            SQLHelper.DameInstancia.ExecuteNonQuery()
            Return True

        Catch ex As Exception
            MsgBox(ex)
        End Try


        Return resultvalue
    End Function
    'Le quito la patente a un usuario
    Public Function QuitarPatente(ByVal objusupat As BE.Usu_Pat)
        Try
            Dim modClie = From usupat In context.usu_pat
                          Where usupat.usu_id = objusupat.usuario_id._id And usupat.Patente.pat_desc = objusupat.patente_id._desc
                          Select usupat

            Dim modCliente As New DAL.usu_pat

            modCliente = modClie.First
            modCliente.tipo = objusupat._tipo
            modCliente.pat_id = objusupat.patente_id._id
            modCliente.tipo = True
            context.usu_pat.DeleteOnSubmit(modCliente)
            context.SubmitChanges()

            Return False
        Catch ex As Exception
            Throw ex

        End Try
    End Function
    'Consulto por las patentes de un usuario
    Public Function Consultar(ByVal usr As BE.Usuario) As List(Of BE.Patente)
        Dim listaPatUsu As New List(Of BE.Patente)
        Try
            Dim mUsuario = From p In context.usu_pat
                               Where p.tipo = True And usr._id = p.usu_id


            Dim colpat As New List(Of BE.Patente)

            For Each m In mUsuario
                Dim objpat As New BE.Patente
                objpat._desc = m.Patente.pat_desc
                colpat.Add(objpat)
            Next

            Return colpat
        Catch se As SqlClient.SqlException
            Throw se
        Catch de As DataException
            Throw de
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Consulto por las patentes Negadasde un usuario
    Public Function ConsultarNegadas(ByVal usr As BE.Usuario) As List(Of BE.Patente)
        Dim listaPatUsu As New List(Of BE.Patente)
        Try
            Dim mUsuario = From p In context.usu_pat
                           Where p.tipo = False And usr._id = p.usu_id


            Dim colpat As New List(Of BE.Patente)

            For Each m In mUsuario
                Dim objpat As New BE.Patente
                objpat._desc = m.Patente.pat_desc
                colpat.Add(objpat)
            Next

            Return colpat
        Catch se As SqlClient.SqlException
            Throw se
        Catch de As DataException
            Throw de
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Le quito la negacion de una patente
    Public Function QuitarPatenteNegada(ByVal objusupat As BE.Usu_Pat)
        Dim resultvalue As Boolean = False
        Dim modClie = From usupat In context.usu_pat
              Where usupat.usu_id = objusupat.usuario_id._id And usupat.Patente.pat_desc = objusupat.patente_id._desc
              Select usupat
        ''Niego una patente a un usuario la pongo en false el campo tipo
        Dim a As New usu_pat
        Dim modCliente As New DAL.usu_pat
        Try

            modCliente = modClie.First
            modCliente.tipo = objusupat._tipo
            modCliente.pat_id = objusupat.patente_id._id
            modCliente.tipo = False
            context.usu_pat.DeleteOnSubmit(modCliente)
            context.SubmitChanges()
            resultvalue = False

            'Actualizo el dvv de la tabla
            Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 6 Select dvv
            Dim modActDVV As New DAL.DVV
            Dim acumdvh As New DVV

            Dim usupatente As New List(Of BE.Usu_Pat)

            For Each oUsuPat In context.usu_pat
                usupatente.Add(New BE.Usu_Pat(oUsuPat.usu_id, oUsuPat.pat_id, oUsuPat.dvh, objusupat._tipo))
                modActDVV = modDVV.First
                acumdvh.dvv_dvv = acumdvh.dvv_dvv + oUsuPat.dvh
                modActDVV.dvv_dvv = acumdvh.dvv_dvv

            Next

            If usupatente.Count = 0 Then
                modActDVV = modDVV.First
                modActDVV.dvv_dvv = 0
            End If

            context.SubmitChanges()


        Catch ex As Exception
            MsgBox("Debe seleccionar una patente")
        End Try

        Return resultvalue
        Return False
    End Function
    'Le quito la patente asignada
    Public Function QuitarPatenteAsignada(ByVal objusupat As BE.Usu_Pat)
        Dim resultvalue As Boolean = False

        Dim modClie = From usupat In context.usu_pat
              Where usupat.usu_id = objusupat.usuario_id._id And usupat.Patente.pat_desc = objusupat.patente_id._desc
              Select usupat

        Dim a As New usu_pat
        Dim modCliente As New DAL.usu_pat
        Try

            modCliente = modClie.First
            modCliente.tipo = objusupat._tipo
            modCliente.pat_id = objusupat.patente_id._id
            modCliente.tipo = False

            'context.usu_pat.InsertOnSubmit(a)
            context.usu_pat.DeleteOnSubmit(modCliente)
            context.SubmitChanges()
            resultvalue = False

            'Actualizo el dvv de la tabla
            Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 6 Select dvv
            Dim modActDVV As New DAL.DVV
            Dim acumdvh As New DVV

            Dim usupatente As New List(Of BE.Usu_Pat)


            For Each oUsuPat In context.usu_pat
                usupatente.Add(New BE.Usu_Pat(oUsuPat.usu_id, oUsuPat.pat_id, oUsuPat.dvh, objusupat._tipo))
                modActDVV = modDVV.First
                acumdvh.dvv_dvv = acumdvh.dvv_dvv + oUsuPat.dvh
                modActDVV.dvv_dvv = acumdvh.dvv_dvv

            Next

            If usupatente.Count = 0 Then
                modActDVV = modDVV.First
                modActDVV.dvv_dvv = 0
            End If

            context.SubmitChanges()

        Catch ex As Exception
            Throw ex

        End Try

        Return resultvalue

        Return False


    End Function
    'Quitar la patente permitida
    Public Function QuitarPatentePermitida(ByVal objusupat As BE.Usu_Pat)
        Dim resultvalue As Boolean = False
        ''Niego una patente a un usuario la pongo en true el campo tipo
        Dim a As New usu_pat
        Try
            a.usu_id = objusupat.usuario_id._id
            a.pat_id = objusupat.patente_id._id
            a._tipo = False
            context.SubmitChanges()
            resultvalue = True
        Catch ex As Exception
            Throw ex
        End Try
        Return resultvalue
        Return False
    End Function
    'Niego la patente al usuario
    Public Function NegarPatente(ByVal objusupat As BE.Usu_Pat)
        Try

            'Niego la patente al usuario
            Dim modClie = From usupat In context.usu_pat
                          Where usupat.usu_id = objusupat.usuario_id._id And usupat.Patente.pat_id = objusupat.patente_id._id
                          Select usupat

            If modClie.Count = 0 Then
                AsignarPatente(objusupat)
            End If


            Dim modCliente As New DAL.usu_pat

            modCliente = modClie.First
            modCliente.tipo = objusupat._tipo
            modCliente.dvh = objusupat._dvh
            modCliente.tipo = False
            ''context.usu_pat.DeleteOnSubmit(modCliente)
            context.SubmitChanges()


            'Actualizo el dvv de la tabla
            Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 6 Select dvv
            Dim modActDVV As New DAL.DVV
            Dim acumdvh As New DVV

            Dim usupatente As New List(Of BE.Usu_Pat)

            For Each oUsuPat In context.usu_pat
                usupatente.Add(New BE.Usu_Pat(oUsuPat.usu_id, oUsuPat.pat_id, oUsuPat.dvh, objusupat._tipo))
                modActDVV = modDVV.First
                acumdvh.dvv_dvv = acumdvh.dvv_dvv + oUsuPat.dvh
                modActDVV.dvv_dvv = acumdvh.dvv_dvv

            Next

            If usupatente.Count = 0 Then
                modActDVV = modDVV.First
                modActDVV.dvv_dvv = 0
            End If


            context.SubmitChanges()




            Return False
        Catch ex As Exception
            Throw ex

        End Try
    End Function
    'Pemrito la patente al usuario
    Public Function PermitirPatente(ByVal objusupat As BE.Usu_Pat)
        Try

            'Permito la patente

            Dim modClie = From usupat In context.usu_pat
                          Where usupat.usu_id = objusupat.usuario_id._id And usupat.Patente.pat_id = objusupat.patente_id._id
                          Select usupat

            If modClie.Count = 0 Then
                AsignarPatente(objusupat)
            End If

            Dim modCliente As New DAL.usu_pat

            modCliente = modClie.First
            modCliente.tipo = objusupat._tipo
            modCliente.dvh = objusupat._dvh
            modCliente.tipo = True
            context.SubmitChanges()

            'Actualizo el dvv de la tabla
            Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 6 Select dvv
            Dim modActDVV As New DAL.DVV
            Dim acumdvh As New DVV

            Dim usupatente As New List(Of BE.Usu_Pat)

            For Each oUsuPat In context.usu_pat
                usupatente.Add(New BE.Usu_Pat(oUsuPat.usu_id, oUsuPat.pat_id, oUsuPat.dvh, objusupat._tipo))
                modActDVV = modDVV.First
                acumdvh.dvv_dvv = acumdvh.dvv_dvv + oUsuPat.dvh
                modActDVV.dvv_dvv = acumdvh.dvv_dvv

            Next

            If usupatente.Count = 0 Then
                modActDVV = modDVV.First
                modActDVV.dvv_dvv = 0
            End If

            context.SubmitChanges()


            Return False
        Catch ex As Exception
            Throw ex
        End Try

    End Function
    'Listo las patentes del usuario
    Public Function Listar() As System.Collections.Generic.List(Of BE.Usu_Pat)

        Dim usupat As New List(Of BE.Usu_Pat)
        Dim reader As SqlClient.SqlDataReader
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("select * from [usu-pat]"))
        reader = SQLHelper.DameInstancia.ExecuteReader
        Try
            While reader.Read
                Dim unaPatenteFam As New BE.Usu_Pat
                unaPatenteFam.patente_id._id = reader("pat-id")
                unaPatenteFam.usuario_id._id = reader("usu-id")
                unaPatenteFam._dvh = reader("dvh")

                usupat.Add(unaPatenteFam)
            End While
        Catch ex As Exception
            Throw ex
        End Try
        Return usupat
    End Function
#End Region
End Class
