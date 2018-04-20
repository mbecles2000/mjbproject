Public Class Customer
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("ses_Comp_ID") = Nothing Then
            Response.Redirect("Login.aspx")
        End If

        If Not Page.IsPostBack Then

            Dim dt_FromServiceDate As Date = DateAdd(DateInterval.Day, -30, Today)
            Dim dt_ToServiceDate As Date = Today

            If Session("ses_SearchCustomer") <> Nothing Then
                Me.txt_SearchCustomer.Text = Session("ses_SearchCustomer")
                Me.drp_SearchCategory.SelectedValue = Session("ses_SearchCategory")

                If drp_SearchCategory.SelectedValue = "C" Then
                    GetCustomerList(Me.txt_SearchCustomer.Text, Nothing, Nothing)
                Else
                    GetSearchRecipientList(Me.txt_SearchCustomer.Text)
                End If
                Session("ses_SearchCustomer") = Nothing
            Else
                GetCustomerList(Nothing, Nothing, Nothing, "A")
            End If
        End If
        

    End Sub


    Private Sub GetCustomerList(ByVal str_Search As String, strAlpha1 As String, strAlpha2 As String, Optional strOption As String = Nothing)


        Try

            Me.lbl_SubHeader.Text = "Customer List"
            Me.pan_CustomerList.Visible = True
            Me.pan_RecipientList.Visible = False

            Me.SqlDS_CustomerList.SelectParameters.Clear()
            Me.SqlDS_CustomerList.SelectParameters.Add("Company_ID", Session("ses_Comp_ID"))
            'Me.SqlDS_CustomerList.SelectParameters.Add("AlphaGrp1", strAlpha1)
            'Me.SqlDS_CustomerList.SelectParameters.Add("AlphaGrp2", strAlpha2)
            If strOption <> Nothing Then Me.SqlDS_CustomerList.SelectParameters.Add("Option", strOption)
            If str_Search <> Nothing Then Me.SqlDS_CustomerList.SelectParameters.Add("Search_String", str_Search)

            Me.SqlDS_CustomerList.DataBind()
            Me.grdViewCustomerList.DataBind()

        Catch ex As Exception
            'Me.lbl_Total.Text = Err.Description
            Err.Clear()
        End Try

    End Sub

    Private Sub GetSearchRecipientList(ByVal str_Search As String)


        Try
            Me.lbl_SubHeader.Text = "Recipient List"
            Me.pan_CustomerList.Visible = False
            Me.pan_RecipientList.Visible = True

            Me.sqlDS_SearchRecipient.SelectParameters.Clear()
            Me.sqlDS_SearchRecipient.SelectParameters.Add("Company_ID", Session("ses_Comp_ID"))
            Me.sqlDS_SearchRecipient.SelectParameters.Add("SearchStr", str_Search)

            Me.sqlDS_SearchRecipient.DataBind()
            Me.grdViewSearchRecipientList.DataBind()

        Catch ex As Exception
            lbl_SubHeader.Text = Err.Description
            Err.Clear()
            'Me.lbl_Total.Text = Err.Description
        End Try

    End Sub


    Private Sub SqlDS_CustomerList_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDS_CustomerList.Selected

        If e.AffectedRows > 0 Then
            Me.lbl_Total.Text = e.AffectedRows
        Else
            Me.lbl_Total.Text = 0
        End If


    End Sub

    Private Sub grdViewCustomerList_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles grdViewCustomerList.RowCommand

        Try
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim row As GridViewRow = grdViewCustomerList.Rows(index)

            If e.CommandName = "Recipient" Then
                'Me.lbl_Total.Text = "Test " & grdViewCustomerList.DataKeys(row.RowIndex).Value

                EnableDisableREQFields(True, False)

                GetRecipientList(grdViewCustomerList.DataKeys(row.RowIndex).Value)
                Me.lbl_CustomerName.Text = row.Cells(1).Text
                Me.hdn_SenderID.Value = grdViewCustomerList.DataKeys(row.RowIndex).Value
                Me.pan_CustomerRecipientInfoList.Visible = True
                Me.pan_AddUpdateRecipient.Visible = False
                Me.pan_RecipientHistoryAddress.Visible = False
                Me.updtPan_CustomerRecipientEdit.Update()
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PopupCustomerRecipientEdit", "popup('popUpDivCustomerRecipientEdit','','100','blanket','700');", True)

            ElseIf e.CommandName = "NewCargoPickUp" Then

                GetCargoListSchedule(grdViewCustomerList.DataKeys(row.RowIndex).Value)
                Me.hdn_SenderIDCargo.Value = grdViewCustomerList.DataKeys(row.RowIndex).Value
                Me.lbl_SenderName.Text = row.Cells(1).Text
                Me.pan_PickupCargoAdd.Visible = False
                Me.pan_PickupCargoList.Visible = True
                Me.updtPan_PickupCargo.Update()
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "popUpDivAddPickupCargo", "popup('popUpDivAddPickupCargo','','200','blanket','700');", True)

                'Me.updtPan_CustomerList.Update()
            ElseIf e.CommandName = "CargoHistory" Then
                Me.SQLDS_HistoryCargo.SelectParameters.Clear()
                Me.SQLDS_HistoryCargo.SelectParameters.Add("Sender_ID", grdViewCustomerList.DataKeys(row.RowIndex).Value)
                Me.SQLDS_HistoryCargo.SelectParameters.Add("Company_ID", Session("ses_Comp_ID"))
                Me.SQLDS_HistoryCargo.SelectParameters.Add("ForHistory", "Y")
                Me.SQLDS_HistoryCargo.DataBind()
                Me.grdview_CargoHistory.DataBind()

                Me.updtPan_CargoHistory.Update()
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "popUpDivAddHistoryCargo", "popup('popupDivCargoHistory','','200','blanket','700');", True)

            End If
        Catch ex As Exception
            Err.Clear()
        End Try


    End Sub

    Private Sub EnableDisableREQFields(blnRecipient As Boolean, blnCustomer As Boolean)

        Me.reqFieldRecipient1.Enabled = blnRecipient
        Me.reqFieldRecipient2.Enabled = blnRecipient
        Me.reqFieldRecipient3.Enabled = blnRecipient
        Me.reqFieldRecipient4.Enabled = blnRecipient
        'Me.reqFieldRecipient5.Enabled = blnRecipient
        'Me.reqFieldRecipient6.Enabled = blnRecipient
        Me.updtPan_CustomerRecipientEdit.Update()

        Me.reqFieldCustomer1.Enabled = blnCustomer
        Me.reqFieldCustomer2.Enabled = blnCustomer
        Me.reqFieldCustomer3.Enabled = blnCustomer
        Me.reqFieldCustomer4.Enabled = blnCustomer
        Me.reqFieldCustomer5.Enabled = blnCustomer
        Me.reqFieldCustomer6.Enabled = blnCustomer
        Me.updtPan_CustomerEdit.Update()

    End Sub

    Private Sub grdViewCustomerList_SelectedIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles grdViewCustomerList.SelectedIndexChanging

        Dim slctdRow As GridViewRow = Me.grdViewCustomerList.Rows(e.NewSelectedIndex)
        'RetrieveCustomerInfo(Me.grdViewCustomerList.DataKeys(slctdRow.RowIndex).Value, Session("ses_Comp_ID"), _
        '                        Me.txt_CustomerFirstName, Me.txt_CustomerLastName, _
        '                        Me.txt_CustomerAdd1, Me.txt_CustomerAdd2, Me.txt_CustomerCity, _
        '                        Me.txt_CustomerState, Me.txt_CustomerZip, Me.txt_CustomerCountry, _
        '                        Me.txt_CustomerPhone, Me.lbl_CustomerNotes, Me.lbl_AddressNotes, Me.lbl_ErrMsgCustomer.Text)
        RetrieveCustomerInfo(Me.grdViewCustomerList.DataKeys(slctdRow.RowIndex).Value, Session("ses_Comp_ID"), _
                               Me.txt_CustomerFirstName, Me.txt_CustomerLastName, _
                               Me.txt_CustomerAdd1, Me.txt_CustomerAdd2, Me.txt_CustomerCity, _
                               Me.txt_CustomerState, Me.txt_CustomerZip, Me.txt_CustomerCountry, _
                               Me.txt_CustomerPhone, Me.txt_CustomerNewNotes, Me.txt_AddressNotes, Me.lbl_ErrMsgCustomer.Text)

        Me.hdn_CustomerEditID.Value = Me.grdViewCustomerList.DataKeys(slctdRow.RowIndex).Value
        Me.lbl_CustomerAddUpdateHeader.Text = "Update Customer"
        Me.lbl_ConfirmMessageOKCustomer.Text = Nothing
        Me.lbl_ErrMsgCustomer.Text = Nothing
        Me.pan_CustomerAddUpdate.Visible = True
        Me.btn_AddUpdateCustomer.Text = "Update"
        Me.btn_DeleteCustomer.Visible = True
        'Me.txt_CustomerNewNotes.Text = Nothing
        'Me.txt_AddressNotes.Text = Nothing

        Me.btn_PrintViewCustomer.Visible = True

        Me.updtPan_CustomerEdit.Update()
        EnableDisableREQFields(False, True)
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PopupCustomerEdit", "popup('divPopupUpdateAddCustomer','','100','blanket','700');", True)

    End Sub

    Private Sub GetRecipientList(str_SenderID As String)

        Me.SqlDS_Recipient.SelectParameters.Clear()
        Me.SqlDS_Recipient.SelectParameters.Add("Company_ID", Session("ses_Comp_ID"))
        Me.SqlDS_Recipient.SelectParameters.Add("Sender_ID", str_SenderID)
        Me.SqlDS_Recipient.DataBind()
        Me.grdViewRecipientList.DataBind()

    End Sub

    Private Sub grdViewRecipientList_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles grdViewRecipientList.RowCommand

        Try
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim row As GridViewRow = Me.grdViewRecipientList.Rows(index)

            If e.CommandName = "AddressHistory" Then
                Me.SqlDS_RecipientAddHistory.SelectParameters.Clear()
                Me.SqlDS_RecipientAddHistory.SelectParameters.Add("Recipient_ID", grdViewRecipientList.DataKeys(row.RowIndex).Value)
                Me.SqlDS_RecipientAddHistory.DataBind()
                Me.grdViewRecipientAddressHistory.DataBind()
                Me.pan_RecipientHistoryAddress.Visible = True
                Me.pan_AddUpdateRecipient.Visible = False
                Me.pan_CustomerRecipientInfoList.Visible = False

                btn_CloseRecipientAddressHistory.Visible = True

                lbl_RecipientNameAddHistory.Text = row.Cells(1).Text & " " & row.Cells(2).Text
                updtPan_CustomerRecipientEdit.Update()

            End If
            If e.CommandName = "NewCargo" Then
                Session("CargoSenderID") = Me.hdn_SenderID.Value
                Session("CargoSenderName") = Me.lbl_CustomerName.Text
                Session("CargoRecipientID") = grdViewRecipientList.DataKeys(row.RowIndex).Value
                Response.Redirect("./Cargo.aspx?a=nc")
            End If
        Catch ex As Exception
            Err.Clear()
        End Try

    End Sub


    Private Sub grdViewRecipientList_SelectedIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles grdViewRecipientList.SelectedIndexChanging


        Dim slctdRow As GridViewRow = Me.grdViewRecipientList.Rows(e.NewSelectedIndex)

        Me.hdn_RecipientID.Value = Me.grdViewRecipientList.DataKeys(slctdRow.RowIndex).Value
        RetrieveCustomerRecipientInfo(Me.grdViewRecipientList.DataKeys(slctdRow.RowIndex).Value, Session("ses_Comp_ID"), _
                                      Me.txt_RecipientFirst, Me.txt_RecipientLast, Me.txt_RecipientAddress1, _
                                      Me.txt_RecipientAddress2, Me.txt_RecipientCity, Me.txt_RecipientStateProvince, _
                                      Me.txt_RecipientZip, Me.txt_Recipientphone, Me.txt_Recipientphone, Me.txt_NewNotesRecipient, Me.lbl_MsgErrRecipient.Text)

        'Me.btn_DeleteRecipient.Visible = True
        Me.btn_AddUpdateRecipient.Text = "Update"
        Me.pan_CustomerRecipientInfoList.Visible = False
        Me.pan_AddUpdateRecipient.Visible = True
        'Me.txt_NewNotesRecipient.Text = Nothing
        Me.lbl_ConfirmMessageOKRecipient.Text = Nothing
        Me.lbl_MsgErrRecipient.Text = Nothing
        Me.lbl_RecipientAddUpdateHeader.Text = "Update Recipient"

        Me.btn_DeleteRecipient.Visible = True

        Me.updtPan_CustomerRecipientEdit.Update()
        EnableDisableREQFields(True, False)

    End Sub

    Private Sub btn_CancelEditRecipient_Click(sender As Object, e As System.EventArgs) Handles btn_CancelEditRecipient.Click

        Me.pan_CustomerRecipientInfoList.Visible = True
        Me.pan_AddUpdateRecipient.Visible = False

    End Sub

    Private Sub btn_AddUpdateRecipient_Click(sender As Object, e As System.EventArgs) Handles btn_AddUpdateRecipient.Click

        If Page.IsValid Then
            Dim strNotes As String = Me.txt_NewNotesRecipient.Text '& "|" & Session("ses_User_ID") & " " & Now() '& "<" '& "<br/><br/>" & lbl_NotesRecipient.Text

            If Me.hdn_RecipientID.Value <> Nothing Then 'do update
                AddUpdateRecipient(Me.hdn_SenderID.Value, Me.hdn_RecipientID.Value, Session("ses_Comp_ID"), _
                                   Me.txt_RecipientFirst.Text, Me.txt_RecipientLast.Text, _
                                   Me.txt_RecipientAddress1.Text, Me.txt_RecipientAddress2.Text, _
                                   Me.txt_RecipientCity.Text, Me.txt_RecipientStateProvince.Text, _
                                   Me.txt_RecipientZip.Text, Me.txt_RecipientCountry.Text, _
                                   Me.txt_Recipientphone.Text, strNotes, "U", Session("ses_User_ID"), Me.lbl_ConfirmMessageOKRecipient.Text)

            Else
                AddUpdateRecipient(Me.hdn_SenderID.Value, CreateID(), Session("ses_Comp_ID"), _
                                 Me.txt_RecipientFirst.Text, Me.txt_RecipientLast.Text, _
                                 Me.txt_RecipientAddress1.Text, Me.txt_RecipientAddress2.Text, _
                                 Me.txt_RecipientCity.Text, Me.txt_RecipientStateProvince.Text, _
                                 Me.txt_RecipientZip.Text, Me.txt_RecipientCountry.Text, _
                                 Me.txt_Recipientphone.Text, strNotes, "I", Session("ses_User_ID"), Me.lbl_ConfirmMessageOKRecipient.Text)
            End If

            Me.btn_DeleteRecipientNo.Visible = False
            Me.btn_DeleteRecipientYes.Visible = False
            Me.btn_ConfirmOKRecipient.Visible = True

            Me.updtPan_CustomerRecipientEdit.Update()
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ConfirmMessageShow", "ConfirmMessageShow();", True)
        End If

    End Sub

    Private Sub btn_ConfirmOKRecipient_Click(sender As Object, e As System.EventArgs) Handles btn_ConfirmOKRecipient.Click

        GetRecipientList(Me.hdn_SenderID.Value)
        Me.pan_CustomerRecipientInfoList.Visible = True
        Me.pan_AddUpdateRecipient.Visible = False
        Me.updtPan_CustomerRecipientEdit.Update()
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ConfirmOKRecipient", "ConfirmOKRecipient()", True)

    End Sub

    Private Sub btn_CloseRecipientAddressHistory_Click(sender As Object, e As System.EventArgs) Handles btn_CloseRecipientAddressHistory.Click

        Me.pan_RecipientHistoryAddress.Visible = False
        Me.pan_CustomerRecipientInfoList.Visible = True
        Me.updtPan_CustomerList.Update()

    End Sub

    Private Sub btn_AddUpdateCustomer_Click(sender As Object, e As System.EventArgs) Handles btn_AddUpdateCustomer.Click


        If Page.IsValid Then
            Dim strNotes As String = Me.txt_CustomerNewNotes.Text '& "<br/><br/>>" & Session("ses_User_ID") & " " & Now() '& "<" & "<br/><br/>" & lbl_CustomerNotes.Text
            Dim strNotesAddress As String = Me.txt_AddressNotes.Text '& "<br/><br/>>" & Session("ses_User_ID") & " " & Now() & "<" & "<br/><br/>" & lbl_AddressNotes.Text

            Me.btn_ConfirmOKCustomer.Visible = True
            Me.btn_DeleteCustomerNo.Visible = False
            Me.btn_DeleteCustomerYes.Visible = False

            If Me.hdn_CustomerEditID.Value <> Nothing Then 'do update

                Me.lbl_CustomerAddUpdateHeader.Text = "Add Update Customer"
                AddUpdateCustomer(Me.hdn_CustomerEditID.Value, Session("ses_Comp_ID"), _
                                   Me.txt_CustomerFirstName.Text, Me.txt_CustomerLastName.Text, _
                                   Me.txt_CustomerAdd1.Text, Me.txt_CustomerAdd2.Text, _
                                   Me.txt_CustomerCity.Text, Me.txt_CustomerState.Text, _
                                   Me.txt_CustomerZip.Text, Me.txt_CustomerCountry.Text, _
                                   Me.txt_CustomerPhone.Text, Me.txt_CustomerAltPhone.Text, Me.txt_CustomerID1.Text, _
                                   Me.txt_CustomerID2.Text, Session("ses_User_ID"), strNotes, strNotesAddress, "U", Me.lbl_ConfirmMessageOKCustomer.Text)
            Else
                Me.lbl_CustomerAddUpdateHeader.Text = "Add Customer"
                AddUpdateCustomer(CreateID(), Session("ses_Comp_ID"), _
                                   Me.txt_CustomerFirstName.Text, Me.txt_CustomerLastName.Text, _
                                   Me.txt_CustomerAdd1.Text, Me.txt_CustomerAdd2.Text, _
                                   Me.txt_CustomerCity.Text, Me.txt_CustomerState.Text, _
                                   Me.txt_CustomerZip.Text, Me.txt_CustomerCountry.Text, _
                                   Me.txt_CustomerPhone.Text, Me.txt_CustomerAltPhone.Text, Me.txt_CustomerID1.Text, _
                                   Me.txt_CustomerID2.Text, Session("ses_User_ID"), strNotes, strNotesAddress, "I", Me.lbl_ConfirmMessageOKCustomer.Text)
            End If

            Me.updtPan_CustomerEdit.Update()
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ConfirmMessageShowCustomer", "ConfirmMessageShowCustomer();", True)
        End If

    End Sub

    Private Sub btn_ConfirmOKCustomer_Click(sender As Object, e As System.EventArgs) Handles btn_ConfirmOKCustomer.Click

        GetCustomerList(Nothing, Nothing, Nothing, "D") 'D = sort by date descending to display the item that was just updated
        Me.updtPan_CustomerList.Update()
        Me.updtPan_CustomerEdit.Update()
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PopupCustomerEdit", "popup('divPopupUpdateAddCustomer','','100','blanket','700');", True)

    End Sub


    'Private Sub imgBtnAddNewCustomer_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imgBtnAddNewCustomer.Click

    '    ResetTextBoxes(Me.pan_CustomerAddUpdate)
    '    Me.lbl_CustomerNotes.Text = Nothing
    '    Me.hdn_SenderID.Value = Nothing
    '    Me.hdn_RecipientID.Value = Nothing
    '    Me.hdn_CustomerEditID.Value = Nothing
    '    pan_CustomerAddUpdate.Visible = True
    '    Me.btn_AddUpdateCustomer.Text = "Add"
    '    Me.lbl_ErrMsgCustomer.Text = Nothing
    '    Me.lbl_CustomerAddUpdateHeader.Text = "Add New Customer"
    '    Me.updtPan_CustomerEdit.Update()
    '    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PopupCustomerEdit", "popup('divPopupUpdateAddCustomer','','100','blanket','700');", True)


    'End Sub

    Private Sub SqlDS_Recipient_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDS_Recipient.Selected

        If e.AffectedRows > 0 Then
            lbl_TotalRecipient.Text = e.AffectedRows
        Else
            lbl_TotalRecipient.Text = 0
        End If


    End Sub

    Private Sub btn_SearchCustomer_Click(sender As Object, e As System.EventArgs) Handles btn_SearchCustomer.Click

        Session("ses_SearchCustomer") = Me.txt_SearchCustomer.Text
        Session("ses_SearchCategory") = Me.drp_SearchCategory.SelectedValue

        If drp_SearchCategory.SelectedValue = "C" Then

            GetCustomerList(Me.txt_SearchCustomer.Text, Nothing, Nothing)
        Else
           
            GetSearchRecipientList(Me.txt_SearchCustomer.Text)
        End If

    End Sub


