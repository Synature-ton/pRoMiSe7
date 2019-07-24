<%@ page language="C#" autoeventwireup="true" inherits="GreyHound_DiscountReport, App_Web_greyhound_discountreport.aspx.dfa151d5" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Discount Report</title>

    <script src="../javascript/JQuery/jquery-1.6.2.js" type="text/javascript"></script>
    <script src="../javascript/JQuery/jquery-1.6.2.min.js" type="text/javascript"></script>
    <script src="../javascript/JQuery/jquery.js" type="text/javascript"></script>
    <script src="../javascript/webscript.js" type="text/javascript"></script>
    
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
</head>
<body <% = GlobalParam.BodyProp %>>
    <form id="frmDiscountReport" runat="server">
    <table bgcolor="White" cellpadding="0" cellspacing="0">
        <tr style="background-color: #EEEEEE">
            <td height="35" style="background-image: url('../images/headerstub.jpg')">
                &nbsp; &nbsp;
            </td>
            <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                <div>
                    <asp:Label ID="Label1" runat="server" Text="GREYHOUND - Discount Report" CssClass="headerText"></asp:Label>
                </div>
            </td>
            <td rowspan="99" style="background-color: #003366; width: 1px;">
                <img src="../images/clear.gif" height="1px" width="1px" >
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
            <td id="content">
                <table id="tbFilter" class="noprint">
                    <tbody class="text">
                        <tr>
                            <td align="right">เลือกสาขา : </td>
                            <td>
                                <asp:DropDownList ID="ddListBranch" runat="server" Width="200px" >
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">เลือกช่วงเวลา : </td>
                            <td>
                                <asp:RadioButton ID="radioDate" runat="server" Text="วันที่" GroupName="selectedPeriod" />
                                <asp:RadioButton ID="radioMonth" runat="server" Text="เดือน-ปี" GroupName="selectedPeriod" />
                                <asp:RadioButton ID="radioYear" runat="server" Text="ปี" GroupName="selectedPeriod" />
                                <asp:RadioButton ID="radioPeriod" runat="server" Text="ช่วงเวลา" GroupName="selectedPeriod" />
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>
                                <div>
                                    <span id="fromPeriod">
                                        <asp:DropDownList ID="ddListDay" runat="server">
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddListMonth" runat="server">
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddListYear" runat="server">
                                        </asp:DropDownList>
                                    </span>
                                    <span id="toPeriod">
                                        &nbsp;To&nbsp;
                                        <asp:DropDownList ID="ddListDayTo" runat="server">
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddListMonthTo" runat="server">
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddListYearTo" runat="server">
                                        </asp:DropDownList>
                                    </span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>
                                <asp:Button ID="btnReport" runat="server" Text="เรียกดู" 
                                    onclick="btnReport_Click" />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <table id="tbReport" style="min-width:980px">
                    <tbody class="text">
                        <tr>
                            <td>
                                <asp:Label ID="lbError" runat="server" Text=""></asp:Label>
                                <div id="linkForPrint" runat="server"></div>
                                <div id="MyTable">
                                    <div id="tbResult" runat="server" style="min-width:980px"></div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
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
    </form>
</body>
</html>
