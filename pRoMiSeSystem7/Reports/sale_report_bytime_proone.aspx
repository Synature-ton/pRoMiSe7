<%@ Page Language="VB" ContentType="text/html" EnableViewState="False" debug="True" %>
<%@ Register tagPrefix="Web" Namespace="WebChart" Assembly="WebChart" %>
<%@ Import Namespace="System.Drawing" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<%@ Register tagprefix="synature" Tagname="time" Src="../UserControls/Time.ascx" %>

<html>
<head>
<title>Sale Reports By Time</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body<% = GlobalParam.BodyProp %>>
<div id="showPage" visible="true" runat="server">
<form runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<input type="hidden" id="ShopIDList" runat="server" />
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
			<tr id="bbb" visible="false" runat="Server">
				<td><asp:radiobutton ID="Radio_11" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
			<tr>
				<td><asp:radiobutton ID="Radio_12" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
			<tr id="showOption" visible="false" runat="server">
				<td><asp:radiobutton ID="Radio_13" GroupName="Group2" CssClass="text" runat="server" />
				<asp:dropdownlist ID="GroupByParam" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
			</tr>
			<tr>
				<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
			</tr>
		</table></td>
	<td>
	<table>
		<tr>
			<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
			<td><synature:date id="DailyDate" runat="server" /></td>
			<td colspan="2"><asp:CheckBox ID="ExpandReceipt" CssClass="text" Checked="false" Visible="false" runat="server" /></td>
		</tr>
		<tr>
			<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
			<td colspan="3"><synature:date id="MonthYearDate" runat="server" /></td>
		</tr>
		<tr id="showYearOption" visible="false" runat="Server">
			<td><asp:radiobutton ID="Radio_4" GroupName="Group1" runat="server" /></td>
			<td colspan="3"><synature:date id="YearDate" runat="server" /></td>
		</tr>
		<tr>
			<td><asp:radiobutton ID="Radio_2" GroupName="Group1" runat="server" /></td>
			<td><synature:date id="CurrentDate" runat="server" /></td>
			<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
			<td><synature:date id="ToDate" runat="server" /></td>
		</tr>
		<tr>
			<td></td>
			<td><synature:time id="FromTime" runat="server" /></td>
			<td class="text"><div id="ToTimeParam" class="text" runat="server"></div></td>
			<td><synature:time id="ToTime" runat="server" /></td>
		</tr>
		<tr id="aaa" visible="false" runat="Server"><td>&nbsp;</td>
			<td colspan="4"><asp:CheckBox ID="DisplayGraph" CssClass="text" Checked="false" Visible="false" runat="server" /></td>
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
	<span id="TableHeaderText" runat="server"></span>
	<span id="ExtraHeader" runat="server"></span>
	</tr>
	
	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>

