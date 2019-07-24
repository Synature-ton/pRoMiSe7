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
<title>Void Bill Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Void Bill Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
				<td><span id="ReceiptTypeText" runat="server"></span></td>
			</tr>
			<tr>
				<td><span id="ShopText" runat="server"></span></td>
			</tr>
			<tr>
				<td><asp:radiobutton ID="Radio_11" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
			<tr>
				<td><asp:radiobutton ID="Radio_12" GroupName="Group2" CssClass="text" runat="server" /></td>
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
		<tr><td>&nbsp;</td>
			<td colspan="4"><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
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
<div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>
<span id="showHeader" runat="server">
<span id="startTable" runat="server"></span>
	
	<tr>
    	<span id="TableHeaderText" runat="server"></span>
		<span id="ExtraHeader" runat="server"></span>
	</tr>
	
	<div id="ResultText" runat="server"></div>
</table>
</span></td></tr>
</table></span>
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
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer = 8
		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_Void") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		showHeader.Visible = False
		
		TableHeaderText.InnerHtml = ""
		
		Dim i As Integer
		
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
		LangList.Text = LangListText
		
		Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
		If LangDefault.Rows.Count >= 4 Then
			PrintText.Text = LangDefault.Rows(0)(LangText)
			Export.Text = LangDefault.Rows(1)(LangText)
			SubmitForm.Text = LangDefault.Rows(3)(LangText)
		End If
		
		Dim LangData2 As DataTable = getProp.GetLangData(PageID,2,-1,Request)
		
		StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		
		Dim HeaderString As String = ""

		ResultText.InnerHtml = ""
		ResultSearchText.InnerHtml = ""
		errorMsg.InnerHtml = ""
		Dim SMData As DataTable = objDB.List("select * from SaleMode where Deleted=0 order by SaleModeID", objCnn)
		
		Dim SM As Boolean = False
		If SMData.Rows.Count > 0 Then
			SM = True
		End If
		
		Dim FromUrl As Boolean = False
		If Not Request.QueryString("ShopID") is Nothing AND Trim(Request.QueryString("StartDate")) <> "" Then
			Dim AllShop As Boolean = getReport.CheckAllShop(Request.QueryString("ShopID"), objCnn)
			If AllShop = True Then 
				HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(7)(LangText) + "</td>"
			End If
			GenVoidReport(Request.QueryString("ShopID"),Request.QueryString("StartDate"),Request.QueryString("EndDate"),Request.QueryString("ReceiptSaleType"),objCnn)
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(0)(LangText) + "</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(1)(LangText) + "</td>"
			If SM = True Then
				HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Sale Mode" + "</td>"
			End If
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(2)(LangText) + "</td>"
			FromUrl = True
		Else
			If Radio_11.Checked = True Then
				HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(0)(LangText) + "</td>"
				HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(1)(LangText) + "</td>"
				If SM = True Then
					HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Sale Mode" + "</td>"
				End If
				HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(2)(LangText) + "</td>"
			ElseIf Radio_12.Checked = True Then
				HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(2)(LangText) + "</td>"
				HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(0)(LangText) + "</td>"
				HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(1)(LangText) + "</td>"	
			End If
			
		End If
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(3)(LangText) + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(5)(LangText) + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(6)(LangText) + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(4)(LangText) + "</td>"
		
		TableHeaderText.InnerHtml = HeaderString
		
		DocumentToDateParam.InnerHtml = LangDefault.Rows(22)(LangText)
			
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
		
		Radio_11.Text = LangData2.Rows(8)(LangText)
		Radio_12.Text = LangData2.Rows(9)(LangText)
				
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
			Radio_11.Checked = True
		End If

		Dim ShopIDValue As String = "0"
		If Not Request.Form("ShopID") is Nothing Then
			ShopIDValue = Request.Form("ShopID").ToString
		Else If Not Request.QueryString("ShopID") is Nothing Then
			ShopIDValue = Request.QueryString("ShopID").ToString
		End If
			
		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		Dim Multiple As Boolean
		
		Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
		If ShopData.Rows.Count > 0 Then

			outputString = "<select name=""ShopID"">"
			If ShopData.Rows.Count > 1 Then
				If Not Page.IsPostBack Then 
					FormSelected = "selected"
				ElseIf ShopIDValue = 0 Then
					FormSelected = "selected"
				Else
					FormSelected = ""
				End If
				outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & "--- All Shops ---"
				Multiple = True
			End If
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
			Next
			outputString += "</select>"
			ShopText.InnerHtml = outputString
			ShowShop.Visible = True
		Else
			ShowShop.Visible = False
		End If
		
		'Load Receipt Type Combo
		Dim ReceiptTypeValue As String = "1"
		If IsNumeric(Request.Form("ReceiptType")) Then
			ReceiptTypeValue = Request.Form("ReceiptType").ToString
		Else If IsNumeric(Request.QueryString("ReceiptType"))
			ReceiptTypeValue = Request.QueryString("ReceiptType").ToString
		End If
		Select Case Cint(ReceiptTypeValue)
			Case > 3
				ReceiptTypeValue = "1"
			Case <= 0 
				ReceiptTypeValue = "1"
		End Select 
		outputString = "<select name=""ReceiptType"">"
		If ReceiptTypeValue = "1" Then
			FormSelected = "selected"
		Else
			FormSelected = ""
		End If
		outputString += "<option value=""" & "1" & """ " & FormSelected & ">" & "Sale"
		If ReceiptTypeValue = "2" Then
			FormSelected = "selected"
		Else
			FormSelected = ""
		End If
		outputString += "<option value=""" & "2" & """ " & FormSelected & ">" & "Non Sale"
		If ReceiptTypeValue = "3" Then
			FormSelected = "selected"
		Else
			FormSelected = ""
		End If
		outputString += "<option value=""" & "3" & """ " & FormSelected & ">" & "Sale + Non Sale"
		ReceiptTypeText.InnerHtml = outputString	
			
		If FromUrl = True Then ShowShop.Visible = False
				
		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
	  
	Else
		showPage.Visible = False
		errorMsg.InnerHtml = "Access Denied"
	End If
End Sub

Sub DoSearch(Source As Object, E As EventArgs)
	errorMsg.InnerHtml = ""
	Dim FoundError As Boolean
	FoundError = False
	Session("ReportResult") = ""
	Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
	Dim LangText As String = "lang" + Session("LangID").ToString
	Dim LangData2 As DataTable = getProp.GetLangData(PageID,2,-1,Request)
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
	Dim StartMonth As Integer
	Dim StartYear As Integer
	Dim StartDay As Integer
	Dim EndDay As Integer
	Dim EndMonth As Integer
	Dim EndYear As Integer
			
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
		
		Dim EDate As New Date(EndYearValue,EndMonthValue,1)
		Dim EnDate As DateTime = DateAdd(DateInterval.Day, -1, EDate)
		
		StartMonth = StartMonthValue
		StartYear = StartYearValue
		StartDay = 1
		EndMonth = StartMonthValue
		EndYear = StartYearValue
		EndDay = EnDate.Day
		
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
			ReportDate = DateTimeUtil.FormatDateTime(SDate1, "d MMMM yyyy",Session("LangID"),objCnn) + " - " + ReportDate = DateTimeUtil.FormatDateTime(EDate1, "d MMMM yyyy",Session("LangID"),objCnn)
		End If
		
		StartMonth = Request.Form("Doc_Month")
		StartYear = Request.Form("Doc_Year")
		StartDay = Request.Form("Doc_Day")
		EndDay = Request.Form("DocTo_Day")
		EndMonth = Request.Form("DocTo_Month")
		EndYear = Request.Form("DocTo_Year")
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
			ReportDate = DateTimeUtil.FormatDateTime(SDate2, "d MMMM yyyy",Session("LangID"),objCnn)
		End If
		
		StartMonth = Request.Form("DocDaily_Month")
		StartYear = Request.Form("DocDaily_Year")
		StartDay = Request.Form("DocDaily_Day")
		EndMonth = Request.Form("DocDaily_Month")
		EndYear = Request.Form("DocDaily_Year")
		EndDay = Request.Form("DocDaily_Day")
		
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
		
		ShowHeader.Visible = True
		ShowPrint.Visible = True
		
		Dim ViewOption As Integer
		If Radio_11.Checked = True Then
			ViewOption = 1
		ElseIf Radio_12.Checked = True Then
			ViewOption = 2
		Else
			ViewOption = 3 
		End If
		Dim strDisplaySaleType as String 
		Dim receiptSaleType as Integer
		If Not IsNumeric(Request.Form("ReceiptType")) Then
			Request.Form("ReceiptType") = 1
		End If 
		receiptSaleType = Request.Form("ReceiptType") 
		
		'Application.Lock()
		Dim dtTable As DataTable = VoidBillReports(ViewOption,receiptSaleType, StartDate, EndDate, Request.Form("ShopID"), 0, 0, Session("LangID"), objCnn)
		
		Select Case receiptSaleType
			Case 2
				strDisplaySaleType = " - Non Sale"
			Case 3
				strDisplaySaleType = " - Sale + Non Sale"
			Case Else
				strDisplaySaleType = ""
		End Select 
		
		ResultSearchText.InnerHtml = LangData2.Rows(10)(LangText) + " " + SelShopName.Value + " (" + ReportDate + ")" & strDisplaySaleType
		'Application.UnLock()
		If Request.Form("ShopID") = 0 Then
			DisplayOutputAll(receiptSaleType, ViewOption,Request.Form("ShopID"),dtTable,StartDate,EndDate,LangData2,LangText,StartDay,StartMonth,StartYear,EndDay,EndMonth,EndYear,objCnn)
		Else
			DisplayOutput(ViewOption,Request.Form("ShopID"),dtTable,StartDate,EndDate,LangData2,LangText,objCnn)
		End If
		
		Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"
	End If
	
End Sub

Public Function DisplayOutputAll(receiptSaleNonSaleType as integer, ByVal ViewOption As Integer, ByVal ShopID As String, ByVal dtTable As DataTable, ByVal StartDate As String, ByVal EndDate As String, ByVal LangData2 As DataTable, ByVal LangText As String, ByVal StartDay As Integer, ByVal StartMonth As Integer, ByVal StartYear As Integer, ByVal EndDay As Integer, ByVal EndMonth As Integer, ByVal EndYear As Integer, ByVal objCnn As MySqlConnection) As String
	Dim FormatData As DataTable = Util.FormatParam(FormatObject,Session("LangID"),objCnn)
	Dim ci As New CultureInfo(FormatObject.CultureString)
	Dim i, j As Integer
	Dim StDate As New DateTime(StartYear, StartMonth, StartDay, 0, 0, 0)
	Dim EnDate As New DateTime(EndYear, EndMonth, EndDay, 0, 0, 0)
	Dim CurrD As DateTime = StDate
	Dim HeaderString As String = ""
	Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
	HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Date/Branch" + "</td>"
	For i = 0 to ShopData.Rows.Count - 1
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + ShopData.Rows(i)("ProductLevelCode").ToString + "</td>"
	Next
	HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Total" + "</td>"
	TableHeaderText.InnerHtml = HeaderString
	Dim DateString As String
	Dim foundRows() As DataRow
    Dim expression As String
	Dim outputString As StringBuilder = New StringBuilder
	Dim TextClass As String = "smallText"
	Dim SumTotal As Double 
	Dim GrandTotal As Double
	Dim Summary(ShopData.Rows.Count-1) As Double
	Dim SDate,EDate As String
	While (CurrD <= EnDate)   
		DateString = CurrD.ToString("yyyyMMdd", InvC)    
		SDate = "{ d '" + CurrD.ToString("yyyy-MM-dd", InvC) + "'}"
		
		outputString = outputString.Append("<tr>") 
		outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + DateTimeUtil.FormatDateTime(CurrD, "DateOnly", Session("LangID"), objCnn) + "</td>")
		SumTotal = 0
		CurrD = CurrD.AddDays(1)
		EDate = "{ d '" + CurrD.ToString("yyyy-MM-dd", InvC) + "'}"
		For i = 0 To ShopData.Rows.Count - 1
			expression = "DateValue = '" + DateString + "' AND ShopID=" + ShopData.Rows(i)("ProductLevelID").ToString
            foundRows = dtTable.Select(expression)
			If foundRows.GetUpperBound(0) >= 0 Then
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_void_sushitei.aspx?ShopID=" + ShopData.Rows(i)("ProductLevelID").ToString + "&StartDate=" + Replace(SDate, "'", "\'") + "&EndDate=" + Replace(EDate, "'", "\'") & "&ReceiptSaleType=" & receiptSaleNonSaleType & "', '', 'width=900,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + CDbl(foundRows(0)("SalePrice")).ToString(FormatObject.CurrencyFormat, ci) + "</a></td>")
				SumTotal += foundRows(0)("SalePrice")
				Summary(i) += foundRows(0)("SalePrice")
				GrandTotal += foundRows(0)("SalePrice")
			Else
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + "-" + "</td>")
			End If
		Next
		outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SumTotal).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
		outputString = outputString.Append("</tr>") 

	End While
	outputString = outputString.Append("<tr>") 
	outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + "Total" + "</td>")
	For i = 0 To ShopData.Rows.Count - 1
		outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_void_sushitei.aspx?ShopID=" + ShopData.Rows(i)("ProductLevelID").ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") & "&ReceiptSaleType=" & receiptSaleNonSaleType & "', '', 'width=900,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + CDbl(Summary(i)).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
	Next
	outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(GrandTotal).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
	outputString = outputString.Append("</tr>") 
	ResultText.InnerHtml = outputString.ToString
	
End Function

Public Function GenVoidReport(ByVal ShopID As String, ByVal StartDate As String, ByVal EndDate As String, receiptSaleNonSaleType as integer, ByVal objCnn As MySqlConnection) As String
	Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
	Dim LangText As String = "lang" + Session("LangID").ToString
	Dim LangData2 As DataTable = getProp.GetLangData(PageID,2,-1,Request)
	Dim LangData As DataTable = getProp.GetLangData(PageID,1,-1,Request)
	ShowHeader.Visible = True
	ShowShop.Visible = False
	ShowPrint.Visible = True
	LangList.Text = ""
	LangText0.Text =  LangData.Rows(0)(LangText)
	
	Dim dtTable As DataTable = VoidBillReports(1,receiptSaleNonSaleType, StartDate, EndDate, ShopID, 0, 0, Session("LangID"), objCnn)
	DisplayOutput(1,ShopID,dtTable,StartDate,EndDate,LangData2,LangText,objCnn)
	
	Dim ReportDateVal As DataTable = objDB.List("select " + Request.QueryString("StartDate").ToString + " AS StDate," + Request.QueryString("EndDate") + " As EndDate", objCnn)
	Dim CheckDate As New DateTime(Year(ReportDateVal.Rows(0)("EndDate")), Month(ReportDateVal.Rows(0)("EndDate")), Day(ReportDateVal.Rows(0)("EndDate")), 0, 0, 0)
	CheckDate = DateAdd("d",-1,CheckDate)
	Dim SDate2 As New Date(Year(ReportDateVal.Rows(0)("StDate")), Month(ReportDateVal.Rows(0)("StDate")), Day(ReportDateVal.Rows(0)("StDate")))
	 
	Dim ReportDate As String = DateTimeUtil.FormatDateTime(SDate2, "d MMMM yyyy",Session("LangID"),objCnn) + " - " + DateTimeUtil.FormatDateTime(CheckDate, "d MMMM yyyy",Session("LangID"),objCnn)
	Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel where ProductLevelID IN (" + ShopID.ToString + ")", objCnn)
	Dim AllShop As Boolean = getReport.CheckAllShop(ShopID,objCnn)
	If AllShop = True Then
		ResultSearchText.InnerHtml = LangData2.Rows(10)(LangText) + " " + LangDefault.Rows(23)(LangText) + " " + " (" + ReportDate + ")"
	Else
		ResultSearchText.InnerHtml = LangData2.Rows(10)(LangText) + " " + ShopInfo.Rows(0)("ProductLevelName") + " (" + ReportDate + ")"
	End If
	
	If LangDefault.Rows.Count >= 3 Then
		CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(NOW(), "DateAndTime",Session("LangID"),objCnn)
	End If
	
	Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"
	
	'errorMsg.InnerHtml = "select " + Request.QueryString("StartDate").ToString + " AS StDate" + "<P>" + StartDate + "::" + EndDate + "::" + ShopID.ToString + "::" + dtTable.Rows.Count.ToString
End Function

Public Function DisplayOutput(ByVal ViewOption As Integer, ByVal ShopID As String, ByVal dtTable As DataTable, ByVal StartDate As String, ByVal EndDate As String, ByVal LangData2 As DataTable, ByVal LangText As String, ByVal objCnn As MySqlConnection) As String
	Dim FormatData As DataTable = Util.FormatParam(FormatObject,Session("LangID"),objCnn)
	Dim ci As New CultureInfo(FormatObject.CultureString)
		Dim outputString As String = ""
		Dim grandTotal As Double = 0
		Dim AdditionalHeaderText, HText, RText, GlobalFTHeaderText As String
		Dim i As Integer
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

		Dim ReceiptHeaderData As DataTable
		ReceiptHeaderData = getInfo.GetDocType(1, 0, 8, 1, objCnn)

		If ReceiptHeaderData.Rows.Count > 0 Then
			If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
				AdditionalHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
			End If
		End If
		
		ReceiptHeaderData = getInfo.GetDocType(1, 0, 11, 1, objCnn)
		If ReceiptHeaderData.Rows.Count > 0 Then
			If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
				GlobalFTHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
			End If
		End If
		
		Dim TextClass As String
		Dim TotalProductDiscount As Double = 0
		Dim TotalSale As Double
		Dim grandTotalRetailPrice As Double = 0
		Dim grandTotalDiscount As Double = 0
		Dim grandTotalServiceCharge As Double = 0
		Dim grandTotalBeforeVAT As Double = 0
		Dim grandTotalVAT As Double = 0
		Dim grandTotalAfterVAT As Double = 0
		
		Dim FullText As String
		Dim VoidText As String
		
		Dim DigitRunning As Integer
		Dim ChkRunning As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramtypeID = 1 AND PropertyID = 29 AND KeyID = 1", objCnn)
		If ChkRunning.Rows.Count > 0 Then
			If ChkRunning.Rows(0)("PropertyValue") > 5 Then
				DigitRunning = ChkRunning.Rows(0)("PropertyValue")
			End If
		End If
		
		Dim SMData As DataTable = objDB.List("select * from SaleMode where Deleted=0 order by SaleModeID", objCnn)
		
		Dim SM As Boolean = False
		If SMData.Rows.Count > 0 Then
			SM = True
		End If

		For i = 0 To dtTable.Rows.Count - 1
			TotalProductDiscount = dtTable.Rows(i)("ReceiptDiscount")
			TotalSale = dtTable.Rows(i)("ReceiptSalePrice")
			TextClass = "redText"
			grandTotalRetailPrice += dtTable.Rows(i)("ReceiptProductRetailPrice")
			grandTotalDiscount += TotalProductDiscount
			grandTotalServiceCharge += dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT")
			grandTotalBeforeVAT += TotalSale - dtTable.Rows(i)("TransactionVAT")
			grandTotalVAT += dtTable.Rows(i)("TransactionVAT")
			grandTotalAfterVAT += TotalSale

			outputString += "<tr bgColor=""" + "white" + """>"
			If ShopID = 0 Then
				outputString += "<td align=""left"" class=""" + TextClass + """>" + dtTable.Rows(i)("ProductLevelName") + "</td>"
			End If
			HText = ""
			If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
				If DigitRunning > 5 Then
					HText = "Running," + DigitRunning.ToString
				Else
					If Not IsDBNull(dtTable.Rows(i)("DocumentTypeHeader")) Then
						HText = dtTable.Rows(i)("DocumentTypeHeader")
					End If
				End If
			ElseIf DigitRunning > 5 Then
				HText = "Running," + DigitRunning.ToString
			Else
				HText = AdditionalHeaderText
			End If
			If IsDBNull(dtTable.Rows(i)("ReceiptID")) Or IsDBNull(dtTable.Rows(i)("ReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("ReceiptYear")) Then
				RText = "-"
			Else
				RText = FormatDocNumber.GetReceiptHeader(HText, dtTable.Rows(i)("ReceiptYear"), dtTable.Rows(i)("ReceiptMonth"), dtTable.Rows(i)("ReceiptID"))
			End If
			
			HText = ""
			If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
				If Not IsDBNull(dtTable.Rows(i)("DocTypeHeader")) Then
					HText = dtTable.Rows(i)("DocTypeHeader")
				End If
			Else
				HText = GlobalFTHeaderText
			End If
			If IsDBNull(dtTable.Rows(i)("FReceiptYear")) Or IsDBNull(dtTable.Rows(i)("FReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("FReceiptID")) Then
				FullText = ""
			Else
				FullText = "<br>" + FormatDocNumber.GetReceiptHeader(HText, dtTable.Rows(i)("FReceiptYear"), dtTable.Rows(i)("FReceiptMonth"), dtTable.Rows(i)("FReceiptID"))

			End If
			
			If ViewOption = 1 Then
				outputString += "<td align=""left"" class=""" + TextClass + """>" + DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly", Session("LangID"),objCnn) + "</td>"
				If RText <> "-" Then
					outputString += "<td align=""left"" class=""" + TextClass + """><a href=""JavaScript: newWindow = window.open( 'BillDetails.aspx?ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "&ShopID=" + ShopID.ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & RText & "</a>" & FullText + "</td>"
				Else
					outputString += "<td align=""left"" class=""" + TextClass + """>" & RText & FullText & "</td>"
				End If
				If SM = True Then
					If Not IsDBNull(dtTable.Rows(i)("SaleModeName")) Then
						outputString += "<td align=""center"" class=""" + TextClass + """>" + dtTable.Rows(i)("SaleModeName") + "</td>"
					Else
						outputString += "<td align=""center"" class=""" + TextClass + """>" + "-" + "</td>"
					End If
				End If
				If Not IsDBNull(dtTable.Rows(i)("VoidStaffName")) Then
					outputString += "<td align=""left"" class=""" + TextClass + """>" + dtTable.Rows(i)("VoidStaffName") + "</td>"
				Else
					outputString += "<td align=""left"" class=""" + TextClass + """>" + "-" + "</td>"
				End If
			Else
				If Not IsDBNull(dtTable.Rows(i)("VoidStaffName")) Then
					outputString += "<td align=""left"" class=""" + TextClass + """>" + dtTable.Rows(i)("VoidStaffName") + "</td>"
				Else
					outputString += "<td align=""left"" class=""" + TextClass + """>" + "-" + "</td>"
				End If
				outputString += "<td align=""left"" class=""" + TextClass + """>" + DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly") + "</td>"
				If RText <> "-" Then
					outputString += "<td align=""left"" class=""" + TextClass + """><a href=""JavaScript: newWindow = window.open( 'BillDetails.aspx?ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "&ShopID=" + ShopID.ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & RText & "</a></td>"
				Else
					outputString += "<td align=""left"" class=""" + TextClass + """>" & RText & "</td>"
				End If
			End If
			
			If Not IsDBNull(dtTable.Rows(i)("MemberName")) Then
				outputString += "<td align=""left"" class=""" + TextClass + """>" + dtTable.Rows(i)("MemberName") + "</td>"
			Else
				outputString += "<td align=""left"" class=""" + TextClass + """>" + "-" + "</td>"
			End If
			
			If Not IsDBNull(dtTable.Rows(i)("VoidTime")) Then
				outputString += "<td align=""left"" class=""" + TextClass + """>" + DateTimeUtil.FormatDateTime(dtTable.Rows(i)("VoidTime"), "DateAndTime", Session("LangID"), objCnn) + "</td>"
			Else
				outputString += "<td align=""left"" class=""" + TextClass + """>" + "-" + "</td>"
			End If
			
			VoidText = ""
			If Not IsDBNull(dtTable.Rows(i)("VoidReason")) Then
				VoidText = dtTable.Rows(i)("VoidReason")
			End If
			
			If Not IsDBNull(dtTable.Rows(i)("VoidReasonText")) Then
				If Trim(VoidText) = "" Then
					VoidText = dtTable.Rows(i)("VoidReasonText")
				Else
					VoidText = VoidText + "," + dtTable.Rows(i)("VoidReasonText")
				End If
			End If
			
			If Not IsDBNull(dtTable.Rows(i)("VoidReason")) Then
				outputString += "<td align=""left"" class=""" + TextClass + """>" + VoidText + "</td>"
			Else
				outputString += "<td align=""left"" class=""" + TextClass + """>" + "-" + "</td>"
			End If
			outputString += "<td align=""right"" class=""" + TextClass + """>" + Format(TotalSale, FormatData.Rows(0)("CurrencyFormat")) + "</td>"
			outputString += "</tr>"
		Next
		outputString += "<tr bgColor=""" + "#ebebeb" + """>"
		If ShopID = 0 Then
			outputString += "<td colspan=""7"" align=""right"" class=""text"">" +  LangData2.Rows(11)(LangText) + "</td>"
		Else
			If SM = True Then
				outputString += "<td colspan=""7"" align=""right"" class=""text"">" +  LangData2.Rows(11)(LangText) + "</td>"
			Else
				outputString += "<td colspan=""6"" align=""right"" class=""text"">" +  LangData2.Rows(11)(LangText) + "</td>"
			End If
		End If
		outputString += "<td align=""right"" class=""text"">" + Format(grandTotalAfterVAT, FormatData.Rows(0)("CurrencyFormat")) + "</td>"
		outputString += "</tr>"
		ResultText.InnerHtml = outputString

End Function

Public Function VoidBillReports(ByVal ViewOption As Integer, receiptSaleNonSaleType As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal ShopID As String, ByVal TransactionID As Integer, ByVal ComputerID As Integer, ByVal LangID As Integer, ByVal objCnn As MySqlConnection) As DataTable

        Dim sqlStatement, sqlStatement1, WhereString As String
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

        'Dim AllShop As Boolean = getReport.CheckAllShop(ShopID, objCnn)
        'If AllShop = False Then
		If ShopID <> "0" Then
            AdditionalQuery += " AND a.ShopID IN (" + ShopID.ToString + ")"
        End If

        If StartDate <> "" And EndDate <> "" Then
            AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
        End If

		Select Case receiptSaleNonSaleType
			Case 2				'Non Sale
				AdditionalQuery += " AND a.TransactionStatusID IN (12,13) AND a.DocType NOT IN (4,8) "
			Case 3				'Sale + Non Sale
				AdditionalQuery += " AND a.TransactionStatusID IN (5,8,12,13) "
				
			Case Else			'Sale
				AdditionalQuery += " AND a.TransactionStatusID IN (5,8) AND a.DocType IN (4,8) "
			
		End Select
		
        Dim OrderBy As String = " a.SaleDate,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"
        If ShopID = 0 Then
            OrderBy = " pl.ProductLevelCode,a.SaleDate,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"
        End If

        If ViewOption = 2 Then
            OrderBy = " s.StaffID,a.SaleDate,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"
            If ShopID = 0 Then
                OrderBy = " pl.ProductLevelCode,s.StaffID,a.SaleDate,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"
            End If
        End If
		
		If ShopID = "0" Then
			sqlStatement = "select ShopID,ShopCode,ShopName,SaleDate,DATE_FORMAT(SaleDate,'%Y%m%d') As DateValue,SUM(SalePrice+TransactionExcludeVAT+ServiceCharge+ServiceChargeVAT) As SalePrice from summary_tranreport a where 0=0 " & AdditionalQuery & " group by ShopID,ShopCode,ShopName,SaleDate"
			GetData = objDB.List(sqlStatement, objCnn)
		Else
			objDB.sqlExecute("DROP TABLE IF EXISTS DummyDocType", objCnn)
			objDB.sqlExecute("create table DummyDocType (DocumentTypeID int, ComputerID int, DocumentTypeHeader varchar(50))", objCnn)
			objDB.sqlExecute("insert into DummyDocType select DocumentTypeID,ComputerID,DocumentTypeHeader from DocumentType where DocumentTypeID=11 AND langid=" + LangID.ToString, objCnn)
	
			sqlStatement = "select a.*,sm.SaleModeName,pl.ProductLevelCode,pl.ProductLevelName,a.VoidReason,aaa.VoidReasonText,dt.DocumentTypeHeader,ft.ReceiptID AS FReceiptID,ft.ReceiptMonth AS FReceiptMonth,ft.ReceiptYear AS FReceiptYear,dt1.DocumentTypeHeader AS DocTypeHeader,CONCAT(s.StaffFirstName, ' ', s.StaffLastName) AS VoidStaffName, CONCAT(m.MemberFirstName,' ',m.MemberLastName) AS MemberName " & _
			" from ordertransaction a left outer join ProductLevel pl ON a.ShopID=pl.ProductLevelID left outer join Staffs s ON a.VoidStaffID=s.StaffID left outer join Members m ON a.MemberDiscountID=m.MemberID left outer join DocumentType dt ON a.DocType=dt.DocumentTypeID AND (a.CloseComputerID=dt.ComputerID OR a.ShopID = dt.ShopID) left outer join OrderTransactionFullTaxInvoice ft ON a.TransactionID=ft.TransactionID AND a.ComputerID=ft.ComputerID left outer join DummyDocType dt1 ON ft.DocType=dt1.DocumentTypeID AND dt1.ComputerID=ft.CloseComputerID left outer join (select TransactionID,ComputerID,group_concat(ReasonText) As VoidReasonText from reasonorderdetail aa left outer join reasontext bb ON aa.ReasonID=bb.ReasonID where FrontFunctionID=22 group by TransactionID,ComputerID) aaa ON a.TransactionID=aaa.TransactionID AND a.ComputerID=aaa.ComputerID left outer join SaleMode sm ON a.SaleMode=sm.SaleModeID " & _
			"where a.ReceiptID > 0 AND dt.LangID=" + LangID.ToString + AdditionalQuery + " Order By " + OrderBy
	
			GetData = objDB.List(sqlStatement, objCnn)
			objDB.sqlExecute("DROP TABLE IF EXISTS DummyDocType", objCnn)
		End If
        Return GetData

    End Function

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "VoidData" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
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
