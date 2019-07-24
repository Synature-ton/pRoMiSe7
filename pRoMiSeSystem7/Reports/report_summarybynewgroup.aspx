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
<%@Import Namespace="ReportByNewGroup" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Summary Sale Reports By Department</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<input type="hidden" id="ShopIDList" runat="server" />
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
				<td><asp:button ID="SubmitForm" Font-Size="8" Height="25" Width="120" OnClick="DoSearch" runat="server" />&nbsp;<asp:CheckBox ID="DisplayGraph" CssClass="text" Visible="false" Checked="false" runat="server" /></td>
			</tr>
			<tr>
				<td><asp:Button ID="ExportExcel" OnClick="ExportToExcel" Height="25" Font-Size="8" Width="120" Text="Export To Excel" runat="server"></asp:Button>
			</td>
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
		<tr>
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
<table width="100%">

<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>

<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
</table>
<span id="startTable" runat="server"></span>

	<tr>
		<td id="headerTD11" align="center" class="smallTdHeader" runat="server"><div id="Text11" runat="server"></div></td>
		<td id="headerTD12" align="center" class="smallTdHeader" runat="server"><div id="Text12" runat="server"></div></td>
		<td id="headerTD13" align="center" class="smallTdHeader" runat="server"><div id="Text13" runat="server"></div></td>
		<td id="headerTD1" align="center" class="smallTdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD2" align="center" class="smallTdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD3" align="center" class="smallTdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD4" align="center" class="smallTdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td id="headerTD5" align="center" class="smallTdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<td id="headerTD6" align="center" class="smallTdHeader" runat="server"><div id="Text6" runat="server"></div></td>
		<td id="headerTD7" align="center" class="smallTdHeader" runat="server"><div id="Text7" runat="server"></div></td>
		<td id="headerTD8" align="center" class="smallTdHeader" runat="server"><div id="Text8" runat="server"></div></td>
		<td id="headerTD9" align="center" class="smallTdHeader" runat="server"><div id="Text9" runat="server"></div></td>
		<td id="headerTD10" align="center" class="smallTdHeader" runat="server"><div id="Text10" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>

