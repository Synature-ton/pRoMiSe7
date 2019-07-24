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
<title>Promotion Discount Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

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
				<td><asp:CheckBox ID="AllShopSum" CssClass="text" runat="server"></asp:CheckBox></td>
			</tr>
			<tr>
				<td><asp:CheckBox ID="OnlyZeroNet" CssClass="text" runat="server"></asp:CheckBox></td>
			</tr>
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
	<tr>
	<span id="TableHeaderText" runat="server"></span>
	<span id="ExtraHeader" runat="server"></span>
	</tr>
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
	If User.Identity.IsAuthenticated  AND Session("Report_PromotionByProduct") Then
		
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
		
		HeaderText.InnerHtml = "Promotion Discount Report"
		
		OnlyZeroNet.Text = "Display Only Net = 0"
		AllShopSum.Text = "All Shops Sum Only"
			
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
		
		Dim HeaderString As String
		
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Code</td>"		
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Product Name</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Unit Price</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Qty</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Price</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Discount</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Net</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>%</td>"
		
		TableHeaderText.InnerHtml = HeaderString
		
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
		
		Dim TestDate As DateTime = Convert.ToDateTime("2006-04-02")
		If Not Page.IsPostBack Then
			Radio_3.Checked = True
			If IsNumeric(Request.QueryString("ShopID")) Then
				ShowSearch.Visible = False
				Dim ReportDate As String
				Dim StartDate As String = Replace(Request.QueryString("StartDate"),"{","")
				StartDate = Replace(StartDate,"}","")
				StartDate = Replace(StartDate,"'","")
				StartDate = Replace(StartDate,"d","")
				Dim StartDateValCheck As DateTime = Convert.ToDateTime(StartDate)
				Dim StartDateVal As New DateTime(Year(StartDateValCheck),Month(StartDateValCheck),Day(StartDateValCheck))
				Dim EndDate As String = Replace(Request.QueryString("EndDate"),"{","")
				EndDate = Replace(EndDate,"}","")
				EndDate = Replace(EndDate,"'","")
				EndDate = Replace(EndDate,"d","")
				Dim EndDateValCheck As DateTime = Convert.ToDateTime(EndDate)
				Dim EndDateVal As New DateTime(Year(EndDateValCheck),Month(EndDateValCheck),Day(EndDateValCheck))
				If Request.QueryString("ViewOption") = 1 Then
					ReportDate = Format(StartDateVal,"MMMM yyyy")
				ElseIf Request.QueryString("ViewOption") = 2 Then
					ReportDate = Format(StartDateVal, "dd MMMM yyyy") + " - " + Format(EndDateVal, "dd MMMM yyyy")
				ElseIf Request.QueryString("ViewOption") = 0 Then
					ReportDate = Format(StartDateVal, "dd MMMM yyyy")
				ElseIf Request.QueryString("ViewOption") = 4 Then
					ReportDate = "Year " + Format(StartDateVal, "yyyy")
				Else
					ReportDate = ""
				End If
				Dim PromotionData As New DataTable()
				Dim SummaryPromotion As New DataTable()
				Dim dtTable As DataTable
				ShowResults.Visible = True
				ShowPrint.Visible = True
				'Application.Lock()
				Dim Result As String = getReport.PromotionDiscountReport(SummaryPromotion,1,dtTable,PromotionData,Request.QueryString("StartDate"), Request.QueryString("EndDate"), Request.QueryString("ShopID"), Session("LangID"), 0, objCnn)
				GenResults(SummaryPromotion,PromotionData,Request.QueryString("ShopID"),ReportDate)	
				objDB.sqlExecute("DROP TABLE IF EXISTS DummyPromotionDiscount", objCnn)
        		objDB.sqlExecute("DROP TABLE IF EXISTS DummyPromotionDiscountSummary", objCnn)
				'Application.UnLock()
				
			End If
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
		
		Dim ShopData As DataTable = getInfo.GetProductLevel(-999,objCnn)
		If ShopData.Rows.Count > 0 Then

			outputString = "<select name=""ShopID"">"
			If ShopData.Rows.Count > 1 Then
				If Not Page.IsPostBack Then 
					FormSelected = "selected"
					SelShopName.Value = "All Shops"
				ElseIf ShopIDValue = 0 Then
					FormSelected = "selected"
					SelShopName.Value = "All Shops"
				Else
					FormSelected = ""
				End If
				outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & "--- All Shops ---"
			End If
			For i = 0 to ShopData.Rows.Count - 1
				If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
					FormSelected = "selected"
					SelShopName.Value = ShopData.Rows(i)("ProductLevelName")
				Else
					FormSelected = ""
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
	Dim outputString As String = ""
	Dim grandTotal As Double = 0
	Dim GraphData As New DataSet()
	Dim ReportDate As String
			
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
		ReportDate = Format(SDate,"MMMM yyyy")
		ViewOption = 1
		Catch ex As Exception
			FoundError = True
		End Try
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
	
	If FoundError = False Then
		
		ShowResults.Visible = True
		ShowPrint.Visible = True
		Dim PromotionID As String = 0
		Dim PromotionData As New DataTable()
		Dim SummaryPromotion As New DataTable()
		Dim dtTable As DataTable
		Dim ReportTypeVal As Integer = 1
		If OnlyZeroNet.Checked = True Then
			ReportTypeVal = 99
		End If
		'Application.Lock()
		Dim Result As String = getReport.PromotionDiscountReport(SummaryPromotion,ReportTypeVal,dtTable,PromotionData,StartDate, EndDate, Request.Form("ShopID"), Session("LangID"), PromotionID, objCnn)

		GenResults(SummaryPromotion,PromotionData,Request.Form("ShopID"),ReportDate) 
		objDB.sqlExecute("DROP TABLE IF EXISTS DummyPromotionDiscount", objCnn)
        objDB.sqlExecute("DROP TABLE IF EXISTS DummyPromotionDiscountSummary", objCnn)
		
		'Application.UnLock()

	End If
	
