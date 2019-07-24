<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RewardSpecial.aspx.vb" Inherits="RewardPointSetting.RewardSpecial" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Reward</title>
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
                        <asp:Label ID="lblHeader" runat="server" Text="ตั้งค่าการสะสมแต้มพิเศษ" CssClass="headerText"></asp:Label>
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
                            <td style="width: 10%; text-align: right;">
                                <asp:Label ID="lblSpecialFor" runat="server" Text="ใช้สำหรับ" ></asp:Label></td>
                            <td style="width: 30%;">
                                <asp:RadioButton ID="rdoSpecialDay2" runat="server" Text="วันเกิด" GroupName="group1" Checked="true" AutoPostBack="true" />

                            </td>
                            <td style="width: 15%; text-align: right;">
                                <asp:Label ID="lblSpecialFor2" runat="server" Text="ใช้สำหรับ" ></asp:Label></td>
                            <td >
                                <asp:RadioButton ID="rdoSpecialDay1" runat="server" Text="ช่วงวันพิเศษ/วันหยุดนักขัตฤกษ์" GroupName="group1" AutoPostBack="true" />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right;">
                                <asp:Label ID="lblBirthdayCondition" runat="server" Text="เงื่อนไข" ></asp:Label>
                            </td>
                            <td>
                                <asp:RadioButtonList ID="rdoIsInMonthOfBirthDay" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Selected="True" Value="0">ตรงกับวัน</asp:ListItem>
                                    <asp:ListItem Value="1">ตรงกับดือน</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td style="width: 15%; text-align: right;">
                                <asp:Label ID="lblStartDate" runat="server" Text="วันที่เริ่มต้น" ></asp:Label></td>
                            <td >
                                <div id="date_startdate" runat="server" style="float: left;">
                                </div>
                                <span id="validate_startdate" runat="server" class="redText"></span>
                            </td>
                        </tr>

                        <tr>
                            <td style="width: 15%; text-align: right;">
                                <asp:Label ID="lblBeforeBirthday" runat="server" Text="ให้คำนวนแต้มก่อนหน้าวันเกิดกี่วัน"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="txtBefore" runat="server" Width="100px" Height="20px"></asp:TextBox>&nbsp;
                                <asp:Label ID="lblBeforeBirthdayDay" runat="server" Text="วัน"></asp:Label></td>
                            <td style="text-align: right;">
                                <asp:Label ID="lblEndDate" runat="server" Text="ถึงวันที่" ></asp:Label></td>
                            <td>
                                <div id="date_enddate" runat="server" style="float: left;">
                                </div>

                            </td>
                        </tr>

                        <tr>
                            <td style="text-align: right;">
                                <asp:Label ID="lblAfterBirthDay" runat="server" Text="ให้คำนวณแต้มหลังวันเกิดกี่วัน" ></asp:Label></td>
                            <td>
                                <asp:TextBox ID="txtAfter" runat="server" Width="100px" Height="20px"></asp:TextBox>&nbsp;
                                <asp:Label ID="lblAfterBirthDayDay" runat="server" Text="วัน"></asp:Label></td>
                            <td style="text-align: right;">
                                <asp:Label ID="lblSpecialDayCondition" runat="server" Text="เงื่อนไขการสะสมแต้ม" ></asp:Label></td>
                            <td>
                                <asp:TextBox ID="txtPriceForSpecialDay" runat="server" Width="100px" Height="20px" Enabled="false"></asp:TextBox>
                                <asp:Label ID="lbforPriceForSpecialDay" runat="server"></asp:Label><label>/</label>
                                <asp:TextBox ID="txtPointForSpecialDay" runat="server" Width="100px" Height="20px" Enabled="false"></asp:TextBox>
                                <asp:Label ID="lblForPointForSpecialDay" runat="server" Text="แต้ม"></asp:Label>&nbsp;&nbsp;
                                <asp:Label ID="lbRewardTypeValidateForSpecialDay" runat="server" CssClass="redText"></asp:Label></td>
                        </tr>
                        <tr >
                            <td style="text-align: right;">
                                <asp:Label ID="lblBirhdayCondition" runat="server" Text="เงื่อนไขการสะสมแต้ม" ></asp:Label></td>
                            <td>
                                <asp:TextBox ID="txtPrice" runat="server" Width="100px" Height="20px"></asp:TextBox>
                                <asp:Label ID="lbforPrice" runat="server"></asp:Label><label>/</label>
                                <asp:TextBox ID="txtPoint" runat="server" Width="100px" Height="20px"></asp:TextBox>
                                <asp:Label ID="lblForPoint" runat="server" Text="แต้ม"></asp:Label>&nbsp;&nbsp;
                                </td>
                            <td style="text-align: right;">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>


                        <tr >
                            <td style="width: 10%; text-align: right;">
                                &nbsp;</td>
                            <td>
                                <asp:Label ID="lbRewardTypeValidate" runat="server" CssClass="redText"></asp:Label></td>
                             <td>
                                &nbsp;</td>
                            <td>
                                <asp:Button ID="btnSave" runat="server" Text="บันทึก" Width="100px" Height="25px" />
                                <asp:Button ID="btnUpdate" runat="server" Text="บันทึกการปรับปรุ่ง" Width="120px" Height="25px" Visible="false" />
                                <asp:Button ID="btnCancelUpdate" runat="server" Text="ยกเลิก" Width="100px" Height="25px" Visible="false" />
                                <asp:Button ID="btnCancel" runat="server" Text="เสร็จสิ้น" Width="100px" Height="25px" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 15%; text-align: right;">
                                &nbsp;</td>
                            <td colspan="2" style="text-align:center;">
                                &nbsp;</td>
                            <td><div id="ErrorMessage" runat="server" ></div>
                                &nbsp;</td>
                        </tr>

                        <tr>
                            <td colspan="4">
                                <table class="blue">
                                    <tr>
                                        <th style="width: 5%;">#</th>
                                        <th style="width: 15%;"><asp:Label ID="lblRewardUseFor" runat="server" Text="ใช้สำหรับ"></asp:Label></th>
                                        <th style="width: 10%;"><asp:Label ID="lblRewardStartDate" runat="server" Text="วันที่เริ่มต้น"></asp:Label></th>
                                        <th style="width: 10%;"><asp:Label ID="lblRewardEndDate" runat="server" Text="ถึงวันที่"></asp:Label></th>                                        
                                        <th style="width: 15%;"><asp:Label ID="lblRewardCondition" runat="server" Text="เงื่อนไข"></asp:Label></th>
                                        <th style="width: 10%;"><asp:Label ID="lblRewardCalculateBeforeBirthday" runat="server" Text="ให้คำนวนแต้มก่อนหน้าวันเกิดกี่วัน"></asp:Label></th>
                                        <th style="width: 10%;"><asp:Label ID="lblRewardCalculateAfterBirthday" runat="server" Text="ให้คำนวณแต้มหลังวันเกิดกี่วัน"></asp:Label></th>
                                        <th style="width: 10%;"><asp:Label ID="lblRewardCalculateCondition" runat="server" Text="เงื่อนไขการสะสมแต้ม"></asp:Label></th>
                                        <th style="width: 5%;"><asp:Label ID="lblRewardEdit" runat="server" Text="แก้ไข"></asp:Label></th>
                                        <th style="width: 5%;"><asp:Label ID="lblRewardDelete" runat="server" Text="ลบ"></asp:Label></th>
                                    </tr>
                                    <asp:Label ID="lbResultText" runat="server"></asp:Label>
                                </table>
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
