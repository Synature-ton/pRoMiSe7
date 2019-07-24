<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="CostingClass.pRoMiSeCosting" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="POSBackOfficeReport" %>
<%@Import Namespace="QAReports" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<html>
<head>
<title>Stock Card Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="../StyleSheet/webscript.js"></script> 
</head>
<body>

<div id="ShowContent" visible="false" runat="server">
<form id="mainForm" runat="server">
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
<table border="0">
<span id="showShop" runat="server">
<tr>
	<td><span id="SelectShop" class="text" runat="server"></span></td>
	<td><span id="ShopText" runat="server"></span></td>
    <td><asp:radiobutton ID="Radio_1" GroupName="Group1" Enabled="True" runat="server" /></td>
	<td colspan="3"><synature:date id="MonthYearDate" runat="server" /></td>
</tr>
<tr>
	<td></td>
	<td><span id="GroupString" runat="server"></span></td>
    <td><asp:radiobutton ID="Radio_2" GroupName="Group1" Enabled="True" runat="server" /></td>
    <td><synature:date id="CurrentDate" runat="server" /></td>
    <td>to</td>
    <td><synature:date id="ToDate" runat="server" /></td>

</tr>
<tr>
	<td></td>
	<td><asp:dropdownlist ID="OrderParam" Width="250" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
     <td></td>
     <td colspan="3"><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" />&nbsp;&nbsp;<asp:CheckBox ID="DisplayOnly" Checked="false" Text="Display only materials that have movement" CssClass="text" Visible="True" runat="server" /></td>
</tr>
</span>
</table>
</div>
<br>
<table width="100%">

<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr>
</table>
<span id="MyTable">
<table width="100%">
<tr><td align="left"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>

<span id="myTable2" visible="false" runat="server">
<span id="startTable" runat="server"></span>
	<span id="headerTextString" runat="server"></span>
	
	<div id="ResultText" runat="server"></div>
