<%@ page language="VB" autoeventwireup="false" inherits="Reports_ShowReportCrystal, App_Web_showreportcrystal.aspx.dfa151d5" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <CR:CrystalReportViewer ID="CrView" runat="server" AutoDataBind="true" HasCrystalLogo="False"
            HasDrillUpButton="False" HasSearchButton="False" HasToggleGroupTreeButton="true"
            PrintMode="ActiveX" />
        <asp:GridView ID="Grview" runat="server" Visible="false" Height="240px" PageSize="15"
            Width="960px">
            <PagerSettings FirstPageImageUrl="~/Images/navigate_left2.ico" FirstPageText="First"
                LastPageImageUrl="~/Images/navigate_right2.ico" LastPageText="Last" Mode="NextPreviousFirstLast"
                NextPageImageUrl="~/Images/navigate_right.ico" NextPageText="Next" PreviousPageImageUrl="~/Images/navigate_left.ico"
                PreviousPageText="Back" />
        </asp:GridView>
        <asp:Label ID="LblHeader" runat="server" Visible="False"></asp:Label><br />
        <asp:Label ID="LblHead2" runat="server" Visible="False"></asp:Label><br />
        <asp:Label ID="LblMember" runat="server" Visible="False"></asp:Label><br />
        <asp:Label ID="LblPath" runat="server" Visible="False"></asp:Label>
    </div>
    </form>
</body>
</html>
