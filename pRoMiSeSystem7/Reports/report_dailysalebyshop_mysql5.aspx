<%@ Page Language="VB" ContentType="text/html" EnableViewState="False"  debug="True" %>
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
<html>
<head>
<title>Daily Sales By Shop Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>

<div id="ShowContent" visible="false" runat="server">
<form runat="server">
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><b class="headerText"><div class="headerText" align="left" id="HeaderText" runat="server" /></b></div>
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
<table border="0">
<span id="showShop" runat="server">
<tr>
	<td><span id="SelectMonth" class="text" runat="server"></span></td>
	<td><synature:date id="MonthYearDate" runat="server" /></td>
	<td><span id="OrderText" runat="server"></span></td>
	<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
</tr>

</span>
</table>
</div>
<br>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr>

</table>
<span id="myTable" visible="false" runat="server">
<table width="100%">
<tr><td align="center">
<div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>


<span id="startTable" runat="server"></span>
	<span id="headerTextString" runat="server"></span>
	
	<div id="ResultText" runat="server"></div>
</table></td></tr>
</table> 
</span>
<table>
<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table>
<span id="ResultString" runat="server"></span>
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
Dim getInfo As New CCategory()
Dim objDB As New CDBUtil()
Dim DateTimeUtil As New MyDateTime()
Dim getReport As New GenReports()
Dim getProp As New CPreferences()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer = 8

Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("DailySaleByShop") Then
		
		Try	
			SubmitForm.Attributes.Item("onclick") = "this.disabled=true;" & GetPostBackEventReference(SubmitForm).ToString
			objCnn = getCnn.EstablishConnection()
			ShowContent.Visible = True		
			errorMsg.InnerHtml = ""
			
			StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
			
			'Dim GetReportLog As DataTable = getReport.ReportLog(objCnn)
			'If GetReportLog.Rows.Count > 0 Then
			'	DBText.InnerHtml = "Report Database: " + Format(GetReportLog.Rows(0)("LogDateTime"), "dd MMMM yyyy HH:mm:ss") + "&nbsp;&nbsp;"
			'Else
			'	DBText.InnerHtml = "Report Database&nbsp;&nbsp;"
			'End If
			DBText.InnerHtml = "&nbsp;"
			
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
			'LangList.Text = LangListText
			
			Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
			
			If LangDefault.Rows.Count >= 4 Then
				PrintText.Text = LangDefault.Rows(0)(LangText)
				Export.Text = LangDefault.Rows(1)(LangText)
				SubmitForm.Text = LangDefault.Rows(3)(LangText)
			End If
			HeaderText.InnerHtml = "Daily Sales By Shop Report"
			
			MonthYearDate.YearType = GlobalParam.YearType
			MonthYearDate.FormName = "MonthYearDate"
			MonthYearDate.StartYear = GlobalParam.StartYear
			MonthYearDate.EndYear = GlobalParam.EndYear
			MonthYearDate.LangID = Session("LangID")
			MonthYearDate.ShowDay = False
			MonthYearDate.Lang_Data = LangDefault
			MonthYearDate.Culture = CultureString
			
			If Not Page.IsPostBack Or Request.Form("OrderParam") = "a.MaterialCode" Then
				OrderText.InnerHtml = "<select name=""OrderParam"">"
				OrderText.InnerHtml += "<option value=""a.MaterialCode"" selected>Order By Material Code"
				OrderText.InnerHtml += "<option value=""a.MaterialName"">Order By Material Name"
				OrderText.InnerHtml += "</select>"
			Else
				OrderText.InnerHtml = "<select name=""OrderParam"">"
				OrderText.InnerHtml += "<option value=""a.MaterialCode"">Order By Material Code"
				OrderText.InnerHtml += "<option value=""a.MaterialName"" selected>Order By Material Name"
				OrderText.InnerHtml += "</select>"
			End If
			
			OrderText.InnerHtml = ""
			
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
			
			
		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
	  
	Else
		errorMsg.InnerHtml = "Access Denied"
	End If
