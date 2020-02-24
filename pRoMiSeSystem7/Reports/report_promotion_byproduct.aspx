<%@ Page Language="VB" ContentType="text/html" debug="True" %>
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
<title>Promotion Discount Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <style type="text/css">
        .auto-style2 {
            width: 14px;
        }
    </style>

</head>
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<input type="hidden" id="SelPromotionIDList" runat="server" />

    <script src="../Scripts/jquery.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

 <SCRIPT type="text/javascript">
     function CheckAll(checked) {
         len = document.forms[0].chkbSelectPromotion.Items.Count;
         var i = 0;
         for (i = 0; i < len; i++) {
             document.forms[0].chkbSelectPromotion.Items(0).Selected = checked;
         }
     }
     
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
    <td valign="top" id="tdMasterShop" runat="server" >
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
    <td valign="top" id="tdShopInfo" runat="server" > 
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
				<td><asp:CheckBox ID="AllShopSum" CssClass="text" runat="server"></asp:CheckBox></td>
			</tr>
			<tr>
				<td><asp:CheckBox ID="OnlyZeroNet" CssClass="text" runat="server"></asp:CheckBox></td>
			</tr>
        </table>
    </td>
	<td valign="top">
	    <table>
		    <tr>
			    <td><asp:radiobutton ID="optViewPromotionByDate" GroupName="Group1" runat="server" /></td>
			    <td colspan="3"><table cellpadding="0" cellspacing="0"><tr><td><synature:date id="DailyDate" runat="server" /></td></tr></table></td>
		    </tr>
		    <tr>
			    <td><asp:radiobutton ID="optViewPromotionByMonth" GroupName="Group1" runat="server" /></td>
			    <td colspan="3"><synature:date id="MonthYearDate" runat="server" /></td>
		    </tr>
		    <tr>
			    <td><asp:radiobutton ID="optViewPromotionByDateRange" GroupName="Group1" runat="server" /></td>
    			<td><synature:date id="CurrentDate" runat="server" /></td>
	    		<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
		    	<td><synature:date id="ToDate" runat="server" /></td>
		    </tr>
	    </table>
	</td>
</tr>
<tr>
    <td colspan="5">
        <asp:Checkbox ID="chkDisplaySelectPromotion" runat="server" Text="Display Selected Promotion" AutoPostBack="true" OnCheckedChanged="chkDisplaySelectPromotion_CheckedChanged"/>
    </td>
</tr>
<tr>      
    <td  colspan="5">
        <div id="pnlDisplayPromotion" runat="server">
        <table>
            <tr>
                <td class="auto-style2"></td>
                <td><asp:Checkbox ID="chkSelAllPromotion" Text="Sel All Data" AutoPostBack="true" runat="server" OnCheckedChanged="CheckAllPromotion" />
                </td>
                <td align="right">
                    <asp:DropDownList ID="cboDisplayPromotionType" runat="server" style="margin-left: 0px" AutoPostBack="True" OnSelectedIndexChanged="cboDisplayPromotionType_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>                   
            <tr>
                <td class="auto-style2"></td>
                <td colspan="2">
                <div id="pnlSelectPromotion" style="border-width:1px;border-style:solid;height:120px;width:450px;overflow:auto" >
                    <asp:CheckBoxList ID="chkbSelectPromotion" runat="server" Width="250px"  Height="16px" ></asp:CheckBoxList>
                </div></td>
            </tr>
        </table>
        </div>
    </td>
