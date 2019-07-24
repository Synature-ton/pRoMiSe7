<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RedeemManagement.aspx.vb" Inherits="RewardPointSetting.RedeemManagement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Redeem Managagement</title>
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
                        <asp:Label ID="lblHeader" runat="server" Text="ตั้งค่าการแลกแต้ม" CssClass="headerText"></asp:Label>
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
                    <div style="text-align: right;"><a href="../Redeem/RedeemEdit.aspx"><asp:Label ID="lblAddRedeemPoint" runat="server" Text="เพิ่มการตั้งค่าการแลกแต้ม"></asp:Label></a></div>
                    <table class="blue">
                        <tr>
                            <th style="width: 5%;">#</th>
                            <th style="width: 5%;"><asp:Label ID="lblRedeemStatus" runat="server" Text="สถานะ"></asp:Label></th>
                            <th style="width: 10%;"><asp:Label ID="lblActivate" runat="server" Text="อนุญาตใช้งาน"></asp:Label></th>
                            <th><asp:Label ID="lblRedeemName" runat="server" Text="ชื่อการแลกแต้ม"></asp:Label></th>
                            <th style="width: 10%;"><asp:Label ID="lblRedeemType" runat="server" Text="ประเภทการแลกแต้ม"></asp:Label></th>
                            <th style="width: 10%;"><asp:Label ID="lblRedeemDetail" runat="server" Text="รายละเอียด"></asp:Label></th>
                            <th style="width: 10%;"><asp:Label ID="lblRedeemShop" runat="server" Text="สาขาเข้าร่วม"></asp:Label></th>                            
                            <th style="width: 5%;"><asp:Label ID="lblEdit" runat="server" Text="แก้ไข"></asp:Label></th>
                            <th style="width: 5%;"><asp:Label ID="lblDelete" runat="server" Text="ลบ"></asp:Label></th>
                        </tr>
                        <asp:Label ID="lbResultText" runat="server"></asp:Label>
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
</body>
</html>
