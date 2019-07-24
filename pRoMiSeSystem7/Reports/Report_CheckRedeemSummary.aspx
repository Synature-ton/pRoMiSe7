<%@ page language="VB" autoeventwireup="false" inherits="Reports_Report_CheckRedeemSummary, App_Web_report_checkredeemsummary.aspx.dfa151d5" %>
<html>
<head runat="server">
    <title>Report redeem product summary.</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/StyleSheet.css" rel="stylesheet" type="text/css" />

    <script src="../StyleSheet/webscript.js" type="text/javascript"></script>
</head>
<body style="background-color:#C8D3DC;margin: 0px;">
    <form id="form1" runat="server">
    <div>
     <table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
            <tr bgcolor="eeeeee">
                <td height="35" nowrap background="../images/headerstub.jpg">
                    &nbsp; &nbsp;
                </td>
                <td colspan="2" background="../images/headerbg2000.jpg">
                    <span class="headerText">
                        Report redeem product summary.</span>
                </td>
                <td width="1px" nowrap rowspan="99" bgcolor="003366">
                    <img src="../images/clear.gif" height="1px" width="1px">
                </td>
            </tr>
            <tr bgcolor="666666">
                <td width="3%" height="1">
                    <p style="line-height: 1px;">
                        <img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p>
                </td>
                <td width="94%">
                    <p style="line-height: 1px;">
                        <img src="../images/clear.gif" height="1" width="1" border="0" hspace="252"></p>
                </td>
                <td width="3%">
                    <p style="line-height: 1px;">
                        <img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p>
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
                    <div class="noprint">
                        <table style="width: 100%;">
                            <tr>
                                <td width="200px">
                                    <asp:DropDownList ID="DdlProductLevel" runat="server" Width="170px">
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
                                    <asp:Button ID="BtnShowReport" runat="server" Text="View Report" />
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
                    </div>
                    <br />
                    <div class="noprint" id="Print" runat="server">
                        <a href="javascript: window.print()">Print Report</a> | <a href="javascript:ExportToExcel()">
                            Export to Excel</a> <a href="JavaScript: newWindow = window.open( '../Help/ExportExcel.html', '', 'width=500,height=500,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()">
                                <img src="../images/help.jpg" border="0" hspace="4" vspace="0" align="absmiddle"></a></div>
                    <div style="clear: both; height: 2px;">
                    </div>
                    <span id="MyTable">
                        <div id="print_content" class="smalltext">
                            <div class="boldText" align="left">
                                <span runat="server" id="headerResultText">
                                     </span>
                                <span id="ReportDate" runat="server" class="boldText"></span>
                            </div>
                            <div runat="server" id="ResultText">
                              
                            </div>
                        </div>
                    </span>
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
                <td height="1px" colspan="3" bgcolor="999999">
                    <p style="line-height: 1px;">
                        <img src="../images/clear.gif" height="1" width="1"></p>
                </td>
            </tr>
            <tr>
                <td height="50" colspan="3" background="../images/footerbg2000.gif">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td height="1" colspan="3" bgcolor="999999">
                    <p style="line-height: 1px;">
                        <img src="../images/clear.gif" height="1" width="1"></p>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
