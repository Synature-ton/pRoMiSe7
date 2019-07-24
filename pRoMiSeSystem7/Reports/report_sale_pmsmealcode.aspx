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
<title>Sale Report By Meal Code</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script language="JavaScript" src="../StyleSheet/webscript.js"></script> 
</head>
<body>
<div id="showPage" visible="true" runat="server">

<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<input type="hidden" id="DisplayVAT" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Sale Report By Meal Code" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
				<td><asp:DropDownList ID="ShopInfo" CssClass="text" Width="200" AutoPostBack="true" OnSelectedIndexChanged="SelPMSMealCode" runat="server"></asp:DropDownList></td>
			</tr>
			<tr>
				<td><asp:DropDownList ID="MealCodeInfo" Width="200" CssClass="text" runat="server"></asp:DropDownList></td>
			</tr>
            <tr>
				<td><asp:radiobutton ID="optReportByBill" GroupName="ReportSelectView" CssClass="text" runat="server" /></td>
			</tr>
			<tr>
				<td><asp:radiobutton ID="optReportByProduct" GroupName="ReportSelectView" CssClass="text" runat="server" /></td>
			</tr>
         </table></td>
	<td>
	<table>
		<tr>
		    <td><asp:radiobutton ID="optDailyDate" GroupName="ReportSelectDateGroup" runat="server" /></td>
		    <td><synature:date id="DailyDate" runat="server" /></td>
            <td colspan="2"><asp:CheckBox ID="chkExpandReceipt" CssClass="text" Checked="false" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="optMonthlyDate" GroupName="ReportSelectDateGroup" runat="server" /></td>
		<td><synature:date id="MonthYearDate" runat="server" /></td>
        <td colspan="2"><asp:radiobutton ID="Linechart" Text="Line Chart" Checked="true" GroupName="Group3" CssClass="text" runat="server" />
		&nbsp;<asp:radiobutton ID="Barchart" Text="Column Chart" GroupName="Group3" CssClass="text" runat="server" /></td>

		</tr>
		<tr>
		<td><asp:radiobutton ID="optRangeDate" GroupName="ReportSelectDateGroup" runat="server" /></td>
		<td><synature:date id="CurrentDate" runat="server" /></td>
		<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
		<td><synature:date id="ToDate" runat="server" /></td>
	</tr>
	<tr><td>&nbsp;</td>
		<td colspan="4" class="text"><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" />
            &nbsp;<asp:CheckBox ID="DisplayGraph" CssClass="text" Checked="true" runat="server" /></td>
	</tr>
	</table>
	</td>
</tr>


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
<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>
<span id="startTable" runat="server"></span>
    	<span id="TableHeaderText" runat="server"></span>
        <span id="ExtraHeader" runat="server"></span>
		<div id="ResultText" runat="server"></div>
 	    <div id="SummaryResult" runat="server"></div>

<asp:Panel ID="showGraph" Visible="false" runat="server">
<br>
<Web:ChartControl id="ChartControl1" ChartPadding=40 runat="Server" />
    </asp:Panel></td></tr>
</table>
    </span>
