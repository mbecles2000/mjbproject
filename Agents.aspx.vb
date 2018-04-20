Public Class Agents
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Session("ses_Comp_ID") = Nothing Then
            Response.Redirect("Login.aspx")
        End If

        If Not Page.IsPostBack Then
            AgentList()
        End If

    End Sub


    Private Sub AgentList()

        Me.SqlDS_AgentList.SelectParameters.Clear()
        Me.SqlDS_AgentList.SelectParameters.Add("Company_ID", Session("ses_Comp_ID"))
        Me.SqlDS_AgentList.DataBind()
        Me.grdViewAgentList.DataBind()

    End Sub

    
    Private Sub grdViewAgentList_SelectedIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles grdViewAgentList.SelectedIndexChanging

        Try

            Dim slctdRow As GridViewRow = Me.grdViewAgentList.Rows(e.NewSelectedIndex)
            Me.txt_FirstName.Text = slctdRow.Cells(2).Text
            Me.txt_LastName.Text = slctdRow.Cells(3).Text

            Dim hdnUserID As HiddenField = TryCast(Me.grdViewAgentList.Rows(e.NewSelectedIndex).FindControl("hdn_UserID"), HiddenField)
            Me.txt_UserID.Text = hdnUserID.Value
            Me.lbl_UserID.Text = hdnUserID.Value

            Dim hdnIDNum As HiddenField = TryCast(Me.grdViewAgentList.Rows(e.NewSelectedIndex).FindControl("hdn_IDNum"), HiddenField)
            Me.hdn_IDNum.Value = hdnIDNum.Value

            Dim lblPassword As Label = TryCast(Me.grdViewAgentList.Rows(e.NewSelectedIndex).FindControl("lbl_Password"), Label)
            Dim str_Password As String = lblPassword.Text
            Decrypt_Str(str_Password)
            Me.hdnCurrentPassword.Value = str_Password

            Dim hdnBranchAccess As HiddenField = TryCast(Me.grdViewAgentList.Rows(e.NewSelectedIndex).FindControl("hdn_BranchAccess"), HiddenField)
            Dim hdnBranchID As HiddenField = TryCast(Me.grdViewAgentList.Rows(e.NewSelectedIndex).FindControl("hdn_BranchID"), HiddenField)
            Me.chkListBranchList.Items.Clear()
            Me.drp_MainBranchAccess.Items.Clear()
            Retrieve_AccessBranchList(Me.chkListBranchList, Session("ses_Comp_ID"), hdnBranchAccess.Value, hdnBranchID.Value, Me.drp_MainBranchAccess)

            Dim hdnMenuAccess As HiddenField = TryCast(Me.grdViewAgentList.Rows(e.NewSelectedIndex).FindControl("hdn_MenuAccess"), HiddenField)
            Me.chkListMaster.Items.Clear()
            Retrieve_MenuList(Me.chkListMaster, hdnMenuAccess.Value)

            Me.btn_AddUpdate.Text = "Update"

            Me.lbl_MsgAgentAddUpdate.Text = Nothing
            Me.lbl_ConfirmMessageOK.Text = Nothing

            Me.updtPan_AgentView.Update()

            If Session("ses_User_ID") = Me.lbl_UserID.Text Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PopupDivAgentView1", "popup('popUpDivAgentView','','100','blanket','600');HideHtmlButton('#btn_Delete');", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PopupDivAgentView2", "popup('popUpDivAgentView','','100','blanket','600');", True)
            End If

        Catch ex As Exception
            Me.lbl_MsgAgentAddUpdate.Text = Err.Description
            Err.Clear()
        End Try

    End Sub

    Private Sub btn_AddUpdate_Click(sender As Object, e As System.EventArgs) Handles btn_AddUpdate.Click

        Dim strResult As String = Nothing
       
        Dim strSW As String
        If Me.hdn_IDNum.Value = Nothing Then strSW = "I" Else strSW = "U"

        Dim str_UserAccess As String = Nothing
        'master menu
        For Each item As ListItem In Me.chkListMaster.Items
            If item.Selected Then
                If str_UserAccess = Nothing Then
                    str_UserAccess = item.Text
                Else
                    str_UserAccess = item.Text & "|" & str_UserAccess
                End If
            End If
        Next

        'branch access
        Dim str_UserBranchesAccess As String = Nothing
        For Each item As ListItem In Me.chkListBranchList.Items
            If item.Selected Then
                If str_UserAccess = Nothing Then
                    str_UserBranchesAccess = item.Value
                Else
                    str_UserBranchesAccess = item.Value & ", " & str_UserBranchesAccess
                End If
            End If
        Next

        Dim strPassword As String
        If Me.txt_Password.Text <> Nothing Then
            strPassword = Me.txt_Password.Text
            Encrypt_Str(strPassword)
        Else 'use the current password
            strPassword = Me.hdnCurrentPassword.Value
            Encrypt_Str(strPassword)
        End If

        AddUpdateAgent(Me.txt_FirstName.Text, Me.txt_LastName.Text, Me.txt_UserID.Text, _
                       strPassword, Session("ses_Comp_ID"), Me.drp_MainBranchAccess.SelectedValue, str_UserAccess, "null", str_UserBranchesAccess, 5, strSW, strResult)

        If InStr(strResult, "Error") > 0 Then
            lbl_MsgAgentAddUpdate.Text = strResult
        Else
            Me.lbl_ConfirmMessageOK.Text = strResult
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ConfirmMessageShow", "ConfirmMessageShow();", True)
        End If

    End Sub

    Private Sub btn_ConfirmOK_Click(sender As Object, e As System.EventArgs) Handles btn_ConfirmOK.Click

        AgentList()
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ClosePopupDivAgentView", "popup('popUpDivAgentView','','100','blanket','600');", True)
        Me.updtPan_AgentList.Update()

    End Sub

    Private Sub btn_AddNewAgent_Click(sender As Object, e As System.EventArgs) Handles btn_AddNewAgent.Click


        Me.txt_FirstName.Text = Nothing
        Me.txt_LastName.Text = Nothing
        Me.txt_Password.Text = Nothing
        Me.txt_UserID.Text = Nothing
        Me.lbl_ConfirmMessageOK.Text = Nothing
        Me.lbl_MsgAgentAddUpdate.Text = Nothing
        Me.lbl_UserID.Text = Nothing
        Me.hdn_IDNum.Value = Nothing
        Me.btn_AddUpdate.Text = "Add"

        Me.chkListMaster.Items.Clear()
        Retrieve_MenuList(Me.chkListMaster, Nothing)

        Me.chkListBranchList.Items.Clear()
        Me.drp_MainBranchAccess.Items.Clear()
        Retrieve_AccessBranchList(Me.chkListBranchList, Session("ses_Comp_ID"), Nothing, Nothing, Me.drp_MainBranchAccess)

        Me.updtPan_AgentView.Update()
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PopupDivAgentView", "popup('popUpDivAgentView','','100','blanket','600');HideHtmlButton('#btn_Delete')", True)

    End Sub

    Private Sub btn_DeleteCancel_Click(sender As Object, e As System.EventArgs) Handles btn_DeleteCancel.Click

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ClosePopupDivAgentView", "popup('popUpDivAgentView','','100','blanket','600');", True)

    End Sub

    Private Sub btn_DeleteYes_Click(sender As Object, e As System.EventArgs) Handles btn_DeleteYes.Click

        DeleteAgent(Me.lbl_UserID.Text, lbl_ConfirmMessageOK.Text)

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ConfirmMessageShow", "ConfirmMessageShow();", True)
        updtPan_AgentView.Update()

    End Sub
End Class