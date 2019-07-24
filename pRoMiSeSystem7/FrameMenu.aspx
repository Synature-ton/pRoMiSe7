<%@ page language="VB" autoeventwireup="false" inherits="FrameMenu, App_Web_framemenu.aspx.cdcab7d2" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Menu</title>
    <link href="StyleSheet/adminMenu.css" rel="stylesheet" type="text/css" />
</head>
<body text="#ccffcc" vlink="white" alink="#ffcc00" link="white" bgcolor="#507093"
    style="margin-top: 0px; margin-right: 0px;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table width="100%" border="0">
        <tr>
            <td align="center" width="50%">
                <asp:HyperLink ID="Text_HomeParam" runat="server" Target="Content" NavigateUrl="Admin_Main.aspx"
                    Font-Underline="False">[Text_HomeParam]</asp:HyperLink>
            </td>
            <td align="center" width="50%">
                <asp:HyperLink ID="Text_LogoutParam" runat="server" Target="_top" NavigateUrl="Logout.aspx"
                    Font-Underline="False"></asp:HyperLink>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <hr width="100%" color="#ffffff" size="0" />
            </td>
        </tr>
       <%-- <tr>
            <td colspan="2">
                <label class="text2">
                    Login By :</label>
                <span id="StaffCode" runat="server" class="text2"></span>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <label class="text2">
                    UserName :</label>
                <span id="StaffName" runat="server" class="text2"></span>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <hr width="100%" color="#ffffff" size="0" />
            </td>
        </tr>--%>
    </table>
    <div>
        <telerik:RadTreeView ID="RadTreeView1" runat="server" DataFieldID="PermissionGroupID" ForeColor="#FFCCFFCC">
            <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
            <ExpandAnimation Duration="100" type="InQuad"></ExpandAnimation>
        </telerik:RadTreeView>
    </div>
    </form>
</body>
</html>
