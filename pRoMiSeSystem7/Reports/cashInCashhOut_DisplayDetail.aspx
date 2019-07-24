<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSBackOfficeReport" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Cash In/ Out Report</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:#FFF">
<div id="showPage" visible="true" runat="server">

<form id="mainForm" runat="server">

<table width="100%">
<tr>
<td align="left"><div class="headerText" align="left" id="HeaderText" runat="server" /></td>
<td align="right"><div class="noprint"><div class="text"><a href="javascript: window.print()">Print</a> | 
    <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton> | 
    <a href="javascript: window.close()">Close</a></div></div></td>
</tr>
</table>

    <div id="ResultSearchText" align="center" class="boldText" runat="server"></div>

<div align="center"><br>
<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
    <div id="TableHeaderText" runat="server"></div>
	<div id="ResultText" runat="server"></div>
</table></div>

 </form>
</div>
<div id="errorMsg" runat="server" />

<script language="VB" runat="server">

    Dim objCnn As New MySqlConnection()
    Dim getCnn As New CDBUtil()
    Dim Util As New UtilityFunction()
    Dim getPageText As New DefaultText()
    Dim getInfo As New CCategory()
    Dim DateTimeUtil As New MyDateTime()
    Dim getProp As New CPreferences()
    Dim getCat As New CCategory
    Dim objDB As New CDBUtil()
    Dim InvC As CultureInfo = CultureInfo.InvariantCulture
    Dim getReport As New BackOfficeReport()
    Dim SaleReportPageID As Integer = 6
    Dim CashInOutPageID As Integer = 100
    
Sub Page_Load()
	'If User.Identity.IsAuthenticated  AND Session("Report_Voucher") Then
		
	'Try	
		
		objCnn = getCnn.EstablishConnection()
        Dim LangCashOutData As DataTable = getProp.GetLangData(CashInOutPageID, 2, -1, Request)
        Dim LangData2 As DataTable = getProp.GetLangData(SaleReportPageID, 2, -1, Request)
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
        
        Dim LangPath As String = Util.GetLangPath(Request.PhysicalApplicationPath)
        Dim strHeader As String
        Dim selShopID As Integer
        Dim dStartDate, dEndDate As Date
        Dim dtResult As DataTable
        
        'Create Report Header
        strHeader = Request.QueryString("ShopID")
        If Not IsNumeric(strHeader) Then
            selShopID = 0
        Else
            selShopID = strHeader
        End If
        
        dtResult = getCat.GetProductLevel(selShopID, objCnn)
        
        strHeader = BackOfficeReport.GetLanguageText(LangCashOutData, 15, LangText, "รายงาน Cash In/ Out ของ")
        If dtResult.Rows.Count > 0 Then
            strHeader &= " " & dtResult.Rows(0)("ProductLevelName")
        End If
               
        'Get Start - End Date        
        dStartDate = Date.MinValue
        dEndDate = Date.MinValue
        
        getReport.GetDateFromStartEndMySQLDateString(objCnn, Request.QueryString("StartDate"), Request.QueryString("EndDate"), dStartDate, dEndDate)
        
        'End Day always > 1, adjust date
        If dEndDate <> Date.MinValue Then
            dEndDate = dEndDate.AddDays(-1)
        End If
        If dStartDate <> Date.MinValue And dEndDate <> Date.MinValue Then
            If dStartDate = dEndDate Then
                strHeader &= " (" & DateTimeUtil.FormatDateTime(dStartDate, "DateOnly", Session("LangID"), objCnn) & ")"
            Else
                strHeader &= " (" & DateTimeUtil.FormatDateTime(dStartDate, "DateOnly", Session("LangID"), objCnn) & " - " & _
                                    DateTimeUtil.FormatDateTime(dEndDate, "DateOnly", Session("LangID"), objCnn) & ")"
            End If
        End If
        ResultSearchText.InnerHtml = strHeader
        
        Dim HeaderString As String = ""
        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangCashOutData, 3, LangText, "วันที่") & "</td>"
		
        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangCashOutData, 4, LangText, "เลขที่ Cash In/Out") & "</td>"

        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangCashOutData, 12, LangText, "รายการ") & "</td>"
        'CashOutAmount				
        If getProp.CheckColumnExist("CashOutOrderDetail", "CashOutAmount", objCnn) = True Then
            HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangData2, 37, LangText, "จำนวน") & "</td>"
        End If
        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangCashOutData, 10, LangText, "ราคา") & "</td>"
				
        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangCashOutData, 5, LangText, "เลขที่อ้างอิง") & "</td>"

        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangCashOutData, 6, LangText, "หมายเหตุ") & "</td>"

        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangCashOutData, 13, LangText, "พนักงาน") & "</td>"

        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangCashOutData, 14, LangText, "เวลาทำรายการ") & "</td>"
           
        TableHeaderText.InnerHtml = HeaderString
              
        'View CashInOutType = 0, ViewOption = 2 (Date Range)
        ResultText.InnerHtml = getReport.CashInOutReport(GlobalParam.GrayBGColor, GlobalParam.AdminBGColor, Session("LangID"), True, False, _
                                     0, 2, Request.QueryString("StartDate"), Request.QueryString("EndDate"), selShopID, _
                                     0, 0, False, LangPath, Session("StaffRole"), objCnn)

        'Create Table Tag For Header/ Result Text
        strHeader = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
        Session("CashInOutDisplayDetailResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr>" & _
                                                "<tr><td>" & strHeader & _
                                                "<tr>" & TableHeaderText.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"
        
        
        'Application.UnLock()
        'Catch ex As Exception
        'errorMsg.InnerHtml = ex.Message
        'End Try
	  
        '	Else
        '		showPage.Visible = False
        '		errorMsg.InnerHtml = "Access Denied"
        '	End If
    End Sub

    Sub ExportData(Source As Object, E As EventArgs)
	
        Dim FileName As String = "CashInOutData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
        Dim OutputText As String = ""
        Dim CSSFile As String = Replace(UCase(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))), "REPORTS", "") & "StyleSheet\admin.css"
	
        Util.ExportData(Session("CashInOutDisplayDetailResult"), FileName, CSSFile, GlobalParam.ExportCharSet, -1)
    End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
