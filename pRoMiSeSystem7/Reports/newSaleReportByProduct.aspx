<%@ page language="C#" autoeventwireup="true" inherits="Reports_newSummarySaleReport, App_Web_newsalereportbyproduct.aspx.dfa151d5" enableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Sale report by Product</title>

    <script src="../javascript/JQuery/jquery-1.6.2.js" type="text/javascript"></script>
    <script src="../javascript/JQuery/jquery-1.6.2.min.js" type="text/javascript"></script>
    <script src="../javascript/JQuery/jquery.js" type="text/javascript"></script>
    <script type="text/javascript">
        function submitForm() {
            //alert("test");
            document.forms[0].submit();
        }

        function listAllProduct() {
            //alert('List All');
            __doPostBack('ListAllProduct', '');
        }

        function clearAllProduct() {
            //alert('List All');
            __doPostBack('ClearAllProduct', '');
        }

        function listAllProductDept() {
            //alert('List All');
            __doPostBack('ListAllProductDept', '');
        }

        function clearAllProductDept() {
            //alert('List All');
            __doPostBack('ClearAllProductDept', '');
        }
    </script>
    
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        #webDataGrid
        {
            max-width:980px;
        }
        .NumberHeaderStyle
        {
            text-align:right;
            vertical-align:bottom;
            height:30px;
        }
        .TextHeaderStyle
        {
            text-align:left;
            vertical-align:bottom;
            height:30px;
        }
        .NumberStyle
        {
            text-align:right;
            vertical-align:bottom;
            height:30px;
        }
        .TextStyle
        {
            text-align:left;
            vertical-align:bottom;
            height:30px; 
        }
    </style>
