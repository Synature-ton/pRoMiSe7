<%@ page language="C#" autoeventwireup="true" inherits="Preferences_addOtherIncome, App_Web_addotherincome.aspx.475a53d1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head id="Head1" runat="server">
    <title>Add Other Income</title>
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
        .style4
        {
            width: 306px;
        }
        .style6
        {
            width: 117px;
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
                    <span class="headerText">Add Other Income</span>
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
                                <div id="divLV3" runat="server">
                                    <table id="tbLV3" runat="server" class="style2">
                                        <tr align="right">
                                            <td colspan="2">
                                                <asp:LinkButton ID="linkBack" runat="server" onclick="linkBack_Click"><< Back</asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" class="style6">
                                                Income Code
                                            </td>
                                            <td class="style4">
                                                <div style="float: left; padding: 3px;">
                                                    <asp:TextBox ID="txtIncomeCode" runat="server" Width="150"></asp:TextBox>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" class="style6">
                                                Income Name
                                            </td>
                                            <td class="style4">
                                                <div style="float: left; padding: 3px;">
                                                    <asp:TextBox ID="txtIncomeName" runat="server" Width="300"></asp:TextBox>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" class="style6">
                                                Sale Mode
                                            </td>
                                            <td>
                                                <div style="float: left; padding: 3px;">
                                                    <asp:DropDownList ID="ddListSaleMode" Width="150" runat="server">
                                                    </asp:DropDownList>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" class="style6">
                                                Income Amount
                                            </td>
                                            <td class="style4">
                                                <div style="float: left; padding: 3px;">
                                                    <asp:TextBox ID="txtAmount" runat="server" Width="150"></asp:TextBox>
                                                </div>
                                                <div style="float: left; padding: 3px;">
                                                    <asp:RadioButtonList ID="radioAmountType" RepeatDirection="Horizontal" runat="server">
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div style="float: left; padding: 3px;">
                                                    <asp:RegularExpressionValidator ID="regularExpressionValidator" runat="server" ControlToValidate="txtAmount"
                                                    ValidationExpression="^([-+]?[0-9]+|[0-9]{1,3}(,[0-9]{3})*)(\.[0-9]{1,2})?$" SetFocusOnError="true"
                                                    ValidationGroup="p3" ErrorMessage="Please insert numeric.">
                                                    </asp:RegularExpressionValidator>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" class="style6">
                                                Include Service Charge
                                            </td>
                                            <td class="style4">
                                                <div style="float: left; padding: 3px;">
                                                    <asp:RadioButtonList ID="radioIncludeServiceCharge" RepeatDirection="Horizontal" runat="server">
                                                    </asp:RadioButtonList>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" class="style6">
                                                Not Calculate When Price Over
                                            </td>
                                            <td class="style4">
                                                <div style="float: left; padding: 3px;">
                                                    <asp:TextBox ID="txtNotCalculatePrice" runat="server" Width="150"></asp:TextBox>
                                                </div>
                                                <div style="float: left; padding: 3px;">
                                                    <asp:RegularExpressionValidator ID="regularExpressionValidator1" runat="server" ControlToValidate="txtNotCalculatePrice"
                                                    ValidationExpression="^([-+]?[0-9]+|[0-9]{1,3}(,[0-9]{3})*)(\.[0-9]{1,2})?$" SetFocusOnError="true"
                                                    ValidationGroup="p3" ErrorMessage="Please insert numeric.">
                                                    </asp:RegularExpressionValidator>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" class="style6">
                                                Is Default
                                            </td>
                                            <td class="style4">
                                                <div style="float: left; padding: 3px;">
                                                    <asp:RadioButtonList ID="radioIsDefault" RepeatDirection="Horizontal" runat="server">
                                                    </asp:RadioButtonList>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" class="style6">
                                                VAT Type
                                            </td>
                                            <td class="style4">
                                                <div style="float: left; padding: 3px;">
                                                    <asp:RadioButtonList ID="radioVATType" RepeatDirection="Horizontal" runat="server">
                                                    </asp:RadioButtonList>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" class="style6">
                                                Activated
                                            </td>
                                            <td class="style4">
                                                <div style="float: left; padding: 3px;">
                                                    <asp:RadioButtonList ID="radioActivated" RepeatDirection="Horizontal" runat="server">
                                                    </asp:RadioButtonList>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style6">
                                                &nbsp;
                                            </td>
                                            <td class="style4">
                                                <div style="float: left; padding: 3px;">
                                                    <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" ValidationGroup="p3" />
                                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                                                        onclick="btnCancel_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style6">&nbsp;</td>
                                            <td>
                                                <asp:Label ID="lbError" runat="server" Text=""></asp:Label>
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
