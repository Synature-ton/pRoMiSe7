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
<%@Import Namespace="PromotionReport" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Promotion Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    
    <script src="../Scripts/jquery.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

    <script type="text/javascript">

        jQuery(document).ready(function ($) {

            $('#chkSelectAllShop').live('click', function () {
                $("#chklShopInfo INPUT[type='checkbox']").attr('checked', $(this).is(':checked') ? 'checked' : '');
            });

            $("#chklShopInfo input").live("click", function () {
                if ($("#chklShopInfo input[type='checkbox']:checked").length == $("#chklShopInfo input").length) {
                    $('#chkSelectAllShop').attr('checked', 'checked').next();
                }
                else {
                    $('#chkSelectAllShop').removeAttr('checked');
                }

            });
        });
    </script>

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
<tr><td colspan="3" class="smalltext" align="right"><span id="DBText" class="smalltext" runat="server" /></td></tr>

<tr>
<td>&nbsp;</td>
<td>
<div id="ShowSearch" runat="server">
<div class="noprint">
<table>
<tr id="ShowShop" runat="server">
 	<td valign="top">
        <div id="ShowMasterShop" runat="server" >
		<table>
 			<tr>
                <td width="170px">
                    <asp:Panel ID="pnlMasterShop" runat="server" Height="180px" ScrollBars="Auto" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px">
                    <asp:CheckBoxList ID="chklMasterShop" runat="server" AutoPostBack="true" OnSelectedIndexChanged="SelShop" Height="16px" Width="145px"></asp:CheckBoxList>       
                     </asp:Panel>
                </td> 
		    </tr>
		</table>
	    </div>
    </td>
 	<td valign="top"> 
     	<table>
            <tr>
	            <td width="225px" id="ShowShopInfoList" runat="server">
                    <asp:Panel ID="pnlShop" runat="server" Height="180px" ScrollBars="Auto" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px">
                    &nbsp;<asp:CheckBox ID="chkSelectAllShop" runat="server" Text="Select All" />
                    <asp:CheckBoxList ID="chklShopInfo" runat="server" Height="16px" Width="200px"></asp:CheckBoxList>       
                    </asp:Panel>
                </td>                   
	            <td id="ShowShopInfoCombo" runat="server">                    
                    <asp:DropDownList ID="cboShopInfo" runat="server"></asp:DropDownList>                    
                </td>    
			</tr>
		</table>
	</td>
    <td valign="top">	
	<table>
		<tr>
			<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
			<td colspan="4"><table cellpadding="0" cellspacing="0"><tr><td><synature:date id="DailyDate" runat="server" /></td></tr></table></td>
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
            <tr id="showSumShop" visible="true" runat="server">
				<td colspan="3"><asp:CheckBox ID="AllShopSum" CssClass="text" runat="server"></asp:CheckBox></td>
			</tr>
			<tr>
				<td colspan="3"><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
			</tr>
	
	</table>
	</td>
</tr>


</table>
</div>
</div>
<span id="showResults" runat="server">
<table width="100%">
<div class="noprint">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr>
</div>
<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>
<span id="startTable" runat="server"></span>
	<span id="TableHeaderText" runat="server"></span>
	<span id="ExtraHeader" runat="server"></span>
	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>
