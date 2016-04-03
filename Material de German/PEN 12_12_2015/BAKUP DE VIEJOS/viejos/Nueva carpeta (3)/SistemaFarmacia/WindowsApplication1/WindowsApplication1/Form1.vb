Public Class Form1
    Public Event threadCompleted()
    Public Sub New()
        InitializeComponent()
        AddHandler threadCompleted, AddressOf Me.Thread_Completed
    End Sub

 
    Public Sub mithread()
        'simulate some work:
        Threading.Thread.Sleep(3000)
        'then raise the event when done
        RaiseEvent threadCompleted()
    End Sub

    Public Delegate Sub Thread_CompletedDelegate()
    Private Sub Thread_Completed()
        If Me.InvokeRequired Then
            Me.BeginInvoke(New Thread_CompletedDelegate(AddressOf Thread_Completed))
        Else
            If autoclose.Checked = True Then
                Me.Close()
            End If
        End If
    End Sub

    Private Sub Button1_Click_1(sender As Object, e As EventArgs) Handles Button1.Click
        Dim t1 As New Threading.Thread(AddressOf mithread)
        t1.Start()
    End Sub

    Sub Main()

        Dim thread_1 As System.Threading.Thread = New Threading.Thread(AddressOf mithread)
        thread_1.Start()

        System.Threading.Thread.Sleep(100)

        While Not thread_1.ThreadState = Threading.ThreadState.Running
            Console.WriteLine(thread_1.ThreadState.ToString)
            thread_1.Abort()
            Console.WriteLine(thread_1.ThreadState.ToString)
            If thread_1.ThreadState = Threading.ThreadState.Aborted Then Exit While
        End While

    End Sub

    Sub mithread()
    End Sub
End Class