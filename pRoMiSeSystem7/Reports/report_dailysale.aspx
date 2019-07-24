<%@ Page Language="VB" ContentType="text/html" EnableViewState="false" debug="True" %>
<%@ Register tagPrefix="Web" Namespace="WebChart" Assembly="WebChart" %>
<%@ Import Namespace="System.Drawing" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.Data.OleDb" %>
<%@Import Namespace="POSSQLServer.POSControl" %>
<%@Import Namespace="POSSQLServer.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Daily Sale Reports</title>
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
		<table><tr><td><div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Sale Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div></td><td>&nbsp;&nbsp;<asp:HyperLink ID="Text_LogoutParam" runat="server" NavigateUrl="../LogoutDailySale.aspx" Text="[Log Out]"
                    Font-Underline="False"></asp:HyperLink></td></tr></table>
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
			<tr id="displaygroup" visible="false" runat="server">
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
		<tr>
		<td><asp:radiobutton ID="Radio_4" GroupName="Group1" runat="server" /></td>
		<td colspan="3"><synature:date id="YearDate" runat="server" /></td>
		</tr>
		<tr id="DateRange" visible="false" runat="server">
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
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr>
</table>
<span id="MyTable">
<table width="100%">

<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>
<span id="startTable" runat="server"></span>

	<tr>
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
		<td id="headerTD11" align="center" class="smallTdHeader" runat="server"><div id="Text11" runat="server"></div></td>
        <td id="headerTD12" align="center" class="smallTdHeader" runat="server"><div id="Text12" runat="server"></div></td>
		<td id="headerTD13" align="center" class="smallTdHeader" runat="server"><div id="Text13" runat="server"></div></td>
        <td id="headerTD14" align="center" class="smallTdHeader" runat="server"><div id="Text14" runat="server"></div></td>
		<td id="headerTD15" align="center" class="smallTdHeader" runat="server"><div id="Text15" runat="server"></div></td>
        <td id="headerTD16" align="center" class="smallTdHeader" runat="server"><div id="Text16" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>

<asp:Panel ID="showGraph" Visible="false" runat="server">
<br>
<Web:ChartControl id="ChartControl1" ChartPadding=40 runat="Server" />
</asp:Panel></table></td></tr>
</table></span>
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

Dim objCnn As New OleDbConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim DateTimeUtil As New MyDateTime()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture

