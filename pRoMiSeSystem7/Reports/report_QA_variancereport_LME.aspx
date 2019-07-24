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
    Dim InvC As CultureInfo = CultureInfo.InvariantCulture
    Dim PageID As Integer  = 998

    Sub Page_Load()
        If User.Identity.IsAuthenticated AND Session("QAVarianceReport") Then

            Try
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true;" & GetPostBackEventReference(SubmitForm).ToString
                objCnn = getCnn.EstablishConnection()
                ShowContent.Visible = True

                StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"

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
                    Dim TestLabel = Util.FindControlRecursive(mainForm,"LangText" & z)
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

                If Not Page.IsPostBack Then
                    Radio_1.Checked = True
                End If

                Dim ShopIDValue As String = "0"
                If IsNumeric(Request.Form("ShopID")) Then
                    ShopIDValue = Request.Form("ShopID").ToString
                Else If IsNumeric(Request.QueryString("ShopID"))
                    ShopIDValue = Request.QueryString("ShopID").ToString
                End If

                Dim i As Integer
                Dim outputString,FormSelected,compareString As String
                Dim SelectString As String

                Dim ShopData As DataTable = getInfo.GetProductLevel(-99,objCnn)
                If ShopData.Rows.Count > 0 Then

                    outputString = "<select name=""ShopID"" style=""width:250px"">"
                    For i = 0 to ShopData.Rows.Count - 1
                        If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        outputString += "<option value=""" & ShopData.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & ShopData.Rows(i)("ProductLevelName")
                    Next
                    outputString += "</select>"
                    ShopText.InnerHtml = outputString
                    ShowShop.Visible = True
                Else
                    ShowShop.Visible = False
                End If

                Dim MaterialGroup As DataTable = getInfo.GetMaterialGroup(0,0,objCnn)
                Dim GroupStringValue As String = ""
                If Trim(Request.Form("MaterialGroup")) <> "" Then
                    GroupStringValue = Request.Form("MaterialGroup").ToString
                Else If Trim(Request.QueryString("MaterialGroup")) <> "" Then
                    GroupStringValue = Request.QueryString("MaterialGroup").ToString
                End If
                outputString = "<select name=""MaterialGroup"" style=""width:250px"">"
                If GroupStringValue = "" Then
                    FormSelected = "selected"
                Else
                    FormSelected = ""
                End If
                outputString += "<option value="""" " & FormSelected & ">" & "-- All Group--"
                For i = 0 to MaterialGroup.Rows.Count - 1
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
        Dim LangData2 As DataTable = getProp.GetLangData(PageID,2,-1,Request)
        Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
        Dim FormatData As DataTable = Util.FormatParam(FormatObject,Session("LangID"),objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)

        myTable2.Visible = False

        'Try
        Dim InvC As CultureInfo = CultureInfo.InvariantCulture
        Dim StartDate,EndDate As String
        Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
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
        If Radio_1.Checked = True Then
            ReportType = 1
            If SelMonth = 0 Or SelYear = 0 Then
                FoundError = True
            Else
                Dim SDate As New Date(Request.Form("MonthYearDate_Year"),Request.Form("MonthYearDate_Month"),1)
                ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy",Session("LangID"),objCnn)
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
                StartDate = DateTimeUtil.FormatDate(Request.Form("Doc_Day"),Request.Form("Doc_Month"),Request.Form("Doc_Year"))
                Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
                CheckDate = DateAdd("d",1,CheckDate)
                EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))
                StartDateForMovement = DateTimeUtil.FormatDate(1,Request.Form("Doc_Month"),Request.Form("Doc_Year"))
                SelMonth = Request.Form("Doc_Month")
                SelYear = Request.Form("Doc_Year")
                If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
                    ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
                    FoundError = True
                Else
                    ResultSearchText.InnerHtml = ""
                    Dim SDate1 As New Date(Request.Form("Doc_Year"), Request.Form("Doc_Month"), Request.Form("Doc_Day"))
                    Dim EDate1 As New Date(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"))
                    ReportDate = DateTimeUtil.FormatDateTime(SDate1, "DateOnly",Session("LangID"),objCnn) + " - " + DateTimeUtil.FormatDateTime(EDate1, "DateOnly",Session("LangID"),objCnn)
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
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(NOW(), "DateAndTime", Session("LangID"), objCnn)
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
            Result = getReport.StockCardReport(MGroupData, "", dtTable, groupData, groupDataL, Request.Form("ShopID"), SelMonth, SelYear, OrderParam.SelectedItem.Value, StartDate, EndDate, ReportType, BeginningDay, BeginningMonth, BeginningYear, objCnn)
            'Application.UnLock()

            ResultSearchText.InnerHtml = "Variance Report (Show Stock Movement) " + " (" + ReportDate + ")"
            Dim i As Integer

            Dim ExtraInfo As String
            Dim totalSale As Double = 0
            Dim totalCost As Double = 0
            Dim deptCost As Double = 0
            Dim groupCost As Double = 0
            Dim DummyPGroupID, DummyPDeptID, DummyMGroupID, DummyMDeptID As Integer
            Dim ProductGroupName, ProductDeptName, MaterialGroupName, MaterialDeptName As String


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
            Dim UnitName As String
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
            Dim BSumText As String = ""

            Dim HeaderString As String = "<tr>"
            If ShowGroup = True Then
                HeaderString += "<td align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Code" + "</td>"
                HeaderString += "<td align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Group Name" + "</td>"
            End If
            HeaderString += "<td align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Code" + "</td>"
            HeaderString += "<td align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Name" + "</td>"
            HeaderString += "<td align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Unit<br>Cost" + "</td>"
            HeaderString += "<td align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "+Beginning<br>Amount" + "</td>"
            For i = 0 To groupData.Rows.Count - 1
                HeaderString += "<td align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + groupData.Rows(i)("GroupHeader") + "<br>Amount</td>"
            Next


            HeaderString += "<td align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Onhand" + "<br>Amount</td>"
            HeaderString += "<td align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Ending" + "<br>Amount</td>"

            For i = 0 To groupDataL.Rows.Count - 1
                HeaderString += "<td align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + groupDataL.Rows(i)("GroupHeader") + "<br>Amount</td>"
            Next
            HeaderString += "<td align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Actual" + "<br>Amount</td>"
            HeaderString += "<td align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "%<br>Variance" + "<br></td>"
            HeaderString += "<td align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Compare<br>Standard" + "<br></td>"
            HeaderString += "</tr>"
            headerTextString.InnerHtml = HeaderString

            Dim groupString, PriceString, QtyString, StdString As String
            Dim resultString As StringBuilder = New StringBuilder
            Dim showData As Boolean
            Dim j As Integer
            Dim UnitPrice As String
            Dim UnitInfo As DataTable
            Dim CostPerUnit As Double
            Dim UnitText As String
            Dim UnitRatioVal As Double = 1
            Dim ActualQty, GroupActualQty, TotalActualQty As Double
            Dim StdQty, GroupStdQty, TotalStdQty As Double
            Dim VarianceQty, GroupVarianceQty, TotalVarianceQty As Double
            Dim StatGBColor As String = "#ffe4e1"
            Dim GroupSumActual, TotalSumActual, GroupSumStd, TotalSumStd As Double
            Dim LineSumActual, LineSumStd As Double
            Dim SumVariance As Double
            Dim CheckGroupVal As Double
            Dim TestString As String
            For i = 0 To dtTable.Rows.Count - 1
                Dim outputString As StringBuilder = New StringBuilder
                showData = False
                subTotalUse = 0
                subTotalPrice = 0
                ActualQty = 0
                StdQty = 0

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
                outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"">" + UnitText + "<br><a  class=""smallText"" href=""JavaScript: newWindow = window.open( '../Inventory/product_stdcost.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&SelMonth=" & SelMonth.ToString & "&SelYear=" & SelYear.ToString & "&ProductLevelID=" & Request.Form("ShopID").ToString + "', '', 'width=900,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(CostPerUnit * UnitRatioVal, "##,##0.00") + "</a></td>")

                '----- Beginning Stock ---------------
                If Not IsDBNull(dtTable.Rows(i)("NetSmallAmount0")) Then
                    'If dtTable.Rows(i)("NetSmallAmount0") > 0 Then
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"">" + Format(dtTable.Rows(i)("NetSmallAmount0") / UnitRatioVal, "##,##0.0000;(##,##0.0000)") + "<br>")
                    subTotalUse += dtTable.Rows(i)("NetSmallAmount0")
                    If dtTable.Rows(i)("NetSmallAmount0") <> 0 Then
                        showData = True
                    End If
                    'Else
                    'outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"">0.0000<br>")
                    'End If
                Else
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"">0.0000<br>")
                End If

                If Not IsDBNULL(dtTable.Rows(i)("NetSmallAmount0")) And Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                    If dtTable.Rows(i)("TotalPrice") > 0 And dtTable.Rows(i)("TotalAmount") > 0 Then
                        outputString = outputString.Append(Format(dtTable.Rows(i)("NetSmallAmount0") * (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")), "##,##0.00") + "</td>")
                        subTotalPrice += dtTable.Rows(i)("NetSmallAmount0") * (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount"))
                        BeginningSum += dtTable.Rows(i)("NetSmallAmount0") * (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount"))
                        BeginningSumGroup += dtTable.Rows(i)("NetSmallAmount0") * (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount"))
                        DLineBeginningSumGroup = dtTable.Rows(i)("NetSmallAmount0") * (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount"))
                        'BSumText += "<BR>" + Format(dtTable.Rows(i)("NetSmallAmount0")*(dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount")),"##,##0.000000")
                        showData = True
                    Else
                        outputString = outputString.Append("</td>")
                    End If
                Else
                    outputString = outputString.Append("</td>")
                End If

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
                        outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top""><a class=""smalltext"" href=""JavaScript: newWindow = window.open( 'report_material_doc2.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&UnitPrice=" + UnitPrice + "&DocumentTypeGroupID=" & groupData.Rows(j)("DocumentTypeGroupID").ToString + "&SelMonth=" & SelMonth.ToString & "&SelYear=" & SelYear.ToString & "&ProductLevelID=" & Request.Form("ShopID").ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "&ReportDate=" + ReportDate + "', '', 'width=1000,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(dtTable.Rows(i)(groupString) / UnitRatioVal, "##,##0.0000;(##,##0.0000)") + "</a><br>")
                        subTotalUse += dtTable.Rows(i)(groupString)
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
                        outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"">0.0000<br>")
                    End If


                    If Not IsDBNull(dtTable.Rows(i)(QtyString)) And Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull("TotalAmount") Then
                        If dtTable.Rows(i)("TotalAmount") = 0 Then
                            outputString = outputString.Append("</td>")
                        Else
                            outputString = outputString.Append(Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString), "##,##0.00;(##,##0.00)") + "</td>")
                            subTotalPrice += (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString)
                            ColumnSum(j) += (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString)
                            ColumnSumGroup(j) += (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString)
                            DLineColumnSumGroup(j) = (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString)
                        End If
                        showData = True
                    Else
                        outputString = outputString.Append("</td>")
                    End If

                Next
                If Not IsDBNull(subTotalUse) Then
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"" bgColor=""" + GlobalParam.GrayBGColor + """>" + Format(subTotalUse / UnitRatioVal, "##,##0.0000;(##,##0.0000)") + "<br>")
                    If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                        If dtTable.Rows(i)("TotalAmount") > 0 Then
                            If subTotalUse > 0 Or (subTotalUse = 0 And showData = True) Then
                                outputString = outputString.Append(Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * subTotalUse, "##,##0.00") + "</td>")
                                subTotalPrice += (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * subTotalUse
                                EndingSum += (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * subTotalUse
                                EndingSumGroup += (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * subTotalUse
                                DLineEndingSumGroup = (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * subTotalUse
                                showData = True
                            Else
                                outputString = outputString.Append("</td>")
                            End If
                        Else
                            outputString = outputString.Append("</td>")
                        End If
                    Else
                        outputString = outputString.Append("</td>")
                    End If
                Else
                    outputString = outputString.Append("<td></td>")
                End If

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
                        subTotalUse += dtTable.Rows(i)(groupString)
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
                                subTotalPrice += (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString)
                                ColumnSaleSum(j) += (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString)
                                ColumnSaleSumGroup(j) += (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString)
                                DLineColumnSaleSumGroup(j) = (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString)
                                showData = True
                            End If
                        End If
                    End If
                Next

                If Not IsDBNull(subTotalUse) Then
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"" bgColor=""" + GlobalParam.GrayBGColor + """><a  class=""smallText"" href=""JavaScript: newWindow = window.open( 'report_material_movement2.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&SelMonth=" & SelMonth.ToString & "&SelYear=" & SelYear.ToString & "&ProductLevelID=" & Request.Form("ShopID").ToString + "&StartDate=" + Replace(StartDateForMovement, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "&ReportDate=" + ReportDate + "', '', 'width=1000,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(subTotalUse / UnitRatioVal, "##,##0.0000;(##,##0.0000)") + "</a><br>")
                    If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                        If dtTable.Rows(i)("TotalAmount") > 0 Then
                            If subTotalUse > 0 Or (subTotalUse = 0 And showData = True) Then
                                outputString = outputString.Append(Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * subTotalUse, "##,##0.00;(##,##0.00)") + "</td>")
                                subTotalPrice += (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * subTotalUse
                                TotalSum += (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * subTotalUse
                                TotalSumGroup += (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * subTotalUse
                                DLineTotalSumGroup = (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * subTotalUse
                                showData = True
                                'objDB.sqlExecute("insert into EndingStock (MaterialID,MaterialCode,MaterialName,UnitSmallAmount,UnitLargeAmount,PricePerUnitSmall,PricePerUnitLarge,UnitName,NetPrice) values (" + dtTable.Rows(i)("MaterialID").ToString + ",'" + dtTable.Rows(i)("MaterialCode") + "','" + dtTable.Rows(i)("MaterialName").ToString + "'," + subTotalUse.ToString + "," + (subTotalUse/UnitRatioVal).ToString + "," + (dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount")).ToString + "," + (CostPerUnit*UnitRatioVal).ToString + "," + ((dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount"))*subTotalUse).ToString + "," + ((CostPerUnit*UnitRatioVal)*(subTotalUse/UnitRatioVal)).ToString + ")", objCnn)
                            Else
                                outputString = outputString.Append("</td>")
                            End If
                        Else
                            outputString = outputString.Append("</td>")
                        End If
                    Else
                        outputString = outputString.Append("</td>")
                    End If
                    TotalUse += subTotalUse
                    TotalPrice += subTotalPrice
                Else
                    outputString = outputString.Append("<td></td>")
                End If

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
                        outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top""><a class=""smalltext"" href=""JavaScript: newWindow = window.open( 'report_material_doc2.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&UnitPrice=" + UnitPrice + "&DocumentTypeGroupID=" & groupDataL.Rows(j)("DocumentTypeGroupID").ToString + "&SelMonth=" & SelMonth.ToString & "&SelYear=" & SelYear.ToString & "&ProductLevelID=" & Request.Form("ShopID").ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "&ReportDate=" + ReportDate + "', '', 'width=1000,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(dtTable.Rows(i)(groupString) / UnitRatioVal, "##,##0.0000;(##,##0.0000)") + "</a><br>")
                        VarianceQty += dtTable.Rows(i)(groupString)
                        ShowData = True
                    Else
                        outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"">0.0000<br>")
                    End If


                    If Not IsDBNull(dtTable.Rows(i)(StdString)) Then
                        If Not IsDBNull(dtTable.Rows(i)(QtyString)) And Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull("TotalAmount") Then
                            If dtTable.Rows(i)("TotalAmount") <> 0 Then
                                outputString = outputString.Append(Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * dtTable.Rows(i)(groupString), "##,##0.00;(##,##0.00)") + "</td>")
                            Else
                                outputString = outputString.Append("</td>")
                            End If
                        Else
                            outputString = outputString.Append("</td>")
                        End If
                    Else
                        outputString = outputString.Append("</td>")
                    End If
                Next

                outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"" bgColor=""" + StatGBColor + """>" + Format(ActualQty / UnitRatioVal, "##,##0.0000;(##,##0.0000)") + "<br>")

                If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull("TotalAmount") Then
                    If dtTable.Rows(i)("TotalAmount") <> 0 Then
                        outputString = outputString.Append(Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * ActualQty, "##,##0.00;(##,##0.00)") + "</td>")
                        GroupSumActual += (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * ActualQty
                        TotalSumActual += (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * ActualQty
                        GroupSumStd += (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * StdQty
                        TotalSumStd += (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * StdQty
                        LineSumActual = (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * ActualQty
                        LineSumStd = (dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")) * StdQty
                    Else
                        outputString = outputString.Append("</td>")
                    End If
                Else
                    outputString = outputString.Append("</td>")
                End If

                If ActualQty <> 0 Then
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"" bgColor=""" + StatGBColor + """>" + Format(Math.Abs(VarianceQty * 100 / ActualQty), "##,##0.00") + "%<br>")
                    outputString = outputString.Append("</td>")
                Else
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"" bgColor=""" + StatGBColor + """>" + "-" + "</td>")
                End If

                If StdQty <> 0 Then
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"" bgColor=""" + StatGBColor + """>" + Format(ActualQty * 100 / StdQty, "##,##0.00") + "%<br>")
                    outputString = outputString.Append("</td>")
                Else
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"" bgColor=""" + StatGBColor + """>" + "-" + "</td>")
                End If

                outputString = outputString.Append("</tr>")

                If (showData = True And DisplayOnly.Checked = True) Or DisplayOnly.Checked = False Then
                    If Trim(dtTable.Rows(i)("MaterialCode")) <> "" Then
                        resultString = resultString.Append(outputString.ToString)
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
                    If i = 0 Then ShowGroupSummary = False
                    If CheckGroupVal = 0 Then ShowGroupSummary = False
                    If ShowGroupSummary = True Then
                        Dim outputS As StringBuilder = New StringBuilder
                        outputS = outputS.Append("<tr bgColor=""" + "#eeeeee" + """>")

                        outputS = outputS.Append("<td class=""smallText"" align=""right"" colspan=""5"">Summary for " + dtTable.Rows(i)("MaterialGroupName") + "</td>")

                        outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format(BeginningSumGroup, "##,##0.00;(##,##0.00)") + "</td>")
                        For j = 0 To groupData.Rows.Count - 1
                            outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format(ColumnSumGroup(j), "##,##0.00;(##,##0.00)") + "</td>")
                            ColumnSumGroup(j) = LineColumnSumGroup(j)
                        Next
                        outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format(EndingSumGroup, "##,##0.00;(##,##0.00)") + "</td>")
                        outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format(TotalSumGroup, "##,##0.00;(##,##0.00)") + "</td>")
                        SumVariance = 0
                        For j = 0 To groupDataL.Rows.Count - 1
                            outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format(ColumnSaleSumGroup(j), "##,##0.00;(##,##0.00)") + "</td>")
                            SumVariance += ColumnSaleSumGroup(j)
                            ColumnSaleSumGroup(j) = 0
                        Next
                        outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format(GroupSumActual - LineSumActual, "##,##0.00;(##,##0.00)") + "</td>")

                        If GroupSumActual - LineSumActual <> 0 Then
                            outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format(Math.Abs((SumVariance) * 100 / (GroupSumActual - LineSumActual)), "##,##0.00") + "%</td>")
                        Else
                            outputS = outputS.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
                        End If

                        If (GroupSumStd - LineSumStd) <> 0 Then
                            outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format((GroupSumActual - LineSumActual) * 100 / (GroupSumStd - LineSumStd), "##,##0.00") + "%</td>")
                        Else
                            outputS = outputS.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
                        End If

                        outputS = outputS.Append("</tr>")
                        BeginningSumGroup = 0
                        EndingSumGroup = 0
                        TotalSumGroup = 0
                        GroupSumActual = 0
                        GroupSumStd = 0
                        OString = outputS.ToString
                        resultString = resultString.Append(outputS.ToString)

                    End If

                End If

            Next

            SumVariance = 0
            resultString = resultString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
            If ShowGroup = True Then
                resultString = resultString.Append("<td class=""smallText"" align=""right"" colspan=""5"">Summary</td>")
            Else
                resultString = resultString.Append("<td class=""smallText"" align=""right"" colspan=""3"">Summary</td>")
            End If
            resultString = resultString.Append("<td class=""smallText"" align=""right"">" + Format(BeginningSum, "##,##0.00;(##,##0.00)") + "</td>")
            For i = 0 To groupData.Rows.Count - 1
                resultString = resultString.Append("<td class=""smallText"" align=""right"">" + Format(ColumnSum(i), "##,##0.00;(##,##0.00)") + "</td>")
            Next
            resultString = resultString.Append("<td class=""smallText"" align=""right"">" + Format(EndingSum, "##,##0.00;(##,##0.00)") + "</td>")
            resultString = resultString.Append("<td class=""smallText"" align=""right"">" + Format(TotalSum, "##,##0.00;(##,##0.00)") + "</td>")
            For i = 0 To groupDataL.Rows.Count - 1
                resultString = resultString.Append("<td class=""smallText"" align=""right"">" + Format(ColumnSaleSum(i), "##,##0.00;(##,##0.00)") + "</td>")
                SumVariance += ColumnSaleSum(i)
            Next

            resultString = resultString.Append("<td class=""smallText"" align=""right"">" + Format(TotalSumActual, "##,##0.00;(##,##0.00)") + "</td>")

            If TotalSumActual <> 0 Then
                resultString = resultString.Append("<td class=""smallText"" align=""right"">" + Format(Math.Abs((SumVariance) * 100 / TotalSumActual), "##,##0.00") + "%</td>")
            Else
                resultString = resultString.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
            End If

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
            Session("resultString") = resultString.ToString
        End If
        'Catch ex As Exception
        'FoundError = True
        'End Try
    End Sub

    Sub ExportData(Source As Object, E As EventArgs)

        Dim FileName As String = "StockCardData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"

        Dim OutputText As String = ""
        Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"

        Util.ExportData(Session("ReportResult"), FileName, CSSFile, GlobalParam.ExportCharSet, -1)
        'Util.ExportData(Session("resultString"), FileName, CSSFile, GlobalParam.ExportCharSet, -1)

    End Sub

    Sub Page_UnLoad()
        objCnn.Close()
    End Sub
</script>
</body>
</html>
