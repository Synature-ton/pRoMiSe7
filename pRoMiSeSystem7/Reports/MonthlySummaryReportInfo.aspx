<%@ page language="VB" autoeventwireup="false" inherits="Reposts_MonthlySummaryReportInfo, App_Web_monthlysummaryreportinfo.aspx.dfa151d5" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
--%><html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>MonthlySummaryReport</title>
   <%--<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />--%>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/style.css" rel="stylesheet" type="text/css" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGridResult">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridResult" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ViewReport">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridResult" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px"
        Width="75px" Transparency="25">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0;" />
    </telerik:RadAjaxLoadingPanel>
    <div>
        <asp:DropDownList ID="ddlProductLevel" runat="server" Width="170px">
        </asp:DropDownList>
        <asp:DropDownList ID="ddlMonth" runat="server" Width="170px">
        </asp:DropDownList>
        <asp:DropDownList ID="ddlYear" runat="server" Width="100px">
        </asp:DropDownList>
        <asp:Button ID="ViewReport" runat="server" Text="View Report" />
        <asp:Button ID="ExportToExcel" runat="server" Text="Export to Excel" />
    </div>
    <br />
    <div>
        <telerik:RadGrid ID="RadGridResult" runat="server" GridLines="None" Skin="Office2007"
            Height="550px" Width="100%">
            <ExportSettings FileName="MonthlySummaryReport" IgnorePaging="True" Excel-Format="Html">
            </ExportSettings>
            <MasterTableView Width="100%">
                <RowIndicatorColumn>
                    <HeaderStyle Width="20px" Height="30px"></HeaderStyle>
                </RowIndicatorColumn>
                <ExpandCollapseColumn>
                    <HeaderStyle Width="20px" Height="30px"></HeaderStyle>
                </ExpandCollapseColumn>
                <GroupByExpressions>
                    <telerik:GridGroupByExpression>
                        <SelectFields>
                            <telerik:GridGroupByField FieldAlias=":" FieldName="GroupName"></telerik:GridGroupByField>
                        </SelectFields>
                        <GroupByFields>
                            <telerik:GridGroupByField FieldName="GroupID" SortOrder="Ascending"></telerik:GridGroupByField>
                        </GroupByFields>
                    </telerik:GridGroupByExpression>
                </GroupByExpressions>
            </MasterTableView>
            <ClientSettings>
                <Scrolling AllowScroll="True" UseStaticHeaders="True" FrozenColumnsCount="2" />
            </ClientSettings>
            <FilterMenu EnableTheming="True">
                <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
            </FilterMenu>
        </telerik:RadGrid>
    </div>
    </form>
</body>
</html>
