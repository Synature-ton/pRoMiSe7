<%@ Page Language="VB" ContentType="text/html" EnableViewState="True" debug="True" %>
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
<%@Import Namespace="System.IO" %>
<%@Import Namespace="StockOnlyReports" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Non Sale Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="../StyleSheet/webscript.js"></script>
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
<input type="hidden" id="IsSelAllShop" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<input type="hidden" id="SelShopIDList" runat="server" />
<input type="hidden" id="PayTypeName" runat="server" /> 
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
			</tr>
		</table>
	</td>
	<td valign="top">
		<table>
			<tr>
	            <td id="ShowShopInfoCombo" runat="server">                    
                    <asp:DropDownList ID="cboShopInfo" runat="server"></asp:DropDownList>                    
                </td>    
			</tr>
			<tr>
				<td><span id="PayTypeText" runat="server"></span></td>
			</tr>
			<tr>
				<td><asp:radiobutton ID="optReportByDate" GroupName="grReportType" CssClass="text" runat="server" /></td>
			</tr>
			<tr>
				<td><asp:radiobutton ID="optReportByProduct" GroupName="grReportType" CssClass="text" runat="server" /></td>
			</tr>
			<tr id="ShowTimeCriteria" visible="false" runat="server">
				<td><asp:radiobutton ID="optReportByTime" GroupName="grReportType" CssClass="text" runat="server" />
				<asp:dropdownlist ID="GroupByParam" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
			</tr>
		</table></td>
	<td>
	<table>
		<tr>
		<td><asp:radiobutton ID="optViewByDate" GroupName="grReportViewDate" runat="server" /></td>
		<td><synature:date id="DailyDate" runat="server" /></td>
		<td colspan="2"><asp:CheckBox ID="ExpandReceipt" CssClass="text" Checked="false" visible="false" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="optViewByMonth" GroupName="grReportViewDate" runat="server" /></td>
		<td colspan="3"><synature:date id="MonthYearDate" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="optViewByYear" GroupName="grReportViewDate" runat="server" /></td>
		<td colspan="3"><synature:date id="YearDate" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="optViewByDateRange" GroupName="grReportViewDate" runat="server" /></td>
		<td><synature:date id="CurrentDate" runat="server" /></td>
		<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
		<td><synature:date id="ToDate" runat="server" /></td>
	</tr>
	<tr><td>&nbsp;</td>
		<td colspan="4"><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" />&nbsp;<asp:CheckBox ID="DisplayGraph" CssClass="text" Checked="false" visible="false" runat="server" /></td>
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
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim st As New StReports()
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer = 6

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Reports_SaleStockOnly") Then
		
            Try
                objCnn = getCnn.EstablishConnection()

                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
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
                Dim strSelShopID As String
                Dim bolSelAllShop, bolSelMultipleShop As Boolean
                
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
		
                LangText0.Text = "Non Sale Report" 'LangData2.Rows(124)(LangText)
		
                Dim i As Integer
                'Check Current SelectShopID and SelectAllShop
                strSelShopID = ""
                bolSelAllShop = False
                bolSelMultipleShop = False
                GetSelectShopIDAndName(strSelShopID, "", bolSelAllShop, bolSelMultipleShop)
                
                ResultText.InnerHtml = ""
                ResultSearchText.InnerHtml = ""
                errorMsg.InnerHtml = ""
                ExtraHeader.InnerHtml = ""
		
                Dim HeaderString As String = ""
		        
                If (optReportByDate.Checked = True And (optViewByMonth.Checked = True Or optViewByDateRange.Checked = True Or optViewByYear.Checked = True)) Or optReportByTime.Checked = True Or _
                            (bolSelAllShop = True And optReportByProduct.Checked = False) Or (optReportByDate.Checked = True And optViewByDate.Checked = True And ExpandReceipt.Checked = False) Then
                    If (optViewByDate.Checked = True And bolSelMultipleShop = False) Then
                        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(18)(LangText) + "</td>"
                        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(125)(LangText) + "</td>"
                        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(126)(LangText) + "</td>"
                        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(127)(LangText) + "</td>"

                        'Check Display TableName
                        Dim bolDisplayTable As Boolean
                        Dim dtTable As DataTable
                        If strSelShopID <> "" Then
                            dtTable = objDB.List("Select * From ProductLevel Where ShopType = 1 AND ProductLevelID IN (" & strSelShopID & ") ", objCnn)
                            If dtTable.Rows.Count = 0 Then
                                bolDisplayTable = False
                            Else
                                bolDisplayTable = True
                            End If
                        Else
                            bolDisplayTable = False
                        End If
                        If bolDisplayTable = True Then
                            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(19)(LangText) + "</td>"
                        End If
                    Else
                        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Description" + "</td>"
                        If bolSelMultipleShop = True Then
                            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(125)(LangText) + "</td>"
                        End If
                        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "# Bill" + "</td>"
                    End If
				
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Price" + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Discount" + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Sub Total" + "</td>"
			
			
                ElseIf optReportByProduct.Checked = True Then
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
		
                If optViewByDate.Checked = True And (optReportByDate.Checked = True Or optReportByTime.Checked = True) And ExpandReceipt.Checked = True And bolSelAllShop = False Then
                    startTable.InnerHtml = "<table border=""0"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
                Else
                    startTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
                End If

                GroupByParam.Items(0).Text = "Group By Day of Week"
                GroupByParam.Items(0).Value = "1"
                GroupByParam.Items(1).Text = "Group By Time"
                GroupByParam.Items(1).Value = "2"
                If Request.Form("GroupByParam") = 1 Then
                    GroupByParam.Items(0).Selected = True
                ElseIf Request.Form("GroupByParam") = 2 Then
                    GroupByParam.Items(1).Selected = True
                Else
                    GroupByParam.Items(0).Selected = True
                End If
		
                ExpandReceipt.Text = "Show Receipt Details"
                DisplayGraph.Text = "Display Graph for Monthly Report and Date Range Report"
		
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
		
                optReportByDate.Text = LangData2.Rows(0)(LangText)
                optReportByProduct.Text = LangData2.Rows(1)(LangText)
		
		
		
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
                    optViewByDate.Checked = True
                    optReportByProduct.Checked = True
                    InitialLoadMasterShopIntoCombo()
                End If
		
                Dim outputString, FormSelected As String
                Dim Multiple As Boolean = False
                Dim ShopList As String = ""
		
                Dim PayTypeIDValue As String = "0"
                If IsNumeric(Request.Form("PayTypeID")) Then
                    PayTypeIDValue = Request.Form("PayTypeID").ToString
                ElseIf IsNumeric(Request.QueryString("PayTypeID")) Then
                    PayTypeIDValue = Request.QueryString("PayTypeID").ToString
                End If
		
                Dim getOnlyStock As DataTable = st.PayTypeOnlyStockData(0, 0, Session("LangID"), objCnn)
                If getOnlyStock.Rows.Count = 0 Then
                    showPage.Visible = False
                    errorMsg.InnerHtml = LangData2.Rows(128)(LangText)
                Else
                    outputString = "<select name=""PayTypeID"" class=""text"" style=""width=200px"">"
                    If getOnlyStock.Rows.Count > 1 Then
                        If Not Page.IsPostBack Then
                            FormSelected = "selected"
                            PayTypeName.Value = LangData2.Rows(129)(LangText)
                        ElseIf PayTypeIDValue = "0" Then
                            FormSelected = "selected"
                            PayTypeName.Value = LangData2.Rows(129)(LangText)
                        Else
                            FormSelected = ""
                        End If
                        outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & "--- " + LangData2.Rows(129)(LangText) + " ---"
                    End If
                    For i = 0 To getOnlyStock.Rows.Count - 1
                        If getOnlyStock.Rows(i)("SaleDocumentTypeID") = PayTypeIDValue Then
                            FormSelected = " selected"
                            PayTypeName.Value = getOnlyStock.Rows(i)("PayType")
                        Else
                            FormSelected = ""
                        End If
                        outputString += "<option value=""" & getOnlyStock.Rows(i)("SaleDocumentTypeID").ToString & """ " & FormSelected & ">" & getOnlyStock.Rows(i)("PayType")
                    Next
                    outputString += "</select>"
                    PayTypeText.InnerHtml = outputString
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
        
        Dim StartDate, EndDate As String
        Dim StartMonthValue, StartYearValue, EndMonthValue, EndYearValue As Integer
        Dim outputString As String = ""
        Dim grandTotal As Double = 0
        Dim VATTotal As Double = 0
        Dim GraphData As New DataSet()
        Dim ReportDate As String
        Dim YearValue4 As Integer
        Dim bolViewByMonth, bolViewByDateRange, bolViewByDate, bolViewByYear, bolReportByDate, bolReportByProduct, bolReportByTime As Boolean
        
        bolViewByMonth = False
        bolViewByDateRange = False
        bolViewByDate = False
        bolViewByYear = False
        If Request.Form("grReportViewDate") = "optViewByMonth" Then
            bolViewByMonth = True
        ElseIf Request.Form("grReportViewDate") = "optViewByDateRange" Then
            bolViewByDateRange = True
        ElseIf Request.Form("grReportViewDate") = "optViewByDate" Then
            bolViewByDate = True
        Else
            bolViewByYear = True
        End If
	
        If Request.Form("grReportType") = "optReportByDate" Then
            bolReportByDate = True
        ElseIf Request.Form("grReportType") = "optReportByProduct" Then
            bolReportByProduct = True
        ElseIf Request.Form("grReportType") = "optReportByTime" Then
            bolReportByTime = True
        End If
	
        Dim ExpReceipt As Boolean = False
        If Request.Form("ExpandReceipt") = "on" Then ExpReceipt = True
	
        Dim DGraph As Boolean = False
        If Request.Form("DisplayGraph") = "on" Then DGraph = True
	
        If bolViewByMonth = True Then
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
            End Try
        ElseIf bolViewByDateRange = True Then
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
            End Try
        ElseIf bolViewByDate = True Then
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
        ElseIf bolViewByYear = True Then
            Try
                StartDate = DateTimeUtil.FormatDate(1, 1, Request.Form("YearDate_Year"))
		 
                YearValue4 = Request.Form("YearDate_Year") + 1
                EndDate = DateTimeUtil.FormatDate(1, 1, YearValue4)
                Dim SDate4 As New Date(Request.Form("YearDate_Year"), 1, 1)
                ReportDate = DateTimeUtil.FormatDateTime(SDate4, "yyyy", Session("LangID"), objCnn)
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
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(Now(), "DateAndTime", Session("LangID"), objCnn)
            End If
            Dim displayTable As New DataTable()
            Dim bolSelAllShop, bolSelMultipleShop As Boolean
            Dim strSelShopID, strSelShopName As String
		
            ShowPrint.Visible = True
            showResults.Visible = True
		
            Dim ViewOption As Integer
            If bolViewByMonth = True Then
                ViewOption = 1
            ElseIf bolViewByDateRange = True Then
                ViewOption = 2
            ElseIf bolViewByYear = True Then
                ViewOption = 4
            Else
                ViewOption = 0
            End If
            'Application.Lock()
		
            Dim LangPath As String = Util.GetLangPath(Request.PhysicalApplicationPath)

            'Get Select ShopID/ Name
            strSelShopID = ""
            strSelShopName = ""
            bolSelAllShop = False
            bolSelMultipleShop = False
            GetSelectShopIDAndName(strSelShopID, strSelShopName, bolSelAllShop, bolSelMultipleShop)

            Dim groupParam, langID As Integer
            groupParam = Request.Form("GroupByParam")
            langID = Session("LangID")
            
            ResultText.InnerHtml = st.SaleReports(PayTypeList, outputString, grandTotal, VATTotal, GraphData, True, GlobalParam.GrayBGColor, GlobalParam.AdminBGColor, _
                                         langID, ViewOption, bolReportByDate, bolReportByProduct, bolReportByTime, groupParam, StartDate, EndDate, _
                                         strSelShopID, 0, 0, True, ExpReceipt, DGraph, Request.Form("PayTypeID").ToString, LangPath, _
                                         Session("StaffRole"), objCnn)
		
            SelShopIDList.Value = strSelShopID
            SelShopName.Value = strSelShopName
            
            Dim ShopDisplay As String
            If bolSelAllShop = True Then
                ShopDisplay = "All Shops"
            Else
                ShopDisplay = SelShopName.Value
            End If 'LangData2.Rows(130)(LangText)
            ResultSearchText.InnerHtml = "Non Sale Report " + " " + PayTypeName.Value + " " + LangData2.Rows(131)(LangText) + " " + ShopDisplay + " (" + ReportDate + ")"
            'Application.UnLock()
            Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"
		
            If DGraph = True And (bolViewByDate = False Or (bolViewByDate = True And bolSelAllShop = True) Or (bolViewByDate = True And Request.Form("GroupByParam") = 2)) And _
                    (bolReportByDate = True Or bolReportByTime = True) Then

                showGraph.Visible = True
                Dim view As DataView = GraphData.Tables(0).DefaultView
            
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
                ConfigureColors("Sale Report of " + ShopDisplay + " (" + ReportDate + ")")
        
                ChartControl1.RedrawChart()
            Else
                showGraph.Visible = False
            End If
        End If
    End Sub

    Private Sub GetSelectShopIDAndName(ByRef selShopID As String, ByRef selShopName As String, ByRef bolSelAllShop As Boolean, ByRef bolSelMultipleShop As Boolean)
        Dim i, noSelShop As Integer
        bolSelAllShop = False
        bolSelMultipleShop = False
        selShopID = ""
        selShopName = ""
        If ShowShopInfoCombo.Visible = True Then
            If cboShopInfo.Items.Count > 0 Then
                If cboShopInfo.SelectedIndex = 0 Then
                    bolSelAllShop = True
                    bolSelMultipleShop = True
                    For i = 1 To cboShopInfo.Items.Count - 1
                        selShopID &= cboShopInfo.Items(i).Value & ", "
                        selShopName &= cboShopInfo.Items(i).Text & ", "
                    Next i
                Else
                    bolSelAllShop = False
                    selShopID &= cboShopInfo.SelectedItem.Value & ", "
                    selShopName &= cboShopInfo.SelectedItem.Text & ", "
                End If
            End If
        Else
            bolSelAllShop = chkSelectAllShop.Checked
            noSelShop = 0
            For i = 0 To chklShopInfo.Items.Count - 1
                If chklShopInfo.Items(i).Selected = True Then
                    selShopID &= chklShopInfo.Items(i).Value & ", "
                    selShopName &= chklShopInfo.Items(i).Text & ", "
                    noSelShop += 1
                End If
            Next i
            If noSelShop > 1 Then
                bolSelMultipleShop = True
            End If
        End If
        If selShopID <> "" Then
            selShopID = Mid(selShopID, 1, Len(selShopID) - 2)
        Else
            selShopID = "-1"
        End If
        If selShopName <> "" Then
            selShopName = Mid(selShopName, 1, Len(selShopName) - 2)
        End If
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
        If cboShopInfo.Items.Count > 1 Then
            cboShopInfo.SelectedIndex = 1
        End If
    End Sub
       
    Sub ConfigureColors(TitleName)
        'ChartControl1.Background.Color = Color.FromArgb(75, Color.SteelBlue)
        Dim ChartWidth As Integer = 650
        Dim ChartHeight As Integer = 500
        If Request.Form("grReportType") = "optReportByTime" Then
            If Request.Form("GroupByParam") = 1 Then
                ChartWidth = 500
                ChartHeight = 350
            Else
                ChartWidth = 600
                ChartHeight = 400
            End If
        End If
        ChartControl1.Background.Type = InteriorType.LinearGradient
        ChartControl1.Background.ForeColor = Color.SteelBlue
        ChartControl1.Background.EndPoint = New Point(ChartWidth, ChartHeight)
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
	
        Dim FileName As String = "OtherSaleData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
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
