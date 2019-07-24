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
<title>Deposit Bank Report</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<input type="hidden" id="ShopIDList" runat="server" />
<input type="hidden" id="IsMobile" runat="server" />
<a name="TopPage" id="TopPage"></a>
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Deposit Bank Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
			<tr id="showoption" visible="false" runat="server">
				<td><asp:dropdownlist ID="GroupByParam" Width="200" runat="server">
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

<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr>
</table>
<table border="0" width="100%">

<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>
<span id="startTable" runat="server"></span>
	<thead><tr>
	<span id="TableHeaderText" runat="server"></span>
    <span id="ExtraHeader" runat="server"></span>
	</thead></tr>
  
  <tbody>
	<div id="ResultText" runat="server"></div>
  </tbody>
  <tfoot>
	<div id="SummaryResult" runat="server"></div>
	</tfoot>
<asp:Panel ID="showGraph" Visible="false" runat="server">
<br>
<Web:ChartControl id="ChartControl1" runat="Server" />
</asp:Panel></td></tr>
</table>
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
Dim getInfo As New CCategory()
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer = 998
		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("DepositReport") Then
		
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

		StartTable.InnerHtml = "<table id=""myTable2"" class=""blue""  width=""100%"">"
		
		Dim HeaderString As String = ""
		
		HeaderString += "<th align=""center"">" + "Outlet" + "</td>"
		HeaderString += "<th align=""center"">" + "Date" + "</td>"
		HeaderString += "<th align=""center"">" + "No." + "</td>"
		HeaderString += "<th align=""center"">" + "Close Time" + "</td>"
		HeaderString += "<th align=""center"">" + "Closed By" + "</td>"
		HeaderString += "<th align=""center"">" + "Deposit Time" + "</td>"
		HeaderString += "<th align=""center"">" + "Deposit By" + "</td>"
		HeaderString += "<th align=""center"">" + "Bank Info" + "</td>"
		HeaderString += "<th align=""center"">" + "Deposit Fee" + "</td>"
		HeaderString += "<th align=""center"">" + "Deposit Amount" + "</td>"
		'HeaderString += "<th align=""center"">" + "Account #" + "</td>"
		HeaderString += "<th align=""center"">" + "Cash Amount" + "</td>"
		HeaderString += "<th align=""center"">" + "Reference" + "</td>"
		HeaderString += "<th align=""center"">" + "Remark" + "</td>"
		HeaderString += "<th align=""center"">" + "Diff" + "</td>"
		
		TableHeaderText.InnerHtml = HeaderString
		
		DocumentToDateParam.InnerHtml = LangDefault.Rows(22)(LangText)
		
		
		If Request.QueryString("mobile") = "yes" Then
			IsMobile.Value = 1
		Else
			IsMobile.Value = 0
		End If
		
		GroupByParam.Items(0).Text = "Display By Outlet"
		GroupByParam.Items(0).Value = "1"
		GroupByParam.Items(1).Text = "Display By Date"
		GroupByParam.Items(1).Value = "2"
		If Request.Form("GroupByParam") = 1 Then
			GroupByParam.Items(0).Selected = True
		ElseIf Request.Form("GroupByParam") = 2 Then
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
		YearDate.Lang_Data = LangDefault
		YearDate.Culture = CultureString
		
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
		
		Dim ShopData As DataTable

		ShopData = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)

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
	Dim FormatData As DataTable = Util.FormatParam(FormatObject,Session("LangID"),objCnn)
	Dim ci As New CultureInfo(FormatObject.CultureString)
	
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
	
	If FoundError = False Then
		If LangDefault.Rows.Count >= 3 Then
			CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(NOW(), "DateAndTime",Session("LangID"),objCnn)
		End If
		Dim displayTable As New DataTable()
		
		ShowPrint.Visible = True
		ShowResults.Visible = True
		Dim ShopIDList As String = Request.Form("ShopID").ToString
		Dim i,j As Integer
		If Request.Form("ShopID") = "0" Then
			Dim ShopData As DataTable

			ShopData = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)

			For i = 0 To ShopData.Rows.Count - 1
				ShopIDList += "," + ShopData.Rows(i)("ProductLevelID").ToString
			Next
		End If
		
		Dim MultiDeposit As Boolean = False
		Dim ChkMulti As DataTable = getProp.PropertyValue(1,1025,1,objCnn)
		If ChkMulti.Rows.Count > 0 Then
			If ChkMulti.Rows(0)("PropertyValue") = 1 Then
				MultiDeposit = True
			End If
		End If
	
		Dim ResultData As New DataSet
		'Application.Lock()
		DepositBankReport(ResultData, StartDate, EndDate, ShopIDList, Request.Form("GroupByParam"),"", Session("LangID"),objCnn)
		'Application.UnLock()
		
		Dim HeaderString As String = ""
		Dim ColData As New DataTable 
		'ColData = ResultData.Tables("ColumnData")
		'HeaderString = "<tr>"

		'For i = 1 to ColData.Columns.Count - 1
			'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + ColData.Rows(0)(i) + "</td>"
		'Next
		'HeaderString += "</tr>"
		'TableHeaderText.InnerHtml = HeaderString
		
		Dim TextClass As String = "smallText"
		Dim ColSpan As String = "1"
		Dim Align As String = ""
		Dim ExtraProp As String = ""
		Dim outString As StringBuilder = New StringBuilder
		Dim dtTable As DataTable = ResultData.Tables("DataOutput")
		
		For i = 0 to dtTable.Rows.Count - 1
			If i = dtTable.Rows.Count - 1 Then
				TextClass = "smallText"'"smallsummaryText"
			Else
				TextClass = "smallText"
			End If
			outString = outString.Append("<tr>")
			For j = 1 to dtTable.Columns.Count - 1

				ExtraProp = ""
				If j = 1 
					If dtTable.Rows(i)("Property") > 0 Then
						Align = "right"
					Else
						Align = "left"
					End If
				ElseIf j = 2 Or j=3 Or j=4 Or j=6 Then
					Align = "center"
				ElseIf j=4 Or j=7 Or j=8 Or j=13 Or j=19 Or j=12 Then
					Align = "left"
				ElseIf j = 5 Then
					If Request.Form("GroupByParam") = 1 Then
						Align = "right"
					Else
						Align = "left"
					End If
				Else
					Align = "right"
				End If

				If Not IsDBNull(dtTable.Rows(i)(j)) Then
					If dtTable.Rows(i)("Property") <> 0 AND j=1 Then
						If dtTable.Rows(i)(0) < 11 Then
							TextClass = "smallText"'"smallsummaryText"
						Else
							TextClass = "smallText"
						End If
						outString = outString.Append("<td align=""" + Align + """ colspan=""" + (dtTable.Rows(i)(0)-1).ToString + """ class=""" + TextClass + ExtraProp + """>" + dtTable.Rows(i)(j) + "</td>") 
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
		ResultSearchText.InnerHtml = "Deposit Bank Report of " + ShopDisplay + "<br>" + ReportDate + ""
		
		Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<thead><tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</thead></tr><tbody>" & ResultText.InnerHtml & "</td></tbody></tr></table>"
		
		
	End If
End Sub

Public Function DepositBankReport(ByRef ResultData As DataSet, ByVal StartDate As String, ByVal EndDate As String, ByVal ShopID As String, ByVal GroupByParam As Integer, ByVal OrderByString As String, ByVal LangID As Integer, ByVal objCnn As MySqlConnection) As String
		Dim FormatData As DataTable = Util.FormatParam(FormatObject,LangID,objCnn)
		Dim ci As New CultureInfo(FormatObject.CultureString)
        Dim sqlStatement As String
        Dim AdditionalQuery As String = ""
        Dim ShopIDListValue As String
        Dim ResultString As String = ""
        Dim TextClass As String
        Dim GetData As DataTable
        Dim i, j As Integer

        If Trim(ShopID) <> "" Then
            AdditionalQuery += " AND aa.ProductLevelID IN (" + ShopID + ")"
        End If

        If StartDate <> "" And EndDate <> "" Then
            AdditionalQuery += " AND (aa.SessionDate >= " + StartDate + " AND aa.SessionDate < " + EndDate + ")"
        End If

        Dim OrderBy As String
        If GroupByParam = 1 Then
            OrderBy = " pl.ProductLevelCode,pl.ProductLevelID,Day(aa.SessionDate),Month(aa.SessionDate),Year(aa.SessionDate),aa.AccountID, aa.AccountShopID, aa.CloseSessionDateTime DESC "
        Else
            OrderBy = " pl.ProductLevelCode,pl.ProductLevelID,Day(aa.SessionDate),Month(aa.SessionDate),Year(aa.SessionDate),aa.AccountID, aa.AccountShopID, aa.CloseSessionDateTime DESC "
        End If
        If Trim(OrderByString) <> "" Then OrderBy = OrderByString

        'sqlStatement = "select pl.ProductLevelID + DatePart(d,ss.SessionDate) + Month(ss.SessionDate) + Year(ss.SessionDate) As KeyString, ss.*,pl.ProductLevelCode,pl.ProductLevelName,s1.StaffFirstName + ' ' + s1.StaffLastName As CloseStaffFullName,s2.StaffFirstName + ' ' + s2.StaffLastName As DepositStaffFullName, ba.BankName, ba.BankAccountNo_A, ba.BankAccountNo_B " + _
     '" from session ss " + _
     '" left outer join ProductLevel pl ON ss.ProductLevelID=pl.ProductLevelID " + _
    '' " left outer join staffs s1 ON ss.CloseStaffID=s1.StaffID " + _
    ' " left outer join staffs s2 ON ss.DepositStaffID=s2.StaffID " + _
    ' " left outer join DepositBank ba ON ss.BankID_AccountA=ba.BankID " + _
    ' " left outer join DepositBank bb ON ss.BankID_AccountB=bb.BankID " + _
    ' " where ss.SessionAccountStatus IN (1,2) " + AdditionalQuery + _
        '      " Order By " + OrderBy
			  
		sqlStatement = " select CONCAT(CAST(pl.ProductLevelID AS CHAR),CAST(Day(aa.SessionDate) AS CHAR),CAST(Month(aa.SessionDate) AS CHAR),CAST(Year(aa.SessionDate) AS CHAR)) As KeyString,aa.*,ba.*,pl.ProductLevelCode,pl.ProductLevelName,CONCAT(aa.StaffFirstName,' ',aa.StaffLastName) As CloseStaffFullName,CONCAT(s2.StaffFirstName,' ',s2.StaffLastName) As DepositStaffFullName, d.BankName, d.BankAccountNo As BankAccountNo_A, d.BankAccountNo As BankAccountNo_B  " & _
		" from (Select count(*) As TotalSessionDay,a.AccountID,a.AccountShopID,b.ProductLevelID,b.SessionDate,s1.StaffFirstName,s1.StaffLastName,b.CloseSessionDateTime,c.EndDayDateTime From SessionBankAccountLink a, Session b, SessionEndDayDetail c, Staffs s1 where a.SessionID=b.SessionID AND a.ComputerID=b.ComputerID AND b.ProductLevelID=c.ProductLevelID AND b.SessionDate=c.SessionDate AND b.CloseStaffID=s1.StaffID AND c.IsEndDay=1 " & _
		" group by a.AccountID,a.AccountShopID,b.ProductLevelID,b.SessionDate,s1.StaffFirstName,s1.StaffLastName,b.CloseSessionDateTime,c.EndDayDateTime) aa " & _
		" left outer join ProductLevel pl ON aa.ProductLevelID=pl.ProductLevelID  " & _
		" left outer join SessionBankAccountDetail ba ON aa.AccountID=ba.AccountID AND aa.AccountShopID=ba.AccountShopID " & _
		" left outer join DepositBank d ON ba.AccountBankID=d.BankID  " & _
		" left outer join staffs s2 ON ba.DepositStaffID=s2.StaffID  " & _
		" where ba.SessionAccountStatus IN (1,2) AND ba.SubAccountID=0 " & AdditionalQuery & _
		" Order By " & OrderBy
	
        Dim dtTable As DataTable = objDB.List(sqlStatement, objCnn)

		' From SQL Statement there maybe some AccountID, AccountShopID has more than 2 rows (Due to more than 1 session)
		Dim accountID, accountShopID As Integer
        accountID = -1
        accountShopID = -1
        'Remove Repeat AccountID, AccountShopID
        For i = 0 To dtTable.Rows.Count - 1
            If i >= dtTable.Rows.Count Then
                Exit For
            End If
            'Remove Repeat AccountID, AccountShopID
            If (accountID = dtTable.Rows(i)("AccountID")) And (accountShopID = dtTable.Rows(i)("AccountShopID")) Then
                dtTable.Rows.RemoveAt(i)
                i -= 1
            End If
            accountID = dtTable.Rows(i)("AccountID")
            accountShopID = dtTable.Rows(i)("AccountShopID")
        Next i
			
        Dim ColData As New DataTable

        Dim dtTableOut As New DataTable
        ColData.Columns.Clear()
        dtTableOut.Columns.Clear()
        ColData.Columns.Add("Property", System.Type.GetType("System.Int32"))
        dtTableOut.Columns.Add("Property", System.Type.GetType("System.Int32"))

        For i = 1 To 16
            ColData.Columns.Add("Col" & i.ToString, System.Type.GetType("System.String"))
            dtTableOut.Columns.Add("Col" & i.ToString, System.Type.GetType("System.String"))
        Next

        Dim rData As DataRow

        Dim counter As Integer = 1
        Dim CompareString As String = ""
        Dim DummyCompareString As String = "-1"
        Dim subTotalDepositA, subTotalFeeA, subTotalDepositB, subTotalFeeB, subTotalDiff, subTotalCash As Double
        Dim grandTotalDepositA, grandTotalFeeA, grandTotalDepositB, grandTotalFeeB, grandTotalDiff, grandTotalCash As Double
		Dim BankInfo As String
        For i = 0 To dtTable.Rows.Count - 1

            If Not IsDBNull(dtTable.Rows(i)("KeyString")) Then
                CompareString = dtTable.Rows(i)("KeyString")
            Else
                CompareString = ""
            End If
            If Not (DummyCompareString = CompareString) Then

                If i <> 0 Then
                    'rData = dtTableOut.NewRow
                    'rData(0) = 10
                    'If Not IsDBNull(dtTable.Rows(i - 1)("KeyString")) Then
                       ' rData(1) = "Outlet Total: " + dtTable.Rows(i - 1)("ProductLevelName") + " Date " + Format(dtTable.Rows(i - 1)("SessionDate")).ToString(FormatObject.DateFormat, ci)
                    'Else
                        'rData(1) = "N/A Total"
                    'End If
                    'rData(11) = Format(subTotalDepositA).ToString(FormatObject.CurrencyFormat, ci)
                    'rData(12) = Format(subTotalFeeA).ToString(FormatObject.CurrencyFormat, ci)
                    'rData(13) = "-"
                    'rData(14) = Format(subTotalDepositB).ToString(FormatObject.CurrencyFormat, ci)
                    'rData(15) = Format(subTotalFeeB).ToString(FormatObject.CurrencyFormat, ci)
                    'rData(16) = "-"
                    'rData(17) = Format(subTotalDepositA + subTotalDepositB).ToString(FormatObject.CurrencyFormat, ci)
                    'rData(18) = Format(subTotalFeeA + subTotalFeeB).ToString(FormatObject.CurrencyFormat, ci)
                    'rData(19) = "-"
                    'dtTableOut.Rows.Add(rData)

                End If

                counter = 1
                subTotalDepositA = 0
                subTotalFeeA = 0
                subTotalDepositB = 0
                subTotalFeeB = 0
				subTotalDiff = 0
				subTotalCash = 0

            End If
            rData = dtTableOut.NewRow
            rData(0) = 0

            rData("Col1") = dtTable.Rows(i)("ProductLevelName")
            rData("Col2") = CDate(dtTable.Rows(i)("SessionDate")).ToString(FormatObject.DateFormat, ci)
            rData("Col3") = counter.ToString

            If Not IsDBNull(dtTable.Rows(i)("CloseSessionDateTime")) Then
                rData("Col4") = CDate(dtTable.Rows(i)("CloseSessionDateTime")).ToString(FormatObject.TimeFormat, ci)
            Else
                rData("Col4") = ""
            End If
            If Not IsDBNull(dtTable.Rows(i)("CloseStaffFullName")) Then
                rData("Col5") = dtTable.Rows(i)("CloseStaffFullName")
            Else
                rData("Col5") = ""
            End If


            If Not IsDBNull(dtTable.Rows(i)("DepositDateTime")) Then
                rData("Col6") = CDate(dtTable.Rows(i)("DepositDateTime")).ToString(FormatObject.DateFormat, ci) + " " + CDate(dtTable.Rows(i)("DepositDateTime")).ToString(FormatObject.TimeFormat, ci)
            Else
                rData("Col6") = ""
            End If
            If Not IsDBNull(dtTable.Rows(i)("DepositStaffFullName")) Then
                rData("Col7") = dtTable.Rows(i)("DepositStaffFullName")
            Else
                rData("Col7") = ""
            End If
			
			BankInfo = ""
            If Not IsDBNull(dtTable.Rows(i)("BankName")) Then
				BankInfo = dtTable.Rows(i)("BankName")
            End If
            If Not IsDBNull(dtTable.Rows(i)("BankAccountNo_A")) Then
				BankInfo += ":" + dtTable.Rows(i)("BankAccountNo_A")
            Else
            End If
			
			rData("Col8") = BankInfo
            rData("Col9") = CDbl(dtTable.Rows(i)("AccountFee")).ToString(FormatObject.CurrencyFormat, ci)
			rData("Col10") = CDbl(dtTable.Rows(i)("AmountToBankInAccount")).ToString(FormatObject.CurrencyFormat, ci)
            rData("Col11") = CDbl(dtTable.Rows(i)("AmountInAccount") + dtTable.Rows(i)("AdjustAmount")).ToString(FormatObject.CurrencyFormat, ci)
			
            
            If Not IsDBNull(dtTable.Rows(i)("AccountReference")) Then
                rData("Col12") = dtTable.Rows(i)("AccountReference")
            Else
                rData("Col12") = ""
            End If

            If Not IsDBNull(dtTable.Rows(i)("DepositNote")) Then
                rData("Col13") = dtTable.Rows(i)("DepositNote")
            Else
                rData("Col13") = ""
            End If
			rData("Col14") = CDbl(dtTable.Rows(i)("AmountToBankInAccount") - (dtTable.Rows(i)("AmountInAccount") + dtTable.Rows(i)("AdjustAmount"))).ToString(FormatObject.CurrencyFormat, ci)
			
            subTotalCash += dtTable.Rows(i)("AmountInAccount") + dtTable.Rows(i)("AdjustAmount")
			subTotalDepositA += dtTable.Rows(i)("AmountToBankInAccount")
            subTotalFeeA += dtTable.Rows(i)("AccountFee")
            subTotalDepositB += dtTable.Rows(i)("AmountInAccount") + dtTable.Rows(i)("AdjustAmount")
            subTotalFeeB += dtTable.Rows(i)("AccountFee")
			subTotalDiff += dtTable.Rows(i)("AmountToBankInAccount") - (dtTable.Rows(i)("AmountInAccount") + dtTable.Rows(i)("AdjustAmount"))

            grandTotalCash += dtTable.Rows(i)("AmountInAccount") + dtTable.Rows(i)("AdjustAmount")
			grandTotalDepositA += dtTable.Rows(i)("AmountToBankInAccount")
            grandTotalFeeA += dtTable.Rows(i)("AccountFee")
            grandTotalDepositB += dtTable.Rows(i)("AmountInAccount") + dtTable.Rows(i)("AdjustAmount")
            grandTotalFeeB += dtTable.Rows(i)("AccountFee")
			
			grandTotalDiff += dtTable.Rows(i)("AmountToBankInAccount") - (dtTable.Rows(i)("AmountInAccount") + dtTable.Rows(i)("AdjustAmount"))

            dtTableOut.Rows.Add(rData)

            counter = counter + 1

            If Not IsDBNull(dtTable.Rows(i)("KeyString")) Then
                DummyCompareString = dtTable.Rows(i)("KeyString")
            Else
                DummyCompareString = ""
            End If
        Next

        If counter > 0 And dtTable.Rows.Count > 0 Then
            'rData = dtTableOut.NewRow
            'rData(0) = 10
            'If Not IsDBNull(dtTable.Rows(i - 1)("KeyString")) Then
            '    rData(1) = "Outlet Total: " + dtTable.Rows(i - 1)("ProductLevelName") + " Date " + Format(dtTable.Rows(i - 1)("SessionDate")).ToString(FormatObject.DateFormat, ci)
            'Else
            '    rData(1) = "N/A Total:"
            'End If
            'rData(11) = Format(subTotalDepositA).ToString(FormatObject.CurrencyFormat, ci)
            'rData(12) = Format(subTotalFeeA).ToString(FormatObject.CurrencyFormat, ci)
            'rData(13) = "-"
            'rData(14) = Format(subTotalDepositB).ToString(FormatObject.CurrencyFormat, ci)
            'rData(15) = Format(subTotalFeeB).ToString(FormatObject.CurrencyFormat, ci)
            'rData(16) = "-"
            'rData(17) = Format(subTotalDepositA + subTotalDepositB).ToString(FormatObject.CurrencyFormat, ci)
            'rData(18) = Format(subTotalFeeA + subTotalFeeB).ToString(FormatObject.CurrencyFormat, ci)
            'rData(19) = "-"
            'dtTableOut.Rows.Add(rData)

            rData = dtTableOut.NewRow
            rData(0) = 9
            rData(1) = "Grand Total:"
			rData(9) = CDbl(grandTotalFeeA).ToString(FormatObject.CurrencyFormat, ci)
            rData(10) = CDbl(grandTotalDepositA).ToString(FormatObject.CurrencyFormat, ci)
			rData(11) = CDbl(grandTotalCash).ToString(FormatObject.CurrencyFormat, ci)
            rData(12) = "-"
            rData(13) = "-"
			rData(14) = CDbl(grandTotalDiff).ToString(FormatObject.CurrencyFormat, ci)
            dtTableOut.Rows.Add(rData)
        End If

        ColData.TableName = "ColumnData"
        ResultData.Tables.Add(ColData)
        dtTableOut.TableName = "DataOutput"
        ResultData.Tables.Add(dtTableOut)


    End Function

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "DepositBankData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub	
	
Sub Page_UnLoad()
	objCnn.Close()
End Sub
	
</script>
</body>
</html>