<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table>
</form>
</div>
<div id="errorMsg" class="boldText" runat="server" />
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
    Dim getReport As New GenReports
    Dim reports As New POSBackOfficeReport.BackOfficeReport

Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
    Dim SaleReportPageID As Integer = 6
    Dim MealCodeSalePageID As Integer = 104


Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Report_Sale_New") Then
		
            Try
                objCnn = getCnn.EstablishConnection()

                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
                ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
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
                Dim LangData As DataTable = getProp.GetLang(LangListText, LangListData, PageName & "?ID" & Request.QueryString("ID") & "&Order=" + Request.QueryString("Order") & "&GroupID=" & Request.QueryString("GroupID"), MealCodeSalePageID, 1, -1, Request, objCnn)
                Dim LangText As String = "lang" + Session("LangID").ToString
		
                For z = 0 To LangData.Rows.Count - 1
                    Dim TestLabel = Util.FindControlRecursive(mainForm, "LangText" & z)
                    Try
                        TestLabel.Text = LangData.Rows(z)(LangText)
                    Catch ex As Exception
                    End Try
                Next
                LangList.Text = LangListText
		
                Dim LangData2 As DataTable = getProp.GetLangData(SaleReportPageID, 2, -1, Request)
		
                Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
                If LangDefault.Rows.Count >= 2 Then
                    PrintText.Text = LangDefault.Rows(0)(LangText)
                    Export.Text = LangDefault.Rows(1)(LangText)
                End If
                               
                Dim HeaderString As String = ""
                Dim ShopProp1 As DataTable = getInfo.GetProductLevel(Request.Form("ShopID"), objCnn)
		
                If Request.Form("ShopID") = 0 Then
                    'Set The First Shop's ShopType = 1 When View All Shop, If At Least 1 of All Shop Has ShopType = 1, There is Column that Show Only ShopType = 1
                    If ShopProp1.Rows(0)("ShopType") <> 1 Then
                        For i = 0 To ShopProp1.Rows.Count - 1
                            If ShopProp1.Rows(i)("ShopType") = 1 Then
                                ShopProp1.Rows(0)("ShopType") = 1
                                Exit For
                            End If
                        Next i
                    End If
                End If
		
                If (optReportByBill.Checked = True And (optMonthlyDate.Checked = True Or optRangeDate.Checked = True)) Or _
                    (Request.Form("ShopID") = 0 And optReportByProduct.Checked = False) Or (optReportByBill.Checked = True And optDailyDate.Checked = True And chkExpandReceipt.Checked = False) Then
                    If optReportByBill.Checked = True And optDailyDate.Checked = True And chkExpandReceipt.Checked = False And Request.Form("ShopID") >= 0 Then
                        If Request.Form("ShopID") = 0 Then
                            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(64)(LangText) + "</td>"
                            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(20)(LangText) + "</td>"
                        Else
                            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(18)(LangText) & "</td>"
                        End If
				
                        If ShopProp1.Rows(0)("ShopType") = 1 Then
                            If Request.Form("ShopID") <> 0 Then
                                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(19)(LangText) & "</td>"
                            End If
                            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(21)(LangText) & "</td>"
                        End If

                    Else
                        If Request.Form("ShopID") = 0 Then
                            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(64)(LangText) + "</td>"
                        Else
                            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(65)(LangText) + "</td>"
                        End If
                        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(20)(LangText) + "</td>"
                        If ShopProp1.Rows(0)("ShopType") = 1 Then
                            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(21)(LangText) & "</td>"
                        End If
                    End If
			
                    Dim DisplayVATType As String = "V"
                    If Request.Form("ShopID") >= 0 Then
                        Dim ShopInfo As DataTable
                        If Request.Form("ShopID") = 0 Then
                            ShopInfo = objDB.List("select * from ProductLevel where IsShop=1 AND Deleted=0", objCnn)
                        Else
                            ShopInfo = objDB.List("select * from ProductLevel where ProductLevelID=" + Request.Form("ShopID").ToString, objCnn)
                        End If
                        If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
                            DisplayVATType = "E"
                        End If
                    End If
                    DisplayVAT.Value = DisplayVATType
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(22)(LangText) + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(23)(LangText) + "</td>"
                    If Request.Form("ShopID") >= 0 Then
                        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(24)(LangText) + "</td>"
                    End If
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(25)(LangText) + "</td>"
                    'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(26)(LangText) + "</td>"
                    'If Request.Form("ShopID") >= 0 Then
                    '	If DisplayVATType = "E" Then
                    '		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(27)(LangText) + "</td>"
                    '					HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(28)(LangText) + "</td>"
                    '				End If
                    '			End If

                    '			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(29)(LangText) + "</td>"
                    '			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(30)(LangText) + "</td>"
			
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
				
                If optDailyDate.Checked = True And (optReportByBill.Checked = True) And chkExpandReceipt.Checked = True And Request.Form("ShopID") >= 0 Then
                    startTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(33)(LangText) + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(34)(LangText) + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(36)(LangText) + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(37)(LangText) + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(38)(LangText) + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "" + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(127)(LangText) + "</td>"
                    If GlobalParam.ShowSubmitOrderDetail = True Then
                        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Terminal" + "</td>"
                        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Order Staff" + "</td>"
                        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Order Time" + "</td>"
                    End If
                Else
                    startTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
                End If
		
                TableHeaderText.InnerHtml = HeaderString
                                
                SubmitForm.Text = LangDefault.Rows(3)(LangText)
                DocumentToDateParam.InnerHtml = LangDefault.Rows(22)(LangText)
		
                startTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		
                chkExpandReceipt.Text = LangData2.Rows(6)(LangText)
                DisplayGraph.Text = LangData2.Rows(7)(LangText)

                optReportByBill.Text = LangData2.Rows(0)(LangText)
                optReportByProduct.Text = LangData2.Rows(1)(LangText)
	
		
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
		
                If Not Page.IsPostBack Then
                    optDailyDate.Checked = True
                    optReportByBill.Checked = True
                End If
		
                Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-1, Session("StaffRole"), objCnn)
                If Not Page.IsPostBack Then
                    ShopInfo.DataSource = ShopData
                    ShopInfo.DataValueField = "ProductLevelID"
                    ShopInfo.DataTextField = "ProductLevelName"
                    ShopInfo.DataBind()
			
                    ShowPMSMealCode()
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
        
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
        Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
	
        Dim DateFromValue As String = ""
        Dim DateToValue As String = ""
        Dim DailyDateValue As String = ""
        Dim InvC As CultureInfo = CultureInfo.InvariantCulture
        Dim dtPayType, dtIncomeType As DataTable
        
        Dim StartDate, EndDate As String
        Dim viewReportBy As POSBackOfficeReport.ViewSaleReportBy
        Dim StartMonthValue, StartYearValue, EndMonthValue, EndYearValue As Integer
        Dim outputString As String = ""
        Dim grandTotal As Double = 0
        Dim GraphData As New DataSet()
        Dim ReportDate As String
        Dim i As Integer
        Dim ReportType As String
        
        If optReportByBill.Checked = True Then
            If optDailyDate.Checked = True Then
                ReportType = SaleLangData.Rows(11)(LangText)
            ElseIf optRangeDate.Checked = True Then
                ReportType = SaleLangData.Rows(14)(LangText)
            ElseIf optMonthlyDate.Checked = True Then
                ReportType = SaleLangData.Rows(12)(LangText)
            Else
                ReportType = SaleLangData.Rows(13)(LangText)
            End If
        ElseIf optReportByProduct.Checked = True Then
            ReportType = SaleLangData.Rows(15)(LangText)
        Else
            ReportType = ""
        End If
        
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
        End If
        
        If FoundError = False Then
            If LangDefault.Rows.Count >= 3 Then
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(Now(), "DateAndTime", Session("LangID"), objCnn)
            End If
            Dim dtTable As New DataTable()
		
            ShowPrint.Visible = True
	
         
		
            'Application.Lock()

            Dim k As Integer
            Dim strShop, strMeal As String
            strShop = ""
            strMeal = ""
            If ShopInfo.SelectedItem.Value = "0" Then
                For k = 0 To ShopInfo.Items.Count - 1
                    strShop &= ShopInfo.Items(k).Value & ", "
                Next k
            Else
                strShop = ShopInfo.SelectedItem.Value
            End If
            strShop = " ShopInfoValue = " & strShop
            
            If MealCodeInfo.SelectedItem.Value = "0" Then
                For k = 0 To MealCodeInfo.Items.Count - 1
                    strMeal &= MealCodeInfo.Items(k).Value & ", "
                Next k
            Else
                strMeal = MealCodeInfo.SelectedItem.Value
            End If
            strMeal = " ShopInfoValue = " & strMeal
            
            dtIncomeType = New DataTable
            dtPayType = New DataTable
            errorMsg.InnerHtml = strShop & " : " & strMeal

            
            'reports.PMSMealCode_CreateSaleReport viewreportby
            
            
            '	getReport.SharingSaleReports(dtTable,grandTotal,GraphData, StartDate, EndDate, ShopInfo.SelectedItem.Value,GroupInfo.SelectedItem.Value,DeptInfo.SelectedItem.Value, DisplayGraph.Checked, Session("LangID"),"", objCnn)
		
            'Application.UnLock()
            
            
            Dim strAddionalHeader As String
            Dim HavePrepaid As Boolean = False
            Dim HavePrepaidDiscount As Boolean = False


            strAddionalHeader = ""
            If (optReportByBill.Checked = True And (optMonthlyDate.Checked = True Or optRangeDate.Checked = True)) Or (optReportByBill.Checked = True And optDailyDate.Checked = True And chkExpandReceipt.Checked = False) Then
				
                For i = 0 To dtIncomeType.Rows.Count - 1
                    strAddionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + dtIncomeType.Rows(i)("IncomeName") + "</td>"
                Next
			
                strAddionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + SaleLangData.Rows(26)(LangText) + "</td>"
                If Request.Form("ShopID") >= 0 Then
                    If DisplayVAT.Value = "E" Then
                        strAddionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + SaleLangData.Rows(27)(LangText) + "</td>"
                        strAddionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + SaleLangData.Rows(28)(LangText) + "</td>"
                    End If
                End If
                If DisplayVAT.Value <> "E" Then
                    strAddionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + SaleLangData.Rows(134)(LangText) + "</td>"
                    strAddionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + SaleLangData.Rows(30)(LangText) + "</td>"
                End If
				
                Dim strExtraPayText As String
                For i = 0 To dtPayType.Rows.Count - 1
                    strExtraPayText = ""
                    If dtPayType.Rows(i)("PrepaidDiscountPercent") > 0 Then
                        HavePrepaidDiscount = True
                        strExtraPayText = "<br>Total/Disc"
                    End If
                    strAddionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + dtPayType.Rows(i)("PayTypeName") + strExtraPayText + "</td>"
                    If dtPayType.Rows(i)("IsSale") = 0 Then
                        If PropertyInfo.Rows(0)("SummaryPrepaidInSaleReport") = 1 Then
                            HavePrepaid = True
                        End If
                    End If
                Next
				
                Dim ShopProp1 As DataTable = getInfo.GetProductLevel(Request.Form("ShopID"), objCnn)
                If Request.Form("ShopID") = 0 Then
                    'Set The First Shop's ShopType = 1 When View All Shop, If At Least 1 of All Shop Has ShopType = 1, There is Column that Show Only ShopType = 1
                    If ShopProp1.Rows(0)("ShopType") <> 1 Then
                        For i = 0 To ShopProp1.Rows.Count - 1
                            If ShopProp1.Rows(i)("ShopType") = 1 Then
                                ShopProp1.Rows(0)("ShopType") = 1
                                Exit For
                            End If
                        Next i
                    End If
                End If
                strAddionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + SaleLangData.Rows(31)(LangText) + "</td>"
                strAddionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + SaleLangData.Rows(32)(LangText) + "</td>"
				
                strAddionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & SaleLangData.Rows(88)(LangText) & "</td>"
                If ShopProp1.Rows(0)("ShopType") = 1 Then
                    strAddionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & SaleLangData.Rows(87)(LangText) & "</td>"
                End If
			
                Dim NotInRevenueBit As Boolean = False
                Try
                    NotInRevenueBit = PropertyInfo.Rows(0)("EnableNotInRevenue")
                Catch ex As Exception
                    NotInRevenueBit = False
                End Try
                Try
                    If NotInRevenueBit = True Then
                        Dim NotInRevenueData As DataTable = getReport.NotInRevenueType(objCnn)
                        For i = 0 To NotInRevenueData.Rows.Count - 1
                            strAddionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + NotInRevenueData.Rows(i)("NotInRevenueName") + "</td>"
                        Next
                        strAddionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + SaleLangData.Rows(66)(LangText) + "</td>"
                        HavePrepaidDiscount = True
                    End If
                Catch ex As Exception
                    NotInRevenueBit = False
                End Try
                If HavePrepaidDiscount = True Then
                    strAddionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + SaleLangData.Rows(67)(LangText) + "</td>"
                End If
                If HavePrepaid = True Then
                    strAddionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + SaleLangData.Rows(68)(LangText) + "</td>"
                    strAddionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + SaleLangData.Rows(69)(LangText) + "</td>"
                End If
				
                ExtraHeader.InnerHtml = strAddionalHeader
            End If

            Dim ShopDisplay As String
            If Request.Form("ShopID") = 0 Then
                ShopDisplay = SaleLangData.Rows(70)(LangText)
            Else
                ShopDisplay = SelShopName.Value
            End If
            ResultSearchText.InnerHtml = ReportType + " " + ShopDisplay + " (" + ReportDate + ")"
            
            
            
            
            Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"

            If DisplayGraph.Checked = True And (optDailyDate.Checked = False Or (optDailyDate.Checked = True And Request.Form("ShopID") = 0) Or _
                    (optDailyDate.Checked = True And chkExpandReceipt.Checked = False And Request.Form("GroupByParam") = 2)) And (optReportByBill.Checked = True) Then
                showGraph.Visible = True
                Dim view As DataView = GraphData.Tables(0).DefaultView
				
                If view.Count > 0 Then
                    If Barchart.Checked = True Then
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
                        ConfigureColors(ReportType & " " + ShopDisplay + " (" + ReportDate + ")")
			
                        ChartControl1.RedrawChart()
                    Else
                        Dim chart As New SmoothLineChart()
                        chart.Fill.Color = Color.FromArgb(80, Color.SpringGreen)
                        chart.Line.Color = Color.SteelBlue
                        chart.Line.Width = 2
                        chart.ShowLegend = True
                        chart.DataSource = view
                        chart.DataXValueField = "Description"
                        chart.DataYValueField = "Value1"
                        chart.DataBind()
                        ChartControl1.Charts.Add(chart)
                        ConfigureColors(ReportType & " " + ShopDisplay + " (" + ReportDate + ")")
			
                        ChartControl1.RedrawChart()

                    End If
                Else
                    showGraph.Visible = False
                End If
            ElseIf optReportByProduct.Checked = True And DisplayGraph.Checked = True Then
                showGraph.Visible = True
			
                Dim view As DataView = GraphData.Tables(0).DefaultView
                If view.Count > 0 Then
                    Dim chart As New PieChart()
                    chart.Explosion = 3
                    chart.Fill.Color = Color.FromArgb(80, Color.SpringGreen)
                    chart.Line.Color = Color.SteelBlue
                    chart.Line.Width = 1
                    chart.ShowLegend = True
                    chart.DataLabels.Visible = True
                    chart.DataSource = view
                    chart.DataXValueField = "Description"
                    chart.DataYValueField = "Value1"
                    chart.DataBind()
                    ChartControl1.Charts.Add(chart)
                    ConfigureColors(ReportType + " " + ShopDisplay + " (" + ReportDate + ")")
        
                    ChartControl1.RedrawChart()
                End If
            Else
                showGraph.Visible = False
            End If
            
        End If
    End Sub

 Sub ConfigureColors(TitleName)
        	'ChartControl1.Background.Color = Color.FromArgb(75, Color.SteelBlue)
			Dim ChartWidth As Integer = 700
			Dim ChartHeight As Integer = 550
			
			
            ChartControl1.Background.Type = InteriorType.LinearGradient
            ChartControl1.Background.ForeColor = Color.SteelBlue
            ChartControl1.Background.EndPoint = new Point(ChartWidth, ChartHeight) 
            ChartControl1.Legend.Position = LegendPosition.Bottom
           ' 'ChartControl1.Legend.Width = 40
			ChartControl1.Width = Unit.Parse(ChartWidth.ToString + "px")
			ChartControl1.Height = Unit.Parse(ChartHeight.ToString + "px")
 
            ChartControl1.YAxisFont.ForeColor = Color.SteelBlue
            ChartControl1.XAxisFont.ForeColor = Color.SteelBlue
            
            ChartControl1.ChartTitle.Text = TitleName
            ChartControl1.ChartTitle.ForeColor = Color.White
      
            ChartControl1.Border.Color = Color.SteelBlue
            'ChartControl1.BorderStyle = BorderStyle.Ridge
    End Sub

