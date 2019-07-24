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
<%@Import Namespace="pRoMiSe_TransferDataLogReport" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Import Data Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="FrontSystemType" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<input type="hidden" id="ReportName" runat="server" />
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
			<tr id="ShowType" visible="false" runat="server">
				<td><asp:DropDownList ID="ViewTypeList" CssClass="text" Width="150" runat="server">
						<asp:listitem></asp:listitem>
						<asp:listitem></asp:listitem>
						<asp:listitem></asp:listitem>
						<asp:listitem></asp:listitem>
				</asp:DropDownList></td>
			</tr>
			<tr>
				<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
			</tr>


		</table></td>
	<td>
	<table>
		<tr>
			<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
			<td colspan="4"><synature:date id="DailyDate" runat="server" /></td>
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
<br>
</div>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
<tr><td align="left">
<div id="ResultSearchText" class="boldText" runat="server"></div></td></tr></table>
<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">

	<tr>
		<td id="headerTD1" align="center" class="smallTdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD2" align="center" class="smallTdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD3" align="center" class="smallTdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD6" align="center" class="smallTdHeader" runat="server"><div id="Text6" runat="server"></div></td>
		<td id="headerTD4" align="center" class="smallTdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td id="headerTD5" align="center" class="smallTdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<td id="headerTD7" align="center" class="smallTdHeader" runat="server"><div id="Text7" runat="server"></div></td>
	</tr>
	<div id="ResultText" runat="server"></div>
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
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim DBUtil As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim pRoMiSeReport As New TransferDataLogReport()
Dim PageID As Integer = 10

