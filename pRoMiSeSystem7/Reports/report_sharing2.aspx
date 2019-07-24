<%@ Page Language="VB" ContentType="text/html" debug="True" %>
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
<%@Import Namespace="SaleReport3" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Top Sale Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body<% = GlobalParam.BodyProp %>>
<div id="showPage" visible="true" runat="server">



<form runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
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
				<td><asp:DropDownList ID="ShopInfo" CssClass="text" Width="200" AutoPostBack="true" OnSelectedIndexChanged="SelGroup" runat="server"></asp:DropDownList></td>
			</tr>
			<tr>
				<td><asp:DropDownList ID="GroupInfo" CssClass="text" Width="200" AutoPostBack="true" OnSelectedIndexChanged="SelDept" runat="server"></asp:DropDownList></td>
			</tr>
			<tr>
				<td><asp:DropDownList ID="DeptInfo" Width="200" CssClass="text" runat="server"></asp:DropDownList></td>
			</tr>

		</table></td>
	<td>
	<table>
		<tr>
		<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
		<td colspan="3"><synature:date id="DailyDate" runat="server" /></td>
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
	<tr><td>&nbsp;</td>
		<td colspan="4" class="text"><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" />&nbsp;<asp:CheckBox ID="DisplayGraph" CssClass="text" Checked="true" runat="server" />&nbsp;&nbsp;<asp:radiobutton ID="Piechart" Text="Pie Chart" Checked="true" GroupName="Group2" CssClass="text" runat="server" />
			&nbsp;&nbsp;<asp:radiobutton ID="Barchart" Text="Column Chart" GroupName="Group2" CssClass="text" runat="server" /></td>
	</tr>
	</table>
	</td>
</tr>


</table>
</div>
<br>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
<tr><td align="center">
<div id="ResultSearchText" class="boldText" runat="server"></div></td></tr></table>
<span id="startTable" runat="server"></span>

	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="Text6" runat="server"></div></td>
		<td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="Text7" runat="server"></div></td>
		<td id="headerTD8" align="center" class="tdHeader" runat="server"><div id="Text8" runat="server"></div></td>
		<td id="headerTD9" align="center" class="tdHeader" runat="server"><div id="Text9" runat="server"></div></td>
		<td id="headerTD10" align="center" class="tdHeader" runat="server"><div id="Text10" runat="server"></div></td>
		<td id="headerTD11" align="center" class="tdHeader" runat="server"><div id="Text11" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>
</table>
	<div id="SummaryResult" runat="server"></div>

<asp:Panel ID="showGraph" Visible="false" runat="server">
<br>
<Web:ChartControl id="ChartControl1" ChartPadding=40 runat="Server" />
</asp:Panel>
<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table>
</form>
</div>
<div id="errorMsg" class="boldText" runat="server" />
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
Dim getReport2 As New StReports()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_Sharing2") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim MySQL5Report As Boolean = getProp.ChkMySQL5Report(objCnn)
		If MySQL5Report = True Then
			Response.Redirect("report_sharing2_mysql5.aspx")
		End If
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")

			
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
		
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(13,Session("LangID"),objCnn)
		Dim textTable1 As New DataTable()
		textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)

		SubmitForm.Text = textTable.Rows(8)("TextParamValue")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
		headerTD1.Visible = True
		headerTD2.Visible = True
		headerTD3.Visible = True
		headerTD4.Visible = False
		headerTD5.Visible = True
		headerTD6.Visible = True
		headerTD7.Visible = False
		headerTD8.Visible = False
		headerTD9.Visible = False
		headerTD10.Visible = False
		headerTD11.Visible = False
		
		StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""90%"">"

		Text1.InnerHtml = ""
		Text2.InnerHtml = "Code"
		Text3.InnerHtml = "Name"
		Text4.InnerHtml = "Qty"
		Text5.InnerHtml = "Total Sale"
		Text6.InnerHtml = "% Sharing"
		
		
		DisplayGraph.Text = "Display Graph"
		
		DocumentToDateParam.InnerHtml = defaultTextTable.Rows(91)("TextParamValue")
		
		HeaderText.InnerHtml = "Sale Report By Product Group"
		
		
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

		Dim i As Integer
		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		
		Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
		If Not Page.IsPostBack Then
			ShopInfo.DataSource = ShopData
			ShopInfo.DataValueField = "ProductLevelID"
			ShopInfo.DataTextField = "ProductLevelName"
			ShopInfo.DataBind()
			
			ShowGroup()

		End If
				
		Catch ex As Exception
			errorMsg.InnerHtml = "No Shop Data"'ex.Message
			SubmitForm.Enabled = False
		End Try
	  
	Else
		showPage.Visible = False
		errorMsg.InnerHtml = "Access Denied"
	End If
End Sub

