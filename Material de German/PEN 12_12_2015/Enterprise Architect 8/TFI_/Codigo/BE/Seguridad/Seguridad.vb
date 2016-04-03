<Serializable()> Public Class Seguridad

    'Variables utilizadas para encriptar y desencriptar
    Public Shared Idioma As String
    Private Const tabla = "abcdefghijklmnopqrstuvwxyz 0123456789ABCDEFGHIJLKMNOPQRSTUVWXYZ,.-;:_{}[]+*\¿?!¡#$&/()=áéíóúÁÉÍÓÚñÑ" + Chr(13)
    Private Const tablaDecimal = "0123456789" + Chr(13)

    Private i As Integer
    Private X As Integer

#Region "Encriptacion"
    Public Shared Function Encriptar(ByVal texto As String) As String
        Dim key As Integer = 5
        Dim i As Integer = 0
        Dim resultado As String = ""
        Dim pos As Integer

        texto = clean(texto)
        For i = 0 To (texto.Length - 1)
            'buscar la posicion del caracter 
            pos = tabla.IndexOf(texto.Chars(i))
            'realiza el reemplazo de caracteres
            If (pos + key) < tabla.Length Then
                resultado = resultado + tabla.Chars(pos + key)
            Else
                resultado = resultado + tabla.Chars((pos + key) - tabla.Length)
            End If
        Next
        'reconstruye el mensaje con los retornos de carro
        resultado = resultado.Replace("{.13}", vbCrLf)
        Return resultado
    End Function

    Public Shared Function EncriptarDecimal(ByVal texto As String) As String
        Dim key As Integer = 2
        Dim i As Integer = 0
        Dim resultado As String = ""
        Dim pos As Integer

        texto = cleand(texto)
        For i = 0 To (texto.Length - 1)
            'buscar la posicion del caracter 
            pos = tablaDecimal.IndexOf(texto.Chars(i))
            'realiza el reemplazo de caracteres
            If (pos + key) <= tablaDecimal.Length Then
                resultado = resultado + tablaDecimal.Chars(pos + key)
            Else
                resultado = resultado + tablaDecimal.Chars((pos + key) - tabla.Length)
            End If
        Next
        'reconstruye el mensaje con los retornos de carro
        resultado = resultado.Replace("{.13}", vbCrLf)
        Return resultado
    End Function

    Public Shared Function Desencriptar(ByVal texto As String) As String
        Dim key As Integer = 5
        Dim i As Integer = 0
        Dim pos As Integer

        Dim resultado As String = ""
        texto = clean(texto)
        For i = 0 To (texto.Length - 1)
            pos = tabla.IndexOf(texto.Chars(i))
            If ((pos - key) < 0) Then
                resultado = resultado + tabla.Chars((pos - key) + tabla.Length)
            Else
                resultado = resultado + tabla.Chars(pos - key)
            End If
        Next
        resultado = resultado.Replace("{.13}", vbCrLf)


        Return resultado
    End Function

    Private Shared Function clean(ByVal t As String) As String
        Dim i As Integer = 0
        Dim pos As Integer = 0
        ' reemplaza el retorno de carro con un simbolo
        t = t.Replace(vbCrLf, "{.13}")
        ' reemplaza los caracteres que no se encuentran en la tabla por un simbolo
        For i = 0 To (t.Length - 1)
            pos = tabla.IndexOf(t.Chars(i))
            If (pos = -1) Then
                t = t.Replace(t.Chars(i), "{.d}")
            End If
        Next
        Return t
    End Function

    Private Shared Function cleand(ByVal t As String) As String
        Dim i As Integer = 0
        Dim pos As Integer = 0
        ' reemplaza el retorno de carro con un simbolo
        t = t.Replace(vbCrLf, "{.13}")
        ' reemplaza los caracteres que no se encuentran en la tabla por un simbolo
        For i = 0 To (t.Length - 1)
            pos = tablaDecimal.IndexOf(t.Chars(i))
            If (pos = -1) Then
                t = t.Replace(t.Chars(i), "{.d}")
            End If
        Next
        Return t
    End Function

    Public Shared Function DesencriptarDecimal(ByVal texto As String) As String
        Dim key As Integer = 2
        Dim i As Integer = 0
        Dim pos As Integer

        Dim resultado As String = ""
        ''texto = cleand(texto)


        For i = 0 To (texto.Length - 1)
            pos = tablaDecimal.IndexOf(texto.Chars(i))

            If ((pos - key) < 0) Then
                resultado = resultado + tablaDecimal.Chars((pos - key) + tablaDecimal.Length)
            Else
                resultado = resultado + tablaDecimal.Chars(pos - key)
            End If
        Next
        'resultado = resultado.Replace("{.13}", vbCrLf)


        Return resultado
    End Function
#End Region

#Region "DVH"
    Public Function CalcularDVH(ByVal cliente As BE.Cliente)

        Dim i As Integer = 0
        Dim DVH As Integer
        Dim cadena As String = ""

        cadena = cliente.ID.ToString & _
        cliente._ape.ToString


        ''Encripto en clase cliente

        cadena = cadena.Trim
        If (cadena.Length > 0) Then
            For i = 0 To cadena.Length - 1
                DVH += (Asc(cadena.Chars(i)) * (i))
            Next
        End If

        cliente._dvh = DVH

    End Function

    Shared Function CalcularDVH(ByVal campo As String) As Long
        Dim i As Integer
        Dim sumatoriaaux As Long = 0

        For i = 1 To campo.Length
            sumatoriaaux = sumatoriaaux + (Asc(campo.Substring(i - 1, 1)) * i)
        Next

        Return sumatoriaaux
    End Function
#End Region

#Region "Propiedades"
    'Propiedades utilizadas para la funcion ayuda
    Private mHlpFile As String
    Public Property HelpFile() As String
        Get
            Return mHlpFile
        End Get
        Set(ByVal value As String)
            mHlpFile = value
        End Set
    End Property

    Public Shared _CurrentUser As BE.Usuario
    Public Shared Property CurrentUser() As BE.Usuario
        Get
            Return _CurrentUser
        End Get
        Set(ByVal value As BE.Usuario)
            _CurrentUser = value
        End Set
    End Property

#End Region

End Class
