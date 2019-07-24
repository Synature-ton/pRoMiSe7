<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@ Register tagPrefix="Web" Namespace="WebChart" Assembly="WebChart" %>
<%@ Import Namespace="System.Drawing" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="MySQL5DBClass.POSControl" %>
<%@Import Namespace="MySQL5DBClass.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="ReportModuleMySQL5" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Member Statistics Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body<% = GlobalParam.BodyProp %>>
<div id="showPage" visible="true" runat="server">
<form runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />

<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">

<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><b class="headerText"><div class="headerText" align="left" id="HeaderText" runat="server"></div></b></div>
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
<div id="ShowSearch" runat="server">
<div class="noprint">
<table>
<tr id="ShowShop" runat="server">
	<td valign="top">
		<table>
			<tr>
				<td><span id="ShopText" runat="server"></span></td>
			</tr>
            <tr>
            	<td><asp:DropDownList ID="ColList" Width="200" runat="server"></asp:DropDownList></td>
			<tr>
				<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
			</tr>

		</table></td>
	<td>
	<table>
		<tr>
			<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
			<td colspan="4"><table cellpadding="0" cellspacing="0"><tr><td><synature:date id="DailyDate" runat="server" /></td></tr></table></td>
		</tr>
		<tr>
			<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
			<td colspan="3"><synature:date id="MonthYearDate" runat="server" /></td>
		</tr>
		<tr>
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
</div>
<span id="showResults" runat="server">
<table width="100%">
<div class="noprint">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
</div>
<tr>
	<td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td>
</tr>
<tr><td>
<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">

	<span id="TableHeaderText" runat="server"></span>
	<span id="ExtraHeader" runat="server"></span>

	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>
</table></td></tr>
</table>
</span>
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
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getReport As New stReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("MemberStatistics") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		showResults.Visible = False
		
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(13,Session("LangID"),objCnn)
		Dim textTable1 As New DataTable()
		textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)

		SubmitForm.Text = textTable.Rows(8)("TextParamValue")
		
		Dim GetReportLog As DataTable = getReport.ReportLog(objCnn)
		If GetReportLog.Rows.Count > 0 Then
			DBText.InnerHtml = "Report Database: " + Format(GetReportLog.Rows(0)("LogDateTime"), "dd MMMM yyyy HH:mm:ss") + "&nbsp;&nbsp;"
		Else
			DBText.InnerHtml = "Report Database&nbsp;&nbsp;"
		End If
		
		HeaderText.InnerHtml = "Member Statistics Report"
			
		DailyDate.YearType = GlobalParam.YearType
		DailyDate.FormName = "DocDaily"
		DailyDate.StartYear = GlobalParam.StartYear
		DailyDate.EndYear = GlobalParam.EndYear
		DailyDate.LangID = Session("LangID")
		
		CurrentDate.YearType = GlobalParam.YearType
		CurrentDate.FormName = "Doc"
		CurrentDate.StartYear = GlobalParam.StartYear
		CurrentDate.EndYear = GlobalParam.EndYear
		CurrentDate.LangID = Session("LangID")
		
		ToDate.YearType = GlobalParam.YearType
		ToDate.FormName = "DocTo"
		ToDate.StartYear = GlobalParam.StartYear
		ToDate.EndYear = GlobalParam.EndYear
		ToDate.LangID = Session("LangID")
		
		MonthYearDate.YearType = GlobalParam.YearType
		MonthYearDate.FormName = "MonthYearDate"
		MonthYearDate.StartYear = GlobalParam.StartYear
		MonthYearDate.EndYear = GlobalParam.EndYear
		MonthYearDate.LangID = Session("LangID")
		MonthYearDate.ShowDay = False

		errorMsg.InnerHtml = ""
		ShowSearch.Visible = True
		
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
		
		Dim TestDate As DateTime = Convert.ToDateTime("2006-04-02")
		
		If Not Page.IsPostBack Then
			Radio_3.Checked = True
			OptionDataBound(objCnn)
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
		
		Dim ShopData As DataTable = getInfo.GetAllShopData(objCnn)'getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
		If ShopData.Rows.Count > 0 Then

			outputString = "<select name=""ShopID"" style=""width:200px"">"
			For i = 0 to ShopData.Rows.Count - 1
				If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
					FormSelected = "selected"
					SelShopName.Value = ShopData.Rows(i)("ProductLevelName")
				Else
					If Not Page.IsPostBack And i=0 Then
						FormSelected = "selected"
					Else
						FormSelected = ""
					End If
				End If
				outputString += "<option value=""" & ShopData.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & ShopData.Rows(i)("ProductLevelName")
			Next
			outputString += "</select>"
			ShopText.InnerHtml = outputString
			ShowShop.Visible = True
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

