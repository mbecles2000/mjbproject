<%@ Page Title="MJBUMAC: Company Update" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master"
    CodeBehind="CompanyUpdate.aspx.vb" Inherits="MJBUMAC1.CompanyUpdate" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script language="javascript" type="text/javascript">
        /*Update Company List*/
        
        function ConfirmMessageShow() {
            $('#div_MsgConfirmDelete').css('visibility', 'hidden');
            $('#<%=pan_ServiceListInfo.ClientID%>').css('visibility', 'hidden');
            $('#div_MsgConfirmOK').css('visibility', 'visible');
        }

        function HideHtmlButton(objBtnID) {
            document.getElementById(objBtnID).disabled = true;
        }

        $(document).ready(function () {
            
            try{
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
            $('#<%=btn_AddNewServiceList.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_AddUpdate.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_ConfirmOK.ClientID%>').css('cursor', 'pointer');
            $('#<%=btn_DeleteService.ClientID%>').css('cursor', 'pointer');
            $('#btn_Close').css('cursor', 'pointer');
        }
                      
    </script>
    <h2>
        Company Updates
    </h2>
    <center>
        <asp:SqlDataSource ID="SqlDS_ServiceList" runat="server" ConnectionString="<%$ ConnectionStrings:MJBCONN %>"
            SelectCommand="Sp_Retrieve_Service_Type_List" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>

       <%--  <div id="divMenuSelected" style="position:fixed; margin-top:-42px; margin-left:60px;z-index:20000">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/PointerWhite.gif" />
         </div>
--%>
        <asp:UpdatePanel ID="updtPan_GrdviewServiceTypeList" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <table class="tblBorderHeader" width="400px" cellpadding="2" cellspacing="2">
                    <tr>
                        <td valign="middle" align="left" class="FontHeader">
                            Service List
                        </td>
                        <td valign="middle" align="right">
                            <asp:Button ID="btn_AddNewServiceList" runat="server" Text="Add New" CausesValidation="false"  CssClass="submitButtonWithImage" style="background-image:url(/Images/Add.gif)" />
                        </td>
                    </tr>
                </table>
                <asp:GridView ID="grdViewServiceTypeList" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" DataSourceID="SqlDS_ServiceList" HeaderStyle-CssClass="gridViewheader"
                    HeaderStyle-HorizontalAlign="Center" PageSize="10" GridLines="Horizontal" RowStyle-HorizontalAlign="Center"
                    Width="400px" PagerStyle-HorizontalAlign="Center" DataKeyNames="ID_Num" PagerStyle-VerticalAlign="Middle"
                    CssClass="gridView">
                    <Columns>
                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/Gear.gif" SelectText=""
                            ControlStyle-CssClass="submitButtonNoBordeAuto" HeaderText="Edit" ShowSelectButton="True" />
                        <asp:BoundField DataField="Service_Type" HeaderText="Service Type" SortExpression="Service_Type"
                            HeaderStyle-Wrap="false" />
                        <asp:BoundField DataField="Service_Desc" HeaderText="Service Desc" SortExpression="Service_Desc"
                            HeaderStyle-Wrap="false" />
                        <asp:BoundField DataField="Service_Charge" HeaderText="Service Charge" SortExpression="Service_Charge"
                            DataFormatString="{0:F}" HeaderStyle-Wrap="false" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HiddenField ID="hdn_ServiceType" runat="server" Value='<%# Eval("Service_Type")%>' />
                                <asp:HiddenField ID="hdn_ServiceDesc" runat="server" Value='<%# Eval("Service_Desc")%>' />
                                <asp:HiddenField ID="hdn_ServiceCharge" runat="server" Value='<%# FormatNumber(Eval("Service_Charge"),2)%>' />
                                <asp:HiddenField ID="hdn_IDNum" runat="server" Value='<%# Eval("ID_Num")%>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#f1f1f1" />
                    <PagerStyle BackColor="#f1f1f1" HorizontalAlign="Center" CssClass="pagination" ForeColor="Black" />
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="grdViewServiceTypeList" EventName="Sorting" />
                <asp:AsyncPostBackTrigger ControlID="btn_AddNewServiceList" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="grdViewServiceTypeList" EventName="PageIndexChanging" />
            </Triggers>
        </asp:UpdatePanel>
        <div id="blanket" style="display: none">
        </div>
        <div id="popUpDivServiceList" style="display: none; z-index: 9012; position: fixed">
            <asp:Panel ID="pan_ServiceList" Width="500px" runat="server" CssClass="FrameBorderGridBG1">
                <asp:UpdatePanel ID="updtPan_ServiceList" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div style="z-index: 9013; position: fixed; top: 95px; margin-top: 95px">
                            <asp:Panel ID="pan_HeadTitle" runat="server" Width="500px" Style="position: fixed;
                                background-color: transparent">
                                <table width="520px" style="background-color: Transparent">
                                    <tr>
                                        <td align="right" valign="top">
                                            <input id="btn_Close" type="button" style="background-image: url(../Images/Xclose.png);
                                                background-repeat: no-repeat; cursor: pointer; background-color: Transparent;
                                                border: none; width: 32px; height: 32px" onclick="popup('popUpDivServiceList','','200','blanket','500')" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" valign="bottom" style="padding-left: 10px">
                                            <asp:Label ID="lbl_ServiceID" runat="server" Text="" CssClass="FontBold" Visible="false"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                        <asp:Panel ID="pan_ServiceListInfo" Width="480px" runat="server" Style="padding: 10px 10px 10px 10px">
                            <table style="background-color: #ffffff; height: 200px" width="480px">
                                <tr>
                                    <td align="center">
                                        Service Type Code:<br />
                                        (no none alphanumeric character)<br />
                                        <asp:TextBox ID="txt_ServTypeCode" runat="server" MaxLength="3" CssClass="textEntrySmall"
                                            Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="ErrMsg"
                                            SetFocusOnError="true" ErrorMessage="*" ToolTip="Required!" ControlToValidate="txt_ServTypeCode"
                                            Display="Dynamic"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        Service Desc:<br />
                                        <asp:TextBox ID="txt_ServDesc" runat="server" MaxLength="50" CssClass="textEntry"
                                            Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="ErrMsg"
                                            SetFocusOnError="true" ErrorMessage="*" ToolTip="Required!" ControlToValidate="txt_ServDesc"
                                            Display="Dynamic"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        Service Charge:<br />
                                        <asp:TextBox ID="txt_ServCharge" runat="server" MaxLength="8" CssClass="textEntrySmall"
                                            Style="text-align: right" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="ErrMsg"
                                            SetFocusOnError="true" ErrorMessage="*" ToolTip="Required!" ControlToValidate="txt_ServCharge"
                                            Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_ServCharge"
                                            CssClass="ErrMsg" SetFocusOnError="true" ValidationExpression="([0-9]+\.[0-9]*)|([0-9]*\.[0-9]+)|([0-9]+)"
                                            ErrorMessage="*" ToolTip="Numeric Value Required!" Display="Dynamic"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <asp:Button ID="btn_DeleteService" runat="server" Text="Delete"  CssClass="submitButtonWithImage80" style="background-image:url(/Images/RedXSmall.gif)"
                                                            CausesValidation="false"/>
                                        <asp:Button ID="btn_AddUpdate" runat="server" Text="Add/Update" CssClass="submitButtonWithImage80" style="background-image:url(/Images/Add.gif)" />
                                       <br />
                                       <asp:Label ID="lbl_MsgAddUpdateServiceList" runat="server" Text="" CssClass="ErrMsg"></asp:Label>
                                        <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmOnFormSubmit="true"
                                                            ConfirmText="Are you sure you want to delete now?" TargetControlID="btn_DeleteService">
                                                        </asp:ConfirmButtonExtender>

                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                     
                        <div id="div_MsgConfirmOK" style="visibility: hidden; position: fixed; margin-top: 103px;
                            top: 103px; text-align: center; padding: 10px">
                            <table style="background-color: #ffffff; height: 202px" width="480px">
                                <tr>
                                    <td>
                                        <asp:Label ID="lbl_ConfirmMessageOK" runat="server" Text="" CssClass="ErrMsg"></asp:Label>
                                        <br />
                                        <asp:Button ID="btn_ConfirmOK" runat="server" Text="OK" CausesValidation="false" CssClass="submitButtonWithImage60" style="background-image:url(/Images/Check.gif)" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="grdViewServiceTypeList" EventName="SelectedIndexChanging" />
                        <asp:AsyncPostBackTrigger ControlID="btn_AddUpdate" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btn_DeleteService" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btn_ConfirmOK" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </asp:Panel>
        </div>
    </center>
</asp:Content>
