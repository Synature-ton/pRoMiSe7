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
<title>Full Tax Invoice Reports</title>
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
<div class="noprint">
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
</div>
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
			<tr>
				<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
			</tr>
			
		</table></td>
	<td>
	<table>
		<tr>
			<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
			<td colspan="4"><table cellpadding="0" cellspacing="0"><tr><td><synature:date id="DailyDate" runat="server" /></td><td>&nbsp;&nbsp;</td><td><span id="ItemNameText" class="text" runat="server"></span>&nbsp;<asp:TextBox ID="ItemNameVal" runat="server"></asp:TextBox></td></tr></table></td>
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
</div>
<div id="showResults" runat="server">
<table width="100%">
<div class="noprint">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr></div>
</table>
<span id="MyTable">
<table width="100%">
<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr>
	<td width="100%">
	<table width="100%">
		<tr>
			<td valign="top"><span id="CompanyInfoText1" runat="server"></span></td>
			<td align="right" valign="top"><span id="CompanyInfoText2" runat="server"></span></td>
		</tr>
	</table>
	</td>
</tr>
<tr><td>
	<asp:DataGrid ID="Results" AutoGenerateColumns="false" CellPadding="3" CssClass="smallText" HeaderStyle-BackColor="#507093" HeaderStyle-CssClass="smallTdHeader" HeaderStyle-HorizontalAlign="center" AllowPaging="false" OnPageIndexChanged="ChangeGridPage" Width="100%" OnItemDataBound="Results_ItemDataBound" runat="server">
		<columns>
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="#"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" ItemStyle-CssClass="smallText" DataField="Date"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="FullTaxInvoice"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="CustomerName"></asp:BoundColumn> 
            <asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="CustomerTaxID"></asp:BoundColumn> 
            <asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="CustomerCompany"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="ItemName"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" ItemStyle-CssClass="smallText" DataField="PriceBeforeVAT"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" ItemStyle-CssClass="smallText" DataField="VAT"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" ItemStyle-CssClass="smallText" DataField="SubTotal"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="RefNo"></asp:BoundColumn> 
		</columns>
	</asp:DataGrid></td></tr>
</table></span>
</div>
</form>
</div>
<div id="errorMsg" runat="server" />
</td>
<td>&nbsp;</td>
</tr>
<div class="noprint">
<tr><td colspan="3" height="30">&nbsp;</td></tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
<tr>
	<td height="50" colspan="3" background="../images/footerbg2000.gif">&nbsp;</td>
</tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
</div>
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
Dim PageID As Integer = 17

Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_FullTax") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		
		Dim Chk As Boolean = getProp.CheckColumnExist("ordertransactionfulltaxinvoice","InvoiceCompanyType",objCnn)
		If Chk = False Then
			errorMsg.InnerHtml = "Cannot find new customer Tax ID structure in database. Please upgrade database structure"
			Exit Sub
		End If

		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString

		showResults.Visible = False
		
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
			ItemNameVal.Text = LangData2.Rows(0)(LangText)
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
		
		Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
		If ShopData.Rows.Count > 0 Then

			outputString = "<select name=""ShopID"">"
			For i = 0 to ShopData.Rows.Count - 1
				If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
					FormSelected = "selected"
					SelShopName.Value = ShopData.Rows(i)("ProductLevelName")
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
	Else
		DateFromValue = ""
		DateToValue = ""
		DailyDateValue = ""
	End If	
	If FoundError = False Then
		'If LangDefault.Rows.Count >= 3 Then
			'CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(NOW(), "DateAndTime",Session("LangID"),objCnn)
		'End If
		Dim displayTable As New DataTable()
		
		ShowResults.Visible = True
		ShowPrint.Visible = True

		'Application.Lock()
		Dim dtTable As DataTable = FullTaxReports(StartDate, EndDate, Request.Form("ShopID"), Session("LangID"), objCnn)					
		ResultSearchText.InnerHtml = LangText0.Text + "<BR>" + SelShopName.Value'LangData2.Rows(1)(LangText)
		'Application.UnLock()
		Dim GlobalRCHeaderText,GlobalFTHeaderText,GlobalCMHeaderText, HText, RText As String
		Dim i,j As Integer
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

		Dim ReceiptHeaderData As DataTable
		ReceiptHeaderData = getInfo.GetDocType(1, 0, 8, 1, objCnn)
		If ReceiptHeaderData.Rows.Count > 0 Then
			If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
				GlobalRCHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
			End If
		End If
		ReceiptHeaderData = getInfo.GetDocType(1, 0, 11, 1, objCnn)
		If ReceiptHeaderData.Rows.Count > 0 Then
			If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
				GlobalFTHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
			End If
		End If
		ReceiptHeaderData = getInfo.GetDocType(1, 0, 33, 1, objCnn)
		If ReceiptHeaderData.Rows.Count > 0 Then
			If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
				GlobalCMHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
			End If
		End If
		
		Dim myDataTable As DataTable = new DataTable("FullTax")
		Dim myDataColumn As DataColumn 
		Dim myDataRow As DataRow
	
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "#"
		myDataColumn.ReadOnly = True
		myDataColumn.Unique = False
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "Date"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "FullTaxInvoice"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "RefNo"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "CustomerName"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "CustomerTaxID"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "CustomerCompany"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "ItemName"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "PriceBeforeVAT"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "VAT"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "SubTotal"
		myDataTable.Columns.Add(myDataColumn)
	
		Dim TextClass As String
		Dim TotalVAT As Double = 0
		Dim TotalFullTax As Double
		
		Dim DummyHeader As String
		Dim FullText As String
		Dim ReceiptData As DataTable
		Dim RefBill As String
		Dim DebugText As String
		
		Dim POSTotalBeforeVAT As Double = 0
		Dim POSTotalVAT As Double = 0
		Dim POSTotalAfterVAT As Double = 0
		Dim MultiPOS As Integer = 0
		Dim VoidText As String
		Dim BranchString As String
		For i = 0 To dtTable.Rows.Count - 1

			HText = ""
			If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
				If Not IsDBNull(dtTable.Rows(i)("DocumentTypeHeader")) Then
					HText = dtTable.Rows(i)("DocumentTypeHeader")
				End If
			Else
				HText = GlobalFTHeaderText
			End If
			If IsDBNull(dtTable.Rows(i)("ReceiptID")) Or IsDBNull(dtTable.Rows(i)("ReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("ReceiptYear")) Then
				RText = "-"
			Else
				RText = FormatDocNumber.GetReceiptHeader(HText, dtTable.Rows(i)("ReceiptYear"), dtTable.Rows(i)("ReceiptMonth"), dtTable.Rows(i)("ReceiptID"))
				If dtTable.Rows(i)("TransactionStatusID") = 5 Or dtTable.Rows(i)("TransactionStatusID") = 8 Then
					RText += " " + LangData2.Rows(2)(LangText)
				End If
			End If
			
			myDataRow = myDataTable.NewRow()
			myDataRow("#") = (i+1).ToString
			myDataRow("FullTaxInvoice") = RText
			myDataRow("ItemName") = ItemNameVal.Text
			
			If dtTable.Rows(i)("RefDocType") = 8 Then
				DummyHeader = GlobalRCHeaderText
			Else
				DummyHeader = GlobalCMHeaderText
			End If
			
			VoidText = ""
			If dtTable.Rows(i)("FullTaxStatus") <> 2 Then
				VoidText = "<BR>Voided"
			End If
			If dtTable.Rows(i)("RefDocType") = 8 Then
				'ReceiptData = objDB.List("select b.*,dt.* from OrderFullTaxInvoiceLink a left outer join OrderTransaction b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID left outer join DocumentType dt ON b.DocType=dt.DocumentTypeID AND b.CloseComputerID=dt.ComputerID AND dt.LangID=" + Session("LangID").ToString + " where a.FullTaxStatus=2 AND a.FullTaxInvoiceID=" + dtTable.Rows(i)("FullTaxInvoiceID").ToString + " AND a.FullTaxInvoiceComputerID=" + dtTable.Rows(i)("FullTaxInvoiceComputerID").ToString + " order by b.ReceiptYear,b.ReceiptMonth,b.ReceiptID", objCnn)
				ReceiptData = objDB.List("select b.*,dt.* from OrderFullTaxInvoiceLink a left outer join OrderTransaction b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID left outer join DocumentType dt ON b.DocType=dt.DocumentTypeID AND b.CloseComputerID=dt.ComputerID AND dt.LangID=" + Session("LangID").ToString + " where a.FullTaxInvoiceID=" + dtTable.Rows(i)("FullTaxInvoiceID").ToString + " AND a.FullTaxInvoiceComputerID=" + dtTable.Rows(i)("FullTaxInvoiceComputerID").ToString + " order by b.ReceiptYear,b.ReceiptMonth,b.ReceiptID", objCnn)
				
				RefBill = ""
				For j = 0 To ReceiptData.Rows.Count - 1
					HText = ""
					If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
						If Not IsDBNull(ReceiptData.Rows(j)("DocumentTypeHeader")) Then
							HText = ReceiptData.Rows(j)("DocumentTypeHeader")
						End If
					Else
						HText = DummyHeader
					End If
					If IsDBNull(ReceiptData.Rows(j)("ReceiptID")) Or IsDBNull(ReceiptData.Rows(j)("ReceiptMonth")) Or IsDBNull(ReceiptData.Rows(j)("ReceiptYear")) Then
						RText = "-"
					Else
						RText = FormatDocNumber.GetReceiptHeader(HText, ReceiptData.Rows(j)("ReceiptYear"), ReceiptData.Rows(j)("ReceiptMonth"), ReceiptData.Rows(j)("ReceiptID"))
					End If
					If j = 0 Then
						RefBill += "<a href=""JavaScript: newWindow = window.open( 'BillDetails.aspx?ComputerID=" + ReceiptData.Rows(j)("ComputerID").ToString + "&TransactionID=" + ReceiptData.Rows(j)("TransactionID").ToString + "&ShopID=" + ReceiptData.Rows(j)("ShopID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"" class=""smallText"">" & RText & "</a>"
						
					Else
						RefBill += "<br><a href=""JavaScript: newWindow = window.open( 'BillDetails.aspx?ComputerID=" + ReceiptData.Rows(j)("ComputerID").ToString + "&TransactionID=" + ReceiptData.Rows(j)("TransactionID").ToString + "&ShopID=" + ReceiptData.Rows(j)("ShopID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"" class=""smallText"">" & RText & "</a>"
					End If
				Next
				myDataRow("RefNo") = RefBill + VoidText
			Else
				myDataRow("RefNo") = RText + VoidText
			End If
				
			If Not IsDBNull(dtTable.Rows(i)("InvoiceName")) Then
				myDataRow("CustomerName") = dtTable.Rows(i)("InvoiceName")
			Else
				myDataRow("CustomerName") = "-"
			End If
			
			If Not IsDBNull(dtTable.Rows(i)("InvoiceTaxID")) Then
				myDataRow("CustomerTaxID") = dtTable.Rows(i)("InvoiceTaxID")
			Else
				myDataRow("CustomerTaxID") = "-"
			End If
			
			BranchString = ""
			If dtTable.Rows(i)("InvoiceCompanyType") = 1 Then
				myDataRow("CustomerCompany") = LangData2.Rows(17)(LangText)
			ElseIf dtTable.Rows(i)("InvoiceCompanyType") = 2 Then
				If Not IsDBNull(dtTable.Rows(i)("InvoiceCompanyBranchNo")) Then
					BranchString = dtTable.Rows(i)("InvoiceCompanyBranchNo")
				End If
				myDataRow("CustomerCompany") = LangData2.Rows(18)(LangText) + " " + BranchString
			Else
				myDataRow("CustomerCompany") = "-"
			End If
			
			If Not IsDBNull(dtTable.Rows(i)("InvoiceDate")) Then
				myDataRow("Date") = DateTimeUtil.FormatDateTime(dtTable.Rows(i)("InvoiceDate"), "DateOnly", Session("LangID"), objCnn)
			Else
				myDataRow("Date") = "-"
			End If
			
			myDataRow("PriceBeforeVAT") = Format(dtTable.Rows(i)("PaymentAmount")-dtTable.Rows(i)("PaymentVAT"), FormatData.Rows(0)("CurrencyFormat"))
			myDataRow("VAT") = Format(dtTable.Rows(i)("PaymentVAT"), FormatData.Rows(0)("CurrencyFormat"))
			myDataRow("SubTotal") = Format(dtTable.Rows(i)("PaymentAmount"), FormatData.Rows(0)("CurrencyFormat"))
			
			If dtTable.Rows(i)("FullTaxStatus") = 2 Then
				TotalFullTax += dtTable.Rows(i)("PaymentAmount")
				TotalVAT += dtTable.Rows(i)("PaymentVAT")

                POSTotalVAT += dtTable.Rows(i)("PaymentVAT")
                POSTotalAfterVAT += dtTable.Rows(i)("PaymentAmount")
			End If
			
			myDataTable.Rows.Add(myDataRow)
			
			If i <> dtTable.Rows.Count - 1
				If dtTable.Rows(i)("FullTaxInvoiceComputerID") <> dtTable.Rows(i+1)("FullTaxInvoiceComputerID") Then
					myDataRow = myDataTable.NewRow()
					myDataRow("ItemName") = LangData2.Rows(14)(LangText)
					myDataRow("PriceBeforeVAT") = Format(POSTotalAfterVAT - POSTotalVAT, FormatData.Rows(0)("CurrencyFormat"))
					myDataRow("VAT") = Format(POSTotalVAT, FormatData.Rows(0)("CurrencyFormat"))
					myDataRow("SubTotal") = Format(POSTotalAfterVAT, FormatData.Rows(0)("CurrencyFormat"))
					myDataTable.Rows.Add(myDataRow)
					
					POSTotalBeforeVAT = 0
                	POSTotalVAT = 0
                	POSTotalAfterVAT = 0
					MultiPOS += 1
				End If
			End If
			
			If i = dtTable.Rows.Count - 1 AND MultiPOS > 0 Then
				myDataRow = myDataTable.NewRow()
				myDataRow("ItemName") = LangData2.Rows(14)(LangText)
				myDataRow("PriceBeforeVAT") = Format(POSTotalAfterVAT - POSTotalVAT, FormatData.Rows(0)("CurrencyFormat"))
				myDataRow("VAT") = Format(POSTotalVAT, FormatData.Rows(0)("CurrencyFormat"))
				myDataRow("SubTotal") = Format(POSTotalAfterVAT, FormatData.Rows(0)("CurrencyFormat"))
				myDataTable.Rows.Add(myDataRow)
			End If
		Next
		myDataRow = myDataTable.NewRow()
		myDataRow("ItemName") = LangData2.Rows(3)(LangText)
		myDataRow("PriceBeforeVAT") = Format(TotalFullTax-TotalVAT, FormatData.Rows(0)("CurrencyFormat"))
		myDataRow("VAT") = Format(TotalVAT, FormatData.Rows(0)("CurrencyFormat"))
		myDataRow("SubTotal") = Format(TotalFullTax, FormatData.Rows(0)("CurrencyFormat"))
		myDataTable.Rows.Add(myDataRow)
		Results.DataSource = myDataTable
		Results.DataBind()
		
		Dim CompanyInfo As DataTable
		CompanyInfo = getInfo.GetCompanyInfo(Request.Form("ShopID"), objCnn)
		
		Dim CompanyInfo1,CompanyInfo2 As String
		Dim Add2 As String = ""
		
		If CompanyInfo.Rows.Count > 0 Then
			CompanyInfo1 += "<table>"
			CompanyInfo1 += "<tr><td class=""text"">" + CompanyInfo.Rows(0)("CompanyName") + "</td></tr>"
			If Not IsDBNull(CompanyInfo.Rows(0)("CompanyAddress1")) Then
				CompanyInfo1 += "<tr><td class=""text"">" + CompanyInfo.Rows(0)("CompanyAddress1") + "</td></tr>"
			End If
			
			If Not IsDBNull(CompanyInfo.Rows(0)("CompanyAddress2")) Then
				Add2 += CompanyInfo.Rows(0)("CompanyAddress2")
			End If
			If Not IsDBNull(CompanyInfo.Rows(0)("CompanyCity")) Then
				If Add2 <> "" Then Add2 += " "
				Add2 += CompanyInfo.Rows(0)("CompanyCity")
			End If
			
			If Add2 <> "" Then
				CompanyInfo1 += "<tr><td class=""text"">" + Add2 + "</td></tr>"
			End If
			
			Dim Chk As Boolean = getReport.CheckTableColumn("CompanyProfile","DisplayCompanyProvinceLangID",objCnn)
			Dim Province As DataTable 
			If Chk = False Then
				Province = objDB.List("select * from provinces where provinceid=" + CompanyInfo.Rows(0)("CompanyProvince").ToString + " and LangID=" + CompanyInfo.Rows(0)("DisplayCompanyProvinceLangID").ToString, objCnn)
			Else
				Province = objDB.List("select * from provinces where provinceid=" + CompanyInfo.Rows(0)("CompanyProvince").ToString + " and LangID=" + Session("LangID").ToString, objCnn)
			End If
			
			Add2 = ""
			If Province.Rows.Count > 0 Then
				Add2 += Province.Rows(0)("ProvinceName")
			End If
			If Not IsDBNull(CompanyInfo.Rows(0)("CompanyZipcode")) Then
				If Add2 <> "" Then Add2 += " "
				Add2 += CompanyInfo.Rows(0)("CompanyZipcode")
			End If
			If Add2 <> "" Then
				CompanyInfo1 += "<tr><td class=""text"">" + Add2 + "</td></tr>"
			End If

			CompanyInfo1 += "</table>"
			
			CompanyInfo2 = "<table>"
			CompanyInfo2 += "<tr><td class=""text"">" + ReportDate + "</td></tr>"
			If Not IsDBNull(CompanyInfo.Rows(0)("CompanyTaxID")) Then
				CompanyInfo2 += "<tr><td class=""text"">" + LangData2.Rows(4)(LangText) + "</td></tr>"
				CompanyInfo2 += "<tr><td class=""text"">" + CompanyInfo.Rows(0)("CompanyTaxID") + "</td></tr>"
			End If
			CompanyInfo2 += "</table>"
			
		End If
		CompanyInfoText1.InnerHtml = CompanyInfo1
		CompanyInfoText2.InnerHtml = CompanyInfo2
		
		Dim sw As New System.IO.StringWriter()
		Dim htw As New System.Web.UI.HtmlTextWriter(sw)
		Results.RenderControl(htw)
		
		Session("ReportResult") = "<table width=""100%""><tr><td align=""center"">" + ResultSearchText.InnerHtml + "</td></tr><tr><td width=""100%""><table width=""100%""><tr><td valign=""top"" colspan=""7"">" + CompanyInfoText1.InnerHtml  + "</td><td align=""right"" valign=""top"" colspan=""2"">" + CompanyInfoText2.InnerHtml + "</td></tr></table></td></tr><tr><td>" + sw.ToString() + "</td></tr></table>"
		
		'errorMsg.InnerHtml = DebugText
		
	End If
	
End Sub

Sub ChangeGridPage(objSender As Object, objArgs As DataGridPageChangedEventArgs)
	
   Results.CurrentPageIndex = objArgs.NewPageIndex

	
End Sub
		
Private Sub Results_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) 
	Dim LangData2 As DataTable = getProp.GetLangData(PageID,2,-1,Request)
	Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
	Dim LangText As String = "lang" + Session("LangID").ToString
	If e.Item.ItemType = ListItemType.Header Then
		e.Item.Cells(0).Text = LangData2.Rows(5)(LangText)
		e.Item.Cells(1).Text = LangData2.Rows(6)(LangText)
		e.Item.Cells(2).Text = LangData2.Rows(7)(LangText)
		e.Item.Cells(3).Text = LangData2.Rows(8)(LangText)
		e.Item.Cells(4).Text = LangData2.Rows(15)(LangText)
		e.Item.Cells(5).Text = LangData2.Rows(16)(LangText)
		e.Item.Cells(6).Text = LangData2.Rows(9)(LangText)
		e.Item.Cells(7).Text = LangData2.Rows(10)(LangText)
		e.Item.Cells(8).Text = LangData2.Rows(11)(LangText)
		e.Item.Cells(9).Text = LangData2.Rows(12)(LangText)
		e.Item.Cells(10).Text = LangData2.Rows(13)(LangText)
	End If
End Sub

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "FullTaxData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub	

Public Function FullTaxReports(ByVal StartDate As String, ByVal EndDate As String, ByVal ShopID As Integer, ByVal LangID As Integer, ByVal objCnn As MySqlConnection) As DataTable

        Dim sqlStatement, sqlStatement1, WhereString As String
        Dim AdditionalQuery As String = ""
        Dim ShopIDListValue As String
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
            AdditionalQuery += " AND ot.ShopID IN (" + ShopID.ToString + ")"
        End If

        If StartDate <> "" And EndDate <> "" Then
            AdditionalQuery += " AND (a.InvoiceDate >= " + StartDate + " AND a.InvoiceDate < " + EndDate + ")"
        End If

        sqlStatement = "SELECT a.FullTaxInvoiceID,a.FullTaxInvoiceComputerID,a.ShopID,a.DocType,c.DocumentTypeHeader,a.RefDocType,d.DocumentTypeHeader AS RefDocumentTypeHeader,a.TransactionID,a.ComputerID,a.ReceiptID,a.ReceiptMonth,a.ReceiptYear,InvoiceName,InvoiceNote,InvoiceDate,(a.TotalSalePrice+a.ServiceCharge+a.TransactionVAT) AS PaymentAmount,a.TransactionVAT AS PaymentVAT,ot.ReceiptID AS RefReceiptID,ot.ReceiptMonth AS RefReceiptMonth,ot.ReceiptYear AS RefReceiptYear,ot.TransactionStatusID,a.FullTaxStatus,a.InvoiceTaxID,a.InvoiceCompanyType,a.InvoiceCompanyBranchNo FROM OrderTransactionFullTaxInvoice" + BranchStr + " a inner join OrderTransaction" + BranchStr + " ot ON a.TransactionID=ot.TransactionID AND a.ComputerID=ot.ComputerID LEFT OUTER JOIN DocumentType c ON a.DocType=c.DocumentTypeID AND a.CloseComputerID=c.ComputerID LEFT OUTER JOIN DocumentType d ON a.RefDocType=d.DocumentTypeID AND ot.CloseComputerID=d.ComputerID WHERE a.RefDocType IN (4,8) AND (c.LangID=" + LangID.ToString + " OR c.LangID is NULL) AND (d.LangID=" + LangID.ToString + " OR d.LangID is NULL) " + AdditionalQuery + " UNION SELECT a.FullTaxInvoiceID,a.FullTaxInvoiceComputerID,a.ShopID,a.DocType,c.DocumentTypeHeader,a.RefDocType,d.DocumentTypeHeader AS RefDocumentTypeHeader,a.TransactionID,a.ComputerID,a.ReceiptID,a.ReceiptMonth,a.ReceiptYear,InvoiceName,InvoiceNote,InvoiceDate,(a.TotalSalePrice+a.ServiceCharge+a.TransactionVAT) As PaymentAmount,a.TransactionVAT,b.ReceiptID AS RefReceiptID,b.ReceiptMonth AS RefReceiptMonth,b.ReceiptYear AS RefReceiptYear,ot.TransactionStatusID,a.FullTaxStatus,a.InvoiceTaxID,a.InvoiceCompanyType,a.InvoiceCompanyBranchNo FROM OrderTransactionFullTaxInvoice" + BranchStr + " a inner join PayByCreditMoney" + BranchStr + " b ON a.TransactionID=b.CMTransactionID AND a.ComputerID=b.CMComputerID inner join OrderTransaction" + BranchStr + " ot ON b.TransactionID=ot.TransactionID AND b.ComputerID=ot.ComputerID LEFT OUTER JOIN DocumentType c ON a.DocType=c.DocumentTypeID AND a.CloseComputerID=c.ComputerID LEFT OUTER JOIN DocumentType d ON a.RefDocType=d.DocumentTypeID AND a.CloseComputerID=d.ComputerID WHERE a.RefDocType=33 AND (c.LangID=" + LangID.ToString + " OR c.LangID is NULL) AND (d.LangID=" + LangID.ToString + " OR d.LangID is NULL) " + AdditionalQuery + " ORDER BY FullTaxInvoiceComputerID,ReceiptYear,ReceiptMonth,ReceiptID"
        GetData = objDB.List(sqlStatement, objCnn)

        Return GetData

    End Function

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
