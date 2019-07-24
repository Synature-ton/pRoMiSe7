<%@ Page Language="VB" ContentType="text/html" EnableViewState="False" debug="True" %>
<%@ Register tagPrefix="Web" Namespace="WebChart" Assembly="WebChart" %>
<%@ Import Namespace="System.Drawing" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSBackOfficeReport" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Cash In/ Out Reports</title>
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
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Sale Report By HourGroup Report" runat="server" /></b></td>
		<td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
				<td><span id="HourGroupText" runat="server"></span></td>
			</tr>
			<tr>
				<td><asp:radiobutton ID="optViewByBill" GroupName="ReportViewGroup" CssClass="text" runat="server" /></td>
			</tr>
			<tr>
				<td><asp:radiobutton ID="optViewByProduct" GroupName="ReportViewGroup" CssClass="text" runat="server" /></td>
			</tr>
			<tr>
				<td><asp:radiobutton ID="optViewByWeek" GroupName="ReportViewGroup" CssClass="text" runat="server" /></td>
			</tr>
            <tr>
            	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:dropdownlist ID="ReportProductOrdering" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
           </tr>
		</table></td>
	<td>
	<table>
		<tr>
		<td><asp:radiobutton ID="optDailyDate" GroupName="ReportSelectDateGroup" runat="server" /></td>
		<td><synature:date id="DailyDate" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="optMonthlyDate" GroupName="ReportSelectDateGroup" runat="server" /></td>
		<td><synature:date id="MonthYearDate" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="optRangeDate" GroupName="ReportSelectDateGroup" runat="server" /></td>
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
	<span id="TableHeaderText" runat="server"></span>
	<span id="ExtraHeader" runat="server"></span>
	
	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>
