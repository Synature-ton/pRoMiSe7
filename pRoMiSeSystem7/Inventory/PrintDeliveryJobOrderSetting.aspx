<%@ page language="VB" autoeventwireup="false" inherits="Inventory_PrintDeliveryJobOrderSetting, App_Web_printdeliveryjobordersetting.aspx.9758fd70" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title>Print Delivery Form Setting</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {
            font-size: 13px;
            line-height: 15px;
            font-family: sans-serif;
            font-family: Arial, Verdana, Geneva, Arial, Helvetica, sans-serif, Verdana;
            color: black;
            width: 18%;
        }
        .auto-style2 {
            width: 18%;
        }
    </style>
</head>
<body>
    <div id="showPage" visible="true" runat="server">
    <form id="form1" runat="server">
        <table bgcolor="White" cellpadding="0" cellspacing="0">
            <tr style="background-color: #EEEEEE">
                <td height="35" style="background-image: url('../images/headerstub.jpg')">&nbsp; &nbsp;
                </td>
                <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                    <div>
                        <asp:Label ID="lblHeader" runat="server" Text="ตั้งค่าสำหรับการพิมพ์ใบ Delivery" CssClass="headerText"></asp:Label>
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
                <td>
                </td>
                <td>
                    <span id="MessageText" class="boldText" runat="server"></span>
                    <table style="width: 100%;">                       
                        <tr>
                            <td class="auto-style1" style="text-align: left; ">
                                <asp:Label ID="lblPrinterID" runat="server" Text="Printer ที่พิมพ์ :"></asp:Label></td>
                            <td class="text">
                                <asp:DropDownList ID="cboPrinter" runat="server" Width="250px" Height="25px" AutoPostBack="true"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1" style="text-align: left; ">
                                <asp:Label ID="lblNewLineCharacter" runat="server" Text="อักษรสำหรับการขึ้นบรรทัดใหม่"></asp:Label></td>
                            <td class="text">
                                <asp:TextBox ID="txtNewLineCharacter" runat="server" Width="26px" Height="20px" MaxLength="1" style="text-align: center"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1" style="text-align: left; ">
                               <asp:Label ID="lblSaleMode" runat="server" Text="Sale Mode ที่พิมพ์ใบ Delivery"></asp:Label></td>
                            <td class="text">
                                <div style="width: 350px; height: 110px; border: 1px solid #ccc; overflow: auto;">
                                    <asp:CheckBoxList ID="chksSaleMode" runat="server"></asp:CheckBoxList>
                                </div>
                            </td>
                        </tr>
                        <tr id="row2" runat="server" style="display: none;" >
                            <td class="auto-style1" style="text-align: left; ">
                                <asp:Label ID="lblPrintIncludePrice" runat="server" Text="แสดงราคาสินค้า"></asp:Label></td>
                            <td class="text">
                                <asp:RadioButtonList ID="optPrintIncludePrice" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Selected="True" Value="1">ใช่</asp:ListItem>
                                    <asp:ListItem Value="0">ไม่ใช่</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">
                                <asp:Button ID="cmdSetProduct" runat="server" Text="กำหนดสินค้าที่จะพิมพ์" Width="164px" Height="25px" />
                            </td>
                            <td>
                                <asp:Button ID="cmdUpdate" runat="server" Text="บันทึก" Width="120px" Height="25px" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                               
                            </td>
                        </tr>
                    </table>
                    <div id="ErrorMessage" runat="server" class="redText"></div> 
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
    </div>
       <div id="ShowAccessDenied" runat="server" />
</body>
</html>
