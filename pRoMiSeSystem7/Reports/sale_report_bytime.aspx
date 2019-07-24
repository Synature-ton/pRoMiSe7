<%@ Page Language="VB" ContentType="text/html" EnableViewState="False" debug="True" %>
<%@ Register tagPrefix="Web" Namespace="WebChart" Assembly="WebChart" %>
<%@ Import Namespace="System.Drawing" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<%@ Register tagprefix="synature" Tagname="time" Src="../UserControls/Time.ascx" %>

<html>
<head>
<title>Sale Reports By Time</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script language="JavaScript" src="../StyleSheet/webscript.js"></script>
</head>
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<input type="hidden" id="ShopIDList" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="HeaderText" Text="Sale Report By Time" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
	</td>
	<td width="1" nowrap rowspan="99" bgcolor="003366"><img src="../images/clear.gif" height="1" width="1"></td>
</tr>
<tr bgcolor="666666">
	<td width="3%" height="1"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	<td width="94%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="252"></p></td>
	<td width="3%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	
</tr>
<tr><td height="10" colspan="3">&nbsp;</td></tr>
<tr>
<td>&nbsp;</td>
<td>
<div class="noprint">
<table>
<tr id="ShowShop" runat="server">
	<td valign="top">
		<table>
			<tr>
				<td><span id="ShopText" runat="server"></span></td>
			</tr>
			<tr id="bbb" visible="false" runat="Server">
				<td><asp:radiobutton ID="Radio_11" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
			<tr>
				<td><asp:radiobutton ID="Radio_12" GroupName="Group2" CssClass="text" runat="server" />
				    <asp:dropdownlist ID="ByProductGroupByParam" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
			</tr>
			<tr id="showOption" visible="false" runat="server">
				<td><asp:radiobutton ID="Radio_13" GroupName="Group2" CssClass="text" runat="server" />
				<asp:dropdownlist ID="GroupByParam" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
			</tr>
			<tr>
				<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
			</tr>
		</table></td>
	<td>
	<table>
		<tr>
			<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
			<td><synature:date id="DailyDate" runat="server" /></td>
			<td colspan="2"><asp:CheckBox ID="ExpandReceipt" CssClass="text" Checked="false" Visible="false" runat="server" /></td>
		</tr>
		<tr>
			<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
			<td colspan="3"><synature:date id="MonthYearDate" runat="server" /></td>
		</tr>
		<tr id="showYearOption" visible="false" runat="Server">
			<td><asp:radiobutton ID="Radio_4" GroupName="Group1" runat="server" /></td>
			<td colspan="3"><synature:date id="YearDate" runat="server" /></td>
		</tr>
		<tr>
			<td><asp:radiobutton ID="Radio_2" GroupName="Group1" runat="server" /></td>
			<td><synature:date id="CurrentDate" runat="server" /></td>
			<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
			<td><synature:date id="ToDate" runat="server" /></td>
		</tr>
		<tr>
			<td></td>
			<td><synature:time id="FromTime" runat="server" /></td>
			<td class="text"><div id="ToTimeParam" class="text" runat="server"></div></td>
			<td><synature:time id="ToTime" runat="server" /></td>
		</tr>
		<tr id="aaa" visible="false" runat="Server"><td>&nbsp;</td>
			<td colspan="4"><asp:CheckBox ID="DisplayGraph" CssClass="text" Checked="false" Visible="false" runat="server" /></td>
		</tr>
	</table>
	</td>
</tr>
</table>
</div>

<div id="showResults" visible="false" runat="server">
<table width="100%">

<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr>
</table>
<span id="MyTable">
<table width="100%">

<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>
<span id="startTable" runat="server"></span>
	<tr>
	<span id="TableHeaderText" runat="server"></span>
	<span id="ExtraHeader" runat="server"></span>
	</tr>
	
	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>

<asp:Panel ID="showGraph" Visible="false" runat="server">
<br>
<Web:ChartControl id="ChartControl1" ChartPadding=40 runat="Server" />
</asp:Panel></td></tr>
</table></span>
<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table>
</div>
</form>
</div>
<div id="errorMsg" runat="server" />
</td>
<td>&nbsp;</td>
</tr>

<tr><td colspan="3" height="30">&nbsp;</td></tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
<tr>
	<td height="50" colspan="3" background="../images/footerbg2000.gif">&nbsp;</td>
</tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
</table>
<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer = 6

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Sale_Report_ByTime") Then
		
            Try
                objCnn = getCnn.EstablishConnection()

                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
                ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
                Dim z As Integer
		
                If Not Request.QueryString("ToLangID") Is Nothing Then
                    If IsNumeric(Request.QueryString("ToLangID")) Then
                        Session("LangID") = Request.QueryString("ToLangID")
                    End If
                End If
		
                Dim CultureString As String = Util.GetCultureByLangID(Session("LangID"), objCnn)
                Dim PageName As String = System.IO.Path.GetFileName(Request.ServerVariables("SCRIPT_NAME"))
                Dim LangListText As String = ""
                Dim LangListData As DataTable
                Dim LangData As DataTable = getProp.GetLang(LangListText, LangListData, PageName & "?ID" & Request.QueryString("ID") & "&Order=" + Request.QueryString("Order") & "&GroupID=" & Request.QueryString("GroupID"), PageID, 1, -1, Request, objCnn)
                Dim LangText As String = "lang" + Session("LangID").ToString
		
                For z = 0 To LangData.Rows.Count - 1
                    Dim TestLabel = Util.FindControlRecursive(mainForm, "LangText" & z)
                    Try
                        TestLabel.Text = LangData.Rows(z)(LangText)
                    Catch ex As Exception
                    End Try
                Next
                LangList.Text = LangListText
		
                Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
		
                Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
                If LangDefault.Rows.Count >= 2 Then
                    PrintText.Text = LangDefault.Rows(0)(LangText)
                    Export.Text = LangDefault.Rows(1)(LangText)
                End If

                SubmitForm.Text = LangDefault.Rows(3)(LangText)
		
                HeaderText.Text = LangData2.Rows(118)(LangText)
                Dim i As Integer
                ResultText.InnerHtml = ""
                ResultSearchText.InnerHtml = ""
                errorMsg.InnerHtml = ""
                ExtraHeader.InnerHtml = ""
		
                Dim HeaderString As String = ""
		
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(33)(LangText) + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(34)(LangText) + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(36)(LangText) + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(37)(LangText) + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(35)(LangText) + "</td>"
		
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(38)(LangText) + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(35)(LangText) + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(39)(LangText) + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(40)(LangText) + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(35)(LangText) + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>"
                TableHeaderText.InnerHtml = HeaderString
		
                If Radio_3.Checked = True And (Radio_11.Checked = True Or Radio_13.Checked = True) And ExpandReceipt.Checked = True And Request.Form("ShopID") <> 0 Then
                    startTable.InnerHtml = "<table border=""0"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
                Else
                    startTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
                End If

                GroupByParam.Items(0).Text = "Group By Day of Week"
                GroupByParam.Items(0).Value = "1"
                GroupByParam.Items(1).Text = "Group By Time"
                GroupByParam.Items(1).Value = "2"
                If Request.Form("GroupByParam") = 1 Then
                    GroupByParam.Items(0).Selected = True
                ElseIf Request.Form("GroupByParam") = 2 Then
                    GroupByParam.Items(1).Selected = True
                Else
                    GroupByParam.Items(0).Selected = True
                End If
		
                ByProductGroupByParam.Items(0).Text = "By Open Time"
                ByProductGroupByParam.Items(0).Value = "1"
                ByProductGroupByParam.Items(1).Text = "By Paid Time"
                ByProductGroupByParam.Items(1).Value = "2"
                If Request.Form("ByProductGroupByParam") = 1 Then
                    ByProductGroupByParam.Items(0).Selected = True
                ElseIf Request.Form("ByProductGroupByParam") = 2 Then
                    ByProductGroupByParam.Items(1).Selected = True
                Else
                    ByProductGroupByParam.Items(0).Selected = True
                End If
		
                ExpandReceipt.Text = "Show Receipt Details"
                DisplayGraph.Text = "Display Graph for Monthly Report and Date Range Report"
		
                DocumentToDateParam.InnerHtml = LangDefault.Rows(22)(LangText)
                ToTimeParam.InnerHtml = LangDefault.Rows(22)(LangText)
			
                DailyDate.YearType = GlobalParam.YearType
                DailyDate.FormName = "DocDaily"
                DailyDate.StartYear = GlobalParam.StartYear
                DailyDate.EndYear = GlobalParam.EndYear
                DailyDate.LangID = Session("LangID")
                DailyDate.Lang_Data = LangDefault
                DailyDate.Culture = CultureString
		
                CurrentDate.YearType = GlobalParam.YearType
                CurrentDate.FormName = "Doc"
                CurrentDate.StartYear = GlobalParam.StartYear
                CurrentDate.EndYear = GlobalParam.EndYear
                CurrentDate.LangID = Session("LangID")
                CurrentDate.Lang_Data = LangDefault
                CurrentDate.Culture = CultureString
		
                ToDate.YearType = GlobalParam.YearType
                ToDate.FormName = "DocTo"
                ToDate.StartYear = GlobalParam.StartYear
                ToDate.EndYear = GlobalParam.EndYear
                ToDate.LangID = Session("LangID")
                ToDate.Lang_Data = LangDefault
                ToDate.Culture = CultureString
		
                MonthYearDate.YearType = GlobalParam.YearType
                MonthYearDate.FormName = "MonthYearDate"
                MonthYearDate.StartYear = GlobalParam.StartYear
                MonthYearDate.EndYear = GlobalParam.EndYear
                MonthYearDate.LangID = Session("LangID")
                MonthYearDate.ShowDay = False
                MonthYearDate.Lang_Data = LangDefault
                MonthYearDate.Culture = CultureString
		
                YearDate.YearType = GlobalParam.YearType
                YearDate.FormName = "YearDate"
                YearDate.StartYear = GlobalParam.StartYear
                YearDate.EndYear = GlobalParam.EndYear
                YearDate.LangID = Session("LangID")
                YearDate.ShowDay = False
                YearDate.ShowMonth = False
                YearDate.Lang_Data = LangDefault
                YearDate.Culture = CultureString
		
                FromTime.LangID = Session("LangID")
                FromTime.FormName = "FromTime"
                FromTime.SelectedHour = -1
                FromTime.SelectedMinute = -1
                FromTime.Lang_Data = LangDefault
		
                ToTime.LangID = Session("LangID")
                ToTime.FormName = "ToTime"
                ToTime.SelectedHour = -1
                ToTime.SelectedMinute = -1
                ToTime.Lang_Data = LangDefault
		
                Radio_11.Text = LangData2.Rows(0)(LangText)
                Radio_12.Text = LangData2.Rows(1)(LangText)
		
		
		
                If IsNumeric(Request.Form("DocDaily_Day")) Then
                    Session("DocDailyDay") = Request.Form("DocDaily_Day")
                ElseIf IsNumeric(Request.QueryString("DocDaily_Day")) Then
                    Session("DocDailyDay") = Request.QueryString("DocDaily_Day")
                ElseIf Trim(Session("DocDailyDay")) = "" Then
                    Session("DocDailyDay") = DateTime.Now.Day
                ElseIf Trim(Session("DocDailyDay")) = 0 And Not Page.IsPostBack Then
                    Session("DocDailyDay") = DateTime.Now.Day
                End If
                If Page.IsPostBack And Request.Form("DocDaily_Day") = "" Then Session("DocDailyDay") = 0
                DailyDate.SelectedDay = Session("DocDailyDay")
		
		
                If IsNumeric(Request.Form("DocDaily_Month")) Then
                    Session("DocDaily_Month") = Request.Form("DocDaily_Month")
                ElseIf IsNumeric(Request.QueryString("DocDaily_Month")) Then
                    Session("DocDaily_Month") = Request.QueryString("DocDaily_Month")
                ElseIf Trim(Session("DocDaily_Month")) = "" Then
                    Session("DocDaily_Month") = DateTime.Now.Month
                ElseIf Trim(Session("DocDaily_Month")) = 0 And Not Page.IsPostBack Then
                    Session("DocDaily_Month") = DateTime.Now.Month
                End If
                If Page.IsPostBack And Request.Form("DocDaily_Month") = "" Then Session("DocDaily_Month") = 0
                DailyDate.SelectedMonth = Session("DocDaily_Month")
		
                If IsNumeric(Request.Form("DocDaily_Year")) Then
                    Session("DocDaily_Year") = Request.Form("DocDaily_Year")
                ElseIf IsNumeric(Request.QueryString("DocDaily_Year")) Then
                    Session("DocDaily_Year") = Request.QueryString("DocDaily_Year")
                ElseIf Trim(Session("DocDaily_Year")) = "" Then
                    Session("DocDaily_Year") = DateTime.Now.Year
                ElseIf Trim(Session("DocDaily_Year")) = 0 And Not Page.IsPostBack Then
                    Session("DocDaily_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("DocDaily_Year") = "" Then Session("DocDaily_Year") = 0
                DailyDate.SelectedYear = Session("DocDaily_Year")
		
                If IsNumeric(Request.Form("Doc_Day")) Then
                    Session("DocDay") = Request.Form("Doc_Day")
                ElseIf IsNumeric(Request.QueryString("Doc_Day")) Then
                    Session("DocDay") = Request.QueryString("Doc_Day")
                ElseIf Trim(Session("DocDay")) = "" Then
                    Session("DocDay") = DateTime.Now.Day
                ElseIf Trim(Session("DocDay")) = 0 And Not Page.IsPostBack Then
                    Session("DocDay") = DateTime.Now.Day
                End If
                If Page.IsPostBack And Request.Form("Doc_Day") = "" Then Session("DocDay") = 0
                CurrentDate.SelectedDay = Session("DocDay")
		
		
                If IsNumeric(Request.Form("Doc_Month")) Then
                    Session("Doc_Month") = Request.Form("Doc_Month")
                ElseIf IsNumeric(Request.QueryString("Doc_Month")) Then
                    Session("Doc_Month") = Request.QueryString("Doc_Month")
                ElseIf Trim(Session("Doc_Month")) = "" Then
                    Session("Doc_Month") = DateTime.Now.Month
                ElseIf Trim(Session("Doc_Month")) = 0 And Not Page.IsPostBack Then
                    Session("Doc_Month") = DateTime.Now.Month
                End If
                If Page.IsPostBack And Request.Form("Doc_Month") = "" Then Session("Doc_Month") = 0
                CurrentDate.SelectedMonth = Session("Doc_Month")
		
                If IsNumeric(Request.Form("Doc_Year")) Then
                    Session("Doc_Year") = Request.Form("Doc_Year")
                ElseIf IsNumeric(Request.QueryString("Doc_Year")) Then
                    Session("Doc_Year") = Request.QueryString("Doc_Year")
                ElseIf Trim(Session("Doc_Year")) = "" Then
                    Session("Doc_Year") = DateTime.Now.Year
                ElseIf Trim(Session("Doc_Year")) = 0 And Not Page.IsPostBack Then
                    Session("Doc_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("Doc_Year") = "" Then Session("Doc_Year") = 0
                CurrentDate.SelectedYear = Session("Doc_Year")
		
                If IsNumeric(Request.Form("DocTo_Day")) Then
                    Session("DocTo_Day") = Request.Form("DocTo_Day")
                ElseIf IsNumeric(Request.QueryString("DocTo_Day")) Then
                    Session("DocTo_Day") = Request.QueryString("DocTo_Day")
                ElseIf Trim(Session("DocTo_Day")) = "" Then
                    Session("DocTo_Day") = DateTime.Now.Day
                ElseIf Trim(Session("DocTo_Day")) = 0 And Not Page.IsPostBack Then
                    Session("DocTo_Day") = DateTime.Now.Day
                End If
                If Page.IsPostBack And Request.Form("DocTo_Day") = "" Then Session("DocTo_Day") = 0
                ToDate.SelectedDay = Session("DocTo_Day")
		
		
                If IsNumeric(Request.Form("DocTo_Month")) Then
                    Session("DocTo_Month") = Request.Form("DocTo_Month")
                ElseIf IsNumeric(Request.QueryString("DocTo_Month")) Then
                    Session("DocTo_Month") = Request.QueryString("DocTo_Month")
                ElseIf Trim(Session("DocTo_Month")) = "" Then
                    Session("DocTo_Month") = DateTime.Now.Month
                ElseIf Trim(Session("DocTo_Month")) = 0 And Not Page.IsPostBack Then
                    Session("DocTo_Month") = DateTime.Now.Month
                End If
                If Page.IsPostBack And Request.Form("DocTo_Month") = "" Then Session("DocTo_Month") = 0
                ToDate.SelectedMonth = Session("DocTo_Month")
		
                If IsNumeric(Request.Form("DocTo_Year")) Then
                    Session("DocTo_Year") = Request.Form("DocTo_Year")
                ElseIf IsNumeric(Request.QueryString("DocTo_Year")) Then
                    Session("DocTo_Year") = Request.QueryString("DocTo_Year")
                ElseIf Trim(Session("DocTo_Year")) = "" Then
                    Session("DocTo_Year") = DateTime.Now.Year
                ElseIf Trim(Session("DocTo_Year")) = 0 And Not Page.IsPostBack Then
                    Session("DocTo_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("DocTo_Year") = "" Then Session("DocTo_Year") = 0
                ToDate.SelectedYear = Session("DocTo_Year")
		
                If IsNumeric(Request.Form("MonthYearDate_Day")) Then
                    Session("MonthYearDate_Day") = Request.Form("MonthYearDate_Day")
                ElseIf IsNumeric(Request.QueryString("MonthYearDate_Day")) Then
                    Session("MonthYearDate_Day") = Request.QueryString("MonthYearDate_Day")
                ElseIf Trim(Session("MonthYearDate_Day")) = "" Then
                    Session("MonthYearDate_Day") = DateTime.Now.Day
                ElseIf Trim(Session("MonthYearDate_Day")) = 0 And Not Page.IsPostBack Then
                    Session("MonthYearDate_Day") = DateTime.Now.Day
                End If
                If Page.IsPostBack And Request.Form("MonthYearDate_Day") = "" Then Session("MonthYearDate_Day") = 0
                MonthYearDate.SelectedDay = Session("MonthYearDate_Day")
		
		
                If IsNumeric(Request.Form("MonthYearDate_Month")) Then
                    Session("MonthYearDate_Month") = Request.Form("MonthYearDate_Month")
                ElseIf IsNumeric(Request.QueryString("MonthYearDate_Month")) Then
                    Session("MonthYearDate_Month") = Request.QueryString("MonthYearDate_Month")
                ElseIf Trim(Session("MonthYearDate_Month")) = "" Then
                    Session("MonthYearDate_Month") = DateTime.Now.Month
                ElseIf Trim(Session("MonthYearDate_Month")) = 0 And Not Page.IsPostBack Then
                    Session("MonthYearDate_Month") = DateTime.Now.Month
                End If
                If Page.IsPostBack And Request.Form("MonthYearDate_Month") = "" Then Session("MonthYearDate_Month") = 0
                MonthYearDate.SelectedMonth = Session("MonthYearDate_Month")
		
                If IsNumeric(Request.Form("MonthYearDate_Year")) Then
                    Session("MonthYearDate_Year") = Request.Form("MonthYearDate_Year")
                ElseIf IsNumeric(Request.QueryString("MonthYearDate_Year")) Then
                    Session("MonthYearDate_Year") = Request.QueryString("MonthYearDate_Year")
                ElseIf Trim(Session("MonthYearDate_Year")) = "" Then
                    Session("MonthYearDate_Year") = DateTime.Now.Year
                ElseIf Trim(Session("MonthYearDate_Year")) = 0 And Not Page.IsPostBack Then
                    Session("MonthYearDate_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("MonthYearDate_Year") = "" Then Session("MonthYearDate_Year") = 0
                MonthYearDate.SelectedYear = Session("MonthYearDate_Year")
		
                If IsNumeric(Request.Form("YearDate_Year")) Then
                    Session("YearDate_Year") = Request.Form("YearDate_Year")
                ElseIf IsNumeric(Request.QueryString("YearDate_Year")) Then
                    Session("YearDate_Year") = Request.QueryString("YearDate_Year")
                ElseIf Trim(Session("YearDate_Year")) = "" Then
                    Session("YearDate_Year") = DateTime.Now.Year
                ElseIf Trim(Session("YearDate_Year")) = 0 And Not Page.IsPostBack Then
                    Session("YearDate_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("YearDate_Year") = "" Then Session("YearDate_Year") = 0
                YearDate.SelectedYear = Session("YearDate_Year")
		
                If IsNumeric(Request.Form("FromTime_Hour")) Then
                    FromTime.SelectedHour = Request.Form("FromTime_Hour")
                End If
                If IsNumeric(Request.Form("FromTime_Minute")) Then
                    FromTime.SelectedMinute = Request.Form("FromTime_Minute")
                End If
                If IsNumeric(Request.Form("ToTime_Hour")) Then
                    ToTime.SelectedHour = Request.Form("ToTime_Hour")
                End If
                If IsNumeric(Request.Form("ToTime_Minute")) Then
                    ToTime.SelectedMinute = Request.Form("ToTime_Minute")
                End If
		
                If Not Page.IsPostBack Then
                    Radio_3.Checked = True
                    Radio_12.Checked = True
                End If

                Dim ShopIDValue As String = "0"
                If IsNumeric(Request.Form("ShopID")) Then
                    ShopIDValue = Request.Form("ShopID").ToString
                ElseIf IsNumeric(Request.QueryString("ShopID")) Then
                    ShopIDValue = Request.QueryString("ShopID").ToString
                End If

                Dim outputString, FormSelected As String
                Dim Multiple As Boolean = False
                Dim ShopList As String = ""
		
                Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), objCnn)
                If ShopData.Rows.Count > 0 Then

                    outputString = "<select name=""ShopID"">"
                    'If ShopData.Rows.Count > 1 Then
                    'If Not Page.IsPostBack Then 
                    'FormSelected = "selected"
                    'ElseIf ShopIDValue = 0 Then
                    'FormSelected = "selected"
                    'Else
                    '	'FormSelected = ""
                    'End If
                    'outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & "--- All Shops ---"
                    'Multiple = True
                    'End If
                    For i = 0 To ShopData.Rows.Count - 1
                        If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
                            FormSelected = "selected"
                            SelShopName.Value = ShopData.Rows(i)("ProductLevelName")
                        Else
                            If Not Page.IsPostBack And i = 0 And Multiple = False Then
                                FormSelected = "selected"
                            Else
                                FormSelected = ""
                            End If
                        End If
                        outputString += "<option value=""" & ShopData.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & ShopData.Rows(i)("ProductLevelName")
                        ShopList += "," + ShopData.Rows(i)("ProductLevelID").ToString
                    Next
                    outputString += "</select>"
                    ShopText.InnerHtml = outputString
                    ShowShop.Visible = True
                    ShopList = "0" + ShopList
                    ShopIDList.Value = ShopList
                Else
                    ShowShop.Visible = False
                End If
				
            Catch ex As Exception
                errorMsg.InnerHtml = ex.Message
            End Try
	  
        Else
            showPage.Visible = False
            errorMsg.InnerHtml = "Access Denied"
        End If
    End Sub

    Sub DoSearch(Source As Object, E As EventArgs)
        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
        Dim FoundError As Boolean
        FoundError = False
        Session("ReportResult") = ""
        Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
	
        Dim DateFromValue As String = ""
        Dim DateToValue As String = ""
        Dim DailyDateValue As String = ""
        Dim InvC As CultureInfo = CultureInfo.InvariantCulture
        Dim AdditionalHeader As String = ""
        Dim PayTypeList As DataTable
	
        Dim StartDate, EndDate As String
        Dim StartMonthValue, StartYearValue, EndMonthValue, EndYearValue As Integer
        Dim outputString As String = ""
        Dim grandTotal As Double = 0
        Dim VATTotal As Double = 0
        Dim groupParam As Integer
        Dim strReport As String
        Dim bolUsePaidTime As Boolean
        Dim GraphData As New DataSet()
        Dim ReportDate As String
        Dim YearValue4 As Integer
        Dim R1, R2, R3, R4, R11, R12, R13 As Boolean
	
        R1 = False
        R2 = False
        R3 = False
        R4 = False
        If Request.Form("Group1") = "Radio_1" Then
            R1 = True
        ElseIf Request.Form("Group1") = "Radio_2" Then
            R2 = True
        ElseIf Request.Form("Group1") = "Radio_3" Then
            R3 = True
        Else
            R4 = True
        End If
	
        If Request.Form("Group2") = "Radio_11" Then
            R11 = True
        ElseIf Request.Form("Group2") = "Radio_12" Then
            R12 = True
        ElseIf Request.Form("Group2") = "Radio_13" Then
            R13 = True
        End If
	
        Dim ExpReceipt As Boolean = False
        If Request.Form("ExpandReceipt") = "on" Then ExpReceipt = True
	
        Dim DGraph As Boolean = False
        If Request.Form("DisplayGraph") = "on" Then DGraph = True
	
        If R1 = True Then
            Try
                If Request.Form("MonthYearDate_Month") = 12 Then
                    StartMonthValue = Request.Form("MonthYearDate_Month")
                    EndMonthValue = 1
                    StartYearValue = Request.Form("MonthYearDate_Year")
                    EndYearValue = Request.Form("MonthYearDate_Year") + 1
                Else
                    StartMonthValue = Request.Form("MonthYearDate_Month")
                    EndMonthValue = Request.Form("MonthYearDate_Month") + 1
                    StartYearValue = Request.Form("MonthYearDate_Year")
                    EndYearValue = Request.Form("MonthYearDate_Year")
                End If
                StartDate = DateTimeUtil.FormatDate(1, StartMonthValue, StartYearValue)
                EndDate = DateTimeUtil.FormatDate(1, EndMonthValue, EndYearValue)
                Dim SDate As New Date(StartYearValue, StartMonthValue, 1)
                ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy", Session("LangID"), objCnn)
            Catch ex As Exception
                FoundError = True
            End Try
        ElseIf R2 = True Then
            Try
                StartDate = DateTimeUtil.FormatDate(Request.Form("Doc_Day"), Request.Form("Doc_Month"), Request.Form("Doc_Year"))
                Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
                CheckDate = DateAdd("d", 1, CheckDate)
                EndDate = DateTimeUtil.FormatDate(Day(CheckDate), Month(CheckDate), CheckDate.ToString("yyyy", InvC))
		
                If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
                    ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
                    FoundError = True
                    DateFromValue = ""
                    DateToValue = ""
                    DailyDateValue = ""
                Else
                    ResultSearchText.InnerHtml = ""
                    Dim SDate1 As New Date(Request.Form("Doc_Year"), Request.Form("Doc_Month"), Request.Form("Doc_Day"))
                    Dim EDate1 As New Date(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"))
                    ReportDate = DateTimeUtil.FormatDateTime(SDate1, "DateOnly", Session("LangID"), objCnn) + " - " + DateTimeUtil.FormatDateTime(EDate1, "DateOnly", Session("LangID"), objCnn)
                End If
            Catch ex As Exception
                FoundError = True
            End Try
        ElseIf R3 = True Then
            Try
                StartDate = DateTimeUtil.FormatDate(Request.Form("DocDaily_Day"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Year"))
                Dim CheckDate As New DateTime(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"), 0, 0, 0)
                CheckDate = DateAdd("d", 1, CheckDate)
                EndDate = DateTimeUtil.FormatDate(Day(CheckDate), Month(CheckDate), CheckDate.ToString("yyyy", InvC))

                If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
                    ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
                    FoundError = True
                    DateFromValue = ""
                    DateToValue = ""
                    DailyDateValue = ""
                Else
                    ResultSearchText.InnerHtml = ""
                    Dim SDate2 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
                    ReportDate = DateTimeUtil.FormatDateTime(SDate2, "DateOnly", Session("LangID"), objCnn)
                End If
            Catch ex As Exception
                FoundError = True
            End Try
        ElseIf R4 = True Then
            Try
                StartDate = DateTimeUtil.FormatDate(1, 1, Request.Form("YearDate_Year"))
		 
                YearValue4 = Request.Form("YearDate_Year") + 1
                EndDate = DateTimeUtil.FormatDate(1, 1, YearValue4)
                Dim SDate4 As New Date(Request.Form("YearDate_Year"), 1, 1)
                ReportDate = DateTimeUtil.FormatDateTime(SDate4, "yyyy", Session("LangID"), objCnn)
            Catch ex As Exception
                FoundError = True
            End Try
        Else
            DateFromValue = ""
            DateToValue = ""
            DailyDateValue = ""
        End If
        If FoundError = False Then
            If LangDefault.Rows.Count >= 3 Then
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(Now(), "DateAndTime", Session("LangID"), objCnn)
            End If
            Dim displayTable As New DataTable()
		
            ShowPrint.Visible = True
            showResults.Visible = True
		
            Dim ViewOption As Integer
            If R1 = True Then
                ViewOption = 1
            ElseIf R2 = True Then
                ViewOption = 2
            ElseIf R4 = True Then
                ViewOption = 4
            Else
                ViewOption = 0
            End If
            Dim ReportTime As String
            If IsNumeric(Request.Form("FromTime_Hour")) And IsNumeric(Request.Form("FromTime_Minute")) And IsNumeric(Request.Form("ToTime_Hour")) And IsNumeric(Request.Form("ToTime_Minute")) Then
                ReportTime = " " + LangData2.Rows(119)(LangText) + " " + Request.Form("FromTime_Hour") + ":" + Request.Form("FromTime_Minute") + " " + LangData2.Rows(120)(LangText) + " " + Request.Form("ToTime_Hour") + ":" + Request.Form("ToTime_Minute")
            ElseIf IsNumeric(Request.Form("FromTime_Hour")) And IsNumeric(Request.Form("FromTime_Minute")) Then
                ReportTime = " " + LangData2.Rows(121)(LangText) + " " + Request.Form("FromTime_Hour") + ":" + Request.Form("FromTime_Minute")
            ElseIf IsNumeric(Request.Form("ToTime_Hour")) And IsNumeric(Request.Form("ToTime_Minute")) Then
                ReportTime = " " + LangData2.Rows(122)(LangText) + " " + Request.Form("ToTime_Hour") + ":" + Request.Form("ToTime_Minute")
            Else
                ReportTime = ""
            End If
            'Application.Lock()
            
            If R12 = True Then
                groupParam = Request.Form("ByProductGroupByParam")
                If groupParam = 2 Then
                    bolUsePaidTime = True
                Else
                    bolUsePaidTime = False
                End If
            Else
                groupParam = Request.Form("GroupByParam")
                If groupParam = 3 Then
                    bolUsePaidTime = True
                Else
                    bolUsePaidTime = False
                End If
            End If
            Dim LangPath As String = Util.GetLangPath(Request.PhysicalApplicationPath)
            ResultText.InnerHtml = getReport.SaleReports(PayTypeList, outputString, grandTotal, VATTotal, GraphData, True, GlobalParam.GrayBGColor, _
                                              GlobalParam.AdminBGColor, Session("LangID"), ViewOption, R11, R12, R13, groupParam, StartDate, EndDate, _
                                              Request.Form("FromTime_Hour"), Request.Form("FromTime_Minute"), Request.Form("ToTime_Hour"), Request.Form("ToTime_Minute"), _
                                              Request.Form("ShopID"), 0, 0, True, ExpReceipt, DGraph, LangPath, objCnn)
		
            Dim ShopDisplay As String
            If Request.Form("ShopID") = 0 Then
                ShopDisplay = LangData2.Rows(70)(LangText)
            Else
                ShopDisplay = SelShopName.Value
            End If
            strReport = LangData2.Rows(123)(LangText) & ShopDisplay & " (" + ReportDate + ReportTime + ")"
            If bolUsePaidTime = True Then
                strReport &= " (By PaidTime) "
            Else
                strReport &= " (By OpenTime) "
            End If
            ResultSearchText.InnerHtml = strReport
            
            
            Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"
            DGraph = True
            'Application.UnLock()
            
            If DGraph = True Then
                showGraph.Visible = True
                Dim view As DataView = GraphData.Tables(0).DefaultView
                If view.Count > 0 Then
                    Dim chart As New PieChart()
                    chart.Explosion = 3
                    chart.Fill.Color = Color.FromArgb(80, Color.SpringGreen)
                    chart.Line.Color = Color.SteelBlue
                    chart.Line.Width = 1
                    chart.ShowLegend = True
                    chart.DataLabels.Visible = True
                    chart.DataSource = view
                    chart.DataXValueField = "Description"
                    chart.DataYValueField = "Value1"
                    chart.DataBind()
                    ChartControl1.Charts.Add(chart)
                    ConfigureColors(LangData2.Rows(123)(LangText) + " " + ShopDisplay + " (" + ReportDate + ReportTime + ")")
        
                    ChartControl1.RedrawChart()
                End If
            Else
                showGraph.Visible = False
            End If
        End If

    End Sub

 Sub ConfigureColors(TitleName)
        	'ChartControl1.Background.Color = Color.FromArgb(75, Color.SteelBlue)
			Dim ChartWidth As Integer = 650
			Dim ChartHeight As Integer = 500
			If Request.Form("Group2") = "Radio_13" Then
				If Request.Form("GroupByParam") = 1 Then
					ChartWidth = 500
					ChartHeight = 350
				Else
					ChartWidth = 600
					ChartHeight = 400
				End If
			End If
            ChartControl1.Background.Type = InteriorType.LinearGradient
            ChartControl1.Background.ForeColor = Color.SteelBlue
            ChartControl1.Background.EndPoint = new Point(ChartWidth, ChartHeight) 
            ChartControl1.Legend.Position = LegendPosition.Bottom
            'ChartControl1.Legend.Width = 40
			ChartControl1.Width = Unit.Parse(ChartWidth.ToString + "px")
			ChartControl1.Height = Unit.Parse(ChartHeight.ToString + "px")
 
            ChartControl1.YAxisFont.ForeColor = Color.SteelBlue
            ChartControl1.XAxisFont.ForeColor = Color.SteelBlue
            
            ChartControl1.ChartTitle.Text = TitleName
            ChartControl1.ChartTitle.ForeColor = Color.White
      
            ChartControl1.Border.Color = Color.SteelBlue
            'ChartControl1.BorderStyle = BorderStyle.Ridge
    End Sub


Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "SaleByTimeData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub	

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
