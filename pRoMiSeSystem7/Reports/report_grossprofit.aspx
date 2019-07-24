<%@ Page Language="VB" ContentType="text/html" EnableViewState="True" debug="True" %>
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
<%@Import Namespace="ProfitLossReport" %>
<%@Import Namespace="CostingClass.pRoMiSeCosting" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Profit Loss Reports</title>
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
<a name="TopPage" id="TopPage"></a>
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Profit Loss Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
			<tr>
				<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
			</tr>
		</table></td>
	<td valign="top">
	<table>
		<tr id="showDay" visible="false" runat="Server">
		<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="DailyDate" runat="server" /></td>
		<td colspan="2"><asp:CheckBox ID="ExpandReceipt" Visible="false" CssClass="text" Checked="false" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
		<td colspan="2"><synature:date id="MonthYearDate" runat="server" /></td>
		<td><asp:dropdownlist ID="GroupByParam" Width="200" Visible="True" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
		</tr>
		<tr id="showyear" visible="false" runat="server">
		<td><asp:radiobutton ID="Radio_4" GroupName="Group1" runat="server" /></td>
		<td colspan="3"><synature:date id="YearDate" runat="server" /></td>
		</tr>
		<tr id="showPeriod" visible="false" runat="Server">
		<td><asp:radiobutton ID="Radio_2" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="CurrentDate" runat="server" /></td>
		<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
		<td><synature:date id="ToDate" runat="server" /></td>
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

<tr><td align="center" colspan="2"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
</table>
<span id="startTable" runat="server"></span>

	<span id="TableHeaderText" runat="server"></span>
	
	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>

<asp:Panel ID="showGraph" Visible="false" runat="server">
<br>
<Web:ChartControl id="ChartControl1" ChartPadding=40 runat="Server" />
</asp:Panel></span>
<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table>
<div class="noprint">
<table width="100%">
<tr><td width="100%" align="right"><a href="javascript: window.print()">Print Report</a>&nbsp;&nbsp;<a href="#TopPage">Top Page</a></td></tr></table>
</div>
</div>
</form>
</div>
<div id="errorMsg1" runat="server" />
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
Dim getReport As New StReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim CostInfo As New CostClass()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer  = 998
		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_GrossProfit") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		errorMsg.InnerHtml = "This page is not use"
		objDB.sqlExecute("update permissionitem set Deleted=1 where PermissionItemID=609", objCnn)
			ShowShop.Visible = False
			Exit Sub
			
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
		
		DocumentToDateParam.InnerHtml =LangDefault.Rows(22)(LangText)
			
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
		
		ResultText.InnerHtml = ""
		ResultSearchText.InnerHtml = ""
		errorMsg.InnerHtml = ""
		
		Dim GroupData As DataTable = objDB.List("select -1 As ExpenseID,'-- All --                        ' As ExpenseName,-1 As Ordering UNION select 0 As ExpenseID,'Selling Report' As ExpenseName,0 As Ordering UNION select 9999 As ExpenseID,'Gross Profit' As ExpenseName,9999 As Ordering UNION select ExpenseID,ExpenseName,Ordering from Expense order by Ordering", objCnn)
		If Not Page.IsPostBack Then
			GroupByParam.DataSource = GroupData
			GroupByParam.DataValueField = "ExpenseID"
			GroupByParam.DataTextField = "ExpenseName"
			GroupByParam.DataBind()
		End If
		
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
		End If
		If Page.IsPostBack AND Request.Form("YearDate_Year") = "" Then Session("YearDate_Year") = 0
		YearDate.SelectedYear = Session("YearDate_Year")
		
		If Not Page.IsPostBack Then
			Radio_1.Checked = True
		End If

		Dim ShopIDValue As String = "0"
		If IsNumeric(Request.Form("ShopID")) Then
			ShopIDValue = Request.Form("ShopID").ToString
		Else If IsNumeric(Request.QueryString("ShopID"))
			ShopIDValue = Request.QueryString("ShopID").ToString
		End If
			
		Dim i As Integer
		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		Dim Multiple As Boolean = False
		Dim ShopList As String = ""
		
		Dim ShopData As DataTable = getInfo.GetProductLevel(-999,objCnn)
		If ShopData.Rows.Count > 0 Then

			outputString = "<select name=""ShopID"">"

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
				
		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
	  
	Else
		showPage.Visible = False
		errorMsg.InnerHtml = "Access Denied"
	End If
End Sub

