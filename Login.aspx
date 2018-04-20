<%@ Page Title="MJBUMAC: Login" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master"
    CodeBehind="Login.aspx.vb" Inherits="MJBUMAC1.Login1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    

    <script type="text/javascript" language="javascript">

        $(document).ready(function () {
           
            $('#<%=btn_Login.ClientID%>').click(function () {
                $('html,body').css('cursor', 'wait');
                $('#<%=lbl_LoginMsg.ClientID%>').value = "";
                $('#<%=btn_Login.ClientID%>').css('cursor', 'wait');
            });
        })

        function ResetCursor() {
            $('html,body').css('cursor', 'pointer');
            $('#<%=btn_Login.ClientID%>').css('cursor', 'pointer');
        }

   </script>

   <%--  <div id="divMenuSelected" style="position:fixed; margin-top:-20px; margin-left:205px;z-index:20000">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/PointerWhite.gif" />
     </div>--%>
      
    <div id="divLogin">
        <h2>
            Login
        </h2>
        <center>
            <asp:Panel ID="pan_Login" runat="server" DefaultButton="btn_Login">
                <asp:Table ID="tbl_Login" runat="server" Width="500px">
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Center" CssClass="tblBorderAllShadow" Style="padding: 20px 40px 20px 40px">
                            <p>
                                User ID:<br />
                                <asp:TextBox ID="txt_UserID" runat="server" CssClass="textLogin" MaxLength="10"></asp:TextBox>
                            </p>
                            <p>
                                Company ID:<br />
                                <asp:TextBox ID="txt_CompanyID" runat="server" CssClass="textLogin" MaxLength="10"></asp:TextBox>
                            </p>
                            <p>
                                Password:<br />
                                <asp:TextBox ID="txt_Password" runat="server" CssClass="textLogin" TextMode="Password"
                                    MaxLength="30"></asp:TextBox>
                            </p>
                            <p>
                                <asp:Button ID="btn_Login" runat="server" Text="Login" CssClass="submitButtonWithImage"
                                    Style="cursor: pointer; background-image: url(/Images/Locked.gif)" />
                            </p>
                            <p>
                                <asp:Label ID="lbl_LoginMsg" runat="server" Text="Label" CssClass="lblMessage"></asp:Label>
                            </p>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
        </center>
    </div>
</asp:Content>