Sub DoSearch(Source As Object, E As EventArgs)
	
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
		ReportDate = Format(SDate,"MMMM yyyy")
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
			ReportDate = Format(SDate1, "d MMMM yyyy") + " - " + Format(EDate1, "d MMMM yyyy")
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
			Dim SDate2 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
			ReportDate = Format(SDate2, "d MMMM yyyy")
			ResultSearchText.InnerHtml = ""
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

		Dim dtTable As New DataTable()
		
		ShowPrint.Visible = True
		
		Dim ViewOption As Integer
		If Radio_1.Checked = True Then
			ViewOption = 1
		ElseIf Radio_2.Checked = True Then
			ViewOption = 2
		Else
			ViewOption = 0 
		End If
		
		Application.Lock()

		getReport2.SharingSaleReports(dtTable,grandTotal,GraphData, StartDate, EndDate, ShopInfo.SelectedItem.Value,GroupInfo.SelectedItem.Value,DeptInfo.SelectedItem.Value, DisplayGraph.Checked, Session("LangID"),"", objCnn)
		
		Application.UnLock()

		'Text6.InnerHtml = "% (based on " +  Format(grandTotal, "##,##0.00") + ")"
		outputString = ""
		Dim TextClass As String = "text"
		Dim i,totalDisplay As Integer
		
		Dim gData As New DataSet()
		Dim table As DataTable = gData.Tables.Add("Data")
        table.Columns.Add("Description")
        table.Columns.Add("Value1", GetType(Double))
		Dim subTotal As Double = 0
		Dim TotalProductDiscount As Double
		Dim SaleTotal As Double = 0
					
		For i = 0 to dtTable.Rows.Count - 1 
			
			outputString += "<tr>"
			outputString += "<td align=""left"" class=""" + TextClass + """>" & (i+1).ToString & "</td>"
			If Not IsDBNull(dtTable.Rows(i)("PCode")) Then
				If Trim(dtTable.Rows(i)("PCode")) <> "" Then
					outputString += "<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("PCode") & "</td>"
				Else
					outputString += "<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>"
				End If
			Else
				outputString += "<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>"
			End If
			If Not IsDBNull(dtTable.Rows(i)("PName")) Then
				If Trim(dtTable.Rows(i)("PName")) <> "" Then
					outputString += "<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("PName") & "</td>"
				Else
					outputString += "<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>"
				End If
			Else
				outputString += "<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>"
			End If

			outputString += "<td align=""right"" class=""" + TextClass + """>" & Format(dtTable.Rows(i)("TotalSale"), "##,##0.00") & "</td>"
			outputString += "<td align=""right"" class=""" + TextClass + """>" & Format(dtTable.Rows(i)("TotalSale")*100/grandTotal, "##,##0.00") & "%</td>"

			
			Dim row As DataRow = table.NewRow()
			row("Description") = dtTable.Rows(i)("PName")
			row("Value1") = Format(dtTable.Rows(i)("TotalSale")*100/grandTotal, "##,##0.00")
			table.Rows.Add(row)

			outputString += "</tr>"
		Next
		outputString += "<tr bgcolor=""" + GlobalParam.GrayBGColor + """>"
		outputString += "<td align=""right"" colspan=""3"" class=""" + TextClass + """>Sub Total</td>"
		outputString += "<td align=""right"" class=""" + TextClass + """>" & Format(grandTotal, "##,##0.00") & "</td>"
		outputString += "<td align=""right"" class=""" + TextClass + """>" & Format(grandTotal*100/grandTotal, "##,##0.00") & "%</td>"
		outputString += "</tr>"

		ResultText.InnerHtml = outputString
		Dim ShopGroupDept As String = ShopInfo.SelectedItem.Text
		Dim HeaderGroup As String = " Product Group "
		If GroupInfo.SelectedItem.Value > 0 Then
			ShopGroupDept += ":" + GroupInfo.SelectedItem.Text
			HeaderGroup = " Product Dept "
		End If
		If DeptInfo.SelectedItem.Value > 0 Then
			ShopGroupDept += ":" + DeptInfo.SelectedItem.Text
			HeaderGroup = " Product "
		End If
		ResultSearchText.InnerHtml = "Sale Report By" + HeaderGroup + "of " + ShopGroupDept + " (" + ReportDate + ")"
		If DisplayGraph.Checked = True Then

				showGraph.Visible = True
				Dim view As DataView = gData.Tables(0).DefaultView
            If Barchart.Checked = True
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
				ConfigureColors("Sale Report By" + HeaderGroup + "of " + ShopGroupDept + " (" + ReportDate + ")")
        
        		ChartControl1.RedrawChart()
			Else
				
				
				Dim chart As New PieChart()
				chart.Explosion = 3
				chart.Fill.Color = Color.FromArgb(80, Color.SpringGreen)
            	chart.Line.Color = Color.SteelBlue
            	chart.Line.Width = 1
				chart.ShowLegend = True
				chart.DataLabels.Visible = True
				chart.DataSource = view
				chart.DataXValueField = "Description"
				chart.DataYValueField = "Value1"
				chart.DataBind()
				ChartControl1.Charts.Add(chart)
				ConfigureColors("Sale Report By Group of " + ShopGroupDept + " (" + ReportDate + ")")
        
        		ChartControl1.RedrawChart()

			End If
				
		Else
			showGraph.Visible = False
		End If
	End If
End Sub

 Sub ConfigureColors(TitleName)
        	'ChartControl1.Background.Color = Color.FromArgb(75, Color.SteelBlue)
			Dim ChartWidth As Integer = 700
			Dim ChartHeight As Integer = 550
			
			
            ChartControl1.Background.Type = InteriorType.LinearGradient
            ChartControl1.Background.ForeColor = Color.SteelBlue
            ChartControl1.Background.EndPoint = new Point(ChartWidth, ChartHeight) 
            ChartControl1.Legend.Position = LegendPosition.Bottom
           ' ChartControl1.Legend.Width = 40
			ChartControl1.Width = Unit.Parse(ChartWidth.ToString + "px")
			ChartControl1.Height = Unit.Parse(ChartHeight.ToString + "px")
 
            ChartControl1.YAxisFont.ForeColor = Color.SteelBlue
            ChartControl1.XAxisFont.ForeColor = Color.SteelBlue
            
            ChartControl1.ChartTitle.Text = TitleName
            ChartControl1.ChartTitle.ForeColor = Color.White
      
            ChartControl1.Border.Color = Color.SteelBlue
            'ChartControl1.BorderStyle = BorderStyle.Ridge
    End Sub

Sub SelGroup(sender As Object, e As System.EventArgs)
	ShowGroup()
End Sub

Sub ShowGroup()
	showGraph.Visible = False
	Dim i As Integer
	Dim gpTable As New DataTable()
	gpTable = getInfo.GetProductGroup(ShopInfo.SelectedItem.Value,0,objCnn)
			
	Dim groupTable As DataTable = New DataTable("GroupData")
	groupTable.Columns.Add("ProductGroupName")
	groupTable.Columns.Add("ProductGroupID", GetType(Integer))
	Dim myrow As DataRow = groupTable.NewRow()
	myrow("ProductGroupName") = "-- Display All Groups --"
	myrow("ProductGroupID") = "0"
	groupTable.Rows.Add(myrow)
	For i = 0 To gpTable.Rows.Count - 1
		If gpTable.Rows(i)("ProductGroupCode").IndexOf("TW:") = -1 Then
			myrow = groupTable.NewRow()
			myrow("ProductGroupName") = gpTable.Rows(i)("ProductGroupName")
			myrow("ProductGroupID") = gpTable.Rows(i)("ProductGroupID")
			groupTable.Rows.Add(myrow)
		End If
	Next
	GroupInfo.DataSource = groupTable
	GroupInfo.DataValueField = "ProductGroupID"
	GroupInfo.DataTextField = "ProductGroupName"
	GroupInfo.DataBind()
	
	Dim deptTable As DataTable = New DataTable("DeptData")
	deptTable.Columns.Add("ProductDeptName")
	deptTable.Columns.Add("ProductDeptID", GetType(Integer))
	Dim deptRow As DataRow = deptTable.NewRow()
	deptRow("ProductDeptName") = "-- Display All Dept --"
	deptRow("ProductDeptID") = "0"
	deptTable.Rows.Add(deptRow)
	DeptInfo.DataSource = deptTable
	DeptInfo.DataValueField = "ProductDeptID"
	DeptInfo.DataTextField = "ProductDeptName"
	DeptInfo.DataBind()
	DeptInfo.Enabled = False
End Sub

Sub SelDept(sender As Object, e As System.EventArgs)
	ShowDept()
End Sub

Sub ShowDept()
	showGraph.Visible = False
	Dim i As Integer
	Dim deptTable As DataTable = New DataTable("DeptData")
	deptTable.Columns.Add("ProductDeptName")
	deptTable.Columns.Add("ProductDeptID", GetType(Integer))
	Dim deptRow As DataRow = deptTable.NewRow()
	If GroupInfo.SelectedItem.Value = 0 Then
		DeptInfo.Enabled = False
		
		deptRow("ProductDeptName") = "-- Display All Dept --"
		deptRow("ProductDeptID") = "0"
		deptTable.Rows.Add(deptRow)
		DeptInfo.Enabled = False
	Else
		DeptInfo.Enabled = True
		Dim dpTable As New DataTable()
		dpTable = getInfo.GetProductDept(GroupInfo.SelectedItem.Value,0,objCnn)
		deptRow("ProductDeptName") = "-- Display All Dept --"
		deptRow("ProductDeptID") = "0"
		deptTable.Rows.Add(deptRow)
		For i = 0 To dpTable.Rows.Count - 1
			deptRow = deptTable.NewRow()
			deptRow("ProductDeptName") = dpTable.Rows(i)("ProductDeptName")
			deptRow("ProductDeptID") = dpTable.Rows(i)("ProductDeptID")
			deptTable.Rows.Add(deptRow)
		Next
		DeptInfo.DataSource = deptTable
		DeptInfo.DataValueField = "ProductDeptID"
		DeptInfo.DataTextField = "ProductDeptName"
		DeptInfo.DataBind()
	End If
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
