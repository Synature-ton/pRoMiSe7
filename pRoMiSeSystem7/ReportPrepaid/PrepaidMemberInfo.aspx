<%@ page language="VB" autoeventwireup="false" inherits="ReportPrepaid_PrepaidMemberInfo, App_Web_prepaidmemberinfo.aspx.71748ee8" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Prepaid Card Info</title>
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
    <form id="form1" runat="server">
        <div>
            <table bgcolor="White" cellpadding="0" cellspacing="0">
                <tr style="background-color: #EEEEEE">
                    <td height="35" style="background-image: url('../images/headerstub.jpg')">&nbsp; &nbsp;
                    </td>
                    <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                        <span class="headerText"></span>
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
                        <fieldset style="margin: 20px auto; margin-bottom: 0px; padding: 0px; padding-bottom: 20px; text-align: center;">                            
                            <legend></legend>
                            <center>                                
                            <table style="width:800px; flex-align:center; text-align: center;">
                                <tr style="text-align:center;">
                                    <th colspan="4">&nbsp;<br /><asp:Label ID="lblHeader" runat="server" Font-Size="Large" Text="Header"></asp:Label><br />&nbsp;</th>
                                </tr>                                
                                <tr style="vertical-align:top;">
                                    <td style="text-align:right; width:25%; color:blue;" ><asp:Label ID="lblHeaderCardNo" runat="server" Text="Card No."></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                                    <td style="text-align:left; width:25%;"><asp:Label ID="lblCardNo" runat="server"></asp:Label></td>
                                    <td style="text-align:right; width:20%; color:blue;" ><asp:Label ID="lblHeaderUpdateDate" runat="server" Text="Update Date"></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                                    <td style="text-align:left; width:30%;"><asp:Label ID="lblUpdateDate" runat="server"></asp:Label></td>
                                </tr>     
                                <tr style="vertical-align:top;">
                                    <td style="text-align:right; color:blue;"><asp:Label ID="lblHeaderCardCreateDate" runat="server" Text="Card Create Date"></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                                    <td style="text-align:left; width:25%;"><asp:Label ID="lblCardCreateDate" runat="server"></asp:Label></td>
                                    <td style="text-align:right; color:blue;"><asp:Label ID="lblHeaderCardExpireDate" runat="server" Text="Card Expire Date"></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                                    <td style="text-align:left; width:30%;"><asp:Label ID="lblCardExpireDate" runat="server"></asp:Label></td>
                                </tr>
                                <tr style="vertical-align:top;">
                                    <td style="text-align:right; width:25%; color:blue;"><asp:Label ID="lblHeaderMemberCode" runat="server" Text="Member Code"></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                                    <td style="text-align:left; width:25%;"><asp:Label ID="lblMemberCode" runat="server"></asp:Label></td>
                                    <td style="text-align:right; width:20%; color:blue;"><asp:Label ID="lblHeaderMemberGroup" runat="server" Text="Member Group"></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                                    <td style="text-align:left; width:30%;"><asp:Label ID="lblMemberGroup" runat="server"></asp:Label></td>
                                </tr>
                                <tr style="vertical-align:top;">
                                    <td style="text-align:right; color:blue;"><asp:Label ID="lblHeaderMemberName" runat="server" Text="Member Name"></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                                    <td style="text-align:left; width:25%;"><asp:Label ID="lblMemberName" runat="server"></asp:Label></td>
                                    <td style="text-align:right; color:blue;"><asp:Label ID="lblHeaderGender" runat="server" Text="Gender"></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                                    <td style="text-align:left; width:30%;"><asp:Label ID="lblGender" runat="server"></asp:Label></td>
                                </tr>
                                <tr style="vertical-align:top;">
                                    <td style="text-align:right; color:blue;"><asp:Label ID="lblHeaderBirthday" runat="server" Text="Birthday"></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                                    <td style="text-align:left; width:25%;"><asp:Label ID="lblBirthday" runat="server"></asp:Label></td>
                                    <td style="text-align:right; color:blue;"><asp:Label ID="lblHeaderEmail" runat="server" Text="E Mail"></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                                    <td style="text-align:left; width:30%;"><asp:Label ID="lblEMail" runat="server"></asp:Label></td>
                                </tr>
                                <tr style="vertical-align:top;">
                                    <td style="text-align:right; color:blue;"><asp:Label ID="lblHeaderTelephone" runat="server" Text="Tel."></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                                    <td style="text-align:left; width:25%;"><asp:Label ID="lblTelephone" runat="server"></asp:Label></td>
                                    <td style="text-align:right; color:blue;"><asp:Label ID="lblHeaderMobileNo" runat="server" Text="Mobile No."></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                                    <td style="text-align:left; width:30%;"><asp:Label ID="lblMobileNo" runat="server"></asp:Label></td>
                                </tr>                                
                                <tr style="vertical-align:top;">
                                    <td style="text-align:right; color:blue;"><asp:Label ID="lblHeaderPrepaidCurrentAmount" runat="server" Text="Prepaid Current Amount"></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                                    <td style="text-align:left; width:25%;"><asp:Label ID="lblPrepaidCurrentAmount" runat="server"></asp:Label></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                            </table>
                            </center>
                        </fieldset>

                        <center>
                        <table >
                            <tr style="vertical-align:top;">
                                <td colspan="2" style="text-align:center; width:20%;">
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
                                     <asp:Button ID="cmdSearchHistory" runat="server" Text="Submit" ></asp:Button>
                               </td>
                            </tr>                           
                        </table>
                        </center>
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
                    <td colspan="3" height="30">
                        <table style="width: 100%;">
                            <tr>                                
                            </tr>
                        </table>
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
        </div>
    </form>
    <div id="errorMsg" runat="server" />
</body>

</html>