Sub DoSearch(Source As Object, E As EventArgs)
	Dim FoundError As Boolean
	FoundError = False
	Session("ReportResult") = ""
	Dim LangData2 As DataTable = getProp.GetLangData(PageID,2,-1,Request)
	Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
	Dim LangText As String = "lang" + Session("LangID").ToString
	Dim FormatData As DataTable = Util.FormatParam(FormatObject,Session("LangID"),objCnn)
	Dim ci As New CultureInfo(FormatObject.CultureString)
	
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""
	Dim DailyDateValue As String = ""
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
	Dim outputString As String = ""

	Dim ReportDate As String
	Dim YearValue4 As Integer
	Dim LastDay As Integer = 0
	If Radio_1.Checked = True Then
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
		Dim LastDate As New Date(EndYearValue,EndMonthValue,1)
		LastDay = Day(DateAdd("d",-1,LastDate))
		Catch ex As Exception
			FoundError = True
		End Try
	ElseIf Radio_2.Checked = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(Request.Form("Doc_Day"),Request.Form("Doc_Month"),Request.Form("Doc_Year"))
		Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate).ToString("yyyy-MM-dd HH:mm:ss", InvC)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),Year(CheckDate))
		
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
	Else If Radio_3.Checked = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(Request.Form("DocDaily_Day"),Request.Form("DocDaily_Month"),Request.Form("DocDaily_Year"))
		Dim CheckDate As New DateTime(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"), 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate).ToString("yyyy-MM-dd HH:mm:ss", InvC)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),Year(CheckDate))

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
	Else If Radio_4.Checked = True Then
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
		
		Dim ResultData As New DataSet
		Dim dtTable As DataTable
		Dim SaleData As DataTable
		Dim InvenData As DataTable
		Dim OtherMenuData As DataTable
		Dim ProductPROData As DataTable
		Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel where ProductLevelID=" + Request.Form("ShopID").ToString, objCnn)
		Dim VATType As String = "V"
		Dim DisplayVAT As String = " (Include VAT)"
		If ShopInfo.Rows.Count > 0 Then
			If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
				VATType = "E"
				DisplayVAT = " (Exclude VAT)"
			End If
		End If
		Application.Lock()
		Dim ColData As DataTable = ProfitLoss(SaleData,InvenData,OtherMenuData, Request.Form("MonthYearDate_Month"), Request.Form("MonthYearDate_Year"), StartDate, EndDate, Request.Form("ShopID"),"",VATType,objCnn)
		Application.UnLock()
		
		Dim ShowGrossProfit As Boolean = False'
		Dim ShowOther As Boolean = True
		Dim getExpense As DataTable 
		If Request.Form("GroupByParam") = -1 Or Request.Form("GroupByParam") = 9999 Then
			getExpense = objDB.List("select 0 As ExpenseID,'Selling Report                   ' As ExpenseName,1 As Costing,0 As Ordering,0 As ExcludeVAT UNION select ExpenseID,ExpenseName,Costing,Ordering,ExcludeVAT from Expense order by Ordering", objCnn)
			ShowGrossProfit = True
			If Request.Form("GroupByParam") = 9999 Then
				ShowOther = False
			End If
		ElseIf Request.Form("GroupByParam") = 0 Then
			getExpense = objDB.List("select 0 As ExpenseID,'Selling Report                   ' As ExpenseName,1 As Costing,0 As Ordering,0 As ExcludeVAT", objCnn)
		Else
			getExpense = objDB.List("select ExpenseID,ExpenseName,Costing,Ordering,ExcludeVAT from Expense where ExpenseID=" + Request.Form("GroupByParam").ToString + " order by Ordering", objCnn)
		End If
		
		Dim getCategory As DataTable = objDB.List("select * from ExpenseGroupName order by Ordering", objCnn)
		Dim i,j As Integer
		Dim HeaderString As String = ""
		Dim CostingText As String = ""
		Dim VATText As String = ""
		HeaderString = "<tr>"
		HeaderString += "<td rowspan=""3"" align=""center"" valign=""middle"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Date</td>"
		If ShowOther = True Then
			For i = 0 To getExpense.Rows.Count - 1
				CostingText = ""
				If getExpense.Rows(i)("Costing") = 1 Then
					CostingText = "**"
				End If
				If getExpense.Rows(i)("ExpenseID") = 0 Then
					VATText = DisplayVAT
				Else
					If getExpense.Rows(i)("ExcludeVAT") = 1 Then
						VATText = " (Exclude VAT)"
					Else
						VATText = " (Include VAT)"
					End If
				End If
				HeaderString += "<td colspan=""" + ((getCategory.Rows.Count+1)*2).ToString + """ align=""center"" class=""tdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + getExpense.Rows(i)("ExpenseName") + CostingText + VATText + "</td>"
			Next
		End If
		If ShowGrossProfit = True Then
			HeaderString += "<td colspan=""" + ((getCategory.Rows.Count+1)*4).ToString + """ align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Gross Profit" + "</td>"
		End If
		HeaderString += "</tr>"
		HeaderString += "<tr>"
		Dim Span As String
		If ShowOther = True Then
			For j = 0 To getExpense.Rows.Count - 1
				Span = "2"
				For i = 0 To getCategory.Rows.Count - 1
					HeaderString += "<td align=""center"" colspan=""" + Span + """ valign=""middle"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + getCategory.Rows(i)("PMGroupName") + "</td>"
				Next
				HeaderString += "<td align=""center"" colspan=""" + Span + """ valign=""middle"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Total Monthly" + "</td>"
			Next
		End If
		If ShowGrossProfit = True Then
			Span = "4"
			For i = 0 To getCategory.Rows.Count - 1
				HeaderString += "<td align=""center"" colspan=""" + Span + """ valign=""middle"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + getCategory.Rows(i)("PMGroupName") + "</td>"
			Next
			HeaderString += "<td align=""center"" colspan=""" + Span + """ valign=""middle"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Total Monthly" + "</td>"
		End if
		HeaderString += "</tr>"
		If ShowOther = True Then
			For j = 0 To getExpense.Rows.Count - 1

				For i = 0 To getCategory.Rows.Count
					HeaderString += "<td align=""center"" valign=""middle"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Daily" + "</td>"
					HeaderString += "<td align=""center"" valign=""middle"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Monthly" + "</td>"
				Next

			Next
		End If
		If ShowGrossProfit = True Then
			For i = 0 To getCategory.Rows.Count
			  If i = getCategory.Rows.Count Then
			    HeaderString += "<td align=""center"" valign=""middle"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Daily" + "</td>"
				HeaderString += "<td align=""center"" valign=""middle"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "%" + "</td>"
				HeaderString += "<td align=""center"" valign=""middle"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Monthly" + "</td>"
				HeaderString += "<td align=""center"" valign=""middle"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "%" + "</td>"
			  Else
				HeaderString += "<td align=""center"" valign=""middle"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Daily" + "</td>"
				HeaderString += "<td align=""center"" valign=""middle"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "%Cost" + "</td>"
				HeaderString += "<td align=""center"" valign=""middle"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Monthly" + "</td>"
				HeaderString += "<td align=""center"" valign=""middle"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "%Cost" + "</td>"
			  End If
			Next
		End If
		HeaderString += "</tr>"
		TableHeaderText.InnerHtml = HeaderString
		Dim TestString As String = ""
		Dim TextClass As String = "smallText"
		Dim ColSpan As String = "1"
		Dim Align As String = ""
		Dim outString As StringBuilder = New StringBuilder
		Dim foundRows() As DataRow
        Dim expression As String
		Dim foundRows2() As DataRow
        Dim expression2 As String
		Dim sumEachProfit(getCategory.Rows.Count) As Double
		Dim sumEachSale(getCategory.Rows.Count) As Double
		Dim sumEachCost(getCategory.Rows.Count) As Double
		Dim MontlyArrayLen As Integer = (getCategory.Rows.Count+1)*(getExpense.Rows.Count+1)
		Dim sumMonthly(MontlyArrayLen) As Double
		Dim sumMonthlySale(MontlyArrayLen) As Double
		Dim sumMonthlyCost(MontlyArrayLen) As Double
		Dim sumEachDay As Double = 0
		Dim sumTotalEachDay As Double = 0
		Dim TotalEach As Double = 0
		Dim TotalEachSale As Double = 0
		Dim TotalEachCost As Double = 0
		Dim EachSale(getCategory.Rows.Count) As Double
		Dim DayWeek As Integer
		Dim TodayDate As Date
		Dim k As Integer
		Dim bgColor As String
		For j = 1 To LastDay
			sumEachDay = 0
			sumTotalEachDay = 0
			TotalEachSale = 0
			Dim ChkDate As New Date(StartYearValue, StartMonthValue, j)
			DayWeek = ChkDate.DayOfWeek
			outString = outString.Append("<tr>")
			If DayWeek = 6 Or DayWeek = 0 Then
				outString = outString.Append("<td bgColor=""#f9484d"" align=""" + "center" + """ class=""" + TextClass + """>" + j.ToString + "</td>") 
			Else
				outString = outString.Append("<td align=""" + "center" + """ class=""" + TextClass + """>" + j.ToString + "</td>") 
			End If
			For i = 0 To getCategory.Rows.Count - 1
				sumEachProfit(i) = 0
				EachSale(i) = 0
				sumEachCost(i) = 0
			Next
			'If DateTime.Compare(Today,ChkDate) >= 0 Then
			For k = 0 to getExpense.Rows.Count - 1
				TotalEach = 0
				
				TestString += "<p>"
				For i = 0 To getCategory.Rows.Count - 1
					
					If getExpense.Rows(k)("ExpenseID") = 0 Then 
						expression = "PMGroupID=" + getCategory.Rows(i)("PMGroupID").ToString + " AND DayDate = " + j.ToString + " AND MonthDate = " + StartMonthValue.ToString + " AND YearDate=" + StartYearValue.ToString
						foundRows = SaleData.Select(expression)
						If getCategory.Rows(i)("OtherProduct") = 1 Then
							expression = "DayDate = " + j.ToString + " AND MonthDate = " + StartMonthValue.ToString + " AND YearDate=" + StartYearValue.ToString
							foundRows2 = OtherMenuData.Select(expression)
						End If
					Else
						expression = "PMGroupID=" + getCategory.Rows(i)("PMGroupID").ToString + " AND DayDate = " + j.ToString + " AND MonthDate = " + StartMonthValue.ToString + " AND YearDate=" + StartYearValue.ToString + " AND ExpenseID=" + getExpense.Rows(k)("ExpenseID").ToString
						foundRows = InvenData.Select(expression)
					End If
					If foundRows.GetUpperBound(0) >= 0 Then
						If getExpense.Rows(k)("ExpenseID") = 0 Then 
							If getCategory.Rows(i)("OtherProduct") = 1 AND foundRows2.GetUpperBound(0) >= 0 Then
								TotalEach += foundRows(0)("TotalSale") + foundRows2(0)("TotalSale")
								TotalEachSale += foundRows(0)("TotalSale") + foundRows2(0)("TotalSale")
								sumEachProfit(i) += foundRows(0)("TotalSale") + foundRows2(0)("TotalSale")
								sumEachSale(i) += foundRows(0)("TotalSale") + foundRows2(0)("TotalSale")
								EachSale(i) += foundRows(0)("TotalSale") + foundRows2(0)("TotalSale")
								sumMonthly(k*(getCategory.Rows.Count+1)+i) += foundRows(0)("TotalSale") + foundRows2(0)("TotalSale")
								sumMonthlySale(k*(getCategory.Rows.Count+1)+i) += foundRows(0)("TotalSale") + foundRows2(0)("TotalSale")
							Else
								TotalEach += foundRows(0)("TotalSale")
								TotalEachSale += foundRows(0)("TotalSale")
								sumEachProfit(i) += foundRows(0)("TotalSale")
								sumEachSale(i) += foundRows(0)("TotalSale")
								EachSale(i) += foundRows(0)("TotalSale")
								sumMonthly(k*(getCategory.Rows.Count+1)+i) += foundRows(0)("TotalSale")
								sumMonthlySale(k*(getCategory.Rows.Count+1)+i) += foundRows(0)("TotalSale")
							End If
							TestString += j.ToString + "/" + i.ToString + "=" + foundRows(0)("TotalSale").ToString
							If ShowOther = True Then
								If getCategory.Rows(i)("OtherProduct") = 1 AND foundRows2.GetUpperBound(0) >= 0 Then
									outString = outString.Append("<td align=""" + "right" + """ class=""" + TextClass + """>" + Format(foundRows(0)("TotalSale") + foundRows2(0)("TotalSale"), "##,##0.00;(##,##0.00)") + "</td>")
								Else
									outString = outString.Append("<td align=""" + "right" + """ class=""" + TextClass + """>" + Format(foundRows(0)("TotalSale"), "##,##0.00;(##,##0.00)") + "</td>")
								End If
							End If
						Else
							TotalEach += foundRows(0)("TotalPrice")
							sumMonthly(k*(getCategory.Rows.Count+1)+i) += foundRows(0)("TotalPrice")
							'outString = outString.Append("<td align=""" + "right" + """ class=""" + TextClass + """>" + Format(foundRows(0)("TotalPrice"), "##,##0.00;(##,##0.00)") + "</td>")
							If ShowOther = True Then
								outString = outString.Append("<td class=""" + TextClass + """ align=""right""><a  class=""smallText"" href=""JavaScript: newWindow = window.open( '../Inventory/expense_cost_detail.aspx?ExpenseID=" + getExpense.Rows(k)("ExpenseID").ToString + "&SelDay=" + j.ToString + "&SelMonth=" & Request.Form("MonthYearDate_Month").ToString & "&SelYear=" & Request.Form("MonthYearDate_Year").ToString & "&ShopID=" & Request.Form("ShopID").ToString + "&PMGroupID=" + getCategory.Rows(i)("PMGroupID").ToString + "&StartDate=" + Replace(StartDate,"'","\'") + "&EndDate=" + Replace(EndDate,"'","\'") + "&VATType=" + VATType + "', '', 'width=900,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(foundRows(0)("TotalPrice"), "##,##0.00;(##,##0.00)") + "</a></td>")
							End If
							
							If getExpense.Rows(k)("Costing") = 1 Then
								TestString += j.ToString + "/" + i.ToString + "=" + sumEachProfit(i).ToString + "-" + foundRows(0)("TotalPrice").ToString
								sumEachProfit(i) = sumEachProfit(i) + foundRows(0)("TotalPrice")
								sumEachCost(i) += foundRows(0)("TotalPrice")
								sumMonthlyCost(k*(getCategory.Rows.Count+1)+i) += foundRows(0)("TotalPrice")
								TestString += "=" + sumEachProfit(i).ToString
							End If
						End If
					Else
						If ShowOther = True Then
							outString = outString.Append("<td align=""" + "right" + """ class=""" + TextClass + """>" + "0.00" + "</td>")
						End If
					End If
					If getExpense.Rows(k)("ExpenseID") = 0 Then
						bgColor = "#ffe4b5"
					ElseIf getExpense.Rows(k)("ExpenseID") = 1 Then
						bgColor = "#ffb6c1"
					ElseIf getExpense.Rows(k)("ExpenseID") = 2 Then
						bgColor = "#b7ffb7"
					Else
						bgColor = "#ffb6c1"
					End If
				
					If ShowOther = True Then
						outString = outString.Append("<td bgColor=""" + bgColor + """ align=""" + "right" + """ class=""" + TextClass + """>" + Format(sumMonthly(k*(getCategory.Rows.Count+1)+i), "##,##0.00;(##,##0.00)")  + "</td>")
					End If
					
				Next
				
				bgColor = "#b0e0e6"
				sumMonthly(k*(getCategory.Rows.Count+1)+i) += TotalEach
				If ShowOther = True Then
					outString = outString.Append("<td bgColor=""" + bgColor + """ align=""" + "right" + """ class=""" + TextClass + """>" + Format(TotalEach, "##,##0.00;(##,##0.00)") + "</td>")
					outString = outString.Append("<td bgColor=""" + bgColor + """ align=""" + "right" + """ class=""smallboldText"">" + Format(sumMonthly(k*(getCategory.Rows.Count+1)+i), "##,##0.00;(##,##0.00)") + "</td>")
				End If
				
			Next	
			If ShowGrossProfit = True Then
				TotalEach = 0  
				TotalEachCost = 0
				For i = 0 To getCategory.Rows.Count - 1
					TotalEach += sumEachProfit(i)
					TotalEachCost += sumEachCost(i)
					sumMonthly(k*(getCategory.Rows.Count+1)+i) += sumEachProfit(i)
					sumMonthlySale(k*(getCategory.Rows.Count+1)+i) += sumEachSale(i)
					sumMonthlyCost(k*(getCategory.Rows.Count+1)+i) += sumEachCost(i)
					outString = outString.Append("<td align=""" + "right" + """ class=""" + TextClass + """>" + Format(sumEachProfit(i), "##,##0.00;(##,##0.00)") + "</td>")
					If EachSale(i) = 0 Then
						outString = outString.Append("<td align=""" + "right" + """ class=""" + TextClass + """>" + Format(0, "##,##0.00;(##,##0.00)") + "%</td>")
					Else
						'outString = outString.Append("<td align=""" + "right" + """ class=""" + TextClass + """>" + Format(sumEachProfit(i)*100/EachSale(i), "##,##0.00;(##,##0.00)") + "%</td>")
						outString = outString.Append("<td align=""" + "right" + """ class=""" + TextClass + """>" + Format(Math.Abs(sumEachCost(i)*100/EachSale(i)), "##,##0.00;(##,##0.00)") + "%</td>")
					End If
					outString = outString.Append("<td bgColor=""#ffff99"" align=""" + "right" + """ class=""" + TextClass + """>" + Format(sumMonthly(k*(getCategory.Rows.Count+1)+i), "##,##0.00;(##,##0.00)") + "</td>")
					If sumMonthly(i) = 0 Then
						outString = outString.Append("<td bgColor=""#ffff99"" align=""" + "right" + """ class=""" + TextClass + """>" + Format(0, "##,##0.00;(##,##0.00)") + "%</td>")
					Else
						'outString = outString.Append("<td bgColor=""#ffff99"" align=""" + "right" + """ class=""" + TextClass + """>" + Format(sumMonthly(k*(getCategory.Rows.Count+1)+i)*100/sumMonthly(i), "##,##0.00;(##,##0.00)") + "%</td>")
						outString = outString.Append("<td bgColor=""#ffff99"" align=""" + "right" + """ class=""" + TextClass + """>" + Format(math.abs(sumMonthlyCost(k*(getCategory.Rows.Count+1)+i)*100/sumEachSale(i)), "##,##0.00;(##,##0.00)") + "%</td>")
					End If
				Next
				If TotalEach = 0 Then
					outString = outString.Append("<td align=""" + "right" + """ class=""" + TextClass + """>" + "0.00" + "</td>")
					outString = outString.Append("<td align=""" + "right" + """ class=""" + TextClass + """>" + "0.00%" + "</td>")
				Else
					outString = outString.Append("<td align=""" + "right" + """ class=""" + TextClass + """>" + Format(TotalEach, "##,##0.00;(##,##0.00)") + "</td>")
					outString = outString.Append("<td align=""" + "right" + """ class=""" + TextClass + """>" + Format(TotalEach*100/TotalEachSale, "##,##0.00;(##,##0.00)") + "%</td>")
					sumMonthly(k*(getCategory.Rows.Count+1)+i) += TotalEach
				End If
				outString = outString.Append("<td bgColor=""#b0e0e6"" align=""" + "right" + """ class=""smallboldText"">" + Format(sumMonthly(k*(getCategory.Rows.Count+1)+i), "##,##0.00;(##,##0.00)") + "</td>")
				outString = outString.Append("<td bgColor=""#b0e0e6"" align=""" + "right" + """ class=""smallboldText"">" + Format(sumMonthly(k*(getCategory.Rows.Count+1)+i)*100/sumMonthly(i), "##,##0.00;(##,##0.00)") + "%</td>")
			End If
			outString = outString.Append("</tr>") 
		Next
		
		outString = outString.Append("</table>")
		ResultText.InnerHtml = outString.ToString
		'errorMsg.InnerHtml = TestString

		Dim ShopDisplay As String
		If Request.Form("ShopID") = 0 Then
			ShopDisplay = "All Shops"
		Else
			ShopDisplay = SelShopName.Value
		End If
		'GenDateText.InnerHtml = "Generate Report Data: " + Format(Now(), "dd MMMM yyyy HH:mm:ss")
		If GroupByParam.SelectedItem.Value = -1 Then
			ResultSearchText.InnerHtml = "Profit Loss Report for " + ShopDisplay + "<br>" + ReportDate + ""
		Else
			ResultSearchText.InnerHtml = GroupByParam.SelectedItem.Text + " Report for " + ShopDisplay + "<br>" + ReportDate + ""
		End If
		
		'Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"
		
	End If
End Sub

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "CostByDeptData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub	

  Public Function ProfitLoss(ByRef SaleData As DataTable, ByRef InvenData As DataTable, ByRef OtherMenuData As DataTable, ByVal SelMonth As Integer, ByVal SelYear As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal ShopID As Integer, ByVal OrderByString As String, ByVal VATType As String, ByVal objCnn As MySqlConnection) As DataTable

        Dim sqlStatement As String
        Dim AdditionalQuery As String = ""
        Dim DocQuery As String = ""
        Dim ShopIDListValue As String
        Dim ResultString As String = ""
        Dim TextClass As String
        Dim GetData As DataTable
        Dim DocBuyQuery As String

        Dim i, j As Integer

        If ShopID > 0 Then
            AdditionalQuery += " AND a.ShopID IN (" + ShopID.ToString + ")"
            If SelYear >= 2009 Then
                If SelYear = 2009 And SelMonth < 11 Then
                    DocQuery += " AND a.ProductLevelID IN (" + ShopID.ToString + ") AND f.ExpenseID NOT IN (1)"
                    DocBuyQuery += " AND a.ProductLevelID IN (" + ShopID.ToString + ") AND f.ExpenseID=1"
                Else
                    DocQuery += " AND a.ProductLevelID IN (" + ShopID.ToString + ") AND f.ExpenseID NOT IN (1)"
                    DocBuyQuery += " AND a.ProductLevelID IN (1) AND f.ExpenseID=1"
                End If
            Else
                DocQuery += " AND a.ProductLevelID IN (" + ShopID.ToString + ") AND f.ExpenseID NOT IN (1)"
                DocBuyQuery += " AND a.ProductLevelID IN (" + ShopID.ToString + ") AND f.ExpenseID=1"
            End If

        End If

        If StartDate <> "" And EndDate <> "" Then
            AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
            DocQuery += " AND (a.DocumentDate >= " + StartDate + " AND a.DocumentDate < " + EndDate + ")"
            DocBuyQuery += " AND (a.DocumentDate >= " + StartDate + " AND a.DocumentDate < " + EndDate + ")"
        End If

        Dim OrderBy As String = "a.SaleDate"
        If Trim(OrderByString) <> "" Then OrderBy = OrderByString

        sqlStatement = "select DAYOFMONTH(a.SaleDate) As DayDate,MONTH(a.SaleDate) As MonthDate,YEAR(a.SaleDate) As YearDate,y.PMGroupID,y.PMGroupName,y.Ordering,SUM(c.SalePrice) As TotalSale from ordertransaction a, orderdetail b, orderdiscountdetail c, products p, productdept pd, productgroup pg, expenseproduct x, expensegroupname y where a.TransactionID=b.TransactionID and a.ComputerID=b.ComputerID and b.TransactionID=c.TransactionID and b.ComputerID=c.ComputerID and b.OrderDetailID=c.OrderDetailID and a.TransactionStatusID=2 and a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3) and b.ProductID=p.ProductID and p.ProductDeptID=pd.ProductDeptID and pd.ProductGroupID=pg.ProductGroupID and pg.ProductGroupCode=x.PMProductGroupCode and x.PMGroupID=y.PMGroupID " + AdditionalQuery + " group by y.PMGroupID,y.PMGroupName,y.Ordering,DAYOFMONTH(a.SaleDate),MONTH(a.SaleDate),YEAR(a.SaleDate)"
        SaleData = objDB.List(sqlStatement, objCnn)

        sqlStatement = "select DAYOFMONTH(a.SaleDate) As DayDate,MONTH(a.SaleDate) As MonthDate,YEAR(a.SaleDate) As YearDate,SUM(c.SalePrice) As TotalSale from ordertransaction a, orderdetail b, orderdiscountdetail c where a.TransactionID=b.TransactionID and a.ComputerID=b.ComputerID and b.TransactionID=c.TransactionID and b.ComputerID=c.ComputerID and b.OrderDetailID=c.OrderDetailID and a.TransactionStatusID=2 and a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3) and b.ProductID=0 " + AdditionalQuery + " group by DAYOFMONTH(a.SaleDate),MONTH(a.SaleDate),YEAR(a.SaleDate)"
        OtherMenuData = objDB.List(sqlStatement, objCnn)

        CostInfo.MaterialStdCost("DummyMaterialStandardCost", SelMonth, SelYear, ShopID, objCnn)


        objDB.sqlExecute("Drop Table If Exists DummyMaterialStandardCost_For_ProfitLoss ", objCnn)
        objDB.sqlExecute("create table if not exists " + "DummyMaterialStandardCost_For_ProfitLoss" + " (MaterialID int, TotalPrice decimal(18,4), TotalAmount decimal(18,4), BeginningPricePerUnit decimal(18,4), PricePerUnit decimal(18,4), RecTotalPrice decimal(18,4), RecTotalAmount decimal(18,4), PRIMARY KEY (MaterialID))", objCnn)
        sqlStatement = "select m.MaterialID,b.TotalPrice,b.TotalAmount,b.BeginningPricePerUnit,b.PricePerUnit,b.RecTotalPrice,b.RecTotalAmount from Materials m left outer join DummyMaterialStandardCost b ON m.MaterialID=b.MaterialID"
        objDB.sqlExecute("insert into " + "DummyMaterialStandardCost_For_ProfitLoss " + sqlStatement, objCnn)

        Dim DataString As String = "b.ProductNetPrice*dt.MovementInStock"
        If VATType = "V" Then
            DataString = "(b.ProductNetPrice+b.ProductTax)*dt.MovementInStock"
        End If
        'DataString = "IF(f.ExcludeVAT=1,b.ProductNetPrice*dt.MovementInStock,(b.ProductNetPrice+b.ProductTax)*dt.MovementInStock)"

        sqlStatement = "select DAYOFMONTH(a.DocumentDate) As DayDate,MONTH(a.DocumentDate) As MonthDate,YEAR(a.DocumentDate) As YearDate,f.ExpenseID,f.ExpenseName,y.PMGroupID,y.PMGroupName,SUM(IF(d.UseAvgCost = 1,IF(std.TotalAmount = 0,0,(std.TotalPrice*b.UnitSmallAmount*dt.MovementInStock)/std.TotalAmount)," + DataString + ")) As TotalPrice from document a, docdetail b, documenttype dt, documenttypegroupvalue c, documenttypegroup d, expenselink e, expense f, materials m, materialdept md, materialgroup mg, expensematerial x, expensegroupname y, DummyMaterialStandardCost_For_ProfitLoss std where a.documentid=b.documentid and a.shopid=b.shopid and a.DocumentStatus=2 and a.documenttypeid=c.documenttypeid and c.documenttypegroupid=d.documenttypegroupid and d.documenttypegroupid=e.documenttypegroupid and a.DocumentTypeID=dt.DocumentTypeID and a.ProductLevelID=dt.ShopID AND dt.LangID=1 and e.expenseid=f.expenseid and b.ProductID=m.materialid and m.MaterialDeptID=md.MaterialDeptID and md.MaterialGroupID=mg.MaterialGroupID and mg.MaterialGroupID=x.PMmaterialgroupid and x.PMGroupID=y.PMGroupID AND m.MaterialID=std.MaterialID " + DocQuery + " group by f.ExpenseID,f.ExpenseName,y.PMGroupID,y.PMGroupName,DAYOFMONTH(a.DocumentDate),MONTH(a.DocumentDate),YEAR(a.DocumentDate) UNION select DAYOFMONTH(a.DocumentDate) As DayDate,MONTH(a.DocumentDate) As MonthDate,YEAR(a.DocumentDate) As YearDate,f.ExpenseID,f.ExpenseName,y.PMGroupID,y.PMGroupName,SUM(IF(d.UseAvgCost = 1,IF(std.TotalAmount = 0,0,(std.TotalPrice*b.UnitSmallAmount*dt.MovementInStock)/std.TotalAmount)," + DataString + ")) As TotalPrice from document a, docdetail b, documenttype dt, documenttypegroupvalue c, documenttypegroup d, expenselink e, expense f, materials m, materialdept md, materialgroup mg, expensematerial x, expensegroupname y, DummyMaterialStandardCost_For_ProfitLoss std where a.documentid=b.documentid and a.shopid=b.shopid and a.DocumentStatus=2 and a.documenttypeid=c.documenttypeid and c.documenttypegroupid=d.documenttypegroupid and d.documenttypegroupid=e.documenttypegroupid and a.DocumentTypeID=dt.DocumentTypeID and a.ProductLevelID=dt.ShopID AND dt.LangID=1 and e.expenseid=f.expenseid and b.ProductID=m.materialid and m.MaterialDeptID=md.MaterialDeptID and md.MaterialGroupID=mg.MaterialGroupID and mg.MaterialGroupID=x.PMmaterialgroupid and x.PMGroupID=y.PMGroupID AND m.MaterialID=std.MaterialID " + DocBuyQuery + " group by f.ExpenseID,f.ExpenseName,y.PMGroupID,y.PMGroupName,DAYOFMONTH(a.DocumentDate),MONTH(a.DocumentDate),YEAR(a.DocumentDate)"
        InvenData = objDB.List(sqlStatement, objCnn)

        objDB.sqlExecute("Drop Table If Exists DummyMaterialStandardCost_For_ProfitLoss ", objCnn)
        objDB.sqlExecute("Drop Table If Exists DummyMaterialStandardCost ", objCnn)

    End Function

    Public Function ProfitLossDataDetail(ByVal ExpenseID As Integer, ByVal PMGroupID As Integer, ByVal SelMonth As Integer, ByVal SelYear As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal ShopID As Integer, ByVal OrderByString As String, ByVal VATType As String, ByVal objCnn As MySqlConnection) As DataTable

        Dim sqlStatement As String
        Dim AdditionalQuery As String = ""
        Dim DocQuery As String = ""
        Dim ShopIDListValue As String
        Dim ResultString As String = ""
        Dim TextClass As String
        Dim GetData As DataTable


        Dim i, j As Integer

        If ShopID > 0 Then
            DocQuery += " AND a.ProductLevelID IN (" + ShopID.ToString + ")"
        End If

        If StartDate <> "" And EndDate <> "" Then
            DocQuery += " AND (a.DocumentDate >= " + StartDate + " AND a.DocumentDate < " + EndDate + ")"
        End If

        If ExpenseID > 0 Then
            DocQuery += " AND f.ExpenseID=" + ExpenseID.ToString
        End If

        If PMGroupID > 0 Then
            DocQuery += " AND y.PMGroupID=" + PMGroupID.ToString
        End If

        Dim OrderBy As String = " Order By m.MaterialName"
        If Trim(OrderByString) <> "" Then OrderBy = OrderByString

        CostInfo.MaterialStdCost("DummyMaterialStandardCost", SelMonth, SelYear, ShopID, objCnn)


        objDB.sqlExecute("Drop Table If Exists DummyMaterialStandardCost_For_ProfitLoss ", objCnn)
        objDB.sqlExecute("create table if not exists " + "DummyMaterialStandardCost_For_ProfitLoss" + " (MaterialID int, TotalPrice decimal(18,4), TotalAmount decimal(18,4), BeginningPricePerUnit decimal(18,4), PricePerUnit decimal(18,4), RecTotalPrice decimal(18,4), RecTotalAmount decimal(18,4), PRIMARY KEY (MaterialID))", objCnn)
        sqlStatement = "select m.MaterialID,b.TotalPrice,b.TotalAmount,b.BeginningPricePerUnit,b.PricePerUnit,b.RecTotalPrice,b.RecTotalAmount from Materials m left outer join DummyMaterialStandardCost b ON m.MaterialID=b.MaterialID"
        objDB.sqlExecute("insert into " + "DummyMaterialStandardCost_For_ProfitLoss " + sqlStatement, objCnn)

        Dim DataString As String = "b.ProductNetPrice*dt.MovementInStock"
        Dim PricePerUnitString As String = "b.ProductNetPrice/b.UnitSmallAmount"
        If VATType = "V" Then
            DataString = "(b.ProductNetPrice+b.ProductTax)*dt.MovementInStock"
            PricePerUnitString = ""
        End If
        DataString = "IF(f.ExcludeVAT=1,b.ProductNetPrice*dt.MovementInStock,(b.ProductNetPrice+b.ProductTax)*dt.MovementInStock)"

        sqlStatement = "select mg.MaterialGroupID,mg.MaterialGroupCode,mg.MaterialGroupName,md.MaterialDeptID,md.MaterialDeptCode,md.MaterialDeptName,m.MaterialID,m.MaterialCode,m.MaterialName,std.TotalPrice As TotalPriceStd,std.TotalAmount As TotalAmountStd,u.UnitSmallName As UnitName,SUM(b.UnitSmallAmount*dt.MovementInStock) As UnitSmallAmount,SUM(b.ProductNetPrice*dt.MovementInStock) As ProductNetPrice,IF(d.UseAvgCost = 1,std.TotalPrice/std.TotalAmount,b.ProductNetPrice/b.UnitSmallAmount) As PricePerUnit,SUM(IF(d.UseAvgCost = 1,IF(std.TotalAmount = 0,0,(std.TotalPrice*b.UnitSmallAmount*dt.MovementInStock)/std.TotalAmount)," + DataString + ")) As TotalPrice from document a, docdetail b, documenttype dt, documenttypegroupvalue c, documenttypegroup d, expenselink e, expense f, materials m, materialdept md, materialgroup mg, expensematerial x, expensegroupname y, DummyMaterialStandardCost_For_ProfitLoss std, UnitSmall u where a.documentid=b.documentid and a.shopid=b.shopid and a.DocumentStatus=2 and a.documenttypeid=c.documenttypeid and c.documenttypegroupid=d.documenttypegroupid and d.documenttypegroupid=e.documenttypegroupid and a.DocumentTypeID=dt.DocumentTypeID AND a.ProductLevelID=dt.ShopID AND dt.LangID=1 and e.expenseid=f.expenseid and b.ProductID=m.materialid and m.MaterialDeptID=md.MaterialDeptID and md.MaterialGroupID=mg.MaterialGroupID and mg.MaterialGroupID=x.PMmaterialgroupid and x.PMGroupID=y.PMGroupID AND m.MaterialID=std.MaterialID AND m.UnitSmallID=u.UnitSmallID " + DocQuery + " group by mg.MaterialGroupID,mg.MaterialGroupCode,mg.MaterialGroupName,md.MaterialDeptID,md.MaterialDeptCode,md.MaterialDeptName,m.MaterialID,m.MaterialCode,m.MaterialName,std.TotalPrice,std.TotalAmount,u.UnitSmallName " + OrderBy
        GetData = objDB.List(sqlStatement, objCnn)

        objDB.sqlExecute("Drop Table If Exists DummyMaterialStandardCost_For_ProfitLoss ", objCnn)
        objDB.sqlExecute("Drop Table If Exists DummyMaterialStandardCost ", objCnn)
        Return GetData
    End Function

	
Sub Page_UnLoad()
	objCnn.Close()
End Sub
	
</script>
</body>
</html>
