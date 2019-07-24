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
<title>Member's Redeem Product</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script language="JavaScript" src="../StyleSheet/webscript.js"></script> 

        <script type="text/javascript">

         //   jQuery(document).ready(function ($) {           
           //     $('#chkAllProduct').live('click', function () {
             //       $("#chkbProduct INPUT[type='checkbox']").attr('checked', $(this).is(':checked') ? 'checked' : '');
//                });

  //          });


    </script>



    <style type="text/css">
        .auto-style2 {
            width: 479px;
        }
        .auto-style3 {
            width: 137px;
        }
        </style>
</head>
<body>
<div id="showPage" visible="true" runat="server">

<form id="mainForm" runat="server">
<input type="hidden" id="AllShopIDList" runat="server" />
<input type="hidden" id="SelMemberGroupIDList" runat="server" />
<input type="hidden" id="SelShopIDList" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Redeem Product Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
<table style="height: 100px; width: 860px">
    <tr>
        <td valign="Top" class="auto-style3">
            <table id="tShowShop" runat="server">
                <tr>
                    <td><asp:DropDownList ID="cboReportViewType" runat="server"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td><asp:DropDownList ID="cboShopName" runat="server"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3"><asp:Label ID="lblSelectMemberGroup" runat="server" Text="Select Member Group : " CssClass="text" ></asp:Label>
                    </td>                   
                </tr>
                <tr id="ShowShop" runat="server">
                   <td colspan="3"><div id="pnlMemberGroup" style="border-width:1px;border-style:solid;height:100px;width:280px;overflow:auto" >                           
                        <asp:CheckBoxList ID="chkbMemberGroup" runat="server" Width="250px" Height="16px" ></asp:CheckBoxList>
                    </div></td>
                </tr>
            </table>
        </td>
        <td id="SelectDate" class="auto-style2">
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
    	    	    <td><asp:radiobutton ID="optYearlyDate" GroupName="ReportSelectDateGroup" runat="server" /></td>
	    	        <td><synature:date id="YearDate" runat="server" /></td>
    		    </tr>
	    	    <tr>
		        <td><asp:radiobutton ID="optRangeDate" GroupName="ReportSelectDateGroup" runat="server" /></td>
		        <td><synature:date id="CurrentDate" runat="server" /></td>
    		    <td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
	    	    <td><synature:date id="ToDate" runat="server" /></td>
	            </tr>
                <tr>
		            <td>&nbsp;</td><td colspan="3" class="text"><asp:button ID="SubmitForm" Font-Size="8" Height="25" Width="120" OnClick="DoSearch" runat="server" /></td>
	            </tr>
            </table>
        </td>
    </tr>   
</table>
</div>	
</td>
</tr>
    
<div id="showResults" visible="false" runat="server" bgcolor="white">
<table style="height: 50px; width: 100%" bgcolor="white">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr>
</table>
<span id="MyTable"> 
<table width="100%" bgcolor="white" >
<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>
<span id="startTable" runat="server"></span>
    	<span id="TableHeaderText" runat="server"></span>
		<div id="ResultText" runat="server"></div>
</td></tr>
</table></span>
<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table>
</div>
</form>
</div>

<table style="width:100%;" bgcolor="white">
     <tr>
        <td>&nbsp;</td>
    </tr>
</table>

<div id="errorMsg" class="boldText" runat="server" />

<table style ="width:100%" bgcolor="white">
        <tr><td colspan="9999" height="30">&nbsp;</td></tr>
    <tr><td height="1" colspan="9999" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
    <tr>
	    <td height="50" colspan="9999" background="../images/footerbg2000.gif">&nbsp;</td>
    </tr>
    <tr><td height="1" colspan="9999" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
</table>

