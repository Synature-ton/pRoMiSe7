<%@ page language="VB" autoeventwireup="false" inherits="Reports_ReportCompareReceipt, App_Web_reportcomparereceipt.aspx.dfa151d5" debug="true" %>

<html>
<head runat="server">
    <title>Bill And Receipt Comparison Report</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/StyleSheet.css" rel="stylesheet" type="text/css" />

    <script src="../StyleSheet/webscript.js" type="text/javascript"></script>

</head>

<script language="javascript">
function Clickheretoprint()
{ 
  var disp_setting="width=900,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1'"; 
   
  var content_vlue = document.getElementById("print_content").innerHTML; 
  
  var docprint=window.open(",",disp_setting); 
   docprint.document.open(); 
   docprint.document.write('<html><link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" /><head><title></title>'); 
   docprint.document.write('</head><body onLoad="self.print()"><center>');          
   docprint.document.write(content_vlue);          
   docprint.document.write('</center></body></html>'); 
   docprint.document.close(); 
   docprint.focus(); 
}

    function ExportToExcel() {
        var htmltable = document.getElementById("GvReport");
            var html = htmltable.outerHTML;
            window.open('data:application/vnd.ms-excel,' + encodeURIComponent(html));
        }
</script>
    
<body style="background-color:#C8D3DC;margin: 0px;">
    <form id="form1" runat="server">
    <div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
            <tr bgcolor="eeeeee">
                <td height="35" nowrap background="../images/headerstub.jpg">
                    &nbsp; &nbsp;
                </td>
                <td colspan="2" background="../images/headerbg2000.jpg">
                    <label class="headerText">
                        Bill And Receipt Comparison Report</label>
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
                    <div class="text">
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
                                    <asp:DropDownList ID="DdlViewReport" runat="server" Width="170px">
                                        <asp:ListItem Value="1">Display All</asp:ListItem>
                                        <asp:ListItem Value="2">Display Difference only</asp:ListItem>
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
                    <div class="noprint" id="Print" runat="server" visible="false">
                        <a href="javascript: window.print()">Print Report</a> |  <a href="javascript:ExportToExcel()">
                            Export to Excel</a> <a href="JavaScript: newWindow = window.open( '../Help/ExportExcel.html', '', 'width=500,height=500,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()">
                                <img src="../images/help.jpg" border="0" hspace="4" vspace="0" align="absmiddle"></a>

                       
                    </div>
                    <div style="clear: both; height: 2px;">
                    </div>
                    <span id="MyTable">
                        <div id="print_content" class="smalltext">
                            <div class="boldText" align="left">
                                <label class="boldText" visible="false" id="TextHearder" runat="server">
                                    Bill And Receipt Comparison</label>
                                <span id="ReportDate" runat="server" class="boldText"></span>
                            </div>
                            <div class="text" align="left">
                                <asp:GridView ID="GvReport" runat="server" AutoGenerateColumns="False" BackColor="White"
                                    BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" CssClass="smalltext"
                                    AllowPaging="True" PageSize="100">
                                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                    <RowStyle BackColor="White" ForeColor="Black" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Receipt No.">
                                            <ItemTemplate>
                                                <asp:Label ID="ReceiptNo" runat="server" Text='<%#bind("ReceiptNo") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" Width="120px" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderText="Table" DataField="ReceiptTableName">
                                            <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Qty" DataField="ReceiptQty">
                                            <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Amount" DataField="ReceiptAmount">
                                            <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Payment" DataField="PaymentType">
                                            <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="#Print" DataField="PrintAmount">
                                            <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Ref No.">
                                            <ItemTemplate>
                                                <asp:Label ID="BillNo" runat="server" Text='<%#bind("BillNo") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderText="Table" DataField="BillTableName">
                                            <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Qty" DataField="BillQty">
                                            <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Amount" DataField="BillAmount">
                                            <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BillTime" HeaderText="PrintTime">
                                            <HeaderStyle HorizontalAlign="Center" Width="170px" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Qty" DataField="DiffQty">
                                            <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Amount" DataField="DiffAmount">
                                            <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                    </Columns>
                                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                    <HeaderStyle BackColor="#507093" Font-Bold="True" ForeColor="White" />
                                </asp:GridView>
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
