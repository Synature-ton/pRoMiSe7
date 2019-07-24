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
<title>Tracking Time Report</title>
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
<input type="hidden" id="DisplayVAT" runat="server" />
<input type="hidden" id="AllShopID" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Tracking Time Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
	<td valign="middle">
		<span id="SelShopText" runat="server"></span>
    </td>
	<td valign="top">
		<table>
			<tr>
				<td><span id="ShopText" runat="server"></span></td>
			</tr>
			<tr id="showbill" visible="false" runat="server">
				<td><asp:radiobutton ID="Radio_11" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
			<tr id="showp" visible="false" runat="server">
				<td><asp:radiobutton ID="Radio_12" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
            <tr id="show2" visible="false" runat="server">
            	<td>
                	<table>
                    	<tr><td width="20">&nbsp;</td><td><asp:dropdownlist ID="ReportProductOrdering" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td></tr>
                        <tr id="ShowBySaleMode" visible="false" runat="server"><td>&nbsp;</td><td><asp:CheckBox ID="BySaleMode" Text="Group By Sale Mode" Checked="false" runat="server"></asp:CheckBox></td></tr>
                    </table>
                </td>
            </tr>
			<tr id="showoption" visible="false" runat="server">
				<td><asp:radiobutton ID="Radio_13" GroupName="Group2" CssClass="text" runat="server" />
				<asp:dropdownlist ID="GroupByParam" runat="server">
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
			</tr>
            <tr>
            	<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" />&nbsp;<asp:CheckBox ID="DisplayGraph" CssClass="text" Checked="true" Visible="false" runat="server" /></td>
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
		<tr id="showYear" visible="false" runat="server">
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
<span id="MyTable">
<table width="100%">
<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>

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
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
</table></span>

<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table>

