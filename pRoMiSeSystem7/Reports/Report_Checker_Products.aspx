<%@ page language="VB" autoeventwireup="false" inherits="Report_Checker_Products, App_Web_report_checker_products.aspx.dfa151d5" debug="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Report Checker By Products</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/StyleSheet.css" rel="stylesheet" type="text/css" />
    <script src="../StyleSheet/webscript.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">

        <table bgcolor="White" cellpadding="0" cellspacing="0">
            <tr style="background-color: #EEEEEE">
                <td height="35" style="background-image: url('../images/headerstub.jpg')">&nbsp; &nbsp;
                </td>
                <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                    <div class="headerText" align="left" id="Text_SectionParam" runat="server">
                        <asp:Label ID="Label1" runat="server" Text="Report Checker By Products"></asp:Label>
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
                    <table style="width: 100%">
                        <tr>
                            <td valign="top" align="left" style="width: 20%">
                                <table style="width: 100%">
                                    <tr>
                                        <td>
                                            <asp:DropDownList ID="DDlProLevel" runat="server" Width="170px" OnSelectedIndexChanged="DDlProLevel_SelectedIndexChanged"
                                                AutoPostBack="true">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 12px">
                                            <asp:DropDownList ID="DdlProductGroup" runat="server" Width="170px" AutoPostBack="true"
                                                OnSelectedIndexChanged="DdlProductGroup_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 12px">
                                            <asp:DropDownList ID="DdlProductDept" runat="server" Width="170px" AutoPostBack="true"
                                                OnSelectedIndexChanged="DdlProductDept_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 12px">
                                            <asp:DropDownList ID="DdlProducts" runat="server" Width="170px" AutoPostBack="true">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="3" valign="top" style="width: 100%" align="left">
                                <table>
                                    <tr>
                                        <td valign="top" style="width: 120px" align="left">
                                            <asp:RadioButton ID="RdoDay" runat="server" Text="Day" Checked="True" GroupName="Group1"
                                                AutoPostBack="True" />
                                        </td>
                                        <td valign="top" align="left" colspan="2">
                                            <asp:DropDownList ID="DdlDayByDay" runat="server">
                                            </asp:DropDownList>
                                            &nbsp;
                                        <asp:DropDownList ID="DdlMonthByDay" runat="server">
                                        </asp:DropDownList>
                                            <asp:DropDownList ID="DdlYearByDay" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                        <td align="left" colspan="1" style="width: 3px" valign="top"></td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:CheckBox ID="CbBetweenTime" runat="server" Text="Time" AutoPostBack="True" />
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="DdlStartHour" runat="server">
                                            </asp:DropDownList>
                                            &nbsp;
                                        <asp:DropDownList ID="DdlStartMinute" runat="server">
                                        </asp:DropDownList>
                                            &nbsp;&nbsp; &nbsp;&nbsp;
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="Label6" runat="server" Text="To">
                                            </asp:Label>
                                            <asp:DropDownList ID="DdlEndHour" runat="server">
                                            </asp:DropDownList>
                                            <asp:DropDownList ID="DdlEndMinute" runat="server">
                                            </asp:DropDownList>
                                            &nbsp;&nbsp; &nbsp;&nbsp;
                                        </td>
                                        <td align="left" style="width: 3px">&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:Button ID="BtnShowData" runat="server" Text="View Report" Width="120" />
                                        </td>
                                        <td align="left">&nbsp;
                                        </td>
                                        <td align="left">&nbsp;
                                        </td>
                                        <td align="left" style="width: 3px">&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <div class="noprint" id="Print" runat="server" style="width: 100%;">
                        <a href="javascript: window.print()">Print Report</a> |
                                <asp:LinkButton ID="btnExportToExcel" runat="server">ExportToExcel</asp:LinkButton>
                    </div>
                    <span id="MyTable"></span>
                    <asp:Label ID="lbResultdata" runat="server"></asp:Label>
                    <asp:Label ID="LblSession" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="LblErr" runat="server" Visible="False"></asp:Label>
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
