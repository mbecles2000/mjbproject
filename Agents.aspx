<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master"
    CodeBehind="Agents.aspx.vb" Inherits="MJBUMAC1.Agents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script language="javascript" type="text/javascript">


        function DeleteAgentConfirm(strUserID) {
            $('#div_MsgConfirmDelete').css('visibility', 'visible');
            $('#<%=pan_AgentView.ClientID%>').css('visibility', 'hidden');
            $('#<%=lbl_MsgAgentConfirm.ClientID%>').text("Are your sure you want to delete this agent  " + strUserID);
        }


        function ConfirmMessageShow() {
            $('#div_MsgConfirmDelete').css('visibility', 'hidden');
            $('#<%=pan_AgentView.ClientID%>').css('visibility', 'hidden');
            $('#div_MsgConfirmOK').css('visibility', 'visible');
        }

        function HideHtmlButton(objBtnID) {
            $(objBtnID).attr('disabled', 'disabled');
            $(objBtnID).hover(function () {
                $(objBtnID).css('background-color', '#ffffff');
            });
        }

        $(document).ready(function () {
            try {
                var prm = Sys.WebForms.PageRequestManager.getInstance();
                prm.add_initializeRequest(InitializeRequest);
                prm.add_endRequest(EndRequest);
            }
            catch (err) {
            }

        });

        function InitializeRequest(sender, args) {
            $("*").css("cursor", "wait");
        }

        function EndRequest(sender, args) {
            $("*").css('cursor', 'auto');
            $('#<%=btn_AddUpdate.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_DeleteCancel.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_DeleteYes.ClientID%>').css('cursor', 'pointer');
            $('#btn_Close').css('cursor', 'pointer');
            $('#btn_Delete').css('cursor', 'pointer');
            $('#<%=btn_ConfirmOK.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_AddNewAgent.ClientID%>').css('cursor', 'pointer');
        }

              
    </script>
    <h2>
        Agents
    </h2>
    <center>
        <asp:SqlDataSource ID="SqlDS_AgentList" runat="server" ConnectionString="<%$ ConnectionStrings:MJBCONN %>"
            SelectCommand="Sp_Retrieve_Agent_List" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

     <%--  <div id="divMenuSelected" style="position:fixed; margin-top:-42px; margin-left:174px;z-index:20000">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/PointerWhite.gif" />
      </div>--%>

        <asp:UpdatePanel ID="updtPan_AgentList" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <table class="tblBorderHeader" width="500px" cellpadding="2" cellspacing="2">
                    <tr>
                        <td valign="middle" align="left" class="FontHeader">
                            Agent List
                        </td>
                        <td valign="middle" align="right">
                            <asp:Button ID="btn_AddNewAgent" runat="server" Text="Add New"
                                CausesValidation="false" CssClass="submitButtonWithImage" style="background-image:url(/Images/Agent.gif)" />
                        </td>
                    </tr>
                </table>
                <asp:GridView ID="grdViewAgentList" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" DataSourceID="SqlDS_AgentList" HeaderStyle-CssClass="gridViewheader"
                    HeaderStyle-HorizontalAlign="Center" PageSize="10" GridLines="Horizontal" RowStyle-HorizontalAlign="Center"
                    Width="500px" PagerStyle-HorizontalAlign="Center" DataKeyNames="ID_Num" PagerStyle-VerticalAlign="Middle"
                    CssClass="gridView">
                    <Columns>
                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/Gear.gif" SelectText=""
                            ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="Edit" ShowSelectButton="True" />
                        <asp:BoundField DataField="User_ID" HeaderText="User ID" SortExpression="User_ID"
                            HeaderStyle-Wrap="false" />
                        <asp:BoundField DataField="Agent_FName" HeaderText="First Name" SortExpression="Agent_FName"
                            HeaderStyle-Wrap="false" />
                        <asp:BoundField DataField="Agent_LName" HeaderText="Last Name" SortExpression="Agent_LName"
                            HeaderStyle-Wrap="false" />
                        <asp:BoundField DataField="Branch_ID" HeaderText="Branch ID" SortExpression="Branch_ID"
                            HeaderStyle-Wrap="false" />
                        <asp:BoundField DataField="Last_Logon_Date" HeaderText="Logon Date" SortExpression="Last_Logon_Date"
                            HeaderStyle-Wrap="false" />
                        <asp:BoundField DataField="Logon_Count" HeaderText="Logon Count" SortExpression="Logon_Count"
                            HeaderStyle-Wrap="false" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HiddenField ID="hdn_UserID" runat="server" Value='<%# Eval("User_ID")%>' />
                                <asp:HiddenField ID="hdn_BranchID" runat="server" Value='<%# Eval("Branch_ID")%>' />
                                <asp:HiddenField ID="hdn_LastLogonDate" runat="server" Value='<%# Eval("Last_Logon_Date")%>' />
                                <asp:HiddenField ID="hdn_LogonCount" runat="server" Value='<%# Eval("Logon_Count")%>' />
                                <asp:HiddenField ID="hdn_BranchAccess" runat="server" Value='<%# Eval("Branch_Access")%>' />
                                <asp:HiddenField ID="hdn_MenuAccess" runat="server" Value='<%# Eval("User_Access")%>' />
                                <asp:HiddenField ID="hdn_IDNum" runat="server" Value='<%# Eval("ID_Num")%>' />
                                <%--<asp:HiddenField ID="hdn_Password" runat="server" Value='<%# Eval("Password")%>' /> hidden fiel is not working with password--%>
                                <asp:Label ID="lbl_Password" runat="server" Text='<%# Eval("Password")%>' Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#f1f1f1" />
                    <PagerStyle BackColor="#f1f1f1" HorizontalAlign="Center" CssClass="pagination" ForeColor="Black" />
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="grdViewAgentList" EventName="Sorting" />
                <asp:AsyncPostBackTrigger ControlID="btn_AddNewAgent" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="grdViewAgentList" EventName="PageIndexChanging" />
            </Triggers>
        </asp:UpdatePanel>
        <div id="blanket" style="display: none">
        </div>
        <div id="popUpDivAgentView" style="display: none; z-index: 9012; position: fixed">
            <asp:Panel ID="pan_AgentViewMain" Width="500px" runat="server" CssClass="FrameBorderGridBG1">
                <asp:UpdatePanel ID="updtPan_AgentView" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div style="z-index: 9013; position: fixed; top: 45px; margin-top: 45px">
                            <asp:Panel ID="pan_HeadTitle" runat="server" Width="500px" Style="position: fixed;
                                background-color: transparent">
                                <table width="520px" style="background-color: Transparent">
                                    <tr>
                                        <td align="left" valign="bottom" style="padding-left: 10px" class="FontHeader">
                                            Agents
                                            <asp:Label ID="lbl_UserID" runat="server" Text="" CssClass="FontBold" Visible="false"></asp:Label>
                                            <asp:HiddenField ID="hdn_IDNum" runat="server" />
                                        </td>
                                        <td align="right" valign="top">
                                            <input id="btn_Close" type="button" style="background-image: url(../Images/Xclose.png);
                                                background-repeat: no-repeat; cursor: pointer; background-color: Transparent;
                                                border: none; width: 32px; height: 32px" onclick="popup('popUpDivAgentView','','200','blanket','500')" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                        <asp:Panel ID="pan_AgentView" Width="480px" runat="server" Style="padding: 30px 10px 10px 10px">
                            <table style="background-color: #ffffff; height: 200px" width="480px">
                                <tr>
                                    <td align="center">
                                        User ID:<br />
                                        <asp:TextBox ID="txt_UserID" runat="server" MaxLength="20" CssClass="textEntryMedium"
                                            Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="ErrMsg"
                                            SetFocusOnError="true" ErrorMessage="*" ToolTip="Required!" ControlToValidate="txt_UserID"
                                            Display="Dynamic"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        Password:<br />
                                        <asp:TextBox ID="txt_Password" runat="server" MaxLength="20" CssClass="textEntryMedium"
                                            TextMode="Password" Text=""></asp:TextBox>
                                        <asp:HiddenField ID="hdnCurrentPassword" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        First Name:<br />
                                        <asp:TextBox ID="txt_FirstName" runat="server" MaxLength="50" CssClass="textEntryMedium"
                                            Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="ErrMsg"
                                            SetFocusOnError="true" ErrorMessage="*" ToolTip="Required!" ControlToValidate="txt_FirstName"
                                            Display="Dynamic"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        Last Name:<br />
                                        <asp:TextBox ID="txt_LastName" runat="server" MaxLength="50" CssClass="textEntryMedium"
                                            Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="ErrMsg"
                                            SetFocusOnError="true" ErrorMessage="*" ToolTip="Required!" ControlToValidate="txt_LastName"
                                            Display="Dynamic"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <h3>
                                            Menu Access:</h3>
                                        <asp:Panel ID="pan_MenuAccess" runat="server" ScrollBars="Auto" Height="200px" CssClass="tblBorderAll">
                                            <table width="400px">
                                                <tr>
                                                    <td valign="top">
                                                        <h4>
                                                            Master Menu:</h4>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tblBorderAll" valign="top">
                                                        <asp:CheckBoxList ID="chkListMaster" runat="server">
                                                        </asp:CheckBoxList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="top">
                                                        <h4>
                                                            Main Branch:</h4>
                                                        <asp:DropDownList ID="drp_MainBranchAccess" runat="server" CssClass="drpDownAuto">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tblBorderAll" valign="top">
                                                        Branch Access:
                                                        <asp:CheckBoxList ID="chkListBranchList" runat="server">
                                                        </asp:CheckBoxList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center" style="padding-top: 5px">
                                        <p>
                                            <input id="btn_Delete" type="button" value="Delete" class="submitButtonWithImage60" style="background-image:url(/Images/RedXSmall.gif)"
                                                onclick="DeleteAgentConfirm('<%=lbl_UserID.text%>')" />
                                            <asp:Button ID="btn_AddUpdate" runat="server" Text="Add/Update" CssClass="submitButtonWithImage60" style="background-image:url(/Images/Add.gif)" />
                                            <br />
                                            <asp:Label ID="lbl_MsgAgentAddUpdate" runat="server" Text="" CssClass="ErrMsg"></asp:Label>
                                        </p>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
   
                        <div id="div_MsgConfirmDelete" style="visibility: hidden; position: fixed; margin-top: 53px;
                            top: 53px; text-align: center; padding: 20px 10px 10px 10px">
                            <table style="background-color: #ffffff; height: 448px" width="480px">
                                <tr>
                                    <td align="center">
                                        <asp:Label ID="lbl_MsgAgentConfirm" runat="server" Text="" CssClass="ErrMsg"></asp:Label>
                                        <p>
                                            <asp:Button ID="btn_DeleteCancel" runat="server" Text="Cancel" CssClass="submitButtonWithImage60" CausesValidation="false" style="background-image:url(/Images/Cancel.gif)" />
                                            <asp:Button ID="btn_DeleteYes" runat="server" Text="Yes" CssClass="submitButtonWithImage60" CausesValidation="false" style="background-image:url(/Images/Check.gif)" />
                                        </p>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="div_MsgConfirmOK" style="visibility: hidden; position: fixed; margin-top: 53px;
                            top: 53px; text-align: center; padding: 25px 10px 10px 10px">
                            <table style="background-color: #ffffff; height: 448px" width="480px">
                                <tr>
                                    <td>
                                        <asp:Label ID="lbl_ConfirmMessageOK" runat="server" Text="" CssClass="ErrMsg"></asp:Label>
                                        <br />
                                        <asp:Button ID="btn_ConfirmOK" runat="server" Text="OK" CssClass="submitButtonWithImage60" CausesValidation="false" style="background-image:url(/Images/Check.gif)" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="grdViewAgentList" EventName="SelectedIndexChanging" />
                        <asp:AsyncPostBackTrigger ControlID="btn_AddUpdate" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btn_DeleteCancel" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btn_DeleteYes" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btn_ConfirmOK" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </asp:Panel>
        </div>
  
       
    </center>
</asp:Content>
