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
<%@Import Namespace="QAReports" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Day Sales Report</title>
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
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Day Sales Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
			<tr>
				<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" />&nbsp;<asp:CheckBox ID="DisplayGraph" CssClass="text" Visible="false" Checked="false" runat="server" /></td>
			</tr>
		</table></td>
	<td>
	<table>
		<tr>
		<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="DailyDate" runat="server" /></td>
		<td colspan="2"><asp:CheckBox ID="ExpandReceipt" Visible="false" CssClass="text" Checked="false" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
		<td colspan="3"><synature:date id="MonthYearDate" runat="server" /></td>
		</tr>
		<tr id="showYear" visible="false" runat="server">
		<td><asp:radiobutton ID="Radio_4" GroupName="Group1" runat="server" /></td>
		<td colspan="3"><synature:date id="YearDate" runat="server" /></td>
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

<div id="showResults" visible="false" runat="server">
<span id="MyTable">
<table><tr><td colspan="2">
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

<span id="ResultText2" runat="server"></span>

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
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getReport As New StReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer  = 998

Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_DailySaleCoca") Then
		
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
		
		ShowGroup.Text = "Day Sales Report"
		ShowGroup.Visible = False

		StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		
		Dim HeaderString As String = ""
		
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Description" + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Qty" + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "%" + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Amount" + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "%" + "</td>"
		
		TableHeaderText.InnerHtml = HeaderString
		
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
		Dim PaymentResult As DataTable
		Dim PayByCreditMoney As DataTable
		Dim outString2 As String
		
		'Application.Lock()
		Dim dtTable As DataTable = DaySaleReportCoca(ViewOption,ShowGroup.Checked,outputString, outString2, StartDate, EndDate, Request.Form("ShopID"),0,0, "pg.ProductGroupCode,pd.ProductDeptCode", GlobalParam.AdminBGColor, objCnn)

		If Request.Form("ShopID") >= 0 Then
			ResultText.InnerHtml = outputString
			ResultText2.InnerHtml = outString2
		End If
		Dim ShopDisplay As String
		If Request.Form("ShopID") = 0 Then
			ShopDisplay = "All Shops"
		Else
			ShopDisplay = SelShopName.Value
		End If
		ResultSearchText.InnerHtml = "Day Sales Report of " + ShopDisplay + "<br>" + ReportDate + ""
		'Application.UnLock()
		
		Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td><table><tr><td valign=""top"">" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table></td><td valign=""top"">" + ResultText2.InnerHtml + "</td></tr></table>"
		
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
	
	Dim FileName As String = "DaySalesReport_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub	

