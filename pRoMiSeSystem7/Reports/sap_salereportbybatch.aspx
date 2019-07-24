<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="sap_salereportbybatch.aspx.vb"
    Inherits="InterfaceData.sap_salereportbybatch" %>

<html>
<head id="Head1" runat="server">
    <title>Sale Report by Batch</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />

    <script language="JavaScript" src="../StyleSheet/webscript.js"></script>

</head>
<body>
    <form id="form1" runat="server">
    <table bgcolor="White" cellpadding="0" cellspacing="0">
        <tr style="background-color: #EEEEEE">
            <td height="35" style="background-image: url('../images/headerstub.jpg')">
                &nbsp; &nbsp;
            </td>
            <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                <div>
                    <asp:Label ID="Label1" runat="server" Text="Summary Sale Report By Batch" CssClass="headerText"></asp:Label></div>
            </td>
            <td rowspan="99" style="background-color: #003366; width: 1px;">
                <img src="../images/clear.gif" height="1px" width="1px">
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
            <td>
                <table class="noprint">
                    <tr>
                        <td>
                            <span>Select Shop:</span>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlShop" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:RadioButton ID="rdb1" runat="server" GroupName="r1" Checked="true" />
                        </td>
                        <td>
                            <div id="date_byday" runat="server" style="float: left;">
                            </div>
                            <asp:CheckBox ID="chkshowdetail" runat="server" Text="Show Receipt Details" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <asp:Button ID="btnShowReport" runat="server" Text="Generate Report" />
                        </td>
                        <td>
                            <asp:RadioButton ID="rdb2" runat="server" GroupName="r1" />
                        </td>
                        <td>
                            <div id="date_bymonth" runat="server" style="float: left;">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <asp:RadioButton ID="rdb3" runat="server" GroupName="r1" />
                        </td>
                        <td>
                            <div id="date_startdate" runat="server" style="float: left;">
                            </div>
                            <div id="date_enddate" runat="server" style="float: left;">
                            </div>
                        </td>
                    </tr>
                </table>
                <br />
                <div class="noprint">
                    <a href="javascript: window.print()"><span id="PrintText">Print Report</span></a>
                    | <a id="Export" href="javascript:__doPostBack('Export','')">Export to Excel</a></div>
                <span id="MyTable"><span id="startTable" runat="server"></span>
                    <div style="width: 100%; text-align: center;">
                        <p>
                            <span id="OutputStringHeader" runat="server" class="boldText"></span>
                        </p>
                    </div>
                    <div style="width: 100%;">
                        <span id="OutputString" runat="server"></span>
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
