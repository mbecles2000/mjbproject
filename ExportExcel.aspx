<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ExportExcel.aspx.vb" Inherits="MJBUMAC1.ExportExcel" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Export To CSV</title>
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-color:#ffffff">
    <form id="form1" runat="server">
    <div>
        <asp:Button ID="btn_ExportCargotoExcel" runat="server" Text="Export To Execel" Style="cursor: pointer;
            background-image: url(/Images/Excel.gif)" CssClass="submitButtonWithImage" CausesValidation="false" />
        <table class="tblBorderAll" style="background-color:#ffffff">
            <tr>
                <td>
                    <asp:SqlDataSource ID="SqlDS_CargoList" runat="server" ConnectionString="<%$ ConnectionStrings:MJBCONN %>"
                        SelectCommand="Sp_Retrieve_Cargo_Transaction_List_N" SelectCommandType="StoredProcedure">
                    </asp:SqlDataSource>
                    <asp:GridView ID="grdViewCargoList" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDS_CargoList" HeaderStyle-CssClass="gridViewheader"
                        HeaderStyle-HorizontalAlign="Center" GridLines="Horizontal" RowStyle-HorizontalAlign="Center"
                        Width="800px" PagerStyle-HorizontalAlign="Center" DataKeyNames="Box_Number" PagerStyle-VerticalAlign="Middle" 
                        CssClass="gridView">
                        <Columns>
                            <asp:BoundField DataField="Box_Number" HeaderText="Box Number" SortExpression="Box_Number" NullDisplayText=" "
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Sender_FName" HeaderText="Sender First Name" SortExpression="Sender_FName" NullDisplayText=" "
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Sender_LName" HeaderText="Sender Last Name" SortExpression="Sender_LName" NullDisplayText=" "
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Sender_Add1" HeaderText="Sender Address" SortExpression="Sender_Add1" NullDisplayText=" "
                                HeaderStyle-Wrap="false" />
                             <asp:BoundField DataField="Sender_City" HeaderText="Sender City" SortExpression="Sender_City" NullDisplayText=" "
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Sender_State" HeaderText="Sender State" SortExpression="Sender_State" NullDisplayText=" "
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Sender_Zip" HeaderText="Sender Zip" SortExpression="Sender_Zip" NullDisplayText=" "
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Sender_Phone" HeaderText="Sender Phone" SortExpression="Sender_Phone" NullDisplayText=" "
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Recipient_FName" HeaderText="Recipient First Name" SortExpression="Recipient_FName" NullDisplayText=" "
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Recipient_LName" HeaderText="Recipient Last Name" SortExpression="Recipient_LName" NullDisplayText=" "
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Recipient_Add1" HeaderText="Recipient Add1" SortExpression="Recipient_Add1" NullDisplayText=" "
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Recipient_Add2" HeaderText="Recipient Add2" SortExpression="Recipient_Add2" NullDisplayText=" "
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Recipient_City" HeaderText="Recipient City" SortExpression="Recipient_City" NullDisplayText=" "
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Recipient_State" HeaderText="Recipient State/Province" NullDisplayText=" "
                                SortExpression="Recipient_State" HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Recipient_Phone" HeaderText="Recipient Phone" SortExpression="Recipient_Phone" NullDisplayText=" "
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Service_Date" HeaderText="Service Date" SortExpression="Service_Date" NullDisplayText=" "
                                HeaderStyle-Wrap="false" DataFormatString="{0:d}" />
                            <asp:BoundField DataField="Service_Charge" HeaderText="Service Charge" SortExpression="Service_Charge" NullDisplayText=" "
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Agent_Charge" HeaderText="Agent Charge" SortExpression="Agent_Charge" NullDisplayText=" "
                                HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Agent_Code" HeaderText="Agent Code" SortExpression="Agent_Code" NullDisplayText=" "
                                HeaderStyle-Wrap="false" />
                        </Columns>
                        <AlternatingRowStyle BackColor="#f1f1f1" />
                        <%--<PagerStyle BackColor="#f1f1f1" HorizontalAlign="Center" CssClass="pagination" ForeColor="Black" />
                        <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last"
                            NextPageText=">" PreviousPageText="<" />--%>
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