#Region "Cargo List"

    Private Sub GetCargoListSchedule(ByVal strSenderID As String)

        Me.SQLDS_PickUpCargo.SelectParameters.Clear()
        Me.SQLDS_PickUpCargo.SelectParameters.Add("Sender_ID", strSenderID)
        Me.SQLDS_PickUpCargo.DataBind()
        Me.grdViewCargoPickUpDate.DataBind()
        Me.updtPan_PickupCargo.Update()

    End Sub

    Private Sub btn_AddPickupCargo_Click(sender As Object, e As System.EventArgs) Handles btn_AddPickupCargo.Click

        Try
            If Me.btn_AddPickupCargo.Text = "Add" Then
                If Me.drp_CargoPickupStatus.SelectedValue = "NPC" Then
                    InsertUpdatePickupCagoSchedule("Add", Nothing, Me.hdn_SenderIDCargo.Value, Me.drp_TripNumber.SelectedValue, _
                                                       Me.drp_CargoPickupStatus.SelectedValue, Me.ucPickUpDate.CalValue, _
                                                        Me.txt_PickupCargoNotes.Text & Chr(13), Session("ses_User_ID"), Session("ses_Comp_ID"), Me.lbl_MsgAddUpdateCargo.Text)
                Else
                    lbl_MsgAddUpdateCargo.Text = "Invalid Status Selected!"
                End If

            Else 'update
                Dim intTripNumber As Integer = 0
                If Me.drp_CargoPickupStatus.SelectedValue <> "CAN" Then
                    intTripNumber = Me.drp_TripNumber.SelectedValue
                End If
                InsertUpdatePickupCagoSchedule("Update", Me.hdn_CargoPickupID.Value, Nothing, intTripNumber, _
                                    Me.drp_CargoPickupStatus.SelectedValue, Me.ucPickUpDate.CalValue, _
                                    Me.txt_PickupCargoNotes.Text, Session("ses_User_ID"), Session("ses_Comp_ID"), Me.lbl_MsgAddUpdateCargo.Text)

            End If

            Me.pan_PickupCargoAdd.Visible = False
            Me.pan_PickupCargoUpdateMsg.Visible = True
            GetCargoListSchedule(Me.hdn_SenderIDCargo.Value)

        Catch ex As Exception
            lbl_MsgAddUpdateCargo.Text = "Invalid Trip Number!"
            Err.Clear()
        End Try

    End Sub

    Private Sub GetSetTripNumber(slctdTripNumber As Integer, ByVal dtPickupDate As Date)

        Dim strArryTripNumber As String = Nothing

        Try
            If dtPickupDate <> Nothing Then
                GetTripNumber(strArryTripNumber, dtPickupDate, Session("ses_Comp_ID"))
            End If

            Me.drp_TripNumber.Items.Clear()

            For i = 0 To 19
                If InStr(strArryTripNumber, i + 1) > 0 Then
                    If slctdTripNumber = i + 1 Then
                        Me.drp_TripNumber.Items.Add(i)
                        Me.drp_TripNumber.Items(i).Value = i + 1
                        Me.drp_TripNumber.Items(i).Text = i + 1
                        Me.drp_TripNumber.SelectedIndex = i
                    Else
                        Me.drp_TripNumber.Items.Add(i)
                        Me.drp_TripNumber.Items(i).Value = ""
                        Me.drp_TripNumber.Items(i).Text = "-"
                    End If
                Else
                    Me.drp_TripNumber.Items.Add(i)
                    Me.drp_TripNumber.Items(i).Value = i + 1
                    Me.drp_TripNumber.Items(i).Text = i + 1
                End If
            Next

            For i = 0 To 19
                If Me.drp_TripNumber.Items(i).Text <> "-" Then
                    Me.drp_TripNumber.SelectedIndex = i
                    Exit For
                End If
            Next

            Me.updtPan_PickupCargo.Update()

        Catch ex As Exception
            Me.lbl_MsgCargo.Text = Err.Description
            Err.Clear()
        End Try
    End Sub

    Private Sub GetSetCargoStatus(slctdSatus As String)

        Dim strStatus As String = "NPC,RSC,CMP,CAN"
        Dim strArryStatus() As String = Split(strStatus, ",")

        For i = 0 To UBound(strArryStatus)
            If strArryStatus(i) = slctdSatus Then
                Me.drp_CargoPickupStatus.SelectedIndex = i
                Exit For
            End If
        Next

    End Sub

    Private Sub grdViewCargoPickUpDate_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles grdViewCargoPickUpDate.RowCommand

        Try
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim row As GridViewRow = Me.grdViewCargoPickUpDate.Rows(index)

            Me.lbl_MsgCargo.Text = Nothing
            Me.lbl_MsgCargo2.Text = Nothing
            Me.lbl_MsgAddUpdateCargo.Text = Nothing
            Me.txt_PickupCargoNotes.Text = Nothing

            Dim txtCargoNotes As TextBox = TryCast(row.Cells(2).FindControl("txt_CargoNotes"), TextBox)

            If e.CommandName = "UpdateCargoSched" Then
                Me.pan_PickupCargoAdd.Visible = True
                Me.pan_PickupCargoList.Visible = False

                Me.ucPickUpDate.CalValue = row.Cells(0).Text
                Me.hdn_CargoPickupID.Value = grdViewCargoPickUpDate.DataKeys(row.RowIndex).Value()

                'Me.txt_PickupCargoCurrentNotes.Text = txtCargoNotes.Text
                Me.txt_PickupCargoNotes.Text = txtCargoNotes.Text

                GetSetTripNumber(row.Cells(1).Text, Me.ucPickUpDate.CalValue)
                GetSetCargoStatus(row.Cells(3).Text)

                Me.btn_AddPickupCargo.Text = "Update"
                Me.updtPan_PickupCargo.Update()

            ElseIf e.CommandName = "CancelCargoSched" Then
                'Me.pan_PickupCargoAdd.Visible = True
                'Me.pan_PickupCargoList.Visible = False
                'Me.updtPan_PickupCargo.Update()
                InsertUpdatePickupCagoSchedule("Update", grdViewCargoPickUpDate.DataKeys(row.RowIndex).Value(), Me.hdn_SenderID.Value, 0, _
                                         "CAN", row.Cells(0).Text, _
                                          " Canceled " & Chr(13) & Now() & Chr(13) & "|" & Chr(13) & txtCargoNotes.Text, Session("ses_User_ID"), Session("ses_Comp_ID"), lbl_MsgCargo2.Text)

                Me.lbl_MsgAddUpdateCargo.Text = "Trip Canceled Successfully!"
                lbl_MsgCargo2.Text = Nothing
                Me.pan_PickupCargoUpdateMsg.Visible = True
                Me.pan_PickupCargoList.Visible = False

            End If
        Catch ex As Exception
            Err.Clear()
        End Try

    End Sub

    Private Sub imgButtonAddNewCargo_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles imgButtonAddNewCargo.Click


        Me.lbl_MsgAddUpdateCargo.Text = Nothing
        Me.lbl_MsgCargo.Text = Nothing

        Me.btn_AddPickupCargo.Text = "Add"
        Me.txt_PickupCargoNotes.Text = Nothing
        'Me.txt_PickupCargoCurrentNotes.Text = Nothing

        GetSetCargoStatus(Nothing)


        If Me.ucPickUpDate.CalValue = Nothing Then
            If Session("CargoPickupDate") <> Nothing Then
                Me.ucPickUpDate.CalValue = Session("CargoPickupDate")
            Else
                Me.ucPickUpDate.CalValue = Today
            End If

        End If

        GetSetTripNumber(0, Today)

        Me.drp_CargoPickupStatus.SelectedIndex = 0

        Me.pan_PickupCargoAdd.Visible = True
        Me.pan_PickupCargoList.Visible = False
        Me.updtPan_PickupCargo.Update()

    End Sub

    Private Sub btn_AddPickupCancel_Click(sender As Object, e As System.EventArgs) Handles btn_AddPickupCancel.Click

        Me.pan_PickupCargoAdd.Visible = False
        Me.pan_PickupCargoList.Visible = True
        Me.updtPan_PickupCargo.Update()

    End Sub

    Private Sub ucPickUpDate_TextOnChanged(sender As Object, e As System.EventArgs) Handles ucPickUpDate.TextOnChanged

        GetSetTripNumber(0, Me.ucPickUpDate.CalValue)

        Session("CargoPickupDate") = Me.ucPickUpDate.CalValue

        updtPan_PickupCargo.Update()

    End Sub

    Private Sub btn_CargoAddUpdateOK_Click(sender As Object, e As System.EventArgs) Handles btn_CargoAddUpdateOK.Click

        Me.pan_PickupCargoUpdateMsg.Visible = False
        Me.pan_PickupCargoList.Visible = True
        GetCargoListSchedule(Me.hdn_SenderIDCargo.Value)

    End Sub

    Private Sub btn_PrintCargoHistory_Click(sender As Object, e As System.EventArgs) Handles btn_PrintCargoHistory.Click

        Try
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PrintDiv", "PrintDiv('popupDivCargoHistory')", True)
        Catch ex As Exception
            Err.Clear()
        End Try
       
    End Sub

