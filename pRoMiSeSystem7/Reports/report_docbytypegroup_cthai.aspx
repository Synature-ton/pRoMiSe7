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
<%@Import Namespace="CostingClass.pRoMiSeCosting" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Document Type Group Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="../StyleSheet/webscript.js"></script> 
</head>
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelDocGroupName" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<input type="hidden" id="ShopIDList" runat="server" />
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
<div class="noprint"><span id="showShop" runat="server">
<table>
<tr id="ShowDocGroup" runat="server">
	<td valign="top">
		<table>
			<tr>
				<td><span id="ShopText" runat="server"></span></td>
			</tr>
			<tr>
				<td><span id="DocGroupText" runat="server"></span></td>
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
<br></span>
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
		<span id="Header1" runat="server"></span>
		<span id="ExtraHeader" runat="server"></span>
		<span id="Header2" runat="server"></span>
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
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim FormatHeader As New FormatText()
Dim CostInfo As New CostClass()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer  = 998
		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_StockByTypeGroup") Then
		
	'Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString

		showHeader.Visible = False
		Dim i As Integer
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
		
		LangText0.Text = "Document By Document Group Reports"
		
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
		MonthYearDate.Lang_Data = LangDefault
		MonthYearDate.Culture = CultureString
		
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
		End If

		Dim DocumentTypeGroupID As Integer = -1
		If IsNumeric(Request.Form("DocumentTypeGroupID")) Then
			DocumentTypeGroupID = Request.Form("DocumentTypeGroupID")
		Else If IsNumeric(Request.QueryString("DocumentTypeGroupID"))
			DocumentTypeGroupID = Request.QueryString("DocumentTypeGroupID")
		End If
			
		
		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		Dim Multiple As Boolean = False
		Dim DocTypeGroup As DataTable = getInfo.DocumentTypeGroup(1,0,objCnn)
		If DocTypeGroup.Rows.Count > 0 Then

			outputString = "<select name=""DocumentTypeGroupID"">"
			If DocTypeGroup.Rows.Count > 1 Then
				If Not Page.IsPostBack Then 
					FormSelected = "selected"
				ElseIf DocumentTypeGroupID = -1 Then
					FormSelected = "selected"
				Else
					FormSelected = ""
				End If
				outputString += "<option value=""" & "-1" & """ " & FormSelected & ">" & "--- Please Select Group ---"
			End If
			If DocumentTypeGroupID = 0 Then
				FormSelected = "selected"
			Else
				FormSelected = ""
			End If
			outputString += "<option value=""0"" " & FormSelected & ">" & "Beginning Stock Document"
			For i = 0 to DocTypeGroup.Rows.Count - 1
				If DocumentTypeGroupID = DocTypeGroup.Rows(i)("DocumentTypeGroupID") Then
					FormSelected = "selected"
				Else
					FormSelected = ""
				End If
				outputString += "<option value=""" & DocTypeGroup.Rows(i)("DocumentTypeGroupID") & """ " & FormSelected & ">" & DocTypeGroup.Rows(i)("GroupName")
			Next
			outputString += "</select>"
			DocGroupText.InnerHtml = outputString
			ShowDocGroup.Visible = True
		Else
			ShowDocGroup.Visible = False
		End If
		
		Dim ShopIDValue As String = "0"
		If IsNumeric(Request.Form("ShopID")) Then
			ShopIDValue = Request.Form("ShopID").ToString
		Else If IsNumeric(Request.QueryString("ShopID"))
			ShopIDValue = Request.QueryString("ShopID").ToString
		End If
		
		Dim ShopList As String = ""
		Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-99,Session("StaffRole"),objCnn)
		If ShopData.Rows.Count > 0 Then

			outputString = "<select name=""ShopID"">"
			
			If ShopData.Rows.Count > 1 Then
				If Not Page.IsPostBack Then 
					FormSelected = "selected"
					SelShopName.Value = "All Shops"
				ElseIf ShopIDValue = "0" Then
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
	Dim SelMonth,SelYear As Integer
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
		SelMonth = StartMonthValue
		SelYear = StartYearValue
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
		
		SelMonth = Request.Form("Doc_Month")
		SelYear = Request.Form("Doc_Year")
		
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
		
		SelMonth = Request.Form("DocDaily_Month")
		SelYear = Request.Form("DocDaily_Year")

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

	
	Dim TD1 As Boolean = True
	Dim TD2 As Boolean = True
	Dim TD3 As Boolean = True
	Dim TD4 As Boolean = True
	Dim TD5 As Boolean = True
	Dim TD6 As Boolean = True
	Dim TD7 As Boolean = True
	
	Dim Text_5 As String = "Document No."
	Dim Text_2 As String = "Remark"
	Dim Text_1 As String = "Document Date"
	Dim Text_3 As String = "Inventory"
	Dim Text_6 As String  = "To Inv"
	Dim Text_7 As String = "From Inv"
	Dim MGroupData As DataTable = getInfo.GetMaterialGroup(1,0,objCnn)
	Dim i As integer
	Dim HeaderString As String = ""
	For i = 0 To MGroupData.Rows.Count - 1
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + MGroupData.Rows(i)("MaterialGroupName") + "</td>"
	Next
	ExtraHeader.InnerHtml = HeaderString
	Dim Text_4 As String = "Total Cost"
		
	If Request.Form("DocumentTypeGroupID") < 0 Then
		FoundError = True
	End If	
	If FoundError = False Then
		If LangDefault.Rows.Count >= 3 Then
			CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(NOW(), "DateAndTime",Session("LangID"),objCnn)
		End If
		Dim displayTable As New DataTable()
		
		ShowHeader.Visible = True
		ShowPrint.Visible = True
		
		Dim ViewOption As Integer = 1
		Dim TableNameString As String = "DummyMaterialCostTable" 'Session.SessionID
		
		Application.Lock()
		Dim dtTable As DataTable = DocumentByGroupReport(TableNameString,Request.Form("ShopID"),Request.Form("DocumentTypeGroupID"), StartDate, EndDate, SelMonth, SelYear, Session("LangID"), "", objCnn)
		Application.UnLock()
		
		Dim CostInfo As New DataTable
		CostInfo = getInfo.GetProductLevel(Request.Form("ShopID"), objCnn)

		Dim CalculateFromShopID As Integer = 0

		If CostInfo.Rows(0)("CalculateCostType") > 0 Then
			CalculateFromShopID = CostInfo.Rows(0)("CalculateCostType")
		End If
		
		Dim DocGroupData As DataTable = getInfo.DocumentTypeGroup(0,Request.Form("DocumentTypeGroupID"),objCnn)
		Dim DocGroupDisplay As String
		If DocGroupData.Rows.Count = 0 Then
			DocGroupDisplay = ""
		Else
			DocGroupDisplay = DocGroupData.Rows(0)("GroupName")
		End If
		ResultSearchText.InnerHtml = "Report of " + DocGroupDisplay + " (" + ReportDate + ")"

		Dim TextClass As String = "smallText"

		Dim j,k As Integer
		Dim DocHeader As String = ""
		Dim KeyString As String = ""
		Dim BeforeKeyString As String = "0"
		
		Dim ShopData As DataTable
		If Request.Form("DocumentTypeGroupID") = 3 Or Request.Form("DocumentTypeGroupID") = 11 Then
			ShopData = objDB.List("SELECT count(*),ToInvID AS ProductLevelID,ToProductLevelName AS ProductLevelName from " + TableNameString + " group by ToInvID,ToProductLevelName order by ToInvID", objCnn)
		Else
			ShopData = objDB.List("SELECT count(*),ProductLevelID,ProductLevelName,ProductLevelOrder from " + TableNameString + " group by ProductLevelID,ProductLevelName,ProductLevelOrder order by ProductLevelOrder, ProductLevelID", objCnn)
		End If

		Dim DocData As DataTable
		'Dim MGroupData As DataTable
		Dim DocDetailData As DataTable
		
		'MGroupData = getInfo.GetMaterialGroup(1,0,objCnn)
		
		Dim SumEachLine As Double
		Dim SumShop As Double
		Dim SumGroup(MGroupData.Rows.Count - 1) As Double
		Dim SumGrandTotalGroup(MGroupData.Rows.Count - 1) As Double
		outputString = ""
		Dim ProductCost As Double
		Dim InvString As String
		Dim ColSpanVal As String
		Dim ShowFromInv As Boolean
		Dim ShowToInv As Boolean
		For i = 0 To ShopData.Rows.Count - 1
			SumShop = 0
			If Request.Form("DocumentTypeGroupID") = 3 Or Request.Form("DocumentTypeGroupID") = 11 Or Request.Form("DocumentTypeGroupID") = 1000 Then
				DocData = objDB.List("select count(*),ShopID,DocumentID,DocumentTypeID,DocumentTypeName,ProductLevelName,ToProductLevelName,DocumentDate,DocumentYear,DocumentMonth,DocumentNumber,ApproveStaff,Remark,FromProductLevelName from " + TableNameString + " where ToInvID=" + ShopData.Rows(i)("ProductLevelID").ToString + " group by ShopID,DocumentID,DocumentTypeID,ProductLevelName,ToProductLevelName,DocumentDate,DocumentYear,DocumentMonth,DocumentNumber,ApproveStaff,DocumentTypeName,Remark Order By DocumentTypeID,DocumentYear,DocumentMonth,DocumentNumber", objCnn)
			Else
				DocData = objDB.List("select count(*),ShopID,DocumentID,DocumentTypeID,DocumentTypeName,ProductLevelName,ToProductLevelName,DocumentDate,DocumentYear,DocumentMonth,DocumentNumber,ApproveStaff,Remark,FromProductLevelName from " + TableNameString + " where ProductLevelID=" + ShopData.Rows(i)("ProductLevelID").ToString + " group by ShopID,DocumentID,DocumentTypeID,ProductLevelName,ToProductLevelName,DocumentDate,DocumentYear,DocumentMonth,DocumentNumber,ApproveStaff,DocumentTypeName,Remark,FromProductLevelName Order By DocumentTypeID,DocumentYear,DocumentMonth,DocumentNumber", objCnn)
			End If
			For j = 0 To DocData.Rows.Count - 1
				outputString += "<tr>"
				
				DocHeader = FormatHeader.DocumentNumber(DocData.Rows(j)("ShopID"),DocData.Rows(j)("DocumentTypeID"),DocData.Rows(j)("DocumentID"),Session("LangID"), GlobalParam.YearType, objCnn)
				
				outputString += "<td align=""center"" class=""" + TextClass + """>" & DateTimeUtil.FormatDateTime(DocData.Rows(j)("DocumentDate"), "DateOnly") & "</td>"
				
				outputString += "<td align=""left"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( '../Inventory/document_detail.aspx?MaterialID=" + "0" + "&SelMonth=0&SelYear=0&DocumentID=" & DocData.Rows(j)("DocumentID").ToString & "&ShopID=" & DocData.Rows(j)("ShopID").ToString & "&ProductLevelID=" & DocData.Rows(j)("ShopID").ToString + "', '', 'width=800,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & DocHeader & "</a>" & "<br>(" & DocData.Rows(j)("DocumentTypeName") & ")</td>"
				
				If Not IsDBNull(DocData.Rows(j)("Remark")) Then
					outputString += "<td align=""left"" class=""" + TextClass + """>" & DocData.Rows(j)("Remark") & "</td>"
				Else
					outputString += "<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>"
				End if
				
				InvString = ""
				ShowFromInv = True
				ShowToInv = True
				If DocData.Rows(j)("DocumentTypeID") = 2 Or DocData.Rows(j)("DocumentTypeID") = 39 Or DocData.Rows(j)("DocumentTypeID") = 1001 Or DocData.Rows(j)("DocumentTypeID") = 47 Or DocData.Rows(j)("DocumentTypeID") = 25 Then
					If DocData.Rows(j)("DocumentTypeID") = 2 Or DocData.Rows(j)("DocumentTypeID") = 39 Then
						ShowFromInv = False
					End If
					ShowToInv = False
				ElseIf DocData.Rows(j)("DocumentTypeID") = 3 Or DocData.Rows(j)("DocumentTypeID") = 46 Or DocData.Rows(j)("DocumentTypeID") = 1000 Then
					ShowFromInv = False
				Else
					ShowFromInv = False
					ShowToInv = False
				End If
				
				If Not IsDBNull(DocData.Rows(j)("FromProductLevelName")) AND ShowFromInv = True Then
					If DocData.Rows(j)("DocumentTypeID") = 2 Or DocData.Rows(j)("DocumentTypeID") = 39 Then
						'outputString += "<td align=""center"" class=""" + TextClass + """>" & "-" & "</td>"
					Else
						outputString += "<td align=""center"" class=""" + TextClass + """>" & DocData.Rows(j)("FromProductLevelName") & "</td>"
					End If
					TD7 = True
				Else
					TD7 = False
				End If
				
				If Not IsDBNull(DocData.Rows(j)("ProductLevelName")) Then
					outputString += "<td align=""center"" class=""" + TextClass + """>" & DocData.Rows(j)("ProductLevelName") & "</td>"
					TD3 = True
				Else
					TD3 = False
				End If
				
				If Not IsDBNull(DocData.Rows(j)("ToProductLevelName")) AND ShowToInv = True Then
					outputString += "<td align=""center"" class=""" + TextClass + """>" & DocData.Rows(j)("ToProductLevelName") & "</td>"
					TD6 = True
				Else
					TD6 = False
				End If
				
				
				Dim TestString as string
				SumEachLine = 0
				For k = 0 To MGroupData.Rows.Count - 1
					DocDetailData = objDB.List("select * from " + TableNameString + " where DocumentID=" + DocData.Rows(j)("DocumentID").ToString + " AND ShopID=" + DocData.Rows(j)("ShopID").ToString + " AND MaterialGroupID=" + MGroupData.Rows(k)("MaterialGroupID").ToString, objCnn)
					If DocDetailData.Rows.Count > 0 Then
						If DocDetailData.Rows(0)("ProductLevelID") = CalculateFromShopID AND ((Request.Form("DocumentTypeGroupID") = 0 Or Request.Form("DocumentTypeGroupID") = 1) OR (DocDetailData.rows(0)("UseAvgCost") = 0)) Then
							If Not IsDBNull(DocDetailData.Rows(0)("TotalNetPrice")) Then
								ProductCost = DocDetailData.Rows(0)("TotalNetPrice")
							Else
								ProductCost = 0
							End If
						Else
							If Not IsDBNull(DocDetailData.Rows(0)("TotalDocPrice")) Then
								ProductCost = DocDetailData.Rows(0)("TotalDocPrice")
							Else
								ProductCost = 0
							End If
						End If
						TestString = DocDetailData.Rows(0)("ProductLevelID").ToString + "::" + CalculateFromShopID.ToString + "/" + Request.Form("DocumentTypeGroupID").ToString
						If ProductCost = 0 Then
							outputString += "<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>"
						Else
							outputString += "<td align=""right"" class=""" + TextClass + """>" & ProductCost.ToString(FormatObject.AccountingFormat, ci) & "</td>"
						End If
						SumEachLine += ProductCost
						SumGroup(k) += ProductCost
						SumGrandTotalGroup(k) += ProductCost
					Else
						outputString += "<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>"
					End If
				Next
				outputString += "<td align=""right"" class=""" + TextClass + """>" & SumEachLine.ToString(FormatObject.AccountingFormat, ci)  & "</td>"
				outputString += "</tr>"
				SumShop += SumEachLine
			Next
			Dim ColVal As Integer

			ColVal = 4
			If ShowFromInv = True Then ColVal += 1
			If ShowToInv = True Then ColVal += 1
			ColSpanVal = ColVal.ToString
			outputString += "<tr>"
			outputString += "<td align=""right"" colspan=""" + ColSpanVal + """ bgColor=""" + GlobalParam.GrayBGColor + """ class=""" + TextClass + """>" & "Summary for " + ShopData.Rows(i)("ProductLevelName") & "</td>"
			For k = 0 To MGroupData.Rows.Count - 1
				outputString += "<td align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """  class=""" + TextClass + """>" & SumGroup(k).ToString(FormatObject.AccountingFormat, ci)  & "</td>"
				SumGroup(k) = 0
			Next
			outputString += "<td align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """  class=""" + TextClass + """>" & SumShop.ToString(FormatObject.AccountingFormat, ci)  & "</td>"
			outputString += "</tr>"
		Next
		If ShopData.Rows.Count >  1 Then
			Dim ColSpan As Integer
			If TD7 = True Then
				ColSpan = 7 + MGroupData.Rows.Count
			Else
				ColSpan = 6 + MGroupData.Rows.Count
			End If
			outputString += "<tr><td height=""10"" colspan=""" + ColSpan.ToString + """></td></tr>"
			outputString += "<tr>"
			outputString += "<td align=""right"" colspan=""" + ColSpanVal + """ bgColor=""" + GlobalParam.GrayBGColor + """ class=""" + TextClass + """>" & "Grand Total" & "</td>"
			For k = 0 To MGroupData.Rows.Count - 1
				outputString += "<td align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """  class=""" + TextClass + """>" & SumGrandTotalGroup(k).ToString(FormatObject.AccountingFormat, ci)  & "</td>"
				grandTotal += SumGrandTotalGroup(k)
			Next
			outputString += "<td align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """  class=""" + TextClass + """>" & grandTotal.ToString(FormatObject.AccountingFormat, ci)  & "</td>"
			outputString += "</tr>"
		End If
		ResultText.InnerHtml = outputString
		
		Dim ExportData As String = ""
		Dim ExportData1 As String = ""
		If TD1 = True Then
			ExportData += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + Text_1 + "</td>"
		End If
		If TD5 = True Then
			ExportData += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + Text_5 + "</td>"
		End If
		If TD2 = True Then
			ExportData += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + Text_2 + "</td>"
		End If
		If TD7 = True Then
			ExportData += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + Text_7 + "</td>"
		End If
		If TD3 = True Then
			ExportData += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + Text_3 + "</td>"
		End If
		If TD6 = True Then
			ExportData += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + Text_6 + "</td>"
		End If
		If TD4 = True Then
			ExportData1 += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + Text_4 + "</td>"
		End If
		
		Header1.InnerHtml = ExportData
		Header2.InnerHtml = ExportData1
		
		Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & ExportData & ExtraHeader.InnerHtml & ExportData1 & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"
		
		objDB.sqlExecute("Drop Table If Exists " + TableNameString, objCnn)
	End If
	
