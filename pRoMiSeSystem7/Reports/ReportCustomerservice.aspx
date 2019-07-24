<%@ page language="C#" masterpagefile="~/MasterPage/MasterPage.master" autoeventwireup="true" inherits="ReportCustomerservice, App_Web_reportcustomerservice.aspx.dfa151d5" title="รายงานพอใจไม่พอใจ" enableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script language="javascript" src="../StyleSheet/DateDropdownJScript.js" type="text/javascript"></script>
 <style type="text/css">
        .altrowstyle
        {
            background-color: #C8D3DC;
        }
        .fieldset
        {
            border: 1px solid #61B5CF;
            margin: 20px auto;
            margin-bottom: 0px;
            padding: 0px;
            padding-bottom: 20px;
            text-align: left;
        }
        .legend
        {
            font: bold 12px Tahoma,Arial, Helvetica, sans-serif;
            color: #00008B; /* background-color: #FFFFFF;*/
        }
        .th_label
        {
            font-family: Tahoma;
            font-size: 12px;
            font-weight: bold;
            margin-right: 5px;
        }
        .star_label
        {
            color: Red;
        }
        .container
        {
            /* So the overflow scrolls */
            overflow: auto;
            position: relative; /* Style */
            border: 0px solid black;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:Label ID="lbHeader" runat="server" Text="รายงานพอใจไม่พอใจ"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
 <div  style="width: 100%;">
        <table width="100%" class="noprint" >
            <th width="25%">
            </th>
            <th width="25%">
            </th>
            <th width="50%">
            </th>
            <tbody>
                <tr>
                    <td style="text-align: right; padding-right: 10px">
                        <table style="text-align: right;">
                            <tr>
                                <td>
                                    <asp:DropDownList ID="DdlProductLevel" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <asp:RadioButton ID="Rdotype2" GroupName="typegroup" Text="Report by Default" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <asp:RadioButton ID="Rdotype1" GroupName="typegroup" Text="Report by Bill" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <asp:RadioButton ID="Rdotype3" GroupName="typegroup" Text="Group by Day of Week"
                                        runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <asp:RadioButton ID="Rdotype4" GroupName="typegroup" Text="Group by Time" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <asp:RadioButton ID="Rdotype5" GroupName="typegroup" Text="Group by Branch" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="bntReport" runat="server" Text="สร้างรายงาน" OnClick="bntReport_Click" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td colspan="2">
                        <table>
                            <tr>
                                <td>
                                    <asp:RadioButton ID="Radio1" GroupName="Group1" runat="server" />
                                </td>
                                <td colspan="3">
                                    <select id="day1" name="day1">
                                    </select>
                                    <select id="month1" name="month1">
                                    </select>
                                    <select id="year1" name="year1">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:RadioButton ID="Radio2" GroupName="Group1" runat="server" />
                                </td>
                                <td colspan="3">
                                    <select id="month2" name="month2">
                                    </select>
                                    <select id="year2" name="year2">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:RadioButton ID="Radio3" GroupName="Group1" runat="server" />
                                </td>
                                <td colspan="3">
                                    <select id="year3" name="year3">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:RadioButton ID="Radio4" GroupName="Group1" runat="server" />
                                </td>
                                <td colspan="3">
                                    <%-- <span style="margin-left:15px;font-size:13px">เริ่ม</span>--%>
                                    <select id="day4s" name="day4s">
                                    </select>
                                    <select id="month4s" name="month4s">
                                    </select>
                                    <select id="year4s" name="year4s">
                                    </select>
                                    <span style="margin-left: 15px; font-size: 13px">To</span>
                                    <select id="day4e" name="day4e">
                                    </select>
                                    <select id="month4e" name="month4e">
                                    </select>
                                    <select id="year4e" name="year4e">
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:Label ID="lblText" runat="server" Font-Bold="true" ForeColor="Red" Text=""></asp:Label>
                    </td>
                </tr>
            </tbody>
        </table>
        <table width="100%" id="tbrpt" style="display:" >
            <tbody>
                <tr>
                    <td align="left">
                      <div class="noprint" id="PrintReport" runat="server">
                           </div>
                    </td>
                </tr>
                <tr >
                    <td>
                        <div style="float: left; width: 100%; text-align: center; padding-bottom: 20px;">
                          
                            <div style="padding-bottom: 5px;">
                                <span ID="lbHeaderPage" runat="server" style="text-align: center; font-size:16px;font-weight: bold;">สรุปความพอใจลูกค้า</span></div>
                            <div>
                                <span ID="lbTextDate" runat="server" style="text-align: center;font-size:16px;font-weight:bold">วันที่</span>
                                <asp:Label ID="lblHeadder" runat="server" Text=""></asp:Label></div>
                        </div>
                        <div style="float: left; width: 100%">
                            <table id="tdGridbill" width="60%" style="display:none;">
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbntExport" runat="server" OnClick="lbntExport_Click">Export to excel</asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                            <ContentTemplate>
                                                <asp:GridView ID="gvData" runat="server" BackColor="White" BorderColor="#3366CC"
                                                    BorderStyle="None" BorderWidth="1px" CellPadding="4" AllowPaging="false" OnRowDataBound="gvData_RowDataBound"
                                                    Width="100%" HeaderStyle-CssClass="tdHeader" RowStyle-CssClass="itemText" AutoGenerateColumns="false">
                                                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                                    <RowStyle BackColor="White" ForeColor="#000" CssClass="smalltext" HorizontalAlign="Right"
                                                         />
                                                    <Columns>
                                                        <asp:BoundField DataField="productlevelname" HeaderText="ชื่อสาขา" HeaderStyle-CssClass="tdHeader"
                                                            ItemStyle-CssClass="itemText">
                                                            <HeaderStyle CssClass="tdHeader"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="center" />
                                                        </asp:BoundField>
                                                        <%--<asp:TemplateField HeaderText="หมายเลขใบเสร็จ" HeaderStyle-CssClass="tdHeader"
                                                            ItemStyle-CssClass="itemText">
                                                            <ItemTemplate>
                                                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="#" Text='<%# Eval("documenttypeheader") %>'>
                                                                </asp:HyperLink>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="tdHeader"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:TemplateField>--%>
                                                       <asp:BoundField DataField="documenttypeheader" HeaderText="หมายเลขใบเสร็จ" HeaderStyle-CssClass="tdHeader"
                                                            ItemStyle-CssClass="itemText">
                                                            <HeaderStyle CssClass="tdHeader"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="center" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="saledate" HeaderText="วันที่" HeaderStyle-CssClass="tdHeader"
                                                            ItemStyle-CssClass="itemText">
                                                            <HeaderStyle CssClass="tdHeader"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="center" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="likeCustomer" HeaderText="สถานะ" HeaderStyle-CssClass="tdHeader"
                                                            ItemStyle-CssClass="itemText">
                                                            <HeaderStyle CssClass="tdHeader"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="center" />
                                                        </asp:BoundField>
                                                    </Columns>
                                                    <PagerStyle BackColor="White" HorizontalAlign="Center" CssClass="text" />
                                                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                                    <HeaderStyle BackColor="#507093" Font-Bold="True" ForeColor="White" CssClass="smalltext" />
                                                   
                                                </asp:GridView>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                            <table id="tdGridOthers" width="60%" style="display:none ">
                            <tr>
                                    <td>
                                        <asp:LinkButton ID="lbntExportother" runat="server" 
                                            onclick="lbntExportother_Click" >Export to excel</asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <asp:GridView ID="gvOthers" runat="server" BackColor="White" BorderColor="#6666FF"
                                                    BorderStyle="Solid" BorderWidth="1px" CellPadding="3" EmptyDataText="ไม่พบข้อมูลที่ทำการค้นหา"
                                                    EmptyDataRowStyle-ForeColor="Red" AutoGenerateColumns="true" PageSize="20" RowStyle-CssClass="itemText"
                                                    OnRowDataBound="gvOthers_RowDataBound" OnRowCreated="gvOthers_RowCreated" 
                                                    Width="100%">
                                                    <RowStyle ForeColor="#000066" Font-Names="BrowalliaUPC" Font-Size="18px" />
                                                    <EmptyDataRowStyle ForeColor="Red" />
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <HeaderStyle BackColor="#507093" Font-Bold="True" ForeColor="White" Font-Names="BrowalliaUPC"
                                                        Font-Size="18px" CssClass="tdHeader" />
                                                   
                                                </asp:GridView>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                       
                                    </td>
                                </tr>
                            </table>
                           
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
    
     window.onload = function() {
        
            populatedropdown('day1', 'month1', 'year1',<%=LangID %>);
            populatedropdown('', 'month2', 'year2', <%=LangID %>);
            populatedropdown('', '', 'year3', <%=LangID %>);
            populatedropdown('day4s', 'month4s', 'year4s', <%=LangID %>);
            populatedropdown('day4e', 'month4e', 'year4e', <%=LangID %>);
            
            <%=scriptSetDate %>
        }
        
         function Showrpt() {
                document.getElementById("tbrpt").style.display = '';
           
            }

            function UnShowrpt() {
                document.getElementById("tbrpt").style.display = 'none';
            }
           
             function switchGrid(){
            
                document.getElementById("tdGridbill").style.display = '';
                document.getElementById("tdGridOthers").style.display = 'none';
            }
             
            function UnswitchGrid(){
            
                document.getElementById("tdGridbill").style.display = 'none';
                document.getElementById("tdGridOthers").style.display = '';
            }
            
        function showbill(transactionid,computid,shopid){
           window.open('BillDetails.aspx?ComputerID='+computid+'&ShopID='+shopid+'&TransactionID='+transactionid+'','_blank','scrollbars=1,toolbar=0,resizable=1,height=600,width=750,status=0,directories=0,menubar=0,location=0');  
                                                                                                  
        }
        
    <%=script %>
   <%=scriptSwitch %>
    
    </script>
</asp:Content>