Sub SelPMSMealCode(sender As Object, e As System.EventArgs)
	ShowPMSMealCode()
End Sub	
	
Sub ShowPMSMealCode()
	Dim i As Integer
	Dim dtMealCode As DataTable = New DataTable("MealCode")
	dtMealCode.Columns.Add("MealName")
	dtMealCode.Columns.Add("MealCode", GetType(String))
	Dim mealRow As DataRow = dtMealCode.NewRow()
	Dim dtData As New DataTable()
        dtData = reports.PMSMealCodeSale_ListPMSMealCode(objCnn, ShopInfo.SelectedItem.Value)
	mealRow("MealName") = "-- Display All Meal --"
	mealRow("MealCode") = "0"
	dtMealCode.Rows.Add(mealRow)
	For i = 0 To dtData.Rows.Count - 1
		mealRow = dtMealCode.NewRow()
		mealRow("MealName") = dtData.Rows(i)("MealName")
		mealRow("MealCode") = dtData.Rows(i)("MealCode")
		dtMealCode.Rows.Add(mealRow)
	Next i
	
	MealCodeInfo.DataSource = dtMealCode
	MealCodeInfo.DataValueField = "MealCode"
	MealCodeInfo.DataTextField = "MealName"
	MealCodeInfo.DataBind()
End Sub	
	
Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "SaleSharingData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
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
