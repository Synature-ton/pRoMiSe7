<%@ Page Language="VB" ContentType="text/html" EnableViewState="False" debug="True" %>
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
<title>Sale Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="../StyleSheet/webscript.js"></script> 
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
			</tr>
			<tr>
				<td><asp:radiobutton ID="Radio_11" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
			<tr id="showproduct" visible="false" runat="server">
				<td><asp:radiobutton ID="Radio_12" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
            <tr id="xx" visible="false" runat="server">
            	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:dropdownlist ID="ReportProductOrdering" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
            </tr>
			<tr id="yy" visible="false" runat="server">
				<td><asp:radiobutton ID="Radio_13" GroupName="Group2" CssClass="text" runat="server" />
				<asp:dropdownlist ID="GroupByParam" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
			</tr>
		</table></td>
	<td>
	<table>
		<tr>
		<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="DailyDate" runat="server" /></td>
		<td colspan="2"><asp:CheckBox ID="ExpandReceipt" CssClass="text" Checked="false" Visible="false" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="MonthYearDate" runat="server" /></td>
		<td colspan="2"><asp:radiobutton ID="Linechart" Text="Line Chart" Checked="true" GroupName="Group3" CssClass="text" Visible="false" runat="server" />
			&nbsp;<asp:radiobutton ID="Barchart" Text="Column Chart" GroupName="Group3" CssClass="text" Visible="false" runat="server" /></td>
		</tr>
		<tr id="yearoption" visible="false" runat="server">
		<td><asp:radiobutton ID="Radio_4" GroupName="Group1" runat="server" /></td>
		<td colspan="3"><synature:date id="YearDate" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="Radio_2" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="CurrentDate" runat="server" /></td>
		<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
		<td><synature:date id="ToDate" runat="server" /></td>
	</tr>
	<tr><td>&nbsp;</td>
		<td colspan="4"><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" />&nbsp;<asp:CheckBox ID="DisplayGraph" CssClass="text" Checked="true" Visible="false" runat="server" /></td>
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
<span id="MyTable">
<table width="100%">
<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>

<span id="startTable" runat="server"></span>
	<tr>
	<span id="TableHeaderText" runat="server"></span>
	<span id="ExtraHeader" runat="server"></span>
	</tr>
	
	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>

<asp:Panel ID="showGraph" Visible="false" runat="server">
<br>
<Web:ChartControl id="ChartControl1" ChartPadding=40 runat="Server" />
</asp:Panel></td></tr>
</table></span>

<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table>

</div>
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
Dim Fm As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer = 6

Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("SaleReportB2") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
		Dim i As Integer
		
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
		
		ResultText.InnerHtml = ""
		ResultSearchText.InnerHtml = ""
		errorMsg.InnerHtml = ""
		ExtraHeader.InnerHtml = ""
		
		Dim HeaderString As String = ""
		Dim ShopProp1 As DataTable = getInfo.GetProductLevel(Request.Form("ShopID"),objCnn)
		If (Radio_11.Checked = True AND (Radio_1.Checked = True Or Radio_2.Checked = True Or Radio_4.Checked = True)) Or Radio_13.Checked = True Or (Request.Form("ShopID") = 0 And Radio_12.Checked = False) Or (Radio_11.Checked = True AND Radio_3.Checked = True And ExpandReceipt.Checked = False) Then
			If Radio_11.Checked = True AND Radio_3.Checked = True And ExpandReceipt.Checked = False And Request.Form("ShopID") > 0 Then
				HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(18)(LangText) & "</td>"

				
				If ShopProp1.Rows(0)("ShopType") = 1 Then
					'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(19)(LangText) & "</td>"
					'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(21)(LangText) & "</td>"
				End If

			Else
				If Radio_13.Checked = True Then
					If Request.Form("GroupByParam") = 1 Then
						HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(61)(LangText) & "</td>"
					Else
						HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(60)(LangText) + "</td>"
					End if
				ElseIf Radio_4.Checked = True Then
					HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(63)(LangText) + "</td>"
				Else
					If Request.Form("ShopID") = 0 Then
						HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(64)(LangText) + "</td>"
					Else
						HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(65)(LangText) + "</td>"
					End If
				End If
				'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(20)(LangText) + "</td>"
				If ShopProp1.Rows(0)("ShopType") = 1 Then
					'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(21)(LangText) & "</td>"
				End If		
			End If
			
            Dim DisplayVATType As String = "V"
			If Request.Form("ShopID") > 0 Then
				Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel where ProductLevelID=" + Request.Form("ShopID").ToString, objCnn)
				If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
					DisplayVATType = "E"
				End If
			End If
			'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>x" + LangData2.Rows(22)(LangText) + "</td>"
			'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>xx" + LangData2.Rows(23)(LangText) + "</td>"
			If Request.Form("ShopID") > 0 Then
			'	HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(24)(LangText) + "</td>"
			End If
			'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(25)(LangText) + "</td>"
			'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(26)(LangText) + "</td>"
			If Request.Form("ShopID") <> 0 Then
				If DisplayVATType = "E" Then
			'		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(27)(LangText) + "</td>"
			'		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(28)(LangText) + "</td>"
				End If
			End If
			If Request.Form("ShopID") = 0 Then
			'	HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>"
			End If
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(29)(LangText) + "</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(30)(LangText) + "</td>"
			
		ElseIf Radio_12.Checked = True Then
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(33)(LangText) + "</td>"		
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(34)(LangText) + "</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(36)(LangText) + "</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(37)(LangText) + "</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(35)(LangText) + "</td>"
			
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(38)(LangText) + "</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(35)(LangText) + "</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(39)(LangText) + "</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(40)(LangText) + "</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(35)(LangText) + "</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>"

		End If
		TableHeaderText.InnerHtml = HeaderString
		
		If Radio_3.Checked = True AND (Radio_11.Checked = True Or Radio_13.Checked = True) And ExpandReceipt.Checked = True AND Request.Form("ShopID") <> 0 Then
			StartTable.InnerHtml = "<table border=""0"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		Else
			StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		End If

		GroupByParam.Items(0).Text = LangData2.Rows(4)(LangText)
		GroupByParam.Items(0).Value = "1"
		GroupByParam.Items(1).Text = LangData2.Rows(5)(LangText)
		GroupByParam.Items(1).Value = "2"
		If Request.Form("GroupByParam") = 1 Then
			GroupByParam.Items(0).Selected = True
		ElseIf Request.Form("GroupByParam") = 2 Then
			GroupByParam.Items(1).Selected = True
		Else
			GroupByParam.Items(0).Selected = True
		End If
		
		ReportProductOrdering.Items(0).Text = LangData2.Rows(2)(LangText)
		ReportProductOrdering.Items(0).Value = "p.ProductCode"
		ReportProductOrdering.Items(1).Text = LangData2.Rows(3)(LangText)
		ReportProductOrdering.Items(1).Value = "p.ProductName"
		If Request.Form("ReportProductOrdering") = "p.ProductCode" Then
			ReportProductOrdering.Items(0).Selected = True
		ElseIf Request.Form("ReportProductOrdering") = "p.ProductName" Then
			ReportProductOrdering.Items(1).Selected = True
		Else
			ReportProductOrdering.Items(0).Selected = True
		End If
		
		ExpandReceipt.Text = LangData2.Rows(6)(LangText)
		DisplayGraph.Text = LangData2.Rows(7)(LangText)
		
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
		
		YearDate.YearType = GlobalParam.YearType
		YearDate.FormName = "YearDate"
		YearDate.StartYear = GlobalParam.StartYear
		YearDate.EndYear = GlobalParam.EndYear
		YearDate.LangID = Session("LangID")
		YearDate.ShowDay = False
		YearDate.ShowMonth = False
		YearDate.Lang_Data = LangDefault
		YearDate.Culture = CultureString
		
		Radio_11.Text = LangData2.Rows(0)(LangText)
		Radio_12.Text = LangData2.Rows(1)(LangText)
		Linechart.Text = LangData2.Rows(8)(LangText)
		Barchart.Text = LangData2.Rows(9)(LangText)
		
		
		
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
		Else If Trim(Session("YearDate_Year")) = 0 And Not Page.IsPostBack Then
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

		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		Dim Multiple As Boolean = False
		Dim ShopList As String = ""
		
		Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
		If ShopData.Rows.Count > 0 Then

			outputString = "<select name=""ShopID"">"
			'If ShopData.Rows.Count > 1 Then
			'	If Not Page.IsPostBack Then 
			'		FormSelected = "selected"
			'	ElseIf ShopIDValue = 0 Then
			'		FormSelected = "selected"
			'	Else
			'		FormSelected = ""
			'	End If
			'	outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & "--- All Shops ---"
			'	Multiple = True
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
	
	Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
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
	Dim AdditionalHeader As String = ""
	Dim PayTypeList As DataTable
	Dim i As Integer
	
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
	Dim outputString As String = ""
	Dim grandTotal As Double = 0
	Dim VATTotal As Double = 0
	Dim GraphData As New DataSet()
	Dim ReportDate As String
	Dim YearValue4 As Integer
	Dim R1,R2,R3,R4,R11,R12,R13 As Boolean
	R1 = False
	R2 = False
	R3 = False
	R4 = False
	If Request.Form("Group1") = "Radio_1" Then
		R1 = True
	ElseIf Request.Form("Group1") = "Radio_2" Then
		R2 = True
	ElseIf Request.Form("Group1") = "Radio_3" Then
		R3 = True
	Else
		R4 = True
	End If
	
	Dim ReportType As String
	If Request.Form("Group2") = "Radio_11" Then
		R11 = True
		If R3 = True Then
			ReportType = LangData2.Rows(11)(LangText)
		ElseIf R2 = True Then
			ReportType = LangData2.Rows(14)(LangText)
		ElseIf R1 = True Then
			ReportType = LangData2.Rows(12)(LangText)
		Else
			ReportType = LangData2.Rows(13)(LangText)
		End If
	ElseIf Request.Form("Group2") = "Radio_12" Then
		R12 = True
		ReportType = LangData2.Rows(15)(LangText)
	ElseIf Request.Form("Group2") = "Radio_13" Then
		R13 = True
		If Request.Form("GroupByParam") = 1 Then
			ReportType = LangData2.Rows(16)(LangText)
		Else
			ReportType = LangData2.Rows(17)(LangText)
		End If
	End If
	
	Dim ExpReceipt As Boolean = False
	If Request.Form("ExpandReceipt") = "on" Then ExpReceipt = True
	
	Dim DGraph As Boolean = False
	If Request.Form("DisplayGraph") = "on" Then DGraph = True
	
	If R1 = True Then
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
			errorMsg.InnerHtml = ex.Message
		End Try
	ElseIf R2 = True Then
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
			errorMsg.InnerHtml = ex.Message
		End Try
	Else If R3 = True Then
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
	Else If R4 = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(1,1,Request.Form("YearDate_Year"))
		 
		YearValue4 = Request.Form("YearDate_Year") + 1
		EndDate = DateTimeUtil.FormatDate(1,1,YearValue4)
		Dim SDate4 As New Date(Request.Form("YearDate_Year"),1,1)
		ReportDate = DateTimeUtil.FormatDateTime(SDate4, "yyyy",Session("LangID"),objCnn)
		Catch ex As Exception
			FoundError = True
			errorMsg.InnerHtml = ex.Message
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
		
		Dim ViewOption As Integer
		If R1 = True Then
			ViewOption = 1
		ElseIf R2 = True Then
			ViewOption = 2
		ElseIf R4 = True Then
			ViewOption = 4
		Else
			ViewOption = 0 
		End If
		
		'Application.Lock()
		Dim HavePrepaid As Boolean = False
		Dim HavePrepaidDiscount As Boolean = False
		Dim ExtraPayText As String
		
		Dim LangPath As String = Util.GetLangPath(Request.PhysicalApplicationPath)
			
		If Request.Form("ShopID") > 0 Or (Request.Form("ShopID")=0 AND R12 = True) Then
			ResultText.InnerHtml = SaleReports_A2(PayTypeList,outputString, grandTotal, VATTotal, GraphData, True,GlobalParam.GrayBGColor,GlobalParam.AdminBGColor,Session("LangID"),ViewOption,R11, R12, R13, Request.Form("GroupByParam"), StartDate, EndDate,Request.Form("ReportProductOrdering"),"","","", Request.Form("ShopID"),0,0,True,ExpReceipt, DGraph, LangPath, objCnn)
			
		Else
			ResultText.InnerHtml = ""'getReport.SaleReportsAll(PayTypeList,outputString, grandTotal, GraphData, True,GlobalParam.GrayBGColor,GlobalParam.AdminBGColor,Session("LangID"),ViewOption,R11, R12, R13, Request.Form("GroupByParam"), StartDate, EndDate, Request.Form("ShopID"),0,0,True,ExpReceipt, DGraph, objCnn)

		End If
	
		If (R11 = True AND (R1 = True Or R2 = True Or R4 = True)) Or R13 = True Or (R11 = True AND R3 = True And ExpReceipt = False) Then
				
				For i = 0 To PayTypeList.Rows.Count - 1
					ExtraPayText = ""
					If PayTypeList.Rows(i)("PrepaidDiscountPercent") > 0 Then
						HavePrepaidDiscount = True
						ExtraPayText = "<br>Total/Disc"
					End If
					AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + PayTypeList.Rows(i)("PayTypeName") + ExtraPayText + "</td>"
					If PayTypeList.Rows(i)("IsSale") = 0 Then
						If PropertyInfo.Rows(0)("SummaryPrepaidInSaleReport") = 1 Then
							HavePrepaid = True
						End If	
					End If
				Next
				
				Dim ShopProp1 As DataTable = getInfo.GetProductLevel(Request.Form("ShopID"),objCnn)
			
				AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(31)(LangText) + "</td>"
				AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(32)(LangText) + "</td>"
				
				AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(88)(LangText) & "</td>"
				If ShopProp1.Rows(0)("ShopType") = 1 Then
						AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(87)(LangText) & "</td>"
				End If
				
			
				Dim NotInRevenueBit As Boolean = False
				Try
					NotInRevenueBit = PropertyInfo.Rows(0)("EnableNotInRevenue")
				Catch ex As Exception
					NotInRevenueBit = False
				End Try
				Try
				If NotInRevenueBit = True Then
					Dim NotInRevenueData As DataTable = getReport.NotInRevenueType(objCnn)
					For i = 0 to NotInRevenueData.Rows.Count - 1
						AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + NotInRevenueData.Rows(i)("NotInRevenueName") + "</td>"
					Next
					AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(66)(LangText) + "</td>"
					HavePrepaidDiscount = True
				End If
				Catch ex As Exception
					NotInRevenueBit = False
				End Try
				If HavePrepaidDiscount = True  Then
					AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(67)(LangText) + "</td>"
				End If
				If HavePrepaid = True Then
					AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(68)(LangText) + "</td>"
					AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(69)(LangText) + "</td>"
				End If	
				
				ExtraHeader.InnerHtml = "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Total Payment" + "</td>"'AdditionalHeader
			End If

		Dim ShopDisplay As String
		If Request.Form("ShopID") = 0 Then
			ShopDisplay = LangData2.Rows(70)(LangText)
		Else
			ShopDisplay = SelShopName.Value
		End If
		ResultSearchText.InnerHtml = ReportType + " " + ShopDisplay + " (" + ReportDate + ")"
		'Application.UnLock()
		
		Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"

		If DGraph = True AND (R3 = False Or (R3 = True AND Request.Form("ShopID")=0) Or (R3 = True AND ExpReceipt = False AND Request.Form("GroupByParam") = 2)) AND (R11 = True Or R13 = True) Then

				showGraph.Visible = True
				Dim view As DataView = GraphData.Tables(0).DefaultView
				
				If view.Count > 0 Then
            
				If BarChart.Checked = True Then
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
					ConfigureColors(ReportType & " " + ShopDisplay + " (" + ReportDate + ")")
			
					ChartControl1.RedrawChart()
				Else
					Dim chart As New SmoothLineChart()
					chart.Fill.Color = Color.FromArgb(80, Color.SpringGreen)
					chart.Line.Color = Color.SteelBlue
					chart.Line.Width = 2
					chart.ShowLegend = True
					chart.DataSource = view
					chart.DataXValueField = "Description"
					chart.DataYValueField = "Value1"
					chart.DataBind()
					ChartControl1.Charts.Add(chart)
					ConfigureColors(ReportType & " " + ShopDisplay + " (" + ReportDate + ")")
			
					ChartControl1.RedrawChart()

				End If
				Else
					showGraph.Visible = False
				End If
		ElseIf R12 = True AND DGraph = True Then
			showGraph.Visible = True
			Dim view As DataView = GraphData.Tables(0).DefaultView
			If view.Count > 0 Then
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
				ConfigureColors(ReportType + " " + ShopDisplay + " (" + ReportDate + ")")
        
        		ChartControl1.RedrawChart()
			End If
		Else
			showGraph.Visible = False
		End If
	End If

