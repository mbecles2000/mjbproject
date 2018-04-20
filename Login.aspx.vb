Public Class Login1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Me.lbl_LoginMsg.Text = Nothing

        If Request.QueryString("Logoff") = "Y" Then

            Session.Clear()
            Session.Abandon()
            Response.Redirect("Login.aspx")

        End If

    End Sub


    Private Sub Validate_User()

        Try
            Me.lbl_LoginMsg.Text = Nothing

            Dim isValidUser As Boolean
            Dim str_UserID, str_CompID, str_UserPwd

            str_UserID = Me.txt_UserID.Text
            str_CompID = Me.txt_CompanyID.Text
            str_UserPwd = Me.txt_Password.Text

            Dim HttpUserIpaddress
            HttpUserIpaddress = Request.ServerVariables("REMOTE_ADDR")

            If (str_UserID <> "" And str_CompID <> "" And str_UserPwd <> "") Then

                Dim strError As String = Nothing
                InsertUpdate_DataSystemUserLog(str_UserID, HttpUserIpaddress, str_CompID, strError)
                Response.Write(strError)

                'Dim intLogon_Tries As Integer
                'Retrieve_DataCountUserLog(HttpUserIpaddress, DateAdd("d", -1, Now()), intLogon_Tries)
                'If intLogon_Tries >= 50 Then
                '    Me.lbl_LoginMsg.Text = "Sorry you can't login at this time! If you feel that this is not accurate please contact the system addministrator. Thank you!"
                '    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ResetCursor", "ResetCursor()", True)
                '    Exit Sub
                'End If

                'first retrieve the login count if this is a valid user
                Dim int_LogonCount As Integer = -1
                Retrieve_DataValidateUserLogCount(str_UserID, "", HttpUserIpaddress, Now(), int_LogonCount, "", Me.lbl_LoginMsg.Text)
                'check if the user is valid
                If str_UserID <> "Invalid" Then  'this must be a valid user
                    isValidUser = True
                Else
                    isValidUser = False
                End If

                'Me.lbl_LoginMsg.Text = str_UserID & int_LogonCount

                int_LogonCount -= 1
                'if the login count is greater than or = to zero then this must be a valid user
                If int_LogonCount >= 0 Then
                    'finally validate the user here and update the login count
                    If int_LogonCount = -1 Then int_LogonCount = 0 'this to avoid puting negative number on to logon count

                    'Me.lbl_LoginMsg.Text = str_UserID & str_CompID

                    Retrieve_DataValidateUser(str_UserID, str_CompID, HttpUserIpaddress, Now(), int_LogonCount, str_UserPwd, Me.lbl_LoginMsg.Text)
                    'now check encrypted the password

                    If str_UserID <> "Invalid" Then
                        'decrypt the password here 
                        Call Decrypt_Str(str_UserPwd)
                        If Me.txt_Password.Text <> str_UserPwd Then
                            isValidUser = False 'invalid password
                        Else
                            isValidUser = True   'valid password
                        End If
                    Else
                        isValidUser = False 'invalid user id
                    End If
                End If

                If isValidUser = False Then
                    'invalid user
                    Me.lbl_LoginMsg.Text = "Please enter a Valid User ID, Company ID and Password"
                Else
                    If int_LogonCount > 0 Then
                        'Response.Redirect("Main.aspx")
                        Response.Redirect("Customer.aspx")
                    Else
                        Me.lbl_LoginMsg.Text = "Sorry you can't login at this time! There are too many unsucessfull login attempts!"
                    End If
                End If

            Else
                Me.lbl_LoginMsg.Text = "Please enter a Valid User ID, Company ID and Password"
            End If

            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ResetCursor", "ResetCursor()", True)

        Catch ex As Exception
            Me.lbl_LoginMsg.Text = "Please enter a Valid User ID, Company ID and Password *" 'Err.Description & ex.StackTrace
            Err.Clear()
        End Try
End sub


    Private Sub btn_Login_Click(sender As Object, e As System.EventArgs) Handles btn_Login.Click

        Validate_User()

    End Sub


End Class