</tr>
<tr>
    <td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
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
Dim PageID As Integer = 18

    Private Const DISPLAYPROMOTIONINDEX_ACTIVED As Integer = 0
    Private Const DISPLAYPROMOTIONINDEX_INCLUDENOTACTIVED As Integer = 1
    Private Const DISPLAYPROMOTIONINDEX_INCLUDEDELETED As Integer = 2
    
    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Report_PromotionByProduct") Then
		
            Try
                objCnn = getCnn.EstablishConnection()
                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
                ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
                showResults.Visible = False
		
                startTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		
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
		
                OnlyZeroNet.Text = LangData2.Rows(0)(LangText)
                AllShopSum.Text = LangData2.Rows(1)(LangText)
			
                chkDisplaySelectPromotion.Text = BackOfficeReport.GetLanguageText(LangData2, 21, LangText, "Select Promotion")
                chkSelAllPromotion.Text = BackOfficeReport.GetLanguageText(LangData2, 17, LangText, "Select All")
                                
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
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(2)(LangText) + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(3)(LangText) + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(4)(LangText) + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(5)(LangText) + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(6)(LangText) + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(7)(LangText) + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(8)(LangText) + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(9)(LangText) + "</td>"
		
                TableHeaderText.InnerHtml = HeaderString
		
                If IsNumeric(Request.Form("DocDaily_Day")) Then
                    Session("DocDailyDay") = Request.Form("DocDaily_Day")
                ElseIf IsNumeric(Request.QueryString("DocDaily_Day")) Then
                    Session("DocDailyDay") = Request.QueryString("DocDaily_Day")
                ElseIf Trim(Session("DocDailyDay")) = "" Then
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
                End If
                If Page.IsPostBack And Request.Form("DocDaily_Month") = "" Then Session("DocDaily_Month") = 0
                DailyDate.SelectedMonth = Session("DocDaily_Month")
		
                If IsNumeric(Request.Form("DocDaily_Year")) Then
                    Session("DocDaily_Year") = Request.Form("DocDaily_Year")
                ElseIf IsNumeric(Request.QueryString("DocDaily_Year")) Then
                    Session("DocDaily_Year") = Request.QueryString("DocDaily_Year")
                ElseIf Trim(Session("DocDaily_Year")) = "" Then
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
                End If
                If Page.IsPostBack And Request.Form("Doc_Day") = "" Then Session("DocDay") = 0
                CurrentDate.SelectedDay = Session("DocDay")
		
		
                If IsNumeric(Request.Form("Doc_Month")) Then
                    Session("Doc_Month") = Request.Form("Doc_Month")
                ElseIf IsNumeric(Request.QueryString("Doc_Month")) Then
                    Session("Doc_Month") = Request.QueryString("Doc_Month")
                ElseIf Trim(Session("Doc_Month")) = "" Then
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
                End If
                If Page.IsPostBack And Request.Form("Doc_Year") = "" Then Session("Doc_Year") = 0
                CurrentDate.SelectedYear = Session("Doc_Year")
		
                If IsNumeric(Request.Form("DocTo_Day")) Then
                    Session("DocTo_Day") = Request.Form("DocTo_Day")
                ElseIf IsNumeric(Request.QueryString("DocTo_Day")) Then
                    Session("DocTo_Day") = Request.QueryString("DocTo_Day")
                ElseIf Trim(Session("DocTo_Day")) = "" Then
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
                End If
                If Page.IsPostBack And Request.Form("DocTo_Month") = "" Then Session("DocTo_Month") = 0
                ToDate.SelectedMonth = Session("DocTo_Month")
		
                If IsNumeric(Request.Form("DocTo_Year")) Then
                    Session("DocTo_Year") = Request.Form("DocTo_Year")
                ElseIf IsNumeric(Request.QueryString("DocTo_Year")) Then
                    Session("DocTo_Year") = Request.QueryString("DocTo_Year")
                ElseIf Trim(Session("DocTo_Year")) = "" Then
                    Session("DocTo_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("DocTo_Year") = "" Then Session("DocTo_Year") = 0
                ToDate.SelectedYear = Session("DocTo_Year")
		
                If IsNumeric(Request.Form("MonthYearDate_Day")) Then
                    Session("MonthYearDate_Day") = Request.Form("MonthYearDate_Day")
                ElseIf IsNumeric(Request.QueryString("MonthYearDate_Day")) Then
                    Session("MonthYearDate_Day") = Request.QueryString("MonthYearDate_Day")
                ElseIf Trim(Session("DocDay")) = "" Then
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
                End If
                If Page.IsPostBack And Request.Form("MonthYearDate_Month") = "" Then Session("MonthYearDate_Month") = 0
                MonthYearDate.SelectedMonth = Session("MonthYearDate_Month")
		
                If IsNumeric(Request.Form("MonthYearDate_Year")) Then
                    Session("MonthYearDate_Year") = Request.Form("MonthYearDate_Year")
                ElseIf IsNumeric(Request.QueryString("MonthYearDate_Year")) Then
                    Session("MonthYearDate_Year") = Request.QueryString("MonthYearDate_Year")
                ElseIf Trim(Session("MonthYearDate_Year")) = "" Then
                    Session("MonthYearDate_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("MonthYearDate_Year") = "" Then Session("MonthYearDate_Year") = 0
                MonthYearDate.SelectedYear = Session("MonthYearDate_Year")
		
                Dim TestDate As DateTime = Convert.ToDateTime("2006-04-02")
                If Not Page.IsPostBack Then
                    optViewPromotionByDate.Checked = True
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
                        EndDateValCheck = DateAdd("d", -1, EndDateValCheck)
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
                        Dim SummaryPromotion As New DataTable()
                        Dim dtTable As DataTable
                        showResults.Visible = True
                        ShowPrint.Visible = True
                        dtTable = New DataTable
                        'Application.Lock()
                        Dim Result As String = getReport.PromotionDiscountReport(SummaryPromotion, 1, dtTable, PromotionData, Request.QueryString("StartDate"), _
                                                      Request.QueryString("EndDate"), Request.QueryString("ShopID"), Session("LangID"), 0, objCnn)
                        GenResults(SummaryPromotion, PromotionData, Request.QueryString("ShopID"), ReportDate, LangDefault, LangData2)
                        objDB.sqlExecute("DROP TABLE IF EXISTS DummyPromotionDiscount", objCnn)
                        objDB.sqlExecute("DROP TABLE IF EXISTS DummyPromotionDiscountSummary", objCnn)
                        'Application.UnLock()
				
                    End If
                End If
                
                If Not Page.IsPostBack Then
                    InitialLoadMasterShopIntoCombo()
                    ListPromotionData(True, False, False)
                    InitialDisplayPromotionTypeInCombo(LangData2, LangText)
                End If

                Dim i As Integer
                Dim strTemp As String
                'PromotionID
                strTemp = ""
                For i = 0 To chkbSelectPromotion.Items.Count - 1
                    If chkbSelectPromotion.Items(i).Selected = True Then
                        strTemp &= chkbSelectPromotion.Items(i).Value & ", "
                    End If
                Next i
                If strTemp <> "" Then
                    strTemp = Mid(strTemp, 1, Len(strTemp) - 2)
                End If
                SelPromotionIDList.Value = strTemp
                
                pnlDisplayPromotion.Visible = chkDisplaySelectPromotion.Checked
                
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
			
        StartDate = ""
        EndDate = ""
        ReportDate = ""
        If optViewPromotionByMonth.Checked = True Then
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
                ViewOption = 1
            Catch ex As Exception
                FoundError = True
            End Try
        ElseIf optViewPromotionByDateRange.Checked = True Then
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
        ElseIf optViewPromotionByDate.Checked = True Then
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
            Dim i, selLangID As Integer
            Dim strShopID, strSelPromoID As String
            Dim PromotionData As New DataTable()
            Dim SummaryPromotion As New DataTable()
            Dim dtTable As DataTable
            Dim ReportTypeVal As Integer = 1
            If OnlyZeroNet.Checked = True Then
                ReportTypeVal = 99
            End If

            strSelPromoID = ""
            For i = 0 To chkbSelectPromotion.Items.Count - 1
                If chkbSelectPromotion.Items(i).Selected = True Then
                    strSelPromoID &= chkbSelectPromotion.Items(i).Value & ", "
                    SelPromotionIDList.Value &= chkbSelectPromotion.Items(i).Value & ", "
                End If
            Next i
            If strSelPromoID <> "" Then
                strSelPromoID = Mid(strSelPromoID, 1, Len(strSelPromoID) - 2)
            End If
            'Save Data In Hidden Field
            SelPromotionIDList.Value = strSelPromoID
            
            'Display All Promotion In Report
            If chkDisplaySelectPromotion.Checked = False Then
                strSelPromoID = ""
            End If
            
            selLangID = Session("LangID")
          
            Dim bolSelAllShop, bolSelMultipleShop As Boolean
            strShopID = ""
            bolSelAllShop = False
            bolSelMultipleShop = False
            GetSelectShopIDAndName(strShopID, "", bolSelAllShop, bolSelMultipleShop)
                    
            dtTable = New DataTable
            
            'Application.Lock()
            Dim Result As String = Reports.PromotionDiscountReport_SelectGroupOfPromoID(SummaryPromotion, ReportTypeVal, dtTable, PromotionData, _
                                        StartDate, EndDate, strShopID, selLangID, strSelPromoID, objCnn)

            GenResults(SummaryPromotion, PromotionData, strShopID, ReportDate, LangDefault, LangData2)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummyPromotionDiscount", objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummyPromotionDiscountSummary", objCnn)
		
            Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"
            'Application.UnLock()

        End If
    End Sub
	
    Private Function GenResults(ByVal SummaryPromotion As DataTable, ByVal PromotionData As DataTable, ByVal groupOfShopID As String, _
    ByVal ReportDate As String, ByVal LangDefault As DataTable, ByVal LangData2 As DataTable) As String
        Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
        Dim LangText As String = "lang" + Session("LangID").ToString
        Dim ReportHeader As String = ""
        Dim i As Integer
        Dim strShopID() As String
        
        strShopID = Split(groupOfShopID, ",")
        If chkSelectAllShop.Checked = True Then
            ReportHeader += LangDefault.Rows(23)(LangText) & "<br>"
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
            ReportHeader &= strSQL & "<br>"
        End If
        
        ResultSearchText.InnerHtml = ReportHeader + LangText0.Text + " (" + ReportDate + ")"
		
        Dim DummyShopID As Integer = -1
        Dim DummyPromotionID As Integer = -1
        Dim netPrice As Double = 0
        Dim totalQty As Double = 0
        Dim totalAmount As Double = 0
        Dim totalDiscount As Double = 0
        Dim branchTotalQty As Double = 0
        Dim branchTotalPrice As Double = 0
        Dim branchTotalDiscount As Double = 0
        Dim branchTotalNet As Double = 0
        Dim grandTotalQty As Double = 0
        Dim grandTotalPrice As Double = 0
        Dim grandTotalDiscount As Double = 0
        Dim grandTotalNet As Double = 0
        Dim ColSpan As String = "8"
        Dim outputString As StringBuilder = New StringBuilder
        Dim countPromo As Integer = 0
        Dim j As Integer = 0
        For i = 0 To PromotionData.Rows.Count - 1
            grandTotalNet += PromotionData.Rows(i)("TotalPrice") - PromotionData.Rows(i)("Discount")
            grandTotalQty += PromotionData.Rows(i)("Amount")
            grandTotalPrice += PromotionData.Rows(i)("TotalPrice")
            grandTotalDiscount += PromotionData.Rows(i)("Discount")
        Next
		
        If (strShopID.Length > 1 And AllShopSum.Checked = False) Or (strShopID.Length = 1) Then
		
            For i = 0 To PromotionData.Rows.Count - 1
                If PromotionData.Rows(i)("ShopID") <> DummyShopID Then
                    If j > 0 Then
                        outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
                        outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""smallText"">" + LangData2.Rows(11)(LangText) + "</td>")
                        outputString = outputString.Append("<td align=""center"" class=""smallText"">" + Format(totalQty, FormatData.Rows(0)("QtyFormat")) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalAmount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalAmount - totalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                        If grandTotalDiscount > 0 Then
                            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalDiscount / grandTotalDiscount, FormatData.Rows(0)("PercentFormat")) + "</td>")
                        Else
                            outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
                        End If
                        outputString = outputString.Append("</tr>")
                        totalQty = 0
                        totalAmount = 0
                        totalDiscount = 0
                    End If
                    If countPromo >= 1 Then
                        outputString = outputString.Append("<tr><td height=""10px"" colspan=""8""></td></tr>")
                        outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
                        outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""smallText"">" + LangData2.Rows(12)(LangText) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
                        'outputString = outputString.Append("<td align=""center"" class=""smallText"">" + Format(branchTotalQty, FormatData.Rows(0)("QtyFormat")) + "</td>")
                        'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(branchTotalPrice, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(branchTotalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                        'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(branchTotalNet, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
                        If grandTotalDiscount > 0 Then
                            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(branchTotalDiscount / grandTotalDiscount, FormatData.Rows(0)("PercentFormat")) + "</td>")
                        Else
                            outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
                        End If
                        outputString = outputString.Append("</tr>")
                    End If
                    If strShopID.Length > 1 Then
                        outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
                        outputString = outputString.Append("<td colspan=""8"" align=""left"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + PromotionData.Rows(i)("ShopName") + "</td>")
                        outputString = outputString.Append("</tr>")
                    End If
                    countPromo = 0
                    j = 0
                    branchTotalNet = 0
                    branchTotalQty = 0
                    branchTotalPrice = 0
                    branchTotalDiscount = 0
                    DummyPromotionID = -1
                End If
                If PromotionData.Rows(i)("PromotionID") <> DummyPromotionID Then
                    If j > 0 Then
                        outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
                        outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""smallText"">" + LangData2.Rows(11)(LangText) + "</td>")
                        outputString = outputString.Append("<td align=""center"" class=""smallText"">" + Format(totalQty, FormatData.Rows(0)("QtyFormat")) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalAmount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalAmount - totalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalDiscount / grandTotalDiscount, FormatData.Rows(0)("PercentFormat")) + "</td>")
                        outputString = outputString.Append("</tr>")
                        totalQty = 0
                        totalAmount = 0
                        totalDiscount = 0
                    End If
                    outputString = outputString.Append("<tr>")
                    If PromotionData.Rows(i)("PromotionID") > 0 Then
                        outputString = outputString.Append("<td colspan=""" + ColSpan + """ align=""left"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(13)(LangText) + ": " + PromotionData.Rows(i)("PromotionName") + "</td>")
                    Else
                        outputString = outputString.Append("<td colspan=""" + ColSpan + """ align=""left"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + PromotionData.Rows(i)("PromotionName") + "</td>")
                    End If
                    outputString = outputString.Append("</tr>")
                    countPromo += 1
                End If

                outputString = outputString.Append("<tr>")
                outputString = outputString.Append("<td class=""smallText"">" + PromotionData.Rows(i)("ProductCode") + "</td>")
                outputString = outputString.Append("<td class=""smallText"">" + PromotionData.Rows(i)("ProductName") + "</td>")
                If PromotionData.Rows(i)("Amount") <> 0 Then
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("TotalPrice") / PromotionData.Rows(i)("Amount"), FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("TotalPrice"), FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                End If
                outputString = outputString.Append("<td align=""center"" class=""smallText"">" + Format(PromotionData.Rows(i)("Amount"), FormatData.Rows(0)("QtyFormat")) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("TotalPrice"), FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("Discount"), FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("TotalPrice") - PromotionData.Rows(i)("Discount"), FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                If grandTotalDiscount > 0 Then
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("Discount") / grandTotalDiscount, FormatData.Rows(0)("PercentFormat")) + "</td>")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
                End If
                outputString = outputString.Append("</tr>")
                totalQty += PromotionData.Rows(i)("Amount")
                totalAmount += PromotionData.Rows(i)("TotalPrice")
                totalDiscount += PromotionData.Rows(i)("Discount")
                branchTotalNet += PromotionData.Rows(i)("TotalPrice") - PromotionData.Rows(i)("Discount")
                branchTotalQty += PromotionData.Rows(i)("Amount")
                branchTotalPrice += PromotionData.Rows(i)("TotalPrice")
                branchTotalDiscount += PromotionData.Rows(i)("Discount")

                DummyPromotionID = PromotionData.Rows(i)("PromotionID")
                DummyShopID = PromotionData.Rows(i)("ShopID")
                j += 1
            Next
		
            If i > 0 Then
                outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""smallText"">" + LangData2.Rows(11)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""center"" class=""smallText"">" + Format(totalQty, FormatData.Rows(0)("QtyFormat")) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalAmount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalAmount - totalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                If grandTotalDiscount > 0 Then
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalDiscount / grandTotalDiscount, FormatData.Rows(0)("PercentFormat")) + "</td>")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
                End If
                outputString = outputString.Append("</tr>")
            End If
            If countPromo >= 1 Then
                outputString = outputString.Append("<tr><td height=""10px"" colspan=""8""></td></tr>")
                outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""smallText"">" + LangData2.Rows(12)(LangText) + "</td>")
                'outputString = outputString.Append("<td align=""center"" class=""smallText"">" + Format(branchTotalQty, FormatData.Rows(0)("QtyFormat")) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(branchTotalPrice, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(branchTotalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(branchTotalNet, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
                If grandTotalDiscount > 0 Then
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(branchTotalDiscount / grandTotalDiscount, FormatData.Rows(0)("PercentFormat")) + "</td>")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
                End If
                outputString = outputString.Append("</tr>")
            End If
		
            If strShopID.Length > 1 And PromotionData.Rows.Count > 0 Then
                outputString = outputString.Append("<tr><td height=""15px"" colspan=""8""></td></tr>")
                outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""smallText"">" + LangData2.Rows(14)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
                'outputString = outputString.Append("<td align=""center"" class=""smallText"">" + Format(grandTotalQty, FormatData.Rows(0)("QtyFormat")) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(grandTotalPrice, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(grandTotalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(grandTotalNet, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
                If grandTotalDiscount > 0 Then
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(1, FormatData.Rows(0)("PercentFormat")) + "</td>")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
                End If
                outputString = outputString.Append("</tr>")
            End If
        End If
        If strShopID.Length > 1 Then
            Dim Result2 As String = GenResults2(SummaryPromotion, ReportDate, LangDefault, LangData2, FormatData, LangText)
            ResultText.InnerHtml = outputString.ToString + "<tr><td height=""40px"" colspan=""8"">" + LangData2.Rows(15)(LangText) + "</td></tr>" + Result2
        Else
            ResultText.InnerHtml = outputString.ToString
        End If
    End Function

    Private Function GenResults2(ByVal PromotionData As DataTable, ByVal ReportDate As String, ByVal LangDefault As DataTable, _
    ByVal LangData2 As DataTable, ByVal FormatData As DataTable, ByVal LangText As String) As String
        Dim DummyPromotionID As Integer = -1
        Dim netPrice As Double = 0
        Dim totalQty As Double = 0
        Dim totalAmount As Double = 0
        Dim totalDiscount As Double = 0
        Dim grandTotalQty As Double = 0
        Dim grandTotalPrice As Double = 0
        Dim grandTotalDiscount As Double = 0
        Dim grandTotalNet As Double = 0
        Dim ColSpan As String = "8"
        Dim outputString As StringBuilder = New StringBuilder
        Dim i As Integer
        Dim countPromo As Integer = 0
        For i = 0 To PromotionData.Rows.Count - 1
            grandTotalNet += PromotionData.Rows(i)("TotalPrice") - PromotionData.Rows(i)("Discount")
            grandTotalQty += PromotionData.Rows(i)("Amount")
            grandTotalPrice += PromotionData.Rows(i)("TotalPrice")
            grandTotalDiscount += PromotionData.Rows(i)("Discount")
        Next
        Dim SetString As String = ""
        For i = 0 To PromotionData.Rows.Count - 1
            If PromotionData.Rows(i)("PromotionID") <> DummyPromotionID Then
                If i > 0 Then
                    outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
                    outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""smallText"">" + LangData2.Rows(11)(LangText) + "</td>")
                    outputString = outputString.Append("<td align=""center"" class=""smallText"">" + Format(totalQty, FormatData.Rows(0)("QtyFormat")) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalAmount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalAmount - totalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format((totalAmount - totalDiscount) / grandTotalNet, FormatData.Rows(0)("PercentFormat")) + "</td>")
                    outputString = outputString.Append("</tr>")
                    totalQty = 0
                    totalAmount = 0
                    totalDiscount = 0
                End If
                outputString = outputString.Append("<tr>")
                If PromotionData.Rows(i)("PromotionID") > 0 Then
                    outputString = outputString.Append("<td colspan=""" + ColSpan + """ align=""left"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(13)(LangText) + ": " + PromotionData.Rows(i)("PromotionName") + "</td>")
                Else
                    outputString = outputString.Append("<td colspan=""" + ColSpan + """ align=""left"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + PromotionData.Rows(i)("PromotionName") + "</td>")
                End If
                outputString = outputString.Append("</tr>")
                countPromo += 1
            End If
            If PromotionData.Rows(i)("ProductSetType") >= 0 Then
                SetString = ""
            Else
                SetString = "**"
            End If
            outputString = outputString.Append("<tr>")
            outputString = outputString.Append("<td class=""smallText"">" + PromotionData.Rows(i)("ProductCode") + "</td>")
            outputString = outputString.Append("<td class=""smallText"">" + PromotionData.Rows(i)("ProductName") + SetString + "</td>")
            If PromotionData.Rows(i)("Amount") <> 0 Then
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("TotalPrice") / PromotionData.Rows(i)("Amount"), FormatData.Rows(0)("CurrencyFormat")) + "</td>")
            Else
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("TotalPrice"), FormatData.Rows(0)("CurrencyFormat")) + "</td>")
            End If
            outputString = outputString.Append("<td align=""center"" class=""smallText"">" + Format(PromotionData.Rows(i)("Amount"), FormatData.Rows(0)("QtyFormat")) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("TotalPrice"), FormatData.Rows(0)("CurrencyFormat")) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("Discount"), FormatData.Rows(0)("CurrencyFormat")) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(PromotionData.Rows(i)("TotalPrice") - PromotionData.Rows(i)("Discount"), FormatData.Rows(0)("CurrencyFormat")) + "</td>")
            If grandTotalNet > 0 Then
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format((PromotionData.Rows(i)("TotalPrice") - PromotionData.Rows(i)("Discount")) / grandTotalNet, FormatData.Rows(0)("PercentFormat")) + "</td>")
            Else
                outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
            End If
            outputString = outputString.Append("</tr>")
            totalQty += PromotionData.Rows(i)("Amount")
            totalAmount += PromotionData.Rows(i)("TotalPrice")
            totalDiscount += PromotionData.Rows(i)("Discount")
            DummyPromotionID = PromotionData.Rows(i)("PromotionID")
        Next
        If i > 0 Then
            outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
            outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""smallText"">" + LangData2.Rows(11)(LangText) + "</td>")
            outputString = outputString.Append("<td align=""center"" class=""smallText"">" + Format(totalQty, FormatData.Rows(0)("QtyFormat")) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalAmount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(totalAmount - totalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
            If grandTotalNet > 0 Then
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format((totalAmount - totalDiscount) / grandTotalNet, FormatData.Rows(0)("PercentFormat")) + "</td>")
            Else
                outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
            End If
            outputString = outputString.Append("</tr>")
        End If
        If countPromo > 1 Then
            outputString = outputString.Append("<tr><td height=""10px"" colspan=""8""></td></tr>")
            outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
            outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""smallText"">" + LangData2.Rows(14)(LangText) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
            'outputString = outputString.Append("<td align=""center"" class=""smallText"">" + Format(grandTotalQty, FormatData.Rows(0)("QtyFormat")) + "</td>")
            'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(grandTotalPrice, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(grandTotalDiscount, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + "" + "</td>")
            'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(grandTotalNet, FormatData.Rows(0)("CurrencyFormat")) + "</td>")
            If grandTotalNet > 0 Then
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Format(1, FormatData.Rows(0)("PercentFormat")) + "</td>")
            Else
                outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
            End If
            outputString = outputString.Append("</tr>")
        End If
        Return outputString.ToString
    End Function
       
    Sub ShowPromotion(sender As Object, e As System.EventArgs)
        ListPromotionData(True, False, False)
    End Sub

    Sub ListPromotionData(showOnlyNotExpire As Boolean, showNotActivated As Boolean, showDeleted As Boolean)
        Dim i, j As Integer
        Dim selPromoID() As String
        Dim dtPromoData As DataTable = New DataTable("PromotionData")
        Dim rNew As DataRow
        Dim dtData As DataTable
                
        dtPromoData.Columns.Add("PromotionName", GetType(String))
        dtPromoData.Columns.Add("PromotionID", GetType(Integer))
        dtData = ReportShareSQL.ListPromotionData(objDB, objCnn, showOnlyNotExpire, showNotActivated, showDeleted)
        For i = 0 To dtData.Rows.Count - 1
            rNew = dtPromoData.NewRow()
            If IsDBNull(dtData.Rows(i)("PromotionPriceName")) Then
                dtData.Rows(i)("PromotionPriceName") = ""
            End If
            rNew("PromotionName") = Trim(dtData.Rows(i)("PromotionPriceName"))
            rNew("PromotionID") = dtData.Rows(i)("PriceGroupID")
            dtPromoData.Rows.Add(rNew)
        Next i
        chkbSelectPromotion.DataSource = dtPromoData
        chkbSelectPromotion.DataValueField = "PromotionID"
        chkbSelectPromotion.DataTextField = "PromotionName"
        chkbSelectPromotion.DataBind()
        
        'Try To Check the last select value
        If SelPromotionIDList.Value <> "" Then
            selPromoID = Split(SelPromotionIDList.Value, ",")
            For i = 0 To selPromoID.Length - 1
                For j = 0 To chkbSelectPromotion.Items.Count - 1
                    If chkbSelectPromotion.Items(j).Value = Trim(selPromoID(i)) Then
                        chkbSelectPromotion.Items(j).Selected = True
                        Exit For
                    End If
                Next j
            Next i
        End If
               
    End Sub

    Sub InitialDisplayPromotionTypeInCombo(dtLangData2 As DataTable, langText As String)
        cboDisplayPromotionType.Items.Clear()
        cboDisplayPromotionType.Items.Add(BackOfficeReport.GetLanguageText(dtLangData2, 18, langText, "Only Enable Promotion"))
        cboDisplayPromotionType.Items.Add(BackOfficeReport.GetLanguageText(dtLangData2, 19, langText, "Include Expired Promotion"))
        cboDisplayPromotionType.Items.Add(BackOfficeReport.GetLanguageText(dtLangData2, 20, langText, "All Promotion (Include Deleted Promotion)"))
    End Sub
    
    Sub CheckAllPromotion(sender As Object, e As System.EventArgs)
        Dim i As Integer
        For i = 0 To chkbSelectPromotion.Items.Count - 1
            chkbSelectPromotion.Items(i).Selected = chkSelAllPromotion.Checked
        Next i
    End Sub
    
    Protected Sub cboDisplayPromotionType_SelectedIndexChanged(sender As Object, e As EventArgs)
        Select Case cboDisplayPromotionType.SelectedIndex
            Case DISPLAYPROMOTIONINDEX_INCLUDENOTACTIVED
                ListPromotionData(False, True, False)
            Case DISPLAYPROMOTIONINDEX_INCLUDEDELETED
                ListPromotionData(False, True, True)
            Case Else
                ListPromotionData(True, False, False)
        End Select
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
            Next
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

            tdMasterShop.Visible = True
            tdShopInfo.Visible = True
        Else
            chklMasterShop.Items.Clear()
            ShowMasterShop.Visible = False
            ShowShopInfoList.Visible = False
            ShowShopInfoCombo.Visible = True
            
            tdMasterShop.Visible = False
            tdShopInfo.Visible = False
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
    
    Sub ExportData(Source As Object, E As EventArgs)
        Dim FileName As String = "PromotionData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
        Dim OutputText As String = ""
        Dim CSSFile As String = Replace(UCase(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))), "REPORTS", "") & "StyleSheet\admin.css"
        Util.ExportData(Session("ReportResult"), FileName, CSSFile, GlobalParam.ExportCharSet, -1)
    End Sub
     
    Sub Page_UnLoad()
        objCnn.Close()
    End Sub
   
    Protected Sub chkDisplaySelectPromotion_CheckedChanged(sender As Object, e As EventArgs)
        pnlDisplayPromotion.Visible = chkDisplaySelectPromotion.Checked
    End Sub
</script>
</body>
</html>