<br>
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
    Dim getReport As New BackOfficeReport()
    Dim DateTimeUtil As New MyDateTime()
    Dim getProp As New CPreferences()
    Dim objDB As New CDBUtil()
    Dim FormatDocNumber As New FormatText()
    Dim InvC As CultureInfo = CultureInfo.InvariantCulture
    Dim SaleReportPageID As Integer = 6
    Dim SaleReportHourGroupPageID As Integer = 102

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Report_Sale_New") Then
		
            Try
                objCnn = getCnn.EstablishConnection()
		
                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
		
                ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
                Dim i As Integer
		
                Dim z As Integer
                If Not Request.QueryString("ToLangID") Is Nothing Then
                    If IsNumeric(Request.QueryString("ToLangID")) Then
                        Session("LangID") = Request.QueryString("ToLangID")
                    End If
                End If

                Dim CultureString As String = Util.GetCultureByLangID(Session("LangID"), objCnn)
                Dim PageName As String = System.IO.Path.GetFileName(Request.ServerVariables("SCRIPT_NAME"))
                Dim LangListText As String = ""
                Dim LangListData As DataTable
                Dim LangData As DataTable = getProp.GetLang(LangListText, LangListData, PageName & "?ID" & Request.QueryString("ID") & "&Order=" + Request.QueryString("Order") & "&GroupID=" & Request.QueryString("GroupID"), SaleReportHourGroupPageID, 1, -1, Request, objCnn)
                Dim LangText As String = "lang" + Session("LangID").ToString
		
                For z = 0 To LangData.Rows.Count - 1
                    Dim TestLabel = Util.FindControlRecursive(mainForm, "LangText" & z)
                    Try
                        TestLabel.Text = LangData.Rows(z)(LangText)
                    Catch ex As Exception
                    End Try
                Next
                LangList.Text = LangListText
		
                Dim LangData2 As DataTable = getProp.GetLangData(SaleReportPageID, 2, -1, Request)
                Dim hourGroupLangData As DataTable = getProp.GetLangData(SaleReportHourGroupPageID, 2, -1, Request)
		
                Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
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
                If (optViewByBill.Checked = True) Or (optViewByWeek.Checked = True) Then
                    If (optMonthlyDate.Checked = True Or optRangeDate.Checked = True Or optDailyDate.Checked = True) Then
                        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(hourGroupLangData, 3, LangText, "à¸§à¸±à¸à¸à¸µà¹") & "</td>"
		
                        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(hourGroupLangData, 4, LangText, "à¹à¸¥à¸à¸à¸µà¹ Cash In/Out") & "</td>"

                        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(hourGroupLangData, 12, LangText, "à¸£à¸²à¸¢à¸à¸²à¸£") & "</td>"
				
                        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(hourGroupLangData, 10, LangText, "à¸£à¸²à¸à¸²") & "</td>"
				
                        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(hourGroupLangData, 5, LangText, "à¹à¸¥à¸à¸à¸µà¹à¸­à¹à¸²à¸à¸­à¸´à¸") & "</td>"

                        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(hourGroupLangData, 6, LangText, "à¸«à¸¡à¸²à¸¢à¹à¸«à¸à¸¸") & "</td>"

                        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(hourGroupLangData, 13, LangText, "à¸à¸à¸±à¸à¸à¸²à¸") & "</td>"

                        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(hourGroupLangData, 14, LangText, "à¹à¸§à¸¥à¸²à¸à¸³à¸£à¸²à¸¢à¸à¸²à¸£") & "</td>"
                    Else
                        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(hourGroupLangData, 7, LangText, "Month/ Year") & "</td>"
		
                        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(hourGroupLangData, 8, LangText, "Cash Out") & "</td>"
				
                        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(hourGroupLangData, 9, LangText, "Cash In") & "</td>"
                    End If
			
                ElseIf optViewByProduct.Checked = True Then
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangData2, 33, LangText, "à¸£à¸«à¸±à¸ªà¸ªà¸´à¸à¸à¹à¸²") & "</td>"

                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangData2, 34, LangText, "à¸ªà¸´à¸à¸à¹à¸²") & "</td>"

                    If getProp.CheckColumnExist("CashOutOrderDetail", "CashOutAmount", objCnn) = True Then
                        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangData2, 37, LangText, "à¸à¸³à¸à¸§à¸") & "</td>"
                    End If
			
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangData2, 38, LangText, "à¸£à¸§à¸¡à¸£à¸²à¸à¸²") & "</td>"
                End If
                HeaderString = ""
                TableHeaderText.InnerHtml = HeaderString
		
                StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
	
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
                ReportProductOrdering.Visible = False
		
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

                optViewByBill.Text = BackOfficeReport.GetLanguageText(hourGroupLangData, 1, LangText, "&#3649;&#3626;&#3604;&#3591;&#3626;&#3619;&#3640;&#3611;&#3605;&#3634;&#3617;&#3623;&#3633;&#3609;")
                optViewByProduct.Text = BackOfficeReport.GetLanguageText(hourGroupLangData, 2, LangText, "&#3649;&#3626;&#3604;&#3591;&#3605;&#3634;&#3617;&#3626;&#3636;&#3609;&#3588;&#3657;&#3634;")
                optViewByWeek.Text = BackOfficeReport.GetLanguageText(hourGroupLangData, 22, LangText, "แสดงตามสัปดาห์")
		
                If IsNumeric(Request.Form("DocDaily_Day")) Then
                    Session("DocDailyDay") = Request.Form("DocDaily_Day")
                ElseIf IsNumeric(Request.QueryString("DocDaily_Day")) Then
                    Session("DocDailyDay") = Request.QueryString("DocDaily_Day")
                ElseIf Trim(Session("DocDailyDay")) = "" Then
                    Session("DocDailyDay") = DateTime.Now.Day
                ElseIf Trim(Session("DocDailyDay")) = 0 And Not Page.IsPostBack Then
                    Session("DocDailyDay") = DateTime.Now.Day
                End If
                If Page.IsPostBack And Request.Form("DocDaily_Day") = "" Then Session("DocDailyDay") = 0
                DailyDate.SelectedDay = Session("DocDailyDay")
		
		
                If IsNumeric(Request.Form("DocDaily_Month")) Then
                    Session("DocDaily_Month") = Request.Form("DocDaily_Month")
                ElseIf IsNumeric(Request.QueryString("DocDaily_Month")) Then
                    Session("DocDaily_Month") = Request.QueryString("DocDaily_Month")
                ElseIf Trim(Session("DocDaily_Month")) = "" Then
                    Session("DocDaily_Month") = DateTime.Now.Month
                ElseIf Trim(Session("DocDaily_Month")) = 0 And Not Page.IsPostBack Then
                    Session("DocDaily_Month") = DateTime.Now.Month
                End If
                If Page.IsPostBack And Request.Form("DocDaily_Month") = "" Then Session("DocDaily_Month") = 0
                DailyDate.SelectedMonth = Session("DocDaily_Month")
		
                If IsNumeric(Request.Form("DocDaily_Year")) Then
                    Session("DocDaily_Year") = Request.Form("DocDaily_Year")
                ElseIf IsNumeric(Request.QueryString("DocDaily_Year")) Then
                    Session("DocDaily_Year") = Request.QueryString("DocDaily_Year")
                ElseIf Trim(Session("DocDaily_Year")) = "" Then
                    Session("DocDaily_Year") = DateTime.Now.Year
                ElseIf Trim(Session("DocDaily_Year")) = 0 And Not Page.IsPostBack Then
                    Session("DocDaily_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("DocDaily_Year") = "" Then Session("DocDaily_Year") = 0
                DailyDate.SelectedYear = Session("DocDaily_Year")
		
                If IsNumeric(Request.Form("Doc_Day")) Then
                    Session("DocDay") = Request.Form("Doc_Day")
                ElseIf IsNumeric(Request.QueryString("Doc_Day")) Then
                    Session("DocDay") = Request.QueryString("Doc_Day")
                ElseIf Trim(Session("DocDay")) = "" Then
                    Session("DocDay") = DateTime.Now.Day
                ElseIf Trim(Session("DocDay")) = 0 And Not Page.IsPostBack Then
                    Session("DocDay") = DateTime.Now.Day
                End If
                If Page.IsPostBack And Request.Form("Doc_Day") = "" Then Session("DocDay") = 0
                CurrentDate.SelectedDay = Session("DocDay")
		
		
                If IsNumeric(Request.Form("Doc_Month")) Then
                    Session("Doc_Month") = Request.Form("Doc_Month")
                ElseIf IsNumeric(Request.QueryString("Doc_Month")) Then
                    Session("Doc_Month") = Request.QueryString("Doc_Month")
                ElseIf Trim(Session("Doc_Month")) = "" Then
                    Session("Doc_Month") = DateTime.Now.Month
                ElseIf Trim(Session("Doc_Month")) = 0 And Not Page.IsPostBack Then
                    Session("Doc_Month") = DateTime.Now.Month
                End If
                If Page.IsPostBack And Request.Form("Doc_Month") = "" Then Session("Doc_Month") = 0
                CurrentDate.SelectedMonth = Session("Doc_Month")
		
                If IsNumeric(Request.Form("Doc_Year")) Then
                    Session("Doc_Year") = Request.Form("Doc_Year")
                ElseIf IsNumeric(Request.QueryString("Doc_Year")) Then
                    Session("Doc_Year") = Request.QueryString("Doc_Year")
                ElseIf Trim(Session("Doc_Year")) = "" Then
                    Session("Doc_Year") = DateTime.Now.Year
                ElseIf Trim(Session("Doc_Year")) = 0 And Not Page.IsPostBack Then
                    Session("Doc_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("Doc_Year") = "" Then Session("Doc_Year") = 0
                CurrentDate.SelectedYear = Session("Doc_Year")
		
                If IsNumeric(Request.Form("DocTo_Day")) Then
                    Session("DocTo_Day") = Request.Form("DocTo_Day")
                ElseIf IsNumeric(Request.QueryString("DocTo_Day")) Then
                    Session("DocTo_Day") = Request.QueryString("DocTo_Day")
                ElseIf Trim(Session("DocTo_Day")) = "" Then
                    Session("DocTo_Day") = DateTime.Now.Day
                ElseIf Trim(Session("DocTo_Day")) = 0 And Not Page.IsPostBack Then
                    Session("DocTo_Day") = DateTime.Now.Day
                End If
                If Page.IsPostBack And Request.Form("DocTo_Day") = "" Then Session("DocTo_Day") = 0
                ToDate.SelectedDay = Session("DocTo_Day")
		
		
                If IsNumeric(Request.Form("DocTo_Month")) Then
                    Session("DocTo_Month") = Request.Form("DocTo_Month")
                ElseIf IsNumeric(Request.QueryString("DocTo_Month")) Then
                    Session("DocTo_Month") = Request.QueryString("DocTo_Month")
                ElseIf Trim(Session("DocTo_Month")) = "" Then
                    Session("DocTo_Month") = DateTime.Now.Month
                ElseIf Trim(Session("DocTo_Month")) = 0 And Not Page.IsPostBack Then
                    Session("DocTo_Month") = DateTime.Now.Month
                End If
                If Page.IsPostBack And Request.Form("DocTo_Month") = "" Then Session("DocTo_Month") = 0
                ToDate.SelectedMonth = Session("DocTo_Month")
		
                If IsNumeric(Request.Form("DocTo_Year")) Then
                    Session("DocTo_Year") = Request.Form("DocTo_Year")
                ElseIf IsNumeric(Request.QueryString("DocTo_Year")) Then
                    Session("DocTo_Year") = Request.QueryString("DocTo_Year")
                ElseIf Trim(Session("DocTo_Year")) = "" Then
                    Session("DocTo_Year") = DateTime.Now.Year
                ElseIf Trim(Session("DocTo_Year")) = 0 And Not Page.IsPostBack Then
                    Session("DocTo_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("DocTo_Year") = "" Then Session("DocTo_Year") = 0
                ToDate.SelectedYear = Session("DocTo_Year")
		
                If IsNumeric(Request.Form("MonthYearDate_Day")) Then
                    Session("MonthYearDate_Day") = Request.Form("MonthYearDate_Day")
                ElseIf IsNumeric(Request.QueryString("MonthYearDate_Day")) Then
                    Session("MonthYearDate_Day") = Request.QueryString("MonthYearDate_Day")
                ElseIf Trim(Session("MonthYearDate_Day")) = "" Then
                    Session("MonthYearDate_Day") = DateTime.Now.Day
                ElseIf Trim(Session("MonthYearDate_Day")) = 0 And Not Page.IsPostBack Then
                    Session("MonthYearDate_Day") = DateTime.Now.Day
                End If
                If Page.IsPostBack And Request.Form("MonthYearDate_Day") = "" Then Session("MonthYearDate_Day") = 0
                MonthYearDate.SelectedDay = Session("MonthYearDate_Day")
		
		
                If IsNumeric(Request.Form("MonthYearDate_Month")) Then
                    Session("MonthYearDate_Month") = Request.Form("MonthYearDate_Month")
                ElseIf IsNumeric(Request.QueryString("MonthYearDate_Month")) Then
                    Session("MonthYearDate_Month") = Request.QueryString("MonthYearDate_Month")
                ElseIf Trim(Session("MonthYearDate_Month")) = "" Then
                    Session("MonthYearDate_Month") = DateTime.Now.Month
                ElseIf Trim(Session("MonthYearDate_Month")) = 0 And Not Page.IsPostBack Then
                    Session("MonthYearDate_Month") = DateTime.Now.Month
                End If
                If Page.IsPostBack And Request.Form("MonthYearDate_Month") = "" Then Session("MonthYearDate_Month") = 0
                MonthYearDate.SelectedMonth = Session("MonthYearDate_Month")
		
                If IsNumeric(Request.Form("MonthYearDate_Year")) Then
                    Session("MonthYearDate_Year") = Request.Form("MonthYearDate_Year")
                ElseIf IsNumeric(Request.QueryString("MonthYearDate_Year")) Then
                    Session("MonthYearDate_Year") = Request.QueryString("MonthYearDate_Year")
                ElseIf Trim(Session("MonthYearDate_Year")) = "" Then
                    Session("MonthYearDate_Year") = DateTime.Now.Year
                ElseIf Trim(Session("MonthYearDate_Year")) = 0 And Not Page.IsPostBack Then
                    Session("MonthYearDate_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("MonthYearDate_Year") = "" Then Session("MonthYearDate_Year") = 0
                MonthYearDate.SelectedYear = Session("MonthYearDate_Year")
		
                If IsNumeric(Request.Form("YearDate_Year")) Then
                    Session("YearDate_Year") = Request.Form("YearDate_Year")
                ElseIf IsNumeric(Request.QueryString("YearDate_Year")) Then
                    Session("YearDate_Year") = Request.QueryString("YearDate_Year")
                ElseIf Trim(Session("YearDate_Year")) = "" Then
                    Session("YearDate_Year") = DateTime.Now.Year
                ElseIf Trim(Session("YearDate_Year")) = 0 And Not Page.IsPostBack Then
                    Session("YearDate_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("YearDate_Year") = "" Then Session("YearDate_Year") = 0
		
                If Not Page.IsPostBack Then
                    optDailyDate.Checked = True
                    optViewByBill.Checked = True
                End If

                Dim ShopIDValue As String = "0"
                If IsNumeric(Request.Form("ShopID")) Then
                    ShopIDValue = Request.Form("ShopID").ToString
                ElseIf IsNumeric(Request.QueryString("ShopID")) Then
                    ShopIDValue = Request.QueryString("ShopID").ToString
                End If

                Dim outputString, FormSelected As String
                Dim Multiple As Boolean = False
                Dim ShopList As String = ""
		
                Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), objCnn)
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
                    For i = 0 To ShopData.Rows.Count - 1
                        If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
                            FormSelected = "selected"
                            SelShopName.Value = ShopData.Rows(i)("ProductLevelName")
                        Else
                            If Not Page.IsPostBack And i = 0 And Multiple = False Then
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
	
        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
        Dim FoundError As Boolean
        FoundError = False
        Session("ReportResult") = ""
	
        Dim LangHourGroupData As DataTable = getProp.GetLangData(SaleReportHourGroupPageID, 2, -1, Request)
        Dim LangData2 As DataTable = getProp.GetLangData(SaleReportPageID, 2, -1, Request)
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
	
        Dim DateFromValue As String = ""
        Dim DateToValue As String = ""
        Dim DailyDateValue As String = ""
        Dim InvC As CultureInfo = CultureInfo.InvariantCulture
        Dim AdditionalHeader As String = ""
	
        Dim StartDate, EndDate As String
        Dim startDay, startMonth, startYear, endDay, endMonth, endYear As Integer
        Dim outputString As String = ""
        Dim grandTotal As Double = 0
        Dim VATTotal As Double = 0
        Dim GraphData As New DataSet()
        Dim ReportDate As String
        Dim viewOption As Integer
        Dim bolByDate, bolByMonth, bolByDateRange As Boolean
        Dim bolViewByBill, bolViewByProduct, bolViewByWeekly As Boolean
        bolByMonth = False
        bolByDateRange = False
        bolByDate = False
        If Request.Form("ReportSelectDateGroup") = "optMonthlyDate" Then
            bolByMonth = True
            viewOption = 2
        ElseIf Request.Form("ReportSelectDateGroup") = "optRangeDate" Then
            bolByDateRange = True
            viewOption = 3
        ElseIf Request.Form("ReportSelectDateGroup") = "optDailyDate" Then
            bolByDate = True
            viewOption = 1
        Else
            bolByDate = True
            viewOption = 1
        End If
	
        Dim ReportType As String
        If Request.Form("ReportViewGroup") = "optViewByBill" Then
            bolViewByBill = True
            ReportType = BackOfficeReport.GetLanguageText(LangHourGroupData, 3, LangText, "&#3649;&#3626;&#3604;&#3591;&#3605;&#3634;&#3617;&#3610;&#3636;&#3621;")
        ElseIf Request.Form("ReportViewGroup") = "optViewByProduct" Then
            bolViewByProduct = True
            ReportType = BackOfficeReport.GetLanguageText(LangHourGroupData, 4, LangText, "&#3649;&#3626;&#3604;&#3591;&#3605;&#3634;&#3617;&#3626;&#3636;&#3609;&#3588;&#3657;&#3634;")
        ElseIf Request.Form("ReportViewGroup") = "optViewByWeek" Then
            bolViewByWeekly = True
            ReportType = BackOfficeReport.GetLanguageText(LangHourGroupData, 23, LangText, "รายงานสรุปยอดขายตามช่วงเวลาตามสัปดาห์ของ")
        Else
            ReportType = ""
        End If

        ReportDate = ""
        If bolByMonth = True Then
            Try
                startDay = 1
                endDay = 1
                If Request.Form("MonthYearDate_Month") = 12 Then
                    startMonth = Request.Form("MonthYearDate_Month")
                    endMonth = 1
                    startYear = Request.Form("MonthYearDate_Year")
                    endYear = Request.Form("MonthYearDate_Year") + 1
                Else
                    startMonth = Request.Form("MonthYearDate_Month")
                    endMonth = Request.Form("MonthYearDate_Month") + 1
                    startYear = Request.Form("MonthYearDate_Year")
                    endYear = Request.Form("MonthYearDate_Year")
                End If
                StartDate = DateTimeUtil.FormatDate(startDay, startMonth, startYear)
                EndDate = DateTimeUtil.FormatDate(endDay, endMonth, endYear)
                Dim SDate As New Date(startYear, startMonth, startDay)
                ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy", Session("LangID"), objCnn)
            Catch ex As Exception
                FoundError = True
                errorMsg.InnerHtml = ex.Message
            End Try
        ElseIf bolByDateRange = True Then
            Try
                StartDate = DateTimeUtil.FormatDate(Request.Form("Doc_Day"), Request.Form("Doc_Month"), Request.Form("Doc_Year"))
                Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
                CheckDate = DateAdd("d", 1, CheckDate)
                EndDate = DateTimeUtil.FormatDate(Day(CheckDate), Month(CheckDate), CheckDate.ToString("yyyy", InvC))
		
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
                    ReportDate = DateTimeUtil.FormatDateTime(SDate1, "DateOnly", Session("LangID"), objCnn) + " - " + DateTimeUtil.FormatDateTime(EDate1, "DateOnly", Session("LangID"), objCnn)
                End If
                
                startDay = Request.Form("Doc_Day")
                startMonth = Request.Form("Doc_Month")
                startYear = Request.Form("Doc_Year")
                endDay = CheckDate.Day
                endMonth = CheckDate.Month
                endYear = CheckDate.Year
            Catch ex As Exception
                FoundError = True
                errorMsg.InnerHtml = ex.Message
            End Try
        ElseIf bolByDate = True Then
            Try
                StartDate = DateTimeUtil.FormatDate(Request.Form("DocDaily_Day"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Year"))
                Dim CheckDate As New DateTime(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"), 0, 0, 0)
                CheckDate = DateAdd("d", 1, CheckDate)
                EndDate = DateTimeUtil.FormatDate(Day(CheckDate), Month(CheckDate), CheckDate.ToString("yyyy", InvC))

                If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
                    ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
                    FoundError = True
                    DateFromValue = ""
                    DateToValue = ""
                    DailyDateValue = ""
                Else
                    ResultSearchText.InnerHtml = ""
                    Dim SDate2 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
                    ReportDate = DateTimeUtil.FormatDateTime(SDate2, "DateOnly", Session("LangID"), objCnn)
                End If
                startDay = Request.Form("DocDaily_Day")
                startMonth = Request.Form("DocDaily_Month")
                startYear = Request.Form("DocDaily_Year")
                endDay = CheckDate.Day
                endMonth = CheckDate.Month
                endYear = CheckDate.Year
                
            Catch ex As Exception
                FoundError = True
            End Try
        Else
            DateFromValue = ""
            DateToValue = ""
            DailyDateValue = ""
        End If
        If Request.Form("ShopID") = 0 And bolViewByProduct = True Then
            errorMsg.InnerHtml = "Report is not support option All Shop with view by product"
            FoundError = True
        End If

        If FoundError = False Then
            If LangDefault.Rows.Count >= 3 Then
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(Now(), "DateAndTime", Session("LangID"), objCnn)
            End If
            Dim displayTable As New DataTable()
		
            ShowPrint.Visible = True
            showResults.Visible = True
		
            Dim selShopID As String
            Dim selHourGroupID As Integer = 0
				
            'Application.Lock()
            Dim LangPath As String = Util.GetLangPath(Request.PhysicalApplicationPath)
						
            If Request.Form("ShopID") = 0 Then
                selShopID = ShopIDList.Value
            Else
                selShopID = Request.Form("ShopID")
            End If
            
            ResultText.InnerHtml = getReport.SaleReportByHourGroupReport(objCnn, GlobalParam.GrayBGColor, GlobalParam.AdminBGColor, Session("LangID"), _
                                     bolViewByBill, bolViewByProduct, bolViewByWeekly, selHourGroupID, startDay, startMonth, startYear, endDay, endMonth, endYear, _
                                     viewOption, selShopID, LangPath, Session("StaffRole"))

            Dim ShopDisplay As String
            If Request.Form("ShopID") = 0 Then
                ShopDisplay = LangData2.Rows(70)(LangText)
            Else
                ShopDisplay = SelShopName.Value
            End If
            ResultSearchText.InnerHtml = ReportType + " " + ShopDisplay + " (" + ReportDate + ")"
            'Application.UnLock()
		
            Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"

        End If

    End Sub
 
Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "SaleByHourGroupData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
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