<asp:Panel ID="showGraph" Visible="false" runat="server">
<br>
<Web:ChartControl id="ChartControl1" ChartPadding=40 runat="Server" />
</asp:Panel>
<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
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
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()

Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Sale_Report_ByTime") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(13,Session("LangID"),objCnn)
		Dim textTable1 As New DataTable()
		textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)

		SubmitForm.Text = textTable.Rows(8)("TextParamValue")
		Dim i As Integer
		ResultText.InnerHtml = ""
		ResultSearchText.InnerHtml = ""
		errorMsg.InnerHtml = ""
		ExtraHeader.InnerHtml = ""
		
		Dim HeaderString As String = ""
		
		If (Radio_11.Checked = True AND (Radio_1.Checked = True Or Radio_2.Checked = True Or Radio_4.Checked = True)) Or Radio_13.Checked = True Or (Request.Form("ShopID") = 0 And Radio_12.Checked = False) Or (Radio_11.Checked = True AND Radio_3.Checked = True And ExpandReceipt.Checked = False) Then
			If Radio_11.Checked = True AND Radio_3.Checked = True And ExpandReceipt.Checked = False And Request.Form("ShopID") > 0 Then
				HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Receipt #</td>"
			Else
				If Radio_13.Checked = True Then
					If Request.Form("GroupByParam") = 1 Then
						HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Day of Week</td>"
					Else
						HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Time Range</td>"
					End if
				ElseIf Radio_4.Checked = True Then
					HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Month</td>"
				Else
					If Request.Form("ShopID") = 0 Then
						HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Shop Name</td>"
					Else
						HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Date</td>"
					End If
				End If
				HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """># Bills</td>"		
			End If
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Total Price</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Disc</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>SC</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Total Sale</td>"
			If Request.Form("ShopID") = 0 Then
				HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>"
			End If
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Vatable</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Total VAT</td>"
			
		ElseIf Radio_12.Checked = True Then
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Code</td>"		
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Product Name</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Unit Price</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Qty</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>%</td>"
			
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Sub Total</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>%</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Discount</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Total</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>%</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>"
		Else
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Code</td>"		
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Product Name</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Unit Price</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Qty</td>"		
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Sub Total</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Discount</td>"
			'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Sub Total<br>(Before VAT)</td>"
			'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>VAT</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Total</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>"
		End If
		TableHeaderText.InnerHtml = HeaderString
		
		If Radio_3.Checked = True AND (Radio_11.Checked = True Or Radio_13.Checked = True) And ExpandReceipt.Checked = True AND Request.Form("ShopID") <> 0 Then
			StartTable.InnerHtml = "<table border=""0"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		Else
			StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		End If

		GroupByParam.Items(0).Text = "Group By Day of Week"
		GroupByParam.Items(0).Value = "1"
		GroupByParam.Items(1).Text = "Group By Time"
		GroupByParam.Items(1).Value = "2"
		If Request.Form("GroupByParam") = 1 Then
			GroupByParam.Items(0).Selected = True
		ElseIf Request.Form("GroupByParam") = 2 Then
			GroupByParam.Items(1).Selected = True
		Else
			GroupByParam.Items(0).Selected = True
		End If
		
		ExpandReceipt.Text = "Show Receipt Details"
		DisplayGraph.Text = "Display Graph for Monthly Report and Date Range Report"
		
		DocumentToDateParam.InnerHtml = defaultTextTable.Rows(91)("TextParamValue")
		ToTimeParam.InnerHtml = defaultTextTable.Rows(91)("TextParamValue")
		
		HeaderText.InnerHtml = "Sale Report By Time"
			
		DailyDate.YearType = GlobalParam.YearType
		DailyDate.FormName = "DocDaily"
		DailyDate.StartYear = GlobalParam.StartYear
		DailyDate.EndYear = GlobalParam.EndYear
		DailyDate.LangID = Session("LangID")
		
		CurrentDate.YearType = GlobalParam.YearType
		CurrentDate.FormName = "Doc"
		CurrentDate.StartYear = GlobalParam.StartYear
		CurrentDate.EndYear = GlobalParam.EndYear
		CurrentDate.LangID = Session("LangID")
		
		ToDate.YearType = GlobalParam.YearType
		ToDate.FormName = "DocTo"
		ToDate.StartYear = GlobalParam.StartYear
		ToDate.EndYear = GlobalParam.EndYear
		ToDate.LangID = Session("LangID")
		
		MonthYearDate.YearType = GlobalParam.YearType
		MonthYearDate.FormName = "MonthYearDate"
		MonthYearDate.StartYear = GlobalParam.StartYear
		MonthYearDate.EndYear = GlobalParam.EndYear
		MonthYearDate.LangID = Session("LangID")
		MonthYearDate.ShowDay = False
		
		YearDate.YearType = GlobalParam.YearType
		YearDate.FormName = "YearDate"
		YearDate.StartYear = GlobalParam.StartYear
		YearDate.EndYear = GlobalParam.EndYear
		YearDate.LangID = Session("LangID")
		YearDate.ShowDay = False
		YearDate.ShowMonth = False
		
		FromTime.LangID = Session("LangID")
		FromTime.FormName = "FromTime"
		FromTime.SelectedHour = -1
		FromTime.SelectedMinute = -1
		
		ToTime.LangID = Session("LangID")
		ToTime.FormName = "ToTime"
		ToTime.SelectedHour = -1
		ToTime.SelectedMinute = -1
		
		Radio_11.Text = "Reported By Bill"
		Radio_12.Text = "Reported By Products"
		
		
		
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
		
		If IsNumeric(Request.Form("FromTime_Hour")) Then 
			FromTime.SelectedHour = Request.Form("FromTime_Hour")
		End If
		If IsNumeric(Request.Form("FromTime_Minute")) Then 
			FromTime.SelectedMinute = Request.Form("FromTime_Minute")
		End If
		If IsNumeric(Request.Form("ToTime_Hour")) Then 
			ToTime.SelectedHour = Request.Form("ToTime_Hour")
		End If
		If IsNumeric(Request.Form("ToTime_Minute")) Then 
			ToTime.SelectedMinute = Request.Form("ToTime_Minute")
		End If
		
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

		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		Dim Multiple As Boolean = False
		Dim ShopList As String = ""
		
		Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
		If ShopData.Rows.Count > 0 Then

			outputString = "<select name=""ShopID"">"
			'If ShopData.Rows.Count > 1 Then
				'If Not Page.IsPostBack Then 
					'FormSelected = "selected"
				'ElseIf ShopIDValue = 0 Then
					'FormSelected = "selected"
				'Else
				'	'FormSelected = ""
				'End If
				'outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & "--- All Shops ---"
				'Multiple = True
			'End If
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
	Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
	Dim FoundError As Boolean
	FoundError = False
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(12,Session("LangID"),objCnn)
			
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""
	Dim DailyDateValue As String = ""
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	Dim AdditionalHeader As String = ""
	Dim PayTypeList As DataTable
	Dim i As Integer
	
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
	Dim outputString As String = ""
	Dim grandTotal As Double = 0
	Dim VATTotal As Double = 0
	Dim GraphData As New DataSet()
	Dim ReportDate As String
	Dim YearValue4 As Integer
	Dim R1,R2,R3,R4,R11,R12,R13 As Boolean
	
	R1 = False
	R2 = False
	R3 = False
	R4 = False
	If Request.Form("Group1") = "Radio_1" Then
		R1 = True
	ElseIf Request.Form("Group1") = "Radio_2" Then
		R2 = True
	ElseIf Request.Form("Group1") = "Radio_3" Then
		R3 = True
	Else
		R4 = True
	End If
	
	If Request.Form("Group2") = "Radio_11" Then
		R11 = True
	ElseIf Request.Form("Group2") = "Radio_12" Then
		R12 = True
	ElseIf Request.Form("Group2") = "Radio_13" Then
		R13 = True
	End If
	
	Dim ExpReceipt As Boolean = False
	If Request.Form("ExpandReceipt") = "on" Then ExpReceipt = True
	
	Dim DGraph As Boolean = False
	If Request.Form("DisplayGraph") = "on" Then DGraph = True
	
	If R1 = True Then
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
		ReportDate = Format(SDate,"MMMM yyyy")
		Catch ex As Exception
			FoundError = True
		End Try
	ElseIf R2 = True Then
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
			ReportDate = Format(SDate1, "dd MMMM yyyy") + " - " + Format(EDate1, "dd MMMM yyyy")
		End If
		Catch ex As Exception
			FoundError = True
		End Try
	Else If R3 = True Then
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
			ReportDate = Format(SDate2, "d MMMM yyyy")
		End If
		Catch ex As Exception
			FoundError = True
		End Try
	Else If R4 = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(1,1,Request.Form("YearDate_Year"))
		 
		YearValue4 = Request.Form("YearDate_Year") + 1
		EndDate = DateTimeUtil.FormatDate(1,1,YearValue4)
		Dim SDate4 As New Date(Request.Form("YearDate_Year"),1,1)
		ReportDate = Format(SDate4,"yyyy")
		Catch ex As Exception
			FoundError = True
		End Try
	Else
		DateFromValue = ""
		DateToValue = ""
		DailyDateValue = ""
	End If
	
	If FoundError = False Then

		Dim displayTable As New DataTable()
		
		ShowPrint.Visible = True
		ShowResults.Visible = True
		
		Dim ViewOption As Integer
		If R1 = True Then
			ViewOption = 1
		ElseIf R2 = True Then
			ViewOption = 2
		ElseIf R4 = True Then
			ViewOption = 4
		Else
			ViewOption = 0 
		End If
		Dim ReportTime As String
		If IsNumeric(Request.Form("FromTime_Hour")) AND IsNumeric(Request.Form("FromTime_Minute")) AND IsNumeric(Request.Form("ToTime_Hour")) AND IsNumeric(Request.Form("ToTime_Minute")) Then
			ReportTime = " Open time between " + Request.Form("FromTime_Hour") + ":" + Request.Form("FromTime_Minute") + " and " + Request.Form("ToTime_Hour") + ":" + Request.Form("ToTime_Minute")
		ElseIf IsNumeric(Request.Form("FromTime_Hour")) AND IsNumeric(Request.Form("FromTime_Minute"))
			ReportTime = " Open time >= " + Request.Form("FromTime_Hour") + ":" + Request.Form("FromTime_Minute")
		ElseIf IsNumeric(Request.Form("ToTime_Hour")) AND IsNumeric(Request.Form("ToTime_Minute"))
			ReportTime = " Open time <= " + Request.Form("ToTime_Hour") + ":" + Request.Form("ToTime_Minute")
		Else
			ReportTime = ""
		End If
		Application.Lock()
		
		If Request.Form("ShopID") > 0 Or (Request.Form("ShopID")=0 AND R12 = True) Then

			ResultText.InnerHtml = SaleReportsByTime(PayTypeList,outputString, grandTotal, VATTotal, GraphData, True,GlobalParam.GrayBGColor,GlobalParam.AdminBGColor,Session("LangID"),ViewOption,R11, R12, R13, Request.Form("GroupByParam"), StartDate, EndDate, Request.Form("FromTime_Hour"), Request.Form("FromTime_Minute"), Request.Form("ToTime_Hour"),Request.Form("ToTime_Minute"), Request.Form("ShopID"),0,0,True,ExpReceipt, DGraph, objCnn)
			If (R11 = True AND (R1 = True Or R2 = True Or R4 = True)) Or R13 = True Or (R11 = True AND R3 = True And ExpReceipt = False) Then
				Dim HavePrepaid As Boolean = False
				Dim HavePrepaidDiscount As Boolean = False
				Dim ExtraPayText As String
				For i = 0 To PayTypeList.Rows.Count - 1
					ExtraPayText = ""
					If PayTypeList.Rows(i)("PrepaidDiscountPercent") > 0 Then
						HavePrepaidDiscount = True
						ExtraPayText = "<br>Total/Disc"
					End If
					AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + PayTypeList.Rows(i)("PayTypeName") + ExtraPayText + "</td>"
					If PayTypeList.Rows(i)("IsSale") = 0 Then
						If PropertyInfo.Rows(0)("SummaryPrepaidInSaleReport") = 1 Then
							HavePrepaid = True
						End If	
					End If
				Next
			
				AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Total Payment" + "</td>"
				AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Diff" + "</td>"
				Dim NotInRevenueBit As Boolean = False
				Try
					NotInRevenueBit = PropertyInfo.Rows(0)("EnableNotInRevenue")
				Catch ex As Exception
					NotInRevenueBit = False
				End Try
				Try
				If NotInRevenueBit = True Then
					'Dim NotInRevenueData As DataTable = getReport.NotInRevenueType(objCnn)
					'For i = 0 to NotInRevenueData.Rows.Count - 1
						'AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + NotInRevenueData.Rows(i)("NotInRevenueName") + "</td>"
					'Next
					'AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Used Course" + "</td>"
					'HavePrepaidDiscount = True
				End If
				Catch ex As Exception
					NotInRevenueBit = False
				End Try
				If HavePrepaidDiscount = True  Then
					AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Total Revenue" + "</td>"
				End If
				If HavePrepaid = True Then
					AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Total Prepaid" + "</td>"
					AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Total Payment<br>(witout prepaid)" + "</td>"
				End If	
				
				ExtraHeader.InnerHtml = AdditionalHeader
			End If
		Else
			ResultText.InnerHtml = getReport.SaleReportsAll(outputString, grandTotal, GraphData, True,GlobalParam.GrayBGColor,GlobalParam.AdminBGColor,Session("LangID"),ViewOption,R11, R12, R13, Request.Form("GroupByParam"), StartDate, EndDate, ShopIDList.Value,0,0,True,ExpReceipt, DGraph, objCnn)
		End If
		
		Dim ShopDisplay As String
		If Request.Form("ShopID") = 0 Then
			ShopDisplay = "All Shops"
		Else
			ShopDisplay = SelShopName.Value
		End If
		ResultSearchText.InnerHtml = "Sale Report of " + ShopDisplay + " (" + ReportDate + ReportTime + ")"
		Application.UnLock()
		If DGraph = True AND (R3 = False Or (R3 = True AND Request.Form("ShopID")=0)) AND (R11 = True Or R13 = True) Then

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
			Dim ChartHeight As Integer = 450
			If Request.Form("Group2") = "Radio_13" Then
				If Request.Form("GroupByParam") = 1 Then
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
            ChartControl1.Legend.Width = 40
			ChartControl1.Width = Unit.Parse(ChartWidth.ToString + "px")
			ChartControl1.Height = Unit.Parse(ChartHeight.ToString + "px")
 
            ChartControl1.YAxisFont.ForeColor = Color.SteelBlue
            ChartControl1.XAxisFont.ForeColor = Color.SteelBlue
            
            ChartControl1.ChartTitle.Text = TitleName
            ChartControl1.ChartTitle.ForeColor = Color.White
      
            ChartControl1.Border.Color = Color.SteelBlue
            'ChartControl1.BorderStyle = BorderStyle.Ridge
    End Sub

Public Function SaleReportsByTime(ByRef PayTypeList As DataTable, ByRef outputString As String, ByRef grandTotal As Double, ByRef VATTotal As Double, ByRef GraphData As DataSet, ByVal ShowSummary As Boolean, ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal LangID As Integer, ByVal ViewOption As Integer, ByVal ReportByBill As Boolean, ByVal ReportByProduct As Boolean, ByVal ReportByTime As Boolean, ByVal GroupByParam As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal StartTimeHour As String, ByVal StartTimeMinute As String, ByVal EndTimeHour As String, ByVal EndTimeMinute As String, ByVal ShopID As Integer, ByVal TransactionID As Integer, ByVal ComputerID As Integer, ByVal DisplaySummary As Boolean, ByVal ExpandReceipt As Boolean, ByVal DisplayGraph As Boolean, ByVal objCnn As MySqlConnection) As String

            Dim sqlStatement, sqlStatement1, sqlStatement2, WhereString, WString, ExtraSql, ExtraSelect As String
            Dim AdditionalQuery As String = ""
            Dim ShopIDListValue As String = ""
            Dim ResultString As String = ""
            Dim TextClass As String
            Dim GetData As DataTable
            Dim PayTypeData As DataTable

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

            Dim NotInRevenueBit As Boolean = False
            Try
                NotInRevenueBit = PropertyInfo.Rows(0)("EnableNotInRevenue")
            Catch ex As Exception
                NotInRevenueBit = False
            End Try

			
			
            If ShopID = 0 Then
                Dim getInfo As New CCategory
                Dim ShopData As DataTable = getInfo.GetProductLevel(-999, objCnn)
                For ii = 0 To ShopData.Rows.Count - 1
                    ShopIDListValue += "," + ShopData.Rows(ii)("ProductLevelID").ToString
                Next
                If ShopIDListValue <> "" Then ShopIDListValue = "0" + ShopIDListValue
            Else
                ShopIDListValue = ShopID.ToString
            End If


            If TransactionID > 0 And ComputerID > 0 Then
                AdditionalQuery += " AND ( a.TransactionID = " + TransactionID.ToString + " AND a.ComputerID = " + ComputerID.ToString + ")"
            End If

            If ShopID > 0 Then
                AdditionalQuery += " AND a.ShopID IN (" + ShopIDListValue + ")"
                WhereString += " AND ShopID IN (" + ShopIDListValue + ")"
                WString += " AND a.ShopID IN (" + ShopIDListValue + ")"
            End If

            If StartDate <> "" And EndDate <> "" Then
                AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
                WhereString += " AND (PayDate >= " + StartDate + " AND PayDate < " + EndDate + ")"
                WString += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
            End If
			
			Dim StartTime As String = ""
			Dim EndTime As String = ""
			If IsNumeric(StartTimeHour) AND IsNumeric(StartTimeMinute) Then
				StartTime = StartTimeHour + ":" + StartTimeMinute + ":0"
				AdditionalQuery += " AND ( TIME_TO_SEC(a.OpenTime) >= TIME_TO_SEC('" + StartTime + "') )"
			End If
			If IsNumeric(EndTimeHour) AND IsNumeric(EndTimeMinute) Then
				EndTime = EndTimeHour + ":" + EndTimeMinute + ":0"
				AdditionalQuery += " AND ( TIME_TO_SEC(a.OpenTime) <= TIME_TO_SEC('" + EndTime + "') )"
			End If

            If Trim(WhereString) = "" Then
                WhereString = " AND 0=1"
                WString = " AND 0=1"
            End If
            Dim OrderBy As String = " a.DocType,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID,b.OrderDetailID,d.PayTypeID"

            sqlStatement = "select sum(payamount) AS TotalPay, sum(PaymentVAT) AS TotalVAT, a.PayTypeID,b.PayType AS PayTypeName from paybycreditmoney" + BranchStr + " a left outer join paytype b ON a.PayTypeID=b.TypeID where a.CreditMoneyStatusID=2 " + WhereString + " group by a.PayTypeID,b.PayType order by a.PayTypeID,b.PayType"
            Dim PayByCreditMoney As DataTable = objDB.List(sqlStatement, objCnn)



            sqlStatement2 = "select * from BankName where 0=1"
            PayTypeList = getReport.GetSalePayType(ShopID.ToString, StartDate, EndDate, objCnn)

            ExtraSql = ""
            ExtraSelect = ""

            If ReportByProduct = True Or (ReportByProduct = False And ViewOption = 0 And ExpandReceipt = True) Then

                sqlStatement = "select a.TransactionID,a.ComputerID,b.VATType,NoCustomer,SUM(c.SalePrice) AS TotalExcludePrice FROM OrderTransaction" + BranchStr + " a, OrderDetail" + BranchStr + " b, OrderDiscountDetail" + BranchStr + " c WHERE a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.OrderDetailID=c.OrderDetailID AND b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3) " + AdditionalQuery + " GROUP BY a.TransactionID,a.ComputerID,b.VATType,NoCustomer"

                objDB.sqlExecute("DROP TABLE IF EXISTS DummySaleReport", objCnn)

                objDB.sqlExecute("create table DummySaleReport (TransactionID int, ComputerID int, VATType tinyint, NoCustomer int ,TotalProductSale decimal(18,4))", objCnn)

                objDB.sqlExecute("insert into DummySaleReport " + sqlStatement, objCnn)

                If ReportByProduct = True Then
                    sqlStatement = "SELECT a.TransactionStatusID,b.ProductID,b.OtherFoodName,b.OrderStatusID,b.ProductSetType,b.VATType, p.ProductCode,p.ProductName, p.ProductDeptID,pd.ProductGroupID, pd.ProductDeptName,pg.ProductGroupName,SUM(b.Amount) AS Amount,SUM(c.TotalPrice) AS TotalPrice,SUM(c.TotalRetailPrice) AS TotalRetailPrice,SUM(f.TotalProductSale) AS TotalProductSale, SUM(Round(a.TransactionVAT,2)-Round(a.TransactionExcludeVAT,2)) AS TransactionIncludeVAT,  SUM(IF(b.VATType=1 , IF(a.TransactionVAT = 0, c.SalePrice-(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale),(c.SalePrice-(Round(a.TransactionVAT,2)-Round(a.TransactionExcludeVAT,2)-Round(ServiceChargeVAT,2))*c.SalePrice/f.TotalProductSale)-(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale)), IF(b.VATType=2 and a.TransactionVAT=0,c.SalePrice+(Round(a.TransactionExcludeVAT,2)*c.SalePrice/f.TotalProductSale)-(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale),c.SalePrice-(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale)))) AS SalePriceBeforeVAT, SUM(IF(b.VATType=1, IF(a.TransactionVAT = 0, 0, (Round(a.TransactionVAT,2)-Round(a.TransactionExcludeVAT,2)-Round(ServiceChargeVAT,2))*c.SalePrice/f.TotalProductSale), IF(b.VATType=2,IF(a.TransactionVAT = 0, 0, Round(a.TransactionExcludeVAT,2)*c.SalePrice/f.TotalProductSale),0))) AS ProductVAT, SUM(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale) AS CompensateOtherDiscount, SUM(c.MemberDiscount) AS MemberDiscount, SUM(c.StaffDiscount) AS StaffDiscount, SUM(c.CouponDiscount) AS CouponDiscount, SUM(c.VoucherDiscount) AS VoucherDiscount, SUM(c.OtherPercentDiscount) AS OtherPercentDiscount, SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount, SUM(c.PricePromotionDiscount) AS PricePromotionDiscount, SUM(IF(b.VATType=2,Round(a.TransactionExcludeVAT,2)*c.SalePrice/f.TotalProductSale,0)) AS ProductExcludeVAT FROM ordertransaction" + BranchStr + " a, orderdetail" + BranchStr + " b , orderdiscountdetail" + BranchStr + " c , DummySaleReport f  left outer join Products p ON b.ProductID=p.ProductID left outer join ProductDept pd ON p.ProductDeptID=pd.ProductDeptID left outer join ProductGroup pg ON pd.ProductGroupID=pg.ProductGroupID WHERE a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND b.OrderDetailID=c.OrderDetailID AND a.TransactionID=f.TransactionID AND a.ComputerID=f.ComputerID AND b.VATType=f.VATType AND a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3) AND a.TransactionStatusID=2 " + AdditionalQuery + "  GROUP BY a.TransactionStatusID,b.ProductID,b.OtherFoodName,b.OrderStatusID,b.ProductSetType,b.VATType, p.ProductCode,p.ProductName, p.ProductDeptID,pd.ProductGroupID, pd.ProductDeptName,pg.ProductGroupName ORDER BY pd.ProductGroupID,p.ProductDeptID,p.ProductName"
                    sqlStatement1 = "select b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT, IsOtherReceipt from ordertransaction" + BranchStr + " a, paydetail" + BranchStr + " b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.PayTypeID=c.TypeID and a.TransactionStatusID=2 " + AdditionalQuery + " group by b.PayTypeID,c.PayType,IsSale, IsVAT, IsOtherReceipt order by b.PayTypeID,c.PayType,IsSale DESC"
                    GetData = objDB.List(sqlStatement, objCnn)
                    outputString = ""
                    grandTotal = 0
                    SaleReportByProduct(outputString, grandTotal, VATTotal, ShowSummary, GrayBGColor, AdminBGColor, ShopID, ViewOption, StartDate, EndDate, GetData, objDB.List(sqlStatement1, objCnn), PayByCreditMoney, objCnn)

                    Return outputString
                
                End If


           
            End If

        End Function
		Public Function SaleReportByProduct(ByRef ResultString As String, ByRef grandTotal As Double, ByRef VATTotal As Double, ByVal ShowSummary As Boolean, ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal ShopID As Integer, ByVal ViewOption As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal dtTable As DataTable, ByVal PaymentResult As DataTable, ByVal PayByCreditMoney As DataTable, ByVal objCnn As MySqlConnection) As String

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

            Dim subTotalGroupRetailPrice As Double = 0
            Dim subTotalGroupPriceDiscount As Double = 0
            Dim subTotalGroupDiscount As Double = 0
            Dim subTotalGroupBeforeVAT As Double = 0
            Dim subTotalGroupVAT As Double = 0
            Dim subTotalGroupAfterVAT As Double = 0
            Dim subTotalGroupOtherDiscount As Double = 0
            Dim subTotalGroupQty As Double = 0

            Dim subTotalRetailPriceDate As Double = 0
            Dim subTotalPriceDiscountDate As Double = 0
            Dim subTotalDiscountDate As Double = 0
            Dim subTotalBeforeVATDate As Double = 0
            Dim subTotalVATDate As Double = 0
            Dim subTotalAfterVATDate As Double = 0
            Dim subTotalOtherDiscountDate As Double = 0
            Dim subTotalServiceChargeDate As Double = 0

            Dim grandTotalRetailPrice As Double = 0
            Dim grandTotalPriceDiscount As Double = 0
            Dim grandTotalDiscount As Double = 0
            Dim grandTotalBeforeVAT As Double = 0
            Dim grandTotalVAT As Double = 0
            Dim grandTotalAfterVAT As Double = 0
            Dim grandTotalOtherDiscount As Double = 0
            Dim grandTotalServiceCharge As Double = 0
            Dim grandTotalQty As Double = 0
            Dim DiscountArray(7) As Double
            Dim grandTotalVoid As Double = 0

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
            Dim PriceDiscount, PricePerUnit, ProductQty As Double
            Dim totalSale As Double = 0
            Dim totalSaleBeforeDiscount As Double = 0
            Dim totalQty As Integer = 0
            For i = 0 To dtTable.Rows.Count - 1
                If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                    If Not IsDBNull(dtTable.Rows(i)("SalePriceBeforeVAT")) And Not IsDBNull(dtTable.Rows(i)("ProductVAT")) Then
                        totalSale += dtTable.Rows(i)("SalePriceBeforeVAT") + dtTable.Rows(i)("ProductVAT")
                    End If
                    If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) And Not IsDBNull(dtTable.Rows(i)("ProductExcludeVAT")) Then
                        totalSaleBeforeDiscount += dtTable.Rows(i)("TotalRetailPrice") + dtTable.Rows(i)("ProductExcludeVAT")
                    End If
                    totalQty += dtTable.Rows(i)("Amount")
                End If
            Next
            For i = 0 To dtTable.Rows.Count - 1
                If Not IsDBNull(dtTable.Rows(i)("ProductGroupID")) Then
                    CompareGroupID = dtTable.Rows(i)("ProductGroupID")
                Else
                    CompareGroupID = 0
                End If
                If Not IsDBNull(dtTable.Rows(i)("ProductDeptID")) Then
                    CompareDeptID = dtTable.Rows(i)("ProductDeptID")
                Else
                    CompareDeptID = 0
                End If
                If Not (DummyGroupID = CompareGroupID And DummyDeptID = CompareDeptID) Then

                    If i <> 0 Then
                        outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
                        outputString = outputString.Append("<td colspan=""4"" align=""right"" class=""" + TextClass + """>Total for " + dtTable.Rows(i - 1)("ProductDeptName") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalQty, "##,##0.0") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format((subTotalQty / totalQty) * 100, "##,##0.00") + "%</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalRetailPrice, "##,##0.00") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & Format((subTotalRetailPrice / totalSaleBeforeDiscount) * 100, "##,##0.00") & "%</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalPriceDiscount + subTotalDiscount, "##,##0.00") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalAfterVAT, "##,##0.00") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format((subTotalAfterVAT / totalSale) * 100, "##,##0.00") + "%</td>")
                        outputString = outputString.Append("<td></td></tr>")
                        subTotalGroupPriceDiscount += subTotalPriceDiscount
                        subTotalGroupDiscount += subTotalDiscount
                        subTotalGroupBeforeVAT += subTotalBeforeVAT
                        subTotalGroupVAT += subTotalVAT
                        subTotalGroupAfterVAT += subTotalAfterVAT
                        subTotalGroupRetailPrice += subTotalRetailPrice
                        subTotalGroupQty += subTotalQty
                    End If
                    If Not DummyGroupID = CompareGroupID Then
                        If i <> 0 Then
                            outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                            outputString = outputString.Append("<td colspan=""4"" align=""right"" class=""" + TextClass + """>Summary for " + dtTable.Rows(i - 1)("ProductGroupName") + " group</td>")
                            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalGroupQty, "##,##0.0") + "</td>")
                            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format((subTotalGroupQty / totalQty) * 100, "##,##0.00") + "%</td>")
                            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalGroupRetailPrice, "##,##0.00") + "</td>")
                            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & Format((subTotalGroupRetailPrice / totalSaleBeforeDiscount) * 100, "##,##0.00") & "%</td>")
                            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalGroupPriceDiscount + subTotalGroupDiscount, "##,##0.00") + "</td>")
                            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalGroupAfterVAT, "##,##0.00") + "</td>")
                            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format((subTotalGroupAfterVAT / totalSale) * 100, "##,##0.00") + "%</td>")
                            outputString = outputString.Append("<td></td></tr>")
                        End If
                        subTotalGroupPriceDiscount = 0
                        subTotalGroupDiscount = 0
                        subTotalGroupBeforeVAT = 0
                        subTotalGroupVAT = 0
                        subTotalGroupAfterVAT = 0
                        subTotalGroupRetailPrice = 0
                        subTotalGroupQty = 0
                    End If
                    outputString = outputString.Append("<tr><td colspan=""12"" class=""tdHeader"" bgColor=""" + AdminBGColor + """>" + dtTable.Rows(i)("ProductGroupName") + " :: " + dtTable.Rows(i)("ProductDeptName") + "</td></tr>")

                    counter = 1
                    subTotalPriceDiscount = 0
                    subTotalDiscount = 0
                    subTotalBeforeVAT = 0
                    subTotalVAT = 0
                    subTotalAfterVAT = 0
                    subTotalRetailPrice = 0
                    subTotalQty = 0

                End If



                outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")

                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & counter.ToString & ")</td>")

                If Not IsDBNull(dtTable.Rows(i)("ProductCode")) Then
                    outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("ProductCode") & "</td>")
                Else
                    outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>")
                End If
                If dtTable.Rows(i)("ProductSettype") < 0 Then
                    ExtraInfo = "**"
                Else
                    ExtraInfo = ""
                End If
                If Not IsDBNull(dtTable.Rows(i)("ProductName")) Then
                    outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("ProductName") + ExtraInfo & "</td>")
                ElseIf Not IsDBNull(dtTable.Rows(i)("OtherFoodName")) Then
                    outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("OtherFoodName") & "</td>")
                Else
                    outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>")
                End If
                If Not IsDBNull(dtTable.Rows(i)("Amount")) Then

                    ProductQty = dtTable.Rows(i)("Amount")
                    If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                        subTotalQty += ProductQty
                        grandTotalQty += ProductQty
                    End If
                Else
                    ProductQty = 0
                End If

                If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) And Not IsDBNull(dtTable.Rows(i)("ProductExcludeVAT")) Then
                    If dtTable.Rows(i)("ProductSettype") < 0 Then
                        RetailPriceAfterVAT = 0
                    Else
                        RetailPriceAfterVAT = dtTable.Rows(i)("TotalRetailPrice") + dtTable.Rows(i)("ProductExcludeVAT")
                    End If
                    PricePerUnit = RetailPriceAfterVAT / ProductQty
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & Format(PricePerUnit, "##,##0.00") & "</td>")
                    If ProductQty > 0 Then
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & Format(ProductQty, "##,##0.0") & "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & Format((ProductQty / totalQty) * 100, "##,##0.00") & "%</td>")
                    Else
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                    End If
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & Format(RetailPriceAfterVAT, "##,##0.00") & "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & Format((RetailPriceAfterVAT / totalSaleBeforeDiscount) * 100, "##,##0.00") & "%</td>")
                    If dtTable.Rows(i)("TransactionStatusID") = 2 And dtTable.Rows(i)("ProductSettype") >= 0 Then
                        subTotalRetailPrice += dtTable.Rows(i)("TotalRetailPrice") + dtTable.Rows(i)("ProductExcludeVAT")
                        grandTotalRetailPrice += dtTable.Rows(i)("TotalRetailPrice") + dtTable.Rows(i)("ProductExcludeVAT")
                    End If
                Else
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & "0.00" & "</td>")
                    If ProductQty > 0 Then
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & Format(ProductQty, "##,##0.0") & "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & Format((ProductQty / totalQty) * 100, "##,##0.00") & "%</td>")
                    Else
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                    End If
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & "0.00" & "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & "0.00" & "</td>")
                    PricePerUnit = 0
                End If

                If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And dtTable.Rows(i)("ProductSettype") >= 0 Then
                    PriceDiscount = dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalPrice")
                    If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                        subTotalPriceDiscount += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalPrice")
                        grandTotalPriceDiscount += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalPrice")
                    End If
                Else
                    PriceDiscount = 0

                End If

                If dtTable.Rows(i)("TransactionStatusID") = 2 Then
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
                End If


                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & Format(TotalProductDiscount + PriceDiscount, "##,##0.00") & "</td>")

                If Not IsDBNull(dtTable.Rows(i)("SalePriceBeforeVAT")) Then
                    If Not IsDBNull(dtTable.Rows(i)("ProductVAT")) Then
                        DummyVAT = dtTable.Rows(i)("ProductVAT") - Math.Round(dtTable.Rows(i)("ProductVAT"), 2)
                    Else
                        DummyVAT = 0
                    End If

                    If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                        subTotalBeforeVAT += dtTable.Rows(i)("SalePriceBeforeVAT")
                        grandTotalBeforeVAT += dtTable.Rows(i)("SalePriceBeforeVAT")
                    End If

                End If
                If Not IsDBNull(dtTable.Rows(i)("ProductVAT")) Then

                    If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                        subTotalVAT += dtTable.Rows(i)("ProductVAT")
                        grandTotalVAT += dtTable.Rows(i)("ProductVAT")
                    End If

                End If

                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & Format(RetailPriceAfterVAT - TotalProductDiscount - PriceDiscount, "##,##0.00") & "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & Format(((RetailPriceAfterVAT - TotalProductDiscount - PriceDiscount) / totalSale) * 100, "##,##0.00") & "%</td>")
                If dtTable.Rows(i)("ProductSettype") >= 0 Then
                    If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                        subTotalAfterVAT += RetailPriceAfterVAT - TotalProductDiscount - PriceDiscount
                        grandTotalAfterVAT += RetailPriceAfterVAT - TotalProductDiscount - PriceDiscount
                    Else
                        grandTotalVoid += RetailPriceAfterVAT - TotalProductDiscount - PriceDiscount
                    End If
                End If

                If dtTable.Rows(i)("VATType") = 0 Then
                    VATString = "N"
                ElseIf dtTable.Rows(i)("VATType") = 1 Then
                    VATString = "V"
                Else
                    VATString = "E"
                End If
                outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & VATString & "</td>")
                outputString = outputString.Append("</tr>")

                counter = counter + 1



                If Not IsDBNull(dtTable.Rows(i)("ProductGroupID")) Then
                    DummyGroupID = dtTable.Rows(i)("ProductGroupID")
                Else
                    DummyGroupID = 0
                End If
                If Not IsDBNull(dtTable.Rows(i)("ProductDeptID")) Then
                    DummyDeptID = dtTable.Rows(i)("ProductDeptID")
                Else
                    DummyDeptID = 0
                End If

            Next
            If counter > 0 Then
                outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
                If i > 0 Then
                    outputString = outputString.Append("<td colspan=""4"" align=""right"" class=""" + TextClass + """>Total for " + dtTable.Rows(i - 1)("ProductDeptName") + "</td>")
                Else
                    outputString = outputString.Append("<td colspan=""4"" align=""right"" class=""" + TextClass + """></td>")
                End If
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalQty, "##,##0.0") + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format((subTotalQty / totalQty) * 100, "##,##0.00") + "%</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalRetailPrice, "##,##0.00") + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & Format((subTotalRetailPrice / totalSaleBeforeDiscount) * 100, "##,##0.00") & "%</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalPriceDiscount + subTotalDiscount, "##,##0.00") + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalAfterVAT, "##,##0.00") + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format((subTotalAfterVAT / totalSale) * 100, "##,##0.00") + "%</td>")
                outputString = outputString.Append("<td></td></tr>")
                If dtTable.Rows.Count > 0 Then
                    outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                    outputString = outputString.Append("<td colspan=""4"" align=""right"" class=""" + TextClass + """>Summary for " + dtTable.Rows(i - 1)("ProductGroupName") + " group</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalQty + subTotalGroupQty, "##,##0.0") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(((subTotalQty + subTotalGroupQty) / totalQty) * 100, "##,##0.00") + "%</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalGroupRetailPrice + subTotalRetailPrice, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & Format((subTotalGroupRetailPrice / totalSaleBeforeDiscount) * 100, "##,##0.00") & "%</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalGroupPriceDiscount + subTotalPriceDiscount + subTotalGroupDiscount + subTotalDiscount, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(subTotalGroupAfterVAT + subTotalAfterVAT, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(((subTotalGroupAfterVAT + subTotalAfterVAT) / totalSale) * 100, "##,##0.00") + "%</td>")
                    outputString = outputString.Append("<td></td></tr>")
                End If

                If ShowSummary = False Then
                    outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                    outputString = outputString.Append("<td colspan=""7"" align=""right"" class=""" + TextClass + """>Grand Total</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalBeforeVAT, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalVAT, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalAfterVAT, "##,##0.00") + "</td>")
                    outputString = outputString.Append("<td></td></tr>")
                End If



            End If
            VATTotal = grandTotalVAT

            outputString = outputString.Append("</table>")

            'If grandTotalBeforeVAT > 0 Then
            If ShowSummary = True Then
                Dim ServiceChargeQuery As String = ""

                If ShopID > 0 Then
                    ServiceChargeQuery = " AND a.ShopID = " + ShopID.ToString
                End If
                Dim grandTotalServiceChargeVAT As Double = 0
                If ShopID = 0 Then ShopID = 1
                Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel where ProductLevelID=" + ShopID.ToString, objCnn)
                Dim DisplayVATType As String = "V"
                If ShopInfo.Rows.Count > 0 Then
                    If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
                        DisplayVATType = "E"
                    End If
                Else
                    ShopInfo = objDB.List("select * from ProductLevel where IsShop=1 AND Deleted=0", objCnn)
                    If ShopInfo.Rows.Count > 0 Then
                        If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
                            DisplayVATType = "E"
                        End If
                    End If
                End If

                Dim serviceCharge As DataTable = objDB.List("select SUM(IF(a.TransactionVAT = 0,a.ServiceCharge+a.ServiceChargeVAT,a.ServiceCharge)) AS ServiceCharge, SUM(IF(a.TransactionVAT=0,0,a.ServiceChargeVAT)) AS ServiceChargeVAT from  ordertransaction a WHERE TransactionStatusID=2 AND ReceiptID > 0 AND SaleDate >= " + StartDate + " AND SaleDate < " + EndDate + ServiceChargeQuery, objCnn)
                If Not IsDBNull(serviceCharge.Rows(0)("ServiceCharge")) Then
                    grandTotalServiceCharge = serviceCharge.Rows(0)("ServiceCharge") + serviceCharge.Rows(0)("ServiceChargeVAT")
                    grandTotalServiceChargeVAT = serviceCharge.Rows(0)("ServiceChargeVAT")
                    grandTotalVAT += serviceCharge.Rows(0)("ServiceChargeVAT")
                    grandTotalAfterVAT += serviceCharge.Rows(0)("ServiceCharge") + serviceCharge.Rows(0)("ServiceChargeVAT")
                    grandTotalBeforeVAT += serviceCharge.Rows(0)("ServiceCharge")
                Else
                    grandTotalServiceCharge = 0
                End If
                outputString = outputString.Append("<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">")
                outputString = outputString.Append("<tr><td colspan=""9"" align=""left"" class=""tdHeader"" bgColor=""" + AdminBGColor + """>Total Summary</td></tr>")
                outputString = outputString.Append("<tr bgColor=""" + "white" + """>")
                outputString = outputString.Append("<td align=""center"" class=""smallText"">Total Qty</td>")
                outputString = outputString.Append("<td align=""center"" class=""smallText"">Total Price</td>")
                outputString = outputString.Append("<td align=""center"" class=""smallText"">Total Discount</td>")
                outputString = outputString.Append("<td align=""center"" class=""smallText"">Service Charge</td>")
                outputString = outputString.Append("<td align=""center"" class=""smallText"">Total Sale</td>")
                outputString = outputString.Append("</tr>")
                outputString = outputString.Append("<tr bgColor=""" + "white" + """>")

                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(grandTotalQty, "##,##0.0") + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(grandTotalRetailPrice, "##,##0.00") + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(grandTotalPriceDiscount + grandTotalDiscount, "##,##0.00") + "</td>")
                If DisplayVATType = "V" Then
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(grandTotalServiceCharge, "##,##0.00") + "</td>")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(grandTotalServiceCharge - grandTotalServiceChargeVAT, "##,##0.00") + "</td>")
                End If
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(grandTotalAfterVAT, "##,##0.00") + "</td>")

                outputString = outputString.Append("</tr>")
                'End If
                outputString = outputString.Append("</table>")
                Dim FinalSaleAmount As Double

                DiscountArray(0) = grandTotalPriceDiscount + grandTotalDiscount
                DiscountArray(1) += grandTotalPriceDiscount
                'Dim ResultSummary As String = SaleReportSummary(FinalSaleAmount, GrayBGColor, AdminBGColor, ShopID, ViewOption, StartDate, EndDate, grandTotalVAT, grandTotalAfterVAT, grandTotalVoid, PaymentResult, PayByCreditMoney, DiscountArray, True, False, objCnn)
                'outputString = outputString.Append(ResultSummary)

            End If
            grandTotal = grandTotalAfterVAT
            ResultString = outputString.ToString()

        End Function
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
