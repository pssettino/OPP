Public Interface ICRUD(Of T)

    'Metodos ICRUD
    Function Alta(ByVal objAlta As T) As Boolean
    Function Baja(ByVal objBaja As T) As Boolean
    Function Modificar(ByVal objAct As T) As Boolean
    Function Listar() As List(Of T)

End Interface