</table></td></tr>
</table>
</span>
</form>
</div>
<div id="WarningMsg" runat="server"></div>
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
    Dim Reports As New ReportV6()
    Dim DateTimeUtil As New MyDateTime()
    Dim getProp As New CPreferences()
    Dim objDB As New CDBUtil()
    Dim FormatDocNumber As New FormatText()
    Dim InvC As CultureInfo = CultureInfo.InvariantCulture
    Dim forCompanyType As Integer
    Dim PageID As Integer = 18

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Report_Promotion") Then
		
            Try
                objCnn = getCnn.EstablishConnection()
                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
                ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
                showResults.Visible = False
		
                forCompanyType = ReportModule.ReportMySQL.ReportTypeForCompany(objDB, objCnn)
                
                startTable.InnerHtml = "<table border=""1"" cellpadding=""2"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		
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
                Dim LangData3 As DataTable = getProp.GetLangData(19, 2, -1, Request)
		
                Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
                If LangDefault.Rows.Count >= 2 Then
                    PrintText.Text = LangDefault.Rows(0)(LangText)
                    Export.Text = LangDefault.Rows(1)(LangText)
                End If
               
                SubmitForm.Text = LangDefault.Rows(3)(LangText)
		
                DocumentToDateParam.InnerHtml = LangDefault.Rows(22)(LangText)
                AllShopSum.Text = LangData2.Rows(1)(LangText)
		
                'LangText0.Text = "Promotion Report"
			
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
                ShowSearch.Visible = True
		
                Dim HeaderString As String
                HeaderString = ""
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData3.Rows(0)(LangText) + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(5)(LangText) + "</td>"
                If forCompanyType = ReportModule.ReportV6.FORCOMPANY_GREYHOUND Then
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(6)(LangText) + "</td>"
                End If
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(7)(LangText) + "</td>"
                If forCompanyType = ReportModule.ReportV6.FORCOMPANY_GREYHOUND Then
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(8)(LangText) + "</td>"
                End If
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(9)(LangText) + "</td>"
		
                TableHeaderText.InnerHtml = HeaderString
		               
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
		
                Dim TestDate As DateTime = Convert.ToDateTime("2006-04-02")
                If Not Page.IsPostBack Then
                    Radio_3.Checked = True
                    If IsNumeric(Request.QueryString("ShopID")) Then
                        ShowSearch.Visible = False
                        Dim ReportDate As String
                        Dim StartDate As String = Replace(Request.QueryString("StartDate"), "{", "")
                        StartDate = Replace(StartDate, "}", "")
                        StartDate = Replace(StartDate, "'", "")
                        StartDate = Replace(StartDate, "d", "")
                        Dim StartDateValCheck As DateTime = Convert.ToDateTime(StartDate)
                        Dim StartDateVal As New DateTime(Year(StartDateValCheck), Month(StartDateValCheck), Day(StartDateValCheck))
                        Dim EndDate As String = Replace(Request.QueryString("EndDate"), "{", "")
                        EndDate = Replace(EndDate, "}", "")
                        EndDate = Replace(EndDate, "'", "")
                        EndDate = Replace(EndDate, "d", "")
                        Dim EndDateValCheck As DateTime = Convert.ToDateTime(EndDate)
                        Dim EndDateVal As New DateTime(Year(EndDateValCheck), Month(EndDateValCheck), Day(EndDateValCheck))
                        If Request.QueryString("ViewOption") = 1 Then
                            ReportDate = DateTimeUtil.FormatDateTime(StartDateVal, "MMMM yyyy", Session("LangID"), objCnn)
                        ElseIf Request.QueryString("ViewOption") = 2 Then
                            ReportDate = DateTimeUtil.FormatDateTime(StartDateVal, "dd MMMM yyyy", Session("LangID"), objCnn) + " - " + DateTimeUtil.FormatDateTime(EndDateVal, "dd MMMM yyyy", Session("LangID"), objCnn)
                        ElseIf Request.QueryString("ViewOption") = 0 Then
                            ReportDate = DateTimeUtil.FormatDateTime(StartDateVal, "dd MMMM yyyy", Session("LangID"), objCnn)
                        ElseIf Request.QueryString("ViewOption") = 4 Then
                            ReportDate = "Year " + DateTimeUtil.FormatDateTime(StartDateVal, "yyyy", Session("LangID"), objCnn)
                        Else
                            ReportDate = ""
                        End If
                        Dim PromotionData As New DataTable()
                        Dim dtTable As DataTable
                        showResults.Visible = True
                        ShowPrint.Visible = True
                        Dim SummaryPromotion As New DataTable()
                        Dim selPromoID, selShopID, selLangID As Integer
                        
                        dtTable = New DataTable
                        selShopID = Request.QueryString("ShopID")
                        selLangID = Session("LangID")
                        selPromoID = 0
                        'Application.Lock()
                        Dim Result As String
                        Result = Reports.PromotionDiscountReport(SummaryPromotion, 90, dtTable, PromotionData, _
                                           Request.QueryString("StartDate"), Request.QueryString("EndDate"), Request.QueryString("SaleModeID"), _
                                           selShopID, selPromoID, selPromoID, objCnn)
                        'Application.UnLock()
                        GenResults(PromotionData, Request.QueryString("ShopID"), ReportDate, LangDefault, LangData2)
                         
                        errorMsg.InnerHtml = "SaleModeID = " & Request.QueryString("SaleModeID")
                    End If
                End If
                
                If Not IsPostBack Then
                    InitialLoadMasterShopIntoCombo()
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
        Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
	
        Dim ViewOption As Integer
        Dim DateFromValue As String = ""
        Dim DateToValue As String = ""
        Dim DailyDateValue As String = ""
        Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	
        Dim StartDate, EndDate As String
        Dim StartMonthValue, StartYearValue, EndMonthValue, EndYearValue As Integer
        Dim outputString As String = ""
        Dim grandTotal As Double = 0
        Dim GraphData As New DataSet()
        Dim ReportDate As String
			
        If Radio_1.Checked = True Then
            If IsNumeric(Request.Form("MonthYearDate_Month")) And IsNumeric(Request.Form("MonthYearDate_Year")) Then
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
                ViewOption = 1
            Else
                FoundError = True
            End If
        ElseIf Radio_2.Checked = True Then
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
                ViewOption = 2
            Catch ex As Exception
                FoundError = True
            End Try
        ElseIf Radio_3.Checked = True Then
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
                ViewOption = 3
            Catch ex As Exception
                FoundError = True
            End Try
        Else
            DateFromValue = ""
            DateToValue = ""
            DailyDateValue = ""
            ViewOption = 0
        End If
        If FoundError = False Then
            If LangDefault.Rows.Count >= 3 Then
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(Now(), "DateAndTime", Session("LangID"), objCnn)
            End If
            Reports.CheckConfigReport(1, objCnn)
            showResults.Visible = True
            ShowPrint.Visible = True
            Dim selPromoID, selLangID As Integer
            Dim strShopID As String
            Dim i As Integer
            Dim PromotionData As New DataTable()
            Dim dtTable As DataTable
            Dim SummaryPromotion As New DataTable()
            Dim reportType As Integer
            selPromoID = 0
            selLangID = Session("LangID")

            strShopID = ""
            If ShowShopInfoCombo.Visible = False Then
                For i = 0 To chklShopInfo.Items.Count - 1
                    If chklShopInfo.Items(i).Selected = True Then
                        strShopID &= chklShopInfo.Items(i).Value & ", "
                    End If
                Next i
            Else
                'For ComboShop
                If cboShopInfo.SelectedIndex = 0 Then
                    'All Shop
                    For i = 1 To cboShopInfo.Items.Count - 1
                        strShopID &= cboShopInfo.Items(i).Value & ", "
                    Next i
                    chkSelectAllShop.Checked = True
                Else
                    strShopID = cboShopInfo.SelectedItem.Value & ", "
                End If
            End If
            If strShopID <> "" Then
                strShopID = Mid(strShopID, 1, Len(strShopID) - 2)
            Else
                strShopID = "-1"
            End If
                        
            If (AllShopSum.Checked = True) Then
                reportType = 90
            Else
                reportType = 91
            End If
            'Application.Lock()
            Dim Result As String = Reports.PromotionDiscountReport(SummaryPromotion, reportType, dtTable, PromotionData, StartDate, EndDate, _
                                           strShopID, selLangID, selPromoID, objCnn)
            'Application.UnLock()
            'Exit Sub
            GenResults(PromotionData, strShopID, ReportDate, LangDefault, LangData2)

            Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & _
                    CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & _
                    ResultText.InnerHtml & "</td></tr></table>"
        End If
	
    End Sub
    
    Public Function GenResults(ByVal PromotionData As DataTable, ByVal groupOfShopID As String, ByVal ReportDate As String, _
    ByVal LangDefault As DataTable, ByVal LangData2 As DataTable) As String
        Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
        Dim LangText As String = "lang" + Session("LangID").ToString
        Dim ReportHeader As String = ""
        Dim i As Integer
        Dim colSpan As Integer
               
        If chkSelectAllShop.Checked = True Then
            ReportHeader += "All Shops" + "<br>"
        Else
            Dim dtShopData As DataTable
            Dim strSQL As String
            strSQL = "Select ProductLevelCode, ProductLevelName From ProductLevel Where ProductlevelID IN (" & groupOfShopID & ") "
            dtShopData = objDB.List(strSQL, objCnn)
            
            strSQL = ""
            For i = 0 To dtShopData.Rows.Count - 1
                strSQL &= dtShopData.Rows(i)("ProductLevelName") & ", "
            Next i
            If strSQL <> "" Then
                strSQL = Mid(strSQL, 1, Len(strSQL) - 2)
            End If
            ReportHeader &= strSQL + "<br>"
        End If
        ResultSearchText.InnerHtml = ReportHeader + LangText0.Text + " (" + ReportDate + ")"
		
        Dim dclTotalPriceAfterDiscount,branchTotalPriceAfterDiscount As Decimal
        Dim totalDiscount As Double = 0
        Dim grandTotalNet As Double = 0
        Dim outputString As StringBuilder = New StringBuilder
        Dim countPromo As Integer
        Dim TotalBill As Double = 0
        Dim BranchTotalBill As Double = 0
        Dim BranchTotalDiscount As Double = 0
        Dim bolByShop As Boolean = False
		
        If AllShopSum.Checked = False Then
            bolByShop = True
        End If
		
        For i = 0 To PromotionData.Rows.Count - 1
            grandTotalNet += PromotionData.Rows(i)("TotalDiscount")
        Next
        
        If forCompanyType = ReportModule.ReportV6.FORCOMPANY_GREYHOUND Then
            colSpan = 7
        Else
            colSpan = 5
        End If
        countPromo = 0
        dclTotalPriceAfterDiscount = 0
        branchTotalPriceAfterDiscount = 0
        For i = 0 To PromotionData.Rows.Count - 1
            If bolByShop = True Then
                If i = 0 Then
                    outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
                    outputString = outputString.Append("<td align=""left"" colspan=""" & colSpan & """ class=""smallText"">" + PromotionData.Rows(i)("ShopName") + "</td>")
                    outputString = outputString.Append("</tr>")
                ElseIf PromotionData.Rows(i - 1)("ShopID") <> PromotionData.Rows(i)("ShopID") Then
                    outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
                    outputString = outputString.Append("<td align=""left"" colspan=""" & colSpan & """ class=""smallText"">" + PromotionData.Rows(i)("ShopName") + "</td>")
                    outputString = outputString.Append("</tr>")
                End If
            End If
            countPromo += 1
            outputString = outputString.Append("<tr>")
            outputString = outputString.Append("<td align=""center"" class=""smallText"">" & countPromo.ToString & "</td>")
            If Not IsDBNull(PromotionData.Rows(i)("PromotionName")) Then
                outputString = outputString.Append("<td class=""smallText"">" + PromotionData.Rows(i)("PromotionName") + "</td>")
            Else
                outputString = outputString.Append("<td class=""smallText"">" + "-" + "</td>")
            End If
            If Not IsDBNull(PromotionData.Rows(i)("TotalBill")) Then
                outputString = outputString.Append("<td align=""center"" class=""smallText"">" + Format(PromotionData.Rows(i)("TotalBill"), FormatData.Rows(0)("QtyFormat")) + "</td>")
            Else
                outputString = outputString.Append("<td align=""center"" class=""smallText"">" + "-" + "</td>")
            End If
            If forCompanyType = ReportModule.ReportV6.FORCOMPANY_GREYHOUND Then
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("TotalDiscount") + PromotionData.Rows(i)("PriceAfterDiscount"), FormatData.Rows(0)("CurrencyFormat")) + "</td>")
            End If
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("TotalDiscount"), FormatData.Rows(0)("CurrencyFormat")) + "</td>")
            
            If forCompanyType = ReportModule.ReportV6.FORCOMPANY_GREYHOUND Then
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("PriceAfterDiscount"), FormatData.Rows(0)("CurrencyFormat")) + "</td>")
            End If
                        
            If grandTotalNet > 0 Then
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format((PromotionData.Rows(i)("TotalDiscount")) / grandTotalNet, FormatData.Rows(0)("PercentFormat")) + "</td>")
            Else
                outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
            End If
            outputString = outputString.Append("</tr>")
            TotalBill += PromotionData.Rows(i)("TotalBill")
            totalDiscount += PromotionData.Rows(i)("TotalDiscount")
            BranchTotalBill += PromotionData.Rows(i)("TotalBill")
            BranchTotalDiscount += PromotionData.Rows(i)("TotalDiscount")
			
            If forCompanyType = ReportModule.ReportV6.FORCOMPANY_GREYHOUND Then
                dclTotalPriceAfterDiscount += PromotionData.Rows(i)("PriceAfterDiscount")
                branchTotalPriceAfterDiscount += PromotionData.Rows(i)("PriceAfterDiscount")
            End If
            
            If bolByShop = True Then
                If i = PromotionData.Rows.Count - 1 Then
                    outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
                    outputString = outputString.Append("<td colspan=""2"" align=""right"" class=""smallText"">" + "Summary " + PromotionData.Rows(i)("ShopName") + "</td>")
                    outputString = outputString.Append("<td align=""center"" class=""smallText"">" + Format(BranchTotalBill, FormatData.Rows(0)("QtyFormat")) + "</td>")
                    If forCompanyType = ReportModule.ReportV6.FORCOMPANY_GREYHOUND Then
                        '                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(BranchTotalDiscount + branchTotalPriceAfterDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
                    End If
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(BranchTotalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                    If forCompanyType = ReportModule.ReportV6.FORCOMPANY_GREYHOUND Then
                        '                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(branchTotalPriceAfterDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
                    End If
                    If grandTotalNet > 0 Then
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(BranchTotalDiscount / grandTotalNet, FormatData.Rows(0)("PercentFormat")) + "</td>")
                    Else
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
                    End If
                    countPromo = 0
                ElseIf PromotionData.Rows(i + 1)("ShopID") <> PromotionData.Rows(i)("ShopID") Then
                    outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
                    outputString = outputString.Append("<td colspan=""2"" align=""right"" class=""smallText"">" + "Summary " + PromotionData.Rows(i)("ShopName") + "</td>")
                    outputString = outputString.Append("<td align=""center"" class=""smallText"">" + Format(BranchTotalBill, FormatData.Rows(0)("QtyFormat")) + "</td>")
                    If forCompanyType = ReportModule.ReportV6.FORCOMPANY_GREYHOUND Then
                        '                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(BranchTotalDiscount + branchTotalPriceAfterDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
                    End If
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(BranchTotalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                    If forCompanyType = ReportModule.ReportV6.FORCOMPANY_GREYHOUND Then
'                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(branchTotalPriceAfterDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
                    End If
                    If grandTotalNet > 0 Then
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(BranchTotalDiscount / grandTotalNet, FormatData.Rows(0)("PercentFormat")) + "</td>")
                    Else
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
                    End If
                    BranchTotalBill = 0
                    BranchTotalDiscount = 0
                    countPromo = 0
                End If
            End If
        Next
        If i > 0 Then
            outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
            outputString = outputString.Append("<td colspan=""2"" align=""right"" class=""smallText"">" + "Summary" + "</td>")
            outputString = outputString.Append("<td align=""center"" class=""smallText"">" + Format(TotalBill, FormatData.Rows(0)("QtyFormat")) + "</td>")
            If forCompanyType = ReportModule.ReportV6.FORCOMPANY_GREYHOUND Then
                '                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalDiscount + dclTotalPriceAfterDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
            End If
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
            If forCompanyType = ReportModule.ReportV6.FORCOMPANY_GREYHOUND Then
                '                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(dclTotalPriceAfterDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
            End If
            If grandTotalNet > 0 Then
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(1, FormatData.Rows(0)("PercentFormat")) + "</td>")
            Else
                outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
            End If
            outputString = outputString.Append("</tr>")
        End If
		
        ResultText.InnerHtml = outputString.ToString
        
        '  If forCompanyType = ReportModule.ReportV6.FORCOMPANY_GREYHOUND Then
        'WarningMsg.InnerHtml = LangData2.Rows(22)(LangText)
        'Else
        'WarningMsg.InnerHtml = ""
        'End If
        
        Return ""
    End Function

    Sub ExportData(Source As Object, E As EventArgs)
	
        Dim FileName As String = "PromotionDiscountData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
        Dim OutputText As String = ""
        Dim CSSFile As String = Replace(UCase(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))), "REPORTS", "") & "StyleSheet\admin.css"
	
        Util.ExportData(Session("ReportResult"), FileName, CSSFile, GlobalParam.ExportCharSet, -1)
    End Sub
    
    Private Sub InitialLoadMasterShopIntoCombo()
        If POSBackOfficeReport.ReportShareSQL.BackOfficeReport_IsDisplayShopByMasterShop(objDB, objCnn) <> 0 Then
            Dim lstItem As ListItem
            Dim i As Integer
            Dim dtShopMaster As DataTable
            dtShopMaster = getInfo.ListMasterShop(Session("StaffRole"), objCnn)
            chklMasterShop.Items.Clear()
            For i = 0 To dtShopMaster.Rows.Count - 1
                lstItem = New ListItem
                lstItem.Text = dtShopMaster.Rows(i)("ProductLevelName")
                lstItem.Value = dtShopMaster.Rows(i)("ProductLevelID")
                    
                chklMasterShop.Items.Add(lstItem)
            Next i
            If chklMasterShop.Items.Count <= 1 Then
                ShowMasterShop.Visible = False
            Else
                ShowMasterShop.Visible = True
            End If
            ShowShopInfoList.Visible = True
            ShowShopInfoCombo.Visible = False
        Else
            chklMasterShop.Items.Clear()
            ShowMasterShop.Visible = False
            ShowShopInfoList.Visible = False
            ShowShopInfoCombo.Visible = True
        End If
        LoadShopIntoCheckBoxList()
    End Sub

    Sub SelShop(sender As Object, e As System.EventArgs)
        LoadShopIntoCheckBoxList()
    End Sub
    
    Private Sub LoadShopIntoCheckBoxList()
        Dim dtShopData As DataTable
        Dim lstItem As ListItem
        Dim i As Integer
        Dim strSelMasterShopID As String
        
        strSelMasterShopID = ""
        For i = 0 To chklMasterShop.Items.Count - 1
            If chklMasterShop.Items(i).Selected = True Then
                strSelMasterShopID &= chklMasterShop.Items(i).Value & ", "
            End If
        Next i
        
        If strSelMasterShopID = "" Then
            dtShopData = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), objCnn)
        Else
            dtShopData = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), Mid(strSelMasterShopID, 1, Len(strSelMasterShopID) - 2), objCnn)
        End If
        
        cboShopInfo.Items.Clear()
        chklShopInfo.Items.Clear()
        
        'All Shop For Combo
        lstItem = New ListItem
        lstItem.Text = "----- All Shops -----"
        lstItem.Value = 0
        cboShopInfo.Items.Add(lstItem)
        For i = 0 To dtShopData.Rows.Count - 1
            lstItem = New ListItem
            lstItem.Text = dtShopData.Rows(i)("ProductLevelName")
            lstItem.Value = dtShopData.Rows(i)("ProductLevelID")
            chklShopInfo.Items.Add(lstItem)
            lstItem = New ListItem
            lstItem.Text = dtShopData.Rows(i)("ProductLevelName")
            lstItem.Value = dtShopData.Rows(i)("ProductLevelID")
            cboShopInfo.Items.Add(lstItem)
        Next i
        If dtShopData.Rows.Count >= 1 Then
            cboShopInfo.SelectedIndex = 1
        End If


    End Sub
       
    
    Sub Page_UnLoad()
        objCnn.Close()
    End Sub

</script>
</body>
</html>