Sub Page_Load()
	If User.Identity.IsAuthenticated Then
		
	Try	
		objCnn = getCnn.EstablishConnection("127.0.0.1","WebSale","websale","12ws345")

		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
			
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
		headerTD14.BgColor = GlobalParam.AdminBGColor
		headerTD15.BgColor = GlobalParam.AdminBGColor
		headerTD16.BgColor = GlobalParam.AdminBGColor

		SubmitForm.Text = "Generate Report"
		
		headerTD1.Visible = True
		headerTD2.Visible = True
		headerTD3.Visible = True
		headerTD4.Visible = True
		headerTD5.Visible = True
		headerTD6.Visible = True
		headerTD7.Visible = True
		headerTD8.Visible = True
		headerTD9.Visible = False
		headerTD10.Visible = True
		headerTD11.Visible = True
		headerTD12.Visible = True
		headerTD13.Visible = True
		headerTD14.Visible = True
		headerTD15.Visible = True
		headerTD16.Visible = True
		
		ShowGroup.Text = "Group By Product Group"

		StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"

		Text1.InnerHtml = "Outlet No"
		Text2.InnerHtml = "Outlet Name"
		Text3.InnerHtml = "Sale Date"
		Text4.InnerHtml = "Take In"
		Text5.InnerHtml = "Take Out"
		Text6.InnerHtml = "Delivery"
		Text7.InnerHtml = "Discount"
		Text8.InnerHtml = "Sale Amount"
		Text9.InnerHtml = "Non Sale"
		Text10.InnerHtml = "Service Charge"
		Text11.InnerHtml = "Total Sale"
		Text12.InnerHtml = "Tax1"
		Text13.InnerHtml = "Tax2"
		Text14.InnerHtml = "Gross Sale"
		Text15.InnerHtml = "People"
		Text16.InnerHtml = "Price Per Run"
		
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
		
		DocumentToDateParam.InnerHtml = "to"
		
		HeaderText.InnerHtml = "Sale Reports"
			
		DailyDate.YearType = 2'GlobalParam.YearType
		DailyDate.FormName = "DocDaily"
		DailyDate.StartYear = GlobalParam.StartYear
		DailyDate.EndYear = GlobalParam.EndYear
		DailyDate.LangID = Session("LangID")
		
		CurrentDate.YearType = 2'GlobalParam.YearType
		CurrentDate.FormName = "Doc"
		CurrentDate.StartYear = GlobalParam.StartYear
		CurrentDate.EndYear = GlobalParam.EndYear
		CurrentDate.LangID = Session("LangID")
		
		ToDate.YearType = 2'GlobalParam.YearType
		ToDate.FormName = "DocTo"
		ToDate.StartYear = GlobalParam.StartYear
		ToDate.EndYear = GlobalParam.EndYear
		ToDate.LangID = Session("LangID")
		
		MonthYearDate.YearType = 2'GlobalParam.YearType
		MonthYearDate.FormName = "MonthYearDate"
		MonthYearDate.StartYear = GlobalParam.StartYear
		MonthYearDate.EndYear = GlobalParam.EndYear
		MonthYearDate.LangID = Session("LangID")
		MonthYearDate.ShowDay = False
		
		YearDate.YearType = 2'GlobalParam.YearType
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
		
		Dim YesterDayDate As DateTime = DateTime.Now
		YesterDayDate = DateAdd("d",-1,YesterDayDate)
		
		If IsNumeric(Request.Form("DocDaily_Day")) Then 
			Session("DocDailyDay") = Request.Form("DocDaily_Day")
		Else If IsNumeric(Request.QueryString("DocDaily_Day")) Then 
			Session("DocDailyDay") = Request.QueryString("DocDaily_Day")
		Else If Trim(Session("DocDailyDay")) = "" Then
			Session("DocDailyDay") = YesterDayDate.Day
		Else If Trim(Session("DocDailyDay")) = 0 And Not Page.IsPostBack Then
			Session("DocDailyDay") = YesterDayDate.Day
		End If
		If Page.IsPostBack AND Request.Form("DocDaily_Day") = "" Then Session("DocDailyDay") = 0
		DailyDate.SelectedDay = Session("DocDailyDay")
		
		
		If IsNumeric(Request.Form("DocDaily_Month")) Then 
			Session("DocDaily_Month") = Request.Form("DocDaily_Month")
		Else If IsNumeric(Request.QueryString("DocDaily_Month")) Then 
			Session("DocDaily_Month") = Request.QueryString("DocDaily_Month")
		Else If Trim(Session("DocDaily_Month")) = "" Then
			Session("DocDaily_Month") = YesterDayDate.Month
		Else If Trim(Session("DocDaily_Month")) = 0 And Not Page.IsPostBack Then
			Session("DocDaily_Month") = YesterDayDate.Month
		End If
		If Page.IsPostBack AND Request.Form("DocDaily_Month") = "" Then Session("DocDaily_Month") = 0
		DailyDate.SelectedMonth = Session("DocDaily_Month")
		
		If IsNumeric(Request.Form("DocDaily_Year")) Then 
			Session("DocDaily_Year") = Request.Form("DocDaily_Year")
		Else If IsNumeric(Request.QueryString("DocDaily_Year")) Then 
			Session("DocDaily_Year") = Request.QueryString("DocDaily_Year")
		Else If Trim(Session("DocDaily_Year")) = "" Then
			Session("DocDaily_Year") = YesterDayDate.Year
		Else If Trim(Session("DocDaily_Year")) = 0 And Not Page.IsPostBack Then
			Session("DocDaily_Year") = YesterDayDate.Year
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
		
		Dim ShopData As DataTable = objDB.List("SELECT OutletNo As ProductLevelID,OutletNo + ':' + OutletName AS ProductLevelName FROM Outlet WHERE Deleted=0 Order By Ordering,OutletNo",objCnn)
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
				outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & "--- All Outlets ---"
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
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + "Invalid Date Format" + "</td></tr></table>"
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
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + "Invalid Date Format" + "</td></tr></table>"
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
			If Request.Form("ShopID") = "0" Then
				Text3.InnerHtml = "Sale Month"
			End If
		ElseIf Radio_2.Checked = True Then
			ViewOption = 2
		ElseIf Radio_4.Checked = True Then
			ViewOption = 4
			If Request.Form("ShopID") = "0" Then
				Text3.InnerHtml = "Sale Year"
			Else
				Text3.InnerHtml = "Sale Month"
			End If
		Else
			ViewOption = 0 
		End If

		Application.Lock()
		Dim dtTable As DataTable = DailySaleReport(outputString,GraphData, StartDate, EndDate, Request.Form("ShopID"),ViewOption, objCnn)

		If Request.Form("ShopID") >= 0 Then
			ResultText.InnerHtml = outputString
		End If
		Dim ShopDisplay As String
		If Request.Form("ShopID") = 0 Then
			ShopDisplay = "All Outlets"
		Else
			ShopDisplay = SelShopName.Value
		End If
		ResultSearchText.InnerHtml = "Sale Report of " + ShopDisplay + " (" + ReportDate + ")"
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
	
