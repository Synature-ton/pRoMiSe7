<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Promotion_Level.aspx.vb"
    Inherits="POSPromotionSettings.Promotion_Level" %>

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
                    <asp:Label ID="lh" runat="server" Text="Promotion Setting" CssClass="headerText"></asp:Label></div>
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
                <table style="width: 100%;">
                    <tr>
                        <td>
                            <asp:LinkButton ID="LbtBackToHomePage" runat="server" PostBackUrl="~/Promotions/promotion_setup.aspx">Home Page</asp:LinkButton> &nbsp;|&nbsp;
                            <asp:LinkButton ID="LbtnAddPromotion" runat="server">New Promotion</asp:LinkButton>
                        </td>
                    </tr>
                </table>
                <table class="blue">
                    <thead>
                        <tr>
                            <th style="width: 5%;">
                                <asp:Label ID="lbh1" runat="server" Text="Status"></asp:Label>
                            </th>
                            <th style="width: 5%;">
                                <asp:Label ID="lbh2" runat="server" Text="Activated"></asp:Label>
                            </th>
                            <th>
                                <asp:Label ID="lbh3" runat="server" Text="Promotion"></asp:Label>
                            </th>
                            <th style="width: 10%;">
                                <asp:Label ID="lbh4" runat="server" Text="More"></asp:Label>
                            </th>
                            <th style="width: 10%;">
                                <asp:Label ID="lbh5" runat="server" Text="Less than / equal."></asp:Label>
                            </th>
                            <th style="width: 10%;">
                                <asp:Label ID="lbh6" runat="server" Text="Free/Purchase"></asp:Label>
                            </th>
                            <th style="width: 10%;">
                                <asp:Label ID="lbh10" runat="server" Text="Header/Footer"></asp:Label>
                            </th>
                            <th style="width: 5%;">
                                <asp:Label ID="lbh7" runat="server" Text="Edit"></asp:Label>
                            </th>
                            <th style="width: 5%;">
                                <asp:Label ID="lbh8" runat="server" Text="Del"></asp:Label>
                            </th>
                        </tr>
                    </thead>
                    <asp:Label ID="OutStringData" runat="server"></asp:Label>
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
