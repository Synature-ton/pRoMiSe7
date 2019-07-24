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
<title>Sale Sharing Reports</title>
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
				<td><asp:DropDownList ID="ShopInfo" CssClass="text" Width="200" AutoPostBack="true" OnSelectedIndexChanged="SelGroup" runat="server"></asp:DropDownList></td>
			</tr>
            <tr>
				<td><asp:DropDownList ID="SaleModeInfo" CssClass="text" Width="200" runat="server"></asp:DropDownList></td>
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
</asp:Panel></td></tr>
</table></span>
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
Dim PageID As Integer  = 998

Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_Sharing2") Then
		
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
		
		LangText0.Text = "Sale Report By Product Group"
			
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
		
		StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"

		Text1.InnerHtml = ""
		Text2.InnerHtml = "Code"
		Text3.InnerHtml = "Name"
		Text4.InnerHtml = "Qty"
		Text5.InnerHtml = "Total Sale"
		Text6.InnerHtml = "% Sharing"
		
		
		DisplayGraph.Text = "Display Graph"

		
		
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

		Dim i As Integer
		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		
		Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-1,Session("StaffRole"),objCnn)
		If Not Page.IsPostBack Then
			ShopInfo.DataSource = ShopData
			ShopInfo.DataValueField = "ProductLevelID"
			ShopInfo.DataTextField = "ProductLevelName"
			ShopInfo.DataBind()
						
			ShowGroup()
			
			Dim SMData As DataTable = objDB.List("select * from SaleMode where Deleted=0 order by SaleModeID", objCnn)
			
			Dim SaleModeData As DataTable = New DataTable("SMData")
			SaleModeData.Columns.Add("SaleModeName")
			SaleModeData.Columns.Add("SaleModeID", GetType(Integer))
			Dim myrow As DataRow = SaleModeData.NewRow()
			myrow("SaleModeName") = "-- Display All SaleMode --"
			myrow("SaleModeID") = "0"
			SaleModeData.Rows.Add(myrow)
			For i = 0 To SMData.Rows.Count - 1
				myrow = SaleModeData.NewRow()
				myrow("SaleModeName") = SMData.Rows(i)("SaleModeName")
				myrow("SaleModeID") = SMData.Rows(i)("SaleModeID")
				SaleModeData.Rows.Add(myrow)
			Next
			SaleModeInfo.DataSource = SaleModeData
			SaleModeInfo.DataValueField = "SaleModeID"
			SaleModeInfo.DataTextField = "SaleModeName"
			SaleModeInfo.DataBind()

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
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
			FoundError = True
			DateFromValue = ""
			DateToValue = ""
			DailyDateValue = ""
		Else
			Dim SDate2 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
			ReportDate = DateTimeUtil.FormatDateTime(SDate2, "DateOnly",Session("LangID"),objCnn)
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
		If LangDefault.Rows.Count >= 3 Then
			CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(NOW(), "DateAndTime",Session("LangID"),objCnn)
		End If
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
		
		'Application.Lock()

		SharingSaleReports(dtTable,grandTotal,GraphData, StartDate, EndDate, ShopInfo.SelectedItem.Value,SaleModeInfo.SelectedItem.Value,GroupInfo.SelectedItem.Value,DeptInfo.SelectedItem.Value, DisplayGraph.Checked, Session("LangID"),"", objCnn)
		
		'Application.UnLock()

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

			outputString += "<td align=""right"" class=""" + TextClass + """>" & CDbl(dtTable.Rows(i)("TotalSale")).ToString(FormatData.Rows(0)("CurrencyFormat"), ci) & "</td>"
			outputString += "<td align=""right"" class=""" + TextClass + """>" & CDbl((dtTable.Rows(i)("TotalSale")/grandTotal)).ToString(FormatData.Rows(0)("PercentFormat"), ci) & "</td>"

			
			Dim row As DataRow = table.NewRow()
			row("Description") = dtTable.Rows(i)("PName")
			row("Value1") = CDbl((dtTable.Rows(i)("TotalSale")*100/grandTotal)).ToString(FormatData.Rows(0)("NumericFormat"), ci)
			table.Rows.Add(row)

			outputString += "</tr>"
		Next
		outputString += "<tr bgcolor=""" + GlobalParam.GrayBGColor + """>"
		outputString += "<td align=""right"" colspan=""3"" class=""" + TextClass + """>Sub Total</td>"
		outputString += "<td align=""right"" class=""" + TextClass + """>" & grandTotal.ToString(FormatData.Rows(0)("CurrencyFormat"), ci) & "</td>"
		outputString += "<td align=""right"" class=""" + TextClass + """>" & (grandTotal/grandTotal).ToString(FormatData.Rows(0)("PercentFormat"), ci) & "</td>"
		outputString += "</tr>"

		ResultText.InnerHtml = outputString
		Dim ShopGroupDept As String = ShopInfo.SelectedItem.Text
		Dim HeaderGroup As String = " Product Group "
		Dim GroupText As String = ""
		If GroupInfo.SelectedItem.Value > 0 Then
			GroupText = " => " + GroupInfo.SelectedItem.Text
			HeaderGroup = " Product Dept "
		End If
		If DeptInfo.SelectedItem.Value > 0 Then
			GroupText = " => " + DeptInfo.SelectedItem.Text
			HeaderGroup = " Product "
		End If
		Dim SaleModeText As String = ": All Sale Mode"
		If SaleModeInfo.SelectedItem.Value > 0 Then
			SaleModeText = ": " + SaleModeInfo.SelectedItem.Text
		End If
		ResultSearchText.InnerHtml = "Sale Report By" + HeaderGroup + "of " + ShopGroupDept + SaleModeText + GroupText + " (" + ReportDate + ")"
		
		Dim ExportData As String = ""
		ExportData += "<table width=""100%"">"
		ExportData += "<tr><td align=""center"">" + ResultSearchText.InnerHtml + "</td></tr>"
		ExportData += "<tr><td align=""right"">" + CreateReportDate.Text + "</td></tr>"
		ExportData += "<tr><td>"
		ExportData += startTable.InnerHtml
		ExportData += "<tr>"
		ExportData += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + Text1.InnerHtml + "</td>"
		ExportData += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + Text2.InnerHtml + "</td>"
		ExportData += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + Text3.InnerHtml + "</td>"
		ExportData += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + Text5.InnerHtml + "</td>"
		ExportData += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + Text6.InnerHtml + "</td>"
		ExportData += "</tr>"
	
		ExportData += ResultText.InnerHtml
		ExportData += "</td></tr></table>"

		Session("ReportResult") = ExportData
		
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
           ' 'ChartControl1.Legend.Width = 40
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
	gpTable = getInfo.GetProductGroupNew(ShopInfo.SelectedItem.Value,0,objCnn)
			
	Dim groupTable As DataTable = New DataTable("GroupData")
	groupTable.Columns.Add("ProductGroupName")
	groupTable.Columns.Add("ProductGroupID", GetType(Integer))
	Dim myrow As DataRow = groupTable.NewRow()
	myrow("ProductGroupName") = "-- Display All Groups --"
	myrow("ProductGroupID") = "0"
	groupTable.Rows.Add(myrow)
	For i = 0 To gpTable.Rows.Count - 1
		myrow = groupTable.NewRow()
		myrow("ProductGroupName") = gpTable.Rows(i)("ProductGroupName")
		myrow("ProductGroupID") = gpTable.Rows(i)("ProductGroupID")
		groupTable.Rows.Add(myrow)
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

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "SaleSharingData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub

Public Overloads Function SharingSaleReports(ByRef returnData As DataTable, ByRef grandTotal As Double, ByRef GraphData As DataSet, ByVal StartDate As String, ByVal EndDate As String, ByVal ShopID As Integer, ByVal SaleModeID As Integer, ByVal GroupID As Integer, ByVal DeptID As Integer, ByVal DisplayGraph As Boolean, ByVal LangID As Integer, ByVal MemberIDList As String, ByVal objCnn As MySqlConnection) As String

        Dim sqlStatement, sqlStatement1, WhereString As String
        Dim AdditionalQuery As String = ""
        Dim ExtraQuery As String = ""
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
        End If

        If Trim(MemberIDList) <> "" Then
            AdditionalQuery += " AND a.MemberDiscountID IN (" + MemberIDList + ")"
        End If

        If GroupID > 0 Then
            ExtraQuery += " AND pg.ProductGroupID IN (" + GroupID.ToString + ")"
        End If

        If DeptID > 0 Then
            ExtraQuery += " AND pd.ProductDeptID IN (" + DeptID.ToString + ")"
        End If
		
		If SaleModeID > 0 Then
            AdditionalQuery += " AND b.SaleMode IN (" + SaleModeID.ToString + ")"
        End If

        If StartDate <> "" And EndDate <> "" Then
            AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
        End If
        Dim OrderBy As String = " SalePriceBeforeVAT desc, totalAmount desc "


        Dim PName As String = "p." + getReport.ProductNameForReport(LangID, objCnn)

        Dim SelectString, GroupByString, OrderByString As String
        If GroupID = 0 Then
            SelectString = "pg.ProductGroupName As PName,pg.ProductGroupCode As PCode,pg.ProductGroupID AS PID"
            GroupByString = "pg.ProductGroupID,pg.ProductGroupName,pg.ProductGroupCode"
            OrderByString = " Order By pg.ProductGroupName"
        ElseIf DeptID = 0 Then
            SelectString = "pd.ProductDeptName As PName,pd.ProductDeptCode As PCode,pd.ProductDeptID AS PID"
            GroupByString = "pd.ProductDeptID,pd.ProductDeptName,pd.ProductDeptCode"
            OrderByString = " Order By pd.ProductDeptName"
        Else
            SelectString = PName + " PName,p.ProductCode As PCode,p.ProductID AS PID"
            GroupByString = "p.ProductID,p.ProductName,p.ProductCode"
            OrderByString = " Order By " + PName
        End If

        returnData = GroupingByReport(1, SaleModeID, GroupID, AdditionalQuery, ExtraQuery, SelectString, GroupByString, OrderByString, objCnn)

        grandTotal = 0

        Dim TestText As String
        Dim i, PIDVal As Integer
        Dim TotalSale, TotalProductDiscount As Double
        TotalSale = 0
        returnData = objDB.List("select PName,PCode,PID,SUM(TotalSale) As TotalSale from DummyOutput group by PName,PCode,PID order by TotalSale Desc", objCnn)
        For i = 0 To returnData.Rows.Count - 1
            grandTotal += returnData.Rows(i)("TotalSale")
        Next
        objDB.sqlExecute("DROP TABLE IF EXISTS DummyProducts", objCnn)
        objDB.sqlExecute("DROP TABLE IF EXISTS DummyOutput", objCnn)

    End Function
	
	Public Function GroupingByReport(ByVal TypeID As Integer, ByVal SaleModeID As Integer, ByVal GroupID As Integer, ByVal AdditionalQuery As String, ByVal ExtraQuery As String, ByVal SelectString As String, ByVal GroupByString As String, ByVal OrderByString As String, ByVal objCnn As MySqlConnection) As DataTable

        Dim sqlStatement As String
        If TypeID = 5 Then 'NoSale Report
            sqlStatement = "SELECT p.ProductName,p.ProductCode,p.ProductID,0 As TotalQty,0 As TotalSale from Products p LEFT OUTER JOIN ProductDept pd ON p.ProductDeptID=pd.ProductDeptID LEFT OUTER JOIN ProductGroup pg ON pd.ProductGroupID=pg.ProductGroupID LEFT OUTER JOIN (SELECT " + SelectString + ",SUM(b.Amount) As TotalQty,SUM(SalePrice) As TotalSale FROM ordertransaction a inner join orderdetail b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID inner join orderdiscountdetail c ON b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND b.OrderDetailID=c.OrderDetailID left outer join Products p ON b.ProductID=p.ProductID left outer join ProductDept pd ON p.ProductDeptID=pd.ProductDeptID left outer join ProductGroup pg ON pd.ProductGroupID=pg.ProductGroupID WHERE a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3,14,16) AND a.TransactionStatusID=2 " + AdditionalQuery + ExtraQuery + "  GROUP BY " + GroupByString + ") aa ON p.ProductID=aa.ProductID where p.Deleted=0 And aa.ProductID is NULL " + ExtraQuery
        ElseIf SaleModeID = 0 AND GroupID=0 Then
			sqlStatement = "SELECT " + SelectString + ",SUM(b.Amount) As TotalQty,SUM(SalePrice) As TotalSale FROM ordertransaction a inner join orderdetail b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID inner join orderdiscountdetail c ON b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND b.OrderDetailID=c.OrderDetailID left outer join Products p ON b.ProductID=p.ProductID left outer join ProductDept pd ON p.ProductDeptID=pd.ProductDeptID left outer join ProductGroup pg ON pd.ProductGroupID=pg.ProductGroupID WHERE a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3,14,16) AND a.TransactionStatusID=2 AND b.SaleMode=1 " + AdditionalQuery + ExtraQuery + "  GROUP BY " + GroupByString + " UNION " + " SELECT sm.SaleModeName As PName,sm.PrefixText As PCode,sm.SaleModeID AS PID,SUM(b.Amount) As TotalQty,SUM(SalePrice) As TotalSale FROM ordertransaction a inner join orderdetail b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID inner join orderdiscountdetail c ON b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND b.OrderDetailID=c.OrderDetailID left outer join SaleMode sm ON b.SaleMode=sm.SaleModeID WHERE a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3,14,16) AND a.TransactionStatusID=2 "  + AdditionalQuery + " AND b.SaleMode<>1 GROUP BY sm.SaleModeID,sm.SaleModeName,sm.PrefixText"
		Else
            sqlStatement = "SELECT " + SelectString + ",SUM(b.Amount) As TotalQty,SUM(SalePrice) As TotalSale FROM ordertransaction a inner join orderdetail b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID inner join orderdiscountdetail c ON b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND b.OrderDetailID=c.OrderDetailID left outer join Products p ON b.ProductID=p.ProductID left outer join ProductDept pd ON p.ProductDeptID=pd.ProductDeptID left outer join ProductGroup pg ON pd.ProductGroupID=pg.ProductGroupID WHERE a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3,14,16) AND a.TransactionStatusID=2 " + AdditionalQuery + ExtraQuery + "  GROUP BY " + GroupByString + OrderByString
        End If

        objDB.sqlExecute("DROP TABLE IF EXISTS DummyOutput", objCnn)
        objDB.sqlExecute("create table DummyOutput (PName varchar(100), PCode varchar(100), PID int, TotalQty decimal(18,2), TotalSale decimal(18,6))", objCnn)
        objDB.sqlExecute("insert into DummyOutput " + sqlStatement, objCnn)
    End Function


Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>