End Sub

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "DocumentTypeData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub

 Public Function DocumentByGroupReport(ByVal TableNameString As String, ByVal ShopID As Integer, ByVal DocumentTypeGroupID As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal SelMonth As Integer, ByVal SelYear As Integer, ByVal LangID As Integer, ByVal OrderByString As String, ByVal objCnn As MySqlConnection) As DataTable

        Dim sqlStatement, AdditionalQuery As String
		Dim strUseAvgCost As String
        '------- Calculate Material Standard Cost
        Dim StdTable As String = TableNameString + "_Std"
        CostInfo.MaterialStdCost(StdTable, SelMonth, SelYear, ShopID, objCnn)

        If LangID > 0 And IsNumeric(LangID) Then
            AdditionalQuery += " AND a.LangID=" + LangID.ToString
        End If

        If ShopID > 0 Then
            AdditionalQuery += " AND b.ProductLevelID=" + ShopID.ToString
        End If

        If DocumentTypeGroupID > 0 Then
            Dim dtTable As DataTable = objDB.List("select DocumentTypeID from DocumentTypeGroupValue where DocumentTypeGroupID=" + DocumentTypeGroupID.ToString, objCnn)
            Dim i As Integer
            Dim DocTypeIDList As String = ""
            For i = 0 To dtTable.Rows.Count - 1
                DocTypeIDList += "," + dtTable.Rows(i)("DocumentTypeID").ToString
            Next
            If DocTypeIDList <> "" Then
                AdditionalQuery += " AND a.DocumentTypeID IN (-999" + DocTypeIDList + ")"
            Else
                AdditionalQuery += " AND a.DocumentTypeID IN (-999)"
            End If
            dtTable = objDB.List("select UseAvgCost from DocumentTypeGroup where DocumentTypeGroupID=" + DocumentTypeGroupID.ToString, objCnn)
            If dtTable.Rows.Count = 0 Then
                strUseAvgCost = ",1 as UseAvgCost"
            Else
                strUseAvgCost = "," & dtTable.Rows(0)("UseAvgCost") & " as UseAvgCost "
            End If
		ElseIf DocumentTypeGroupID = 0 Then
            AdditionalQuery += " AND a.DocumentTypeID IN (10)"
            strUseAvgCost = ",0 as UseAvgCost "
        Else
            strUseAvgCost = ",0 as UseAvgCost "
		End If

        If OrderByString = "" Then
            OrderByString = " Order By pl.ProductLevelOrder,pl.ProductLevelID,a.DocumentTypeID,b.DocumentDate,DocumentYear,DocumentMonth,DocumentNumber,mg.MaterialGroupID"
        End If
        sqlStatement = " select CONCAT(s.StaffFirstName,' ',s.StaffLastName) AS ApproveStaff,CONCAT(s1.StaffFirstName,' ',s1.StaffLastName) AS InputStaff,a.DocumentTypeName,a.DocumentTypeID,b.DocumentDate,b.DocumentMonth,b.DocumentYear,b.DocumentNumber, b.DocumentID,b.ShopID, b.Remark,b.ProductLevelID,b.ToInvID,pl2.ProductLevelName AS ToProductLevelName,fp.ProductLevelID AS FromProductLevelID,fp.ProductLevelName AS FromProductLevelName,pl.ProductLevelName,pl.ProductLevelOrder,mg.MaterialGroupID,mg.MaterialGroupName,b.VendorID,b.VendorGroupID,b.VendorShopID,v.VendorName,SUM(a.MovementInStock*c.UnitSmallAmount*std.TotalPrice/std.TotalAmount) AS TotalDocPrice, SUM(a.MovementInStock*c.ProductNetPrice) AS TotalNetPrice" + strUseAvgCost + " from documenttype a inner join document b ON a.DocumentTypeID=b.DocumentTypeID AND a.ShopID=b.ShopID inner join docdetail c ON b.DocumentID=c.DocumentID AND b.ShopID=c.ShopID left outer join materials m ON c.ProductID=m.MaterialID left outer join " + StdTable + " std ON c.ProductID=std.MaterialID left outer join UnitSmall d ON c.ProductUnit=d.UnitSmallID left outer join Vendors v ON b.VendorID=v.VendorID AND b.VendorGroupID=v.VendorGroupID AND b.VendorShopID=v.ShopID left outer join Staffs s ON b.ApproveBy=s.StaffID left outer join Staffs s1 ON b.InputBy=s1.StaffID left outer join ProductLevel pl ON b.ProductLevelID=pl.ProductLevelID left outer join MaterialDept md ON m.MaterialDeptID=md.MaterialDeptID left outer join MaterialGroup mg ON md.MaterialGroupID=mg.MaterialGroupID left outer join ProductLevel pl2 ON b.ToInvID=pl2.ProductLevelID left outer join Document aa ON b.DocumentIDRef=aa.DocumentID AND b.DocIDRefShopID=aa.ShopID left outer join ProductLevel fp ON aa.ProductLevelID=fp.ProductLevelID where b.DocumentStatus=2 AND b.DocumentDate >= " + StartDate + " AND b.DocumentDate < " + EndDate + AdditionalQuery + " group by a.DocumentTypeID,b.DocumentDate,b.DocumentMonth,b.DocumentYear,b.DocumentNumber, b.DocumentID,b.ShopID,b.ProductLevelID,b.ToInvID,pl2.ProductLevelName,pl.ProductLevelName,b.VendorID,b.VendorGroupID,b.VendorShopID,v.VendorName,mg.MaterialGroupID,mg.MaterialGroupName " ' + OrderByString

        objDB.sqlExecute("Drop Table If Exists " + TableNameString, objCnn)
        objDB.sqlExecute("create table if not exists " + TableNameString + " (ApproveStaff varchar(200), InputStaff varchar(200), DocumentTypeName varchar(200), DocumentTypeID int, DocumentDate datetime, DocumentMonth smallint, DocumentYear smallint, DocumentNumber int, DocumentID int, ShopID int, Remark varchar(255), ProductLevelID int, ToInvID int, ToProductLevelName varchar(200), FromProductLevelID int, FromProductLevelName varchar(200), ProductLevelName varchar(200), ProductLevelOrder int, MaterialGroupID int, MaterialGroupName varchar(200), VendorID int, VendorGroupID int, VendorShopID int, VendorName varchar(200), TotalDocPrice decimal(18,4), TotalNetPrice decimal(18,4), UseAvgCost tinyint)", objCnn)

        objDB.sqlExecute("insert into " + TableNameString + sqlStatement, objCnn)


    End Function
		
Sub Page_UnLoad()
	objCnn.Close()
End Sub
</script>
</body>
</html>