<asp:Panel ID="showGraph" Visible="false" runat="server">
<br>
<Web:ChartControl id="ChartControl1" runat="Server" />
</asp:Panel>
<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table>
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
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim rpt As New ReportClass()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_ByNewGroup") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		'ExportExcel.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(ExportExcel).ToString
			
	  	headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor
		headerTD6.BgColor = GlobalParam.AdminBGColor
		headerTD7.BgColor = GlobalParam.AdminBGColor
		headerTD8.BgColor = GlobalParam.AdminBGColor
		headerTD9.BgColor = GlobalParam.AdminBGColor
		headerTD10.BgColor = GlobalParam.AdminBGColor
		headerTD11.BgColor = GlobalParam.AdminBGColor
		headerTD12.BgColor = GlobalParam.AdminBGColor
		headerTD13.BgColor = GlobalParam.AdminBGColor
		
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(13,Session("LangID"),objCnn)
		Dim textTable1 As New DataTable()
		textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)

		SubmitForm.Text = textTable.Rows(8)("TextParamValue")
		
		headerTD1.Visible = True
		headerTD2.Visible = True
		headerTD3.Visible = True
		headerTD4.Visible = True
		headerTD5.Visible = True
		headerTD6.Visible = True
		headerTD7.Visible = True
		headerTD8.Visible = True
		headerTD9.Visible = True
		headerTD10.Visible = True
		headerTD11.Visible = True
		headerTD12.Visible = True
		headerTD13.Visible = True
		


		StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		
		Text11.InnerHtml = "Shop Code"
		Text12.InnerHtml = "Shop Name"
		Text13.InnerHtml = "Product Dept"
		Text1.InnerHtml = "Code"
		Text2.InnerHtml = "Product"
		Text3.InnerHtml = "Qty"
		Text4.InnerHtml = "%"
		Text5.InnerHtml = "Sub Total"
		Text6.InnerHtml = "%"
		Text7.InnerHtml = "SC"
		Text8.InnerHtml = "Discount"
		Text9.InnerHtml = "Total Sale"
		Text10.InnerHtml = "%"
		
		GroupByParam.Items(0).Text = "Group By Day of Week"
		GroupByParam.Items(0).Value = "1"
		GroupByParam.Items(1).Text = "Group By Time"
		GroupByParam.Items(1).Value = "2"
		
		If Request.Form("ShopID") = 0 Then
			If Radio_11.Checked = True Then
				Text1.InnerHtml  = "Shop Name"
				headerTD12.Visible = True
			End If
			
		End If
		ExpandReceipt.Text = "Show Receipt Details"
		DisplayGraph.Text = "Display Graph for Monthly Report and Date Range Report"
		
		DocumentToDateParam.InnerHtml = defaultTextTable.Rows(91)("TextParamValue")
		
		Dim HeaderReport As DataTable = getProp.PermissionName(1024,Session("LangID"),objCnn)
		
		If HeaderReport.Rows.Count > 0 Then
			LangText0.Text = HeaderReport.Rows(0)("PermissionItemName")
		Else
			LangText0.Text = "Summary Sale Reports By Department"
		End If
		
		ReportName.Value = LangText0.Text
			
		DailyDate.YearType = GlobalParam.YearType
		DailyDate.FormName = "DocDaily"
		DailyDate.StartYear = 1
		DailyDate.EndYear = 2
		DailyDate.LangID = Session("LangID")
		'DailyDate.Lang_Data = LangDefault
		'DailyDate.Culture = CultureString
		
		CurrentDate.YearType = GlobalParam.YearType
		CurrentDate.FormName = "Doc"
		CurrentDate.StartYear = 1
		CurrentDate.EndYear = 2
		CurrentDate.LangID = Session("LangID")
		'CurrentDate.Lang_Data = LangDefault
		'CurrentDate.Culture = CultureString
		
		ToDate.YearType = GlobalParam.YearType
		ToDate.FormName = "DocTo"
		ToDate.StartYear = 1
		ToDate.EndYear = 2
		ToDate.LangID = Session("LangID")
		'ToDate.Lang_Data = LangDefault
		'ToDate.Culture = CultureString
		
		MonthYearDate.YearType = GlobalParam.YearType
		MonthYearDate.FormName = "MonthYearDate"
		MonthYearDate.StartYear = 1
		MonthYearDate.EndYear = 2
		MonthYearDate.LangID = Session("LangID")
		MonthYearDate.ShowDay = False
		'MonthYearDate.Lang_Data = LangDefault
		'MonthYearDate.Culture = CultureString
		
		YearDate.YearType = GlobalParam.YearType
		YearDate.FormName = "YearDate"
		YearDate.StartYear = 3
		YearDate.EndYear = 0
		YearDate.LangID = Session("LangID")
		YearDate.ShowDay = False
		YearDate.ShowMonth = False
		'YearDate.Lang_Data = LangDefault
		'YearDate.Culture = CultureString
		
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
		
		If IsNumeric(Request.Form("YearDate_Year")) Then 
			Session("YearDate_Year") = Request.Form("YearDate_Year")
		Else If IsNumeric(Request.QueryString("YearDate_Year")) Then 
			Session("YearDate_Year") = Request.QueryString("YearDate_Year")
		Else If Trim(Session("YearDate_Year")) = "" Then
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
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(12,Session("LangID"),objCnn)
			
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
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
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + defaultTextTable.Rows(45)("TextParamValue") + "</td></tr></table>"
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
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + defaultTextTable.Rows(45)("TextParamValue") + "</td></tr></table>"
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
		'If LangDefault.Rows.Count >= 3 Then
			'CreateReportDate.Text = "Create Report Date" & " " & DateTimeUtil.FormatDateTime(NOW(), "DateAndTime",Session("LangID"),objCnn)
		'End If
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
		Dim TestTime As String
        TestTime += "<br>" + DateTimeUtil.CurrentDateTime
		Application.Lock()
		Dim dtTable As DataTable = rpt.SaleReportByNewGroup_Summary(1,outputString, grandTotal, VATTotal, GraphData, PaymentResult, PayByCreditMoney, StartDate, EndDate, Request.Form("ShopID"),0,0, objCnn)
		TestTime += "<br>" + DateTimeUtil.CurrentDateTime
		rpt.GenOutputSaleByDept_Summary(outputString,grandTotal,VATTotal,False,GlobalParam.GrayBGColor,GlobalParam.AdminBGColor,dtTable,PaymentResult,PayByCreditMoney,Request.Form("ShopID"),StartDate,EndDate,objCnn)
		TestTime += "<br>" + DateTimeUtil.CurrentDateTime

		If Request.Form("ShopID") >= 0 Then
			ResultText.InnerHtml = outputString
		End If
		Dim ShopDisplay As String
		If Request.Form("ShopID") = 0 Then
			ShopDisplay = "All Shops"
		Else
			ShopDisplay = SelShopName.Value
		End If
		ResultSearchText.InnerHtml = "Summary Sale Report By Department of " + ShopDisplay + " (" + ReportDate + ")"
		Application.UnLock()
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
	