Public Function OptionDataBound(ByVal objCnn As MySqlConnection) As Boolean
	Dim DynamicUDD As New DataTable()
	DynamicUDD = UDDSelectionOption(Session("StaffID"),objCnn)
	ColList.DataSource = DynamicUDD
	ColList.DataValueField = "UDDID"
	ColList.DataTextField = "UDDName"
	ColList.DataBind()
	
End Function

Public Function UDDSelectionOption(ByVal StaffID As Integer, ByVal objCnn As MySqlConnection) As DataTable
            Return objDB.List("SELECT -10 As UDDID,'Statistics By Shop' AS UDDName,-10 As Ordering UNION SELECT -9 AS UDDID,'Statistics By Age' As UDDName,-9 As Ordering UNION SELECT UDDID,CONCAT('Statistics By ',UDDName) As UDDName,0 As Ordering FROM UserDefineData WHERE Deleted=0 AND UDDPropID IN (1,3) AND UDDTypeID IN (3,4) ORDER BY Ordering,UDDName", objCnn)
        End Function
		
		Public Function UDDData(ByVal UDDID As Integer, ByVal objCnn As MySqlConnection) As DataTable
            Return objDB.List("SELECT * FROM UserDefineData WHERE UDDID=" + UDDID.ToString + " ORDER BY UDDName", objCnn)
        End Function

