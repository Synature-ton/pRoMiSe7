<%@ Page Language="VB" ContentType="text/html" EnableViewState="False" debug="true" %>
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
<%@Import Namespace="POSBackOfficeReport" %>
<%@Import Namespace="CheckSummaryByZone" %>
<%@Import Namespace="System.IO" %>


<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Sale Report By Group</title>
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
				<td><span id="ZoneText" runat="server"></span></td>
			</tr>
			<tr id="show12" visible="false" runat="server">
				<td><asp:radiobutton ID="Radio_11" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
			<tr id="show22" visible="false" runat="server">
				<td><asp:radiobutton ID="Radio_12" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
			<tr>
				<td><asp:button ID="SubmitForm" Font-Size="10" Height="30" Width="200" OnClick="DoSearch" runat="server" /></td>
			</tr>

		</table></td>
	
	<td>	
	<table>
		<tr>
			<td><asp:radiobutton ID="Radio_3" GroupName="Group1" Enabled="true" runat="server" /></td>
			<td colspan="4"><synature:date id="DailyDate" runat="server" /></td>
		</tr>
		<tr id="show1" visible="true" runat="server">
			<td><asp:radiobutton ID="Radio_1" GroupName="Group1" Enabled="true" runat="server" /></td>
			<td colspan="3"><synature:date id="MonthYearDate" runat="server" /></td>
		</tr>
		<tr>
			<td><asp:radiobutton ID="Radio_4" GroupName="Group1" runat="server" /></td>
			<td colspan="3"><synature:date id="YearDate" runat="server" /></td>
		</tr>
		<tr id="show2" visible="true" runat="server">
			<td><asp:radiobutton ID="Radio_2" GroupName="Group1" Enabled="true" runat="server" /></td>
			<td><synature:date id="CurrentDate" runat="server" /></td>
			<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
			<td><synature:date id="ToDate" runat="server" /></td>
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
<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>
<span id="showHeader" runat="server">
<span id="startTable" runat="server"></span>
	
	<span id="TableHeaderText" runat="server"></span>
	<span id="ExtraHeader" runat="server"></span>
	
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
Dim getReport As New stReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
    Dim FormatDocNumber As New FormatText()
    Dim Fm As New UtilityFunction()
