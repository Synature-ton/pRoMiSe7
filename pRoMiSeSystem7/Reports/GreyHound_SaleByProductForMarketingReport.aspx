<%@ page language="VB" autoeventwireup="false" inherits="Reports_GreyHound_SaleByProductForMarketingReport, App_Web_greyhound_salebyproductformarketingreport.aspx.dfa151d5" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>GreyHound Sale Report By Product</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" />
    <link href="../StyleSheet/StyleSheet2.css" rel="stylesheet" />

    <script language="JavaScript" src="../StyleSheet/webscript.js"></script> 
    <script src="../Scripts/jquery.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

    <script type="text/javascript">

        jQuery(document).ready(function ($) {

            $('#chkSelectAllShop').live('click', function () {
                $("#chklShopInfo INPUT[type='checkbox']").attr('checked', $(this).is(':checked') ? 'checked' : '');
            });

            $("#chklShopInfo input").live("click", function () {
                if ($("#chklShopInfo input[type='checkbox']:checked").length == $("#chklShopInfo input").length) {
                    $('#chkSelectAllShop').attr('checked', 'checked').next();
                }
                else {
                    $('#chkSelectAllShop').removeAttr('checked');
                }
            });

            $('#chkSelectAllSaleMode').live('click', function () {
                $("#chklSaleMode INPUT[type='checkbox']").attr('checked', $(this).is(':checked') ? 'checked' : '');
            });

            $("#chklSaleMode input").live("click", function () {
                if ($("#chklSaleMode input[type='checkbox']:checked").length == $("#chklSaleMode input").length) {
                    $('#chkSelectAllSaleMode').attr('checked', 'checked').next();
                }
                else {
                    $('#chkSelectAllSaleMode').removeAttr('checked');
                }
            });
        });

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
                        <asp:Label ID="lblHeader" runat="server" Text="GreyHound Sale Report By Product" CssClass="headerText"></asp:Label>
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
                            <td valign="top">
                                <div id="ShowMasterShop" runat="server" >
		                        <table>
 			                        <tr>
                                        <td width="160px">
                                            <asp:Panel ID="pnlMasterShop" runat="server" Height="180px" ScrollBars="Auto" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px">
                                            <asp:CheckBoxList ID="chklMasterShop" runat="server" AutoPostBack="true" Height="16px" Width="140px"></asp:CheckBoxList>       
                                            </asp:Panel>
                                        </td> 
		                            </tr>
		                        </table>
	                            </div>
                             </td>
                            <td valign="top"> 
     	                        <table>
                                    <tr>
	                                    <td width="210px" id="ShowShopInfoList" runat="server">
                                            <asp:Panel ID="pnlShop" runat="server" Height="180px" ScrollBars="Auto" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px">
                                            &nbsp;<asp:CheckBox ID="chkSelectAllShop" runat="server" Text="Select All" />
                                            <asp:CheckBoxList ID="chklShopInfo" runat="server" Height="16px" Width="190px"></asp:CheckBoxList>       
                                            </asp:Panel>
                                        </td>                   
			                        </tr>
		                        </table>    
	                        </td>
                            <td valign="top">
		                        <table> 
                                    <tr>
                                       <td><asp:dropdownlist ID="ReportProductOrdering" runat="server">
							                    <asp:listitem></asp:listitem>
							                    <asp:listitem></asp:listitem>
						                   </asp:dropdownlist>
                                        </td>
                    	            </tr>
                                    <tr>
                                        <td><asp:CheckBox ID="chkGroupBySaleMode" Text="Group By Sale Mode" Checked="false" runat="server"></asp:CheckBox>
                                        </td>
                                    </tr>   			                    
                                    <tr>
                                        <td>
                                         <asp:Panel ID="pnlSaleMode" runat="server" Height="120px" ScrollBars="Auto" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px">
                                            &nbsp;<asp:CheckBox ID="chkSelectAllSaleMode" runat="server" Text="Select All" />
                                            <asp:CheckBoxList ID="chklSaleMode" runat="server" Height="16px" Width="190px"></asp:CheckBoxList>       
                                            </asp:Panel>
                                        </td>
                                    </tr>                                                                       
		                        </table>
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:RadioButton ID="optDaily" runat="server" GroupName="SelDateGroup" Checked="True" />
                                            <asp:DropDownList ID="cboDailDay" runat="server"></asp:DropDownList>
                                            <asp:DropDownList ID="cboDailyMonth" runat="server"></asp:DropDownList>
                                            <asp:DropDownList ID="cboDailyYear" runat="server"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:RadioButton ID="optMonthly" runat="server" GroupName="SelDateGroup" />
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
                                    <tr>
                                        <td>
                                            <asp:RadioButton ID="optDateRange" runat="server" GroupName="SelDateGroup" />
                                            <asp:DropDownList ID="cboRangeStartDay" runat="server"></asp:DropDownList>
                                            <asp:DropDownList ID="cboRangeStartMonth" runat="server"></asp:DropDownList>
                                            <asp:DropDownList ID="cboRangeStartYear" runat="server"></asp:DropDownList>
                                            <label>To</label>
                                            <asp:DropDownList ID="cboRangeEndDay" runat="server"></asp:DropDownList>
                                            <asp:DropDownList ID="cboRangeEndMonth" runat="server"></asp:DropDownList>
                                            <asp:DropDownList ID="cboRangeEndYear" runat="server"></asp:DropDownList>
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
                    <div id="ResultHeaderData" runat="server" ></div>
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