Sub ExportToExcel(Source As Object, E As EventArgs)
	Dim FoundError As Boolean
	FoundError = False
	Session("ReportResult") = ""
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(12,Session("LangID"),objCnn)
			
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
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
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + defaultTextTable.Rows(45)("TextParamValue") + "</td></tr></table>"
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
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + defaultTextTable.Rows(45)("TextParamValue") + "</td></tr></table>"
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
		'If LangDefault.Rows.Count >= 3 Then
		'	CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(NOW(), "DateAndTime",Session("LangID"),objCnn)
		'End If
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
		Dim TestTime As String
        TestTime += "<br>" + DateTimeUtil.CurrentDateTime
		Application.Lock()
		Dim dtTable As DataTable = rpt.SaleReportByNewGroup_Summary(1,outputString, grandTotal, VATTotal, GraphData, PaymentResult, PayByCreditMoney, StartDate, EndDate, Request.Form("ShopID"),0,0, objCnn)
		Application.UnLock()
		TestTime += "<br>" + DateTimeUtil.CurrentDateTime
		GenOutputSaleByDept_Summary_Excel(outputString,grandTotal,VATTotal,False,GlobalParam.GrayBGColor,GlobalParam.AdminBGColor,dtTable,PaymentResult,PayByCreditMoney,Request.Form("ShopID"),StartDate,EndDate,objCnn)
		TestTime += "<br>" + DateTimeUtil.CurrentDateTime

	End If
	

End Sub

