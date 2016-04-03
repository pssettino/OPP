'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BLL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On

Imports System.Security
Imports System.IO
Imports System.Text
Imports System.Windows.Forms
Imports System.Windows.Forms.VisualStyles.VisualStyleElement

Public Class Traduccion

    Dim TraduccionDAL As New DAL.Traduccion
    Dim IdiomaBE As BE.Idioma

    Public Sub New(ByVal IdiomaBEParam As BE.Idioma)
        IdiomaBE = IdiomaBEParam
    End Sub

    Public Sub TraducirForm(ByRef Form As Form)
        If IdiomaBE IsNot Nothing Then
            ' CAMBIO EL TEXTO DE LA VENTANA
            Form.Text = TraducirTexto(Form.Text)
            If Form.MainMenuStrip IsNot Nothing Then
                ' CAMBIO LOS TEXTOS DEL MENU
                For Each MenuStrip In Form.MainMenuStrip.Items
                    MenuStrip.Text = TraducirTexto(MenuStrip.Text)
                    For i = 0 To MenuStrip.DropDown.Items.Count - 1
                        MenuStrip.DropDown.Items(i).Text = TraducirTexto(MenuStrip.DropDown.Items(i).Text)
                    Next
                Next
            End If
            For Each Control In Form.Controls
                If Control.GetType = GetType(System.Windows.Forms.DataGridView) Then
                    ' CAMBIO LOS TEXTOS DE LOS BOTONES DE LOS DATAGRIDVIEW 
                    For Each Column In Control.Columns
                        Column.HeaderText = TraducirTexto(Column.HeaderText)
                        If Column.GetType = GetType(System.Windows.Forms.DataGridViewButtonColumn) Then
                            Column.Text = TraducirTexto(Column.text)
                        End If
                    Next
                ElseIf Control.GetType = GetType(System.Windows.Forms.Label) Then
                    ' CAMBIO LOS TEXTOS DE LOS LABELS
                    Control.Text = TraducirTexto(Control.text)
                ElseIf Control.GetType = GetType(System.Windows.Forms.Button) Then
                    ' CAMBIO LOS TEXTOS DE LOS BOTONES
                    Control.Text = TraducirTexto(Control.text)
                ElseIf Control.GetType = GetType(System.Windows.Forms.GroupBox) Then
                    Control.text = TraducirTexto(Control.text)
                    For Each ctrl As Control In Control.controls
                        If ctrl.GetType = GetType(System.Windows.Forms.Label) Then
                            ' CAMBIO LOS TEXTOS DE LOS LABELS
                            ctrl.Text = TraducirTexto(ctrl.Text)
                        ElseIf ctrl.GetType = GetType(System.Windows.Forms.Button) Then
                            ' CAMBIO LOS TEXTOS DE LOS BOTONES
                            ctrl.Text = TraducirTexto(ctrl.Text)
                        End If
                    Next
                End If
            Next
            For Each GroupBoxCntrol As Control In Form.Controls
                If TypeOf GroupBoxCntrol Is GroupBox Then
                    For Each cntrl As Control In GroupBoxCntrol.Controls
                        'cntrl.Text = TraducirTexto(cntrl.Text)
                        If cntrl.GetType = GetType(System.Windows.Forms.DataGridView) Then
                            For Each Item In DirectCast(cntrl, System.Windows.Forms.DataGridView).Columns
                                Item.HeaderText = TraducirTexto(Item.HeaderText)
                                If Item.GetType = GetType(System.Windows.Forms.DataGridViewButtonColumn) Then
                                    Item.Text = TraducirTexto(Item.Text)
                                End If
                            Next
                        End If
                    Next
                End If
            Next
        End If


        For Each Control In Form.Controls
            If Control.GetType = GetType(System.Windows.Forms.TextBox) Then
                If (Control.MaxLength = 32767 And Control.Multiline = False) Then
                    Control.MaxLength = 256
                End If
            ElseIf Control.GetType = GetType(System.Windows.Forms.NumericUpDown) Then
                Control.Maximum = 9999999900
                Control.ReadOnly = True
            End If
        Next
    End Sub

    Public Function TraducirTexto(ByVal Texto As String) As String
        If IdiomaBE Is Nothing Or Texto = "" Or IdiomaBE.IdiomaId = 1 Then
            Return Texto
        Else
            Dim Traduccion = TraduccionDAL.CargarTraduccion(Texto, IdiomaBE)
            If Traduccion <> "" Then
                Return Traduccion
            Else
                Return Texto
            End If
        End If
    End Function

End Class