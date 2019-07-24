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
				<td><span id="ReceiptTypeText" runat="server"></span></td>
			</tr>
			<tr>
				<td><span id="ShopText" runat="server"></span></td>
			</tr>
			<tr id="bbb" visible="false" runat="Server">
				<td><asp:radiobutton ID="Radio_11" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
			<tr>
				<td><asp:radiobutton ID="Radio_12" GroupName="Group2" CssClass="text" runat="server" /></td>
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
Dim Fm As New POSMySQL.POSControl.UtilityFunction
Dim PageID As Integer = 6

Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Sale_Report_ByTime") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()

		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
		Dim z As Integer
		
		If NOT Request.QueryString("ToLangID") Is Nothing Then
			If IsNumeric(Request.QueryString("ToLangID")) Then
				Session("LangID") = Request.QueryString("ToLangID")
			End If
		End If
		
		Dim CultureString As String = Util.GetCultureByLangID(Session("LangID"), objCnn)
		Dim PageName as string = System.IO.Path.GetFileName(Request.ServerVariables("SCRIPT_NAME"))
		Dim LangListText As String = ""
		Dim LangListData As DataTable
		Dim LangData As DataTable = getProp.GetLang(LangListText,LangListData,PageName & "?ID" & Request.QueryString("ID") & "&Order=" + Request.QueryString("Order") & "&GroupID=" & Request.QueryString("GroupID"),PageID,1,-1,Request,objCnn)
		Dim LangText As String = "lang" + Session("LangID").ToString
		
		For z = 0 To LangData.Rows.Count - 1
			Dim TestLabel =	Util.FindControlRecursive(mainForm,"LangText" & z)
			Try
				TestLabel.Text = LangData.Rows(z)(LangText)
			Catch ex As Exception
			End Try
		Next
		LangList.Text = LangListText
		
		Dim LangData2 As DataTable = getProp.GetLangData(PageID,2,-1,Request)
		
		Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
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
		
		If Radio_3.Checked = True AND (Radio_11.Checked = True Or Radio_13.Checked = True) And ExpandReceipt.Checked = True AND Request.Form("ShopID") <> 0 Then
			StartTable.InnerHtml = "<table border=""0"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		Else
			StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
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
		Else If IsNumeric(Request.QueryString("DocDaily_Day")) Then 
			Session("DocDailyDay") = Request.QueryString("DocDaily_Day")
		Else If Trim(Session("DocDailyDay")) = "" Then
			Session("DocDailyDay") = DateTime.Now.Day
		Else If Trim(Session("DocDailyDay")) = 0 And Not Page.IsPostBack Then
			Session("DocDailyDay") = DateTime.Now.Day
		End If
		If Page.IsPostBack AND Request.Form("DocDaily_Day") = "" Then Session("DocDailyDay") = 0
		DailyDate.SelectedDay = Session("DocDailyDay")
		
		
		If IsNumeric(Request.Form("DocDaily_Month")) Then 
			Session("DocDaily_Month") = Request.Form("DocDaily_Month")
		Else If IsNumeric(Request.QueryString("DocDaily_Month")) Then 
			Session("DocDaily_Month") = Request.QueryString("DocDaily_Month")
		Else If Trim(Session("DocDaily_Month")) = "" Then
			Session("DocDaily_Month") = DateTime.Now.Month
		Else If Trim(Session("DocDaily_Month")) = 0 And Not Page.IsPostBack Then
			Session("DocDaily_Month") = DateTime.Now.Month
		End If
		If Page.IsPostBack AND Request.Form("DocDaily_Month") = "" Then Session("DocDaily_Month") = 0
		DailyDate.SelectedMonth = Session("DocDaily_Month")
		
		If IsNumeric(Request.Form("DocDaily_Year")) Then 
			Session("DocDaily_Year") = Request.Form("DocDaily_Year")
		Else If IsNumeric(Request.QueryString("DocDaily_Year")) Then 
			Session("DocDaily_Year") = Request.QueryString("DocDaily_Year")
		Else If Trim(Session("DocDaily_Year")) = "" Then
			Session("DocDaily_Year") = DateTime.Now.Year
		Else If Trim(Session("DocDaily_Year")) = 0 And Not Page.IsPostBack Then
			Session("DocDaily_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("DocDaily_Year") = "" Then Session("DocDaily_Year") = 0
		DailyDate.SelectedYear = Session("DocDaily_Year")
		
		If IsNumeric(Request.Form("Doc_Day")) Then 
			Session("DocDay") = Request.Form("Doc_Day")
		Else If IsNumeric(Request.QueryString("Doc_Day")) Then 
			Session("DocDay") = Request.QueryString("Doc_Day")
		Else If Trim(Session("DocDay")) = "" Then
			Session("DocDay") = DateTime.Now.Day
		Else If Trim(Session("DocDay")) = 0 And Not Page.IsPostBack Then
			Session("DocDay") = DateTime.Now.Day
		End If
		If Page.IsPostBack AND Request.Form("Doc_Day") = "" Then Session("DocDay") = 0
		CurrentDate.SelectedDay = Session("DocDay")
		
		
		If IsNumeric(Request.Form("Doc_Month")) Then 
			Session("Doc_Month") = Request.Form("Doc_Month")
		Else If IsNumeric(Request.QueryString("Doc_Month")) Then 
			Session("Doc_Month") = Request.QueryString("Doc_Month")
		Else If Trim(Session("Doc_Month")) = "" Then
			Session("Doc_Month") = DateTime.Now.Month
		Else If Trim(Session("Doc_Month")) = 0 And Not Page.IsPostBack Then
			Session("Doc_Month") = DateTime.Now.Month
		End If
		If Page.IsPostBack AND Request.Form("Doc_Month") = "" Then Session("Doc_Month") = 0
		CurrentDate.SelectedMonth = Session("Doc_Month")
		
		If IsNumeric(Request.Form("Doc_Year")) Then 
			Session("Doc_Year") = Request.Form("Doc_Year")
		Else If IsNumeric(Request.QueryString("Doc_Year")) Then 
			Session("Doc_Year") = Request.QueryString("Doc_Year")
		Else If Trim(Session("Doc_Year")) = "" Then
			Session("Doc_Year") = DateTime.Now.Year
		Else If Trim(Session("Doc_Year")) = 0 And Not Page.IsPostBack Then
			Session("Doc_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("Doc_Year") = "" Then Session("Doc_Year") = 0
		CurrentDate.SelectedYear = Session("Doc_Year")
		
		If IsNumeric(Request.Form("DocTo_Day")) Then 
			Session("DocTo_Day") = Request.Form("DocTo_Day")
		Else If IsNumeric(Request.QueryString("DocTo_Day")) Then 
			Session("DocTo_Day") = Request.QueryString("DocTo_Day")
		Else If Trim(Session("DocTo_Day")) = "" Then
			Session("DocTo_Day") = DateTime.Now.Day
		Else If Trim(Session("DocTo_Day")) = 0 And Not Page.IsPostBack Then
			Session("DocTo_Day") = DateTime.Now.Day
		End If
		If Page.IsPostBack AND Request.Form("DocTo_Day") = "" Then Session("DocTo_Day") = 0
		ToDate.SelectedDay = Session("DocTo_Day")
		
		
		If IsNumeric(Request.Form("DocTo_Month")) Then 
			Session("DocTo_Month") = Request.Form("DocTo_Month")
		Else If IsNumeric(Request.QueryString("DocTo_Month")) Then 
			Session("DocTo_Month") = Request.QueryString("DocTo_Month")
		Else If Trim(Session("DocTo_Month")) = "" Then
			Session("DocTo_Month") = DateTime.Now.Month
		Else If Trim(Session("DocTo_Month")) = 0 And Not Page.IsPostBack Then
			Session("DocTo_Month") = DateTime.Now.Month
		End If
		If Page.IsPostBack AND Request.Form("DocTo_Month") = "" Then Session("DocTo_Month") = 0
		ToDate.SelectedMonth = Session("DocTo_Month")
		
		If IsNumeric(Request.Form("DocTo_Year")) Then 
			Session("DocTo_Year") = Request.Form("DocTo_Year")
		Else If IsNumeric(Request.QueryString("DocTo_Year")) Then 
			Session("DocTo_Year") = Request.QueryString("DocTo_Year")
		Else If Trim(Session("DocTo_Year")) = "" Then
			Session("DocTo_Year") = DateTime.Now.Year
		Else If Trim(Session("DocTo_Year")) = 0 And Not Page.IsPostBack Then
			Session("DocTo_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("DocTo_Year") = "" Then Session("DocTo_Year") = 0
		ToDate.SelectedYear = Session("DocTo_Year")
		
		If IsNumeric(Request.Form("MonthYearDate_Day")) Then 
			Session("MonthYearDate_Day") = Request.Form("MonthYearDate_Day")
		Else If IsNumeric(Request.QueryString("MonthYearDate_Day")) Then 
			Session("MonthYearDate_Day") = Request.QueryString("MonthYearDate_Day")
		Else If Trim(Session("MonthYearDate_Day")) = "" Then
			Session("MonthYearDate_Day") = DateTime.Now.Day
		Else If Trim(Session("MonthYearDate_Day")) = 0 And Not Page.IsPostBack Then
			Session("MonthYearDate_Day") = DateTime.Now.Day
		End If
		If Page.IsPostBack AND Request.Form("MonthYearDate_Day") = "" Then Session("MonthYearDate_Day") = 0
		MonthYearDate.SelectedDay = Session("MonthYearDate_Day")
		
		
		If IsNumeric(Request.Form("MonthYearDate_Month")) Then 
			Session("MonthYearDate_Month") = Request.Form("MonthYearDate_Month")
		Else If IsNumeric(Request.QueryString("MonthYearDate_Month")) Then 
			Session("MonthYearDate_Month") = Request.QueryString("MonthYearDate_Month")
		Else If Trim(Session("MonthYearDate_Month")) = "" Then
			Session("MonthYearDate_Month") = DateTime.Now.Month
		Else If Trim(Session("MonthYearDate_Month")) = 0 And Not Page.IsPostBack Then
			Session("MonthYearDate_Month") = DateTime.Now.Month
		End If
		If Page.IsPostBack AND Request.Form("MonthYearDate_Month") = "" Then Session("MonthYearDate_Month") = 0
		MonthYearDate.SelectedMonth = Session("MonthYearDate_Month")
		
		If IsNumeric(Request.Form("MonthYearDate_Year")) Then 
			Session("MonthYearDate_Year") = Request.Form("MonthYearDate_Year")
		Else If IsNumeric(Request.QueryString("MonthYearDate_Year")) Then 
			Session("MonthYearDate_Year") = Request.QueryString("MonthYearDate_Year")
		Else If Trim(Session("MonthYearDate_Year")) = "" Then
			Session("MonthYearDate_Year") = DateTime.Now.Year
		Else If Trim(Session("MonthYearDate_Year")) = 0 And Not Page.IsPostBack Then
			Session("MonthYearDate_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("MonthYearDate_Year") = "" Then Session("MonthYearDate_Year") = 0
		MonthYearDate.SelectedYear = Session("MonthYearDate_Year")
		
		If IsNumeric(Request.Form("YearDate_Year")) Then 
			Session("YearDate_Year") = Request.Form("YearDate_Year")
		Else If IsNumeric(Request.QueryString("YearDate_Year")) Then 
			Session("YearDate_Year") = Request.QueryString("YearDate_Year")
		Else If Trim(Session("YearDate_Year")) = "" Then
			Session("YearDate_Year") = DateTime.Now.Year
		Else If Trim(Session("YearDate_Year")) = 0 And Not Page.IsPostBack Then
			Session("YearDate_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("YearDate_Year") = "" Then Session("YearDate_Year") = 0
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
		Else If IsNumeric(Request.QueryString("ShopID"))
			ShopIDValue = Request.QueryString("ShopID").ToString
		End If

		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		Dim Multiple As Boolean = False
		Dim ShopList As String = ""
		
		Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
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
			For i = 0 to ShopData.Rows.Count - 1
				If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
					FormSelected = "selected"
					SelShopName.Value = ShopData.Rows(i)("ProductLevelName")
				Else
					If Not Page.IsPostBack And i=0 And Multiple = False Then
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

		'Load Receipt Type Combo
		Dim ReceiptTypeValue As String = "1"
		If IsNumeric(Request.Form("ReceiptType")) Then
			ReceiptTypeValue = Request.Form("ReceiptType").ToString
		Else If IsNumeric(Request.QueryString("ReceiptType"))
			ReceiptTypeValue = Request.QueryString("ReceiptType").ToString
		End If
		Select Case Cint(ReceiptTypeValue)
			Case > 3
				ReceiptTypeValue = "1"
			Case <= 0 
				ReceiptTypeValue = "1"
		End Select 
		outputString = "<select name=""ReceiptType"">"
		If ReceiptTypeValue = "1" Then
			FormSelected = "selected"
		Else
			FormSelected = ""
		End If
		outputString += "<option value=""" & "1" & """ " & FormSelected & ">" & "Sale"
		If ReceiptTypeValue = "2" Then
			FormSelected = "selected"
		Else
			FormSelected = ""
		End If
		outputString += "<option value=""" & "2" & """ " & FormSelected & ">" & "Non Sale"
		If ReceiptTypeValue = "3" Then
			FormSelected = "selected"
		Else
			FormSelected = ""
		End If
		outputString += "<option value=""" & "3" & """ " & FormSelected & ">" & "Sale + Non Sale"
		ReceiptTypeText.InnerHtml = outputString
				
		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
	  
	Else
		showPage.Visible = False
		errorMsg.InnerHtml = "Access Denied"
	End If
End Sub

Sub DoSearch(Source As Object, E As EventArgs)
	Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
	Dim FoundError As Boolean
	FoundError = False
	Session("ReportResult") = ""
	Dim LangData2 As DataTable = getProp.GetLangData(PageID,2,-1,Request)
	Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
	Dim LangText As String = "lang" + Session("LangID").ToString
	
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""
	Dim DailyDateValue As String = ""
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	Dim AdditionalHeader As String = ""
	Dim PayTypeList As DataTable
	Dim i As Integer
	
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
	Dim outputString As String = ""
	Dim grandTotal As Double = 0
	Dim VATTotal As Double = 0
	Dim GraphData As New DataSet()
	Dim ReportDate As String
	Dim YearValue4 As Integer
	Dim R1,R2,R3,R4,R11,R12,R13 As Boolean
	
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
		StartDate = DateTimeUtil.FormatDate(1,StartMonthValue,StartYearValue)
		EndDate = DateTimeUtil.FormatDate(1,EndMonthValue,EndYearValue)
		Dim SDate As New Date(StartYearValue,StartMonthValue,1)
		ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy",Session("LangID"),objCnn)
		Catch ex As Exception
			FoundError = True
		End Try
	ElseIf R2 = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(Request.Form("Doc_Day"),Request.Form("Doc_Month"),Request.Form("Doc_Year"))
		Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))
		
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
			ReportDate = DateTimeUtil.FormatDateTime(SDate1, "DateOnly",Session("LangID"),objCnn) + " - " + DateTimeUtil.FormatDateTime(EDate1, "DateOnly",Session("LangID"),objCnn)
		End If
		Catch ex As Exception
			FoundError = True
		End Try
	Else If R3 = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(Request.Form("DocDaily_Day"),Request.Form("DocDaily_Month"),Request.Form("DocDaily_Year"))
		Dim CheckDate As New DateTime(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"), 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))

		If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
			FoundError = True
			DateFromValue = ""
			DateToValue = ""
			DailyDateValue = ""
		Else
			ResultSearchText.InnerHtml = ""
			Dim SDate2 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
			ReportDate = DateTimeUtil.FormatDateTime(SDate2, "DateOnly",Session("LangID"),objCnn)
		End If
		Catch ex As Exception
			FoundError = True
		End Try
	Else If R4 = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(1,1,Request.Form("YearDate_Year"))
		 
		YearValue4 = Request.Form("YearDate_Year") + 1
		EndDate = DateTimeUtil.FormatDate(1,1,YearValue4)
		Dim SDate4 As New Date(Request.Form("YearDate_Year"),1,1)
		ReportDate = DateTimeUtil.FormatDateTime(SDate4, "yyyy",Session("LangID"),objCnn)
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
			CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(NOW(), "DateAndTime",Session("LangID"),objCnn)
		End If
		Dim displayTable As New DataTable()
		
		ShowPrint.Visible = True
		ShowResults.Visible = True
		
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
		If IsNumeric(Request.Form("FromTime_Hour")) AND IsNumeric(Request.Form("FromTime_Minute")) AND IsNumeric(Request.Form("ToTime_Hour")) AND IsNumeric(Request.Form("ToTime_Minute")) Then
			ReportTime = " " + LangData2.Rows(119)(LangText) + " " + Request.Form("FromTime_Hour") + ":" + Request.Form("FromTime_Minute") + " " + LangData2.Rows(120)(LangText) + " " + Request.Form("ToTime_Hour") + ":" + Request.Form("ToTime_Minute")
		ElseIf IsNumeric(Request.Form("FromTime_Hour")) AND IsNumeric(Request.Form("FromTime_Minute"))
			ReportTime = " " + LangData2.Rows(121)(LangText) + " " + Request.Form("FromTime_Hour") + ":" + Request.Form("FromTime_Minute")
		ElseIf IsNumeric(Request.Form("ToTime_Hour")) AND IsNumeric(Request.Form("ToTime_Minute"))
			ReportTime = " " + LangData2.Rows(122)(LangText) + " " + Request.Form("ToTime_Hour") + ":" + Request.Form("ToTime_Minute")
		Else
			ReportTime = ""
		End If

		Dim receiptSaleType as Integer
		If Not IsNumeric(Request.Form("ReceiptType")) Then
			Request.Form("ReceiptType") = 1
		End If 
		receiptSaleType = Request.Form("ReceiptType") 

		'Application.Lock()
		

		Dim LangPath As String = Util.GetLangPath(Request.PhysicalApplicationPath)
		ResultText.InnerHtml = SaleReports(PayTypeList,outputString, grandTotal, VATTotal, GraphData, receiptSaleType,True,GlobalParam.GrayBGColor,GlobalParam.AdminBGColor,Session("LangID"),ViewOption,R11, R12, R13, Request.Form("GroupByParam"), StartDate, EndDate, Request.Form("FromTime_Hour"), Request.Form("FromTime_Minute"), Request.Form("ToTime_Hour"),Request.Form("ToTime_Minute"), Request.Form("ShopID"),0,0,True,ExpReceipt, DGraph, LangPath, objCnn)

		Dim strDisplaySaleType as String
		Dim ShopDisplay As String
		If Request.Form("ShopID") = 0 Then
			ShopDisplay = LangData2.Rows(70)(LangText)
		Else
			ShopDisplay = SelShopName.Value
		End If
		Select Case receiptSaleType
			Case 2
				strDisplaySaleType = " - Non Sale"
			Case 3
				strDisplaySaleType = " - Sale + Non Sale"
			Case Else
				strDisplaySaleType = ""
		End Select 
		ResultSearchText.InnerHtml = LangData2.Rows(123)(LangText) + " " + ShopDisplay + " (" + ReportDate + ReportTime + ")" & strDisplaySaleType
		
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
	
  Public Function SaleReports(ByRef PayTypeList As DataTable, ByRef outputString As String, ByRef grandTotal As Double, ByRef VATTotal As Double, ByRef GraphData As DataSet, receiptSaleNonSaleType As Integer, ByVal ShowSummary As Boolean, ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal LangID As Integer, ByVal ViewOption As Integer, ByVal ReportByBill As Boolean, ByVal ReportByProduct As Boolean, ByVal ReportByTime As Boolean, ByVal GroupByParam As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal StartTimeHour As String, ByVal StartTimeMinute As String, ByVal EndTimeHour As String, ByVal EndTimeMinute As String, ByVal ShopID As Integer, ByVal TransactionID As Integer, ByVal ComputerID As Integer, ByVal DisplaySummary As Boolean, ByVal ExpandReceipt As Boolean, ByVal DisplayGraph As Boolean, ByVal LangPath As String, ByVal objCnn As MySqlConnection) As String

        Dim sqlStatement, sqlStatement1, sqlStatement2, WhereString, WString, ExtraSql, ExtraSelect As String
        Dim strTransStatus As String
        Dim AdditionalQuery As String = ""
        Dim ShopIDListValue As String = ""
        Dim ResultString As String = ""
        Dim TextClass As String
        Dim GetData As DataTable
        Dim PayTypeData As DataTable

        Dim BranchStr, StrBefore As String
        Dim ii As Integer
        Dim getProp As New CPreferences

        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
        If PropertyInfo.Rows(0)("ImportDataToCopyTable") = 1 Then
            For ii = 1 To 4 - Len(ShopID.ToString)
                StrBefore = StrBefore & "0"
            Next
            BranchStr = StrBefore & ShopID.ToString
        Else
            BranchStr = ""
        End If
        Dim PName As String = "p." + getReport.ProductNameForReport(LangID, objCnn) + " As ProductName"
        Dim PName2 As String = "p." + getReport.ProductNameForReport(LangID, objCnn)
        Dim SaleModePName As String = "IF(b.SaleMode = 1," + PName2 + ",IF(sm.PositionPrefix=0,CONCAT(sm.PrefixText," + PName2 + "),CONCAT(" + PName2 + ",sm.PrefixText))) As ProductName"

        Dim NotInRevenueBit As Boolean = False
        Try
            NotInRevenueBit = PropertyInfo.Rows(0)("EnableNotInRevenue")
        Catch ex As Exception
            NotInRevenueBit = False
        End Try

        If ShopID = 0 Then
            Dim getInfo As New CCategory
            Dim ShopData As DataTable = getInfo.GetProductLevel(-999, objCnn)
            For ii = 0 To ShopData.Rows.Count - 1
                ShopIDListValue += "," + ShopData.Rows(ii)("ProductLevelID").ToString
            Next
            If ShopIDListValue <> "" Then ShopIDListValue = "0" + ShopIDListValue
        Else
            ShopIDListValue = ShopID.ToString
        End If

        If TransactionID > 0 And ComputerID > 0 Then
            AdditionalQuery += " AND ( a.TransactionID = " + TransactionID.ToString + " AND a.ComputerID = " + ComputerID.ToString + ")"
            strTransStatus = " "
        Else
            'AdditionalQuery += " AND a.DocType IN (4,8)"
            Select Case receiptSaleNonSaleType
                Case 2          'Non Sale
                    strTransStatus = " AND a.TransactionStatusID = 11 "
                    AdditionalQuery += " AND a.DocType NOT IN (4,8)"
                Case 3          'Sale + Non Sale
                    strTransStatus = " AND a.TransactionStatusID IN (2,11) "
                    AdditionalQuery += " "
                Case Else       'Sale 
                    strTransStatus = " AND a.TransactionStatusID = 2 "
                    AdditionalQuery += " AND a.DocType IN (4,8)"
            End Select
        End If

        If ShopID > 0 Then
            AdditionalQuery += " AND a.ShopID IN (" + ShopIDListValue + ")"
            WhereString += " AND ShopID IN (" + ShopIDListValue + ")"
            WString += " AND a.ShopID IN (" + ShopIDListValue + ")"
        End If

        If StartDate <> "" And EndDate <> "" Then
            AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
            WhereString += " AND (PayDate >= " + StartDate + " AND PayDate < " + EndDate + ")"
            WString += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
        End If

        Dim StartTime As String = ""
        Dim EndTime As String = ""
        Dim TimeString As String = ""
        If IsNumeric(StartTimeHour) And IsNumeric(StartTimeMinute) Then
            StartTime = StartTimeHour + ":" + StartTimeMinute + ":0"
            'AdditionalQuery += " AND ( TIME_TO_SEC(a.OpenTime) >= TIME_TO_SEC('" + StartTime + "') )"
            'TimeString +=  " AND ( TIME_TO_SEC(a.OpenTime) >= TIME_TO_SEC('" + StartTime + "') )"
            AdditionalQuery += " AND ( TIME_TO_SEC(a.PaidTime) >= TIME_TO_SEC('" + StartTime + "') )"
            TimeString += " AND ( TIME_TO_SEC(a.PaidTime) >= TIME_TO_SEC('" + StartTime + "') )"
        End If
        If IsNumeric(EndTimeHour) And IsNumeric(EndTimeMinute) Then
            EndTime = EndTimeHour + ":" + EndTimeMinute + ":0"
            'AdditionalQuery += " AND ( TIME_TO_SEC(a.OpenTime) <= TIME_TO_SEC('" + EndTime + "') )"
            'TimeString += " AND ( TIME_TO_SEC(a.OpenTime) <= TIME_TO_SEC('" + EndTime + "') )"
            AdditionalQuery += " AND ( TIME_TO_SEC(a.PaidTime) <= TIME_TO_SEC('" + EndTime + "') )"
            TimeString += " AND ( TIME_TO_SEC(a.PaidTime) <= TIME_TO_SEC('" + EndTime + "') )"
        End If

        If Trim(WhereString) = "" Then
            WhereString = " AND 0=1"
            WString = " AND 0=1"
        End If
        Dim OrderBy As String = " a.DocType,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID,b.OrderDetailID,d.PayTypeID"
        Dim ExtraTableString As String = Now.Year.ToString + Now.Month.ToString + Now.Day.ToString + Now.Hour.ToString + Now.Minute.ToString + Now.Second.ToString + Now.Millisecond.ToString
        sqlStatement = "select sum(payamount) AS TotalPay, sum(PaymentVAT) AS TotalVAT, a.PayTypeID,b.PayType AS PayTypeName from paybycreditmoney" + BranchStr + " a left outer join paytype b ON a.PayTypeID=b.TypeID where a.CreditMoneyStatusID=2 " + WhereString + " group by a.PayTypeID,b.PayType order by a.PayTypeID,b.PayType"
        Dim PayByCreditMoney As DataTable = objDB.List(sqlStatement, objCnn)

        sqlStatement2 = "select * from BankName where 0=1"
        PayTypeList = getReport.GetSalePayType(ShopID.ToString, StartDate, EndDate, objCnn)

        ExtraSql = ""
        ExtraSelect = ""

        If ReportByProduct = True Or (ReportByBill = True And ShopID > 0 And ViewOption = 0 And ExpandReceipt = True) Then

            sqlStatement = "select a.TransactionID,a.ComputerID,b.VATType,NoCustomer,SUM(c.SalePrice) AS TotalExcludePrice " & _
                        "FROM OrderTransaction" + BranchStr + " a, OrderDetail" + BranchStr + " b, OrderDiscountDetail" + BranchStr + " c " & _
                        " WHERE a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.OrderDetailID=c.OrderDetailID AND b.TransactionID=c.TransactionID AND " & _
                        " b.ComputerID=c.ComputerID AND a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3,14,16) " + AdditionalQuery + " GROUP BY a.TransactionID,a.ComputerID,b.VATType,NoCustomer"

            objDB.sqlExecute("DROP TABLE IF EXISTS DummySaleReport", objCnn)

            objDB.sqlExecute("create table DummySaleReport (TransactionID int, ComputerID int, VATType tinyint, NoCustomer int ,TotalProductSale decimal(18,4))", objCnn)

            objDB.sqlExecute("insert into DummySaleReport " + sqlStatement, objCnn)

            If ReportByProduct = True Then
                Dim OrderingProduct As String = "p.ProductName"
                If Trim(StartTimeHour) <> "" Then
                    ' OrderingProduct = StartTimeHour
                End If
                objDB.sqlExecute("DROP TABLE IF EXISTS DummyGroupOrdering_" + ExtraTableString, objCnn)
                objDB.sqlExecute("create table DummyGroupOrdering_" + ExtraTableString + " (GroupOrdering int NOT NULL AUTO_INCREMENT PRIMARY KEY, ProductGroupCode varchar(100))", objCnn)
                objDB.sqlExecute("insert into DummyGroupOrdering_" + ExtraTableString + " (ProductGroupCode) select distinct(ProductGroupCode) from ProductGroup order by ProductGroupCode", objCnn)

                objDB.sqlExecute("DROP TABLE IF EXISTS DummyDeptOrdering_" + ExtraTableString, objCnn)
                objDB.sqlExecute("create table DummyDeptOrdering_" + ExtraTableString + " (DeptOrdering int NOT NULL AUTO_INCREMENT PRIMARY KEY, ProductDeptCode varchar(100))", objCnn)
                objDB.sqlExecute("insert into DummyDeptOrdering_" + ExtraTableString + " (ProductDeptCode) select distinct(ProductDeptCode) from ProductDept order by ProductDeptCode", objCnn)

                sqlStatement = "SELECT ld.ProductID As ProductIDLink,a.TransactionStatusID,b.OtherFoodName,b.OrderStatusID,b.ProductSetType,b.VATType, p.ProductCode," + SaleModePName + ", pd.ProductDeptName,pg.ProductGroupName,pg.ProductGroupCode,pd.ProductDeptCode,g1.GroupOrdering,d1.DeptOrdering,b.SaleMode,sm.SaleModeName,sm.PositionPrefix,sm.PrefixText,SUM(b.Amount) AS Amount,SUM(c.TotalPrice) AS TotalPrice,SUM(IF(b.ProductSetType>=0,c.TotalRetailPrice,IF(b.ProductSetType=-4,c.SalePrice,0))) AS TotalRetailPrice,SUM(SalePrice) AS SalePrice, SUM(c.MemberDiscount) AS MemberDiscount, SUM(c.StaffDiscount) AS StaffDiscount, SUM(c.CouponDiscount) AS CouponDiscount, SUM(c.VoucherDiscount) AS VoucherDiscount, SUM(c.OtherPercentDiscount) AS OtherPercentDiscount, SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount, SUM(c.PricePromotionDiscount) AS PricePromotionDiscount FROM ordertransaction" + BranchStr + " a inner join orderdetail" + BranchStr + " b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID inner join orderdiscountdetail" + BranchStr + " c ON b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND b.OrderDetailID=c.OrderDetailID left outer join Products p ON b.ProductID=p.ProductID left outer join ProductDept pd ON p.ProductDeptID=pd.ProductDeptID left outer join ProductGroup pg ON pd.ProductGroupID=pg.ProductGroupID left outer join DummyGroupOrdering_" + ExtraTableString + " g1 on pg.ProductGroupCode=g1.ProductGroupCode left outer join DummyDeptOrdering_" + ExtraTableString + " d1 ON pd.ProductDeptCode=d1.ProductDeptCode left outer join SaleMode sm ON b.SaleMode=sm.SaleModeID left outer join OrderProductLinkDetail ld ON b.OrderDetailID=ld.OrderDetailID AND b.TransactionID=ld.TransactionID AND b.ComputerID=ld.ComputerID WHERE a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3,14,16) " + AdditionalQuery & strTransStatus & "  GROUP BY ld.ProductID,a.TransactionStatusID,b.OtherFoodName,b.OrderStatusID,b.ProductSetType,b.VATType, p.ProductCode,p.ProductName, pd.ProductDeptName,pg.ProductGroupName,pg.ProductGroupCode,pd.ProductDeptCode,b.SaleMode,sm.SaleModeName,sm.PositionPrefix,sm.PrefixText ORDER BY g1.GroupOrdering,d1.DeptOrdering," + OrderingProduct
				
                sqlStatement1 = "select c.TypeID as PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT, IsOtherReceipt from ordertransaction" + BranchStr + " a, paydetail" + BranchStr + " b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and IF(b.SmartcardType > 0,b.SmartcardType,b.PayTypeID)=c.TypeID " + AdditionalQuery & strTransStatus & " group by b.PayTypeID,c.PayType,IsSale, IsVAT, IsOtherReceipt order by b.PayTypeID,c.PayType,IsSale DESC"
				
                GetData = objDB.List(sqlStatement, objCnn)
                outputString = ""
                grandTotal = 0
                SaleReportByProduct(GraphData, outputString, grandTotal, VATTotal, receiptSaleNonSaleType, ShowSummary, GrayBGColor, AdminBGColor, ShopID, ViewOption, StartDate, EndDate, GetData, objDB.List(sqlStatement1, objCnn), PayByCreditMoney, LangID, LangPath, TimeString, objCnn)
                objDB.sqlExecute("DROP TABLE IF EXISTS DummyGroupOrdering_" + ExtraTableString, objCnn)
                objDB.sqlExecute("DROP TABLE IF EXISTS DummyDeptOrdering_" + ExtraTableString, objCnn)

                Return outputString
            Else
                sqlStatement = "SELECT c.OtherPercentDiscount AS OPercentDiscount, d.Amount AS AmountPaid, d.PaymentVAT AS AmountPaidVAT,a.TransactionID AS TID, a.ComputerID AS CID, b.OrderDetailID AS OID, a.*,b.OrderDetailID,b.ProductID,b.OtherFoodName,b.OrderStatusID,b.ProductSetType,b.Amount,b.VATType,b.StaffID AS ServiceStaffID,b.SubRoomID,b.StartTime,b.DurationTime,b.Price,IF(b.ProductSetType=-4,b.Price,b.RetailPrice) As RetailPrice,c.*,d.*,e.PayType,e.PayTypeCode,e.IsSale,e.IsVAT,e.IsOtherReceipt, CONCAT(s.StaffFirstName, ' ', s.StaffLastName) AS ReceivedBy, CONCAT(sv.StaffFirstName, ' ', sv.StaffLastName) AS VoidedBy, CONCAT(sd.StaffFirstName, ' ', sd.StaffLastName) AS StaffDiscountName, CONCAT(m.MemberFirstName, ' ', m.MemberLastName) AS MemberName,f.TotalProductSale, a.TransactionVAT-a.TransactionExcludeVAT AS TransactionIncludeVAT, IF(b.VATType=1 , IF(a.TransactionVAT = 0, c.SalePrice-(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale),(c.SalePrice-(a.TransactionVAT-a.TransactionExcludeVAT-ServiceChargeVAT)*c.SalePrice/f.TotalProductSale)-(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale)), IF(b.VATType=2 and a.TransactionVAT=0,c.SalePrice+(a.TransactionExcludeVAT*c.SalePrice/f.TotalProductSale)-(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale),c.SalePrice-(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale))) AS SalePriceBeforeVAT, IF(b.VATType=1, IF(a.TransactionVAT = 0, 0, (a.TransactionVAT-a.TransactionExcludeVAT-ServiceChargeVAT)*c.SalePrice/f.TotalProductSale), IF(b.VATType=2,IF(a.TransactionVAT = 0, 0, a.TransactionExcludeVAT*c.SalePrice/f.TotalProductSale),0)) AS ProductVAT, p.ProductCode," + SaleModePName + ",bn.BankName AS CCBankName,cct.CreditCardType AS CCTypeName, c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale AS CompensateOtherDiscount,DocumentTypeHeader,CouponDiscountID,CouponDiscountTypeID,MemberDiscountID,StaffDiscountID,MemberPriceGroupID,StaffPriceGroupID,ps.PromotionPriceName AS StaffPromotion,pm.PromotionPriceName AS MemberPromotion,t.TableName,t.TableNumber,t.TableID,obk.*,pt.PayType As CCGroupName FROM ordertransaction" + BranchStr + " a inner join orderdetail" + BranchStr + " b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID left outer join orderdiscountdetail" + BranchStr + " c ON  b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND b.OrderDetailID=c.OrderDetailID left outer join Staffs s ON a.PaidStaffID=s.StaffID left outer join Members m ON a.MemberDiscountID=m.MemberID left outer join PayDetail" + BranchStr + " d ON a.TransactionID=d.TransactionID AND a.ComputerID=d.ComputerID left outer join PayType e ON d.PayTypeID=e.TypeID left outer join DummySaleReport f ON a.TransactionID=f.TransactionID AND a.ComputerID=f.ComputerID AND b.VATType=f.VATType left outer join Products p ON b.ProductID=p.ProductID left outer join BankName bn ON d.BankName=bn.BankNameID left outer join CreditCardType cct ON d.CreditCardType=cct.CCTypeID left outer join Staffs sv ON a.VoidStaffID=sv.StaffID left outer join Staffs sd ON a.StaffDiscountID=sd.StaffID left outer join PromotionPriceGroup ps ON a.StaffPriceGroupID=ps.PriceGroupID left outer join PromotionPriceGroup pm ON a.MemberPriceGroupID=pm.PriceGroupID left outer join DocumentType dt ON a.DocType=dt.DocumentTypeID AND (a.CloseComputerID=dt.ComputerID OR a.ShopID=dt.ShopID) left outer join TableNo t ON a.TableID=t.TableID left outer join OrderBookRecord obk ON b.OrderDetailID=obk.OrderDetailID AND b.ComputerID=obk.ComputerID AND b.TransactionID=obk.TransactionID left outer join SaleMode sm ON b.SaleMode=sm.SaleModeID left outer join PayType pt ON d.SmartCardType=pt.TypeID WHERE a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3,14,16) AND dt.LangID=" + LangID.ToString + AdditionalQuery + " ORDER BY " + OrderBy
                GetData = objDB.List(sqlStatement, objCnn)
                objDB.sqlExecute("DROP TABLE IF EXISTS DummyPayment", objCnn)
                objDB.sqlExecute("create table DummyPayment (PayTypeID int, PayTypeName varchar(100), PayAmount decimal(18,4), PaymentVAT decimal(18,4), IsSale tinyint, IsVAT tinyint, PrepaidDiscountPercent decimal(5,2), IsOtherReceipt tinyint NOT NULL default '0' )", objCnn)

                Return getReport.SaleReportDetails(LangID, GrayBGColor, AdminBGColor, ShopID, ViewOption, StartDate, EndDate, GetData, PayByCreditMoney, DisplaySummary, LangPath, objCnn)
            End If


        Else
            Dim DisplayReceipt As Boolean = False
            If ReportByProduct = False And ReportByTime = False And ViewOption = 0 And ExpandReceipt = False Then DisplayReceipt = True
            Dim ExtraCriteria As String = ""
            If DisplayReceipt = False Then
                ExtraCriteria = strTransStatus
            End If

            objDB.sqlExecute("DROP TABLE IF EXISTS DummySaleSummary", objCnn)
            objDB.sqlExecute("create table DummySaleSummary (TransactionID int, ComputerID int,Amount decimal(18,4),Price decimal(18,4),RetailPrice decimal(18,4),SalePrice decimal(18,4), MemberDiscount decimal(18,4), StaffDiscount decimal(18,4),CouponDiscount decimal(18,4),VoucherDiscount decimal(18,4),OtherPercentDiscount decimal(18,4),EachProductOtherDiscount decimal(18,4),PricePromotionDiscount decimal(18,4))", objCnn)
            objDB.sqlExecute("ALTER TABLE DummySaleSummary ADD PRIMARY KEY (TransactionID,ComputerID)", objCnn)
            sqlStatement = "select a.TransactionID,a.ComputerID,SUM(b.Amount) AS Amount,SUM(c.TotalPrice) AS Price,SUM(IF(b.ProductSetType >= 0, c.TotalRetailPrice, IF(b.ProductSetType=-4,c.SalePrice,0))) AS RetailPrice, SUM(c.SalePrice) AS SalePrice,SUM(c.MemberDiscount) AS MemberDiscount,SUM(c.StaffDiscount) AS StaffDiscount,SUM(c.CouponDiscount) AS CouponDiscount,SUM(c.VoucherDiscount) AS VoucherDiscount,SUM(c.OtherPercentDiscount) AS OtherPercentDiscount,SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount,SUM(c.PricePromotionDiscount) AS PricePromotionDiscount from OrderTransaction a, OrderDetail b, OrderDiscountDetail c where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND b.OrderDetailID=c.OrderDetailID AND a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3,14,16) " + AdditionalQuery + ExtraCriteria + " GROUP BY a.TransactionID,a.ComputerID"

            objDB.sqlExecute("insert into DummySaleSummary " + sqlStatement, objCnn)

            If NotInRevenueBit = True Then
                Dim SelectString, GroupByString As String
                SelectString = "a.TransactionID,a.ComputerID"
                GroupByString = "a.TransactionID,a.ComputerID"

                objDB.sqlExecute("DROP TABLE IF EXISTS DummyProductRevenue", objCnn)
                objDB.sqlExecute("create table DummyProductRevenue (TransactionID int, ComputerID int, TotalNotInRevenue1 decimal(18,4))", objCnn)
                objDB.sqlExecute("ALTER TABLE DummyProductRevenue ADD INDEX DummyRevenueIndex (TransactionID,ComputerID)", objCnn)
                sqlStatement = "select " + SelectString + ",SUM(c.SalePrice) AS TotalNotInRevenue1 FROM OrderTransaction a, OrderDetail b, OrderDiscountDetail c, ProductType pt " & _
                                "where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.OrderDetailID=c.OrderDetailID AND b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND " & _
                                " b.ProductSetType=pt.ProductTypeID AND a.ReceiptID > 0 AND pt.NotInRevenue=1 " + AdditionalQuery & strTransStatus & " group by " + GroupByString
                objDB.sqlExecute("insert into DummyProductRevenue " + sqlStatement, objCnn)

                objDB.sqlExecute("DROP TABLE IF EXISTS DummyProductRevenue1", objCnn)
                objDB.sqlExecute("create table DummyProductRevenue1 (TransactionID int, ComputerID int, TotalNotInRevenue2 decimal(18,4))", objCnn)
                objDB.sqlExecute("ALTER TABLE DummyProductRevenue1 ADD INDEX DummyRevenueIndex1 (TransactionID,ComputerID)", objCnn)
                sqlStatement = "select " + SelectString + ",SUM(c.SalePrice) AS TotalNotInRevenue2 FROM OrderTransaction a, OrderDetail b, OrderDiscountDetail c, ProductType pt " & _
                                "where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.OrderDetailID=c.OrderDetailID AND b.TransactionID=c.TransactionID AND " & _
                                " b.ComputerID=c.ComputerID AND b.ProductSetType=pt.ProductTypeID AND a.ReceiptID > 0 AND " & _
                                "pt.NotInRevenue=2 " + AdditionalQuery & strTransStatus & " group by " + GroupByString
                objDB.sqlExecute("insert into DummyProductRevenue1 " + sqlStatement, objCnn)

                objDB.sqlExecute("DROP TABLE IF EXISTS DummyUsedPackage", objCnn)
                objDB.sqlExecute("create table DummyUsedPackage (TransactionID int, ComputerID int, TotalUsedPackage decimal(18,4))", objCnn)
                objDB.sqlExecute("ALTER TABLE DummyUsedPackage ADD INDEX DummyUsedPackageIndex (TransactionID,ComputerID)", objCnn)
                Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel where ProductLevelID IN (" + ShopIDListValue + ")", objCnn)
                Dim DisplayVATType As String = "E"
                For ii = 0 To ShopInfo.Rows.Count - 1
                    If ShopInfo.Rows(ii)("DisplayReceiptVATableType") = 1 Then
                        DisplayVATType = "V"
                    End If
                Next

                If DisplayVATType = "E" Then
                    sqlStatement = "select " + SelectString + ",SUM(c.CommissionPrice) AS TotalUsedPackage FROM OrderTransaction a, OrderDetail b, PackageHistory c " & _
                                "where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.OrderDetailID=c.OrderDetailID AND b.TransactionID=c.TransactionID AND " & _
                                "b.ComputerID=c.ComputerID AND a.ReceiptID > 0 AND c.PackageStatus=1 " + AdditionalQuery & strTransStatus & " group by " + GroupByString
                Else
                    sqlStatement = "select " + SelectString + ",SUM(c.CommissionPrice+c.CommissionPriceVAT) AS TotalUsedPackage " & _
                                "FROM OrderTransaction a, OrderDetail b, PackageHistory c where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND " & _
                                " b.OrderDetailID=c.OrderDetailID AND b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND a.ReceiptID > 0 AND " & _
                                " c.PackageStatus=1 " + AdditionalQuery & strTransStatus & " group by " + GroupByString
                End If
                objDB.sqlExecute("insert into DummyUsedPackage " + sqlStatement, objCnn)

                If DisplayReceipt = True Then
                    ExtraSelect += ",r.TotalNotInRevenue1,r1.TotalNotInRevenue2,TotalUsedPackage"
                Else
                    ExtraSelect += ",SUM(r.TotalNotInRevenue1) AS TotalNotInRevenue1,SUM(r1.TotalNotInRevenue2) AS TotalNotInRevenue2,SUM(up.TotalUsedPackage) AS TotalUsedPackage"
                End If
                ExtraSql += " left outer join DummyProductRevenue r ON a.TransactionID=r.TransactionID AND a.ComputerID=r.ComputerID left outer join DummyProductRevenue1 r1 ON a.TransactionID=r1.TransactionID AND a.ComputerID=r1.ComputerID left outer join DummyUsedPackage up ON a.TransactionID=up.TransactionID AND a.ComputerID=up.ComputerID "
            End If

            If ShopID = 0 And ReportByBill = True Then
                sqlStatement = "select CONCAT(pl.ProductLevelCode,':',pl.ProductLevelName) AS SaleDate,a.ShopID,pl.ProductLevelCode,pl.ProductLevelName,pl.ProductLevelOrder,SUM(a.TransactionVATable) AS TransactionVATable,count(distinct a.TransactionID,a.ComputerID) AS TotalBill,SUM(a.NoCustomer) AS TotalCustomer,SUM(a.OtherAmountDiscount) AS OtherAmountDiscount,SUM(a.TransactionVAT) AS TransactionVAT,SUM(a.TransactionExcludeVAT) AS TransactionExcludeVAT,SUM(a.ServiceCharge) AS ServiceCharge,SUM(a.ServiceChargeVAT) AS ServiceChargeVAT,SUM(c.Amount) AS Amount,SUM(c.Price) AS Price,SUM(c.RetailPrice) AS RetailPrice, SUM(c.SalePrice) AS SalePrice,SUM(c.MemberDiscount) AS MemberDiscount,SUM(c.StaffDiscount) AS StaffDiscount,SUM(c.CouponDiscount) AS CouponDiscount,SUM(c.VoucherDiscount) AS VoucherDiscount,SUM(c.OtherPercentDiscount) AS OtherPercentDiscount,SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount,SUM(c.PricePromotionDiscount) AS PricePromotionDiscount" + ExtraSelect + " FROM OrderTransaction a, DummySaleSummary c " + ExtraSql + ",ProductLevel pl where a.TransactionID=c.TransactionID AND a.ComputerID=c.ComputerID AND a.ShopID=pl.ProductLevelID " & strTransStatus & " group by a.ShopID,pl.ProductLevelCode,pl.ProductLevelName,pl.ProductLevelOrder Order By pl.ProductLevelOrder,pl.ProductLevelID"

                sqlStatement2 = "select CONCAT(pl.ProductLevelCode,':',pl.ProductLevelName) AS SaleDate,a.ShopID,pl.ProductLevelCode,pl.ProductLevelName,pl.ProductLevelOrder,b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT from ordertransaction" + BranchStr + " a, paydetail" + BranchStr + " b, paytype c, ProductLevel pl where a.transactionid=b.transactionid and a.computerid=b.computerid and b.PayTypeID=c.TypeID and a.ShopID=pl.ProductLevelID " + AdditionalQuery & strTransStatus & " group by b.PayTypeID,c.PayType,IsSale,IsVAT,a.ShopID,pl.ProductLevelCode,pl.ProductLevelName,pl.ProductLevelOrder order by pl.ProductLevelOrder,pl.ProductLevelID,b.PayTypeID"

            ElseIf DisplayReceipt = True Then
                objDB.sqlExecute("DROP TABLE IF EXISTS DummyDocType", objCnn)
                objDB.sqlExecute("create table DummyDocType (DocumentTypeID int, ComputerID int, DocumentTypeHeader varchar(50))", objCnn)
                objDB.sqlExecute("insert into DummyDocType select DocumentTypeID,ComputerID,DocumentTypeHeader from DocumentType where DocumentTypeID=11 AND langid=" + LangID.ToString, objCnn)

                sqlStatement = "select CONCAT('T=',a.TransactionID,':C=',a.ComputerID) AS SaleDate,a.TransactionID,a.ComputerID,a.TransactionStatusID,a.ReceiptID,a.ReceiptMonth,a.ReceiptYear,a.DocType,dt.DocumentTypeHeader,ft.ReceiptID AS FReceiptID,ft.ReceiptMonth AS FReceiptMonth,ft.ReceiptYear AS FReceiptYear,dt1.DocumentTypeHeader AS DocTypeHeader,SUM(a.TransactionVATable) AS TransactionVATable,count(distinct a.TransactionID,a.ComputerID) AS TotalBill,SUM(a.NoCustomer) AS TotalCustomer,SUM(a.OtherAmountDiscount) AS OtherAmountDiscount,SUM(a.TransactionVAT) AS TransactionVAT,SUM(a.TransactionExcludeVAT) AS TransactionExcludeVAT,SUM(a.ServiceCharge) AS ServiceCharge,SUM(a.ServiceChargeVAT) AS ServiceChargeVAT,SUM(c.Amount) AS Amount,SUM(c.Price) AS Price,SUM(c.RetailPrice) AS RetailPrice, SUM(c.SalePrice) AS SalePrice,SUM(c.MemberDiscount) AS MemberDiscount,SUM(c.StaffDiscount) AS StaffDiscount,SUM(c.CouponDiscount) AS CouponDiscount,SUM(c.VoucherDiscount) AS VoucherDiscount,SUM(c.OtherPercentDiscount) AS OtherPercentDiscount,SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount,SUM(c.PricePromotionDiscount) AS PricePromotionDiscount,a.TableID,t.TableNumber,t.TableName" + ExtraSelect + " FROM OrderTransaction a inner join DummySaleSummary c ON a.TransactionID=c.TransactionID AND a.ComputerID=c.ComputerID left outer join DocumentType dt ON a.DocType=dt.DocumentTypeID AND (a.CloseComputerID=dt.ComputerID OR a.ShopID=dt.ShopID) left outer join OrderFullTaxInvoiceLink ftl ON a.TransactionID=ftl.TransactionID AND a.ComputerID=ftl.ComputerID AND ftl.FullTaxStatus=2 left outer join OrderTransactionFullTaxInvoice" + BranchStr + " ft ON ftl.FullTaxInvoiceID=ft.FullTaxInvoiceID AND ftl.FullTaxInvoiceComputerID=ft.FullTaxInvoiceComputerID AND ft.FullTaxStatus=2 left outer join DummyDocType dt1 ON ft.DocType=dt1.DocumentTypeID AND ft.CloseComputerID=dt1.ComputerID left outer join TableNo t ON a.TableID=t.TableID  " + ExtraSql + " where a.ReceiptID > 0 AND dt.LangID=" + LangID.ToString + " group by a.TransactionID,a.ComputerID,a.TransactionStatusID,a.ReceiptID,a.ReceiptMonth,a.ReceiptYear,a.DocType Order By a.DocType,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"

                sqlStatement2 = "select CONCAT('T=',a.TransactionID,':C=',a.ComputerID) AS SaleDate,a.TransactionID,a.ComputerID,a.TransactionStatusID,a.DocType,b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT from ordertransaction" + BranchStr + " a, paydetail" + BranchStr + " b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.PayTypeID=c.TypeID " + AdditionalQuery + " group by b.PayTypeID,c.PayType,IsSale,IsVAT,a.TransactionID,a.ComputerID,a.DocType,a.TransactionStatusID order by a.DocType,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"


            ElseIf ReportByTime = True Then
                If GroupByParam = 1 Then
                    sqlStatement = "select DAYNAME(a.SaleDate) AS SaleDate,SUM(a.TransactionVATable) AS TransactionVATable,count(distinct a.TransactionID,a.ComputerID) AS TotalBill,SUM(a.NoCustomer) AS TotalCustomer,SUM(a.OtherAmountDiscount) AS OtherAmountDiscount,SUM(a.TransactionVAT) AS TransactionVAT,SUM(a.TransactionExcludeVAT) AS TransactionExcludeVAT,SUM(a.ServiceCharge) AS ServiceCharge,SUM(a.ServiceChargeVAT) AS ServiceChargeVAT,SUM(c.Amount) AS Amount,SUM(c.Price) AS Price,SUM(c.RetailPrice) AS RetailPrice, SUM(c.SalePrice) AS SalePrice,SUM(c.MemberDiscount) AS MemberDiscount,SUM(c.StaffDiscount) AS StaffDiscount,SUM(c.CouponDiscount) AS CouponDiscount,SUM(c.VoucherDiscount) AS VoucherDiscount,SUM(c.OtherPercentDiscount) AS OtherPercentDiscount,SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount,SUM(c.PricePromotionDiscount) AS PricePromotionDiscount" + ExtraSelect + " FROM OrderTransaction a, DummySaleSummary c " + ExtraSql + " where a.TransactionID=c.TransactionID AND a.ComputerID=c.ComputerID group by WEEKDAY(a.SaleDate) Order By WEEKDAY(a.SaleDate)"

                    sqlStatement2 = "select DAYNAME(a.SaleDate) AS SaleDate,b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT from ordertransaction" + BranchStr + " a, paydetail" + BranchStr + " b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.PayTypeID=c.TypeID " + AdditionalQuery & strTransStatus & " group by b.PayTypeID,c.PayType,IsSale,IsVAT,WEEKDAY(a.SaleDate) order by WEEKDAY(a.SaleDate),b.PayTypeID"
                Else
                    'Check 24 Hour Feature
                    Dim Chk As DataTable
                    Dim AllDayFeature As Boolean = False
                    If ShopID = 0 Then
                        Chk = objDB.List("select * from programpropertyvalue where ProgramTypeID=1 AND propertyid=1049 AND PropertyValue>0", objCnn)
                        If Chk.Rows.Count > 0 Then
                            AllDayFeature = True
                        End If
                    Else
                        Chk = objDB.List("select * from programpropertyvalue where ProgramTypeID=1 AND propertyid=1049 AND KeyID=" + ShopID.ToString + " AND PropertyValue>0", objCnn)
                        If Chk.Rows.Count > 0 Then
                            AllDayFeature = True
                        End If
                    End If
                    If AllDayFeature = True Then
                        sqlStatement = "select HOUR(a.OpenTime) AS SaleDate,SUM(a.TransactionVATable) AS TransactionVATable,count(distinct a.TransactionID,a.ComputerID) AS TotalBill,SUM(a.NoCustomer) AS TotalCustomer,SUM(a.OtherAmountDiscount) AS OtherAmountDiscount,SUM(a.TransactionVAT) AS TransactionVAT,SUM(a.TransactionExcludeVAT) AS TransactionExcludeVAT,SUM(a.ServiceCharge) AS ServiceCharge,SUM(a.ServiceChargeVAT) AS ServiceChargeVAT,SUM(c.Amount) AS Amount,SUM(c.Price) AS Price,SUM(c.RetailPrice) AS RetailPrice, SUM(c.SalePrice) AS SalePrice,SUM(c.MemberDiscount) AS MemberDiscount,SUM(c.StaffDiscount) AS StaffDiscount,SUM(c.CouponDiscount) AS CouponDiscount,SUM(c.VoucherDiscount) AS VoucherDiscount,SUM(c.OtherPercentDiscount) AS OtherPercentDiscount,SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount,SUM(c.PricePromotionDiscount) AS PricePromotionDiscount" + ExtraSelect + " FROM OrderTransaction a, DummySaleSummary c " + ExtraSql + " where a.TransactionID=c.TransactionID AND a.ComputerID=c.ComputerID group by HOUR(a.OpenTime) Order By HOUR(a.OpenTime)"

                    Else
                        Dim OpenShopID As Integer = ShopID
                        If ShopID = 0 Then
                            OpenShopID = 1
                        End If
                        Dim getOpenHour As DataTable = objDB.List("select HOUR(OpenHour) As OpenHour,HOUR(CloseHour) As CloseHour from productlevel where ProductLevelID=" + OpenShopID.ToString, objCnn)
                        Dim OpenHourVal As Integer = 0
                        Dim EndHourVal As Integer = 23
                        If getOpenHour.Rows.Count > 0 Then
                            If Not IsDBNull(getOpenHour.Rows(0)("OpenHour")) Then
                                OpenHourVal = getOpenHour.Rows(0)("OpenHour")
                            End If
                            If Not IsDBNull(getOpenHour.Rows(0)("CloseHour")) Then
                                EndHourVal = getOpenHour.Rows(0)("CloseHour")
                            End If
                        End If
                        objDB.sqlExecute("DROP TABLE IF EXISTS DummyHourly", objCnn)
                        objDB.sqlExecute("create table DummyHourly (ID int, Hourly int)", objCnn)
                        ii = 1
                        Dim i As Integer
                        Dim EndLoop As Integer = EndHourVal
                        If OpenHourVal >= EndHourVal Then
                            EndLoop = 23
                        End If
                        For i = OpenHourVal To EndLoop
                            objDB.sqlExecute("insert into DummyHourly (ID,Hourly) values (" & ii & "," & i & ")", objCnn)
                            ii += 1
                        Next
                        If OpenHourVal >= EndHourVal Then
                            If OpenHourVal = EndHourVal Then
                                EndLoop = EndHourVal - 1
                            Else
                                EndLoop = EndHourVal
                            End If
                            For i = 0 To EndLoop
                                objDB.sqlExecute("insert into DummyHourly (ID,Hourly) values (" & ii & "," & i & ")", objCnn)
                                ii += 1
                            Next
                        End If
                        sqlStatement = "select aa.Hourly AS SaleDate,IF(bb.TransactionVATable is NULL,0,bb.TransactionVATable) As TransactionVATable,IF(bb.TotalBill is NULL,0,bb.TotalBill) As TotalBill,IF(bb.TotalCustomer is NULL,0,bb.TotalCustomer) As TotalCustomer,IF(bb.OtherAmountDiscount is NULL,0,bb.OtherAmountDiscount) As OtherAmountDiscount,IF(bb.TransactionVAT is NULL,0,bb.TransactionVAT) As TransactionVAT,IF(bb.TransactionExcludeVAT is NULL,0,bb.TransactionExcludeVAT) As TransactionExcludeVAT,IF(bb.ServiceCharge is NULL,0,bb.ServiceCharge) As ServiceCharge,IF(bb.ServiceChargeVAT is NULL,0,bb.ServiceChargeVAT) As ServiceChargeVAT,IF(bb.Amount is NULL,0,bb.Amount) As Amount,IF(bb.Price is NULL,0,bb.Price) As Price,IF(bb.RetailPrice is NULL,0,bb.RetailPrice) As RetailPrice,IF(bb.SalePrice is NULL,0,bb.SalePrice) As SalePrice,IF(bb.MemberDiscount is NULL,0,bb.MemberDiscount) As MemberDiscount,IF(bb.StaffDiscount is NULL,0,bb.StaffDiscount) As StaffDiscount,IF(bb.CouponDiscount is NULL,0,bb.CouponDiscount) As CouponDiscount,IF(bb.VoucherDiscount is NULL,0,bb.VoucherDiscount) As VoucherDiscount,IF(bb.OtherPercentDiscount is NULL,0,bb.OtherPercentDiscount) As OtherPercentDiscount,IF(bb.EachProductOtherDiscount is NULL,0,bb.EachProductOtherDiscount) As EachProductOtherDiscount,IF(bb.PricePromotionDiscount is NULL,0,bb.PricePromotionDiscount) As PricePromotionDiscount from DummyHourly aa left outer join (select HOUR(a.OpenTime) As OpenHour,SUM(a.TransactionVATable) AS TransactionVATable,count(distinct a.TransactionID,a.ComputerID) AS TotalBill,SUM(a.NoCustomer) AS TotalCustomer,SUM(a.OtherAmountDiscount) AS OtherAmountDiscount,SUM(a.TransactionVAT) AS TransactionVAT,SUM(a.TransactionExcludeVAT) AS TransactionExcludeVAT,SUM(a.ServiceCharge) AS ServiceCharge,SUM(a.ServiceChargeVAT) AS ServiceChargeVAT,SUM(c.Amount) AS Amount,SUM(c.Price) AS Price,SUM(c.RetailPrice) AS RetailPrice, SUM(c.SalePrice) AS SalePrice,SUM(c.MemberDiscount) AS MemberDiscount,SUM(c.StaffDiscount) AS StaffDiscount,SUM(c.CouponDiscount) AS CouponDiscount,SUM(c.VoucherDiscount) AS VoucherDiscount,SUM(c.OtherPercentDiscount) AS OtherPercentDiscount,SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount,SUM(c.PricePromotionDiscount) AS PricePromotionDiscount" + ExtraSelect + " FROM OrderTransaction a inner join DummySaleSummary c ON a.TransactionID=c.TransactionID AND a.ComputerID=c.ComputerID " + ExtraSql + " where 0=0 group by HOUR(a.OpenTime)) bb ON aa.Hourly=bb.OpenHour Order By aa.ID"
                    End If
                    sqlStatement2 = "select HOUR(a.OpenTime) AS SaleDate,b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT from ordertransaction" + BranchStr + " a, paydetail" + BranchStr + " b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.PayTypeID=c.TypeID " + AdditionalQuery & strTransStatus & " group by b.PayTypeID,c.PayType,IsSale,IsVAT,HOUR(a.OpenTime) order by HOUR(a.OpenTime),b.PayTypeID"
                End If
            Else
                If ViewOption = 4 Then
                    sqlStatement = "select DATE_FORMAT(a.SaleDate,'%M') AS SaleDate,SUM(a.TransactionVATable) AS TransactionVATable,count(distinct a.TransactionID,a.ComputerID) AS TotalBill,SUM(a.NoCustomer) AS TotalCustomer,SUM(a.OtherAmountDiscount) AS OtherAmountDiscount,SUM(a.TransactionVAT) AS TransactionVAT,SUM(a.TransactionExcludeVAT) AS TransactionExcludeVAT,SUM(a.ServiceCharge) AS ServiceCharge,SUM(a.ServiceChargeVAT) AS ServiceChargeVAT,SUM(c.Amount) AS Amount,SUM(c.Price) AS Price,SUM(c.RetailPrice) AS RetailPrice, SUM(c.SalePrice) AS SalePrice,SUM(c.MemberDiscount) AS MemberDiscount,SUM(c.StaffDiscount) AS StaffDiscount,SUM(c.CouponDiscount) AS CouponDiscount,SUM(c.VoucherDiscount) AS VoucherDiscount,SUM(c.OtherPercentDiscount) AS OtherPercentDiscount,SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount,SUM(c.PricePromotionDiscount) AS PricePromotionDiscount" + ExtraSelect + " FROM OrderTransaction a, DummySaleSummary c " + ExtraSql + " where a.TransactionID=c.TransactionID AND a.ComputerID=c.ComputerID group by MONTH(a.SaleDate) Order By MONTH(a.SaleDate)"

                    sqlStatement2 = "select DATE_FORMAT(a.SaleDate,'%M') AS SaleDate,b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT from ordertransaction" + BranchStr + " a, paydetail" + BranchStr + " b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.PayTypeID=c.TypeID " + AdditionalQuery & strTransStatus & " group by b.PayTypeID,c.PayType,IsSale,IsVAT,MONTH(a.SaleDate) order by MONTH(a.SaleDate),b.PayTypeID"
                Else
                    sqlStatement = "select a.SaleDate,SUM(a.TransactionVATable) AS TransactionVATable,count(distinct a.TransactionID,a.ComputerID) AS TotalBill,SUM(a.NoCustomer) AS TotalCustomer,SUM(a.OtherAmountDiscount) AS OtherAmountDiscount,SUM(a.TransactionVAT) AS TransactionVAT,SUM(a.TransactionExcludeVAT) AS TransactionExcludeVAT,SUM(a.ServiceCharge) AS ServiceCharge,SUM(a.ServiceChargeVAT) AS ServiceChargeVAT,SUM(c.Amount) AS Amount,SUM(c.Price) AS Price,SUM(c.RetailPrice) AS RetailPrice, SUM(c.SalePrice) AS SalePrice,SUM(c.MemberDiscount) AS MemberDiscount,SUM(c.StaffDiscount) AS StaffDiscount,SUM(c.CouponDiscount) AS CouponDiscount,SUM(c.VoucherDiscount) AS VoucherDiscount,SUM(c.OtherPercentDiscount) AS OtherPercentDiscount,SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount,SUM(c.PricePromotionDiscount) AS PricePromotionDiscount" + ExtraSelect + " FROM OrderTransaction a, DummySaleSummary c " + ExtraSql + " where a.TransactionID=c.TransactionID AND a.ComputerID=c.ComputerID Group by a.SaleDate Order By a.SaleDate"

                    sqlStatement2 = "select a.SaleDate,b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT from ordertransaction" + BranchStr + " a, paydetail" + BranchStr + " b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.PayTypeID=c.TypeID " + AdditionalQuery & strTransStatus & " group by b.PayTypeID,c.PayType,IsSale,IsVAT,a.SaleDate order by a.SaleDate,b.PayTypeID"

                End If
            End If
            sqlStatement1 = "select b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT, IsOtherReceipt from ordertransaction" + BranchStr + " a, paydetail" + BranchStr + " b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.PayTypeID=c.TypeID " + AdditionalQuery & strTransStatus & " group by b.PayTypeID,c.PayType,IsSale,IsVAT, IsOtherReceipt order by b.PayTypeID,c.PayType,IsSale DESC"
            GetData = objDB.List(sqlStatement, objCnn)
            PayTypeData = objDB.List(sqlStatement2, objCnn)

            ResultString = getReport.SaleReportByDate(GraphData, GrayBGColor, AdminBGColor, ShopID, ViewOption, StartDate, EndDate, GetData, objDB.List(sqlStatement1, objCnn), PayByCreditMoney, PayTypeList, PayTypeData, DisplayGraph, DisplayReceipt, LangID, LangPath, objCnn)

            objDB.sqlExecute("DROP TABLE IF EXISTS DummyHourly", objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummyDocType", objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummySaleSummary", objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummyNoVAT", objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummyProductRevenue", objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummyProductRevenue1", objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummyUsedPackage", objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummyGroupOrdering_" + ExtraTableString, objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummyDeptOrdering_" + ExtraTableString, objCnn)
            Return ResultString
        End If

    End Function
	
 Public Function SaleReportByProduct(ByRef GraphData As DataSet, ByRef ResultString As String, ByRef grandTotal As Double, ByRef VATTotal As Double, receiptSaleNonSaleType As Integer, ByVal ShowSummary As Boolean, ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal ShopID As Integer, ByVal ViewOption As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal dtTable As DataTable, ByVal PaymentResult As DataTable, ByVal PayByCreditMoney As DataTable, ByVal LangID As Integer, ByVal LangPath As String, ByVal TimeString As String, ByVal objCnn As MySqlConnection) As String

        Dim FormatData As DataTable = Fm.FormatParam(FormatObject, LangID, objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
        Dim LangData2 As DataTable = pRoMiSeLanguage.pRoMiSeLanguage.LangInfo(6, 2, -1, LangPath)
        Dim LangText As String = "lang" + LangID.ToString

        Dim i As Integer
        Dim strTransStatus As String
        Dim outputString As StringBuilder = New StringBuilder
        Dim counter As Integer
        Dim ShowString As String = ""
        Dim subTotalRetailPrice As Double = 0
        Dim subTotalPriceDiscount As Double = 0
        Dim subTotalDiscount As Double = 0
        Dim subTotalBeforeVAT As Double = 0
        Dim subTotalVAT As Double = 0
        Dim subTotalAfterVAT As Double = 0
        Dim subTotalOtherDiscount As Double = 0
        Dim subTotalQty As Double = 0

        Dim subTotalGroupRetailPrice As Double = 0
        Dim subTotalGroupPriceDiscount As Double = 0
        Dim subTotalGroupDiscount As Double = 0
        Dim subTotalGroupBeforeVAT As Double = 0
        Dim subTotalGroupVAT As Double = 0
        Dim subTotalGroupAfterVAT As Double = 0
        Dim subTotalGroupOtherDiscount As Double = 0
        Dim subTotalGroupQty As Double = 0

        Dim subTotalRetailPriceDate As Double = 0
        Dim subTotalPriceDiscountDate As Double = 0
        Dim subTotalDiscountDate As Double = 0
        Dim subTotalBeforeVATDate As Double = 0
        Dim subTotalVATDate As Double = 0
        Dim subTotalAfterVATDate As Double = 0
        Dim subTotalOtherDiscountDate As Double = 0
        Dim subTotalServiceChargeDate As Double = 0

        Dim grandTotalRetailPrice As Double = 0
        Dim grandTotalPriceDiscount As Double = 0
        Dim grandTotalDiscount As Double = 0
        Dim grandTotalBeforeVAT As Double = 0
        Dim grandTotalVAT As Double = 0
        Dim grandTotalAfterVAT As Double = 0
        Dim grandTotalOtherDiscount As Double = 0
        Dim grandTotalServiceCharge As Double = 0
        Dim grandTotalQty As Double = 0
        Dim DiscountArray(7) As Double
        Dim grandTotalVoid As Double = 0

        Dim RetailPriceAfterVAT As Double = 0
        Dim TextClass As String
        Dim DummyGroupID, DummyDeptID As String
        Dim VATString As String
        Dim TotalProductDiscount As Double
        Dim bgColor As String = "white" 'GlobalParam.GrayBGColor
        Dim ExtraInfo As String
        Dim getProp As New CPreferences

        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

        TextClass = "smallText"

        Dim table As DataTable = GraphData.Tables.Add("Data")
        table.Columns.Add("Description")
        table.Columns.Add("Value1", GetType(Double))

        Dim CompareDeptID, CompareGroupID As String
        counter = 1
        Dim PriceDiscount, PricePerUnit, ProductQty As Double
        Dim totalSale As Double = 0
        Dim totalSaleBeforeDiscount As Double = 0
        Dim totalQty As Integer = 0
        For i = 0 To dtTable.Rows.Count - 1
            Select Case receiptSaleNonSaleType
                Case 2, 3            'Update TransctionStatus = 11 To 2
                    If dtTable.Rows(i)("TransactionStatusID") = 11 Then
                        dtTable.Rows(i)("TransactionStatusID") = 2
                    End If
            End Select

            If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                If Not IsDBNull(dtTable.Rows(i)("SalePrice")) Then
                    totalSale += dtTable.Rows(i)("SalePrice")
                End If
                If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) Then
                    totalSaleBeforeDiscount += dtTable.Rows(i)("TotalRetailPrice")
                End If
                totalQty += dtTable.Rows(i)("Amount")
            End If
        Next
        For i = 0 To dtTable.Rows.Count - 1
            If Not IsDBNull(dtTable.Rows(i)("ProductGroupCode")) Then
                CompareGroupID = dtTable.Rows(i)("ProductGroupCode")
            Else
                CompareGroupID = ""
            End If
            If Not IsDBNull(dtTable.Rows(i)("ProductDeptCode")) Then
                CompareDeptID = dtTable.Rows(i)("ProductDeptCode")
            Else
                CompareDeptID = ""
            End If
            If Not (DummyGroupID = CompareGroupID And DummyDeptID = CompareDeptID) Then

                If i <> 0 Then
                    outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
                    outputString = outputString.Append("<td colspan=""4"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(91)(LangText) + " " + dtTable.Rows(i - 1)("ProductDeptName") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((subTotalQty / totalQty)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl((subTotalRetailPrice / totalSaleBeforeDiscount)).ToString(FormatObject.PercentFormat, ci) & "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalPriceDiscount + subTotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((subTotalAfterVAT / totalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                    outputString = outputString.Append("<td></td></tr>")
                    subTotalGroupPriceDiscount += subTotalPriceDiscount
                    subTotalGroupDiscount += subTotalDiscount
                    subTotalGroupBeforeVAT += subTotalBeforeVAT
                    subTotalGroupVAT += subTotalVAT
                    subTotalGroupAfterVAT += subTotalAfterVAT
                    subTotalGroupRetailPrice += subTotalRetailPrice
                    subTotalGroupQty += subTotalQty
                End If
                If Not DummyGroupID = CompareGroupID Then
                    If i <> 0 Then
                        outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                        outputString = outputString.Append("<td colspan=""4"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(89)(LangText) + " " + dtTable.Rows(i - 1)("ProductGroupName") + LangData2.Rows(90)(LangText) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((subTotalGroupQty / totalQty)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl((subTotalGroupRetailPrice / totalSaleBeforeDiscount)).ToString(FormatObject.PercentFormat, ci) & "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupPriceDiscount + subTotalGroupDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((subTotalGroupAfterVAT / totalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                        outputString = outputString.Append("<td></td></tr>")
                        Dim row As DataRow = table.NewRow()
                        row("Description") = dtTable.Rows(i - 1)("ProductGroupName")
                        row("Value1") = CDbl((subTotalGroupAfterVAT / totalSale) * 100).ToString(FormatObject.NumericFormat, ci)
                        table.Rows.Add(row)
                    End If

                    subTotalGroupPriceDiscount = 0
                    subTotalGroupDiscount = 0
                    subTotalGroupBeforeVAT = 0
                    subTotalGroupVAT = 0
                    subTotalGroupAfterVAT = 0
                    subTotalGroupRetailPrice = 0
                    subTotalGroupQty = 0
                End If
                outputString = outputString.Append("<tr><td colspan=""12"" class=""tdHeader"" bgColor=""" + AdminBGColor + """>" + dtTable.Rows(i)("ProductGroupName") + " :: " + dtTable.Rows(i)("ProductDeptName") + "</td></tr>")

                counter = 1
                subTotalPriceDiscount = 0
                subTotalDiscount = 0
                subTotalBeforeVAT = 0
                subTotalVAT = 0
                subTotalAfterVAT = 0
                subTotalRetailPrice = 0
                subTotalQty = 0

            End If



            outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")

            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & counter.ToString & ")</td>")

            If Not IsDBNull(dtTable.Rows(i)("ProductCode")) Then
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("ProductCode") & "</td>")
            Else
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>")
            End If
            If dtTable.Rows(i)("ProductSettype") < 0 Then
                ExtraInfo = "**"
            ElseIf dtTable.Rows(i)("OrderStatusID") = 5 Then
                ExtraInfo = "*"
            ElseIf Not IsDBNull(dtTable.Rows(i)("ProductIDLink")) Then
                ExtraInfo = "**"
            Else
                ExtraInfo = ""
            End If
            If Not IsDBNull(dtTable.Rows(i)("ProductName")) Then
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("ProductName") + ExtraInfo & "</td>")
            ElseIf Not IsDBNull(dtTable.Rows(i)("OtherFoodName")) Then
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("OtherFoodName") & "</td>")
            Else
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>")
            End If
            If Not IsDBNull(dtTable.Rows(i)("Amount")) Then

                ProductQty = dtTable.Rows(i)("Amount")
                If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                    subTotalQty += ProductQty
                    grandTotalQty += ProductQty
                End If
            Else
                ProductQty = 0
            End If

            If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) Then
                If dtTable.Rows(i)("ProductSettype") < 0 And dtTable.Rows(i)("ProductSettype") <> -4 Then
                    RetailPriceAfterVAT = 0
                Else
                    RetailPriceAfterVAT = dtTable.Rows(i)("TotalRetailPrice")
                End If
                PricePerUnit = RetailPriceAfterVAT / ProductQty
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(PricePerUnit).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
                If ProductQty > 0 Then
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(ProductQty).ToString(FormatObject.QtyFormat, ci) & "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl((ProductQty / totalQty)).ToString(FormatObject.PercentFormat, ci) & "</td>")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                End If
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(RetailPriceAfterVAT).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl((RetailPriceAfterVAT / totalSaleBeforeDiscount)).ToString(FormatObject.PercentFormat, ci) & "</td>")
                If dtTable.Rows(i)("TransactionStatusID") = 2 And (dtTable.Rows(i)("ProductSettype") >= 0 Or dtTable.Rows(i)("ProductSettype") = -4) Then
                    subTotalRetailPrice += dtTable.Rows(i)("TotalRetailPrice")
                    grandTotalRetailPrice += dtTable.Rows(i)("TotalRetailPrice")
                End If
            Else
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(0).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
                If ProductQty > 0 Then
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(ProductQty).ToString(FormatObject.QtyFormat, ci) & "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl((ProductQty / totalQty)).ToString(FormatObject.PercentFormat, ci) & "</td>")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                End If
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(0).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(0).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
                PricePerUnit = 0
            End If

            If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And (dtTable.Rows(i)("ProductSettype") >= 0 Or dtTable.Rows(i)("ProductSettype") = -4) Then
                PriceDiscount = dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalPrice")
                If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                    subTotalPriceDiscount += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalPrice")
                    grandTotalPriceDiscount += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalPrice")
                End If
            Else
                PriceDiscount = 0

            End If

            If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                TotalProductDiscount = 0
                If Not IsDBNull(dtTable.Rows(i)("MemberDiscount")) Then
                    TotalProductDiscount += dtTable.Rows(i)("MemberDiscount")
                    DiscountArray(2) += dtTable.Rows(i)("MemberDiscount")
                End If
                If Not IsDBNull(dtTable.Rows(i)("StaffDiscount")) Then
                    TotalProductDiscount += dtTable.Rows(i)("StaffDiscount")
                    DiscountArray(3) += dtTable.Rows(i)("StaffDiscount")
                End If
                If Not IsDBNull(dtTable.Rows(i)("CouponDiscount")) Then
                    TotalProductDiscount += dtTable.Rows(i)("CouponDiscount")
                    DiscountArray(4) += dtTable.Rows(i)("CouponDiscount")
                End If
                If Not IsDBNull(dtTable.Rows(i)("OtherPercentDiscount")) Then
                    TotalProductDiscount += dtTable.Rows(i)("OtherPercentDiscount")
                    DiscountArray(6) += dtTable.Rows(i)("OtherPercentDiscount")
                End If
                If Not IsDBNull(dtTable.Rows(i)("EachProductOtherDiscount")) Then
                    TotalProductDiscount += dtTable.Rows(i)("EachProductOtherDiscount")
                    DiscountArray(6) += dtTable.Rows(i)("EachProductOtherDiscount")
                End If
                If Not IsDBNull(dtTable.Rows(i)("VoucherDiscount")) Then
                    TotalProductDiscount += dtTable.Rows(i)("VoucherDiscount")
                    DiscountArray(5) += dtTable.Rows(i)("VoucherDiscount")
                End If
                'If Not IsDBNull(dtTable.Rows(i)("CompensateOtherDiscount")) Then
                'TotalProductDiscount += dtTable.Rows(i)("CompensateOtherDiscount")
                'DiscountArray(6) += dtTable.Rows(i)("CompensateOtherDiscount")
                'End If
                If Not IsDBNull(dtTable.Rows(i)("PricePromotionDiscount")) Then
                    TotalProductDiscount += dtTable.Rows(i)("PricePromotionDiscount")
                    DiscountArray(1) += dtTable.Rows(i)("PricePromotionDiscount")
                End If
                subTotalDiscount += TotalProductDiscount
                grandTotalDiscount += TotalProductDiscount
            End If


            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(TotalProductDiscount + PriceDiscount).ToString(FormatObject.CurrencyFormat, ci) & "</td>")

            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(RetailPriceAfterVAT - TotalProductDiscount - PriceDiscount).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(((RetailPriceAfterVAT - TotalProductDiscount - PriceDiscount) / totalSale)).ToString(FormatObject.PercentFormat, ci) & "</td>")
            If dtTable.Rows(i)("ProductSettype") >= 0 Or dtTable.Rows(i)("ProductSettype") = -4 Then
                If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                    subTotalAfterVAT += RetailPriceAfterVAT - TotalProductDiscount - PriceDiscount
                    grandTotalAfterVAT += RetailPriceAfterVAT - TotalProductDiscount - PriceDiscount
                Else
                    grandTotalVoid += RetailPriceAfterVAT - TotalProductDiscount - PriceDiscount
                End If
            End If

            If dtTable.Rows(i)("VATType") = 0 Then
                VATString = "N"
            ElseIf dtTable.Rows(i)("VATType") = 1 Then
                VATString = "V"
            Else
                VATString = "E"
            End If
            outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & VATString & "</td>")
            outputString = outputString.Append("</tr>")

            counter = counter + 1



            If Not IsDBNull(dtTable.Rows(i)("ProductGroupCode")) Then
                DummyGroupID = dtTable.Rows(i)("ProductGroupCode")
            Else
                DummyGroupID = ""
            End If
            If Not IsDBNull(dtTable.Rows(i)("ProductDeptCode")) Then
                DummyDeptID = dtTable.Rows(i)("ProductDeptCode")
            Else
                DummyDeptID = ""
            End If

        Next
        If counter > 0 Then
            outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
            If i > 0 Then
                outputString = outputString.Append("<td colspan=""4"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(91)(LangText) + " " + dtTable.Rows(i - 1)("ProductDeptName") + "</td>")
            Else
                outputString = outputString.Append("<td colspan=""4"" align=""right"" class=""" + TextClass + """></td>")
            End If
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((subTotalQty / totalQty)).ToString(FormatObject.PercentFormat, ci) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl((subTotalRetailPrice / totalSaleBeforeDiscount)).ToString(FormatObject.PercentFormat, ci) & "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalPriceDiscount + subTotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((subTotalAfterVAT / totalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
            outputString = outputString.Append("<td></td></tr>")
            If dtTable.Rows.Count > 0 Then
                Dim row As DataRow = table.NewRow()
                row("Description") = dtTable.Rows(i - 1)("ProductGroupName")
                row("Value1") = CDbl((subTotalGroupAfterVAT / totalSale) * 100).ToString(FormatObject.NumericFormat, ci)
                table.Rows.Add(row)
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""4"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(89)(LangText) + " " + dtTable.Rows(i - 1)("ProductGroupName") + LangData2.Rows(90)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalQty + subTotalGroupQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(((subTotalQty + subTotalGroupQty) / totalQty)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupRetailPrice + subTotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl((subTotalGroupRetailPrice / totalSaleBeforeDiscount)).ToString(FormatObject.PercentFormat, ci) & "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupPriceDiscount + subTotalPriceDiscount + subTotalGroupDiscount + subTotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupAfterVAT + subTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(((subTotalGroupAfterVAT + subTotalAfterVAT) / totalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                outputString = outputString.Append("<td></td></tr>")

                outputString = outputString.Append("<tr><td colspan=""12"" height=""5""></td></tr>")
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""4"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(92)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(totalQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(((totalQty) / totalQty)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(totalSaleBeforeDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl((totalSaleBeforeDiscount / totalSaleBeforeDiscount)).ToString(FormatObject.PercentFormat, ci) & "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(totalSaleBeforeDiscount - totalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(totalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(((totalSale) / totalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                outputString = outputString.Append("<td></td></tr>")
            End If
        End If

        'outputString = outputString.Append("</table>")

        If ShowSummary = True Then
            Dim ServiceChargeQuery As String = ""
            If ShopID > 0 Then
                ServiceChargeQuery = " AND a.ShopID = " + ShopID.ToString
            End If
            Select Case receiptSaleNonSaleType
                Case 2          'Non Sale
                    ServiceChargeQuery &= " AND a.TransactionStatusID = 11 "
                Case 3          'Sale + Non Sale
                    ServiceChargeQuery &= " AND a.TransactionStatusID IN (2,11) "
                Case Else       'Sale
                    ServiceChargeQuery &= " AND a.TransactionStatusID = 2 "
            End Select

            Dim grandTotalServiceChargeVAT As Double = 0
            If ShopID = 0 Then ShopID = 1
            Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel where ProductLevelID=" + ShopID.ToString, objCnn)
            Dim DisplayVATType As String = "V"
            If ShopInfo.Rows.Count > 0 Then
                If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
                    DisplayVATType = "E"
                End If
            Else
                ShopInfo = objDB.List("select * from ProductLevel where IsShop=1 AND Deleted=0", objCnn)
                If ShopInfo.Rows.Count > 0 Then
                    If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
                        DisplayVATType = "E"
                    End If
                End If
            End If

            Dim serviceCharge As DataTable = objDB.List("select SUM(a.ServiceCharge) AS ServiceCharge, SUM(a.ServiceChargeVAT) AS ServiceChargeVAT " & _
                                    "from  ordertransaction a WHERE ReceiptID > 0 AND SaleDate >= " + StartDate + " AND SaleDate < " + EndDate + ServiceChargeQuery + TimeString, objCnn)
            If Not IsDBNull(serviceCharge.Rows(0)("ServiceCharge")) Then
                grandTotalServiceCharge = serviceCharge.Rows(0)("ServiceCharge") + serviceCharge.Rows(0)("ServiceChargeVAT")
                grandTotalServiceChargeVAT = serviceCharge.Rows(0)("ServiceChargeVAT")
            Else
                grandTotalServiceCharge = 0
            End If
            Dim grandTotalSaleAvg As Double

            outputString = outputString.Append("<tr><td colspan=""12"" height=""5""></td></tr>")


            If DisplayVATType = "V" Then
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""9"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(93)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalServiceCharge).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")
                grandTotalAfterVAT += grandTotalServiceCharge
                grandTotalSaleAvg = grandTotalAfterVAT
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""9"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(95)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")

            Else
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""9"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(93)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalServiceCharge - grandTotalServiceChargeVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")

                Dim VATData As DataTable = objDB.List("select SUM(a.TransactionExcludeVAT) AS TotalVAT from  ordertransaction a WHERE ReceiptID > 0 AND SaleDate >= " + StartDate + " AND SaleDate < " + EndDate + ServiceChargeQuery + TimeString, objCnn)
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""9"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(94)(LangText) + "</td>")
                If Not IsDBNull(VATData.Rows(0)("TotalVAT")) Then
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(VATData.Rows(0)("TotalVAT") + grandTotalServiceChargeVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")
                    grandTotalSaleAvg += grandTotalServiceCharge
                    grandTotalAfterVAT += grandTotalServiceCharge + VATData.Rows(0)("TotalVAT")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(0).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")
                End If
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""9"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(95)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")

            End If

            outputString = outputString.Append("</table>")
            'End If

            Dim ChkShowComment As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramTypeID=1 AND PropertyID=91 AND KeyID=1", objCnn)
            If ChkShowComment.Rows.Count > 0 Then
                If ChkShowComment.Rows(0)("PropertyValue") = 1 Then
                    Dim CommentData As DataTable = objDB.List("select SUM(b.Amount) As TotalQty,ProductID,ProductCode,ProductName " & _
                                    "from ordertransaction a, ordercommentdetail b, Products p where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.CommentID=p.ProductID AND " & _
                                    " a.ReceiptID>0 AND a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate & ServiceChargeQuery & " group by ProductID,ProductCode,ProductName", objCnn)
                    outputString = outputString.Append("<br><table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"">")
                    outputString = outputString.Append("<tr bgColor=""" + AdminBGColor + """>")
                    outputString = outputString.Append("<td align=""center"" class=""tdHeader"">" + "Comment Code" + "</td>")
                    outputString = outputString.Append("<td align=""center"" class=""tdHeader"">" + "Comment Name" + "</td>")
                    outputString = outputString.Append("<td align=""center"" class=""tdHeader"">" + "Qty" + "</td>")
                    outputString = outputString.Append("</tr>")
                    For i = 0 To CommentData.Rows.Count - 1
                        outputString = outputString.Append("<tr>")
                        outputString = outputString.Append("<td align=""left"" class=""smallText"">" + CommentData.Rows(i)("ProductCode") + "</td>")
                        outputString = outputString.Append("<td align=""left"" class=""smallText"">" + CommentData.Rows(i)("ProductName") + " </td>")
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(CommentData.Rows(i)("TotalQty")).ToString(FormatObject.QtyFormat, ci) + "</td>")
                        outputString = outputString.Append("</tr>")
                    Next
                    outputString = outputString.Append("</table>")
                End If
            End If

            Dim FinalSaleAmount As Double
            'If DisplayVATType = "V" Then
            DiscountArray(0) = grandTotalPriceDiscount + grandTotalDiscount
            DiscountArray(1) += grandTotalPriceDiscount
            If dtTable.Rows.Count > 0 Then
                Dim ResultSummary As String = SaleReportSummaryNew(receiptSaleNonSaleType, grandTotalSaleAvg, grandTotalRetailPrice, FinalSaleAmount, GrayBGColor, AdminBGColor, ShopID, ViewOption, StartDate, EndDate, grandTotalVAT, grandTotalAfterVAT, grandTotalVoid, PaymentResult, PayByCreditMoney, DiscountArray, True, False, LangID, LangPath, objCnn)
                outputString = outputString.Append(ResultSummary)
            End If

            'End If
        End If
        grandTotal = grandTotalAfterVAT
        ResultString = outputString.ToString()

    End Function

    Public Function SaleReportSummaryNew(receiptSaleNonSaleType As Integer, ByVal grandTotalSaleAvg As Double, ByVal grandTotalRetailPrice As Double, ByRef FinalSaleAmount As Double, ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal ShopID As Integer, ByVal ViewOption As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal grandTotalVAT As Double, ByVal grandTotalAfterVAT As Double, ByVal grandTotalVoid As Double, ByVal PaymentResult As DataTable, ByVal PayByCreditMoney As DataTable, ByVal DiscountArray() As Double, ByVal ShowStatistics As Boolean, ByVal VATDisplay As Boolean, ByVal LangID As Integer, ByVal LangPath As String, ByVal objCnn As MySqlConnection) As String

        Dim FormatData As DataTable = Fm.FormatParam(FormatObject, LangID, objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
        Dim totalRealSale As Double = 0
        Dim totalPaymentValue As Double = 0
        Dim ColSpan As String
        Dim TextClass As String
        Dim i, j As Integer
        Dim outputString As String = ""
        Dim totalVATNotPaid As Double = 0
        Dim strTransStatus, strVoidTransStatus As String

        Dim LangData2 As DataTable = pRoMiSeLanguage.pRoMiSeLanguage.LangInfo(6, 2, -1, LangPath)
        Dim LangText As String = "lang" + LangID.ToString

        Dim VATValue As Double = 0
        Dim VATData As DataTable = objDB.List("SELECT CompanyVAT FROM CompanyProfile WHERE CompanyID=" + ShopID.ToString, objCnn)
        If VATData.Rows.Count > 0 Then
            If Not IsDBNull(VATData.Rows(0)("CompanyVAT")) Then
                VATValue = VATData.Rows(0)("CompanyVAT")
            Else
                VATValue = 0
            End If
        End If

        Dim HavePrepaidDiscount As Boolean = False
        Dim totalActual As Double = 0
        For i = 0 To PaymentResult.Rows.Count - 1
            totalPaymentValue += PaymentResult.Rows(i)("TotalPay")
            totalActual += PaymentResult.Rows(i)("TotalPay") - PaymentResult.Rows(i)("TotalPayDiscount")
            If PaymentResult.Rows(i)("TotalPayDiscount") > 0 Then
                HavePrepaidDiscount = True
            End If
        Next

        If VATDisplay = False Then
            If HavePrepaidDiscount = True Then
                ColSpan = "6"
            Else
                ColSpan = "3"
            End If
        Else
            ColSpan = "4"
        End If

        outputString += "<br><table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"">"
        outputString += "<tr bgColor=""" + AdminBGColor + """>"
        outputString += "<td colspan=""" + ColSpan.ToString + """ align=""center"" class=""tdHeader"">" + LangData2.Rows(41)(LangText) + "</td>"
        outputString += "</tr>"
        outputString += "<tr bgColor=""" + AdminBGColor + """>"
        outputString += "<td align=""center"" class=""tdHeader"">" + LangData2.Rows(42)(LangText) + "</td>"
        If VATDisplay = True Then
            outputString += "<td align=""center"" class=""tdHeader"">" + LangData2.Rows(73)(LangText) + "</td>"
        End If
        outputString += "<td align=""center"" class=""tdHeader"">" + LangData2.Rows(52)(LangText) + "</td>"
        outputString += "<td align=""center"" class=""tdHeader"">%</td>"
        If HavePrepaidDiscount = True Then
            outputString += "<td align=""center"" class=""tdHeader"">" + LangData2.Rows(74)(LangText) + "</td>"
            outputString += "<td align=""center"" class=""tdHeader"">" + LangData2.Rows(75)(LangText) + "</td>"
            outputString += "<td align=""center"" class=""tdHeader"">%</td>"
        End If

        outputString += "</tr>"

        Dim totalPaymentDiscount As Double = 0
        For i = 0 To PaymentResult.Rows.Count - 1
            If PaymentResult.Rows(i)("IsSale") = 1 Then
                totalRealSale += PaymentResult.Rows(i)("TotalPay")
                TextClass = "smallText"
            Else
                TextClass = "smallText"
            End If
            totalPaymentDiscount += PaymentResult.Rows(i)("TotalPayDiscount")

            outputString += "<tr>"
            If PaymentResult.Rows(i)("PayTypeID") = 7 Or (PaymentResult.Rows(i)("PayTypeID") >= 10 And PaymentResult.Rows(i)("IsOtherReceipt") = 0 And PaymentResult.Rows(i)("IsSale") = 1) Then
        '        outputString += "<td align=""right"" class=""" + TextClass + """>" + PaymentResult.Rows(i)("PayTypeName") + "</td>"
            ElseIf PaymentResult.Rows(i)("PayTypeID") = 2 Then
         '       outputString += "<td align=""right"" class=""" + TextClass + """>" + PaymentResult.Rows(i)("PayTypeName") + "</td>"
            ElseIf PaymentResult.Rows(i)("PayTypeID") = 5 Then
          '      outputString += "<td align=""right"" class=""" + TextClass + """>" + PaymentResult.Rows(i)("PayTypeName") + "</td>"
            ElseIf PaymentResult.Rows(i)("PayTypeID") = 3 Then
           '     outputString += "<td align=""right"" class=""" + TextClass + """>" + PaymentResult.Rows(i)("PayTypeName") + "</td>"
            ElseIf PaymentResult.Rows(i)("PayTypeID") = 9 Then
            '    outputString += "<td align=""right"" class=""" + TextClass + """>" + PaymentResult.Rows(i)("PayTypeName") + "</td>"
            Else
             '   outputString += "<td align=""right"" class=""" + TextClass + """>" + PaymentResult.Rows(i)("PayTypeName") + "</td>"
            End If

            If PaymentResult.Rows(i)("PayTypeID") = 1 Or PaymentResult.Rows(i)("PayTypeID") = 7 Or (PaymentResult.Rows(i)("PayTypeID") >= 10 And PaymentResult.Rows(i)("IsOtherReceipt") >= 0 And PaymentResult.Rows(i)("IsSale") = 1) Then
                outputString += "<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'coupon_voucher.aspx?ViewOption=0&PayTypeID=" + PaymentResult.Rows(i)("PayTypeID").ToString + "&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=600,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + PaymentResult.Rows(i)("PayTypeName") + "</a></td>"
            ElseIf PaymentResult.Rows(i)("PayTypeID") = 2 Then
                outputString += "<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'CreditCard/CreditCard_SaleReport.aspx?ViewOption=0&CCTypeID=-1&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=700,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + PaymentResult.Rows(i)("PayTypeName") + "</a></td>"
            ElseIf PaymentResult.Rows(i)("PayTypeID") = 5 Then
                outputString += "<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_creditmoney.aspx?ViewOption=1&PayTypeID=5&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=700,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + PaymentResult.Rows(i)("PayTypeName") + "</a></td>"
            ElseIf PaymentResult.Rows(i)("PayTypeID") = 3 Then
                outputString += "<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_creditmoney.aspx?ViewOption=1&PayTypeID=3&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=700,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + PaymentResult.Rows(i)("PayTypeName") + "</a></td>"
            ElseIf PaymentResult.Rows(i)("PayTypeID") = 9 Then
                outputString += "<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_creditmoney.aspx?ViewOption=1&PayTypeID=9&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=700,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + PaymentResult.Rows(i)("PayTypeName") + "</a></td>"
            Else
                outputString += "<td align=""right"" class=""" + TextClass + """>" + PaymentResult.Rows(i)("PayTypeName") + "</td>"
            End If
			
			
			
            If VATDisplay = True Then
                If PaymentResult.Rows(i)("IsVAT") = 1 Then
                    outputString += "<td align=""right"" class=""" + TextClass + """>-</td>"
                Else
                    totalVATNotPaid += PaymentResult.Rows(i)("TotalVAT")
                    outputString += "<td align=""right"" class=""" + TextClass + """>" + CDbl(PaymentResult.Rows(i)("TotalVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                End If
            End If

            outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(PaymentResult.Rows(i)("TotalPay")).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
            outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl((PaymentResult.Rows(i)("TotalPay") / totalPaymentValue)).ToString(FormatObject.PercentFormat, ci) + "</td>"
            If HavePrepaidDiscount = True Then
                If PaymentResult.Rows(i)("TotalPayDiscount") > 0 Then
                    outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(PaymentResult.Rows(i)("TotalPayDiscount")).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                Else
                    outputString += "<td align=""right"" class=""" + TextClass + """>-</td>"
                End If
                outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(PaymentResult.Rows(i)("TotalPay") - PaymentResult.Rows(i)("TotalPayDiscount")).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl((PaymentResult.Rows(i)("TotalPay") - PaymentResult.Rows(i)("TotalPayDiscount")) / totalActual).ToString(FormatObject.PercentFormat, ci) + "</td>"
            End If

            outputString += "</tr>"
        Next
        TextClass = "smallText"
        outputString += "<tr bgColor=""" + GrayBGColor + """>"
        outputString += "<td align=""right"" class=""" + TextClass + """>" + LangData2.Rows(43)(LangText) + "</td>"
        If VATDisplay = True Then
            outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(grandTotalVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
        End If

        outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(totalPaymentValue).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
        outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(1).ToString(FormatObject.PercentFormat, ci) + "</td>"
        If HavePrepaidDiscount = True Then
            outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(totalPaymentDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
            outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(totalPaymentValue - totalPaymentDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
            outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(1).ToString(FormatObject.PercentFormat, ci) + "</td>"
        End If

        outputString += "</tr>"

        Dim getProp As New CPreferences
        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
        Dim CheckDiff As Double = Math.Round(totalPaymentValue * 100) - Math.Round(grandTotalAfterVAT * 100)
        If PropertyInfo.Rows(0)("SummaryPrepaidInSaleReport") = 1 Then
            If CheckDiff <> 0 Then
                outputString += "<tr>"
                outputString += "<td align=""right"" class=""" + TextClass + """>" + LangData2.Rows(44)(LangText) + "</td>"
                If VATDisplay = True Then
                    outputString += "<td class=""" + TextClass + """ align=""right"">-</td>"
                End If
                outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(totalPaymentValue - grandTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                outputString += "<td class=""" + TextClass + """ align=""right"">-</td>"
                outputString += "</tr>"
            End If
            If totalPaymentValue <> totalRealSale Then
                outputString += "<tr bgColor=""#ebebeb"">"
                outputString += "<td align=""right"" class=""" + TextClass + """>" + LangData2.Rows(76)(LangText) + "</td>"
                If VATDisplay = True Then
                    outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(grandTotalVAT - totalVATNotPaid).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                End If
                outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(totalRealSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                outputString += "<td class=""" + TextClass + """ align=""right"">-</td>"
                outputString += "</tr>"
            End If
        End If

        TextClass = "smallText"
        Dim totalPayByCreditMoney As Double = 0
        Dim totalVATCreditMoney As Double = 0
        Dim CreditMoneyText As String
        If PayByCreditMoney.Rows.Count > 0 Then

            For i = 0 To PayByCreditMoney.Rows.Count - 1
                If Not IsDBNull(PayByCreditMoney.Rows(i)("TotalPay")) Then
                    totalPayByCreditMoney += PayByCreditMoney.Rows(i)("TotalPay")
                End If
            Next
            For i = 0 To PayByCreditMoney.Rows.Count - 1
                If Not IsDBNull(PayByCreditMoney.Rows(i)("TotalPay")) Then
                    totalVATCreditMoney += PayByCreditMoney.Rows(i)("TotalVAT")
                    outputString += "<tr>"
                    If Not IsDBNull(PayByCreditMoney.Rows(i)("PayTypeName")) Then
                        CreditMoneyText = PayByCreditMoney.Rows(i)("PayTypeName")
                    Else
                        CreditMoneyText = "Back Office"
                    End If
                    outputString += "<td align=""right"" class=""" + TextClass + """>" + LangData2.Rows(83)(LangText) + " " + CreditMoneyText + "</td>"
                    If VATDisplay = True Then
                        outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(PayByCreditMoney.Rows(i)("TotalPay") * (VATValue / (VATValue + 100))).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                    End If
                    outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(PayByCreditMoney.Rows(i)("TotalPay")).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                    outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl((PayByCreditMoney.Rows(i)("TotalPay") / totalPayByCreditMoney)).ToString(FormatObject.PercentFormat, ci) + "</td>"
                    outputString += "</tr>"
                End If
            Next
            If totalPayByCreditMoney > 0 Then
                outputString += "<tr bgColor=""#eeeeee"">"
                outputString += "<td align=""right"" class=""" + TextClass + """>" + LangData2.Rows(84)(LangText) + "</td>"
                If VATDisplay = True Then
                    outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(totalVATCreditMoney).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                End If

                outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(totalPayByCreditMoney).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                outputString += "<td class=""" + TextClass + """ align=""right"">100.00%</td>"
                outputString += "</tr>"
                outputString += "<tr bgColor=""#ebebeb"">"
                outputString += "<td align=""right"" class=""" + TextClass + """>" + LangData2.Rows(85)(LangText) + "</td>"
                If VATDisplay = True Then
                    outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(grandTotalVAT + totalVATCreditMoney - totalVATNotPaid).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                End If

                outputString += "<td class=""" + TextClass + """ align=""right"">" + CDbl(totalPaymentValue + totalPayByCreditMoney).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                outputString += "<td class=""" + TextClass + """ align=""right"">-</td>"
                outputString += "</tr>"
                FinalSaleAmount += totalPayByCreditMoney
            End If
        End If

        outputString += "</table>"

        FinalSaleAmount = grandTotalAfterVAT
        totalRealSale = grandTotalAfterVAT
        ShowStatistics = False
        If ShowStatistics = True Then
            outputString += "<br><table><tr>"
            If DiscountArray(0) <> 0 Then 'Grand Total Discount
                outputString += "<td valign=""top"">"
                outputString += "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"">"
                outputString += "<tr>"
                outputString += "<td colspan=""3"" align=""center"" class=""tdHeader"" bgColor=""" + AdminBGColor + """>" + LangData2.Rows(45)(LangText) + " (% " + LangData2.Rows(72)(LangText) + " " + CDbl(grandTotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + ")</td>"
                outputString += "</tr>"
                outputString += "<tr>"
                outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """>" + LangData2.Rows(46)(LangText) + "</td>"
                outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """>" + LangData2.Rows(47)(LangText) + "</td>"
                outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """>%</td>"
                outputString += "</tr>"
                If DiscountArray(1) <> 0 Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">" + LangData2.Rows(77)(LangText) + "</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(DiscountArray(1)).ToString(FormatObject.CurrencyFormat, ci) + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(DiscountArray(1) / grandTotalRetailPrice).ToString(FormatObject.PercentFormat, ci) + "</td>"
                    outputString += "</tr>"
                End If
                If DiscountArray(2) <> 0 Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">" + LangData2.Rows(78)(LangText) + "</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(DiscountArray(2)).ToString(FormatObject.CurrencyFormat, ci) + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(DiscountArray(2) / grandTotalRetailPrice).ToString(FormatObject.PercentFormat, ci) + "</td>"
                    outputString += "</tr>"
                End If
                If DiscountArray(3) <> 0 Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">" + LangData2.Rows(79)(LangText) + "</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(DiscountArray(3)).ToString(FormatObject.CurrencyFormat, ci) + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(DiscountArray(3) / grandTotalRetailPrice).ToString(FormatObject.PercentFormat, ci) + "</td>"
                    outputString += "</tr>"
                End If
                If DiscountArray(4) <> 0 Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText""><a class=""smallText"" href=""JavaScript: newWindow = window.open( 'coupon_voucher.aspx?ViewOption=4&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=600,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + LangData2.Rows(80)(LangText) + "</a></td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(DiscountArray(4)).ToString(FormatObject.CurrencyFormat, ci) + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(DiscountArray(4) / grandTotalRetailPrice).ToString(FormatObject.PercentFormat, ci) + "</td>"
                    outputString += "</tr>"
                End If
                If DiscountArray(5) <> 0 Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText""><a class=""smallText"" href=""JavaScript: newWindow = window.open( 'coupon_voucher.aspx?ViewOption=5&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=600,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + LangData2.Rows(81)(LangText) + "</a></td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(DiscountArray(5)).ToString(FormatObject.CurrencyFormat, ci) + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(DiscountArray(5) / grandTotalRetailPrice).ToString(FormatObject.PercentFormat, ci) + "</td>"
                    outputString += "</tr>"
                End If
                If DiscountArray(6) <> 0 Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">" + LangData2.Rows(86)(LangText) + "</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(DiscountArray(6)).ToString(FormatObject.CurrencyFormat, ci) + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(DiscountArray(6) / grandTotalRetailPrice).ToString(FormatObject.PercentFormat, ci) + "</td>"
                    outputString += "</tr>"
                End If
                If DiscountArray(0) <> 0 Then
                    outputString += "<tr>"
                    outputString += "<td align=""right"" class=""smallText"" bgColor=""" + GrayBGColor + """><a class=""smallText"" href=""JavaScript: newWindow = window.open( 'report_promotion_byproduct.aspx?ViewOption=" + ViewOption.ToString + "&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=800,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + LangData2.Rows(82)(LangText) + "</a></td>"
                    outputString += "<td align=""right"" class=""smallText"" bgColor=""" + GrayBGColor + """>" + CDbl(DiscountArray(0)).ToString(FormatObject.CurrencyFormat, ci) + " </td>"
                    outputString += "<td align=""right"" class=""smallText"" bgColor=""" + GrayBGColor + """>" + CDbl(DiscountArray(0) / grandTotalRetailPrice).ToString(FormatObject.PercentFormat, ci) + "</td>"
                    outputString += "</tr>"
                End If
                outputString += "</table>"
                outputString += "</td>"
            End If

            Select Case receiptSaleNonSaleType
                Case 2          'Sale
                    strTransStatus = " AND TransactionStatusID = 11 AND DocType NOT IN (4,8) "
                    strVoidTransStatus = " AND TransactionStatusID IN (12,13) AND DocType NOT IN (4,8) "
                Case 3          'Non Sale
                    strTransStatus = " AND TransactionStatusID IN (2,11) "
                    strVoidTransStatus = " AND TransactionStatusID IN (5,8,12,13) "
                Case Else       'Sale + Non Sale
                    strTransStatus = " AND TransactionStatusID = 2 AND DocType IN (4,8) "
                    strVoidTransStatus = " AND TransactionStatusID IN (5,8) AND DocType IN (4,8) "
            End Select

            Dim AvgBill As DataTable = objDB.List("select count(*) AS TotalBill, SUM(NoCustomer) AS TotalCustomer from OrderTransaction " & _
                                "where (SaleDate >= " + StartDate + " and SaleDate < " + EndDate + ") AND ReceiptID>0 AND ShopID IN (" + ShopID.ToString + ")" & strTransStatus, objCnn)
            Dim ChkAvgBill As DataTable = objDB.List("select count(*) AS MinusBill, SUM(NoCustomer) AS MinusCustomer from OrderTransaction a left outer join orderdetail b on a.transactionid=b.transactionid and a.computerid=b.computerid " & _
                                "where b.transactionid is null AND (SaleDate >= " + StartDate + " and SaleDate < " + EndDate + ") AND ReceiptID>0 AND ShopID IN (" + ShopID.ToString + ")" & strTransStatus, objCnn)
            Dim VoidBill As DataTable = objDB.List("select count(*) AS VoidBill from OrderTransaction where (SaleDate >= " + StartDate + " and SaleDate < " + EndDate + ") AND " & _
                                "ReceiptID>0 AND ShopID IN (" + ShopID.ToString + ")" & strVoidTransStatus, objCnn)
            Dim totalQty As DataTable = objDB.List("select SUM(b.Amount) AS TotalQty from OrderTransaction a, OrderDetail b " & _
                                "where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND (SaleDate >= " + StartDate + " and SaleDate < " + EndDate + ") AND " & _
                                "ReceiptID>0 AND b.OrderStatusID NOT IN (3,4) AND a.ShopID IN (" + ShopID.ToString + ")" & strTransStatus, objCnn)
            Dim TotalBill As Double = 1
            Dim TotalCustomer As Double = 1

            If Not IsDBNull(AvgBill.Rows(0)("TotalBill")) And Not IsDBNull(AvgBill.Rows(0)("TotalCustomer")) Then
                TotalBill = AvgBill.Rows(0)("TotalBill")
                TotalCustomer = AvgBill.Rows(0)("TotalCustomer")
                If Not IsDBNull(ChkAvgBill.Rows(0)("MinusBill")) Then
                    TotalBill = TotalBill - ChkAvgBill.Rows(0)("MinusBill")
                End If
                If Not IsDBNull(ChkAvgBill.Rows(0)("MinusCustomer")) Then
                    TotalCustomer = TotalCustomer - ChkAvgBill.Rows(0)("MinusCustomer")
                End If
                outputString += "<td valign=""top"">"
                outputString += "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"">"
                outputString += "<tr>"
                outputString += "<td colspan=""4"" align=""center"" class=""tdHeader"" bgColor=""" + AdminBGColor + """>" + LangData2.Rows(48)(LangText) + "</td>"
                outputString += "</tr>"
                outputString += "<tr>"
                outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """></td>"
                outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """>#</td>"
                outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """>" + LangData2.Rows(50)(LangText) + "</td>"
                outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """>" + LangData2.Rows(51)(LangText) + "</td>"
                outputString += "</tr>"


                If Not IsDBNull(AvgBill.Rows(0)("TotalCustomer")) Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">" + LangData2.Rows(54)(LangText) + "</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(TotalCustomer).ToString(FormatObject.QtyFormat, ci) + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(grandTotalSaleAvg).ToString(FormatObject.CurrencyFormat, ci) + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(grandTotalSaleAvg / TotalCustomer).ToString(FormatObject.NumericFormat, ci) + "</td>"
                    outputString += "</tr>"
                End If
                If Not IsDBNull(AvgBill.Rows(0)("TotalBill")) Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">" + LangData2.Rows(55)(LangText) + "</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(TotalBill).ToString(FormatObject.QtyFormat, ci) + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(grandTotalSaleAvg).ToString(FormatObject.CurrencyFormat, ci) + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(grandTotalSaleAvg / TotalBill).ToString(FormatObject.NumericFormat, ci) + "</td>"
                    outputString += "</tr>"
                End If
                If Not IsDBNull(totalQty.Rows(0)("totalQty")) Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">" + LangData2.Rows(56)(LangText) + "</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(TotalBill).ToString(FormatObject.QtyFormat, ci) + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(totalQty.Rows(0)("totalQty")).ToString(FormatObject.QtyFormat, ci) + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(totalQty.Rows(0)("totalQty") / TotalBill).ToString(FormatObject.NumericFormat, ci) + "</td>"
                    outputString += "</tr>"
                End If
                outputString += "</table>"
                outputString += "</td>"
            End If

            If AvgBill.Rows(0)("TotalBill") > 0 Or VoidBill.Rows(0)("VoidBill") > 0 Then
                outputString += "<td valign=""top"">"
                outputString += "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"">"
                outputString += "<tr>"
                outputString += "<td colspan=""3"" align=""center"" class=""tdHeader"" bgColor=""" + AdminBGColor + """>" + LangData2.Rows(49)(LangText) + "</td>"
                outputString += "</tr>"
                outputString += "<tr>"
                outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """></td>"
                outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """>#</td>"
                outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """>" + LangData2.Rows(52)(LangText) + "</td>"
                outputString += "</tr>"


                If Not IsDBNull(AvgBill.Rows(0)("TotalBill")) Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">" + LangData2.Rows(57)(LangText) + "</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(TotalBill).ToString(FormatObject.QtyFormat, ci) + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(grandTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + " </td>"
                    outputString += "</tr>"
                End If
                If Not IsDBNull(VoidBill.Rows(0)("VoidBill")) Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">" + LangData2.Rows(58)(LangText) + "</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(VoidBill.Rows(0)("VoidBill")).ToString(FormatObject.QtyFormat, ci) + " </td>"
                    If grandTotalVoid = 0 And VoidBill.Rows(0)("VoidBill") > 0 Then
                        Dim VoidData As DataTable = objDB.List("select SUM(ReceiptSalePrice) As TransactionPrice from ordertransaction a where  a.receiptid>0 and a.transactionstatusid<>2 AND (SaleDate >= " + StartDate + " and SaleDate < " + EndDate + ") AND a.ShopID IN (" + ShopID.ToString + ")", objCnn)
                        For i = 0 To VoidData.Rows.Count - 1
                            grandTotalVoid += VoidData.Rows(i)("TransactionPrice")
                        Next
                    End If
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(grandTotalVoid).ToString(FormatObject.CurrencyFormat, ci) + " </td>"
                    outputString += "</tr>"
                End If
                If Not IsDBNull(AvgBill.Rows(0)("TotalBill")) And Not IsDBNull(VoidBill.Rows(0)("VoidBill")) Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">" + LangData2.Rows(59)(LangText) + "</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(TotalBill + VoidBill.Rows(0)("VoidBill")).ToString(FormatObject.QtyFormat, ci) + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(grandTotalAfterVAT + grandTotalVoid).ToString(FormatObject.CurrencyFormat, ci) + " </td>"

                    outputString += "</tr>"
                End If
                outputString += "</table></td>"
            End If
            outputString += "</tr></table>"

        End If
        Return outputString
    End Function

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
