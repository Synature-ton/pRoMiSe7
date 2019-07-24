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
<title>Sale Reports By Department</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
		<td id="headerTD1" align="center" class="smallTdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD12" align="center" class="smallTdHeader" runat="server"><div id="Text12" runat="server"></div></td>
		<td id="headerTD13" align="center" class="smallTdHeader" runat="server"><div id="Text13" runat="server"></div></td>
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
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer = 10

Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_ByNewGroup") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
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
		
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(13,Session("LangID"),objCnn)
		Dim textTable1 As New DataTable()
		textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
		
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
		'LangList.Text = LangListText
		
		Dim LangData2 As DataTable = getProp.GetLangData(PageID,2,-1,Request)
		
		Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)

		SubmitForm.Text = textTable.Rows(8)("TextParamValue")
		
		headerTD1.Visible = True
		headerTD2.Visible = True
		headerTD3.Visible = True
		headerTD4.Visible = True
		headerTD5.Visible = True
		headerTD6.Visible = True
		headerTD7.Visible = False
		headerTD8.Visible = True
		headerTD9.Visible = True
		headerTD10.Visible = True
		headerTD11.Visible = False
		headerTD12.Visible = False
		headerTD13.Visible = False
		


		StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"

		Text1.InnerHtml = "Code"
		Text2.InnerHtml = "Product Dept"
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
		
		'HeaderText.InnerHtml = "Sale Report By Products"
		LangText0.Text = "Sale Report By Products"
			
		DailyDate.YearType = GlobalParam.YearType
		DailyDate.FormName = "DocDaily"
		DailyDate.StartYear = 1
		DailyDate.EndYear = 2
		DailyDate.LangID = Session("LangID")
		DailyDate.Lang_Data = LangDefault
		DailyDate.Culture = CultureString
		
		CurrentDate.YearType = GlobalParam.YearType
		CurrentDate.FormName = "Doc"
		CurrentDate.StartYear = 1
		CurrentDate.EndYear = 2
		CurrentDate.LangID = Session("LangID")
		CurrentDate.Lang_Data = LangDefault
		CurrentDate.Culture = CultureString
		
		ToDate.YearType = GlobalParam.YearType
		ToDate.FormName = "DocTo"
		ToDate.StartYear = 1
		ToDate.EndYear = 2
		ToDate.LangID = Session("LangID")
		ToDate.Lang_Data = LangDefault
		ToDate.Culture = CultureString
		
		MonthYearDate.YearType = GlobalParam.YearType
		MonthYearDate.FormName = "MonthYearDate"
		MonthYearDate.StartYear = 1
		MonthYearDate.EndYear = 2
		MonthYearDate.LangID = Session("LangID")
		MonthYearDate.ShowDay = False
		MonthYearDate.Lang_Data = LangDefault
		MonthYearDate.Culture = CultureString
		
		YearDate.YearType = GlobalParam.YearType
		YearDate.FormName = "YearDate"
		YearDate.StartYear = 3
		YearDate.EndYear = 0
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
			'CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(NOW(), "DateAndTime",Session("LangID"),objCnn)
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
		
		'Application.Lock()
		Dim dtTable As DataTable = getReport.SaleReportByNewGroup(1,outputString, grandTotal, VATTotal, GraphData, PaymentResult, PayByCreditMoney, StartDate, EndDate, Request.Form("ShopID"),0,0, objCnn)

		GenOutputSaleByDept(outputString,grandTotal,VATTotal,False,GlobalParam.GrayBGColor,GlobalParam.AdminBGColor,dtTable,PaymentResult,PayByCreditMoney,Request.Form("ShopID"),StartDate,EndDate,objCnn)

		If Request.Form("ShopID") >= 0 Then
			ResultText.InnerHtml = outputString
		End If
		Dim ShopDisplay As String
		If Request.Form("ShopID") = 0 Then
			ShopDisplay = "All Shops"
		Else
			ShopDisplay = SelShopName.Value
		End If
		ResultSearchText.InnerHtml = "Sale Report By Department of " + ShopDisplay + " (" + ReportDate + ")"
		'Application.UnLock()
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
	
	Public Function GenOutputSaleByDept(ByRef outputString As String, ByRef grandTotal As Double, ByRef VATTotal As Double, ByVal ShowSummary As Boolean, ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal dtTable As DataTable, ByVal PaymentResult As DataTable, ByVal PayByCreditMoney As DataTable, ByVal ShopID As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal objCnn As MySqlConnection) As String

        Dim i As Integer
        outputString = ""
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
        Dim CompareGroupCode, CompareDeptCode, DummyGroupCode, DummyDeptCode As String
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
            totalSale += dtTable.Rows(i)("SalePrice")
            totalRetailPrice += dtTable.Rows(i)("TotalRetailPrice")
            totalQty += dtTable.Rows(i)("Amount")
        Next

        For i = 0 To dtTable.Rows.Count - 1
            If Not IsDBNull(dtTable.Rows(i)("ProductGroupCode")) Then
                CompareGroupCode = dtTable.Rows(i)("ProductGroupCode")
            Else
                CompareGroupCode = ""
            End If

            If Not (DummyGroupCode = CompareGroupCode) Then

                If i <> 0 Then
                    outputString += "<tr bgColor=""" + bgColor + """>"
                    outputString += "<td colspan=""2"" align=""right"" class=""" + TextClass + """>Total for " + dtTable.Rows(i - 1)("ProductGroupName") + "</td>"
                    outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(subTotalQty, "##,##0.0") + "</td>"
                    outputString += "<td align=""right"" class=""" + TextClass + """>" + Format((subTotalQty / totalQty) * 100, "##,##0.00") + "%</td>"
                    outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(subTotalRetailPrice, "##,##0.00") + "</td>"
                    outputString += "<td align=""right"" class=""" + TextClass + """>" + Format((subTotalRetailPrice / totalRetailPrice) * 100, "##,##0.00") + "%</td>"
                    outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(subTotalDiscount, "##,##0.00") + "</td>"

                    outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(subTotalAfterVAT, "##,##0.00") + "</td>"
                    outputString += "<td align=""right"" class=""" + TextClass + """>" + Format((subTotalAfterVAT / totalSale) * 100, "##,##0.00") + "%</td>"
                    outputString += "</tr>"

                    myDataRow = myDataTable.NewRow()
                    myDataRow("ProductGroupName") = dtTable.Rows(i - 1)("ProductGroupName")
                    myDataRow("ProductGroupSale") = subTotalAfterVAT
                    myDataTable.Rows.Add(myDataRow)

                    subTotalPriceDiscount = 0
                    subTotalDiscount = 0
                    subTotalBeforeVAT = 0
                    subTotalVAT = 0
                    subTotalAfterVAT = 0
                    subTotalRetailPrice = 0
                    subTotalQty = 0
                    subTotalServiceCharge = 0
                    subTotalServiceChargeVAT = 0

                End If

                outputString += "<tr><td colspan=""10"" class=""tdHeader"" bgColor=""" + AdminBGColor + """>" + dtTable.Rows(i)("ProductGroupName") + "</td></tr>"


            End If

            outputString += "<tr bgColor=""" + bgColor + """>"

            If Not IsDBNull(dtTable.Rows(i)("ProductDeptCode")) Then
                outputString += "<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("ProductDeptCode") & "</td>"
            Else
                outputString += "<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>"
            End If

            If Not IsDBNull(dtTable.Rows(i)("ProductDeptName")) Then
                outputString += "<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("ProductDeptName") + ExtraInfo & "</td>"
            Else
                outputString += "<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>"
            End If
            If Not IsDBNull(dtTable.Rows(i)("Amount")) Then
                outputString += "<td align=""right"" class=""" + TextClass + """>" & Format(dtTable.Rows(i)("Amount"), "##,##0.0") & "</td>"

                ProductQty = dtTable.Rows(i)("Amount")

                subTotalQty += ProductQty
                grandTotalQty += ProductQty
                outputString += "<td align=""right"" class=""" + TextClass + """>" & Format((ProductQty / totalQty) * 100, "##,##0.00") & "%</td>"

            Else
                outputString += "<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>"
                outputString += "<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>"
                ProductQty = 0
            End If

            If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) Then

                RetailPriceAfterVAT = dtTable.Rows(i)("TotalRetailPrice")
                outputString += "<td align=""right"" class=""" + TextClass + """>" & Format(RetailPriceAfterVAT, "##,##0.00") & "</td>"
                outputString += "<td align=""right"" class=""" + TextClass + """>" & Format((RetailPriceAfterVAT / totalRetailPrice) * 100, "##,##0.00") & "%</td>"
                subTotalRetailPrice += dtTable.Rows(i)("TotalRetailPrice")
                grandTotalRetailPrice += dtTable.Rows(i)("TotalRetailPrice")

            Else
                outputString += "<td align=""right"" class=""" + TextClass + """>" & "0.00" & "</td>"
                outputString += "<td align=""right"" class=""" + TextClass + """>" & "0.00" & "%</td>"
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
            If Not IsDBNull(dtTable.Rows(i)("PricePromotionDiscount")) Then
                TotalProductDiscount += dtTable.Rows(i)("PricePromotionDiscount")
                DiscountArray(1) += dtTable.Rows(i)("PricePromotionDiscount")
            End If
            TotalProductDiscount = dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("SalePrice")
            subTotalDiscount += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("SalePrice")
            grandTotalDiscount += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("SalePrice")



            outputString += "<td align=""right"" class=""" + TextClass + """>" & Format(TotalProductDiscount, "##,##0.00") & "</td>"


            If Not IsDBNull(dtTable.Rows(i)("SalePrice")) Then
                lineTotal = dtTable.Rows(i)("SalePrice")
                outputString += "<td align=""right"" class=""" + TextClass + """>" & Format(lineTotal, "##,##0.00") & "</td>"
                outputString += "<td align=""right"" class=""" + TextClass + """>" & Format((lineTotal) / totalSale * 100, "##,##0.00") & "%</td>"
                subTotalAfterVAT += lineTotal
                grandTotalAfterVAT += lineTotal

            Else
                outputString += "<td align=""right"" class=""" + TextClass + """>" & "0.00" & "</td>"
                outputString += "<td align=""right"" class=""" + TextClass + """>" & "0.00" & "%</td>"
            End If

            outputString += "</tr>"

            counter = counter + 1

            If Not IsDBNull(dtTable.Rows(i)("ProductGroupCode")) Then
                DummyGroupCode = dtTable.Rows(i)("ProductGroupCode")
            Else
                DummyGroupCode = ""
            End If

        Next

        If counter > 0 And dtTable.Rows.Count > 0 Then
            outputString += "<tr bgColor=""" + bgColor + """>"
            If i > 0 Then
                outputString += "<td colspan=""2"" align=""right"" class=""" + TextClass + """>Total for " + dtTable.Rows(i - 1)("ProductGroupName") + "</td>"
            Else
                outputString += "<td colspan=""2"" align=""right"" class=""" + TextClass + """></td>"
            End If

            outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(subTotalQty, "##,##0.0") + "</td>"
            outputString += "<td align=""right"" class=""" + TextClass + """>" + Format((subTotalQty / totalQty) * 100, "##,##0.00") + "%</td>"
            outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(subTotalRetailPrice, "##,##0.00") + "</td>"
            outputString += "<td align=""right"" class=""" + TextClass + """>" + Format((subTotalRetailPrice / totalRetailPrice) * 100, "##,##0.00") + "%</td>"
            outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(subTotalDiscount, "##,##0.00") + "</td>"

            outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(subTotalAfterVAT, "##,##0.00") + "</td>"
            outputString += "<td align=""right"" class=""" + TextClass + """>" + Format((subTotalAfterVAT / totalSale) * 100, "##,##0.00") + "%</td>"
            outputString += "</tr>"

            myDataRow = myDataTable.NewRow()
            myDataRow("ProductGroupName") = dtTable.Rows(i - 1)("ProductGroupName")
            myDataRow("ProductGroupSale") = subTotalAfterVAT
            myDataTable.Rows.Add(myDataRow)

        End If
        If dtTable.Rows.Count > 0 Then
            outputString += "<tr bgColor=""" + GrayBGColor + """>"
            outputString += "<td colspan=""2"" align=""right"" class=""" + TextClass + """>Grand Total</td>"
            outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalQty, "##,##0.0") + "</td>"
            outputString += "<td align=""right"" class=""" + TextClass + """>" + Format((grandTotalQty / totalQty) * 100, "##,##0.00") + "%</td>"
            outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalRetailPrice, "##,##0.00") + "</td>"
            outputString += "<td align=""right"" class=""" + TextClass + """>" + Format((grandTotalRetailPrice / totalRetailPrice) * 100, "##,##0.00") + "%</td>"
            outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalDiscount, "##,##0.00") + "</td>"

            outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalAfterVAT, "##,##0.00") + "</td>"
            outputString += "<td align=""right"" class=""" + TextClass + """>" + Format((grandTotalAfterVAT / totalSale) * 100, "##,##0.00") + "%</td>"
            outputString += "</tr>"
        End If
        outputString += "</table>"

        'Dim PaymentSummaryString As String = SalePaymentSummary(myDataTable, GrayBGColor, AdminBGColor, ShopID, 0, StartDate, EndDate, PaymentResult, False, objCnn)

        'outputString += PaymentSummaryString

        Dim FinalSaleAmount As Double

        DiscountArray(0) = grandTotalPriceDiscount + grandTotalDiscount
        DiscountArray(1) += grandTotalPriceDiscount
        Dim ResultSummary As String = ""
        If ShowSummary = True Then
            ResultSummary = SaleReportSummary(FinalSaleAmount, GrayBGColor, AdminBGColor, ShopID, 0, StartDate, EndDate, grandTotalVAT, grandTotalAfterVAT, 0, PaymentResult, PayByCreditMoney, DiscountArray, True, False, objCnn)
        End If

        outputString += ResultSummary

    End Function
	
	Public Overloads Function SaleReportSummary(ByRef FinalSaleAmount As Double, ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal ShopID As Integer, ByVal ViewOption As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal grandTotalVAT As Double, ByVal grandTotalAfterVAT As Double, ByVal grandTotalVoid As Double, ByVal PaymentResult As DataTable, ByVal PayByCreditMoney As DataTable, ByVal DiscountArray() As Double, ByVal ShowStatistics As Boolean, ByVal VATDisplay As Boolean, ByVal objCnn As MySqlConnection) As String

        Dim totalRealSale As Double = 0
        Dim totalPaymentValue As Double = 0
        Dim ColSpan As String
        Dim TextClass As String
        Dim i, j As Integer
        Dim outputString As String = ""
        Dim totalVATNotPaid As Double = 0
        Dim ColSpan1 As Integer


        Dim VATValue As Double = 0
        Dim VATData As DataTable = objDB.List("SELECT CompanyVAT FROM CompanyProfile WHERE CompanyID=" + ShopID.ToString, objCnn)
        If VATData.Rows.Count > 0 Then
            If Not IsDBNull(VATData.Rows(0)("CompanyVAT")) Then
                VATValue = VATData.Rows(0)("CompanyVAT")
            Else
                VATValue = 0
            End If
        End If

        Dim HavePrepaidDiscount As Boolean = False
        Dim totalActual As Double = 0
        For i = 0 To PaymentResult.Rows.Count - 1
            totalPaymentValue += PaymentResult.Rows(i)("TotalPay")
            totalActual += PaymentResult.Rows(i)("TotalPay") - PaymentResult.Rows(i)("TotalPayDiscount")
            If PaymentResult.Rows(i)("TotalPayDiscount") > 0 Then
                HavePrepaidDiscount = True
            End If
        Next

        If VATDisplay = False Then
            If HavePrepaidDiscount = True Then
                ColSpan = "6"
            Else
                ColSpan = "3"
            End If
        Else
            ColSpan = "4"
        End If

        outputString += "<br><table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"">"
        outputString += "<tr bgColor=""" + AdminBGColor + """>"
        outputString += "<td colspan=""" + ColSpan.ToString + """ align=""center"" class=""tdHeader"">Payment Summary</td>"
        outputString += "</tr>"
        outputString += "<tr bgColor=""" + AdminBGColor + """>"
        outputString += "<td align=""center"" class=""tdHeader"">Payment Type</td>"
        If VATDisplay = True Then
            outputString += "<td align=""center"" class=""tdHeader"">VAT</td>"
        End If
        outputString += "<td align=""center"" class=""tdHeader"">Amount</td>"
        outputString += "<td align=""center"" class=""tdHeader"">%</td>"
        If HavePrepaidDiscount = True Then
            outputString += "<td align=""center"" class=""tdHeader"">Disc</td>"
            outputString += "<td align=""center"" class=""tdHeader"">Actual</td>"
            outputString += "<td align=""center"" class=""tdHeader"">%</td>"
        End If

        outputString += "</tr>"

        Dim totalPaymentDiscount As Double = 0
        For i = 0 To PaymentResult.Rows.Count - 1
            If PaymentResult.Rows(i)("IsSale") = 1 Then
                totalRealSale += PaymentResult.Rows(i)("TotalPay")
                TextClass = "smallText"
            Else
                TextClass = "smallText"
            End If
            totalPaymentDiscount += PaymentResult.Rows(i)("TotalPayDiscount")

            outputString += "<tr>"
            If PaymentResult.Rows(i)("PayTypeID") = 7 Or (PaymentResult.Rows(i)("PayTypeID") >= 10 And PaymentResult.Rows(i)("IsOtherReceipt") = 0 And PaymentResult.Rows(i)("IsSale") = 1) Then
                outputString += "<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'coupon_voucher.aspx?ViewOption=0&PayTypeID=" + PaymentResult.Rows(i)("PayTypeID").ToString + "&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=600,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + PaymentResult.Rows(i)("PayTypeName") + "</a></td>"
            ElseIf PaymentResult.Rows(i)("PayTypeID") = 2 Then
                outputString += "<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'CreditCard/CreditCard_SaleReport.aspx?ViewOption=0&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=700,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + PaymentResult.Rows(i)("PayTypeName") + "</a></td>"
            ElseIf PaymentResult.Rows(i)("PayTypeID") = 5 Then
                outputString += "<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_creditmoney.aspx?ViewOption=1&PayTypeID=5&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=700,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + PaymentResult.Rows(i)("PayTypeName") + "</a></td>"
            ElseIf PaymentResult.Rows(i)("PayTypeID") = 3 Then
                outputString += "<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_creditmoney.aspx?ViewOption=1&PayTypeID=3&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=700,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + PaymentResult.Rows(i)("PayTypeName") + "</a></td>"
            ElseIf PaymentResult.Rows(i)("PayTypeID") = 9 Then
                outputString += "<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_creditmoney.aspx?ViewOption=1&PayTypeID=9&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=700,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + PaymentResult.Rows(i)("PayTypeName") + "</a></td>"
            Else
                outputString += "<td align=""right"" class=""" + TextClass + """>" + PaymentResult.Rows(i)("PayTypeName") + "</td>"
            End If

            If VATDisplay = True Then
                If PaymentResult.Rows(i)("IsVAT") = 1 Then
                    outputString += "<td align=""right"" class=""" + TextClass + """>-</td>"
                Else
                    totalVATNotPaid += PaymentResult.Rows(i)("TotalVAT")
                    outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(PaymentResult.Rows(i)("TotalVAT"), "##,##0.00") + "</td>"
                End If
            End If

            outputString += "<td class=""" + TextClass + """ align=""right"">" + Format(PaymentResult.Rows(i)("TotalPay"), "##,##0.00") + "</td>"
            outputString += "<td class=""" + TextClass + """ align=""right"">" + Format((PaymentResult.Rows(i)("TotalPay") / totalPaymentValue) * 100, "##,##0.00") + "%</td>"
            If HavePrepaidDiscount = True Then
                If PaymentResult.Rows(i)("TotalPayDiscount") > 0 Then
                    outputString += "<td class=""" + TextClass + """ align=""right"">" + Format(PaymentResult.Rows(i)("TotalPayDiscount"), "##,##0.00") + "</td>"
                Else
                    outputString += "<td align=""right"" class=""" + TextClass + """>-</td>"
                End If
                outputString += "<td class=""" + TextClass + """ align=""right"">" + Format(PaymentResult.Rows(i)("TotalPay") - PaymentResult.Rows(i)("TotalPayDiscount"), "##,##0.00") + "</td>"
                outputString += "<td class=""" + TextClass + """ align=""right"">" + Format((PaymentResult.Rows(i)("TotalPay") - PaymentResult.Rows(i)("TotalPayDiscount")) * 100 / totalActual, "##,##0.00") + "%</td>"
            End If

            outputString += "</tr>"
        Next
        TextClass = "smallText"
        outputString += "<tr bgColor=""" + GrayBGColor + """>"
        outputString += "<td align=""right"" class=""" + TextClass + """>Total Payment</td>"
        If VATDisplay = True Then
            outputString += "<td class=""" + TextClass + """ align=""right"">" + Format(grandTotalVAT, "##,##0.00") + "</td>"
        End If

        outputString += "<td class=""" + TextClass + """ align=""right"">" + Format(totalPaymentValue, "##,##0.00") + "</td>"
        outputString += "<td class=""" + TextClass + """ align=""right"">100.00%</td>"
        If HavePrepaidDiscount = True Then
            outputString += "<td class=""" + TextClass + """ align=""right"">" + Format(totalPaymentDiscount, "##,##0.00") + "</td>"
            outputString += "<td class=""" + TextClass + """ align=""right"">" + Format(totalPaymentValue - totalPaymentDiscount, "##,##0.00") + "</td>"
            outputString += "<td class=""" + TextClass + """ align=""right"">100.00%</td>"
        End If

        outputString += "</tr>"

        Dim getProp As New CPreferences
        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
        Dim CheckDiff As Double = Math.Round(totalPaymentValue * 100) - Math.Round(grandTotalAfterVAT * 100)
        If PropertyInfo.Rows(0)("SummaryPrepaidInSaleReport") = 1 Then
            If CheckDiff <> 0 Then
                outputString += "<tr>"
                outputString += "<td align=""right"" class=""" + TextClass + """>Amount Diff</td>"
                If VATDisplay = True Then
                    outputString += "<td class=""" + TextClass + """ align=""right"">-</td>"
                End If
                outputString += "<td class=""" + TextClass + """ align=""right"">" + Format(totalPaymentValue - grandTotalAfterVAT, "##,##0.00") + "</td>"
                outputString += "<td class=""" + TextClass + """ align=""right"">-</td>"
                outputString += "</tr>"
            End If
            If totalPaymentValue <> totalRealSale Then
                outputString += "<tr bgColor=""#ebebeb"">"
                outputString += "<td align=""right"" class=""" + TextClass + """>Total Payment (Not count prepaid payment)</td>"
                If VATDisplay = True Then
                    outputString += "<td class=""" + TextClass + """ align=""right"">" + Format(grandTotalVAT - totalVATNotPaid, "##,##0.00") + "</td>"
                End If
                outputString += "<td class=""" + TextClass + """ align=""right"">" + Format(totalRealSale, "##,##0.00") + "</td>"
                outputString += "<td class=""" + TextClass + """ align=""right"">-</td>"
                outputString += "</tr>"
            End If
        End If

        TextClass = "smallText"
        Dim totalPayByCreditMoney As Double = 0
        Dim totalVATCreditMoney As Double = 0
        Dim CreditMoneyText As String
        If PayByCreditMoney.Rows.Count > 0 Then

            For i = 0 To PayByCreditMoney.Rows.Count - 1
                If Not IsDBNull(PayByCreditMoney.Rows(i)("TotalPay")) Then
                    totalPayByCreditMoney += PayByCreditMoney.Rows(i)("TotalPay")
                End If
            Next
            For i = 0 To PayByCreditMoney.Rows.Count - 1
                If Not IsDBNull(PayByCreditMoney.Rows(i)("TotalPay")) Then
                    totalVATCreditMoney += PayByCreditMoney.Rows(i)("TotalVAT")
                    outputString += "<tr>"
                    If Not IsDBNull(PayByCreditMoney.Rows(i)("PayTypeName")) Then
                        CreditMoneyText = PayByCreditMoney.Rows(i)("PayTypeName")
                    Else
                        CreditMoneyText = "Back Office"
                    End If
                    outputString += "<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_creditmoney.aspx?ViewOption=0&PayTypeID=" + PayByCreditMoney.Rows(i)("PayTypeID").ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=900,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">Credit Money: Paid By " + CreditMoneyText + "</a></td>"
                    If VATDisplay = True Then
                        outputString += "<td class=""" + TextClass + """ align=""right"">" + Format(PayByCreditMoney.Rows(i)("TotalPay") * (VATValue / (VATValue + 100)), "##,##0.00") + "</td>"
                    End If
                    outputString += "<td class=""" + TextClass + """ align=""right"">" + Format(PayByCreditMoney.Rows(i)("TotalPay"), "##,##0.00") + "</td>"
                    outputString += "<td class=""" + TextClass + """ align=""right"">" + Format((PayByCreditMoney.Rows(i)("TotalPay") / totalPayByCreditMoney) * 100, "##,##0.00") + "%</td>"
                    outputString += "</tr>"
                End If
            Next
            If totalPayByCreditMoney > 0 Then
                outputString += "<tr bgColor=""#eeeeee"">"
                outputString += "<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_creditmoney.aspx?ViewOption=0&PayTypeID=-1&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=900,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">Summary Credit Money</a></td>"
                If VATDisplay = True Then
                    outputString += "<td class=""" + TextClass + """ align=""right"">" + Format(totalVATCreditMoney, "##,##0.00") + "</td>"
                End If

                outputString += "<td class=""" + TextClass + """ align=""right"">" + Format(totalPayByCreditMoney, "##,##0.00") + "</td>"
                outputString += "<td class=""" + TextClass + """ align=""right"">100.00%</td>"
                outputString += "</tr>"
                outputString += "<tr bgColor=""#ebebeb"">"
                outputString += "<td align=""right"" class=""" + TextClass + """>Total Payment (include credit money)</td>"
                If VATDisplay = True Then
                    outputString += "<td class=""" + TextClass + """ align=""right"">" + Format(grandTotalVAT + totalVATCreditMoney - totalVATNotPaid, "##,##0.00") + "</td>"
                End If

                outputString += "<td class=""" + TextClass + """ align=""right"">" + Format(totalPaymentValue + totalPayByCreditMoney, "##,##0.00") + "</td>"
                outputString += "<td class=""" + TextClass + """ align=""right"">-</td>"
                outputString += "</tr>"
                FinalSaleAmount += totalPayByCreditMoney
            End If
        End If

        outputString += "</table>"

        FinalSaleAmount = grandTotalAfterVAT
        totalRealSale = grandTotalAfterVAT
        If ShowStatistics = True Then
            outputString += "<br><table><tr>"
            If DiscountArray(0) <> 0 Then 'Grand Total Discount
                outputString += "<td valign=""top"">"
                outputString += "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"">"
                outputString += "<tr>"
                outputString += "<td colspan=""3"" align=""center"" class=""tdHeader"" bgColor=""" + AdminBGColor + """>Discount Summary (% based on " + Format(totalRealSale, "##,##0.00") + ")</td>"
                outputString += "</tr>"
                outputString += "<tr>"
                outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """>Name</td>"
                outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """>Discount</td>"
                outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """>%</td>"
                outputString += "</tr>"
                If DiscountArray(1) <> 0 Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">Price Discount</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(DiscountArray(1), "##,##0.00") + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(DiscountArray(1) * 100 / totalRealSale, "##,##0.00") + "%</td>"
                    outputString += "</tr>"
                End If
                If DiscountArray(2) <> 0 Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">Member Discount</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(DiscountArray(2), "##,##0.00") + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(DiscountArray(2) * 100 / totalRealSale, "##,##0.00") + "%</td>"
                    outputString += "</tr>"
                End If
                If DiscountArray(3) <> 0 Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">Staff Discount</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(DiscountArray(3), "##,##0.00") + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(DiscountArray(3) * 100 / totalRealSale, "##,##0.00") + "%</td>"
                    outputString += "</tr>"
                End If
                If DiscountArray(4) <> 0 Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText""><a class=""smallText"" href=""JavaScript: newWindow = window.open( 'coupon_voucher.aspx?ViewOption=4&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=600,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">Coupon Discount</a></td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(DiscountArray(4), "##,##0.00") + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(DiscountArray(4) * 100 / totalRealSale, "##,##0.00") + "%</td>"
                    outputString += "</tr>"
                End If
                If DiscountArray(5) <> 0 Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText""><a class=""smallText"" href=""JavaScript: newWindow = window.open( 'coupon_voucher.aspx?ViewOption=5&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=600,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">Voucher Discount</a></td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(DiscountArray(5), "##,##0.00") + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(DiscountArray(5) * 100 / totalRealSale, "##,##0.00") + "%</td>"
                    outputString += "</tr>"
                End If
                If DiscountArray(6) <> 0 Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">Other Discount</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(DiscountArray(6), "##,##0.00") + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(DiscountArray(6) * 100 / totalRealSale, "##,##0.00") + "%</td>"
                    outputString += "</tr>"
                End If
                If DiscountArray(0) <> 0 Then
                    outputString += "<tr>"
                    outputString += "<td align=""right"" class=""smallText"" bgColor=""" + GrayBGColor + """><a class=""smallText"" href=""JavaScript: newWindow = window.open( 'report_promotion_byproduct.aspx?ViewOption=" + ViewOption.ToString + "&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=800,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">Total Discount</a></td>"
                    outputString += "<td align=""right"" class=""smallText"" bgColor=""" + GrayBGColor + """>" + Format(DiscountArray(0), "##,##0.00") + " </td>"
                    outputString += "<td align=""right"" class=""smallText"" bgColor=""" + GrayBGColor + """>" + Format(DiscountArray(0) * 100 / totalRealSale, "##,##0.00") + "%</td>"
                    outputString += "</tr>"
                End If
                outputString += "</table>"
                outputString += "</td>"
            End If

            Dim ExtraSql As String = ""
            If ShopID > 0 Then
                ExtraSql += " AND ShopID=" + ShopID.ToString
            End If
            Dim AvgBill As DataTable = objDB.List("select count(*) AS TotalBill, SUM(NoCustomer) AS TotalCustomer, TransactionStatusID from OrderTransaction where (SaleDate >= " + StartDate + " and SaleDate < " + EndDate + ") AND DocType=8 AND ReceiptID>0 " + ExtraSql + " GROUP BY TransactionStatusID", objCnn)
            Dim ChkAvgBill As DataTable '= objDB.List("select count(*) AS MinusBill, SUM(NoCustomer) AS MinusCustomer from OrderTransaction a left outer join orderdetail b on a.transactionid=b.transactionid and a.computerid=b.computerid where b.transactionid is null AND (SaleDate >= " + StartDate + " and SaleDate < " + EndDate + ") AND TransactionStatusID=2 AND DocType=8 AND ReceiptID>0 AND ShopID IN (" + ShopID.ToString + ")", objCnn)
            Dim VoidBill As DataTable '= objDB.List("select count(*) AS VoidBill from OrderTransaction where (SaleDate >= " + StartDate + " and SaleDate < " + EndDate + ") AND TransactionStatusID<>2 AND ReceiptID>0 AND DocType=8 AND ShopID IN (" + ShopID.ToString + ")", objCnn)
            Dim totalQty As DataTable = objDB.List("select SUM(Amount) AS TotalQty from DummyTran where (SaleDate >= " + StartDate + " and SaleDate < " + EndDate + ") AND TransactionStatusID=2 AND DocType=8 AND ReceiptID>0 AND OrderStatusID<>3 " + ExtraSql, objCnn)
            Dim TotalBill As Double = 0
            Dim TotalCustomer As Double = 0
            Dim TotalVoid As Double = 0
            If AvgBill.Rows.Count > 0 Then
                If Not IsDBNull(AvgBill.Rows(0)("TotalBill")) And Not IsDBNull(AvgBill.Rows(0)("TotalCustomer")) Then
                    For i = 0 To AvgBill.Rows.Count - 1
                        If AvgBill.Rows(i)("TransactionStatusID") = 2 Then
                            TotalBill += AvgBill.Rows(i)("TotalBill")
                            TotalCustomer += AvgBill.Rows(i)("TotalCustomer")
                        Else
                            TotalVoid += AvgBill.Rows(i)("TotalBill")
                        End If
                    Next
                    'TotalBill = AvgBill.Rows(0)("TotalBill")
                    'TotalCustomer = AvgBill.Rows(0)("TotalCustomer")
                    'If Not IsDBNull(ChkAvgBill.Rows(0)("MinusBill")) Then
                    'TotalBill = TotalBill - ChkAvgBill.Rows(0)("MinusBill")
                    'End If
                    'If Not IsDBNull(ChkAvgBill.Rows(0)("MinusCustomer")) Then
                    'TotalCustomer = TotalCustomer - ChkAvgBill.Rows(0)("MinusCustomer")
                    'End If
                    outputString += "<td valign=""top"">"
                    outputString += "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"">"
                    outputString += "<tr>"
                    outputString += "<td colspan=""4"" align=""center"" class=""tdHeader"" bgColor=""" + AdminBGColor + """>Statistics</td>"
                    outputString += "</tr>"
                    outputString += "<tr>"
                    outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """></td>"
                    outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """>#</td>"
                    outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """>Total</td>"
                    outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """>Avg.</td>"
                    outputString += "</tr>"


                    'If Not IsDBNull(AvgBill.Rows(0)("TotalCustomer")) Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">Avg Per Customer</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(TotalCustomer, "##,##0.0") + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(grandTotalAfterVAT, "##,##0.00") + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(grandTotalAfterVAT / TotalCustomer, "##,##0.00") + "</td>"
                    outputString += "</tr>"
                    'End If
                    'If Not IsDBNull(AvgBill.Rows(0)("TotalBill")) Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">Avg Per Bill</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(TotalBill, "##,##0.0") + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(grandTotalAfterVAT, "##,##0.0") + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(grandTotalAfterVAT / TotalBill, "##,##0.00") + "</td>"
                    outputString += "</tr>"
                    'End If
                    If Not IsDBNull(totalQty.Rows(0)("totalQty")) Then
                        outputString += "<tr>"
                        outputString += "<td align=""left"" class=""smallText"">Avg Items Per Bill</td>"
                        outputString += "<td align=""right"" class=""smallText"">" + Format(TotalBill, "##,##0.0") + " </td>"
                        outputString += "<td align=""right"" class=""smallText"">" + Format(totalQty.Rows(0)("totalQty"), "##,##0.00") + " </td>"
                        outputString += "<td align=""right"" class=""smallText"">" + Format(totalQty.Rows(0)("totalQty") / TotalBill, "##,##0.00") + "</td>"
                        outputString += "</tr>"
                    End If
                    outputString += "</table>"
                    outputString += "</td>"
                End If
            End If

            If TotalBill > 0 Or TotalVoid > 0 Then
                outputString += "<td valign=""top"">"
                outputString += "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"">"
                outputString += "<tr>"
                outputString += "<td colspan=""4"" align=""center"" class=""tdHeader"" bgColor=""" + AdminBGColor + """>Bill Statistics</td>"
                outputString += "</tr>"
                outputString += "<tr>"
                outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """></td>"
                outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """>#</td>"
                outputString += "<td align=""center"" class=""smallText"" bgColor=""" + GrayBGColor + """>Amount</td>"
                outputString += "</tr>"


                If TotalBill > 0 Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">Used Bills</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(TotalBill, "##,##0.0") + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(grandTotalAfterVAT, "##,##0.00") + " </td>"
                    outputString += "</tr>"
                End If
                If TotalVoid > 0 Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">Voided Bills</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(TotalVoid, "##,##0.0") + " </td>"
                    If grandTotalVoid = 0 And TotalVoid > 0 Then
                        Dim VoidData As DataTable = objDB.List("select SUM(SalePrice) AS TransactionPrice from DummyTran a where a.receiptid>0 and a.transactionstatusid<>2 AND (SaleDate >= " + StartDate + " and SaleDate < " + EndDate + ") " + ExtraSql, objCnn)
                        grandTotalVoid = VoidData.Rows(0)("TransactionPrice")
                    End If
                    outputString += "<td align=""right"" class=""smallText"">" + Format(grandTotalVoid, "##,##0.00") + " </td>"
                    outputString += "</tr>"
                End If
                If TotalBill > 0 And TotalVoid > 0 Then
                    outputString += "<tr>"
                    outputString += "<td align=""left"" class=""smallText"">Total Bills</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(TotalBill + TotalVoid, "##,##0.0") + " </td>"
                    outputString += "<td align=""right"" class=""smallText"">" + Format(grandTotalAfterVAT + grandTotalVoid, "##,##0.00") + " </td>"

                    outputString += "</tr>"
                End If
            End If
            outputString += "</table>"
            outputString += "</td>"

            outputString += "</tr></table>"
        End If
        Return outputString

    End Function

Sub Page_UnLoad()
	objCnn.Close()
End Sub	
</script>
</body>
</html>