End Sub
	
Public Function GenResults(ByVal SummaryPromotion As DataTable, ByVal PromotionData As DataTable, ByVal ShopID As Integer, ByVal ReportDate As String) As String
		
		Dim ShopData As DataTable = getInfo.GetProductLevel(ShopID,objCnn)
		Dim ReportHeader As String = ""
		If ShopData.Rows.Count > 0 Then
			If ShopID = 0 Then
				ReportHeader += "All Shops" + "<br>"
			Else
				ReportHeader += ShopData.Rows(0)("ProductLevelName") + "<br>"
			End If
		Else
			ReportHeader += "All Shops" + "<br>"
		End If
		ResultSearchText.InnerHtml = ReportHeader + "Discount History By Item (" + ReportDate + ")"
		
		Dim DummyShopID As Integer = -1
		Dim DummyPromotionID As Integer = -1
		Dim netPrice As Double = 0
		Dim totalQty As Double = 0
		Dim totalAmount As Double = 0
		Dim totalDiscount As Double = 0
		Dim branchTotalQty As Double = 0
		Dim branchTotalPrice As Double = 0
		Dim branchTotalDiscount As Double = 0
		Dim branchTotalNet As Double = 0
		Dim grandTotalQty As Double = 0
		Dim grandTotalPrice As Double = 0
		Dim grandTotalDiscount As Double = 0
		Dim grandTotalNet As Double = 0
		Dim ColSpan As String = "8"
		Dim outputString As String = ""
		Dim i As Integer
		Dim countPromo As Integer = 0
		Dim j As Integer = 0
		For i = 0 To PromotionData.Rows.Count - 1
			grandTotalNet += PromotionData.Rows(i)("TotalPrice")-PromotionData.Rows(i)("Discount")
			grandTotalQty += PromotionData.Rows(i)("Amount")
			grandTotalPrice += PromotionData.Rows(i)("TotalPrice")
			grandTotalDiscount += PromotionData.Rows(i)("Discount")
		Next
		
		If ShopID = 0 AND AllShopSum.Checked = False Or ShopID > 0 Then
		
		For i = 0 To PromotionData.Rows.Count - 1
			If PromotionData.Rows(i)("ShopID") <> DummyShopID Then
				If j > 0 Then
					outputString += "<tr bgColor=""" + GlobalParam.GrayBGColor + """>"
					outputString += "<td colspan=""3"" align=""right"" class=""smallText"">Summary</td>"
					outputString += "<td align=""center"" class=""smallText"">" + totalQty.ToString + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format(totalAmount, "##,##0.00") + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format(totalDiscount, "##,##0.00") + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format(totalAmount-totalDiscount, "##,##0.00") + "</td>"
					If grandTotalNet > 0 Then
						outputString += "<td align=""right"" class=""smallText"">" + Format((totalAmount-totalDiscount)*100/grandTotalNet, "##,##0.00") + "%</td>"
					Else
						outputString += "<td align=""right"" class=""smallText"">-</td>"
					End If
					outputString += "</tr>"
					totalQty = 0
					totalAmount = 0
					totalDiscount = 0
				End If
				If countPromo >= 1 Then
					outputString += "<tr><td height=""10px"" colspan=""8""></td></tr>"
					outputString += "<tr bgColor=""" + GlobalParam.GrayBGColor + """>"
					outputString += "<td colspan=""3"" align=""right"" class=""smallText"">Branch Total</td>"
					outputString += "<td align=""center"" class=""smallText"">" + branchTotalQty.ToString + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format(branchTotalPrice, "##,##0.00") + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format(branchTotalDiscount, "##,##0.00") + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format(branchTotalNet, "##,##0.00") + "</td>"
					If grandTotalNet > 0 Then
						outputString += "<td align=""right"" class=""smallText"">" + Format(branchTotalNet*100/grandTotalNet, "##,##0.00") + "%</td>"
					Else
						outputString += "<td align=""right"" class=""smallText"">-</td>"
					End If
					outputString += "</tr>"
				End If
				If ShopID = 0 Then
					outputString += "<tr bgColor=""" + GlobalParam.GrayBGColor + """>"
					outputString += "<td colspan=""8"" align=""left"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + PromotionData.Rows(i)("ShopName") + "</td>"
					outputString += "</tr>"
				End If
				countPromo = 0
				j = 0
				branchTotalNet = 0
				branchTotalQty = 0
				branchTotalPrice = 0
				branchTotalDiscount = 0
				DummyPromotionID = 0
			End If
			If PromotionData.Rows(i)("PromotionID") <> DummyPromotionID Then
				If j > 0 Then
					outputString += "<tr bgColor=""" + GlobalParam.GrayBGColor + """>"
					outputString += "<td colspan=""3"" align=""right"" class=""smallText"">Summary</td>"
					outputString += "<td align=""center"" class=""smallText"">" + totalQty.ToString + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format(totalAmount, "##,##0.00") + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format(totalDiscount, "##,##0.00") + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format(totalAmount-totalDiscount, "##,##0.00") + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format((totalAmount-totalDiscount)*100/grandTotalNet, "##,##0.00") + "%</td>"
					outputString += "</tr>"
					totalQty = 0
					totalAmount = 0
					totalDiscount = 0
				End If
				outputString += "<tr>"
				If PromotionData.Rows(i)("PromotionID") > 0 Then
					outputString += "<td colspan=""" + ColSpan + """ align=""left"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Promotion: " + PromotionData.Rows(i)("PromotionName") + "</td>"
				Else
					outputString += "<td colspan=""" + ColSpan + """ align=""left"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + PromotionData.Rows(i)("PromotionName") + "</td>"
				End If
				outputString += "</tr>"
				countPromo += 1
			End If

			outputString += "<tr>"
			outputString += "<td class=""smallText"">" + PromotionData.Rows(i)("ProductCode") + "</td>"
			outputString += "<td class=""smallText"">" + PromotionData.Rows(i)("ProductName") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("TotalPrice")/PromotionData.Rows(i)("Amount"), "##,##0.00") + "</td>"
			outputString += "<td align=""center"" class=""smallText"">" + PromotionData.Rows(i)("Amount").ToString + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("TotalPrice"), "##,##0.00") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("Discount"), "##,##0.00") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("TotalPrice")-PromotionData.Rows(i)("Discount"), "##,##0.00") + "</td>"
			If grandTotalNet > 0 Then
				outputString += "<td align=""right"" class=""smallText"">" + Format((PromotionData.Rows(i)("TotalPrice")-PromotionData.Rows(i)("Discount"))*100/grandTotalNet, "##,##0.00") + "</td>"
			Else
				outputString += "<td align=""right"" class=""smallText"">-</td>"
			End If
			outputString += "</tr>"
			totalQty += PromotionData.Rows(i)("Amount")
			totalAmount += PromotionData.Rows(i)("TotalPrice")
			totalDiscount += PromotionData.Rows(i)("Discount")
			branchTotalNet += PromotionData.Rows(i)("TotalPrice")-PromotionData.Rows(i)("Discount")
			branchTotalQty += PromotionData.Rows(i)("Amount")
			branchTotalPrice += PromotionData.Rows(i)("TotalPrice")
			branchTotalDiscount += PromotionData.Rows(i)("Discount")

			DummyPromotionID = PromotionData.Rows(i)("PromotionID")
			DummyShopID = PromotionData.Rows(i)("ShopID")
			j += 1
		Next
		
		If i > 0 Then
			outputString += "<tr bgColor=""" + GlobalParam.GrayBGColor + """>"
			outputString += "<td colspan=""3"" align=""right"" class=""smallText"">Summary</td>"
			outputString += "<td align=""center"" class=""smallText"">" + totalQty.ToString + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(totalAmount, "##,##0.00") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(totalDiscount, "##,##0.00") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(totalAmount-totalDiscount, "##,##0.00") + "</td>"
			If grandTotalNet > 0 Then
				outputString += "<td align=""right"" class=""smallText"">" + Format((totalAmount-totalDiscount)*100/grandTotalNet, "##,##0.00") + "%</td>"
			Else
				outputString += "<td align=""right"" class=""smallText"">-</td>"
			End If
			outputString += "</tr>"
		End If
		If countPromo >= 1 Then
			outputString += "<tr><td height=""10px"" colspan=""8""></td></tr>"
			outputString += "<tr bgColor=""" + GlobalParam.GrayBGColor + """>"
			outputString += "<td colspan=""3"" align=""right"" class=""smallText"">Branch Total</td>"
			outputString += "<td align=""center"" class=""smallText"">" + branchTotalQty.ToString + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(branchTotalPrice, "##,##0.00") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(branchTotalDiscount, "##,##0.00") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(branchTotalNet, "##,##0.00") + "</td>"
			If grandTotalNet > 0 Then
				outputString += "<td align=""right"" class=""smallText"">" + Format(branchTotalNet*100/grandTotalNet, "##,##0.00") + "%</td>"
			Else
				outputString += "<td align=""right"" class=""smallText"">-</td>"
			End If
			outputString += "</tr>"
		End If
		
		If Request.Form("ShopID") = 0 AND PromotionData.Rows.Count > 0 Then
			outputString += "<tr><td height=""15px"" colspan=""8""></td></tr>"
			outputString += "<tr bgColor=""" + GlobalParam.GrayBGColor + """>"
			outputString += "<td colspan=""3"" align=""right"" class=""smallText"">Grand Total</td>"
			outputString += "<td align=""center"" class=""smallText"">" + grandTotalQty.ToString + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(grandTotalPrice, "##,##0.00") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(grandTotalDiscount, "##,##0.00") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(grandTotalNet, "##,##0.00") + "</td>"
			If grandTotalNet > 0 Then
				outputString += "<td align=""right"" class=""smallText"">100%</td>"
			Else
				outputString += "<td align=""right"" class=""smallText"">-</td>"
			End If
			outputString += "</tr>"
		End If
		
		End If
		If ShopID = 0 Then
			Dim Result2 As String = GenResults2(SummaryPromotion,Request.Form("ShopID"),ReportDate) 
			ResultText.InnerHtml = outputString + "<tr><td height=""40px"" colspan=""8"">Summary for All Shops</td></tr>" + Result2
		Else
			ResultText.InnerHtml = outputString
		End If
End Function

Public Function GenResults2(ByVal PromotionData As DataTable, ByVal ShopID As Integer, ByVal ReportDate As String) As String
		
		Dim DummyPromotionID As Integer = -1
		Dim netPrice As Double = 0
		Dim totalQty As Double = 0
		Dim totalAmount As Double = 0
		Dim totalDiscount As Double = 0
		Dim grandTotalQty As Double = 0
		Dim grandTotalPrice As Double = 0
		Dim grandTotalDiscount As Double = 0
		Dim grandTotalNet As Double = 0
		Dim ColSpan As String = "8"
		Dim outputString As String = ""
		Dim i As Integer
		Dim countPromo As Integer = 0
		For i = 0 To PromotionData.Rows.Count - 1
			grandTotalNet += PromotionData.Rows(i)("TotalPrice")-PromotionData.Rows(i)("Discount")
			grandTotalQty += PromotionData.Rows(i)("Amount")
			grandTotalPrice += PromotionData.Rows(i)("TotalPrice")
			grandTotalDiscount += PromotionData.Rows(i)("Discount")
		Next
		For i = 0 To PromotionData.Rows.Count - 1
			If PromotionData.Rows(i)("PromotionID") <> DummyPromotionID Then
				If i > 0 Then
					outputString += "<tr bgColor=""" + GlobalParam.GrayBGColor + """>"
					outputString += "<td colspan=""3"" align=""right"" class=""smallText"">Summary</td>"
					outputString += "<td align=""center"" class=""smallText"">" + totalQty.ToString + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format(totalAmount, "##,##0.00") + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format(totalDiscount, "##,##0.00") + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format(totalAmount-totalDiscount, "##,##0.00") + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format((totalAmount-totalDiscount)*100/grandTotalNet, "##,##0.00") + "%</td>"
					outputString += "</tr>"
					totalQty = 0
					totalAmount = 0
					totalDiscount = 0
				End If
				outputString += "<tr>"
				If PromotionData.Rows(i)("PromotionID") > 0 Then
					outputString += "<td colspan=""" + ColSpan + """ align=""left"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Promotion: " + PromotionData.Rows(i)("PromotionName") + "</td>"
				Else
					outputString += "<td colspan=""" + ColSpan + """ align=""left"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + PromotionData.Rows(i)("PromotionName") + "</td>"
				End If
				outputString += "</tr>"
				countPromo += 1
			End If
			outputString += "<tr>"
			outputString += "<td class=""smallText"">" + PromotionData.Rows(i)("ProductCode") + "</td>"
			outputString += "<td class=""smallText"">" + PromotionData.Rows(i)("ProductName") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("TotalPrice")/PromotionData.Rows(i)("Amount"), "##,##0.00") + "</td>"
			outputString += "<td align=""center"" class=""smallText"">" + PromotionData.Rows(i)("Amount").ToString + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("TotalPrice"), "##,##0.00") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("Discount"), "##,##0.00") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("TotalPrice")-PromotionData.Rows(i)("Discount"), "##,##0.00") + "</td>"
			If grandTotalNet > 0 Then
				outputString += "<td align=""right"" class=""smallText"">" + Format((PromotionData.Rows(i)("TotalPrice")-PromotionData.Rows(i)("Discount"))*100/grandTotalNet, "##,##0.00") + "</td>"
			Else
				outputString += "<td align=""right"" class=""smallText"">-</td>"
			End If
			outputString += "</tr>"
			totalQty += PromotionData.Rows(i)("Amount")
			totalAmount += PromotionData.Rows(i)("TotalPrice")
			totalDiscount += PromotionData.Rows(i)("Discount")
			DummyPromotionID = PromotionData.Rows(i)("PromotionID")
		Next
		If i > 0 Then
			outputString += "<tr bgColor=""" + GlobalParam.GrayBGColor + """>"
			outputString += "<td colspan=""3"" align=""right"" class=""smallText"">Summary</td>"
			outputString += "<td align=""center"" class=""smallText"">" + totalQty.ToString + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(totalAmount, "##,##0.00") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(totalDiscount, "##,##0.00") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(totalAmount-totalDiscount, "##,##0.00") + "</td>"
			If grandTotalNet > 0 Then
				outputString += "<td align=""right"" class=""smallText"">" + Format((totalAmount-totalDiscount)*100/grandTotalNet, "##,##0.00") + "%</td>"
			Else
				outputString += "<td align=""right"" class=""smallText"">-</td>"
			End If
			outputString += "</tr>"
		End If
		If countPromo > 1 Then
			outputString += "<tr><td height=""10px"" colspan=""8""></td></tr>"
			outputString += "<tr bgColor=""" + GlobalParam.GrayBGColor + """>"
			outputString += "<td colspan=""3"" align=""right"" class=""smallText"">Grand Total</td>"
			outputString += "<td align=""center"" class=""smallText"">" + grandTotalQty.ToString + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(grandTotalPrice, "##,##0.00") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(grandTotalDiscount, "##,##0.00") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(grandTotalNet, "##,##0.00") + "</td>"
			If grandTotalNet > 0 Then
				outputString += "<td align=""right"" class=""smallText"">100%</td>"
			Else
				outputString += "<td align=""right"" class=""smallText"">-</td>"
			End If
			outputString += "</tr>"
		End If
		Return outputString
End Function

Sub Page_UnLoad()
	objCnn.Close()
End Sub
</script>
</body>
</html>
