<%@ page language="VB" autoeventwireup="false" inherits="Preferences_TargetSale, App_Web_targetsale.aspx.1ae37aa7" %>

<html>
<head runat="server">
    <title>TargetSale</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/StyleSheet2.css" rel="stylesheet" type="text/css" />
</head>
<body <% = GlobalParam.BodyProp %> style="background-color: #C8D3DC;">
    <form id="form1" runat="server">
    <div>
        <table bgcolor="White" cellpadding="0" cellspacing="0">
            <tr style="background-color: #EEEEEE">
                <td height="35" style="background-image: url('../images/headerstub.jpg')">
                    &nbsp; &nbsp;
                </td>
                <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                    <asp:Label ID="lbQuestionHeader" runat="server" CssClass="headerText" Text="Target Sale"></asp:Label>
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
                    <table class="text">
                        <tr>
                            <td>
                                Select Year:
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlTargetYear" runat="server" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                    <span id="myTable" runat="server"></span>
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
    </div>
    </form>
</body>
</html>
