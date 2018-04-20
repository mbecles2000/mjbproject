<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master"
    CodeBehind="Cargo.aspx.vb" Inherits="MJBUMAC1.Cargo" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/UserControls/Calendar.ascx" TagName="ucCalendar" TagPrefix="ucCal" %>
<%@ Register Src="~/UserControls/REQCalendar.ascx" TagName="ucREQCalendar" TagPrefix="ucREQCal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script language="javascript" type="text/javascript">
        /*Update Company List*/

        function ConfirmMessageShow() {
            $('#<%=pan_CargoAddUpdate.ClientID%>').css('visibility', 'hidden');
            $('#div_MsgConfirmOK').css('visibility', 'visible');
            $('#<%=pan_CargoAddUpdate.ClientID%>').css('height', '300');
        }

        function HideHtmlButton(objBtnID) {
            document.getElementById(objBtnID).disabled = true;
        }

        $(document).ready(function () {

            try {
                $("body").css("cursor", "auto");
                var prm = Sys.WebForms.PageRequestManager.getInstance();
                prm.add_initializeRequest(InitializeRequest);
                prm.add_endRequest(EndRequest);
            }
            catch (err) {
            }
        });

        function InitializeRequest(sender, args) {
             $("*").css("cursor", "wait");
            //$("body").css("cursor", "wait");
        }

        function EndRequest(sender, args) {
            $("*").css("cursor", "auto");
            $('#<%=btn_FilterCargoList.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_SearchCargo.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_AddUpdateCargo.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_DeleteCargo.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_ConfirmOK.ClientID%>').css('cursor', 'pointer');

            $('#<%=btn_EditCargoSched.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_PrintViewCargoSched.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_PrintViewCargo.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_ExportCargotoExcel.ClientID%>').css('cursor', 'pointer');
            $('#btn_Close').css('cursor', 'pointer');
            $('#btn_CloseCargoSchedule').css('cursor', 'pointer');
            $('#btn_PrintCargo').css('cursor', 'pointer');
        }

        function OpenDirection(OpenUrl) {
            open(OpenUrl, "_blank", "toolbar=yes, scrollbars=yes, resizable=yes, width=800, height=800");
        }

        function PrintDiv(divName) {
            var printContents = document.getElementById(divName).innerHTML;
            var originalContents = document.body.innerHTML;
            document.body.innerHTML = printContents;
            window.print();
            document.body.innerHTML = originalContents;
        }

       $("body").css("cursor", "wait");
