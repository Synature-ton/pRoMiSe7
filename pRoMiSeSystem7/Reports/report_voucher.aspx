<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Voucher/Coupon Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="../StyleSheet/webscript.js"></script> 
</head>
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
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
<span id="showCriteria" runat="server">
<table>
<tr id="ShowShop" runat="server">
	<td colspan="2"><span id="SelectShop" class="text" runat="server"></span></td>
	<td><span id="ShopText" runat="server"></span></td>
	<td colspan="2"><span class="text"><asp:Label ID="LangText1" Text="Coupon/Voucher" runat="server" /></span></td>
	<td colspan="4" class="text"><asp:textbox ID="VoucherHeader" MaxLength="10" Width="70" runat="server" /> / <asp:textbox ID="VoucherNumber" Width="120" runat="server" /> <asp:Label ID="LangText2" Text="You can use , as number list" runat="server" /></td>
</tr>
<tr>
	<td align="right" valign="middle"><div id="DocumentDateParam" class="text" runat="server"></div></td>
	<td><asp:radiobutton ID="optMonthly" GroupName="Group1" runat="server" /></td>
	<td><synature:date id="MonthYearDate" runat="server" /></td>
	<td>&nbsp;</td>
	<td align="right"><asp:radiobutton ID="optDateRange" GroupName="Group1" runat="server" /></td>
	<td><synature:date id="CurrentDate" runat="server" /></td>
	<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
	<td><synature:date id="ToDate" runat="server" /></td>

</tr>

<tr>
	<td colspan="2">&nbsp;</td>
	<td colspan="2"><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
	<td class="text" colspan="4">&nbsp;</td>
</tr>

</table>
</span>
</div>
<br>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr>
</table>
<span id="MyTable">
<table width="100%">
<tr><td align="center"><div id="ResultSearchText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>
<span id="startTable" runat="server"></span>
	
	<div id="ResultText" runat="server"></div>
