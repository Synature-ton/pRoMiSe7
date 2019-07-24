<%@ Page Language="VB" ContentType="text/html" debug="True" %>
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
<title>Sale VAT Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Sale Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" Visible="false" runat="server" /></td></tr></table></div>
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
	<td>
	<table>
		<tr>
			<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
			<td colspan="4"><table cellpadding="0" cellspacing="0"><tr><td><synature:date id="DailyDate" runat="server" /></td><td>&nbsp;&nbsp;</td><td><asp:Label id="LangText1" class="text" runat="server" />&nbsp;<asp:TextBox ID="ItemNameVal" runat="server"></asp:TextBox></td></tr></table></td>
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
<span id="showResults" runat="server">
<table width="100%">
<div class="noprint">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton> | <asp:LinkButton ID="ExportERP" Text="Export to ERP" OnClick="ExportToERP" runat="server"></asp:LinkButton></div></td>
</tr></div>
</table>
<span id="MyTable">
<table width="100%">

<tr>
	<td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td>
</tr>
<tr>
	<td width="100%">
	<table width="100%">
		<tr>
			<td valign="top"><span id="CompanyInfoText1" runat="server"></span></td>
			<td align="right" valign="top"><span id="CompanyInfoText2" runat="server"></span></td>
		</tr>
	</table>
	</td>
</tr>
<tr><td>
	<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
    <tr>
	<span id="TableHeaderText" runat="server"></span>
	</tr>
	
	<div id="ResultText" runat="server"></div>
	
    </table>
    </td></tr>
