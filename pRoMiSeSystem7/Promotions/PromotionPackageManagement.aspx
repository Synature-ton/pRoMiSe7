<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PromotionPackageManagement.aspx.vb" Inherits="POSPromotionSettings.PromotionPackageManagement" %>

<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
    <title>Promotion Setting</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />

    <script language="JavaScript" src="../StyleSheet/webscript.js"></script>

</head>
<body>
    <form id="form1" runat="server">
    <table bgcolor="White" cellpadding="0" cellspacing="0">
        <tr style="background-color: #EEEEEE">
            <td height="35" style="background-image: url('../images/headerstub.jpg')">
                &nbsp; &nbsp;
            </td>
            <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                <div>
                    <asp:Label ID="lh" runat="server" Text="Member's Promotion Set Setting" CssClass="headerText"></asp:Label>
                </div>
            </td>
            <td rowspan="99" style="background-color: #003366; width: 1px;">
                <img src="../images/clear.gif" height="1px" width="1px">
            </td>
        </tr>
        <tr style="background-color: #666666">
            <td width="3%" height="1">
            </td>
            <td width="94%">
            </td>
            <td width="3%">
            </td>
        </tr>
        <tr>
            <td height="10" colspan="3">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <table style="width: 100%;" >
                    <tr>
                        <td>
                            <asp:LinkButton ID="LbtnAddPromotion" runat="server" PostBackUrl="~/Promotions/PromotionPackage_Edit.aspx?Action=1">New Promotion Set</asp:LinkButton>
                        </td>
                        <td align="right">
                            <asp:DropDownList ID="DDLActivated" runat="server" AutoPostBack="True">
                                <asp:ListItem Value="-1">Show All Promotion Set</asp:ListItem>
                                <asp:ListItem Value="1" Selected="True">Enable Promotion Set</asp:ListItem>
                                <asp:ListItem Value="0">Disable Promotion Set</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <table class="blue">
                    <thead>
                        <tr>
                            <th style="width: 5%;">
                                <asp:Label ID="lblStatus" runat="server" Text="Status"></asp:Label>
                            </th>
                            <th style="width: 10%;">
                                <asp:Label ID="lblActivated" runat="server" Text="Activated"></asp:Label>
                            </th>
                            <th>
                                <asp:Label ID="lblPromotionName" runat="server" Text="Promotion"></asp:Label>
                            </th>
                            <th style="width: 35%;">
                                <asp:Label ID="lblDescription" runat="server" Text="Description"></asp:Label>
                            </th>
                            <th style="width: 5%;">
                                <asp:Label ID="lblEdit" runat="server" Text="Edit"></asp:Label>
                            </th>
                            <th style="width: 5%;">
                                <asp:Label ID="lblDelete" runat="server" Text="Del"></asp:Label>
                            </th>
                        </tr>
                    </thead>
                    <asp:Label ID="OutputStringData" runat="server"></asp:Label>
                </table>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3" height="30">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background-color: #999999; height: 1px;">
            </td>
        </tr>
        <tr>
            <td height="50" colspan="3" style="background-image: url('../images/footerbg2000.gif')">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background-color: #999999; height: 1px;">
            </td>
        </tr>
    </table>
    </form>
</body>

</html>
