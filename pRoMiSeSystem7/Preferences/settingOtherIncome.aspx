<%@ page language="C#" autoeventwireup="true" inherits="Preferences_settingOtherIncome, App_Web_settingotherincome.aspx.475a53d1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head id="Head1" runat="server">
    <title>Set Other Income</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/StyleSheet.css" rel="stylesheet" type="text/css" />

    <script src="../javascript/JQuery/jquery-1.6.2.js" type="text/javascript"></script>
    <script src="../javascript/JQuery/jquery-1.6.2.min.js" type="text/javascript"></script>
    <script src="../javascript/JQuery/jquery.js" type="text/javascript"></script>
    <style type="text/css">
        .style2
        {
            font-size: 13px;
            line-height: 15px;
            font-family: sans-serif;
            font-family: Arial, Verdana, Geneva, Arial, Helvetica, sans-serif, Verdana;
            color : black;
            width: 800px;
        }
        .style3
        {
            width: 59px;
        }
        .style4
        {
            width: 306px;
        }
        .style5
        {
            width: 72px;
        }
        .style6
        {
            width: 89px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Label ID="lbPermission" runat="server" Text=""></asp:Label>
    <div id="chkPermission" runat="server">
        <table bgcolor="White" cellpadding="0" cellspacing="0">
            <tr style="background-color: #EEEEEE">
                <td height="35" style="background-image: url('../images/headerstub.jpg')">
                    &nbsp; &nbsp;
                </td>
                <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                    <span class="headerText">Set Other Income</span>
                </td>
                <td rowspan="99" style="background-color: #003366; width: 1px;">
                    <img src="../images/clear.gif" height="1px" width="1px" />
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
                    <table style="width: 100%;" class="text">
                        <tr>
                            <td>
                                <div>&nbsp;</div>
                                <div id="divLV1" runat="server">
                                    <table class="style2">
                                        <tr align="right">
                                            <td>
                                                <asp:LinkButton ID="linAddOtherIncome" runat="server" 
                                                onclick="linAddOtherIncome_Click">Add Other Income</asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbError" runat="server" Text=""></asp:Label><br />
                                                <asp:Label ID="lbTable" runat="server" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
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
    </div>
    </form>
</body>
</html>