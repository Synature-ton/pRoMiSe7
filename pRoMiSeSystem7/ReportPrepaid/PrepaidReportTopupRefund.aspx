<%@ page language="VB" autoeventwireup="false" inherits="ReportPrepaid_PrepaidReportRefund, App_Web_prepaidreporttopuprefund.aspx.71748ee8" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Prepaid Topup/ Refund Report</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" />
    <link href="../StyleSheet/StyleSheet2.css" rel="stylesheet" />
</head>
<body>
    <div  id="showPage" visible="true" runat="server">
    <form id="form1" runat="server">

        <table bgcolor="White" cellpadding="0" cellspacing="0">
            <tr style="background-color: #EEEEEE">
                <td height="35" style="background-image: url('../images/headerstub.jpg')">&nbsp; &nbsp;
                </td>
                <td colspan="2" style="background-image: url('../images/headerbg2000.jpg');">
                    <div class="noprint">
                        <asp:Label ID="lblHeader" runat="server" Text="Prepaid Topup/ Refund Report" CssClass="headerText"></asp:Label>
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
                            <td>
                                <asp:DropDownList ID="cboReportType" runat="server" ></asp:DropDownList>
                            </td>
                            <td>
                                <label>From</label>
                                <asp:DropDownList ID="cboRangeStartDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="cboRangeStartMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="cboRangeStartYear" runat="server">
                                </asp:DropDownList>
                                <label>To</label>
                                <asp:DropDownList ID="cboRangeEndDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="cboRangeEndMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="cboRangeEndYear" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>                        
                        <tr>
                            <td>
                                <asp:DropDownList ID="cboShop" runat="server" ></asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label ID="lblPrepaidCardNo" runat="server" Text="Prepaid Card No. : " ></asp:Label>                                
                                     <asp:TextBox ID="txtPrepaidCardNo" runat="server" Width="245px" ></asp:TextBox>
                            </td>                              
                        </tr>
                      <tr>
                          <td>
                             <asp:Label ID="lblOrderBy" runat="server" Text="Order By " ></asp:Label>&nbsp; <asp:DropDownList ID="cboOrderBy" runat="server" ></asp:DropDownList>
                          </td>
                          <td>
                               <asp:Button ID="cmdDisplayReport" runat="server" Text="View Report" Height="25px" />
                          </td>
                        </tr>
                    </table>
                    <br />
                    <div id="HeaderResult" runat="server" style="text-align: center;" class="boldText">
                    </div>
                    <div id="CreateReportDate" runat="server" style="text-align: right;">
                    </div>
                    <div class="noprint" id="Print">
                        <a href="javascript: window.print()">Print Report</a> |  
                        <asp:LinkButton ID="cmdExportData" runat="server">Export To Excel</asp:LinkButton>
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
</div>                    
<div id="errorMsg" runat="server" />
</body>

</html>
