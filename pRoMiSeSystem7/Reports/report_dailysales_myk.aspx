<%@ Page Language="VB" ContentType="text/html" EnableViewState="False" debug="True" %>
<%@ Register tagPrefix="Web" Namespace="WebChart" Assembly="WebChart" %>
<%@ Import Namespace="System.Drawing" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySql.POSControl" %>
<%@Import Namespace="POSMySql.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="CostingClass.pRoMiSeCosting" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Daily Sales Report (Vendor)</title>
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
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Daily Sales Report (Vendor)" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
	</td>
	<td width="1" nowrap rowspan="99" bgcolor="003366"><img src="../images/clear.gif" height="1" width="1"></td>
</tr>
<tr bgcolor="666666">
	<td width="3%" height="1"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	<td width="94%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="252"></p></td>
	<td width="3%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	
</tr>
<tr><td colspan="3" class="smalltext" align="right"><span id="DBText" class="smalltext" runat="server" /></td></tr>
<tr>
<td>&nbsp;</td>
<td>
<div class="noprint">
<table>
<tr id="ShowShop" runat="server">
	<td valign="top">
		<table>
			<tr>
				<td><span id="ShopText" runat="server"></span></td><td>&nbsp;</td><td><span id="PeriodText" runat="server"></span></td></td><td>&nbsp;</td>
                <td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
			</tr>
			<tr visible="false" runat="server">
				<td><asp:radiobutton ID="Radio_11" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
			<tr visible="false" runat="server">
				<td><asp:radiobutton ID="Radio_12" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
			<tr visible="false" runat="server">
				<td><asp:radiobutton ID="Radio_13" GroupName="Group2" CssClass="text" runat="server" />
				<asp:dropdownlist ID="GroupByParam" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
			</tr>

		</table></td>
	<td>
	<table>
		<tr id="daycriteria" visible="false" runat="server">
		<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="DailyDate" runat="server" /></td>
		<td colspan="2"><asp:CheckBox ID="ExpandReceipt" Visible="false" CssClass="text" Checked="false" runat="server" /></td>
		</tr>
		<tr id="monthcriteria" visible="false" runat="server">
		<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
		<td colspan="3"><synature:date id="MonthYearDate" runat="server" /></td>
		</tr>
		<tr id="yearcriteria" visible="false" runat="server">
		<td><asp:radiobutton ID="Radio_4" GroupName="Group1" runat="server" /></td>
		<td colspan="3"><synature:date id="YearDate" runat="server" /></td>
		</tr>
		<tr id="rangecriteria" visible="false" runat="server">
		<td><asp:radiobutton ID="Radio_2" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="CurrentDate" runat="server" /></td>
		<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
		<td><synature:date id="ToDate" runat="server" /></td>
	</tr>
	<tr><td>&nbsp;</td>
		<td colspan="4">&nbsp;<asp:CheckBox ID="DisplayGraph" CssClass="text" Checked="false" Visible="false" runat="server" /></td>
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

<tr><td align="left"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="left"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>
<span id="startTable" runat="server"></span>

	<span id="TableHeaderText" runat="server"></span>
	<span id="ExtraHeader" runat="server"></span>
	
	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>

