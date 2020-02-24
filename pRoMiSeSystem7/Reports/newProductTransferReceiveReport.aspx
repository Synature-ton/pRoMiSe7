<%@ page language="C#" autoeventwireup="true" inherits="Reports_newProductTransferReceiveReport, App_Web_newproducttransferreceivereport.aspx.dfa151d5" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>New Material Transafer Receive Report</title>

    <script src="../javascript/JQuery/jquery-1.6.2.js" type="text/javascript"></script>

    <script src="../javascript/JQuery/jquery-1.6.2.min.js" type="text/javascript"></script>

    <script src="../javascript/JQuery/jquery.js" type="text/javascript"></script>

    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        #webDataGrid
        {
            max-width: 980px;
        }
        .NumberHeaderStyle
        {
            text-align: right;
            vertical-align: bottom;
            height: 30px;
        }
        .TextHeaderStyle
        {
            text-align: left;
            vertical-align: bottom;
            height: 30px;
        }
        .NumberStyle
        {
            text-align: right;
            vertical-align: bottom;
            height: 30px;
        }
        .TextStyle
        {
            text-align: left;
            vertical-align: bottom;
            height: 30px;
        }
        .style1
        {
            width: 660px;
        }
    </style>
</head>
<body <% = GlobalParam.BodyProp %>>
    <form id="frmNewMaterialTransferReceiveReport" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="true" EnableScriptLocalization="true" AsyncPostBackTimeout="500000">
    </asp:ScriptManager>
    <table bgcolor="White" cellpadding="0" cellspacing="0">
        <tr style="background-color: #EEEEEE">
            <td height="35" style="background-image: url('../images/headerstub.jpg')">
                &nbsp; &nbsp;
            </td>
            <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                <div>
                    <asp:Label ID="Label1" runat="server" Text="" CssClass="headerText"></asp:Label>
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
                                    <asp:Label ID="Label6" runat="server" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddListDocumentType" runat="server" AutoPostBack="true" Width="200" 
                                        onselectedindexchanged="ddListDocumentType_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td align="right">
                                    <asp:Label ID="Label3" runat="server" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddListMaterialGroup" runat="server" Width="200" AutoPostBack="true" OnSelectedIndexChanged="ddListMaterialGroup_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label8" runat="server" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddListReportView" runat="server" Width="200">
                                    </asp:DropDownList>
                                </td>
                                <td align="right">
                                    <asp:Label ID="Label5" runat="server" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddListMaterialDept" runat="server" Width="200" AutoPostBack="true" OnSelectedIndexChanged="ddListMaterialDept_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddListDocumentStatus" runat="server" Width="200">
                                    </asp:DropDownList>
                                </td>
                                <td align="right">
                                    <asp:Label ID="Label7" runat="server" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddListMaterials" runat="server" Width="200">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label4" runat="server" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddListInventory" runat="server" Width="200" AutoPostBack="true" 
                                        onselectedindexchanged="ddListInventory_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td align="right">
                                    <asp:Label ID="Label15" runat="server" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddListToInventory" runat="server" Width="200">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label9" runat="server" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtStartDate" Width="150" runat="server"></asp:TextBox><asp:Image
                                        ID="ImStartDate" runat="server" ImageUrl="~/Images/Calendar_scheduleHS.png" />
                                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" PopupButtonID="ImStartDate"
                                        TargetControlID="txtStartDate" FirstDayOfWeek="Sunday" Format="yyyy-MM-dd">
                                    </cc1:CalendarExtender>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please select date"
                                        ControlToValidate="txtStartDate" Display="Dynamic" InitialValue="" SetFocusOnError="True"
                                        ValidationGroup="p2">
                                    </asp:RequiredFieldValidator>
                                </td>
                                <td align="right">
                                    <asp:Label ID="Label10" runat="server" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddListVendorGroup" runat="server" Width="200" AutoPostBack="true" OnSelectedIndexChanged="ddListVendorGroup_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label11" runat="server" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEndDate" Width="150" runat="server"></asp:TextBox><asp:Image
                                        ID="ImEndDate" runat="server" ImageUrl="~/Images/Calendar_scheduleHS.png" />
                                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" PopupButtonID="ImEndDate"
                                        TargetControlID="txtEndDate" FirstDayOfWeek="Sunday" Format="yyyy-MM-dd">
                                    </cc1:CalendarExtender>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please select date"
                                        ControlToValidate="txtEndDate" Display="Dynamic" InitialValue="" SetFocusOnError="True"
                                        ValidationGroup="p2">
                                    </asp:RequiredFieldValidator>
                                </td>
                                <td align="right">
                                    <asp:Label ID="Label12" runat="server" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddListVendor" runat="server" Width="200">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label13" runat="server" Text=""></asp:Label>
                                </td>
                                <td colspan="3">
                                    <asp:TextBox ID="txtSearch" Width="400" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label14" runat="server" Text=""></asp:Label>
                                </td>
                                <td colspan="3">
                                    <asp:RadioButtonList ID="radioViewType" runat="server" RepeatDirection="Horizontal" >
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td colspan="3">
                                    <asp:Button ID="btnReport" ValidationGroup="p2" runat="server" Text="" OnClick="btnReport_Click" OnClientClick="btnClick();" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <table id="tbReport" style="min-width: 980px">
                    <tbody class="text">
                        <tr>
                            <td>
                                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Export to Excel</asp:LinkButton>
                                <asp:Label ID="lblExportTab" runat="server">  ||  </asp:Label>
                                <asp:LinkButton ID="lbtExportCSV" runat="server" OnClick="lbtExportCSV_Click">Export as CSV format</asp:LinkButton>
                                <div id="showReport" runat="server">
                                </div>
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