<script language="VB" runat="server">

    Dim objCnn As New MySqlConnection()
    Dim getCnn As New CDBUtil()
    Dim Util As New UtilityFunction()
    Dim FormatObject As New FormatClass()
    Dim getPageText As New DefaultText()
    Dim getInfo As New CCategory()
    Dim reports As New POSBackOfficeReport.BackOfficeReport

    Dim DateTimeUtil As New MyDateTime()
    Dim getProp As New CPreferences()
    Dim objDB As New CDBUtil()
    Dim FormatDocNumber As New FormatText()
    Dim InvC As CultureInfo = CultureInfo.InvariantCulture
    Dim SaleReportPageID As Integer = 6
    Dim saleByProductPageID As Integer = 105
    Dim redeemProductPageID As Integer = 107

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Report_Sale_New") Then
		
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

                Dim i As Integer
                Dim CultureString As String = Util.GetCultureByLangID(Session("LangID"), objCnn)
                Dim PageName As String = System.IO.Path.GetFileName(Request.ServerVariables("SCRIPT_NAME"))
                Dim LangListText As String = ""
                Dim LangListData As New DataTable
                Dim LangData As DataTable = getProp.GetLang(LangListText, LangListData, PageName & "?ID" & Request.QueryString("ID") & "&Order=" + Request.QueryString("Order") & "&GroupID=" & Request.QueryString("GroupID"), redeemProductPageID, 1, -1, Request, objCnn)
                Dim LangText As String = "lang" + Session("LangID").ToString
                Dim strTemp As String

                For z = 0 To LangData.Rows.Count - 1
                    Dim TestLabel = Util.FindControlRecursive(mainForm, "LangText" & z)
                    Try
                        TestLabel.Text = LangData.Rows(z)(LangText)
                    Catch ex As Exception
                    End Try
                Next
                LangList.Text = LangListText
		
                Dim LangData2 As DataTable = getProp.GetLangData(SaleReportPageID, 2, -1, Request)
                Dim saleByProductLangData As DataTable = getProp.GetLangData(saleByProductPageID, 2, -1, Request)
                Dim dtRedeemProductLangData As DataTable = getProp.GetLangData(redeemProductPageID, 2, -1, Request)
                Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
                If LangDefault.Rows.Count >= 2 Then
                    PrintText.Text = LangDefault.Rows(0)(LangText)
                    Export.Text = LangDefault.Rows(1)(LangText)
                End If
                               
                Dim HeaderString As String = ""
                TableHeaderText.InnerHtml = HeaderString
                                
                SubmitForm.Text = LangDefault.Rows(3)(LangText)
                DocumentToDateParam.InnerHtml = LangDefault.Rows(22)(LangText)
		
                lblSelectMemberGroup.Text = BackOfficeReport.GetLanguageText(dtRedeemProductLangData, 1, LangText, "Member Group")
                  
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
		
                ResultText.InnerHtml = ""
                ResultSearchText.InnerHtml = ""
                CreateReportDate.Text = ""
                errorMsg.InnerHtml = ""
                
                ShowPrint.Visible = False
		
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
                End If
                If Page.IsPostBack And Request.Form("YearDate_Year") = "" Then Session("YearDate_Year") = 0
                YearDate.SelectedYear = Session("YearDate_Year")

                If Not Page.IsPostBack Then
                    optDailyDate.Checked = True
                End If
		
                If Not Page.IsPostBack Then
                    'Load MemberGroup
                    Dim dtMemberGroup As DataTable
                    Dim lstMemberGroup As ListItem
                    dtMemberGroup = POSBackOfficeReport.ReportShareSQL.ListMemberGroup(objDB, objCnn)
                    chkbMemberGroup.Items.Clear()
                    
                    For i = 0 To dtMemberGroup.Rows.Count - 1
                        lstMemberGroup = New ListItem
                        lstMemberGroup.Text = dtMemberGroup.Rows(i)("MemberGroupCode") & " : " & dtMemberGroup.Rows(i)("MemberGroupName")
                        lstMemberGroup.Value = dtMemberGroup.Rows(i)("MemberGroupID")
                        lstMemberGroup.Selected = True
                        chkbMemberGroup.Items.Add(lstMemberGroup)
                    Next i
                    
                    'Load Shop
                    AllShopIDList.Value = ""
                    Dim dtShopData As DataTable = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), objCnn)
                    Dim lstShopName As ListItem
                    strTemp = ""
                    cboShopName.Items.Clear()
                    'All Shop if there is more than 1 shop
                    If dtShopData.Rows.Count > 1 Then
                        lstShopName = New ListItem
                        lstShopName.Text = "------- All Shop -------"
                        lstShopName.Value = 0
                        cboShopName.Items.Add(lstShopName)
                    End If
                    For i = 0 To dtShopData.Rows.Count - 1
                        strTemp &= dtShopData.Rows(i)("ProductLevelID") & ", "
                        
                        lstShopName = New ListItem
                        lstShopName.Text = dtShopData.Rows(i)("ProductLevelCode") & " : " & dtShopData.Rows(i)("ProductLevelName")
                        lstShopName.Value = dtShopData.Rows(i)("ProductLevelID")
                        cboShopName.Items.Add(lstShopName)
                    Next i
                    If strTemp = "" Then
                        strTemp = "-1"
                    Else
                        strTemp = Mid(strTemp, 1, Len(strTemp) - 2)
                    End If
                    AllShopIDList.Value = strTemp
                    
                    InitalReportTypeIntoCombo(dtRedeemProductLangData, LangText)
                End If
                
            Catch ex As Exception
                errorMsg.InnerHtml = "No Shop Data" 'ex.Message
                SubmitForm.Enabled = False
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
        Dim SaleLangData As DataTable = getProp.GetLangData(SaleReportPageID, 2, -1, Request)
        Dim dtRedeemProductLangData As DataTable = getProp.GetLangData(redeemProductPageID, 2, -1, Request)
        
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
        Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
	
        Dim DateFromValue As String = ""
        Dim DateToValue As String = ""
        Dim DailyDateValue As String = ""
        Dim InvC As CultureInfo = CultureInfo.InvariantCulture
        
        Dim StartDate, EndDate As String
        Dim viewReportBy As POSBackOfficeReport.ViewSaleReportBy
        Dim StartMonthValue, StartYearValue, EndMonthValue, EndYearValue As Integer
        Dim outputString As String = ""
        Dim grandTotal As Double = 0
        Dim ReportDate As String
        Dim i As Integer
        Dim ReportType As String
        
        ReportType = BackOfficeReport.GetLanguageText(dtRedeemProductLangData, 6, LangText, "Redeem Product Report")
        ReportDate = ""
        StartDate = ""
        EndDate = ""
        If optMonthlyDate.Checked = True Then
            viewReportBy = ViewSaleReportBy.ByMonth
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
        ElseIf optRangeDate.Checked = True Then
            viewReportBy = ViewSaleReportBy.ByDateRange
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
                    ReportDate = Format(SDate1, "d MMMM yyyy") + " - " + Format(EDate1, "d MMMM yyyy")
                End If
            Catch ex As Exception
                FoundError = True
            End Try
        ElseIf optDailyDate.Checked = True Then
            viewReportBy = ViewSaleReportBy.ByDay
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
                    Dim SDate2 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
                    ReportDate = DateTimeUtil.FormatDateTime(SDate2, "DateOnly", Session("LangID"), objCnn)
                    ResultSearchText.InnerHtml = ""
                End If
            Catch ex As Exception
                FoundError = True
            End Try
        Else
            viewReportBy = ViewSaleReportBy.ByYear
            DateFromValue = ""
            DateToValue = ""
            DailyDateValue = ""
            Try
                StartYearValue = Request.Form("YearDate_Year")
                EndYearValue = Request.Form("YearDate_Year") + 1

                StartDate = DateTimeUtil.FormatDate(1, 1, StartYearValue)
                EndDate = DateTimeUtil.FormatDate(1, 1, EndYearValue)
                Dim SDate As New Date(StartYearValue, 1, 1)
                ReportDate = DateTimeUtil.FormatDateTime(SDate, "yyyy", Session("LangID"), objCnn)
            Catch ex As Exception
                FoundError = True
            End Try
        End If
        
        If FoundError = False Then
            If LangDefault.Rows.Count >= 3 Then
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(Now(), "DateAndTime", Session("LangID"), objCnn)
            End If
            Dim LangPath As String = Util.GetLangPath(Request.PhysicalApplicationPath)

            'Application.Lock()

            'Select Shop
            SelShopIDList.Value = ""
            If cboShopName.Items(cboShopName.SelectedIndex).Value = 0 Then
                For i = 0 To cboShopName.Items.Count - 1
                    SelShopIDList.Value &= cboShopName.Items(i).Value & ", "
                Next i
                If SelShopIDList.Value <> "" Then
                    SelShopIDList.Value = Mid(SelShopIDList.Value, 1, Len(SelShopIDList.Value) - 2)
                End If
            Else
                SelShopIDList.Value = cboShopName.Items(cboShopName.SelectedIndex).Value
            End If
            
            'Select MemberGroup
            SelMemberGroupIDList.Value = ""
            For i = 0 To chkbMemberGroup.Items.Count - 1
                If chkbMemberGroup.Items(i).Selected = True Then
                    SelMemberGroupIDList.Value &= chkbMemberGroup.Items(i).Value & ", "
                End If
            Next i
            If SelMemberGroupIDList.Value <> "" Then
                SelMemberGroupIDList.Value = Mid(SelMemberGroupIDList.Value, 1, Len(SelMemberGroupIDList.Value) - 2)
            End If
         
            If SelShopIDList.Value = "" Then
                errorMsg.InnerHtml = "Please select shop to view report."
                showResults.Visible = False
                ShowPrint.Visible = False
                Exit Sub
            ElseIf SelMemberGroupIDList.Value = "" Then
                errorMsg.InnerHtml = "Please select member group to view report."
                showResults.Visible = False
                ShowPrint.Visible = False
                Exit Sub
            Else
                errorMsg.InnerHtml = ""
                showResults.Visible = True
                ShowPrint.Visible = True
            End If
            Dim viewType As ViewRedeemProductType
            Select Case cboReportViewType.Items(cboReportViewType.SelectedIndex).Value
                Case 1
                    viewType = ViewRedeemProductType.ListMemberDetailByProductAndDate
                    ReportType &= " " & BackOfficeReport.GetLanguageText(dtRedeemProductLangData, 2, LangText, "รายละเอียดตามสินค้าและสมาชิก")
                Case 2
                    viewType = ViewRedeemProductType.SummaryByMemberByProduct
                    ReportType &= " " & BackOfficeReport.GetLanguageText(dtRedeemProductLangData, 3, LangText, "สรุปตามสมาชิก")
                Case 3
                    viewType = ViewRedeemProductType.SummaryByProduct
                    ReportType &= " " & BackOfficeReport.GetLanguageText(dtRedeemProductLangData, 4, LangText, "สรุปตามสินค้า")
                Case Else
                    viewType = ViewRedeemProductType.SummaryByProductPerShop
                    ReportType &= " " & BackOfficeReport.GetLanguageText(dtRedeemProductLangData, 5, LangText, "สรุปตามสินค้าแยกตามร้าน")
            End Select
            
            ResultText.InnerHtml = reports.MemberRedeemProductReport(objCnn, GlobalParam.GrayBGColor, GlobalParam.AdminBGColor, Session("LangID"), _
                                  StartDate, EndDate, SelMemberGroupIDList.Value, SelShopIDList.Value, viewType, LangPath, Session("StaffID"))
        End If
            'Application.UnLock()
        ResultSearchText.InnerHtml = ReportType + " (" + ReportDate + ")"
            
        Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"
    End Sub

    Private Sub InitalReportTypeIntoCombo(dtRedeemProductLang As DataTable, langText As String)
        Dim lstReport As ListItem
        'ReportType
        cboReportViewType.Items.Clear()

        lstReport = New ListItem
        lstReport.Text = BackOfficeReport.GetLanguageText(dtRedeemProductLang, 2, langText, "รายละเอียดตามสินค้าและสมาชิก")
        lstReport.Value = 1
        cboReportViewType.Items.Add(lstReport)
                    
        lstReport = New ListItem
        lstReport.Text = BackOfficeReport.GetLanguageText(dtRedeemProductLang, 3, langText, "สรุปตามสมาชิก")
        lstReport.Value = 2
        cboReportViewType.Items.Add(lstReport)

        lstReport = New ListItem
        lstReport.Text = BackOfficeReport.GetLanguageText(dtRedeemProductLang, 4, langText, "สรุปตามสินค้า")
        lstReport.Value = 3
        cboReportViewType.Items.Add(lstReport)

        lstReport = New ListItem
        lstReport.Text = BackOfficeReport.GetLanguageText(dtRedeemProductLang, 5, langText, "สรุปตามสินค้าแยกตามร้าน")
        lstReport.Value = 4
        cboReportViewType.Items.Add(lstReport)
    End Sub
    
    
    
    
    Sub ExportData(Source As Object, E As EventArgs)
	
        Dim FileName As String = "MemberRedeemProductData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
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
