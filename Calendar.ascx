<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Calendar.ascx.vb" Inherits="MJBUMAC1.Calendar" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
<asp:TextBox ID="txt_Date" runat="server" CssClass="textEntrySmall"></asp:TextBox>
<asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txt_Date" CssClass="CalendarCSS">
</asp:CalendarExtender>
