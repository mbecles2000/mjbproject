Public Class Site
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("ses_Comp_ID") <> "" Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "LoginSuccess", "sucessLogin()", True)
            'Me.NavigationDefaultMenu.Visible = False
            'Me.NavigationMainLogoff.Visible = True
            'Me.NavigationMainMenu.Visible = True
            Me.td_CellMainLogin.Visible = False
            Me.td_CellMainMenu.Visible = True
            Me.td_CellMainLogoff.Visible = True
            Me.NavigationDefaultMenu.Width = "0"

            If Session("ses_BName") <> Nothing Then
                If Session("ses_BAdd2") = Nothing Then
                    Me.lbl_MainAddress.Text = "<b>" & Session("ses_CName") & "</b><br/>" & _
                       Session("ses_BAdd1") & "<br/>" & _
                       Session("ses_BCity") & ", " & _
                       Session("ses_BState") & " " & _
                        Session("ses_BZip") & "<br/>" & _
                        "PH#: " & Session("ses_BPhone") & " Fax: " & Session("ses_BFax")
                Else
                    Me.lbl_MainAddress.Text = "<b>" & Session("ses_CName") & "</b><br/>" & _
                         Session("ses_BAdd1") & "<br/>" & _
                        Session("ses_BAdd2") & "<br/>" & _
                       Session("ses_BCity") & ", " & _
                       Session("ses_BState") & " " & _
                        Session("ses_BZip") & "<br/>" & _
                        "PH#: " & Session("ses_BPhone") & " Fax: " & Session("ses_BFax")
                End If
            End If
            Me.updt_PanMaster.Update()
        Else
            'Me.NavigationDefaultMenu.Visible = True
            'Me.NavigationMainLogoff.Visible = False
            'Me.NavigationMainMenu.Visible = False
            Me.td_CellMainLogin.Visible = True
            Me.td_CellMainMenu.Visible = False
            Me.td_CellMainLogoff.Visible = False
        End If

    End Sub

End Class