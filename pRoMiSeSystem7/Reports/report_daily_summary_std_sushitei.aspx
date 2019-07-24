<%@ Page Language="VB" ContentType="text/html" EnableViewState="false" debug="True" %>
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
<title>Daily Sales Report</title>
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
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Daily Sales Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
				<td><span id="ReceiptTypeText" runat="server"></span></td>
			</tr>
			<tr>
				<td><span id="ShopText" runat="server"></span></td>
			</tr><span id="Display" visible="false" runat="server">
			<tr>
				<td><asp:radiobutton ID="Radio_11" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
			<tr>
				<td><asp:radiobutton ID="Radio_12" GroupName="Group2" Checked="true" CssClass="text" runat="server" /></td>
			</tr>
			<tr>
				<td><asp:radiobutton ID="Radio_13" GroupName="Group2" CssClass="text" runat="server" />
				<asp:dropdownlist ID="GroupByParam" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
			</tr></span>
			<tr>
				<td><asp:CheckBox ID="ShowGroup" CssClass="text" runat="server"></asp:CheckBox></td>
			</tr>

		</table></td>
	<td valign="top">
	<table>
		<tr>
		<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="DailyDate" runat="server" /></td>
		<td colspan="2"><asp:CheckBox ID="ExpandReceipt" Visible="false" CssClass="text" Checked="false" runat="server" /></td>
		</tr>
		<tr id="SelMonth" visible="false" runat="server">
		<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
		<td colspan="3"><synature:date id="MonthYearDate" runat="server" /></td>
		</tr>
		<tr id="showYear" visible="false" runat="server">
		<td><asp:radiobutton ID="Radio_4" GroupName="Group1" runat="server" /></td>
		<td colspan="3"><synature:date id="YearDate" runat="server" /></td>
		</tr>
		<tr id="showRange" visible="false" runat="server">
		<td><asp:radiobutton ID="Radio_2" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="CurrentDate" runat="server" /></td>
		<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
		<td><synature:date id="ToDate" runat="server" /></td>
	</tr>
	
	</table>
	</td>
    <td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" />&nbsp;<asp:CheckBox ID="DisplayGraph" CssClass="text" Visible="false" Checked="false" runat="server" /></td>
</tr>
</table>
</div>

<div id="showResults" visible="false" runat="server">
<span id="MyTable">
<table><tr><td colspan="3">
<table width="100%">

<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr>

<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>

</table></td></tr>
<tr><td valign="top">
<span id="startTable" runat="server"></span>

	<tr>
		<span id="TableHeaderText" runat="server"></span>
		<span id="ExtraHeader" runat="server"></span>
	</tr>
	
	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>

<asp:Panel ID="showGraph" Visible="false" runat="server">
<br>
<Web:ChartControl id="ChartControl1" ChartPadding=40 runat="Server" />
</asp:Panel></span>
<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table>
</td>
<td valign="top">
<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
<span id="ResultText2" runat="server" />
</table>
</td>

<td valign="top">
<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
<span id="ResultText3" runat="server" />
</table>
</td>