Public Function GenOutputSaleByDept_Summary_Excel(ByRef outString As String, ByRef grandTotal As Double, ByRef VATTotal As Double, ByVal ShowSummary As Boolean, ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal dtTable As DataTable, ByVal PaymentResult As DataTable, ByVal PayByCreditMoney As DataTable, ByVal ShopID As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal objCnn As MySqlConnection) As String
			
	Dim filename As String = "ProductSaleData.csv"
	Response.Clear()
    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader("Content-Disposition", "attachment; filename=""" & filename & """")
	Response.Charset = "windows-874"
	Response.ContentEncoding = System.Text.Encoding.GetEncoding(874)
    Response.Flush()
	Response.Write("ShopCode,ShopName,ProductDept,ProductCode,ProductName,Qty,QtyPercent,SubTotal,SubTotalPercent,SC,Discount,TotalSale,TotalSalePercent" + chr(13) & chr(10))
	
	Dim i As Integer
	Dim outputString As StringBuilder = New StringBuilder
	Dim counter As Integer
	Dim ShowString As String = ""
	Dim DummyShopID As Integer
	Dim subTotalRetailPrice As Double = 0
	Dim subTotalPriceDiscount As Double = 0
	Dim subTotalDiscount As Double = 0
	Dim subTotalBeforeVAT As Double = 0
	Dim subTotalVAT As Double = 0
	Dim subTotalAfterVAT As Double = 0
	Dim subTotalOtherDiscount As Double = 0
	Dim subTotalQty As Double = 0
	Dim subTotalServiceCharge As Double = 0
	Dim subTotalServiceChargeVAT As Double = 0

	Dim grandTotalRetailPrice As Double = 0
	Dim grandTotalPriceDiscount As Double = 0
	Dim grandTotalDiscount As Double = 0
	Dim grandTotalBeforeVAT As Double = 0
	Dim grandTotalVAT As Double = 0
	Dim grandTotalAfterVAT As Double = 0
	Dim grandTotalOtherDiscount As Double = 0
	Dim grandTotalServiceCharge As Double = 0
	Dim grandTotalQty As Double = 0
	Dim grandTotalServiceChargeVAT As Double = 0


	Dim DiscountArray(7) As Double

	Dim RetailPriceAfterVAT As Double = 0
	Dim sqlCommand, TextClass As String
	Dim DummyGroupID, DummyDeptID, SectionString As Integer
	Dim VATString As String
	Dim TotalProductDiscount, EachSubTotal As Double
	Dim bgColor As String = "white" 'GlobalParam.GrayBGColor
	Dim ExtraInfo As String
	Dim DummyVAT As Double
	Dim DummySaleDate As Date
	Dim getProp As New CPreferences

	Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

	TextClass = "smallText"
	Dim PaymentString, compareString, ExtraPaymentString As String

	Dim CompareDeptID, CompareGroupID As Integer
	counter = 1
	Dim PriceDiscount, PricePerUnit, ProductQty, VATValue As Double

	Dim totalSale As Double = 0
	Dim totalQty As Integer = 0
	Dim totalRetailPrice As Double = 0
	Dim lineTotal As Double

	Dim myDataTable As DataTable = New DataTable("ParentTable")

	Dim myDataColumn As DataColumn
	Dim myDataRow As DataRow

	myDataColumn = New DataColumn
	myDataColumn.DataType = System.Type.GetType("System.String")
	myDataColumn.ColumnName = "ProductGroupName"
	myDataTable.Columns.Add(myDataColumn)

	myDataColumn = New DataColumn
	myDataColumn.DataType = System.Type.GetType("System.Double")
	myDataColumn.ColumnName = "ProductGroupSale"
	myDataTable.Columns.Add(myDataColumn)

	For i = 0 To dtTable.Rows.Count - 1
		If Not IsDBNull(dtTable.Rows(i)("SalePriceBeforeVAT")) And Not IsDBNull(dtTable.Rows(i)("ProductVAT")) And Not IsDBNull(dtTable.Rows(i)("ServiceChargeVAT")) Then
			totalSale += dtTable.Rows(i)("SalePriceBeforeVAT") + dtTable.Rows(i)("ProductVAT") + dtTable.Rows(i)("ServiceChargeVAT") + dtTable.Rows(i)("ServiceCharge")
		End If
		If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) And Not IsDBNull(dtTable.Rows(i)("ProductExcludeVAT")) Then
			totalRetailPrice += dtTable.Rows(i)("TotalRetailPrice") + dtTable.Rows(i)("ProductExcludeVAT")
		End If
		totalQty += dtTable.Rows(i)("Amount")
	Next

	For i = 0 To dtTable.Rows.Count - 1
		If Not IsDBNull(dtTable.Rows(i)("ProductGroupID")) Then
			CompareGroupID = dtTable.Rows(i)("ProductGroupID")
		Else
			CompareGroupID = 0
		End If

		If Not IsDBNull(dtTable.Rows(i)("ProductLevelCode")) Then
			Response.Write("""" + Replace(dtTable.Rows(i)("ProductLevelCode"),"""","""""") + """") 
		Else
			Response.Write("""" + "-" + """") 
		End If
		
		If Not IsDBNull(dtTable.Rows(i)("ProductLevelName")) Then
			Response.Write(",""" + Replace(dtTable.Rows(i)("ProductLevelName"),"""","""""") + """") 
		Else
			Response.Write(",""" + "-" + """") 
		End If
		
		If Not IsDBNull(dtTable.Rows(i)("ProductGroupName")) Then
			Response.Write(",""" + Replace(dtTable.Rows(i)("ProductGroupName"),"""","""""") + """") 
		Else
			Response.Write(",""" + "-" + """") 
		End If
		
		If Not IsDBNull(dtTable.Rows(i)("ProductDeptCode")) Then
			Response.Write(",""" + Replace(dtTable.Rows(i)("ProductDeptCode"),"""","""""") + """") 
		Else
			Response.Write(",""" + "-" + """") 
		End If

		If Not IsDBNull(dtTable.Rows(i)("ProductDeptName")) Then
			Response.Write(",""" + Replace(dtTable.Rows(i)("ProductDeptName"),"""","""""") + """") 
		Else
			Response.Write(",""" + "-" + """") 
		End If
		If Not IsDBNull(dtTable.Rows(i)("Amount")) Then
			Response.Write(",""" + Replace(Format(dtTable.Rows(i)("Amount"), "##,##0.0"),"""","""""") + """") 
			ProductQty = dtTable.Rows(i)("Amount")

			subTotalQty += ProductQty
			grandTotalQty += ProductQty
			Response.Write(",""" + Replace(Format((ProductQty / totalQty) * 100, "##,##0.00"),"""","""""") + """") 
		Else
			Response.Write(",""" + "0" + """") 
			Response.Write(",""" + "0" + """") 
			ProductQty = 0
		End If

		If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) And Not IsDBNull(dtTable.Rows(i)("ProductExcludeVAT")) Then

			RetailPriceAfterVAT = dtTable.Rows(i)("TotalRetailPrice") + dtTable.Rows(i)("ProductExcludeVAT")
			Response.Write(",""" + Replace(Format(RetailPriceAfterVAT, "##,##0.00"),"""","""""") + """") 
			Response.Write(",""" + Replace(Format((RetailPriceAfterVAT / totalRetailPrice) * 100, "##,##0.00"),"""","""""") + """") 

			subTotalRetailPrice += dtTable.Rows(i)("TotalRetailPrice") + dtTable.Rows(i)("ProductExcludeVAT")
			grandTotalRetailPrice += dtTable.Rows(i)("TotalRetailPrice") + dtTable.Rows(i)("ProductExcludeVAT")

		Else
			Response.Write(",""" + "0" + """") 
			Response.Write(",""" + "0" + """") 
		End If

		If Not IsDBNull(dtTable.Rows(i)("ServiceCharge")) And Not IsDBNull(dtTable.Rows(i)("ServiceChargeVAT")) Then

			Response.Write(",""" + Replace(Format(dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT"), "##,##0.00"),"""","""""") + """") 
			subTotalServiceCharge += dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT")
			grandTotalServiceCharge += dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT")

		Else
			Response.Write(",""" + "0" + """")
		End If

		If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalPrice")) Then
			PriceDiscount = dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalPrice")

			subTotalPriceDiscount += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalPrice")
			grandTotalPriceDiscount += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalPrice")

		Else
			PriceDiscount = 0

		End If


		TotalProductDiscount = 0
		If Not IsDBNull(dtTable.Rows(i)("MemberDiscount")) Then
			TotalProductDiscount += dtTable.Rows(i)("MemberDiscount")
			DiscountArray(2) += dtTable.Rows(i)("MemberDiscount")
		End If
		If Not IsDBNull(dtTable.Rows(i)("StaffDiscount")) Then
			TotalProductDiscount += dtTable.Rows(i)("StaffDiscount")
			DiscountArray(3) += dtTable.Rows(i)("StaffDiscount")
		End If
		If Not IsDBNull(dtTable.Rows(i)("CouponDiscount")) Then
			TotalProductDiscount += dtTable.Rows(i)("CouponDiscount")
			DiscountArray(4) += dtTable.Rows(i)("CouponDiscount")
		End If
		If Not IsDBNull(dtTable.Rows(i)("OtherPercentDiscount")) Then
			TotalProductDiscount += dtTable.Rows(i)("OtherPercentDiscount")
			DiscountArray(6) += dtTable.Rows(i)("OtherPercentDiscount")
		End If
		If Not IsDBNull(dtTable.Rows(i)("EachProductOtherDiscount")) Then
			TotalProductDiscount += dtTable.Rows(i)("EachProductOtherDiscount")
			DiscountArray(6) += dtTable.Rows(i)("EachProductOtherDiscount")
		End If
		If Not IsDBNull(dtTable.Rows(i)("VoucherDiscount")) Then
			TotalProductDiscount += dtTable.Rows(i)("VoucherDiscount")
			DiscountArray(5) += dtTable.Rows(i)("VoucherDiscount")
		End If
		If Not IsDBNull(dtTable.Rows(i)("CompensateOtherDiscount")) Then
			TotalProductDiscount += dtTable.Rows(i)("CompensateOtherDiscount")
			DiscountArray(6) += dtTable.Rows(i)("CompensateOtherDiscount")
		End If
		If Not IsDBNull(dtTable.Rows(i)("PricePromotionDiscount")) Then
			TotalProductDiscount += dtTable.Rows(i)("PricePromotionDiscount")
			DiscountArray(1) += dtTable.Rows(i)("PricePromotionDiscount")
		End If
		subTotalDiscount += TotalProductDiscount
		grandTotalDiscount += TotalProductDiscount

		Response.Write(",""" + Replace(Format(TotalProductDiscount + PriceDiscount, "##,##0.00"),"""","""""") + """") 

		If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) And Not IsDBNull(dtTable.Rows(i)("ProductExcludeVAT")) And Not IsDBNull(dtTable.Rows(i)("ServiceChargeVAT")) Then
			lineTotal = dtTable.Rows(i)("TotalRetailPrice") + dtTable.Rows(i)("ProductExcludeVAT") - TotalProductDiscount - PriceDiscount + dtTable.Rows(i)("ServiceChargeVAT") + dtTable.Rows(i)("ServiceCharge")
			Response.Write(",""" + Replace(Format(lineTotal, "##,##0.00"),"""","""""") + """") 
			Response.Write(",""" + Replace(Format((lineTotal) / totalSale * 100, "##,##0.00"),"""","""""") + """") 
			subTotalAfterVAT += lineTotal
			grandTotalAfterVAT += lineTotal

		Else
			Response.Write(",""" + "0" + """")
			Response.Write(",""" + "0" + """")
		End If

		counter = counter + 1

		If Not IsDBNull(dtTable.Rows(i)("ProductGroupID")) Then
			DummyGroupID = dtTable.Rows(i)("ProductGroupID")
		Else
			DummyGroupID = 0
		End If
		Response.Write(chr(13) & chr(10))
	Next
	Response.End()
	
End Function


</script>
</body>
</html>