End Sub

Sub DoSearch(Source As Object, E As EventArgs)
	
	Dim FormatData As DataTable = Util.FormatParam(FormatObject,Session("LangID"),objCnn)
	Dim ci As New CultureInfo(FormatObject.CultureString)
	
	Dim FoundError As Boolean
	FoundError = False
	myTable.Visible = False
	'Try
	
	Dim SelMonth As Integer = 0
	Dim SelYear As Integer = 0
	If IsNumeric(Request.Form("MonthYearDate_Month")) Then SelMonth = Request.Form("MonthYearDate_Month")
	If IsNumeric(Request.Form("MonthYearDate_Year")) Then SelYear = Request.Form("MonthYearDate_Year")
	
	If SelMonth = 0 Or SelYear = 0 Then
		FoundError = True
	End If
	
	If FoundError = False Then
		ShowPrint.Visible = True
		myTable.Visible = True
		Dim TestTime,Result As String
		Dim dtTable,groupData As DataTable
		Dim displayTable As New DataTable()
		Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
		Dim TableNameString As String = ""

		Dim ReportDate As String
		Dim SDate As New Date(Request.Form("MonthYearDate_Year"),Request.Form("MonthYearDate_Month"),1)
		'ReportDate = Format(SDate,"MMMM yyyy")
		ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy",Session("LangID"),objCnn)
		ResultSearchText.InnerHtml = "Daily Sales By Shop Report " + " (" + ReportDate + ")"
		Dim i As Integer
		
		Dim ExtraInfo As String
		Dim totalSale As Double = 0
		Dim totalCost As Double = 0
		Dim deptCost As Double = 0
		Dim groupCost As Double = 0
		Dim DummyPGroupID,DummyPDeptID,DummyMGroupID,DummyMDeptID As Integer
		Dim ProductGroupName,ProductDeptName,MaterialGroupName,MaterialDeptName As String
		
		
		Dim StartDate,EndDate As String
		Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
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
		
		Dim LastDate As New Date(EndYearValue,EndMonthValue,1)
		Dim LastDay As Integer = Day(DateAdd("d",-1,LastDate))
		Dim DayWeek As Integer
		'Application.Lock()
		Result = DailySaleByShopReport(dtTable,1,StartDate, EndDate,Request.Form("OrderParam"),objCnn)
		'Application.UnLock()
		
		Dim totalStandardCost As Double = 0
		Dim SubTotalSale As Double = 0
		Dim GrandTotalSale As Double = 0
		Dim SaleText As String
		
		Dim HeaderString As String = "<tr>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "" + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Date" + "</td>"
		For i = 0 To ShopData.Rows.Count - 1
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + ShopData.Rows(i)("ProductLevelName") + "</td>"
		Next

		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Total" + "</td>"
		HeaderString += "</tr>"
		headerTextString.InnerHtml = HeaderString
		
		Dim groupString,PriceString,QtyString,StdString As String
		Dim resultString As StringBuilder = New StringBuilder
		Dim showData As Boolean
		Dim j As Integer
		Dim UnitPrice As String
		Dim UnitInfo As DataTable
		Dim PricePerUnit As Double
		
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
		
		Dim UnitText As String
		Dim UnitRatioVal As Double = 1
		Dim outputString As StringBuilder = New StringBuilder
		Dim DayName() As String = {"Su","Mo","Tu","We","Th","Fr","Sa"}
		Dim ShopTotal(ShopData.Rows.Count) As Double
		Dim foundRows() As DataRow
        Dim expression As String
		Dim LineColor As String = "white"
		For i = 1 to LastDay
			Dim ChkDate As New Date(StartYearValue, StartMonthValue, i)
			DayWeek = ChkDate.DayOfWeek
			SubTotalSale = 0
			LineColor = "white"
			If DayWeek = 0 Or DayWeek = 6 Then
				LineColor = "#ffdead"
			End If
			outputString = outputString.Append("<tr bgColor=""" + LineColor + """>")
			outputString = outputString.Append("<td class=""smallText"" align=""center"">" + DayName(DayWeek) + "</td>")
			outputString = outputString.Append("<td class=""smallText"" align=""center"">" + i.ToString + "/" + SelMonth.ToString + "/" + SelYear.ToString + "</td>")
			For j = 0 to ShopData.Rows.Count - 1
				expression = "SaleDay=" + i.ToString + " AND SaleMonth=" + SelMonth.ToString + " AND SaleYear=" + SelYear.ToString + " AND ShopID=" + ShopData.Rows(j)("ProductLevelID").ToString
				foundRows = dtTable.Select(expression)
				If foundRows.GetUpperBound(0) >= 0 Then
					SubTotalSale += foundRows(0)("TotalSale")
					SaleText = CDbl(foundRows(0)("TotalSale")).ToString(FormatObject.CurrencyFormat, ci)
					GrandTotalSale += foundRows(0)("TotalSale")
					ShopTotal(j) += foundRows(0)("TotalSale")
				Else
					SaleText = "-"
				End If
				outputString = outputString.Append("<td class=""smallText"" align=""right"">" + SaleText + "</td>")
			Next
			outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>" + CDbl(SubTotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
			
			outputString = outputString.Append("</tr>")
		Next
		Dim ColSpan As Integer = 2
		outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
		outputString = outputString.Append("<td class=""smallText"" align=""right"" colspan=""" + ColSpan.ToString + """>Total</td>")
		For j = 0 to ShopData.Rows.Count - 1
			outputString = outputString.Append("<td class=""smallText"" align=""right"">" + CDbl(ShopTotal(j)).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
		Next
		outputString = outputString.Append("<td class=""smallText"" align=""right"">" + CDbl(GrandTotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
		outputString = outputString.Append("</tr>")
		
		ResultText.InnerHtml = outputString.ToString
		
		Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & headerTextString.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"
	End If
	'Catch ex As Exception
			'FoundError = True
		'End Try
End Sub

Public Function DailySaleByShopReport(ByRef dtTable As DataTable, ByVal ReportType As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal OrderBy As String, ByVal objCnn As MySqlConnection) As String

        Dim sqlStatement As String
        Dim AdditionalQuery As String = ""
        Dim ResultString As String = ""
        Dim GetData As DataTable

        If StartDate <> "" And EndDate <> "" Then
            AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
        End If

        AdditionalQuery += " AND a.DocType=8"
        If ReportType = 1 Then
            sqlStatement = "select a.ShopID,pl.ProductLevelName As ShopName,DayOfMonth(a.SaleDate) As SaleDay,MONTH(a.SaleDate) As SaleMonth,YEAR(a.SaleDate) As SaleYear,DayOfWeek(a.SaleDate) As DayOfWeekVal,SUM(a.ReceiptSalePrice) As TotalSale from OrderTransaction a, ProductLevel pl where a.ShopID=pl.ProductLevelID AND a.TransactionStatusID=2 AND a.ReceiptID>0 " + AdditionalQuery + " group by a.ShopID,pl.ProductLevelName,a.SaleDate"
        Else
            sqlStatement = "select a.ShopID,pl.ProductLevelName As ShopName,DayOfMonth(a.SaleDate) As SaleDay,MONTH(a.SaleDate) As SaleMonth,YEAR(a.SaleDate) As SaleYear,DayOfWeek(a.SaleDate) As DayOfWeekVal,SUM(a.ReceiptPayPrice) As TotalSale from OrderTransaction a, ProductLevel pl where a.ShopID=pl.ProductLevelID AND a.TransactionStatusID=2 AND a.ReceiptID>0 " + AdditionalQuery + " group by a.ShopID,pl.ProductLevelName,a.SaleDate"
        End If
        dtTable = objDB.List(sqlStatement, objCnn)

    End Function

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "Consol_DailySale_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
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