Dim gtReport As New GenReports()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
    Dim PageID As Integer = 7
		
    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Report_SaleByGroupZone") Then
		
            Try
                objCnn = getCnn.EstablishConnection()
                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
                ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")

                showHeader.Visible = False
                Radio_3.Visible = True
		
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
                        TestLabel.Text = LangData.Rows(z)(LangText)
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
                DocumentToDateParam.InnerHtml = LangDefault.Rows(22)(LangText)
		
                LangText0.Text = "Summary Sale Report By Zone Report"
		
                startTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
			
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
		
                Radio_11.Text = "Order By Bill Date"
                Radio_12.Text = "Order By Staff"
		
                ResultText.InnerHtml = ""
                ResultSearchText.InnerHtml = ""
                errorMsg.InnerHtml = ""
		
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
			
                Dim i As Integer
                Dim outputString, FormSelected As String
                Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), objCnn)
                If ShopData.Rows.Count > 0 Then

                    outputString = "<select name=""ShopID"" style=""width:200px"">"
                    For i = 0 To ShopData.Rows.Count - 1
                        If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
                            FormSelected = "selected"
                            SelShopName.Value = ShopData.Rows(i)("ProductLevelName")
                        Else
                            If Not Page.IsPostBack And i = 0 Then
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
		
                Dim DataInfo As DataTable = getProp.TableInfo(1, ShopIDValue, 0, 0, objCnn)
                Dim ZoneIDValue As String = "0"
                If IsNumeric(Request.Form("ZoneID")) Then
                    ZoneIDValue = Request.Form("ZoneID").ToString
                ElseIf IsNumeric(Request.QueryString("ZoneID")) Then
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
                For i = 0 To DataInfo.Rows.Count - 1
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
				
                If Request.QueryString("from") = "drilldown" Then
                    ShowShop.Visible = False
                    Dim ViewOption As Integer = 1
                    Dim ShopID As String = ""
                    Dim zoneID As Integer = 0
                    Dim StartDate As String = ""
                    Dim EndDate As String = ""
                    Dim ReportDate As String = ""
                    Dim ReportOption As Integer = 1
                    If IsNumeric(Request.QueryString("ViewOption")) Then
                        ViewOption = Request.QueryString("ViewOption")
                    End If
                    If Not Request.QueryString("ShopID") Is Nothing Then
                        ShopID = Request.QueryString("ShopID")
                    End If
                    If Not Request.QueryString("ZoneID") Is Nothing Then
                        zoneID = Request.QueryString("ZoneID")
                    End If
                    If Trim(Request.QueryString("StartDate")) <> "" And Trim(Request.QueryString("EndDate")) <> "" Then
                        StartDate = Request.QueryString("StartDate")
                        EndDate = Request.QueryString("EndDate")
                    End If
                    If Trim(Request.QueryString("ReportDate")) <> "" Then
                        ReportDate = Request.QueryString("ReportDate")
                    End If
                    If Not Request.QueryString("ReportOption") Is Nothing Then
                        ReportOption = Request.QueryString("ReportOption")
                    End If
                    'errorMsg.InnerHtml = ViewOption.ToString + "::" + ShopID.ToString + "::" + StartDate + "::" + EndDate
			
                    showHeader.Visible = True
                    ShowPrint.Visible = True
			
                    GenOutput(ViewOption, ShopID, "", zoneID, Session("LangID"), StartDate, EndDate, ReportDate, ReportOption, objCnn)
			
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
        errorMsg.InnerHtml = ""
        Dim FoundError As Boolean
        FoundError = False
        Session("ReportResult") = ""
        Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
	
        Dim DateFromValue As String = ""
        Dim DateToValue As String = ""
        Dim DailyDateValue As String = ""
        Dim InvC As CultureInfo = CultureInfo.InvariantCulture
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString

        Dim StartDate, EndDate As String
        Dim StartMonthValue, StartYearValue, EndMonthValue, EndYearValue As Integer
        Dim outputString As String = ""
        Dim grandTotal As Double = 0
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
        ElseIf Request.Form("Group1") = "Radio_3" Then
            R3 = True
        Else
            R4 = True
        End If
	
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
        If FoundError = False Then
            If LangDefault.Rows.Count >= 3 Then
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(Now(), "DateAndTime", Session("LangID"), objCnn)
            End If
            Dim displayTable As New DataTable()
		
            showHeader.Visible = True
            ShowPrint.Visible = True
		
            Dim ViewOption As Integer
            If R3 = True Then
                ViewOption = 1
            ElseIf R1 = True Or R2 = True Then
                ViewOption = 2
            Else
                ViewOption = 3
            End If
            
            Dim ShopID As String = Request.Form("ShopID")
            Dim SMData As DataTable = objDB.List("select * from SaleMode where Deleted=0 order by SaleModeID", objCnn)
            Dim ROption As Integer
            If SMData.Rows.Count > 1 Then
                ROption = Request.Form("ReportOption")
            Else
                ROption = 1
            End If
		
            GenOutput(ViewOption, ShopID, Request.Form("AllShopID"), Request.Form("ZoneID"), Session("LangID"), StartDate, EndDate, ReportDate, ROption, objCnn)
        End If
           
    End Sub
        
    Public Sub GenOutput(ByVal ViewOption As Integer, ByVal ShopID As String, ByVal AllShopID As String, zoneID As Integer, _
    ByVal LangID As Integer, ByVal StartDate As String, _
    ByVal EndDate As String, ByVal ReportDate As String, ByVal ReportOption As Integer, ByVal objCnn As MySqlConnection)
        Dim i, j As Integer
        Dim bolDisplayExemptVAT As Boolean
        Dim PayTypeList, PayTypeData, ColumnData As DataTable
        Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
        Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel where ProductLevelID=" + ShopID, objCnn)
        Dim DisplayVATType As String = "V"
        If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
            DisplayVATType = "E"
        End If
		
        Dim ZoneText As String = ""
        If zoneID = 0 Then
            ZoneText = ": All Zones"
        Else
            Dim ZoneInfo As DataTable = getProp.TableInfo(1, ShopID, zoneID, 0, objCnn)
            If ZoneInfo.Rows.Count > 0 Then ZoneText = ": " + ZoneInfo.Rows(0)("ZoneName")
        End If
		       
        Dim CCTypeList, CCTypeData As DataTable
        Dim VoidData, IncomeType, IncomeData As DataTable
        Dim getReport2 As New ReportV6
 
        Application.Lock()
        '           Dim dtTable As DataTable = getReport.SaleReportByGroup(ColumnData, PayTypeList, PayTypeData, ViewOption, StartDate, EndDate, Request.Form("ShopID"), _
        '                                                        Request.Form("ZoneID"), 0, 0, Session("LangID"), objCnn)
        ColumnData = New DataTable
        PayTypeList = New DataTable
        PayTypeData = New DataTable
        CCTypeList = New DataTable
        CCTypeData = New DataTable
            
        VoidData = New DataTable
        IncomeType = New DataTable
        IncomeData = New DataTable
        Dim dtTable As DataTable = getReport2.SaleReportByGroupZone(ColumnData, PayTypeList, PayTypeData, CCTypeList, CCTypeData, _
                                        VoidData, IncomeType, IncomeData, ViewOption, 1, StartDate, EndDate, ShopID, _
                                        zoneID, Session("LangID"), objCnn)
		            
        ResultSearchText.InnerHtml = "summary Sale Report By Zone of " + SelShopName.Value + ZoneText + " (" + ReportDate + ")"
        Application.UnLock()

        
        'Check For whether to Display Exempt VAT Column
         If dtTable.Select("TransactionExemptVAT <> 0").Length <> 0 Then
            bolDisplayExemptVAT = True
        Else
            bolDisplayExemptVAT = False
        End If
        
        Dim SMQuery As String = ""
        Dim SMData As DataTable = objDB.List("select * from SaleMode where Deleted=0 " + SMQuery + " order by SaleModeID", objCnn)
		
        Dim ColSpan As Integer = 11
        Dim HeaderString As String = ""
        If ViewOption = 1 Then
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(5)(LangText) & "</td>"
        ElseIf ViewOption = 2 Then
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(6)(LangText) & "</td>"
        Else
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Month</td>"
        End If
        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(7)(LangText) & "</td>"
        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(8)(LangText) & "</td>"
        For i = 0 To ColumnData.Rows.Count - 1
            If (ColumnData.Rows(i)("ProductGroupCode") = "" And ColumnData.Rows(i)("ProductGroupName") = "-") Then
                ColumnData.Rows(i)("ProductGroupName") = "Other"
            End If
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + ColumnData.Rows(i)("ProductGroupName") + "</td>"
            ColSpan += 1
        Next
        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(9)(LangText) + "</td>"
        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(10)(LangText) + "</td>"
        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(11)(LangText) + "</td>"
        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(12)(LangText) + "</td>"

        If bolDisplayExemptVAT = True Then
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangData2, 35, LangText, "Exempt VAT") & "</td>"
            ColSpan += 1
        End If

        For i = 0 To IncomeType.Rows.Count - 1
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + IncomeType.Rows(i)("IncomeName") + "</td>"
        Next

        If DisplayVATType = "V" Then
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(13)(LangText) + "</td>"
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(14)(LangText) + "</td>"
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(15)(LangText) + "</td>"
        Else
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(16)(LangText) + "</td>"
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(17)(LangText) + "</td>"
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(18)(LangText) + "</td>"
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(19)(LangText) + "</td>"
        End If
            
        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(21)(LangText) + "</td>"
        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(20)(LangText) + "</td>"
        TableHeaderText.InnerHtml = HeaderString
		
        Dim HavePrepaid As Boolean = False
        Dim HavePrepaidDiscount As Boolean = False
        Dim ExtraPayText As String
        Dim AdditionalHeader As String = ""

        For i = 0 To PayTypeList.Rows.Count - 1
            ExtraPayText = ""
            If PayTypeList.Rows(i)("PrepaidDiscountPercent") > 0 Then
                HavePrepaidDiscount = True
                ExtraPayText = "<br>Total/Disc"
            End If
            AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + PayTypeList.Rows(i)("PayTypeName") + ExtraPayText + "</td>"
            If PayTypeList.Rows(i)("PayTypeID") = 2 Then
                For j = 0 To CCTypeList.Rows.Count - 1
                    AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + "#008080" + """>" + CCTypeList.Rows(j)("CreditCardType") + ExtraPayText + "</td>"
                    ColSpan += 1
                Next
            End If

            ColSpan += 1
            If PayTypeList.Rows(i)("IsSale") = 0 Then
                'HavePrepaid = True
            End If
        Next
        AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(22)(LangText) + "</td>"
        AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(23)(LangText) + "</td>"
        If HavePrepaidDiscount = True Then
            AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(24)(LangText) + "</td>"
            ColSpan += 1
        End If
        If HavePrepaid = True Then
            AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(25)(LangText) + "</td>"
            AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(26)(LangText) + "</td>"
            ColSpan += 2
        End If

        If ViewOption <> 1 Then
            AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(27)(LangText) + "</td>"
            AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(28)(LangText) + "</td>"
            ColSpan += 2
        End If

        If DisplayVATType = "E" Then
            ColSpan += 1
        End If
        ExtraHeader.InnerHtml = AdditionalHeader
		
        Dim LangPath As String = Util.GetLangPath(Request.PhysicalApplicationPath)

        '        Dim outputResult As String = getReport.GenSaleReportByGroup(ColSpan, GlobalParam.GrayBGColor, GlobalParam.AdminBGColor, Request.Form("ShopID"), ViewOption, StartDate, EndDate, ColumnData, dtTable, PayTypeList, PayTypeData, objCnn)
        Dim outputResult As String = GenSaleReportByGroupZone(ColSpan, GlobalParam.GrayBGColor, GlobalParam.AdminBGColor, ShopID, _
                                            ViewOption, StartDate, EndDate, ColumnData, dtTable, PayTypeList, PayTypeData, _
                                            CCTypeList, CCTypeData, VoidData, IncomeType, IncomeData, ReportDate, _
                                            Session("LangID"), LangPath, SMData, 1, bolDisplayExemptVAT, objCnn)
			
        ResultText.InnerHtml = outputResult
		
        Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & _
                    "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & _
                    ResultText.InnerHtml & "</td></tr></table>"
    End Sub
    
    Private Function GenSaleReportByGroupZone(ByVal ColSpan As Integer, ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal ShopID As String, _
    ByVal ViewOption As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal ColumnData As DataTable, ByVal dtTable As DataTable, ByVal PayTypeList As DataTable, _
    ByVal PayTypeData As DataTable, ByVal CCTypeList As DataTable, ByVal CCTypeData As DataTable, ByVal VoidData As DataTable, ByVal IncomeType As DataTable, _
    ByVal IncomeData As DataTable, ByVal ReportDate As String, ByVal LangID As Integer, ByVal LangPath As String, ByVal SMData As DataTable, ByVal ReportOption As Integer, _
    displayExemptVAT As Boolean, ByVal objCnn As MySqlConnection) As String
        Dim FormatData As DataTable = Fm.FormatParam(FormatObject, LangID, objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
        Dim i, j, k, m, n As Integer
        Dim outputString As StringBuilder = New StringBuilder
        Dim TotalProductDiscount As Double = 0
        Dim TotalSale, EachTotalSale As Double
        Dim grandTotalRetailPrice As Double = 0
        Dim grandTotalDiscount As Double = 0
        Dim grandTotalServiceCharge As Double = 0
        Dim grandTotalServiceChargeVAT As Double = 0
        Dim grandTotalBeforeVAT As Double = 0
        Dim grandTotalVAT As Double = 0
        Dim grandTotalAfterVAT As Double = 0
        Dim grandTotalExemptVAT As Double = 0
        Dim grandTotalBill As Integer = 0
        Dim grandTotalCustomer As Integer = 0
        Dim grandTotalVoid As Double = 0
        Dim totalEachPayment As Double = 0
        Dim totalEachPaymentPrepaid As Double = 0
        Dim totalEachPaymentDiscount As Double = 0
        Dim grandPayment As Double = 0
        Dim grandTotalPaymentDiscount As Double = 0
        Dim grandTotalVatable As Double = 0
        Dim grandTotalVoidAmount As Double = 0
        Dim grandTotal As Double = 0
        Dim HavePrepaid As Boolean = False
        Dim HavePrepaidDiscount As Boolean = False
        Dim DiscountArray(7) As Double
        Dim SumPayment(PayTypeList.Rows.Count - 1) As Double
        Dim SumCCType(CCTypeList.Rows.Count - 1) As Double
        Dim SumPaymentDiscount(PayTypeList.Rows.Count - 1) As Double
        Dim InvC As CultureInfo = CultureInfo.InvariantCulture
        For j = 0 To PayTypeList.Rows.Count - 1
            SumPayment(j) = 0
            SumPaymentDiscount(j) = 0
            If PayTypeList.Rows(j)("IsSale") = 0 Then
                'HavePrepaid = True
            End If
            If PayTypeList.Rows(j)("PrepaidDiscountPercent") > 0 Then
                HavePrepaidDiscount = True
            End If
        Next
        For j = 0 To CCTypeList.Rows.Count - 1
            SumCCType(j) = 0
        Next

        Dim SumSaleGroup(SMData.Rows.Count - 1, ColumnData.Rows.Count - 1) As Double
       
        Dim SumSubSaleGroup(SMData.Rows.Count - 1, ColumnData.Rows.Count - 1) As Double
        Dim SumSubPayment(PayTypeList.Rows.Count - 1) As Double
        Dim SumSubCCType(CCTypeList.Rows.Count - 1) As Double
        Dim SumSubPaymentDiscount(PayTypeList.Rows.Count - 1) As Double
        Dim SubTotalCustomer, SubTotalServiceCharge, SubTotalServiceChargeVAT, SubTotalAmount, SubTotalDiscount, SubTotalSale, SubTotalVatable, SubTotalVAT As Double
        Dim SubPayment, SubTotalPaymentDiscount, SubTotalBill, SubTotalExemptVAT As Double
        Dim totalVoidPrice As Double
        Dim voidBill As Integer
        Dim SumIncome(IncomeType.Rows.Count - 1) As Double
        Dim SumSubIncome(IncomeType.Rows.Count - 1) As Double
        Dim IncomeTotal As Double
        Dim lineIncome As Double

        Dim DisplayString As String
        Dim FoundPayType, FoundGroup As Boolean
        Dim TextClass As String
        Dim PaymentDiscountText As String

        Dim AdditionalHeaderText, HText, RText, VoidText As String
        Dim FullText As String = ""
        Dim getInfo As New CCategory
        Dim getProp As New CPreferences

        Dim PropertyInfo As DataTable

        Dim ReceiptHeaderData As DataTable

        Dim LangData2 As DataTable = pRoMiSeLanguage.pRoMiSeLanguage.LangInfo(7, 2, -1, LangPath)
        Dim LangText As String = "lang" + LangID.ToString

        Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel where ProductLevelID IN (" + ShopID.ToString + ")", objCnn)
        Dim DisplayVATType As String = "V"

        Dim ShopIDList As String = "," + ShopID + ","
        Dim AllShop As Boolean = False
        If ShopIDList.IndexOf(",0,") <> -1 Then
            AllShop = True
        End If
        If AllShop = True Then
            Dim GetShopVAT As DataTable = objDB.List("select count(*) As TotalRecord from ProductLevel where DisplayReceiptVATableType=2 AND Deleted=0", objCnn)
            If GetShopVAT.Rows(0)("TotalRecord") > 0 Then
                DisplayVATType = "E"
            End If
        ElseIf ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
            DisplayVATType = "E"
        End If

        PropertyInfo = getProp.PropertyInfo(1, objCnn)
        ReceiptHeaderData = getInfo.GetDocType(1, 0, 8, 1, objCnn)

        If ReceiptHeaderData.Rows.Count > 0 Then
            If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
                AdditionalHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
            End If
        End If

        Dim DigitRunning As Integer
        Dim ChkRunning As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramtypeID = 1 AND PropertyID = 29 AND KeyID = 1", objCnn)
        If ChkRunning.Rows.Count > 0 Then
            If ChkRunning.Rows(0)("PropertyValue") > 5 Then
                DigitRunning = ChkRunning.Rows(0)("PropertyValue")
            End If
        End If

        Dim StringText As String
        Dim DummyTransactionKey As String = ""
        Dim DummySessionKey As String
        Dim foundRows() As DataRow
        Dim expression As String

        Dim foundCCType() As DataRow
        Dim expCC As String

        Dim foundRows2() As DataRow

        Dim lineSale As Double = 0
        Dim CalAvgHead As Double = 0
        Dim DateFrom, DateTo As String
        Dim x, y As Integer
        Dim curZoneID As Integer
        Dim SumSaleMode As Double = 0
        Dim bolNewZone As Boolean
        
        curZoneID = -1
        DummySessionKey = ""
        For i = 0 To dtTable.Rows.Count - 1
            bolNewZone = False
            
            If ViewOption = 1 And AllShop = False Then
                If (dtTable.Rows(i)("SessionKey") <> DummySessionKey) Or (dtTable.Rows(i)("ZoneID") <> curZoneID) Then
                    bolNewZone = True
                    StringText = ""
                    If Not IsDBNull(dtTable.Rows(i)("ZoneName")) Then
                        StringText &= "Zone:" & dtTable.Rows(i)("ZoneName") & " "
                    End If
                    If Not IsDBNull(dtTable.Rows(i)("OpenStaff")) Then
                        StringText &= dtTable.Rows(i)("OpenStaff")
                    End If
                    If Not IsDBNull(dtTable.Rows(i)("CloseStaff")) Then
                        StringText += " (" + LangData2.Rows(29)(LangText) + " " + dtTable.Rows(i)("CloseStaff") + ")"
                    Else
                        StringText += " (" + LangData2.Rows(29)(LangText) + " -)"
                    End If
                    If Not IsDBNull(dtTable.Rows(i)("RegistrationNumber")) Then
                        StringText += " " + LangData2.Rows(30)(LangText) + " " + dtTable.Rows(i)("RegistrationNumber")
                    End If
                    If Not IsDBNull(dtTable.Rows(i)("CloseSessionDateTime")) Then
                        StringText += " " + LangData2.Rows(31)(LangText) + " " + CDate(dtTable.Rows(i)("OpenSessionDateTime")).ToString(FormatObject.TimeFormat, ci) + " - " + CDate(dtTable.Rows(i)("CloseSessionDateTime")).ToString(FormatObject.TimeFormat, ci)
                    Else
                        If IsDate(dtTable.Rows(i)("OpenSessionDateTime")) Then
                            StringText += " " + LangData2.Rows(30)(LangText) + " " + CDate(dtTable.Rows(i)("OpenSessionDateTime")).ToString(FormatObject.TimeFormat, ci) + " - " + " "
                        Else
                            StringText += " " + LangData2.Rows(30)(LangText) + " -"
                        End If
                    End If
                    outputString = outputString.Append("<tr bgColor=""" + "white" + """>")
                    outputString = outputString.Append("<td colspan=""" + ColSpan.ToString + """ align=""left"" class=""smallText"">" & StringText & "</td>")
                End If
            ElseIf dtTable.Rows(i)("ZoneID") <> curZoneID Then
                bolNewZone = True
                StringText = ""
                If Not IsDBNull(dtTable.Rows(i)("ZoneName")) Then
                    StringText &= "Zone:" & dtTable.Rows(i)("ZoneName") & " "
                End If
                outputString = outputString.Append("<tr bgColor=""" + "white" + """>")
                outputString = outputString.Append("<td colspan=""" + ColSpan.ToString + """ align=""left"" class=""smallText"">" & StringText & "</td>")
            End If
            
            If bolNewZone = True Then
                For x = 0 To SMData.Rows.Count - 1
                    For j = 0 To ColumnData.Rows.Count - 1
                        SumSubSaleGroup(x, j) = 0
                    Next
                Next
                For j = 0 To PayTypeList.Rows.Count - 1
                    SumSubPayment(j) = 0
                    SumSubPaymentDiscount(j) = 0
                Next
                For j = 0 To CCTypeList.Rows.Count - 1
                    SumSubCCType(j) = 0
                Next
                For j = 0 To IncomeType.Rows.Count - 1
                    SumSubIncome(j) = 0
                Next
                SubTotalPaymentDiscount = 0
                SubPayment = 0
                SubTotalServiceCharge = 0
                SubTotalServiceChargeVAT = 0
                SubTotalExemptVAT = 0
                SubTotalVAT = 0
                SubTotalVatable = 0
                SubTotalCustomer = 0
                SubTotalAmount = 0
                SubTotalDiscount = 0
                SubTotalSale = 0
                SubTotalBill = 0
                voidBill = 0
                totalVoidPrice = 0
            End If

            If dtTable.Rows(i)("TransactionKey").ToString <> DummyTransactionKey Then
                If AllShop = True Then
                    DisplayString = dtTable.Rows(i)("ShopCode")
                    DateFrom = StartDate
                    DateTo = EndDate
                Else
                    Select Case ViewOption
                        Case 1              'Daily
                            HText = ""
                            If dtTable.Rows(i)("DocType") = 37 Then
                                If Not IsDBNull(dtTable.Rows(i)("DocumentTypeHeader")) Then
                                    HText = dtTable.Rows(i)("DocumentTypeHeader")
                                End If
                            Else
                                If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
                                    If DigitRunning > 5 Then
                                        HText = "Running," + DigitRunning.ToString
                                    Else
                                        If Not IsDBNull(dtTable.Rows(i)("DocumentTypeHeader")) Then
                                            HText = dtTable.Rows(i)("DocumentTypeHeader")
                                        End If
                                    End If
                                Else
                                    HText = AdditionalHeaderText
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
                                DisplayString = "<a class=""smallText"" href=""JavaScript: newWindow = window.open( 'BillDetails.aspx?ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "&ShopID=" + dtTable.Rows(i)("ShopID").ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & RText & "</a>" & VoidText & FullText
                            Else
                                DisplayString = RText & VoidText
                            End If
                        Case 2              'By Month/ Date Range
                            DateFrom = DateTimeUtil.FormatDate(Day(dtTable.Rows(i)("SaleDate")), Month(dtTable.Rows(i)("SaleDate")), CDate(dtTable.Rows(i)("SaleDate")).ToString("yyyy", InvC))
                            Dim CheckDate As New DateTime(CDate(dtTable.Rows(i)("SaleDate")).ToString("yyyy", InvC), Month(dtTable.Rows(i)("SaleDate")), Day(dtTable.Rows(i)("SaleDate")), 0, 0, 0)
                            CheckDate = DateAdd("d", 1, CheckDate)
                            DateTo = DateTimeUtil.FormatDate(Day(CheckDate), Month(CheckDate), CheckDate.ToString("yyyy", InvC))
                            DisplayString = "<a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_sale_bygroupzone.aspx?ViewOption=1&from=drilldown&ShopID=" + ShopID.ToString + "&ReportOption=" + ReportOption.ToString + "&ReportDate=" + Replace(DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly", LangID, objCnn), "'", "\'") + "&StartDate=" + Replace(DateFrom, "'", "\'") + "&EndDate=" + Replace(DateTo, "'", "\'") + "&ZoneID=" & dtTable.Rows(i)("ZoneID") & "', '', 'width=1000,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly", LangID, objCnn) + "</a>"
                           
                        Case 3              'By Year
                            Dim showDate As Date
                            showDate = New Date(dtTable.Rows(i)("SaleYear"), dtTable.Rows(i)("SaleMonth"), 1)
                            DisplayString = DateTimeUtil.FormatDateTime(showDate, "DayYear", LangID, objCnn)
                    End Select
                   
                End If
                If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                    TextClass = "smallText"

                    grandTotalServiceChargeVAT += dtTable.Rows(i)("ServiceChargeVAT")
                    grandTotalExemptVAT += dtTable.Rows(i)("TransactionExemptVAT")
                    grandTotalBeforeVAT += TotalSale - dtTable.Rows(i)("TransactionVAT")
                    grandTotalVAT += dtTable.Rows(i)("TransactionVAT")

                    grandTotalCustomer += dtTable.Rows(i)("TotalCustomer")


                    SubTotalServiceChargeVAT += dtTable.Rows(i)("ServiceChargeVAT")
                    SubTotalExemptVAT += dtTable.Rows(i)("TransactionExemptVAT")
                    SubTotalVAT += dtTable.Rows(i)("TransactionVAT")

                    SubTotalCustomer += dtTable.Rows(i)("TotalCustomer")

                    SubTotalBill += dtTable.Rows(i)("TotalBill")
                    grandTotalBill += dtTable.Rows(i)("TotalBill")

                    If DisplayVATType = "V" Then
                        grandTotalVatable += dtTable.Rows(i)("TransactionVATable")
                        SubTotalVatable += dtTable.Rows(i)("TransactionVATable")
                        SubTotalServiceCharge += dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT")
                        grandTotalServiceCharge += dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT")
                    Else
                        grandTotalVatable += dtTable.Rows(i)("TransactionVATable") - dtTable.Rows(i)("TransactionVAT")
                        SubTotalVatable += dtTable.Rows(i)("TransactionVATable") - dtTable.Rows(i)("TransactionVAT")
                        SubTotalServiceCharge += dtTable.Rows(i)("ServiceCharge")
                        grandTotalServiceCharge += dtTable.Rows(i)("ServiceCharge")
                    End If
                Else
                    TextClass = "smallRedText"
                    DisplayString += " " + LangData2.Rows(32)(LangText)
                End If

                outputString = outputString.Append("<tr bgColor=""" + "white" + """>")
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + DisplayString + "</td>")
                If AllShop = True Then
                    outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_sale_bygroup.aspx?ViewOption=" + ViewOption.ToString + "&from=drilldown&ShopID=" + dtTable.Rows(i)("ShopID").ToString + "&ReportOption=" + ReportOption.ToString + "&ReportDate=" + Replace(ReportDate, "'", "\'") + "&StartDate=" + Replace(DateFrom, "'", "\'") + "&EndDate=" + Replace(DateTo, "'", "\'") + "', '', 'width=1000,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + dtTable.Rows(i)("ShopName") + "</a></td>")
                End If
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TotalBill")).ToString(FormatObject.QtyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TotalCustomer")).ToString(FormatObject.QtyFormat, ci) + "</td>")
                ' Loop display value in product group
                TotalSale = 0
                TotalProductDiscount = 0

                expression = "TransactionKey = '" + dtTable.Rows(i)("TransactionKey").ToString + "'"
                foundRows = dtTable.Select(expression)

                If ReportOption = 1 Then
                    x = 0
                    For j = 0 To ColumnData.Rows.Count - 1
                        FoundGroup = False
                        For k = 0 To foundRows.GetUpperBound(0)

                            If (foundRows(k)("ProductGroupCode") = "" And foundRows(k)("ProductGroupName") = "-") Then
                                foundRows(k)("ProductGroupName") = "Other"
                            End If
						
                            If ColumnData.Rows(j)("ProductGroupCode") = foundRows(k)("ProductGroupCode") And ColumnData.Rows(j)("ProductGroupName") = foundRows(k)("ProductGroupName") Then
                                If DisplayVATType = "V" Then
                                    EachTotalSale = foundRows(k)("RetailPrice") '+ foundRows(k)("VATAmount")
                                Else
                                    EachTotalSale = foundRows(k)("RetailPrice") '+ foundRows(k)("TransactionExcludeVAT")
                                End If

                                TotalSale += EachTotalSale
                                TotalProductDiscount += foundRows(k)("TotalDiscount")

                                If foundRows(k)("TransactionStatusID") = 2 Then
                                    TextClass = "smallText"
                                    SumSaleGroup(x, j) += EachTotalSale
                                    SumSubSaleGroup(x, j) += EachTotalSale
                                Else
                                    TextClass = "smallRedText"
                                End If
                                If TotalSale <> 0 Then
                                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(EachTotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                                Else
                                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>-</td>")
                                End If
                                FoundGroup = True
                            End If
                        Next
                        If FoundGroup = False Then
                            outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
                        End If
                    Next
                Else
                    For x = 0 To SMData.Rows.Count - 1
                        SumSaleMode = 0

                        For j = 0 To ColumnData.Rows.Count - 1
                            FoundGroup = False
                            For k = 0 To foundRows.GetUpperBound(0)
                                'TestString  += "<BR>" + dtTable.Rows(i)("TransactionKey").ToString + "|k=" + k.ToString + "|" + foundRows(k)("ProductGroupCode").ToString + ":" + foundRows(k)("SaleMode").ToString + "===" + ColumnData.Rows(j)("ProductGroupCode").ToString + ":" + SMData.Rows(x)("SaleModeID").ToString
                                If ColumnData.Rows(j)("ProductGroupCode") = foundRows(k)("ProductGroupCode") And ColumnData.Rows(j)("ProductGroupName") = foundRows(k)("ProductGroupName") And SMData.Rows(x)("SaleModeID") = foundRows(k)("SaleMode") Then
                                    If DisplayVATType = "V" Then
                                        EachTotalSale = foundRows(k)("RetailPrice") '+ foundRows(k)("VATAmount")
                                    Else
                                        EachTotalSale = foundRows(k)("RetailPrice") '+ foundRows(k)("TransactionExcludeVAT")
                                    End If

                                    TotalSale += EachTotalSale
                                    TotalProductDiscount += foundRows(k)("TotalDiscount")
                                    SumSaleMode += EachTotalSale

                                    If foundRows(k)("TransactionStatusID") = 2 Then
                                        TextClass = "smallText"
                                        SumSaleGroup(x, j) += EachTotalSale
                                        SumSubSaleGroup(x, j) += EachTotalSale
                                    Else
                                        TextClass = "smallRedText"
                                    End If
                                    If ReportOption = 2 Or (ReportOption = 3 And SMData.Rows(x)("SaleModeID") = 1) Then
                                        If TotalSale <> 0 Then
                                            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(EachTotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                                        Else
                                            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>-</td>")
                                        End If
                                    End If
                                    FoundGroup = True
                                End If

                            Next
                            If FoundGroup = False And (ReportOption = 2 Or (ReportOption = 3 And SMData.Rows(x)("SaleModeID") = 1)) Then
                                outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
                            End If
                        Next
                        If SMData.Rows.Count > 1 Then
                            outputString = outputString.Append("<td bgColor=""#ffe4b5"" align=""right"" class=""" + TextClass + """>" + CDbl(SumSaleMode).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                        End If
                    Next
                End If
                ' End Loop product group
                'outMsg.InnerHtml = TestString
                If DisplayVATType = "V" Then
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalProductDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalSale - TotalProductDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    If displayExemptVAT = True Then
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(dtTable.Rows(i)("TransactionExemptVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    End If
                    
                    IncomeTotal = 0
                    For j = 0 To IncomeType.Rows.Count - 1
                        lineIncome = 0
                        expression = "TransactionKey = '" + dtTable.Rows(i)("TransactionKey").ToString + "'" + " AND IncomeTypeID=" + IncomeType.Rows(j)("IncomeTypeID").ToString
                        foundRows = IncomeData.Select(expression)
                        If foundRows.GetUpperBound(0) >= 0 Then
                            IncomeTotal += foundRows(0)("Income") + foundRows(0)("IncomeVAT")
                            lineIncome = foundRows(0)("Income") + foundRows(0)("IncomeVAT")
                        End If
                        outputString = outputString.Append("<td bgColor=""#ffe4b5"" align=""right"" class=""" + TextClass + """>" + CDbl(lineIncome).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                        SumIncome(j) += lineIncome
                        SumSubIncome(j) += lineIncome
                    Next

                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalSale + dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT") _
                                                      - TotalProductDiscount + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TransactionVATable") - dtTable.Rows(i)("TransactionVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TransactionVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((TotalSale + dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT") - TotalProductDiscount + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")) / dtTable.Rows(i)("TotalCustomer")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((TotalSale + dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT") - TotalProductDiscount + IncomeTotal- dtTable.Rows(i)("TransactionExemptVAT")) / dtTable.Rows(i)("TotalBill")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")

                    If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                        grandTotalRetailPrice += TotalSale - TotalProductDiscount
                        grandTotalDiscount += TotalProductDiscount
                        grandTotalAfterVAT += TotalSale + dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT") - TotalProductDiscount + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")
                        SubTotalAmount += TotalSale - TotalProductDiscount
                        SubTotalDiscount += TotalProductDiscount
                        SubTotalSale += TotalSale + dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT") - TotalProductDiscount + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")
                        grandTotal += TotalSale + dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT") - TotalProductDiscount + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")
                    End If

                    lineSale = TotalSale + dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT") - TotalProductDiscount + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalProductDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalSale - TotalProductDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")

                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("ServiceCharge")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")

                    If displayExemptVAT = True Then
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(dtTable.Rows(i)("TransactionExemptVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    End If
                                        
                    IncomeTotal = 0
                    For j = 0 To IncomeType.Rows.Count - 1
                        lineIncome = 0
                        expression = "TransactionKey = '" + dtTable.Rows(i)("TransactionKey").ToString + "'" + " AND IncomeTypeID=" + IncomeType.Rows(j)("IncomeTypeID").ToString
                        foundRows = IncomeData.Select(expression)
                        If foundRows.GetUpperBound(0) >= 0 Then
                            IncomeTotal += foundRows(0)("Income")
                            lineIncome = foundRows(0)("Income")
                        End If
                        outputString = outputString.Append("<td bgColor=""#ffe4b5"" align=""right"" class=""" + TextClass + """>" + CDbl(lineIncome).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                        SumIncome(j) += lineIncome
                        SumSubIncome(j) += lineIncome
                    Next

                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalSale + dtTable.Rows(i)("ServiceCharge") - TotalProductDiscount + _
                                                       IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TransactionVATable") - dtTable.Rows(i)("TransactionVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(dtTable.Rows(i)("TransactionVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(TotalSale + dtTable.Rows(i)("ServiceCharge") - TotalProductDiscount + dtTable.Rows(i)("TransactionVAT") + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((TotalSale + dtTable.Rows(i)("ServiceCharge") - TotalProductDiscount + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")) / dtTable.Rows(i)("TotalCustomer")).ToString(FormatObject.NumericFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((TotalSale + dtTable.Rows(i)("ServiceCharge") - TotalProductDiscount + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")) / dtTable.Rows(i)("TotalBill")).ToString(FormatObject.NumericFormat, ci) + "</td>")
                    lineSale = TotalSale + dtTable.Rows(i)("ServiceCharge") - TotalProductDiscount + dtTable.Rows(i)("TransactionVAT") + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")

                    If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                        grandTotalRetailPrice += TotalSale - TotalProductDiscount
                        grandTotalDiscount += TotalProductDiscount

                        SubTotalAmount += TotalSale - TotalProductDiscount
                        SubTotalDiscount += TotalProductDiscount

                        If AllShop = True Then
                            If dtTable.Rows(i)("ShopVATType") = 2 Then
                                grandTotalAfterVAT += TotalSale + dtTable.Rows(i)("ServiceCharge") - TotalProductDiscount + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")
                                SubTotalSale += TotalSale + dtTable.Rows(i)("ServiceCharge") - TotalProductDiscount + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")
                                grandTotal += TotalSale + dtTable.Rows(i)("ServiceCharge") - TotalProductDiscount + dtTable.Rows(i)("TransactionVAT") + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")
                            Else
                                grandTotalAfterVAT += TotalSale + dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT") - TotalProductDiscount + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")
                                SubTotalSale += TotalSale + dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT") - TotalProductDiscount + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")
                                grandTotal += TotalSale + dtTable.Rows(i)("ServiceCharge") + dtTable.Rows(i)("ServiceChargeVAT") - TotalProductDiscount + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")
                            End If
                        Else
                            grandTotalAfterVAT += TotalSale + dtTable.Rows(i)("ServiceCharge") - TotalProductDiscount + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")
                            SubTotalSale += TotalSale + dtTable.Rows(i)("ServiceCharge") - TotalProductDiscount + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")
                            grandTotal += TotalSale + dtTable.Rows(i)("ServiceCharge") - TotalProductDiscount + dtTable.Rows(i)("TransactionVAT") + IncomeTotal - dtTable.Rows(i)("TransactionExemptVAT")
                        End If
                    End If
                End If

                totalEachPayment = 0
                totalEachPaymentPrepaid = 0
                totalEachPaymentDiscount = 0
                For j = 0 To PayTypeList.Rows.Count - 1
                    FoundPayType = False
                    For k = 0 To PayTypeData.Rows.Count - 1
                        If PayTypeData.Rows(k)("PayTypeID") = PayTypeList.Rows(j)("PayTypeID") And dtTable.Rows(i)("TransactionKey").ToString = PayTypeData.Rows(k)("TransactionKey").ToString Then

                            If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                                TextClass = "smallText"
                                SumPayment(j) += PayTypeData.Rows(k)("TotalPay")
                                SumPaymentDiscount(j) += PayTypeData.Rows(k)("TotalPayDiscount")
                                grandPayment += PayTypeData.Rows(k)("TotalPay")

                                SumSubPayment(j) += PayTypeData.Rows(k)("TotalPay")
                                SumSubPaymentDiscount(j) += PayTypeData.Rows(k)("TotalPayDiscount")
                                SubPayment += PayTypeData.Rows(k)("TotalPay")
                            Else
                                TextClass = "smallRedText"
                            End If

                            If PayTypeData.Rows(k)("IsSale") = 1 Then
                                'TextClass = "smallText"
                            Else
                                'TextClass = "smallText"
                                totalEachPaymentPrepaid += PayTypeData.Rows(k)("TotalPay")
                            End If
                            If PayTypeData.Rows(k)("TotalPayDiscount") > 0 Then
                                outputString = outputString.Append("<td bgColor=""#ccffff"" align=""right"" class=""" + TextClass + """>" + CDbl(PayTypeData.Rows(k)("TotalPay")).ToString(FormatObject.CurrencyFormat, ci) + "/" + CDbl(PayTypeData.Rows(k)("TotalPayDiscount")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                            Else
                                If PayTypeList.Rows(j)("PayTypeID") = 2 And ViewOption <> 1 Then
                                    outputString = outputString.Append("<td bgColor=""#ccffff"" align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'CreditCard/CreditCard_SaleReport.aspx?ViewOption=0&CCTypeID=-1&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(DateFrom, "'", "\'") + "&EndDate=" + Replace(DateTo, "'", "\'") + "', '', 'width=700,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + CDbl(PayTypeData.Rows(k)("TotalPay")).ToString(FormatObject.CurrencyFormat, ci) + "</a></td>")
                                Else
                                    outputString = outputString.Append("<td bgColor=""#ccffff"" align=""right"" class=""" + TextClass + """>" + CDbl(PayTypeData.Rows(k)("TotalPay")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                                End If
                            End If
                            totalEachPaymentDiscount += PayTypeData.Rows(k)("TotalPayDiscount")
                            totalEachPayment += PayTypeData.Rows(k)("TotalPay")
                            FoundPayType = True
                        End If
                    Next
                    If FoundPayType = False Then
                        outputString = outputString.Append("<td bgColor=""#ccffff"" align=""right"" class=""smallText"">-</td>")
                    End If
                    If PayTypeList.Rows(j)("PayTypeID") = 2 Then
                        For m = 0 To CCTypeList.Rows.Count - 1
                            expCC = "TransactionKey = '" + dtTable.Rows(i)("TransactionKey").ToString + "' AND CCTypeID=" + CCTypeList.Rows(m)("CCTypeID").ToString
                            foundCCType = CCTypeData.Select(expCC)
                            If foundCCType.GetUpperBound(0) >= 0 Then
                                If ViewOption <> 1 Then
                                    outputString = outputString.Append("<td bgColor=""#ffff99"" align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'CreditCard/CreditCard_SaleReport.aspx?ViewOption=0&CCTypeID=" + CCTypeList.Rows(m)("CCTypeID").ToString + "&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(DateFrom, "'", "\'") + "&EndDate=" + Replace(DateTo, "'", "\'") + "', '', 'width=700,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + CDbl(foundCCType(0)("TotalPay")).ToString(FormatObject.CurrencyFormat, ci) + "</a></td>")
                                Else
                                    outputString = outputString.Append("<td bgColor=""#ffff99"" align=""right"" class=""" + TextClass + """>" + CDbl(foundCCType(0)("TotalPay")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                                End If
                                If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                                    SumCCType(m) += foundCCType(0)("TotalPay")
                                    SumSubCCType(m) += foundCCType(0)("TotalPay")
                                End If

                            Else
                                outputString = outputString.Append("<td bgColor=""#ffff99"" align=""right"" class=""" + TextClass + """>" + "" + "</td>")
                            End If
                        Next
                    End If
                Next
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(totalEachPayment).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                If Math.Round(lineSale, 2) - Math.Round(totalEachPayment, 2) <> 0 Then
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(totalEachPayment - lineSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>-</td>")
                End If
                If HavePrepaidDiscount = True Then
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(totalEachPayment - totalEachPaymentDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                End If
                If HavePrepaid = True Then
                    If totalEachPaymentPrepaid > 0 Then
                        outputString = outputString.Append("<td bgColor=""#ffffcc"" align=""right"" class=""" + TextClass + """>" + CDbl(totalEachPaymentPrepaid).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    Else
                        outputString = outputString.Append("<td bgColor=""#ffffcc"" align=""right"" class=""" + TextClass + """>-</td>")
                    End If
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(totalEachPayment - totalEachPaymentPrepaid).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                End If

                If ViewOption <> 1 Then
                    expression = "TransactionKey = '" + dtTable.Rows(i)("TransactionKey").ToString + "'"
                    foundRows2 = VoidData.Select(expression)
                    If foundRows2.GetUpperBound(0) >= 0 Then
                        outputString = outputString.Append("<td bgColor=""#ffdab9"" align=""right"" class=""" + TextClass + """>" + CDbl(foundRows2(0)("NoVoid")).ToString(FormatObject.QtyFormat, ci) + "</td>")
                        outputString = outputString.Append("<td bgColor=""#ffdab9"" align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_void.aspx?ShopID=" + ShopID.ToString + "&StartDate=" + Replace(DateFrom, "'", "\'") + "&EndDate=" + Replace(DateTo, "'", "\'") + "', '', 'width=900,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + CDbl(foundRows2(0)("VoidAmount")).ToString(FormatObject.CurrencyFormat, ci) + "</a></td>")
                        grandTotalVoid += foundRows2(0)("NoVoid")
                        grandTotalVoidAmount += foundRows2(0)("VoidAmount")
                        
                        voidBill += foundRows2(0)("NoVoid")
                        totalVoidPrice += foundRows2(0)("VoidAmount")
                    Else
                        outputString = outputString.Append("<td bgColor=""#ffdab9"" align=""center"" class=""" + TextClass + """>" + "&nbsp;" + "</td>")
                        outputString = outputString.Append("<td bgColor=""#ffdab9"" align=""center"" class=""" + TextClass + """>" + "&nbsp;" + "</td>")
                    End If
                End If
                outputString = outputString.Append("</tr>")
            End If
            curZoneID = dtTable.Rows(i)("ZoneID")
            DummyTransactionKey = dtTable.Rows(i)("TransactionKey").ToString
            If ViewOption = 1 And AllShop = False Then
                DummySessionKey = dtTable.Rows(i)("SessionKey")
                If i < dtTable.Rows.Count - 1 Then
                    If (dtTable.Rows(i + 1)("SessionKey") <> DummySessionKey) Or (dtTable.Rows(i + 1)("ZoneID") <> dtTable.Rows(i)("ZoneID")) Then
                        outputString = outputString.Append(GenSubSaleReportByGroupZone(HavePrepaidDiscount, DisplayVATType, ColumnData, PayTypeList, SumSubSaleGroup, _
                                                      SumSubPayment, SumSubPaymentDiscount, CCTypeList, SumSubCCType, SumSubIncome, SubTotalBill, SubTotalCustomer, _
                                                      SubTotalServiceCharge, SubTotalServiceChargeVAT, SubTotalExemptVAT, SubTotalAmount, SubTotalDiscount, SubTotalSale, _
                                                      SubTotalVatable, SubTotalVAT, SubPayment, voidBill, totalVoidPrice, FormatData, LangData2, LangText, SMData, IncomeType, _
                                                      ViewOption, ReportOption, displayExemptVAT, objCnn))
                    End If
                End If
            Else
                'Difference Zone
                If i < dtTable.Rows.Count - 1 Then
                    If (dtTable.Rows(i + 1)("ZoneID") <> dtTable.Rows(i)("ZoneID")) Then
                        outputString = outputString.Append(GenSubSaleReportByGroupZone(HavePrepaidDiscount, DisplayVATType, ColumnData, PayTypeList, SumSubSaleGroup, _
                                                        SumSubPayment, SumSubPaymentDiscount, CCTypeList, SumSubCCType, SumSubIncome, SubTotalBill, SubTotalCustomer, _
                                                        SubTotalServiceCharge, SubTotalServiceChargeVAT, SubTotalExemptVAT, SubTotalAmount, SubTotalDiscount, SubTotalSale, _
                                                        SubTotalVatable, SubTotalVAT, SubPayment, voidBill, totalVoidPrice, FormatData, LangData2, LangText, SMData, IncomeType, _
                                                        ViewOption, ReportOption, displayExemptVAT, objCnn))
                    End If
                End If
            End If
        Next
        'If ViewOption = 1 And AllShop = False Then
        outputString = outputString.Append(GenSubSaleReportByGroupZone(HavePrepaidDiscount, DisplayVATType, ColumnData, PayTypeList, SumSubSaleGroup, SumSubPayment, _
                                             SumSubPaymentDiscount, CCTypeList, SumSubCCType, SumSubIncome, SubTotalBill, SubTotalCustomer, _
                                             SubTotalServiceCharge, SubTotalServiceChargeVAT, SubTotalExemptVAT, SubTotalAmount, SubTotalDiscount, SubTotalSale, _
                                             SubTotalVatable, SubTotalVAT, SubPayment, voidBill, totalVoidPrice, FormatData, LangData2, LangText, SMData, IncomeType, _
                                             ViewOption, ReportOption, displayExemptVAT, objCnn))
        '        End If
        Dim grandTotalPrepaid As Double = 0

        outputString = outputString.Append("<tr><td height=""10px"" colspan=""" + ColSpan.ToString + """></td></tr>")
        outputString = outputString.Append("<tr bgColor=""" + "#ebebeb" + """>")

        If AllShop = True Then
            outputString = outputString.Append("<td colspan=""2"" align=""right"" class=""smallText"">" + LangData2.Rows(33)(LangText) + "</td>")
        Else
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + LangData2.Rows(33)(LangText) + "</td>")
        End If

        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalBill).ToString(FormatObject.QtyFormat, ci) + "</td>")

        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalCustomer).ToString(FormatObject.QtyFormat, ci) + "</td>")
        If ReportOption = 1 Then
            For j = 0 To ColumnData.Rows.Count - 1
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SumSaleGroup(0, j)).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            Next
        Else
            For i = 0 To SMData.Rows.Count - 1
                SumSaleMode = 0
                For j = 0 To ColumnData.Rows.Count - 1
                    If ReportOption = 2 Or (ReportOption = 3 And SMData.Rows(i)("SaleModeID") = 1) Then
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SumSaleGroup(i, j)).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    End If
                    SumSaleMode += SumSaleGroup(i, j)
                Next
                If SMData.Rows.Count > 1 Then
                    outputString = outputString.Append("<td bgColor=""#ffe4b5"" align=""right"" class=""" + TextClass + """>" + CDbl(SumSaleMode).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                End If
            Next
        End If
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalRetailPrice + grandTotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalServiceCharge).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        If displayExemptVAT = True Then
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalExemptVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        End If
        For j = 0 To IncomeType.Rows.Count - 1
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SumIncome(j)).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        Next
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        If DisplayVATType = "E" Then
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalVatable).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        Else
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalVatable - grandTotalVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        End If

        Dim grandTotalDiff As Double = grandTotal 'grandTotalAfterVAT
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")


        If DisplayVATType = "E" Then
            'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalAfterVAT + grandTotalVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            'grandTotalDiff = grandTotalAfterVAT + grandTotalVAT
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotal).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        End If
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalAfterVAT / grandTotalCustomer).ToString(FormatObject.NumericFormat, ci) + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalAfterVAT / grandTotalBill).ToString(FormatObject.NumericFormat, ci) + "</td>")
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
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'coupon_voucher.aspx?ViewOption=0&PayTypeID=" + PayTypeList.Rows(i)("PayTypeID").ToString + "&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=600,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + CDbl(SumPayment(i)).ToString(FormatObject.CurrencyFormat, ci) + PaymentDiscountText + "</a></td>")
            ElseIf PayTypeList.Rows(i)("PayTypeID") = 2 Then
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'CreditCard/CreditCard_SaleReport.aspx?ViewOption=0&CCTypeID=-1&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=700,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + CDbl(SumPayment(i)).ToString(FormatObject.CurrencyFormat, ci) + PaymentDiscountText + "</a></td>")
            ElseIf PayTypeList.Rows(i)("PayTypeID") = 5 Then
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_creditmoney.aspx?ViewOption=1&PayTypeID=5&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=700,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + CDbl(SumPayment(i)).ToString(FormatObject.CurrencyFormat, ci) + PaymentDiscountText + "</a></td>")
            ElseIf PayTypeList.Rows(i)("PayTypeID") = 3 Then
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_creditmoney.aspx?ViewOption=1&PayTypeID=3&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=700,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + CDbl(SumPayment(i)).ToString(FormatObject.CurrencyFormat, ci) + PaymentDiscountText + "</a></td>")
            ElseIf PayTypeList.Rows(i)("PayTypeID") = 9 Then
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_creditmoney.aspx?ViewOption=1&PayTypeID=9&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=700,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + CDbl(SumPayment(i)).ToString(FormatObject.CurrencyFormat, ci) + PaymentDiscountText + "</a></td>")
            Else
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SumPayment(i)).ToString(FormatObject.CurrencyFormat, ci) + PaymentDiscountText + "</td>")
            End If
            If PayTypeList.Rows(i)("PayTypeID") = 2 Then
                For m = 0 To CCTypeList.Rows.Count - 1
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'CreditCard/CreditCard_SaleReport.aspx?ViewOption=0&CCTypeID=" + CCTypeList.Rows(m)("CCTypeID").ToString + "&ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=700,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + CDbl(SumCCType(m)).ToString(FormatObject.CurrencyFormat, ci) + "</a></td>")
                Next
            End If
        Next
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandPayment).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        If Math.Round(grandTotalDiff, 2) - Math.Round(grandPayment, 2) <> 0 Then
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandPayment - grandTotalDiff).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        Else
            outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
        End If
        If HavePrepaidDiscount = True Then
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandPayment - grandTotalPaymentDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        End If
        If HavePrepaid = True Then
            If grandTotalPrepaid > 0 Then
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalPrepaid).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            Else
                outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
            End If
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandPayment - grandTotalPrepaid).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        End If
        If ViewOption <> 1 Then
            outputString = outputString.Append("<td bgColor=""#ffdab9"" align=""right"" class=""smallText"">" + CDbl(grandTotalVoid).ToString(FormatObject.QtyFormat, ci) + "</td>")
            outputString = outputString.Append("<td bgColor=""#ffdab9"" align=""right"" class=""" + TextClass + """><a class=""" + TextClass + """ href=""JavaScript: newWindow = window.open( 'report_void.aspx?ShopID=" + ShopID.ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=900,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + CDbl(grandTotalVoidAmount).ToString(FormatObject.CurrencyFormat, ci) + "</a></td>")
        End If

        outputString = outputString.Append("</tr>")
        'outputString = outputString.Append("</table>")

        Return outputString.ToString()
    End Function

    Public Function GenSubSaleReportByGroupZone(ByVal HavePrepaidDiscount As Boolean, ByVal DisplayVATType As String, ByVal ColumnData As DataTable, ByVal PayTypeList As DataTable, _
    ByVal SumSubSaleGroup(,) As Double, ByVal SumSubPayment() As Double, ByVal SumSubPaymentDiscount() As Double, ByVal CCTypeList As DataTable, ByVal SumSubCCType() As Double, _
    ByVal SumSubIncome() As Double, ByVal SubTotalBill As Double, ByVal SubTotalCustomer As Double, ByVal SubTotalServiceCharge As Double, ByVal SubTotalServiceChargeVAT As Double, _
    subTotalExemptVAT As Double, ByVal SubTotalAmount As Double, ByVal SubTotalDiscount As Double, ByVal SubTotalSale As Double, ByVal SubTotalVatable As Double, _
    ByVal SubTotalVAT As Double, ByVal SubPayment As Double, voidBill As Integer, totalVoidPrice As Double, _
    ByVal FormatData As DataTable, ByVal LangData2 As DataTable, ByVal LangText As String, ByVal SMData As DataTable, ByVal IncomeType As DataTable, _
    viewOption As Integer, ByVal ReportOption As Integer, displayExemptVAT As Boolean, ByVal objCnn As MySqlConnection) As String

        Dim ci As New CultureInfo(FormatObject.CultureString)
        Dim PaymentDiscountText As String
        Dim outputString As StringBuilder = New StringBuilder
        Dim SubTotalPaymentDiscount As Double
        Dim SubTotalDiff As Double
        Dim i, j As Integer
        Dim m As Integer
        Dim SumSaleMode As Double = 0
        SubTotalPaymentDiscount = 0
        outputString = outputString.Append("<tr bgColor=""" + "#ebebeb" + """>")
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + LangData2.Rows(34)(LangText) + "</td>")
        If SubTotalBill > 0 Then
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SubTotalBill).ToString(FormatObject.QtyFormat, ci) + "</td>")
        End If
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SubTotalCustomer).ToString(FormatObject.QtyFormat, ci) + "</td>")

        If ReportOption = 1 Then
            For j = 0 To ColumnData.Rows.Count - 1
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SumSubSaleGroup(0, j)).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            Next
        Else
            For i = 0 To SMData.Rows.Count - 1
                SumSaleMode = 0
                For j = 0 To ColumnData.Rows.Count - 1
                    If ReportOption = 2 Or (ReportOption = 3 And SMData.Rows(i)("SaleModeID") = 1) Then
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SumSubSaleGroup(i, j)).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    End If
                    SumSaleMode += SumSubSaleGroup(i, j)
                Next
                If SMData.Rows.Count > 1 Then
                    outputString = outputString.Append("<td bgColor=""#ffe4b5"" align=""right"" class=""smallText"">" + CDbl(SumSaleMode).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                End If
            Next
        End If
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SubTotalAmount + SubTotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SubTotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SubTotalAmount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SubTotalServiceCharge).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        If displayExemptVAT = True Then
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(subTotalExemptVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        End If
        For j = 0 To IncomeType.Rows.Count - 1
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SumSubIncome(j)).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        Next
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SubTotalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        If DisplayVATType = "E" Then
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SubTotalVatable).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        Else
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SubTotalVatable - SubTotalVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        End If

        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SubTotalVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")

        If DisplayVATType = "E" Then
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SubTotalSale + SubTotalVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            SubTotalDiff = SubTotalSale + SubTotalVAT
        Else
            SubTotalDiff = SubTotalSale
        End If
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SubTotalSale / SubTotalCustomer).ToString(FormatObject.NumericFormat, ci) + "</td>")
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SubTotalSale / SubTotalBill).ToString(FormatObject.NumericFormat, ci) + "</td>")
        For j = 0 To PayTypeList.Rows.Count - 1
            If SumSubPaymentDiscount(j) > 0 Then
                PaymentDiscountText = "/" + CDbl(SumSubPaymentDiscount(j)).ToString(FormatObject.CurrencyFormat, ci)
            Else
                PaymentDiscountText = ""
            End If
            SubTotalPaymentDiscount += SumSubPaymentDiscount(j)
            If SumSubPayment(j) = 0 Then
                outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
            Else
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SumSubPayment(j)).ToString(FormatObject.CurrencyFormat, ci) + PaymentDiscountText + "</td>")
            End If
            If PayTypeList.Rows(j)("PayTypeID") = 2 Then
                For m = 0 To CCTypeList.Rows.Count - 1
                    If SumSubCCType(m) = 0 Then
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
                    Else
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SumSubCCType(m)).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    End If
                Next
            End If
        Next
        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SubPayment).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        If Math.Round(SubTotalDiff, 2) - Math.Round(SubPayment, 2) <> 0 Then
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SubPayment - SubTotalDiff).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        Else
            outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
        End If

        If HavePrepaidDiscount = True Then
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(SubPayment - SubTotalPaymentDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
        End If

        'For Void Data
        If viewOption <> 1 Then
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" & voidBill.ToString(FormatObject.QtyFormat, ci) & "</td>")
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" & totalVoidPrice.ToString(FormatObject.CurrencyFormat, ci) & "</td>")
        End If
        
        outputString = outputString.Append("</tr>")
        Return outputString.ToString()
    End Function


    Sub ExportData(Source As Object, E As EventArgs)
	
        Dim FileName As String = "SummaryByZone_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
        Dim OutputText As String = ""
        Dim CSSFile As String = Replace(UCase(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))), "REPORTS", "") & "StyleSheet\admin.css"
	
        Util.ExportData(Session("ReportResult"), FileName, CSSFile, GlobalParam.ExportCharSet, -1)
    End Sub

    Sub Page_UnLoad()
        objCnn.Close()
    End Sub

</script>
</body>
</html>
