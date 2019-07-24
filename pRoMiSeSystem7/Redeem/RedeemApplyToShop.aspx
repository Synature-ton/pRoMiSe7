<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RedeemApplyToShop.aspx.vb" Inherits="RewardPointSetting.RedeemApplyToShop" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Apply To Shop</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <table bgcolor="White" cellpadding="0" cellspacing="0">
            <tr style="background-color: #EEEEEE">
                <td height="35" style="background-image: url('../images/headerstub.jpg')">&nbsp; &nbsp;
                </td>
                <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                    <div>
                        <asp:Label ID="lblHeader" runat="server" Text="กำหนดสาขาเข้าร่วม" CssClass="headerText"></asp:Label>
                    </div>
                </td>
                <td rowspan="99" style="background-color: #003366; width: 1px;">
                    <img src="../images/clear.gif" height="1px" width="1px">
                </td>
            </tr>
            <tr style="background-color: #666666">
                <td width="3%" height="1"></td>
                <td width="94%"></td>
                <td width="3%"></td>
            </tr>
            <tr>
                <td height="10" colspan="3">&nbsp;
                </td>
            </tr>
            <tr>
                <td>&nbsp;
                </td>
                <td>
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <span id="lbLink" runat="server"></span>
                            </td>
                        </tr>

                        <tr>
                            <td><a href="javascript:CheckAll(true)">Select&nbsp;All</a> | <a href="javascript:CheckAll(false)">Clear&nbsp;All</a></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbResultText" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnUpdate" runat="server" Text="บันทึก" Width="110px" Height="25px" />
                                &nbsp;
                                <asp:Button ID="btnBackToList" runat="server" Text="เสร็จสิ้น" Width="110px" Height="25px" />
                               
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbResponseText" runat="server" CssClass="boldText"></asp:Label>
                            </td>
                        </tr>
                    </table>

                </td>
                <td>&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3" height="30">&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3" style="background-color: #999999; height: 1px;"></td>
            </tr>
            <tr>
                <td height="50" colspan="3" style="background-image: url('../images/footerbg2000.gif')">&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3" style="background-color: #999999; height: 1px;"></td>
            </tr>
        </table>
    </form>

    <script type="text/javascript">
        function CheckAll(checked) {
            len = document.forms[0].selList.length;
            var i = 0;
            for (i = 0; i < len; i++) {
                document.forms[0].selList[i].checked = checked;
            }
        }
    </script>
</body>
</html>
