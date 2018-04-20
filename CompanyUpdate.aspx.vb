Public Class CompanyUpdate
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("ses_Comp_ID") = Nothing Then
            Response.Redirect("Login.aspx")
        End If

        If Not Page.IsPostBack Then
            CompanyList()
        End If

    End Sub


    Private Sub CompanyList()

        Me.SqlDS_ServiceList.SelectParameters.Clear()
        Me.SqlDS_ServiceList.SelectParameters.Add("Comp_ID", Session("ses_Comp_ID"))
        Me.SqlDS_ServiceList.DataBind()
        Me.grdViewServiceTypeList.DataBind()

    End Sub


    Private Sub grdViewServiceTypeList_SelectedIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles grdViewServiceTypeList.SelectedIndexChanging

        Try
            Dim hdnServiceType As HiddenField = TryCast(Me.grdViewServiceTypeList.Rows(e.NewSelectedIndex).FindControl("hdn_ServiceType"), HiddenField)
            Dim hdnServiceDesc As HiddenField = TryCast(Me.grdViewServiceTypeList.Rows(e.NewSelectedIndex).FindControl("hdn_ServiceDesc"), HiddenField)
            Dim hdnServiceCharge As HiddenField = TryCast(Me.grdViewServiceTypeList.Rows(e.NewSelectedIndex).FindControl("hdn_ServiceCharge"), HiddenField)
            Dim hdnIDNum As HiddenField = TryCast(Me.grdViewServiceTypeList.Rows(e.NewSelectedIndex).FindControl("hdn_IDNum"), HiddenField)

            Me.txt_ServTypeCode.Text = hdnServiceType.Value
            Me.txt_ServDesc.Text = hdnServiceDesc.Value
            Me.txt_ServCharge.Text = hdnServiceCharge.Value
            Me.lbl_ServiceID.Text = hdnIDNum.Value
            Me.btn_AddUpdate.Text = "Update"

            Me.btn_DeleteService.Visible = True

            Me.updtPan_ServiceList.Update()

            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PopupServiceListView", "popup('popUpDivServiceList','','200','blanket','500');", True)
        Catch ex As Exception
            Me.lbl_MsgAddUpdateServiceList.Text = Err.Description
        End Try
       

    End Sub

    Private Sub btn_AddUpdate_Click(sender As Object, e As System.EventArgs) Handles btn_AddUpdate.Click


        Dim strResult As String = Nothing
        Dim blnError As Boolean = False

        InsertUpdateServiceList(Me.lbl_ServiceID.Text, Session("ses_Comp_ID"), Me.txt_ServTypeCode.Text, Me.txt_ServDesc.Text, Me.txt_ServCharge.Text, strResult)

        If strResult = "Exists" Then
            Me.lbl_ConfirmMessageOK.Text = "Service type code already exists, please enter a different service type code!"
        ElseIf strResult = "Inserted" Then
            Me.lbl_ConfirmMessageOK.Text = "Service type code added suceessfully!"
        ElseIf strResult = "Updated" Then
            Me.lbl_ConfirmMessageOK.Text = "Service type updated suceessfully!"
        Else
            Me.lbl_MsgAddUpdateServiceList.Text = strResult
            blnError = True
        End If

        If blnError = False Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ConfirmMessageShow", "ConfirmMessageShow();", True)
        End If

    End Sub


    Private Sub btn_ConfirmOK_Click(sender As Object, e As System.EventArgs) Handles btn_ConfirmOK.Click

        CompanyList()
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ClosePopupDivServList", "popup('popUpDivServiceList','','200','blanket','500')", True)
        Me.updtPan_GrdviewServiceTypeList.Update()

    End Sub


    Private Sub btn_AddNewServiceList_Click(sender As Object, e As System.EventArgs) Handles btn_AddNewServiceList.Click

        Me.txt_ServCharge.Text = Nothing
        Me.txt_ServDesc.Text = Nothing
        Me.txt_ServTypeCode.Text = Nothing
        Me.lbl_ConfirmMessageOK.Text = Nothing
        'Me.lbl_MsgAddUpdateServiceList.Text = Nothing
        Me.lbl_ServiceID.Text = Nothing

        Me.btn_AddUpdate.Text = "Add"

        Me.updtPan_ServiceList.Update()
        Me.btn_DeleteService.Visible = False
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PopupServiceListView", "popup('popUpDivServiceList','','200','blanket','500');", True)

    End Sub

    'Private Sub btn_DeleteCancel_Click(sender As Object, e As System.EventArgs) Handles btn_DeleteCancel.Click

    'End Sub


    Private Sub btn_DeleteService_Click(sender As Object, e As System.EventArgs) Handles btn_DeleteService.Click

        Dim strResult As String = Nothing
        DeleteItems(Me.lbl_ServiceID.Text, "ST", strResult)

        If strResult = Nothing Then
            lbl_ConfirmMessageOK.Text = "Service deleted successfully"
        Else
            lbl_ConfirmMessageOK.Text = strResult
        End If
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ConfirmMessageShow", "ConfirmMessageShow();", True)

    End Sub
End Class