</table>
</span></td></tr>
</table></span>
<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
<span id="ResultString" runat="server"></span>
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
Dim getInfo As New CCategory()
Dim getPageText As New DefaultText()
Dim objDB As New CDBUtil()
Dim DateTimeUtil As New MyDateTime()
Dim getReport As New StReports()
Dim CostInfo As New CostClass()
    Dim getProp As New CPreferences()
    Dim bolUseAvgCostForAllDocumentType As Boolean = True
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer  = 998

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("QAVarianceReport") Then
		
            Try
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true;" & GetPostBackEventReference(SubmitForm).ToString
                objCnn = getCnn.EstablishConnection()
                ShowContent.Visible = True
			
                startTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
			
                Dim z As Integer
                If Not Request.QueryString("ToLangID") Is Nothing Then
                    If IsNumeric(Request.QueryString("ToLangID")) Then
                        Session("LangID") = Request.QueryString("ToLangID")
                    End If
                End If
	                
                bolUseAvgCostForAllDocumentType = POSBackOfficeReport.ReportShareSQL.BackOfficeReport_QA_UseAvgCostForAllColumn(objDB, objCnn)
                
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
			
                LangText0.Text = "Stock Card Report"
			
                MonthYearDate.YearType = GlobalParam.YearType
                MonthYearDate.FormName = "MonthYearDate"
                MonthYearDate.StartYear = GlobalParam.StartYear
                MonthYearDate.EndYear = GlobalParam.EndYear
                MonthYearDate.LangID = Session("LangID")
                MonthYearDate.ShowDay = False
                MonthYearDate.Lang_Data = LangDefault
                MonthYearDate.Culture = CultureString
			
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
			
                OrderParam.Items(0).Text = "Order By Group -> Material Code"
                OrderParam.Items(0).Value = "mg.MaterialGroupCode,a.MaterialCode"
                OrderParam.Items(1).Text = "Order By Group -> Material Name"
                OrderParam.Items(1).Value = "mg.MaterialGroupCode,a.MaterialName"
                OrderParam.Items(2).Text = "Order By Material Code"
                OrderParam.Items(2).Value = "a.MaterialCode"
                OrderParam.Items(3).Text = "Order By Material Name"
                OrderParam.Items(3).Value = "a.MaterialName"
			
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
			
                If Not Page.IsPostBack Then
                    Radio_1.Checked = True
                End If
			
                Dim ShopIDValue As String = "0"
                If IsNumeric(Request.Form("ShopID")) Then
                    ShopIDValue = Request.Form("ShopID").ToString
                ElseIf IsNumeric(Request.QueryString("ShopID")) Then
                    ShopIDValue = Request.QueryString("ShopID").ToString
                End If
			
                Dim i As Integer
                Dim outputString, FormSelected As String
			
                Dim ShopData As DataTable = getInfo.GetProductLevel(-99, objCnn)
                If ShopData.Rows.Count > 0 Then

                    outputString = "<select name=""ShopID"" style=""width:250px"">"
                    For i = 0 To ShopData.Rows.Count - 1
                        If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        outputString += "<option value=""" & ShopData.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & ShopData.Rows(i)("ProductLevelName")
                    Next
                    outputString += "</select>"
                    ShopText.InnerHtml = outputString
                    showShop.Visible = True
                Else
                    showShop.Visible = False
                End If
			
                Dim MaterialGroup As DataTable = getInfo.GetMaterialGroup(0, 0, objCnn)
                Dim GroupStringValue As String = ""
                If Trim(Request.Form("MaterialGroup")) <> "" Then
                    GroupStringValue = Request.Form("MaterialGroup").ToString
                ElseIf Trim(Request.QueryString("MaterialGroup")) <> "" Then
                    GroupStringValue = Request.QueryString("MaterialGroup").ToString
                End If
                outputString = "<select name=""MaterialGroup"" style=""width:250px"">"
                If GroupStringValue = "" Then
                    FormSelected = "selected"
                Else
                    FormSelected = ""
                End If
                outputString += "<option value="""" " & FormSelected & ">" & "-- All Group--"
                For i = 0 To MaterialGroup.Rows.Count - 1
                    If GroupStringValue = MaterialGroup.Rows(i)("MaterialGroupCode") Then
                        FormSelected = "selected"
                    Else
                        FormSelected = ""
                    End If
                    outputString += "<option value=""" & MaterialGroup.Rows(i)("MaterialGroupCode") & """ " & FormSelected & ">" & MaterialGroup.Rows(i)("MaterialGroupName")
                Next
                outputString += "</select>"
                GroupString.InnerHtml = outputString
				
            Catch ex As Exception
                errorMsg.InnerHtml = ex.Message
            End Try
	  
        Else
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
        Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
	
        myTable2.Visible = False

        'Try
        Dim InvC As CultureInfo = CultureInfo.InvariantCulture
        Dim StartDate, EndDate As String
        Dim StartMonthValue, StartYearValue, EndMonthValue, EndYearValue As Integer
        Dim ReportDate As String
		
        Dim SelMonth As Integer = 0
        Dim SelYear As Integer = 0
        If IsNumeric(Request.Form("MonthYearDate_Month")) Then SelMonth = Request.Form("MonthYearDate_Month")
        If IsNumeric(Request.Form("MonthYearDate_Year")) Then SelYear = Request.Form("MonthYearDate_Year")
        Dim BeginningDay As Integer = 0
        Dim BeginningMonth As Integer = 0
        Dim BeginningYear As Integer = 0
        Dim StartDateForMovement, BeginStartDate, BeginEndDate As String
        Dim ReportType As Integer
        
        StartDate = ""
        EndDate = ""
        ReportDate = ""
        
        If Radio_1.Checked = True Then
            ReportType = 1
            If SelMonth = 0 Or SelYear = 0 Then
                FoundError = True
            Else
                Dim SDate As New Date(Request.Form("MonthYearDate_Year"), Request.Form("MonthYearDate_Month"), 1)
                ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy", Session("LangID"), objCnn)
                If SelMonth = 12 Then
                    StartMonthValue = SelMonth
                    EndMonthValue = 1
                    StartYearValue = SelYear
                    EndYearValue = SelYear + 1
                Else
                    StartMonthValue = SelMonth
                    EndMonthValue = SelMonth + 1
                    StartYearValue = SelYear
                    EndYearValue = SelYear
                End If
                StartDate = DateTimeUtil.FormatDate(1, StartMonthValue, StartYearValue)
                EndDate = DateTimeUtil.FormatDate(1, EndMonthValue, EndYearValue)
                StartDateForMovement = StartDate
            End If
        ElseIf Radio_2.Checked = True Then
            Try
                StartDate = DateTimeUtil.FormatDate(Request.Form("Doc_Day"), Request.Form("Doc_Month"), Request.Form("Doc_Year"))
                Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
                CheckDate = DateAdd("d", 1, CheckDate)
                EndDate = DateTimeUtil.FormatDate(Day(CheckDate), Month(CheckDate), CheckDate.ToString("yyyy", InvC))
                StartDateForMovement = DateTimeUtil.FormatDate(1, Request.Form("Doc_Month"), Request.Form("Doc_Year"))
                SelMonth = Request.Form("Doc_Month")
                SelYear = Request.Form("Doc_Year")
                If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
                    ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
                    FoundError = True
                Else
                    ResultSearchText.InnerHtml = ""
                    Dim SDate1 As New Date(Request.Form("Doc_Year"), Request.Form("Doc_Month"), Request.Form("Doc_Day"))
                    Dim EDate1 As New Date(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"))
                    ReportDate = DateTimeUtil.FormatDateTime(SDate1, "DateOnly", Session("LangID"), objCnn) + " - " + DateTimeUtil.FormatDateTime(EDate1, "DateOnly", Session("LangID"), objCnn)
                    BeginningDay = Request.Form("Doc_Day")
                    BeginningMonth = Request.Form("Doc_Month")
                    BeginningYear = Request.Form("DocTo_Year")
                    BeginStartDate = DateTimeUtil.FormatDate(1, BeginningMonth, BeginningYear)
                    BeginEndDate = StartDate
                End If
                ReportType = 2
            Catch ex As Exception
                FoundError = True
            End Try
        End If
        If FoundError = False Then
            If LangDefault.Rows.Count >= 3 Then
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(Now(), "DateAndTime", Session("LangID"), objCnn)
            End If
            ShowPrint.Visible = True
            myTable2.Visible = True
            Dim TestTime, Result As String
            Dim dtTable, groupData, groupDataL As DataTable
            Dim displayTable As New DataTable()
		
            Dim MGroupData As String = ""
            If Trim(Request.Form("MaterialGroup")) <> "" Then
                MGroupData = "'" & Replace(Request.Form("MaterialGroup"), "'", "''") & "'"
            End If
		
            'Application.Lock()
            dtTable = New DataTable
            groupData = New DataTable
            groupDataL = New DataTable
            Result = StockCardReport(MGroupData, "", dtTable, groupData, groupDataL, Request.Form("ShopID"), SelMonth, SelYear, OrderParam.SelectedItem.Value, StartDate, EndDate, ReportType, BeginningDay, BeginningMonth, BeginningYear, objCnn)
            'Application.UnLock()
		
            ResultSearchText.InnerHtml = "Variance Report (Show Stock Movement) " + " (" + ReportDate + ")"
            
            Dim i As Integer
		
            Dim totalSale As Double = 0
            Dim totalCost As Double = 0
            Dim deptCost As Double = 0
            Dim groupCost As Double = 0


            Dim totalStandardCost As Double = 0
            Dim AmountDiff As Double = 0
            Dim StdUse As Double = 0
            Dim TotalUse As Double = 0
            Dim SubTotalUse As Double = 0
            Dim SubTotalPrice As Double = 0
            Dim TotalPrice As Double = 0
            Dim BeginningSum As Double = 0
            Dim EndingSum As Double = 0
            Dim TotalSum As Double = 0
            Dim ColumnSum(groupData.Rows.Count) As Double
            Dim ColumnSaleSum(groupDataL.Rows.Count) As Double
            Dim ShowGroup As Boolean = False
            If Trim(Request.Form("MaterialGroup")) = "" And (OrderParam.SelectedIndex = 0 Or OrderParam.SelectedIndex = 1) Then
                ShowGroup = True
            End If
            Dim BeginningSumGroup As Double = 0
            Dim EndingSumGroup As Double = 0
            Dim TotalSumGroup As Double = 0
            Dim ColumnSumGroup(groupData.Rows.Count) As Double
            Dim ColumnSaleSumGroup(groupDataL.Rows.Count) As Double
            Dim DummyGroupCode As String = ""
            Dim DummyGroupName As String = ""
            Dim ShowGroupSummary As Boolean
		
            Dim LineBeginningSumGroup As Double = 0
            Dim LineEndingSumGroup As Double = 0
            Dim LineTotalSumGroup As Double = 0
            Dim LineColumnSumGroup(groupData.Rows.Count) As Double
            Dim LineColumnSaleSumGroup(groupDataL.Rows.Count) As Double
		
            Dim DLineBeginningSumGroup As Double = 0
            Dim DLineEndingSumGroup As Double = 0
            Dim DLineTotalSumGroup As Double = 0
            Dim DLineColumnSumGroup(groupData.Rows.Count) As Double
            Dim DLineColumnSaleSumGroup(groupDataL.Rows.Count) As Double
            Dim OString As String
            Dim noCol As Integer
            Dim BSumText As String = ""
            Dim bolHasBegining As Boolean
            Dim HeaderString As String = "<tr>"
        
            If ShowGroup = True Then
                HeaderString += "<td rowspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Code" + "</td>"
                HeaderString += "<td rowspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Group Name" + "</td>"
            End If
            HeaderString += "<td rowspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Code" + "</td>"
            HeaderString += "<td rowspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Name" + "</td>"
            HeaderString += "<td rowspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Cost" + "</td>"
            HeaderString += "<td rowspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Unit" + "</td>"

            noCol = 1
            HeaderString += "<td colspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "+Beginning" + "</td>"
            For i = 0 To groupData.Rows.Count - 1
                HeaderString += "<td colspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + groupData.Rows(i)("GroupHeader") + "<br>Amount</td>"
                noCol += 1
            Next
            noCol += 2
            HeaderString += "<td colspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Onhand" + "</td>"
            HeaderString += "<td colspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Ending" + "</td>"

            For i = 0 To groupDataL.Rows.Count - 1
                HeaderString += "<td  colspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + groupDataL.Rows(i)("GroupHeader") + "<br>Amount</td>"
                noCol += 1
            Next
            noCol += 1
            HeaderString += "<td colspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Actual" + "</td>"
            
            HeaderString += "<td rowspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "%<br>Variance" + "<br></td>"
            HeaderString += "<td rowspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Compare<br>Standard" + "<br></td>"
            HeaderString += "</tr>"
            For i = 1 To noCol
                HeaderString += "<td align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Qty" + "</td>"
                HeaderString += "<td align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Amount" + "</td>"
            Next
            HeaderString += "<tr>"
		
            HeaderString += "</tr>"

            headerTextString.InnerHtml = HeaderString
		
            Dim strTemp As String
            Dim groupString, PriceString, QtyString, StdString As String
            Dim resultString As StringBuilder = New StringBuilder
            Dim showData As Boolean
            Dim j As Integer
            Dim UnitPrice As String
            Dim dclAmount, dclPrice As Decimal
            Dim UnitInfo As DataTable
            Dim CostPerUnit As Double
            Dim UnitText As String
            Dim UnitRatioVal As Double = 1
            Dim ActualQty, GroupActualQty, TotalActualQty As Double
            Dim StdQty, GroupStdQty, TotalStdQty As Double
            Dim VarianceQty As Double
            Dim StatGBColor As String = "#ffe4e1"
            Dim GroupSumActual, TotalSumActual, GroupSumStd, TotalSumStd As Double
            Dim LineSumActual, LineSumStd As Double
            Dim SumVariance As Double
            Dim CheckGroupVal As Double
            Dim noShowMaterialInGroup As Integer
            Dim strQtyFormat, strCostFormat, strCalCostFormat As String

            strQtyFormat = "##,##0.00##;(##,##0.00##)"
            strCostFormat = "##,##0.0000;(##,##0.0000)"
            strCalCostFormat = "0.0000"
            
            'Display Only Material Has Movement ---> Check MovementCount Field and Remove Data From DataTable
            If DisplayOnly.Checked = True Then
                For i = 0 To dtTable.Rows.Count - 1
                    If i = dtTable.Rows.Count Then
                        Exit For
                    End If
                
                    showData = True
                    If IsDBNull(dtTable.Rows(i)("MovementCount")) Then
                        showData = False
                    ElseIf dtTable.Rows(i)("MovementCount") = 0 Then
                        showData = False
                    End If
                    If showData = False Then
                        dtTable.Rows.RemoveAt(i)
                        i -= 1
                    End If
    
                Next i
            End If
            
            For i = 0 To dtTable.Rows.Count - 1
                Dim outputString As StringBuilder = New StringBuilder
                showData = False
                SubTotalUse = 0
                SubTotalPrice = 0
                ActualQty = 0
                StdQty = 0
			
                noShowMaterialInGroup = 0
                DLineBeginningSumGroup = 0
                DLineEndingSumGroup = 0
                DLineTotalSumGroup = 0
                For j = 0 To groupData.Rows.Count - 1
                    DLineColumnSumGroup(j) = 0
                Next
                For j = 0 To groupDataL.Rows.Count - 1
                    DLineColumnSaleSumGroup(j) = 0
                Next
                outputString = outputString.Append("<tr>")
                If ShowGroup = True Then
                    outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MaterialGroupCode") + "</td>")
                    outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MaterialGroupName") + "</td>")
                End If
                outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MaterialCode") + "</td>")
                outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MaterialName") + "</td>")
                CostPerUnit = 0
                If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                    '**********************************************************************************
                    'TotalAmount = 0 AND TotalPrice = 0 ---> Reset TotalPrice = BeginPricePerUnit, TotalAmount = 1
                    If dtTable.Rows(i)("TotalAmount") = 0 And dtTable.Rows(i)("TotalPrice") = 0 Then
                        If Not IsDBNull(dtTable.Rows(i)("BeginningPricePerUnit")) Then
                            dtTable.Rows(i)("TotalPrice") = dtTable.Rows(i)("BeginningPricePerUnit")
                            dtTable.Rows(i)("TotalAmount") = 1
                        End If
                    End If
                    '**********************************************************************************
                    If dtTable.Rows(i)("TotalAmount") > 0 Then
                        CostPerUnit = dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")
                    End If
                End If
                UnitRatioVal = 1
                If Not IsDBNull(dtTable.Rows(i)("UnitSmallName")) Then
                    UnitText = dtTable.Rows(i)("UnitSmallName")
                Else
                    UnitText = "-"
                End If
                UnitInfo = getInfo.GetUnitSetting(dtTable.Rows(i)("MaterialID"), dtTable.Rows(i)("UnitSmallID"), objCnn)
                If UnitInfo.Rows.Count <> 0 Then
                    UnitRatioVal = UnitInfo.Rows(0)("UnitSmallRatio")
                    UnitText = UnitInfo.Rows(0)("UnitLargeName")
                End If
                
                'Insert Unit Cost/ Unit
                strTemp = "<td class=""smallText"" align=""right"" >" & _
                           "<br><a  class=""smallText"" href=""JavaScript: newWindow = window.open( '../Inventory/product_stdcost.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString & _
                            "&SelMonth=" & SelMonth.ToString & "&SelYear=" & SelYear.ToString & "&ProductLevelID=" & Request.Form("ShopID").ToString & _
                            "', '', 'width=900,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & _
                          Format(CostPerUnit * UnitRatioVal, strCostFormat) & "</a></td>"
                outputString = outputString.Append(strTemp)

                'Insert Unit Name
                strTemp = "<td class=""smallText"" align=""left"" >" & UnitText & "</td>"
                outputString = outputString.Append(strTemp)
			
                '----- Beginning Stock ---------------
                If Not IsDBNull(dtTable.Rows(i)("NetSmallAmount0")) Then
                    'If dtTable.Rows(i)("NetSmallAmount0") > 0 Then
                    'Amount
                    dclAmount = dtTable.Rows(i)("NetSmallAmount0") / UnitRatioVal
                            
                    SubTotalUse += dtTable.Rows(i)("NetSmallAmount0")
                    If dtTable.Rows(i)("NetSmallAmount0") <> 0 Then
                        showData = True
                    End If
                Else
                    dclAmount = 0
                End If
                
                strTemp = "<td class=""smallText"" align=""right"" >" & Format(dclAmount, strQtyFormat) & "</td>"
                outputString = outputString.Append(strTemp)
						
                bolHasBegining = True
                If Not IsDBNull(dtTable.Rows(i)("NetSmallAmount0")) And Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                    If dtTable.Rows(i)("TotalPrice") > 0 And dtTable.Rows(i)("TotalAmount") > 0 Then
                        'Cost From Beginning Amount * Avg Cost PricePerUnit
                        dclPrice = dtTable.Rows(i)("NetSmallAmount0") * (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount"))
                                               
                        'Using ProductNetPrice For BeginningAmount
                        dclPrice = dtTable.Rows(i)("ProductNetPrice0")
                        
                        SubTotalPrice += Format(dclPrice, strCalCostFormat)
                        BeginningSum += Format(dclPrice, strCalCostFormat)
                        BeginningSumGroup += Format(dclPrice, strCalCostFormat)
                        DLineBeginningSumGroup = Format(dclPrice, strCalCostFormat)
                        'BSumText += "<BR>" + Format(dtTable.Rows(i)("NetSmallAmount0")*(dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount")),"##,##0.000000")
                        showData = True
                        bolHasBegining = True
                    Else
                        dclPrice = 0
                    End If
                Else
                    dclPrice = 0
                End If
                strTemp = "<td class=""smallText"" align=""right"" >" & Format(dclPrice, strCostFormat) & "</td>"
                outputString = outputString.Append(strTemp)

                '------------- End Beginning -------------------
			
                For j = 0 To groupData.Rows.Count - 1
                    UnitPrice = "0"
                    groupString = "NetSmallAmount" + groupData.Rows(j)("DocumentTypeGroupID").ToString
                    PriceString = "ProductNetPrice" + groupData.Rows(j)("DocumentTypeGroupID").ToString
                    QtyString = "TotalAmount" + groupData.Rows(j)("DocumentTypeGroupID").ToString
                    StdString = "CalculateStandardProfitLoss" + groupData.Rows(j)("DocumentTypeGroupID").ToString
				
                    If Not IsDBNull(dtTable.Rows(i)("TotalAmount")) And Not IsDBNull(dtTable.Rows(i)("TotalPrice")) Then
                        If dtTable.Rows(i)("TotalAmount") > 0 Then
                            UnitPrice = Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")), "##,##0.000000")
                        Else
                            UnitPrice = "0"
                        End If
                    Else
                        UnitPrice = "0"
                    End If
                    If Not IsDBNull(dtTable.Rows(i)(groupString)) Then
                        ' For Material Amount
                        strTemp = "<td class=""smallText"" align=""right"" ><a class=""smalltext"" " & _
                                "href=""JavaScript: newWindow = window.open( 'report_material_doc2.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString & _
                                "&UnitPrice=" + UnitPrice + "&DocumentTypeGroupID=" & groupData.Rows(j)("DocumentTypeGroupID").ToString + "&SelMonth=" & SelMonth.ToString & _
                                "&SelYear=" & SelYear.ToString & "&ProductLevelID=" & Request.Form("ShopID").ToString + "&StartDate=" + Replace(StartDate, "'", "\'") & _
                                "&EndDate=" + Replace(EndDate, "'", "\'") + "&ReportDate=" + ReportDate + "', '', 'width=1000,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & _
                                Format(dtTable.Rows(i)(groupString) / UnitRatioVal, strQtyFormat) + "</a></td>"
         
                        SubTotalUse += dtTable.Rows(i)(groupString)
                        If groupData.Rows(j)("ActualCost") = 1 Or groupData.Rows(j)("ActualCost") = 2 Then
                            ActualQty += dtTable.Rows(i)(groupString)
                            GroupActualQty += dtTable.Rows(i)(groupString)
                            TotalActualQty += dtTable.Rows(i)(groupString)
                        End If
                        If groupData.Rows(j)("ActualCost") = 2 Then
                            StdQty += dtTable.Rows(i)(groupString)
                            GroupStdQty += dtTable.Rows(i)(groupString)
                            TotalStdQty += dtTable.Rows(i)(groupString)
                        End If
                        showData = True
                    Else
                        dclAmount = 0
                        strTemp = "<td class=""smallText"" align=""right"" >" & Format(dclAmount, strQtyFormat) & "</td>"
                    End If
                    outputString = outputString.Append(strTemp)
                    ' For Material Cost
                    Dim bolUseAvgCost As Boolean
                    If groupData.Rows(j)("UseAvgCost") = 1 Then
                        bolUseAvgCost = True
                    Else
                        bolUseAvgCost = False
                    End If
                    dclPrice = 0
                    If bolUseAvgCost = False Then
                        If IsDBNull(dtTable.Rows(i)(PriceString)) Then
                            dclPrice = 0
                        Else
                            dclPrice = dtTable.Rows(i)(PriceString)
                        End If
                    Else
                        If Not IsDBNull(dtTable.Rows(i)(QtyString)) And Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                            If dtTable.Rows(i)("TotalAmount") = 0 Then
                                dclPrice = 0
                            Else
                                dclPrice = dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount") * dtTable.Rows(i)(groupString)
                            End If
                        Else
                            dclPrice = 0
                        End If
                    End If

                    If bolUseAvgCostForAllDocumentType = False Then
                        'Check if there is data to be displayed
                        If Not IsDBNull(dtTable.Rows(i)(QtyString)) And Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                            showData = True
                        End If
                        If dclPrice <> 0 Then
                            SubTotalPrice += Format(dclPrice, strCalCostFormat)
                            ColumnSum(j) += Format(dclPrice, strCalCostFormat)
                            ColumnSumGroup(j) += Format(dclPrice, strCalCostFormat)
                            DLineColumnSumGroup(j) = Format(dclPrice, strCalCostFormat)
                        End If
                        strTemp = "<td class=""smallText"" align=""right"" >" & Format(dclPrice, strCostFormat) & "</td>"
                        outputString = outputString.Append(strTemp)
                        
                    Else
                        'Use Old Code --> Use Avg Cost For All DocumentType (No Checking bolUseAvgCost)
                        If Not IsDBNull(dtTable.Rows(i)(QtyString)) And Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                            If dtTable.Rows(i)("TotalAmount") = 0 Then
                                dclPrice = 0
                            Else
                                dclPrice = (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString)
                                
                                SubTotalPrice += Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString), strCalCostFormat)
                                ColumnSum(j) += Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString), strCalCostFormat)
                                ColumnSumGroup(j) += Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString), strCalCostFormat)
                                DLineColumnSumGroup(j) = Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString), strCalCostFormat)
                            End If
                            showData = True
                        Else
                            dclPrice = 0
                        End If
                        strTemp = "<td class=""smallText"" align=""right"" >" & Format(dclPrice, strCostFormat) & "</td>"
                        outputString = outputString.Append(strTemp)
                    End If
                Next
			
                ' On Hand (Summary of All Left Column)
                If Not IsDBNull(SubTotalUse) Then
                    dclAmount = SubTotalUse / UnitRatioVal
                    dclPrice = 0
                    If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                        If dtTable.Rows(i)("TotalAmount") > 0 Then
                            If SubTotalUse > 0 Or (SubTotalUse = 0 And showData = True) Then
                                dclPrice = (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * SubTotalUse

                                SubTotalPrice += Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * SubTotalUse, strCalCostFormat)
                                EndingSum += Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * SubTotalUse, strCalCostFormat)
                                EndingSumGroup += Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * SubTotalUse, strCalCostFormat)
                                DLineEndingSumGroup = Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * SubTotalUse, strCalCostFormat)
                                showData = True
                            End If
                        End If
                    End If
                Else
                    dclAmount = 0
                    dclPrice = 0
                End If
                'Amount
                strTemp = "<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>" & Format(dclAmount, strQtyFormat) & "</td>"
                outputString = outputString.Append(strTemp)
                'Price
                strTemp = "<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>" & Format(dclPrice, strCostFormat) & "</td>"
                outputString = outputString.Append(strTemp)

                For j = 0 To groupDataL.Rows.Count - 1 ' Calculate subTotal including Variance
                    UnitPrice = "0"
                    groupString = "NetSmallAmount" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
                    PriceString = "ProductNetPrice" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
                    QtyString = "TotalAmount" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
                    StdString = "CalculateStandardProfitLoss" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
				
                    If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                        If dtTable.Rows(i)("TotalAmount") > 0 Then
                            UnitPrice = Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")), "##,##0.000000")
                        End If
                    End If
				
                    If Not IsDBNull(dtTable.Rows(i)(groupString)) Then
                        SubTotalUse += dtTable.Rows(i)(groupString)
                        If groupDataL.Rows(j)("ActualCost") = 1 Or groupDataL.Rows(j)("ActualCost") = 2 Then
                            ActualQty += dtTable.Rows(i)(groupString)
                            GroupActualQty += dtTable.Rows(i)(groupString)
                            TotalActualQty += dtTable.Rows(i)(groupString)
                        End If
                        If groupDataL.Rows(j)("ActualCost") = 2 Then
                            StdQty += dtTable.Rows(i)(groupString)
                            GroupStdQty += dtTable.Rows(i)(groupString)
                            TotalStdQty += dtTable.Rows(i)(groupString)
                        End If
                        showData = True
                    End If
				
                    If Not IsDBNull(dtTable.Rows(i)(StdString)) Then
                        If Not IsDBNull(dtTable.Rows(i)(QtyString)) And Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull("TotalAmount") Then
                            If dtTable.Rows(i)("TotalAmount") <> 0 Then
                                SubTotalPrice += Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString), strCalCostFormat)
                                ColumnSaleSum(j) += Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString), strCalCostFormat)
                                ColumnSaleSumGroup(j) += Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString), strCalCostFormat)
                                DLineColumnSaleSumGroup(j) = Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString), strCalCostFormat)
                                showData = True
                            End If
                        End If
                    End If
                Next
			
                'Ending Amount
                If Not IsDBNull(SubTotalUse) Then
                    strTemp = "<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """><a  class=""smallText"" " & _
                            "href=""JavaScript: newWindow = window.open( 'report_material_movement2.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString & _
                            "&SelMonth=" & SelMonth.ToString & "&SelYear=" & SelYear.ToString & "&ProductLevelID=" & Request.Form("ShopID").ToString + "&StartDate=" & _
                            Replace(StartDateForMovement, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "&ReportDate=" + ReportDate & _
                            "', '', 'width=1000,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & _
                            Format(SubTotalUse / UnitRatioVal, strQtyFormat) + "</a></td>"
                    outputString = outputString.Append(strTemp)
                                        
                    If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                        If dtTable.Rows(i)("TotalAmount") > 0 Then
                            If SubTotalUse > 0 Or (SubTotalUse = 0 And showData = True) Then
                                dclPrice = (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * SubTotalUse
                                
                                SubTotalPrice += Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * SubTotalUse, strCalCostFormat)
                                TotalSum += Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * SubTotalUse, strCalCostFormat)
                                TotalSumGroup += Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * SubTotalUse, strCalCostFormat)
                                DLineTotalSumGroup = Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * SubTotalUse, strCalCostFormat)
                                showData = True
                                'objDB.sqlExecute("insert into EndingStock (MaterialID,MaterialCode,MaterialName,UnitSmallAmount,UnitLargeAmount,PricePerUnitSmall,PricePerUnitLarge,UnitName,NetPrice) values (" + dtTable.Rows(i)("MaterialID").ToString + ",'" + dtTable.Rows(i)("MaterialCode") + "','" + dtTable.Rows(i)("MaterialName").ToString + "'," + subTotalUse.ToString + "," + (subTotalUse/UnitRatioVal).ToString + "," + (dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount")).ToString + "," + (CostPerUnit*UnitRatioVal).ToString + "," + ((dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount"))*subTotalUse).ToString + "," + ((CostPerUnit*UnitRatioVal)*(subTotalUse/UnitRatioVal)).ToString + ")", objCnn)
                            Else
                                dclPrice = 0
                            End If
                        Else
                            dclPrice = 0
                        End If
                    Else
                        dclPrice = 0
                    End If
                    strTemp = "<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>" & _
                                Format(dclPrice, strCostFormat) & "</td>"
                    outputString = outputString.Append(strTemp)
                    
                    TotalUse += SubTotalUse
                    TotalPrice += SubTotalPrice
                Else
                    strTemp = "<td></td><td></td>"
                    outputString = outputString.Append(strTemp)
                End If
			    
                'Variance
                VarianceQty = 0
                For j = 0 To groupDataL.Rows.Count - 1 'Display Variance
                    UnitPrice = "0"
                    groupString = "NetSmallAmount" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
                    PriceString = "ProductNetPrice" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
                    QtyString = "TotalAmount" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
                    StdString = "CalculateStandardProfitLoss" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
				
                    If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                        If dtTable.Rows(i)("TotalAmount") > 0 Then
                            UnitPrice = Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")), "##,##0.000000")
                        End If
                    End If
				
                    If Not IsDBNull(dtTable.Rows(i)(groupString)) Then
                        strTemp = "<td class=""smallText"" align=""right"" ><a class=""smalltext"" href=""JavaScript: newWindow = window.open(" & _
                                "'report_material_doc2.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&UnitPrice=" + UnitPrice & _
                                "&DocumentTypeGroupID=" & groupDataL.Rows(j)("DocumentTypeGroupID").ToString + "&SelMonth=" & SelMonth.ToString & "&SelYear=" & SelYear.ToString & _
                                "&ProductLevelID=" & Request.Form("ShopID").ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") & _
                                "&ReportDate=" + ReportDate + "', '', 'width=1000,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); " & _
                                "newWindow.focus()"">" + Format(dtTable.Rows(i)(groupString) / UnitRatioVal, strQtyFormat) + "</a></td>"
                        VarianceQty += dtTable.Rows(i)(groupString)
                        showData = True
                    Else
                        dclAmount = 0
                        strTemp = "<td class=""smallText"" align=""right"" >" & Format(dclAmount, strQtyFormat) & "</td>"
                    End If
                    outputString = outputString.Append(strTemp)
				
                    If Not IsDBNull(dtTable.Rows(i)(StdString)) Then
                        If Not IsDBNull(dtTable.Rows(i)(QtyString)) And Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull("TotalAmount") Then
                            If dtTable.Rows(i)("TotalAmount") <> 0 Then
                                strTemp = "<td class=""smallText"" align=""right"" >" & Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString), strCostFormat) & _
                                             "</td>"
                            Else
                                strTemp = "<td></td>"
                            End If
                        Else
                            strTemp = "<td></td>"
                        End If
                    Else
                        strTemp = "<td></td>"
                    End If
                    outputString = outputString.Append(strTemp)
                Next
			                
                strTemp = "<td class=""smallText"" align=""right"" bgColor=""" + StatGBColor + """>" + Format(ActualQty / UnitRatioVal, strQtyFormat) & "</td>"
                outputString = outputString.Append(strTemp)
			
                If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull("TotalAmount") Then
                    If dtTable.Rows(i)("TotalAmount") <> 0 Then
                        dclPrice = (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * ActualQty
                                           
                        GroupSumActual += Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * ActualQty, strCalCostFormat)
                        TotalSumActual += Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * ActualQty, strCalCostFormat)
                        GroupSumStd += Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * StdQty, strCalCostFormat)
                        TotalSumStd += Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * StdQty, strCalCostFormat)
                        LineSumActual = Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * ActualQty, strCalCostFormat)
                        LineSumStd = Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * StdQty, strCalCostFormat)
                    Else
                        dclPrice = 0
                    End If
                Else
                    dclPrice = 0
                End If
                strTemp = "<td class=""smallText"" align=""right"" bgColor=""" + StatGBColor + """>" + Format(dclPrice, strCostFormat) & "</td>"
                outputString = outputString.Append(strTemp)
			
                '% Variance
                If ActualQty <> 0 Then
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + StatGBColor + """>" & _
                                                 Format(Math.Abs(VarianceQty * 100 / ActualQty), strQtyFormat) & "%</td>")
                Else
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + StatGBColor + """>" + "-" + "</td>")
                End If
                'Compare Standard
                If StdQty <> 0 Then
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + StatGBColor + """>" & _
                                                 Format(ActualQty * 100 / StdQty, "##,##0.00") & "%</td>")
                Else
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + StatGBColor + """>" + "-" + "</td>")
                End If
                outputString = outputString.Append("</tr>")
			
                If bolHasBegining = False Then
                    If IsDBNull(dtTable.Rows(i)("MovementCount")) Then
                        showData = False
                    ElseIf dtTable.Rows(i)("MovementCount") = 0 Then
                        showData = False
                    End If
                End If
                
                If (showData = True And DisplayOnly.Checked = True) Or DisplayOnly.Checked = False Then
                    If Trim(dtTable.Rows(i)("MaterialCode")) <> "" Then
                        resultString = resultString.Append(outputString.ToString)
                        noShowMaterialInGroup += 1
                    End If
                End If
			
                CheckGroupVal = BeginningSumGroup

                For j = 0 To groupData.Rows.Count - 1
                    CheckGroupVal += ColumnSumGroup(j)
                Next
                CheckGroupVal += EndingSumGroup
                CheckGroupVal += TotalSumGroup
                For j = 0 To groupDataL.Rows.Count - 1
                    CheckGroupVal += ColumnSaleSumGroup(j)
                Next
                If ShowGroup = True Then
                    ShowGroupSummary = False
                    If Not IsDBNull(dtTable.Rows(i)("MaterialGroupCode")) Then
                        If i = dtTable.Rows.Count - 1 Then
                            ShowGroupSummary = True
                        ElseIf dtTable.Rows(i + 1)("MaterialGroupCode") <> dtTable.Rows(i)("MaterialGroupCode") Then
                            ShowGroupSummary = True
                        End If
                    End If
                    If i = 0 Then
                        ShowGroupSummary = False
                    End If
                    'If CheckGroupVal = 0 Then ShowGroupSummary = False
                    If ShowGroupSummary = True Then
                        Dim outputS As StringBuilder = New StringBuilder
                        outputS = outputS.Append("<tr bgColor=""" + "#eeeeee" + """>")

                        outputS = outputS.Append("<td class=""smallText"" align=""right"" colspan=""6"">Summary for " + dtTable.Rows(i)("MaterialGroupName") + "</td>")

                        outputS = outputS.Append("<td class=""smallText"" align=""right""></td>")
                        outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format(BeginningSumGroup, strCostFormat) + "</td>")
                        For j = 0 To groupData.Rows.Count - 1
                            outputS = outputS.Append("<td class=""smallText"" align=""right""></td>")
                            outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format(ColumnSumGroup(j), strCostFormat) + "</td>")
                            ColumnSumGroup(j) = LineColumnSumGroup(j)
                        Next
                        outputS = outputS.Append("<td class=""smallText"" align=""right""></td>")
                        outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format(EndingSumGroup, strCostFormat) + "</td>")
                        outputS = outputS.Append("<td class=""smallText"" align=""right""></td>")
                        outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format(TotalSumGroup, strCostFormat) + "</td>")
                        SumVariance = 0
                        For j = 0 To groupDataL.Rows.Count - 1
                            outputS = outputS.Append("<td class=""smallText"" align=""right""></td>")
                            outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format(ColumnSaleSumGroup(j), strCostFormat) + "</td>")
                            SumVariance += ColumnSaleSumGroup(j)
                            ColumnSaleSumGroup(j) = 0
                        Next
                        outputS = outputS.Append("<td class=""smallText"" align=""right""></td>")
                        outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format(GroupSumActual, strCostFormat) + "</td>")
					
                        Dim bolOldCode As Boolean = False
                        If bolOldCode = True Then
                            outputS = outputS.Append("<td class=""smallText"" align=""right""></td>")
                            If GroupSumActual - LineSumActual <> 0 Then
                                outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format(Math.Abs((SumVariance) * 100 / (GroupSumActual - LineSumActual)), strCostFormat) + "</td>")
                            Else
                                outputS = outputS.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
                            End If
                            outputS = outputS.Append("<td class=""smallText"" align=""right""></td>")
                            If (GroupSumStd - LineSumStd) <> 0 Then
                                outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format((GroupSumActual - LineSumActual) * 100 / (GroupSumStd - LineSumStd), "##,##0.00") + "%</td>")
                            Else
                                outputS = outputS.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
                            End If
                        Else
                            'outputS = outputS.Append("<td class=""smallText"" align=""right""></td>")
                            If GroupSumActual <> 0 Then
                                outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format(Math.Abs((SumVariance) * 100 / (GroupSumActual)), strCostFormat) + "%</td>")
                            Else
                                outputS = outputS.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
                            End If
					
                            'outputS = outputS.Append("<td class=""smallText"" align=""right""></td>")
                            If (GroupSumStd) <> 0 Then
                                outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format((GroupSumActual) * 100 / (GroupSumStd), "##,##0.00") + "%</td>")
                            Else
                                outputS = outputS.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
                            End If
                        End If
		
                        outputS = outputS.Append("</tr>")
                        BeginningSumGroup = 0
                        EndingSumGroup = 0
                        TotalSumGroup = 0
                        GroupSumActual = 0
                        GroupSumStd = 0
                        OString = outputS.ToString
                        
                        If noShowMaterialInGroup > 0 Then
                            resultString = resultString.Append(outputS.ToString)
                        End If
                        noShowMaterialInGroup = 0
                    End If
                End If
            Next
				
            SumVariance = 0
            resultString = resultString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
            If ShowGroup = True Then
                resultString = resultString.Append("<td class=""smallText"" align=""right"" colspan=""6"">Summary</td>")
            Else
                resultString = resultString.Append("<td class=""smallText"" align=""right"" colspan=""4"">Summary</td>")
            End If
            resultString = resultString.Append("<td class=""smallText"" align=""right""></td>")
            resultString = resultString.Append("<td class=""smallText"" align=""right"">" + Format(BeginningSum, strCostFormat) + "</td>")
            For i = 0 To groupData.Rows.Count - 1
                resultString = resultString.Append("<td class=""smallText"" align=""right""></td>")
                resultString = resultString.Append("<td class=""smallText"" align=""right"">" + Format(ColumnSum(i), strCostFormat) + "</td>")
            Next
            resultString = resultString.Append("<td class=""smallText"" align=""right""></td>")
            resultString = resultString.Append("<td class=""smallText"" align=""right"">" + Format(EndingSum, strCostFormat) + "</td>")
            resultString = resultString.Append("<td class=""smallText"" align=""right""></td>")
            resultString = resultString.Append("<td class=""smallText"" align=""right"">" + Format(TotalSum, strCostFormat) + "</td>")
            For i = 0 To groupDataL.Rows.Count - 1
                resultString = resultString.Append("<td class=""smallText"" align=""right""></td>")
                resultString = resultString.Append("<td class=""smallText"" align=""right"">" + Format(ColumnSaleSum(i), strCostFormat) + "</td>")
                SumVariance += ColumnSaleSum(i)
            Next
		
            resultString = resultString.Append("<td class=""smallText"" align=""right""></td>")
            resultString = resultString.Append("<td class=""smallText"" align=""right"">" + Format(TotalSumActual, strCostFormat) + "</td>")
		
            '            resultString = resultString.Append("<td class=""smallText"" align=""right""></td>")
            If TotalSumActual <> 0 Then
                resultString = resultString.Append("<td class=""smallText"" align=""right"">" + Format(Math.Abs((SumVariance) * 100 / TotalSumActual), "##,##0.00") + "%</td>")
            Else
                resultString = resultString.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
            End If
		
            '            resultString = resultString.Append("<td class=""smallText"" align=""right""></td>")
            If TotalSumStd <> 0 Then
                resultString = resultString.Append("<td class=""smallText"" align=""right"">" + Format(TotalSumActual * 100 / TotalSumStd, "##,##0.00") + "%</td>")
            Else
                resultString = resultString.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
            End If
            resultString = resultString.Append("</tr>")
		
            ResultText.InnerHtml = resultString.ToString
		
            Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & headerTextString.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"
		
            TestTime += "<br>" + DateTimeUtil.CurrentDateTime
            'errorMsg.InnerHtml = BSumText
        End If
        'Catch ex As Exception
        'FoundError = True
        'End Try
    End Sub

    Sub ExportData(Source As Object, E As EventArgs)
        Dim FileName As String = "StockCardData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
        Dim OutputText As String = ""
        Dim CSSFile As String = Replace(UCase(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))), "REPORTS", "") & "StyleSheet\admin.css"
	
        Util.ExportData(Session("ReportResult"), FileName, CSSFile, GlobalParam.ExportCharSet, -1)
    End Sub
	
    Public Function StockCardReport(ByVal GroupCode As String, ByVal DeptCode As String, ByRef GetData As DataTable, ByRef groupData As DataTable, ByRef GroupDataL As DataTable, _
    ByVal ShopID As Integer, ByVal SelMonth As Integer, ByVal SelYear As Integer, ByVal OrderParam As String, ByVal StartDateData As String, ByVal EndDateData As String, _
    ByVal ReportType As Integer, ByVal BeginningDay As Integer, ByVal BeginningMonth As Integer, ByVal BeginningYear As Integer, ByVal objCnn As MySqlConnection) As String
        Dim strSQL As String
        Dim sqlStatement As String
        Dim AdditionalQuery As String = ""

        If Trim(GroupCode) <> "" Then
            AdditionalQuery += " AND mg.MaterialGroupCode IN (" + GroupCode + ")"
        End If
        If Trim(DeptCode) <> "" Then
            AdditionalQuery += " AND md.MaterialDeptCode IN (" + DeptCode + ")"
        End If
        'Dim DateTimeUtil As New GlobalFunctions.MyDateTime
        Dim StartDate, EndDate As String
        Dim BeginStartDate, BeginEndDate As String
        Dim StartMonthValue, StartYearValue, EndMonthValue, EndYearValue As Integer
        If SelMonth = 12 Then
            StartMonthValue = SelMonth
            EndMonthValue = 1
            StartYearValue = SelYear
            EndYearValue = SelYear + 1
        Else
            StartMonthValue = SelMonth
            EndMonthValue = SelMonth + 1
            StartYearValue = SelYear
            EndYearValue = SelYear
        End If
        If ReportType = 1 Then
            StartDate = DateTimeUtil.FormatDate(1, StartMonthValue, StartYearValue)
            EndDate = DateTimeUtil.FormatDate(1, EndMonthValue, EndYearValue)
            BeginStartDate = ""
            BeginEndDate = ""
        Else
            StartDate = StartDateData
            EndDate = EndDateData
            BeginStartDate = DateTimeUtil.FormatDate(1, BeginningMonth, BeginningYear)
            BeginEndDate = StartDate
        End If

        '------- Calculate Material Standard Cost
        CostInfo.MaterialStdCost("DummyMaterialStandardCost_For_Stock", SelMonth, SelYear, ShopID, objCnn)

        If ReportType = 1 Or (ReportType = 2 And BeginningDay = 1) Then
            sqlStatement = "(select 0 AS Ordering, 0 AS DocumentTypeGroupID,'Beginning' AS GroupHeader,ProductID As MaterialID,UnitSmallAmount As NetSmallAmount, " & _
                        "UnitSmallAmount AS TotalAmount,ProductNetPrice, dt.CalculateStandardProfitLoss, 0 As ActualCost " & _
                        " FROM document aa, docdetail bb, documenttype dt where aa.DocumentID=bb.DocumentID AND aa.ShopID=bb.ShopID AND aa.DocumentTypeID=10  AND " & _
                        " aa.DocumentStatus=2 AND aa.DocumentTypeID=dt.DocumentTypeID AND dt.LangID=1 AND dt.ShopID=aa.ProductLevelID AND " & _
                        " aa.ProductLevelID=" + ShopID.ToString + " AND aa.DocumentDate = " + StartDate + ") " & _
                        " UNION " & _
                        "(select d.Ordering, d.DocumentTypeGroupID,d.GroupHeader, ProductID As MaterialID ,sum(e.MovementInStock*b.UnitSmallAmount) As NetSmallAmount, " & _
                        " sum(b.UnitSmallAmount) AS TotalAmount, sum(ProductNetPrice) As ProductNetPrice, " & _
                        " Max(e.CalculateStandardProfitLoss) as CalculateStandardProfitLoss,d.ActualCost " & _
                        "from document a, docdetail b, documentTypeGroupValue c, DocumentTypeGroup d, DocumentType e " & _
                        "where a.DocumentID=b.DocumentID AND a.ShopID=b.ShopID AND a.DocumentTypeID=c.DocumentTypeID AND c.DocumentTypeGroupID = d.DocumentTypeGroupID AND " & _
                        " a.DocumentTypeID=e.DocumentTypeID AND a.ShopID=e.ShopID  AND d.Ordering > 0 AND e.DocumentTypeID<>10 AND a.DocumentStatus=2 AND " & _
                        " a.ProductLevelID=" + ShopID.ToString + " AND e.LangID=1  AND a.DocumentDate >= " + StartDate + " AND a.DocumentDate < " + EndDate & _
                        " group by d.Ordering,d.DocumentTypeGroupID,d.GroupHeader, ProductID,d.ActualCost order by d.Ordering ) " & _
                        " UNION " & _
                        "(select d.Ordering,d.DocumentTypeGroupID,d.GroupHeader, ProductID As MaterialID ,sum(e.MovementInStock*b.UnitSmallAmount) As NetSmallAmount, " & _
                        " sum(b.UnitSmallAmount) AS TotalAmount, sum(ProductNetPrice) As ProductNetPrice, " & _
                        " Max(e.CalculateStandardProfitLoss) as CalculateStandardProfitLoss, d.ActualCost " & _
                        "from document a, docdetail b, documentTypeGroupValue c, DocumentTypeGroup d, DocumentType e " & _
                        "where a.DocumentID=b.DocumentID AND a.ShopID=b.ShopID AND a.DocumentTypeID=c.DocumentTypeID AND c.DocumentTypeGroupID = d.DocumentTypeGroupID AND " & _
                        " a.DocumentTypeID=e.DocumentTypeID AND a.ShopID=e.ShopID  AND d.Ordering < 0 AND e.DocumentTypeID<>10 AND a.DocumentStatus=2 AND " & _
                        " a.ProductLevelID=" + ShopID.ToString + " AND e.LangID=1  AND a.DocumentDate >= " + StartDate + " AND a.DocumentDate < " + EndDate & _
                        " group by d.Ordering,d.DocumentTypeGroupID,d.GroupHeader, ProductID ,d.ActualCost order by d.Ordering )"
        Else
            'Create Data For Beginning (Qty and Cost)
            strSQL = "DROP TABLE IF EXISTS DummyStockCardForBeginning"
            objDB.sqlExecute(strSQL, objCnn)
            
            strSQL = "create table DummyStockCardForBeginning(MaterialID int, NetSmallAmount decimal(18,4), ProductNetPrice decimal(18,4), " & _
                    " UseAvgCost tinyint, FromTransferStockDocument tinyint) "
            objDB.sqlExecute(strSQL, objCnn)
            strSQL = "Insert INTO DummyStockCardForBeginning(MaterialID, NetSmallAmount, ProductNetPrice, UseAvgCost, FromTransferStockDocument) " & _
                    "Select dd.ProductID As MaterialID, Sum(dd.UnitSmallAmount) As NetSmallAmount, Sum(dd.ProductNetPrice) AS ProductNetPrice," & _
                    " 0 as UseAvgCost, 1 as FromTransferStockDocument " & _
                    " FROM Document d, DocDetail dd, Materials m, MaterialDept md, MaterialGroup mg " & _
                    "Where d.DocumentID = dd.DocumentID AND d.ShopID = dd.ShopID AND dd.ProductID = m.MaterialID AND m.MaterialDeptID = md.MaterialDeptID AND " & _
                    " md.MaterialGroupID = mg.MaterialGroupID AND d.DocumentTypeID = 10 AND d.DocumentStatus = 2 AND " & _
                    " d.DocumentDate = " & BeginStartDate & " AND d.ProductLevelID = " & ShopID & AdditionalQuery & _
                    " Group By dd.ProductID " & _
                    " UNION " & _
                    "Select dd.ProductID As MaterialID, Sum(dt.MovementInStock * dd.UnitSmallAmount) As NetSmallAmount, " & _
                    " Sum(dd.ProductNetPrice) As ProductNetPrice, dtg.UseAvgCost, 0 as FromTransferStockDocument " & _
                    " FROM Document d, DocDetail dd, DocumentType dt, DocumentTypeGroup dtg, DocumentTypeGroupValue dtgv, " & _
                    " Materials m, MaterialDept md, MaterialGroup mg  " & _
                    "Where d.DocumentID = dd.DocumentID AND d.ShopID = dd.ShopID AND dd.ProductID = m.MaterialID AND m.MaterialDeptID = md.MaterialDeptID AND " & _
                    " md.MaterialGroupID = mg.MaterialGroupID AND d.DocumentStatus = 2 AND d.DocumentTypeID = dt.DocumentTypeID AND d.ShopID = dt.ShopID AND " & _
                    "  dt.LangID = 1 AND dt.ComputerID = 0 AND d.DocumentTypeID = dtgv.DocumentTypeID AND dtg.DocumentTypeGroupID = dtgv.DocumentTypeGroupID AND " & _
                    "  d.DocumentDate >= " & BeginStartDate & " AND d.DocumentDate < " & BeginEndDate & " AND d.ProductLevelID = " & ShopID & AdditionalQuery & _
                    " Group By dd.ProductID, dtg.UseAvgCost "
            objDB.sqlExecute(strSQL, objCnn)

            'Old Code For Begining Data (Sum ProductNetPrice for all Document)
            sqlStatement = "(select 0 AS Ordering, 0 AS DocumentTypeGroupID,'Beginning' AS GroupHeader,ProductID As MaterialID, " & _
                     "sum(dt.MovementInStock*bb.UnitSmallAmount) As NetSmallAmount,sum(bb.UnitSmallAmount) AS TotalAmount," & _
                     "sum(ProductNetPrice) As ProductNetPrice,1 As CalculateStandardProfitLoss, 0 As ActualCost " & _
                     " FROM document aa, docdetail bb, documenttype dt where aa.DocumentID=bb.DocumentID AND aa.ShopID=bb.ShopID AND aa.DocumentStatus=2 AND " & _
                     " aa.DocumentTypeID=dt.DocumentTypeID AND dt.LangID=1 AND dt.ShopID=aa.ProductLevelID AND aa.ProductLevelID=" + ShopID.ToString + " AND " & _
                     " aa.DocumentDate >= " + BeginStartDate + " AND aa.DocumentDate < " + BeginEndDate + " group by ProductID ) "

            If bolUseAvgCostForAllDocumentType = False Then
                'Begining Data (ProductNetPrice = ProductNetPrice or (Amount * Avg Cost for UseAvgCost = 1))
                strSQL = "(Select 0 AS Ordering, 0 AS DocumentTypeGroupID,'Beginning' AS GroupHeader, ds.MaterialID, " & _
                        "Sum(ds.NetSmallAmount) As NetSmallAmount, 0 as TotalAmount, " & _
                        "Sum(IF (ds.UseAvgCost = 0, ds.ProductNetPrice, IF (std.TotalAmount = 0, 0, (ds.NetSmallAmount * std.TotalPrice/ std.TotalAmount)))) as ProductNetPrice, " & _
                        "1 As CalculateStandardProfitLoss, 0 As ActualCost " & _
                        " FROM DummyStockCardForBeginning ds LEFT OUTER JOIN DummyMaterialStandardCost_For_Stock std ON " & _
                        " ds.MaterialID = std.MaterialID " & _
                        " Group By ds.MaterialID) "
            Else
                'Begining Data (ProductNetPrice = (Amount * Avg Cost except DocumentType = 10 --> Check IsFromTransferStockDocument))
                strSQL = "(Select 0 AS Ordering, 0 AS DocumentTypeGroupID,'Beginning' AS GroupHeader, ds.MaterialID, " & _
                            "Sum(ds.NetSmallAmount) As NetSmallAmount, 0 as TotalAmount, " & _
                            "Sum(IF (ds.FromTransferStockDocument = 1, ds.ProductNetPrice, IF (std.TotalAmount = 0, 0, (ds.NetSmallAmount * std.TotalPrice/ std.TotalAmount)))) as ProductNetPrice, " & _
                            "1 As CalculateStandardProfitLoss, 0 As ActualCost " & _
                            " FROM DummyStockCardForBeginning ds LEFT OUTER JOIN DummyMaterialStandardCost_For_Stock std ON " & _
                            " ds.MaterialID = std.MaterialID " & _
                            " Group By ds.MaterialID) "
            End If
            
            'For Begining Data (ProductNetPrice = (Amount * Avg Cost except DocumentType = 10))
            sqlStatement = strSQL & " UNION " & _
                    "( select d.Ordering, d.DocumentTypeGroupID,d.GroupHeader, ProductID As MaterialID ,sum(e.MovementInStock*b.UnitSmallAmount) As NetSmallAmount, " & _
                    " sum(b.UnitSmallAmount) AS TotalAmount, sum(ProductNetPrice) As ProductNetPrice, " & _
                    " Max(e.CalculateStandardProfitLoss) as CalculateStandardProfitLoss,d.ActualCost " & _
                    "from document a, docdetail b, documentTypeGroupValue c, DocumentTypeGroup d, DocumentType e " & _
                    "where a.DocumentID=b.DocumentID AND a.ShopID=b.ShopID AND a.DocumentTypeID=c.DocumentTypeID   AND c.DocumentTypeGroupID = d.DocumentTypeGroupID AND " & _
                    " a.DocumentTypeID=e.DocumentTypeID AND a.ShopID=e.ShopID  AND d.Ordering > 0 AND a.DocumentTypeID<>10 AND a.DocumentStatus=2 AND " & _
                    " a.ProductLevelID=" + ShopID.ToString + " AND e.LangID=1  AND a.DocumentDate >= " + StartDate + " AND a.DocumentDate < " + EndDate & _
                    " group by d.Ordering,d.DocumentTypeGroupID,d.GroupHeader, ProductID,d.ActualCost order by d.Ordering ) " & _
                    " UNION " & _
                    "( select d.Ordering,d.DocumentTypeGroupID,d.GroupHeader, ProductID As MaterialID ,sum(e.MovementInStock*b.UnitSmallAmount) As NetSmallAmount, " & _
                    " sum(b.UnitSmallAmount) AS TotalAmount, sum(ProductNetPrice) As ProductNetPrice," & _
                    " Max(e.CalculateStandardProfitLoss) as CalculateStandardProfitLoss,d.ActualCost " & _
                    "from document a, docdetail b, documentTypeGroupValue c, DocumentTypeGroup d, DocumentType e where a.DocumentID=b.DocumentID AND a.ShopID=b.ShopID AND " & _
                    " a.DocumentTypeID=c.DocumentTypeID   AND c.DocumentTypeGroupID = d.DocumentTypeGroupID  AND a.DocumentTypeID=e.DocumentTypeID AND a.ShopID=e.ShopID AND " & _
                    " d.Ordering < 0 AND a.DocumentTypeID<>10 AND a.DocumentStatus=2 AND a.ProductLevelID=" + ShopID.ToString + " AND e.LangID=1  AND " & _
                    " a.DocumentDate >= " + StartDate + " AND a.DocumentDate < " + EndDate & _
                    " group by d.Ordering,d.DocumentTypeGroupID,d.GroupHeader, ProductID ,d.ActualCost order by d.Ordering) "
        End If
          
        Dim TestTime As String
        TestTime = "<br>" + DateTimeUtil.CurrentDateTime
        objDB.sqlExecute("DROP TABLE IF EXISTS DummyStockCard", objCnn)
        objDB.sqlExecute("create table DummyStockCard (Ordering int, DocumentTypeGroupID int, GroupHeader varchar(50), MaterialID int, NetSmallAmount decimal(18,4),TotalAmount decimal(18,4), ProductNetPrice decimal(18,4), CalculateStandardProfitLoss tinyint, ActualCost tinyint)", objCnn)
        objDB.sqlExecute("insert into DummyStockCard " + sqlStatement, objCnn)
        objDB.sqlExecute("ALTER TABLE dummystockcard ADD INDEX OrderingIndex (Ordering,MaterialID);", objCnn)
        objDB.sqlExecute("ALTER TABLE dummystockcard ADD INDEX GroupMaterialIndex (DocumentTypeGroupID,MaterialID);", objCnn)
        TestTime += "<br>" + DateTimeUtil.CurrentDateTime
        '-----------------------------------------
        TestTime += "<br>" + DateTimeUtil.CurrentDateTime
        groupData = objDB.List("select * from DocumentTypeGroup where Ordering > 0 order by Ordering", objCnn)

        Dim SelectString As String = "u.UnitSmallName,a.UnitSmallID,a.MaterialID,a.MaterialName,a.MaterialCode,mg.MaterialGroupCode,mg.MaterialGroupName,std.TotalPrice,std.TotalAmount,std.BeginningPricePerUnit,std.RecTotalPrice,std.RecTotalAmount,b.CalculateStandardProfitLoss AS CalculateStandardProfitLoss0,b.NetSmallAmount AS NetSmallAmount0,b.TotalAmount AS TotalAmount0,b.ProductNetPrice AS ProductNetPrice0, aa.MovementCount "
		
        Dim WhereString As String = " left outer join UnitSmall u ON a.UnitSmallID=u.UnitSmallID left outer join DummyMaterialStandardCost_For_Stock std ON a.MaterialID=std.MaterialID left outer join DummyStockCard b on a.MaterialID=b.MaterialID AND b.Ordering=0 "

        Dim i As Integer
        For i = 0 To groupData.Rows.Count - 1
            SelectString += ",b" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ".CalculateStandardProfitLoss AS CalculateStandardProfitLoss" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ",b" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ".NetSmallAmount As NetSmallAmount" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ",b" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ".TotalAmount AS TotalAmount" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ",b" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ".ProductNetPrice AS ProductNetPrice" + groupData.Rows(i)("DocumentTypeGroupID").ToString
            WhereString += " left outer join DummyStockCard b" + groupData.Rows(i)("DocumentTypeGroupID").ToString + " on a.MaterialID=b" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ".MaterialID AND b" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ".DocumentTypeGroupID=" + groupData.Rows(i)("DocumentTypeGroupID").ToString
        Next

        GroupDataL = objDB.List("select * from DocumentTypeGroup where Ordering < 0 order by Ordering", objCnn)

        For i = 0 To GroupDataL.Rows.Count - 1
            SelectString += ",b" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ".CalculateStandardProfitLoss AS CalculateStandardProfitLoss" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ",b" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ".NetSmallAmount As NetSmallAmount" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ",b" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ".TotalAmount AS TotalAmount" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ",b" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ".ProductNetPrice AS ProductNetPrice" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString
            WhereString += " left outer join DummyStockCard b" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + " on a.MaterialID=b" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ".MaterialID AND b" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ".DocumentTypeGroupID=" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString
        Next

        sqlStatement = "select " + SelectString & _
                     " From Materials a LEFT OUTER JOIN (select count(*) as MovementCount,ProductID As MaterialID " & _
                     "       from document a1,docdetail b1, Documenttype dt where a1.DocumentID=b1.DocumentID AND a1.ShopID=b1.ShopID AND " & _
                     "       a1.ProductLevelID = " & ShopID.ToString & " AND a1.DocumentStatus = 2 AND a1.DocumentDate >= " & StartDate & " AND " & _
                     "       a1.DocumentDate < " & EndDate & " AND a1.DocumentTypeID <> 10 AND dt.DocumentTypeID = a1.DocumentTypeID AND dt.ShopID = a1.ShopID AND " & _
                     "       dt.LangID = 1 AND dt.MovementInStock <> 0 group by ProductID) aa ON a.MaterialID=aa.MaterialID " & _
                     " left outer join MaterialDept md ON a.MaterialDeptID=md.MaterialDeptID left outer join MaterialGroup mg ON md.MaterialGroupID=mg.MaterialGroupID " & _
                     WhereString & " Where 0=0 AND ((a.Deleted = 0) OR (a.Deleted = 1 AND aa.MovementCount > 0)) " & AdditionalQuery & _
                     " order by " & OrderParam

        strSQL = sqlStatement
        strSQL = "Insert INTO ErrorLog(ErrorMessage, ErrorTime) VALUES('" & Replace(strSQL, "'", "''") & "', {ts '" & Now.Year & Format(Now, "-MM-dd HH:mm:ss") & "'})"
        objDB.sqlExecute(strSQL, objCnn)

        GetData = objDB.List(sqlStatement, objCnn)
        TestTime += "<br>" + DateTimeUtil.CurrentDateTime

        'errorMsg.InnerHtml = sqlStatement

        ' objDB.sqlExecute("DROP TABLE IF EXISTS DummyStockCard", objCnn)
        '  objDB.sqlExecute("DROP TABLE IF EXISTS DummyMaterialStandardCost_For_Stock", objCnn)
        '   strSQL = "DROP TABLE IF EXISTS DummyStockCardForBeginning"
        '    objDB.sqlExecute(strSQL, objCnn)
         
        Return ""
    End Function






Sub Page_UnLoad()
	objCnn.Close()
End Sub
</script>
</body>
</html>
