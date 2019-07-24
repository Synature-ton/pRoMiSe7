<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PrepaidEdit.aspx.vb" Inherits="RewardPointSetting.PrepaidEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Prepaid Product</title>
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
                        <asp:Label ID="lblHeader" runat="server" Text="กำหนดสินค้า Prepaid" CssClass="headerText"></asp:Label>
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
                            <td style="width: 15%; text-align: right;">
                                <asp:Label ID="lblPrepaidProductCode" runat="server" Text="รหัสสินค้า" ></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPrepaidProductCode" runat="server" Width="150px" Height="20px"></asp:TextBox>
                                <div id="selectProductText" class="text" runat="server"></div>
                                <asp:Label ID="lblPrepaidProductValidate" runat="server" CssClass="redText"></asp:Label>
                            </td>
                            
                        </tr>
                        <tr>
                            <td style="width: 15%; text-align: right;">
                                <asp:Label ID="lblPrepaidProductName" runat="server" Text="ชื่อสินค้า" ></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPrepaidProductName" runat="server" Width="400px" Height="20px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right;">
                                <asp:Label ID="lblPrepaidAmount" runat="server" Text="Prepaid Amount"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="txtPrepaidAmount" runat="server" Width="100px" Height="20px"></asp:TextBox>
                                <asp:Label ID="lblPrepaidAmountValidate" runat="server" CssClass="redText"></asp:Label>
                            </td>
                        </tr>
                        <tr id="trExpireDate" runat="server" >
                            <td style="text-align: right;">
                                <asp:Label ID="lblExpireDate" runat="server" Text="วันหมดอายุ Prepaid"></asp:Label></td>
                            <td>
                                <table>
                                    <tr>
                                        <td><asp:RadioButton id="optNoExpire" runat="server" Text="ไม่มีวันหมดอายุ" GroupName="grbExpireDate"></asp:RadioButton> </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td>
                                            <asp:RadioButton id="optExpireDate" runat="server" Text="กำหนดวันหมดอายุ" GroupName="grbExpireDate"></asp:RadioButton>&nbsp; 
                                                        </td><td>
                                            <div id="date_enddate" runat="server" style="float: left;"></div>
                                                            </td><td>
                                            <asp:Label ID="lblExpireDateValidate" runat="server" CssClass="redText"></asp:Label>
                                                                </td>
                                                    </tr>
                                                </table>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td><asp:RadioButton id="optExpireAfter" runat="server" Text="หมดอายุหลังจากสร้าง" GroupName="grbExpireDate"></asp:RadioButton>&nbsp;
                                            <asp:TextBox ID="txtExpireAfterDay" runat="server" Width="50px"></asp:TextBox>&nbsp;
                                            <asp:Label ID="lblExpireAfterDay" runat="server" Text="วัน"></asp:Label>
                                            <asp:Label ID="lblExpireAfterDayValidate" runat="server" CssClass="redText"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>
                                <asp:Button ID="btnSave" runat="server" Text="บันทึก" Width="100px" Height="25px" />
                                <asp:Button ID="btnUpdate" runat="server" Text="บันทึกการปรับปรุ่ง" Width="120px" Height="25px" Visible="false" />
                                <asp:Button ID="btnCancel" runat="server" Text="ยกเลิก" Width="100px" Height="25px" />
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
</body>
</html>
