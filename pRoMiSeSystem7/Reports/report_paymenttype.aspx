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

<html>
<head>
<title>Sale Report By Payment Type</title>
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
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Payment Type Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
			<tr id="show12" visible="false" runat="server">
				<td><asp:radiobutton ID="Radio_11" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
			<tr id="show22" visible="false" runat="server">
				<td><asp:radiobutton ID="Radio_12" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>

		</table></td>
	<td>
	<table>
		<tr>
			<td><asp:radiobutton ID="Radio_3" GroupName="Group1" Enabled="false" runat="server" /></td>
			<td colspan="4"><synature:date id="DailyDate" runat="server" /></td>
		</tr>
		<tr id="show1" visible="false" runat="server">
			<td><asp:radiobutton ID="Radio_1" GroupName="Group1" Enabled="false" runat="server" /></td>
			<td colspan="3"><synature:date id="MonthYearDate" runat="server" /></td>
		</tr>
		<tr id="show2" visible="false" runat="server">
			<td><asp:radiobutton ID="Radio_2" GroupName="Group1" Enabled="false" runat="server" /></td>
			<td><synature:date id="CurrentDate" runat="server" /></td>
			<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
			<td><synature:date id="ToDate" runat="server" /></td>
		</tr>
		
	
	</table>
	</td>
	<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
</tr>


</table>
<br>
</div>
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
<span id="showHeader" runat="server">
<span id="startTable" runat="server"></span>
	
	<tr>
	<span id="TableHeaderText" runat="server"></span>
	<span id="ExtraHeader" runat="server"></span>
	</tr>
	
	<div id="ResultText" runat="server"></div>
</table>
</span></td></tr>
</table></span>
<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table>
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
Dim Reports As New ReportV6()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer  = 998

Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_PaymentType") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		showHeader.Visible = False
		Radio_3.Visible = False
		
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
		
		
		StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
			
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
		
		Radio_11.Text = "Order By Bill Date"
		Radio_12.Text = "Order By Staff"
		
		ResultText.InnerHtml = ""
		ResultSearchText.InnerHtml = ""
		errorMsg.InnerHtml = ""
		
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
			
		Dim i As Integer
		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		
		Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
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
	errorMsg.InnerHtml = ""
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
	Dim grandTotal As Double = 0
	Dim GraphData As New DataSet()
	Dim ReportDate As String
			
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
	
	If FoundError = False Then
		If LangDefault.Rows.Count >= 3 Then
			CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(NOW(), "DateAndTime",Session("LangID"),objCnn)
		End If
		Dim displayTable As New DataTable()
		
		ShowHeader.Visible = True
		ShowPrint.Visible = True
		
		Dim ViewOption As Integer
		If Radio_11.Checked = True Then
			ViewOption = 1
		ElseIf Radio_12.Checked = True Then
			ViewOption = 2
		Else
			ViewOption = 3 
		End If
		Dim i As Integer
		Dim PayTypeList,PayTypeData,ColumnData As DataTable
		
		Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel where ProductLevelID=" + Request.Form("ShopID").ToString, objCnn)
		Dim DisplayVATType As String = "V"
		If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
			DisplayVATType = "E"
		End If

		'Application.Lock()
		Dim dtTable As DataTable = PaymentTypeReport(ColumnData,PayTypeList,PayTypeData,ViewOption, StartDate, EndDate, Request.Form("ShopID"), 0, 0, Session("LangID"), objCnn)
		ResultSearchText.InnerHtml = "Payment Type Report of " + SelShopName.Value + "<br>" + ReportDate + ""
		'Application.UnLock()
		
		Dim ColSpan As Integer = 10
		Dim HeaderString As String = ""
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Staff</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Pay Type</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Bill #</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Time</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Guest</td>"	
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Sale Amount</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Disc</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Total Sales</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>SC</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Grand Total</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Payment</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Remark</td>"
		
		TableHeaderText.InnerHtml = HeaderString
		
		Dim outputResult As String = GenPaymentTypeReport(GlobalParam.GrayBGColor,GlobalParam.AdminBGColor,Request.Form("ShopID"),ViewOption, StartDate, EndDate,  dtTable, objCnn)
			
		ResultText.InnerHtml = outputResult
		
		Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"
		
	End If
	