</table></td></tr>
</table></span>
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
Dim Fm As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer = 20

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Report_Voucher") Then
		
            Try
                objCnn = getCnn.EstablishConnection()
                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
                ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
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
		
                ResultText.InnerHtml = ""
                ResultSearchText.InnerHtml = ""
                errorMsg.InnerHtml = ""
		
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
		
                If Not Page.IsPostBack Then
                    optDateRange.Checked = True
                End If

                Dim ShopIDValue As String = "0"
                If IsNumeric(Request.Form("ShopID")) Then
                    ShopIDValue = Request.Form("ShopID").ToString
                ElseIf IsNumeric(Request.QueryString("ShopID")) Then
                    ShopIDValue = Request.QueryString("ShopID").ToString
                End If


                SelectShop.InnerHtml = LangData2.Rows(0)(LangText)

                Dim i As Integer
                Dim outputString, FormSelected As String
			
                Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), objCnn)
                If ShopData.Rows.Count > 0 Then
                    outputString = "<select name=""ShopID"">"
                    If ShopData.Rows.Count > 1 Then
                        If Not Page.IsPostBack Then
                            FormSelected = "selected"
                            'SelShopName.Value = "All Shops"
                        ElseIf ShopIDValue = 0 Then
                            FormSelected = "selected"
                            'SelShopName.Value = "All Shops"
                        Else
                            FormSelected = ""
                        End If
                        outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & "--- All Shops ---"
                    End If
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
                    ShowShop.Visible = True
                Else
                    ShowShop.Visible = False
                End If
			
                showCriteria.Visible = True
			
                If Not Request.QueryString("FromSale") Is Nothing Then
                    Dim dtTable As DataTable = getReport.VoucherReports(Session("LangID"), False, True, 0, 0, Request.QueryString("StartDate"), Request.QueryString("EndDate"), Request.QueryString("ShopID"), "", "", objCnn)
                    GenerateReport(dtTable)
                    showCriteria.Visible = False
                    LangList.Text = ""
                    ShowPrint.Visible = True
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
	
        Dim DateFromValue As String = ""
        Dim DateToValue As String = ""
        Try
            If optDateRange.Checked = True Then
                DateFromValue = DateTimeUtil.FormatDate(Request.Form("Doc_Day"), Request.Form("Doc_Month"), Request.Form("Doc_Year"))
		
                Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
                CheckDate = DateAdd("d", 1, CheckDate)
                DateToValue = DateTimeUtil.FormatDate(Day(CheckDate), Month(CheckDate), CheckDate.ToString("yyyy", InvC))
		
                'DateToValue = DateTimeUtil.FormatDate(Request.Form("DocTo_Day"),Request.Form("DocTo_Month"),Request.Form("DocTo_Year"))
		
                If Trim(DateFromValue) = "InvalidDate" Or Trim(DateToValue) = "InvalidDate" Then
                    ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
                    FoundError = True
                    DateFromValue = ""
                    DateToValue = ""
                Else
                    ResultSearchText.InnerHtml = ""
                End If
            Else
                DateFromValue = ""
                DateToValue = ""
            End If
            If optMonthly.Checked = True Then
                If Not (IsNumeric(Request.Form("MonthYearDate_Month")) And IsNumeric(Request.Form("MonthYearDate_Year"))) Then
                    FoundError = True
                End If
            End If
        Catch ex As Exception
            FoundError = True
        End Try
	
        If FoundError = False Then
            If LangDefault.Rows.Count >= 3 Then
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(Now(), "DateAndTime", Session("LangID"), objCnn)
            End If
            ShowPrint.Visible = True
            Dim displayTable As New DataTable()
			
            Dim FormatData As DataTable = Fm.FormatParam(FormatObject, Session("LangID"), objCnn)
            Dim ci As New CultureInfo(FormatObject.CultureString)

            Dim outputString As String = ""
            Dim ShowSaleDate As String = ""
            Dim bgColor As String = "e9e9e9"
            Dim SelMonth As Integer = 0
            Dim SelYear As Integer = 0
            Dim strSelShopID As String
            Dim i As Integer
		
            If IsNumeric(Request.Form("MonthYearDate_Month")) Then SelMonth = Request.Form("MonthYearDate_Month")
            If IsNumeric(Request.Form("MonthYearDate_Year")) Then SelYear = Request.Form("MonthYearDate_Year")
            'Application.Lock()
            
            i = Request.Form("ShopID")
            If i = 0 Then
                'All Shop
                Dim dtShopData As DataTable = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), objCnn)
                strSelShopID = ""
                For i = 0 To dtShopData.Rows.Count - 1
                    strSelShopID &= dtShopData.Rows(i)("ProductLevelID") & ", "
                Next i
                strSelShopID &= "0"
            Else
                strSelShopID = i
            End If

            Dim dtTable As DataTable = getReport.VoucherReports(Session("LangID"), optMonthly.Checked, optDateRange.Checked, SelMonth, SelYear, _
                                                 DateFromValue, DateToValue, strSelShopID, Trim(VoucherHeader.Text), Trim(VoucherNumber.Text), objCnn)
            'Application.UnLock()
            GenerateReport(dtTable)
        End If
    End Sub

    Public Function GenerateReport(ByVal dtTable As DataTable) As String
        Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
	
        Dim i As Integer
		
        Dim FormatData As DataTable = Fm.FormatParam(FormatObject, Session("LangID"), objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)

        Dim strBuild As StringBuilder
        Dim counter As Integer
        Dim ShowSaleDate As String = ""
        Dim bgColor As String = "e9e9e9"
        Dim TypeHeader, TypeString, CouponNumber As String
		
        Dim DummyTypeID As Integer = -1
        Dim TotalAmount As Double = 0
        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
        Dim strSystemHeaderText, strReceiptNo As String
        Dim ReceiptHeaderData As DataTable
        ReceiptHeaderData = getInfo.GetDocType(1, 0, 8, Session("LangID"), objCnn)

        strSystemHeaderText = ""
        If ReceiptHeaderData.Rows.Count > 0 Then
            If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
                strSystemHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
            End If
        End If
		
        Dim DigitRunning As Integer
        Dim ChkRunning As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramtypeID = 1 AND PropertyID = 29 AND KeyID = 1", objCnn)
        If ChkRunning.Rows.Count > 0 Then
            If ChkRunning.Rows(0)("PropertyValue") > 5 Then
                DigitRunning = ChkRunning.Rows(0)("PropertyValue")
            End If
        End If
		
        Dim ColSpan As String = "8"
        strBuild = New StringBuilder
        TypeHeader = ""
        For i = 0 To dtTable.Rows.Count - 1
            If dtTable.Rows(i)("VTypeID") <> DummyTypeID Then
                TotalAmount = 0
                If dtTable.Rows(i)("VTypeID") = 4 Then
                    TypeHeader = LangData2.Rows(1)(LangText)
                    TypeString = LangData2.Rows(2)(LangText)
                ElseIf dtTable.Rows(i)("VTypeID") = 5 Then
                    TypeHeader = LangData2.Rows(3)(LangText)
                    TypeString = LangData2.Rows(4)(LangText)
                Else
                    TypeHeader = LangData2.Rows(5)(LangText)
                    TypeString = LangData2.Rows(6)(LangText)
                End If
				
                strBuild.Append("<tr>")
                strBuild.Append("<td colspan=""" & ColSpan & """ align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" & TypeHeader & "</td>")
                strBuild.Append("</tr>")
                strBuild.Append("<tr>")
                strBuild.Append("<td class=""tdHeader"" align=""center"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "#" + "</td>")
                strBuild.Append("<td class=""tdHeader"" align=""center"" bgColor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(7)(LangText) + "</td>")
                strBuild.Append("<td class=""tdHeader"" align=""center"" bgColor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(8)(LangText) + "</td>")
                strBuild.Append("<td class=""tdHeader"" align=""center"" bgColor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(9)(LangText) + "</td>")
                strBuild.Append("<td class=""tdHeader"" align=""center"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Receipt Amount" + "</td>")
                strBuild.Append("<td class=""tdHeader"" align=""center"" bgColor=""" + GlobalParam.AdminBGColor + """>" + TypeString + "</td>")
                strBuild.Append("<td class=""tdHeader"" align=""center"" bgColor=""" + GlobalParam.AdminBGColor + """>" + TypeHeader + " " + "Amount" + "</td>")
                strBuild.Append("<td class=""tdHeader"" align=""center"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Authorized By" + "</td>")
                strBuild.Append("</tr>")
            counter = 1
            End If
            strReceiptNo = ""
            If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
                If Not IsDBNull(dtTable.Rows(i)("DocumentTypeHeader")) Then
                    strReceiptNo = dtTable.Rows(i)("DocumentTypeHeader")
                End If
            Else
                strReceiptNo = strSystemHeaderText
            End If
            If IsDBNull(dtTable.Rows(i)("ReceiptID")) Or IsDBNull(dtTable.Rows(i)("ReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("ReceiptYear")) Then
                strReceiptNo = "-"
            Else
                strReceiptNo = pRoMiSeUtil.pRoMiSeUtil.GetReceiptHeader(strReceiptNo, dtTable.Rows(i)("ReceiptYear"), dtTable.Rows(i)("ReceiptMonth"), _
                                                        dtTable.Rows(i)("ReceiptID"))
            End If
            ShowSaleDate = DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly", Session("LangID"), objCnn)
			
            'If dtTable.Rows(i)("VTypeID") = 4 Then
            'maxNum = dtTable.Rows(i)("VoucherID") + 1000000
            'CouponNumber = dtTable.Rows(i)("VoucherHeader") + "/" + Right(maxNum.ToString, 6)
            'Else If dtTable.Rows(i)("VTypeID") = 5 Then
            'maxNum = dtTable.Rows(i)("VoucherID") + 1000000
            'CouponNumber = dtTable.Rows(i)("VoucherHeader") + "/" + Right(maxNum.ToString, 6)
            'ElseIf Not IsDBNull(dtTable.Rows(i)("CashCouponNumber")) 
            'CouponNumber = dtTable.Rows(i)("CashCouponNumber")
            'Else
            'CouponNumber = "N/A"
            'End If
            CouponNumber = ""
            If Not IsDBNull(dtTable.Rows(i)("CouponVoucherNo")) Then
                CouponNumber = dtTable.Rows(i)("CouponVoucherNo")
            End If
            strBuild.Append("<tr>")
            strBuild.Append("<td align=""center"" class=""text"">" & counter.ToString & "</td>")
            'Shop Name
            strBuild.Append("<td align=""left"" class=""text"">" & dtTable.Rows(i)("ProductLevelName") & "</td>")
            'Sale Date
            strBuild.Append("<td align=""left"" class=""text"">" & ShowSaleDate & "</td>")
            'Receipt No
            If strReceiptNo <> "-" Then
                strBuild.Append("<td align=""left"" class=""text""><a href=""JavaScript: newWindow = window.open( '../Reports/BillDetails.aspx?ComputerID=" & _
                        dtTable.Rows(i)("ComputerID").ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "&ShopID=" + dtTable.Rows(i)("ShopID").ToString & _
                        "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & _
                        strReceiptNo & "</a></td>")
            Else
                strBuild.Append("<td align=""left"" class=""text"">" & strReceiptNo & "</td>")
            End If
            'SalePrice
            strBuild.Append("<td align=""right"" class=""text"">" & CDbl(dtTable.Rows(i)("ReceiptSalePrice")).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
            'Coupon No
            strBuild.Append("<td align=""right"" class=""text"">" & CouponNumber & "</td>")
            'Use Amount
            strBuild.Append("<td align=""right"" class=""text"">" & CDbl(dtTable.Rows(i)("UsedAmount")).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
            'Authorize Staff
            If Not IsDBNull(dtTable.Rows(i)("AuthorizeStaff")) Then
                strBuild.Append("<td align=""right"" class=""text"">" & dtTable.Rows(i)("AuthorizeStaff") & "</td>")
            Else
                strBuild.Append("<td align=""right"" class=""text"">" & "-" & "</td>")
            End If
            strBuild.Append("</tr>")
            counter = counter + 1
            TotalAmount += dtTable.Rows(i)("UsedAmount")
            DummyTypeID = dtTable.Rows(i)("VTypeID")
			
            'Summary Line
            If i = dtTable.Rows.Count - 1 Then
                strBuild.Append("<tr>")
                strBuild.Append("<td align=""right"" class=""text"" colspan=""6"">" & "Total for " & TypeHeader & "</td>")
                strBuild.Append("<td align=""right"" class=""text"">" & CDbl(TotalAmount).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
                strBuild.Append("<td align=""right"" class=""text"">" & "" & "</td>")
                strBuild.Append("</tr>")
            ElseIf DummyTypeID <> dtTable.Rows(i + 1)("VTypeID") Then
                strBuild.Append("<tr>")
                strBuild.Append("<td align=""right"" class=""text"" colspan=""6"">" & "Total for " & TypeHeader & "</td>")
                strBuild.Append("<td align=""right"" class=""text"">" & CDbl(TotalAmount).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
                strBuild.Append("<td align=""right"" class=""text"">" & "" & "</td>")
                strBuild.Append("</tr>")
            End If

        Next
        If dtTable.Rows.Count = 0 Then
            strBuild.Append("<tr><td class=""boldText"" colspan=""" + ColSpan + """>" + LangDefault.Rows(26)(LangText) + "</td></tr>")
        End If
        
        ResultText.InnerHtml = strBuild.ToString
		
        Session("ReportResult") = startTable.InnerHtml & ResultText.InnerHtml & "</table>"
    End Function

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "CouponData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
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
