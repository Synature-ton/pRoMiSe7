<%@ page language="VB" autoeventwireup="false" inherits="Reports_Reportcompare_Viewdetail, App_Web_reportcompare_viewdetail.aspx.dfa151d5" %>

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
</script>

<body>
    <form id="form1" runat="server">
    <div>
        <div class="noprint" style="float: left; margin-left: 1em;">
            <a href="javascript: window.print()">Print Report</a> | <a href="javascript:ExportToExcel()">
                Export to Excel</a> <a href="JavaScript: newWindow = window.open( '../Help/ExportExcel.html', '', 'width=500,height=500,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()">
                    <img src="../images/help.jpg" border="0" hspace="4" vspace="0" align="absmiddle"></a></div>
        <div style="clear: both; height: 2px;">
        </div>
        <span id="MyTable">
            <div id="print_content" class="smalltext">
                <div class="text" style="float: left; margin-left: 1em;">
                    <asp:GridView ID="GvReport" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" CssClass="smalltext">
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <RowStyle BackColor="White" ForeColor="Black" />
                        <Columns>
                            <asp:BoundField HeaderText="Code" DataField="ProductCode">
                                <HeaderStyle HorizontalAlign="Center" Width="200px" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="ProductName" DataField="ProductName">
                                <HeaderStyle HorizontalAlign="Center" Width="220px" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="Unit Price" DataField="UnitPrice">
                                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="Qty" DataField="Qty">
                                <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="SubTotal" DataField="SubTotal">
                                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="Discount" DataField="Discount">
                                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="Total" DataField="Total">
                                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                        </Columns>
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <HeaderStyle BackColor="#507093" Font-Bold="True" ForeColor="White" />
                    </asp:GridView>
                </div>
                <div style="clear: both; height: 5px;">
                </div>
                <div class="text" style="float: left; margin-left: 1em; margin-bottom: 1em;">
                    <asp:Label ID="txtProHis" runat="server" CssClass="boldText"></asp:Label>
                    <asp:GridView ID="gvPromo" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" CssClass="smalltext">
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <RowStyle BackColor="White" ForeColor="Black" />
                        <Columns>
                            <asp:BoundField HeaderText="Status" DataField="OperationCode">
                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                <ItemStyle HorizontalAlign="left" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="PromotionName" DataField="PromotionName">
                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="StaffName" DataField="ChangeStaffName">
                                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="Time" DataField="ChangeDateTime">
                                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                        </Columns>
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <HeaderStyle BackColor="#507093" Font-Bold="True" ForeColor="White" />
                    </asp:GridView>
                </div>
                <div style="clear: both;">
                </div>
                <div class="text" style="float: left; margin-left: 1em; margin-bottom: 1em;">
                    <asp:Label ID="txtOrder" runat="server" CssClass="boldText"></asp:Label>
                    <asp:GridView ID="gvOrder" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" CssClass="smalltext">
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <RowStyle BackColor="White" ForeColor="Black" />
                        <Columns>
                            <asp:BoundField HeaderText="FromTable" DataField="FromTableName">
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" />
                                <ItemStyle HorizontalAlign="left" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="ToTable" DataField="ToTableName">
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="FromReceiptNo" DataField="FromReceiptNo">
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="ToReceiptNo" DataField="ToReceiptNo">
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="MoveDateTime" DataField="MoveDateTime">
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="ProductName" DataField="ProductName">
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="OriginalAmount" DataField="OriginalAmount">
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="MoveAmount" DataField="MoveAmount">
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="Note" DataField="HistoryNote">
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" />
                                <ItemStyle HorizontalAlign="left" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="StaffName">
                                <ItemTemplate>
                                    <asp:Label ID="lbStaffName" runat="server" Text='<%#bind("MoveStaffName") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" />
                                <ItemStyle HorizontalAlign="left" />
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="FunctionName" DataField="FrontFunctionName">
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" />
                                <ItemStyle HorizontalAlign="left" />
                            </asp:BoundField>
                        </Columns>
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <HeaderStyle BackColor="#507093" Font-Bold="True" ForeColor="White" />
                    </asp:GridView>
                </div>
                <div style="clear: both; height: 5px;">
                </div>
            </div>
        </span>
    </div>
    </form>
</body>
</html>
