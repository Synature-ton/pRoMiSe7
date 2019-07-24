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
<title>Member Statistics By Month Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body<% = GlobalParam.BodyProp %>>
<div id="showPage" visible="true" runat="server">
<form runat="server">

<input type="hidden" id="SelShopName" runat="server" />
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
<table>
<tr id="ShowShop" runat="server">
	<td valign="top">
		<table>
			<tr>
				<td><span id="ShopText" runat="server"></span></td>
				<td class="text">From:</td>
				<td class="text"><synature:date id="MonthYearDate" runat="server" /></td>
				<td class="text">To:</td>
				<td class="text"><synature:date id="MonthYearDate2" runat="server" /></td>

				<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
				
				<td><asp:CheckBox ID="DisplayOption" CssClass="text" Visible="false" runat="server"></asp:CheckBox></td>
			</tr>

		</table></td>
</tr>
<div id="NoData"  runat="server">
<tr>
	<td class="boldText">No option member option data to be displayed. Please go to member section and create the option member data before using this report.</td>
</tr>
</div>

</table>
</div>
<br>
<div id="showResults" runat="server">
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
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
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getData As New CMembers()
Dim getReport As New stReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim GCounter As Integer = 0
		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("MemberStatByMonth") Then
		
	Try	
		Dim InvC As CultureInfo = CultureInfo.InvariantCulture
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		Dim YearType As Integer = PropertyInfo.Rows(0)("YearSetting")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		showResults.Visible = False
		
		Dim GetReportLog As DataTable = getReport.ReportLog(objCnn)
		If GetReportLog.Rows.Count > 0 Then
			DBText.InnerHtml = "Report Database: " + Format(GetReportLog.Rows(0)("LogDateTime"), "dd MMMM yyyy HH:mm:ss") + "&nbsp;&nbsp;"
		Else
			DBText.InnerHtml = "Report Database&nbsp;&nbsp;"
		End If
		
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(13,Session("LangID"),objCnn)
		Dim textTable1 As New DataTable()
		textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)

		SubmitForm.Text = textTable.Rows(8)("TextParamValue")
		DisplayOption.Text = "Caluculate based on unique member"
		
		HeaderText.InnerHtml = "Member Statistics"
		Dim ShopIDValue As String = "0"
		If IsNumeric(Request.Form("ShopID")) Then
			ShopIDValue = Request.Form("ShopID").ToString
		Else If IsNumeric(Request.QueryString("ShopID"))
			ShopIDValue = Request.QueryString("ShopID").ToString
		End If
			
		Dim i As Integer
		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		
		Dim ShopData As DataTable = getInfo.GetAllShopData(objCnn)
		If ShopData.Rows.Count > 0 Then

			outputString = "<select name=""ShopID"">"
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
		NoData.Visible = False
		
		MonthYearDate.YearType = GlobalParam.YearType
		MonthYearDate.FormName = "MonthYearDate"
		MonthYearDate.StartYear = GlobalParam.StartYear
		MonthYearDate.EndYear = GlobalParam.EndYear
		MonthYearDate.LangID = Session("LangID")
		MonthYearDate.ShowDay = False
		
		MonthYearDate2.YearType = GlobalParam.YearType
		MonthYearDate2.FormName = "MonthYearDate2"
		MonthYearDate2.StartYear = GlobalParam.StartYear
		MonthYearDate2.EndYear = GlobalParam.EndYear
		MonthYearDate2.LangID = Session("LangID")
		MonthYearDate2.ShowDay = False
		
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
		
		
		If IsNumeric(Request.Form("MonthYearDate2_Day")) Then 
			Session("MonthYearDate2_Day") = Request.Form("MonthYearDate2_Day")
		Else If IsNumeric(Request.QueryString("MonthYearDate2_Day")) Then 
			Session("MonthYearDate2_Day") = Request.QueryString("MonthYearDate2_Day")
		Else If Trim(Session("MonthYearDate2_Day")) = "" Then
			Session("MonthYearDate2_Day") = DateTime.Now.Day
		Else If Trim(Session("MonthYearDate2_Day")) = 0 And Not Page.IsPostBack Then
			Session("MonthYearDate2_Day") = DateTime.Now.Day
		End If
		If Page.IsPostBack AND Request.Form("MonthYearDate2_Day") = "" Then Session("MonthYearDate2_Day") = 0
		MonthYearDate2.SelectedDay = Session("MonthYearDate2_Day")
		
		
		If IsNumeric(Request.Form("MonthYearDate2_Month")) Then 
			Session("MonthYearDate2_Month") = Request.Form("MonthYearDate2_Month")
		Else If IsNumeric(Request.QueryString("MonthYearDate2_Month")) Then 
			Session("MonthYearDate2_Month") = Request.QueryString("MonthYearDate2_Month")
		Else If Trim(Session("MonthYearDate2_Month")) = "" Then
			Session("MonthYearDate2_Month") = DateTime.Now.Month
		Else If Trim(Session("MonthYearDate2_Month")) = 0 And Not Page.IsPostBack Then
			Session("MonthYearDate2_Month") = DateTime.Now.Month
		End If
		If Page.IsPostBack AND Request.Form("MonthYearDate2_Month") = "" Then Session("MonthYearDate2_Month") = 0
		MonthYearDate2.SelectedMonth = Session("MonthYearDate2_Month")
		
		If IsNumeric(Request.Form("MonthYearDate2_Year")) Then 
			Session("MonthYearDate2_Year") = Request.Form("MonthYearDate2_Year")
		Else If IsNumeric(Request.QueryString("MonthYearDate2_Year")) Then 
			Session("MonthYearDate2_Year") = Request.QueryString("MonthYearDate2_Year")
		Else If Trim(Session("MonthYearDate2_Year")) = "" Then
			Session("MonthYearDate2_Year") = DateTime.Now.Year
		Else If Trim(Session("MonthYearDate2_Year")) = 0 And Not Page.IsPostBack Then
			Session("MonthYearDate2_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("MonthYearDate2_Year") = "" Then Session("MonthYearDate2_Year") = 0
		MonthYearDate2.SelectedYear = Session("MonthYearDate2_Year")
						
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
			
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
	ShowPrint.Visible = True
	Dim ShopID As Integer = Request.Form("ShopID")
	Dim ShopData As DataTable = getInfo.GetProductLevel(ShopID,objCnn)
	Dim ReportHeader As String = ""
	If ShopID = 0 Then
		ReportHeader += "All Shops" + "<br>"
	ElseIf ShopData.Rows.Count > 0 Then
		ReportHeader += ShopData.Rows(0)("ProductLevelName") + "<br>"
	End If
		
	ResultSearchText.InnerHtml = ReportHeader + "Member Statistics By Month"
	
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	Dim StartDate As String =  DateTimeUtil.FormatDate(1,Request.Form("MonthYearDate_Month"),Request.Form("MonthYearDate_Year"))
	Dim EndDate As String
	Dim EndMonthValue,EndYearValue As Integer
	If Request.Form("MonthYearDate2_Month") = 12 Then
		EndMonthValue = 1
		EndYearValue = Request.Form("MonthYearDate2_Year") + 1
	Else
		EndMonthValue = Request.Form("MonthYearDate2_Month") + 1
		EndYearValue = Request.Form("MonthYearDate2_Year")
	End If
	EndDate = DateTimeUtil.FormatDate(1,EndMonthValue,EndYearValue)
	
	Dim MemberData,BillData As DataTable
	
	Dim Result As String = getReport.MemberStatByMonth(MemberData,BillData,Request.Form("ShopID"),StartDate,EndDate,objCnn)
	
	Dim HeaderString As String
	HeaderString += "<tr>"
	HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Month</td>"		
	HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Year</td>"
	HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """># Member</td>"
	HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """># Bill</td>"
	HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Amount</td>"
	HeaderString += "</tr>"
	
	TableHeaderText.InnerHtml = HeaderString
	showResults.Visible = True

	Dim i,j As Integer 
	Dim StartYear As Integer = Request.Form("MonthYearDate_Year")
	Dim EndYear As Integer = Request.Form("MonthYearDate2_Year")
	Dim StartMonth,EndMonth As Integer
	Dim foundRows() As DataRow
    Dim expression As String
	Dim SubTotalSale As Double = 0
	Dim GrandTotalSale As Double = 0
	Dim SaleText As String
	Dim SubTotalMember,SubTotalBill,SubTotalAmount As Double
	Dim outputString As StringBuilder = New StringBuilder
	Dim AmountText As String
	For i = Request.Form("MonthYearDate_Year") to Request.Form("MonthYearDate2_Year")
		If i = StartYear AND i = EndYear Then
			StartMonth = Request.Form("MonthYearDate_Month")
			EndMonth = Request.Form("MonthYearDate2_Month")
		ElseIf i > StartYear AND i < EndYear Then
			StartMonth = 1
			EndMonth = 12
		ElseIf i > StartYear AND i = EndYear Then
			StartMonth = 1
			EndMonth = Request.Form("MonthYearDate2_Month")
		ElseIf i = StartYear AND i < EndYear
			StartMonth = Request.Form("MonthYearDate_Month")
			EndMonth = 12
		Else
			StartMonth = 0
			EndMonth = 0
		End If
		
		For j = StartMonth To EndMonth
			outputString = outputString.Append("<tr>")
			outputString = outputString.Append("<td class=""smallText"" align=""center"">" + j.ToString + "</td>")
			outputString = outputString.Append("<td class=""smallText"" align=""center"">" + i.ToString + "</td>")
			expression = "SaleMonth=" + j.ToString + " AND SaleYear=" + i.ToString
			foundRows = MemberData.Select(expression)
			If foundRows.GetUpperBound(0) >= 0 Then
				SubTotalMember += foundRows(0)("TotalMember")
				SaleText = Format(foundRows(0)("TotalMember"),"##,##0;(##,##0)")
			Else
				SaleText = "-"
			End If
			outputString = outputString.Append("<td class=""smallText"" align=""right"">" + SaleText + "</td>")

			foundRows = BillData.Select(expression)
			If foundRows.GetUpperBound(0) >= 0 Then
				SubTotalBill += foundRows(0)("TotalBill")
				SaleText = Format(foundRows(0)("TotalBill"),"##,##0;(##,##0)")
				SubTotalAmount += foundRows(0)("TotalPaid")
				AmountText = Format(foundRows(0)("TotalPaid"),"##,##0.00;(##,##0.00)")
			Else
				SaleText = "-"
				AmountText = "-"
			End If
			outputString = outputString.Append("<td class=""smallText"" align=""right"">" + SaleText + "</td>")
			outputString = outputString.Append("<td class=""smallText"" align=""right"">" + AmountText + "</td>")
			outputString = outputString.Append("</tr>")
		Next
		
	Next
	Dim ColSpan As Integer = 2
	outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
	outputString = outputString.Append("<td class=""smallText"" align=""right"" colspan=""" + ColSpan.ToString + """>Total</td>")
	outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(SubTotalMember,"##,##0;(##,##0)") + "</td>")
	outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(SubTotalBill,"##,##0;(##,##0)") + "</td>")
	outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(SubTotalAmount,"##,##0.00;(##,##0.00)") + "</td>")
	outputString = outputString.Append("</tr>")
	ResultText.InnerHtml = outputString.ToString
	
End Sub
	
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