<asp:Panel ID="showGraph" Visible="false" runat="server">
<br>
<Web:ChartControl id="ChartControl1" runat="Server" />
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
Dim CostInfo As New CostClass()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer  = 998

Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("DailySales_MyK") Then
		
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
		
		Dim i As Integer
		ResultText.InnerHtml = ""
		ResultSearchText.InnerHtml = ""
		errorMsg.InnerHtml = ""
		ExtraHeader.InnerHtml = ""
		
		Radio_12.Checked = True
		
		DBText.InnerHtml = "&nbsp;"
		
		StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"">"

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
		
		Radio_11.Text = "Reported By Bill"
		Radio_12.Text = "Reported By Products"
		
		If IsNumeric(Request.Form("DocDaily_Day")) Then 
			Session("DocDailyDay") = Request.Form("DocDaily_Day")
		Else If IsNumeric(Request.QueryString("DocDaily_Day")) Then 
			Session("DocDailyDay") = Request.QueryString("DocDaily_Day")
		Else If Trim(Session("DocDailyDay")) = "" Then
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
		End If
		If Page.IsPostBack AND Request.Form("DocDaily_Month") = "" Then Session("DocDaily_Month") = 0
		DailyDate.SelectedMonth = Session("DocDaily_Month")
		
		If IsNumeric(Request.Form("DocDaily_Year")) Then 
			Session("DocDaily_Year") = Request.Form("DocDaily_Year")
		Else If IsNumeric(Request.QueryString("DocDaily_Year")) Then 
			Session("DocDaily_Year") = Request.QueryString("DocDaily_Year")
		Else If Trim(Session("DocDaily_Year")) = "" Then
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
		End If
		If Page.IsPostBack AND Request.Form("Doc_Day") = "" Then Session("DocDay") = 0
		CurrentDate.SelectedDay = Session("DocDay")
		
		
		If IsNumeric(Request.Form("Doc_Month")) Then 
			Session("Doc_Month") = Request.Form("Doc_Month")
		Else If IsNumeric(Request.QueryString("Doc_Month")) Then 
			Session("Doc_Month") = Request.QueryString("Doc_Month")
		Else If Trim(Session("Doc_Month")) = "" Then
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
		End If
		If Page.IsPostBack AND Request.Form("Doc_Year") = "" Then Session("Doc_Year") = 0
		CurrentDate.SelectedYear = Session("Doc_Year")
		
		If IsNumeric(Request.Form("DocTo_Day")) Then 
			Session("DocTo_Day") = Request.Form("DocTo_Day")
		Else If IsNumeric(Request.QueryString("DocTo_Day")) Then 
			Session("DocTo_Day") = Request.QueryString("DocTo_Day")
		Else If Trim(Session("DocTo_Day")) = "" Then
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
		End If
		If Page.IsPostBack AND Request.Form("DocTo_Month") = "" Then Session("DocTo_Month") = 0
		ToDate.SelectedMonth = Session("DocTo_Month")
		
		If IsNumeric(Request.Form("DocTo_Year")) Then 
			Session("DocTo_Year") = Request.Form("DocTo_Year")
		Else If IsNumeric(Request.QueryString("DocTo_Year")) Then 
			Session("DocTo_Year") = Request.QueryString("DocTo_Year")
		Else If Trim(Session("DocTo_Year")) = "" Then
			Session("DocTo_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("DocTo_Year") = "" Then Session("DocTo_Year") = 0
		ToDate.SelectedYear = Session("DocTo_Year")
		
		If IsNumeric(Request.Form("MonthYearDate_Day")) Then 
			Session("MonthYearDate_Day") = Request.Form("MonthYearDate_Day")
		Else If IsNumeric(Request.QueryString("MonthYearDate_Day")) Then 
			Session("MonthYearDate_Day") = Request.QueryString("MonthYearDate_Day")
		Else If Trim(Session("DocDay")) = "" Then
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
		End If
		If Page.IsPostBack AND Request.Form("MonthYearDate_Month") = "" Then Session("MonthYearDate_Month") = 0
		MonthYearDate.SelectedMonth = Session("MonthYearDate_Month")
		
		If IsNumeric(Request.Form("MonthYearDate_Year")) Then 
			Session("MonthYearDate_Year") = Request.Form("MonthYearDate_Year")
		Else If IsNumeric(Request.QueryString("MonthYearDate_Year")) Then 
			Session("MonthYearDate_Year") = Request.QueryString("MonthYearDate_Year")
		Else If Trim(Session("MonthYearDate_Year")) = "" Then
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
			Radio_12.Checked = True
		End If

		Dim ShopIDValue As String = "0"
		If IsNumeric(Request.Form("ShopID")) Then
			ShopIDValue = Request.Form("ShopID").ToString
		Else If IsNumeric(Request.QueryString("ShopID"))
			ShopIDValue = Request.QueryString("ShopID").ToString
		End If
		
		Dim PIDValue As String = "0"
		If IsNumeric(Request.Form("PeriodID")) Then
			PIDValue = Request.Form("PeriodID").ToString
		Else If IsNumeric(Request.QueryString("PeriodID"))
			PIDValue = Request.QueryString("PeriodID").ToString
		End If

		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		Dim Multiple As Boolean = False
		Dim ShopList As String = ""
		
		Dim ShopData As DataTable = objDB.List("select a.ProductGroupID As ProductLevelID,b.ProductGroupName As ProductLevelName from GP_ProductGroupSetting a inner join ProductGroup b ON a.ProductGroupID=b.ProductGroupID where a.StaffIDList LIKE '%," & Session("StaffID") & ",%' AND b.Deleted=0 order by b.ProductGroupOrdering", objCnn)
		If ShopData.Rows.Count > 0 Then

			outputString = "<select name=""ShopID"">"

			For i = 0 to ShopData.Rows.Count - 1
				If ShopData.Rows(i)("ProductLevelID") <> 0 Then
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
				End If
			Next
			outputString += "</select>"
			ShopText.InnerHtml = outputString
			ShowShop.Visible = True
			ShopList = "0" + ShopList
			ShopIDList.Value = ShopList
		Else
			ShowShop.Visible = False
		End If
		
		Dim Period as DataTable = objDB.List("select * from MyK_Period where Activate=1 AND Deleted=0 order by StartDate", objCnn)
		outputString = "<select name=""PeriodID"">"

		For i = 0 to Period.Rows.Count - 1
			If Period.Rows(i)("PeriodID") <> 0 Then
				If PIDValue = Period.Rows(i)("PeriodID") Then
					FormSelected = "selected"
				Else
					If Not Page.IsPostBack And i=0 And Multiple = False Then
						FormSelected = "selected"
					Else
						FormSelected = ""
					End If
				End If
				outputString += "<option value=""" & Period.Rows(i)("PeriodID") & """ " & FormSelected & ">" & Period.Rows(i)("PeriodName")
			End If
		Next
		outputString += "</select>"
		PeriodText.InnerHtml = outputString
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
	Dim FormatData As DataTable = Util.FormatParam(FormatObject,Session("LangID"),objCnn)
	Dim ci As New CultureInfo(FormatObject.CultureString)
	
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""
	Dim DailyDateValue As String = ""
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	Dim AdditionalHeader As String = ""
	Dim PayTypeList As DataTable
	Dim i,j As Integer
	
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
	Dim grandTotal As Double = 0
	Dim VATTotal As Double = 0
	Dim GraphData As New DataSet()
	Dim ReportDate As String
	Dim YearValue4 As Integer
	Dim R1,R2,R3,R4,R11,R12,R13 As Boolean
	Dim SelMonth,SelYear As Integer
	
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
		
		Dim TestString As String
		
		Dim AdditionalQuery As String = ""
		Dim sqlStatement As String = ""
		Dim dtTable As DataTable
		Dim PaymentData As DataTable
		Dim VoidData As DataTable

		Dim ProductGroupID As Integer = Request.Form("ShopID")
		Dim PeriodID As Integer = Request.Form("PeriodID")
		
		Dim Period As DataTable = objDB.List("select *,DATE_FORMAT(StartDate,'%Y-%m-%d') As StartDateString,DATE_FORMAT(EndDate,'%Y-%m-%d') As EndDateString from MyK_Period where PeriodID=" & PeriodID, objCnn)
		
		If Period.Rows.Count > 0 Then
			StartDate = Period.Rows(0)("StartDateString")
			EndDate = Period.Rows(0)("EndDateString")
			AdditionalQuery += " AND a.SaleDate between '" & StartDate & "' AND '" & EndDate & "'"
		End If
		If ProductGroupID > 0 Then
			AdditionalQuery += " AND pg.ProductGroupID=" & ProductGroupID 
		End If
		
		sqlStatement = "SELECT DATE_FORMAT(a.SaleDate,'%d-%m-%y') As DateString, a.SaleDate,pg.ProductGroupID,SUM(a.Amount) AS TotalQty,SUM(a.TotalRetailPrice) AS TotalRetailPrice,SUM(SalePrice) AS SalePrice FROM summary_productreport a LEFT OUTER JOIN Products p ON a.ProductID=p.ProductID LEFT OUTER JOIN ProductDept pd ON p.ProductDeptID=pd.ProductDeptID LEFT OUTER JOIN ProductGroup pg ON pd.ProductGroupID=pg.ProductGroupID WHERE 0=0 " & AdditionalQuery & " GROUP BY a.SaleDate,pg.ProductGroupID order by SaleDate"
		'errorMsg.InnerHtml = sqlStatement
		
		dtTable = objDB.List(sqlStatement, objCnn)
		Dim HeaderString As String = ""
		
		HeaderString += "<tr>"
		HeaderString += "<td align=""center"" class=""TdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>วันที่</td>"		
		HeaderString += "<td align=""center"" class=""TdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>ปริมาณการขาย</td>"
		HeaderString += "<td align=""center"" class=""TdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>ราคาต่อหน่วย</td>"
		HeaderString += "<td align=""center"" class=""TdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>ยอดขายรวม</td>"
		HeaderString += "<td align=""center"" class=""TdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>ส่วนลดโปรโมชั่น</td>"
		HeaderString += "<td align=""center"" class=""TdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>ยอดขายสุทธิ</td>"
		HeaderString += "<td align=""center"" class=""TdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Daily Sales</td>"
		HeaderString += "</tr>"
		
		TableHeaderText.InnerHtml = HeaderString
		
		Dim outputString As StringBuilder = New StringBuilder
		Dim TextClass As String = "Text"
		Dim foundRows() As DataRow
        Dim expression As String
		Dim CurrentDay As Integer = DateTime.Now.Day
		
		Dim TotalRetailPrice As Double = 0
		Dim TotalVAT As Double = 0
		Dim TotalDiscount As Double = 0
		Dim TotalDiff As Double = 0
		Dim TotalSale As Double = 0
		Dim TotalBill As Double = 0
		Dim TotalCustomer As Double = 0
		Dim TotalPay As Double = 0
		Dim TotalQty As Double = 0
		Dim TotalBillDisc As Double = 0
		Dim TotalBillRounding As Double = 0
		
		
		For i = 0 To dtTable.Rows.Count - 1
			outputString = outputString.Append("<tr>")
            outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & dtTable.Rows(i)("DateString").ToString & "</td>")
			If Not IsDBNull(dtTable.Rows(i)("TotalQty")) Then
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TotalQty")).ToString(FormatObject.QtyFormat, ci) + "</td>")
			Else
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + "" + "</td>")
			End If
			If Not IsDBNull(dtTable.Rows(i)("TotalQty")) And  Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) Then
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TotalRetailPrice")/dtTable.Rows(i)("TotalQty")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
			Else
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + "" + "</td>")
			End If
			
			If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) Then
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TotalRetailPrice")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
			Else
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + "" + "</td>")
			End If
			
			outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TotalRetailPrice")-dtTable.Rows(i)("SalePrice")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
			
			outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("SalePrice")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
			
			outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + "" + "</td>")
			
			outputString = outputString.Append("</tr>")
			
			If Not IsDBNull(dtTable.Rows(i)("TotalQty")) Then
				TotalQty += dtTable.Rows(i)("TotalQty")
			End If
			
			If Not IsDBNull(dtTable.Rows(i)("SalePrice")) Then
				TotalSale += dtTable.Rows(i)("SalePrice")
			End If

			If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) Then
				TotalRetailPrice += dtTable.Rows(i)("TotalRetailPrice")
			End If

			If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) Then
				TotalDiscount += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("SalePrice")
			End If
			
		Next
		
		outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
		outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & "Total" & "</td>")
		outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(TotalQty).ToString(FormatObject.QtyFormat, ci) & "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(TotalRetailPrice/TotalQty).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
		outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
		outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
		outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
		outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & "" & "</td>")
		outputString = outputString.Append("</tr>")
			
		outputString = outputString.Append("</table>")
		ResultText.InnerHtml = outputString.ToString
		
		
		
		Dim ShopDisplay As String

		ShopDisplay = SelShopName.Value

		ResultSearchText.InnerHtml = "Daily Sales Report (Vendor)"

		
		Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "" & ResultText.InnerHtml & "</td></tr></table>"
		
		showGraph.Visible = False
		
		'errorMsg.InnerHtml = TestString
	End If

End Sub

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "DailySales_Vendor_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
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