</head>
<body <% = GlobalParam.BodyProp %>>
    <form id="frmNewSaleReportByDept" runat="server">
    <table bgcolor="White" cellpadding="0" cellspacing="0">
        <tr style="background-color: #EEEEEE">
            <td height="35" style="background-image: url('../images/headerstub.jpg')">
                &nbsp; &nbsp;
            </td>
            <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                <div>
                    <asp:Label ID="Label1" runat="server" Text=""
                        CssClass="headerText"></asp:Label>
                </div>
            </td>
            <td rowspan="99" style="background-color: #003366; width: 1px;">
                <img src="../images/clear.gif" height="1px" width="1px" />
            </td>
        </tr>
        <tr style="background-color: #666666">
            <td width="3%" height="1">
            </td>
            <td width="94%">
            </td>
            <td width="3%">
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
            <td id="content">
                <div class="noprint">
                <table id="tbFilter">
                    <tbody class="text">
                        <tr>
                            <td align="right">
                                <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
                            </td>
                            <td>
                                <%--<asp:RadioButton ID="radioDate" runat="server" Text="วันที่" GroupName="selectedPeriod" />--%>
                                <asp:RadioButton ID="radioMonth" runat="server" Text="" AutoPostBack="true"
                                    GroupName="selectedPeriod" oncheckedchanged="radioMonth_CheckedChanged" />
                                <asp:RadioButton ID="radioYear" runat="server" Text="" AutoPostBack="true" 
                                    GroupName="selectedPeriod" oncheckedchanged="radioYear_CheckedChanged" />
                                <asp:RadioButton ID="radioPeriod" runat="server" Text="" AutoPostBack="true" 
                                    GroupName="selectedPeriod" oncheckedchanged="radioPeriod_CheckedChanged" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                &nbsp;
                            </td>
                            <td>
                                <div>
                                    <span id="fromPeriod">
                                        <asp:DropDownList ID="ddListDay" runat="server">
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddListMonth" runat="server">
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddListYear" runat="server">
                                        </asp:DropDownList>
                                    </span><span id="toPeriod" runat="server">&nbsp;To&nbsp;
                                        <asp:DropDownList ID="ddListDayTo" runat="server">
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddListMonthTo" runat="server">
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddListYearTo" runat="server">
                                        </asp:DropDownList>
                                    </span>
                                </div>
                            </td>
                        </tr>
                        <%--<tr>
                            <td>
                                ระบุรหัสสินค้า : 
                            </td>
                            <td>
                                <asp:TextBox ID="txtProductCodeFrom" runat="server" Width="200px" ></asp:TextBox>
                                &nbsp;To&nbsp;<asp:TextBox ID="txtProductCodeTo" runat="server" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                ระบุชื่อสินค้า : 
                            </td>
                            <td>
                                <asp:TextBox ID="txtProductNameFrom" runat="server" Width="200px" ></asp:TextBox>
                                &nbsp;To&nbsp;<asp:TextBox ID="txtProductNameTo" runat="server" Width="200px"></asp:TextBox>
                            </td>
                        </tr>--%>
                        <tr>
                            <td align="right">
                                <asp:Label ID="Label3" runat="server" Text=""></asp:Label> 
                            </td>
                            <td>
                                <asp:DropDownList ID="ddListShop" runat="server" AutoPostBack="true" 
                                    onselectedindexchanged="ddListShop_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <%--<tr>
                            <td align="right">
                                ระบุกลุ่มสินค้า : 
                            </td>
                            <td>
                                <asp:DropDownList ID="ddListProductGroup" runat="server" AutoPostBack="True" 
                                    onselectedindexchanged="ddListProductGroup_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>--%>
                        <tr>
                            <td align="right" valign="top">
                                &nbsp;
                            </td>
                            <td valign="top">
                                <div style=" float:left; padding:3px;">
                                    <asp:Label ID="Label4" runat="server" Text=""></asp:Label><br />
                                    [<a href="#" onclick="chkAll('chkListGroup');listAllProductDept();">Select All</a>]
                                    [<a href="#" onclick="clsAll('chkListGroup');clearAllProductDept();">Clear All</a>]
                                    <asp:Panel ID="panelGroup" runat="server" Width="300px" Height="120px" ScrollBars="Auto" BorderWidth="1px">
                                        <asp:CheckBoxList ID="chkListGroup" runat="server" AutoPostBack="True" 
                                            onselectedindexchanged="chkListGroup_SelectedIndexChanged">
                                        </asp:CheckBoxList>
                                    </asp:Panel>
                                </div>
                                <div style=" float:left; padding:3px;">
                                    <asp:Label ID="Label5" runat="server" Text=""></asp:Label><br />
                                    [<a href="#" onclick="chkAll('chkListCategory');listAllProduct();">Select All</a>]
                                    [<a href="#" onclick="clsAll('chkListCategory');clearAllProduct();">Clear All</a>]
                                    <asp:Panel ID="panelCategory" runat="server" Width="300px" Height="120px" ScrollBars="Auto" BorderWidth="1px">
                                        <asp:CheckBoxList ID="chkListCategory" runat="server" AutoPostBack="True" 
                                            onselectedindexchanged="chkListCategory_SelectedIndexChanged">
                                        </asp:CheckBoxList>
                                    </asp:Panel>
                                </div>
                                <div style=" float:left; padding:3px;">
                                    <asp:Label ID="Label6" runat="server" Text=""></asp:Label><br />
                                    [<a href="#" onclick="chkAll('chkListProduct');">Select All</a>]
                                    [<a href="#" onclick="clsAll('chkListProduct');">Clear All</a>]
                                    <asp:Panel ID="panelProduct" runat="server" Width="300px" Height="120px" ScrollBars="Auto" BorderWidth="1px">
                                        <asp:CheckBoxList ID="chkListProduct" runat="server">
                                        </asp:CheckBoxList>
                                    </asp:Panel>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <asp:Button ID="btnReport" runat="server" Text="" 
                                            onclick="btnReport_Click" OnClientClick="btnClick();" />
                            </td>
                        </tr>
                    </tbody>
                </table>
                </div>
                        <table id="tbReport" style="min-width: 980px">
                            <tbody class="text">
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">Export to Excel</asp:LinkButton>
                                        <div id="showReport" runat="server"></div>
                                        <asp:Label ID="lbError" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
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
            <td colspan="3" style="background-color: #999999; height: 1px;">
            </td>
        </tr>
        <tr>
            <td height="50" colspan="3" style="background-image: url('../images/footerbg2000.gif')">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background-color: #999999; height: 1px;">
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
