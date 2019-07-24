<%@ Page Language="VB" ContentType="text/html" debug="True"%>
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
<title>Order Staff Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="../StyleSheet/webscript.js"></script>
</head>
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Sale Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
            	<td><asp:dropdownlist ID="GroupByParam" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
                            <asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
            </tr>
            <tr>
            	<td class="smalltext"><asp:TextBox ID="CodeString" Width="160" runat="server" /><br>Use "," for more than one code</td>
            </tr>

		</table></td>
	<td valign="top">
	<table>
		<tr>
			<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
			<td colspan="3"><synature:date id="DailyDate" runat="server" /></td></td>
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
        <tr>
        	<td></td>
            <td colspan="3"><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
        </tr>
	
	</table>
	</td>
</tr>


</table>
</div>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr>
</table><span id="showResult" visible="false" runat="server">
<span id="MyTable">
<table width="100%">
<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr><tr><td height="10"></td></tr>
<tr><td>
<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
	<span id="TableHeaderText" runat="server"></span>
	<span id="ExtraHeader" runat="server"></span>
	</tr>
	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>
</table></td></tr>
</table></span>
<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table></span>
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

Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("OrderStaffReport") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(13,Session("LangID"),objCnn)
		Dim textTable1 As New DataTable()
		textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)

		SubmitForm.Text = textTable.Rows(8)("TextParamValue")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
		HeaderText.InnerHtml = "Order Staff Report"
		showResult.Visible = False
		
		GroupByParam.Items(0).Text = "-- No Filter --"
		GroupByParam.Items(0).Value = "0"
		GroupByParam.Items(1).Text = "Filter By Group Code"
		GroupByParam.Items(1).Value = "1"
		GroupByParam.Items(2).Text = "Filter By Product Code"
		GroupByParam.Items(2).Value = "2"
			
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
		
		ResultText.InnerHtml = ""
		ResultSearchText.InnerHtml = ""
		errorMsg.InnerHtml = ""
		
		Dim HeaderString As String = ""
		
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>#</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Group Code</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Group Name</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Product Code</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Product Name</td>"		
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Qty</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Total Sale</td>"
		TableHeaderText.InnerHtml = HeaderString
		
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

		Dim ShopIDValue As String = "0"
		If IsNumeric(Request.Form("ShopID")) Then
			ShopIDValue = Request.Form("ShopID").ToString
		Else If IsNumeric(Request.QueryString("ShopID"))
			ShopIDValue = Request.QueryString("ShopID").ToString
		End If
		
		If Not Page.IsPostBack Then
			Radio_3.Checked = True
		End If
		
		Dim i As Integer
		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		
		Dim ShopData As DataTable = getInfo.GetProductLevel(-999,objCnn)
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
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(12,Session("LangID"),objCnn)
			
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
		ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy",Session("LangID"),objCnn)
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
		ShowPrint.Visible = True
		Dim displayTable As New DataTable()
		Dim dtTable As New DataTable()

		dtTable = OrderStaffReport(Session("LangID"),Request.Form("GroupByParam"),Trim(CodeString.Text),StartDate, EndDate, Request.Form("ShopID"), objCnn)
		ResultSearchText.InnerHtml = "Order Staff Report of " + SelShopName.Value + " (" + ReportDate + ")"

		Dim ReportHeader As String 
		Dim DummyDate As String
		Dim i,j,k As Integer
		Dim DummyCloseStaffID As Integer = -1
		Dim DummyOpenStaffID As Integer = -1
		Dim DummyStaffID As Integer = -1
		Dim ExtraHeaderString As String = ""
		Dim PayTypeString As String = ""
		Dim TestString As String
		Dim IDList() As String
		Dim counter As Integer = 0
		Dim SumRow,SumRowCash,SumRowDiff As Double
		Dim subTotalQty,subTotalSale,grandTotalQty,grandTotalSale As Double
		
		ExtraHeader.InnerHtml = ""
		Dim NeedSummary As Boolean
		Dim CloseBy As String
		Dim BgColor As String = GlobalParam.GrayBgColor
		For i = 0 To dtTable.Rows.Count - 1
			If Not (dtTable.Rows(i)("StaffID") = DummyStaffID) Then
				outputString += "<tr>"
				outputString += "<td class=""smallText"" colspan=""7"">" + dtTable.Rows(i)("OrderStaffName") + "</td>"
				outputString += "</tr>"
				counter = 1
				subTotalQty = 0
				subTotalSale = 0
			End If
			outputString += "<tr>"
			outputString += "<td align=""center"" class=""smallText"">" + counter.ToString + "</td>"
			outputString += "<td class=""smallText"">" + dtTable.Rows(i)("ProductGroupCode") + "</td>"
			outputString += "<td class=""smallText"">" + dtTable.Rows(i)("ProductGroupName") + "</td>"
			outputString += "<td class=""smallText"">" + dtTable.Rows(i)("ProductCode") + "</td>"
			outputString += "<td class=""smallText"">" + dtTable.Rows(i)("ProductName") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(dtTable.Rows(i)("TotalQty"), "##,##0.00") + "</td>"
			outputString += "<td align=""right"" class=""smallText"">" + Format(dtTable.Rows(i)("TotalSale"), "##,##0.00") + "</td>"
			outputString += "</tr>"
			subTotalQty += dtTable.Rows(i)("TotalQty")
			subTotalSale += dtTable.Rows(i)("TotalSale")
			grandTotalQty += dtTable.Rows(i)("TotalQty")
			grandTotalSale += dtTable.Rows(i)("TotalSale")
			counter += 1
			If i = dtTable.Rows.Count - 1 Then

					outputString += "<tr bgColor=""" + BgColor + """>"
					outputString += "<td colspan=""5"" align=""right"" class=""smallText"">Sub Total for " + dtTable.Rows(i)("OrderStaffName") + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format(subTotalQty, "##,##0.00") + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format(subTotalSale, "##,##0.00") + "</td>"
					outputString += "</tr>"

			ElseIf dtTable.Rows(i)("StaffID") <> dtTable.Rows(i+1)("StaffID")
					outputString += "<tr bgColor=""" + BgColor + """>"
					outputString += "<td colspan=""5"" align=""right"" class=""smallText"">Sub Total for " + dtTable.Rows(i)("OrderStaffName") + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format(subTotalQty, "##,##0.00") + "</td>"
					outputString += "<td align=""right"" class=""smallText"">" + Format(subTotalSale, "##,##0.00") + "</td>"
					outputString += "</tr>"
			End If

			DummyStaffID = dtTable.Rows(i)("StaffID")

		Next
		
		outputString += "<tr><td colspan=""" + "7" + """ height=""10""></td></tr>"
		outputString += "<tr>"
		outputString += "<td colspan=""5"" align=""right"" class=""smallText"">Grand Total</td>"
		outputString += "<td align=""right"" class=""smallText"">" + Format(grandTotalQty, "##,##0.00") + "</td>"
		outputString += "<td align=""right"" class=""smallText"">" + Format(grandTotalSale, "##,##0.00") + "</td>"
		outputString += "</tr>"
		ResultText.InnerHtml = outputString
		showResult.Visible = True
	End If
End Sub

Public Function OrderStaffReport(ByVal LangID As Integer, ByVal FilteringParam As Integer, ByVal CodeString As String, ByVal StartDate As String, ByVal EndDate As String, ByVal ShopID As Integer, ByVal objCnn As MySqlConnection) As DataTable

            Dim sqlStatement As String
            Dim AdditionalQuery As String = ""
            Dim TextClass As String = "text"
            Dim i As Integer

            If StartDate <> "" And EndDate <> "" Then
                AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
            End If
            If ShopID > 0 Then
                AdditionalQuery += " AND a.ShopID=" + ShopID.ToString
            End If

            Dim CodeList As String
            If FilteringParam > 0 Then
                If Trim(CodeString) <> "" Then
                    CodeList = "'" + Replace(CodeString, ",", "','") + "'"
                    If FilteringParam = 1 Then
                        AdditionalQuery += " AND pg.ProductGroupCode IN (" + CodeList + ")"
                    Else
                        AdditionalQuery += " AND p.ProductCode IN (" + CodeList + ")"
                    End If
                End If
            End If

            Dim PName As String = ProductNameForReport(LangID, objCnn)

            sqlStatement = "select pg.ProductGroupOrdering,pg.ProductGroupCode,pg.ProductGroupName,p.ProductID,p.ProductCode," + PName + " As ProductName,s.StaffID,s.StaffCode,CONCAT(s.StaffFirstName, ' ',s.StaffLastName) AS OrderStaffName,sum(b.Amount) as TotalQty,sum(c.SalePrice) As TotalSale from ordertransaction a, orderdetail b, orderdiscountdetail c, staffs s, products p, productdept pd, productgroup pg where a.transactionid=b.transactionid and a.computerid=b.computerid and b.transactionid=c.transactionid and b.computerid=c.computerid and b.orderdetailid=c.orderdetailid and b.ProductID=p.ProductID and p.ProductDeptID=pd.ProductDeptID AND pd.ProductGroupID=pg.ProductGroupID and b.OrderStaffID=s.StaffID and a.TransactionStatusID=2 AND a.ReceiptID>0 " + AdditionalQuery + " group by s.StaffFirstName,s.StaffLastName,s.StaffID,s.StaffCode,p.ProductID,p.ProductCode," + PName + ",pg.ProductGroupCode,pg.ProductGroupName,pg.ProductGroupOrdering order by s.StaffID,pg.ProductGroupOrdering,pg.ProductGroupCode,p.ProductCode"

            Return objDB.List(sqlStatement, objCnn)
End Function

Public Function ProductNameForReport(ByVal LangID As Integer, ByVal objCnn As MySqlConnection) As String

            Dim PName As String = "ProductName"
            Dim ChkData As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramTypeID=2 AND PropertyID=8 AND KeyID=1", objCnn)
            
            If ChkData.Rows.Count > 0 Then
                If IsNumeric(ChkData.Rows(0)("PropertyValue")) Then
                    If ChkData.Rows(0)("PropertyValue") = 99 Then
                        If LangID = 1 Then
                            PName = "ProductName1"
                        Else
                            PName = "ProductName"
                        End If
                    ElseIf ChkData.Rows(0)("PropertyValue") = 98 Then
                        If LangID = 1 Then
                            PName = "ProductName"
                        Else
                            PName = "ProductName1"
                        End If
                    End If
                End If
            End If

            Return PName
        End Function

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
