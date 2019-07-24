<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="CreditCardByZone" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Credit Card Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="../StyleSheet/webscript.js"></script> 
</head>
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
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
	<td><span id="SelectShop" class="text" runat="server"></span><br><span id="ShopText" runat="server"></span><br><span class="text">Select Zone</span><br>
	<span id="ZoneText" runat="server"></span></td>
	<td>
	<table>
		<tr><td>&nbsp;</td><td colspan="4"><span id="DocumentDateParam" class="text" runat="server"></span></td></tr>
		<tr>
		<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
		<td colspan="4"><synature:date id="MonthYearDate" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="Radio_2" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="CurrentDate" runat="server" /></td>
		<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
		<td><synature:date id="ToDate" runat="server" /></td>
	</tr>
	<tr><td>&nbsp;</td>
		<td colspan="3"><table cellpadding="0" cellspacing="0"><tr><td><asp:dropdownlist ID="GroupByParam" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td><td>&nbsp;</td><td><asp:CheckBox ID="GroupDate" CssClass="text" runat="server" /></td><td>&nbsp;</td><td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td></tr></table></td>
	</tr>
	</table>
	</td>
</tr>


</table>
<br>
</div>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr>
</table>
<span id="MyTable">
<table width="100%">
<tr><td align="center">
<div id="ResultSearchText" runat="server"></div></td></tr>
<tr><td>
<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="Text6" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>
</table></td></tr>
</table></span>
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
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim FormatDocNumber As New FormatText()
Dim objDB As New CDBUtil()
Dim getReport As New StReports()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_CCByZone") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		Dim MultipleShop As String  = ""
		If PropertyInfo.Rows(0)("ImportDataToCopyTable") = 0 Then
			MultipleShop = "multiple"
		End If
		MultipleShop = ""
		
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
			
	  	headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor
		headerTD6.BgColor = GlobalParam.AdminBGColor

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
		
		GroupByParam.Items(0).Text = "No Grouping"
		GroupByParam.Items(0).Value = "1"
		GroupByParam.Items(1).Text = "Group By Type"
		GroupByParam.Items(1).Value = "2"
		GroupByParam.Items(2).Text = "Group By Bank"
		GroupByParam.Items(2).Value = "3"
		GroupByParam.Items(3).Text = "Group By Bank/Type"
		GroupByParam.Items(3).Value = "4"
		GroupDate.Text = "Grouping Date"
		
		ResultText.InnerHtml = ""
		ResultSearchText.InnerHtml = ""
		errorMsg.InnerHtml = ""
		
		headerTD1.Visible = True
		headerTD2.Visible = True
		headerTD3.Visible = True
		headerTD4.Visible = True
		headerTD5.Visible = True
		headerTD6.Visible = True
		If GroupByParam.SelectedItem.Value = 1 AND GroupDate.Checked = True Then
			headerTD1.Visible = False
			headerTD2.Visible = False
			headerTD3.Visible = False
			headerTD4.Visible = False
		Else If GroupByParam.SelectedItem.Value = 2 Then
			headerTD1.Visible = False
			headerTD2.Visible = False
			headerTD3.Visible = False
			headerTD5.Visible = False
			If GroupDate.Checked = True Then headerTD5.Visible = True
		Else If GroupByParam.SelectedItem.Value = 3 Then
			headerTD1.Visible = False
			headerTD2.Visible = False
			headerTD4.Visible = False
			headerTD5.Visible = False
			If GroupDate.Checked = True Then headerTD5.Visible = True
		Else If GroupByParam.SelectedItem.Value = 4 Then
			headerTD1.Visible = False
			headerTD2.Visible = False
			headerTD5.Visible = False
			If GroupDate.Checked = True Then headerTD5.Visible = True
		End If
		
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
			Radio_2.Checked = True
		End If

		Dim ShopIDValue As String = "0"
		If IsNumeric(Request.Form("ShopID")) Then
			ShopIDValue = Request.Form("ShopID").ToString
		Else If IsNumeric(Request.QueryString("ShopID"))
			ShopIDValue = Request.QueryString("ShopID").ToString
		End If
			
			
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(13,Session("LangID"),objCnn)
			Dim textTable1 As New DataTable()
			textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			DocumentDateParam.InnerHtml = textTable.Rows(5)("TextParamValue")
			SubmitForm.Text = textTable.Rows(8)("TextParamValue")
			Text1.InnerHtml = "Receipt #"
			Text2.InnerHtml = "Credit Card #"
			Text3.InnerHtml = "CC Bank"
			Text4.InnerHtml = "CC Type"
			Text5.InnerHtml = "Date"
			Text6.InnerHtml = "Amount"
			SelectShop.InnerHtml = "Select Shop"
			DocumentToDateParam.InnerHtml = defaultTextTable.Rows(91)("TextParamValue")
			
			HeaderText.InnerHtml = "Credit Card By Zone Report"

			'If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
			Dim i As Integer
			Dim outputString,FormSelected,compareString As String
			Dim SelectString As String 

			Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
			If ShopData.Rows.Count > 0 Then
	
				outputString = "<select name=""ShopID"" style=""width:200px"">"
				For i = 0 to ShopData.Rows.Count - 1
					If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
						FormSelected = "selected"
						'SelShopName.Value = ShopData.Rows(i)("ProductLevelName")
					Else
						If Not Page.IsPostBack And i=0 Then
							FormSelected = "selected"
						Else
							FormSelected = ""
						End If
					End If
					outputString += "<option value=""" & ShopData.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & ShopData.Rows(i)("ProductLevelName")
				Next
				outputString += "</select>"
				ShopText.InnerHtml = outputString
				ShowShop.Visible = True
			Else
				ShowShop.Visible = False
			End If
			
			Dim DataInfo As DataTable = getProp.TableInfo(1,ShopIDValue,0,0,objCnn)
			Dim ZoneIDValue As String = "0"
			If IsNumeric(Request.Form("ZoneID")) Then
				ZoneIDValue = Request.Form("ZoneID").ToString
			Else If IsNumeric(Request.QueryString("ZoneID"))
				ZoneIDValue = Request.QueryString("ZoneID").ToString
			End If
			
			outputString = "<select name=""ZoneID"" style=""width:200px"">"
			If DataInfo.Rows.Count > 1 Then
				If Not Page.IsPostBack Then 
					FormSelected = "selected"
				ElseIf ZoneIDValue = 0 Then
					FormSelected = "selected"
				Else
					FormSelected = ""
				End If
				outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & "--- All Zones ---"
			End If
			For i = 0 to DataInfo.Rows.Count - 1
				If ZoneIDValue = DataInfo.Rows(i)("ZoneID") Then
					FormSelected = "selected"
				Else
					FormSelected = ""
					'If Not Page.IsPostBack Then
						'FormSelected = "selected"
					'Else
						'FormSelected = ""
					'End If
				End If
				outputString += "<option value=""" & DataInfo.Rows(i)("ZoneID") & """ " & FormSelected & ">" & DataInfo.Rows(i)("ZoneName")
			Next
			outputString += "</select>"
			ZoneText.InnerHtml = outputString
					
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
	Try
	If Radio_2.Checked = True Then
		Dim InvC As CultureInfo = CultureInfo.InvariantCulture
		DateFromValue = DateTimeUtil.FormatDate(Request.Form("Doc_Day"),Request.Form("Doc_Month"),Request.Form("Doc_Year"))
		Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate)
		DateToValue = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))
		
		If Trim(DateFromValue) = "InvalidDate" Or Trim(DateToValue) = "InvalidDate" Then
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
			FoundError = True
			DateFromValue = ""
			DateToValue = ""
		Else
			ResultSearchText.InnerHtml = ""
		End If
	Else
		DateFromValue = ""
		DateToValue = ""
	End If
	
	If Radio_1.Checked = True Then
		If Not (IsNumeric(Request.Form("MonthYearDate_Month")) AND IsNumeric(Request.Form("MonthYearDate_Year"))) Then
			FoundError = True
		End If
	End If
	Catch ex As Exception
			FoundError = True
		End Try
	
	If FoundError = False Then
		ShowPrint.Visible = True
		Dim i As Integer
		Dim DateCheck As Boolean

		Dim outputString As String = ""
		Dim counter As Integer
		Dim ShowString As String = ""
		Dim bgColor As String = "e9e9e9"
		Dim DummyShopID As Integer
		Dim sumTotal As Double = 0
		Dim sumTotalPlus As Double = 0
		Dim sumTotalMinus As Double = 0
		Dim SelMonth As Integer = 0
		Dim SelYear As Integer = 0
		
		If IsNumeric(Request.Form("MonthYearDate_Month")) Then SelMonth = Request.Form("MonthYearDate_Month")
		If IsNumeric(Request.Form("MonthYearDate_Year")) Then SelYear = Request.Form("MonthYearDate_Year")
		Application.Lock()
		Dim dtTable As DataTable = getReport.CreditCardByZoneReport(Session("LangID"),Radio_1.Checked, Radio_2.Checked, SelMonth, SelYear, DateFromValue, DateToValue, Request.Form("ShopID"),GroupByParam.SelectedItem.Value, GroupDate.Checked, Request.Form("ZoneID").ToString, objCnn)
		Application.UnLock()
		
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		Dim AdditionalHeaderText,HText,RText As String
		Dim ReceiptHeaderData As Datatable
		ReceiptHeaderData = getInfo.GetDocType(1,0,8,Session("LangID"),objCnn)

		If ReceiptHeaderData.Rows.Count > 0 Then
			If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
				AdditionalHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
			End If
		End If
		Dim ColSpan As Integer = 0
		If headerTD1.Visible = True Then ColSpan += 1
		If headerTD2.Visible = True Then ColSpan += 1
		If headerTD3.Visible = True Then ColSpan += 1
		If headerTD4.Visible = True Then ColSpan += 1
		If headerTD5.Visible = True Then ColSpan += 1
		Dim DummyKey As String = ""
		Dim CompareKey As String = ""
		Dim SessionSum As Double = 0
		Dim ZoneSum As Double = 0
		For i=0 To dtTable.Rows.Count - 1
			CompareKey = dtTable.Rows(i)("ZoneID").ToString + ":" + dtTable.Rows(i)("SessionID").ToString
			If CompareKey <>  DummyKey Then
				
				If i > 0 Then
					outputString += "<tr><td colspan=""" + ColSpan.ToString + """ class=""boldText"" align=""right"">Session Summary</td><td align=""right"" class=""boldText"">" + Format(SessionSum,"##,##0.00") + "</td></tr>"
					If dtTable.Rows(i-1)("ZoneID") <> dtTable.Rows(i)("ZoneID") Then
						outputString += "<tr><td colspan=""" + ColSpan.ToString + """ class=""boldText"" align=""right"">Zone Summary</td><td align=""right"" class=""boldText"">" + Format(ZoneSum,"##,##0.00") + "</td></tr>"
						ZoneSum = 0
					End If
					SessionSum = 0
				End If
				outputString += "<tr><td colspan=""" + (ColSpan+1).ToString + """ class=""text"" align=""left"">Zone:" + dtTable.Rows(i)("ZoneName") + "</td></tr>"
			End If
			outputString += "<tr>"
			If headerTD1.Visible = True Then
				HText  = ""
				If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
					If Not IsDBNull(dtTable.Rows(i)("DocumentTypeHeader")) Then
						HText = dtTable.Rows(i)("DocumentTypeHeader")
					End If
				Else
					HText = AdditionalHeaderText
				End If
				If IsDBNull(dtTable.Rows(i)("ReceiptID")) Or IsDBNull(dtTable.Rows(i)("ReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("ReceiptYear")) Then
					RText = "-"
				Else
					RText = FormatDocNumber.getReceiptHeader(HText,dtTable.Rows(i)("ReceiptYear"),dtTable.Rows(i)("ReceiptMonth"),dtTable.Rows(i)("ReceiptID"))
				End If
				If RText <> "-" Then
					outputString += "<td align=""left"" class=""text""><a href=""JavaScript: newWindow = window.open( '../../Reports/BillDetails.aspx?ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & RText & "</a></td>"
				Else
					outputString += "<td align=""left"" class=""text"">" & RText & "</td>"
				End If

			End If
			If headerTD2.Visible = True Then
			  If Not IsDBNull(dtTable.Rows(i)("CreditCardNo")) Then
				outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("CreditCardNo") & "</td>"
			  Else
			  	outputString += "<td align=""left"" class=""text"">" & "N/A" & "</td>"
			  End If

			End If
			If headerTD3.Visible = True Then
			  If Not IsDBNull(dtTable.Rows(i)("BankName")) Then
				outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("BankName") & "</td>"
			  Else
			  	outputString += "<td align=""left"" class=""text"">" & "N/A" & "</td>"
			  End If
	
			End If
			If headerTD4.Visible = True Then
			  If Not IsDBNull(dtTable.Rows(i)("CreditCardType")) Then
				outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("CreditCardType") & "</td>"
			  Else
			  	outputString += "<td align=""left"" class=""text"">" & "N/A" & "</td>"
			  End If
	
			End If
			If headerTD5.Visible = True Then
				outputString += "<td align=""right"" class=""text"">" & DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly") & "</td>"
	
			End If
			If headerTD6.Visible = True Then
				outputString += "<td align=""right"" class=""text"">" & Format(dtTable.Rows(i)("totalAmount"),"##,##0.00") & "</td>"
			End If
			
			outputString += "</tr>"
			sumTotal += dtTable.Rows(i)("totalAmount")
			SessionSum += dtTable.Rows(i)("totalAmount")
			ZoneSum += dtTable.Rows(i)("totalAmount")

			counter = counter + 1
			DummyKey = dtTable.Rows(i)("ZoneID").ToString + ":" + dtTable.Rows(i)("SessionID").ToString
			
		Next
		If dtTable.Rows.Count > 0 Then
			outputString += "<tr><td colspan=""" + ColSpan.ToString + """ class=""boldText"" align=""right"">Session Summary</td><td align=""right"" class=""boldText"">" + Format(SessionSum,"##,##0.00") + "</td></tr>"
			outputString += "<tr><td colspan=""" + ColSpan.ToString + """ class=""boldText"" align=""right"">Zone Summary</td><td align=""right"" class=""boldText"">" + Format(ZoneSum,"##,##0.00") + "</td></tr>"
			outputString += "<tr><td colspan=""" + ColSpan.ToString + """ class=""boldText"" align=""right"">Grand Total Amount</td><td align=""right"" class=""boldText"">" + Format(sumTotal,"##,##0.00") + "</td></tr>"
		End If
		If dtTable.Rows.Count = 0 Then
			outputString = "<tr><td class=""boldText"" colspan=""4"">No Data Found</td></tr>"
		End If
		ResultText.InnerHtml = outputString
	End If
	
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
