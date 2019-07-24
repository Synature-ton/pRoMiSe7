<%@ page language="VB" autoeventwireup="false" inherits="ReportPrepaid_PrepaidReportHistory, App_Web_prepaidreporthistory.aspx.71748ee8" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Prepaid Summary Of History Report</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" />
    <link href="../StyleSheet/StyleSheet2.css" rel="stylesheet" />
    
    <link href="../javascript/JQueryUI/1.11.4/jquery-ui.css" rel="Stylesheet" type="text/css" />
    <script src="../javascript/JQuery/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="../javascript/JQueryUI/1.11.4/jquery-ui.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function NumberCheck(evt, exp) {
            if (exp == 1)
                if (evt.charCode == 46)
                    return true;
            if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                alert("Allow Only Numbers");
                return false;
            }
        }

    </script>    
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
                        <asp:Label ID="lblHeader" runat="server" Text="Prepaid Summary Of History Report" CssClass="headerText"></asp:Label>
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
                    <table  runat="server" id="tbCondition" class="noprint">
                        <tr>
                            <td style="vertical-align: top; padding-right: 5px;">
                                <table style="vertical-align: top;">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblMemberGroup" runat="server" Text="Member Group" ></asp:Label>                                
                                        </td>
                                    </tr>                        
                                    <tr>
                                        <td>
                                           <asp:DropDownList ID="cboMemberGroup" runat="server" Width="200"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblMemberCode" runat="server" Text="Member Code" ></asp:Label>                                
                                        </td>
                                    </tr>                        
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtMemberCode" runat="server" Width="200"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblPrepaidCardNo" runat="server" Text="Prepaid Card No. : " ></asp:Label>                                
                                        </td>
                                    </tr>                        
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtPrepaidCardNo" runat="server" Width="200px" ></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblOrderBy" runat="server" Text="Order By " ></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:DropDownList ID="cboOrderBy" runat="server" ></asp:DropDownList>
                                        </td>
                                    </tr>                                   
                                </table>
                            </td>
                            <td style="vertical-align: top; border-left: 2px #bebebe solid; padding-left: 10px;">
                                <table style="vertical-align: top;">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblStartDate" runat="server" Text="From" ></asp:Label>
                                            <asp:DropDownList ID="cboRangeStartDay" runat="server">
                                            </asp:DropDownList>
                                            <asp:DropDownList ID="cboRangeStartMonth" runat="server">
                                            </asp:DropDownList>
                                            <asp:DropDownList ID="cboRangeStartYear" runat="server">
                                            </asp:DropDownList>
                                            <asp:Label ID="lblEndDate" runat="server" Text="To" ></asp:Label>
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
                                            <asp:RadioButton ID="optShowResultOnlyRow" runat="server" Text="Display Data Only (Rows) " GroupName="ShowResultRow" />&nbsp;
                                            <asp:TextBox ID="txtShowRow" runat="server" onkeypress="return NumberCheck(event,0)"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                         <td>
                                            <asp:RadioButton ID="optShowResultAll" runat="server" Text="Display All Data" GroupName="ShowResultRow" />
                                         </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="chkDisplayCurrentAmountRange" runat="server" text="Prepaid Amount Between " />&nbsp;
                                            <asp:TextBox ID="txtPrepaidAmountFrom" runat="server" onkeypress="return NumberCheck(event,1)"></asp:TextBox> &nbsp;
                                            <asp:Label ID="lblCurrentAmountRangeTo" runat="server" Text="To" ></asp:Label>&nbsp;
                                            <asp:TextBox ID="txtPrepaidAmountTo" runat="server" onkeypress="return NumberCheck(event,1)" ></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="chkDisplayZeroCurrentAmount" runat="server" Text="Inclue Zero Amount" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:RadioButton ID="optDisplayAsPrice" runat="server" Text="Price"  GroupName="DisplayType" />
                                            <asp:RadioButton ID="optDisplayAsNumberTime" runat="server" Text="Number of Time"  GroupName="DisplayType" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Button ID="cmdDisplayReport" runat="server" Text="View Report" Height="25px" />
                                        </td>
                                    </tr>
                                </table>
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