</tr></table>
</div>
</form>
</div>
<div id="errorMsg1" runat="server" />
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
Dim Fm As New UtilityFunction()
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
	If User.Identity.IsAuthenticated  AND Session("DailySalesStd") Then
		
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
		
		DocumentToDateParam.InnerHtml =LangDefault.Rows(22)(LangText)
		
		ShowGroup.Text = "Group By Product Group"
		ShowGroup.Visible = False

		StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		
		Dim HeaderString As String = ""
		
		'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Description" + "</td>"
		'HeaderString += "<td width=""100"" align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Amount" + "</td>"
		
		'TableHeaderText.InnerHtml = HeaderString
		
		GroupByParam.Items(0).Text = "Group By Day of Week"
		GroupByParam.Items(0).Value = "1"
		GroupByParam.Items(1).Text = "Group By Time"
		GroupByParam.Items(1).Value = "2"
		
		If Request.Form("ShopID") = 0 Then
			If Radio_11.Checked = True Then
				'Text1.InnerHtml  = "Shop Name"
			End If
			
		End If
		ExpandReceipt.Text = "Show Receipt Details"
		DisplayGraph.Text = "Display Graph for Monthly Report and Date Range Report"
			
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
		
		If IsNumeric(Request.Form("YearDate_Year")) Then 
			Session("YearDate_Year") = Request.Form("YearDate_Year")
		Else If IsNumeric(Request.QueryString("YearDate_Year")) Then 
			Session("YearDate_Year") = Request.QueryString("YearDate_Year")
		Else If Trim(Session("YearDate_Year")) = "" Then
			Session("YearDate_Year") = DateTime.Now.Year
		Else If Trim(Session("YearDate_Year")) = 0 And Not Page.IsPostBack Then
			Session("YearDate_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("YearDate_Year") = "" Then Session("YearDate_Year") = 0
		YearDate.SelectedYear = Session("YearDate_Year")
		
		If Not Page.IsPostBack Then
			Radio_3.Checked = True
			Radio_11.Checked = True
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
		Dim ShopList As String = ""
		
		Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
		If ShopData.Rows.Count > 0 Then
			outputString = "<select name=""ShopID"">"
			'If ShopData.Rows.Count > 1 Then
			'	If Not Page.IsPostBack Then 
			'		FormSelected = "selected"
			'		SelShopName.Value = "All Shops"
			'	ElseIf ShopIDValue = 0 Then
			'		FormSelected = "selected"
			'		SelShopName.Value = "All Shops"
			'	Else
			'		FormSelected = ""
			'	End If
			'	outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & "--- All Shops ---"
			'End If
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

		'Load Receipt Type Combo
		Dim ReceiptTypeValue As String = "1"
		If IsNumeric(Request.Form("ReceiptType")) Then
			ReceiptTypeValue = Request.Form("ReceiptType").ToString
		Else If IsNumeric(Request.QueryString("ReceiptType"))
			ReceiptTypeValue = Request.QueryString("ReceiptType").ToString
		End If
		Select Case Cint(ReceiptTypeValue)
			Case > 3
				ReceiptTypeValue = "1"
			Case <= 0 
				ReceiptTypeValue = "1"
		End Select 
		outputString = "<select name=""ReceiptType"">"
		If ReceiptTypeValue = "1" Then
			FormSelected = "selected"
		Else
			FormSelected = ""
		End If
		outputString += "<option value=""" & "1" & """ " & FormSelected & ">" & "Sale"
		If ReceiptTypeValue = "2" Then
			FormSelected = "selected"
		Else
			FormSelected = ""
		End If
		outputString += "<option value=""" & "2" & """ " & FormSelected & ">" & "Non Sale"
		If ReceiptTypeValue = "3" Then
			FormSelected = "selected"
		Else
			FormSelected = ""
		End If
		outputString += "<option value=""" & "3" & """ " & FormSelected & ">" & "Sale + Non Sale"
		ReceiptTypeText.InnerHtml = outputString	
				
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
	
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""
	Dim DailyDateValue As String = ""
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
	Dim outputString As String = ""
	Dim grandTotal As Double = 0
	Dim VATTotal As Double = 0
	Dim GraphData As New DataSet()
	Dim ReportDate As String
	Dim YearValue4 As Integer
	Dim BeginDay As String
	Dim NoDay As Integer = 1
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
		
		BeginDay = DateTimeUtil.FormatDate(1,Request.Form("DocDaily_Month"),Request.Form("DocDaily_Year"))
		NoDay = CInt(Request.Form("DocDaily_Day"))

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
	Else If Radio_4.Checked = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(1,1,Request.Form("YearDate_Year"))
		 
		YearValue4 = Request.Form("YearDate_Year") + 1
		EndDate = DateTimeUtil.FormatDate(1,1,YearValue4)
		Dim SDate4 As New Date(Request.Form("YearDate_Year"),1,1)
		ReportDate = DateTimeUtil.FormatDateTime(SDate4, "yyyy",Session("LangID"),objCnn)
		Catch ex As Exception
			FoundError = True
		End Try
	Else
		DateFromValue = ""
		DateToValue = ""
		DailyDateValue = ""
	End If	
	If FoundError = False Then
		If LangDefault.Rows.Count >= 3 Then
			CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(NOW(), "DateAndTime",Session("LangID"),objCnn)
		End If
		Dim displayTable As New DataTable()
		
		ShowPrint.Visible = True
		ShowResults.Visible = True
		
		Dim ViewOption As Integer
		If Radio_1.Checked = True Then
			ViewOption = 1
		ElseIf Radio_2.Checked = True Then
			ViewOption = 2
		ElseIf Radio_4.Checked = True Then
			ViewOption = 4
		Else
			ViewOption = 0 
		End If
		
		Dim strDisplaySaleType as String 
		Dim receiptSaleType as Integer
		If Not IsNumeric(Request.Form("ReceiptType")) Then
			Request.Form("ReceiptType") = 1
		End If 
		receiptSaleType = Request.Form("ReceiptType") 
		
		Dim PaymentResult As DataTable
		Dim PayByCreditMoney As DataTable
		Dim outString2 As String
		Dim outString3 As String
		
		Dim dtTable As DataTable = DailyReport(ShowGroup.Checked,outputString, outString2, outString3, StartDate, EndDate, Request.Form("ShopID"),0,0, "pg.ProductGroupCode,pd.ProductDeptCode", GlobalParam.AdminBGColor, Session("LangID"), BeginDay, NoDay, receiptSaleType, objCnn)

		If Request.Form("ShopID") >= 0 Then
			ResultText.InnerHtml = outputString
			ResultText2.InnerHtml = outString2
			ResultText3.InnerHtml = outString3
		End If
		Dim ShopDisplay As String
		If Request.Form("ShopID") = 0 Then
			ShopDisplay = "All Shops"
		Else
			ShopDisplay = SelShopName.Value
		End If
		Select Case receiptSaleType 
			Case 2
				strDisplaySaleType = " - Non Sale"
			Case 3 
				strDisplaySaleType = " - Sale + Non Sale"
			Case else
				strDisplaySaleType = ""
		End Select 
		ResultSearchText.InnerHtml = "Daily Sales Report of " + ShopDisplay + " (" + ReportDate + ") " & strDisplaySaleType
		
		Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td><table><tr><td valign=""top"">" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table></td><td valign=""top"">" + startTable.InnerHtml + ResultText2.InnerHtml + "</table></td><td valign=""top"">" + startTable.InnerHtml + ResultText3.InnerHtml + "</table></td></tr></table>"
		
		If DisplayGraph.Checked = True AND (Radio_3.Checked = False Or (Radio_3.Checked = True AND Request.Form("ShopID")=0)) AND (Radio_11.Checked = True Or Radio_13.Checked = True) Then

				showGraph.Visible = True
				Dim view As DataView = GraphData.Tables(0).DefaultView
            
				Dim chart As New ColumnChart()
				chart.Fill.Color = Color.FromArgb(80, Color.SpringGreen)
            	chart.Line.Color = Color.SteelBlue
            	chart.Line.Width = 2
				chart.ShowLegend = True
				chart.DataSource = view
				chart.DataXValueField = "Description"
				chart.DataYValueField = "Value1"
				chart.DataBind()
				ChartControl1.Charts.Add(chart)
				ConfigureColors("Sale Report of " + ShopDisplay + " (" + ReportDate + ")")
        
        		ChartControl1.RedrawChart()
		Else
			showGraph.Visible = False
		End If
	End If
End Sub

 Sub ConfigureColors(TitleName)
        	'ChartControl1.Background.Color = Color.FromArgb(75, Color.SteelBlue)
			Dim ChartWidth As Integer = 650
			Dim ChartHeight As Integer = 500
			If Radio_13.Checked = True
				If GroupByParam.SelectedItem.Value = 1 Then
					ChartWidth = 500
					ChartHeight = 350
				Else
					ChartWidth = 600
					ChartHeight = 400
				End If
			End If
            ChartControl1.Background.Type = InteriorType.LinearGradient
            ChartControl1.Background.ForeColor = Color.SteelBlue
            ChartControl1.Background.EndPoint = new Point(ChartWidth, ChartHeight) 
            ChartControl1.Legend.Position = LegendPosition.Bottom
            'ChartControl1.Legend.Width = 40
			ChartControl1.Width = Unit.Parse(ChartWidth.ToString + "px")
			ChartControl1.Height = Unit.Parse(ChartHeight.ToString + "px")
 
            ChartControl1.YAxisFont.ForeColor = Color.SteelBlue
            ChartControl1.XAxisFont.ForeColor = Color.SteelBlue
            
            ChartControl1.ChartTitle.Text = TitleName
            ChartControl1.ChartTitle.ForeColor = Color.White
      
            ChartControl1.Border.Color = Color.SteelBlue
            'ChartControl1.BorderStyle = BorderStyle.Ridge
    End Sub	

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "DailySales_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub	

   
    Public Function DailyReport(ByVal ShowGroup As Boolean, ByRef ResultString As String, ByRef ResultString2 As String, ByRef ResultString3 As String, _
    ByVal StartDate As String, ByVal EndDate As String, ByVal ShopID As Integer, ByVal TransactionID As Integer, ByVal ComputerID As Integer, _
    ByVal OrderBy As String, ByVal AdminBGColor As String, ByVal LangID As Integer, ByVal BeginDay As String, ByVal NoDay As Integer, receiptSaleNonSaleType As Integer, _
    ByVal objCnn As MySqlConnection) As DataTable

        Dim FormatData As DataTable = Fm.FormatParam(FormatObject, LangID, objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)

        Dim sqlStatement, sqlStatement1, WhereString, WString, SessionString, SaleModeQuery As String
        Dim AdditionalQuery As String = ""
        Dim strTransStatus, strVoidTransStatus, strDocType As String
        Dim ShopIDListValue As String
        Dim dtTable As DataTable
        Dim strSQL As String

        Dim BranchStr, StrBefore As String
        Dim ii As Integer
        Dim getProp As New CPreferences

        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

        If ShopID > 0 Then
            AdditionalQuery += " AND a.ShopID IN (" + ShopID.ToString + ")"
            WhereString += " AND ShopID IN (" + ShopID.ToString + ")"
            SessionString += " AND ProductLevelID IN (" + ShopID.ToString + ")"
            SaleModeQuery += " AND ShopID IN (" + ShopID.ToString + ")"
        End If

        If StartDate <> "" And EndDate <> "" Then
            AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
            WhereString += " AND (PayDate >= " + StartDate + " AND PayDate < " + EndDate + ")"
            SessionString += " AND (SessionDate >= " + StartDate + " AND SessionDate < " + EndDate + ")"
            SaleModeQuery += " AND (a.SaleDate >= " + BeginDay + " AND a.SaleDate < " + EndDate + ")"
        End If

        Select Case receiptSaleNonSaleType
            Case 2          'Non Sale
                strTransStatus = " AND a.TransactionStatusID = 11 "
                strDocType = " AND a.DocType NOT IN (4,8) "
                strVoidTransStatus = " AND a.TransactionStatusID IN (12,13) "

            Case 3          'Sale + Non Sale
                strTransStatus = " AND a.TransactionStatusID IN (2,11) "
                strDocType = " "
                strVoidTransStatus = " AND a.TransactionStatusID IN (5,8,12,13) "

            Case Else       'Sale
                strTransStatus = " AND a.TransactionStatusID = 2 "
                strDocType = " AND a.DocType IN (4,8) "
                strVoidTransStatus = " AND a.TransactionStatusID IN (5,8) "
        End Select

        If Trim(WhereString) = "" Then
            WhereString = " AND 0=1"
        End If
        If Trim(OrderBy) = "" Then OrderBy = " pg.ProductGroupCode,pd.ProductDeptCode"

        Dim OtherIncomeData As DataTable
        Dim ColExist As Boolean = getProp.CheckColumnExist("ordertransactionotherincomedetail", "IncomeAmount", objCnn)
        If ColExist = True Then
            sqlStatement = "select SUM(b.IncomeAmount) As IncomeAmount, SUM(b.Income) As Income, SUM(b.IncomeVAT) As IncomeVAT " & _
                            "from ordertransaction a, ordertransactionotherincomedetail b where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID " & _
                            AdditionalQuery & strTransStatus & strDocType
            OtherIncomeData = objDB.List(sqlStatement, objCnn)
        End If
        Dim PaymentResult As DataTable
        sqlStatement = "select sum(payamount) AS TotalPay, sum(PaymentVAT) AS TotalVAT, a.PayTypeID,b.PayType AS PayTypeName from paybycreditmoney a " & _
                        "left outer join paytype b ON a.PayTypeID=b.TypeID where a.CreditMoneyStatusID=2 " + WhereString + " group by a.PayTypeID,b.PayType order by a.PayTypeID,b.PayType"
        Dim PayByCreditMoney As DataTable = objDB.List(sqlStatement, objCnn)

        sqlStatement = "select SaleMode,SaleModeName,ProductGroupCode,ProductGroupName,GroupOrdering,SUM(Amount) As TotalQty, SUM(TotalRetailPrice) As TotalRetailPrice, SUM(SalePrice) As SalePrice " & _
                        "from summary_productreport a where ProductSetType NOT IN (-1,-3,14,16) " & AdditionalQuery & strTransStatus & strDocType & _
                        " group by SaleMode,SaleModeName,ProductGroupCode,ProductGroupName,GroupOrdering order by SaleMode,GroupOrdering"
        dtTable = objDB.List(sqlStatement, objCnn)

	    Dim reportType As Integer = 0
        Dim Chk As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramTypeID=2 AND PropertyID=16 AND KeyID=1", objCnn)
        If Chk.Rows.Count > 0 Then
            ReportType = Chk.Rows(0)("PropertyValue")
        End If
        If ReportType = 0 Then
            sqlStatement1 = "select c.TypeID, as PayTypeID, c.PayType AS PayTypeName,IF(d.CreditCardType is NULL,c.PayType,d.CreditCardType) As CreditCardType,count(PayTypeID) As TotalQty, " & _
                        "SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT, IsOtherReceipt " & _
                        " from ordertransaction a left outer join paydetail b ON a.transactionid=b.transactionid and a.computerid=b.computerid " & _
                        " left outer join  paytype c ON b.PayTypeID=c.TypeID left outer join creditcardtype d ON b.CreditCardType=d.CCTypeID " & _
                        " where 0=0 " & AdditionalQuery & strTransStatus & " group by c.TypeID,c.PayType,IsSale, IsVAT,d.CreditCardType " & _
                        " having SUM(b.Amount) > 0  order by PayTypeID,CreditCardType"
        Else
            sqlStatement1 = "select c.TypeID as PayTypeID,c.PayType AS PayTypeName,IF(d.CreditCardType is NULL,c.PayType,d.CreditCardType) As CreditCardType,count(PayTypeID) As TotalQty, " & _
                          "SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT, IsOtherReceipt " & _
                          " from ordertransaction a left outer join paydetail b ON a.transactionid=b.transactionid and a.computerid=b.computerid " & _
                          " left outer join  paytype c ON IF(b.SmartcardType > 0,b.SmartcardType,b.PayTypeID)=c.TypeID " & _
                          " left outer join creditcardtype d ON b.CreditCardType=d.CCTypeID " & _
                          " where 0=0 " & AdditionalQuery & strTransStatus & " group by c.TypeID,c.PayType,IsSale, IsVAT,d.CreditCardType " & _
                          " having SUM(b.Amount) > 0  order by PayTypeID,CreditCardType"
        End If
        Dim PaymentData As DataTable = objDB.List(sqlStatement1, objCnn)

        sqlStatement = "select * from Session where IsEndDaySession=1 " + SessionString
        Dim EndDaySession As DataTable = objDB.List(sqlStatement, objCnn)

        sqlStatement = "select * from summary_tranreport a where 0=0 " & AdditionalQuery & strTransStatus & strDocType
        Dim SaleData As DataTable = objDB.List(sqlStatement, objCnn)
	
        sqlStatement = "select * from summary_tranreport a where 0=0 " & AdditionalQuery & strVoidTransStatus & strDocType
        Dim VoidData As DataTable = objDB.List(sqlStatement, objCnn)

        sqlStatement = "select SaleMode,SaleModeName,SUM(SalePrice) As SalePrice,SUM(Amount) As TotalQty " & _
                        "from Summary_ProductReport a where ProductSetType NOT IN (-1,-3,14,16) " & SaleModeQuery & strTransStatus & strDocType & _
                        " group by SaleMode,SaleModeName order by SaleMode"
        Dim SaleModeData As DataTable = objDB.List(sqlStatement, objCnn)

        sqlStatement = "select ProductName,SUM(SalePrice) As SalePrice,SUM(Amount) As TotalQty " & _
                        "from Summary_ProductReport a where ProductSetType NOT IN (-1,-3,14,16) " & AdditionalQuery & strTransStatus & strDocType & _
                        " group by ProductName order by SUM(Amount) DESC, SUM(SalePrice) DESC LIMIT 0,5"
        Dim TopMenu As DataTable = objDB.List(sqlStatement, objCnn)

        sqlStatement = "select a.*,CONCAT(s1.StaffFirstName,' ',s1.StaffLastName) As OpenStaff,CONCAT(s2.StaffFirstName,' ',s2.StaffLastName) As CloseStaff " & _
                    "from Session a left outer join Staffs s1 ON a.OpenStaffID=s1.StaffID left outer join Staffs s2 ON a.CloseStaffID=s2.StaffID " & _
                    "where a.CloseSessionDateTime is not NULL " + SessionString + " order by SessionID"
        Dim SessionData As DataTable = objDB.List(sqlStatement, objCnn)

        sqlStatement = "select SUM(TotalCashOutPrice) As TotalCashOut,CashMovement,a.SessionID,a.ComputerID " & _
                    "from session a, cashoutordertransaction b where a.CloseSessionDateTime is not NULL AND b.TransactionStatusID=2 AND " & _
                    " a.SessionID=b.SessionID AND a.ComputerID=b.ComputerID" + SessionString + " Group By CashMovement,a.SessionID,a.ComputerID"
        Dim CashOutData As DataTable = objDB.List(sqlStatement, objCnn)

        sqlStatement = "select PromotionID,PromotionName,SUM(TotalDiscount) As TotalDiscount,SUM(PriceAfterDiscount) As PriceAfterDiscount " & _
                       "from Summary_PromotionReport a where 0=0 " & AdditionalQuery & strTransStatus & " group by PromotionID,PromotionName order by SUM(TotalDiscount) DESC"
        Dim PromotionData As DataTable = objDB.List(sqlStatement, objCnn)

        sqlStatement = "select * from summary_transalemodereport a where 0=0 " & AdditionalQuery & strTransStatus & strDocType & " Order by SaleMode "
        Dim SaleModeSummaryData As DataTable = objDB.List(sqlStatement, objCnn)

        'Question Define Data
        sqlStatement = " Select q.QDDID, qd.QDDName, qo.OptionName, q.OptionID, Count(*) as NoQuestion " & _
                "From OrderTransaction a, QuestionDefineDetail q, QuestionDefineData qd, QuestionDefineOption qo " & _
                "Where a.ComputerID = q.ComputerID AND a.TransactionID = q.TransactionID AND " & _
                " q.QDDID = qd.QDDID AND q.OptionID = qo.OptionID AND a.ReceiptID <> 0 " & AdditionalQuery & strTransStatus & strDocType & _
                "Group By q.QDDID, qd.QDDName, qo.OptionName, q.OptionID " & _
                "Order by QDDName, OptionID "
        Dim QuestionData As DataTable = objDB.List(sqlStatement, objCnn)

        Dim VoidQty As Double = 0
        Dim VoidAmount As Double = 0
        If VoidData.Rows.Count > 0 Then
            VoidQty = VoidData.Rows(0)("TotalBill")
            VoidAmount = VoidData.Rows(0)("SalePrice") + VoidData.Rows(0)("ServiceCharge") + VoidData.Rows(0)("ServiceChargeVAT") + VoidData.Rows(0)("OtherIncome") + VoidData.Rows(0)("OtherIncomeVAT") + VoidData.Rows(0)("TransactionExcludeVAT")
        End If

        Dim VATPercent As String = ""
        Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel a left outer join CompanyProfile b ON a.ProductLevelID=b.CompanyID where ProductLevelID=" + ShopID.ToString, objCnn)
        Dim DisplayVATType As String = "V"
        If ShopInfo.Rows.Count > 0 Then
            If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
                DisplayVATType = "E"
            End If
            If Not IsDBNull(ShopInfo.Rows(0)("CompanyVAT")) Then
                VATPercent = ShopInfo.Rows(0)("CompanyVAT").ToString + "%"
            End If
        Else
            ShopInfo = objDB.List("select * from ProductLevel where IsShop=1 AND Deleted=0", objCnn)
            If ShopInfo.Rows.Count > 0 Then
                If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
                    DisplayVATType = "E"
                End If
            End If
        End If

        Dim foundRows() As DataRow
        Dim expression As String
        Dim bgColor As String = "white"
        Dim TextClass As String = "smallText"
        Dim outputString As StringBuilder = New StringBuilder
        Dim grandTotalQty As Double = 0
        Dim grandTotal As Double = 0
        Dim subTotalQty As Double = 0
        Dim subTotal As Double = 0
        Dim grandTotalDiscount As Double = 0
        Dim TotalCash As Double = 0
        Dim i, j As Integer
        Dim CategorySummary As New DataTable
        CategorySummary.Columns.Add("Name", System.Type.GetType("System.String"))
        CategorySummary.Columns.Add("Qty", System.Type.GetType("System.String"))
        CategorySummary.Columns.Add("QtyP", System.Type.GetType("System.String"))
        CategorySummary.Columns.Add("Amount", System.Type.GetType("System.String"))
        CategorySummary.Columns.Add("AmountP", System.Type.GetType("System.String"))
        Dim rData As DataRow

        If dtTable.Rows.Count = 0 Then
		    ResultString = ""
            ResultString2 = ""
            Exit Function
        End If
		
        Dim SummaryTotal As Double = 0
        Dim ShortOver As Double = 0
        Dim CashAmount As Double = 0
        Dim CashChange As Double = 0
        Dim TodaySale As Double = 0
        Dim TodayDiscount As Double = 0
        Dim TodayOtherIncome As Double = 0
        Dim TodayServiceCharge As Double = 0
        Dim TodayVAT As Double = 0
        Dim TodayBill As Double = 0
        Dim TodayCustomer As Double = 0
        Dim NetSale As Double = 0
        Dim TipAmount As Double = 0
        Dim TipPerson As Double = 0
        Dim TotalCustomers As Double = 0
        Dim SumCC As Double = 0
        Dim TotalEDC As Double = 0
        Dim TotalSaleModeQty As Double = 0
        Dim TotalSaleMode As Double = 0
        Dim RemarkText As String = ""
        Dim CashInputAmount As Double = 0
        Dim CCInputAmount As Double = 0
        Dim CashSystem As Double = 0
        Dim SaleModeTotalQty As Double = 0
        Dim SaleModeTotalRetailPrice As Double = 0
		Dim noPayment as integer 
		
        If SaleData.Rows.Count > 0 Then
			For i = 0 to SaleData.Rows.Count - 1
				NetSale += SaleData.Rows(i)("TotalRetailPrice")
				TodayDiscount += SaleData.Rows(i)("TotalDiscount")
				If DisplayVATType = "V" Then
					TodayOtherIncome += SaleData.Rows(i)("OtherIncome") + SaleData.Rows(i)("OtherIncomeVAT")
					TodayServiceCharge += SaleData.Rows(i)("ServiceCharge") + SaleData.Rows(i)("ServiceChargeVAT")
					TodaySale += SaleData.Rows(i)("SalePrice") + SaleData.Rows(i)("ServiceCharge") + SaleData.Rows(i)("ServiceChargeVAT") + SaleData.Rows(i)("OtherIncome") + SaleData.Rows(i)("OtherIncomeVAT")
				Else
					TodayOtherIncome += SaleData.Rows(i)("OtherIncome")
					TodayServiceCharge += SaleData.Rows(i)("ServiceCharge")
					TodaySale += SaleData.Rows(i)("SalePrice") + SaleData.Rows(i)("ServiceCharge") + SaleData.Rows(i)("OtherIncome")
				End If
				TodayVAT += SaleData.Rows(i)("TransactionVAT")
				TodayBill += SaleData.Rows(i)("TotalBill")
				TodayCustomer += SaleData.Rows(i)("TotalCustomer")
			Next i
        Else
            TodaySale = 0
        End If

        outputString = outputString.Append("<tr>")
        outputString = outputString.Append("<td colspan=""3"" align=""center"" class=""smallTdHeader"" bgcolor=""" + AdminBGColor + """>" + "Sales Summary" + "</td>")
        outputString = outputString.Append("</tr>")

        For i = 0 To dtTable.Rows.Count - 1
            If i = 0 Then
                outputString = outputString.Append("<tr>")
                outputString = outputString.Append("<td colspan=""3"" align=""center"" class=""" + TextClass + """ bgcolor=""#ebebeb"">" + dtTable.Rows(i)("SaleModeName") + "</td>")
                outputString = outputString.Append("</tr>")
                SaleModeTotalQty = 0
                SaleModeTotalRetailPrice = 0
            ElseIf dtTable.Rows(i)("SaleMode") <> dtTable.Rows(i - 1)("SaleMode") Then
                outputString = outputString.Append("<tr>")
                outputString = outputString.Append("<td colspan=""3"" align=""center"" class=""" + TextClass + """ bgcolor=""#ebebeb"">" + dtTable.Rows(i)("SaleModeName") + "</td>")
                outputString = outputString.Append("</tr>")
                SaleModeTotalQty = 0
                SaleModeTotalRetailPrice = 0
            End If
            outputString = outputString.Append("<tr>")
            outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + dtTable.Rows(i)("ProductGroupName") + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TotalQty")).ToString(FormatObject.QtyFormat, ci) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TotalRetailPrice")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("</tr>")

            grandTotalQty += dtTable.Rows(i)("TotalQty")
            grandTotal += dtTable.Rows(i)("TotalRetailPrice")
            grandTotalDiscount += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("SalePrice")
            SaleModeTotalRetailPrice += dtTable.Rows(i)("TotalRetailPrice")
            SaleModeTotalQty += dtTable.Rows(i)("TotalQty")
            If i = dtTable.Rows.Count - 1 Then
                outputString = outputString.Append("<tr bgcolor=""#ebebeb"">")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>Total for " + dtTable.Rows(i)("SaleModeName") + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SaleModeTotalQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SaleModeTotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("</tr>")
            ElseIf dtTable.Rows(i)("SaleMode") <> dtTable.Rows(i + 1)("SaleMode") Then
                outputString = outputString.Append("<tr bgcolor=""#ebebeb"">")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>Total for " + dtTable.Rows(i)("SaleModeName") + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SaleModeTotalQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SaleModeTotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("</tr>")
            End If
        Next

        outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
        outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + "Net Sales" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(NetSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        outputString = outputString.Append("</tr>")

        outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
        outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + "Discount" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TodayDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        outputString = outputString.Append("</tr>")

        outputString = outputString.Append("<tr bgColor=""#ebebeb"">")
        outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + "Net Sales  after Discount" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(NetSale - TodayDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        outputString = outputString.Append("</tr>")

        outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
        If ColExist = True Then
            outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + "Other Income" + "</td>")
            If Not IsDBNull(OtherIncomeData.Rows(0)("IncomeAmount")) Then
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(OtherIncomeData.Rows(0)("IncomeAmount")).ToString(FormatObject.QtyFormat, ci) + "</td>")
            Else
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + "0" + "</td>")
            End If
        Else
            outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + "Other Income" + "</td>")
        End If
        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TodayOtherIncome).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        outputString = outputString.Append("</tr>")

        outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
        outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + "Service Charge" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TodayServiceCharge).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        outputString = outputString.Append("</tr>")

        Dim TotalSaleStat As Double
        Dim grandTotalSale As Double

        If DisplayVATType = "V" Then
            TotalSaleStat = TodaySale
            grandTotalSale = TodaySale
            outputString = outputString.Append("<tr bgColor=""#ebebeb"">")
            outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + "Total Sales" + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TodaySale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("</tr>")

            outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
            outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + "VAT " + VATPercent + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TodayVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("</tr>")

            outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
            outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + "Sales Before VAT" + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TodaySale - TodayVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("</tr>")
        Else
            TotalSaleStat = TodaySale
            grandTotalSale = TodaySale + TodayVAT
            outputString = outputString.Append("<tr bgColor=""#ebebeb"">")
            outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + "Sales Before VAT" + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TodaySale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("</tr>")

            outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
            outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + "VAT " + VATPercent + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TodayVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("</tr>")

            outputString = outputString.Append("<tr bgColor=""#ebebeb"">")
            outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + "Total Sales" + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TodaySale + TodayVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("</tr>")


        End If

        outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
        outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + "Pax (Customers)" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TodayCustomer).ToString(FormatObject.QtyFormat, ci) + "</td>")
        outputString = outputString.Append("</tr>")

        outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
        outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + "Price/Customer" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalSaleStat / TodayCustomer).ToString(FormatObject.QtyFormat, ci) + "</td>")
        outputString = outputString.Append("</tr>")

        outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
        outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + "No Bills" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TodayBill).ToString(FormatObject.QtyFormat, ci) + "</td>")
        outputString = outputString.Append("</tr>")

        outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
        outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + "Price/Bill" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalSaleStat / TodayBill).ToString(FormatObject.QtyFormat, ci) + "</td>")
        outputString = outputString.Append("</tr>")

        outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
        outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_void.aspx?ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=900,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Void Bill" + "</a></td>")
        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(VoidQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(VoidAmount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        outputString = outputString.Append("</tr>")

        'Sale Mode Summary and Average
        If SaleModeSummaryData.Rows.Count > 0 Then
            Dim dclSaleModePayment, dclAvg As Decimal
            Dim useAveragePriceType As Integer = 2      'For SushiTei use 2
            outputString = outputString.Append("<tr><td></td></tr>")
            For i = 0 To SaleModeSummaryData.Rows.Count - 1
                Select Case useAveragePriceType
                    Case 1          'AverageBeforeDiscount
                        'Use Price Before Discount ---> SalePrice + Discount
                        dclSaleModePayment = SaleModeSummaryData.Rows(i)("TotalRetailPrice")

                        'Use PayPrice - VAT - ServiceCharge
                    Case 2          'AverageBeforeVATAndServiceCharge
                        dclSaleModePayment = SaleModeSummaryData.Rows(i)("SalePrice")
                    Case Else       'Average Use PaymentPrice
                        dclSaleModePayment = SaleModeSummaryData.Rows(i)("SalePrice") + (SaleModeSummaryData.Rows(i)("TransactionExcludeVAT") + _
                                                    SaleModeSummaryData.Rows(i)("ServiceCharge") + SaleModeSummaryData.Rows(i)("OtherIncome") + _
                                                    SaleModeSummaryData.Rows(i)("ServiceChargeVAT") + SaleModeSummaryData.Rows(i)("OtherIncomeVAT"))
                End Select
                outputString = outputString.Append("<tr bgColor=""#ebebeb"">")
                outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + SaleModeSummaryData.Rows(i)("SaleModeName") + " Summary" + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + dclSaleModePayment.ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("</tr>")
                'Total Receipt
                outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
                outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + " Total Receipt In Day" + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CInt(SaleModeSummaryData.Rows(i)("TotalBill")).ToString(FormatObject.QtyFormat, ci) + "</td>")
                outputString = outputString.Append("</tr>")
                dclAvg = dclSaleModePayment / SaleModeSummaryData.Rows(i)("TotalBill")
                outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
                outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + " Avg. Per Receipt" + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + dclAvg.ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("</tr>")

                'Total Customer
                outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
                outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + " Total Customer In Day" + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CInt(SaleModeSummaryData.Rows(i)("TotalCustomer")).ToString(FormatObject.QtyFormat, ci) + "</td>")
                outputString = outputString.Append("</tr>")
                dclAvg = dclSaleModePayment / SaleModeSummaryData.Rows(i)("TotalCustomer")
                outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
                outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + " Avg. Per Customer" + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + dclAvg.ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("</tr>")
            Next i
        End If

        'Question Define Data 
        Dim curQDDID As Integer
        If QuestionData.Rows.Count > 0 Then
            curQDDID = -1
            For i = 0 To QuestionData.Rows.Count - 1
                If curQDDID <> QuestionData.Rows(i)("QDDID") Then
                    outputString = outputString.Append("<tr bgColor=""" + AdminBGColor + """>")
                    outputString = outputString.Append("<td colspan=""3"" align=""center"" class=""smallTdHeader"">" + QuestionData.Rows(i)("QDDName") + "</td>")
                    outputString = outputString.Append("</tr>")
                    curQDDID = QuestionData.Rows(i)("QDDID")
                End If
                outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
                outputString = outputString.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + QuestionData.Rows(i)("OptionName") + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CInt(QuestionData.Rows(i)("NoQuestion")).ToString(FormatObject.QtyFormat, ci) + "</td>")
                outputString = outputString.Append("</tr>")
            Next i
        End If

        ResultString = outputString.ToString

        Dim outputString2 As StringBuilder = New StringBuilder

        outputString2 = outputString2.Append("<tr>")
        outputString2 = outputString2.Append("<td colspan=""5"" align=""center"" class=""smallTdHeader"" bgcolor=""" + AdminBGColor + """>" + "Payment Summary" + "</td>")
        outputString2 = outputString2.Append("</tr>")

        outputString2 = outputString2.Append("<tr bgColor=""#ebebeb"">")
        outputString2 = outputString2.Append("<td class=""" + TextClass + """ align=""center"">Payment Type</td>")
        outputString2 = outputString2.Append("<td class=""" + TextClass + """ align=""center"">Qty</td>")
        outputString2 = outputString2.Append("<td class=""" + TextClass + """ align=""center"">%</td>")
        outputString2 = outputString2.Append("<td class=""" + TextClass + """ align=""center"">Amount</td>")
        outputString2 = outputString2.Append("<td class=""" + TextClass + """ align=""center"">%</td>")
        outputString2 = outputString2.Append("</tr>")

        subTotalQty = 0
        subTotal = 0
        grandTotalQty = 0
        grandTotal = 0

        For i = 0 To PaymentData.Rows.Count - 1
            grandTotalQty += PaymentData.Rows(i)("TotalQty")
            grandTotal += PaymentData.Rows(i)("TotalPay")
        Next
		noPayment = 0
        For i = 0 To PaymentData.Rows.Count - 1
			noPayment += 1
            subTotalQty += PaymentData.Rows(i)("TotalQty")
            subTotal += PaymentData.Rows(i)("TotalPay")
            outputString2 = outputString2.Append("<tr bgColor=""" + bgColor + """>")
            outputString2 = outputString2.Append("<td align=""left"" class=""" + TextClass + """>" + PaymentData.Rows(i)("CreditCardType") + "</td>")
            outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(PaymentData.Rows(i)("TotalQty"), "##,##0") + "</td>")
            outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(PaymentData.Rows(i)("TotalQty") * 100 / grandTotalQty, "##,##0.00") + "%</td>")
            outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(PaymentData.Rows(i)("TotalPay"), "##,##0.00") + "</td>")
            outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(PaymentData.Rows(i)("TotalPay") * 100 / grandTotal, "##,##0.00") + "%</td>")
            outputString2 = outputString2.Append("</tr>")
            If PaymentData.Rows(i)("PayTypeID") = 1 Then
                TotalCash += PaymentData.Rows(i)("TotalPay")
            End If
            If i <= PaymentData.Rows.Count - 1 Then
                If i = PaymentData.Rows.Count - 1 Then
					If (noPayment > 1) OR (PaymentData.Rows(i)("PayTypeName") <> PaymentData.Rows(i)("CreditCardType")) Then
						outputString2 = outputString2.Append("<tr bgColor=""#ebebeb"">")
						outputString2 = outputString2.Append("<td align=""left"" class=""" + TextClass + """>Total " + PaymentData.Rows(i)("PayTypeName") + "</td>")
						outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalQty, "##,##0") + "</td>")
						outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalQty * 100 / grandTotalQty, "##,##0.00") + "%</td>")
						outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotal, "##,##0.00") + "</td>")
						outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotal * 100 / grandTotal, "##,##0.00") + "%</td>")
						outputString2 = outputString2.Append("</tr>")
					End If
                Else
                    If PaymentData.Rows(i)("PayTypeID") <> PaymentData.Rows(i + 1)("PayTypeID") Then
						If (noPayment > 1) OR (PaymentData.Rows(i)("PayTypeName") <> PaymentData.Rows(i)("CreditCardType")) Then
							outputString2 = outputString2.Append("<tr bgColor=""#ebebeb"">")
							outputString2 = outputString2.Append("<td align=""left"" class=""" + TextClass + """>Total " + PaymentData.Rows(i)("PayTypeName") + "</td>")
							outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalQty, "##,##0") + "</td>")
							outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalQty * 100 / grandTotalQty, "##,##0.00") + "%</td>")
							outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotal, "##,##0.00") + "</td>")
							outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotal * 100 / grandTotal, "##,##0.00") + "%</td>")
							outputString2 = outputString2.Append("</tr>")
						End If 
                        subTotal = 0
                        subTotalQty = 0
						noPayment = 0
                    End If
                End If
            End If
        Next

        outputString2 = outputString2.Append("<tr bgColor=""#ebebeb"">")
        outputString2 = outputString2.Append("<td align=""left"" class=""" + TextClass + """>" + "Total Received" + "</td>")
        outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalQty, "##,##0") + "</td>")
        outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalQty * 100 / grandTotalQty, "##,##0.00") + "%</td>")
        outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotal, "##,##0.00") + "</td>")
        outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotal * 100 / grandTotal, "##,##0.00") + "%</td>")
        outputString2 = outputString2.Append("</tr>")

        outputString2 = outputString2.Append("<tr bgColor=""#ebebeb"">")
        outputString2 = outputString2.Append("<td align=""left"" class=""" + TextClass + """>" + "Diff Sale & Payment" + "</td>")
        outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + "" + "</td>")
        outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + "" + "</td>")
        outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotal - grandTotalSale, "##,##0.00") + "</td>")
        outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + "" + "</td>")
        outputString2 = outputString2.Append("</tr>")

        outputString2 = outputString2.Append("<tr>")
        outputString2 = outputString2.Append("<td colspan=""5"" align=""center"" class=""smallTdHeader"" bgcolor=""" + AdminBGColor + """>" + "Promotion Summary" + "</td>")
        outputString2 = outputString2.Append("</tr>")

        outputString2 = outputString2.Append("<tr bgColor=""#ebebeb"">")
        outputString2 = outputString2.Append("<td align=""center"" class=""" + TextClass + """>" + "Promotion Name" + "</td>")
        outputString2 = outputString2.Append("<td colspan=""2"" align=""center"" class=""" + TextClass + """>" + "Discount" + "</td>")
        outputString2 = outputString2.Append("<td colspan=""2"" align=""center"" class=""" + TextClass + """>" + "%" + "</td>")
        outputString2 = outputString2.Append("</tr>")
        Dim grandTotalDisc As Double = 0
        For i = 0 To PromotionData.Rows.Count - 1
            outputString2 = outputString2.Append("<tr bgColor=""" + bgColor + """>")
            outputString2 = outputString2.Append("<td align=""left"" class=""" + TextClass + """><a class=""smallText"" href=""JavaScript: newWindow = window.open( 'report_promotions.aspx?op=1&viewreporttype=" + "2" + "&PromotionID=" + PromotionData.Rows(i)("PromotionID").ToString + "&ShopID=" + ShopID.ToString + "&fromdate=" + Replace(StartDate, "'", "\'") + "&todate=" + Replace(EndDate, "'", "\'") + "', '', 'width=800,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + PromotionData.Rows(i)("PromotionName") + "</a></td>")
            outputString2 = outputString2.Append("<td colspan=""2"" align=""right"" class=""" + TextClass + """>" + CDbl(PromotionData.Rows(i)("TotalDiscount")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString2 = outputString2.Append("<td colspan=""2"" align=""right"" class=""" + TextClass + """>" + CDbl(PromotionData.Rows(i)("TotalDiscount") / TotalSaleStat).ToString(FormatObject.PercentFormat, ci) + "</td>")
            outputString2 = outputString2.Append("</tr>")
            grandTotalDisc += PromotionData.Rows(i)("TotalDiscount")
        Next
        If grandTotalDiscount <> 0 Then
            outputString2 = outputString2.Append("<tr bgColor=""#ebebeb"">")
            outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """><a class=""smallText"" href=""JavaScript: newWindow = window.open( 'report_promotions.aspx?op=1&viewreporttype=" + "2" + "&PromotionID=0" + "&ShopID=" + ShopID.ToString + "&fromdate=" + Replace(StartDate, "'", "\'") + "&todate=" + Replace(EndDate, "'", "\'") + "', '', 'width=800,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Total Discount" + "</a></td>")
            outputString2 = outputString2.Append("<td colspan=""2"" align=""right"" class=""" + TextClass + """>" + CDbl(grandTotalDisc).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString2 = outputString2.Append("<td colspan=""2"" align=""right"" class=""" + TextClass + """>" + CDbl(grandTotalDisc / TotalSaleStat).ToString(FormatObject.PercentFormat, ci) + "</td>")
            outputString2 = outputString2.Append("</tr>")
        End If

        outputString2 = outputString2.Append("<tr>")
        outputString2 = outputString2.Append("<td colspan=""5"" align=""left"" class=""" + TextClass + """>" + "NOTE: % is calculated based on total sales (" + CDbl(TotalSaleStat).ToString(FormatObject.CurrencyFormat, ci) + ")</td>")
        outputString2 = outputString2.Append("</tr>")

        outputString2 = outputString2.Append("<tr>")
        outputString2 = outputString2.Append("<td colspan=""5"" align=""center"" class=""smallTdHeader"" bgcolor=""" + AdminBGColor + """>" + "Top 5 Menus" + "</td>")
        outputString2 = outputString2.Append("</tr>")

        outputString2 = outputString2.Append("<tr bgColor=""#ebebeb"">")
        outputString2 = outputString2.Append("<td align=""center"" class=""" + TextClass + """>" + "Menu" + "</td>")
        outputString2 = outputString2.Append("<td colspan=""2"" align=""center"" class=""" + TextClass + """>" + "Qty" + "</td>")
        outputString2 = outputString2.Append("<td colspan=""2"" align=""center"" class=""" + TextClass + """>" + "Amount" + "</td>")
        outputString2 = outputString2.Append("</tr>")

        For i = 0 To TopMenu.Rows.Count - 1
            outputString2 = outputString2.Append("<tr bgColor=""" + bgColor + """>")
            outputString2 = outputString2.Append("<td align=""left"" class=""" + TextClass + """>" + TopMenu.Rows(i)("ProductName") + "</td>")
            outputString2 = outputString2.Append("<td colspan=""2"" align=""center"" class=""" + TextClass + """>" + CDbl(TopMenu.Rows(i)("TotalQty")).ToString(FormatObject.QtyFormat, ci) + "</td>")
            outputString2 = outputString2.Append("<td colspan=""2"" align=""right"" class=""" + TextClass + """>" + CDbl(TopMenu.Rows(i)("SalePrice")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString2 = outputString2.Append("</tr>")
        Next

        ResultString2 = outputString2.ToString

        Dim outputString3 As StringBuilder = New StringBuilder

        outputString3 = outputString3.Append("<tr>")
        outputString3 = outputString3.Append("<td colspan=""2"" align=""center"" class=""smallTdHeader"" bgcolor=""" + AdminBGColor + """>" + "Shift Close Summary" + "</td>")
        outputString3 = outputString3.Append("</tr>")

        Dim TimeString As String

        Dim OpenSession As Double = 0
        Dim CloseSession As Double = 0
        Dim ShortOverSession As Double = 0
        Dim TotalCashIn As Double = 0
        Dim TotalCashOut As Double = 0
        Dim SubTotalCash As Double = 0

        For i = 0 To SessionData.Rows.Count - 1
            outputString3 = outputString3.Append("<tr bgColor=""#ebebeb"">")
            outputString3 = outputString3.Append("<td colspan=""2"" align=""center"" class=""" + TextClass + """>" + "Shift #" + (i + 1).ToString + "</td>")
            outputString3 = outputString3.Append("</tr>")
            outputString3 = outputString3.Append("<tr bgColor=""" + bgColor + """>")
            outputString3 = outputString3.Append("<td align=""left"" class=""" + TextClass + """>" + "Opened By" + "</td>")
            If Not IsDBNull(SessionData.Rows(i)("OpenStaff")) Then
                outputString3 = outputString3.Append("<td align=""right"" class=""" + TextClass + """>" + SessionData.Rows(i)("OpenStaff") + "</td>")
            Else
                outputString3 = outputString3.Append("<td align=""right"" class=""" + TextClass + """>" + "-" + "</td>")
            End If
            outputString3 = outputString3.Append("</tr>")
            outputString3 = outputString3.Append("<tr bgColor=""" + bgColor + """>")
            outputString3 = outputString3.Append("<td align=""left"" class=""" + TextClass + """>" + "Closed By" + "</td>")
            If Not IsDBNull(SessionData.Rows(i)("CloseStaff")) Then
                outputString3 = outputString3.Append("<td align=""right"" class=""" + TextClass + """>" + SessionData.Rows(i)("CloseStaff") + "</td>")
            Else
                outputString3 = outputString3.Append("<td align=""right"" class=""" + TextClass + """>" + "-" + "</td>")
            End If
            outputString3 = outputString3.Append("</tr>")

            If Not IsDBNull(SessionData.Rows(i)("OpenSessionDateTime")) Then
                TimeString = CDate(SessionData.Rows(i)("OpenSessionDateTime")).ToString(FormatObject.TimeFormat, ci)
            Else
                TimeString = "N/A"
            End If
            If Not IsDBNull(SessionData.Rows(i)("CloseSessionDateTime")) Then
                TimeString += " - " + CDate(SessionData.Rows(i)("CloseSessionDateTime")).ToString(FormatObject.TimeFormat, ci)
            Else
                TimeString += " - " + "N/A"
            End If
            outputString3 = outputString3.Append("<tr bgColor=""" + bgColor + """>")
            outputString3 = outputString3.Append("<td align=""left"" class=""" + TextClass + """>" + "Time" + "</td>")
            outputString3 = outputString3.Append("<td align=""right"" class=""" + TextClass + """>" + TimeString + "</td>")
            outputString3 = outputString3.Append("</tr>")

            expression = "CashMovement = 1 AND SessionID=" + SessionData.Rows(i)("SessionID").ToString + " AND ComputerID=" + SessionData.Rows(i)("ComputerID").ToString
            foundRows = CashOutData.Select(expression)
            TotalCashIn = 0
            If foundRows.GetUpperBound(0) >= 0 Then
                TotalCashIn = foundRows(0)("TotalCashOut")
            End If

            expression = "CashMovement = -1 AND SessionID=" + SessionData.Rows(i)("SessionID").ToString + " AND ComputerID=" + SessionData.Rows(i)("ComputerID").ToString
            foundRows = CashOutData.Select(expression)
            TotalCashOut = 0
            If foundRows.GetUpperBound(0) >= 0 Then
                TotalCashOut = foundRows(0)("TotalCashOut") * -1
            End If

            SubTotalCash = SessionData.Rows(i)("CloseSessionAmount") - SessionData.Rows(i)("CashShortOver")
            TotalCash = SubTotalCash - (SessionData.Rows(i)("OpenSessionAmount") + TotalCashIn + TotalCashOut)

            outputString3 = outputString3.Append("<tr>")
            outputString3 = outputString3.Append("<td align=""left"" class=""" + TextClass + """>" + "Open Shift Amount" + "</td>")
            outputString3 = outputString3.Append("<td align=""right"" class=""" + TextClass + """>" + Format(SessionData.Rows(i)("OpenSessionAmount"), "##,##0.00") + "</td>")
            outputString3 = outputString3.Append("</tr>")
            outputString3 = outputString3.Append("<tr>")
            outputString3 = outputString3.Append("<td align=""left"" class=""" + TextClass + """>" + "Cash Sales" + "</td>")
            outputString3 = outputString3.Append("<td align=""right"" class=""" + TextClass + """>" + Format(TotalCash, "##,##0.00") + "</td>")
            outputString3 = outputString3.Append("</tr>")

            outputString3 = outputString3.Append("<tr>")
            outputString3 = outputString3.Append("<td align=""left"" class=""" + TextClass + """>" + "Cash In" + "</td>")
            outputString3 = outputString3.Append("<td align=""right"" class=""" + TextClass + """>" + Format(TotalCashIn, "##,##0.00") + "</td>")
            outputString3 = outputString3.Append("</tr>")
            outputString3 = outputString3.Append("<tr>")
            outputString3 = outputString3.Append("<td align=""left"" class=""" + TextClass + """>" + "Cash Out" + "</td>")
            outputString3 = outputString3.Append("<td align=""right"" class=""" + TextClass + """>" + Format(TotalCashOut, "##,##0.00") + "</td>")
            outputString3 = outputString3.Append("</tr>")
            outputString3 = outputString3.Append("<tr>")
            outputString3 = outputString3.Append("<tr bgColor=""#f1f1f1"">")
            outputString3 = outputString3.Append("<td align=""right"" class=""" + TextClass + """>" + "Sub Total" + "</td>")
            outputString3 = outputString3.Append("<td align=""right"" class=""" + TextClass + """>" + Format(SubTotalCash, "##,##0.00") + "</td>")
            outputString3 = outputString3.Append("</tr>")
            outputString3 = outputString3.Append("<tr>")
            outputString3 = outputString3.Append("<td align=""left"" class=""" + TextClass + """>" + "Cash Count" + "</td>")
            outputString3 = outputString3.Append("<td align=""right"" class=""" + TextClass + """>" + Format(SessionData.Rows(i)("CloseSessionAmount"), "##,##0.00") + "</td>")
            outputString3 = outputString3.Append("</tr>")
            outputString3 = outputString3.Append("<tr bgColor=""#f1f1f1"">")
            outputString3 = outputString3.Append("<td align=""right"" class=""" + TextClass + """>" + "Short/Over" + "</td>")
            outputString3 = outputString3.Append("<td align=""right"" class=""" + TextClass + """>" + Format(SessionData.Rows(i)("CashShortOver"), "##,##0.00") + "</td>")
            outputString3 = outputString3.Append("</tr>")
        Next

        ResultString3 = outputString3.ToString

    End Function

		
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
