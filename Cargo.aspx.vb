Public Class Cargo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Session("ses_Comp_ID") = Nothing Then
            Response.Redirect("Login.aspx")
        End If

        If Not Page.IsPostBack Then
            Dim dt_FromServiceDate As Date = DateAdd(DateInterval.Day, -30, Today)
            Dim dt_ToServiceDate As Date = Today

            Me.ucFromCalendar.CalValue = dt_FromServiceDate
            Me.ucToCalendar.CalValue = dt_ToServiceDate
            GetCargoList(dt_FromServiceDate, dt_ToServiceDate, "All", Nothing)

            If Request.QueryString("a") = "nc" Then
                Me.lbl_HeaderCargo.Text = "New Cargo"
                Me.txt_SenderName.Text = Session("CargoSenderName")
                GetRecipientListDropList(Me.drp_RecipientName, Session("ses_Comp_ID"), Session("CargoRecipientID"), Session("CargoSenderID"))
                Me.hdn_SenderID.Value = Session("CargoSenderID")
                Me.hdn_RecipientID.Value = Session("CargoRecipientID")
                Me.hdn_IDNum.Value = Nothing

                'Session("CargoSenderID") = Nothing
                'Session("CargoSenderName") = Nothing
                'Session("CargoRecipientID") = Nothing

                Me.txt_BoxNumber.Text = "WNW"

                Me.btn_AddUpdateCargo.Text = "Add"
                Me.btn_DeleteCargo.Visible = False
                Me.updtPan_CargoEdit.Update()

                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PopupCargoEdit", "popup('popUpDivCargoEdit','','200','blanket','500');", True)
            End If

        End If

    End Sub

    Private Sub GetCargoList(ByVal dt_FromServiceDate As Date, ByVal dt_ToServiceDate As Date, str_Status As String, str_Search As String)

        Try
            Me.SqlDS_CargoList.SelectParameters.Clear()
            Me.SqlDS_CargoList.SelectParameters.Add("Comp_ID", Session("ses_Comp_ID"))
            Me.SqlDS_CargoList.SelectParameters.Add("FServiceDate", dt_FromServiceDate)
            Me.SqlDS_CargoList.SelectParameters.Add("TServiceDate", dt_ToServiceDate)
            If str_Search <> Nothing Then Me.SqlDS_CargoList.SelectParameters.Add("StrToSearch", str_Search)
            Me.SqlDS_CargoList.SelectParameters.Add("Export", "N")
            Me.SqlDS_CargoList.SelectParameters.Add("StatOption", str_Status)

            Me.SqlDS_CargoList.DataBind()
            Me.grdViewCargoList.DataBind()
        Catch ex As Exception
            Err.Clear()
        End Try

    End Sub

    Private Sub btn_FilterCargoList_Click(sender As Object, e As System.EventArgs) Handles btn_FilterCargoList.Click

        GetCargoList(Me.ucFromCalendar.CalValue, Me.ucToCalendar.CalValue, Me.drp_CargoStatusFilter.SelectedValue, Nothing)
      
    End Sub

    Private Sub SqlDS_CargoList_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDS_CargoList.Selected

        If e.AffectedRows > 0 Then
            Me.lbl_Total.Text = e.AffectedRows
        End If

        If e.AffectedRows = 0 Then Me.btn_ExportCargotoExcel.Enabled = False Else Me.btn_ExportCargotoExcel.Enabled = True

    End Sub

    Private Sub grdViewCargoList_SelectedIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles grdViewCargoList.SelectedIndexChanging

        Try

            Dim slctdRow As GridViewRow = Me.grdViewCargoList.Rows(e.NewSelectedIndex)
            Me.txt_BoxNumber.Text = slctdRow.Cells(1).Text
            Me.txt_SenderName.Text = slctdRow.Cells(2).Text
         
            Dim hdnIDNumber As HiddenField = TryCast(Me.grdViewCargoList.Rows(e.NewSelectedIndex).FindControl("hdn_IDNumber"), HiddenField)
            Dim hdnServiceType As HiddenField = TryCast(Me.grdViewCargoList.Rows(e.NewSelectedIndex).FindControl("hdn_ServiceType"), HiddenField)
            Dim hdnCtrlNumber As HiddenField = TryCast(Me.grdViewCargoList.Rows(e.NewSelectedIndex).FindControl("hdn_CtrlNumber"), HiddenField)
            Dim hdnServiceCharge As HiddenField = TryCast(Me.grdViewCargoList.Rows(e.NewSelectedIndex).FindControl("hdn_ServiceCharge"), HiddenField)
            Dim hdnAgentCharge As HiddenField = TryCast(Me.grdViewCargoList.Rows(e.NewSelectedIndex).FindControl("hdn_AgentCharge"), HiddenField)
            Dim hdnAgentCode As HiddenField = TryCast(Me.grdViewCargoList.Rows(e.NewSelectedIndex).FindControl("hdn_AgentCode"), HiddenField)
            Dim hdnServiceDate As HiddenField = TryCast(Me.grdViewCargoList.Rows(e.NewSelectedIndex).FindControl("hdn_ServiceDate"), HiddenField)
            Dim hdnNotes As HiddenField = TryCast(Me.grdViewCargoList.Rows(e.NewSelectedIndex).FindControl("hdn_Notes"), HiddenField)

            Dim hdnSenderID As HiddenField = TryCast(Me.grdViewCargoList.Rows(e.NewSelectedIndex).FindControl("hdn_SenderID"), HiddenField)
            Dim hdnRecipientID As HiddenField = TryCast(Me.grdViewCargoList.Rows(e.NewSelectedIndex).FindControl("hdn_RecipientID"), HiddenField)

            Me.txt_CtrlNumber.Text = hdnCtrlNumber.Value

            Me.txt_ServiceCharge.Text = Replace(FormatCurrency(hdnServiceCharge.Value, 2), "$", "")
            'Me.txt_AgentCharge.Text = Replace(FormatCurrency(hdnAgentCharge.Value, 2), "$", "")
            Me.txt_AgentCode.Text = hdnAgentCode.Value
            ucServiceDate.CalValue = FormatDateTime(hdnServiceDate.Value, DateFormat.ShortDate)
            'Me.lbl_Notes.Text = hdnNotes.Value
            Me.txt_NewNotes.Text = hdnNotes.Value

            Me.hdn_SenderID.Value = hdnSenderID.Value
            Me.hdn_RecipientID.Value = hdnRecipientID.Value
            Me.hdn_IDNum.Value = hdnIDNumber.Value

            Me.lbl_HeaderCargo.Text = "Update Cargo"

            GetRecipientListDropList(Me.drp_RecipientName, Session("ses_Comp_ID"), hdnRecipientID.Value, hdnSenderID.Value)
            Me.btn_AddUpdateCargo.Text = "Update"
            Me.btn_DeleteCargo.Visible = True

            Me.ConfirmExt_DeleteCargo.ConfirmText = "Are you sure you want to delete this box " & Me.txt_BoxNumber.Text & " now?"
            Me.updtPan_CargoEdit.Update()

            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PopupCargoEdit", "popup('popUpDivCargoEdit','','200','blanket','500');", True)

        Catch ex As Exception
            Err.Clear()
        End Try

    End Sub

    Private Sub btn_SearchCargo_Click(sender As Object, e As System.EventArgs) Handles btn_SearchCargo.Click

        GetCargoList(Me.ucFromCalendar.CalValue, Me.ucToCalendar.CalValue, Me.drp_CargoStatusFilter.SelectedValue, Me.txt_SearchCargo.Text)

    End Sub

    Private Sub btn_AddUpdateCargo_Click(sender As Object, e As System.EventArgs) Handles btn_AddUpdateCargo.Click

        Dim blnError As Boolean

        If Page.IsValid Then
            Try
                Dim strResult As String = Nothing

                'Dim strIDName As String = Me.hdn_IDNum.Value
                'If strIDName = not
                'AddUpdateCargo(Me.hdn_IDNum.Value, Session("ses_Comp_ID"), Me.hdn_SenderID.Value, Me.hdn_RecipientID.Value, _
                '                 Me.txt_CtrlNumber.Text, Me.txt_BoxNumber.Text, Me.txt_ServiceCharge.Text, 0, _
                '                     Me.txt_AgentCode.Text, Me.ucServiceDate.CalValue, vbNullString, vbNullString, _
                '                     Me.lbl_Notes.Text & vbCrLf & " " & Me.txt_NewNotes.Text & vbCrLf & "*Entered By: " & Session("ses_User_ID"), _
                '                    Session("ses_User_ID"), strResult)

                Dim strRecipientID As String = Me.drp_RecipientName.SelectedValue

                AddUpdateCargo(Me.hdn_IDNum.Value, Session("ses_Comp_ID"), Me.hdn_SenderID.Value, strRecipientID, _
                                Me.txt_CtrlNumber.Text, Me.txt_BoxNumber.Text, Me.txt_ServiceCharge.Text, 0, _
                                    Me.txt_AgentCode.Text, Me.ucServiceDate.CalValue, vbNullString, vbNullString, _
                                   Me.txt_NewNotes.Text, _
                                   Session("ses_User_ID"), strResult)


                Select Case strResult
                    Case "Updated"
                        Me.lbl_ConfirmMessageOK.Text = "Cargo Updated Successfully!"
                    Case "Exists"
                        Me.lbl_MsgCargo.Text = "Box Number already exists please enter a new Box Number!"
                        blnError = True
                    Case "Inserted"
                        Me.lbl_ConfirmMessageOK.Text = "Cargo Added Successfully!"
                    Case Else
                        Me.lbl_MsgCargo.Text = "Box Number Already Exists!" 'strResult
                        blnError = True
                End Select

                Me.updtPan_CargoEdit.Update()

            Catch ex As Exception
                lbl_MsgCargo.Text = "Box Number Already Exists!" ' Err.Description
                blnError = True
                Err.Clear()
            End Try

            If blnError = False Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ConfirmMessageShow", "ConfirmMessageShow();", True)
            End If
        End If


    End Sub

    Private Sub btn_ConfirmOK_Click(sender As Object, e As System.EventArgs) Handles btn_ConfirmOK.Click

        GetCargoList(Me.ucFromCalendar.CalValue, Me.ucToCalendar.CalValue, Me.drp_CargoStatusFilter.SelectedValue, Nothing)
        Me.updtPan_CargoList.Update()
        Response.Redirect("./Customer.aspx")

    End Sub

    Private Sub btn_DeleteCargo_Click(sender As Object, e As System.EventArgs) Handles btn_DeleteCargo.Click

        DeleteCargo(Me.hdn_IDNum.Value, Me.lbl_ConfirmMessageOK.Text)

        If Me.lbl_ConfirmMessageOK.Text = "Deleted" Then Me.lbl_ConfirmMessageOK.Text = "Box " & Me.txt_BoxNumber.Text & " Deleted Sucessfully!"
        Me.updtPan_CargoEdit.Update()
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ConfirmMessageShow", "ConfirmMessageShow();", True)

    End Sub

    Private Sub btn_PrintViewCargo_Click(sender As Object, e As System.EventArgs) Handles btn_PrintViewCargo.Click

        Me.UcCalendarSelectDateCargoPickupDate.CalValue = Today
        SelectLocationList(Me.drp_SelectLocation, Session("ses_Comp_ID"))

        Me.pan_UpdateCargoSchedule.Visible = False

        GetCargoSchedule()

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "popUpDivViewPrintPickupSched", "popup('popUpDivViewPrintPickupSched','','100','blanket1','800');", True)

    End Sub

    Private Sub GetCargoSchedule()

        Me.pan_ViewPrintSchedule.Visible = True

        Me.SqlDS_PrintViewSchedulePickup.SelectParameters.Clear()
        Me.SqlDS_PrintViewSchedulePickup.SelectParameters.Add("Pickup_Date", UcCalendarSelectDateCargoPickupDate.CalValue)
        Me.SqlDS_PrintViewSchedulePickup.SelectParameters.Add("Sender_Company_ID", Session("ses_Comp_ID"))
        If Me.drp_SelectLocation.SelectedValue <> "" Then Me.SqlDS_PrintViewSchedulePickup.SelectParameters.Add("Sender_City", Me.drp_SelectLocation.SelectedValue)

        Me.SqlDS_PrintViewSchedulePickup.DataBind()
        Me.grdViewSchedulePickupList.DataBind()

        If Int(lbl_TotalCargoSched.Text) > 0 Then
            pan_ViewPrintSchedule.Height = "500"
        Else
            pan_ViewPrintSchedule.Height = "200"
        End If

        Me.lbl_SelectedDate.Text = "Pick up Date: " & UcCalendarSelectDateCargoPickupDate.CalValue
        Me.lbl_MsgCargoPickupSched.Text = UcCalendarSelectDateCargoPickupDate.CalValue

        Dim strAllLocation As String = Me.drp_SelectLocation.SelectedValue
        If strAllLocation = "" Then strAllLocation = "All"
        Me.lbl_Location.Text = "Location: " & strAllLocation

        If Me.grdViewSchedulePickupList.Rows.Count > 0 Then
            Me.tbl_CargoHeaderPickUpList.Visible = True
            If Session("ses_BAdd2") = Nothing Then
                Me.lbl_Address.Text = "<b>" & Session("ses_CName") & "</b><br/>" & _
                     Session("ses_BAdd1") & "<br/>" & _
                   Session("ses_BCity") & ", " & _
                   Session("ses_BState") & " " & _
                    Session("ses_BZip") & "<br/>" & _
                    "PH#: " & Session("ses_BPhone") & " Fax: " & Session("ses_BFax")
            Else
                Me.lbl_Address.Text = "<b>" & Session("ses_CName") & "</b><br/>" & _
                     Session("ses_BAdd1") & "<br/>" & _
                    Session("ses_BAdd2") & "<br/>" & _
                   Session("ses_BCity") & ", " & _
                   Session("ses_BState") & " " & _
                    Session("ses_BZip") & "<br/>" & _
                    "PH#: " & Session("ses_BPhone") & " Fax: " & Session("ses_BFax")
            End If
        End If

        Me.updtPan_ViewPrintPickupSched.Update()

    End Sub

    Private Sub btn_PrintViewCargoSched_Click(sender As Object, e As System.EventArgs) Handles btn_PrintViewCargoSched.Click

        Me.lbl_MsgCargoEdit.Text = Me.UcCalendarSelectDateCargoPickupDate.CalValue
        GetCargoSchedule()
        Me.pan_UpdateCargoSchedule.Visible = False
        Me.pan_CargoList.Visible = False

        Me.pan_ViewPrintSchedule.Visible = True

        Me.updtPan_CargoPrintSchedule.Update()
        Me.updtPan_CargoList.Update()

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "popUpDivViewPrintPickupSched", "popup('popUpDivViewPrintPickupSched','','100','blanket1','800')", True)


    End Sub

    Private Sub SqlDS_PrintViewSchedulePickup_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDS_PrintViewSchedulePickup.Selected

        If e.AffectedRows > 0 Then
            Me.lbl_TotalCargoSched.Text = e.AffectedRows
        Else
            Me.lbl_TotalCargoSched.Text = 0
        End If


    End Sub

    Private Sub grdViewSchedulePickupList_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles grdViewSchedulePickupList.RowCommand

        Try
            'If e.CommandArgument <> Nothing Then

            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim row As GridViewRow = grdViewSchedulePickupList.Rows(index)

            Dim lbl_SenderAdd1 As Label = TryCast(row.Cells(1).FindControl("lbl_SenderAdd1"), Label)
            Dim lbl_SenderCity As Label = TryCast(row.Cells(1).FindControl("lbl_SenderCity"), Label)
            Dim lbl_SenderState As Label = TryCast(row.Cells(1).FindControl("lbl_SenderState"), Label)
            Dim lbl_SenderZip As Label = TryCast(row.Cells(1).FindControl("lbl_SenderZip"), Label)



            Dim strToAddress As String = Replace(lbl_SenderAdd1.Text, " ", "+") & "+" & Replace(lbl_SenderCity.Text, " ", "+") & "+" & Replace(lbl_SenderState.Text, " ", "+") & "+" & _
                                Replace(lbl_SenderZip.Text, " ", "+")

            Dim strFromAddress As String = Replace(Session("ses_BAdd1"), " ", "+") & "+" & Replace(Session("ses_BAdd1"), " ", "+") & _
                                    "+" & Replace(Session("ses_BAdd2"), " ", "+") & _
                                    "+" & Replace(Session("ses_BCity"), " ", "+") & _
                                    "+" & Replace(Session("ses_BZip"), " ", "+")

            'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "OpenDirection", "OpenDirection('https://www.google.com/maps/dir/" & strFromAddress & "/" & strToAddress & "')", True)

            'End If
        Catch ex As Exception
            Err.Clear()
        End Try


    End Sub


    Private Sub btn_EditCargoSched_Click(sender As Object, e As System.EventArgs) Handles btn_EditCargoSched.Click


        Me.lbl_MsgCargoEdit.Text = Me.UcCalendarSelectDateCargoPickupDate.CalValue
        GetEditCargoSched(True)

    End Sub

    Private Sub SqlDS_UpdateCargoSchedule_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDS_UpdateCargoSchedule.Selected

        If e.AffectedRows > 0 Then
            Me.lbl_TotalCargoPickupUpdate.Text = e.AffectedRows
        Else
            Me.lbl_TotalCargoPickupUpdate.Text = 0
        End If


    End Sub

    'Private Sub btn_PrintCargoSched_Click(sender As Object, e As System.EventArgs) Handles btn_PrintCargoSched.Click

    '    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PrintDiv", "PrintDiv('divPrintSchedulePickup')", True)
    'End Sub


    Private Sub GetEditCargoSched(ByVal blnShowHide As Boolean)

        Me.SqlDS_UpdateCargoSchedule.SelectParameters.Clear()
        Me.SqlDS_UpdateCargoSchedule.SelectParameters.Add("Pickup_Date", UcCalendarSelectDateCargoPickupDate.CalValue)
        Me.SqlDS_UpdateCargoSchedule.SelectParameters.Add("Sender_Company_ID", Session("ses_Comp_ID"))

        Me.SqlDS_UpdateCargoSchedule.DataBind()
        Me.grdViewUpdateCargoSchedlue.DataBind()

        If blnShowHide Then
            Me.pan_UpdateCargoSchedule.Visible = True
            Me.pan_ViewPrintSchedule.Visible = False
        End If

        Me.updtPan_ViewPrintPickupSched.Update()

    End Sub


    Private Sub grdViewUpdateCargoSchedlue_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles grdViewUpdateCargoSchedlue.RowCommand


        Try
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)

            If e.CommandName = "MoveUp" Then
                If index > 0 Then
                    Dim rowSelected As GridViewRow = Me.grdViewUpdateCargoSchedlue.Rows(index) 'selected row index
                    Dim rowUp As GridViewRow = Me.grdViewUpdateCargoSchedlue.Rows(index - 1) 'row above

                    CargoUpdateTripNumber(Me.grdViewUpdateCargoSchedlue.DataKeys(rowUp.RowIndex).Value(), rowSelected.Cells(0).Text, "Y") 'move down
                    CargoUpdateTripNumber(Me.grdViewUpdateCargoSchedlue.DataKeys(rowSelected.RowIndex).Value(), rowUp.Cells(0).Text, "Y") 'move up
                    GetEditCargoSched(False)
                End If
            End If

            If e.CommandName = "MoveDown" Then
                If Me.grdViewUpdateCargoSchedlue.Rows.Count - 1 > index Then
                    Dim rowSelected As GridViewRow = Me.grdViewUpdateCargoSchedlue.Rows(index) 'selected row index
                    Dim rowDown As GridViewRow = Me.grdViewUpdateCargoSchedlue.Rows(index + 1) 'row down
                    CargoUpdateTripNumber(Me.grdViewUpdateCargoSchedlue.DataKeys(rowDown.RowIndex).Value(), rowSelected.Cells(0).Text, "Y") 'move down
                    CargoUpdateTripNumber(Me.grdViewUpdateCargoSchedlue.DataKeys(rowSelected.RowIndex).Value(), rowDown.Cells(0).Text, "Y") 'move up
                    GetEditCargoSched(False)
                End If
            End If

        Catch ex As Exception
            lbl_MsgCargoEdit.Text = Err.Description
            Err.Clear()
        End Try


    End Sub

    Private Sub btn_ExportCargotoExcel_Click(sender As Object, e As System.EventArgs) Handles btn_ExportCargotoExcel.Click

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "OpenDirection", "OpenDirection('ExportExcel.aspx?fromDate=" & ucFromCalendar.CalValue & "&toDate=" & ucToCalendar.CalValue & "&Status=" & Me.drp_CargoStatusFilter.SelectedValue & "&strSearch=" & Me.txt_SearchCargo.Text & "')", True)

    End Sub

    Private Sub btn_AddMore_Click(sender As Object, e As System.EventArgs) Handles btn_AddMore.Click
        Response.Redirect("./Cargo.aspx?a=nc")
    End Sub



    Private Sub grdViewSchedulePickupList_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdViewSchedulePickupList.RowDataBound

        'Try

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lblCargoNotes As Label = TryCast(e.Row.FindControl("lbl_CargoNotes"), Label)
            Dim lblSenderAdd2 As Label = TryCast(e.Row.FindControl("lbl_SenderAdd2"), Label)

            Dim strCargoNotes() As String
            strCargoNotes = Split(lblCargoNotes.Text, ">")
            lblCargoNotes.Text = Replace(strCargoNotes(0), "=", "")

        End If
        'Catch ex As Exception
        '    Err.Clear()
        'End Try



    End Sub
End Class