#End Region


    Private Sub SQLDS_HistoryCargo_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SQLDS_HistoryCargo.Selected

        If e.AffectedRows > 0 Then
            Me.lbl_CargoHistoryTotal.Text = e.AffectedRows
        Else
            Me.lbl_CargoHistoryTotal.Text = 0
        End If


        If Int(Me.lbl_CargoHistoryTotal.Text) > 10 Then
            Me.pan_CargoHistory.Height = "320"
        Else
            Me.pan_CargoHistory.Height = "200"
        End If

    End Sub

    Private Sub btn_AddNewRecipient_Click(sender As Object, e As System.EventArgs) Handles btn_AddNewRecipient.Click


        Me.pan_CustomerRecipientInfoList.Visible = False
        Me.pan_AddUpdateRecipient.Visible = True

        Me.hdn_RecipientID.Value = Nothing
        ResetTextBoxes(Me.pan_AddUpdateRecipient)

        Me.txt_RecipientCountry.Text = "PHILIPPINES"

        Me.lbl_MsgErrRecipient.Text = Nothing
        'Me.lbl_NotesRecipient.Text = Nothing
        Me.btn_AddUpdateRecipient.Text = "Add"
        'Me.btn_DeleteRecipient.Visible = False
        Me.lbl_RecipientAddUpdateHeader.Text = "Add New Recipient"

        Me.txt_RecipientCountry.Text = "PHILIPPINES"

        Me.btn_DeleteRecipient.Visible = False

        Me.updtPan_CustomerRecipientEdit.Update()

    End Sub

    Private Sub btn_AddNewCustomer_Click(sender As Object, e As System.EventArgs) Handles btn_AddNewCustomer.Click

        ResetTextBoxes(Me.pan_CustomerAddUpdate)
        'Me.lbl_CustomerNotes.Text = Nothing
        Me.hdn_SenderID.Value = Nothing
        Me.hdn_RecipientID.Value = Nothing
        Me.hdn_CustomerEditID.Value = Nothing
        Me.pan_CustomerAddUpdate.Visible = True
        Me.btn_AddUpdateCustomer.Text = "Add"
        Me.lbl_ErrMsgCustomer.Text = Nothing
        Me.lbl_CustomerAddUpdateHeader.Text = "Add New Customer"
        Me.btn_PrintViewCustomer.Visible = False
        Me.btn_DeleteCustomer.Visible = False
        Me.btn_ConfirmOKCustomer.Visible = True
        Me.btn_DeleteCustomerNo.Visible = False
        Me.btn_DeleteCustomerYes.Visible = False

        Me.txt_CustomerCountry.Text = "USA"

        Me.updtPan_CustomerEdit.Update()
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PopupCustomerEdit", "popup('divPopupUpdateAddCustomer','','100','blanket','700');", True)


    End Sub

   
    Private Sub grdViewSearchRecipientList_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles grdViewSearchRecipientList.RowCommand

        Try
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim row As GridViewRow = Me.grdViewSearchRecipientList.Rows(index)

            Dim lblSenderID As Label = TryCast(row.FindControl("lbl_SenderID"), Label)
            Dim lblCustomerName As Label = TryCast(row.FindControl("lbl_CustomerName"), Label)

            If e.CommandName = "NewCargo" Then
                Session("CargoSenderID") = lblSenderID.Text    'Me.hdn_SenderID.Value
                Session("CargoSenderName") = lblCustomerName.Text 'Me.lbl_CustomerName.Text
                Session("CargoRecipientID") = Me.grdViewSearchRecipientList.DataKeys(row.RowIndex).Value
                Response.Redirect("./Cargo.aspx?a=nc")
            End If


            If e.CommandName = "AddressHistory" Then

                Me.hdn_SenderID.Value = lblSenderID.Text
                Me.lbl_CustomerName.Text = lblCustomerName.Text
                btn_CloseRecipientAddressHistory.Visible = False

                Me.SqlDS_RecipientAddHistory.SelectParameters.Clear()
                Me.SqlDS_RecipientAddHistory.SelectParameters.Add("Recipient_ID", grdViewSearchRecipientList.DataKeys(row.RowIndex).Value)
                Me.SqlDS_RecipientAddHistory.DataBind()
                Me.grdViewRecipientAddressHistory.DataBind()
                Me.pan_RecipientHistoryAddress.Visible = True
                Me.pan_AddUpdateRecipient.Visible = False
                Me.pan_CustomerRecipientInfoList.Visible = False

                lbl_RecipientNameAddHistory.Text = row.Cells(1).Text & " " & row.Cells(2).Text
                updtPan_CustomerRecipientEdit.Update()

                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PopupCustomerRecipientEdit", "popup('popUpDivCustomerRecipientEdit','','100','blanket','700');", True)
            End If

            If e.CommandName = "CargoHistory" Then 'Cargo Recipient history

                'Me.hdn_SenderID.Value = lblSenderID.Text
                'Me.lbl_CustomerName.Text = lblCustomerName.Text
                'btn_CloseRecipientAddressHistory.Visible = False
                lbl_RecipientNameCargoHistory.Text = row.Cells(1).Text & " " & row.Cells(2).Text

                Me.SqlDS_RecipientCargoHistory.SelectParameters.Clear()
                Me.SqlDS_RecipientCargoHistory.SelectParameters.Add("Recipient_ID", grdViewSearchRecipientList.DataKeys(row.RowIndex).Value)
                Me.SqlDS_RecipientCargoHistory.SelectParameters.Add("ForHistory", "R")
                Me.SqlDS_RecipientCargoHistory.DataBind()
                Me.grdview_RecipientCargoHistory.DataBind()

                'Me.pan_RecipientHistoryAddress.Visible = False
                'Me.pan_RecipientHistoryAddress.Visible = False
                'Me.pan_AddUpdateRecipient.Visible = False
                'Me.pan_CustomerRecipientInfoList.Visible = False

                'lbl_RecipientNameAddHistory.Text = row.Cells(1).Text & " " & row.Cells(2).Text
                updtPan_RecipientCargoHistory.Update()

                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PopupCustomerRecipientCargoHistory", "popup('popupDivRecipientCargoHistory','','100','blanket','700');", True)
            End If

        Catch ex As Exception
            Err.Clear()
        End Try

    End Sub

    Private Sub grdViewSearchRecipientList_SelectedIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles grdViewSearchRecipientList.SelectedIndexChanging

        Dim slctdRow As GridViewRow = Me.grdViewSearchRecipientList.Rows(e.NewSelectedIndex)

        Me.hdn_RecipientID.Value = Me.grdViewSearchRecipientList.DataKeys(slctdRow.RowIndex).Value
        RetrieveCustomerRecipientInfo(Me.grdViewSearchRecipientList.DataKeys(slctdRow.RowIndex).Value, Session("ses_Comp_ID"), _
                                      Me.txt_RecipientFirst, Me.txt_RecipientLast, Me.txt_RecipientAddress1, _
                                      Me.txt_RecipientAddress2, Me.txt_RecipientCity, Me.txt_RecipientStateProvince, _
                                      Me.txt_RecipientZip, Me.txt_Recipientphone, Me.txt_Recipientphone, Me.txt_NewNotesRecipient, Me.lbl_MsgErrRecipient.Text)

        'Me.btn_DeleteRecipient.Visible = True
        Dim lblSenderID As Label = TryCast(slctdRow.FindControl("lbl_SenderID"), Label)
        Me.hdn_SenderID.Value = lblSenderID.Text
        Dim lblCustomerName As Label = TryCast(slctdRow.FindControl("lbl_CustomerName"), Label)
        Me.lbl_CustomerName.Text = lblCustomerName.Text

        Me.btn_CancelEditRecipient.Visible = False

        Me.btn_AddUpdateRecipient.Text = "Update"
        Me.pan_CustomerRecipientInfoList.Visible = False
        Me.pan_AddUpdateRecipient.Visible = True
        'Me.txt_NewNotesRecipient.Text = Nothing
        Me.lbl_ConfirmMessageOKRecipient.Text = Nothing
        Me.lbl_MsgErrRecipient.Text = Nothing
        Me.lbl_RecipientAddUpdateHeader.Text = "Update Recipient"
        Me.updtPan_CustomerRecipientEdit.Update()
        EnableDisableREQFields(True, False)

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PopupCustomerRecipientEdit", "popup('popUpDivCustomerRecipientEdit','','100','blanket','700');", True)

    End Sub

    Private Sub btn_PrintViewCustomer_Click(sender As Object, e As System.EventArgs) Handles btn_PrintViewCustomer.Click

        'Me.pan_CustomerEdit.Visible = False
        'Me.pan_CustomerPrintView.Visible = True
        Me.lbl_Address1.Text = Me.txt_CustomerAdd1.Text
        Me.lbl_Address2.Text = Me.txt_CustomerAdd2.Text
        Me.lbl_City.Text = Me.txt_CustomerCity.Text
        Me.lbl_Zip.Text = Me.txt_CustomerZip.Text
        Me.lbl_State.Text = Me.txt_CustomerState.Text
        Me.lbl_Country.Text = Me.txt_CustomerCountry.Text
        Me.lbl_AltPhone.Text = Me.txt_CustomerAltPhone.Text
        Me.lbl_Phone.Text = Me.txt_CustomerPhone.Text
        'Me.lbl_CustomerName.Text = Me.txt_CustomerFirstName.Text
        Me.lbl_FirstName.Text = Me.txt_CustomerFirstName.Text
        Me.lbl_LastName.Text = Me.txt_CustomerLastName.Text
        Me.lbl_ID1.Text = Me.txt_CustomerID1.Text
        Me.lbl_ID2.Text = Me.txt_CustomerID2.Text


        'Dim strNotes As String = Replace(Me.txt_CustomerNewNotes.Text, "</br>", "")
        'Me.lbl_Notes.Text = Replace(strNotes, "<br/>", "") '& lbl_CustomerNotes.Text
        'Me.lbl_CustomerNotes.Text = Me.txt_CustomerNewNotes.Text

        Me.lbl_AddressNotesP.Text = Me.txt_AddressNotes.Text '& lbl_AddressNotes.Text

        Me.pan_CustomerPrintView.Visible = True
        'Me.pan_CustomerList.Visible = False
        Me.updtPan_CustomerList.Update()

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PrintViewCustomer", "PrintViewCustomer();", True)
        'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PrintDiv", "PrintDiv('div_PrintCustomer')", True)

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "PopupCustomerUpdate", "popup('divPopupUpdateAddCustomer','','100','blanket','700');", True)
        'Me.updtPan_CustomerEdit.Update()

    End Sub


    Private Sub SqlDS_RecipientCargoHistory_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDS_RecipientCargoHistory.Selected

        If e.AffectedRows > 0 Then
            Me.lbl_TotalRecipientCargorHistory.Text = "Total: " & e.AffectedRows
        Else
            Me.lbl_TotalRecipientCargorHistory.Text = 0
        End If

    End Sub

    Private Sub grdViewCustomerList_Sorting(sender As Object, e As System.Web.UI.WebControls.GridViewSortEventArgs) Handles grdViewCustomerList.Sorting

        Session("ses_SearchCustomer") = Me.txt_SearchCustomer.Text
        Session("ses_SearchCategory") = Me.drp_SearchCategory.SelectedValue


    End Sub

    'Private Function lbl_NotesRecipient() As Object
    '    Throw New NotImplementedException
    'End Function

    Private Sub btn_DeleteCustomer_Click(sender As Object, e As System.EventArgs) Handles btn_DeleteCustomer.Click

        Me.lbl_CustomerAddUpdateHeader.Text = "Delete Customer?"
        Me.btn_ConfirmOKCustomer.Visible = False
        Me.btn_DeleteCustomerNo.Visible = True
        Me.btn_DeleteCustomerYes.Visible = True

        Me.lbl_ConfirmMessageOKCustomer.Text = "Are you sure you want to delete " & Me.txt_CustomerFirstName.Text & " " & Me.txt_CustomerLastName.Text & "?"
        Me.updtPan_CustomerEdit.Update()
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ConfirmMessageShowCustomer", "ConfirmMessageShowCustomer();", True)

    End Sub

    Private Sub btn_DeleteCustomerYes_Click(sender As Object, e As System.EventArgs) Handles btn_DeleteCustomerYes.Click

        Dim strNotes As String = Me.txt_CustomerNewNotes.Text '& "<br/><br/>>" & Session("ses_User_ID") & " " & Now() '& "<" & "<br/><br/>" & lbl_CustomerNotes.Text
        Dim strNotesAddress As String = Me.txt_AddressNotes.Text '& "<br/><br/>>" & Session("ses_User_ID") & " " & Now() & "<" & "<br/><br/>" & lbl_AddressNotes.Text

        Me.btn_ConfirmOKCustomer.Visible = True
        Me.btn_DeleteCustomerNo.Visible = False
        Me.btn_DeleteCustomerYes.Visible = False

        If Me.hdn_CustomerEditID.Value <> Nothing Then 'do update

            Me.lbl_CustomerAddUpdateHeader.Text = "Delete Customer"
            AddUpdateCustomer(Me.hdn_CustomerEditID.Value, Session("ses_Comp_ID"), _
                               Me.txt_CustomerFirstName.Text, Me.txt_CustomerLastName.Text, _
                               Me.txt_CustomerAdd1.Text, Me.txt_CustomerAdd2.Text, _
                               Me.txt_CustomerCity.Text, Me.txt_CustomerState.Text, _
                               Me.txt_CustomerZip.Text, Me.txt_CustomerCountry.Text, _
                               Me.txt_CustomerPhone.Text, Me.txt_CustomerAltPhone.Text, Me.txt_CustomerID1.Text, _
                               Me.txt_CustomerID2.Text, Session("ses_User_ID"), strNotes, strNotesAddress, "D", Me.lbl_ConfirmMessageOKCustomer.Text)

        End If

        Me.updtPan_CustomerEdit.Update()
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ConfirmMessageShowCustomer", "ConfirmMessageShowCustomer();", True)


    End Sub

    Private Sub SqlDS_CustomerList_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles SqlDS_CustomerList.Selecting

        e.Command.CommandTimeout = 600

    End Sub

    Private Sub btn_DeleteRecipient_Click(sender As Object, e As System.EventArgs) Handles btn_DeleteRecipient.Click

        Me.lbl_ConfirmMessageOKRecipient.Text = "Are you sure you want to delete " & Me.txt_RecipientFirst.Text & " " & Me.txt_RecipientLast.Text & "?"
        Me.btn_DeleteRecipientNo.Visible = True
        Me.btn_DeleteRecipientYes.Visible = True
        Me.btn_ConfirmOKRecipient.Visible = False
        Me.updtPan_CustomerRecipientEdit.Update()
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ConfirmMessageShow", "ConfirmMessageShow();", True)

    End Sub

    Private Sub btn_DeleteRecipientYes_Click(sender As Object, e As System.EventArgs) Handles btn_DeleteRecipientYes.Click


        Dim strNotes As String = Me.txt_NewNotesRecipient.Text '& "|" & Session("ses_User_ID") & " " & Now() '& "<" '& "<br/><br/>" & lbl_NotesRecipient.Text

        If Me.hdn_RecipientID.Value <> Nothing Then 'do update
            AddUpdateRecipient(Me.hdn_SenderID.Value, Me.hdn_RecipientID.Value, Session("ses_Comp_ID"), _
                               Me.txt_RecipientFirst.Text, Me.txt_RecipientLast.Text, _
                               Me.txt_RecipientAddress1.Text, Me.txt_RecipientAddress2.Text, _
                               Me.txt_RecipientCity.Text, Me.txt_RecipientStateProvince.Text, _
                               Me.txt_RecipientZip.Text, Me.txt_RecipientCountry.Text, _
                               Me.txt_Recipientphone.Text, strNotes, "D", Session("ses_User_ID"), Me.lbl_ConfirmMessageOKRecipient.Text)

        End If

        Me.btn_DeleteRecipientNo.Visible = False
        Me.btn_DeleteRecipientYes.Visible = False
        Me.btn_ConfirmOKRecipient.Visible = True

        Me.updtPan_CustomerRecipientEdit.Update()
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ConfirmMessageShow", "ConfirmMessageShow();", True)

    End Sub
End Class