Sub DoSearch(Source As Object, E As EventArgs)
	
	Dim FoundError As Boolean
	FoundError = False
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(12,Session("LangID"),objCnn)
	Dim textTable1 As New DataTable()
	textTable1 = getPageText.GetText(13,Session("LangID"),objCnn)
	Dim textTable2 As New DataTable()
	textTable2 = getPageText.GetText(9,Session("LangID"),objCnn)
			
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
	Dim ViewOption As Integer
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""
	Dim DailyDateValue As String = ""
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
	Dim outputString As StringBuilder = New StringBuilder
	Dim grandTotal As Double = 0
	Dim GraphData As New DataSet()
	Dim ReportDate As String
			
	If Radio_1.Checked = True Then
		If IsNumeric(Request.Form("MonthYearDate_Month")) AND IsNumeric(Request.Form("MonthYearDate_Year")) Then
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
			ReportDate = Format(SDate,"MMMM yyyy")
			ViewOption = 1
		Else
			FoundError = True
		End If 
	ElseIf Radio_2.Checked = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(Request.Form("Doc_Day"),Request.Form("Doc_Month"),Request.Form("Doc_Year"))
		Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))
		
		If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + defaultTextTable.Rows(45)("TextParamValue") + "</td></tr></table>"
			FoundError = True
			DateFromValue = ""
			DateToValue = ""
			DailyDateValue = ""
		Else
			ResultSearchText.InnerHtml = ""
			Dim SDate1 As New Date(Request.Form("Doc_Year"), Request.Form("Doc_Month"), Request.Form("Doc_Day"))
			Dim EDate1 As New Date(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"))
			ReportDate = Format(SDate1, "dd MMMM yyyy") + " - " + Format(EDate1, "dd MMMM yyyy")
		End If
		ViewOption = 2
		Catch ex As Exception
			FoundError = True
		End Try
	Else If Radio_3.Checked = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(Request.Form("DocDaily_Day"),Request.Form("DocDaily_Month"),Request.Form("DocDaily_Year"))
		Dim CheckDate As New DateTime(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"), 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))

		If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + defaultTextTable.Rows(45)("TextParamValue") + "</td></tr></table>"
			FoundError = True
			DateFromValue = ""
			DateToValue = ""
			DailyDateValue = ""
		Else
			ResultSearchText.InnerHtml = ""
			Dim SDate2 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
			ReportDate = Format(SDate2, "d MMMM yyyy")
		End If
		ViewOption = 3
		Catch ex As Exception
			FoundError = True
		End Try
	Else
		DateFromValue = ""
		DateToValue = ""
		DailyDateValue = ""
		ViewOption = 0
	End If
	
	Dim TopValue As Integer
	
	If FoundError = False Then
		
		ShowResults.Visible = True
		ShowPrint.Visible = True
		Dim dtTable As New DataTable()
		Dim FavoriteBranch As DataTable
		'Application.Lock()
		Dim Result As String = getReport.MemberStatistics(dtTable,ColList.SelectedItem.Value,Request.Form("ShopID"),StartDate, EndDate, objCnn)
		'Application.UnLock()
		
		Dim ShopID As Integer = Request.Form("ShopID")
		Dim ShopData As DataTable = getInfo.GetProductLevel(ShopID,objCnn)
		Dim ReportHeader As String = ""
		If ShopID = 0 Then
			ReportHeader += "All Shops" + "<br>"
		ElseIf ShopData.Rows.Count > 0 Then
			ReportHeader += ShopData.Rows(0)("ProductLevelName") + "<br>"
		End If
		
		Dim HString As String = ""
		Dim UDD As DataTable
		If ColList.SelectedItem.Value > 0 Then
			UDD = UDDData(ColList.SelectedItem.Value,objCnn)
			If UDD.Rows.Count > 0 Then
				HString = UDD.Rows(0)("UDDName")
			End If
		Else
			If ColList.SelectedItem.Value = -10 Then
				HString = "Shop"
			ElseIf ColList.SelectedItem.Value = -9 Then
				HString = "Range-Age"
			End If
		End If
		ResultSearchText.InnerHtml = ReportHeader + "Member " + ColList.SelectedItem.Text + " (" + ReportDate + ")"
		Dim i As Integer
		
		Dim ShopString As String = ""
		For i = 0 to ShopData.Rows.Count - 1
			If ShopData.Rows(i)("ProductLevelID") > 0 Then
				ShopString += "," + ShopData.Rows(i)("ProductLevelID").ToString
			End If
		Next
		ShopString = "0" + ShopString
		Dim AttachString As String = "&StartDate=" + Server.UrlEncode(Replace(StartDate,"'","\'")) + "&EndDate=" + Server.UrlEncode(Replace(EndDate,"'","\'")) + "&ShopList=" + Server.UrlEncode(ShopString) + "&ReportDate=" + ReportDate
		
		Dim HeaderString As String
		HeaderString += "<tr>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + HString + "</td>"		
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Member#</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Bill#</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Amount</td>"
		HeaderString += "</tr>"
		
		TableHeaderText.InnerHtml = HeaderString

		Dim foundRows() As DataRow
    	Dim expression As String
		Dim grandTotalBill As Double = 0
		Dim grandTotalAmount As Double = 0
		For i = 0 To dtTable.Rows.Count - 1
			outputString = outputString.Append("<tr>")
			If ColList.SelectedItem.Value = -9 AND dtTable.Rows(i)("DisplayName") = "N/A" Then
				outputString = outputString.Append("<td class=""smallText"" align=""left"">" + "<a href=""JavaScript: newWindow = window.open( 'report_no_age_mysql5.aspx?MemberID=0" + AttachString + "', '', 'width=800,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + dtTable.Rows(i)("DisplayName") + "</a></td>")
			Else
				outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("DisplayName") + "</td>")
			End If
			outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(dtTable.Rows(i)("TotalMember"),"##,##0;(##,##0)") + "</td>")
			outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(dtTable.Rows(i)("TotalBill"),"##,##0;(##,##0)")  + "</td>")
			outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(dtTable.Rows(i)("TotalPaid"),"##,##0.00;(##,##0.00)") + "</td>")
			grandTotalBill += dtTable.Rows(i)("TotalBill")
			grandTotalAmount += dtTable.Rows(i)("TotalPaid")
		Next
		Dim ColSpan As Integer = 2
		outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
		outputString = outputString.Append("<td class=""smallText"" align=""right"" colspan=""" + ColSpan.ToString + """>Total</td>")
		outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(grandTotalBill,"##,##0;(##,##0)") + "</td>")
		outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(grandTotalAmount,"##,##0.00;(##,##0.00)") + "</td>")
		outputString = outputString.Append("</tr>")
		ResultText.InnerHtml = outputString.ToString

	End If
	
End Sub
	
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
