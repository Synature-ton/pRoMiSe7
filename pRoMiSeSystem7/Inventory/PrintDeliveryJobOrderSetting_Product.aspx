<%@ page language="VB" autoeventwireup="false" inherits="Inventory_PrintDeliveryJobOrderSetting_Product, App_Web_printdeliveryjobordersetting_product.aspx.9758fd70" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
 <title>Print Delivery Product Setting</title>
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
                        <asp:Label ID="lblHeader" runat="server" Text="กำหนดสินค้าที่ให้พิมพ์ใบ Delivery" CssClass="headerText"></asp:Label>
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
                                <span id="lblLink" runat="server"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:DropDownList ID="ddlShopInfo" runat="server" AutoPostBack="true" Height="25px"></asp:DropDownList>
                                <asp:DropDownList ID="ddlProductGroup" runat="server" AutoPostBack="true" Height="25px" Visible="false"></asp:DropDownList>
                                <asp:DropDownList ID="ddlProductDept" runat="server" AutoPostBack="true" Height="25px" Visible="false"></asp:DropDownList>
                                <asp:HiddenField ID="hdViewPage" runat="server" Value="1" />
                                &nbsp;&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td><a href="javascript:CheckAll(true)">Select&nbsp;All</a> | <a href="javascript:CheckAll(false)">Clear&nbsp;All</a></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblResultText" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="cmdUpdate" runat="server" Text="บันทึก" Width="110px" Height="25px" />
                                &nbsp;&nbsp;
                                <asp:Button ID="cmdBack" runat="server" Text="เสร็จสิ้น" Width="110px" Height="25px" />
                                &nbsp;&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblResponseText" runat="server" CssClass="boldText"></asp:Label>
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

