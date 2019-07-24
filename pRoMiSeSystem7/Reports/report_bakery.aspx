<%@ Page Language="VB" ContentType="text/html" debug="True" EnableViewState="False" %>
<%@ Register tagPrefix="Web" Namespace="WebChart" Assembly="WebChart" %>
<%@ Import Namespace="System.Drawing" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.Math" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="CostingClass.pRoMiSeCosting" %>
<%@Import Namespace="pRoMiSe_SummaryMaterialInDocument" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Bakery Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelDocGroupName" runat="server" />
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
<div class="noprint"><span id="showShop" runat="server">
<table>
<tr id="ShowDocGroup" runat="server">
	<td valign="top">
		<table>
			<tr id="ShowShop2" visible="false" runat="server">
				<td><span id="ShopText" runat="server"></span></td>
			</tr>
			<tr>
				<td><span id="DocGroupText" runat="server"></span></td>
			</tr>
			<tr>
				<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
			</tr>


		</table></td>
	<td>
	<table>
		<tr>
			<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
			<td colspan="4"><synature:date id="DailyDate" runat="server" /></td>
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
	
	</table>
	</td>
</tr>


</table>
<br></span>
</div>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
<tr><td align="center">
<div id="ResultSearchText" class="boldText" runat="server"></div></td></tr></table>
<span id="showHeader" runat="server">
<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td id="headerTD1" align="center" class="smallTdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD2" align="center" class="smallTdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD3" align="center" class="smallTdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD4" align="center" class="smallTdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td id="headerTD5" align="center" class="smallTdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<span id="ExtraHeader" runat="server"></span>
		<td id="headerTD6" align="center" class="smallTdHeader" runat="server"><div id="Text6" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>

	<asp:DataGrid ID="Results" AutoGenerateColumns="true" CellPadding="3" CssClass="smalltext" HeaderStyle-BackColor="#507093" HeaderStyle-CssClass="smallTdHeader" HeaderStyle-HorizontalAlign="center" AllowPaging="false" runat="server">
		
	</asp:DataGrid>
