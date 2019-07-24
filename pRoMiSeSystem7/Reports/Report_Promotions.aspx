<%@ page language="VB" autoeventwireup="false" inherits="Reports_Report_Report_Promotions, App_Web_report_promotions.aspx.dfa151d5" debug="true" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Report Promotion</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" />
    <link href="../StyleSheet/StyleSheet2.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

        <table bgcolor="White" cellpadding="0" cellspacing="0">
            <tr style="background-color: #EEEEEE">
                <td height="35" style="background-image: url('../images/headerstub.jpg')">&nbsp; &nbsp;
                </td>
                <td colspan="2" style="background-image: url('../images/headerbg2000.jpg');">
                    <div class="noprint">
                        <asp:Label ID="lh" runat="server" Text="Report Promotion" CssClass="headerText"></asp:Label>
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

                    <table style="width: 100%;" runat="server" id="tbCondition" class="noprint">
                        <tr>
                            <td width="220px">
                                <asp:DropDownList ID="DdlProductLevel" runat="server" Width="210px">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:RadioButton ID="Rdo1" runat="server" GroupName="d" Checked="True" />
                                <asp:DropDownList ID="Rdo1_DdlDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="Rdo1_DdlMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="Rdo1_DdlYear" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:DropDownList ID="DdlViewReportType" runat="server" Width="210px">
                                    <asp:ListItem Value="1">Show Report By Date</asp:ListItem>
                                    <asp:ListItem Value="2">Show Report By Bill</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:RadioButton ID="Rdo2" runat="server" GroupName="d" />
                                <asp:DropDownList ID="Rdo2_DdlMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="Rdo2_DdlYear" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="BtnShowReport" runat="server" Text="View Report" Height="25px" />
                            </td>
                            <td>
                                <asp:RadioButton ID="Rdo3" runat="server" GroupName="d" />
                                <asp:DropDownList ID="Rdo3s_DdlDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="Rdo3s_DdlMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="Rdo3s_DdlYear" runat="server">
                                </asp:DropDownList>
                                <label>
                                    To</label>
                                <asp:DropDownList ID="Rdo3e_DdlDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="Rdo3e_DdlMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="Rdo3e_DdlYear" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <div id="HeaderResult" runat="server" style="text-align: center;" class="boldText">
                    </div>
                    <div class="noprint" id="Print">
                        <a href="javascript: window.print()">Print Report</a>
                    </div>
                    <div id="ResultData" runat="server"></div>
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
