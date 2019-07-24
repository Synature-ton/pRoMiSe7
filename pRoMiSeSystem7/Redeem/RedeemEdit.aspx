﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RedeemEdit.aspx.vb" Inherits="RewardPointSetting.RedeemEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Redeem Point</title>
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
                    <table style="width: 100%;">
                        <tr>
                            <td style="width: 15%; text-align: right;">
                                <asp:Label ID="lblRedeemName" runat="server" CssClass="redText" Text="ชื่อการแลกแต้ม"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="txtRewardName" runat="server" Width="220px" Height="20px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr>
                            <td style="text-align: right;">
                                <asp:Label ID="lblStartDate" runat="server" CssClass="redText" Text="วันที่เริ่มต้น"></asp:Label></td>
                            <td>
                                <div id="date_startdate" runat="server" style="float: left;">
                                </div>
                                <span id="validate_startdate" runat="server" class="redText"></span>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right;">
                                <asp:Label ID="lblEndDate" runat="server" Text="วันที่หมดอายุ"></asp:Label></td>
                            <td>
                                <div id="date_enddate" runat="server" style="float: left;">
                                </div>

                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right;">
                                <asp:Label ID="lblRedeemType" runat="server" Text="ประเภทการแลกแต้ม"></asp:Label></td>
                            <td>
                                <asp:DropDownList ID="ddlRedeemType" runat="server" Width="220px" Height="25px" AutoPostBack="true"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right;">
                                <asp:Label ID="lblRedeemPoint" runat="server" Text="แต้มที่ใช้สำหรับแลก"></asp:Label></td>
                            <td>

                                <asp:TextBox ID="txtPoint" runat="server" Width="70px" Height="20px"></asp:TextBox>
                                <asp:Label ID="lblForPoint" runat="server" Text="แต้ม"></asp:Label>&nbsp;&nbsp;
                                <asp:Label ID="lbPointValidate" runat="server" CssClass="redText"></asp:Label>
                            </td>
                        </tr>
                        <tr id="RowPaymentAmount" runat="server" style="display: none;">
                            <td style="text-align:right;">
                                <asp:Label ID="lblPaymentAmount" runat="server" Text="มูลค่า"></asp:Label></td>
                            <td>

                                <asp:TextBox ID="txtPrice" runat="server" Width="70px" Height="20px"></asp:TextBox>
                                <asp:Label ID="lbforPrice" runat="server" CssClass="redText"></asp:Label>
                            </td>
                        </tr>
                        <tr id="RowCoupon" runat="server" style="display: none;">
                            <td style="text-align: right;">
                                <asp:Label ID="lblCouponVoucher" runat="server" Text="คูปอง"></asp:Label></td>
                            <td>
                                 <asp:DropDownList ID="ddlCouponVoucher" runat="server" Width="220px" Height="25px"></asp:DropDownList>
                            
                                 <asp:Label ID="lbCouponValidate" runat="server" CssClass="redText"></asp:Label>
                            
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right;">
                                <asp:Label ID="lblRemark" runat="server" Text="รายละเอียดเพิ่มเติม"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="txtRemark" runat="server" Rows="2" TextMode="MultiLine" Width="220px"></asp:TextBox></td>
                        </tr>

                        <tr>
                            <td style="text-align: right;">
                                <asp:Label ID="lblActivate" runat="server" Text="เปิดใช้งาน"></asp:Label></td>
                            <td>
                                <asp:RadioButtonList ID="rdoActivate" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Selected="True" Value="1">ใช่</asp:ListItem>
                                    <asp:ListItem Value="0">ไม่ใช่</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>
                                <asp:Button ID="btnSave" runat="server" Text="บันทึก" Width="100px" Height="25px" />
                                <asp:Button ID="btnUpdate" runat="server" Text="บันทึกการปรับปรุ่ง" Width="120px" Height="25px" Visible="false" />
                                <asp:Button ID="btnCancel" runat="server" Text="ยกเลิก" Width="100px" Height="25px" />
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>
                                <asp:Label ID="lbError" runat="server"></asp:Label>
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
</body>
</html>