</table>
</span>
<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table>
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
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim FormatHeader As New FormatText()
Dim CostInfo As New CostClass()
Dim rpt As New SummaryMaterialInDocument()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Reports_Bakery") Then
		
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
		
		headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor
		headerTD6.BgColor = GlobalParam.AdminBGColor
		
		headerTD1.Visible = True
		headerTD2.Visible = True
		headerTD3.Visible = True
		headerTD4.Visible = False
		headerTD5.Visible = False
		headerTD6.Visible = True
		showHeader.Visible = False
		
		Text1.InnerHtml = "Group"
		Text2.InnerHtml = "Material"
		Text3.InnerHtml = "Unit"
		Text6.InnerHtml = "Summary"
		
		DocumentToDateParam.InnerHtml = defaultTextTable.Rows(91)("TextParamValue")
		
		Dim HeaderReport As DataTable = getProp.PermissionName(1020,Session("LangID"),objCnn)
		
		If HeaderReport.Rows.Count > 0 Then
			LangText0.Text = HeaderReport.Rows(0)("PermissionItemName")
		Else
			LangText0.Text = "Bakery Reports"
		End If
		
		ReportName.Value = LangText0.Text
			
		DailyDate.YearType = GlobalParam.YearType
		DailyDate.FormName = "DocDaily"
		DailyDate.StartYear = GlobalParam.StartYear
		DailyDate.EndYear = GlobalParam.EndYear
		DailyDate.LangID = Session("LangID")
		'DailyDate.Lang_Data = LangDefault
		'DailyDate.Culture = CultureString
		
		CurrentDate.YearType = GlobalParam.YearType
		CurrentDate.FormName = "Doc"
		CurrentDate.StartYear = GlobalParam.StartYear
		CurrentDate.EndYear = GlobalParam.EndYear
		CurrentDate.LangID = Session("LangID")
		'CurrentDate.Lang_Data = LangDefault
		'CurrentDate.Culture = CultureString
		
		ToDate.YearType = GlobalParam.YearType
		ToDate.FormName = "DocTo"
		ToDate.StartYear = GlobalParam.StartYear
		ToDate.EndYear = GlobalParam.EndYear
		ToDate.LangID = Session("LangID")
		'ToDate.Lang_Data = LangDefault
		'ToDate.Culture = CultureString
		
		MonthYearDate.YearType = GlobalParam.YearType
		MonthYearDate.FormName = "MonthYearDate"
		MonthYearDate.StartYear = GlobalParam.StartYear
		MonthYearDate.EndYear = GlobalParam.EndYear
		MonthYearDate.LangID = Session("LangID")
		MonthYearDate.ShowDay = False
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
		
		If Not Page.IsPostBack Then
			Radio_3.Checked = True
		End If

		Dim DocumentTypeGroupID As String = "-1"
		If IsNumeric(Request.Form("DocumentTypeGroupID")) Then
			DocumentTypeGroupID = Request.Form("DocumentTypeGroupID")
		Else If IsNumeric(Request.QueryString("DocumentTypeGroupID"))
			DocumentTypeGroupID = Request.QueryString("DocumentTypeGroupID")
		End If
			
		ShowDocGroup.Visible = True
		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		Dim Multiple As Boolean = False
		Dim i As Integer
		
		Dim DocTypeGroup As New DataTable
		DocTypeGroup.Columns.Clear()
		DocTypeGroup.Columns.Add("DocumentTypeGroupID", System.Type.GetType("System.String"))
		DocTypeGroup.Columns.Add("GroupName", System.Type.GetType("System.String"))

        Dim rData As DataRow
		
		rData = DocTypeGroup.NewRow
		rData("DocumentTypeGroupID") = "20,21"
		rData("GroupName") = "Sale Document"
		DocTypeGroup.Rows.Add(rData)
		
		rData = DocTypeGroup.NewRow
		rData("DocumentTypeGroupID") = "1001,1007,1008"
		rData("GroupName") = "Transfer Document"
		DocTypeGroup.Rows.Add(rData)
		
		rData = DocTypeGroup.NewRow
		rData("DocumentTypeGroupID") = "1003"
		rData("GroupName") = "Return Document"
		DocTypeGroup.Rows.Add(rData)
				
		If DocTypeGroup.Rows.Count > 0 Then

			outputString = "<select name=""DocumentTypeGroupID"">"
			If DocTypeGroup.Rows.Count > 1 Then
				If Not Page.IsPostBack Then 
					FormSelected = "selected"
				ElseIf DocumentTypeGroupID = "-1" Then
					FormSelected = "selected"
				Else
					FormSelected = ""
				End If
				outputString += "<option value=""" & "-1" & """ " & FormSelected & ">" & "--- Please Select Report ---"
			End If
			
			For i = 0 to DocTypeGroup.Rows.Count - 1
				If DocumentTypeGroupID = DocTypeGroup.Rows(i)("DocumentTypeGroupID") Then
					FormSelected = "selected"
				Else
					FormSelected = ""
				End If
				outputString += "<option value=""" & DocTypeGroup.Rows(i)("DocumentTypeGroupID") & """ " & FormSelected & ">" & DocTypeGroup.Rows(i)("GroupName")
			Next
			outputString += "</select>"
			DocGroupText.InnerHtml = outputString
			ShowDocGroup.Visible = True
		Else
			ShowDocGroup.Visible = False
		End If
		
		Dim ShopIDValue As String = "0"
		If IsNumeric(Request.Form("ShopID")) Then
			ShopIDValue = Request.Form("ShopID").ToString
		Else If IsNumeric(Request.QueryString("ShopID"))
			ShopIDValue = Request.QueryString("ShopID").ToString
		End If
		
		Dim ShopList As String = ""
		Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-99,Session("StaffRole"),objCnn)
		If ShopData.Rows.Count > 0 Then

			outputString = "<select name=""ShopID"">"
			
			If ShopData.Rows.Count > 1 Then
				If Not Page.IsPostBack Then 
					FormSelected = "selected"
					SelShopName.Value = "All Shops"
				ElseIf ShopIDValue = "0" Then
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
	
	Dim StartDate,EndDate,EndDate2 As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer

	Dim grandTotal As Double = 0
	Dim GraphData As New DataSet()
	Dim ReportDate As String
	Dim SelMonth,SelYear As Integer
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
		SelMonth = StartMonthValue
		SelYear = StartYearValue
		StartDate = DateTimeUtil.FormatDate(1,StartMonthValue,StartYearValue)
		EndDate = DateTimeUtil.FormatDate(1,EndMonthValue,EndYearValue)
		Dim SDate As New Date(StartYearValue,StartMonthValue,1)
		ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy",Session("LangID"),objCnn)
		
		Dim CheckDate As New DateTime(EndYearValue, EndMonthValue, 1, 0, 0, 0)
		CheckDate = DateAdd("d",-1,CheckDate)
		EndDate2 = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))
		
		Catch ex As Exception
			FoundError = True
		End Try
	ElseIf Radio_2.Checked = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(Request.Form("Doc_Day"),Request.Form("Doc_Month"),Request.Form("Doc_Year"))
		EndDate2 = DateTimeUtil.FormatDate(Request.Form("DocTo_Day"),Request.Form("DocTo_Month"),Request.Form("DocTo_Year"))
		Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))
		
		SelMonth = Request.Form("Doc_Month")
		SelYear = Request.Form("Doc_Year")
		
		If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + "Invalid Date" + "</td></tr></table>"
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
		EndDate2 = DateTimeUtil.FormatDate(Request.Form("DocDaily_Day"),Request.Form("DocDaily_Month"),Request.Form("DocDaily_Year"))
		Dim CheckDate As New DateTime(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"), 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))
		
		SelMonth = Request.Form("DocDaily_Month")
		SelYear = Request.Form("DocDaily_Year")

		If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + "Invalid Date" + "</td></tr></table>"
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
	Else
		DateFromValue = ""
		DateToValue = ""
		DailyDateValue = ""
	End If

	
	If Request.Form("DocumentTypeGroupID") < 0 Then
		FoundError = True
	End If	
	If FoundError = False Then
		
		Dim DocTypeName As String = "Sale Document"
		
		If Request.Form("DocumentTypeGroupID") = "1000" or Request.Form("DocumentTypeGroupID") = "1001,1007,1008" Then
			DocTypeName = "Transfer Document"
		ElseIf Request.Form("DocumentTypeGroupID") = "1003" Then
			DocTypeName = "Return Document"
		End If
		ResultSearchText.InnerHtml = Request.Form("ReportName") + " - " + DocTypeName + " (" + ReportDate + ")"
		Dim displayTable As New DataTable()
		
		ShowPrint.Visible = True
		Dim ShopList As String
		Dim i As Integer
		Dim ShopData As DataTable
		Dim HeaderString As String = ""

		ShopData = objDB.List("select * from ProductLevel where Deleted=0 AND IsInv=1 AND ProductLevelID>1 order by ProductLevelOrder,ProductLevelName", objCnn)
		For i = 0 To ShopData.Rows.Count - 1
			If i = 0 Then
				ShopList = ShopData.Rows(i)("ProductLevelID").ToString
			Else
				ShopList += "," + ShopData.Rows(i)("ProductLevelID").ToString
			End If
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + ShopData.Rows(i)("ProductLevelName") + "</td>"
		Next
		
		Dim MGroupList As String = ""
		Dim MGroup As DataTable = objDB.List("select * from MaterialGroup where MaterialGroupType=1 AND Deleted=0",objCnn)
		For i = 0 To MGroup.Rows.Count - 1
			If i = 0 Then
				MGroupList = MGroup.Rows(i)("MaterialGroupID").ToString
			Else
				MGroupList += "," + MGroup.Rows(i)("MaterialGroupID").ToString
			End If
		Next
		ExtraHeader.InnerHtml = HeaderString
		
		Dim outputString As StringBuilder = New StringBuilder
		Dim bgColor As String = "White"
		Dim TextClass As String = "smallText"
		Dim j As Integer
		Dim k As Integer
		Dim ViewOption As Integer = 1
		Dim TableNameString As String = "ReportBakery_" + Session.SessionID
		Dim errorText As String
		Dim BkType As String
		Dim Summary(ShopData.Rows.Count) As Double
		Dim SumEach As Double
		Dim DataVal As Double
		Application.Lock()
		Dim Result As Boolean
		Dim TestTime As String
		TestTime += "<br>" + DateTimeUtil.CurrentDateTime
		If Request.Form("DocumentTypeGroupID") = 1000 Then
			Result = rpt.CreateTableForSummaryMaterialAmountByShopDisplayToInvIDFilterAtProductLevelID(getCnn, objCnn, Request.Form("DocumentTypeGroupID").ToString, StartDate, EndDate2, "2", Session("StaffID").ToString, "1", ShopList, MGroupList, TableNameString, "Shop_", 0, errorText)
		Else
			Result = rpt.CreateTableForSummaryMaterialAmountByShop(getCnn, objCnn, Request.Form("DocumentTypeGroupID").ToString, StartDate, EndDate2, "2", Session("StaffID").ToString, ShopList, MGroupList, TableNameString, "Shop_", 0, errorText)
		End If
		TestTime += "<br>" + DateTimeUtil.CurrentDateTime
		Dim ArrayValue() As String
            
		If Result = False Then
			errorMsg.InnerHtml = errorText
		Else
			objDB.sqlExecute("ALTER TABLE " + TableNameString + " ADD BakeryType int NOT NULL Default '0'", objCnn)
			Dim dtTable As DataTable = objDB.List("select * from " + TableNameString + " a,MaterialDept b where a.MaterialDeptID=b.MaterialDeptID", objCnn)
			For i = 0 To dtTable.Rows.Count - 1
				ArrayValue = dtTable.Rows(i)("MaterialDeptName").Split(" "c)
				BkType = 0
				If ArrayValue.Length > 0 Then
					If IsNumeric(ArrayValue(ArrayValue.Length-1)) Then
						BkType = ArrayValue(ArrayValue.Length-1)
					End If
				End If
				'BkType = Trim(Replace(dtTable.Rows(i)("MaterialDeptName"),"BAKERY",""))
				objDB.sqlExecute("update " + TableNameString + " set BakeryType=" + BkType + " where MaterialID=" + dtTable.Rows(i)("MaterialID").ToString, objCnn)
			Next
			dtTable = objDB.List("select count(*),BakeryType from " + TableNameString + " group by BakeryType order by BakeryType", objCnn)
			TestTime += "<br>" + DateTimeUtil.CurrentDateTime
			For k = 0 To dtTable.Rows.Count - 1
				displayTable = objDB.List("select * from " + TableNameString + " where BakeryType=" + dtTable.Rows(k)("BakeryType").ToString, objCnn)
				
				For j = 0 To ShopData.Rows.Count - 1 
					Summary(j) = 0
				Next
				SumEach = 0
				If k mod 2 = 0 Then
					bgColor = "white"
				Else
					bgColor = GlobalParam.GrayBGColor
				End If
				For i = 0 To displayTable.Rows.Count - 1
				  
				   outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
				   If i = 0 Then
				   		outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>Bakery " + dtTable.Rows(k)("BakeryType").ToString + "</td>")
				   Else
				   		outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + "" + "</td>")
				   End If
				   outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + displayTable.Rows(i)("MaterialName") + "</td>")
				   outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + displayTable.Rows(i)("UnitSmallName") + "</td>")  
				   For j = 0 To ShopData.Rows.Count - 1 
						'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(displayTable.Rows(i)("Shop_" + ShopData.Rows(j)("ProductLevelID").ToString), "##,##0") + "</td>")  
						outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """><a class=""smalltext"" href=""JavaScript: newWindow = window.open( 'report_material_doctype.aspx?MaterialID=" + displayTable.Rows(i)("MaterialID").ToString + "&StartDate=" & Replace(StartDate,"'","\'") & "&EndDate=" & Replace(EndDate,"'","\'") & "&ProductLevelID=" & ShopData.Rows(j)("ProductLevelID").ToString & "&ReportDate=" & ReportDate & "&DocumentTypeID=" & Request.Form("DocumentTypeGroupID").ToString + "', '', 'width=800,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(Math.ABS(displayTable.Rows(i)("Shop_" + ShopData.Rows(j)("ProductLevelID").ToString)), "##,##0") + "</a></td>") 
						Summary(j) += displayTable.Rows(i)("Shop_" + ShopData.Rows(j)("ProductLevelID").ToString)
				   Next 
				   outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(Math.ABS(displayTable.Rows(i)("SummaryAmount")), "##,##0") + "</td>")    
				   SumEach += displayTable.Rows(i)("SummaryAmount")
				   outputString = outputString.Append("</tr>")   
				   
				Next
				outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
				outputString = outputString.Append("<td align=""right"" colspan=""3"" class=""" + TextClass + """>" + "Summary" + "</td>")   
			    For j = 0 To ShopData.Rows.Count - 1 
					outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(Math.ABS(Summary(j)), "##,##0") + "</td>")    
			    Next   
			    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(Math.ABS(SumEach), "##,##0") + "</td>")       
			    outputString = outputString.Append("</tr>")  
			Next
			TestTime += "<br>" + DateTimeUtil.CurrentDateTime
			ResultText.InnerHtml = outputString.ToString
			showHeader.Visible = True
			'errorMsg.InnerHtml = TestTime
			objDB.sqlExecute("Drop Table If Exists " + TableNameString, objCnn)
		End If
		Application.UnLock()

	End If
	
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub
</script>
</body>
</html>