</table></span>
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
Dim PageID As Integer = 13

Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_SaleVAT") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		showResults.Visible = False
		
		Dim z As Integer
		If NOT Request.QueryString("ToLangID") Is Nothing Then
			If IsNumeric(Request.QueryString("ToLangID")) Then
				Session("LangID") = Request.QueryString("ToLangID")
			End If
		End If
		
		Session("LangID") = 1

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

		'errorMsg.InnerHtml = ""
		
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
			ItemNameVal.Text = LangData2.Rows(0)(LangText)
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
	Dim FoundError As Boolean
	FoundError = False
	Session("ReportResult") = ""
	Dim LangData2 As DataTable = getProp.GetLangData(PageID,2,-1,Request)
	Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
	Dim LangText As String = "lang" + Session("LangID").ToString
	Dim FormatData As DataTable = Util.FormatParam(FormatObject,Session("LangID"),objCnn)
	Dim ci As New CultureInfo(FormatObject.CultureString)
	
	Dim ViewOption As Integer
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""
	Dim DailyDateValue As String = ""
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
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
		objDB.sqlExecute("update TextParamValue Set TextParamValue='" + ItemNameVal.Text + "' where TextParamValueID=1752", objcnn)
		Dim displayTable As New DataTable()
		
		ShowResults.Visible = True
		ShowPrint.Visible = True
		Dim i As Integer
		'Application.Lock()
		Dim PayTypeList As DataTable
		Dim PayTypeData As DataTable
		Dim dtTable As DataTable = SaleVATReports_Kidzania(PayTypeList,PayTypeData,StartDate, EndDate, Request.Form("ShopID"), Session("LangID"), ViewOption, objCnn)
		ResultSearchText.InnerHtml = LangData2.Rows(1)(LangText) + "<BR>" + SelShopName.Value
		'Application.UnLock()
	
		Dim HeaderString As String = ""
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>#</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Date</td>"		
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Description</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Tax Registration No.</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Terminal ID</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Total Sale</td>"
		
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Discount</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Sub Total</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Tax</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Net Sale</td>"
		For i = 0 To PayTypeList.Rows.Count - 1
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + PayTypeList.Rows(i)("PayTypeName") + "</td>"
		Next
		TableHeaderText.InnerHtml = HeaderString
		
		Dim GlobalRCHeaderText,GlobalFTHeaderText,GlobalCMHeaderText, HText, RText As String
		
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

		Dim ReceiptHeaderData As DataTable
		ReceiptHeaderData = getInfo.GetDocType(1, 0, 8, 1, objCnn)
		If ReceiptHeaderData.Rows.Count > 0 Then
			If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
				GlobalRCHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
			End If
		End If
		ReceiptHeaderData = getInfo.GetDocType(1, 0, 11, 1, objCnn)
		If ReceiptHeaderData.Rows.Count > 0 Then
			If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
				GlobalFTHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
			End If
		End If
		ReceiptHeaderData = getInfo.GetDocType(1, 0, 33, 1, objCnn)
		If ReceiptHeaderData.Rows.Count > 0 Then
			If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
				GlobalCMHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
			End If
		End If
	
		Dim TextClass As String
		Dim TotalVAT As Double = 0
		Dim TotalFullTax As Double
		
		Dim DummyHeader As String
		Dim FullText As String
		Dim TotalProductDiscount As Double = 0
		Dim TotalSale As Double = 0
		Dim grandTotalBeforeVAT As Double = 0
        Dim grandTotalVAT As Double = 0
        Dim grandTotalAfterVAT As Double = 0
		Dim grandTotalRetailPrice As Double = 0
		Dim grandTotalDiscount As Double = 0
		Dim VoidText As String
		Dim DateString,InvoiceString,CustomerString,ItemString,ItemValString,VatString,ItemSubTotalString,NoteString,TerminalString As String
		Dim MaxRText As String
		
		Dim POSTotalBeforeVAT As Double = 0
		Dim POSTotalVAT As Double = 0
		Dim POSTotalAfterVAT As Double = 0
		Dim POSRetailPrice As Double = 0
		Dim POSDiscount As Double = 0
		Dim MultiPOS As Integer = 0
		
		Dim RetailPrice As Double = 0
		Dim Discount As Double = 0
		
		Dim outputString As StringBuilder = New StringBuilder
		Dim foundRows() As DataRow
        Dim expression As String
		Dim j,k As Integer
		Dim PaymentVal As Double = 0
		Dim PaymentRecord(PayTypeList.Rows.Count - 1) As Double
		Dim POSPayment(PayTypeList.Rows.Count - 1) As Double
		Dim grandTotalPayment(PayTypeList.Rows.Count - 1) As Double
		Dim LoopLen As Integer
		Dim IDText As String
		Dim CompanyID As String = "KEHT"
		Dim GroupID As String = "T01-0101"
		Dim myDataTable As DataTable = new DataTable("ERPData")
		Dim myDataColumn As DataColumn 
		Dim myDataRow As DataRow
	
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "CompanyID"
		myDataColumn.ReadOnly = True
		myDataColumn.Unique = False
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "GroupID"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "Description"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "Terminal"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "Date"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "Payment"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "Amount"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "STranID"
		myDataTable.Columns.Add(myDataColumn)
		
		Dim counter As Integer = 0
		For i = 0 To dtTable.Rows.Count - 1

			TotalSale = dtTable.Rows(i)("TransactionVatable")
		
			HText = ""
			If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
				If Not IsDBNull(dtTable.Rows(i)("DocumentTypeHeader")) Then
					HText = dtTable.Rows(i)("DocumentTypeHeader")
				End If
			Else
				HText = GlobalRCHeaderText
			End If
			If IsDBNull(dtTable.Rows(i)("ReceiptID")) Or IsDBNull(dtTable.Rows(i)("ReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("ReceiptYear")) Then
				RText = "-"
			Else
				RText = FormatDocNumber.GetReceiptHeader(HText, dtTable.Rows(i)("ReceiptYear"), dtTable.Rows(i)("ReceiptMonth"), dtTable.Rows(i)("ReceiptID"))
			End If
			
			If IsDBNull(dtTable.Rows(i)("MaxReceiptID")) Or IsDBNull(dtTable.Rows(i)("MaxReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("MaxReceiptYear")) Then
				MaxRText = "- N/A"
			Else
				MaxRText = " - " + FormatDocNumber.GetReceiptHeader(HText, dtTable.Rows(i)("MaxReceiptYear"), dtTable.Rows(i)("MaxReceiptMonth"), dtTable.Rows(i)("MaxReceiptID"))
			End If
			If Not IsDBNull(dtTable.Rows(i)("RegistrationNumber")) Then
				TerminalString = dtTable.Rows(i)("RegistrationNumber")
			Else
				TerminalString = "-"
			End If
			
			RetailPrice =  Math.Round((dtTable.Rows(i)("ReceiptSalePrice") + dtTable.Rows(i)("ReceiptDiscount"))*100/(100+dtTable.Rows(i)("VATPercent")),2)
			Discount = (TotalSale - dtTable.Rows(i)("TransactionVAT")) - Math.Round((dtTable.Rows(i)("ReceiptSalePrice") + dtTable.Rows(i)("ReceiptDiscount"))*100/(100+dtTable.Rows(i)("VATPercent")),2)
			
			grandTotalBeforeVAT += TotalSale - dtTable.Rows(i)("TransactionVAT")
			grandTotalVAT += dtTable.Rows(i)("TransactionVAT")
			grandTotalAfterVAT += TotalSale
			grandTotalRetailPrice += RetailPrice
			grandTotalDiscount += Discount
			
			POSTotalBeforeVAT += TotalSale - dtTable.Rows(i)("TransactionVAT")
			POSTotalVAT += dtTable.Rows(i)("TransactionVAT")
			POSTotalAfterVAT += TotalSale
			POSRetailPrice += RetailPrice
			POSDiscount += Discount
			
			DateString = DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly", Session("LangID"), objCnn)
			InvoiceString = RText + MaxRText
			CustomerString = "-"
			ItemString = ItemNameVal.Text
			ItemValString = Format(TotalSale - dtTable.Rows(i)("TransactionVAT"), FormatData.Rows(0)("CurrencyFormat"))
			VatString = Format(dtTable.Rows(i)("TransactionVAT"), FormatData.Rows(0)("CurrencyFormat"))
			ItemSubTotalString = Format(TotalSale, FormatData.Rows(0)("CurrencyFormat"))
			NoteString = "-"

			outputString = outputString.Append("<tr bgColor=""" + "white" + """>")
            outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + (i+1).ToString + "</td>")
			outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + DateString + "</td>")
			outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + InvoiceString + "</td>")
			outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + TerminalString + "</td>")
			outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + HText + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(RetailPrice, FormatData.Rows(0)("CurrencyFormat"))+ "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(-Discount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + ItemValString + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + VatString + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + ItemSubTotalString + "</td>")
			For j = 0 to PayTypeList.Rows.count - 1
				expression = "SaleDateString='" + dtTable.Rows(i)("SaleDateString").ToString + "' AND ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + " AND PayTypeID=" + PayTypeList.Rows(j)("PayTypeID").ToString
				foundRows = PayTypeData.Select(expression)
				If foundRows.GetUpperBound(0) >= 0 Then
					PaymentVal = foundRows(0)("TotalPay")
				Else
					PaymentVal = 0
				End If
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(PaymentVal, FormatData.Rows(0)("CurrencyFormat"))+ "</td>")
				POSPayment(j) += PaymentVal
				grandTotalPayment(j) += PaymentVal
				PaymentRecord(j) = PaymentVal
			Next

			outputString = outputString.Append("</tr>")
			
			GroupID = HText + "-" + dtTable.Rows(i)("ERPMonthYear")
			counter = 0
			
			counter += 1
			LoopLen = LEN(counter.ToString)
			IDText = ""
			For j = 1 To (3-LoopLen)
				IDText += "0"
			Next
			IDText = IDText + counter.ToString
			myDataRow = myDataTable.NewRow()
			myDataRow("CompanyID") = CompanyID
			myDataRow("GroupID") = GroupID
			myDataRow("Description") = "Bill: " + InvoiceString
			myDataRow("Terminal") = HText
			myDataRow("Date") = dtTable.Rows(i)("ERPDate").ToString
			myDataRow("Payment") = "POS"
			myDataRow("Amount") = Replace(Format(RetailPrice, FormatData.Rows(0)("CurrencyFormat")),",","")
			myDataRow("STranID") = HText + "-" + dtTable.Rows(i)("SaleDateString").ToString + "-" + IDText
			myDataTable.Rows.Add(myDataRow)
			
			If Math.Round(Discount,2) <> 0 Then
				counter += 1
				LoopLen = LEN(counter.ToString)
				IDText = ""
				For j = 1 To (3-LoopLen)
					IDText += "0"
				Next
				IDText = IDText + counter.ToString
				myDataRow = myDataTable.NewRow()
				myDataRow("CompanyID") = CompanyID
				myDataRow("GroupID") = GroupID
				myDataRow("Description") = "Bill: " + InvoiceString
				myDataRow("Terminal") = HText
				myDataRow("Date") = dtTable.Rows(i)("ERPDate").ToString
				myDataRow("Payment") = "Discount"
				myDataRow("Amount") = Replace(Format(-Discount, FormatData.Rows(0)("CurrencyFormat")),",","")
				myDataRow("STranID") = dtTable.Rows(i)("SaleDateString").ToString + "-" + IDText
				myDataTable.Rows.Add(myDataRow)
			End If
			
			For j = 0 to PayTypeList.Rows.count - 1
				If PaymentRecord(j) <> 0 Then
					counter += 1
					LoopLen = LEN(counter.ToString)
					IDText = ""
					For k = 1 To (3-LoopLen)
						IDText += "0"
					Next
					IDText = IDText + counter.ToString
					myDataRow = myDataTable.NewRow()
					myDataRow("CompanyID") = CompanyID
					myDataRow("GroupID") = GroupID
					myDataRow("Description") = "Bill: " + InvoiceString
					myDataRow("Terminal") = HText
					myDataRow("Date") = dtTable.Rows(i)("ERPDate").ToString
					myDataRow("Payment") = PayTypeList.Rows(j)("PayTypeName")
					myDataRow("Amount") = Replace(Format(PaymentRecord(j), FormatData.Rows(0)("CurrencyFormat")),",","")
					myDataRow("STranID") = dtTable.Rows(i)("SaleDateString").ToString + "-" + IDText
					myDataTable.Rows.Add(myDataRow)
				End If
			Next
			
			counter += 1
			LoopLen = LEN(counter.ToString)
			IDText = ""
			For j = 1 To (3-LoopLen)
				IDText += "0"
			Next
			IDText = IDText + counter.ToString
			myDataRow = myDataTable.NewRow()
			myDataRow("CompanyID") = CompanyID
			myDataRow("GroupID") = GroupID
			myDataRow("Description") = "Bill: " + InvoiceString
			myDataRow("Terminal") = HText
			myDataRow("Date") = dtTable.Rows(i)("ERPDate").ToString
			myDataRow("Payment") = "Tax"
			myDataRow("Amount") = Replace(Format(dtTable.Rows(i)("TransactionVAT"), FormatData.Rows(0)("CurrencyFormat")),",","")
			myDataRow("STranID") = dtTable.Rows(i)("SaleDateString").ToString + "-" + IDText
			myDataTable.Rows.Add(myDataRow)
			
			If i <> dtTable.Rows.Count - 1
				If dtTable.Rows(i)("ComputerID") <> dtTable.Rows(i+1)("ComputerID") Then
					outputString = outputString.Append("<tr bgColor=""" + "white" + """>")
					outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """ colspan=""5"">" + "Sub Total " + TerminalString + "</td>")
					outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(POSRetailPrice, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
					outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(-POSDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
					outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(POSTotalBeforeVAT, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
					outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(POSTotalVAT, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
					outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(POSTotalAfterVAT, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
					For j = 0 to PayTypeList.Rows.count - 1
						outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(POSPayment(j), FormatData.Rows(0)("CurrencyFormat"))+ "</td>")
						POSPayment(j) = 0
					Next
					outputString = outputString.Append("</tr>")
					
					
					POSTotalBeforeVAT = 0
                	POSTotalVAT = 0
                	POSTotalAfterVAT = 0
					POSRetailPrice = 0
					POSDiscount = 0
					MultiPOS += 1
				End If
			End If
			
			If i = dtTable.Rows.Count - 1 AND MultiPOS > 0 Then
				outputString = outputString.Append("<tr bgColor=""" + "white" + """>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """ colspan=""5"">" + "Sub Total " + TerminalString + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(POSRetailPrice, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(-POSDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(POSTotalBeforeVAT, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(POSTotalVAT, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(POSTotalAfterVAT, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
				For j = 0 to PayTypeList.Rows.count - 1
						outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(POSPayment(j), FormatData.Rows(0)("CurrencyFormat"))+ "</td>")
				Next
				outputString = outputString.Append("</tr>")
			End If
		Next
		outputString = outputString.Append("<tr bgColor=""" + "white" + """>")
		outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """ colspan=""5"">" + "Grand Total" + "</td>")
		outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalRetailPrice, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
		outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(-grandTotalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
		outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalBeforeVAT, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
		outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalVAT, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
		outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalAfterVAT, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
		For j = 0 to PayTypeList.Rows.count - 1
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalPayment(j), FormatData.Rows(0)("CurrencyFormat"))+ "</td>")
		Next
		outputString = outputString.Append("</tr>")

		ResultText.InnerHtml = outputString.ToString
		
		Session("ERPData") = myDataTable
		
		Dim CompanyInfo As DataTable
		CompanyInfo = getInfo.GetCompanyInfo(Request.Form("ShopID"), objCnn)
		
		Dim CompanyInfo1,CompanyInfo2 As String
		Dim Add2 As String = ""
		
		If CompanyInfo.Rows.Count > 0 Then
			CompanyInfo1 += "<table>"
			CompanyInfo1 += "<tr><td class=""text"">" + CompanyInfo.Rows(0)("CompanyName") + "</td></tr>"
			If Not IsDBNull(CompanyInfo.Rows(0)("CompanyAddress1")) Then
				CompanyInfo1 += "<tr><td class=""text"">" + CompanyInfo.Rows(0)("CompanyAddress1") + "</td></tr>"
			End If
			
			If Not IsDBNull(CompanyInfo.Rows(0)("CompanyAddress2")) Then
				Add2 += CompanyInfo.Rows(0)("CompanyAddress2")
			End If
			If Not IsDBNull(CompanyInfo.Rows(0)("CompanyCity")) Then
				If Add2 <> "" Then Add2 += " "
				Add2 += CompanyInfo.Rows(0)("CompanyCity")
			End If
			
			If Add2 <> "" Then
				CompanyInfo1 += "<tr><td class=""text"">" + Add2 + "</td></tr>"
			End If
			
			Dim Chk As Boolean = getReport.CheckTableColumn("CompanyProfile","DisplayCompanyProvinceLangID",objCnn)
			Dim Province As DataTable 
			If Chk = False Then
				Province = objDB.List("select * from provinces where provinceid=" + CompanyInfo.Rows(0)("CompanyProvince").ToString + " and LangID=" + CompanyInfo.Rows(0)("DisplayCompanyProvinceLangID").ToString, objCnn)
			Else
				Province = objDB.List("select * from provinces where provinceid=" + CompanyInfo.Rows(0)("CompanyProvince").ToString + " and LangID=" + Session("LangID").ToString, objCnn)
			End If
			
			Add2 = ""
			If Province.Rows.Count > 0 Then
				Add2 += Province.Rows(0)("ProvinceName")
			End If
			If Not IsDBNull(CompanyInfo.Rows(0)("CompanyZipcode")) Then
				If Add2 <> "" Then Add2 += " "
				Add2 += CompanyInfo.Rows(0)("CompanyZipcode")
			End If
			If Add2 <> "" Then
				CompanyInfo1 += "<tr><td class=""text"">" + Add2 + "</td></tr>"
			End If

			CompanyInfo1 += "</table>"
			
			CompanyInfo2 = "<table>"
			CompanyInfo2 += "<tr><td class=""text"">" + ReportDate + "</td></tr>"
			If Not IsDBNull(CompanyInfo.Rows(0)("CompanyTaxID")) Then
				CompanyInfo2 += "<tr><td class=""text"">" + LangData2.Rows(3)(LangText) + "</td></tr>"
				CompanyInfo2 += "<tr><td class=""text"">" + CompanyInfo.Rows(0)("CompanyTaxID") + "</td></tr>"
			End If
			CompanyInfo2 += "<tr><td class=""text"">" + LangData2.Rows(2)(LangText) + "</td></tr>"
			CompanyInfo2 += "</table>"
			
		End If
		CompanyInfoText1.InnerHtml = CompanyInfo1
		CompanyInfoText2.InnerHtml = CompanyInfo2
		
		Session("ReportResult") = "<table width=""100%""><tr><td align=""center"">" + ResultSearchText.InnerHtml + "</td></tr><tr><td width=""100%""><table width=""100%""><tr><td valign=""top"" colspan=""7"">" + CompanyInfoText1.InnerHtml  + "</td><td align=""right"" valign=""top"" colspan=""2"">" + CompanyInfoText2.InnerHtml + "</td></tr></table></td></tr><tr><td>" + "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%""><tr>" + TableHeaderText.InnerHtml + "</tr>" + ResultText.InnerHtml + "</table></td></tr></table>"
		
	End If
	
End Sub
		

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "SaleVATData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub	

Sub ExportToERP(Source As Object, E As EventArgs)
	Dim dtTable As DataTable
	Dim i As Integer
	If Not Session("ERPData") Is Nothing Then
		dtTable = Session("ERPData")
		Dim filename As String = "SaleDataCollection.csv"
		Response.Clear()
		Response.ContentType = "application/vnd.ms-excel"
		Response.AddHeader("Content-Disposition", "attachment; filename=""" & filename & """")
		Response.Charset = "windows-874"
		Response.ContentEncoding = System.Text.Encoding.GetEncoding(874)
		Response.Flush()
		Response.Write("CompanyID,GroupID,Description,Terminal,Date,Payment,Amount,STranID" + chr(13) & chr(10))
		For i = 0 To dtTable.Rows.Count - 1
			Response.Write(dtTable.Rows(i)("CompanyID") + "," + dtTable.Rows(i)("GroupID") + "," + dtTable.Rows(i)("Description") + "," + dtTable.Rows(i)("Terminal") + "," + dtTable.Rows(i)("Date") + "," + dtTable.Rows(i)("Payment") + "," + dtTable.Rows(i)("Amount") + "," + dtTable.Rows(i)("STranID") + chr(13) & chr(10))
		Next
		Response.End()
	End If

End Sub

   Public Function SaleVATReports_Kidzania(ByRef PayTypeList As DataTable, ByRef PayTypeData As DataTable, ByVal StartDate As String, ByVal EndDate As String, ByVal ShopID As Integer, ByVal LangID As Integer, ByVal ViewOption As Integer, ByVal objCnn As MySqlConnection) As DataTable

        Dim sqlStatement, sqlStatement1, WhereString, WString As String
        Dim AdditionalQuery As String = ""
        Dim ShopIDListValue As String
        Dim ResultString As String = ""
        Dim TextClass As String
        Dim GetData As DataTable

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

        If ShopID > 0 Then
            AdditionalQuery += " AND a.ShopID IN (" + ShopID.ToString + ")"
            WhereString += " AND ShopID IN (" + ShopID.ToString + ")"
            WString += " AND a.ShopID IN (" + ShopID.ToString + ")"
        End If

        If StartDate <> "" And EndDate <> "" Then
            AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
            WhereString += " AND (PayDate >= " + StartDate + " AND PayDate < " + EndDate + ")"
            WString += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
        End If

        AdditionalQuery += " AND a.DocType IN (4,8)"

        Dim OrderBy As String = " a.ReceiptYear,a.ReceiptMonth,a.ReceiptID,b.OrderDetailID,d.PayTypeID"



        objDB.sqlExecute("DROP TABLE IF EXISTS DummyMinMaxTran", objCnn)

            objDB.sqlExecute("create table DummyMinMaxTran (SaleDate date,ComputerID int, MinID int, MinMonth int, MinYear int, MaxID int, MaxMonth int, MaxYear int)", objCnn)
            sqlStatement = "select a.SaleDate,a.CloseComputerID,MIN(a.ReceiptID) AS ReceiptID,MIN(a.ReceiptMonth) AS ReceiptMonth,MIN(a.ReceiptYear) AS ReceiptYear,MAX(a.ReceiptID) AS MaxReceiptID,MAX(a.ReceiptMonth) AS MaxReceiptMonth,MAX(a.ReceiptYear) AS MaxReceiptYear From OrderTransaction" + BranchStr + " a WHERE a.ReceiptID > 0 AND a.DocType IN (4,8) " + AdditionalQuery + " group by a.SaleDate,a.CloseComputerID Order By a.SaleDate,a.CloseComputerID"

            objDB.sqlExecute("insert into DummyMinMaxTran " + sqlStatement, objCnn)
            sqlStatement = "select a.SaleDate,DATE_FORMAT(a.SaleDate,'%Y%m%d') As SaleDateString,DATE_FORMAT(a.SaleDate,'%Y-%m-%d') As ERPDate,DATE_FORMAT(a.SaleDate,'%m%y') As ERPMonthYear,a.CloseComputerID AS ComputerID,t.RegistrationNumber,MinID AS ReceiptID,MinMonth AS ReceiptMonth,MinYear AS ReceiptYear,MaxID AS MaxReceiptID,MaxMonth AS MaxReceiptMonth,MaxYear AS MaxReceiptYear,DocumentTypeHeader,a.VATPercent,SUM(a.TransactionVatable) AS TransactionVatable,SUM(a.TransactionVAT) AS TransactionVAT,SUM(a.ReceiptSalePrice) As ReceiptSalePrice,SUM(a.ReceiptDiscount) As ReceiptDiscount from ordertransaction" + BranchStr + " a inner join DummyMinMaxTran e ON a.SaleDate=e.SaleDate AND a.CloseComputerID=e.ComputerID inner join ComputerName t ON a.CloseComputerID=t.ComputerID left outer join DocumentType dt ON a.DocType=dt.DocumentTypeID AND a.CloseComputerID=dt.ComputerID  where a.TransactionStatusID=2 AND a.ReceiptID > 0 AND a.DocType IN (4,8) AND dt.LangID=" + LangID.ToString + AdditionalQuery + " group by a.VATPercent,a.SaleDate,a.CloseComputerID,t.RegistrationNumber Order By a.CloseComputerID,a.SaleDate"

        GetData = objDB.List(sqlStatement, objCnn)
		
		sqlStatement = "select ShopID,SaleDate,a.CloseComputerID As ComputerID,DATE_FORMAT(a.SaleDate,'%Y%m%d') As SaleDateString,b.PayTypeID,c.PayType As PayTypeName,c.PayTypeCode,SUM(b.Amount) As TotalPay from ordertransaction a, paydetail b, paytype c where a.TransactionStatusID=2 AND a.ReceiptID>0 AND a.DocType IN (4,8) AND a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.PayTypeID=c.TypeID group by a.CloseComputerID,ShopID,SaleDate,b.PayTypeID,c.PayType,c.PayTypeCode"
		
		PayTypeData = objDB.List(sqlStatement, objCnn)
		
		sqlStatement = "select count(*),b.PayTypeID,c.PayType As PayTypeName from ordertransaction a, paydetail b, paytype c where a.TransactionStatusID=2 AND a.ReceiptID>0 AND a.DocType IN (4,8) AND a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.PayTypeID=c.TypeID group by b.PayTypeID,c.PayType order by b.PayTypeID"
		
		PayTypeList = objDB.List(sqlStatement, objCnn)

        objDB.sqlExecute("DROP TABLE IF EXISTS DummyDocType", objCnn)
        objDB.sqlExecute("DROP TABLE IF EXISTS DummyMinMaxTran", objCnn)
        Return GetData


    End Function



Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
