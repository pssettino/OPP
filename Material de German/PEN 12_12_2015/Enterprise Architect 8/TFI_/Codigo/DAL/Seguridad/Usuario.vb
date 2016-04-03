
Public Class Usuario
    Implements BE.ICRUD(Of BE.Usuario)



#Region "Singleton"
    Dim context As New EdicionesFuturoDataContext
    Private Shared instancia As DAL.Usuario

    Public Shared Function GetInstance() As DAL.Usuario


        If instancia Is Nothing Then

            instancia = New DAL.Usuario

        End If

        Return instancia

    End Function

#End Region

#Region "Metodos"
    'Modifico un usuario
    Public Function Modificar(ByVal objUsuario As BE.Usuario) As Boolean Implements BE.ICRUD(Of BE.Usuario).Modificar
        Dim resultvalue As Boolean = False

        'apareo con el ID que traigo de la UI y la bll
        Dim modClie = From clie In context.Usuario Where clie.usu_id = objUsuario._id Select clie

        Dim modCliente As New DAL.Usuario

        ''Parametros a modificar del modCliente
        modCliente = modClie.First
        modCliente.usu_pass = BE.Seguridad.Encriptar(objUsuario._pass)
        modCliente.usu_log = BE.Seguridad.Encriptar(objUsuario._log)
        modCliente.usu_dvh = objUsuario._dvh

        'Updateo la base.
        context.SubmitChanges()

        ''Unificar a metodo DVV
        Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 1 Select dvv
        Dim modActDVV As New DAL.DVV

        Dim acumdvh As New DVV
        Dim Usuarios As New List(Of BE.Usuario)

        For Each clie In context.Usuario
            Usuarios.Add(New BE.Usuario(clie.usu_id, clie.usu_bloqueado, clie.usu_nom, clie.usu_ape, clie.usu_log, clie.usu_pass, clie.usu_email, clie.usu_activo))

            modActDVV = modDVV.First
            acumdvh.dvv_dvv = acumdvh.dvv_dvv + clie.usu_dvh
            modActDVV.dvv_dvv = acumdvh.dvv_dvv

        Next


        context.SubmitChanges()

        Return resultvalue





    End Function
    'Agrego un usuario
    Public Function Alta(ByVal objAlta As BE.Usuario) As Boolean Implements BE.ICRUD(Of BE.Usuario).Alta
        Dim mReturnValue As Boolean = False

        Try
            Dim mUsuario As New Usuario

            mUsuario.usu_id = objAlta._id + 3
            mUsuario.usu_nom = objAlta._nom
            mUsuario.usu_log = BE.Seguridad.Encriptar(objAlta._log)
            mUsuario.usu_ape = objAlta._ape
            mUsuario.usu_pass = BE.Seguridad.Encriptar(objAlta._pass)
            mUsuario.usu_dni = objAlta._dni
            mUsuario.usu_email = objAlta._email
            mUsuario.usu_bloqueado = False
            mUsuario.usu_activo = True
            ''quitar el hc de idioma
            mUsuario.usu_fam_id = 2
            mUsuario.usu_pat_id = 2
            mUsuario.usu_idio_id = 2
            mUsuario.usu_dvh = objAlta._dvh

            context.Usuario.InsertOnSubmit(mUsuario)
            context.SubmitChanges()
            mReturnValue = True


            ''Actualizar DVV pasar a metodo Unificado
            Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 1 Select dvv
            Dim modActDVV As New DAL.DVV
            Dim acumdvh As New DVV

            Dim ColUsu As New List(Of BE.Usuario)


            For Each s In context.Usuario
                ColUsu.Add(New BE.Usuario(s.usu_id, s.usu_bloqueado, s.usu_nom, s.usu_ape, s.usu_log, s.usu_pass, s.usu_email, s.usu_activo))

                modActDVV = modDVV.First
                acumdvh.dvv_dvv = acumdvh.dvv_dvv + s.usu_dvh
                modActDVV.dvv_dvv = acumdvh.dvv_dvv


            Next


            context.SubmitChanges()


        Catch ex As Exception
            Throw ex
        End Try

        Return mReturnValue
    End Function
    'Elimino logicamente un usuario
    Public Function Baja(ByVal objBaja As BE.Usuario)

        Dim modUsu = From usu In context.Usuario Where usu.usu_id = objBaja._id Select usu

        Dim modUsuario As New DAL.Usuario

        modUsuario = modUsu.First

        modUsuario.usu_dvh = objBaja._dvh
        modUsuario.usu_activo = False



        context.SubmitChanges()

        ''Actualizar DVV pasar a metodo Unificado
        Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 1 Select dvv
        Dim modActDVV As New DAL.DVV
        Dim acumdvh As New DVV

        Dim ColUsu As New List(Of BE.Usuario)


        For Each s In context.Usuario
            ColUsu.Add(New BE.Usuario(s.usu_id, s.usu_bloqueado, s.usu_nom, s.usu_ape, s.usu_log, s.usu_pass, s.usu_email, s.usu_activo))

            modActDVV = modDVV.First
            acumdvh.dvv_dvv = acumdvh.dvv_dvv + s.usu_dvh
            modActDVV.dvv_dvv = acumdvh.dvv_dvv


        Next


        context.SubmitChanges()

        Return ColUsu

    End Function
    'Listado de usuarios
    Public Function Listar() As System.Collections.Generic.List(Of BE.Usuario) Implements BE.ICRUD(Of BE.Usuario).Listar
        Dim Usuarios As New List(Of BE.Usuario)

        For Each usu In context.Usuario
            Usuarios.Add(New BE.Usuario(usu.usu_id, usu.usu_bloqueado, usu.usu_nom, usu.usu_ape, BE.Seguridad.Desencriptar(usu.usu_log), BE.Seguridad.Desencriptar(usu.usu_pass), usu.usu_email, usu.usu_activo))

        Next

        Return Usuarios
    End Function
    'Valido existencia de usuario
    Function ValidarUsuario(ByVal ObjUsuario As BE.Usuario) As Boolean

        Dim mReturnValue As Boolean = False
        Dim UsrAct As Integer

        Try

            'valido la existencia del usuario
            Dim mValida = From s In context.Usuario Where s.usu_pass = ObjUsuario._pass And s.usu_log = ObjUsuario._log
            Dim UsrActivos = (From e In context.Usuario Where e.usu_activo = True And e.usu_log = ObjUsuario._log Select e).Count()

            Dim modClie = From clie In context.Usuario Where clie.usu_log = ObjUsuario._log Select clie

            Dim modCliente As New DAL.Usuario

            If modClie.First.usu_pass <> ObjUsuario._pass Then
                MsgBox("Usuario o Contrasenia Incorrecta", MsgBoxStyle.OkOnly)
                modCliente = modClie.First
                modCliente.usu_ciii = modCliente.usu_ciii + 1
            Else
                modCliente.usu_ciii = 0
            End If
            If modClie.First.usu_ciii > 2 Or modClie.First.usu_bloqueado = True Then
                modCliente.usu_bloqueado = True
                MsgBox("Su usuario ha sido Bloqueado, contactar al Administrador del sistema ", MsgBoxStyle.Exclamation)
                context.SubmitChanges()

                Return False
            End If

            If modClie.First.usu_activo = False Then
                MsgBox("Su usuario se encuentra inactivo, por favor contactar al Administrador del Sistema ", MsgBoxStyle.Exclamation)
            End If

            UsrAct = UsrActivos
            If mValida.Count > 0 Then
                If UsrAct = 1 Then
                    mReturnValue = True
                    Return mReturnValue
                End If
            End If




        Catch ex As Exception
            Throw ex
            Return mReturnValue
        End Try

        context.SubmitChanges()

    End Function
    'Recupero el ID del usuario
    Public Function RecuperarId(ByVal ObjUsuario As BE.Usuario) As Integer
        Try
            Dim mUsuario = From s In context.Usuario Where s.usu_pass = (ObjUsuario._pass) And s.usu_log = (ObjUsuario._log)
            Return mUsuario.First.usu_id

            context.SubmitChanges()
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listado de usuario x usuario
    Public Function ListarxUsuario(ByVal oUsu As BE.Usuario) As System.Collections.Generic.List(Of BE.Usuario)
        Try
            Dim ColUsu As New List(Of BE.Usuario)

            Dim mUsu = From s In context.Usuario
            Dim usubit = From b In context.Bitacora

            Dim mTraer = From s In context.Bitacora Where s.Usuario.usu_nom = oUsu._nom Select s

            For Each s In mUsu
                ColUsu.Add(New BE.Usuario(s.usu_id, s.usu_bloqueado, s.usu_nom, s.usu_ape, s.usu_log, s.usu_pass, s.usu_email, s.usu_activo))
            Next

            Return ColUsu

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Desbloqueo un usuario
    Public Function Desbloquear(ByVal unusuario As BE.Usuario) As Boolean

        Dim modClie = From usu In context.Usuario Where usu.usu_log = BE.Seguridad.Encriptar(unusuario._log) Select usu

        Dim modCliente As New DAL.Usuario

        modCliente = modClie.First

        If modCliente.usu_bloqueado = False Or modCliente.usu_ciii < 3 Then
            MsgBox("El usuario seleccionado no se encuentra bloqueado", MsgBoxStyle.Critical, "Usuarios")
        End If

        modCliente.usu_bloqueado = Boolean.FalseString
        modCliente.usu_ciii = 0
        context.SubmitChanges()

        Return Nothing

    End Function
    'Verifico permisos del usuario
    Function VerificarPermisos(ByVal usuid As BE.Usu_Pat, ByVal usupast As BE.Usu_Pat) As Boolean
        Dim mReturnValue As Boolean
        Dim usu As Integer
        Dim pat As Integer
        Dim n As Integer
        Dim a As Integer

        Dim VerifPat = From patente In context.usu_pat Where patente.usu_id = usuid.usuario_id._id

        If usuid._tipo = False Then
            Return mReturnValue = False
        ElseIf usuid._tipo = True Then
            Return mReturnValue = True
        End If

        'Return mReturnValue
    End Function
    Public Function Baja1(ByVal objBaja As BE.Usuario) As Boolean Implements BE.ICRUD(Of BE.Usuario).Baja
        Return Nothing
    End Function
#End Region

End Class
