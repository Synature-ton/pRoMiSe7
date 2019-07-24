<%@ Page Language="VB" ContentType="text/html" EnableViewState="true" debug="True" %>
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
<%@Import Namespace="pRoMiSeReports.pRoMiSeReports" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Clock In/Out Report</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<input type="hidden" id="ShopIDList" runat="server" />
<input type="hidden" id="ExportType" runat="server" />
<input type="hidden" id="CompanyExist" runat="server" />

<a name="TopPage" id="TopPage"></a>
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
            <tr id="showCompany" visible="false" runat="server">
            	<td><asp:DropDownList ID="AccountID" CssClass="text" Width="200" runat="server"></asp:DropDownList></td>
            </tr>
			<tr id="ShowGroup" visible="true" runat="Server">
				<td><asp:dropdownlist ID="GroupByParam" Width="200" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
			</tr>
			<tr>
				<td><asp:button ID="SubmitForm" Font-Size="8" Height="25" Width="140" OnClick="DoSearch" runat="server" /></td>
			</tr>
            <tr>
            	<td><asp:Button ID="ExportClockInOutData" OnClick="ExportData" Height="25" Font-Size="8" Width="140" Text="Export Data to Payroll" runat="server"></asp:Button></td>
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
		<tr id="showyear" visible="false" runat="server">
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

<tr><td align="center" colspan="2"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>

<tr><td align="left"><span id="showPrint" visible="false" runat="server"><div class="noprint"><a href="javascript: window.print()"><span id="printtext" runat="server"></span></a></div></span></td><td align="right"><div id="GenDateText" class="text" runat="server"></div></td></tr>
</table>
<span id="startTable" runat="server"></span>

	<span id="TableHeaderText" runat="server"></span>
	
	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>

