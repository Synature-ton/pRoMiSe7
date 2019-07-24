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

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Sale Reports By Department</title>
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
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated Then
		
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
		
		HeaderText.InnerHtml = "Sale Report By Department"
			
		DailyDate.YearType = GlobalParam.YearType
		DailyDate.FormName = "DocDaily"
		DailyDate.StartYear = 1
		DailyDate.EndYear = 2
		DailyDate.LangID = Session("LangID")
		
		CurrentDate.YearType = GlobalParam.YearType
		CurrentDate.FormName = "Doc"
		CurrentDate.StartYear = 1
		CurrentDate.EndYear = 2
		CurrentDate.LangID = Session("LangID")
		
		ToDate.YearType = GlobalParam.YearType
		ToDate.FormName = "DocTo"
		ToDate.StartYear = 1
		ToDate.EndYear = 2
		ToDate.LangID = Session("LangID")
		
		MonthYearDate.YearType = GlobalParam.YearType
		MonthYearDate.FormName = "MonthYearDate"
		MonthYearDate.StartYear = 1
		MonthYearDate.EndYear = 2
		MonthYearDate.LangID = Session("LangID")
		MonthYearDate.ShowDay = False
		
		YearDate.YearType = GlobalParam.YearType
		YearDate.FormName = "YearDate"
		YearDate.StartYear = 3
		YearDate.EndYear = 0
		YearDate.LangID = Session("LangID")
		YearDate.ShowDay = False
		YearDate.ShowMonth = False
		
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
			'If ShopData.Rows.Count > 1 Then
				'If Not Page.IsPostBack Then 
					'FormSelected = "selected"
				'ElseIf ShopIDValue = 0 Then
					'FormSelected = "selected"
				'Else
					'FormSelected = ""
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
			ReportDate = Format(SDate1, "dd MMMM yyyy") + " - " + Format(EDate1, "dd MMMM yyyy")
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
			ReportDate = Format(SDate2, "d MMMM yyyy")
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
		
		Application.Lock()
		Dim dtTable As DataTable = SaleReportByDept(outputString, grandTotal, VATTotal, GraphData, PaymentResult, PayByCreditMoney, StartDate, EndDate, Request.Form("ShopID"),0,0, objCnn)

		GenOutputSaleByDept3(outputString,grandTotal,VATTotal,False,GlobalParam.GrayBGColor,GlobalParam.AdminBGColor,dtTable,PaymentResult,PayByCreditMoney,Request.Form("ShopID"),StartDate,EndDate,objCnn)

		If Request.Form("ShopID") > 0 Then
			ResultText.InnerHtml = outputString
		End If
		Dim ShopDisplay As String
		If Request.Form("ShopID") = 0 Then
			ShopDisplay = "All Shops"
		Else
			ShopDisplay = SelShopName.Value
		End If
		ResultSearchText.InnerHtml = "Sale Report By Department of " + ShopDisplay + " (" + ReportDate + ")"
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
			Dim ChartHeight As Integer = 450
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
	
	Public Function SaleReportByDept(ByRef outputString As String, ByRef grandTotal As Double, ByRef VATTotal As Double, ByRef GraphData As DataSet, ByRef PaymentResult As DataTable, ByRef PayByCreditMoney As DataTable, ByVal StartDate As String, ByVal EndDate As String, ByVal ShopID As Integer, ByVal TransactionID As Integer, ByVal ComputerID As Integer, ByVal objCnn As MySqlConnection) As DataTable

            Dim sqlStatement, sqlStatement1, WhereString, WString As String
            Dim AdditionalQuery As String = ""
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


            If TransactionID > 0 And ComputerID > 0 Then
                AdditionalQuery += " AND ( a.TransactionID = " + TransactionID.ToString + " AND a.ComputerID = " + ComputerID.ToString + ")"
            End If

            If ShopID > 0 Then
                AdditionalQuery += " AND a.ShopID IN (" + ShopID.ToString + ")"
                WhereString += " AND ShopID IN (" + ShopID.ToString + ")"
                WString += " AND a.ShopID IN (" + ShopID.ToString + ")"
            End If

            If StartDate <> "" And EndDate <> "" Then
                AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
                WhereString += " AND (PayDate >= " + StartDate + " AND PayDate < " + EndDate + ")"
                WString += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
            End If

            If Trim(WhereString) = "" Then
                WhereString = " AND 0=1"
                WString = " AND 0=1"
            End If
            Dim OrderBy As String = " a.DocType,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID,b.OrderDetailID,d.PayTypeID"

            sqlStatement = "select sum(payamount) AS TotalPay, sum(PaymentVAT) AS TotalVAT, a.PayTypeID,b.PayType AS PayTypeName from paybycreditmoney" + BranchStr + " a left outer join paytype b ON a.PayTypeID=b.TypeID where a.CreditMoneyStatusID=2 " + WhereString + " group by a.PayTypeID,b.PayType order by a.PayTypeID,b.PayType"
            PayByCreditMoney = objDB.List(sqlStatement, objCnn)

            sqlStatement = "select a.TransactionID,a.ComputerID,b.VATType,NoCustomer,SUM(c.SalePrice) AS TotalExcludePrice FROM OrderTransaction" + BranchStr + " a, OrderDetail" + BranchStr + " b, OrderDiscountDetail" + BranchStr + " c WHERE a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.OrderDetailID=c.OrderDetailID AND b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3,-6) AND b.OrderStatusID IN (1,5) " + AdditionalQuery + " GROUP BY a.TransactionID,a.ComputerID,b.VATType,NoCustomer"

            objDB.sqlExecute("DROP TABLE IF EXISTS DummySaleReport", objCnn)

            objDB.sqlExecute("create table DummySaleReport (TransactionID int, ComputerID int, VATType tinyint, NoCustomer int ,TotalProductSale decimal(18,4))", objCnn)
            'objDB.sqlExecute("ALTER TABLE DummySaleReport ADD PRIMARY KEY (TransactionID,ComputerID)", objCnn)

            objDB.sqlExecute("insert into DummySaleReport " + sqlStatement, objCnn)

            objDB.sqlExecute("DROP TABLE IF EXISTS DummyServiceCharge", objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummySaleBeforeVAT", objCnn)

            sqlStatement = "select a.transactionid,a.computerid,b.OrderDetailID,b.HasServiceCharge,IF(b.OrderStatusID = 1,c.TotalRetailPrice,0) AS SalePriceBeforeVAT  FROM ordertransaction" + BranchStr + " a, orderdetail" + BranchStr + " b , orderdiscountdetail" + BranchStr + " c WHERE a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND b.OrderDetailID=c.OrderDetailID AND a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3,-6) AND b.OrderStatusID IN (1,5) AND a.TransactionStatusID=2 " + WString

            objDB.sqlExecute("create table DummySaleBeforeVAT (TransactionID int, ComputerID int, OrderDetailID int, HasServiceCharge int, SaleBeforeVAT decimal(18,6))", objCnn)
            objDB.sqlExecute("ALTER TABLE DummySaleBeforeVAT ADD PRIMARY KEY (TransactionID,ComputerID,OrderDetailID)", objCnn)
            objDB.sqlExecute("insert into DummySaleBeforeVAT " + sqlStatement, objCnn)

            sqlStatement = "select transactionid,computerid,sum(SaleBeforeVAT) as TotalSaleBeforeVAT from DummySaleBeforeVAT WHERE HasServiceCharge=1 GROUP BY TransactionID,ComputerID"

            objDB.sqlExecute("create table DummyServiceCharge (TransactionID int, ComputerID int, TotalSaleBeforeVAT decimal(18,6))", objCnn)
            objDB.sqlExecute("ALTER TABLE DummyServiceCharge ADD PRIMARY KEY (TransactionID,ComputerID)", objCnn)
            objDB.sqlExecute("insert into DummyServiceCharge " + sqlStatement, objCnn)

            'sql grouping by dept
            sqlStatement = "SELECT p.ProductDeptID,pd.ProductGroupID,pd.ProductDeptCode,pg.ProductGroupCode, pd.ProductDeptName,pg.ProductGroupName,SUM(IF(b.HasServiceCharge=0,0,aa.SaleBeforeVAT*a.ServiceCharge/bb.TotalSaleBeforeVAT)) AS ServiceCharge,SUM(IF(b.HasServiceCharge=0,0,aa.SaleBeforeVAT*a.ServiceChargeVAT/bb.TotalSaleBeforeVAT)) AS ServiceChargeVAT,SUM(IF(b.HasServiceCharge=0,0,aa.SaleBeforeVAT*a.ServiceChargeVAT/bb.TotalSaleBeforeVAT)) AS ServiceChargeVAT,SUM(b.Amount) AS Amount,SUM(c.TotalPrice) AS TotalPrice,SUM(c.TotalRetailPrice) AS TotalRetailPrice,SUM(f.TotalProductSale) AS TotalProductSale, SUM(Round(a.TransactionVAT,2)-Round(a.TransactionExcludeVAT,2)) AS TransactionIncludeVAT,  SUM(IF(b.VATType=1 , IF(a.TransactionVAT = 0, c.SalePrice-(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale),(c.SalePrice-(Round(a.TransactionVAT,2)-Round(a.TransactionExcludeVAT,2)-Round(ServiceChargeVAT,2))*c.SalePrice/f.TotalProductSale)-(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale)), IF(b.VATType=2 and a.TransactionVAT=0,c.SalePrice+(Round(a.TransactionExcludeVAT,2)*c.SalePrice/f.TotalProductSale)-(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale),c.SalePrice-(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale)))) AS SalePriceBeforeVAT, SUM(IF(b.VATType=1, IF(a.TransactionVAT = 0, 0, (Round(a.TransactionVAT,2)-Round(a.TransactionExcludeVAT,2)-Round(ServiceChargeVAT,2))*c.SalePrice/f.TotalProductSale), IF(b.VATType=2,IF(a.TransactionVAT = 0, 0, Round(a.TransactionExcludeVAT,2)*c.SalePrice/f.TotalProductSale),0))) AS ProductVAT, SUM(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale) AS CompensateOtherDiscount, SUM(c.MemberDiscount) AS MemberDiscount, SUM(c.StaffDiscount) AS StaffDiscount, SUM(c.CouponDiscount) AS CouponDiscount, SUM(c.VoucherDiscount) AS VoucherDiscount, SUM(c.OtherPercentDiscount) AS OtherPercentDiscount, SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount, SUM(c.PricePromotionDiscount) AS PricePromotionDiscount, SUM(IF(b.VATType=2,Round(a.TransactionExcludeVAT,2)*c.SalePrice/f.TotalProductSale,0)) AS ProductExcludeVAT FROM ordertransaction" + BranchStr + " a inner join orderdetail" + BranchStr + " b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID inner join orderdiscountdetail" + BranchStr + " c ON b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND b.OrderDetailID=c.OrderDetailID inner join DummySaleReport f ON a.TransactionID=f.TransactionID AND a.ComputerID=f.ComputerID AND b.VATType=f.VATType inner join DummySaleBeforeVAT aa ON a.TransactionID=aa.TransactionID AND a.ComputerID=aa.ComputerID AND b.OrderDetailID=aa.OrderDetailID left outer join dummyservicecharge bb ON a.TransactionID=bb.TransactionID AND a.ComputerID=bb.ComputerID   left outer join Products p ON b.ProductID=p.ProductID left outer join ProductDept pd ON p.ProductDeptID=pd.ProductDeptID left outer join ProductGroup pg ON pd.ProductGroupID=pg.ProductGroupID WHERE a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3,-6) AND b.OrderStatusID IN (1,5) AND a.TransactionStatusID=2 AND pd.ProductDeptName NOT LIKE 'x-%' " + AdditionalQuery + "  GROUP BY p.ProductDeptID,pd.ProductGroupID, pd.ProductDeptName,pg.ProductGroupName,pd.ProductDeptCode,pg.ProductGroupCode ORDER BY pg.ProductGroupOrdering,pg.ProductGroupID,pd.ProductDeptOrdering,pd.ProductDeptID"

            sqlStatement1 = "select b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT, IsOtherReceipt, NotAllProducts from ordertransaction" + BranchStr + " a, paydetail" + BranchStr + " b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.PayTypeID=c.TypeID and a.TransactionStatusID=2 " + AdditionalQuery + " group by b.PayTypeID,c.PayType,IsSale, IsVAT order by b.PayTypeID,c.PayType,IsSale DESC"

            PaymentResult = objDB.List(sqlStatement1, objCnn)

            GetData = objDB.List(sqlStatement, objCnn)

            objDB.sqlExecute("create table if not exists ProductNotInPrepaid (ProductCode varchar(100))", objCnn)

            objDB.sqlExecute("DROP TABLE IF EXISTS ProductNotInPrepaidTemp", objCnn)
            objDB.sqlExecute("create table ProductNotInPrepaidTemp (ProductCode varchar(100))", objCnn)
            sqlStatement = "select distinct(ProductCode) from ProductNotInPrepaid"
            objDB.sqlExecute("insert into ProductNotInPrepaidTemp " + sqlStatement, objCnn)

            sqlStatement = "Select a.TransactionID,a.ComputerID,b.OrderDetailID,b.ProductID,p.ProductCode,IF(pp.ProductCode is NULL,0,1),c.SalePrice,IF(b.HasServiceCharge=0,0,IF(bb.TotalSaleBeforeVAT=0,0,aa.SaleBeforeVAT*a.ServiceCharge/bb.TotalSaleBeforeVAT)) AS ServiceCharge,IF(b.HasServiceCharge=0,0,IF(bb.TotalSaleBeforeVAT=0,0,aa.SaleBeforeVAT*a.ServiceChargeVAT/bb.TotalSaleBeforeVAT)) AS ServiceChargeVAT FROM OrderTransaction a inner join OrderDetail b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID inner join OrderDiscountDetail c ON b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND b.OrderDetailID=c.OrderDetailID inner join DummySaleBeforeVAT aa ON a.TransactionID=aa.TransactionID AND a.ComputerID=aa.ComputerID AND b.OrderDetailID=aa.OrderDetailID left outer join dummyservicecharge bb ON a.TransactionID=bb.TransactionID AND a.ComputerID=bb.ComputerID   left outer join Products p ON b.ProductID=p.ProductID left outer join ProductNotInPrepaidTemp pp ON p.ProductCode=pp.ProductCode WHERE  a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3,-6) AND b.OrderStatusID IN (1,5) AND a.TransactionStatusID=2 "

            objDB.sqlExecute("DROP TABLE IF EXISTS DummySalePayment", objCnn)
            objDB.sqlExecute("create table DummySalePayment (TransactionID int, ComputerID int, OrderDetailID int, ProductID int, ProductCode varchar(100), NotInPrepaid tinyint, SalePrice decimal(18,4), ServiceCharge decimal(18,4), ServiceChargeVAT decimal(18,4))", objCnn)
            'objDB.sqlExecute("ALTER TABLE DummySalePayment ADD PRIMARY KEY (TransactionID,ComputerID,OrderDetailID)", objCnn)
            objDB.sqlExecute("insert into DummySalePayment " + sqlStatement, objCnn)


            sqlStatement = "select TransactionID,ComputerID,SUM(IF(NotInPrepaid = 0, IF( (SalePrice + ServiceCharge + ServiceChargeVAT) is NULL,0,SalePrice + ServiceCharge + ServiceChargeVAT), 0)) AS SalePricePrepaid, SUM(IF(NotInPrepaid = 1, IF( (SalePrice + ServiceCharge + ServiceChargeVAT) is NULL,0,SalePrice + ServiceCharge + ServiceChargeVAT), 0)) AS SalePriceNotPrepaid from DummySalePayment group by TransactionID,ComputerID"
            objDB.sqlExecute("DROP TABLE IF EXISTS DummySalePaymentSum", objCnn)
            objDB.sqlExecute("create table DummySalePaymentSum (TransactionID int, ComputerID int, SalePricePrepaid decimal(18,4) NOT NULL Default '0', SalePriceNotPrepaid decimal(18,4) NOT NULL Default '0')", objCnn)
            objDB.sqlExecute("ALTER TABLE DummySalePaymentSum ADD INDEX (TransactionID,ComputerID)", objCnn)
            objDB.sqlExecute("insert into DummySalePaymentSum " + sqlStatement, objCnn)

            '--------------------------------------
            'sqlStatement = "select a.TransactionID,a.ComputerID,SUM(b.Amount) FROM OrderTransaction a, PayDetail b WHERE a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID " + AdditionalQuery + " GROUP BY a.TransactionID,a.ComputerID"

            'objDB.sqlExecute("DROP TABLE IF EXISTS DummyPayTypeTemp", objCnn)
            'objDB.sqlExecute("create table DummyPayTypeTemp (TransactionID int, ComputerID int, TotalPayAmount decimal(18,4))", objCnn)
            'objDB.sqlExecute("ALTER TABLE DummyPayTypeTemp ADD PRIMARY KEY (TransactionID,ComputerID)", objCnn)
            'objDB.sqlExecute("insert into DummyPayTypeTemp " + sqlStatement, objCnn)

            'sqlStatement = "select a.TransactionID,a.ComputerID,(b.TotalPayAmount-a.ServiceCharge-a.ServiceChargeVAT) AS TotalPayAmountNoSC FROM OrderTransaction a, DummyPayTypeTemp b WHERE a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID "

            'objDB.sqlExecute("DROP TABLE IF EXISTS DummyPayTypeNoSC", objCnn)
            'objDB.sqlExecute("create table DummyPayTypeNoSC (TransactionID int, ComputerID int, TotalPayAmountNoSC decimal(18,4))", objCnn)
            'objDB.sqlExecute("ALTER TABLE DummyPayTypeNoSC ADD PRIMARY KEY (TransactionID,ComputerID)", objCnn)
            'objDB.sqlExecute("insert into DummyPayTypeNoSC " + sqlStatement, objCnn)
            '--------------------------------------

            '--------------------------------------
            sqlStatement = "select a.TransactionID,a.ComputerID,c.NotAllProducts,SUM(b.Amount) FROM OrderTransaction a, PayDetail b, PayType c WHERE a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.PayTypeID=c.TypeID " + AdditionalQuery + " GROUP BY a.TransactionID,a.ComputerID,c.NotAllProducts"

            objDB.sqlExecute("DROP TABLE IF EXISTS DummyPayType", objCnn)
            objDB.sqlExecute("create table DummyPayType (TransactionID int, ComputerID int, NotAllProducts tinyint, TotalPayAmount decimal(18,4))", objCnn)
            objDB.sqlExecute("ALTER TABLE DummyPayType ADD PRIMARY KEY (TransactionID,ComputerID,NotAllProducts)", objCnn)
            objDB.sqlExecute("insert into DummyPayType " + sqlStatement, objCnn)
            '--------------------------------------

            objDB.sqlExecute("DROP TABLE IF EXISTS DummyPayDetail", objCnn)
            objDB.sqlExecute("create table DummyPayDetail (TransactionID int, ComputerID int, PayTypeID int, Amount decimal(18,4))", objCnn)
            objDB.sqlExecute("ALTER TABLE DummyPayDetail ADD PRIMARY KEY (TransactionID,ComputerID,PayTypeID)", objCnn)

            sqlStatement = "select b.TransactionID,b.ComputerID,b.PayTypeID,SUM(b.Amount) AS Amount from ordertransaction" + BranchStr + " a, paydetail" + BranchStr + " b where a.transactionid=b.transactionid and a.computerid=b.computerid AND a.TransactionStatusID=2 " + AdditionalQuery + " group by b.TransactionID,b.ComputerID,b.PayTypeID"

            objDB.sqlExecute("insert into DummyPayDetail " + sqlStatement, objCnn)


            Dim SelPaymentString As String = ""
            Dim WherePaymentString As String = ""
            Dim TableString As String = ""
            Dim UpdateString As String = ""
            Dim WeightedStringNotAll As String = ""
            Dim WeightedStringAll As String = ""
            Dim SelWeightedNotAll As String = ""
            Dim SelWeightedAll As String = ""
            Dim MinusWeighted As String = "0"
            Dim DividedString As String = "0"
            Dim i As Integer
            For i = 0 To PaymentResult.Rows.Count - 1
                SelPaymentString += ",IF(p" + PaymentResult.Rows(i)("PayTypeID").ToString + ".Amount is NULL,0,p" + PaymentResult.Rows(i)("PayTypeID").ToString + ".Amount) AS PayAmount" + PaymentResult.Rows(i)("PayTypeID").ToString
                WherePaymentString += " LEFT OUTER JOIN DummyPayDetail p" + PaymentResult.Rows(i)("PayTypeID").ToString + " ON a.TransactionID=p" + PaymentResult.Rows(i)("PayTypeID").ToString + ".TransactionID AND a.ComputerID=p" + PaymentResult.Rows(i)("PayTypeID").ToString + ".ComputerID AND p" + PaymentResult.Rows(i)("PayTypeID").ToString + ".PayTypeID=" + PaymentResult.Rows(i)("PayTypeID").ToString
                TableString += ", PayAmount" + PaymentResult.Rows(i)("PayTypeID").ToString + " decimal(18,4)"

                If PaymentResult.Rows(i)("NotAllProducts") = 1 Then
                    UpdateString += ",PayAmount" + PaymentResult.Rows(i)("PayTypeID").ToString + "=0"
                    SelWeightedNotAll += ",IF(b.SalePricePrepaid=0,0,a.PayAmount" + PaymentResult.Rows(i)("PayTypeID").ToString + "*a.SalePrice/b.SalePricePrepaid) AS WeightedPay" + PaymentResult.Rows(i)("PayTypeID").ToString
                    MinusWeighted += "-IF(b.SalePricePrepaid=0,0,a.PayAmount" + PaymentResult.Rows(i)("PayTypeID").ToString + "*a.SalePrice/b.SalePricePrepaid)"
                    WeightedStringNotAll += ", WeightedPay" + PaymentResult.Rows(i)("PayTypeID").ToString + " float"
                Else
                    DividedString += " + a.PayAmount" + PaymentResult.Rows(i)("PayTypeID").ToString
                End If
            Next


            For i = 0 To PaymentResult.Rows.Count - 1
                If PaymentResult.Rows(i)("NotAllProducts") = 0 Then
                    If PaymentResult.Rows(i)("PayTypeID") = 1 Then
                        SelWeightedAll += ",IF(a.AllProductPayAmount = 0, a.SalePrice,a.PayAmount" + PaymentResult.Rows(i)("PayTypeID").ToString + "*(SalePrice-" + MinusWeighted + ")/(" + DividedString + ")) AS WeightedPay" + PaymentResult.Rows(i)("PayTypeID").ToString
                    Else
                        SelWeightedAll += ",a.PayAmount" + PaymentResult.Rows(i)("PayTypeID").ToString + "*(SalePrice-" + MinusWeighted + ")/(" + DividedString + ") AS WeightedPay" + PaymentResult.Rows(i)("PayTypeID").ToString
                    End If
                    WeightedStringAll += ", WeightedPay" + PaymentResult.Rows(i)("PayTypeID").ToString + " float"
                End If
            Next
            sqlStatement = "select a.TransactionID,a.ComputerID,a.OrderDetailID,a.ProductID,a.ProductCode,a.NotInPrepaid,a.SalePrice+a.ServiceCharge+a.ServiceChargeVAT AS SalePriceWSC, b1.TotalPayAmount AS AllProductPayAmount, b2.TotalPayAmount AS NotAllProductPayAmount" + SelPaymentString + " from dummysalepayment a left outer join DummyPayType b1 ON a.TransactionID=b1.TransactionID and a.ComputerID=b1.Computerid AND b1.NotAllProducts=0 left outer join DummyPayType b2 ON a.TransactionID=b2.TransactionID and a.ComputerID=b2.Computerid AND b2.NotAllProducts=1 " + WherePaymentString

            objDB.sqlExecute("DROP TABLE IF EXISTS DummyPayData", objCnn)
            objDB.sqlExecute("create table DummyPayData (TransactionID int, ComputerID int, OrderDetailID int, ProductID int, ProductCode varchar(200), NotInPrepaid tinyint, SalePrice decimal(18,4), AllProductPayAmount decimal(18,4), NotAllProductPayAmount decimal(18,4)" + TableString + ")", objCnn)
            'objDB.sqlExecute("ALTER TABLE DummyPayData ADD PRIMARY KEY (TransactionID,ComputerID,OrderDetailID)", objCnn)
            objDB.sqlExecute("insert into DummyPayData " + sqlStatement, objCnn)

            If UpdateString <> "" Then
                objDB.sqlExecute(" UPDATE DummyPayData SET TransactionID=TransactionID" + UpdateString + " WHERE NotInPrepaid=1", objCnn)
            End If


            sqlStatement = "select a.TransactionID,a.ComputerID,a.OrderDetailID,a.ProductID,a.NotInPrepaid,a.SalePrice" + SelWeightedNotAll + SelWeightedAll + " from DummyPayData a, DummySalePaymentSum b where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID"

            objDB.sqlExecute("DROP TABLE IF EXISTS DummyPayFinal", objCnn)
            objDB.sqlExecute("create table DummyPayFinal (TransactionID int, ComputerID int, OrderDetailID int, ProductID int, NotInPrepaid bit, SalePrice decimal(18,4)" + WeightedStringNotAll + WeightedStringAll + ")", objCnn)
            'objDB.sqlExecute("ALTER TABLE DummyPayFinal ADD PRIMARY KEY (TransactionID,ComputerID,OrderDetailID)", objCnn)
            objDB.sqlExecute("insert into DummyPayFinal " + sqlStatement, objCnn)

            objDB.sqlExecute("DROP TABLE IF EXISTS DummyPayData", objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummyPayType", objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummySalePaymentSum", objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummySalePayment", objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS ProductNotInPrepaidTemp", objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummyPayDetail", objCnn)

            objDB.sqlExecute("DROP TABLE IF EXISTS DummyServiceCharge", objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummySaleBeforeVAT", objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummySaleReport", objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummyNoVAT", objCnn)
            outputString = ""
            grandTotal = 0
            Return GetData


        End Function
		
		Public Function GenOutputSaleByDept3(ByRef outputString As String, ByRef grandTotal As Double, ByRef VATTotal As Double, ByVal ShowSummary As Boolean, ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal dtTable As DataTable, ByVal PaymentResult As DataTable, ByVal PayByCreditMoney As DataTable, ByVal ShopID As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal objCnn As MySqlConnection) As String

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

                If Not (DummyGroupID = CompareGroupID) Then

                    If i <> 0 Then
                        outputString += "<tr bgColor=""" + bgColor + """>"
                        outputString += "<td colspan=""2"" align=""right"" class=""" + TextClass + """>Total for " + dtTable.Rows(i - 1)("ProductGroupName") + "</td>"
                        outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(subTotalQty, "##,##0.0") + "</td>"
                        outputString += "<td align=""right"" class=""" + TextClass + """>" + Format((subTotalQty / totalQty) * 100, "##,##0.00") + "%</td>"
                        outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(subTotalRetailPrice, "##,##0.00") + "</td>"
                        outputString += "<td align=""right"" class=""" + TextClass + """>" + Format((subTotalRetailPrice / totalRetailPrice) * 100, "##,##0.00") + "%</td>"
                        outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(subTotalServiceCharge, "##,##0.00") + "</td>"
                        outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(subTotalPriceDiscount + subTotalDiscount, "##,##0.00") + "</td>"

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

                    outputString += "<tr><td colspan=""11"" class=""tdHeader"" bgColor=""" + AdminBGColor + """>" + dtTable.Rows(i)("ProductGroupName") + "</td></tr>"


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

                If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) And Not IsDBNull(dtTable.Rows(i)("ProductExcludeVAT")) Then

                    RetailPriceAfterVAT = dtTable.Rows(i)("TotalRetailPrice") + dtTable.Rows(i)("ProductExcludeVAT")
                    outputString += "<td align=""right"" class=""" + TextClass + """>" & Format(RetailPriceAfterVAT, "##,##0.00") & "</td>"
                    outputString += "<td align=""right"" class=""" + TextClass + """>" & Format((RetailPriceAfterVAT / totalRetailPrice) * 100, "##,##0.00") & "%</td>"
                    subTotalRetailPrice += dtTable.Rows(i)("TotalRetailPrice") + dtTable.Rows(i)("ProductExcludeVAT")
                    grandTotalRetailPrice += dtTable.Rows(i)("TotalRetailPrice") + dtTable.Rows(i)("ProductExcludeVAT")

                Else
                    outputString += "<td align=""right"" class=""" + TextClass + """>" & "0.00" & "</td>"
                    outputString += "<td align=""right"" class=""" + TextClass + """>" & "0.00" & "%</td>"
                End If

                If Not IsDBNull(dtTable.Rows(i)("ServiceCharge")) And Not IsDBNull(dtTable.Rows(i)("ServiceChargeVAT")) Then

                    outputString += "<td align=""right"" class=""" + TextClass + """>" & Format(dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT"), "##,##0.00") & "</td>"
                    subTotalServiceCharge += dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT")
                    grandTotalServiceCharge += dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT")

                Else
                    outputString += "<td align=""right"" class=""" + TextClass + """>" & "0.00" & "</td>"
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



                outputString += "<td align=""right"" class=""" + TextClass + """>" & Format(TotalProductDiscount + PriceDiscount, "##,##0.00") & "</td>"


                If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) And Not IsDBNull(dtTable.Rows(i)("ProductExcludeVAT")) And Not IsDBNull(dtTable.Rows(i)("ServiceChargeVAT")) Then
                    lineTotal = dtTable.Rows(i)("TotalRetailPrice") + dtTable.Rows(i)("ProductExcludeVAT") - TotalProductDiscount - PriceDiscount + dtTable.Rows(i)("ServiceChargeVAT") + dtTable.Rows(i)("ServiceCharge")
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

                If Not IsDBNull(dtTable.Rows(i)("ProductGroupID")) Then
                    DummyGroupID = dtTable.Rows(i)("ProductGroupID")
                Else
                    DummyGroupID = 0
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
                outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(subTotalServiceCharge, "##,##0.00") + "</td>"
                outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(subTotalPriceDiscount + subTotalDiscount, "##,##0.00") + "</td>"

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
                outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalServiceCharge, "##,##0.00") + "</td>"
                outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalPriceDiscount + grandTotalDiscount, "##,##0.00") + "</td>"

                outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(grandTotalAfterVAT, "##,##0.00") + "</td>"
                outputString += "<td align=""right"" class=""" + TextClass + """>" + Format((grandTotalAfterVAT / totalSale) * 100, "##,##0.00") + "%</td>"
                outputString += "</tr>"
            End If
            outputString += "</table>"

            Dim SelPayString As String = ""
            For i = 0 To PaymentResult.Rows.Count - 1
                SelPayString += ",SUM(WeightedPay" + PaymentResult.Rows(i)("PayTypeID").ToString + ") AS SumWeightedPay" + PaymentResult.Rows(i)("PayTypeID").ToString
            Next
            Dim dTable As DataTable = objDB.List("select pg.ProductGroupID,pg.ProductGroupName" + SelPayString + " from DummyPayFinal a, Products p, ProductDept pd, ProductGroup pg where a.ProductID=p.ProductID AND p.ProductDeptID=pd.ProductDeptID AND pd.ProductGroupID=pg.ProductGroupID group by pg.ProductGroupID,pg.ProductGroupName order by pg.ProductGroupName", objCnn)
            Dim PaymentSumString As String = "" 'SalePaymentSum(dTable, GrayBGColor, AdminBGColor, ShopID, 0, StartDate, EndDate, PaymentResult, False, objCnn)

            'outputString += PaymentSumString

            Dim FinalSaleAmount As Double

            DiscountArray(0) = grandTotalPriceDiscount + grandTotalDiscount
            DiscountArray(1) += grandTotalPriceDiscount
            'Dim ResultSummary As String = SaleReportSummary(FinalSaleAmount, GrayBGColor, AdminBGColor, ShopID, 0, StartDate, EndDate, grandTotalVAT, grandTotalAfterVAT, 0, PaymentResult, PayByCreditMoney, DiscountArray, True, False, objCnn)
            'outputString += ResultSummary

        End Function

Sub Page_UnLoad()
	objCnn.Close()
End Sub
</script>
</body>
</html>