//        $div_CargoList.load("Cargo.aspx", function () {
//            $("body").css("cursor", "auto");
//        });

    </script>
    <h2>
        Cargo
    </h2>
    <center>
        <asp:SqlDataSource ID="SqlDS_CargoList" runat="server" ConnectionString="<%$ ConnectionStrings:MJBCONN %>"
            SelectCommand="Sp_Retrieve_Cargo_Transaction_List_N" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>
        <%--     <div id="divMenuSelected" style="position:fixed; margin-top:-42px; margin-left:260px;z-index:20000">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/PointerWhite.gif" />
      </div>--%>
        <div id="div_CargoList">
        <asp:UpdatePanel ID="updtPan_CargoList" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:Panel ID="pan_CargoList" runat="server" Width="900px">
                    <table class="tblBorderHeader" width="900px" cellpadding="2" cellspacing="2">
                        <tr>
                            <td valign="middle" align="left" class="FontHeader">
                                Cargo List
                            </td>
                            <td valign="middle" align="right">
                                <asp:Button ID="btn_PrintViewCargo" runat="server" Text="Pickup Schedule" Style="cursor: pointer;
                                    background-image: url(/Images/Panel.gif)" CssClass="submitButtonWithImage" CausesValidation="false" />
                            </td>
                        </tr>
                    </table>
                    <table class="tblBorderHeader" width="900px" cellpadding="2" cellspacing="2" style="white-space: nowrap">
                        <tr>
                            <td>
                                Service Between
                                <ucCal:ucCalendar runat="server" ID="ucFromCalendar"></ucCal:ucCalendar>
                            </td>
                            <td>
                                and<ucCal:ucCalendar runat="server" ID="ucToCalendar"></ucCal:ucCalendar>
                            </td>
                            <td>
                                Status:
                                <asp:DropDownList ID="drp_CargoStatusFilter" runat="server" CssClass="drpDownAuto">
                                    <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="EXP-Exported cargo to csv file" Value="EXP"></asp:ListItem>
                                    <asp:ListItem Text="NXP-New cargo" Value="NXP"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:Button ID="btn_FilterCargoList" runat="server" Text="Filter" CausesValidation="false"
                                    Style="cursor: pointer; background-image: url(/Images/Filter.gif)" CssClass="submitButtonWithImage" />
                            </td>
                            <td>
                                Search:
                                <asp:TextBox ID="txt_SearchCargo" runat="server" CssClass="textEntrySmall" MaxLength="12"></asp:TextBox>
                                <asp:Button ID="btn_SearchCargo" runat="server" Text="Search" CausesValidation="false"
                                    Style="cursor: pointer; background-image: url(/Images/Search.gif)" CssClass="submitButtonWithImage" />
                            </td>
                        </tr>
                    </table>
                    <asp:GridView ID="grdViewCargoList" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" DataSourceID="SqlDS_CargoList" HeaderStyle-CssClass="gridViewheader"
                        HeaderStyle-HorizontalAlign="Center" PageSize="30" GridLines="Horizontal" RowStyle-HorizontalAlign="Center"
                        Width="900px" PagerStyle-HorizontalAlign="Center" DataKeyNames="Box_Number" PagerStyle-VerticalAlign="Middle"
                        CssClass="gridView">
                        <Columns>
                            <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/Box.gif" SelectText=""
                                ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="Edit" ShowSelectButton="True" />
                            <asp:BoundField DataField="Box_Number" HeaderText="Box Number" SortExpression="Box_Number"
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Ctr_Number" HeaderText="Ctrl Number" SortExpression="Ctr_Number"
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Sender_FullName" HeaderText="Sender Full Name" SortExpression="Sender_FullName"
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Recipient_FullName" HeaderText="Recipient Full Name" SortExpression="Recipient_FullName"
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Service_Date" HeaderText="Service Date" SortExpression="Service_Date"
                                HeaderStyle-Wrap="false" DataFormatString="{0:d}" />
                            <asp:BoundField DataField="Cargo_Status" HeaderText="Cargo Status" SortExpression="Cargo_Status"
                                HeaderStyle-Wrap="false" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdn_CtrlNumber" runat="server" Value='<%# Eval("Ctr_Number")%>' />
                                    <asp:HiddenField ID="hdn_ServiceCharge" runat="server" Value='<%# Eval("Service_Charge")%>' />
                                    <asp:HiddenField ID="hdn_AgentCharge" runat="server" Value='<%# Eval("Agent_Charge")%>' />
                                    <asp:HiddenField ID="hdn_AgentCode" runat="server" Value='<%# Eval("Agent_Code")%>' />
                                    <asp:HiddenField ID="hdn_ServiceDate" runat="server" Value='<%# Eval("Service_Date")%>' />
                                    <asp:HiddenField ID="hdn_Notes" runat="server" Value='<%# Eval("Notes")%>' />
                                    <asp:HiddenField ID="hdn_SenderID" runat="server" Value='<%# Eval("Sender_ID")%>' />
                                    <asp:HiddenField ID="hdn_RecipientID" runat="server" Value='<%# Eval("Recipient_ID")%>' />
                                    <asp:HiddenField ID="hdn_IDNumber" runat="server" Value='<%# Eval("ID")%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <AlternatingRowStyle BackColor="#f1f1f1" />
                        <PagerStyle BackColor="#f1f1f1" HorizontalAlign="Center" CssClass="pagination" ForeColor="Black" />
                        <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last"
                            NextPageText=">" PreviousPageText="<" />
                    </asp:GridView>
                    <table width="900px">
                        <tr>
                            <td class="tblBorderAll">
                                Total:
                                <asp:Label ID="lbl_Total" runat="server" Text="0"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tblBorderAll">
                                Cargo Status: EXP = Exported cargo to csv file NXP = New cargo
                            </td>
                        </tr>
                        <tr>
                            <td class="tblBorderAll">
                                <asp:Button ID="btn_ExportCargotoExcel" runat="server" Text="Export To Execel" Style="cursor: pointer;
                                    background-image: url(/Images/Excel.gif)" CssClass="submitButtonWithImage" CausesValidation="false" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="grdViewCargoList" EventName="Sorting" />
                <asp:AsyncPostBackTrigger ControlID="btn_PrintViewCargo" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btn_FilterCargoList" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btn_SearchCargo" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btn_ExportCargotoExcel" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="grdViewCargoList" EventName="PageIndexChanging" />
            </Triggers>
        </asp:UpdatePanel>
        </div>

        <asp:UpdatePanel ID="updtPan_CargoPrintSchedule" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
               <asp:Panel ID="pan_ViewPrintSchedule" runat="server" Visible="false" style="background-color:#ffffff">
                <div id="div1" style="width:960px; background-color:#ffffff; margin-left:-14px;">
                 <table width="800px" style="background-color:#ffffff">
                    <tr>
                        <td class="FontHeader" align="left" valign="top">
                            Cargo Pickup Schedule List:
                            <asp:Label ID="lbl_MsgCargoPickupSched" runat="server" Text=""></asp:Label>
                        </td>
                        <td align="right">
                            <input id="btn_PrintCargo" type="button" value="Print" class="submitButtonWithImage"
                                onclick="PrintDiv('divPrintSchedulePickup')" style="background-image: url(/Images/PrintBtn.gif)" />
                            <%--<asp:Button ID="btn_PrintCargoSched" runat="server" Text="Print" CssClass="submitButtonWithImage"
                                                                            Style="background-image: url(/Images/PrintBtn.gif)" CausesValidation="false" />--%>
                        </td>
                    </tr>
                    <tr>
                    <td valign="top" colspan="2">
                        <asp:SqlDataSource ID="SqlDS_PrintViewSchedulePickup" runat="server" ConnectionString="<%$ ConnectionStrings:MJBCONN %>"
                            SelectCommand="Sp_Retrieve_From_Cargo_Schedule" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                        <div id="divPrintSchedulePickup" class="tblBorderAll" style="width:800px; background-color:#ffffff;">
                            <center>
                            <asp:Table ID="tbl_CargoHeaderPickUpList" runat="server" Width="700px" Visible="false">
                                <asp:TableRow>
                                    <asp:TableCell Width="350px" HorizontalAlign="Left">
                                        <asp:Label ID="lbl_Address" runat="server" Text="" Style="color: #000000"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right">
                                             <img src="Images/UMAC06212007.jpg" alt="" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell Width="350px" HorizontalAlign="Left">
                                        <asp:Label ID="lbl_SelectedDate" Style="font-weight: bold; color: #000000" runat="server"
                                            Text=""></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell Width="350px" HorizontalAlign="Right">
                                        <asp:Label ID="lbl_Location" Style="font-weight: bold; color: #000000" runat="server"
                                            Text=""></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                            <asp:GridView ID="grdViewSchedulePickupList" runat="server" AllowSorting="True"
                                AutoGenerateColumns="False" DataSourceID="SqlDS_PrintViewSchedulePickup"
                                HeaderStyle-CssClass="gridViewheader" HeaderStyle-HorizontalAlign="Center" GridLines="Horizontal"
                                RowStyle-HorizontalAlign="Center" Width="700px"
                                PagerStyle-VerticalAlign="Middle" CssClass="gridViewPrint">
                                <Columns>
                                    <asp:BoundField DataField="Trip_Number" HeaderText="Trip #:" SortExpression="Trip_Number"
                                        HeaderStyle-Wrap="false" ItemStyle-VerticalAlign="Top" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <table width="700px">
                                                <tr>
                                                    <td valign="top" align="left" width="350px">
                                                        <%# Eval("Sender_FullName")%>
                                                        <br />
                                                        <%# Eval("Sender_Add1")%><br />
                                                        <%# Eval("Sender_Add2")%>
                                                        <%# Eval("Sender_City")%>,
                                                        <%# Eval("Sender_State")%>
                                                        <%# Eval("Sender_Zip")%>
                                                    </td>
                                                    <td valign="top" align="left" width="350px">
                                                        <font class="FontTitle">Phone:</font>
                                                        <%# Eval("Sender_Phone")%><br />
                                                        <font class="FontTitle">Alt Phone:</font>
                                                        <%# Eval("Sender_AltPhone")%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="top" align="left" width="350px" style="padding-top:20px">
                                                        <font class="FontTitle">Cargo Notes:</font><br />
                                                        <asp:Label ID="lbl_CargoNotes" runat="server" Text='<%# Eval("Notes")%>'></asp:Label>
                                                    </td>
                                                    <td valign="top" align="left" width="350px" style="padding-top:20px">
                                                        <font class="FontTitle">Address Notes:</font><br />
                                                        <asp:Label ID="lbl_AddressNotes" runat="server" Text='<%# Eval("Sender_Address_Notes")%>'></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:ButtonField CommandName="ViewMaP" ButtonType="Image" ImageUrl="~/Images/Wheel.gif"
                                                                                    ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="View Direction" ItemStyle-VerticalAlign="Top" />--%>
                                </Columns>
                                <AlternatingRowStyle BackColor="#f1f1f1" />
                              </asp:GridView>
                              <table width="800px">
                                    <tr>
                                        <td align="left" class="tblBorderAll" valign="top" style="height: 10px" colspan="2">
                                            Total:
                                            <asp:Label ID="lbl_TotalCargoSched" runat="server" Text="0"></asp:Label>
                                        </td>
                                    </tr>
                              </table>
                            </center>
                        </div>
                    </td>
                </tr>
           </table>
           </div>
        </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>

        <div id="blanket1" style="display: none">
        </div>
        <div id="popUpDivViewPrintPickupSched" style="display: none; z-index: 9012; position: fixed;">
            <asp:Panel ID="pan_ViewPrintPickupSched" Width="800px" runat="server" CssClass="FrameBorderGridBG1">
                <asp:UpdatePanel ID="updtPan_ViewPrintPickupSched" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div style="z-index: 9013; position: fixed; top: 45px; margin-top: 45px;">
                            <asp:Panel ID="pan_HeadTitlePrintPickupSched" runat="server" Width="800px" Style="position: fixed;
                                background-color: transparent">
                                <table width="820px" style="background-color: Transparent">
                                    <tr>
                                        <td align="left" valign="bottom" style="padding-left: 10px" class="FontHeader">
                                            Cargo Pickup Schedule
                                        </td>
                                        <td align="right" valign="top">
                                            <input id="btn_CloseCargoSchedule" type="button" style="background-image: url(../Images/Xclose.png);
                                                background-repeat: no-repeat; cursor: pointer; background-color: Transparent;
                                                border: none; width: 32px; height: 32px" onclick="popup('popUpDivViewPrintPickupSched','','100','blanket1','800')" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                        <asp:Panel ID="pan_CargoPickUpSchedule" Width="790px" ScrollBars="None" runat="server"
                            Style="padding: 20px 10px 10px 20px; text-align: center; vertical-align: top;">
                            <table style="background-color: #ffffff; height: 290px" width="770px" cellspacing="0"
                                cellpadding="0">
                                <tr>
                                    <td valign="top">
                                        <table style="background-color: #ffffff;" width="770px" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td valign="middle" align="left" style="background-color: #f1f1f1; padding: 5px 5px 5px 5px">
                                                    Select Date:
                                                    <ucCal:ucCalendar runat="server" ID="UcCalendarSelectDateCargoPickupDate"></ucCal:ucCalendar>
                                                    <asp:Button ID="btn_EditCargoSched" runat="server" Text="Edit Trip" CausesValidation="false"
                                                        Style="cursor: pointer; background-image: url(/Images/EditSmall.gif)" CssClass="submitButtonWithImage" />
                                                </td>
                                                <td valign="middle" align="left" style="background-color: #f1f1f1; padding: 5px 5px 5px 5px">
                                                    Select Location:
                                                    <asp:DropDownList ID="drp_SelectLocation" runat="server" CssClass="drpDownAutoMedium">
                                                    </asp:DropDownList>
                                                    <asp:Button ID="btn_PrintViewCargoSched" runat="server" Text="Print View" CausesValidation="false"
                                                        Style="cursor: pointer; background-image: url(/Images/PaperView.gif)" CssClass="submitButtonWithImage" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center" style="background-color: #ffffff;">
                                                    <asp:Panel ID="pan_UpdateCargoSchedule" runat="server" Width="770px" ScrollBars="Auto"
                                                        Height="400px" Visible="false">
                                                        <table width="700px">
                                                            <tr>
                                                                <td class="FontHeader" align="left" valign="top">
                                                                    Cargo Pickup Schedule Trip Edit:
                                                                    <asp:Label ID="lbl_MsgCargoEdit" runat="server" Text=""></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td valign="top" align="center" style="height: 350px">
                                                                    <asp:SqlDataSource ID="SqlDS_UpdateCargoSchedule" runat="server" ConnectionString="<%$ ConnectionStrings:MJBCONN %>"
                                                                        SelectCommand="Sp_Retrieve_From_Cargo_Schedule" SelectCommandType="StoredProcedure">
                                                                    </asp:SqlDataSource>
                                                                    <asp:GridView ID="grdViewUpdateCargoSchedlue" runat="server" AllowPaging="false"
                                                                        AllowSorting="false" AutoGenerateColumns="False" PageSize="20" DataSourceID="SqlDS_UpdateCargoSchedule"
                                                                        HeaderStyle-CssClass="gridViewheader" HeaderStyle-HorizontalAlign="Center" GridLines="Horizontal"
                                                                        RowStyle-HorizontalAlign="Center" Width="700px" PagerStyle-HorizontalAlign="Center"
                                                                        PagerStyle-VerticalAlign="Middle" CssClass="gridView" DataKeyNames="ID">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="Trip_Number" HeaderText="Trip #:" SortExpression="Trip_Number"
                                                                                HeaderStyle-Wrap="false" ItemStyle-VerticalAlign="Top" />
                                                                            <asp:TemplateField HeaderText="Sender Info">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbl_SenderFullName" runat="server" Text='<%# Eval("Sender_FullName")%>'></asp:Label>
                                                                                    <asp:Label ID="lbl_SenderAddress" runat="server" Text='<%# Eval("Sender_Add1") & "<br/>" & Eval("Sender_City") & " " & Eval("Sender_State") & "," & Eval("Sender_Zip")%>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txt_CargoNotes" runat="server" Text='<%# Eval("Notes")%>' CssClass="textEntryMedium"
                                                                                        Width="220px" TextMode="MultiLine" ReadOnly="true" Rows="3"></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="Entered_By" HeaderText="Entered By" SortExpression="Entered_By"
                                                                                HeaderStyle-Wrap="false" ItemStyle-VerticalAlign="Top" />
                                                                            <asp:ButtonField CommandName="MoveUp" ButtonType="Image" ImageUrl="~/Images/MoveUp.gif"
                                                                                ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="Up" ItemStyle-VerticalAlign="Top" />
                                                                            <asp:ButtonField CommandName="MoveDown" ButtonType="Image" ImageUrl="~/Images/MoveDown.gif"
                                                                                ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="Down" ItemStyle-VerticalAlign="Top" />
                                                                        </Columns>
                                                                        <AlternatingRowStyle BackColor="#f1f1f1" />
                                                                        <PagerStyle BackColor="#f1f1f1" HorizontalAlign="Center" CssClass="pagination" ForeColor="Black" />
                                                                        <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last"
                                                                            NextPageText=">" PreviousPageText="<" />
                                                                    </asp:GridView>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left" class="tblBorderAll" valign="top" style="height: 10px">
                                                                    Total:
                                                                    <asp:Label ID="lbl_TotalCargoPickupUpdate" runat="server" Text="0"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btn_PrintViewCargo" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btn_EditCargoSched" EventName="Click" />
                        <%--<asp:AsyncPostBackTrigger ControlID="btn_PrintViewCargoSched" EventName="Click" />--%>
                        <asp:AsyncPostBackTrigger ControlID="grdViewSchedulePickupList" EventName="RowCommand" />
                        <asp:AsyncPostBackTrigger ControlID="grdViewUpdateCargoSchedlue" EventName="RowCommand" />
                    </Triggers>
                </asp:UpdatePanel>
            </asp:Panel>
        </div>
        <div id="blanket" style="display: none">
        </div>
        <div id="popUpDivCargoEdit" style="display: none; z-index: 9012; position: fixed">
            <asp:Panel ID="pan_CargoEdit" Width="500px" runat="server" CssClass="FrameBorderGridBG1">
                <asp:UpdatePanel ID="updtPan_CargoEdit" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div style="z-index: 9013; position: fixed; top: 95px; margin-top: 95px">
                            <asp:Panel ID="pan_HeadTitle" runat="server" Width="500px" Style="position: fixed;
                                background-color: transparent">
                                <table width="520px" style="background-color: Transparent">
                                    <tr>
                                        <td align="left" valign="bottom" style="padding-left: 10px" class="FontHeader">
                                            <asp:Label ID="lbl_HeaderCargo" runat="server" Text="Cargo" CssClass="FontHeader"></asp:Label>
                                            <asp:Label ID="lbl_ServiceID" runat="server" Text="" Visible="false"></asp:Label>
                                        </td>
                                        <td align="right" valign="top">
                                            <input id="btn_Close" type="button" style="background-image: url(../Images/Xclose.png);
                                                background-repeat: no-repeat; cursor: pointer; background-color: Transparent;
                                                border: none; width: 32px; height: 32px" onclick="popup('popUpDivCargoEdit','','200','blanket','500')" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                        <asp:Panel ID="pan_CargoAddUpdate" Width="490px" runat="server" Style="padding: 30px 10px 10px 10px;
                            text-align: center">
                            <table style="background-color: #ffffff; padding-left: 10px;" width="480px">
                                <tr>
                                    <td align="left">
                                        Sender Name:
                                    </td>
                                    <td align="left">
                                        Recipient Name:
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:TextBox ID="txt_SenderName" runat="server" ReadOnly="true" MaxLength="25" CssClass="textEntryMedium"></asp:TextBox>
                                        <asp:HiddenField ID="hdn_SenderID" runat="server" />
                                        <asp:HiddenField ID="hdn_RecipientID" runat="server" />
                                        <asp:HiddenField ID="hdn_IDNum" runat="server" />
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="drp_RecipientName" runat="server" CssClass="drpDownAutoMedium">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                            ToolTip="Required!" Display="Dynamic" ControlToValidate="drp_RecipientName"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Ctrl Number:
                                    </td>
                                    <td align="left">
                                        Box Number:
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:TextBox ID="txt_CtrlNumber" runat="server" CssClass="textEntryMedium" MaxLength="12"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                            SetFocusOnError="true" CssClass="ErrMsg" ToolTip="Required!" Display="Dynamic"
                                            ControlToValidate="txt_CtrlNumber"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txt_BoxNumber" runat="server" CssClass="textEntryMedium" MaxLength="12"
                                            Text="WNW"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                                            SetFocusOnError="true" CssClass="ErrMsg" ToolTip="Required!" Display="Dynamic"
                                            ControlToValidate="txt_BoxNumber"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                        Service Charge $:
                                    </td>
                                    <%-- <td align="left">
                                        Agent Charge $:
                                    </td>--%>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                        <asp:TextBox ID="txt_ServiceCharge" runat="server" CssClass="textEntryMedium" MaxLength="10"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="ErrMsg"
                                            SetFocusOnError="true" ErrorMessage="*" ToolTip="Required!" ControlToValidate="txt_ServiceCharge"
                                            Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_ServiceCharge"
                                            CssClass="ErrMsg" SetFocusOnError="true" ValidationExpression="([0-9]+\.[0-9]*)|([0-9]*\.[0-9]+)|([0-9]+)"
                                            ErrorMessage="*" ToolTip="Numeric Value Required!" Display="Dynamic"></asp:RegularExpressionValidator>
                                    </td>
                                    <%-- <td align="left">
                                        <asp:TextBox ID="txt_AgentCharge" runat="server" CssClass="textEntryMedium" MaxLength="10"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txt_AgentCharge"
                                            CssClass="ErrMsg" SetFocusOnError="true" ValidationExpression="([0-9]+\.[0-9]*)|([0-9]*\.[0-9]+)|([0-9]+)"
                                            ErrorMessage="*" ToolTip="Numeric Value Required!" Display="Dynamic"></asp:RegularExpressionValidator>
                                    </td>--%>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Agent Code:
                                    </td>
                                    <td align="left">
                                        Service Date:
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:TextBox ID="txt_AgentCode" runat="server" CssClass="textEntryMedium"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" CssClass="ErrMsg"
                                            SetFocusOnError="true" ErrorMessage="*" ToolTip="Required!" ControlToValidate="txt_AgentCode"
                                            Display="Dynamic"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left">
                                        <ucREQCal:ucREQCalendar runat="server" ID="ucServiceDate"></ucREQCal:ucREQCalendar>
                                    </td>
                                </tr>
                              <%--  <tr>
                                    <td colspan="2" align="left">
                                        Notes:
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="left">
                                        <asp:Panel ID="pan_Notes" runat="server" ScrollBars="Vertical" Height="60px" Width="440px"
                                            CssClass="tblBorderAll">
                                            <asp:Label ID="lbl_Notes" runat="server" Text=""></asp:Label>
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
                                        <asp:TextBox ID="txt_NewNotes" runat="server" Width="440px" TextMode="MultiLine"
                                            Rows="3"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center" style="padding-top: 5px">
                                        <asp:Button ID="btn_DeleteCargo" runat="server" Text="Delete" CssClass="submitButtonWithImage60"
                                            Style="background-image: url(/Images/Cancel.gif)" />
                                        <asp:Button ID="btn_AddUpdateCargo" runat="server" Text="Update" CssClass="submitButtonWithImage60"
                                            Style="background-image: url(/Images/Add.gif)" />
                                        <br />
                                        <asp:Label ID="lbl_MsgCargo" runat="server" Text="" CssClass="ErrMsg"></asp:Label>
                                        <asp:ConfirmButtonExtender ID="ConfirmExt_DeleteCargo" runat="server" ConfirmOnFormSubmit="true"
                                            ConfirmText="" TargetControlID="btn_DeleteCargo">
                                        </asp:ConfirmButtonExtender>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <div id="div_MsgConfirmOK" style="visibility: hidden; position: fixed; margin-top: 103px;
                            top: 103px; text-align: center; padding: 10px">
                            <table style="background-color: #ffffff; height: 300px" width="480px">
                                <tr>
                                    <td>
                                        <asp:Label ID="lbl_ConfirmMessageOK" runat="server" Text="" CssClass="ErrMsg"></asp:Label>
                                        <p>
                                            <asp:Button ID="btn_ConfirmOK" runat="server" Text="Done" CssClass="submitButtonWithImage60"
                                                CausesValidation="false" Style="background-image: url(/Images/Check.gif)" />
                                            <asp:Button ID="btn_AddMore" runat="server" Text="Add More" CssClass="submitButtonWithImage80"
                                                CausesValidation="false" Style="background-image: url(/Images/BoxSmall.gif)" />
                                        </p>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="grdViewCargoList" EventName="SelectedIndexChanging" />
                        <asp:AsyncPostBackTrigger ControlID="btn_AddUpdateCargo" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btn_ConfirmOK" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btn_PrintViewCargo" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </asp:Panel>
        </div>
        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="updtPan_CargoList">
            <ProgressTemplate>
                <div id="blanketProg1">
                </div>
                <div id="popUpDivProgress" style="z-index: 9075; position: absolute; top: 50%; left: 50%;
                    margin: -100px 0 0 -200px; height: 200px; width: 400px">
                    <asp:Image ID="img_Loader" runat="server" ImageUrl="../Images/ajax-loaderSmallOrange.gif" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </center>
</asp:Content>
