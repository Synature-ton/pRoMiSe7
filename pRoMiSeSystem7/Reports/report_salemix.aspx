<%@ Page Language="VB" ContentType="text/html" EnableViewState="False" debug="True" %>
<%@ Register tagPrefix="Web" Namespace="WebChart" Assembly="WebChart" %>
<%@ Import Namespace="System.Drawing" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSDBFront" %>
<%@Import Namespace="pRoMiSeUtil.pRoMiSeUtil" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Sales Mix Reports</title>
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
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Sales Mix Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
			
			<tr>
				<td><asp:radiobutton ID="Radio_12" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
            <tr id="showbill" visible="true" runat="server">
				<td><asp:radiobutton ID="Radio_11" GroupName="Group2" CssClass="text" runat="server" /></td>
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
			<tr>
				<td><asp:radiobutton ID="Radio_13" GroupName="Group2" CssClass="text" runat="server" />
				<asp:dropdownlist ID="GroupByParam" Visible="false" runat="server">
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
        If User.Identity.IsAuthenticated And Session("Report_SaleMix") Then
		
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
                Dim LangData As DataTable = getProp.GetLang(LangListText, LangListData, PageName & "?ID" & Request.QueryString("ID") & "&Order=" + Request.QueryString("Order") & "&GroupID=" & Request.QueryString("GroupID"), PageID, 1, -1, Request, objCnn)
                Dim LangText As String = "lang" + Session("LangID").ToString
		
                For z = 0 To LangData.Rows.Count - 1
                    Dim TestLabel = Util.FindControlRecursive(mainForm, "LangText" & z)
                    Try
                        'TestLabel.Text = LangData.Rows(z)(LangText)
                    Catch ex As Exception
                    End Try
                Next
                LangList.Text = LangListText
		
                Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
		
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
		
                Dim SMData As DataTable = objDB.List("select * from SaleMode where Deleted=0 order by SaleModeID", objCnn)
		
                ShowBySaleMode.Visible = False
		
                Dim HeaderString As String = ""
                Dim ShopProp1 As DataTable = getInfo.GetProductLevel(Request.Form("ShopID"), objCnn)

                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Item" + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Description" + "</td>"
                If Radio_12.Checked = True Or Radio_11.Checked = True Then
                    For i = 0 To SMData.Rows.Count - 1
                        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + SMData.Rows(i)("SaleModeName") + "</td>"
                    Next
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Total Qty" + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Gross Sale" + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Discount" + "</td>"
                Else
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "00:00<BR>06:59" + "</td>"
                    For i = 7 To 23
                        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + i.ToString + ":00<BR>" + i.ToString + ":59" + "</td>"
                    Next
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Total Qty" + "</td>"
                End If

                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Net Sale" + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "%" + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>"


                TableHeaderText.InnerHtml = HeaderString
		
                If Radio_3.Checked = True And (Radio_11.Checked = True Or Radio_13.Checked = True) And ExpandReceipt.Checked = True And Request.Form("ShopID") >= 0 Then
                    startTable.InnerHtml = "<table border=""0"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
                Else
                    startTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
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
		
                Radio_11.Text = "O.C. Sales Mix" 'LangData2.Rows(0)(LangText)
                Radio_12.Text = "Sales Mix Report" 'LangData2.Rows(1)(LangText)
                Radio_13.Text = "Sales By Hour"
                Linechart.Text = LangData2.Rows(8)(LangText)
                Barchart.Text = LangData2.Rows(9)(LangText)
		
		
		
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
                YearDate.SelectedYear = Session("YearDate_Year")
		
                If Not Page.IsPostBack Then
                    Radio_3.Checked = True
                    Radio_12.Checked = True
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
	
        Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
	
        Dim DateFromValue As String = ""
        Dim DateToValue As String = ""
        Dim DailyDateValue As String = ""
        Dim InvC As CultureInfo = CultureInfo.InvariantCulture
        Dim AdditionalHeader As String = ""
        Dim PayTypeList As DataTable
        Dim i As Integer
	
        Dim StartDate, EndDate As String
        Dim StartMonthValue, StartYearValue, EndMonthValue, EndYearValue As Integer
        Dim outputString As String = ""
        Dim grandTotal As Double = 0
        Dim VATTotal As Double = 0
        Dim GraphData As New DataSet()
        Dim ReportDate As String
        Dim YearValue4 As Integer
        Dim R1, R2, R3, R4, R11, R12, R13 As Boolean
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
            ReportType = "O.C. Sales Mix Report"
        ElseIf Request.Form("Group2") = "Radio_12" Then
            R12 = True
            ReportType = "Sales Mix Report" 'LangData2.Rows(15)(LangText)
        ElseIf Request.Form("Group2") = "Radio_13" Then
            R13 = True
            If Request.Form("GroupByParam") = 1 Then
                ReportType = "Sales Mix By Hour" 'LangData2.Rows(16)(LangText)
            Else
                ReportType = "Sales Mix By Hour" 'LangData2.Rows(17)(LangText)
            End If
        End If
	
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
                StartDate = DateTimeUtil.FormatDate(1, StartMonthValue, StartYearValue)
                EndDate = DateTimeUtil.FormatDate(1, EndMonthValue, EndYearValue)
                Dim SDate As New Date(StartYearValue, StartMonthValue, 1)
                ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy", Session("LangID"), objCnn)
            Catch ex As Exception
                FoundError = True
                errorMsg.InnerHtml = ex.Message
            End Try
        ElseIf R2 = True Then
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
            Catch ex As Exception
                FoundError = True
                errorMsg.InnerHtml = ex.Message
            End Try
        ElseIf R3 = True Then
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
            Catch ex As Exception
                FoundError = True
            End Try
        ElseIf R4 = True Then
            Try
                StartDate = DateTimeUtil.FormatDate(1, 1, Request.Form("YearDate_Year"))
		 
                YearValue4 = Request.Form("YearDate_Year") + 1
                EndDate = DateTimeUtil.FormatDate(1, 1, YearValue4)
                Dim SDate4 As New Date(Request.Form("YearDate_Year"), 1, 1)
                ReportDate = DateTimeUtil.FormatDateTime(SDate4, "yyyy", Session("LangID"), objCnn)
            Catch ex As Exception
                FoundError = True
                errorMsg.InnerHtml = ex.Message
            End Try
        Else
            DateFromValue = ""
            DateToValue = ""
            DailyDateValue = ""
        End If
	
        If Request.Form("ShopID") = 0 And R4 = True Then
            errorMsg.InnerHtml = "Report is not support option All Shop with total year data"
            FoundError = True
        End If
	
        If Trim(Request.Form("ShopID")) = "" Then
            FoundError = True
            errorMsg.InnerHtml = "Please select shop before submission"
        End If
	
        If FoundError = False Then
            Reports.CheckConfigReport(1, objCnn)
		
            If LangDefault.Rows.Count >= 3 Then
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(Now(), "DateAndTime", Session("LangID"), objCnn) + " By " + Session("StaffName")
            End If
            Dim displayTable As New DataTable()
		
            ShowPrint.Visible = True
            showResults.Visible = True
		
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
            Dim HourlyData As DataTable
			
            If Request.Form("ShopID") >= 0 Or (Request.Form("ShopID") = 0 And R12 = True) Then
                ResultText.InnerHtml = SaleMixReports(HourlyData, IncomeType, PayTypeList, outputString, grandTotal, VATTotal, GraphData, True, GlobalParam.GrayBGColor, GlobalParam.AdminBGColor, Session("LangID"), ViewOption, R11, R12, R13, Request.Form("GroupByParam"), StartDate, EndDate, Request.Form("ReportProductOrdering"), "", "", "", Request.Form("ShopID"), 0, 0, True, ExpReceipt, DGraph, LangPath, True, Session("StaffRole"), objCnn)
			
            End If

            Dim ShopDisplay As String
            If Request.Form("ShopID") = 0 Then
                ShopDisplay = LangData2.Rows(70)(LangText)
            Else
                ShopDisplay = SelShopName.Value
            End If
            ResultSearchText.InnerHtml = ReportType + " " + ShopDisplay + " (" + ReportDate + ")"
            'Application.UnLock()
		
            Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr></table>"

            If DGraph = True And (R3 = False Or (R3 = True And Request.Form("ShopID") = 0) Or (R3 = True And ExpReceipt = False And Request.Form("GroupByParam") = 2)) And (R11 = True Or R13 = True) Then

                showGraph.Visible = True
                Dim view As DataView = GraphData.Tables(0).DefaultView
				
                If view.Count > 0 Then
            
                    If Barchart.Checked = True Then
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
            ElseIf R12 = True And DGraph = True Then
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
	
	Dim FileName As String 
	If Radio_12.Checked = True Then
		FileName = "SalesMixData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	ElseIf Radio_11.Checked = True Then
		FileName = "OCMixData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	Else
		FileName = "SalesMixByHourData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	End If
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub	


 Public Function SaleMixReports(ByRef HourlyData As DataTable, ByRef IncomeType As DataTable, ByRef PayTypeList As DataTable, ByRef outputString As String, ByRef grandTotal As Double, ByRef VATTotal As Double, ByRef GraphData As DataSet, ByVal ShowSummary As Boolean, ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal LangID As Integer, ByVal ViewOption As Integer, ByVal ReportByBill As Boolean, ByVal ReportByProduct As Boolean, ByVal ReportByTime As Boolean, ByVal GroupByParam As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal StartTimeHour As String, ByVal StartTimeMinute As String, ByVal EndTimeHour As String, ByVal EndTimeMinute As String, ByVal ShopID As String, ByVal TransactionID As Integer, ByVal ComputerID As Integer, ByVal DisplaySummary As Boolean, ByVal ExpandReceipt As Boolean, ByVal DisplayGraph As Boolean, ByVal LangPath As String, ByVal BySaleMode As Boolean, ByVal StaffRoleID As Integer, ByVal objCnn As MySqlConnection) As String

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

        Dim ChkIncome As Boolean = getProp.CheckTableExist("ordertransactionotherincomedetail", objCnn)
        Dim IncomeSelect As String = ""

        If ChkIncome = True Then
            IncomeType = objDB.List("select count(*),b.IncomeTypeID,c.IncomeCode As IncomeName from ordertransaction a, ordertransactionotherincomedetail b, otherincometype c where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.IncomeTypeID=c.IncomeTypeID AND b.IncomeStatus=1 " + PaymentQuery + " group by b.IncomeTypeID,c.IncomeCode order by b.IncomeTypeID", objCnn)
        Else
            IncomeType = objDB.List("select * from BankName where 0=1", objCnn)
        End If
        ExtraSql = ""
        ExtraSelect = ""
        Dim PromotionData As DataTable

        Dim TimeNow As String = DateTimeUtil.CurrentDateTime
		
		Dim SMData As DataTable = objDB.List("select * from SaleMode where Deleted=0 order by SaleModeID", objCnn)
		Dim OrderingProduct As String
		Dim PaymentData As DataTable
		
        If ReportByProduct = True Or ReportByBill = True Then
            TimeNow += "<BR>" + DateTimeUtil.CurrentDateTime

            OrderingProduct = "p.ProductCode"
 				
            If Trim(StartTimeHour) <> "" Then
                OrderingProduct = StartTimeHour
            End If

            Dim ReportTable As String = "summary_productreport"
				
            If TransactionID > 0 And ComputerID > 0 Then
                AdditionalQuery += " AND ( a.TransactionID = " + TransactionID.ToString + " AND a.ComputerID = " + ComputerID.ToString + ")"
            Else
                If ReportByProduct = True Then
                    AdditionalQuery += " AND a.DocType IN (8)"
                Else
                    AdditionalQuery += " AND a.DocType<>8"
                    ReportTable = "summary_productreport_stockonly"
                    ShowSummary = False
                End If
            End If

            Dim OrderingText As String = "a.GroupOrdering,a.DeptOrdering," + OrderingProduct
            If BySaleMode = True Then
                OrderingText = "sm.SaleModeID,a.GroupOrdering,a.DeptOrdering," + OrderingProduct
            End If

            sqlStatement = "SELECT IF(a.ProductLinkID is NULL,-99,a.ProductLinkID) As ProductIDLink,a.TransactionStatusID,a.OtherFoodName,a.OrderStatusID,a.ProductSetType,a.VATType, p.ProductCode," + PName + ", a.ProductDeptName,a.ProductGroupName,a.ProductGroupCode,a.ProductDeptCode,a.GroupOrdering,a.DeptOrdering,a.SaleMode,sm.SaleModeName,sm.PositionPrefix,sm.PrefixText,SUM(a.Amount) AS Amount,SUM(a.TotalPrice) AS TotalPrice,SUM(a.TotalRetailPrice) AS TotalRetailPrice,SUM(SalePrice) AS SalePrice FROM " + ReportTable + " a left outer join Products p ON a.ProductID=p.ProductID left outer join SaleMode sm ON a.SaleMode=sm.SaleModeID WHERE a.OrderStatusID IN (1,2,5) " + AdditionalQuery + "  GROUP BY a.ProductLinkID,a.TransactionStatusID,a.OtherFoodName,a.OrderStatusID,a.ProductSetType,a.VATType, p.ProductCode,p.ProductName, a.ProductDeptName,a.ProductGroupName,a.ProductGroupCode,a.ProductDeptCode,a.SaleMode,sm.SaleModeName,sm.PositionPrefix,sm.PrefixText ORDER BY " + OrderingText

            objDB.sqlExecute("DROP TABLE IF EXISTS DummySaleMix_" + ExtraTableString, objCnn)
            objDB.sqlExecute("create table DummySaleMix_" + ExtraTableString + " (ProductIDLink int, TransactionStatusID smallint,OtherFoodName varchar(100),OrderStatusID tinyint, ProductSetType tinyint, VATType tinyint, ProductCode varchar(50),ProductName varchar(255),ProductDeptName varchar(100),ProductGroupName varchar(100),ProductGroupCode varchar(50),ProductDeptCode varchar(50), GroupOrdering int, DeptOrdering int, SaleMode tinyint, SaleModeName varchar(100), PositionPrefix tinyint, PrefixText varchar(20), Amount decimal(18,4), TotalPrice decimal(18,4), TotalRetailPrice decimal(18,4), SalePrice decimal(18,4))", objCnn)
            objDB.sqlExecute("insert into DummySaleMix_" + ExtraTableString + " " + sqlStatement, objCnn)
				
            sqlStatement = "select ProductCode,ProductName,ProductSetType,OrderStatusID,ProductIDLink,VATType,ProductGroupCode,ProductGroupName,ProductDeptCode, " & _
                            "ProductDeptName,GroupOrdering,DeptOrdering,count(*) from  DummySaleMix_" + ExtraTableString & _
                            " group by ProductCode,ProductName,ProductSetType,OrderStatusID,ProductIDLink,VATType,ProductGroupCode,ProductGroupName, " & _
                            " ProductDeptCode,ProductDeptName,GroupOrdering,DeptOrdering " & _
                            " order by GroupOrdering,DeptOrdering,ProductCode"
            Dim ProductData As DataTable = objDB.List(sqlStatement, objCnn)
				
            GetData = objDB.List("select * from DummySaleMix_" + ExtraTableString, objCnn)
							
            sqlStatement1 = ""
                
            TimeNow += "<BR>Out Data:" + DateTimeUtil.CurrentDateTime
            '= objDB.List(sqlStatement1, objCnn)
            TimeNow += "<BR>Payment:" + DateTimeUtil.CurrentDateTime
            outputString = ""
            grandTotal = 0
            If ShowSummary = True Then
                sqlStatement = "select PromotionID,PromotionName,SUM(TotalDiscount) As TotalDiscount,SUM(PriceAfterDiscount) As PriceAfterDiscount from Summary_PromotionReport a where 0=0 " + PaymentQuery + " group by PromotionID,PromotionName order by SUM(TotalDiscount) DESC"
            Else
                sqlStatement = "select * from BankName where 0=1"
            End If
            PromotionData = objDB.List(sqlStatement, objCnn)
				
            SaleMixReportByProduct(BySaleMode, SMData, PromotionData, ProductData, GraphData, outputString, grandTotal, VATTotal, ShowSummary, GrayBGColor, AdminBGColor, ShopIDListValue, ViewOption, StartDate, EndDate, GetData, PaymentData, PayByCreditMoney, LangID, LangPath, objCnn)
            TimeNow += "<BR>" + DateTimeUtil.CurrentDateTime
				
            objDB.sqlExecute("DROP TABLE IF EXISTS DummySaleMix_" + ExtraTableString, objCnn)
            Return outputString
        Else
            Dim DisplayReceipt As Boolean = False
            If ReportByProduct = False And ReportByTime = False And ViewOption = 0 And ExpandReceipt = False Then DisplayReceipt = True
            Dim ExtraCriteria As String = ""
            If DisplayReceipt = False Then
                ExtraCriteria = "  AND a.TransactionStatusID=2"
            End If

            'Check 24 Hour Feature
            Dim Chk As DataTable
            Dim AllDayFeature As Boolean = False

            Dim OpenShopID As Integer = ShopID
            If ShopID = 0 Then
                OpenShopID = 1
            End If
            Dim getOpenHour As DataTable = objDB.List("select HOUR(OpenHour) As OpenHour,HOUR(CloseHour) As CloseHour from productlevel where ProductLevelID=" + OpenShopID.ToString, objCnn)
            Dim OpenHourVal As Integer = 0
            Dim EndHourVal As Integer = 23
            If getOpenHour.Rows.Count > 0 Then
                If Not IsDBNull(getOpenHour.Rows(0)("OpenHour")) Then
                    OpenHourVal = getOpenHour.Rows(0)("OpenHour")
                End If
                If Not IsDBNull(getOpenHour.Rows(0)("CloseHour")) Then
                    EndHourVal = getOpenHour.Rows(0)("CloseHour")
                End If
            End If
            objDB.sqlExecute("DROP TABLE IF EXISTS DummyHourly", objCnn)
            objDB.sqlExecute("create table DummyHourly (ID int, Hourly int)", objCnn)
            ii = 1
            objDB.sqlExecute("insert into DummyHourly (ID,Hourly) values (" & ii & "," & "0" & ")", objCnn)
            Dim i As Integer
            Dim EndLoop As Integer = EndHourVal
            If OpenHourVal >= EndHourVal Then
                EndLoop = 23
            End If
            For i = 7 To 23
                objDB.sqlExecute("insert into DummyHourly (ID,Hourly) values (" & ii & "," & i & ")", objCnn)
                ii += 1
            Next
				
            HourlyData = objDB.List("select * from DummyHourly order by ID", objCnn)
				
            sqlStatement = "SELECT 0 As Hourly,IF(a.ProductLinkID is NULL,-99,a.ProductLinkID) As ProductIDLink,a.TransactionStatusID,a.OtherFoodName,a.OrderStatusID,a.ProductSetType,a.VATType, a.ProductCode,a.ProductName, a.ProductDeptName,a.ProductGroupName,a.ProductGroupCode,a.ProductDeptCode,a.GroupOrdering,a.DeptOrdering,SUM(a.Amount) AS Amount,SUM(a.TotalPrice) AS TotalPrice,SUM(a.TotalRetailPrice) AS TotalRetailPrice,SUM(SalePrice) AS SalePrice FROM Summary_SaleHourlyProduct a WHERE a.OrderStatusID IN (1,2,5) AND a.Hourly >= 0 AND a.Hourly <= 6 " + AdditionalQuery + "  GROUP BY a.ProductLinkID,a.TransactionStatusID,a.OtherFoodName,a.OrderStatusID,a.ProductSetType,a.VATType, a.ProductCode,a.ProductName, a.ProductDeptName,a.ProductGroupName,a.ProductGroupCode,a.ProductDeptCode " + "UNION" + " SELECT a.Hourly,IF(a.ProductLinkID is NULL,-99,a.ProductLinkID) As ProductIDLink,a.TransactionStatusID,a.OtherFoodName,a.OrderStatusID,a.ProductSetType,a.VATType, a.ProductCode,a.ProductName, a.ProductDeptName,a.ProductGroupName,a.ProductGroupCode,a.ProductDeptCode,a.GroupOrdering,a.DeptOrdering,SUM(a.Amount) AS Amount,SUM(a.TotalPrice) AS TotalPrice,SUM(a.TotalRetailPrice) AS TotalRetailPrice,SUM(SalePrice) AS SalePrice FROM Summary_SaleHourlyProduct a WHERE a.Hourly >= 7 AND a.OrderStatusID IN (1,2,5) " + AdditionalQuery + "  GROUP BY a.ProductLinkID,a.TransactionStatusID,a.OtherFoodName,a.OrderStatusID,a.ProductSetType,a.VATType, a.ProductCode,a.ProductName, a.ProductDeptName,a.ProductGroupName,a.ProductGroupCode,a.ProductDeptCode,a.Hourly "
				
            objDB.sqlExecute("DROP TABLE IF EXISTS DummySaleMixHourly_" + ExtraTableString, objCnn)
            objDB.sqlExecute("create table DummySaleMixHourly_" + ExtraTableString + " (Hourly int, ProductIDLink int, TransactionStatusID smallint,OtherFoodName varchar(100),OrderStatusID tinyint, ProductSetType tinyint, VATType tinyint, ProductCode varchar(50),ProductName varchar(255),ProductDeptName varchar(100),ProductGroupName varchar(100),ProductGroupCode varchar(50),ProductDeptCode varchar(50), GroupOrdering int, DeptOrdering int, Amount decimal(18,4), TotalPrice decimal(18,4), TotalRetailPrice decimal(18,4), SalePrice decimal(18,4))", objCnn)
            objDB.sqlExecute("insert into DummySaleMixHourly_" + ExtraTableString + " " + sqlStatement, objCnn)
				
            Dim ProductData As DataTable = objDB.List("select ProductCode,ProductName,ProductSetType,OrderStatusID,ProductIDLink,VATType,ProductGroupCode,ProductGroupName,ProductDeptCode,ProductDeptName,GroupOrdering,DeptOrdering,count(*) from  DummySaleMixHourly_" + ExtraTableString + " group by ProductCode,ProductName,ProductSetType,OrderStatusID,ProductIDLink,VATType,ProductGroupCode,ProductGroupName,ProductDeptCode,ProductDeptName,GroupOrdering,DeptOrdering order by GroupOrdering,DeptOrdering,ProductCode", objCnn)
				
            GetData = objDB.List("select * from DummySaleMixHourly_" + ExtraTableString, objCnn)

            sqlStatement2 = ""

            sqlStatement3 = ""

            TimeNow += "<BR>Out Data:" + DateTimeUtil.CurrentDateTime
				
            SaleMixHourlyReportByProduct(BySaleMode, HourlyData, PromotionData, ProductData, GraphData, outputString, grandTotal, VATTotal, ShowSummary, GrayBGColor, AdminBGColor, ShopIDListValue, ViewOption, StartDate, EndDate, GetData, PaymentData, PayByCreditMoney, LangID, LangPath, objCnn)
            TimeNow += "<BR>" + DateTimeUtil.CurrentDateTime
				
            objDB.sqlExecute("DROP TABLE IF EXISTS DummySaleMixHourly_" + ExtraTableString, objCnn)
  
            Return outputString

            
        End If

    End Function

    Private Sub SaleMixReportByProduct(ByVal BySaleMode As Boolean, ByVal SMData As DataTable, ByVal PromotionData As DataTable, ByVal ProductData As DataTable, _
    ByRef GraphData As DataSet, ByRef ResultString As String, ByRef grandTotal As Double, ByRef VATTotal As Double, ByVal ShowSummary As Boolean, _
    ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal ShopID As String, ByVal ViewOption As Integer, ByVal StartDate As String, ByVal EndDate As String, _
    ByVal dtTable As DataTable, ByVal PaymentResult As DataTable, ByVal PayByCreditMoney As DataTable, ByVal LangID As Integer, _
    ByVal LangPath As String, ByVal objCnn As MySqlConnection)

        Dim FormatData As DataTable = Fm.FormatParam(FormatObject, LangID, objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
        Dim LangData2 As DataTable = pRoMiSeLanguage.pRoMiSeLanguage.LangInfo(6, 2, -1, LangPath)
        Dim LangText As String = "lang" + LangID.ToString

        Dim i, j As Integer
        Dim outputString As StringBuilder = New StringBuilder
        Dim counter As Integer
        Dim ShowString As String = ""
        Dim subTotalRetailPrice As Double = 0
        Dim subTotalDiscount As Double = 0
        Dim subTotalSale As Double = 0
        Dim subTotalQty As Double = 0

        Dim subTotalGroupRetailPrice As Double = 0
        Dim subTotalGroupDiscount As Double = 0
        Dim subTotalGroupSale As Double = 0
        Dim subTotalGroupQty As Double = 0

        Dim grandTotalRetailPrice As Double = 0
        Dim grandTotalDiscount As Double = 0
        Dim grandTotalSale As Double = 0
        Dim grandTotalQty As Double = 0
		
        Dim grandTotalAfterVAT As Double = 0

        Dim RetailPriceAfterVAT As Double = 0
        Dim TextClass As String
        Dim VATString As String
        Dim bgColor As String = "white" 'GlobalParam.GrayBGColor
        Dim ExtraInfo As String
        Dim getProp As New CPreferences

        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

        TextClass = "smallText"
        Dim SummaryText As String = "smallboldtext"

        Dim table As DataTable = GraphData.Tables.Add("Data")
        table.Columns.Add("Description")
        table.Columns.Add("Value1", GetType(Double))

        counter = 1
        Dim ProductQty As Double
        Dim sumtotalSale As Double = 0
        Dim totalSaleBeforeDiscount As Double = 0
        Dim totalQty As Integer = 0
        Dim SumSaleMode As Double = 0

        Dim SaleModeQty As Double = 0
        Dim TotalRetailPrice As Double = 0
        Dim TotalDiscount As Double = 0
        Dim TotalSale As Double = 0

        Dim ColSpan As String = (SMData.Rows.Count + 9).ToString
        Dim ColSpan2 As String = (SMData.Rows.Count + 3).ToString
        Dim ColSpan3 As String = (SMData.Rows.Count + 6).ToString
        Dim strProductName As String
        Dim foundRows() As DataRow
        Dim expression As String
		
        If dtTable.Rows.Count > 0 Then
            sumtotalSale = dtTable.Compute("SUM(SalePrice)", "")
        End If
        For i = 0 To ProductData.Rows.Count - 1
            If IsDBNull(ProductData.Rows(i)("ProductName")) Then
                ProductData.Rows(i)("ProductName") = ""
            End If
            If IsDBNull(ProductData.Rows(i)("ProductCode")) Then
                ProductData.Rows(i)("ProductCode") = ""
            End If
            If IsDBNull(ProductData.Rows(i)("ProductGroupCode")) Then
                ProductData.Rows(i)("ProductGroupCode") = ""
            End If
            If IsDBNull(ProductData.Rows(i)("ProductGroupName")) Then
                ProductData.Rows(i)("ProductGroupName") = ""
            End If
            If IsDBNull(ProductData.Rows(i)("ProductDeptCode")) Then
                ProductData.Rows(i)("ProductDeptCode") = ""
            End If
            If IsDBNull(ProductData.Rows(i)("ProductDeptName")) Then
                ProductData.Rows(i)("ProductDeptName") = ""
            End If
            If IsDBNull(ProductData.Rows(i)("GroupOrdering")) Then
                ProductData.Rows(i)("GroupOrdering") = 0
            End If
            If IsDBNull(ProductData.Rows(i)("DeptOrdering")) Then
                ProductData.Rows(i)("DeptOrdering") = 0
            End If
        Next i
		
        For i = 0 To ProductData.Rows.Count - 1
            If i = 0 Then
                outputString = outputString.Append("<tr><td colspan=""" + ColSpan + """ class=""tdHeader"" bgColor=""" + AdminBGColor + """>" + ProductData.Rows(i)("ProductGroupName") + " :: " + ProductData.Rows(i)("ProductDeptName") + "</td></tr>")
            ElseIf ProductData.Rows(i - 1)("ProductDeptCode") <> ProductData.Rows(i)("ProductDeptCode") Then
                outputString = outputString.Append("<tr><td colspan=""" + ColSpan + """ class=""tdHeader"" bgColor=""" + AdminBGColor + """>" + ProductData.Rows(i)("ProductGroupName") + " :: " + ProductData.Rows(i)("ProductDeptName") + "</td></tr>")
            End If
			
            outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & (i + 1).ToString & ")</td>")
			
            If Not IsDBNull(dtTable.Rows(i)("ProductCode")) Then
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & ProductData.Rows(i)("ProductCode") & "</td>")
            Else
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>")
            End If
            If ProductData.Rows(i)("ProductSettype") < 0 Then
                ExtraInfo = "**"
            ElseIf ProductData.Rows(i)("OrderStatusID") = 5 Then
                ExtraInfo = "*"
            ElseIf ProductData.Rows(i)("ProductIDLink") <> -99 Then
                ExtraInfo = "**"
            Else
                ExtraInfo = ""
            End If
            If Not IsDBNull(ProductData.Rows(i)("ProductName")) Then
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & ProductData.Rows(i)("ProductName") + ExtraInfo & "</td>")
                ' ElseIf Not IsDBNull(ProductData.Rows(i)("OtherFoodName")) Then
                '    outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & ProductData.Rows(i)("OtherFoodName") & "</td>")
            Else
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>")
            End If
            SaleModeQty = 0
            TotalRetailPrice = 0
            TotalDiscount = 0
            TotalSale = 0
			
            For j = 0 To SMData.Rows.Count - 1
                If ProductData.Rows(i)("ProductName") = "" Then
                    strProductName = ""
                    expression = "ProductCode IS NULL AND ProductSetType=" & ProductData.Rows(i)("ProductSetType") & " AND " & _
                                "SaleMode=" & SMData.Rows(j)("SaleModeID") & " AND VATType=" & ProductData.Rows(i)("VATType") & " AND " & _
                                "OrderStatusID=" & ProductData.Rows(i)("OrderStatusID") & " AND ProductIDLink=" & ProductData.Rows(i)("ProductIDLink") & " AND " & _
                                "ProductName IS NULL"
                Else
                    strProductName = Replace(ProductData.Rows(i)("ProductName"), "'", "''").ToString
                    expression = "ProductCode= '" & ProductData.Rows(i)("ProductCode") & "' AND ProductSetType = " & ProductData.Rows(i)("ProductSetType") & " AND " & _
                                " SaleMode=" & SMData.Rows(j)("SaleModeID") & " AND VATType=" & ProductData.Rows(i)("VATType") & " AND " & _
                                " OrderStatusID=" & ProductData.Rows(i)("OrderStatusID") & " AND ProductIDLink=" & ProductData.Rows(i)("ProductIDLink") & " AND " & _
                                " ProductName='" & strProductName & "' AND ProductGroupCode = '" & ProductData.Rows(i)("ProductGroupCode") & "' AND " & _
                                " ProductGroupName = '" & ReplaceSuitableStringForSQL(ProductData.Rows(i)("ProductGroupName")) & "' AND " & _
                                " ProductDeptCode = '" & ProductData.Rows(i)("ProductDeptCode") & "' AND " & _
                                " ProductDeptName = '" & ReplaceSuitableStringForSQL(ProductData.Rows(i)("ProductDeptName")) & "' "
                End If
                foundRows = dtTable.Select(expression)
                ProductQty = 0
				
                If foundRows.GetUpperBound(0) >= 0 Then
                    ProductQty = foundRows(0)("Amount")
                    subTotalQty += ProductQty
                    grandTotalQty += ProductQty
                    subTotalGroupQty += ProductQty
                    SaleModeQty += ProductQty
                    TotalRetailPrice += foundRows(0)("TotalRetailPrice")
                    TotalSale += foundRows(0)("SalePrice")
                    TotalDiscount += foundRows(0)("TotalRetailPrice") - foundRows(0)("SalePrice")
					
                    subTotalRetailPrice += foundRows(0)("TotalRetailPrice")
                    subTotalSale += foundRows(0)("SalePrice")
                    subTotalDiscount += foundRows(0)("TotalRetailPrice") - foundRows(0)("SalePrice")
					
                    subTotalGroupRetailPrice += foundRows(0)("TotalRetailPrice")
                    subTotalGroupSale += foundRows(0)("SalePrice")
                    subTotalGroupDiscount += foundRows(0)("TotalRetailPrice") - foundRows(0)("SalePrice")
					
                    grandTotalRetailPrice += foundRows(0)("TotalRetailPrice")
                    grandTotalSale += foundRows(0)("SalePrice")
                    grandTotalDiscount += foundRows(0)("TotalRetailPrice") - foundRows(0)("SalePrice")
                End If
                outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & CDbl(ProductQty).ToString(FormatObject.QtyFormat, ci) & "</td>")
            Next
            outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & CDbl(SaleModeQty).ToString(FormatObject.QtyFormat, ci) & "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(TotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(TotalDiscount).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(TotalSale).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
			
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(TotalSale / sumtotalSale).ToString(FormatObject.PercentFormat, ci) & "</td>")
			
            If ProductData.Rows(i)("VATType") = 0 Then
                VATString = "N"
            ElseIf ProductData.Rows(i)("VATType") = 1 Then
                VATString = "V"
            Else
                VATString = "E"
            End If
            outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & VATString & "</td>")
            outputString = outputString.Append("</tr>")
			
            If i = ProductData.Rows.Count - 1 Then
                outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
                outputString = outputString.Append("<td colspan=""" + ColSpan2 + """ align=""right"" class=""" + SummaryText + """>" + "SubTotal" + " " + ProductData.Rows(i)("ProductDeptName") + "</td>")
                outputString = outputString.Append("<td align=""center"" class=""" + SummaryText + """>" + CDbl(subTotalQty).ToString(FormatObject.QtyFormat, ci) + "</td>")

                outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")

                outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl((subTotalSale / sumtotalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                outputString = outputString.Append("<td></td></tr>")
				
                outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
                outputString = outputString.Append("<td colspan=""" + ColSpan2 + """ align=""right"" class=""" + SummaryText + """>" + "SubTotal" + " " + ProductData.Rows(i)("ProductGroupName") + "</td>")
                outputString = outputString.Append("<td align=""center"" class=""" + SummaryText + """>" + CDbl(subTotalGroupQty).ToString(FormatObject.QtyFormat, ci) + "</td>")

                outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalGroupRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")

                outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalGroupDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalGroupSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl((subTotalGroupSale / sumtotalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                outputString = outputString.Append("<td></td></tr>")
            Else
                If ProductData.Rows(i)("ProductDeptCode") <> ProductData.Rows(i + 1)("ProductDeptCode") Then
                    outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
                    outputString = outputString.Append("<td colspan=""" + ColSpan2 + """ align=""right"" class=""" + SummaryText + """>" + "SubTotal" + " " + ProductData.Rows(i)("ProductDeptName") + "</td>")
                    outputString = outputString.Append("<td align=""center"" class=""" + SummaryText + """>" + CDbl(subTotalQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
	
                    outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
	
                    outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl((subTotalSale / sumtotalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                    outputString = outputString.Append("<td></td></tr>")
                    subTotalRetailPrice = 0
                    subTotalSale = 0
                    subTotalDiscount = 0
                    subTotalQty = 0
                End If
                If ProductData.Rows(i)("ProductGroupCode") <> ProductData.Rows(i + 1)("ProductGroupCode") Then
                    outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
                    outputString = outputString.Append("<td colspan=""" + ColSpan2 + """ align=""right"" class=""" + SummaryText + """>" + "SubTotal" + " " + ProductData.Rows(i)("ProductGroupName") + "</td>")
                    outputString = outputString.Append("<td align=""center"" class=""" + SummaryText + """>" + CDbl(subTotalGroupQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
	
                    outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalGroupRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
	
                    outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalGroupDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalGroupSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl((subTotalGroupSale / sumtotalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                    outputString = outputString.Append("<td></td></tr>")
                    subTotalGroupRetailPrice = 0
                    subTotalGroupSale = 0
                    subTotalGroupDiscount = 0
                    subTotalGroupQty = 0
                End If
            End If
        Next
		
        If ProductData.Rows.Count > 0 Then
            outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
            outputString = outputString.Append("<td colspan=""" + ColSpan2 + """ align=""right"" class=""" + SummaryText + """>" + "Grand Total" + "</td>")
            outputString = outputString.Append("<td align=""center"" class=""" + SummaryText + """>" + CDbl(grandTotalQty).ToString(FormatObject.QtyFormat, ci) + "</td>")

            outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(grandTotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")

            outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(grandTotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(grandTotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(1).ToString(FormatObject.PercentFormat, ci) + "</td>")
            outputString = outputString.Append("<td></td></tr>")
        End If
        'outputString = outputString.Append("</table>")
		
        grandTotalAfterVAT = grandTotalSale

        If ShowSummary = True Then
            Dim ServiceChargeQuery As String = ""

            If ShopID <> "" Then
                ServiceChargeQuery = " AND a.ShopID IN (" + ShopID.ToString + ")"
            End If
            Dim grandTotalServiceChargeVAT As Double = 0

            Dim ProductLevelID As String = ShopID
            If ShopID = "0" Then ProductLevelID = "1"
            Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel where ProductLevelID IN (" + ProductLevelID.ToString + ")", objCnn)
            Dim DisplayVATType As String = "V"
            If ShopInfo.Rows.Count > 0 Then
                If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
                    DisplayVATType = "E"
                End If
            Else
                ShopInfo = objDB.List("select * from ProductLevel where IsShop=1 AND Deleted=0", objCnn)
                If ShopInfo.Rows.Count > 0 Then
                    If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
                        DisplayVATType = "E"
                    End If
                End If
            End If
			
            Dim grandTotalServiceCharge As Double = 0
			
            outputString = outputString.Append("<tr><td colspan=""" + ColSpan + """ height=""5""></td></tr>")

            Dim serviceCharge As DataTable = objDB.List("select SUM(a.ServiceCharge) AS ServiceCharge, SUM(a.ServiceChargeVAT) AS ServiceChargeVAT from  ordertransaction a WHERE TransactionStatusID=2 AND ReceiptID > 0 AND SaleDate >= " + StartDate + " AND SaleDate < " + EndDate + ServiceChargeQuery, objCnn)
            If Not IsDBNull(serviceCharge.Rows(0)("ServiceCharge")) Then
                grandTotalServiceCharge = serviceCharge.Rows(0)("ServiceCharge") + serviceCharge.Rows(0)("ServiceChargeVAT")
                grandTotalServiceChargeVAT = serviceCharge.Rows(0)("ServiceChargeVAT")
            Else
                grandTotalServiceCharge = 0
            End If
			
            Dim grandTotalOtherIncome As Double = 0
            Dim ChkIncome As Boolean = getProp.CheckTableExist("ordertransactionotherincomedetail", objCnn)
            Dim IncomeText As String = ""
            If ChkIncome = True Then
                Dim OtherIncome As DataTable = objDB.List("select b.IncomeTypeID,c.DisplayName As IncomeName,SUM(b.Income) AS Income, SUM(b.IncomeVAT) AS IncomeVAT from ordertransaction a, ordertransactionotherincomedetail b, OtherIncomeType c  WHERE a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.IncomeTypeID=c.IncomeTypeID AND a.TransactionStatusID=2 AND b.IncomeStatus=1 AND ReceiptID > 0 AND SaleDate >= " + StartDate + " AND SaleDate < " + EndDate + ServiceChargeQuery + " group by b.IncomeTypeID,c.DisplayName order by b.IncomeTypeID", objCnn)
                For i = 0 To OtherIncome.Rows.Count - 1
                    IncomeText += "<tr bgColor=""" + GrayBGColor + """>"
                    IncomeText += "<td colspan=""" + ColSpan3 + """ align=""right"" class=""" + TextClass + """>" + OtherIncome.Rows(i)("IncomeName") + "</td>"
                    If DisplayVATType = "V" Then
                        IncomeText += "<td align=""right"" class=""smallText"">" + CDbl(OtherIncome.Rows(i)("Income") + OtherIncome.Rows(i)("IncomeVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td>"
                        grandTotalOtherIncome += OtherIncome.Rows(i)("Income") + OtherIncome.Rows(i)("IncomeVAT")
                    Else
                        IncomeText += "<td align=""right"" class=""smallText"">" + CDbl(OtherIncome.Rows(i)("Income")).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td>"
                        grandTotalOtherIncome += OtherIncome.Rows(i)("Income")
                    End If
                    IncomeText += "</tr>"
                Next
            End If
			
            grandTotalAfterVAT += grandTotalOtherIncome

            Dim grandTotalSaleAvg As Double

            If DisplayVATType = "V" Then
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""" + ColSpan3 + """ align=""right"" class=""" + TextClass + """>" + LangData2.Rows(93)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalServiceCharge).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")
                'grandTotalAfterVAT += grandTotalServiceCharge + grandTotalOtherIncome
                grandTotalSaleAvg = grandTotalAfterVAT
                If IncomeText <> "" Then
                    outputString = outputString.Append(IncomeText)
                End If
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""" + ColSpan3 + """ align=""right"" class=""" + TextClass + """>" + LangData2.Rows(95)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")
                grandTotalAfterVAT += grandTotalServiceCharge

            Else
                If grandTotalServiceCharge - grandTotalServiceChargeVAT > 0 Then
                    outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                    outputString = outputString.Append("<td colspan=""" + ColSpan3 + """ align=""right"" class=""" + TextClass + """>" + LangData2.Rows(93)(LangText) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalServiceCharge - grandTotalServiceChargeVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")
                End If
				
                grandTotalAfterVAT += grandTotalServiceCharge - grandTotalServiceChargeVAT

                If IncomeText <> "" Then
                    outputString = outputString.Append(IncomeText)
                End If

                Dim VATData As DataTable = objDB.List("select SUM(a.TransactionVAT) AS TotalVAT from  ordertransaction a WHERE TransactionStatusID=2 AND ReceiptID > 0 AND SaleDate >= " + StartDate + " AND SaleDate < " + EndDate + ServiceChargeQuery, objCnn)
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""" + ColSpan3 + """ align=""right"" class=""" + TextClass + """>" + "Tax" + "</td>")
                If Not IsDBNull(VATData.Rows(0)("TotalVAT")) Then
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(VATData.Rows(0)("TotalVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")
                    grandTotalSaleAvg += grandTotalServiceCharge + grandTotalOtherIncome
                    grandTotalAfterVAT += VATData.Rows(0)("TotalVAT")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(0).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")
                End If
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""" + ColSpan3 + """ align=""right"" class=""" + SummaryText + """>" + LangData2.Rows(95)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(grandTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")

            End If

            

            'End If
        End If
        outputString = outputString.Append("</table>")
        grandTotal = grandTotalAfterVAT
        ResultString = outputString.ToString()

    End Sub
		
    Private sub SaleMixHourlyReportByProduct(ByVal BySaleMode As Boolean, ByVal HourlyData As DataTable, ByVal PromotionData As DataTable, _
    ByVal ProductData As DataTable, ByRef GraphData As DataSet, ByRef ResultString As String, ByRef grandTotal As Double, ByRef VATTotal As Double, _
    ByVal ShowSummary As Boolean, ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal ShopID As String, ByVal ViewOption As Integer, _
    ByVal StartDate As String, ByVal EndDate As String, ByVal dtTable As DataTable, ByVal PaymentResult As DataTable, ByVal PayByCreditMoney As DataTable, _
    ByVal LangID As Integer, ByVal LangPath As String, ByVal objCnn As MySqlConnection)
        Dim FormatData As DataTable = Fm.FormatParam(FormatObject, LangID, objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
        Dim LangData2 As DataTable = pRoMiSeLanguage.pRoMiSeLanguage.LangInfo(6, 2, -1, LangPath)
        Dim LangText As String = "lang" + LangID.ToString

        Dim i, j As Integer
        Dim outputString As StringBuilder = New StringBuilder
        Dim counter As Integer
        Dim ShowString As String = ""
        Dim subTotalRetailPrice As Double = 0
        Dim subTotalDiscount As Double = 0
        Dim subTotalSale As Double = 0
        Dim subTotalQty As Double = 0

        Dim subTotalGroupRetailPrice As Double = 0
        Dim subTotalGroupDiscount As Double = 0
        Dim subTotalGroupSale As Double = 0
        Dim subTotalGroupQty As Double = 0

        Dim grandTotalRetailPrice As Double = 0
        Dim grandTotalDiscount As Double = 0
        Dim grandTotalSale As Double = 0
        Dim grandTotalQty As Double = 0
		
        Dim grandTotalAfterVAT As Double = 0

        Dim RetailPriceAfterVAT As Double = 0
        Dim TextClass As String
        Dim VATString As String
        Dim bgColor As String = "white" 'GlobalParam.GrayBGColor
        Dim ExtraInfo As String
        Dim getProp As New CPreferences

        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

        TextClass = "smallText"
        Dim SummaryText As String = "smallboldtext"

        Dim table As DataTable = GraphData.Tables.Add("Data")
        table.Columns.Add("Description")
        table.Columns.Add("Value1", GetType(Double))

        counter = 1
        Dim ProductQty As Double
        Dim sumtotalSale As Double = 0
        Dim totalSaleBeforeDiscount As Double = 0
        Dim totalQty As Integer = 0
        Dim SumSaleMode As Double = 0

        Dim SaleModeQty As Double = 0
        Dim TotalRetailPrice As Double = 0
        Dim TotalDiscount As Double = 0
        Dim TotalSale As Double = 0
	
        Dim ColSpan As String = (HourlyData.Rows.Count + 7).ToString
        Dim ColSpan2 As String = (HourlyData.Rows.Count + 3).ToString
        Dim ColSpan3 As String = (HourlyData.Rows.Count + 4).ToString
        Dim foundRows() As DataRow
        Dim expression As String
		
        If dtTable.Rows.Count = 0 Then
            sumtotalSale = 0
        Else
            sumtotalSale = dtTable.Compute("SUM(SalePrice)", "")
        End If
		
        For i = 0 To ProductData.Rows.Count - 1
            If i = 0 Then
                outputString = outputString.Append("<tr><td colspan=""" + ColSpan + """ class=""tdHeader"" bgColor=""" + AdminBGColor + """>" + ProductData.Rows(i)("ProductGroupName") + " :: " + ProductData.Rows(i)("ProductDeptName") + "</td></tr>")
            ElseIf ProductData.Rows(i - 1)("ProductDeptCode") <> ProductData.Rows(i)("ProductDeptCode") Then
                outputString = outputString.Append("<tr><td colspan=""" + ColSpan + """ class=""tdHeader"" bgColor=""" + AdminBGColor + """>" + ProductData.Rows(i)("ProductGroupName") + " :: " + ProductData.Rows(i)("ProductDeptName") + "</td></tr>")
            End If
			
            outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & (i + 1).ToString & ")</td>")
			
            If Not IsDBNull(dtTable.Rows(i)("ProductCode")) Then
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & ProductData.Rows(i)("ProductCode") & "</td>")
            Else
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>")
            End If
            If ProductData.Rows(i)("ProductSettype") < 0 Then
                ExtraInfo = "**"
            ElseIf ProductData.Rows(i)("OrderStatusID") = 5 Then
                ExtraInfo = "*"
            ElseIf ProductData.Rows(i)("ProductIDLink") <> -99 Then
                ExtraInfo = "**"
            Else
                ExtraInfo = ""
            End If
            If Not IsDBNull(ProductData.Rows(i)("ProductName")) Then
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & ProductData.Rows(i)("ProductName") + ExtraInfo & "</td>")
            ElseIf Not IsDBNull(ProductData.Rows(i)("OtherFoodName")) Then
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & ProductData.Rows(i)("OtherFoodName") & "</td>")
            Else
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>")
            End If
            SaleModeQty = 0
            TotalRetailPrice = 0
            TotalDiscount = 0
            TotalSale = 0
            Dim AdditionalQuery As String
            For j = 0 To HourlyData.Rows.Count - 1
                If HourlyData.Rows(j)("Hourly") = 0 Then
                    AdditionalQuery = " AND Hourly>=0 AND Hourly <= 6"
                Else
                    AdditionalQuery = " AND Hourly=" + HourlyData.Rows(j)("Hourly").ToString
                End If
                expression = "ProductCode='" & ProductData.Rows(i)("ProductCode") & "' AND ProductSetType=" & ProductData.Rows(i)("ProductSetType") & " AND " & _
                            " VATType=" & ProductData.Rows(i)("VATType") & " AND OrderStatusID=" & ProductData.Rows(i)("OrderStatusID") & " AND " & _
                            " ProductIDLink=" & ProductData.Rows(i)("ProductIDLink") & " AND " & _
                            " ProductName= '" & ReplaceSuitableStringForSQL(ProductData.Rows(i)("ProductName")) & "' AND " & _
                            " ProductGroupCode = '" & ProductData.Rows(i)("ProductGroupCode") & "' AND " & _
                            " ProductGroupName = '" & ReplaceSuitableStringForSQL(ProductData.Rows(i)("ProductGroupName")) & "' AND " & _
                            " ProductDeptCode = '" & ProductData.Rows(i)("ProductDeptCode") & "' AND " & _
                            " ProductDeptName = '" & ReplaceSuitableStringForSQL(ProductData.Rows(i)("ProductDeptName")) & "' " & AdditionalQuery
                foundRows = dtTable.Select(expression)
				
                ProductQty = 0
				
                If foundRows.GetUpperBound(0) >= 0 Then
                    ProductQty = foundRows(0)("Amount")
                    subTotalQty += ProductQty
                    grandTotalQty += ProductQty
                    subTotalGroupQty += ProductQty
                    SaleModeQty += ProductQty
                    TotalRetailPrice += foundRows(0)("TotalRetailPrice")
                    TotalSale += foundRows(0)("SalePrice")
                    TotalDiscount += foundRows(0)("TotalRetailPrice") - foundRows(0)("SalePrice")
					
                    subTotalRetailPrice += foundRows(0)("TotalRetailPrice")
                    subTotalSale += foundRows(0)("SalePrice")
                    subTotalDiscount += foundRows(0)("TotalRetailPrice") - foundRows(0)("SalePrice")
					
                    subTotalGroupRetailPrice += foundRows(0)("TotalRetailPrice")
                    subTotalGroupSale += foundRows(0)("SalePrice")
                    subTotalGroupDiscount += foundRows(0)("TotalRetailPrice") - foundRows(0)("SalePrice")
					
                    grandTotalRetailPrice += foundRows(0)("TotalRetailPrice")
                    grandTotalSale += foundRows(0)("SalePrice")
                    grandTotalDiscount += foundRows(0)("TotalRetailPrice") - foundRows(0)("SalePrice")
                End If
                outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & CDbl(ProductQty).ToString(FormatObject.QtyFormat, ci) & "</td>")
            Next
            outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & CDbl(SaleModeQty).ToString(FormatObject.QtyFormat, ci) & "</td>")
            'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(TotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
            'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(TotalDiscount).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(TotalSale).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
			
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(TotalSale / sumtotalSale).ToString(FormatObject.PercentFormat, ci) & "</td>")
			
            If ProductData.Rows(i)("VATType") = 0 Then
                VATString = "N"
            ElseIf ProductData.Rows(i)("VATType") = 1 Then
                VATString = "V"
            Else
                VATString = "E"
            End If
            outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & VATString & "</td>")
            outputString = outputString.Append("</tr>")
			
            If i = ProductData.Rows.Count - 1 Then
                outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
                outputString = outputString.Append("<td colspan=""" + ColSpan2 + """ align=""right"" class=""" + SummaryText + """>" + "SubTotal" + " " + ProductData.Rows(i)("ProductDeptName") + "</td>")
                outputString = outputString.Append("<td align=""center"" class=""" + SummaryText + """>" + CDbl(subTotalQty).ToString(FormatObject.QtyFormat, ci) + "</td>")

                'outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")

                'outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl((subTotalSale / sumtotalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                outputString = outputString.Append("<td></td></tr>")
				
                outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
                outputString = outputString.Append("<td colspan=""" + ColSpan2 + """ align=""right"" class=""" + SummaryText + """>" + "SubTotal" + " " + ProductData.Rows(i)("ProductGroupName") + "</td>")
                outputString = outputString.Append("<td align=""center"" class=""" + SummaryText + """>" + CDbl(subTotalGroupQty).ToString(FormatObject.QtyFormat, ci) + "</td>")

                'outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalGroupRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")

                'outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalGroupDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalGroupSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl((subTotalGroupSale / sumtotalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                outputString = outputString.Append("<td></td></tr>")
            Else
                If ProductData.Rows(i)("ProductDeptCode") <> ProductData.Rows(i + 1)("ProductDeptCode") Then
                    outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
                    outputString = outputString.Append("<td colspan=""" + ColSpan2 + """ align=""right"" class=""" + SummaryText + """>" + "SubTotal" + " " + ProductData.Rows(i)("ProductDeptName") + "</td>")
                    outputString = outputString.Append("<td align=""center"" class=""" + SummaryText + """>" + CDbl(subTotalQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
	
                    'outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
	
                    'outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl((subTotalSale / sumtotalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                    outputString = outputString.Append("<td></td></tr>")
                    subTotalQty = 0
                    subTotalRetailPrice = 0
                    subTotalSale = 0
                    subTotalDiscount = 0
                End If
                If ProductData.Rows(i)("ProductGroupCode") <> ProductData.Rows(i + 1)("ProductGroupCode") Then
                    outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
                    outputString = outputString.Append("<td colspan=""" + ColSpan2 + """ align=""right"" class=""" + SummaryText + """>" + "SubTotal" + " " + ProductData.Rows(i)("ProductGroupName") + "</td>")
                    outputString = outputString.Append("<td align=""center"" class=""" + SummaryText + """>" + CDbl(subTotalGroupQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
	
                    'outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalGroupRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
	
                    'outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalGroupDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(subTotalGroupSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl((subTotalGroupSale / sumtotalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                    outputString = outputString.Append("<td></td></tr>")
                    subTotalGroupQty = 0
                    subTotalGroupRetailPrice = 0
                    subTotalGroupSale = 0
                    subTotalGroupDiscount = 0
                End If
            End If
        Next
		
        If ProductData.Rows.Count > 0 Then
            outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
            outputString = outputString.Append("<td colspan=""" + ColSpan2 + """ align=""right"" class=""" + SummaryText + """>" + "Grand Total" + "</td>")
            outputString = outputString.Append("<td align=""center"" class=""" + SummaryText + """>" + CDbl(grandTotalQty).ToString(FormatObject.QtyFormat, ci) + "</td>")

            'outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(grandTotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")

            'outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(grandTotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(grandTotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(100).ToString(FormatObject.PercentFormat, ci) + "</td>")
            outputString = outputString.Append("<td></td></tr>")
        End If

		
        grandTotalAfterVAT = grandTotalSale

        If ShowSummary = True Then
            Dim ServiceChargeQuery As String = ""

            If ShopID <> "" Then
                ServiceChargeQuery = " AND a.ShopID IN (" + ShopID.ToString + ")"
            End If
            Dim grandTotalServiceChargeVAT As Double = 0

            Dim ProductLevelID As Integer = ShopID
            If ShopID = 0 Then ProductLevelID = 1
            Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel where ProductLevelID=" + ProductLevelID.ToString, objCnn)
            Dim DisplayVATType As String = "V"
            If ShopInfo.Rows.Count > 0 Then
                If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
                    DisplayVATType = "E"
                End If
            Else
                ShopInfo = objDB.List("select * from ProductLevel where IsShop=1 AND Deleted=0", objCnn)
                If ShopInfo.Rows.Count > 0 Then
                    If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
                        DisplayVATType = "E"
                    End If
                End If
            End If
			
            Dim grandTotalServiceCharge As Double = 0
			
            outputString = outputString.Append("<tr><td colspan=""" + ColSpan + """ height=""5""></td></tr>")

            Dim serviceCharge As DataTable = objDB.List("select SUM(a.ServiceCharge) AS ServiceCharge, SUM(a.ServiceChargeVAT) AS ServiceChargeVAT from  ordertransaction a WHERE TransactionStatusID=2 AND ReceiptID > 0 AND SaleDate >= " + StartDate + " AND SaleDate < " + EndDate + ServiceChargeQuery, objCnn)
            If Not IsDBNull(serviceCharge.Rows(0)("ServiceCharge")) Then
                grandTotalServiceCharge = serviceCharge.Rows(0)("ServiceCharge") + serviceCharge.Rows(0)("ServiceChargeVAT")
                grandTotalServiceChargeVAT = serviceCharge.Rows(0)("ServiceChargeVAT")
            Else
                grandTotalServiceCharge = 0
            End If

            Dim grandTotalOtherIncome As Double = 0
            Dim ChkIncome As Boolean = getProp.CheckTableExist("ordertransactionotherincomedetail", objCnn)
            Dim IncomeText As String = ""
            If ChkIncome = True Then
                Dim OtherIncome As DataTable = objDB.List("select b.IncomeTypeID,c.DisplayName As IncomeName,SUM(b.Income) AS Income, SUM(b.IncomeVAT) AS IncomeVAT from ordertransaction a, ordertransactionotherincomedetail b, OtherIncomeType c  WHERE a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.IncomeTypeID=c.IncomeTypeID AND a.TransactionStatusID=2 AND b.IncomeStatus=1 AND ReceiptID > 0 AND SaleDate >= " + StartDate + " AND SaleDate < " + EndDate + ServiceChargeQuery + " group by b.IncomeTypeID,c.DisplayName order by b.IncomeTypeID", objCnn)
                For i = 0 To OtherIncome.Rows.Count - 1
                    IncomeText += "<tr bgColor=""" + GrayBGColor + """>"
                    IncomeText += "<td colspan=""" + ColSpan3 + """ align=""right"" class=""" + TextClass + """>" + OtherIncome.Rows(i)("IncomeName") + "</td>"
                    If DisplayVATType = "V" Then
                        IncomeText += "<td align=""right"" class=""smallText"">" + CDbl(OtherIncome.Rows(i)("Income") + OtherIncome.Rows(i)("IncomeVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td>"
                        grandTotalOtherIncome += OtherIncome.Rows(i)("Income") + OtherIncome.Rows(i)("IncomeVAT")
                    Else
                        IncomeText += "<td align=""right"" class=""smallText"">" + CDbl(OtherIncome.Rows(i)("Income")).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td>"
                        grandTotalOtherIncome += OtherIncome.Rows(i)("Income")
                    End If
                    IncomeText += "</tr>"
                Next
            End If

            Dim grandTotalSaleAvg As Double

            If DisplayVATType = "V" Then
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""" + ColSpan3 + """ align=""right"" class=""" + TextClass + """>" + LangData2.Rows(93)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalServiceCharge).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")
                grandTotalAfterVAT += grandTotalServiceCharge + grandTotalOtherIncome
                grandTotalSaleAvg = grandTotalAfterVAT
                If IncomeText <> "" Then
                    outputString = outputString.Append(IncomeText)
                End If
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""" + ColSpan3 + """ align=""right"" class=""" + TextClass + """>" + LangData2.Rows(95)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")

            Else
                If grandTotalServiceCharge - grandTotalServiceChargeVAT > 0 Then
                    outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                    outputString = outputString.Append("<td colspan=""" + ColSpan3 + """ align=""right"" class=""" + TextClass + """>" + LangData2.Rows(93)(LangText) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalServiceCharge - grandTotalServiceChargeVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")
                End If

                If IncomeText <> "" Then
                    outputString = outputString.Append(IncomeText)
                End If

                Dim VATData As DataTable = objDB.List("select SUM(a.TransactionVAT) AS TotalVAT from  ordertransaction a WHERE TransactionStatusID=2 AND ReceiptID > 0 AND SaleDate >= " + StartDate + " AND SaleDate < " + EndDate + ServiceChargeQuery, objCnn)
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""" + ColSpan3 + """ align=""right"" class=""" + TextClass + """>" + "Tax" + "</td>")
                If Not IsDBNull(VATData.Rows(0)("TotalVAT")) Then
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(VATData.Rows(0)("TotalVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")
                    grandTotalSaleAvg += grandTotalServiceCharge + grandTotalOtherIncome
                    grandTotalAfterVAT += grandTotalServiceCharge + VATData.Rows(0)("TotalVAT")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(0).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")
                End If
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""" + ColSpan3 + """ align=""right"" class=""" + SummaryText + """>" + LangData2.Rows(95)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + SummaryText + """>" + CDbl(grandTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")

            End If

            

            'End If
        End If
        outputString = outputString.Append("</table>")
        grandTotal = grandTotalAfterVAT
        ResultString = outputString.ToString()

    End Sub
	
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
