Public Class Bitacora

#Region "Singleton"

    Dim context As New EdicionesFuturoDataContext

    Private Shared instancia As DAL.Bitacora

    Public Shared Function GetInstance() As DAL.Bitacora


        If instancia Is Nothing Then

            instancia = New DAL.Bitacora

        End If

        Return instancia


    End Function

#End Region

#Region "Metodos"
    'Registro en bitacora un evento
    Public Function RegistrarBitacora(ByVal ObjBitacora As BE.Bitacora) As Boolean
        Dim mReturnValue As Boolean = False
        Dim mBitacora As New Bitacora
        Try
            If ObjBitacora._desc = "Restore" Then
                context.Bitacora.Context.Refresh(bit_id)
                Dim dcb As New EdicionesFuturoDataContext
                mBitacora.bit_desc = BE.Seguridad.Encriptar(ObjBitacora._desc)
                mBitacora.bit_fecha = ObjBitacora._fecha
                mBitacora.bit_usu_log = BE.Seguridad.Encriptar("lcontino")
                mBitacora.bit_dvh = 7
                mBitacora.bit_crit_id = ObjBitacora._crit_id._id
                mBitacora.but_usu_id = 1
                dcb.Bitacora.InsertOnSubmit(mBitacora)
                dcb.SubmitChanges()
                Exit Function
            End If
            'Especifico el vento error de integridad en la base
            If ObjBitacora._desc = "Error de Integridad en la Base" Then
                mBitacora.bit_desc = BE.Seguridad.Encriptar(ObjBitacora._desc)
                mBitacora.bit_fecha = ObjBitacora._fecha
                mBitacora.bit_usu_log = BE.Seguridad.Encriptar("lcontino")
                mBitacora.bit_dvh = 7
                mBitacora.bit_crit_id = ObjBitacora._crit_id._id
                mBitacora.but_usu_id = 1
                context.Bitacora.InsertOnSubmit(mBitacora)
                context.SubmitChanges()
                Exit Function
            End If


            Dim mUsuario = From s In context.Usuario Where s.usu_id = ObjBitacora._usu_id._id Select s
            ObjBitacora._usu_log = mUsuario.First.usu_log
            mBitacora.bit_desc = BE.Seguridad.Encriptar(ObjBitacora._desc)
            mBitacora.but_usu_id = ObjBitacora._usu_id._id
            mBitacora.bit_fecha = ObjBitacora._fecha
            mBitacora.bit_usu_log = ObjBitacora._usu_log
            mBitacora.bit_dvh = ObjBitacora._dvh
            mBitacora.bit_crit_id = ObjBitacora._crit_id._id
            context.Bitacora.InsertOnSubmit(mBitacora)
            context.SubmitChanges()
            mReturnValue = True
        Catch ex As Exception
            Throw ex
        End Try
        Return mReturnValue
    End Function
    'Listo todos los eventos
    Public Function Listar() As System.Collections.Generic.List(Of BE.Bitacora)
        Try
            Dim ColBit As New List(Of BE.Bitacora)

            For Each Bit In context.Bitacora

                Dim mUsuario = From s In context.Usuario Where s.usu_id = Bit.Usuario.usu_id Select s

                Dim mtipocriticidad = From s In context.Bitacora Where s.bit_crit_id = Bit.Criticidad.crit_id Select s

                Dim ObjBit As New BE.Bitacora

                ObjBit._id = Bit.bit_id
                ObjBit._usu_id._id = Bit._but_usu_id
                ObjBit._desc = BE.Seguridad.Desencriptar(Bit.bit_desc)
                ObjBit._usu_log = BE.Seguridad.Desencriptar(Bit.bit_usu_log)
                ObjBit._fecha = Bit._bit_fecha
                ObjBit._usu_log = BE.Seguridad.Desencriptar(mUsuario.First.usu_log)
                ObjBit._crit_id._desc = mtipocriticidad.First.Criticidad.crit_desc
                ObjBit._dvh = Bit.bit_dvh

                ColBit.Add(ObjBit)

            Next

            Return ColBit

        Catch ex As Exception
            Throw ex
        End Try
    End Function
    'Listo eventos por Usuario y criticidad
    Public Function ListarxUsuyCrit(ByVal objbitacora As BE.Bitacora) As System.Collections.Generic.List(Of BE.Bitacora)
        Dim ColBit As New List(Of BE.Bitacora)
        Dim ReturnValue As Boolean = False
        Dim Contador As Integer

        Try

            Dim mUsuario = From s In context.Usuario
                           Where s.usu_log = BE.Seguridad.Encriptar(objbitacora._usu_log)
                           Select s

            Dim mBitacora = From t In context.Bitacora
                            Where t.Usuario.usu_id = mUsuario.First.usu_id
                            Select t

            Dim Valida = From s In context.Bitacora
                         Where s._but_usu_id = mUsuario.First.usu_id
                         Select s

            Dim ContValida = (From s In context.Bitacora
                              Where s.Usuario.usu_id = mUsuario.First.usu_id
                              Select s).Count

            Contador = ContValida
            If Contador >= 1 Then

                For Each m In mBitacora
                    Dim ObjBit As New BE.Bitacora

                    If BE.Seguridad.Encriptar(objbitacora._usu_log) = m._bit_usu_log And objbitacora._crit_id._id = m.Criticidad.crit_id Then
                        ObjBit._id = m.bit_id
                        ObjBit._usu_log = BE.Seguridad.Desencriptar(m.Usuario.usu_log)
                        ObjBit._desc = BE.Seguridad.Desencriptar(m.bit_desc)
                        ObjBit._crit_id._desc = m.Criticidad.crit_desc
                        ObjBit._fecha = m.bit_fecha
                        ColBit.Add(ObjBit)
                    End If

                Next

            Else
                MsgBox("El Usuario No Posee eventos")
            End If

        Catch ex As Exception
            Throw ex
        End Try
        Return ColBit
    End Function
    'Listo eventos por Criticdad y fecha
    Public Function ListarBitacoraxCrityFech(ByVal objbitacora As BE.Bitacora) As System.Collections.Generic.List(Of BE.Bitacora)
        Dim colbit As New List(Of BE.Bitacora)
        Dim mbitacora = From s In context.Bitacora Select s
        For Each m In mbitacora
            Dim ObjBit As New BE.Bitacora
            If objbitacora._crit_id._id = m.bit_crit_id _
        And objbitacora._fecha.Day <= m._bit_fecha.Day And objbitacora._fecha.Month = m._bit_fecha.Month _
                And m._bit_fecha.Day <= objbitacora._ffin.Day And objbitacora._ffin.Month = m._bit_fecha.Month Then
                ObjBit._id = m.bit_id
                ObjBit._usu_log = BE.Seguridad.Desencriptar(m.Usuario.usu_log)
                ObjBit._desc = BE.Seguridad.Desencriptar(m.bit_desc)
                ObjBit._crit_id._desc = m.Criticidad.crit_desc
                ObjBit._fecha = m.bit_fecha
                colbit.Add(ObjBit)
            End If
        Next
        Return colbit
    End Function
    'Listo eventos por Criticdad
    Public Function ListarxCrit(ByVal objbitacora As BE.Bitacora) As System.Collections.Generic.List(Of BE.Bitacora)
        Dim ColBit As New List(Of BE.Bitacora)
        Dim ReturnValue As Boolean = False
        Dim Contador As Integer
        Try

            Dim mCriticidad = From s In context.Criticidad
                           Where s.crit_id = objbitacora._crit_id._id
                           Select s

            Dim mBitacora = From t In context.Bitacora
                            Where t.Criticidad.crit_id = mCriticidad.First.crit_id
                            Select t

            Dim Valida = From s In context.Bitacora
                         Where s.bit_crit_id = mCriticidad.First.crit_id
                         Select s

            Dim ContValida = (From s In context.Bitacora
                              Where s.Criticidad.crit_id = mCriticidad.First.crit_id
                              Select s).Count

            Contador = ContValida
            If Contador >= 1 Then

                For Each m In mBitacora
                    Dim ObjBit As New BE.Bitacora
                    ObjBit._id = m.bit_id
                    ObjBit._usu_log = BE.Seguridad.Desencriptar(m.Usuario.usu_log)
                    ObjBit._desc = BE.Seguridad.Desencriptar(m.bit_desc)
                    ObjBit._crit_id._desc = m.Criticidad.crit_desc
                    ObjBit._fecha = m.bit_fecha
                    ColBit.Add(ObjBit)
                Next

            Else
                MsgBox("El Usuario No Existe")
            End If

        Catch ex As Exception
            Throw ex
        End Try
        Return ColBit
    End Function
    'Listo eventos por Usuario y Fecha y Usuario
    Public Function ListarBitacoraxCrityFechyUsu(ByVal objbitacora As BE.Bitacora) As System.Collections.Generic.List(Of BE.Bitacora)

        Dim colbit As New List(Of BE.Bitacora)

        Dim mbitacora = From s In context.Bitacora Select s
        For Each m In mbitacora

            Dim ObjBit As New BE.Bitacora

            FormatDateTime(m.bit_fecha)

            If objbitacora._crit_id._id = m.bit_crit_id And BE.Seguridad.Encriptar(objbitacora._usu_log) = m._bit_usu_log And _
                objbitacora._fecha.Day <= m._bit_fecha.Day And objbitacora._fecha.Month = m._bit_fecha.Month _
                And m._bit_fecha.Day <= objbitacora._ffin.Day And objbitacora._ffin.Month = m._bit_fecha.Month Then

                ObjBit._id = m.bit_id
                ObjBit._usu_log = BE.Seguridad.Desencriptar(m.Usuario.usu_log)
                ObjBit._desc = BE.Seguridad.Desencriptar(m.bit_desc)
                ObjBit._crit_id._desc = m.Criticidad.crit_desc
                ObjBit._fecha = m.bit_fecha
                colbit.Add(ObjBit)
            End If

        Next
        Return colbit
    End Function
    'Listo eventos por Fecha
    Public Function ListarxFecha(ByVal objbitacora As BE.Bitacora) As System.Collections.Generic.List(Of BE.Bitacora)

        Dim colbit As New List(Of BE.Bitacora)
        Dim mbitacora = From s In context.Bitacora Select s

        For Each m In mbitacora
            Dim ObjBit As New BE.Bitacora

            If objbitacora._fecha.Day <= m._bit_fecha.Day And objbitacora._fecha.Month = m._bit_fecha.Month _
                And m._bit_fecha.Day <= objbitacora._ffin.Day And objbitacora._ffin.Month = m._bit_fecha.Month Then
                ObjBit._id = m.bit_id
                ObjBit._usu_log = BE.Seguridad.Desencriptar(m.Usuario.usu_log)
                ObjBit._desc = BE.Seguridad.Desencriptar(m.bit_desc)
                ObjBit._crit_id._desc = m.Criticidad.crit_desc
                ObjBit._fecha = m.bit_fecha
                colbit.Add(ObjBit)
            End If

        Next
        Return colbit
    End Function
    'Listo eventos por Usuario y Fecha
    Public Function ListarxUsuyFecha(ByVal objbitacora As BE.Bitacora) As System.Collections.Generic.List(Of BE.Bitacora)

        Dim colbit As New List(Of BE.Bitacora)
        Dim mbitacora = From s In context.Bitacora Select s

        For Each m In mbitacora
            Dim ObjBit As New BE.Bitacora

            If BE.Seguridad.Encriptar(objbitacora._usu_log) = m.bit_usu_log _
                And objbitacora._fecha.Day <= m._bit_fecha.Day And objbitacora._fecha.Month = m._bit_fecha.Month _
                And m._bit_fecha.Day <= objbitacora._ffin.Day And objbitacora._ffin.Month = m._bit_fecha.Month Then
                ObjBit._id = m.bit_id
                ObjBit._usu_log = BE.Seguridad.Desencriptar(m.Usuario.usu_log)
                ObjBit._desc = BE.Seguridad.Desencriptar(m.bit_desc)
                ObjBit._crit_id._desc = m.Criticidad.crit_desc
                ObjBit._fecha = m.bit_fecha
                colbit.Add(ObjBit)
            End If

        Next
        Return colbit
    End Function
#End Region

End Class
