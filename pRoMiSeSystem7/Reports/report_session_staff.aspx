<%@ Page Language="VB" ContentType="text/html" debug="True"%>
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
<title>Session Reports By Staff</title>
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
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Session Report By Staff" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
				<td><synature:date id="DailyDate" runat="server" /></td>
				<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
			</tr>
		</table></td>
</tr>


</table>
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
<span id="startTable" runat="server"></span>
	<tr>
	<span id="TableHeaderText" runat="server"></span>
	<span id="ExtraHeader" runat="server"></span>
	</tr>
	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>
</table></td></tr>
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
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer  = 998

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Report_SessionStaff") Then
		
            Try
                objCnn = getCnn.EstablishConnection()
                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
                ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		
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
		
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
			
                DailyDate.YearType = GlobalParam.YearType
                DailyDate.FormName = "DocDaily"
                DailyDate.StartYear = GlobalParam.StartYear
                DailyDate.EndYear = GlobalParam.EndYear
                DailyDate.LangID = Session("LangID")
                DailyDate.Lang_Data = LangDefault
                DailyDate.Culture = CultureString
		
                ResultText.InnerHtml = ""
                ResultSearchText.InnerHtml = ""
                errorMsg.InnerHtml = ""
		
                Dim HeaderString As String = ""
		
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Staff Name</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Terminal</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Open Time</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Close Time</td>"
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

                    outputString = "<select name=""ShopID"">"
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
        Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
	
        Dim CashInOutFeature As Boolean = False
        Dim CashInOut As DataTable = getProp.PropertyValue(1, 23, Request.Form("ShopID"), objCnn)
        If CashInOut.Rows.Count > 0 Then
            If CashInOut.Rows(0)("PropertyValue") = 1 Then
                CashInOutFeature = True
            End If
        End If
        Dim DailyDateValue As String = ""
        Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	
        Dim bolHasVoidManualQR As Boolean
        Dim dclVoidManualQR As Decimal
        Dim StartDate, EndDate As String
        Dim outputString As String = ""
        Dim grandTotal As Double = 0
        Dim GraphData As New DataSet()
        Dim ReportDate As String
			
        Try
            StartDate = DateTimeUtil.FormatDate(Request.Form("DocDaily_Day"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Year"))
            Dim CheckDate As New DateTime(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"), 0, 0, 0)
            CheckDate = DateAdd("d", 1, CheckDate)
            EndDate = DateTimeUtil.FormatDate(Day(CheckDate), Month(CheckDate), CheckDate.ToString("yyyy", InvC))
        Catch ex As Exception
            FoundError = True
        End Try
        If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
            ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
            FoundError = True
            DailyDateValue = ""
        Else
            ResultSearchText.InnerHtml = ""
            Dim SDate2 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
            ReportDate = DateTimeUtil.FormatDateTime(SDate2, "DateOnly", Session("LangID"), objCnn)
        End If
        If FoundError = False Then
            If LangDefault.Rows.Count >= 3 Then
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(Now(), "DateAndTime", Session("LangID"), objCnn)
            End If
            ShowPrint.Visible = True
            Dim displayTable As New DataTable()
            Dim dtTable As New DataTable()

            Dim CashInOutDB As New DataTable()
            Dim foundRows() As DataRow
            Dim expression As String
            'Application.Lock()
		
            dtTable = getReport.SessionReportByStaff(CashInOutDB, StartDate, EndDate, Request.Form("ShopID"), objCnn)
            bolHasVoidManualQR = POSDBSQLFront.POSUtilSQL.IsFieldNameExist(objDB, objCnn, "EDC_PaymentInfo", "IsManualVoid")
            
            ResultSearchText.InnerHtml = "Session Report By Staff of " + SelShopName.Value + " (" + ReportDate + ")"
            'Application.UnLock()
            Dim ReportHeader As String
            Dim i, j, k As Integer
            Dim DummyCloseStaffID As Integer = -1
            Dim DummyOpenStaffID As Integer = -1
            Dim DummySessionID As Integer = -1
            Dim DummyComputerID As Integer = -1
            Dim PayTypeIDList As String = ""
            Dim ExtraHeaderString As String = ""
            Dim PayTypeString As String = ""
            Dim TestString As String
            Dim IDList() As String
            Dim counter As Integer = 0
            Dim SumRow, SumRowCash As Double
		
            PayTypeIDList = ""
            ReDim IDList(-1)
            For i = 0 To dtTable.Rows.Count - 1
                If dtTable.Rows(i)("PayTypeID") <> -1 Then
                    TestString += "<br>" + PayTypeIDList.IndexOf("," + dtTable.Rows(i)("PayTypeID").ToString + ",").ToString
                    If PayTypeIDList.IndexOf("," + dtTable.Rows(i)("PayTypeID").ToString + ",") = -1 Then
                        ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + dtTable.Rows(i)("PayType") + "</td>"
                        ReDim Preserve IDList(counter)
                        IDList(counter) = dtTable.Rows(i)("PayTypeID")
                        counter += 1
                    End If
                    If PayTypeIDList = "" Then
                        PayTypeIDList += "," + dtTable.Rows(i)("PayTypeID").ToString + ","
                    Else
                        PayTypeIDList += dtTable.Rows(i)("PayTypeID").ToString + ","
                    End If
                End If
            Next
		
            Dim Summary(), sumTotal() As Double
            Dim noAdditonalCol As Integer
            Dim CashInOutCount, manualVoidQRCount As Integer
            noAdditonalCol = 0
            CashInOutCount = 0
            manualVoidQRCount = 0
            ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Total Payment" + "</td>"
            ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Initial" + "</td>"
            If CashInOutFeature = True Then
                ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Cash In" + "</td>"
                ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Cash Out" + "</td>"
                noAdditonalCol += 2
                CashInOutCount = 2
            End If
            If bolHasVoidManualQR = True Then
                ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Manual Void From QR Payment" + "</td>"
                noAdditonalCol += 1
                manualVoidQRCount = 1
            End If
            ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Cash Total" + "</td>"
            ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Cash Count" + "</td>"
            ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Diff" + "</td>"
            ReDim Summary(counter + noAdditonalCol + 4)
            ReDim sumTotal(counter + noAdditonalCol + 4)

            ExtraHeader.InnerHtml = ExtraHeaderString
            Dim NeedSummary As Boolean
            Dim CloseBy As String
            Dim BgColor As String = GlobalParam.GrayBGColor
            Dim Zero As Integer = 0
            For i = 0 To dtTable.Rows.Count - 1
                If Not (dtTable.Rows(i)("SessionID") = DummySessionID And dtTable.Rows(i)("ComputerID") = DummyComputerID) Then
                    If Not IsDBNull(dtTable.Rows(i)("CloseStaff")) Then
                        CloseBy = "Closed By: " + dtTable.Rows(i)("CloseStaff")
                    Else
                        CloseBy = "Closed By: -"
                    End If
                    If dtTable.Rows(i)("OpenStaffID") <> DummyOpenStaffID Then
                        For j = 0 To Summary.Length - 1
                            Summary(j) = 0
                        Next
                        NeedSummary = False
                        If BgColor = GlobalParam.GrayBGColor Then
                            BgColor = "white"
                        Else
                            BgColor = GlobalParam.GrayBGColor
                        End If
                        outputString += "<tr bgColor=""" + BgColor + """>"
                        If Not IsDBNull(dtTable.Rows(i)("OpenStaff")) Then
                            ReportHeader = "Session Report of " + SelShopName.Value + " for " + dtTable.Rows(i)("OpenStaff") + " (" + ReportDate + ")"
                            outputString += "<td align=""left"" class=""smallText""><a class=""smallText"" href=""JavaScript: newWindow = window.open( 'report_session_sumstaff.aspx?ShopID=" + Request.Form("ShopID").ToString + "&ReportHeader=" + ReportHeader + "&StaffID=" + dtTable.Rows(i)("OpenStaffID").ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=900,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + dtTable.Rows(i)("OpenStaff") + "</a> [<a class=""smallText"" href=""JavaScript: newWindow = window.open( 'report_session_details.aspx?ShopID=" + Request.Form("ShopID").ToString + "&ReportHeader=" + ReportHeader + "&StaffID=" + dtTable.Rows(i)("OpenStaffID").ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=900,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "details" + "</a>]<br>(" + CloseBy + ")</td>"
                        Else
                            outputString += "<td class=""smallText"">-</td>"
                        End If
                    Else
                        outputString += "<tr bgColor=""" + BgColor + """>"
                        outputString += "<td class=""smallText"">(" + CloseBy + ")</td>"
                        NeedSummary = True
                    End If
			
			
                    If Not IsDBNull(dtTable.Rows(i)("RegistrationNumber")) Then
                        outputString += "<td class=""smallText"">" + dtTable.Rows(i)("RegistrationNumber") + "</td>"
                    Else
                        outputString += "<td class=""smallText"">-</td>"
                    End If
                    If Not IsDBNull(dtTable.Rows(i)("OpenSessionDateTime")) Then
                        outputString += "<td class=""smallText"">" + CDate(dtTable.Rows(i)("OpenSessionDateTime")).ToString(FormatObject.TimeFormat, ci) + "</td>"
                    Else
                        outputString += "<td class=""smallText"">-</td>"
                    End If
                    If Not IsDBNull(dtTable.Rows(i)("CloseSessionDateTime")) Then
                        outputString += "<td class=""smallText"">" + CDate(dtTable.Rows(i)("CloseSessionDateTime")).ToString(FormatObject.TimeFormat, ci) + "</td>"
                    Else
                        outputString += "<td class=""smallText"">-</td>"
                    End If
                    SumRow = 0
                    SumRowCash = 0
                    For j = 0 To IDList.Length - 1
                        PayTypeString = ""
                        For k = 0 To dtTable.Rows.Count - 1
                            If dtTable.Rows(k)("SessionID") = dtTable.Rows(i)("SessionID") And dtTable.Rows(k)("ComputerID") = dtTable.Rows(i)("ComputerID") Then
                                If dtTable.Rows(k)("OpenStaffID") = dtTable.Rows(i)("OpenStaffID") Then
                                    If IDList(j) = dtTable.Rows(k)("PayTypeID") Then
                                        PayTypeString = CDbl(dtTable.Rows(k)("PayAmount")).ToString(FormatObject.CurrencyFormat, ci)
                                        SumRow += dtTable.Rows(k)("PayAmount")
                                        Summary(j) += dtTable.Rows(k)("PayAmount")
                                        sumTotal(j) += dtTable.Rows(k)("PayAmount")
                                        If dtTable.Rows(k)("PayTypeID") = 1 Then
                                            SumRowCash += dtTable.Rows(k)("PayAmount")
                                        ElseIf dtTable.Columns.Contains("ConvertPayTypeTo") = True Then
                                            If dtTable.Rows(k)("ConvertPayTypeTo") = 1 Then
                                                SumRowCash += dtTable.Rows(k)("PayAmount")
                                            End If
                                        End If
                                    End If
                                End If
                            End If
                        Next
                        If PayTypeString = "" Then
                            outputString += "<td align=""right"" class=""smallText"">-</td>"
                        Else
                            outputString += "<td align=""right"" class=""smallText"">" + PayTypeString + "</td>"
                        End If
                    Next
                    outputString += "<td align=""right"" class=""smallText"">" + SumRow.ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(dtTable.Rows(i)("OpenSessionAmount")).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                    If CashInOutFeature = True Then
                        expression = "SessionID = " + dtTable.Rows(i)("SessionID").ToString + " AND ComputerID = " + dtTable.Rows(i)("ComputerID").ToString + " AND CashMovement = 1"
                        foundRows = CashInOutDB.Select(expression)
                        If foundRows.Length > 0 Then
                            outputString += "<td align=""right"" class=""smallText""><a class=""smallText"" href=""JavaScript: newWindow = window.open( 'CashInOut_Details.aspx?CashMovement=1&SessionID=" + dtTable.Rows(i)("SessionID").ToString + "&ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "', '', 'width=900,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + CDbl(foundRows(0)(3)).ToString(FormatObject.CurrencyFormat, ci) + "</a></td>"
                            Summary(counter + 2) += foundRows(0)(3)
                            sumTotal(counter + 2) += foundRows(0)(3)
                            SumRowCash += foundRows(0)(3)
                        Else
                            outputString += "<td align=""right"" class=""smallText"">" + "-" + "</td>"
                        End If
                        expression = "SessionID = " + dtTable.Rows(i)("SessionID").ToString + " AND ComputerID = " + dtTable.Rows(i)("ComputerID").ToString + " AND CashMovement = -1"
                        foundRows = CashInOutDB.Select(expression)
                        If foundRows.Length > 0 Then
                            outputString += "<td align=""right"" class=""smallText""><a class=""smallText"" href=""JavaScript: newWindow = window.open( 'CashInOut_Details.aspx?CashMovement=-1&SessionID=" + dtTable.Rows(i)("SessionID").ToString + "&ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "', '', 'width=900,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + CDbl(foundRows(0)(3)).ToString(FormatObject.CurrencyFormat, ci) + "</a></td>"
                            Summary(counter + 3) += foundRows(0)(3)
                            sumTotal(counter + 3) += foundRows(0)(3)
                            SumRowCash += foundRows(0)(3)
                        Else
                            outputString += "<td align=""right"" class=""smallText"">" + "-" + "</td>"
                        End If
                    End If
                    If bolHasVoidManualQR = True Then
                        dclVoidManualQR = getReport.Session_GetManualVoidQRPayment(objCnn, dtTable.Rows(i)("SessionID"), dtTable.Rows(i)("ComputerID"))
                        If dclVoidManualQR <> 0 Then
                            outputString += "<td align=""right"" class=""smallText"">" & (-dclVoidManualQR).ToString(FormatObject.CurrencyFormat, ci) & "</td>"
                            Summary(counter + CashInOutCount + 2) -= dclVoidManualQR
                            sumTotal(counter + CashInOutCount + 2) -= dclVoidManualQR
                            SumRowCash -= dclVoidManualQR
                        Else
                            outputString += "<td align=""right"" class=""smallText"">" + "-" + "</td>"
                        End If
                    End If
                                        
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(dtTable.Rows(i)("OpenSessionAmount") + SumRowCash).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(dtTable.Rows(i)("CloseSessionAmount")).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                    outputString += "<td align=""right"" class=""smallText"">" + CDbl(dtTable.Rows(i)("CloseSessionAmount") - (dtTable.Rows(i)("OpenSessionAmount") + SumRowCash)).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                    Summary(counter) += SumRow
                    Summary(counter + 1) += dtTable.Rows(i)("OpenSessionAmount")
                    Summary(counter + 2 + CashInOutCount + manualVoidQRCount) += dtTable.Rows(i)("OpenSessionAmount") + SumRowCash
                    Summary(counter + 3 + CashInOutCount + manualVoidQRCount) += dtTable.Rows(i)("CloseSessionAmount")
                    Summary(counter + 4 + CashInOutCount + manualVoidQRCount) += dtTable.Rows(i)("CloseSessionAmount") - (dtTable.Rows(i)("OpenSessionAmount") + SumRowCash)
                    sumTotal(counter) += SumRow
                    sumTotal(counter + 1) += dtTable.Rows(i)("OpenSessionAmount")
                    sumTotal(counter + 2 + CashInOutCount + manualVoidQRCount) += dtTable.Rows(i)("OpenSessionAmount") + SumRowCash
                    sumTotal(counter + 3 + CashInOutCount + manualVoidQRCount) += dtTable.Rows(i)("CloseSessionAmount")
                    sumTotal(counter + 4 + CashInOutCount + manualVoidQRCount) += dtTable.Rows(i)("CloseSessionAmount") - (dtTable.Rows(i)("OpenSessionAmount") + SumRowCash)

                    outputString += "</tr>"
                End If
			
                If i = dtTable.Rows.Count - 1 Then
                    If NeedSummary = True Then
                        outputString += "<tr bgColor=""" + BgColor + """>"
                        If Not IsDBNull(dtTable.Rows(i)("OpenStaff")) Then
                            outputString += "<td colspan=""4"" align=""right"" class=""smallText"">Summary for " + dtTable.Rows(i)("OpenStaff") + "</td>"
                        Else
                            outputString += "<td colspan=""4"" align=""right"" class=""smallText"">Summary for " + "-" + "</td>"
                        End If
                        For j = 0 To Summary.Length - 1
                            If Summary(j) <> 0 Then
                                outputString += "<td align=""right"" class=""smallText"">" + Summary(j).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                            Else
                                outputString += "<td align=""right"" class=""smallText"">" + Zero.ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                            End If
                        Next
                        outputString += "</tr>"
                    End If
                Else
                    If (NeedSummary = True And dtTable.Rows(i)("OpenStaffID") <> dtTable.Rows(i + 1)("OpenStaffID")) Then
                        outputString += "<tr bgColor=""" + BgColor + """>"
                        If Not IsDBNull(dtTable.Rows(i)("OpenStaff")) Then
                            outputString += "<td colspan=""4"" align=""right"" class=""smallText"">Summary for " + dtTable.Rows(i)("OpenStaff") + "</td>"
                        Else
                            outputString += "<td colspan=""4"" align=""right"" class=""smallText"">Summary for " + "-" + "</td>"
                        End If
                        For j = 0 To Summary.Length - 1
                            If Summary(j) <> 0 Then
                                outputString += "<td align=""right"" class=""smallText"">" + Summary(j).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                            Else
                                outputString += "<td align=""right"" class=""smallText"">" + Zero.ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                            End If
                        Next
                        outputString += "</tr>"
                    End If
                End If

                DummyOpenStaffID = dtTable.Rows(i)("OpenStaffID")
                DummySessionID = dtTable.Rows(i)("SessionID")
                DummyComputerID = dtTable.Rows(i)("ComputerID")
            Next
            outputString += "<tr><td colspan=""" + (counter + 9 + CashInOutCount + manualVoidQRCount).ToString + """ height=""10""></td></tr>"
            outputString += "<tr>"
            outputString += "<td colspan=""4"" align=""right"" class=""smallText"">Grand Total</td>"
            For j = 0 To sumTotal.Length - 1
                If sumTotal(j) <> 0 Then
                    If CashInOutFeature = True And j = (counter + 2) Then
                        outputString += "<td align=""right"" class=""smallText""><a class=""smallText"" href=""JavaScript: newWindow = window.open( 'CashInOut_Details.aspx?CashMovement=1&SessionID=0&ComputerID=0&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=900,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(sumTotal(j), "##,##0.00;(##,##0.00)") + "</a></td>"
                    ElseIf CashInOutFeature = True And j = (counter + 3) Then
                        outputString += "<td align=""right"" class=""smallText""><a class=""smallText"" href=""JavaScript: newWindow = window.open( 'CashInOut_Details.aspx?CashMovement=-1&SessionID=0&ComputerID=0&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "', '', 'width=900,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(sumTotal(j), "##,##0.00;(##,##0.00)") + "</a></td>"
                    Else
                        outputString += "<td align=""right"" class=""smallText"">" + sumTotal(j).ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                    End If
                Else
                    outputString += "<td align=""right"" class=""smallText"">" + Zero.ToString(FormatObject.CurrencyFormat, ci) + "</td>"
                End If
            Next
            outputString += "</tr>"
            ResultText.InnerHtml = outputString
            Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"
        End If
    End Sub

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "SesionStaff_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
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
