<%@ page language="VB" autoeventwireup="false" inherits="LinkOtherSystem_LinkBlt, App_Web_linkbuzzebeepaymentcondition_edit.aspx.5253a923" %>

<!DOCTYPE html>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
 <title>Link Buzze Bee - Edit Payment Property</title>
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
                        <asp:Label ID="lblHeader" runat="server" Text="แก้ไขเงื่อนไข Check Code ของ Buzze Bee Payment" CssClass="headerText"></asp:Label>
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
                <td height="10" colspan="3"><asp:HiddenField ID="payTypeIDValue" runat="server" />&nbsp;
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
                                <asp:Label ID="lblPaymentName" runat="server" Text="Payment Name :"></asp:Label></td>
                            <td class="text">
                                  <asp:TextBox ID="txtPaymentName" runat="server" ReadOnly ="true" Width="275px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1" style="text-align: left; ">
                                <asp:Label ID="lblStartCharacter" runat="server" Text="Start Character"></asp:Label></td>
                            <td class="text">
                                <asp:TextBox ID="txtStartCharacter" runat="server" ></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1" style="text-align: left; ">
                               <asp:Label ID="lblValidLength_Start" runat="server" Text="Valid Length Start"></asp:Label></td>
                            <td class="text">
                                 <asp:TextBox ID="txtValidLength_Start" runat="server" Width="50px" MaxLength="2" ></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1" style="text-align: left; ">
                               <asp:Label ID="lblValidLength_End" runat="server" Text="Valid Length End"></asp:Label></td>
                            <td class="text">
                                 <asp:TextBox ID="txtValidLength_End" runat="server" Width="50px" MaxLength="2" ></asp:TextBox>
                            </td>
                        </tr>                       
                        <tr>
                            <td class="auto-style1" style="text-align: left; ">
                               <asp:Label ID="lblNumericOnly" runat="server" Text="Numeric Only"></asp:Label></td>
                            <td class="text">
                                 <asp:RadioButton ID="optIsNumeric" runat="server" GroupName="NumericOnlyGroup" Text="Yes" />
                                 <asp:RadioButton ID="optNotIsNumeric" runat="server" GroupName="NumericOnlyGroup" Text="No" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1" style="text-align: left; ">
                               <asp:Label ID="lblIsManualPayment" runat="server" Text="Is Manual Payment"></asp:Label></td>
                            <td class="text">
                                 <asp:RadioButton ID="optIsManualPayment" runat="server" GroupName="IsManualPayment" Text="Yes" />
                                 <asp:RadioButton ID="optIsBuzzeBeePayment" runat="server" GroupName="IsManualPayment" Text="No" />
                            </td>
                        </tr>                       
                        <tr>                       
                            <td></td><td></td>
                        </tr>
                        <tr>
                            <td class="auto-style2">
                                &nbsp;</td>
                            <td>
                                <asp:Button ID="cmdUpdate" runat="server" Text="บันทึก" Width="120px" Height="25px" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                               <asp:Button ID="cmdCancel" runat="server" Text="ยกเลิก" Width="120px" Height="25px" />
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