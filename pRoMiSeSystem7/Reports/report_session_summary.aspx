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
<title>Session Summary Reports</title>
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
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Session Summary Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
			</tr>
			<tr>
				<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
			</tr>

		</table></td>
	<td>
	<table>
		<tr>
			<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
			<td colspan="3"><synature:date id="DailyDate" runat="server" /></td></td>
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
	
	</table>
	</td>
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
Dim Reports As New ReportV6()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer  = 998

Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Reports_SummarySession") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
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
			Dim TestLabel =	Util.FindControlRecursive(mainForm,"LangText" & z)
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
		
		DocumentToDateParam.InnerHtml =LangDefault.Rows(22)(LangText)
			
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
		
		StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		
		Dim HeaderString As String = ""
		
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Date</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Staff</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Terminal</td>"		
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Open Time</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Close Time</td>"
		TableHeaderText.InnerHtml = HeaderString
		
		If IsNumeric(Request.Form("DocDaily_Day")) Then 
			Session("DocDailyDay") = Request.Form("DocDaily_Day")
		Else If IsNumeric(Request.QueryString("DocDaily_Day")) Then 
			Session("DocDailyDay") = Request.QueryString("DocDaily_Day")
		Else If Trim(Session("DocDailyDay")) = "" Then
			Session("DocDailyDay") = DateTime.Now.Day
		Else If Trim(Session("DocDailyDay")) = 0 And Not Page.IsPostBack Then
			Session("DocDailyDay") = DateTime.Now.Day
		End If
		If Page.IsPostBack AND Request.Form("DocDaily_Day") = "" Then Session("DocDailyDay") = 0
		DailyDate.SelectedDay = Session("DocDailyDay")
		
		
		If IsNumeric(Request.Form("DocDaily_Month")) Then 
			Session("DocDaily_Month") = Request.Form("DocDaily_Month")
		Else If IsNumeric(Request.QueryString("DocDaily_Month")) Then 
			Session("DocDaily_Month") = Request.QueryString("DocDaily_Month")
		Else If Trim(Session("DocDaily_Month")) = "" Then
			Session("DocDaily_Month") = DateTime.Now.Month
		Else If Trim(Session("DocDaily_Month")) = 0 And Not Page.IsPostBack Then
			Session("DocDaily_Month") = DateTime.Now.Month
		End If
		If Page.IsPostBack AND Request.Form("DocDaily_Month") = "" Then Session("DocDaily_Month") = 0
		DailyDate.SelectedMonth = Session("DocDaily_Month")
		
		If IsNumeric(Request.Form("DocDaily_Year")) Then 
			Session("DocDaily_Year") = Request.Form("DocDaily_Year")
		Else If IsNumeric(Request.QueryString("DocDaily_Year")) Then 
			Session("DocDaily_Year") = Request.QueryString("DocDaily_Year")
		Else If Trim(Session("DocDaily_Year")) = "" Then
			Session("DocDaily_Year") = DateTime.Now.Year
		Else If Trim(Session("DocDaily_Year")) = 0 And Not Page.IsPostBack Then
			Session("DocDaily_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("DocDaily_Year") = "" Then Session("DocDaily_Year") = 0
		DailyDate.SelectedYear = Session("DocDaily_Year")
		
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

		Dim ShopIDValue As String = "0"
		If IsNumeric(Request.Form("ShopID")) Then
			ShopIDValue = Request.Form("ShopID").ToString
		Else If IsNumeric(Request.QueryString("ShopID"))
			ShopIDValue = Request.QueryString("ShopID").ToString
		End If
		
		If Not Page.IsPostBack Then
			Radio_3.Checked = True
		End If
		
		Dim i As Integer
		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		
		Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
		If ShopData.Rows.Count > 0 Then

			outputString = "<select name=""ShopID"">"
			
			If ShopData.Rows.Count > 1 Then
				If Not Page.IsPostBack Then 
					FormSelected = "selected"
					SelShopName.Value = "All Shops"
				ElseIf ShopIDValue = 0 Then
					FormSelected = "selected"
					SelShopName.Value = "All Shops"
				Else
					FormSelected = ""
				End If
				outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & "--- All Shops ---"

			End If
			
			For i = 0 to ShopData.Rows.Count - 1
				If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
					FormSelected = "selected"
					SelShopName.Value = ShopData.Rows(i)("ProductLevelName")
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
            'Reports.CheckConfigReport(1,objCnn)
            If LangDefault.Rows.Count >= 3 Then
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(Now(), "DateAndTime", Session("LangID"), objCnn)
            End If
            ShowPrint.Visible = True
            Dim displayTable As New DataTable()
            Dim dtTable As New DataTable()

            'Application.Lock()
		
            ResultSearchText.InnerHtml = "Session Summary Report of " + SelShopName.Value + " (" + ReportDate + ")"
            'Application.UnLock()
	
            Dim bolManualVoidQR As Boolean
            Dim manualVoidQRCount As Integer
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
            Dim ShopData As DataTable
            Dim ShopIDListValue As String = ""
            Dim ii As Integer
            If Request.Form("ShopID") = "0" Then
                ShopData = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), objCnn)
                For ii = 0 To ShopData.Rows.Count - 1
                    ShopIDListValue += "," + ShopData.Rows(ii)("ProductLevelID").ToString
                Next
                If ShopIDListValue <> "" Then ShopIDListValue = "0" + ShopIDListValue
            Else
                ShopIDListValue = Request.Form("ShopID").ToString
                ShopData = objDB.List("select * from ProductLevel where ProductLevelID=" + Request.Form("ShopID").ToString, objCnn)
            End If
		
            Dim PayTypeData As DataTable = getReport.SessionReport_PayType(StartDate, EndDate, ShopIDListValue, objCnn)
		
            bolManualVoidQR = POSDBSQLFront.POSUtilSQL.IsFieldNameExist(objDB, objCnn, "EDC_PaymentInfo", "IsManualVoid")
            If bolManualVoidQR = True Then
                manualVoidQRCount = 1
            Else
                manualVoidQRCount = 0
            End If
               
            For i = 0 To PayTypeData.Rows.Count - 1
                TestString += "<br>" + PayTypeIDList.IndexOf("," + PayTypeData.Rows(i)("PayTypeID").ToString + ",").ToString
                If PayTypeIDList.IndexOf("," + PayTypeData.Rows(i)("PayTypeID").ToString + ",") = -1 Then
                    ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + PayTypeData.Rows(i)("PayType") + "</td>"
                    ReDim Preserve IDList(counter)
                    IDList(counter) = PayTypeData.Rows(i)("PayTypeID")
                    counter += 1
                End If
                If i = 0 Then
                    PayTypeIDList += "," + PayTypeData.Rows(i)("PayTypeID").ToString + ","
                Else
                    PayTypeIDList += PayTypeData.Rows(i)("PayTypeID").ToString + ","
                End If
            Next
            Dim Summary(counter + 7 + manualVoidQRCount) As Double
            Dim sumTotal(counter + 7 + manualVoidQRCount) As Double
            If ExtraHeaderString <> "" Then
                ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Total Payment" + "</td>"
                ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Float" + "</td>"
                ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Sale Cash" + "</td>"
                ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Deposit Cash" + "</td>"
                ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Cash In/Out" + "</td>"
                If bolManualVoidQR = True Then
                    ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Manual Void From QR Payment" + "</td>"
                End If
                ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Total Cash" + "</td>"
                ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Cash Count" + "</td>"
                ExtraHeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Diff" + "</td>"
            End If
            ExtraHeader.InnerHtml = ExtraHeaderString
            Dim BgColor As String = GlobalParam.GrayBGColor
            Dim Zero As Integer = 0
            Dim dtManualVoidQR As DataTable
            Dim outString As StringBuilder = New StringBuilder
            For i = 0 To ShopData.Rows.Count - 1
                dtTable = getReport.SessionReportSummary(StartDate, EndDate, ShopData.Rows(i)("ProductLevelID"), objCnn)
                If bolManualVoidQR = True Then
                    dtManualVoidQR = getReport.Session_GetManualVoidQRPaymentDetail(objCnn, StartDate, EndDate, ShopData.Rows(i)("ProductLevelID"))
                Else
                    dtManualVoidQR = New DataTable
                End If
                                
                outString = outString.Append(GenResultData(Request.Form("ShopID"), ShopData.Rows(i)("ProductLevelName"), dtTable, dtManualVoidQR, _
                                   bolManualVoidQR, IDList, counter, objCnn))
            Next
            ResultText.InnerHtml = outString.ToString
		
            Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"
        End If
    End Sub

    Public Function GenResultData(ByVal ShopID As Integer, ByVal ShopName As String, ByVal dtTable As DataTable, dtManualVoidQR As DataTable, _
    displayManualVoidQRColumn As Boolean, ByVal IDList() As String, ByVal counter As Integer, ByVal objCnn As MySqlConnection) As String
        Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
        Dim DummyDate As String
        Dim i, j, k As Integer
        Dim DummyCloseStaffID As Integer = -1
        Dim DummyOpenStaffID As Integer = -1
        Dim DummySessionID As Integer = -1
        Dim DummyComputerID As Integer = -1
        Dim PayTypeIDList As String = ""
        Dim ExtraHeaderString As String = ""
        Dim PayTypeString As String = ""
        Dim SumRow, SumRowCash, SumCashInOut, SumDepositCash, dclSumManualVoidQR As Double
        Dim rResult() As DataRow
        Dim manualVoidQRCount As Integer
        If displayManualVoidQRColumn = True Then
            manualVoidQRCount = 1
        Else
            manualVoidQRCount = 0
        End If
               
        Dim Summary(counter + 7 + manualVoidQRCount) As Double
        Dim sumTotal(counter + 7 + manualVoidQRCount) As Double
		
        Dim NeedSummary As Boolean
        Dim CloseBy As String
        Dim BgColor As String = GlobalParam.GrayBGColor
        Dim Zero As Integer = 0
        Dim outputString As StringBuilder = New StringBuilder
		
        If dtTable.Rows.Count > 0 And ShopID = 0 Then
            outputString = outputString.Append("<tr><td bgColor=""" + GlobalParam.GrayBGColor + """ align=""center"" colspan=""" + (counter + 13).ToString + """>" + ShopName + "</td></tr>")
        End If
        For i = 0 To dtTable.Rows.Count - 1
            If Not (dtTable.Rows(i)("SessionID") = DummySessionID And dtTable.Rows(i)("ComputerID") = DummyComputerID) Then
                CloseBy = ""
                If dtTable.Rows(i)("SessionDate").ToString <> DummyDate Then
                    For j = 0 To Summary.Length - 1
                        Summary(j) = 0
                    Next
                    NeedSummary = False
                    If BgColor = GlobalParam.GrayBGColor Then
                        BgColor = "white"
                    Else
                        BgColor = GlobalParam.GrayBGColor
                    End If
                    outputString = outputString.Append("<tr bgColor=""" + BgColor + """>")
                    outputString = outputString.Append("<td class=""smallText"">" + DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SessionDate"), "DateOnly", Session("LangID"), objCnn) + "</td>")
                Else
                    outputString = outputString.Append("<tr bgColor=""" + BgColor + """>")
                    outputString = outputString.Append("<td class=""smallText""></td>")
                    NeedSummary = True
                End If
			
                If Not IsDBNull(dtTable.Rows(i)("CloseStaff")) Then
                    outputString = outputString.Append("<td class=""smallText"">" + dtTable.Rows(i)("CloseStaff") + "</td>")
                Else
                    outputString = outputString.Append("<td class=""smallText"">-</td>")
                End If
                If Not IsDBNull(dtTable.Rows(i)("RegistrationNumber")) Then
                    outputString = outputString.Append("<td class=""smallText"">" + dtTable.Rows(i)("RegistrationNumber") + "</td>")
                Else
                    outputString = outputString.Append("<td class=""smallText"">-</td>")
                End If
                If Not IsDBNull(dtTable.Rows(i)("OpenSessionDateTime")) Then
                    outputString = outputString.Append("<td class=""smallText"">" + CDate(dtTable.Rows(i)("OpenSessionDateTime")).ToString(FormatObject.TimeFormat, ci) + "</td>")
                Else
                    outputString = outputString.Append("<td class=""smallText"">-</td>")
                End If
                If Not IsDBNull(dtTable.Rows(i)("CloseSessionDateTime")) Then
                    outputString = outputString.Append("<td class=""smallText"">" + CDate(dtTable.Rows(i)("CloseSessionDateTime")).ToString(FormatObject.TimeFormat, ci) + "</td>")
                Else
                    outputString = outputString.Append("<td class=""smallText"">-</td>")
                End If
                SumRow = 0
                SumRowCash = 0
                For j = 0 To IDList.Length - 1
                    PayTypeString = ""
                    For k = 0 To dtTable.Rows.Count - 1
                        If dtTable.Rows(k)("SessionID") = dtTable.Rows(i)("SessionID") And dtTable.Rows(k)("ComputerID") = dtTable.Rows(i)("ComputerID") Then
                            If dtTable.Rows(k)("SessionDate").ToString = dtTable.Rows(i)("SessionDate").ToString Then
                                If IsDBNull(dtTable.Rows(k)("PayTypeID")) Then
                                    dtTable.Rows(k)("PayTypeID") = 0
                                End If
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
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">-</td>")
                    Else
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + PayTypeString + "</td>")
                    End If
                Next
                SumCashInOut = 0
                If Not IsDBNull(dtTable.Rows(i)("TotalCashInOut")) Then
                    SumCashInOut = dtTable.Rows(i)("TotalCashInOut")
                End If
				
                SumDepositCash = 0
                If Not IsDBNull(dtTable.Rows(i)("TotalDeposit")) Then
                    SumDepositCash = dtTable.Rows(i)("TotalDeposit")
                End If
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + SumRow.ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(dtTable.Rows(i)("OpenSessionAmount")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + SumRowCash.ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + SumDepositCash.ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + SumCashInOut.ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                'Display ManualVoid QR Payment
                dclSumManualVoidQR = 0
                If displayManualVoidQRColumn = True Then
                    If dtManualVoidQR.Rows.Count <> 0 Then
                        rResult = dtManualVoidQR.Select("SessionID = " & dtTable.Rows(i)("SessionID") & " AND ComputerID = " & dtTable.Rows(i)("ComputerID"))
                        If rResult.Length = 0 Then
                            dclSumManualVoidQR = 0
                        ElseIf IsDBNull(rResult(0)("VoidQRPaymentAmount")) Then
                            dclSumManualVoidQR = 0
                        Else
                            dclSumManualVoidQR = rResult(0)("VoidQRPaymentAmount")
                        End If
                    End If
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" & ((-dclSumManualVoidQR).ToString(FormatObject.CurrencyFormat, ci)) & "</td>")
                End If
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + (CDbl(dtTable.Rows(i)("OpenSessionAmount")) + SumRowCash + SumDepositCash + SumCashInOut - dclSumManualVoidQR).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(dtTable.Rows(i)("CloseSessionAmount")).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(dtTable.Rows(i)("CloseSessionAmount") - (dtTable.Rows(i)("OpenSessionAmount") + SumRowCash + SumDepositCash + SumCashInOut - dclSumManualVoidQR)).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                Summary(counter) += SumRow
                Summary(counter + 1) += dtTable.Rows(i)("OpenSessionAmount")
                Summary(counter + 2) += SumRowCash
                Summary(counter + 3) += SumDepositCash
                Summary(counter + 4) += SumCashInOut
                If displayManualVoidQRColumn = True Then
                    Summary(counter + 4 + manualVoidQRCount) -= dclSumManualVoidQR
                End If
                Summary(counter + 5 + manualVoidQRCount) += dtTable.Rows(i)("OpenSessionAmount") + SumRowCash + SumDepositCash + SumCashInOut - dclSumManualVoidQR
                Summary(counter + 6 + manualVoidQRCount) += dtTable.Rows(i)("CloseSessionAmount")
                Summary(counter + 7 + manualVoidQRCount) += dtTable.Rows(i)("CloseSessionAmount") - (dtTable.Rows(i)("OpenSessionAmount") + SumRowCash + SumDepositCash + SumCashInOut - dclSumManualVoidQR)
                
                sumTotal(counter) += SumRow
                sumTotal(counter + 1) += dtTable.Rows(i)("OpenSessionAmount")
                sumTotal(counter + 2) += SumRowCash
                sumTotal(counter + 3) += SumDepositCash
                sumTotal(counter + 4) += SumCashInOut
                If displayManualVoidQRColumn = True Then
                    sumTotal(counter + 4 + manualVoidQRCount) -= dclSumManualVoidQR
                End If
                sumTotal(counter + 5 + manualVoidQRCount) += dtTable.Rows(i)("OpenSessionAmount") + SumRowCash + SumDepositCash + SumCashInOut-dclSumManualVoidQR 
                sumTotal(counter + 6 + manualVoidQRCount) += dtTable.Rows(i)("CloseSessionAmount")
                sumTotal(counter + 7 + manualVoidQRCount) += dtTable.Rows(i)("CloseSessionAmount") - (dtTable.Rows(i)("OpenSessionAmount") + SumRowCash + SumDepositCash + SumCashInOut - dclSumManualVoidQR)
                outputString = outputString.Append("</tr>")
            End If
			
            If i = dtTable.Rows.Count - 1 Then
                If NeedSummary = True Then
                    outputString = outputString.Append("<tr bgColor=""" + BgColor + """>")
                    outputString = outputString.Append("<td colspan=""5"" align=""right"" class=""smallText"">SubTotal " + DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SessionDate"), "DateOnly", Session("LangID"), objCnn) + "</td>")
                    For j = 0 To Summary.Length - 1
                        If Summary(j) <> 0 Then
                            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Summary(j).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                        Else
                            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Zero.ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                        End If
                    Next
                    outputString = outputString.Append("</tr>")
                End If
            Else
                If (NeedSummary = True And dtTable.Rows(i)("SessionDate").ToString <> dtTable.Rows(i + 1)("SessionDate").ToString) Then
                    outputString = outputString.Append("<tr bgColor=""" + BgColor + """>")
                    outputString = outputString.Append("<td colspan=""5"" align=""right"" class=""smallText"">SubTotal " + DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SessionDate"), "DateOnly", Session("LangID"), objCnn) + "</td>")
                    For j = 0 To Summary.Length - 1
                        If Summary(j) <> 0 Then
                            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Summary(j).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                        Else
                            outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Zero.ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                        End If
                    Next
                    outputString = outputString.Append("</tr>")
                End If
            End If

            DummyOpenStaffID = dtTable.Rows(i)("OpenStaffID")
            DummyDate = dtTable.Rows(i)("SessionDate").ToString
            DummySessionID = dtTable.Rows(i)("SessionID")
            DummyComputerID = dtTable.Rows(i)("ComputerID")
        Next
		
        If dtTable.Rows.Count > 0 Then
            outputString = outputString.Append("<tr><td colspan=""" + (counter + 10).ToString + """ height=""10""></td></tr>")
            outputString = outputString.Append("<tr>")
            If ShopID = 0 Then
                outputString = outputString.Append("<td colspan=""5"" align=""right"" class=""smallText"">Grand Total " + ShopName + "</td>")
            Else
                outputString = outputString.Append("<td colspan=""5"" align=""right"" class=""smallText"">Grand Total</td>")
            End If
            For j = 0 To sumTotal.Length - 1
                If sumTotal(j) <> 0 Then
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + sumTotal(j).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + Zero.ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                End If
            Next
            outputString = outputString.Append("</tr>")
        End If
        Return outputString.ToString
    End Function

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "SessionSummary_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
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
