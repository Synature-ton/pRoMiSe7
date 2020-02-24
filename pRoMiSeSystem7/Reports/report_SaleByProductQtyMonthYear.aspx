<%@ page language="VB" autoeventwireup="false" inherits="Reports_report_SaleByProductQtyMonthYear, App_Web_report_salebyproductqtymonthyear.aspx.dfa151d5" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Sale By Product Qty (Month/ Year) Report</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" />
    <link href="../StyleSheet/StyleSheet2.css" rel="stylesheet" />

    <script language="JavaScript" src="../StyleSheet/webscript.js"></script> 
    <script src="../Scripts/jquery.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>



</head>
<body>
    <div  id="showPage" visible="true" runat="server">
    <form id="form1" runat="server">

    <input type="hidden" id="SelShopName" runat="server" />
    <input type="hidden" id="SelShopIDList" runat="server" />
    <input type="hidden" id="SelProductGroupIDList" runat="server" />
    <input type="hidden" id="SelProductDeptIDList" runat="server" />
    <input type="hidden" id="SelProductIDList" runat="server" />

        <table bgcolor="White" cellpadding="0" cellspacing="0">
            <tr style="background-color: #EEEEEE">
                <td height="35" style="background-image: url('../images/headerstub.jpg')">&nbsp; &nbsp;
                </td>
                <td colspan="2" style="background-image: url('../images/headerbg2000.jpg');">
                    <div class="noprint">
                        <asp:Label ID="lblHeader" runat="server" Text="Sale By Product Qty (Month/ Year) Report" CssClass="headerText"></asp:Label>
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
                    <table runat="server" id="tbCondition" >
                        <tr>
                            <td>
                                <asp:DropDownList ID="cboShop" CssClass="text" AutoPostBack="true" runat="server">
                                </asp:DropDownList>
                            </td>                                                       
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:RadioButton ID="optMonthly" runat="server" GroupName="SelDateGroup" checked="true" />
                                            <asp:DropDownList ID="cboMonthlyMonth" runat="server">
                                            </asp:DropDownList>
                                            <asp:DropDownList ID="cboMonthlyYear" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                      <tr>
                                        <td>
                                            <asp:RadioButton ID="optYearLy" runat="server" GroupName="SelDateGroup" />
                                            <asp:DropDownList ID="cboYearlyYear" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>                    
                        <tr>
                            <td style="vertical-align:top" colspan="2">
		                        <table style="height: 144px; ">
                                    <tr>
                                        <td><asp:Label ID="lblSelectProductGroup" runat="server" Text="Select Group" CssClass="text" ></asp:Label></td>
                                        <td><asp:Label ID="lblSelectProductDept" runat="server" Text="Select Dept" CssClass="text" ></asp:Label></td>
                                        <td><asp:Label ID="lblSelectProduct" runat="server" Text="Select Product" CssClass="text" ></asp:Label></td>                       
                                    </tr>
                                    <tr>
                                        <td><asp:Checkbox ID="chkSelAllProductGroup" Text="Sel All Data" CssClass="text" AutoPostBack="True" runat="server" /></td>
                                        <td><asp:Checkbox ID="chkSelAllProductDept" Text="Sel All Data" CssClass="text" AutoPostBack="True" runat="server" /></td>
                                        <td><asp:Checkbox ID="chkSelAllProduct" Text="Sel All Data" CssClass="text" AutoPostBack="True"  runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td><div id="pnlProductGroup" style="border-width:1px;border-style:solid;height:120px;width:280px;overflow:auto" >
                                            <asp:CheckBoxList ID="chkbProductGroup" runat="server" Width="250px" CssClass="text" AutoPostBack="true" Height="16px" ></asp:CheckBoxList>
                                            </div></td>
                                        <td><div id="pnlProductDept" style="border-width:1px;border-style:solid;height:120px;width:280px;overflow:auto" >
                                            <asp:CheckBoxList ID="chkbProductDept" runat="server" Height="25px" Width="261px" CssClass="text" AutoPostBack="true" ></asp:CheckBoxList>
                                            </div></td>
                                        <td><div id="pnlProduct" style="border-width:1px;border-style:solid;height:120px;width:360px;overflow:auto" >
                                            <asp:CheckBoxList ID="chkbProduct" runat="server" Height="21px" Width="315px" CssClass="text" ></asp:CheckBoxList>
                                        </div></td>
                                        </tr>
                               </table>
                           </td>
                        </tr>
                        <tr>
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
                    <div class="noprint" id="dvPrint" runat="server" >
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
