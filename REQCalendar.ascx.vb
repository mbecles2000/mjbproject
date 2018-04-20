Public Class REQCalendar
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

    Public Delegate Sub TextChangedHandler(ByVal sender As Object, ByVal e As System.EventArgs)
    Public Event TextOnChanged As TextChangedHandler

    Protected Sub txt_Date_TextChanged(sender As Object, e As System.EventArgs) Handles txt_Date.TextChanged
        RaiseEvent TextOnChanged(sender, e)
    End Sub


End Class