Public Function DailySaleReport(ByRef outString As String, ByRef GraphData As DataSet, ByVal StartDate As String, ByVal EndDate As String, ByVal OutletNo As String, ByVal ViewOption As Integer, ByVal objCnn As OleDbConnection) As DataTable

            Dim sqlStatement, sqlStatement1, WhereString, WString As String
            Dim AdditionalQuery As String = ""
            Dim ShopIDListValue As String
            Dim ResultString As String = ""
            Dim TextClass As String = "smalltext"
            Dim dtTable As DataTable
            Dim BranchStr, StrBefore As String
            Dim i As Integer
            If OutletNo <> "0" Then
                AdditionalQuery += " AND a.OutletNo='" + OutletNo + "'"
            End If

            If StartDate <> "" And EndDate <> "" Then
                AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
            End If

            Dim OrderBy As String = " a.OutletNo,a.SaleDate"

			If OutletNo = "0" Then
				If ViewOption = 0 Then
					sqlStatement = "select aa.OutletNo As NameString,aa.OutletName As OutletName,bb.DateString,CASE WHEN bb.TakeIn IS NULL THEN 0 ELSE bb.TakeIn END As TakeIn,CASE WHEN bb.TakeOut IS NULL THEN 0 ELSE bb.TakeOut END As TakeOut,CASE WHEN bb.Delivery IS NULL THEN 0 ELSE bb.Delivery END As Delivery,CASE WHEN bb.RoomService IS NULL THEN 0 ELSE bb.RoomService END As RoomService,CASE WHEN bb.Discount IS NULL THEN 0 ELSE bb.Discount END As Discount,CASE WHEN bb.ServiceCharge IS NULL THEN 0 ELSE bb.ServiceCharge END As ServiceCharge,CASE WHEN bb.Tax1 IS NULL THEN 0 ELSE bb.Tax1 END As Tax1,CASE WHEN bb.Tax2 IS NULL THEN 0 ELSE bb.Tax2 END As Tax2,CASE WHEN bb.People IS NULL THEN 0 ELSE bb.People END As People from Outlet aa left outer join (select a.OutletNo,b.OutletName,CONVERT(char(10), a.SaleDate, 103) AS DateString,SUM(a.TakeIn) As TakeIn,SUM(a.TakeOut) As TakeOut,SUM(Delivery) As Delivery,SUM(RoomService) As RoomService,SUM(Discount) As Discount,SUM(ServiceCharge) As ServiceCharge,SUM(Tax1) As Tax1,SUM(Tax2) As Tax2,SUM(People) As People from DailySale a left outer join Outlet b ON a.OutletNo=b.OutletNo WHERE 0=0 " + AdditionalQuery + " group by a.OutletNo,b.OutletName,CONVERT(char(10), a.SaleDate, 103) ) bb ON aa.OutletNo=bb.OutletNo ORDER BY aa.OutletNo,bb.DateString"
				ElseIf ViewOption = 1 Then
					sqlStatement = "select aa.OutletNo As NameString,aa.OutletName As OutletName,bb.DateString,CASE WHEN bb.TakeIn IS NULL THEN 0 ELSE bb.TakeIn END As TakeIn,CASE WHEN bb.TakeOut IS NULL THEN 0 ELSE bb.TakeOut END As TakeOut,CASE WHEN bb.Delivery IS NULL THEN 0 ELSE bb.Delivery END As Delivery,CASE WHEN bb.RoomService IS NULL THEN 0 ELSE bb.RoomService END As RoomService,CASE WHEN bb.Discount IS NULL THEN 0 ELSE bb.Discount END As Discount,CASE WHEN bb.ServiceCharge IS NULL THEN 0 ELSE bb.ServiceCharge END As ServiceCharge,CASE WHEN bb.Tax1 IS NULL THEN 0 ELSE bb.Tax1 END As Tax1,CASE WHEN bb.Tax2 IS NULL THEN 0 ELSE bb.Tax2 END As Tax2,CASE WHEN bb.People IS NULL THEN 0 ELSE bb.People END As People from Outlet aa left outer join (select a.OutletNo,b.OutletName,CONVERT(varchar(2),MONTH(a.SaleDate)) + '-' + CONVERT(varchar(4),YEAR(a.SaleDate)) AS DateString,SUM(a.TakeIn) As TakeIn,SUM(a.TakeOut) As TakeOut,SUM(Delivery) As Delivery,SUM(RoomService) As RoomService,SUM(Discount) As Discount,SUM(ServiceCharge) As ServiceCharge,SUM(Tax1) As Tax1,SUM(Tax2) As Tax2,SUM(People) As People, YEAR(a.SaleDate) As YearSaleDate,MONTH(a.SaleDate) As MonthSaleDate from DailySale a left outer join Outlet b ON a.OutletNo=b.OutletNo WHERE 0=0 " + AdditionalQuery + " group by a.OutletNo,b.OutletName,YEAR(a.SaleDate),MONTH(a.SaleDate) ) bb ON aa.OutletNo=bb.OutletNo Order By aa.OutletNo,bb.YearSaleDate,bb.MonthSaleDate"
				ElseIf ViewOption = 4 Then
					sqlStatement = "select aa.OutletNo As NameString,aa.OutletName As OutletName,bb.DateString,CASE WHEN bb.TakeIn IS NULL THEN 0 ELSE bb.TakeIn END As TakeIn,CASE WHEN bb.TakeOut IS NULL THEN 0 ELSE bb.TakeOut END As TakeOut,CASE WHEN bb.Delivery IS NULL THEN 0 ELSE bb.Delivery END As Delivery,CASE WHEN bb.RoomService IS NULL THEN 0 ELSE bb.RoomService END As RoomService,CASE WHEN bb.Discount IS NULL THEN 0 ELSE bb.Discount END As Discount,CASE WHEN bb.ServiceCharge IS NULL THEN 0 ELSE bb.ServiceCharge END As ServiceCharge,CASE WHEN bb.Tax1 IS NULL THEN 0 ELSE bb.Tax1 END As Tax1,CASE WHEN bb.Tax2 IS NULL THEN 0 ELSE bb.Tax2 END As Tax2,CASE WHEN bb.People IS NULL THEN 0 ELSE bb.People END As People from Outlet aa left outer join (select a.OutletNo,b.OutletName,CONVERT(varchar(4),YEAR(a.SaleDate)) AS DateString,SUM(a.TakeIn) As TakeIn,SUM(a.TakeOut) As TakeOut,SUM(Delivery) As Delivery,SUM(RoomService) As RoomService,SUM(Discount) As Discount,SUM(ServiceCharge) As ServiceCharge,SUM(Tax1) As Tax1,SUM(Tax2) As Tax2,SUM(People) As People,Year(a.SaleDate) As YearSaleDate from DailySale a left outer join Outlet b ON a.OutletNo=b.OutletNo WHERE 0=0 " + AdditionalQuery + " group by a.OutletNo,b.OutletName,YEAR(a.SaleDate) ) bb ON aa.OutletNo=bb.OutletNo  Order By aa.OutletNo,bb.YearSaleDate"
				End If
			Else
				If ViewOption = 0 Or ViewOption = 1 Then
            		sqlStatement = "select a.OutletNo As NameString,b.OutletName,CONVERT(char(10), a.SaleDate, 103) AS DateString,SUM(a.TakeIn) As TakeIn,SUM(a.TakeOut) As TakeOut,SUM(Delivery) As Delivery,SUM(RoomService) As RoomService,SUM(Discount) As Discount,SUM(ServiceCharge) As ServiceCharge,SUM(Tax1) As Tax1,SUM(Tax2) As Tax2,SUM(People) As People from DailySale a left outer join Outlet b ON a.OutletNo=b.OutletNo WHERE 0=0 " + AdditionalQuery + " group by a.OutletNo,b.OutletName,CONVERT(char(10), a.SaleDate, 103) Order By a.OutletNo,CONVERT(char(10), a.SaleDate, 103)"
				ElseIf ViewOption = 4 Then
					sqlStatement = "select a.OutletNo As NameString,b.OutletName,CONVERT(varchar(2),MONTH(a.SaleDate)) + '-' + CONVERT(varchar(4),YEAR(a.SaleDate)) AS DateString,SUM(a.TakeIn) As TakeIn,SUM(a.TakeOut) As TakeOut,SUM(Delivery) As Delivery,SUM(RoomService) As RoomService,SUM(Discount) As Discount,SUM(ServiceCharge) As ServiceCharge,SUM(Tax1) As Tax1,SUM(Tax2) As Tax2,SUM(People) As People from DailySale a left outer join Outlet b ON a.OutletNo=b.OutletNo WHERE 0=0 " + AdditionalQuery + " group by a.OutletNo,b.OutletName,YEAR(a.SaleDate),MONTH(a.SaleDate)  Order By a.OutletNo,YEAR(a.SaleDate),MONTH(a.SaleDate)"
				End If
			End If

            dtTable = objDB.List(sqlStatement, objCnn)
			
			Dim ShopData As DataTable = objDB.List("SELECT OutletNo,OutletName FROM Outlet WHERE Deleted=0 Order By Ordering,OutletNo",objCnn)
			
			Dim outputString As StringBuilder = New StringBuilder
			Dim SaleAmount As Double = 0
			Dim TotalSale As Double = 0
			Dim GrossSale As Double = 0
			Dim grandTotalTakeIn,grandTotalTakeOut,grandTotalDelivery,grandTotalRoomService,grandTotalDiscount,grandTotalSaleAmount,grandTotalServiceCharge,grandTotalSale,grandTotalTax1,grandTotalTax2,grandTotalGrossSale,grandTotalPeople As Double 

			For i = 0 To dtTable.Rows.Count - 1
				SaleAmount = dtTable.Rows(i)("TakeIn") + dtTable.Rows(i)("TakeOut") + dtTable.Rows(i)("Delivery") + dtTable.Rows(i)("RoomService") - dtTable.Rows(i)("Discount")
				If (OutletNo = "0" AND dtTable.Rows(i)("NameString") = "901") OR OutletNo = "901" OR (dtTable.Rows(i)("Tax1")=0 AND dtTable.Rows(i)("Tax2")>0) Then
					TotalSale = SaleAmount + dtTable.Rows(i)("ServiceCharge") - dtTable.Rows(i)("Tax1") - dtTable.Rows(i)("Tax2")
					GrossSale = SaleAmount + dtTable.Rows(i)("ServiceCharge")
				Else
					TotalSale = SaleAmount + dtTable.Rows(i)("ServiceCharge")
					GrossSale = TotalSale + dtTable.Rows(i)("Tax1") + dtTable.Rows(i)("Tax2")
				End If
				grandTotalTakeIn += dtTable.Rows(i)("TakeIn")
				grandTotalTakeOut += dtTable.Rows(i)("TakeOut")
				grandTotalDelivery += dtTable.Rows(i)("Delivery")
				grandTotalRoomService += dtTable.Rows(i)("RoomService")
				grandTotalDiscount += dtTable.Rows(i)("Discount")
				grandTotalSaleAmount += SaleAmount
				grandTotalServiceCharge += dtTable.Rows(i)("ServiceCharge")
				grandTotalSale += TotalSale
				grandTotalTax1 += dtTable.Rows(i)("Tax1")
				grandTotalTax2 += dtTable.Rows(i)("Tax2")
				grandTotalGrossSale += GrossSale
				grandTotalPeople += dtTable.Rows(i)("People")
				
				outputString = outputString.Append("<tr>")
				outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + dtTable.Rows(i)("NameString") + "</td>")
				outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + dtTable.Rows(i)("OutletName") + "</td>")
				outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + dtTable.Rows(i)("DateString") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("TakeIn"), "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("TakeOut"), "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("Delivery"), "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("Discount"), "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(SaleAmount, "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("ServiceCharge"), "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(TotalSale, "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("Tax1"), "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("Tax2"), "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(GrossSale, "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("People"), "##,##0") + "</td>")
				If dtTable.Rows(i)("People") > 0 Then
					outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(TotalSale/dtTable.Rows(i)("People"), "##,##0.00") + "</td>")
				Else
					outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + "-" + "</td>")
				End If
				outputString = outputString.Append("</tr>")
			Next
			If dtTable.Rows.Count > 0 Then
				outputString = outputString.Append("<tr bgColor=""#e3e3e3"">")
				outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""" + TextClass + """>" + "Summary" + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalTakeIn, "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalTakeOut, "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalDelivery, "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalDiscount, "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalSaleAmount, "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalServiceCharge, "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalSale, "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalTax1, "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalTax2, "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalGrossSale, "##,##0.00") + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalPeople, "##,##0") + "</td>")
				If grandTotalPeople > 0 Then
					outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalSale/grandTotalPeople, "##,##0.00") + "</td>")
				Else
					outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + "-" + "</td>")
				End If
				outputString = outputString.Append("</tr>")
			End If
			outString = outputString.ToString
            Return dtTable


        End Function	
		
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
