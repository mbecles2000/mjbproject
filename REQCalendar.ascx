<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="REQCalendar.ascx.vb" Inherits="MJBUMAC1.REQCalendar" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
<asp:TextBox ID="txt_Date" runat="server" CssClass="textEntrySmall"></asp:TextBox>
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" CssClass="ErrMsg" ToolTip="Required!" ControlToValidate="txt_Date"></asp:RequiredFieldValidator>
<asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txt_Date" CssClass="CalendarCSS">
</asp:CalendarExtender>