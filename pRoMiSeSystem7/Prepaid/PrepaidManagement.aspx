<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PrepaidManagement.aspx.vb" Inherits="RewardPointSetting.PrepaidManagement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Prepaid Managagement</title>
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
                        <asp:Label ID="lblHeader" runat="server" Text="ตั้งค่าสินค้าสำหรับ Prepaid" CssClass="headerText"></asp:Label>
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
                    <table style="width:100%">
                        <tr>
                            <td>
                                <asp:DropDownList ID="cboPrepaidSystemType" AutoPostBack="true" runat="server"></asp:DropDownList>
                            </td>   
                            <td align="right">
                                <div style="text-align: right;"><a runat="server" id="aLink" href="../Prepaid/PrepaidEdit.aspx">
                                    <asp:Label ID="lblAddPrepaid" runat="server" Text="เพิ่มสินค้า Prepaid"></asp:Label></a></div>                                                                
                            </td>
                        </tr>        
                    </table>

                    <table class="blue">
                        <tr>
                            <th style="width: 5%;">#</th>
                            <th id="thProductName" runat="server"  ><asp:Label ID="lblPrepaidProductName" runat="server" Text="Prepaid ProductName"></asp:Label></th>
                            <th id="thPrepaidPrice" style="width: 10%;" runat="server" ><asp:Label ID="lblPrepaidPrice" runat="server" Text="Prepaid Amount"></asp:Label></th>   
                            <th id ="thExpireDate" style="width: 15%;" runat="server" ><asp:Label ID="lblExpireDate" runat="server" Text="วันหมดอายุ"></asp:Label></th>                          
                            <th id="thEdit" style="width: 5%;" runat="server" ><asp:Label ID="lblEdit" runat="server" Text="แก้ไข"></asp:Label></th>
                            <th id="thDelete" style="width: 5%;" runat="server" ><asp:Label ID="lblDelete" runat="server" Text="ลบ"></asp:Label></th>
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
