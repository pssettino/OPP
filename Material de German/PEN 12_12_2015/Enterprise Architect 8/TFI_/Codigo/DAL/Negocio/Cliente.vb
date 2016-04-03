Public Class Cliente

    Implements BE.ICRUD(Of BE.Cliente)

#Region "Singleton"

    Dim context As New EdicionesFuturoDataContext

    Private Shared instancia As DAL.Cliente

    Public Shared Function GetInstance() As DAL.Cliente


        If instancia Is Nothing Then

            instancia = New DAL.Cliente

        End If

        Return instancia

    End Function
#End Region

#Region "Metodos"

    'Modifico Cliente
    Public Function Modificar(ByVal objAct As BE.Cliente) As Boolean Implements BE.ICRUD(Of BE.Cliente).Modificar
        Dim resultvalue As Boolean = False
        'Insert
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("UPDATE [cliente] set clie_saldo='{0}',clie_email='{1}',clie_nom='{2}',clie_ape='{3}',clie_dni='{4}',clie_fec_alta='{5}',clie_dir='{6}',clie_tel='{7}',clie_dvh='{8}' where clie_id = '{9}'", BE.Seguridad.EncriptarDecimal(objAct._saldo), objAct._email, objAct._nom, BE.Seguridad.Encriptar(objAct._ape), objAct._dni, objAct._fec_alta.ToString("yyyyMMdd"), objAct._dir, objAct._tel, objAct._dvh, objAct.ID))
        SQLHelper.DameInstancia.ExecuteNonQuery()
        'Actualizo DVV
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("UPDATE DVV set dvv_dvv = (select sum (clie_dvh) from {0}) where DVV_tabla_nom = '{0}'", "Cliente"))
        SQLHelper.DameInstancia.ExecuteNonQuery()

    End Function
    'Alta Cliente
    Public Function Alta(ByVal objAlta As BE.Cliente) As Boolean Implements BE.ICRUD(Of BE.Cliente).Alta

        Dim resultvalue As Boolean = False
        'Insert
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("INSERT into [cliente] (clie_nom,clie_ape,clie_dir,clie_email,clie_tel,clie_dni,clie_dvh,clie_saldo,clie_fec_alta,clie_usu_id,clie_activo) values ('{0}','{1}','{2}','{3}','{4}','{5}','{6}', '{7}', '{8}','{9}','{10}')", _
                                                                                 objAlta._nom, BE.Seguridad.Encriptar(objAlta._ape), objAlta._dir, objAlta._email, objAlta._tel, objAlta._dni, objAlta._dvh, BE.Seguridad.EncriptarDecimal(objAlta._saldo), objAlta._fec_alta.ToString("yyyyMMdd"), 1, True))
        'Actualizo DVV
        SQLHelper.DameInstancia.ExecuteNonQuery()
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("UPDATE DVV set dvv_dvv = (select sum (clie_dvh) from {0}) where DVV_tabla_nom = '{0}'", "Cliente"))
        SQLHelper.DameInstancia.ExecuteNonQuery()
        Return resultvalue
    End Function
    'Baja Cliente
    Public Function baja(ByVal objBaja As BE.Cliente) As Boolean Implements BE.ICRUD(Of BE.Cliente).Baja
        'Insert
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("UPDATE [cliente] set clie_activo='{0}',clie_dvh ='{2}' where clie_id = '{1}'", False, objBaja.ID, objBaja._dvh))
        SQLHelper.DameInstancia.ExecuteNonQuery()

        'Actualizo DVV
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("UPDATE DVV set dvv_dvv = (select sum (clie_dvh) from {0}) where DVV_tabla_nom = '{0}'", "Cliente"))
        SQLHelper.DameInstancia.ExecuteNonQuery()

        Return Nothing

    End Function
    'Listo Clientes
    Public Function Listar() As System.Collections.Generic.List(Of BE.Cliente) Implements BE.ICRUD(Of BE.Cliente).Listar
        Dim usufam As New List(Of BE.Cliente)
        Dim reader As SqlClient.SqlDataReader
        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)
        SQLHelper.DameInstancia.SetCommandText(String.Format("select * from [cliente]"))
        reader = SQLHelper.DameInstancia.ExecuteReader
        Try
            While reader.Read
                Dim unaUsuFam As New BE.Cliente
                unaUsuFam.ID = reader("clie_id")
                unaUsuFam._saldo = BE.Seguridad.DesencriptarDecimal(reader("clie_saldo"))
                unaUsuFam._dvh = reader("clie_dvh")
                unaUsuFam._nom = reader("clie_nom")
                unaUsuFam._ape = BE.Seguridad.Desencriptar(reader("clie_ape"))
                unaUsuFam._dni = reader("clie_dni")
                unaUsuFam._email = reader("clie_email")
                unaUsuFam._fec_alta = reader("clie_fec_alta")
                unaUsuFam._tel = reader("clie_tel")
                unaUsuFam._dir = reader("clie_dir")
                unaUsuFam._activo = reader("clie_activo")
                usufam.Add(unaUsuFam)
            End While
        Catch ex As Exception
            Throw ex
        End Try
        Return usufam
    End Function
    'Agregados, revisar
    Private Sub Onclie_lib_idChanging(ByVal value As Integer)
        Throw New NotImplementedException
    End Sub
    Private Sub Onclie_lib_idChanged()
        Throw New NotImplementedException
    End Sub

    Function ValidarExistencia(ByVal cliente As BE.Cliente) As Boolean

        Dim mReturnValue As Boolean = True
        Dim UsrAct As Integer

        Try

            'valido la existencia del usuario
            Dim mValida = (From s In context.Cliente Where s.clie_dni = cliente._dni).Count

            If mValida >= 1 Then
                MsgBox("El Cliente ya existe en la base de datos", MsgBoxStyle.Information, "Clientes")
                Return mReturnValue = False
            End If


        Catch ex As Exception
            Throw ex
            Return mReturnValue
        End Try
        Return mReturnValue
    End Function

#End Region

End Class
