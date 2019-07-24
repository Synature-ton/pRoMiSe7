<%@ page language="C#" enableeventvalidation="false" autoeventwireup="true" inherits="_OpenCashDrawerReport, App_Web_rhdt3k25" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
<style type="text/css">
        
	    table.fixed { table-layout:fixed; }
            table.fixed td { overflow: hidden; }
            table.fixed td.lbProduct { width:50px }
            table.fixed td.ddlProduct { width:200px }
            table.fixed td.lbDate { width:40px }
            table.fixed td.ddlDate { width:120px }
        table.report {
        border:solid;
        border-width:1px;
        border-collapse: collapse;
        }
            table.report th {
                padding:10px;
                border: solid 1px #000;
            }
            table.report thead th {
                background: #507093;
                color: #fff;
            }
            table.report tbody th {
                background: #507093;
                color: #fff;
            }
            table.report tbody td {
                padding:4px;
                 background: #fff;
            }
            table.report tbody td.sum {
                padding:4px;
                 background: #ebebeb;
                 border-top-width:2px;
            }
            table.report tbody tr:nth-child(even):hover td, table.report tbody tr:nth-child(odd):hover td {  background-color:#FFFFDD; }
            table.report .pagination
            {
                display: table;
                padding: 0;
                margin: 0 auto;
            }
    .auto-style1 {
        width: 137px;
    }
    .auto-style2 {
        width: 11%;
    }
    </style>
<script type="text/javascript">
    function AddWasteType() {
        document.getElementById("dialogadd").style.visibility = (document.getElementById("dialogadd").style.visibility == "visible") ? "hidden" : "visible";
    }
    function PrintDivContent(divId) {
        var printContent = document.getElementById(divId);
        var WinPrint = window.open('', '', 'left=0,top=0,toolbar=0,sta­tus=0');
        WinPrint.document.write(printHTML.innerHTML);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
    }
    function DeleteConfirm() {
        var confirm_value = document.createElement("INPUT");
        confirm_value.type = "hidden";
        confirm_value.name = "confirm_value_delete";
        if (confirm("You want to delete data?"))
            confirm_value.value = "Yes";
        else
            confirm_value.value = "No";
        document.forms[0].appendChild(confirm_value);
    }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table bgcolor="White" cellpadding="0" cellspacing="0">
            <tr style="background-color: #EEEEEE">
                <td height="35" style="background-image: url('../images/headerstub.jpg')" class="auto-style2">&nbsp;&nbsp;</td>
                <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                    <span class="headerText"> Open Cash Drawer Report </span>
                </td>
                <td rowspan="99" style="background-color: #003366; width: 1px;">
                    <img src="../images/clear.gif" height="1px" width="1px">
                    
                </td>
            </tr>
            <tr style="background-color: #666666">
                <td height="1" class="auto-style2"></td>
                <td width="94%"></td>
                <td width="3%"></td>
            </tr>
            <tr><td height="10" colspan="3">&nbsp;</td></tr>
            <tr>
                <td class="auto-style2">&nbsp;</td>
                <td>
                    
                    <table border="0" style="width: 86%;">
                        <tr>
                            <td class="auto-style1">
                                <asp:DropDownList ID="ddlAllShop" runat="server"></asp:DropDownList></td>
                            
                            <td>
                                <asp:RadioButton ID="rbDaily" runat="server" GroupName="date"  />
                                <asp:DropDownList ID="ddlDayOfDaily" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="ddlMonthOfDaily" runat="server" ></asp:DropDownList>
                                <asp:DropDownList ID="ddlYearOfDaily" runat="server"></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="auto-style1">&nbsp;</td>                           
                            <td>
                                <asp:RadioButton ID="rbMonthly" runat="server" GroupName="date" />
                                <asp:DropDownList ID="ddlMonthOfMonthly" runat="server"></asp:DropDownList>
                                <asp:DropDownList ID="ddlYearOfMonthly" runat="server"></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="auto-style1">&nbsp;</td>                            
                            <td>
                                <asp:RadioButton ID="rbPeriod" runat="server" GroupName="date" />
                                <asp:DropDownList ID="ddlBeganDayPeriod" runat="server"></asp:DropDownList>
                                <asp:DropDownList ID="ddlBeganMonthPeriod" runat="server"></asp:DropDownList>
                                <asp:DropDownList ID="ddlBeganYearPeriod" runat="server"></asp:DropDownList>
                                <asp:Label ID="lblTo" runat="server" Text="To"></asp:Label>
                                <asp:DropDownList ID="ddlFinishedDayPeriod" runat="server"></asp:DropDownList>
                                <asp:DropDownList ID="ddlFinishedMonthPeriod" runat="server"></asp:DropDownList>
                                <asp:DropDownList ID="ddlFinishedYearPeriod" runat="server"></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="auto-style1">&nbsp;</td>
                            <td>
                                <asp:Button ID="btnGenerateReport" runat="server" Text="Generate Report" OnClick="btnGenerateReport_Click" /></td>
                        </tr>
                        </table>
              
                </td>
                <td>&nbsp;</td>
            </tr> 
            <tr>
                <td colspan="2"></td>
            </tr> 
            <tr>
                <td colspan="2">
                    
                    
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="exportPrint" runat="server" Text="Print Report" BorderStyle="None" BackColor="Transparent" OnClick="exportPrint_Click" />
                    &nbsp;|&nbsp;
                                <asp:LinkButton ID="exportExcel" runat="server" Text="Export Excel" BorderStyle="None" BackColor="Transparent" OnClick="exportExcel_Click" />
                </td>
                <td>&nbsp;</td>
                
            </tr>
            <tr>
                <td colspan="3" height="30">                
                    <%--<center><asp:GridView ID="GridView1" runat="server" CssClass="report" Width="90%" BackColor ="White" BorderColor="Black" BorderStyle="None" BorderWidth="1px" CellPadding="3" EnableModelValidation="True" ></asp:GridView></center>--%>
                 <span id="tableHTML" runat="server"></span>
                </td>

            </tr>
            <tr><td colspan="3" style="background-color: #999999; height: 1px;"></td></tr>
            <tr><td height="50" colspan="3" style="background-image: url('../images/footerbg2000.gif')">&nbsp;</td></tr>
            <tr><td colspan="3" style="background-color: #999999; height: 1px;"></td></tr>
        </table>
    </div>
    </form>
</body>
</html>
