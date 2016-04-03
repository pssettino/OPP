Public Class Usu_fam

#Region "Singleton"

    Dim context As New EdicionesFuturoDataContext

    Private Shared instancia As DAL.Usu_fam

    Public Shared Function GetInstance() As DAL.Usu_fam


        If instancia Is Nothing Then

            instancia = New DAL.Usu_fam

        End If

        Return instancia

    End Function
#End Region

#Region "Metodos"
    'Actualizo Familia - Usuario
    Public Function Actualizar(ByVal objusufam As BE.Usu_Fam)
        Dim resultvalue As Boolean = False

        Try
            SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
            SQLHelper.DameInstancia.SetCommandText(String.Format("UPDATE [fam-usu] set [dvh] = {0} where [fam-id] = '{1}' and [usu-id] = '{2}'", objusufam._dvh, objusufam.familia_id._id, objusufam.usuario_id._id))
            SQLHelper.DameInstancia.ExecuteNonQuery()
            Return True
        Catch ex As Exception
            MsgBox(ex)
        End Try
        Return resultvalue
    End Function
    'Asigno Familia - Usuario
    Public Function AsignarFamilia(ByVal objusufam As BE.Usu_Fam)
        Dim resultvalue As Boolean = False

        Dim a As New fam_usu

        Try

            a.usu_id = objusufam.usuario_id._id
            a.fam_id = objusufam.familia_id._id
            a.dvh = objusufam._dvh

            context.fam_usu.InsertOnSubmit(a)

            context.SubmitChanges()
            resultvalue = True

            'Agrego parte dvv
            Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 5 Select dvv
            Dim modActDVV As New DAL.DVV
            Dim acumdvh As New DVV
            Dim PatUsus As New List(Of BE.Usu_Fam)
            For Each usufam In context.fam_usu
                PatUsus.Add(New BE.Usu_Fam(usufam.Usuario.usu_id, usufam.Familia.fam_id, usufam.dvh))
                modActDVV = modDVV.First
                acumdvh.dvv_dvv = acumdvh.dvv_dvv + usufam.dvh
                modActDVV.dvv_dvv = acumdvh.dvv_dvv
            Next
            context.SubmitChanges()


        Catch ex As Exception
            Throw ex

        End Try

        Return resultvalue
    End Function
    'Quito Familia - Usuario
    Public Function QuitarFamilia(ByVal objusufam As BE.Usu_Fam)
        Dim resultvalue As Boolean = False

        Dim modClie = From famusu In context.fam_usu
              Where famusu.Familia.fam_desc = objusufam.familia_id._desc And famusu.usu_id = objusufam.usuario_id._id
              Select famusu

        Dim modCliente As New DAL.fam_usu
        Try
            modCliente = modClie.First
            modCliente.fam_id = objusufam.familia_id._id
            modCliente.usu_id = objusufam.usuario_id._id
            modCliente.dvh = objusufam._dvh
            context.fam_usu.DeleteOnSubmit(modCliente)
            context.SubmitChanges()

            'Agrego parte dvv
            Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 5 Select dvv
            Dim modActDVV As New DAL.DVV
            Dim acumdvh As New DVV
            Dim PatUsus As New List(Of BE.Usu_Fam)
            For Each usufam In context.fam_usu
                PatUsus.Add(New BE.Usu_Fam(usufam.Usuario.usu_id, usufam.Familia.fam_id, usufam.dvh))
                modActDVV = modDVV.First
                acumdvh.dvv_dvv = acumdvh.dvv_dvv + usufam.dvh
                modActDVV.dvv_dvv = acumdvh.dvv_dvv
            Next

            If PatUsus.Count = 0 Then
                modActDVV = modDVV.First
                modActDVV.dvv_dvv = 0
            End If


            context.SubmitChanges()

        Catch ex As Exception
            Throw ex

        End Try

        Return resultvalue
    End Function
    'Consulto Familia - Usuario especificando usuario
    Public Function Consultar(ByVal usr As BE.Usuario) As List(Of BE.Familia)
        Dim listaFamUsu As New List(Of BE.Familia)
        Try
            Dim mUsuario = From f In context.fam_usu
                               Where usr._id = f.usu_id


            Dim colfam As New List(Of BE.Familia)

            For Each m In mUsuario
                Dim objfam As New BE.Familia
                objfam._desc = m.Familia.fam_desc
                colfam.Add(objfam)
            Next

            Return colfam
            'Return listaPatUsu
        Catch se As SqlClient.SqlException
            Throw se
        Catch de As DataException
            Throw de
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listo familias - Usuarios
    Public Function Listar() As System.Collections.Generic.List(Of BE.Usu_Fam)

        Dim usufam As New List(Of BE.Usu_Fam)
        Dim reader As SqlClient.SqlDataReader
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("select * from [fam-usu]"))
        reader = SQLHelper.DameInstancia.ExecuteReader
        Try
            While reader.Read
                Dim unaUsuFam As New BE.Usu_Fam
                unaUsuFam.familia_id._id = reader("fam-id")
                unaUsuFam.usuario_id._id = reader("usu-id")
                unaUsuFam._dvh = reader("dvh")

                usufam.Add(unaUsuFam)
            End While
        Catch ex As Exception
            Throw ex
        End Try
        Return usufam
    End Function
#End Region

End Class
