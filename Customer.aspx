<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master"
    CodeBehind="Customer.aspx.vb" Inherits="MJBUMAC1.Customer" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/UserControls/REQCalendar.ascx" TagName="ucREQCalendar" TagPrefix="ucREQCal" %>
<%@ Register Src="~/UserControls/REQCalendarAutoPost.ascx" TagName="ucREQAutoPostCalendar"
    TagPrefix="ucREQAutoPostCal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript" src="Scripts/Global.js"></script>
    <script language="javascript" type="text/javascript">
        /*Update Company List*/


        function ConfirmMessageShow() {
            $('#<%=pan_AddUpdateRecipient.ClientID%>').css('visibility', 'hidden');
            $('#div_MsgConfirmOKRecipient').css('visibility', 'visible');
            $('#<%=pan_AddUpdateRecipient.ClientID%>').css('height', '220');
        }

        function ConfirmOKRecipient() {
            $('#<%=pan_AddUpdateRecipient.ClientID%>').css('height', '0');
            $('#<%=pan_AddUpdateRecipient.ClientID%>').css('visibility', 'hidden');
            $('#div_MsgConfirmOKRecipient').css('visibility', 'hidden');
        }

        function ConfirmMessageShowCustomer() {
            $('#<%=pan_CustomerAddUpdate.ClientID%>').css('visibility', 'hidden');
            $('#div_MsgConfirmOKCustomer').css('visibility', 'visible');
            $('#<%=pan_CustomerAddUpdate.ClientID%>').css('height', '220');
        }

        function ConfirmOKCustomer() {
            $('#<%=pan_CustomerAddUpdate.ClientID%>').css('height', '0');
            $('#<%=pan_CustomerAddUpdate.ClientID%>').css('visibility', 'hidden');
            $('#div_MsgConfirmOKCustomer').css('visibility', 'hidden');
        }

        function PrintViewCustomer() {
            //$('#<%=pan_CustomerAddUpdate.ClientID%>').css('height', '0');
            $('#<%=pan_CustomerAddUpdate.ClientID%>').css('visibility', 'hidden');
            $('#<%=pan_CustomerList.ClientID%>').css('visibility', 'hidden');
            $('#div_PrintCustomer').css('visibility', 'visible');
            $('#div_CustomerList').css('visibility', 'hidden');
            //$('#<%=pan_CustomerPrintView.ClientID%>').css('height', '180');
        }

        function ShowCustomerList() {
            $('#<%=pan_CustomerList.ClientID%>').css('visibility', 'visible');
            $('#div_PrintCustomer').css('visibility', 'hidden');
            $('#div_CustomerList').css('visibility', 'visible');
            //$('#<%=pan_CustomerPrintView.ClientID%>').css('height', '180');
        }


        function HideHtmlButton(objBtnID) {
            document.getElementById(objBtnID).disabled = true;
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

            $('#<%=btn_AddNewRecipient.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_AddUpdateRecipient.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_CloseRecipientAddressHistory.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_ConfirmOKRecipient.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_CancelEditRecipient.ClientID%>').css('cursor', 'pointer');

            $('#<%=btn_SearchCustomer.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_AddNewCustomer.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_AddUpdateCustomer.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_ConfirmOKCustomer.ClientID%>').css('cursor', 'pointer');

            $('#btn_CloseRecipientEdit').css('cursor', 'pointer');
            $('#btn_CloseCustomerEdit').css('cursor', 'pointer');
            $('#btn_CloseCargoPickup').css('cursor', 'pointer');

            $('#<%=btn_AddPickupCancel.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_AddPickupCargo.ClientID%>').css('cursor', 'pointer');
            $('#<%=imgButtonAddNewCargo.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_CargoAddUpdateOK.ClientID%>').css('cursor', 'pointer');
            $('#btn_CloseCargoHistory').css('cursor', 'pointer');
            $('#<%=btn_PrintCargoHistory.ClientID%>').css('cursor', 'pointer');

            $('#btnCloseCargoRecipientHistory').css('cursor', 'pointer');
            $('#btn_PrintCargoHistoryRecipient').css('cursor', 'pointer');

            $('#<%=btn_DeleteCustomer.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_PrintViewCustomer.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_ConfirmOKCustomer.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_DeleteCustomerYes.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_DeleteCustomerNo.ClientID%>').css('cursor', 'pointer');

            $('#<%=btn_DeleteRecipient.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_DeleteRecipientYes.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_DeleteRecipientNo.ClientID%>').css('cursor', 'pointer');
            
        }

        function PrintDiv(divName) {
            var printContents = document.getElementById(divName).innerHTML;
            var originalContents = document.body.innerHTML;
            document.body.innerHTML = printContents;
            window.print();
            document.body.innerHTML = originalContents;
            location.reload();
        }

    </script>
    <h2>
        Customer
    </h2>
    <center>
        <asp:SqlDataSource ID="SqlDS_CustomerList" runat="server" ConnectionString="<%$ ConnectionStrings:MJBCONN %>"
            SelectCommand="Sp_Retrieve_Senders_List" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDS_SearchRecipient" runat="server" ConnectionString="<%$ ConnectionStrings:MJBCONN %>"
            SelectCommand="Sp_Retrieve_Recipient_Prime_List" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>
        <%-- <div id="divMenuSelected" style="position: fixed; margin-top: -42px; margin-left: 356px;
            z-index: 20000">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/PointerWhite.gif" />
        </div>--%>
        <asp:UpdatePanel ID="updtPan_CustomerList" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div id="div_CustomerList">
                <table class="tblBorderHeader" width="800px" cellpadding="2" cellspacing="2">
                    <tr>
                        <td valign="middle" align="left" class="FontHeader">
                            <asp:Label ID="lbl_SubHeader" runat="server" Text="Customer List" CssClass="FontHeader"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table class="tblBorderHeader" width="800px" cellpadding="2" cellspacing="2" style="white-space: nowrap">
                    <tr>
                        <td align="left" style="vertical-align: middle">
                            Search:
                            <asp:TextBox ID="txt_SearchCustomer" runat="server" CssClass="textEntryMedium" MaxLength="25"
                                ToolTip="Enter Customer/Recipient Name or Phone Number"></asp:TextBox>
                            Using
                            <asp:DropDownList ID="drp_SearchCategory" runat="server" CssClass="drpDownAuto">
                                <asp:ListItem Text="Customer" Value="C"></asp:ListItem>
                                <asp:ListItem Text="Recipient" Value="R"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:Button ID="btn_SearchCustomer" runat="server" Text="Search" CssClass="submitButtonWithImage"
                                Style="cursor: pointer; background-image: url(/Images/Search.gif)" CausesValidation="false" />
                        </td>
                        <td align="right" style="vertical-align: middle">
                            <%--  <asp:ImageButton ID="imgBtnAddNewCustomer" CssClass="submitButtonNoBordeAuto" CausesValidation="false"
                                runat="server" ImageUrl="~/Images/AddNewCustomer.gif" ToolTip="Add New Customer" />--%>
                            <asp:Button ID="btn_AddNewCustomer" runat="server" Text="Add New Customer" CssClass="submitButtonWithImage"
                                Style="background-image: url(/Images/AddCustomer.gif)" CausesValidation="false" />
                        </td>
                    </tr>
                </table>
                <!--Search Customer List-->
                <asp:Panel ID="pan_CustomerList" runat="server">
                    <asp:GridView ID="grdViewCustomerList" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" DataSourceID="SqlDS_CustomerList" HeaderStyle-CssClass="gridViewheader"
                        HeaderStyle-HorizontalAlign="Center" PageSize="15" GridLines="Horizontal" RowStyle-HorizontalAlign="Center"
                        Width="800px" PagerStyle-HorizontalAlign="Center" DataKeyNames="Sender_ID" PagerStyle-VerticalAlign="Middle"
                        CssClass="gridView">
                        <Columns>
                            <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/EditCustomer.gif" SelectText=""
                                EditText="EditSender" ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="Edit"
                                ShowSelectButton="True" />
                            <asp:BoundField DataField="Sender_FullName" HeaderText="Customer Name" SortExpression="Sender_FullName"
                                HeaderStyle-Wrap="false" />
                            <asp:TemplateField HeaderText="Address">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_Address1" runat="server" Text='<%# Eval("Sender_Add1")%>'></asp:Label>
                                    <asp:Label ID="lbl_Address2" runat="server" Text='<%# Eval("Sender_Add2")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:ButtonField CommandName="Recipient" ButtonType="Image" ImageUrl="~/Images/Group.gif"
                                ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="View Recipient" />
                            <asp:ButtonField CommandName="NewCargoPickUp" ButtonType="Image" ImageUrl="~/Images/TruckPlus.gif"
                                ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="Cargo Pickup" />
                            <asp:ButtonField CommandName="CargoHistory" ButtonType="Image" ImageUrl="~/Images/Boxes.gif"
                                ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="Cargo History" />
                        </Columns>
                        <AlternatingRowStyle BackColor="#f1f1f1" />
                        <PagerStyle BackColor="#f1f1f1" HorizontalAlign="Center" CssClass="pagination" ForeColor="Black" />
                        <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last"
                            NextPageText=">" PreviousPageText="<" />
                    </asp:GridView>
                    <table width="800px" class="tblBorderAll">
                        <tr>
                            <td>
                                Total:
                                <asp:Label ID="lbl_Total" runat="server" Text="0"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <!--Search Recipient List--->
                <asp:Panel ID="pan_RecipientList" runat="server" Visible="false" ScrollBars="Auto">
                    <asp:GridView ID="grdViewSearchRecipientList" runat="server" AllowSorting="True"
                        AutoGenerateColumns="False" DataSourceID="sqlDS_SearchRecipient" HeaderStyle-CssClass="gridViewheader"
                        HeaderStyle-HorizontalAlign="Center" GridLines="Horizontal" RowStyle-HorizontalAlign="Center"
                        Width="800px" PagerStyle-HorizontalAlign="Center" DataKeyNames="Recipient_ID"
                        PagerStyle-VerticalAlign="Middle" CssClass="gridView">
                        <Columns>
                            <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/EditCustomer.gif" SelectText=""
                                ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="Edit" ShowSelectButton="True" />
                            <asp:BoundField DataField="Recipient_FName" HeaderText="First Name" SortExpression="Recipient_FName"
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Recipient_LName" HeaderText="Last Name" SortExpression="Recipient_LName"
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Sender_FullName" HeaderText="Customer Name" SortExpression="Sender_FullName"
                                HeaderStyle-Wrap="false" />
                            <asp:TemplateField HeaderText="Address">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_Address1" runat="server" Text='<%# Eval("Recipient_Add1")%>'></asp:Label>
                                    <asp:Label ID="lbl_Address2" runat="server" Text='<%# Eval("Recipient_Add2")%>'></asp:Label>
                                    <%--  <asp:Label ID="lbl_RecipientFName" runat="server" Text='<%# Eval("Recipient_FName")%>'></asp:Label>
                                    <asp:Label ID="lbl_RecipientLName" runat="server" Text='<%# Eval("Recipient_LName")%>'></asp:Label>--%>
                                    <asp:Label ID="lbl_SenderID" runat="server" Text='<%# Eval("Sender_ID")%>' Visible="false"></asp:Label>
                                    <asp:Label ID="lbl_CustomerName" runat="server" Text='<%# Eval("Sender_FullName")%>'
                                        Visible="false"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:ButtonField CommandName="NewCargo" ButtonType="Image" ImageUrl="~/Images/BoxAdd.gif"
                                ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="New Cargo" />
                            <asp:ButtonField CommandName="AddressHistory" ButtonType="Image" ImageUrl="~/Images/AddressBook.gif"
                                ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="Address History" />
                            <asp:ButtonField CommandName="CargoHistory" ButtonType="Image" ImageUrl="~/Images/Box.gif"
                                ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="Cargo History" />
                        </Columns>
                        <AlternatingRowStyle BackColor="#f1f1f1" />
                    </asp:GridView>
                </asp:Panel>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="grdViewCustomerList" EventName="Sorting" />
                <asp:AsyncPostBackTrigger ControlID="grdViewCustomerList" EventName="PageIndexChanging" />
            </Triggers>
        </asp:UpdatePanel>
     
        <asp:UpdatePanel ID="updtPan_CustomerPrintView" runat="server">
                  <ContentTemplate>
                        <asp:Panel ID="pan_CustomerPrintView" Visible="false" runat="server" Width="660px" Style="padding: 10px 10px 10px 10px;
                            text-align: center; z-index:1000">
                            <center>
                                <table style="background-color: #ffffff;" width="650px" class="tblBorderAll">
                                    <tr>
                                        <td align="right" style="padding-top: 2px">
                                            <div id="divTools" style="position: absolute; margin-top: 53px; top: 53px; margin-left: 570px;
                                                padding: 10px 10px 10px 10px; z-index: 1000">
                                                <input id="btn_Print1" type="button" value="Print" onclick="PrintDiv('div_PrintCustomer')"
                                                    class="submitButtonWithImage80" style="background-image: url(/Images/PrintBtn.gif)" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <div id="div_PrintCustomer" style="visibility: hidden; position:absolute; margin-top: 65px;
                                                top: 65px; text-align: center; padding: 10px 10px 10px 10px; z-index:1000">
                                                <table width="650px" style="background-color:#ffffff;height:auto" class="tblBorderAll">
                                                    <tr>
                                                        <td align="left">
                                                            First Name:<br />
                                                            <asp:Label ID="lbl_FirstName" runat="server" Text="" CssClass="bold"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            Last Name:<br />
                                                            <asp:Label ID="lbl_LastName" runat="server" Text="" CssClass="bold"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            Address 1:<br />
                                                            <asp:Label ID="lbl_Address1" runat="server" Text="" CssClass="bold"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            Address 2:<br />
                                                            <asp:Label ID="lbl_Address2" runat="server" Text="" CssClass="bold"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            City:<br />
                                                            <asp:Label ID="lbl_City" runat="server" Text="" CssClass="bold"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            State:<br />
                                                            <asp:Label ID="lbl_State" runat="server" Text="" CssClass="bold"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            Zip:<br />
                                                            <asp:Label ID="lbl_Zip" runat="server" Text="" CssClass="bold"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            Country:<br />
                                                            <asp:Label ID="lbl_Country" runat="server" Text="" CssClass="bold"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            Phone:<br />
                                                            <asp:Label ID="lbl_Phone" runat="server" Text="" CssClass="bold"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            Alt Phone:<br />
                                                            <asp:Label ID="lbl_AltPhone" runat="server" Text="" CssClass="bold"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" align="left">
                                                            Identification Number:(OFAC requires at least one identification number is required
                                                            if sending $1000 or more and two identification number if sender is remitting $3000
                                                            or more. Refer to your company documentation for more info.)
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            ID 1:
                                                            <br />
                                                            <asp:Label ID="lbl_ID1" runat="server" Text="" CssClass="bold"></asp:Label>
                                                        </td>
                                                         <td align="left">
                                                            ID 2:
                                                            <br />
                                                            <asp:Label ID="lbl_ID2" runat="server" Text="" CssClass="bold"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            Notes:<br />
                                                            <asp:Label ID="lbl_Notes" runat="server" Text="" CssClass="bold"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            Address Notes:<br />
                                                            <asp:Label ID="lbl_AddressNotesP" runat="server" Text="" CssClass="bold"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </asp:Panel>
                    </ContentTemplate>
        </asp:UpdatePanel>
           
        <div id="blanket" style="display: none">
        </div>
        <div id="popUpDivCustomerRecipientEdit" style="display: none; z-index: 9012; position: fixed">
            <asp:Panel ID="pan_CustomerRecipientEdit" Width="700px" runat="server" CssClass="FrameBorderGridBG1">
                <asp:UpdatePanel ID="updtPan_CustomerRecipientEdit" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div style="z-index: 9013; position: fixed; top: 45px; margin-top: 45px;">
                            <asp:Panel ID="pan_HeadTitleRecipient" runat="server" Width="700px" Style="position: fixed;
                                background-color: transparent">
                                <table width="720px" style="background-color: Transparent">
                                    <tr>
                                        <td align="left" valign="bottom" style="padding-left: 10px" class="FontHeader">
                                            Customer:
                                            <asp:Label ID="lbl_CustomerName" runat="server" Text="" CssClass="FontHeader"></asp:Label>
                                            <asp:HiddenField ID="hdn_SenderID" runat="server" />
                                        </td>
                                        <td align="right" valign="top">
                                            <input id="btn_CloseRecipientEdit" type="button" style="background-image: url(../Images/Xclose.png);
                                                background-repeat: no-repeat; cursor: pointer; background-color: Transparent;
                                                border: none; width: 32px; height: 32px" onclick="popup('popUpDivCustomerRecipientEdit','','100','blanket','700')" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                        <asp:Panel ID="pan_CustomerRecipientInfoList" Width="670px" ScrollBars="Auto" runat="server"
                            Style="padding: 30px 10px 10px 10px; height: 300px; max-height: 300px; text-align: center;
                            vertical-align: top;">
                            <table style="background-color: #ffffff; height: 290px" width="660px">
                                <tr>
                                    <td valign="top">
                                        <table style="background-color: #ffffff;" width="660px">
                                            <tr>
                                                <td class="FontHeader" align="left" valign="top">
                                                    Recipient List:
                                                </td>
                                                <td align="right" valign="top">
                                                    <%--<asp:ImageButton ID="img_BtnAddNewRecipient" CssClass="submitButtonNoBordeAuto" CausesValidation="false"
                                                        runat="server" ImageUrl="~/Images/AddNewCustomer.gif" ToolTip="Add New Recipient" />--%>
                                                    <asp:Button ID="btn_AddNewRecipient" runat="server" Text="Add New Recipient" CssClass="submitButtonWithImage"
                                                        Style="background-image: url(/Images/Customers.gif)" CausesValidation="false" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" valign="top">
                                                    <asp:SqlDataSource ID="SqlDS_Recipient" runat="server" ConnectionString="<%$ ConnectionStrings:MJBCONN %>"
                                                        SelectCommand="Sp_Retrieve_Recipient_Prime_List" SelectCommandType="StoredProcedure">
                                                    </asp:SqlDataSource>
                                                    <asp:GridView ID="grdViewRecipientList" runat="server" 
                                                        AutoGenerateColumns="False" DataSourceID="SqlDS_Recipient" HeaderStyle-CssClass="gridViewheader"
                                                        HeaderStyle-HorizontalAlign="Center" GridLines="Horizontal" RowStyle-HorizontalAlign="Center"
                                                        Width="660px" PagerStyle-HorizontalAlign="Center" DataKeyNames="Recipient_ID"
                                                        PagerStyle-VerticalAlign="Middle" CssClass="gridView">
                                                        <Columns>
                                                            <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/EditCustomer.gif" SelectText=""
                                                                ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="Edit" ShowSelectButton="True" />
                                                            <asp:BoundField DataField="Recipient_FName" HeaderText="First Name" SortExpression="Recipient_FName"
                                                                HeaderStyle-Wrap="false" />
                                                            <asp:BoundField DataField="Recipient_LName" HeaderText="Last Name" SortExpression="Recipient_LName"
                                                                HeaderStyle-Wrap="false" />
                                                            <asp:TemplateField HeaderText="Address">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbl_Address1" runat="server" Text='<%# Eval("Recipient_Add1")%>'></asp:Label>
                                                                    <asp:Label ID="lbl_Address2" runat="server" Text='<%# Eval("Recipient_Add2")%>'></asp:Label>
                                                                    <asp:Label ID="lbl_RecipientFName" runat="server" Text='<%# Eval("Recipient_FName")%>'
                                                                        Visible="false"></asp:Label>
                                                                    <asp:Label ID="lbl_RecipientLName" runat="server" Text='<%# Eval("Recipient_LName")%>'
                                                                        Visible="false"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:ButtonField CommandName="NewCargo" ButtonType="Image" ImageUrl="~/Images/BoxAdd.gif"
                                                                ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="New Cargo" />
                                                            <asp:ButtonField CommandName="AddressHistory" ButtonType="Image" ImageUrl="~/Images/AddressBook.gif"
                                                                ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="Address History" />
                                                        </Columns>
                                                        <AlternatingRowStyle BackColor="#f1f1f1" />
                                                        <PagerStyle BackColor="#f1f1f1" HorizontalAlign="Center" CssClass="pagination" ForeColor="Black" />
                                                        <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last"
                                                            NextPageText=">" PreviousPageText="<" />
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="tblBorderAll" colspan="2" valign="top">
                                                    Total:
                                                    <asp:Label ID="lbl_TotalRecipient" runat="server" Text="0"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="pan_AddUpdateRecipient" Width="660px" runat="server" Style="padding: 30px 10px 10px 10px;
                            text-align: center" Visible="false">
                            <center>
                                <table style="background-color: #ffffff; padding-left: 10px;" width="650px">
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="lbl_RecipientAddUpdateHeader" runat="server" Text="" CssClass="FontHeader"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <table>
                                                <tr>
                                                    <td align="left">
                                                        First Name:
                                                    </td>
                                                    <td align="left">
                                                        Last Name:
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:HiddenField ID="hdn_RecipientID" runat="server" />
                                                        <asp:TextBox ID="txt_RecipientFirst" runat="server" MaxLength="25" CssClass="textEntryLarge"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqFieldRecipient1" runat="server" CssClass="ErrMsg"
                                                            ErrorMessage="*" SetFocusOnError="true" ToolTip="Required!" Display="Dynamic"
                                                            ControlToValidate="txt_RecipientFirst"></asp:RequiredFieldValidator>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_RecipientLast" runat="server" MaxLength="25" CssClass="textEntryLarge"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqFieldRecipient2" runat="server" CssClass="ErrMsg"
                                                            ErrorMessage="*" SetFocusOnError="true" ToolTip="Required!" Display="Dynamic"
                                                            ControlToValidate="txt_RecipientLast"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        Address 1:
                                                    </td>
                                                    <td align="left">
                                                        Address 2:
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_RecipientAddress1" runat="server" CssClass="textEntryLarge"
                                                            MaxLength="50"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqFieldRecipient3" runat="server" CssClass="ErrMsg"
                                                            ErrorMessage="*" SetFocusOnError="true" ToolTip="Required!" Display="Dynamic"
                                                            ControlToValidate="txt_RecipientAddress1"></asp:RequiredFieldValidator>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_RecipientAddress2" runat="server" CssClass="textEntryLarge"
                                                            MaxLength="50"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        City:
                                                    </td>
                                                    <td align="left">
                                                        State/Province:
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_RecipientCity" runat="server" CssClass="textEntryLarge" MaxLength="50"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqFieldRecipient4" runat="server" CssClass="ErrMsg"
                                                            SetFocusOnError="true" ErrorMessage="*" ToolTip="Required!" ControlToValidate="txt_RecipientCity"
                                                            Display="Dynamic"></asp:RequiredFieldValidator>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_RecipientStateProvince" runat="server" CssClass="textEntryLarge"
                                                            MaxLength="50"></asp:TextBox>
                                                        <%--  <asp:RequiredFieldValidator ID="reqFieldRecipient5" runat="server" CssClass="ErrMsg"
                                                            SetFocusOnError="true" ErrorMessage="*" ToolTip="Required!" ControlToValidate="txt_RecipientStateProvince"
                                                            Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" colspan="2">
                                                        Zip:
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" align="left">
                                                        <asp:TextBox ID="txt_RecipientZip" runat="server" CssClass="textEntrySmall" MaxLength="15"></asp:TextBox>
                                                      <%--  <asp:RequiredFieldValidator ID="reqFieldRecipient6" runat="server" CssClass="ErrMsg"
                                                            SetFocusOnError="true" ErrorMessage="*" ToolTip="Required!" ControlToValidate="txt_RecipientZip"
                                                            Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        Country:
                                                    </td>
                                                    <td align="left">
                                                        Phone:
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_RecipientCountry" runat="server" Text="PHILIPPINES" CssClass="textEntryMedium"></asp:TextBox>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_Recipientphone" runat="server" CssClass="textEntryMedium"></asp:TextBox>
                                                    </td>
                                                </tr>
                                               <%-- <tr>
                                                    <td colspan="2" align="left">
                                                        Notes:
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" align="left">
                                                        <asp:Panel ID="pan_Notes" runat="server" ScrollBars="Vertical" Height="60px" Width="440px"
                                                            CssClass="tblBorderAll">
                                                            <asp:Label ID="lbl_NotesRecipient" runat="server" Text=""></asp:Label>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>--%>
                                                <tr>
                                                    <td colspan="2" align="left">
                                                        Enter Notes:
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" align="left">
                                                        <asp:TextBox ID="txt_NewNotesRecipient" runat="server" Width="440px" TextMode="MultiLine"
                                                            Rows="5"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" align="center" style="padding-top: 5px">
                                                        <asp:Button ID="btn_DeleteRecipient" runat="server" Text="Delete" CssClass="submitButtonWithImage80"
                                                            Style="background-image: url(/Images/RedXSmall.gif)" CausesValidation="false"
                                                            Visible="false" />
                                                        <asp:Button ID="btn_CancelEditRecipient" runat="server" Text="Cancel" CausesValidation="false"
                                                            CssClass="submitButtonWithImage80" Style="background-image: url(/Images/Cancel.gif)" />
                                                        <asp:Button ID="btn_AddUpdateRecipient" runat="server" Text="Update" CssClass="submitButtonWithImage80"
                                                            Style="background-image: url(/Images/Add.gif)" />
                                                        <br />
                                                        <asp:Label ID="lbl_MsgErrRecipient" runat="server" Text="" CssClass="ErrMsg"></asp:Label>
                                                        <%--<asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmOnFormSubmit="true"
                                                            ConfirmText="Are you sure you want to delete now?" TargetControlID="btn_DeleteRecipient">
                                                        </asp:ConfirmButtonExtender>--%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </asp:Panel>
                        <asp:Panel ID="pan_RecipientHistoryAddress" runat="server" Visible="false" Width="670px"
                            ScrollBars="Auto" Style="padding: 30px 10px 10px 10px; height: 300px; max-height: 300px;
                            text-align: center;">
                            <table style="background-color: #ffffff; height: 290px" width="660px">
                                <tr>
                                    <td valign="top">
                                        <table>
                                            <tr>
                                                <td class="FontHeader" align="left" valign="top">
                                                    Recipient Address History
                                                </td>
                                                <td align="right" valign="top">
                                                    <asp:Label ID="lbl_RecipientNameAddHistory" runat="server" Text="" CssClass="FontHeader"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" valign="top" align="center">
                                                    <asp:SqlDataSource ID="SqlDS_RecipientAddHistory" runat="server" ConnectionString="<%$ ConnectionStrings:MJBCONN %>"
                                                        SelectCommand="Sp_Retrieve_Recipient_AddressHistory" SelectCommandType="StoredProcedure">
                                                    </asp:SqlDataSource>
                                                    <asp:GridView ID="grdViewRecipientAddressHistory" runat="server"
                                                        AutoGenerateColumns="False" DataSourceID="SqlDS_RecipientAddHistory"
                                                        HeaderStyle-CssClass="gridViewheader" HeaderStyle-HorizontalAlign="Center" GridLines="Horizontal"
                                                        RowStyle-HorizontalAlign="Center" Width="660px" PagerStyle-HorizontalAlign="Center"
                                                        PagerStyle-VerticalAlign="Middle" CssClass="gridView">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Address">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbl_Address1" runat="server" Text='<%# Eval("Recipient_Add1")%>'></asp:Label>
                                                                    <asp:Label ID="lbl_Address2" runat="server" Text='<%# Eval("Recipient_Add2")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="Recipient_City" HeaderText="City" SortExpression="Recipient_City"
                                                                HeaderStyle-Wrap="false" />
                                                            <asp:BoundField DataField="Recipient_State" HeaderText="Province" SortExpression="Entry_Date"
                                                                HeaderStyle-Wrap="false" />
                                                            <asp:BoundField DataField="Recipient_Zip" HeaderText="ZIP" SortExpression="Recipient_Zip"
                                                                HeaderStyle-Wrap="false" />
                                                            <asp:BoundField DataField="Entry_Date" HeaderText="Entry Date" SortExpression="Entry_Date"
                                                                HeaderStyle-Wrap="false" />
                                                        </Columns>
                                                        <AlternatingRowStyle BackColor="#f1f1f1" />
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" align="center">
                                        <asp:Button ID="btn_CloseRecipientAddressHistory" runat="server" Text="Back" CausesValidation="false"
                                            CssClass="submitButtonWithImage80" Style="background-image: url(/Images/BackArrow.gif)" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <div id="div_MsgConfirmOKRecipient" style="visibility: hidden; position: fixed; margin-top: 60px;
                            top: 60px; text-align: center; padding: 10px 10px 10px 10px">
                            <center>
                                <table style="background-color: #ffffff; height: 220px" width="670px">
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="lbl_ConfirmMessageOKRecipient" runat="server" Text="" CssClass="ErrMsg"></asp:Label>
                                            <br />
                                            <br />
                                            <asp:Button ID="btn_ConfirmOKRecipient" runat="server" Text="OK" CssClass="submitButtonWithImage60"
                                                CausesValidation="false" Style="background-image: url(/Images/Check.gif)" />
                                            <asp:Button ID="btn_DeleteRecipientYes" runat="server" Text="Yes" CssClass="submitButtonWithImage60"
                                                CausesValidation="false" Visible="false" Style="cursor: pointer; background-image: url(/Images/Check.gif)" />
                                            <asp:Button ID="btn_DeleteRecipientNo" runat="server" Text="No" CssClass="submitButtonWithImage60"
                                                CausesValidation="false" Visible="false" Style="cursor: pointer; background-image: url(/Images/Cancel.gif)" />
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btn_ConfirmOKRecipient" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btn_CancelEditRecipient" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btn_AddUpdateRecipient" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btn_AddNewRecipient" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </asp:Panel>
        </div>
        <div id="blanket1" style="display: none">
        </div>
        <div id="divPopupUpdateAddCustomer" style="display: none; z-index: 9012; position: fixed">
            <asp:Panel ID="pan_CustomerEdit" Width="700px" runat="server" CssClass="FrameBorderGridBG1">
                <asp:UpdatePanel ID="updtPan_CustomerEdit" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div style="z-index: 9013; position: fixed; top: 45px; margin-top: 45px;">
                            <asp:Panel ID="pan_HeadTitleCustomer" runat="server" Width="700px" Style="position: fixed;
                                background-color: transparent">
                                <table width="720px" style="background-color: Transparent">
                                    <tr>
                                        <td align="left" valign="bottom" style="padding-left: 10px" class="FontHeader">
                                            <asp:Label ID="lbl_CustomerAddUpdateHeader" runat="server" Text="" CssClass="FontHeader"></asp:Label>
                                            <asp:HiddenField ID="hdn_CustomerEditID" runat="server" />
                                        </td>
                                        <td align="right" valign="top">
                                            <input id="btn_CloseCustomerEdit" type="button" style="background-image: url(../Images/Xclose.png);
                                                background-repeat: no-repeat; cursor: pointer; background-color: Transparent;
                                                border: none; width: 32px; height: 32px" onclick="popup('divPopupUpdateAddCustomer','','100','blanket','700')" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                       
                        <asp:Panel ID="pan_CustomerAddUpdate" Width="660px" runat="server" Style="padding: 30px 10px 10px 10px;
                            text-align: center" Visible="false">
                            <center>
                                <table style="background-color: #ffffff; padding-left: 10px;" width="650px">
                                    <tr>
                                        <td align="center">
                                            <table width="400px">
                                                <tr>
                                                    <td align="left">
                                                        First Name:
                                                    </td>
                                                    <td align="left">
                                                        Last Name:
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_CustomerFirstName" runat="server" MaxLength="25" CssClass="textEntryLarge"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqFieldCustomer1" runat="server" CssClass="ErrMsg"
                                                            ErrorMessage="*" ToolTip="Required!" Display="Dynamic" ControlToValidate="txt_CustomerFirstName"
                                                            SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_CustomerLastName" runat="server" MaxLength="25" CssClass="textEntryLarge"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqFieldCustomer2" runat="server" CssClass="ErrMsg"
                                                            ErrorMessage="*" ToolTip="Required!" Display="Dynamic" ControlToValidate="txt_CustomerLastName"
                                                            SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        Address 1:
                                                    </td>
                                                    <td align="left">
                                                        Address 2:
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_CustomerAdd1" runat="server" CssClass="textEntryLarge" MaxLength="50"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqFieldCustomer3" runat="server" CssClass="ErrMsg"
                                                            ErrorMessage="*" ToolTip="Required!" Display="Dynamic" ControlToValidate="txt_CustomerAdd1"
                                                            SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_CustomerAdd2" runat="server" CssClass="textEntryLarge" MaxLength="50"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        City:
                                                    </td>
                                                    <td align="left">
                                                        State:
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_CustomerCity" runat="server" CssClass="textEntryMedium" MaxLength="50"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqFieldCustomer4" runat="server" CssClass="ErrMsg"
                                                            SetFocusOnError="true" ErrorMessage="*" ToolTip="Required!" ControlToValidate="txt_CustomerCity"
                                                            Display="Dynamic"></asp:RequiredFieldValidator>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_CustomerState" runat="server" CssClass="textEntryMedium" MaxLength="50"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqFieldCustomer5" runat="server" CssClass="ErrMsg"
                                                            SetFocusOnError="true" ErrorMessage="*" ToolTip="Required!" ControlToValidate="txt_CustomerState"
                                                            Display="Dynamic"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        Zip:
                                                    </td>
                                                    <td align="left">
                                                        Country:
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_CustomerZip" runat="server" CssClass="textEntrySmall" MaxLength="15"></asp:TextBox>
                                                       <asp:RequiredFieldValidator ID="reqFieldCustomer6" runat="server" CssClass="ErrMsg"
                                                            SetFocusOnError="true" ErrorMessage="*" ToolTip="Required!" ControlToValidate="txt_CustomerZip"
                                                            Display="Dynamic"></asp:RequiredFieldValidator>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_CustomerCountry" runat="server" text="USA" CssClass="textEntryMedium" MaxLength="15"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        Phone:
                                                    </td>
                                                    <td align="left">
                                                        Alt Phone:
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_CustomerPhone" runat="server" CssClass="textEntryMedium" MaxLength="16"></asp:TextBox>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_CustomerAltPhone" runat="server" CssClass="textEntryMedium"
                                                            MaxLength="16"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        Identification Number:(OFAC requires at least one identification number is required
                                                        if sending $1000 or more and two identification number if sender is remitting $3000
                                                        or more. Refer to your company documentation for more info.)
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        ID 1:
                                                    </td>
                                                    <td>
                                                        ID 2:
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txt_CustomerID1" runat="server" CssClass="textEntryMedium" MaxLength="100"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txt_CustomerID2" runat="server" CssClass="textEntryMedium" MaxLength="100"></asp:TextBox>
                                                    </td>
                                                </tr>
                                               <%-- <tr>
                                                    <td align="left">
                                                        Notes:
                                                    </td>
                                                    <td align="left">
                                                        Address Notes:
                                                    </td>
                                                </tr>--%>
                                               <%-- <tr>
                                                    <td align="left">
                                                        <asp:Panel ID="Panel2" runat="server" Visible="false" ScrollBars="Vertical" Height="80px" Width="220px"
                                                            CssClass="tblBorderAll" BackColor="#F8F068">
                                                           <asp:Label ID="lbl_CustomerNotes" runat="server" Text=""></asp:Label>
                                                        </asp:Panel>
                                                    </td>
                                                    <td align="left">
                                                       <asp:Panel ID="Panel3" runat="server"  Visible="false"  ScrollBars="Vertical" Height="80px" Width="220px"
                                                            CssClass="tblBorderAll" BackColor="#F8F068">
                                                           <asp:Label ID="lbl_AddressNotes" runat="server" Text=""></asp:Label>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>--%>
                                                <tr>
                                                    <td align="left">
                                                        Enter Notes:
                                                    </td>
                                                    <td align="left">
                                                        Enter Address Notes:
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_CustomerNewNotes" runat="server" Width="220px" TextMode="MultiLine"
                                                            Rows="10"></asp:TextBox>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txt_AddressNotes" runat="server" Width="220px" TextMode="MultiLine"
                                                            Rows="10"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" align="center" style="padding-top: 5px">
                                                        <asp:Button ID="btn_DeleteCustomer" runat="server" Text="Delete" CssClass="submitButtonWithImage80"
                                                           Style="cursor: pointer; background-image: url(/Images/RedXSmall.gif)" Visible="false" CausesValidation="false" />
                                                        <asp:Button ID="btn_PrintViewCustomer" runat="server" Text="Print View" CausesValidation="false"
                                                            Style="cursor: pointer; background-image: url(/Images/PaperView.gif)" CssClass="submitButtonWithImage80" />
                                                        <%-- <asp:Button ID="btn_CancelCustomer" runat="server" Text="Cancel" CssClass="submitButtonWithImage80"
                                                            Style="background-image: url(/Images/Cancel.gif)" CausesValidation="false" Visible="false" />--%>
                                                        <asp:Button ID="btn_AddUpdateCustomer" runat="server" Text="Update" CssClass="submitButtonWithImage80"
                                                            Style="cursor: pointer; background-image: url(/Images/Add.gif)" />
                                                        <br />
                                                        <asp:Label ID="lbl_ErrMsgCustomer" runat="server" Text="" CssClass="ErrMsg"></asp:Label>
                                                      <%--  <asp:ConfirmButtonExtender ID="ConfirmButtonDeleteCustomer" runat="server" ConfirmOnFormSubmit="true"
                                                            ConfirmText="Are you sure you want to delete now?" TargetControlID="btn_DeleteCustomer">
                                                        </asp:ConfirmButtonExtender>--%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </asp:Panel>
                      
                        <div id="div_MsgConfirmOKCustomer" style="visibility: hidden; position: fixed; margin-top: 60px;
                            top: 60px; text-align: center; padding: 10px 10px 10px 10px">
                            <center>
                                <table style="background-color: #ffffff; height: 220px" width="670px">
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="lbl_ConfirmMessageOKCustomer" runat="server" Text="" CssClass="ErrMsg"></asp:Label>
                                            <br />
                                            <br />
                                            <asp:Button ID="btn_ConfirmOKCustomer" runat="server" Text="OK" CssClass="submitButtonWithImage60"
                                                CausesValidation="false" Style="cursor: pointer; background-image: url(/Images/Check.gif)" />
                                            <asp:Button ID="btn_DeleteCustomerYes" runat="server" Text="Yes" CssClass="submitButtonWithImage60"
                                                CausesValidation="false" Visible="false" Style="cursor: pointer; background-image: url(/Images/Check.gif)" />
                                            <asp:Button ID="btn_DeleteCustomerNo" runat="server" Text="No" CssClass="submitButtonWithImage60"
                                                CausesValidation="false" Visible="false" Style="cursor: pointer; background-image: url(/Images/Cancel.gif)" />
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </asp:Panel>
        </div>
        <div id="blanket2" style="display: none">
        </div>
        <div id="popUpDivAddPickupCargo" style="display: none; z-index: 9012; position: fixed">
            <asp:Panel ID="pan_PickupCargo" Width="700px" runat="server" CssClass="FrameBorderGridBG1">
                <asp:UpdatePanel ID="updtPan_PickupCargo" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div style="z-index: 9013; position: fixed; top: 95px; margin-top: 95px">
                            <asp:Panel ID="pan_HeadTitle" runat="server" Width="700px" Style="position: fixed;
                                background-color: transparent">
                                <table width="720px" style="background-color: Transparent; height: 50px">
                                    <tr>
                                        <td valign="middle" align="left" class="FontHeader" style="white-space: nowrap">
                                            Add/Update Schedule Pickup<br />
                                            <asp:HiddenField ID="hdn_SenderIDCargo" runat="server" />
                                            <asp:HiddenField ID="hdn_CargoPickupID" runat="server" />
                                        </td>
                                        <td valign="middle" align="left" class="FontHeader" style="padding-top: 10px">
                                            <asp:ImageButton ID="imgButtonAddNewCargo" CssClass="submitButtonNoBordeAuto" CausesValidation="false"
                                                runat="server" ImageUrl="~/Images/TruckPlus.gif" ToolTip="Add New Pickup Schedule" />
                                        </td>
                                        <td valign="middle" align="right" class="FontHeader" style="white-space: nowrap">
                                            Sender:&nbsp;<asp:Label ID="lbl_SenderName" runat="server" Text="" CssClass="lblHeader"></asp:Label>
                                        </td>
                                        <td align="right" valign="top" style="width: 550px">
                                            <input id="btn_CloseCargoPickup" type="button" style="background-image: url(../Images/Xclose.png);
                                                background-repeat: no-repeat; cursor: pointer; background-color: Transparent;
                                                border: none; width: 32px; height: 32px" onclick="popup('popUpDivAddPickupCargo','','200','blanket','700')" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                        <asp:Panel ID="pan_PickupCargoAdd" Visible="false" Width="690px" runat="server" Style="padding: 30px 10px 10px 10px;
                            text-align: center">
                            <table style="background-color: #ffffff; padding-left: 10px;" width="680px">
                                <tr>
                                    <td valign="top" align="right">
                                        Pick Up Date:
                                    </td>
                                    <td valign="top" align="left">
                                        <ucREQAutoPostCal:ucREQAutoPostCalendar runat="server" ID="ucPickUpDate"></ucREQAutoPostCal:ucREQAutoPostCalendar>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" align="right">
                                        Trip #:
                                    </td>
                                    <td valign="top" align="left">
                                        <asp:DropDownList ID="drp_TripNumber" runat="server" CssClass="drpDownAuto" AutoPostBack="true">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td valign="top" align="right">
                                        Notes:
                                    </td>
                                    <td valign="top" align="left">
                                        <asp:TextBox ID="txt_PickupCargoCurrentNotes" runat="server" Width="440px" TextMode="MultiLine"
                                            ReadOnly="true" Rows="5"></asp:TextBox>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td valign="top" align="right">
                                        Enter Notes:
                                    </td>
                                    <td valign="top" align="left">
                                        <asp:TextBox ID="txt_PickupCargoNotes" runat="server" Width="440px" TextMode="MultiLine"
                                            Rows="5"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" align="right">
                                        Status:
                                    </td>
                                    <td valign="top" align="left">
                                        <asp:DropDownList ID="drp_CargoPickupStatus" runat="server" CssClass="drpDownAuto">
                                            <asp:ListItem Value="NPC" Text="NPC - New"></asp:ListItem>
                                            <asp:ListItem Value="RSC" Text="RSC - Re-Scheduled"></asp:ListItem>
                                            <asp:ListItem Value="CMP" Text="CMP - Completed"></asp:ListItem>
                                            <asp:ListItem Value="CAN" Text="CAN - Canceled"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center" style="padding: 10px 0px 10px 0px">
                                        <asp:Button ID="btn_AddPickupCancel" runat="server" Text="Cancel" CssClass="submitButtonWithImage80"
                                            Style="background-image: url(/Images/Cancel.gif)" CausesValidation="false" />
                                        <asp:Button ID="btn_AddPickupCargo" runat="server" Text="Add" CausesValidation="false"
                                            CssClass="submitButtonWithImage80" Style="background-image: url(/Images/Add.gif)" />
                                        <br />
                                        <asp:Label ID="lbl_MsgCargo" runat="server" Text="" CssClass="ErrMsg"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="pan_PickupCargoUpdateMsg" runat="server" Visible="false" Width="690px"
                            Style="padding: 30px 10px 10px 10px; text-align: center">
                            <table style="background-color: #ffffff; padding-left: 10px; height: 200px" width="680px">
                                <tr>
                                    <td align="center">
                                        <asp:Label ID="lbl_MsgAddUpdateCargo" runat="server" Text="" CssClass="ErrMsg"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Button ID="btn_CargoAddUpdateOK" runat="server" Text="OK" CssClass="submitButtonWithImage60"
                                            CausesValidation="false" Style="background-image: url(/Images/Check.gif)" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="pan_PickupCargoList" Width="690px" runat="server" Style="padding: 30px 10px 10px 10px;
                            text-align: center">
                            <asp:SqlDataSource ID="SQLDS_PickUpCargo" runat="server" ConnectionString="<%$ ConnectionStrings:MJBCONN %>"
                                SelectCommand="Sp_Retrieve_From_Cargo_Schedule" SelectCommandType="StoredProcedure">
                            </asp:SqlDataSource>
                            <asp:GridView ID="grdViewCargoPickUpDate" runat="server" 
                                AutoGenerateColumns="False" DataSourceID="SQLDS_PickUpCargo" HeaderStyle-CssClass="gridViewheader"
                                HeaderStyle-HorizontalAlign="Center" GridLines="Horizontal" RowStyle-HorizontalAlign="Center"
                                BackColor="#ffffff" Width="680px" PagerStyle-HorizontalAlign="Center" DataKeyNames="ID"
                                PagerStyle-VerticalAlign="Middle" CssClass="gridView">
                                <Columns>
                                    <asp:BoundField DataField="Pickup_Date" HeaderText="Pickup Date" SortExpression="Pickup_Date"
                                        DataFormatString="{0:d}" HeaderStyle-Wrap="false" />
                                    <asp:BoundField DataField="Trip_Number" HeaderText="Trip Number" SortExpression="Trip_Number"
                                        HeaderStyle-Wrap="false" />
                                    <asp:TemplateField HeaderText="Notes">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txt_CargoNotes" runat="server" CssClass="textEntryMedium" Text='<%# Eval("Notes")%>'
                                                Width="220px" TextMode="MultiLine" ReadOnly="true" Rows="3"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" HeaderStyle-Wrap="false" />
                                    <asp:BoundField DataField="Entered_By" HeaderText="Entered By" SortExpression="Entered_By"
                                        HeaderStyle-Wrap="false" />
                                    <asp:ButtonField CommandName="CancelCargoSched" ButtonType="Image" ImageUrl="~/Images/TruckCancel.gif"
                                        ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="Cancel" />
                                    <asp:ButtonField CommandName="UpdateCargoSched" ButtonType="Image" ImageUrl="~/Images/TruckGo.gif"
                                        ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="Update" />
                                </Columns>
                                <AlternatingRowStyle BackColor="#f1f1f1" />
                                <PagerStyle BackColor="#f1f1f1" HorizontalAlign="Center" CssClass="pagination" ForeColor="Black" />
                                <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last"
                                    NextPageText=">" PreviousPageText="<" />
                            </asp:GridView>
                            <br />
                            <asp:Label ID="lbl_MsgCargo2" runat="server" Text="" CssClass="ErrMsg"></asp:Label>
                        </asp:Panel>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btn_AddPickupCargo" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="imgButtonAddNewCargo" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btn_AddPickupCancel" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="grdViewCargoPickUpDate" EventName="RowCommand" />
                        <asp:AsyncPostBackTrigger ControlID="ucPickUpDate" EventName="TextOnChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </asp:Panel>
        </div>
       
        <div id="blanket3" style="display: none">
        </div>
        <div id="popupDivCargoHistory" style="display: none; z-index: 9012; position: fixed">
            <asp:Panel ID="Panel1" Width="700px" runat="server" CssClass="FrameBorderGridBG1">
                <asp:UpdatePanel ID="updtPan_CargoHistory" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div style="z-index: 9013; position: fixed; top: 95px; margin-top: 95px">
                            <asp:Panel ID="panCargoHistoryHeader" runat="server" Width="700px" Style="position: fixed;
                                background-color: transparent">
                                <table width="720px" style="background-color: transparent; height: 50px">
                                    <tr>
                                        <td valign="middle" align="left" class="FontHeader" style="white-space: nowrap">
                                            Cargo History
                                        </td>
                                        <td align="right" valign="top" style="width: 550px">
                                            <input id="btn_CloseCargoHistory" type="button" style="background-image: url(../Images/Xclose.png);
                                                background-repeat: no-repeat; cursor: pointer; background-color: Transparent;
                                                border: none; width: 32px; height: 32px" onclick="popup('popupDivCargoHistory','','200','blanket','700')" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                        <asp:Panel ID="pan_CargoHistory" Width="680px" runat="server" ScrollBars="Auto" Style="padding: 30px 10px 10px 10px;
                            text-align: center">
                            <asp:SqlDataSource ID="SQLDS_HistoryCargo" runat="server" ConnectionString="<%$ ConnectionStrings:MJBCONN %>"
                                SelectCommand="Sp_Retrieve_Cargo_Transaction" SelectCommandType="StoredProcedure">
                            </asp:SqlDataSource>
                            <asp:GridView ID="grdview_CargoHistory" runat="server"
                                AutoGenerateColumns="False" DataSourceID="SQLDS_HistoryCargo"
                                HeaderStyle-CssClass="gridViewheader" HeaderStyle-HorizontalAlign="Center" GridLines="Horizontal"
                                RowStyle-HorizontalAlign="Center" Width="670px" PagerStyle-HorizontalAlign="Center"
                                PagerStyle-VerticalAlign="Middle" BackColor="#ffffff" CssClass="gridView">
                                <Columns>
                                    <asp:BoundField DataField="Recipient_FullName" HeaderText="Recipient FullName" SortExpression="Recipient_FullName"
                                        DataFormatString="{0:d}" HeaderStyle-Wrap="false" />
                                    <asp:BoundField DataField="Box_Number" HeaderText="Box Number" SortExpression="Box_Number"
                                        HeaderStyle-Wrap="false" />
                                    <asp:BoundField DataField="Ctr_Number" HeaderText="Ctrl Number" SortExpression="Ctr_Number"
                                        HeaderStyle-Wrap="false" />
                                    <asp:BoundField DataField="Service_Date" HeaderText="Service Date" SortExpression="Service_Date"
                                        HeaderStyle-Wrap="false" DataFormatString="{0:d}" />
                                </Columns>
                                <AlternatingRowStyle BackColor="#f1f1f1" />
                                <PagerStyle BackColor="#f1f1f1" HorizontalAlign="Center" CssClass="pagination" ForeColor="Black" />
                                <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last"
                                    NextPageText=">" PreviousPageText="<" />
                            </asp:GridView>
                            <table width="670px" class="tblBorderAll">
                                <tr>
                                    <td align="left">
                                        Total:
                                        <asp:Label ID="lbl_CargoHistoryTotal" runat="server" Text="0"></asp:Label>
                                    </td>
                                    <td align="right">
                                        <asp:Button ID="btn_PrintCargoHistory" runat="server" Text="Print" CausesValidation="false"
                                            CssClass="submitButtonWithImage80" Style="background-image: url(/Images/PrintBtn.gif)" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btn_PrintCargoHistory" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </asp:Panel>
        </div>
        
        <div id="blanket4" style="display: none">
        </div>
        <div id="popupDivRecipientCargoHistory" style="display: none; z-index: 9012; position: fixed">
            <asp:Panel ID="Panel4" Width="700px" runat="server" CssClass="FrameBorderGridBG1">
                <asp:UpdatePanel ID="updtPan_RecipientCargoHistory" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div id="div_RecipientCargoHistoryList" class="tblBorderAll">
                            <div style="z-index: 9013; position: fixed; top: 45px; margin-top: 45px;">
                                <asp:Panel ID="pan_RecipientCargoHistoryHeader" runat="server" Width="700px" Style="position: fixed;
                                    background-color: transparent;">
                                    <table width="720px" style="background-color: transparent; height: 50px">
                                        <tr>
                                            <td valign="middle" align="left" class="FontHeader" style="white-space: nowrap">
                                                Recipient Cargo History
                                            </td>
                                            <td align="right" valign="top" style="width: 550px">
                                                <input id="btnCloseCargoRecipientHistory" type="button" style="background-image: url(../Images/Xclose.png);
                                                    background-repeat: no-repeat; cursor: pointer; background-color: Transparent;
                                                    border: none; width: 32px; height: 32px" onclick="popup('popupDivRecipientCargoHistory','','200','blanket','700')" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </div>
                            <table width="720px" style="background-color: transparent;">
                                <tr>
                                    <td align="center" valign="middle" style="white-space: nowrap">
                                        <asp:Label ID="lbl_RecipientNameCargoHistory" runat="server" Text="" CssClass="FontHeader"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        <asp:Panel ID="pan_RecipientCargoHistory" Width="680px" runat="server" ScrollBars="Auto" Style="padding: 30px 10px 10px 10px;
                            text-align: center;">
                            <asp:SqlDataSource ID="SqlDS_RecipientCargoHistory" runat="server" ConnectionString="<%$ ConnectionStrings:MJBCONN %>"
                                SelectCommand="Sp_Retrieve_Cargo_Transaction" SelectCommandType="StoredProcedure">
                            </asp:SqlDataSource>
                            <asp:GridView ID="grdview_RecipientCargoHistory" runat="server"
                                AutoGenerateColumns="False" DataSourceID="SqlDS_RecipientCargoHistory"
                                HeaderStyle-CssClass="gridViewheader" HeaderStyle-HorizontalAlign="Center" GridLines="Horizontal"
                                RowStyle-HorizontalAlign="Center" Width="670px" PagerStyle-HorizontalAlign="Center"
                                PagerStyle-VerticalAlign="Middle" BackColor="#ffffff" CssClass="gridView">
                                <Columns>
                                    <asp:BoundField DataField="Box_Number" HeaderText="Box Number" SortExpression="Box_Number"
                                        HeaderStyle-Wrap="false" />
                                    <asp:BoundField DataField="Ctr_Number" HeaderText="Ctrl Number" SortExpression="Ctr_Number"
                                        HeaderStyle-Wrap="false" />
                                    <asp:BoundField DataField="Service_Date" HeaderText="Service Date" SortExpression="Service_Date"
                                        HeaderStyle-Wrap="false" DataFormatString="{0:d}" />
                                </Columns>
                                <AlternatingRowStyle BackColor="#f1f1f1" />
                                <PagerStyle BackColor="#f1f1f1" HorizontalAlign="Center" CssClass="pagination" ForeColor="Black" />
                                <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last"
                                    NextPageText=">" PreviousPageText="<" />
                            </asp:GridView>
                            <asp:Label ID="lbl_TotalRecipientCargorHistory" runat="server" Text="0"></asp:Label>
                           
                        </asp:Panel>
                         </div>
                        <table width="650px" class="tblBorderAll">
                                <tr>
                                    <td align="right" width="650px">
                                        <input id="btn_PrintCargoHistoryRecipient" type="button" value="Print" class="submitButtonWithImage80"
                                            onclick="PrintDiv('div_RecipientCargoHistoryList')" style="background-image: url(/Images/PrintBtn.gif)" />
                                    </td>
                                </tr>
                         </table>
                    </ContentTemplate>
                  <%--  <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btn_PrintCargoHistoryRecipient" EventName="Click" />
                    </Triggers>--%>
                </asp:UpdatePanel>
            </asp:Panel>
        </div>
        
    </center>
</asp:Content>