Public Function DaySaleReportCoca(ByVal ViewOption As Integer, ByVal ShowGroup As Boolean, ByRef ResultString As String, ByRef ResultString2 As String, ByVal StartDate As String, ByVal EndDate As String, ByVal ShopID As Integer, ByVal TransactionID As Integer, ByVal ComputerID As Integer, ByVal OrderBy As String, ByVal AdminBGColor As String, ByVal objCnn As MySqlConnection) As DataTable

        Dim sqlStatement, sqlStatement1, WhereString, WString, SessionString As String
        Dim AdditionalQuery As String = ""
        Dim ShopIDListValue As String
        Dim dtTable As DataTable

        Dim BranchStr, StrBefore As String
        Dim ii As Integer
        Dim getProp As New CPreferences

        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

        If TransactionID > 0 And ComputerID > 0 Then
            AdditionalQuery += " AND ( a.TransactionID = " + TransactionID.ToString + " AND a.ComputerID = " + ComputerID.ToString + ")"
        Else
            AdditionalQuery += " AND a.DocType=8"
        End If

        If ShopID > 0 Then
            AdditionalQuery += " AND a.ShopID IN (" + ShopID.ToString + ")"
            WhereString += " AND ShopID IN (" + ShopID.ToString + ")"
			SessionString += " AND a.ProductLevelID IN (" + ShopID.ToString + ")"
        End If

        If StartDate <> "" And EndDate <> "" Then
            AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
            WhereString += " AND (PayDate >= " + StartDate + " AND PayDate < " + EndDate + ")"
			SessionString += " AND (a.SessionDate >= " + StartDate + " AND a.SessionDate < " + EndDate + ")"
        End If

        If Trim(WhereString) = "" Then
            WhereString = " AND 0=1"
        End If
		If Trim(SessionString) = "" Then
            SessionString = " AND 0=1"
        End If
        If Trim(OrderBy) = "" Then OrderBy = " pg.ProductGroupCode,pd.ProductDeptCode"

        Dim PaymentResult As DataTable
        sqlStatement = "select sum(payamount) AS TotalPay, sum(PaymentVAT) AS TotalVAT, a.PayTypeID,b.PayType AS PayTypeName from paybycreditmoney a left outer join paytype b ON a.PayTypeID=b.TypeID where a.CreditMoneyStatusID=2 " + WhereString + " group by a.PayTypeID,b.PayType order by a.PayTypeID,b.PayType"
        Dim PayByCreditMoney As DataTable = objDB.List(sqlStatement, objCnn)

        sqlStatement = "select IF(pd.ProductDeptCode is NULL,'-',pd.ProductDeptCode) As ProductDeptCode,IF(pd.ProductDeptName is NULL,'Other Category',pd.ProductDeptName) As ProductDeptName,IF(pg.ProductGroupCode is NULL,'-',pg.ProductGroupCode) As ProductGroupCode,IF(pg.ProductGroupName is NULL,'Other Category',pg.ProductGroupName) As ProductGroupName, SUM(b.Amount) As TotalQty, SUM(IF(b.ProductSetType>=0,c.TotalRetailPrice,0)) AS TotalRetailPrice, SUM(c.SalePrice) As TotalSalePrice, SUM(IF(b.ProductSetType>=0,c.TotalRetailPrice-c.SalePrice,0)) As TotalDiscount, SUM(IF(b.ProductSetType>=0,c.TotalRetailPrice*100/(100+a.VATPercent),0)) AS TotalRetailPriceBeforeVAT, SUM(IF(b.ProductSetType>=0,(c.TotalRetailPrice-c.SalePrice)*100/(100+a.VATPercent),0)) As TotalDiscountBeforeVAT, SUM(c.SalePrice*100/(100+a.VATPercent)) As TotalSalePriceBeforeVAT from OrderTransaction a left outer join OrderDetail b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID left outer join OrderDiscountDetail c ON b.OrderDetailID=c.OrderDetailID AND b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID left outer join Products p ON b.ProductID=p.ProductID left outer join ProductDept pd ON p.ProductDeptID=pd.ProductDeptID left outer join ProductGroup pg ON pd.ProductGroupID=pg.ProductGroupID where a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3) AND a.TransactionStatusID=2 AND b.OrderStatusID NOT IN (3,4) " + AdditionalQuery + " group by pd.ProductDeptCode,pd.ProductDeptName,pg.ProductGroupCode,pg.ProductGroupName order by " + OrderBy

        sqlStatement1 = "select b.PayTypeID,c.PayType AS PayTypeName,IF(d.CreditCardType is NULL,c.PayType,d.CreditCardType) As CreditCardType,count(PayTypeID) As TotalQty,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT, IsOtherReceipt from ordertransaction a left outer join paydetail b ON a.transactionid=b.transactionid and a.computerid=b.computerid left outer join  paytype c ON b.PayTypeID=c.TypeID left outer join creditcardtype d ON b.CreditCardType=d.CCTypeID where a.TransactionStatusID=2 " + AdditionalQuery + " group by b.PayTypeID,c.PayType,IsSale, IsVAT,d.CreditCardType having SUM(b.Amount) > 0  order by b.PayTypeID,CreditCardType"

        dtTable = objDB.List(sqlStatement, objCnn)
		
		Dim getData As DataTable = objDB.List("select SUM(ServiceCharge) As ServiceCharge,SUM(a.OtherIncome) As OtherIncome,SUM(ServiceCharge+ServiceChargeVAT) As ServiceChargeIncVAT,SUM(a.OtherIncome+a.OtherIncomeVAT) As OtherIncomeIncVAT,SUM(TransactionExcludeVAT) As ExcludeVAT,SUM(a.ReceiptDiscount) As TotalDiscount,SUM(a.ReceiptDiscount*100/(100+a.VATPercent)) As TotalDiscountBeforeVAT, SUM(TransactionVAT) As TotalVAT, SUM(a.ReceiptSalePrice) As TotalSale, SUM(a.NoCustomer) As TotalCustomer from OrderTransaction a where a.TransactionStatusID=2 " + AdditionalQuery, objCnn)
		
		sqlStatement = "select SUM(cp.CommAmount) As TotalComm from ordertransaction a inner join OrderDetail b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID inner join Commission cm ON a.SaleDate BETWEEN cm.FromDate AND cm.ToDate inner join CommissionShopLink cs ON a.ShopID=cs.ShopID AND cm.CommissionID=cs.CommissionID inner join CommissionProducts cp ON cm.CommissionID=cp.CommissionID AND b.ProductID=cp.ProductID WHERE a.TransactionStatusID=2 AND a.ReceiptID>0 " + AdditionalQuery
		
		'errorMsg.InnerHtml = sqlStatement
		
		Dim CommData As DataTable = objDB.List(sqlStatement, objCnn)
		
		sqlStatement = "select SUM(TotalCashOutPrice) As TotalCashOut,CashMovement from session a, cashoutordertransaction b where a.CloseSessionDateTime is not NULL AND b.TransactionStatusID=2 AND a.SessionID=b.SessionID AND a.ComputerID=b.ComputerID" + SessionString
		
		Dim CashOutData As DataTable = objDB.List(sqlStatement, objCnn)
		
		sqlStatement = "select * from session a where a.CloseSessionDateTime is not NULL " + SessionString + " Order By a.SessionID"
		'errorMsg.InnerHtml = sqlStatement
		Dim SessionData As DataTable = objDB.List(sqlStatement, objCnn)
		
		Dim grossSaleExVAT As Double = 0
		Dim bgColor As String = "white"
        Dim TextClass As String = "smallText"
        Dim outputString As StringBuilder = New StringBuilder
        Dim grandTotalQty As Double = 0
        Dim grandTotal As Double = 0
        Dim subTotalQty As Double = 0
        Dim subTotal As Double = 0
		Dim RetailPriceBeforeVAT As Double = 0
		Dim DiscountBeforeVAT As Double = 0
		Dim SalePriceBeforeVAT As Double = 0
        Dim grandTotalDiscount As Double = 0
        Dim i, j As Integer
		Dim foundRows() As DataRow
        Dim expression As String
		
        For i = 0 To dtTable.Rows.Count - 1
            grandTotalQty += dtTable.Rows(i)("TotalQty")
            grandTotal += dtTable.Rows(i)("TotalRetailPrice")
            grandTotalDiscount += dtTable.Rows(i)("TotalDiscount")
			grossSaleExVAT += dtTable.Rows(i)("TotalRetailPriceBeforeVAT")
        Next
		
		Dim NetSale As Double = 0
		Dim grandTotalSale As Double = 0
		
		Dim NetSaleTotal As Double = 0
		Dim DiscountEx As Double = 0
		Dim TotalCustomer As Double = 0
		
		If Not IsDBNull(getData.Rows(0)("TotalSale")) Then
			grandTotalSale = getData.Rows(0)("TotalSale")
		End If
		
		If Not IsDBNull(getData.Rows(0)("TotalVAT")) Then
			NetSaleTotal = grandTotalSale - getData.Rows(0)("TotalVAT") - getData.Rows(0)("OtherIncome") - getData.Rows(0)("ServiceCharge")
		End If
		
		DiscountEx = grossSaleExVAT - NetSaleTotal
		
		If Not IsDBNull(getData.Rows(0)("TotalCustomer")) Then
			TotalCustomer = getData.Rows(0)("TotalCustomer")
		End If

        Dim CategorySummary As New DataTable
        CategorySummary.Columns.Add("Name", System.Type.GetType("System.String"))
        CategorySummary.Columns.Add("Qty", System.Type.GetType("System.Double"))
        CategorySummary.Columns.Add("QtyP", System.Type.GetType("System.Double"))
        CategorySummary.Columns.Add("Amount", System.Type.GetType("System.Double"))
        CategorySummary.Columns.Add("AmountP", System.Type.GetType("System.Double"))
        Dim rData As DataRow

        If dtTable.Rows.Count = 0 Then
            ResultString = ""
            ResultString2 = ""
            Exit Function
        End If

        For i = 0 To dtTable.Rows.Count - 1
            subTotalQty += dtTable.Rows(i)("TotalQty")
            subTotal += dtTable.Rows(i)("TotalRetailPrice")
			RetailPriceBeforeVAT += dtTable.Rows(i)("TotalRetailPriceBeforeVAT")
			DiscountBeforeVAT += dtTable.Rows(i)("TotalDiscountBeforeVAT")
			SalePriceBeforeVAT += dtTable.Rows(i)("TotalRetailPriceBeforeVAT") - dtTable.Rows(i)("TotalDiscountBeforeVAT")
            outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
            outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + dtTable.Rows(i)("ProductDeptName") + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("TotalQty"), "##,##0") + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("TotalQty") * 100 / grandTotalQty, "##,##0.00") + "%</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("TotalRetailPrice"), "##,##0.00") + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("TotalRetailPrice") * 100 / grandTotal, "##,##0.00") + "%</td>")
            outputString = outputString.Append("</tr>")
            If i <= dtTable.Rows.Count - 1 Then
                If i = dtTable.Rows.Count - 1 Then
                    outputString = outputString.Append("<tr bgColor=""#ebebeb"">")
                    outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + dtTable.Rows(i)("ProductGroupName") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalQty, "##,##0") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalQty * 100 / grandTotalQty, "##,##0.00") + "%</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotal, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotal * 100 / grandTotal, "##,##0.00") + "%</td>")
                    outputString = outputString.Append("</tr>")
                    rData = CategorySummary.NewRow
                    rData("Name") = dtTable.Rows(i)("ProductGroupName")
                    rData("Qty") = subTotalQty
                    rData("QtyP") = RetailPriceBeforeVAT
                    rData("Amount") = DiscountBeforeVAT
                    rData("AmountP") = SalePriceBeforeVAT
                    CategorySummary.Rows.Add(rData)
                Else
                    If dtTable.Rows(i)("ProductGroupCode") <> dtTable.Rows(i + 1)("ProductGroupCode") Then
                        outputString = outputString.Append("<tr bgColor=""#ebebeb"">")
                        outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + dtTable.Rows(i)("ProductGroupName") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalQty, "##,##0") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalQty * 100 / grandTotalQty, "##,##0.00") + "%</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotal, "##,##0.00") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotal * 100 / grandTotal, "##,##0.00") + "%</td>")
                        outputString = outputString.Append("</tr>")
                        rData = CategorySummary.NewRow
                        rData("Name") = dtTable.Rows(i)("ProductGroupName")
                        rData("Qty") = subTotalQty
                        rData("QtyP") = RetailPriceBeforeVAT
                        rData("Amount") = DiscountBeforeVAT
                        rData("AmountP") = SalePriceBeforeVAT
                        CategorySummary.Rows.Add(rData)
                        subTotal = 0
                        subTotalQty = 0
						RetailPriceBeforeVAT = 0
						DiscountBeforeVAT = 0
						SalePriceBeforeVAT = 0
                    End If
                End If
            End If
        Next

        

        outputString = outputString.Append("<tr bgColor=""#ebebeb"">")
        outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "Gross Sales (Inc VAT)" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(grandTotalQty, "##,##0") + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(grandTotalQty * 100 / grandTotalQty, "##,##0.00") + "%</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(grandTotal, "##,##0.00") + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(grandTotal * 100 / grandTotal, "##,##0.00") + "%</td>")
        outputString = outputString.Append("</tr>")
		
		outputString = outputString.Append("<tr>")
        outputString = outputString.Append("<td align=""left"" class=""" + "smallText" + """>" + "Discount (Inc VAT)" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + Format(grandTotalDiscount, "##,##0.00") + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
        outputString = outputString.Append("</tr>")
		
		If getData.Rows(0)("ServiceChargeIncVAT") > 0 Then
			outputString = outputString.Append("<tr>")
			outputString = outputString.Append("<td align=""left"" class=""" + "smallText" + """>" + "Service Charge (Inc VAT)" + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + Format(getData.Rows(0)("ServiceChargeIncVAT"), "##,##0.00") + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
			outputString = outputString.Append("</tr>")
		End If
		
		If getData.Rows(0)("OtherIncomeIncVAT") > 0 Then
			outputString = outputString.Append("<tr>")
			outputString = outputString.Append("<td align=""left"" class=""" + "smallText" + """>" + "Other Income (Inc VAT)" + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + Format(getData.Rows(0)("OtherIncomeIncVAT"), "##,##0.00") + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
			outputString = outputString.Append("</tr>")
		End If
		
		outputString = outputString.Append("<tr>")
        outputString = outputString.Append("<td align=""left"" class=""" + "smallText" + """>" + "Gross Sale (Ex VAT)" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + Format(grossSaleExVAT, "##,##0.00") + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
        outputString = outputString.Append("</tr>")
		
		
		
		outputString = outputString.Append("<tr>")
        outputString = outputString.Append("<td align=""left"" class=""" + "smallText" + """>" + "Discount (Ex VAT)" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + Format(DiscountEx, "##,##0.00") + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
        outputString = outputString.Append("</tr>")
		
		outputString = outputString.Append("<tr>")
        outputString = outputString.Append("<td align=""left"" class=""" + "smallText" + """>" + "Net Sale (Ex VAT)" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + Format(NetSaleTotal, "##,##0.00") + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
        outputString = outputString.Append("</tr>")
		
		If getData.Rows(0)("ServiceCharge") > 0 Then
			outputString = outputString.Append("<tr>")
			outputString = outputString.Append("<td align=""left"" class=""" + "smallText" + """>" + "Service Charge (Ex VAT)" + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + Format(getData.Rows(0)("ServiceCharge"), "##,##0.00") + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
			outputString = outputString.Append("</tr>")
		End If
		
		If getData.Rows(0)("OtherIncome") > 0 Then
			outputString = outputString.Append("<tr>")
			outputString = outputString.Append("<td align=""left"" class=""" + "smallText" + """>" + "Other Income (Ex VAT)" + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + Format(getData.Rows(0)("OtherIncome"), "##,##0.00") + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
			outputString = outputString.Append("</tr>")
		End If
        outputString = outputString.Append("<tr>")
        outputString = outputString.Append("<td align=""left"" class=""" + "smallText" + """>" + "VAT" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + Format(getData.Rows(0)("TotalVAT"), "##,##0.00") + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """>" + "" + "</td>")
        outputString = outputString.Append("</tr>")

        Dim grandTotalQtySale As Double = grandTotalQty

        outputString = outputString.Append("<tr bgColor=""#ebebeb"">")
        outputString = outputString.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "Total Sales" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + "" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + "" + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(grandTotalSale, "##,##0.00") + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + "" + "</td>")
        outputString = outputString.Append("</tr>")
        ResultString = outputString.ToString


        Dim outputString2 As StringBuilder = New StringBuilder
        dtTable = objDB.List(sqlStatement1, objCnn)
		
		outputString2 = outputString2.Append("<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">")
        outputString2 = outputString2.Append("<tr>")
        outputString2 = outputString2.Append("<td class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">Payment Type</td>")
        outputString2 = outputString2.Append("<td class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">Qty</td>")
        outputString2 = outputString2.Append("<td class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">%</td>")
        outputString2 = outputString2.Append("<td class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">Amount</td>")
        outputString2 = outputString2.Append("<td class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">%</td>")
        outputString2 = outputString2.Append("</tr>")

        subTotalQty = 0
        subTotal = 0
        grandTotalQty = 0
        grandTotal = 0
		Dim TotalCash As Double = 0
        For i = 0 To dtTable.Rows.Count - 1
            grandTotalQty += dtTable.Rows(i)("TotalQty")
            grandTotal += dtTable.Rows(i)("TotalPay")
        Next
        For i = 0 To dtTable.Rows.Count - 1
            subTotalQty += dtTable.Rows(i)("TotalQty")
            subTotal += dtTable.Rows(i)("TotalPay")
            outputString2 = outputString2.Append("<tr bgColor=""" + bgColor + """>")
            outputString2 = outputString2.Append("<td align=""left"" class=""" + TextClass + """>" + dtTable.Rows(i)("CreditCardType") + "</td>")
            outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("TotalQty"), "##,##0") + "</td>")
            outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("TotalQty") * 100 / grandTotalQty, "##,##0.00") + "%</td>")
            outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("TotalPay"), "##,##0.00") + "</td>")
            outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("TotalPay") * 100 / grandTotal, "##,##0.00") + "%</td>")
            outputString2 = outputString2.Append("</tr>")
			If dtTable.Rows(i)("PayTypeID") = 1 Then
				TotalCash += dtTable.Rows(i)("TotalPay")
			End If
            If i <= dtTable.Rows.Count - 1 Then
                If i = dtTable.Rows.Count - 1 Then
                    outputString2 = outputString2.Append("<tr bgColor=""#ebebeb"">")
                    outputString2 = outputString2.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + dtTable.Rows(i)("PayTypeName") + "</td>")
                    outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalQty, "##,##0") + "</td>")
                    outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalQty * 100 / grandTotalQty, "##,##0.00") + "%</td>")
                    outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotal, "##,##0.00") + "</td>")
                    outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotal * 100 / grandTotal, "##,##0.00") + "%</td>")
                    outputString2 = outputString2.Append("</tr>")
                Else
                    If dtTable.Rows(i)("PayTypeID") <> dtTable.Rows(i + 1)("PayTypeID") Then
                        outputString2 = outputString2.Append("<tr bgColor=""#ebebeb"">")
                        outputString2 = outputString2.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + dtTable.Rows(i)("PayTypeName") + "</td>")
                        outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalQty, "##,##0") + "</td>")
                        outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotalQty * 100 / grandTotalQty, "##,##0.00") + "%</td>")
                        outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotal, "##,##0.00") + "</td>")
                        outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(subTotal * 100 / grandTotal, "##,##0.00") + "%</td>")
                        outputString2 = outputString2.Append("</tr>")
                        subTotal = 0
                        subTotalQty = 0
                    End If
                End If
            End If
        Next

        outputString2 = outputString2.Append("<tr bgColor=""#ebebeb"">")
        outputString2 = outputString2.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "Total Received" + "</td>")
        outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(grandTotalQty, "##,##0") + "</td>")
        outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(grandTotalQty * 100 / grandTotalQty, "##,##0.00") + "%</td>")
        outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(grandTotal, "##,##0.00") + "</td>")
        outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(grandTotal * 100 / grandTotal, "##,##0.00") + "%</td>")
        outputString2 = outputString2.Append("</tr>")

        outputString2 = outputString2.Append("<tr bgColor=""#ebebeb"">")
        outputString2 = outputString2.Append("<td align=""left"" class=""" + "smallboldtext" + """>" + "Diff Sale & Payment" + "</td>")
        outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + "" + "</td>")
        outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + "" + "</td>")
        outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(grandTotal - grandTotalSale, "##,##0.00") + "</td>")
        outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + "" + "</td>")
        outputString2 = outputString2.Append("</tr>")
		

        outputString2 = outputString2.Append("<tr>")
        outputString2 = outputString2.Append("<td colspan=""5"" align=""center"" class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">Sales By Category (Ex VAT)</td>")
        outputString2 = outputString2.Append("</tr>")
		
		outputString2 = outputString2.Append("<tr>")
        outputString2 = outputString2.Append("<td class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">Name</td>")
        outputString2 = outputString2.Append("<td class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">Qty</td>")
        outputString2 = outputString2.Append("<td class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">Amount</td>")
        outputString2 = outputString2.Append("<td class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">Discount</td>")
        outputString2 = outputString2.Append("<td class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">Net</td>")
        outputString2 = outputString2.Append("</tr>")
		
		Dim sumQty As Double = 0
		Dim sumRetailPrice As Double = 0
		Dim sumDiscount As Double = 0
		Dim sumSalePrice As Double = 0
		Dim DiscountCal As Double = 0
		Dim SalePriceCal As Double = 0
		
		Dim CatNewSum As New DataTable
        CatNewSum.Columns.Add("Name", System.Type.GetType("System.String"))
        CatNewSum.Columns.Add("Qty", System.Type.GetType("System.Double"))
        CatNewSum.Columns.Add("RetailPrice", System.Type.GetType("System.Double"))
        CatNewSum.Columns.Add("Discount", System.Type.GetType("System.Double"))
        CatNewSum.Columns.Add("SalePrice", System.Type.GetType("System.Double"))
		
        For i = 0 To CategorySummary.Rows.Count - 1
			sumQty += CategorySummary.Rows(i)("Qty")
			sumRetailPrice += CategorySummary.Rows(i)("QtyP")
			sumDiscount += CategorySummary.Rows(i)("Amount")
			
			If sumDiscount > DiscountEx Then
				DiscountCal = DiscountEx - (sumDiscount - CategorySummary.Rows(i)("Amount"))
				sumDiscount -= CategorySummary.Rows(i)("Amount")
				sumDiscount += DiscountCal
				SalePriceCal = CategorySummary.Rows(i)("QtyP") - DiscountCal
			Else
				DiscountCal = CategorySummary.Rows(i)("Amount")
				SalePriceCal = CategorySummary.Rows(i)("AmountP")
			End If
			sumSalePrice += SalePriceCal
			
            outputString2 = outputString2.Append("<tr>")
            outputString2 = outputString2.Append("<td align=""left"" class=""" + TextClass + """>" + CategorySummary.Rows(i)("Name") + "</td>")
            outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(CategorySummary.Rows(i)("Qty"), "##,##0") + "</td>")
            outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(CategorySummary.Rows(i)("QtyP"), "##,##0.00") + "</td>")
            outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(DiscountCal, "##,##0.00") + "</td>")
            outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(SalePriceCal, "##,##0.00") + "</td>")
            outputString2 = outputString2.Append("</tr>")
			
			rData = CatNewSum.NewRow
			rData("Name") = CategorySummary.Rows(i)("Name")
			rData("Qty") = CategorySummary.Rows(i)("Qty")
			rData("RetailPrice") = CategorySummary.Rows(i)("QtyP")
			rData("Discount") = DiscountCal
			rData("SalePrice") = SalePriceCal
			CatNewSum.Rows.Add(rData)
			
        Next
		outputString2 = outputString2.Append("<tr bgColor=""#ebebeb"">")
		outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + "Summary" + "</td>")
		outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(sumQty, "##,##0") + "</td>")
		outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(sumRetailPrice, "##,##0.00") + "</td>")
		outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(sumDiscount, "##,##0.00") + "</td>")
		outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(sumSalePrice, "##,##0.00") + "</td>")
		outputString2 = outputString2.Append("</tr>")
		
		outputString2 = outputString2.Append("<tr>")
        outputString2 = outputString2.Append("<td colspan=""5"" align=""center"" class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">No Person Statistics (Ex VAT)</td>")
        outputString2 = outputString2.Append("</tr>")
		
		outputString2 = outputString2.Append("<tr>")
		outputString2 = outputString2.Append("<td align=""left"" colspan=""3"" class=""" + TextClass + """>" + "No Person Serve" + "</td>")
		outputString2 = outputString2.Append("<td align=""right"" colspan=""2"" class=""" + TextClass + """>" + Format(TotalCustomer, "##,##0.00") + "</td>")
		outputString2 = outputString2.Append("</tr>")
		
		outputString2 = outputString2.Append("<tr>")
        outputString2 = outputString2.Append("<td colspan=""2"" class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">Description</td>")
		outputString2 = outputString2.Append("<td class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">Amount</td>")
        outputString2 = outputString2.Append("<td class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">Avg/Person</td>")
        outputString2 = outputString2.Append("<td class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">%</td>")
        outputString2 = outputString2.Append("</tr>")

		Dim TotalAvg As Double = 0	
		Dim sumNetAvg As Double = 0

		For i = 0 To CatNewSum.Rows.Count - 1

			bgColor = "white"
	
			If CatNewSum.Rows(i)("Discount") > 0 Then
				outputString2 = outputString2.Append("<tr bgColor=""" + bgColor + """>")
				outputString2 = outputString2.Append("<td align=""left"" colspan=""2"" class=""" + TextClass + """>" + CatNewSum.Rows(i)("Name") + " (Ex VAT)</td>")
				outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(CatNewSum.Rows(i)("RetailPrice"), "##,##0.00") + "</td>")
				outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(CatNewSum.Rows(i)("RetailPrice")/TotalCustomer, "##,##0.00") + "</td>")
				outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(CatNewSum.Rows(i)("RetailPrice")*100/NetSaleTotal, "##,##0.00") + "%</td>")
				outputString2 = outputString2.Append("</tr>")
				
				outputString2 = outputString2.Append("<tr bgColor=""" + bgColor + """>")
				outputString2 = outputString2.Append("<td align=""left"" colspan=""2"" class=""" + TextClass + """>Discount " + CatNewSum.Rows(i)("Name") + " (Ex VAT)</td>")
				outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(-CatNewSum.Rows(i)("Discount"), "##,##0.00") + "</td>")
				outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(-CatNewSum.Rows(i)("Discount")/TotalCustomer, "##,##0.00") + "</td>")
				outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(-CatNewSum.Rows(i)("Discount")*100/NetSaleTotal, "##,##0.00") + "%</td>")
				outputString2 = outputString2.Append("</tr>")
			End If
			outputString2 = outputString2.Append("<tr bgColor=""#f1f1f1"">")
            outputString2 = outputString2.Append("<td align=""left"" colspan=""2"" class=""" + TextClass + """>Net " + CatNewSum.Rows(i)("Name") + " (Ex VAT)</td>")
			outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(CatNewSum.Rows(i)("SalePrice"), "##,##0.00") + "</td>")
            outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(CatNewSum.Rows(i)("SalePrice")/TotalCustomer, "##,##0.00") + "</td>")
    		outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(CatNewSum.Rows(i)("SalePrice")*100/NetSaleTotal, "##,##0.00") + "%</td>")
            outputString2 = outputString2.Append("</tr>")
			sumNetAvg += Math.Round(CatNewSum.Rows(i)("SalePrice")/TotalCustomer,2)
		Next
		
		outputString2 = outputString2.Append("<tr bgColor=""#ebebeb"">")
		outputString2 = outputString2.Append("<td align=""right"" colspan=""2"" class=""" + "smallboldtext" + """>" + "Summary" + "</td>")
		outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(sumSalePrice, "##,##0.00") + "</td>")
		outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(sumNetAvg, "##,##0.00") + "</td>")
		outputString2 = outputString2.Append("<td align=""right"" class=""" + "smallboldtext" + """>" + Format(100, "##,##0.00") + "%</td>")
		outputString2 = outputString2.Append("</tr>")
		
		Dim OpenSession As Double = 0
		Dim CloseSession As Double = 0
		Dim ShortOverSession As Double = 0
		Dim TotalCashIn As Double = 0
		Dim TotalCashOut As Double = 0
		Dim SubTotalCash As Double = 0
		Dim CommissionValue As Double = 0
		
		If Not IsDBNull(CommData.Rows(0)("TotalComm")) Then
			CommissionValue = CommData.Rows(0)("TotalComm")
		End If
		
		If ViewOption = 0 Then
			For i = 0 To SessionData.Rows.Count - 1
				If OpenSession = 0 Then
					OpenSession = SessionData.Rows(i)("OpenSessionAmount")
				End If
				CloseSession += SessionData.Rows(i)("CloseSessionAmount")
				ShortOverSession += SessionData.Rows(i)("CashShortOver")
			Next
			
			expression = "CashMovement = 1"
			foundRows = CashOutData.Select(expression)
			
			If foundRows.GetUpperBound(0) >= 0 Then
				TotalCashIn = foundRows(0)("TotalCashOut")
			End If
			
			expression = "CashMovement = -1"
			foundRows = CashOutData.Select(expression)
			
			If foundRows.GetUpperBound(0) >= 0 Then
				TotalCashOut = foundRows(0)("TotalCashOut")*-1
			End If
			
			SubTotalCash = OpenSession+TotalCash+TotalCashIn+TotalCashOut

			outputString2 = outputString2.Append("<tr>")
			outputString2 = outputString2.Append("<td colspan=""5"" align=""center"" class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">Daily Cash Summary</td>")
			outputString2 = outputString2.Append("</tr>")
			outputString2 = outputString2.Append("<tr>")
			outputString2 = outputString2.Append("<td colspan=""3"" align=""left"" class=""" + TextClass + """>" + "Open Shift Amount" + "</td>")
			outputString2 = outputString2.Append("<td colspan=""2"" align=""right"" class=""" + TextClass + """>" + Format(OpenSession, "##,##0.00") + "</td>")
			outputString2 = outputString2.Append("</tr>")
			outputString2 = outputString2.Append("<tr>")
			outputString2 = outputString2.Append("<td colspan=""3"" align=""left"" class=""" + TextClass + """>" + "Cash Sales" + "</td>")
			outputString2 = outputString2.Append("<td colspan=""2"" align=""right"" class=""" + TextClass + """>" + Format(TotalCash, "##,##0.00") + "</td>")
			outputString2 = outputString2.Append("</tr>")
			outputString2 = outputString2.Append("<tr>")
			outputString2 = outputString2.Append("<td colspan=""3"" align=""left"" class=""" + TextClass + """>" + "Cash In" + "</td>")
			outputString2 = outputString2.Append("<td colspan=""2"" align=""right"" class=""" + TextClass + """>" + Format(TotalCashIn, "##,##0.00") + "</td>")
			outputString2 = outputString2.Append("</tr>")
			outputString2 = outputString2.Append("<tr>")
			outputString2 = outputString2.Append("<td colspan=""3"" align=""left"" class=""" + TextClass + """>" + "Cash Out" + "</td>")
			outputString2 = outputString2.Append("<td colspan=""2"" align=""right"" class=""" + TextClass + """>" + Format(TotalCashOut, "##,##0.00") + "</td>")
			outputString2 = outputString2.Append("</tr>")
			outputString2 = outputString2.Append("<tr>")
			outputString2 = outputString2.Append("<tr bgColor=""#f1f1f1"">")
			outputString2 = outputString2.Append("<td colspan=""3"" align=""right"" class=""" + TextClass + """>" + "Sub Total" + "</td>")
			outputString2 = outputString2.Append("<td colspan=""2"" align=""right"" class=""" + TextClass + """>" + Format(SubTotalCash, "##,##0.00") + "</td>")
			outputString2 = outputString2.Append("</tr>")
			outputString2 = outputString2.Append("<tr>")
			outputString2 = outputString2.Append("<td colspan=""3"" align=""left"" class=""" + TextClass + """>" + "Cash Count" + "</td>")
			outputString2 = outputString2.Append("<td colspan=""2"" align=""right"" class=""" + TextClass + """>" + Format(CloseSession, "##,##0.00") + "</td>")
			outputString2 = outputString2.Append("</tr>")
			outputString2 = outputString2.Append("<tr bgColor=""#f1f1f1"">")
			outputString2 = outputString2.Append("<td colspan=""3"" align=""right"" class=""" + TextClass + """>" + "Short/Over" + "</td>")
			outputString2 = outputString2.Append("<td colspan=""2"" align=""right"" class=""" + TextClass + """>" + Format(ShortOverSession, "##,##0.00") + "</td>")
			outputString2 = outputString2.Append("</tr>")
			outputString2 = outputString2.Append("<tr>")
			outputString2 = outputString2.Append("<td colspan=""3"" align=""left"" class=""" + TextClass + """>" + "Cash Balance" + "</td>")
			outputString2 = outputString2.Append("<td colspan=""2"" align=""right"" class=""" + TextClass + """>" + Format(SubTotalCash-OpenSession-CommissionValue, "##,##0.00") + "</td>")
			outputString2 = outputString2.Append("</tr>")
		End If
		
		outputString2 = outputString2.Append("<tr>")
        outputString2 = outputString2.Append("<td colspan=""5"" align=""center"" class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">Commission Information</td>")
        outputString2 = outputString2.Append("</tr>")
		
		outputString2 = outputString2.Append("<tr>")
        outputString2 = outputString2.Append("<td colspan=""2"" class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">Description</td>")
        outputString2 = outputString2.Append("<td class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">Total Sale</td>")
		outputString2 = outputString2.Append("<td class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">Commission</td>")
        outputString2 = outputString2.Append("<td class=""smalltdHeader"" bgcolor=""" + AdminBGColor + """ align=""center"">%</td>")
        outputString2 = outputString2.Append("</tr>")
		
		
		
		If Not IsDBNull(CommData.Rows(0)("TotalComm")) Then
			outputString2 = outputString2.Append("<tr>")
            outputString2 = outputString2.Append("<td colspan=""2"" align=""left"" class=""" + TextClass + """>" + "Commission" + "</td>")
            outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(NetSaleTotal, "##,##0.00") + "</td>")
            outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(CommissionValue, "##,##0.00") + "</td>")
            outputString2 = outputString2.Append("<td align=""right"" class=""" + TextClass + """>" + Format(CommissionValue*100/NetSaleTotal, "##,##0.00") + "%</td>")
            outputString2 = outputString2.Append("</tr>")
		End If
		
		outputString2 = outputString2.Append("</table>")

        ResultString2 = outputString2.ToString

    End Function
		
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