Public Const DATATYPE_TRANSFERDATATYPE As Integer = -1
    Public Const DATATYPE_SYNINFO As Integer = 0
    Public Const DATATYPE_PRODUCT As Integer = 1
    Public Const DATATYPE_COMPUTERRECEIPT As Integer = 2
    Public Const DATATYPE_PROMOTION As Integer = 3
    Public Const DATATYPE_COUPONVOUCHER As Integer = 4
    Public Const DATATYPE_MEMBER As Integer = 5
    Public Const DATATYPE_STAFF As Integer = 6
    Public Const DATATYPE_PREPAIDSMARTCARD As Integer = 7
    Public Const DATATYPE_PACKAGE As Integer = 8
    Public Const DATATYPE_INVENTORY As Integer = 9
    Public Const DATATYPE_MATERIAL As Integer = 10
    Public Const DATATYPE_CONFIG As Integer = 11
    Public Const DATATYPE_SALE As Integer = 12
    Public Const DATATYPE_COMMISSION As Integer = 13
    Public Const DATATYPE_REWARDPOINT As Integer = 14
    Public Const DATATYPE_DOCUMENTHEADER As Integer = 15
    Public Const DATATYPE_USERDEFINEDATA As Integer = 16
    Public Const DATATYPE_PAYTYPE As Integer = 17
    Public Const DATATYPE_TABLEROOM As Integer = 18
    Public Const DATATYPE_VENDOR As Integer = 19
    Public Const DATATYPE_FAVORITEPRODUCT As Integer = 20
    Public Const DATATYPE_TRANSACTIONHISTORY As Integer = 21
    Public Const DATATYPE_STOCKMATERIALSETTING As Integer = 22
    Public Const DATATYPE_DISCOUNTBUTTON As Integer = 23
    Public Const DATATYPE_SELECTEDPRODUCT As Integer = 24
    Public Const DATATYPE_SPASTAFFROOM As Integer = 25
		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Reports_ImportData") Then
		
	'Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		FrontSystemType.Value = PropertyInfo.Rows(0)("FrontSystemType")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(13,Session("LangID"),objCnn)
		Dim textTable1 As New DataTable()
		textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
		
		headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor
		headerTD6.BgColor = GlobalParam.AdminBGColor
		headerTD7.BgColor = GlobalParam.AdminBGColor
		
		Text1.InnerHtml = "Date"
		Text2.InnerHtml = "Shop Code"
		Text3.InnerHtml = "Shop Name"
		Text4.InnerHtml = "Close Time"
		Text5.InnerHtml = "Send Data Time"
		Text6.InnerHtml = "# Sending"
		Text7.InnerHtml = "Diff"
		SubmitForm.Text = textTable.Rows(8)("TextParamValue")
		
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
		'LangList.Text = LangListText
		
		Dim LangData2 As DataTable = getProp.GetLangData(PageID,2,-1,Request)
		
		Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
		
		DocumentToDateParam.InnerHtml = defaultTextTable.Rows(91)("TextParamValue")
		
		Dim HeaderReport As DataTable = getProp.PermissionName(1025,Session("LangID"),objCnn)
		
		If HeaderReport.Rows.Count > 0 Then
			'HeaderText.InnerHtml = HeaderReport.Rows(0)("PermissionItemName")
			LangText0.Text = HeaderReport.Rows(0)("PermissionItemName")
		Else
			LangText0.Text = "Request Document Reports"
		End If
		
		ReportName.Value = LangText0.Text'HeaderText.InnerHtml
			
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
		
		ResultSearchText.InnerHtml = ""
		errorMsg.InnerHtml = ""
		
		ViewTypeList.Items(0).Text = "-- Display All Types --"
		ViewTypeList.Items(0).Value = "0"
		ViewTypeList.Items(1).Text = "Only Move Table"
		ViewTypeList.Items(1).Value = "1"
		ViewTypeList.Items(2).Text = "Only Move Order"
		ViewTypeList.Items(2).Value = "2"
		ViewTypeList.Items(3).Text = "Only Delete Order"
		ViewTypeList.Items(3).Value = "3"
		
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
			Next
			outputString += "</select>"
			ShopText.InnerHtml = outputString
			ShowShop.Visible = True
		Else
			ShowShop.Visible = False
		End If
				
		'Catch ex As Exception
			'errorMsg.InnerHtml = ex.Message
		'End Try
	  
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
	
	Session("ReportResult") = ""
	Dim LangData2 As DataTable = getProp.GetLangData(PageID,2,-1,Request)
	Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
	Dim LangText As String = "lang" + Session("LangID").ToString
	
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
		Catch ex As Exception
			FoundError = True
		End Try
	Else
		DateFromValue = ""
		DateToValue = ""
		DailyDateValue = ""
	End If	
	If FoundError = False Then
		showPrint.Visible = True
		Dim ShopDisplay As String
		If Request.Form("ShopID") = 0 Then
			ShopDisplay = "All Shops"
		Else
			ShopDisplay = SelShopName.Value
		End If
		ResultSearchText.InnerHtml = ReportName.Value + " - " + ShopDisplay + " (" + ReportDate + ")"
		
		Dim TableNameString As String = "ImportData_" + Session.SessionID
		Dim errorText As String
		
		Dim Result As Boolean = DoroTransferDataLogReportForSaleData(getCnn, objCnn, StartDate, EndDate, Request.Form("ShopID").ToString , "1", Session("StaffID"), TableNameString, errorText)
		
		'Exit Sub
		
		If Result = False Then
			errorMsg.InnerHtml = errorText
		Else
			Dim displayTable As DataTable = objDB.List("select *,DAYOFMONTH(ExportDate) As StartDate_Day,MONTH(ExportDate) AS StartDate_Month,YEAR(ExportDate) AS StartDate_Year,DAYOFMONTH(ADDDATE(ExportDate,INTERVAL 1 DAY)) AS EndDate_Day,MONTH(ADDDATE(ExportDate,INTERVAL 1 DAY)) AS EndDate_Month,YEAR(ADDDATE(ExportDate,INTERVAL 1 DAY)) AS EndDate_Year,(TIME_TO_SEC(LastExportDateTime)-TIME_TO_SEC(CloseLastSessionDateTime)) AS Diff_Minute from " + TableNameString + " order by ProductLevelCode,ExportDate", objCnn)

			Dim outputString As StringBuilder = New StringBuilder
			Dim bgColor As String = ""
			Dim TextClass As String = "smallText"
			Dim i As Integer
			Dim DiffDisplay As String
			For i = 0 To displayTable.Rows.Count - 1
				If i mod 2 = 0 Then
					bgColor = "white"
				Else
					bgColor = GlobalParam.GrayBGColor
				End If
			   outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
			   outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + DateTimeUtil.FormatDateTime(displayTable.Rows(i)("ExportDate"), "DateOnly") + "</td>")
			   outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + displayTable.Rows(i)("ProductLevelCode") + "</td>")

			   outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + displayTable.Rows(i)("ProductLevelName") + "</td>")
			   If Not IsDBNull(displayTable.Rows(i)("NoExportData")) Then
			   		outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """><a class=""smalltext"" href=""JavaScript: newWindow = window.open( 'report_importdata_detail.aspx?FromShopID=" + displayTable.Rows(i)("ProductLevelID").ToString + "&StartDate=" & Replace(DateTimeUtil.FormatDate(displayTable.Rows(i)("StartDate_Day"),displayTable.Rows(i)("StartDate_Month"),displayTable.Rows(i)("StartDate_Year")),"'","\'") & "&EndDate=" & Replace(DateTimeUtil.FormatDate(displayTable.Rows(i)("EndDate_Day"),displayTable.Rows(i)("EndDate_Month"),displayTable.Rows(i)("EndDate_Year")),"'","\'") & "&ToShopID=1&DataType=12', '', 'width=800,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + displayTable.Rows(i)("NoExportData").ToString + "</a></td>")   
			   Else
			   		outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>-</td>") 
			   End If
			   If Not IsDBNull(displayTable.Rows(i)("CloseLastSessionDateTime")) Then
			   		outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + DateTimeUtil.FormatDateTime(displayTable.Rows(i)("CloseLastSessionDateTime"), "TimeOnly") + "</td>")
			   Else
			   		outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + "-" + "</td>")
			   End If
			   If Not IsDBNull(displayTable.Rows(i)("LastExportDateTime")) Then
			   		outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + DateTimeUtil.FormatDateTime(displayTable.Rows(i)("LastExportDateTime"), "TimeOnly") + "</td>")
				 Else
			   		outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + "-" + "</td>")
			   End If
			   If Not IsDBNull(displayTable.Rows(i)("Diff_Minute")) Then
			   		If displayTable.Rows(i)("Diff_Minute") \ 3600 = 0 Then
			   			DiffDisplay = "00"
					Else
						If LEN(Replace((DisplayTable.Rows(i)("Diff_Minute") \ 3600).ToString,"-","")) = 1 Then
							DiffDisplay = "0" + Replace((DisplayTable.Rows(i)("Diff_Minute") \ 3600).ToString,"-","")
						Else
							DiffDisplay = Replace((DisplayTable.Rows(i)("Diff_Minute") \ 3600).ToString,"-","")
						End If
					End If
					If (displayTable.Rows(i)("Diff_Minute") mod 3600) \ 60 = 0 Then
			   			DiffDisplay += ":00"
					Else
						If LEN(Replace(((DisplayTable.Rows(i)("Diff_Minute") mod 3600) \ 60).ToString,"-","")) = 1 Then
							DiffDisplay += ":0" + Replace(((DisplayTable.Rows(i)("Diff_Minute") mod 3600) \ 60).ToString,"-","")
						Else
							DiffDisplay += ":" + Replace(((DisplayTable.Rows(i)("Diff_Minute") mod 3600) \ 60).ToString,"-","")
						End If
					End If
					If displayTable.Rows(i)("Diff_Minute") mod 60 = 0 Then
			   			DiffDisplay += ":00"
					Else
						If LEN(Replace((DisplayTable.Rows(i)("Diff_Minute") mod 60).ToString,"-","")) = 1 Then
							DiffDisplay += ":0" + Replace((DisplayTable.Rows(i)("Diff_Minute") mod 60).ToString,"-","")
						Else
							DiffDisplay += ":" + Replace((DisplayTable.Rows(i)("Diff_Minute") mod 60).ToString,"-","")
						End If
					End If
			   		outputString = outputString.Append("<td align=""center"" class=""" & TextClass & """>" &  DiffDisplay & "</td>")
				Else
					outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + "-" + "</td>")
				End If

			   outputString = outputString.Append("</tr>")   
			   
			Next
			ResultText.InnerHtml = outputString.ToString
			objDB.sqlExecute("Drop Table If Exists " + TableNameString, objCnn)
		End If
		
		
	End If
	
End Sub

Public Function DoroTransferDataLogReportForSaleData(ByVal dbUtil As CDBUtil, _
    ByVal objCnn As MySqlConnection, ByVal exportDataStartDate As String, ByVal exportDataToDate As String, _
    ByVal groupOfExportFromShopID As String, ByVal groupOfExportToShopID As String, _
    ByVal staffID As String, ByVal resultTableName As String, ByRef errorText As String) As Boolean
        Return DoroTransferDataLogReport(dbUtil, objCnn, exportDataStartDate, exportDataToDate, _
                groupOfExportFromShopID, groupOfExportToShopID, DATATYPE_SALE, staffID, resultTableName, errorText)
    End Function

    ' NOTE : exportDataToDate = ToDate + 1
    Public Function DoroTransferDataLogReport(ByVal dbUtil As CDBUtil, _
    ByVal objCnn As MySqlConnection, ByVal exportDataStartDate As String, ByVal exportDataToDate As String, _
    ByVal groupOfExportFromShopID As String, ByVal groupOfExportToShopID As String, ByVal dataType As String, _
    ByVal staffID As String, ByVal resultTableName As String, ByRef errorText As String) As Boolean
        Dim strSQL As String
        Dim startDate, endDate As Date
        Dim dtResult As DataTable

       ' Try
            'Temp table for Selected Session (Get Only Session That Close within SessionDate (Not Close from AutoCloseYesterDaySession)
            strSQL = "Drop Table If Exists SelectSessionForExportDataReport" & staffID & ";"
            dbUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Create Table If Not Exists SelectSessionForExportDataReport" & staffID & _
                    " (ProductLevelID int NOT NULL, SessionDate date NULL, CloseSessionDateTime datetime NULL); "
            dbUtil.sqlExecute(strSQL, objCnn)
            strSQL = "ALTER TABLE SelectSessionForExportDataReport" & staffID & " ADD INDEX " & _
                    " ProductLevelDateIndex (ProductLevelID, SessionDate);"
            dbUtil.sqlExecute(strSQL, objCnn)

            strSQL = "Insert INTO SelectSessionForExportDataReport" & staffID & "(ProductlevelID, SessionDate, CloseSessionDateTime) " & _
                     "Select ProductLevelID, SessionDate, Max(CloseSessionDateTime) " & _
                     "From Session " & _
                     "Where SessionDate >= " & exportDataStartDate & " AND SessionDate < " & exportDataToDate & " AND " & _
                     " CloseSessionDateTime > SessionDate AND CloseSessionDateTime < Date_Add(SessionDate, Interval 1 Day) "
            If groupOfExportFromShopID <> "" Then
                strSQL &= " AND ProductLevelID IN (" & groupOfExportFromShopID & ") "
            End If
            strSQL &= " Group by ProductLevelID, SessionDate "
            dbUtil.sqlExecute(strSQL, objCnn)

            'Temp table for Transfer Export Data (GroupTypeID = 1 For Export)
            strSQL = "Drop Table If Exists SelectExportDataLog" & staffID & ";"
            dbUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Create Table If Not Exists SelectExportDataLogReport" & staffID & _
                    " (DataType int NOT NULL, ExportDateTime datetime NULL, ExportDate date NULL, " & _
                    " FromShopID int NOT NULL, DestinationShopID int NOT NULL); "
            dbUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Insert INTO SelectExportDataLogReport" & staffID & "(DataType, ExportDateTime, ExportDate, " & _
                    " FromShopID, DestinationShopID) " & _
                    "Select DataType, LogDateTime, LogDateTime, FromShopID, DestinationShopID " & _
                    "From TransferDataLog " & _
                    "Where DataType IN (" & dataType & ") AND LogDateTime >= " & exportDataStartDate & " AND " & _
                    " LogDateTime < " & exportDataToDate & " AND GroupType = 1 "
			'errorMsg.InnerHtml = strSQL
			'Exit Function		
            If groupOfExportFromShopID <> "" Then
                strSQL &= " AND FromShopID IN (" & groupOfExportFromShopID & ") "
            End If
            If groupOfExportToShopID <> "" Then
                strSQL &= " AND DestinationShopID IN (" & groupOfExportToShopID & ") "
            End If
            dbUtil.sqlExecute(strSQL, objCnn)

            'Temp table for Summary Export Data Detail From SelectExportDataLogReport for create report
            strSQL = "Drop Table If Exists ExportDataLogSummary" & staffID & ";"
            dbUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Create Table If Not Exists ExportDataLogSummary" & staffID & _
                    " (DataType int NOT NULL DEFAULT '0', NoExportData int NOT NULL DEFAULT '0', LastExportDateTime datetime NULL, " & _
                    " ExportDate date NULL, FromShopID int NOT NULL DEFAULT '0', DestinationShopID int NOT NULL DEFAULT '0'); "
            dbUtil.sqlExecute(strSQL, objCnn)
            strSQL = "ALTER TABLE ExportDataLogSummary" & staffID & " ADD INDEX " & _
                        " ExportDataIndex (ExportDate, FromShopID);"
            dbUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Insert INTO ExportDataLogSummary" & staffID & "(DataType, NoExportData, LastExportDateTime, " & _
                " ExportDate,FromShopID, DestinationShopID) " & _
                "Select DataType, Count(*), Max(ExportDateTime), ExportDate, FromShopID, DestinationShopID " & _
                "From SelectExportDataLogReport" & staffID & " " & _
                "Group by DataType, ExportDate, FromShopID, DestinationShopID "
            dbUtil.sqlExecute(strSQL, objCnn)

            'Temp table for Dummy Date for Transfer Report Log
            strSQL = "Drop Table If Exists DummyDateForExportDataLog" & staffID & ";"
            dbUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Create Table If Not Exists DummyDateForExportDataLog" & staffID & _
                    " (StartDate date, EndDate date); "
            dbUtil.sqlExecute(strSQL, objCnn)
            'Get Start And EndDate
            strSQL = "Insert INTO DummyDateForExportDataLog" & staffID & "(StartDate, EndDate) " & _
                     "VALUES(" & exportDataStartDate & ", " & exportDataToDate & ")"
            dbUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Select * From DummyDateForExportDataLog" & staffID
            dtResult = dbUtil.List(strSQL, objCnn)
            startDate = dtResult.Rows(0)("StartDate")
            endDate = dtResult.Rows(0)("EndDate")
            'Insert Dummy Data
            strSQL = "Drop Table If Exists DummyDateForExportDataLog" & staffID & ";"
            dbUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Create Table If Not Exists DummyDateForExportDataLog" & staffID & _
                    " (ExportDataDate date NULL, ProductLevelID int NOT NULL, ProductLevelCode varchar(20) NULL, " & _
                    " ProductLevelName varchar(50) NULL, ProductLevelOrder int NOT NULL); "
            dbUtil.sqlExecute(strSQL, objCnn)
            strSQL = "ALTER TABLE DummyDateForExportDataLog" & staffID & " ADD INDEX " & _
                    " ExportDataIndex (ExportDataDate, ProductLevelID);"
            dbUtil.sqlExecute(strSQL, objCnn)
            Do While startDate < endDate
                strSQL = "Insert INTO DummyDateForExportDataLog" & staffID & "(ExportDataDate, ProductLevelID, " & _
                         " ProductLevelCode, ProductLevelName, ProductLevelOrder) " & _
                         "Select " & FormatDateForMySQL(startDate) & ", ProductLevelID, ProductLevelCode, " & _
                         " ProductLevelName, ProductLevelOrder " & _
                         "From ProductLevel "
                If groupOfExportFromShopID <> "" Then
                    strSQL &= " Where ProductLevelID IN (" & groupOfExportFromShopID & ") "
                Else
                    strSQL &= "Where IsShop = 1 AND ProductLevelID <> 1 "
                End If
                dbUtil.sqlExecute(strSQL, objCnn)

                startDate = startDate.AddDays(1)
            Loop

            'Create Report Temp Table
            strSQL = "Drop Table If Exists " & resultTableName & ";"
            dbUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Create Table If Not Exists " & resultTableName & _
                    " (ProductLevelID int NOT NULL DEFAULT '0', ProductLevelCode varchar(20) NULL, " & _
                    " ProductLevelName varchar(50) NULL, ProductLevelOrder int NOT NULL DEFAULT '0', ExportDate date NULL, " & _
                    " CloseLastSessionDateTime datetime NULL, NoExportData int NOT NULL DEFAULT '0', LastExportDateTime datetime NULL, " & _
                    " ExportToShopID int NOT NULL DEFAULT '0', DataType int NOT NULL DEFAULT '0'); "
            dbUtil.sqlExecute(strSQL, objCnn)
            strSQL = "ALTER TABLE " & resultTableName & " ADD INDEX " & _
                    " ExportDataDateIndex (ExportDate, ProductLevelID);"
            dbUtil.sqlExecute(strSQL, objCnn)

            strSQL = "Insert INTO " & resultTableName & "(ProductLevelID, ProductLevelCode, ProductLevelName, " & _
                    " ProductLevelOrder, ExportDate, CloseLastSessionDateTime, NoExportData, LastExportDateTime, " & _
                    " ExportToShopID, DataType)" & _
                    "Select dd.ProductLevelID, dd.ProductLevelCode, dd.ProductLevelName, dd.ProductLevelOrder, " & _
                    " dd.ExportDataDate, ss.CloseSessionDateTime, IF(el.NoExportData is NULL,0,el.NoExportData), el.LastExportDateTime, " & _
                    " IF(el.DestinationShopID is NULL,0,el.DestinationShopID), IF(el.DataType is NULL,0,el.DataType) " & _
                    "From DummyDateForExportDataLog" & staffID & " dd LEFT OUTER JOIN " & _
                    " SelectSessionForExportDataReport" & staffID & " ss ON dd.ProductLevelID = ss.ProductLevelID AND " & _
                    " dd.ExportDataDate = ss.SessionDate " & _
                    " LEFT OUTER JOIN ExportDataLogSummary" & staffID & " el ON el.FromShopID = dd.ProductLevelID AND " & _
                    " el.ExportDate = dd.ExportDataDate "
            dbUtil.sqlExecute(strSQL, objCnn)
       ' Catch ex As Exception
          '  errorText = ex.ToString
         '   Return False
        'End Try

        strSQL = "Drop Table If Exists SelectSessionForExportDataReport" & staffID & ";"
        dbUtil.sqlExecute(strSQL, objCnn)
        strSQL = "Drop Table If Exists SelectExportDataLogReport" & staffID & ";"
        dbUtil.sqlExecute(strSQL, objCnn)
        strSQL = "Drop Table If Exists ExportDataLogSummary" & staffID & ";"
        dbUtil.sqlExecute(strSQL, objCnn)
        strSQL = "Drop Table If Exists DummyDateForExportDataLog" & staffID & ";"
        dbUtil.sqlExecute(strSQL, objCnn)

        Return True

    End Function
	
	Public Function FormatDateForMySQL(ByVal dt As Date) As String
        Dim DateString As String
        Dim InvC As System.Globalization.CultureInfo = System.Globalization.CultureInfo.InvariantCulture
        DateString = "{ d '" + dt.ToString("yyyy-MM-dd", InvC) + "' }"
        Return DateString
    End Function

Private Sub Results_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) 
	
	If e.Item.ItemType = ListItemType.Header Then
		e.Item.Cells(0).Text = "From Table"
		e.Item.Cells(1).Text = "To Table"
		e.Item.Cells(2).Text = "Opt Code"
		e.Item.Cells(3).Text = "Product Name"
		e.Item.Cells(4).Text = "Org Qty"
		e.Item.Cells(5).Text = "Move Qty"
	End If
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub
     
</script>
</body>
</html>
