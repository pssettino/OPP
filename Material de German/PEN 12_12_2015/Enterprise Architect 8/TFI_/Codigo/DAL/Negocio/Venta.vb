Public Class Venta

#Region "Singleton"

    Dim context As New EdicionesFuturoDataContext

    Private Shared instancia As DAL.Venta

    Public Shared Function GetInstance() As DAL.Venta


        If instancia Is Nothing Then

            instancia = New DAL.Venta

        End If

        Return instancia

    End Function
#End Region

#Region "Metodos"
    'Alta venta
    Public Function Alta(ByVal objAlta As BE.Venta) As Boolean
        Dim a As New Venta

        SQLHelper.DameInstancia.SetCommandType(CommandType.Text)

        Dim actulizarsaldo As New Decimal

        objAlta._clie_id._saldo = objAlta._clie_id._saldo + objAlta._importe

        SQLHelper.DameInstancia.SetCommandText(String.Format("UPDATE [cliente] set [clie_saldo] = {0} where [clie_id] = '{1}'", BE.Seguridad.EncriptarDecimal(objAlta._clie_id._saldo), objAlta._clie_id.ID))
        SQLHelper.DameInstancia.ExecuteNonQuery()
        Try
            a.vent_activo = True
            a.vent_clie_id = objAlta._clie_id.ID
            a.vent_cuotas = BE.Seguridad.EncriptarDecimal(objAlta._cuotas)
            a.vent_dvh = objAlta._dvh
            a.vent_importe = BE.Seguridad.EncriptarDecimal(objAlta._importe)
            a.vent_vend_id = objAlta._vend_id._id
            a.vent_lib_id = objAlta._lib_id._id
            a.vent_fecha = objAlta._fecha
            a.vent_usu_id = objAlta._usu_id._id
            a.vent_valorcuota = objAlta._valorcuota

            context.Venta.InsertOnSubmit(a)
            context.SubmitChanges()

            'Actualizo el dvv de la tabla
            Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 4 Select dvv
            Dim modActDVV As New DAL.DVV
            Dim acumdvh As New DVV

            acumdvh.dvv_dvv = 0
            modActDVV = modDVV.First
            modActDVV.dvv_dvv = modActDVV.dvv_dvv + a.vent_dvh
            context.SubmitChanges()

        Catch ex As Exception
            MsgBox(ex, MsgBoxStyle.Information)
        End Try

    End Function
    'Listado de ventas
    Public Function Listar() As System.Collections.Generic.List(Of BE.Venta)
        Dim Ventas As New List(Of BE.Venta)

        For Each Venta In context.Venta
            Ventas.Add(New BE.Venta(Venta.vent_id, Venta.vent_clie_id, Venta.vent_id, BE.Seguridad.DesencriptarDecimal(Venta.vent_importe), BE.Seguridad.DesencriptarDecimal(Venta.vent_cuotas), Venta.vent_fecha, Venta.vent_usu_id, Venta.vent_lib_id, Venta.vent_dvh, Venta.vent_activo, Venta.vent_valorcuota))
        Next

        Return Ventas

    End Function
    'Baja Logica venta
    Public Function Baja(ByVal objBaja As BE.Venta) As Boolean

        Dim modVent = From oVenta In context.Venta Where oVenta.vent_id = objBaja._id Select oVenta

        Dim modVenta As New DAL.Venta

        modVenta = modVent.First

        modVenta.vent_dvh = objBaja._dvh
        modVenta.vent_activo = False

        objBaja._activo = "false"

        context.SubmitChanges()

        'Actualizo el dvv de la tabla
        Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 4 Select dvv
        Dim modActDVV As New DAL.DVV
        Dim acumdvh As New DVV

        Dim Ventas As New List(Of BE.Venta)

        For Each oventA In context.Venta
            Ventas.Add(New BE.Venta(oventA.vent_id, oventA.vent_clie_id, oventA.vent_id, BE.Seguridad.DesencriptarDecimal(oventA.vent_importe), BE.Seguridad.DesencriptarDecimal(oventA.vent_cuotas), oventA.vent_fecha, oventA.vent_usu_id, oventA.vent_lib_id, oventA.vent_dvh, oventA.vent_activo, oventA.vent_valorcuota))


            modActDVV = modDVV.First
            acumdvh.dvv_dvv = acumdvh.dvv_dvv + oventA.vent_dvh
            modActDVV.dvv_dvv = acumdvh.dvv_dvv

        Next

        context.SubmitChanges()

        Return Nothing

    End Function
    'Actualizo una venta
    Public Function Actualizar(ByVal objAct As BE.Venta) As Boolean
        Dim resultvalue As Boolean = False
        'apareo con el ID que traigo de la UI y la bll
        Dim modVent = From vent In context.Venta Where vent.vent_id = objAct._id Select vent
        Dim modVenta As New DAL.Venta
        ''Parametros a modificar del modCliente
        modVenta = modVent.First
        modVenta.vent_activo = True
        modVenta.vent_clie_id = objAct._clie_id.ID
        modVenta.vent_cuotas = BE.Seguridad.EncriptarDecimal(objAct._cuotas)
        modVenta.vent_dvh = objAct._dvh
        modVenta.vent_importe = BE.Seguridad.EncriptarDecimal(objAct._importe)
        modVenta.vent_vend_id = objAct._vend_id._id
        modVenta.vent_lib_id = objAct._lib_id._id
        modVenta.vent_fecha = objAct._fecha
        modVenta.vent_usu_id = objAct._usu_id._id
        modVenta.vent_valorcuota = objAct._valorcuota
        'Updateo la base.
        context.SubmitChanges()

        ''Unificar a metodo DVV
        Dim modDVV = From dvv In context.DVV Where dvv.iddvv = 4 Select dvv
        Dim modActDVV As New DAL.DVV
        Dim acumdvh As New DVV

        Dim Ventas As New List(Of BE.Venta)

        For Each oventA In context.Venta
            Ventas.Add(New BE.Venta(oventA.vent_id, oventA.vent_clie_id, oventA.vent_id, BE.Seguridad.DesencriptarDecimal(oventA.vent_importe), BE.Seguridad.DesencriptarDecimal(oventA.vent_cuotas), oventA.vent_fecha, oventA.vent_usu_id, oventA.vent_lib_id, oventA.vent_dvh, oventA.vent_activo, oventA.vent_valorcuota))


            modActDVV = modDVV.First
            acumdvh.dvv_dvv = acumdvh.dvv_dvv + oventA.vent_dvh
            modActDVV.dvv_dvv = acumdvh.dvv_dvv

        Next

        context.SubmitChanges()

        Return resultvalue
    End Function
#End Region

End Class