End Sub

 Sub ConfigureColors(TitleName)
        	'ChartControl1.Background.Color = Color.FromArgb(75, Color.SteelBlue)
			Dim ChartWidth As Integer = 650
			Dim ChartHeight As Integer = 500
			If Request.Form("Group2") = "Radio_12" Then
				ChartWidth = 700
				ChartHeight = 550
			ElseIf Request.Form("Group2") = "Radio_13" Then
				If Request.Form("GroupByParam") = 1 Then
					ChartWidth = 650
					ChartHeight = 450
				Else
					ChartWidth = 650
					ChartHeight = 450
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
	
Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "SaleData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub	

   Public Function SaleReports_A2(ByRef PayTypeList As DataTable, ByRef outputString As String, ByRef grandTotal As Double, ByRef VATTotal As Double, ByRef GraphData As DataSet, ByVal ShowSummary As Boolean, ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal LangID As Integer, ByVal ViewOption As Integer, ByVal ReportByBill As Boolean, ByVal ReportByProduct As Boolean, ByVal ReportByTime As Boolean, ByVal GroupByParam As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal StartTimeHour As String, ByVal StartTimeMinute As String, ByVal EndTimeHour As String, ByVal EndTimeMinute As String, ByVal ShopID As Integer, ByVal TransactionID As Integer, ByVal ComputerID As Integer, ByVal DisplaySummary As Boolean, ByVal ExpandReceipt As Boolean, ByVal DisplayGraph As Boolean, ByVal LangPath As String, ByVal objCnn As MySqlConnection) As String

        Dim sqlStatement, sqlStatement1, sqlStatement2, WhereString, WString, ExtraSql, ExtraSelect As String
        Dim AdditionalQuery As String = ""
        Dim ShopIDListValue As String = ""
        Dim ResultString As String = ""
        Dim TextClass As String
        Dim GetData As DataTable
        Dim PayTypeData As DataTable

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
        Dim PName As String = "p." + getReport.ProductNameForReport(LangID, objCnn) + " As ProductName"
        Dim PName2 As String = "p." + getReport.ProductNameForReport(LangID, objCnn)
        Dim SaleModePName As String = "IF(b.SaleMode = 1," + PName2 + ",IF(sm.PositionPrefix=0,CONCAT(sm.PrefixText," + PName2 + "),CONCAT(" + PName2 + ",sm.PrefixText))) As ProductName"

        Dim NotInRevenueBit As Boolean = False
        Try
            NotInRevenueBit = PropertyInfo.Rows(0)("EnableNotInRevenue")
        Catch ex As Exception
            NotInRevenueBit = False
        End Try

        If ShopID = 0 Then
            Dim getInfo As New CCategory
            Dim ShopData As DataTable = getInfo.GetProductLevel(-999, objCnn)
            For ii = 0 To ShopData.Rows.Count - 1
                ShopIDListValue += "," + ShopData.Rows(ii)("ProductLevelID").ToString
            Next
            If ShopIDListValue <> "" Then ShopIDListValue = "0" + ShopIDListValue
        Else
            ShopIDListValue = ShopID.ToString
        End If


        If TransactionID > 0 And ComputerID > 0 Then
            AdditionalQuery += " AND ( a.TransactionID = " + TransactionID.ToString + " AND a.ComputerID = " + ComputerID.ToString + ")"
        Else
            AdditionalQuery += " AND a.DocType IN (8)"
        End If

        If ShopID > 0 Then
            AdditionalQuery += " AND a.ShopID IN (" + ShopIDListValue + ")"
            WhereString += " AND ShopID IN (" + ShopIDListValue + ")"
            WString += " AND a.ShopID IN (" + ShopIDListValue + ")"
        End If

        If StartDate <> "" And EndDate <> "" Then
            AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
            WhereString += " AND (PayDate >= " + StartDate + " AND PayDate < " + EndDate + ")"
            WString += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
        End If

        Dim StartTime As String = ""
        Dim EndTime As String = ""
        If IsNumeric(StartTimeHour) And IsNumeric(StartTimeMinute) Then
            StartTime = StartTimeHour + ":" + StartTimeMinute + ":0"
            AdditionalQuery += " AND ( TIME_TO_SEC(a.OpenTime) >= TIME_TO_SEC('" + StartTime + "') )"
        End If
        If IsNumeric(EndTimeHour) And IsNumeric(EndTimeMinute) Then
            EndTime = EndTimeHour + ":" + EndTimeMinute + ":0"
            AdditionalQuery += " AND ( TIME_TO_SEC(a.OpenTime) <= TIME_TO_SEC('" + EndTime + "') )"
        End If

        If Trim(WhereString) = "" Then
            WhereString = " AND 0=1"
            WString = " AND 0=1"
        End If
        Dim OrderBy As String = " a.DocType,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID,b.OrderDetailID,d.PayTypeID"
        Dim ExtraTableString As String = Now.Year.ToString + Now.Month.ToString + Now.Day.ToString + Now.Hour.ToString + Now.Minute.ToString + Now.Second.ToString + Now.Millisecond.ToString
        sqlStatement = "select sum(payamount) AS TotalPay, sum(PaymentVAT) AS TotalVAT, a.PayTypeID,b.PayType AS PayTypeName from paybycreditmoney" + BranchStr + " a left outer join paytype b ON a.PayTypeID=b.TypeID where a.CreditMoneyStatusID=2 " + WhereString + " group by a.PayTypeID,b.PayType order by a.PayTypeID,b.PayType"
        Dim PayByCreditMoney As DataTable = objDB.List(sqlStatement, objCnn)



        sqlStatement2 = "select * from BankName where 0=1"
        PayTypeList = getReport.GetSalePayType(ShopID.ToString, StartDate, EndDate, objCnn)

        ExtraSql = ""
        ExtraSelect = ""

        If ReportByProduct = True Or (ReportByProduct = False And ViewOption = 0 And ExpandReceipt = True) Then

            sqlStatement = "select a.TransactionID,a.ComputerID,b.VATType,NoCustomer,SUM(c.SalePrice) AS TotalExcludePrice FROM OrderTransaction" + BranchStr + " a, OrderDetail" + BranchStr + " b, OrderDiscountDetail" + BranchStr + " c WHERE a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.OrderDetailID=c.OrderDetailID AND b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3,14,16) " + AdditionalQuery + " GROUP BY a.TransactionID,a.ComputerID,b.VATType,NoCustomer"

            objDB.sqlExecute("DROP TABLE IF EXISTS DummySaleReport", objCnn)

            objDB.sqlExecute("create table DummySaleReport (TransactionID int, ComputerID int, VATType tinyint, NoCustomer int ,TotalProductSale decimal(18,4))", objCnn)

            objDB.sqlExecute("insert into DummySaleReport " + sqlStatement, objCnn)

            If ReportByProduct = True Then
                Dim OrderingProduct As String = "p.ProductName"
                If Trim(StartTimeHour) <> "" Then
                    OrderingProduct = StartTimeHour
                End If
                objDB.sqlExecute("DROP TABLE IF EXISTS DummyGroupOrdering_" + ExtraTableString, objCnn)
                objDB.sqlExecute("create table DummyGroupOrdering_" + ExtraTableString + " (GroupOrdering int NOT NULL AUTO_INCREMENT PRIMARY KEY, ProductGroupCode varchar(100))", objCnn)
                objDB.sqlExecute("insert into DummyGroupOrdering_" + ExtraTableString + " (ProductGroupCode) select distinct(ProductGroupCode) from ProductGroup order by ProductGroupCode", objCnn)

                objDB.sqlExecute("DROP TABLE IF EXISTS DummyDeptOrdering_" + ExtraTableString, objCnn)
                objDB.sqlExecute("create table DummyDeptOrdering_" + ExtraTableString + " (DeptOrdering int NOT NULL AUTO_INCREMENT PRIMARY KEY, ProductDeptCode varchar(100))", objCnn)
                objDB.sqlExecute("insert into DummyDeptOrdering_" + ExtraTableString + " (ProductDeptCode) select distinct(ProductDeptCode) from ProductDept order by ProductDeptCode", objCnn)

                sqlStatement = "SELECT a.TransactionStatusID,b.OtherFoodName,b.OrderStatusID,b.ProductSetType,b.VATType, p.ProductCode," + SaleModePName + ", pd.ProductDeptName,pg.ProductGroupName,pg.ProductGroupCode,pd.ProductDeptCode,g1.GroupOrdering,d1.DeptOrdering,b.SaleMode,sm.SaleModeName,sm.PositionPrefix,sm.PrefixText,SUM(b.Amount) AS Amount,SUM(c.TotalPrice) AS TotalPrice,SUM(IF(b.ProductSetType>=0,c.TotalRetailPrice,IF(b.ProductSetType=-4,c.SalePrice,0))) AS TotalRetailPrice,SUM(SalePrice) AS SalePrice, SUM(c.MemberDiscount) AS MemberDiscount, SUM(c.StaffDiscount) AS StaffDiscount, SUM(c.CouponDiscount) AS CouponDiscount, SUM(c.VoucherDiscount) AS VoucherDiscount, SUM(c.OtherPercentDiscount) AS OtherPercentDiscount, SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount, SUM(c.PricePromotionDiscount) AS PricePromotionDiscount FROM ordertransaction" + BranchStr + " a inner join orderdetail" + BranchStr + " b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID inner join orderdiscountdetail" + BranchStr + " c ON b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND b.OrderDetailID=c.OrderDetailID left outer join Products p ON b.ProductID=p.ProductID left outer join ProductDept pd ON p.ProductDeptID=pd.ProductDeptID left outer join ProductGroup pg ON pd.ProductGroupID=pg.ProductGroupID left outer join DummyGroupOrdering_" + ExtraTableString + " g1 on pg.ProductGroupCode=g1.ProductGroupCode left outer join DummyDeptOrdering_" + ExtraTableString + " d1 ON pd.ProductDeptCode=d1.ProductDeptCode left outer join SaleMode sm ON b.SaleMode=sm.SaleModeID WHERE a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3,14,16) AND a.TransactionStatusID=2 " + AdditionalQuery + "  GROUP BY a.TransactionStatusID,b.OtherFoodName,b.OrderStatusID,b.ProductSetType,b.VATType, p.ProductCode,p.ProductName, pd.ProductDeptName,pg.ProductGroupName,pg.ProductGroupCode,pd.ProductDeptCode,b.SaleMode,sm.SaleModeName,sm.PositionPrefix,sm.PrefixText ORDER BY g1.GroupOrdering,d1.DeptOrdering," + OrderingProduct

                sqlStatement1 = "select b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT, IsOtherReceipt from ordertransaction" + BranchStr + " a, paydetail" + BranchStr + " b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.PayTypeID=c.TypeID and a.TransactionStatusID=2 " + AdditionalQuery + " group by b.PayTypeID,c.PayType,IsSale, IsVAT, IsOtherReceipt order by b.PayTypeID,c.PayType,IsSale DESC"
                GetData = objDB.List(sqlStatement, objCnn)
                outputString = ""
                grandTotal = 0
                getReport.SaleReportByProduct(GraphData, outputString, grandTotal, VATTotal, ShowSummary, GrayBGColor, AdminBGColor, ShopID, ViewOption, StartDate, EndDate, GetData, objDB.List(sqlStatement1, objCnn), PayByCreditMoney, LangID, LangPath, objCnn)
                objDB.sqlExecute("DROP TABLE IF EXISTS DummyGroupOrdering_" + ExtraTableString, objCnn)
                objDB.sqlExecute("DROP TABLE IF EXISTS DummyDeptOrdering_" + ExtraTableString, objCnn)

                Return outputString
            Else
                sqlStatement = "SELECT c.OtherPercentDiscount AS OPercentDiscount, d.Amount AS AmountPaid, Round(d.PaymentVAT,2) AS AmountPaidVAT,a.TransactionID AS TID, a.ComputerID AS CID, b.OrderDetailID AS OID, a.*,b.OrderDetailID,b.ProductID,b.OtherFoodName,b.OrderStatusID,b.ProductSetType,b.Amount,b.VATType,b.StaffID AS ServiceStaffID,b.SubRoomID,b.StartTime,b.DurationTime,b.Price,IF(b.ProductSetType=-4,b.Price,b.RetailPrice) As RetailPrice,c.*,d.*,e.PayType,e.PayTypeCode,e.IsSale,e.IsVAT,e.IsOtherReceipt, CONCAT(s.StaffFirstName, ' ', s.StaffLastName) AS ReceivedBy, CONCAT(sv.StaffFirstName, ' ', sv.StaffLastName) AS VoidedBy, CONCAT(sd.StaffFirstName, ' ', sd.StaffLastName) AS StaffDiscountName, CONCAT(m.MemberFirstName, ' ', m.MemberLastName) AS MemberName,f.TotalProductSale, Round(a.TransactionVAT,2)-Round(a.TransactionExcludeVAT,2) AS TransactionIncludeVAT, IF(b.VATType=1 , IF(a.TransactionVAT = 0, c.SalePrice-(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale),(c.SalePrice-(Round(a.TransactionVAT,2)-Round(a.TransactionExcludeVAT,2)-Round(ServiceChargeVAT,2))*c.SalePrice/f.TotalProductSale)-(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale)), IF(b.VATType=2 and a.TransactionVAT=0,c.SalePrice+(Round(a.TransactionExcludeVAT,2)*c.SalePrice/f.TotalProductSale)-(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale),c.SalePrice-(c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale))) AS SalePriceBeforeVAT, IF(b.VATType=1, IF(a.TransactionVAT = 0, 0, (Round(a.TransactionVAT,2)-Round(a.TransactionExcludeVAT,2)-Round(ServiceChargeVAT,2))*c.SalePrice/f.TotalProductSale), IF(b.VATType=2,IF(a.TransactionVAT = 0, 0, Round(a.TransactionExcludeVAT,2)*c.SalePrice/f.TotalProductSale),0)) AS ProductVAT, p.ProductCode," + SaleModePName + ",bn.BankName AS CCBankName,cct.CreditCardType AS CCTypeName, c.SalePrice*a.OtherAmountDiscount/f.TotalProductSale AS CompensateOtherDiscount,DocumentTypeHeader,CouponDiscountID,CouponDiscountTypeID,MemberDiscountID,StaffDiscountID,MemberPriceGroupID,StaffPriceGroupID,ps.PromotionPriceName AS StaffPromotion,pm.PromotionPriceName AS MemberPromotion,t.TableName,t.TableNumber,t.TableID,obk.*,pt.PayType As CCGroupName FROM ordertransaction" + BranchStr + " a inner join orderdetail" + BranchStr + " b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID left outer join orderdiscountdetail" + BranchStr + " c ON  b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND b.OrderDetailID=c.OrderDetailID left outer join Staffs s ON a.PaidStaffID=s.StaffID left outer join Members m ON a.MemberDiscountID=m.MemberID left outer join PayDetail" + BranchStr + " d ON a.TransactionID=d.TransactionID AND a.ComputerID=d.ComputerID left outer join PayType e ON d.PayTypeID=e.TypeID left outer join DummySaleReport f ON a.TransactionID=f.TransactionID AND a.ComputerID=f.ComputerID AND b.VATType=f.VATType left outer join Products p ON b.ProductID=p.ProductID left outer join BankName bn ON d.BankName=bn.BankNameID left outer join CreditCardType cct ON d.CreditCardType=cct.CCTypeID left outer join Staffs sv ON a.VoidStaffID=sv.StaffID left outer join Staffs sd ON a.StaffDiscountID=sd.StaffID left outer join PromotionPriceGroup ps ON a.StaffPriceGroupID=ps.PriceGroupID left outer join PromotionPriceGroup pm ON a.MemberPriceGroupID=pm.PriceGroupID left outer join DocumentType dt ON a.DocType=dt.DocumentTypeID AND (a.CloseComputerID=dt.ComputerID OR a.ShopID=dt.ShopID) left outer join TableNo t ON a.TableID=t.TableID left outer join OrderBookRecord obk ON b.OrderDetailID=obk.OrderDetailID AND b.ComputerID=obk.ComputerID AND b.TransactionID=obk.TransactionID left outer join SaleMode sm ON b.SaleMode=sm.SaleModeID left outer join PayType pt ON d.SmartCardType=pt.TypeID WHERE a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3,14,16) AND dt.LangID=" + LangID.ToString + AdditionalQuery + " ORDER BY " + OrderBy
                GetData = objDB.List(sqlStatement, objCnn)
                objDB.sqlExecute("DROP TABLE IF EXISTS DummyPayment", objCnn)
                objDB.sqlExecute("create table DummyPayment (PayTypeID int, PayTypeName varchar(100), PayAmount decimal(18,4), PaymentVAT decimal(18,4), IsSale tinyint, IsVAT tinyint, PrepaidDiscountPercent decimal(5,2), IsOtherReceipt tinyint NOT NULL default '0' )", objCnn)

                Return getReport.SaleReportDetails(LangID, GrayBGColor, AdminBGColor, ShopID, ViewOption, StartDate, EndDate, GetData, PayByCreditMoney, DisplaySummary, LangPath, objCnn)
            End If


        Else
            Dim DisplayReceipt As Boolean = False
            If ReportByProduct = False And ReportByTime = False And ViewOption = 0 And ExpandReceipt = False Then DisplayReceipt = True
            Dim ExtraCriteria As String = ""
            If DisplayReceipt = False Then
                ExtraCriteria = "  AND a.TransactionStatusID=2"
            End If

            Dim PickText As String = ""
            Dim ReceiptIDText As String = ",a.ReceiptID As ReceiptID,a.ReceiptMonth As ReceiptMonth,a.ReceiptYear As ReceiptYear"
            Dim ReceiptGroupByText As String = ",a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"
            Dim ReceiptOrderText As String = ",a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"
            Dim ChkPickType As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramTypeID=1 AND PropertyID=30 AND KeyID=" + ShopID.ToString, objCnn)
            If ChkPickType.Rows.Count > 0 Then
				Select Case ChkPickType.Rows(0)("PropertyValue")
					Case 2,3,4
                    PickText = " inner join PickTransactionDetail pt ON a.TransactionID=pt.TransactionID AND a.ComputerID=pt.ComputerID "
                    ReceiptIDText = ",pt.ReceiptID As ReceiptID,pt.ReceiptMonth As ReceiptMonth,pt.ReceiptYear As ReceiptYear"
                    ReceiptGroupByText = ",pt.ReceiptYear,pt.ReceiptMonth,pt.ReceiptID"
                    ReceiptOrderText = ",pt.ReceiptYear,pt.ReceiptMonth,pt.ReceiptID"
				End Select 
            End If

            objDB.sqlExecute("DROP TABLE IF EXISTS DummySaleSummary", objCnn)
            objDB.sqlExecute("create table DummySaleSummary (TransactionID int, ComputerID int,Amount decimal(18,4),Price decimal(18,4),RetailPrice decimal(18,4),SalePrice decimal(18,4), MemberDiscount decimal(18,4), StaffDiscount decimal(18,4),CouponDiscount decimal(18,4),VoucherDiscount decimal(18,4),OtherPercentDiscount decimal(18,4),EachProductOtherDiscount decimal(18,4),PricePromotionDiscount decimal(18,4))", objCnn)
            objDB.sqlExecute("ALTER TABLE DummySaleSummary ADD PRIMARY KEY (TransactionID,ComputerID)", objCnn)
            sqlStatement = "select a.TransactionID,a.ComputerID,SUM(b.Amount) AS Amount,SUM(c.TotalPrice) AS Price,SUM(IF(b.ProductSetType >= 0, c.TotalRetailPrice, IF(b.ProductSetType=-4,c.SalePrice,0))) AS RetailPrice, SUM(c.SalePrice) AS SalePrice,SUM(c.MemberDiscount) AS MemberDiscount,SUM(c.StaffDiscount) AS StaffDiscount,SUM(c.CouponDiscount) AS CouponDiscount,SUM(c.VoucherDiscount) AS VoucherDiscount,SUM(c.OtherPercentDiscount) AS OtherPercentDiscount,SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount,SUM(c.PricePromotionDiscount) AS PricePromotionDiscount from OrderTransaction a inner join OrderDetail b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID inner join OrderDiscountDetail c ON b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND b.OrderDetailID=c.OrderDetailID " + PickText + " where a.ReceiptID > 0 AND b.ProductSetType NOT IN (-1,-3,14,16) " + AdditionalQuery + ExtraCriteria + " GROUP BY a.TransactionID,a.ComputerID"

            objDB.sqlExecute("insert into DummySaleSummary " + sqlStatement, objCnn)

            If NotInRevenueBit = True Then
                Dim SelectString, GroupByString As String
                SelectString = "a.TransactionID,a.ComputerID"
                GroupByString = "a.TransactionID,a.ComputerID"

                objDB.sqlExecute("DROP TABLE IF EXISTS DummyProductRevenue", objCnn)
                objDB.sqlExecute("create table DummyProductRevenue (TransactionID int, ComputerID int, TotalNotInRevenue1 decimal(18,4))", objCnn)
                objDB.sqlExecute("ALTER TABLE DummyProductRevenue ADD INDEX DummyRevenueIndex (TransactionID,ComputerID)", objCnn)
                sqlStatement = "select " + SelectString + ",SUM(c.SalePrice) AS TotalNotInRevenue1 FROM OrderTransaction a, OrderDetail b, OrderDiscountDetail c, ProductType pt where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.OrderDetailID=c.OrderDetailID AND b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND b.ProductSetType=pt.ProductTypeID AND a.ReceiptID > 0 AND a.TransactionStatusID=2 AND pt.NotInRevenue=1 " + AdditionalQuery + " group by " + GroupByString
                objDB.sqlExecute("insert into DummyProductRevenue " + sqlStatement, objCnn)

                objDB.sqlExecute("DROP TABLE IF EXISTS DummyProductRevenue1", objCnn)
                objDB.sqlExecute("create table DummyProductRevenue1 (TransactionID int, ComputerID int, TotalNotInRevenue2 decimal(18,4))", objCnn)
                objDB.sqlExecute("ALTER TABLE DummyProductRevenue1 ADD INDEX DummyRevenueIndex1 (TransactionID,ComputerID)", objCnn)
                sqlStatement = "select " + SelectString + ",SUM(c.SalePrice) AS TotalNotInRevenue2 FROM OrderTransaction a, OrderDetail b, OrderDiscountDetail c, ProductType pt where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.OrderDetailID=c.OrderDetailID AND b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND b.ProductSetType=pt.ProductTypeID AND a.ReceiptID > 0 AND a.TransactionStatusID=2 AND pt.NotInRevenue=2 " + AdditionalQuery + " group by " + GroupByString
                objDB.sqlExecute("insert into DummyProductRevenue1 " + sqlStatement, objCnn)

                objDB.sqlExecute("DROP TABLE IF EXISTS DummyUsedPackage", objCnn)
                objDB.sqlExecute("create table DummyUsedPackage (TransactionID int, ComputerID int, TotalUsedPackage decimal(18,4))", objCnn)
                objDB.sqlExecute("ALTER TABLE DummyUsedPackage ADD INDEX DummyUsedPackageIndex (TransactionID,ComputerID)", objCnn)
                Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel where ProductLevelID IN (" + ShopIDListValue + ")", objCnn)
                Dim DisplayVATType As String = "E"
                For ii = 0 To ShopInfo.Rows.Count - 1
                    If ShopInfo.Rows(ii)("DisplayReceiptVATableType") = 1 Then
                        DisplayVATType = "V"
                    End If
                Next

                If DisplayVATType = "E" Then
                    sqlStatement = "select " + SelectString + ",SUM(c.CommissionPrice) AS TotalUsedPackage FROM OrderTransaction a, OrderDetail b, PackageHistory c where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.OrderDetailID=c.OrderDetailID AND b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND a.ReceiptID > 0 AND a.TransactionStatusID=2 AND c.PackageStatus=1 " + AdditionalQuery + " group by " + GroupByString
                Else
                    sqlStatement = "select " + SelectString + ",SUM(c.CommissionPrice+c.CommissionPriceVAT) AS TotalUsedPackage FROM OrderTransaction a, OrderDetail b, PackageHistory c where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.OrderDetailID=c.OrderDetailID AND b.TransactionID=c.TransactionID AND b.ComputerID=c.ComputerID AND a.ReceiptID > 0 AND a.TransactionStatusID=2 AND c.PackageStatus=1 " + AdditionalQuery + " group by " + GroupByString
                End If
                objDB.sqlExecute("insert into DummyUsedPackage " + sqlStatement, objCnn)

                If DisplayReceipt = True Then
                    ExtraSelect += ",r.TotalNotInRevenue1,r1.TotalNotInRevenue2,TotalUsedPackage"
                Else
                    ExtraSelect += ",SUM(r.TotalNotInRevenue1) AS TotalNotInRevenue1,SUM(r1.TotalNotInRevenue2) AS TotalNotInRevenue2,SUM(up.TotalUsedPackage) AS TotalUsedPackage"
                End If
                ExtraSql += " left outer join DummyProductRevenue r ON a.TransactionID=r.TransactionID AND a.ComputerID=r.ComputerID left outer join DummyProductRevenue1 r1 ON a.TransactionID=r1.TransactionID AND a.ComputerID=r1.ComputerID left outer join DummyUsedPackage up ON a.TransactionID=up.TransactionID AND a.ComputerID=up.ComputerID "
            End If

            If DisplayReceipt = True Then
                objDB.sqlExecute("DROP TABLE IF EXISTS DummyDocType", objCnn)
                objDB.sqlExecute("create table DummyDocType (DocumentTypeID int, ComputerID int, DocumentTypeHeader varchar(50))", objCnn)
                objDB.sqlExecute("insert into DummyDocType select DocumentTypeID,ComputerID,DocumentTypeHeader from DocumentType where DocumentTypeID=11 AND langid=" + LangID.ToString, objCnn)


                sqlStatement = "select CONCAT('T=',a.TransactionID,':C=',a.ComputerID) AS SaleDate,a.TransactionID,a.ComputerID,a.TransactionStatusID" + ReceiptIDText + ",a.DocType,dt.DocumentTypeHeader,ft.ReceiptID AS FReceiptID,ft.ReceiptMonth AS FReceiptMonth,ft.ReceiptYear AS FReceiptYear,dt1.DocumentTypeHeader AS DocTypeHeader,SUM(Round(a.TransactionVATable,2)) AS TransactionVATable,count(distinct a.TransactionID,a.ComputerID) AS TotalBill,SUM(a.NoCustomer) AS TotalCustomer,SUM(a.OtherAmountDiscount) AS OtherAmountDiscount,SUM(Round(a.TransactionVAT,2)) AS TransactionVAT,SUM(Round(a.TransactionExcludeVAT,2)) AS TransactionExcludeVAT,SUM(Round(a.ServiceCharge,2)) AS ServiceCharge,SUM(Round(a.ServiceChargeVAT,2)) AS ServiceChargeVAT,SUM(c.Amount) AS Amount,SUM(c.Price) AS Price,SUM(c.RetailPrice) AS RetailPrice, SUM(c.SalePrice) AS SalePrice,SUM(c.MemberDiscount) AS MemberDiscount,SUM(c.StaffDiscount) AS StaffDiscount,SUM(c.CouponDiscount) AS CouponDiscount,SUM(c.VoucherDiscount) AS VoucherDiscount,SUM(c.OtherPercentDiscount) AS OtherPercentDiscount,SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount,SUM(c.PricePromotionDiscount) AS PricePromotionDiscount,a.TableID,t.TableNumber,t.TableName" + ExtraSelect + " FROM OrderTransaction a inner join DummySaleSummary c ON a.TransactionID=c.TransactionID AND a.ComputerID=c.ComputerID left outer join DocumentType dt ON a.DocType=dt.DocumentTypeID AND (a.CloseComputerID=dt.ComputerID OR a.ShopID=dt.ShopID) left outer join OrderTransactionFullTaxInvoice" + BranchStr + " ft ON a.TransactionID=ft.TransactionID AND a.ComputerID=ft.ComputerID AND ft.FullTaxStatus=2 left outer join DummyDocType dt1 ON ft.DocType=dt1.DocumentTypeID AND ft.CloseComputerID=dt1.ComputerID left outer join TableNo t ON a.TableID=t.TableID  " + PickText + ExtraSql + " where a.ReceiptID > 0 AND dt.LangID=" + LangID.ToString + " group by a.TransactionID,a.ComputerID,a.TransactionStatusID" + ReceiptGroupByText + ",a.DocType Order By a.DocType" + ReceiptOrderText

                sqlStatement2 = "select CONCAT('T=',a.TransactionID,':C=',a.ComputerID) AS SaleDate,a.TransactionID,a.ComputerID,a.TransactionStatusID,a.DocType,b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT from ordertransaction a inner join paydetail b ON a.transactionid=b.transactionid and a.computerid=b.computerid inner join paytype c ON b.PayTypeID=c.TypeID inner join DummySaleSummary d on a.TransactionID=d.TransactionID and a.ComputerID=d.ComputerID where  0=0  " + AdditionalQuery + " group by b.PayTypeID,c.PayType,IsSale,IsVAT,a.TransactionID,a.ComputerID,a.DocType,a.TransactionStatusID "

            ElseIf ReportByTime = True Then
                If GroupByParam = 1 Then
                    sqlStatement = "select DAYNAME(a.SaleDate) AS SaleDate,SUM(Round(a.TransactionVATable,2)) AS TransactionVATable,count(distinct a.TransactionID,a.ComputerID) AS TotalBill,SUM(a.NoCustomer) AS TotalCustomer,SUM(a.OtherAmountDiscount) AS OtherAmountDiscount,SUM(Round(a.TransactionVAT,2)) AS TransactionVAT,SUM(Round(a.TransactionExcludeVAT,2)) AS TransactionExcludeVAT,SUM(Round(a.ServiceCharge,2)) AS ServiceCharge,SUM(Round(a.ServiceChargeVAT,2)) AS ServiceChargeVAT,SUM(c.Amount) AS Amount,SUM(c.Price) AS Price,SUM(c.RetailPrice) AS RetailPrice, SUM(c.SalePrice) AS SalePrice,SUM(c.MemberDiscount) AS MemberDiscount,SUM(c.StaffDiscount) AS StaffDiscount,SUM(c.CouponDiscount) AS CouponDiscount,SUM(c.VoucherDiscount) AS VoucherDiscount,SUM(c.OtherPercentDiscount) AS OtherPercentDiscount,SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount,SUM(c.PricePromotionDiscount) AS PricePromotionDiscount" + ExtraSelect + " FROM OrderTransaction a, DummySaleSummary c " + ExtraSql + " where a.TransactionID=c.TransactionID AND a.ComputerID=c.ComputerID group by WEEKDAY(a.SaleDate) Order By WEEKDAY(a.SaleDate)"

                    sqlStatement2 = "select DAYNAME(a.SaleDate) AS SaleDate,b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT from ordertransaction" + BranchStr + " a, paydetail" + BranchStr + " b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.PayTypeID=c.TypeID and a.TransactionStatusID=2 " + AdditionalQuery + " group by b.PayTypeID,c.PayType,IsSale,IsVAT,WEEKDAY(a.SaleDate) order by WEEKDAY(a.SaleDate),b.PayTypeID"
                Else
                    sqlStatement = "select HOUR(a.OpenTime) AS SaleDate,SUM(Round(a.TransactionVATable,2)) AS TransactionVATable,count(distinct a.TransactionID,a.ComputerID) AS TotalBill,SUM(a.NoCustomer) AS TotalCustomer,SUM(a.OtherAmountDiscount) AS OtherAmountDiscount,SUM(Round(a.TransactionVAT,20)) AS TransactionVAT,SUM(Round(a.TransactionExcludeVAT,2)) AS TransactionExcludeVAT,SUM(Round(a.ServiceCharge,2)) AS ServiceCharge,SUM(Round(a.ServiceChargeVAT,2)) AS ServiceChargeVAT,SUM(c.Amount) AS Amount,SUM(c.Price) AS Price,SUM(c.RetailPrice) AS RetailPrice, SUM(c.SalePrice) AS SalePrice,SUM(c.MemberDiscount) AS MemberDiscount,SUM(c.StaffDiscount) AS StaffDiscount,SUM(c.CouponDiscount) AS CouponDiscount,SUM(c.VoucherDiscount) AS VoucherDiscount,SUM(c.OtherPercentDiscount) AS OtherPercentDiscount,SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount,SUM(c.PricePromotionDiscount) AS PricePromotionDiscount" + ExtraSelect + " FROM OrderTransaction a, DummySaleSummary c " + ExtraSql + " where a.TransactionID=c.TransactionID AND a.ComputerID=c.ComputerID group by HOUR(a.OpenTime) Order By HOUR(a.OpenTime)"

                    sqlStatement2 = "select HOUR(a.OpenTime) AS SaleDate,b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT from ordertransaction" + BranchStr + " a, paydetail" + BranchStr + " b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.PayTypeID=c.TypeID and a.TransactionStatusID=2 " + AdditionalQuery + " group by b.PayTypeID,c.PayType,IsSale,IsVAT,HOUR(a.OpenTime) order by HOUR(a.OpenTime),b.PayTypeID"
                End If
            Else
                If ViewOption = 4 Then
                    sqlStatement = "select DATE_FORMAT(a.SaleDate,'%M') AS SaleDate,SUM(Round(a.TransactionVATable,2)) AS TransactionVATable,count(distinct a.TransactionID,a.ComputerID) AS TotalBill,SUM(a.NoCustomer) AS TotalCustomer,SUM(a.OtherAmountDiscount) AS OtherAmountDiscount,SUM(Round(a.TransactionVAT,2)) AS TransactionVAT,SUM(Round(a.TransactionExcludeVAT,2)) AS TransactionExcludeVAT,SUM(Round(a.ServiceCharge,2)) AS ServiceCharge,SUM(Round(a.ServiceChargeVAT,2)) AS ServiceChargeVAT,SUM(c.Amount) AS Amount,SUM(c.Price) AS Price,SUM(c.RetailPrice) AS RetailPrice, SUM(c.SalePrice) AS SalePrice,SUM(c.MemberDiscount) AS MemberDiscount,SUM(c.StaffDiscount) AS StaffDiscount,SUM(c.CouponDiscount) AS CouponDiscount,SUM(c.VoucherDiscount) AS VoucherDiscount,SUM(c.OtherPercentDiscount) AS OtherPercentDiscount,SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount,SUM(c.PricePromotionDiscount) AS PricePromotionDiscount" + ExtraSelect + " FROM OrderTransaction a, DummySaleSummary c " + ExtraSql + " where a.TransactionID=c.TransactionID AND a.ComputerID=c.ComputerID group by MONTH(a.SaleDate) Order By MONTH(a.SaleDate)"

                    sqlStatement2 = "select DATE_FORMAT(a.SaleDate,'%M') AS SaleDate,b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT from ordertransaction" + BranchStr + " a, paydetail" + BranchStr + " b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.PayTypeID=c.TypeID and a.TransactionStatusID=2 " + AdditionalQuery + " group by b.PayTypeID,c.PayType,IsSale,IsVAT,MONTH(a.SaleDate) order by MONTH(a.SaleDate),b.PayTypeID"
                Else
                    sqlStatement = "select a.SaleDate,SUM(Round(a.TransactionVATable,2)) AS TransactionVATable,count(distinct a.TransactionID,a.ComputerID) AS TotalBill,SUM(a.NoCustomer) AS TotalCustomer,SUM(a.OtherAmountDiscount) AS OtherAmountDiscount,SUM(Round(a.TransactionVAT,2)) AS TransactionVAT,SUM(Round(a.TransactionExcludeVAT,2)) AS TransactionExcludeVAT,SUM(Round(a.ServiceCharge,2)) AS ServiceCharge,SUM(Round(a.ServiceChargeVAT,2)) AS ServiceChargeVAT,SUM(c.Amount) AS Amount,SUM(c.Price) AS Price,SUM(c.RetailPrice) AS RetailPrice, SUM(c.SalePrice) AS SalePrice,SUM(c.MemberDiscount) AS MemberDiscount,SUM(c.StaffDiscount) AS StaffDiscount,SUM(c.CouponDiscount) AS CouponDiscount,SUM(c.VoucherDiscount) AS VoucherDiscount,SUM(c.OtherPercentDiscount) AS OtherPercentDiscount,SUM(c.EachProductOtherDiscount) AS EachProductOtherDiscount,SUM(c.PricePromotionDiscount) AS PricePromotionDiscount" + ExtraSelect + " FROM OrderTransaction a, DummySaleSummary c " + ExtraSql + " where a.TransactionID=c.TransactionID AND a.ComputerID=c.ComputerID Group by a.SaleDate Order By a.SaleDate"

                    sqlStatement2 = "select a.SaleDate,b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT from ordertransaction" + BranchStr + " a, paydetail" + BranchStr + " b, paytype c, DummySaleSummary d where a.transactionid=b.transactionid and a.computerid=b.computerid and b.PayTypeID=c.TypeID and a.TransactionID=d.TransactionID and a.ComputerID=d.ComputerID and a.TransactionStatusID=2 " + AdditionalQuery + " group by b.PayTypeID,c.PayType,IsSale,IsVAT,a.SaleDate order by a.SaleDate,b.PayTypeID"

                End If
            End If
            sqlStatement1 = "select b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT, IsOtherReceipt from ordertransaction" + BranchStr + " a, paydetail" + BranchStr + " b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.PayTypeID=c.TypeID and a.TransactionStatusID=2 " + AdditionalQuery + " group by b.PayTypeID,c.PayType,IsSale,IsVAT, IsOtherReceipt order by b.PayTypeID,c.PayType,IsSale DESC"
            GetData = objDB.List(sqlStatement, objCnn)
            PayTypeData = objDB.List(sqlStatement2, objCnn)

			dim strSQL as string 
			            strSQL = sqlStatement
            strSQL = "Insert INTO ErrorLog(ErrorMessage, ErrorTime) VALUES('" & Replace(strSQL, "'", "''") & "', {ts '" & Now.Year & Format(Now, "-MM-dd HH:mm:ss") & "'})"
               objDB.sqlExecute(strSQL, objCnn)

			
			
			
			
			
			
            ResultString = SaleReportByDate_B2(GraphData, GrayBGColor, AdminBGColor, ShopID, ViewOption, StartDate, EndDate, GetData, objDB.List(sqlStatement1, objCnn), PayByCreditMoney, PayTypeList, PayTypeData, DisplayGraph, DisplayReceipt, LangID, LangPath, objCnn)

        '    objDB.sqlExecute("DROP TABLE IF EXISTS DummyDocType", objCnn)
        '    objDB.sqlExecute("DROP TABLE IF EXISTS DummySaleSummary", objCnn)
        '    objDB.sqlExecute("DROP TABLE IF EXISTS DummyNoVAT", objCnn)
        '    objDB.sqlExecute("DROP TABLE IF EXISTS DummyProductRevenue", objCnn)
        '    objDB.sqlExecute("DROP TABLE IF EXISTS DummyProductRevenue1", objCnn)
        '    objDB.sqlExecute("DROP TABLE IF EXISTS DummyUsedPackage", objCnn)
          '  objDB.sqlExecute("DROP TABLE IF EXISTS DummyGroupOrdering_" + ExtraTableString, objCnn)
         '   objDB.sqlExecute("DROP TABLE IF EXISTS DummyDeptOrdering_" + ExtraTableString, objCnn)
            Return ResultString
        End If

    End Function
	
	   Public Function SaleReportByDate_B2(ByRef GraphData As DataSet, ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal ShopID As Integer, ByVal ViewOption As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal dtTable As DataTable, ByVal PaymentResult As DataTable, ByVal PayByCreditMoney As DataTable, ByVal PayTypeList As DataTable, ByVal PayTypeData As DataTable, ByVal displaygraph As Boolean, ByVal DisplayReceipt As Boolean, ByVal LangID As Integer, ByVal LangPath As String, ByVal objCnn As MySqlConnection) As String
        Dim FormatData As DataTable = Fm.FormatParam(FormatObject, LangID, objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
        Dim getInfo As New CCategory
        Dim getProp As New CPreferences
        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
        Dim i, j, k, z As Integer
        Dim outputString As StringBuilder = New StringBuilder
        Dim TotalProductDiscount As Double = 0
        Dim TotalSale As Double
        Dim grandTotalRetailPrice As Double = 0
        Dim grandTotalDiscount As Double = 0
        Dim grandTotalServiceCharge As Double = 0
        Dim grandTotalServiceChargeVAT As Double = 0
        Dim grandTotalBeforeVAT As Double = 0
        Dim grandTotalVAT As Double = 0
        Dim grandTotalAfterVAT As Double = 0
        Dim grandTotalBill As Integer = 0
        Dim grandTotalCustomer As Integer = 0
        Dim grandTotalVoid As Double = 0
        Dim totalEachPayment As Double = 0
        Dim totalEachPaymentPrepaid As Double = 0
        Dim totalEachPaymentDiscount As Double = 0
        Dim grandPayment As Double = 0
        Dim grandTotalPaymentDiscount As Double = 0
        Dim grandTotalVatable As Double = 0
        Dim grandTotalBillVAT As Double = 0
        Dim sqlStatement As String
        Dim HavePrepaid As Boolean = False
        Dim HavePrepaidDiscount As Boolean = False
        Dim DiscountArray(7) As Double
        Dim SumPayment(PayTypeList.Rows.Count - 1) As Double
        Dim SumPaymentDiscount(PayTypeList.Rows.Count - 1) As Double
        For j = 0 To PayTypeList.Rows.Count - 1
            SumPayment(j) = 0
            SumPaymentDiscount(j) = 0
            If PayTypeList.Rows(j)("IsSale") = 0 Then
                If PropertyInfo.Rows(0)("SummaryPrepaidInSaleReport") = 1 Then
                    HavePrepaid = True
                End If
            End If
            If PayTypeList.Rows(j)("PrepaidDiscountPercent") > 0 Then
                HavePrepaidDiscount = True
            End If
        Next

        Dim LangData2 As DataTable = pRoMiSeLanguage.pRoMiSeLanguage.LangInfo(6, 2, -1, LangPath)
        Dim LangText As String = "lang" + LangID.ToString

        Dim table As DataTable = GraphData.Tables.Add("Data")
        table.Columns.Add("Description")
        table.Columns.Add("Value1", GetType(Double))
        Dim DisplayString As String
        Dim ToTime As Integer
        Dim FoundPayType As Boolean
        Dim TextClass As String
        Dim TestString As String

        Dim AdditionalHeaderText, HText, RText, VoidText As String
        Dim FullText As String = ""

        Dim ReceiptHeaderData As DataTable
        Dim TestingHeaderData As DataTable
        Dim TestingHeaderText As String = ""

        Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel where ProductLevelID=" + ShopID.ToString, objCnn)
        Dim DisplayVATType As String = "V"
        If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
            DisplayVATType = "E"
        End If
        Dim ShowTable As Boolean = False
        If ShopInfo.Rows(0)("ShopType") = 1 Then
            ShowTable = True
        End If

        If DisplayReceipt = True Then

            ReceiptHeaderData = getInfo.GetDocType(1, 0, 8, 1, objCnn)

            If ReceiptHeaderData.Rows.Count > 0 Then
                If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
                    AdditionalHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
                End If
            End If

            TestingHeaderData = getInfo.GetDocType(1, 0, 35, 1, objCnn)
            If TestingHeaderData.Rows.Count > 0 Then
                TestingHeaderText = TestingHeaderData.Rows(0)("DocumentTypeHeader")
            End If
        End If

        Dim totalNotInRevenueEach As Double
        Dim NotInRevenueBit As Boolean = False

        Try
            NotInRevenueBit = PropertyInfo.Rows(0)("EnableNotInRevenue")
            If NotInRevenueBit = True Then
                HavePrepaidDiscount = True
            End If
        Catch ex As Exception
            NotInRevenueBit = False
        End Try

        Dim NotInRevenueData As DataTable = getReport.NotInRevenueType(objCnn)
        Dim grandTotalNotInRevenue(NotInRevenueData.Rows.Count - 1) As Double
        Dim totalNotInRevenue As Double = 0
        Dim x As Integer
        For x = 0 To NotInRevenueData.Rows.Count - 1
            grandTotalNotInRevenue(x) = 0
        Next
        Dim grandTotalUsedPackage As Double = 0
        Dim totalUsedPackage As Double = 0
        Dim DataMatch As Boolean = False
        Dim TotalSaleAvg As Double
        For i = 0 To dtTable.Rows.Count - 1

            TotalProductDiscount = 0
            If DisplayReceipt = True Then
                If dtTable.Rows(i)("TransactionStatusID") = 2 Then
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
                    If Not IsDBNull(dtTable.Rows(i)("OtherAmountDiscount")) Then
                        TotalProductDiscount += dtTable.Rows(i)("OtherAmountDiscount")
                        DiscountArray(6) += dtTable.Rows(i)("OtherAmountDiscount")
                    End If
                    If Not IsDBNull(dtTable.Rows(i)("PricePromotionDiscount")) Then
                        TotalProductDiscount += dtTable.Rows(i)("PricePromotionDiscount")
                        DiscountArray(1) += dtTable.Rows(i)("PricePromotionDiscount")
                    End If
                    If Not IsDBNull(dtTable.Rows(i)("RetailPrice")) And Not IsDBNull(dtTable.Rows(i)("Price")) Then
                        TotalProductDiscount += dtTable.Rows(i)("RetailPrice") - dtTable.Rows(i)("Price")
                        DiscountArray(1) += dtTable.Rows(i)("RetailPrice") - dtTable.Rows(i)("Price")
                    End If
                End If
            Else
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
                If Not IsDBNull(dtTable.Rows(i)("OtherAmountDiscount")) Then
                    TotalProductDiscount += dtTable.Rows(i)("OtherAmountDiscount")
                    DiscountArray(6) += dtTable.Rows(i)("OtherAmountDiscount")
                End If
                If Not IsDBNull(dtTable.Rows(i)("PricePromotionDiscount")) Then
                    TotalProductDiscount += dtTable.Rows(i)("PricePromotionDiscount")
                    DiscountArray(1) += dtTable.Rows(i)("PricePromotionDiscount")
                End If
                If Not IsDBNull(dtTable.Rows(i)("RetailPrice")) And Not IsDBNull(dtTable.Rows(i)("Price")) Then
                    TotalProductDiscount += dtTable.Rows(i)("RetailPrice") - dtTable.Rows(i)("Price")
                    DiscountArray(1) += dtTable.Rows(i)("RetailPrice") - dtTable.Rows(i)("Price")
                End If
            End If


            TotalSale = dtTable.Rows(i)("RetailPrice") + dtTable.Rows(i)("TransactionExcludeVAT") + dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT") - TotalProductDiscount
            Dim row As DataRow = table.NewRow()
            If IsDate(dtTable.Rows(i)("SaleDate")) Then
                row("Description") = Day(dtTable.Rows(i)("SaleDate"))
                DisplayString = DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly", LangID, objCnn)
            ElseIf IsNumeric(dtTable.Rows(i)("SaleDate")) Then
                ToTime = dtTable.Rows(i)("SaleDate") + 1
                row("Description") = dtTable.Rows(i)("SaleDate").ToString + " - " + ToTime.ToString
                DisplayString = dtTable.Rows(i)("SaleDate").ToString + " - " + ToTime.ToString
            ElseIf dtTable.Columns.Contains("TransactionID") Then
                HText = ""
                If dtTable.Rows(i)("DocType") = 37 Then
                    If Not IsDBNull(dtTable.Rows(i)("DocumentTypeHeader")) Then
                        HText = dtTable.Rows(i)("DocumentTypeHeader")
                    End If
                Else
                    If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
                        If Not IsDBNull(dtTable.Rows(i)("DocumentTypeHeader")) Then
                            HText = dtTable.Rows(i)("DocumentTypeHeader")
                        End If
                    Else
                        If dtTable.Rows(i)("DocType") = 35 Then
                            HText = TestingHeaderText
                        Else
                            HText = AdditionalHeaderText
                        End If

                    End If
                End If

                If IsDBNull(dtTable.Rows(i)("ReceiptID")) Or IsDBNull(dtTable.Rows(i)("ReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("ReceiptYear")) Then
                    RText = "-"
                Else
                    RText = FormatDocNumber.GetReceiptHeader(HText, dtTable.Rows(i)("ReceiptYear"), dtTable.Rows(i)("ReceiptMonth"), dtTable.Rows(i)("ReceiptID"))
                End If
                If Not IsDBNull(dtTable.Rows(i)("DocTypeHeader")) Then
                    FullText = "<br>" + FormatDocNumber.GetReceiptHeader(dtTable.Rows(i)("DocTypeHeader"), dtTable.Rows(i)("FReceiptYear"), dtTable.Rows(i)("FReceiptMonth"), dtTable.Rows(i)("FReceiptID"))
                Else
                    FullText = ""
                End If
                If RText <> "-" Then
                    DisplayString = "<a class=""smallText"" href=""JavaScript: newWindow = window.open( 'BillDetails.aspx?ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "&ShopID=" + ShopID.ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & RText & "</a>" & VoidText & FullText
                Else
                    DisplayString = RText & VoidText
                End If
                row("Description") = DisplayString
            Else
                row("Description") = dtTable.Rows(i)("SaleDate")
                DisplayString = dtTable.Rows(i)("SaleDate")
            End If
            row("Value1") = TotalSale
            table.Rows.Add(row)

            If DisplayReceipt = True Then
                If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                    TextClass = "smallText"
                    grandTotalRetailPrice += dtTable.Rows(i)("RetailPrice") ' + dtTable.Rows(i)("TransactionExcludeVAT")
                    grandTotalDiscount += TotalProductDiscount
                    grandTotalServiceCharge += dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT")
                    grandTotalServiceChargeVAT += dtTable.Rows(i)("ServiceChargeVAT")
                    grandTotalBeforeVAT += TotalSale - dtTable.Rows(i)("TransactionVAT")
                    grandTotalVAT += dtTable.Rows(i)("TransactionVAT")
                    grandTotalAfterVAT += TotalSale
                    grandTotalVatable += dtTable.Rows(i)("TransactionVATable")
                    grandTotalBillVAT += dtTable.Rows(i)("ServiceChargeVAT") + dtTable.Rows(i)("TransactionExcludeVAT")
                    grandTotalCustomer += dtTable.Rows(i)("TotalCustomer")
                    grandTotalBill += dtTable.Rows(i)("TotalBill")
                Else
                    TextClass = "smallRedText"
                    DisplayString += " " + LangData2.Rows(96)(LangText)
                End If
            Else
                TextClass = "smallText"
                grandTotalRetailPrice += dtTable.Rows(i)("RetailPrice") '+ dtTable.Rows(i)("TransactionExcludeVAT")
                grandTotalDiscount += TotalProductDiscount
                grandTotalServiceCharge += dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT")
                grandTotalServiceChargeVAT += dtTable.Rows(i)("ServiceChargeVAT")
                grandTotalBeforeVAT += TotalSale - dtTable.Rows(i)("TransactionVAT")
                grandTotalVAT += dtTable.Rows(i)("TransactionVAT")
                grandTotalAfterVAT += TotalSale
                grandTotalVatable += dtTable.Rows(i)("TransactionVATable")
                grandTotalBillVAT += dtTable.Rows(i)("ServiceChargeVAT") + dtTable.Rows(i)("TransactionExcludeVAT")
                grandTotalCustomer += dtTable.Rows(i)("TotalCustomer")
                grandTotalBill += dtTable.Rows(i)("TotalBill")
            End If

            outputString = outputString.Append("<tr bgColor=""" + "white" + """>")
            outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + DisplayString + "</td>")
            If DisplayReceipt = True And ShowTable = True Then
                'outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + dtTable.Rows(i)("TableName") + "</td>")
            End If

            If DisplayReceipt = False Then
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TotalBill")).ToString(FormatObject.QtyFormat, ci) + "</td>")
            End If
            If ShowTable = True Then
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TotalCustomer")).ToString(FormatObject.QtyFormat, ci) + "</td>")
            End If

            'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("RetailPrice")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalProductDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
           ' outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("RetailPrice") - TotalProductDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            If DisplayVATType = "V" Then
                TotalSaleAvg = TotalSale
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TransactionVATable")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TransactionVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            Else
                TotalSaleAvg = TotalSale - dtTable.Rows(i)("TransactionExcludeVAT") - dtTable.Rows(i)("ServiceChargeVAT")
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("ServiceCharge")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalSale - dtTable.Rows(i)("TransactionExcludeVAT") - dtTable.Rows(i)("ServiceChargeVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TransactionExcludeVAT") + dtTable.Rows(i)("ServiceChargeVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TransactionVATable") - dtTable.Rows(i)("TransactionVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TransactionVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")

            End If


            totalEachPayment = 0
            totalEachPaymentPrepaid = 0
            totalEachPaymentDiscount = 0

            For j = 0 To PayTypeList.Rows.Count - 1
                FoundPayType = False
                For k = 0 To PayTypeData.Rows.Count - 1
                    DataMatch = False
                    If dtTable.Columns.Contains("TransactionID") Then
                        If dtTable.Rows(i)("TransactionID") = PayTypeData.Rows(k)("TransactionID") And dtTable.Rows(i)("ComputerID") = PayTypeData.Rows(k)("ComputerID") Then
                            DataMatch = True
                        End If
                    ElseIf dtTable.Columns.Contains("ShopID") Then
                        If dtTable.Rows(i)("ShopID") = PayTypeData.Rows(k)("ShopID") Then
                            DataMatch = True
                        End If
                    Else
                        If dtTable.Rows(i)("SaleDate").ToString = PayTypeData.Rows(k)("SaleDate").ToString Then
                            DataMatch = True
                        End If
                    End If
                    If PayTypeData.Rows(k)("PayTypeID") = PayTypeList.Rows(j)("PayTypeID") And DataMatch = True Then
                        If DisplayReceipt = True Then
                            If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                                TextClass = "smallText"
                                SumPayment(j) += PayTypeData.Rows(k)("TotalPay")
                                SumPaymentDiscount(j) += PayTypeData.Rows(k)("TotalPayDiscount")
                                grandPayment += PayTypeData.Rows(k)("TotalPay")
                            Else
                                TextClass = "smallRedText"
                            End If
                        Else
                            TextClass = "smallText"
                            SumPayment(j) += PayTypeData.Rows(k)("TotalPay")
                            SumPaymentDiscount(j) += PayTypeData.Rows(k)("TotalPayDiscount")
                            grandPayment += PayTypeData.Rows(k)("TotalPay")
                        End If
                        If PayTypeData.Rows(k)("IsSale") = 1 Then
                            'TextClass = "smallText"
                        Else
                            'TextClass = "smallText"
                            totalEachPaymentPrepaid += PayTypeData.Rows(k)("TotalPay")
                        End If
                        If PayTypeData.Rows(k)("TotalPayDiscount") > 0 Then
                            'outputString = outputString.Append("<td bgColor=""#ccffff"" align=""right"" class=""" + TextClass + """>" + CDbl(PayTypeData.Rows(k)("TotalPay")).ToString(FormatObject.CurrencyFormat, ci) + "/" + CDbl(PayTypeData.Rows(k)("TotalPayDiscount")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                        Else
                            'outputString = outputString.Append("<td bgColor=""#ccffff"" align=""right"" class=""" + TextClass + """>" + CDbl(PayTypeData.Rows(k)("TotalPay")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                        End If
                        totalEachPaymentDiscount += PayTypeData.Rows(k)("TotalPayDiscount")
                        totalEachPayment += PayTypeData.Rows(k)("TotalPay")
                        FoundPayType = True
                    End If
                Next
                If FoundPayType = False Then
                    'outputString = outputString.Append("<td bgColor=""#ccffff"" align=""right"" class=""smallText"">-</td>")
                End If
            Next

            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(totalEachPayment).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            If Math.Round(TotalSale, 2) - Math.Round(totalEachPayment, 2) <> 0 Then
                If DisplayReceipt = True Then
                    If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                        'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(totalEachPayment - TotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    Else
                        'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>-</td>")
                    End If
                Else
                    'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(totalEachPayment - TotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                End If

            Else
               ' outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>-</td>")
            End If

           ' outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalSaleAvg / dtTable.Rows(i)("TotalBill")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            If ShowTable = True Then
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalSaleAvg / dtTable.Rows(i)("TotalCustomer")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            End If


            If NotInRevenueBit = True Then
                totalNotInRevenueEach = 0
                totalUsedPackage = 0
                For x = 0 To NotInRevenueData.Rows.Count - 1

                    If Not IsDBNull(dtTable.Rows(i)("TotalNotInRevenue" & NotInRevenueData.Rows(x)("NotInRevenueID").ToString)) Then
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>(" + CDbl(dtTable.Rows(i)("TotalNotInRevenue" & NotInRevenueData.Rows(x)("NotInRevenueID").ToString)).ToString(FormatObject.CurrencyFormat, ci) + ")</td>")
                        totalNotInRevenueEach += dtTable.Rows(i)("TotalNotInRevenue" & NotInRevenueData.Rows(x)("NotInRevenueID").ToString)
                        grandTotalNotInRevenue(x) += dtTable.Rows(i)("TotalNotInRevenue" & NotInRevenueData.Rows(x)("NotInRevenueID").ToString)
                    Else
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>-</td>")
                    End If
                Next
                If Not IsDBNull(dtTable.Rows(i)("TotalUsedPackage")) Then
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TotalUsedPackage")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    totalUsedPackage = dtTable.Rows(i)("TotalUsedPackage")
                    grandTotalUsedPackage += dtTable.Rows(i)("TotalUsedPackage")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>-</td>")
                End If
            End If

            If HavePrepaidDiscount = True Then
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(totalEachPayment - totalEachPaymentDiscount - totalNotInRevenueEach + totalUsedPackage).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            End If
            If HavePrepaid = True Then
                If totalEachPaymentPrepaid > 0 Then
                    outputString = outputString.Append("<td bgColor=""#ffffcc"" align=""right"" class=""" + TextClass + """>" + CDbl(totalEachPaymentPrepaid).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                Else
                    outputString = outputString.Append("<td bgColor=""#ffffcc"" align=""right"" class=""" + TextClass + """>-</td>")
                End If
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(totalEachPayment - totalEachPaymentPrepaid).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            End If
            outputString = outputString.Append("</tr>")
        Next
        Dim grandTotalPrepaid As Double = 0
        outputString = outputString.Append("<tr bgColor=""" + "#ebebeb" + """>")
        If DisplayReceipt = True And ShowTable = True Then
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + LangData2.Rows(97)(LangText) + "</td>")
        Else
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + LangData2.Rows(97)(LangText) + "</td>")
        End If
        If DisplayReceipt = False Then
            'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalBill).ToString(FormatObject.QtyFormat, ci) + "</td>")
        End If
        If ShowTable = True Then
            'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalCustomer).ToString(FormatObject.QtyFormat, ci) + "</td>")
        End If
        Dim grandTotalSale As Double
        'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalRetailPrice - grandTotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        If DisplayVATType = "V" Then
            grandTotalSale = grandTotalAfterVAT
            'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalServiceCharge).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalVatable).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        Else
            grandTotalSale = grandTotalRetailPrice - grandTotalDiscount + grandTotalServiceCharge - grandTotalServiceChargeVAT
            'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalServiceCharge - grandTotalServiceChargeVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalRetailPrice - grandTotalDiscount + grandTotalServiceCharge - grandTotalServiceChargeVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalBillVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalVatable - grandTotalVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")

        End If



        Dim PaymentDiscountText As String
        For i = 0 To PayTypeList.Rows.Count - 1
            If PayTypeList.Rows(i)("IsSale") = 1 Then
                TextClass = "smallText"
            Else
                TextClass = "smallText"
                grandTotalPrepaid += SumPayment(i)
            End If
            grandTotalPaymentDiscount += SumPaymentDiscount(i)
            If SumPaymentDiscount(i) > 0 Then
                PaymentDiscountText = "/" + CDbl(SumPaymentDiscount(i)).ToString(FormatObject.CurrencyFormat, ci)
            Else
                PaymentDiscountText = ""
            End If
            If PayTypeList.Rows(i)("PayTypeID") = 7 Or (PayTypeList.Rows(i)("PayTypeID") >= 10 And PayTypeList.Rows(i)("IsSale") = 1 And PayTypeList.Rows(i)("IsOtherReceipt") = 0) Then
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SumPayment(i)).ToString(FormatObject.CurrencyFormat, ci) + PaymentDiscountText + "</td>")
            ElseIf PayTypeList.Rows(i)("PayTypeID") = 2 Then
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SumPayment(i)).ToString(FormatObject.CurrencyFormat, ci) + PaymentDiscountText + "</td>")
            ElseIf PayTypeList.Rows(i)("PayTypeID") = 5 Then
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SumPayment(i)).ToString(FormatObject.CurrencyFormat, ci) + PaymentDiscountText + "</td>")
            ElseIf PayTypeList.Rows(i)("PayTypeID") = 3 Then
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SumPayment(i)).ToString(FormatObject.CurrencyFormat, ci) + PaymentDiscountText + "</td>")
            ElseIf PayTypeList.Rows(i)("PayTypeID") = 9 Then
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SumPayment(i)).ToString(FormatObject.CurrencyFormat, ci) + PaymentDiscountText + "</td>")
            Else
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SumPayment(i)).ToString(FormatObject.CurrencyFormat, ci) + PaymentDiscountText + "</td>")

            End If
        Next
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandPayment).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        If Math.Round(grandTotalAfterVAT, 2) - Math.Round(grandPayment, 2) <> 0 Then
            'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandPayment - grandTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        Else
            'outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
        End If

        'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalSale / grandTotalBill).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        If ShowTable = True Then
            'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalSale / grandTotalCustomer).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        End If
        If NotInRevenueBit = True Then
            For x = 0 To NotInRevenueData.Rows.Count - 1
                If grandTotalNotInRevenue(x) > 0 Then
                    If x = 0 Then
                        outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """><a class=""" + "smallText" + """ href=""JavaScript: newWindow = window.open( 'report_packagesummary.aspx?DisplayOnly=yes&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=1000,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">(" + CDbl(grandTotalNotInRevenue(x)).ToString(FormatObject.CurrencyFormat, ci) + ")</a></td>")
                    Else
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">(" + CDbl(grandTotalNotInRevenue(x)).ToString(FormatObject.CurrencyFormat, ci) + ")</td>")
                    End If
                    totalNotInRevenue += grandTotalNotInRevenue(x)
                Else
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
                End If
            Next
            If grandTotalUsedPackage > 0 Then
                outputString = outputString.Append("<td align=""right"" class=""" + "smallText" + """><a class=""" + "smallText" + """ href=""JavaScript: newWindow = window.open( 'report_service_package.aspx?DisplayOnly=yes&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=1000,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + CDbl(grandTotalUsedPackage).ToString(FormatObject.CurrencyFormat, ci) + "</a></td>")
            Else
                outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
            End If
        End If
        If HavePrepaidDiscount = True Then
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandPayment - grandTotalPaymentDiscount - totalNotInRevenue + grandTotalUsedPackage).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        End If
        If HavePrepaid = True Then
            If grandTotalPrepaid > 0 Then
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalPrepaid).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            Else
                outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
            End If
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandPayment - grandTotalPrepaid).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        End If

        outputString = outputString.Append("</tr>")
        outputString = outputString.Append("</table>")
        DiscountArray(0) = grandTotalDiscount
        Dim FinalSaleAmount As Double
        If dtTable.Rows.Count > 0 Then
            'Dim ResultSummary As String = SaleReportSummaryNew(grandTotalSale, grandTotalRetailPrice, FinalSaleAmount, GrayBGColor, AdminBGColor, ShopID, ViewOption, StartDate, EndDate, grandTotalVAT, grandTotalAfterVAT, grandTotalVoid, PaymentResult, PayByCreditMoney, DiscountArray, True, False, LangID, LangPath, objCnn)
            'outputString = outputString.Append(ResultSummary)
        End If

        Return outputString.ToString()
    End Function
		
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