End Sub

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "SalePaymentType_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub	

Public Function PaymentTypeReport(ByRef ColumnData As DataTable, ByRef PayTypeList As DataTable, ByRef PayTypeData As DataTable, ByVal ViewOption As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal ShopID As Integer, ByVal TransactionID As Integer, ByVal ComputerID As Integer, ByVal LangID As Integer, ByVal objCnn As MySqlConnection) As DataTable

        Dim sqlStatement, sqlStatement1, sqlStatement2, WhereString As String
        Dim AdditionalQuery As String = ""
        Dim ShopIDListValue As String
        Dim ResultString As String = ""
        Dim TextClass As String
        Dim GetData As DataTable

        Dim BranchStr, StrBefore As String
        Dim ii As Integer
        Dim getProp As New CPreferences

        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

        If TransactionID > 0 And ComputerID > 0 Then
            AdditionalQuery += " AND ( a.TransactionID = " + TransactionID.ToString + " AND a.ComputerID = " + ComputerID.ToString + ")"
        End If

        If ShopID > 0 Then
            AdditionalQuery += " AND a.ShopID IN (" + ShopID.ToString + ")"
        End If

        If StartDate <> "" And EndDate <> "" Then
            AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
        End If

        AdditionalQuery += " AND a.DocType=8"

        Dim OrderBy As String = " a.SaleDate,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"

        If ViewOption = 2 Then
            OrderBy = " s.StaffID,a.SaleDate,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"
        End If

        objDB.sqlExecute("DROP TABLE IF EXISTS DummySalePaymentSummary", objCnn)
        objDB.sqlExecute("create table DummySalePaymentSummary (TransactionID int, ComputerID int, CloseComputerID int,SessionID int, PaidStaffID int, PaidTime datetime, NoCustomer smallint, ReceiptID int,ReceiptMonth int, ReceiptYear int, TotalQty decimal(18,4),TotalRetailPrice decimal(18,4),TotalSalePrice decimal(18,4), TotalDiscount decimal(18,4))", objCnn)
        objDB.sqlExecute("ALTER TABLE DummySalePaymentSummary ADD PRIMARY KEY (TransactionID,ComputerID)", objCnn)
        sqlStatement = "select a.TransactionID,a.ComputerID,a.CloseComputerID,a.SessionID,a.PaidStaffID,a.PaidTime,NoCustomer,a.ReceiptID,a.ReceiptMonth,a.ReceiptYear,SUM(b.Amount) As TotalQty, SUM(c.TotalRetailPrice) AS TotalRetailPrice, SUM(c.SalePrice) As TotalSalePrice, SUM(c.TotalRetailPrice-c.SalePrice) As TotalDiscount  from OrderTransaction a, OrderDetail b, OrderDiscountDetail c where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.OrderDetailID=c.OrderDetailID AND b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND a.TransactionStatusID=2 AND a.ReceiptID>0 AND b.ProductSetType NOT IN (-1,-3) " + AdditionalQuery + " group by a.TransactionID,a.ComputerID,a.CloseComputerID,a.SessionID,a.PaidStaffID,a.PaidTime,NoCustomer,a.ReceiptID,a.ReceiptMonth,a.ReceiptYear"

        objDB.sqlExecute("insert into DummySalePaymentSummary " + sqlStatement, objCnn)

        sqlStatement = "select a.*,IF(s.StaffID is NULL,0,s.StaffID) As StaffID,b.PayTypeID,c.PayType AS PayTypeName,IF(d.CreditCardType is NULL,c.PayType,d.CreditCardType) As CreditCardType,IF(s.StaffFirstName is NULL,'',CONCAT(s.StaffFirstName,' ',s.StaffLastName)) As StaffFullName,IF(s.StaffCode is NULL,'',s.StaffCode) As StaffCode,aa.ServiceCharge+aa.ServiceChargeVAT As ServiceCharge,aa.DocType,dt.DocumentTypeHeader,b.Amount As TotalPay,b.CreditCardNo,b.ExpireMonth,b.ExpireYear from OrderTransaction aa inner join DummySalePaymentSummary a ON aa.TransactionID=a.TransactionID AND aa.ComputerID=a.ComputerID inner join PayDetail b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID left outer join Staffs s ON a.PaidStaffID=s.StaffID left outer join PayType c ON b.PayTypeID=c.TypeID left outer join creditcardtype d ON b.CreditCardType=d.CCTypeID left outer join DocumentType dt ON aa.DocType=dt.DocumentTypeID AND (aa.CloseComputerID=dt.ComputerID OR aa.ShopID=dt.ShopID) where dt.LangID=1 order by s.StaffID,b.PayTypeID,d.CreditCardType,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"

        GetData = objDB.List(sqlStatement, objCnn)
        objDB.sqlExecute("DROP TABLE IF EXISTS DummySalePaymentSummary", objCnn)
        Return GetData

    End Function
	
	Public Function GenPaymentTypeReport(ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal ShopID As Integer, ByVal ViewOption As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal dtTable As DataTable, ByVal objCnn As MySqlConnection) As String
        Dim i, j, k As Integer
        Dim outputString As StringBuilder = New StringBuilder
        Dim TotalProductDiscount As Double = 0
        Dim TotalSale, EachTotalSale As Double

        Dim DisplayString As String
        Dim ToTime As Integer
        Dim FoundPayType, FoundGroup As Boolean
        Dim TextClass As String = "smallText"
        Dim TestString As String
        Dim PaymentDiscountText As String

        Dim AdditionalHeaderText, HText, RText, VoidText As String
        Dim FullText As String = ""
        Dim getInfo As New CCategory
        Dim getProp As New CPreferences

        Dim PropertyInfo As DataTable

        Dim ReceiptHeaderData As DataTable

        Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel where ProductLevelID=" + ShopID.ToString, objCnn)
        Dim DisplayVATType As String = "V"
        If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
            DisplayVATType = "E"
        End If

        PropertyInfo = getProp.PropertyInfo(1, objCnn)
        ReceiptHeaderData = getInfo.GetDocType(1, 0, 8, 1, objCnn)

        If ReceiptHeaderData.Rows.Count > 0 Then
            If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
                AdditionalHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
            End If
        End If

        Dim DigitRunning As Integer
        Dim ChkRunning As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramtypeID = 1 AND PropertyID = 29 AND KeyID = 1", objCnn)
        If ChkRunning.Rows.Count > 0 Then
            If ChkRunning.Rows(0)("PropertyValue") > 5 Then
                DigitRunning = ChkRunning.Rows(0)("PropertyValue")
            End If
        End If

        Dim PayDetails As String = ""
        Dim DummyStaff As Integer = 0
        Dim DummyCreditCardType As String = ""
        Dim subTotalGuest, subTotalSaleAmount, subTotalDiscount, subTotalSale, subTotalSC, subTotal, subTotalPayment As Double
        Dim grandTotalGuest, grandTotalSaleAmount, grandTotalDiscount, grandTotalSale, grandTotalSC, grandTotal, grandTotalPayment As Double
        Dim StaffTotalGuest, StaffTotalSaleAmount, StaffTotalDiscount, StaffTotalSale, StaffTotalSC, StaffTotal, StaffTotalPayment As Double
        For i = 0 To dtTable.Rows.Count - 1
            HText = ""
            PayDetails = ""
            If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
                If DigitRunning > 5 Then
                    HText = "Running," + DigitRunning.ToString
                Else
                    If Not IsDBNull(dtTable.Rows(i)("DocumentTypeHeader")) Then
                        HText = dtTable.Rows(i)("DocumentTypeHeader")
                    End If
                End If
            ElseIf DigitRunning > 5 Then
                HText = "Running," + DigitRunning.ToString
            Else
                HText = AdditionalHeaderText
            End If


            If IsDBNull(dtTable.Rows(i)("ReceiptID")) Or IsDBNull(dtTable.Rows(i)("ReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("ReceiptYear")) Then
                RText = "-"
            Else
                RText = FormatDocNumber.GetReceiptHeader(HText, dtTable.Rows(i)("ReceiptYear"), dtTable.Rows(i)("ReceiptMonth"), dtTable.Rows(i)("ReceiptID"))
            End If

            If RText <> "-" Then
                DisplayString = "<a class=""smallText"" href=""JavaScript: newWindow = window.open( 'BillDetails.aspx?ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "&ShopID=" + ShopID.ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & RText & "</a>"
            Else
                DisplayString = RText
            End If

            If Not IsDBNull(dtTable.Rows(i)("CreditCardNo")) And dtTable.Rows(i)("PayTypeID") = 2 Then
                PayDetails = dtTable.Rows(i)("CreditCardNo") + "-" + dtTable.Rows(i)("ExpireMonth").ToString + "/" + dtTable.Rows(i)("ExpireYear").ToString
            End If
            outputString = outputString.Append("<tr>")
            If DummyStaff <> dtTable.Rows(i)("StaffID") Then
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + dtTable.Rows(i)("StaffCode") + ":" + dtTable.Rows(i)("StaffFullName") + "</td>")
            Else
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + "" + "</td>")
            End If
            If DummyCreditCardType <> dtTable.Rows(i)("CreditCardType") Then
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + dtTable.Rows(i)("CreditCardType").ToString + "</td>")
            Else
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + "" + "</td>")
            End If
            outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + DisplayString + "</td>")
            outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("PaidTime"), "HH:mm:ss") + "</td>")
            outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + dtTable.Rows(i)("NoCustomer").ToString + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("TotalRetailPrice"), "##,##0.00") + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("TotalDiscount"), "##,##0.00") + "</td>")

            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalDiscount"), "##,##0.00") + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("ServiceCharge"), "##,##0.00") + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalDiscount") + dtTable.Rows(i)("ServiceCharge"), "##,##0.00") + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("TotalPay"), "##,##0.00") + "</td>")
            outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + "" + "</td>")
            outputString = outputString.Append("</tr>")

            subTotalGuest += dtTable.Rows(i)("NoCustomer")
            subTotalSaleAmount += dtTable.Rows(i)("TotalRetailPrice")
            subTotalDiscount += dtTable.Rows(i)("TotalDiscount")
            subTotalSale += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalDiscount")
            subTotalSC += dtTable.Rows(i)("ServiceCharge")
            subTotal += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalDiscount") + dtTable.Rows(i)("ServiceCharge")
            subTotalPayment += dtTable.Rows(i)("TotalPay")

            StaffTotalGuest += dtTable.Rows(i)("NoCustomer")
            StaffTotalSaleAmount += dtTable.Rows(i)("TotalRetailPrice")
            StaffTotalDiscount += dtTable.Rows(i)("TotalDiscount")
            StaffTotalSale += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalDiscount")
            StaffTotalSC += dtTable.Rows(i)("ServiceCharge")
            StaffTotal += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalDiscount") + dtTable.Rows(i)("ServiceCharge")
            StaffTotalPayment += dtTable.Rows(i)("TotalPay")

            grandTotalGuest += dtTable.Rows(i)("NoCustomer")
            grandTotalSaleAmount += dtTable.Rows(i)("TotalRetailPrice")
            grandTotalDiscount += dtTable.Rows(i)("TotalDiscount")
            grandTotalSale += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalDiscount")
            grandTotalSC += dtTable.Rows(i)("ServiceCharge")
            grandTotal += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalDiscount") + dtTable.Rows(i)("ServiceCharge")
            grandTotalPayment += dtTable.Rows(i)("TotalPay")

            If i <= dtTable.Rows.Count - 1 Then
                If i = dtTable.Rows.Count - 1 Then
                    outputString = outputString.Append("<tr bgColor=""#ebebeb"">")
                    outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                    outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "Total " + dtTable.Rows(i)("CreditCardType") + "</td>")
                    outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                    outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                    outputString = outputString.Append("<td align=""center"" class=""" + "smallboldtext" + """>" + Format(subTotalGuest, "##,##0") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalSaleAmount, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalDiscount, "##,##0.00") + "</td>")

                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalSale, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalSC, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotal, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalPayment, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                    outputString = outputString.Append("</tr>")

                    outputString = outputString.Append("<tr bgColor=""#ebebeb"">")
                    outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "Total " + dtTable.Rows(i)("StaffFullName") + "</td>")
                    outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                    outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                    outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                    outputString = outputString.Append("<td align=""center"" class=""" + "smallboldtext" + """>" + Format(StaffTotalGuest, "##,##0") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(StaffTotalSaleAmount, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(StaffTotalDiscount, "##,##0.00") + "</td>")

                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(StaffTotalSale, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(StaffTotalSC, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(StaffTotal, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(StaffTotalPayment, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                    outputString = outputString.Append("</tr>")

                    outputString = outputString.Append("<tr><td colspan=""12"" height=""10px""></td></tr>")

                    outputString = outputString.Append("<tr bgColor=""#ebebeb"">")
                    outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "Grand Total" + "</td>")
                    outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                    outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                    outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                    outputString = outputString.Append("<td align=""center"" class=""" + "smallboldtext" + """>" + Format(grandTotalGuest, "##,##0") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(grandTotalSaleAmount, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(grandTotalDiscount, "##,##0.00") + "</td>")

                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(grandTotalSale, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(grandTotalSC, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(grandTotal, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(grandTotalPayment, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                    outputString = outputString.Append("</tr>")
                Else
                    If dtTable.Rows(i)("CreditCardType") <> dtTable.Rows(i + 1)("CreditCardType") Then
                        outputString = outputString.Append("<tr bgColor=""#ebebeb"">")
                        outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                        outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "Total " + dtTable.Rows(i)("CreditCardType") + "</td>")
                        outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                        outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                        outputString = outputString.Append("<td align=""center"" class=""" + "smallboldtext" + """>" + Format(subTotalGuest, "##,##0") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalSaleAmount, "##,##0.00") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalDiscount, "##,##0.00") + "</td>")

                        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalSale, "##,##0.00") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalSC, "##,##0.00") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotal, "##,##0.00") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalPayment, "##,##0.00") + "</td>")
                        outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                        outputString = outputString.Append("</tr>")
                        subTotalGuest = 0
                        subTotalSaleAmount = 0
                        subTotalDiscount = 0
                        subTotalSale = 0
                        subTotalSC = 0
                        subTotal = 0
                        subTotalPayment = 0
                    End If

                    If dtTable.Rows(i)("StaffID") <> dtTable.Rows(i + 1)("StaffID") Then
                        outputString = outputString.Append("<tr bgColor=""#ebebeb"">")
                        outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "Total " + dtTable.Rows(i)("StaffFullName") + "</td>")
                        outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                        outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                        outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                        outputString = outputString.Append("<td align=""center"" class=""" + "smallboldtext" + """>" + Format(StaffTotalGuest, "##,##0") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(StaffTotalSaleAmount, "##,##0.00") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(StaffTotalDiscount, "##,##0.00") + "</td>")

                        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(StaffTotalSale, "##,##0.00") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(StaffTotalSC, "##,##0.00") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(StaffTotal, "##,##0.00") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(StaffTotalPayment, "##,##0.00") + "</td>")
                        outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "" + "</td>")
                        outputString = outputString.Append("</tr>")
                        StaffTotalGuest = 0
                        StaffTotalSaleAmount = 0
                        StaffTotalDiscount = 0
                        StaffTotalSale = 0
                        StaffTotalSC = 0
                        StaffTotal = 0
                        StaffTotalPayment = 0
                    End If
                End If
            End If

            DummyStaff = dtTable.Rows(i)("StaffID")
            DummyCreditCardType = dtTable.Rows(i)("CreditCardType")
        Next

        Return outputString.ToString()
    End Function

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