</div>
</form>
</div>
<div id="outString" runat="server" />
<div id="errorMsg" runat="server" />
<div id="errorMsg2" runat="server" />
<div id="errorMsg3" runat="server" />
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
Dim Reports As New ReportV6()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer = 6

Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_TrackingTime") Then
		
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
				'TestLabel.Text = LangData.Rows(z)(LangText)
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
		
		Dim SMData As DataTable = objDB.List("select * from SaleMode where Deleted=0 order by SaleModeID", objCnn)
		
		ShowBySaleMode.Visible = False
		
		Dim HeaderString As String = ""
		Dim ShopProp1 As DataTable = getInfo.GetProductLevel(Request.Form("ShopID"),objCnn)

		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Sale Mode" + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Input" + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Cooking" + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Serving" + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Eating" + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Dispatch" + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "In Store" + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "On the Road" + "</td>"
		For i = 0 To SMData.Rows.Count - 1
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + SMData.Rows(i)("SaleModeName") + "</td>"
		Next

		TableHeaderText.InnerHtml = HeaderString
		
		If Radio_3.Checked = True AND (Radio_11.Checked = True Or Radio_13.Checked = True) And ExpandReceipt.Checked = True AND Request.Form("ShopID") >= 0 Then
			StartTable.InnerHtml = "<table border=""0"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		Else
			StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		End If

		GroupByParam.Items(0).Text = LangData2.Rows(5)(LangText)
		GroupByParam.Items(0).Value = "1"
		GroupByParam.Items(0).Selected = True
		'GroupByParam.Items(1).Text = LangData2.Rows(5)(LangText)
		'GroupByParam.Items(1).Value = "2"
		'If Request.Form("GroupByParam") = 1 Then
		'	GroupByParam.Items(0).Selected = True
		'ElseIf Request.Form("GroupByParam") = 2 Then
		'	GroupByParam.Items(1).Selected = True
		'Else
		'	GroupByParam.Items(1).Selected = True
		'End If
		
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
			Radio_12.Checked = True
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
		Dim ShopIDListValue As String
		'SelShopText.InnerHtml = Reports.ShopListReport(ShopData,ShopIDListValue,ShopIDValue,Session("StaffRole"),Session("StaffID"),Session("LangID"),objCnn)
		AllShopID.Value = ShopIDListValue
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
	Dim i,j,k As Integer
	
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer

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
	ElseIf Request.Form("Group1") = "Radio_3" Then ' Date
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
		ReportType = "Sale Mix Report"'LangData2.Rows(15)(LangText)
	ElseIf Request.Form("Group2") = "Radio_13" Then
		R13 = True
		If Request.Form("GroupByParam") = 1 Then
			ReportType = LangData2.Rows(16)(LangText)
		Else
			ReportType = LangData2.Rows(17)(LangText)
		End If
	End If
	
	ReportType = "Tracking Time Report"
	
	Dim ExpReceipt As Boolean = False
	If Request.Form("ExpandReceipt") = "on" Then ExpReceipt = True
	
	Dim DGraph As Boolean = False
	If Request.Form("DisplayGraph") = "on" Then DGraph = True
	
	Dim SMode As Boolean = False
	If Request.Form("BySaleMode") = "on" Then SMode = True
	
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
	
	If Request.Form("ShopID") = 0 AND R4 = True Then
		errorMsg.InnerHtml = "Report is not support option All Shop with total year data"
		FoundError = True
	End If
	
	If Trim(Request.Form("ShopID")) = "" Then
		FoundError = True
		errorMsg.InnerHtml = "Please select shop before submission"
	End If
	
	If FoundError = False Then
		Reports.CheckConfigReport(1,objCnn)
		
		If LangDefault.Rows.Count >= 3 Then
			CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(NOW(), "DateAndTime",Session("LangID"),objCnn) + " By " + Session("StaffName")
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
		Dim IncomeType As DataTable
		Dim LangPath As String = Util.GetLangPath(Request.PhysicalApplicationPath)
		Dim DIData,TWData,DLData As DataTable
		Dim dtTable As DataTable
		Dim OtherIncome As DataTable
		Dim SaleModeIncome As DataTable
		Dim VoidData As DataTable
		Dim PaymentData As DataTable
		Dim bgColor As String = "white"
			
		
		SaleModeTimeReports(DIData,TWData,DLData,StartDate,EndDate,GlobalParam.GrayBGColor,GlobalParam.AdminBGColor,Session("LangID"),Request.Form("ShopID"), LangPath,Session("StaffRole"), objCnn)

		Dim ShopDisplay As String
		If Request.Form("ShopID") = 0 Then
			ShopDisplay = LangData2.Rows(70)(LangText)
		Else
			ShopDisplay = SelShopName.Value
		End If
		ResultSearchText.InnerHtml = ReportType + " " + ShopDisplay + " (" + ReportDate + ")"
		'Application.UnLock()
		
		Dim SMData As DataTable = objDB.List("select * from SaleMode where Deleted=0 order by SaleModeID", objCnn)
		
		Dim FormatData As DataTable = Fm.FormatParam(FormatObject, Session("LangID"), objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)

        Dim outputString As StringBuilder = New StringBuilder
        Dim counter As Integer
		Dim TextClass As String = "smalltext"
		Dim foundRows() As DataRow
        Dim expression As String
		Dim TotalBill(SMData.Rows.Count) As Double
		Dim TotalCustomer(SMData.Rows.Count) As Double
		Dim TotalRetailPrice(SMData.Rows.Count) As Double
		Dim TotalDiscount(SMData.Rows.Count) As Double
		Dim SalePrice(SMData.Rows.Count) As Double
		Dim TotalVAT(SMData.Rows.Count) As Double
		Dim subTotalBill As Double = 0
		Dim subTotalCustomer As Double = 0
		Dim subTotalRetailPrice As Double = 0
		Dim subTotalDiscount As Double = 0
		Dim subSalePrice As Double = 0
		Dim subTotalVAT As Double = 0
		Dim NetTotal(SMData.Rows.Count) As Double
		Dim sumNetTotal As Double
		
		For j = 0 To SMData.Rows.Count - 1
			outputString.Append("<tr bgColor=""" + bgColor + """>")
			outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & SMData.Rows(j)("SaleModeName") & "</td>")
			If SMData.Rows(j)("SaleModeID") = 1 Then
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + DIData.Rows(0)("InputTime") + "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & DIData.Rows(0)("CookingTime") & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & DIData.Rows(0)("ServingTime") & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & DIData.Rows(0)("EatingTime") & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & "-" & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & "-" & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & "-" & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & DIData.Rows(0)("DineInTime") & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & "-" & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & "-" & "</td>")
			ElseIf SMData.Rows(j)("SaleModeID") = 2 Then
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & TWData.Rows(0)("InputTime") & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & TWData.Rows(0)("CookingTime") & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & "-" & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & "-" & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & "-" & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & "-" & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & "-" & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & "-" & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & TWData.Rows(0)("TWTime") & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & "-" & "</td>")
			ElseIf SMData.Rows(j)("SaleModeID") = 3 Then
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + DLData.Rows(0)("InputTime") + "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & DLData.Rows(0)("CookingTime") & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & "-" & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & "-" & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & DLData.Rows(0)("DispatchTime") & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & DLData.Rows(0)("OnTheRoadTime") & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & DLData.Rows(0)("InStoreTime") & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & "-" & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & "-" & "</td>")
				outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & DLData.Rows(0)("DeliveryTime") & "</td>")
			Else
			
			End If
			outputString = outputString.Append("</tr>")
		Next

		outputString = outputString.Append("</table>")
		ResultText.InnerHtml = outputString.ToString
		
		Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr></table>"

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
	
	Dim FileName As String = "MSS_SaleData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub	


 Public Function SaleModeTimeReports(ByRef DIData As DataTable, ByRef TWData As DataTable, ByRef DLData As DataTable, ByVal StartDate As String, ByVal EndDate As String, ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal LangID As Integer, ByVal ShopID As String, ByVal LangPath As String, ByVal StaffRoleID As Integer, ByVal objCnn As MySqlConnection) As String

        Dim sqlStatement, sqlStatement1, sqlStatement2, WhereString, WString, ExtraSql, ExtraSelect, PaymentQuery As String
        Dim AdditionalQuery As String = ""
        Dim ShopIDListValue As String = ""
        Dim ResultString As String = ""
        Dim TextClass As String
        Dim GetData As DataTable
        Dim PayTypeData As DataTable
        Dim sqlStatement3 As String

        Dim BranchStr, StrBefore As String
        Dim ii As Integer
        Dim getProp As New CPreferences

        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

        Dim PName As String = "p." + getReport.ProductNameForReport(LangID, objCnn) + " As ProductName"
        Dim PName2 As String = "p." + getReport.ProductNameForReport(LangID, objCnn)
        Dim SaleModePName As String = "IF(a.SaleMode = 1," + PName2 + ",IF(sm.PositionPrefix=0,CONCAT(sm.PrefixText," + PName2 + "),CONCAT(" + PName2 + ",sm.PrefixText))) As ProductName"

        Dim NotInRevenueBit As Boolean = False
        Try
            NotInRevenueBit = PropertyInfo.Rows(0)("EnableNotInRevenue")
        Catch ex As Exception
            NotInRevenueBit = False
        End Try

        If ShopID = "0" Then
            Dim getInfo As New CCategory
            Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999, StaffRoleID, objCnn)
            For ii = 0 To ShopData.Rows.Count - 1
                ShopIDListValue += "," + ShopData.Rows(ii)("ProductLevelID").ToString
            Next
            If ShopIDListValue <> "" Then ShopIDListValue = "0" + ShopIDListValue
        Else
            ShopIDListValue = ShopID.ToString
        End If

        If ShopIDListValue <> "" Then
            AdditionalQuery += " AND a.ShopID IN (" + ShopIDListValue + ")"
            WhereString += " AND ShopID IN (" + ShopIDListValue + ")"
            WString += " AND a.ShopID IN (" + ShopIDListValue + ")"
            PaymentQuery += " AND a.ShopID IN (" + ShopIDListValue + ")"
        End If

        If StartDate <> "" And EndDate <> "" Then
            AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
            WhereString += " AND (PayDate >= " + StartDate + " AND PayDate < " + EndDate + ")"
            WString += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
            PaymentQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
        End If

        Dim StartTime As String = ""
        Dim EndTime As String = ""

        If Trim(WhereString) = "" Then
            WhereString = " AND 0=1"
            WString = " AND 0=1"
        End If
        Dim OrderBy As String = " a.DocType,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID,b.OrderDetailID,d.PayTypeID"
        Dim ExtraTableString As String = Now.Year.ToString + Now.Month.ToString + Now.Day.ToString + Now.Hour.ToString + Now.Minute.ToString + Now.Second.ToString + Now.Millisecond.ToString

        ExtraSql = ""
        ExtraSelect = ""
        Dim PromotionData As DataTable

        Dim TimeNow As String = DateTimeUtil.CurrentDateTime
		
		Dim SMData As DataTable = objDB.List("select * from SaleMode where Deleted=0 order by SaleModeID", objCnn)
		Dim OrderingProduct As String
		
		sqlStatement = "select CAST(SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(SendToKDSTime,FirstOrderTime)))/count(*)) AS CHAR) As InputTime,CAST(SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(LastReadyOrderTime,SendToKDSTime)))/count(*)) AS CHAR) As CookingTime,CAST(SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(LastReadyOrderTime,FirstReadyOrderTime)))/count(*)) AS CHAR) As ServingTime,CAST(SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(PaidTime,FirstReadyOrderTime)))/count(*)) AS CHAR) As EatingTime,CAST(SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(PaidTime,FirstOrderTime)))/count(*)) AS CHAR) As DineInTime from ordertransactiontimedetail a where SaleMode=1 AND FirstOrderTime is not NULL AND SendToKDSTime is NOT NULL AND FirstReadyOrderTime is not NULL AND LastReadyOrderTime is not NULL AND PaidTime is not NULL" + AdditionalQuery

        DIData = objDB.List(sqlStatement, objCnn)
		
		sqlStatement = "select CAST(SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(SendToKDSTime,FirstOrderTime)))/count(*)) AS CHAR) As InputTime,CAST(SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(LastReadyOrderTime,SendToKDSTime)))/count(*)) AS CHAR) As CookingTime,CAST(SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(SendToKDSTime,FirstOrderTime)))/count(*)+SUM(TIME_TO_SEC(TIMEDIFF(LastReadyOrderTime,SendToKDSTime)))/count(*)) AS CHAR) As TWTime from ordertransactiontimedetail a where SaleMode=2 AND FirstOrderTime is not NULL AND SendToKDSTime is NOT NULL AND LastReadyOrderTime is not NULL " + AdditionalQuery
		
		TWData = objDB.List(sqlStatement, objCnn)
		
		sqlStatement = "select CAST(SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(SendToKDSTime,FirstOrderTime)))/count(*)) AS CHAR) As InputTime,CAST(SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(LastReadyOrderTime,SendToKDSTime)))/count(*)) AS CHAR) As CookingTime,CAST(SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(DispatchTime,LastReadyOrderTime)))/count(*)) AS CHAR) As DispatchTime,CAST(SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(SendToKDSTime,FirstOrderTime)))/count(*)+SUM(TIME_TO_SEC(TIMEDIFF(LastReadyOrderTime,SendToKDSTime)))/count(*)+SUM(TIME_TO_SEC(TIMEDIFF(DispatchTime,LastReadyOrderTime)))/count(*)) AS CHAR) As InStoreTime,CAST(SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(PaidTime,DispatchTime)))/count(*)) AS CHAR) As OnTheRoadTime,CAST(SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(SendToKDSTime,FirstOrderTime)))/count(*)+SUM(TIME_TO_SEC(TIMEDIFF(LastReadyOrderTime,SendToKDSTime)))/count(*)+SUM(TIME_TO_SEC(TIMEDIFF(DispatchTime,LastReadyOrderTime)))/count(*) + ((SUM(TIME_TO_SEC(TIMEDIFF(PaidTime,DispatchTime)))/count(*))/2)) AS CHAR) As DeliveryTime from ordertransactiontimedetail a where SaleMode=3 AND FirstOrderTime is not NULL AND SendToKDSTime is NOT NULL AND DispatchTime is not NULL AND LastReadyOrderTime is not NULL AND PaidTime is not NULL" + AdditionalQuery
		
		'errorMsg.InnerHtml = sqlStatement
        DLData = objDB.List(sqlStatement, objCnn)


    End Function

	
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