<asp:Panel ID="showGraph" Visible="false" runat="server">
<br>
<Web:ChartControl id="ChartControl1" runat="Server" />
</asp:Panel>
<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table>
<div class="noprint">
<table width="100%">
<tr><td width="100%" align="right"><a href="javascript: window.print()"><span id="printtext2" runat="server"></span></a>&nbsp;&nbsp;<a href="#TopPage"><span id="gotop" runat="server"></span></a></td></tr></table>
</div>
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
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer = 998

Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_ClockInOut") Then
		
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
			'PrintText.Text = LangDefault.Rows(0)(LangText)
			'Export.Text = LangDefault.Rows(1)(LangText)
		End If

		SubmitForm.Text = LangDefault.Rows(3)(LangText)

		StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		
		DocumentToDateParam.InnerHtml = LangDefault.Rows(22)(LangText)
		
		ExportType.Value = 0
		Dim ChkData As New DataTable
        ChkData = objDB.List("select * from ProgramPropertyValue where ProgramTypeID=2 AND PropertyID=11 AND KeyID=1", objCnn)
        If ChkData.Rows.Count > 0 Then
            If IsNumeric(ChkData.Rows(0)("PropertyValue")) Then
                ExportType.Value = ChkData.Rows(0)("PropertyValue")
            End If
        End If
		CompanyExist.Value = 0
		Dim ChkCompany As Boolean = False
		Dim Exist As Boolean = getProp.CheckTableExist("StaffExtData", objCnn)
		If Exist = True Then
			Dim ChkStaffExt As DataTable = objDB.List("select * from StaffExtData",objCnn)
			Dim ChkAccount As DataTable = objDB.List("select * from AccountData", objCnn)
			If ChkStaffExt.Rows.Count > 0 AND ChkAccount.Rows.Count > 0 Then
				ChkCompany = True
				CompanyExist.Value = 1
			End If
		End If
		
		ShowCompany.Visible = ChkCompany
		
		If Not Page.IsPostBack Then
			Dim AccountData As DataTable = objDB.List("select 0 As AccountID,'--- All Company ---' As AccountName,0 As Ordering UNION select AccountID,AccountName,Ordering from AccountData where Deleted=0 order by Ordering", objCnn)
			AccountID.DataSource = AccountData
			AccountID.DataValueField = "AccountID"
			AccountID.DataTextField = "AccountName"
			AccountID.DataBind()
		End If
		
		If Session("LangID") = 2 Then
			LangText0.Text = "รายงานการเข้างาน"
			GroupByParam.Items(0).Text = "เรียงตามรหัสสาขาและเวลาเข้างาน"
			GroupByParam.Items(1).Text = "เรียงตามพนักงานและเวลาเข้างาน"
			printtext.InnerHtml = "พิมพ์รายงาน"
			printtext2.InnerHtml = "พิมพ์รายงาน"
			gotop.InnerHtml = "กลับสู่ด้านบน"
		Else
			LangText0.Text = "Time Attandance Reports"
			GroupByParam.Items(0).Text = "Order By Shop Code,Clock in time"
			GroupByParam.Items(1).Text = "Order By Staff,Clock in time"
			printtext.InnerHtml = "Print Report"
			printtext2.InnerHtml = "Print Report"
			gotop.InnerHtml = "Top Page"
		End If
		GroupByParam.Items(0).Value = " pl.ProductLevelCode,pl.ProductLevelID,a.StartTime"
		GroupByParam.Items(1).Value = " a.StaffID,a.StartTime,pl.ProductLevelCode"
		If Request.Form("GroupByParam") = " pl.ProductLevelCode,pl.ProductLevelID,a.StartTime" Then
			GroupByParam.Items(0).Selected = True
		ElseIf Request.Form("GroupByParam") = " a.StaffID,a.StartTime,pl.ProductLevelCode" Then
			GroupByParam.Items(1).Selected = True
		Else
			GroupByParam.Items(0).Selected = True
		End If
			
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
		End If
		If Page.IsPostBack AND Request.Form("YearDate_Year") = "" Then Session("YearDate_Year") = 0
		YearDate.SelectedYear = Session("YearDate_Year")
		
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
		Dim ShopList As String = ""
		
		Dim ShopData As DataTable = getInfo.GetProductLevel(-999,objCnn)
		If ShopData.Rows.Count > 0 Then

			outputString = "<select name=""ShopID"" style=""width:200px"">"
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
	
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""
	Dim DailyDateValue As String = ""
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
	Dim outputString As String = ""

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

		Dim displayTable As New DataTable()
		
		ShowPrint.Visible = True
		ShowResults.Visible = True
		Dim AccountIDValue As Integer = -1
		If CompanyExist.Value = 1 Then
			AccountIDValue = AccountID.SelectedItem.Value
		End If
		Dim ResultData As New DataSet
		'Application.Lock()
		getReport.ClockInOutReport(ResultData, StartDate, EndDate, Request.Form("ShopID"), AccountIDValue,Request.Form("GroupByParam"), Session("LangID"),objCnn)
		'Application.UnLock()
		
		Dim i,j As Integer
		Dim HeaderString As String = ""
		Dim ColData As New DataTable 
		ColData = ResultData.Tables("ColumnData")
		HeaderString = "<tr>"

		For i = 1 to ColData.Columns.Count - 1
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + ColData.Rows(0)(i) + "</td>"
		Next
		HeaderString += "</tr>"
		TableHeaderText.InnerHtml = HeaderString
		
		Dim TextClass As String = "smallText"
		Dim ColSpan As String = "1"
		Dim Align As String = ""
		Dim outString As StringBuilder = New StringBuilder
		Dim dtTable As DataTable = ResultData.Tables("DataOutput")
		
		For i = 0 to dtTable.Rows.Count - 1
			outString = outString.Append("<tr>")
			For j = 1 to dtTable.Columns.Count - 1
				
				If j = 1 

						Align = "left"

				ElseIf j = 2 Or j=3 Or j=4 Then
					Align = "left"
				Else
					Align = "right"
				End If
				If Not IsDBNull(dtTable.Rows(i)(j)) Then
					If dtTable.Rows(i)("Property") <> 0 AND j=1 Then
						outString = outString.Append("<td align=""" + Align + """ colspan=""" + dtTable.Rows(i)(0).ToString + """ class=""" + TextClass + """>" + dtTable.Rows(i)(j) + "</td>") 
					Else
						outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + dtTable.Rows(i)(j) + "</td>") 
					End If
				End If
			Next
			outString = outString.Append("</tr>")
		Next
		outString = outString.Append("</table>")
		ResultText.InnerHtml = outString.ToString

		Dim ShopDisplay As String
		If Request.Form("ShopID") = 0 Then
			ShopDisplay = "All Shops"
		Else
			ShopDisplay = SelShopName.Value
		End If
		GenDateText.InnerHtml = "Report Date: " + Format(Now(), "dd MMMM yyyy HH:mm:ss")
		ResultSearchText.InnerHtml = "Time Attandance Report of " + ShopDisplay + "<br>" + ReportDate + ""
		
		
	End If
End Sub

Sub ExportData(Source As Object, E As EventArgs)
	Dim dtTable As DataTable
	Dim TestTime As String
	Dim FoundError As Boolean
	FoundError = False
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
	Dim outputString As String = ""

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
		CheckDate = DateAdd("d",1,CheckDate).ToString("yyyy-MM-dd HH:mm:ss", InvC)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),Year(CheckDate))
		
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
		CheckDate = DateAdd("d",1,CheckDate).ToString("yyyy-MM-dd HH:mm:ss", InvC)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),Year(CheckDate))

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

	Dim filename As String = "ClockInOutData.txt"
	Dim ResultText As String = ""
	
	If FoundError = False Then
	
		Dim AccountIDValue As Integer = -1
		If CompanyExist.Value = 1 Then
			AccountIDValue = AccountID.SelectedItem.Value
			If AccountIDValue > 0 Then
				Dim getAccount As DataTable = objDB.List("select * from AccountData where AccountID=" + AccountIDValue.ToString, objCnn)
				If getAccount.Rows.Count > 0 Then
					filename =  "ClockInOutData_" + getAccount.Rows(0)("AccountCode") + ".txt"
				End If
			End If
		End If
		
            getReport.ClockInOutExport(dtTable, StartDate, EndDate, Request.Form("ShopID"), AccountIDValue, Request.Form("GroupByParam"), objCnn)
		
            Dim i As Integer = 0
		
            Response.Clear()
            Response.ContentType = "application/text"
            Response.AddHeader("Content-Disposition", "attachment; filename=""" & filename & """")
            Response.Charset = "windows-874"
            Response.ContentEncoding = System.Text.Encoding.GetEncoding(874)
            Response.Flush()
            
            Select Case ExportType.Value
                Case 1
                    For i = 0 To dtTable.Rows.Count - 1
                        If Not IsDBNull(dtTable.Rows(i)("StaffIDNumber")) Then
                            Response.Write(dtTable.Rows(i)("StaffIDNumber"))
                        Else
                            Response.Write("")
                        End If
                        Response.Write(",")
                        Response.Write(CDate(dtTable.Rows(i)("SessionDate")).ToString("dd-MM-yyyy", InvC))
                        Response.Write(",")
                        Response.Write(Format(dtTable.Rows(i)("ClockInTime"), "HH:mm"))
                        Response.Write(",0")
                        Response.Write(Chr(13) & Chr(10))
                        If Not IsDBNull(dtTable.Rows(i)("StaffIDNumber")) Then
                            Response.Write(dtTable.Rows(i)("StaffIDNumber"))
                        Else
                            Response.Write("")
                        End If
                        Response.Write(",")
                        Response.Write(CDate(dtTable.Rows(i)("SessionDate")).ToString("dd-MM-yyyy", InvC))
                        Response.Write(",")
                        If Not IsDBNull(dtTable.Rows(i)("ClockOutTime")) Then
                            Response.Write(Format(dtTable.Rows(i)("ClockOutTime"), "HH:mm"))
                        Else
                            Response.Write("")
                        End If
                        Response.Write(",1")
                        Response.Write(Chr(13) & Chr(10))
                    Next
                    
                Case 2
                    For i = 0 To dtTable.Rows.Count - 1
                        If Not IsDBNull(dtTable.Rows(i)("StaffCode")) Then
                            Response.Write(dtTable.Rows(i)("StaffCode"))
                        Else
                            Response.Write("")
                        End If
                        Response.Write(" ")
                        Response.Write(CDate(dtTable.Rows(i)("ClockInTime")).ToString("dd-MM-yyyy"))
                        Response.Write(" ")
                        Response.Write(Format(dtTable.Rows(i)("ClockInTime"), "HH:mm"))
                        Response.Write(Chr(13) & Chr(10))
                        If Not IsDBNull(dtTable.Rows(i)("StaffCode")) Then
                            Response.Write(dtTable.Rows(i)("StaffCode"))
                        Else
                            Response.Write(" ")
                        End If
                        Response.Write(" ")
                        If Not IsDBNull(dtTable.Rows(i)("ClockOutTime")) Then
                            Response.Write(CDate(dtTable.Rows(i)("ClockOutTime")).ToString("dd-MM-yyyy"))
                        Else
                            Response.Write(" ")
                        End If
                        Response.Write(" ")
                        If Not IsDBNull(dtTable.Rows(i)("ClockOutTime")) Then
                            Response.Write(Format(dtTable.Rows(i)("ClockOutTime"), "HH:mm"))
                        Else
                            Response.Write(" ")
                        End If
                        Response.Write(Chr(13) & Chr(10))
                    Next
                   
                Case 4                      'For LME
                    'Response.Write("ShopCode,StaffCode,Date,TimeIn,TimeOut")
                    'Response.Write(chr(13) & chr(10))
                    For i = 0 To dtTable.Rows.Count - 1
                        Response.Write(dtTable.Rows(i)("ProductLevelCode"))
                        Response.Write(",")
                        Response.Write(dtTable.Rows(i)("StaffCode"))
                        Response.Write(",")
                        Response.Write(Format(dtTable.Rows(i)("SessionDate"), "dd/MM/yyyy"))
                        Response.Write(",")
                        Response.Write(Format(dtTable.Rows(i)("ClockInTime"), "HH:mm"))
                        Response.Write(",")
                        If Not IsDBNull(dtTable.Rows(i)("ClockOutTime")) Then
                            Response.Write(Format(dtTable.Rows(i)("ClockOutTime"), "HH:mm"))
                        Else
                            Response.Write("")
                        End If
                        Response.Write(Chr(13) & Chr(10))
                    Next
                    
                Case 5              'For Yogurtland Customize
                    Dim rResult() As DataRow
                    Dim j As Integer
                    
                    If dtTable.Columns.Contains("AlreadyProcess") = False Then
                        dtTable.Columns.Add("AlreadyProcess", System.Type.GetType("System.Integer"))
                        For i = 0 To dtTable.Rows.Count - 1
                            dtTable.Rows(i)("AlreadyProcess") = 0
                        Next
                    End If
                    
                    Response.Write("ShopCode,StaffCode,Date,TimeIn,TimeOut")
                    Response.Write(Chr(13) & Chr(10))
                    For i = 0 To dtTable.Rows.Count - 1
                        If dtTable.Rows(i)("AlreadyProcess") = 0 Then
                            rResult = dtTable.Select("ProductLevelID = " & dtTable.Rows(i)("ProductLevelID") & " AND StaffID = " & dtTable.Rows(i)("StaffID") & _
                                                  " AND AlreadyProcess = 0 ")
                           
                            Response.Write(dtTable.Rows(i)("ProductLevelCode"))
                            Response.Write(",")
                            Response.Write(dtTable.Rows(i)("StaffCode"))
                            Response.Write(",")
                            Response.Write(Format(dtTable.Rows(i)("SessionDate"), "ddMMyyyy"))
                            'Write Clock In/Out
                            For j = 0 To rResult.Length - 1
                                If dtTable.Rows(i)("SessionDate") = rResult(j)("SessionDate") Then
                                    Response.Write(",")
                                    Response.Write(Format(rResult(j)("ClockInTime"), "HHmmss"))
                                    Response.Write(",")
                                    If Not IsDBNull(rResult(j)("ClockOutTime")) Then
                                        Response.Write(Format(rResult(j)("ClockOutTime"), "HHmmss"))
                                    Else
                                        Response.Write("")
                                    End If
                                    rResult(j)("AlreadyProcess") = 1
                                End If
                            Next j
                            Response.Write(Chr(13) & Chr(10))
                        End If
                    Next
                    
                Case Else
                    Response.Write("ShopCode,StaffCode,Date,TimeIn,TimeOut")
                    Response.Write(Chr(13) & Chr(10))
                    For i = 0 To dtTable.Rows.Count - 1
                        Response.Write(dtTable.Rows(i)("ProductLevelCode"))
                        Response.Write(",")
                        Response.Write(dtTable.Rows(i)("StaffCode"))
                        Response.Write(",")
                        Response.Write(Format(dtTable.Rows(i)("SessionDate"), "ddMMyyyy"))
                        Response.Write(",")
                        Response.Write(Format(dtTable.Rows(i)("ClockInTime"), "HHmmss"))
                        Response.Write(",")
                        If Not IsDBNull(dtTable.Rows(i)("ClockOutTime")) Then
                            Response.Write(Format(dtTable.Rows(i)("ClockOutTime"), "HHmmss"))
                        Else
                            Response.Write("")
                        End If
                        Response.Write(Chr(13) & Chr(10))
                    Next
                                       
            End Select
            
            Response.End()
        End If

End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub
	
</script>
</body>
</html>
