Public Class Calendar
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    Public Property CalValue() As String
        Get
            Return txt_Date.Text
        End Get
        Set(ByVal value As String)
            txt_Date.Text = value
        End Set
    End Property


   
End Class