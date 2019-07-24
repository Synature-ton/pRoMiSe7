<%@ Page Language="VB" ContentType="text/html" EnableViewState="False" debug="True" %>
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
<title>Member/ Staff Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="../StyleSheet/webscript.js"></script> 
</head>
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<input type="hidden" id="ShopIDList" runat="server" />
<input type="hidden" id="SelMemberStaffGroup" runat="server" />
<input type="hidden" id="MemberStaffGroupIDList" runat="server" />
<input type="hidden" id="SelPromotionName" runat="server" />
<input type="hidden" id="PromotionIDList" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Member Discount Report" runat="server" /></b></td>
		<td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
				<td><span id="PromotionText" runat="server"></span></td>
			</tr>
			<tr>
				<td><span id="MemberStaffGroupText" runat="server"></span></td>
			</tr>
			<tr>
				<td><asp:radiobutton ID="optViewByBill" GroupName="ReportViewGroup" CssClass="text" runat="server" /></td>
			</tr>
			<tr>
				<td><asp:radiobutton ID="optViewByProduct" GroupName="ReportViewGroup" CssClass="text" runat="server" /></td>
			</tr>
            <tr>
            	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:CheckBox ID="chkDisplayDate" runat="server">
						</asp:CheckBox></td>
           </tr>
	          <tr>
            	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:dropdownlist ID="ReportProductOrdering" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
           </tr>
 	</table></td>
	<td>
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
		<td><asp:radiobutton ID="optRangeDate" GroupName="ReportSelectDateGroup" runat="server" /></td>
		<td><synature:date id="CurrentDate" runat="server" /></td>
		<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
		<td><synature:date id="ToDate" runat="server" /></td>
	</tr>
	<tr><td>&nbsp;</td>
		<td colspan="4"><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
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
<br>
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
Dim Fm As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getReport As New BackOfficeReport()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim SaleReportPageID As Integer = 6
Dim MemberDiscountPageID As Integer = 101
Dim bolMemberDiscountReport As Boolean

Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_PromotionByProduct") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
		Dim i As Integer
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
		Dim LangData As DataTable = getProp.GetLang(LangListText,LangListData,PageName & "?ID" & Request.QueryString("ID") & "&Order=" + Request.QueryString("Order") & "&GroupID=" & Request.QueryString("GroupID"),MemberDiscountPageID,1,-1,Request,objCnn)
		Dim LangText As String = "lang" + Session("LangID").ToString
		
		For z = 0 To LangData.Rows.Count - 1
			Dim TestLabel =	Util.FindControlRecursive(mainForm,"LangText" & z)
			Try
				TestLabel.Text = LangData.Rows(z)(LangText)
			Catch ex As Exception
			End Try
		Next
		LangList.Text = LangListText
		
		Dim LangData2 As DataTable = getProp.GetLangData(SaleReportPageID,2,-1,Request)
		Dim DiscountLangData As DataTable = getProp.GetLangData(MemberDiscountPageID,2,-1,Request)
	
		If Request.QueryString("ID") = 703 then
			LangText0.Text =BackOfficeReport.GetLanguageText(DiscountLangData,7,LangText,"Staff Discount Report")  
			bolMemberDiscountReport = False
		Else
			bolMemberDiscountReport = True
		End If
	
		Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
		If LangDefault.Rows.Count >= 2 Then
			PrintText.Text = LangDefault.Rows(0)(LangText)
			Export.Text = LangDefault.Rows(1)(LangText)
		End If
 
                SubmitForm.Text = LangDefault.Rows(3)(LangText)
                chkDisplayDate.Text = BackOfficeReport.GetLanguageText(DiscountLangData, 14, LangText, "แสดงสินค้าตามวันที่ขาย")

		ResultText.InnerHtml = ""
		ResultSearchText.InnerHtml = ""
		errorMsg.InnerHtml = ""
		ExtraHeader.InnerHtml = ""
		
		Dim HeaderString As String = ""
		Dim strTemp As String
                If optViewByBill.Checked = True Then
                    'Member/ StaffCode
                    If bolMemberDiscountReport = True Then
                        strTemp = BackOfficeReport.GetLanguageText(DiscountLangData, 12, LangText, "รหัสสมาชิก")
                    Else
                        strTemp = BackOfficeReport.GetLanguageText(DiscountLangData, 13, LangText, "รหัสพนักงาน")
                    End If
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & strTemp & "</td>"
                    'Member/ Staff Name
                    If bolMemberDiscountReport = True Then
                        strTemp = BackOfficeReport.GetLanguageText(DiscountLangData, 3, LangText, "à¸à¸·à¹à¸­à¸ªà¸¡à¸²à¸à¸´à¸")
                    Else
                        strTemp = BackOfficeReport.GetLanguageText(DiscountLangData, 8, LangText, "à¸à¸·à¹à¸­à¸à¸à¸±à¸à¸à¸²à¸")
                    End If
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & strTemp & "</td>"
                    'Promotion Name
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(DiscountLangData, 4, LangText, "à¸à¸·à¹à¸­à¹à¸à¸£à¹à¸¡à¸à¸±à¹à¸") & "</td>"
                    'SaleDate
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangData2, 65, LangText, "à¸§à¸±à¸à¸à¸µà¹") & "</td>"
                    'Receipt No
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangData2, 18, LangText, "à¹à¸¥à¸à¸à¸µà¹à¹à¸à¹à¸ªà¸£à¹à¸") & "</td>"
                    'Discount Price
                    If bolMemberDiscountReport = True Then
                        strTemp = BackOfficeReport.GetLanguageText(DiscountLangData, 5, LangText, "à¸ªà¹à¸§à¸à¸¥à¸à¸ªà¸¡à¸²à¸à¸´à¸")
                    Else
                        strTemp = BackOfficeReport.GetLanguageText(DiscountLangData, 9, LangText, "à¸ªà¹à¸§à¸à¸¥à¸à¸à¸à¸±à¸à¸à¸²à¸")
                    End If
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & strTemp & "</td>"
                    'Sale Price
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangData2, 26, LangText, "à¸£à¸²à¸à¸²à¸ªà¸¸à¸à¸à¸´") & "</td>"
			
                ElseIf optViewByProduct.Checked = True Then
                    'Member/ StaffCode
                    If bolMemberDiscountReport = True Then
                        strTemp = BackOfficeReport.GetLanguageText(DiscountLangData, 3, LangText, "à¸à¸·à¹à¸­à¸ªà¸¡à¸²à¸à¸´à¸")
                    Else
                        strTemp = BackOfficeReport.GetLanguageText(DiscountLangData, 8, LangText, "à¸à¸·à¹à¸­à¸à¸à¸±à¸à¸à¸²à¸")
                    End If
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & strTemp & "</td>"
                    'Member/ StaffName
                    If bolMemberDiscountReport = True Then
                        strTemp = BackOfficeReport.GetLanguageText(DiscountLangData, 3, LangText, "à¸à¸·à¹à¸­à¸ªà¸¡à¸²à¸à¸´à¸")
                    Else
                        strTemp = BackOfficeReport.GetLanguageText(DiscountLangData, 8, LangText, "à¸à¸·à¹à¸­à¸à¸à¸±à¸à¸à¸²à¸")
                    End If
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & strTemp & "</td>"
                    'PromotionName
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(DiscountLangData, 4, LangText, "à¸à¸·à¹à¸­à¹à¸à¸£à¹à¸¡à¸à¸±à¹à¸") & "</td>"
                    'SaleDate
                    If chkDisplayDate.Checked = True Then
                        HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangData2, 65, LangText, "à¸§à¸±à¸à¸à¸µà¹") & "</td>"
                    End If
                    'ProductCode
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangData2, 33, LangText, "à¸£à¸«à¸±à¸ªà¸ªà¸´à¸à¸à¹à¸²") & "</td>"
                    'ProductName
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangData2, 34, LangText, "à¸ªà¸´à¸à¸à¹à¸²") & "</td>"
                    'Price/ Unit
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangData2, 36, LangText, "à¸£à¸²à¸à¸²à¸à¹à¸­à¸«à¸à¹à¸§à¸¢") & "</td>"
                    'Amount
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangData2, 37, LangText, "à¸à¸³à¸à¸§à¸") & "</td>"
                    'TotalPrice
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(LangData2, 38, LangText, "à¸£à¸§à¸¡à¸£à¸²à¸à¸²") & "</td>"
                    'Discount Price
                    If bolMemberDiscountReport = True Then
                        strTemp = BackOfficeReport.GetLanguageText(DiscountLangData, 5, LangText, "à¸ªà¹à¸§à¸à¸¥à¸à¸ªà¸¡à¸²à¸à¸´à¸")
                    Else
                        strTemp = BackOfficeReport.GetLanguageText(DiscountLangData, 9, LangText, "à¸ªà¹à¸§à¸à¸¥à¸à¸à¸à¸±à¸à¸à¸²à¸")
                    End If
                    HeaderString &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & strTemp & "</td>"
                End If
		TableHeaderText.InnerHtml = HeaderString
		
		StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"

                ReportProductOrdering.Items(0).Text = LangData2.Rows(2)(LangText)
		ReportProductOrdering.Items(0).Value = "p.ProductCode"
		ReportProductOrdering.Items(1).Text = LangData2.Rows(3)(LangText)
		ReportProductOrdering.Items(1).Value = "p.ProductName"
		If Request.Form("ReportProductOrdering") = "p.ProductCode" Then
			ReportProductOrdering.Items(0).Selected = True
		ElseIf Request.Form("ReportProductOrdering") = "p.ProductName" Then
			ReportProductOrdering.Items(1).Selected = True
		Else
			ReportProductOrdering.Items(0).Selected = True
		End If
		ReportProductOrdering.Visible = False
		
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
					
                optViewByBill.Text = BackOfficeReport.GetLanguageText(DiscountLangData, 1, LangText, "รายงานส่วนลดสมาชิกตามใบเสร็จ")
                optViewByProduct.Text = BackOfficeReport.GetLanguageText(DiscountLangData, 2, LangText, "รายงานส่วนลดสมาชิกตามสินค้า")
		
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
	
		If Not Page.IsPostBack Then
			optDailyDate.Checked = True
			optViewByBill.Checked = True
		End If

                Dim strIDValue As String = "0"
                If IsNumeric(Request.Form("ShopID")) Then
                    strIDValue = Request.Form("ShopID").ToString
                ElseIf IsNumeric(Request.QueryString("ShopID")) Then
                    strIDValue = Request.QueryString("ShopID").ToString
                End If

                Dim outputString, FormSelected As String
                Dim Multiple As Boolean = False
                Dim strAllData As String
		
                Dim dtData As DataTable
                'Load Shop
                dtData = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), objCnn)
                If dtData.Rows.Count > 0 Then
                    outputString = "<select name=""ShopID"">"
                    If dtData.Rows.Count > 1 Then
                        If Not Page.IsPostBack Then
                            FormSelected = "selected"
                        ElseIf strIDValue = 0 Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & "--- All Shops ---"
                        Multiple = True
                    End If
                    strAllData = ""
                    For i = 0 To dtData.Rows.Count - 1
                        If strIDValue = dtData.Rows(i)("ProductLevelID") Then
                            FormSelected = "selected"
                            SelShopName.Value = dtData.Rows(i)("ProductLevelName")
                        Else
                            If Not Page.IsPostBack And i = 0 And Multiple = False Then
                                FormSelected = "selected"
                            Else
                                FormSelected = ""
                            End If
                        End If
                        outputString += "<option value=""" & dtData.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & dtData.Rows(i)("ProductLevelName")
                        strAllData += "," + dtData.Rows(i)("ProductLevelID").ToString
                    Next
                    outputString += "</select>"
                    ShopText.InnerHtml = outputString
                    ShowShop.Visible = True
                    strAllData = "0" & strAllData
                    ShopIDList.Value = strAllData
                Else
                    ShowShop.Visible = False
                End If
        
                'Load Member/ Staff Group
                strIDValue = "0"
                If IsNumeric(Request.Form("MemberStaffGroupID")) Then
                    strIDValue = Request.Form("MemberStaffGroupID").ToString
                ElseIf IsNumeric(Request.QueryString("MemberStaffGroupID")) Then
                    strIDValue = Request.QueryString("MemberStaffGroupID").ToString
                End If
                If bolMemberDiscountReport = True Then
                    dtData = getReport.MemberStaffDiscountReport_ListAllMemberGroup(objCnn)
                Else
                    dtData = getReport.MemberStaffDiscountReport_ListAllStaffGroup(objCnn)
                End If
                
                If dtData.Rows.Count > 0 Then
                    outputString = "<select name=""MemberStaffGroupID"">"
                    If dtData.Rows.Count > 1 Then
                        If Not Page.IsPostBack Then
                            FormSelected = "selected"
                        ElseIf strIDValue  = 0 Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & "--- All ---"
                        Multiple = True
                    End If
                    strAllData = ""
                    For i = 0 To dtData.Rows.Count - 1
                        If strIDValue = dtData.Rows(i)("GroupID") Then
                            FormSelected = "selected"
                            SelMemberStaffGroup.Value = dtData.Rows(i)("GroupName")
                        Else
                            If Not Page.IsPostBack And i = 0 And Multiple = False Then
                                FormSelected = "selected"
                            Else
                                FormSelected = ""
                            End If
                        End If
                        outputString += "<option value=""" & dtData.Rows(i)("GroupID") & """ " & FormSelected & ">" & dtData.Rows(i)("GroupName")
                        strAllData += "," + dtData.Rows(i)("GroupID").ToString
                    Next
                    outputString += "</select>"
                    MemberStaffGroupText.InnerHtml = outputString
                    strAllData = "0" & strAllData
                    MemberStaffGroupIDList.Value = strAllData
                Else
                    SubmitForm.Enabled = False
                End If
                
                'Load Promotion For Member/ Staff
                strIDValue = "0"
                If IsNumeric(Request.Form("MemberStaffPromotionID")) Then
                    strIDValue = Request.Form("MemberStaffPromotionID").ToString
                ElseIf IsNumeric(Request.QueryString("MemberStaffPromotionID")) Then
                    strIDValue = Request.QueryString("MemberStaffPromotionID").ToString
                End If
                dtData = getReport.MemberStaffDiscountReport_ListAllPromotion(objCnn, Not bolMemberDiscountReport, False, False)
                If dtData.Rows.Count > 0 Then
                    outputString = "<select name=""MemberStaffPromotionID"">"
                    If dtData.Rows.Count > 1 Then
                        If Not Page.IsPostBack Then
                            FormSelected = "selected"
                        ElseIf strIDValue = 0 Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & "--- All Promotion ---"
                        Multiple = True
                    End If
                    strAllData = ""
                    For i = 0 To dtData.Rows.Count - 1
                        If strIDValue = dtData.Rows(i)("PriceGroupID") Then
                            FormSelected = "selected"
                            SelShopName.Value = dtData.Rows(i)("PromotionPriceName")
                        Else
                            If Not Page.IsPostBack And i = 0 And Multiple = False Then
                                FormSelected = "selected"
                            Else
                                FormSelected = ""
                            End If
                        End If
                        outputString += "<option value=""" & dtData.Rows(i)("PriceGroupID") & """ " & FormSelected & ">" & dtData.Rows(i)("PromotionPriceName")
                        strAllData += "," + dtData.Rows(i)("PriceGroupID").ToString
                    Next
                    outputString += "</select>"
                    PromotionText.InnerHtml = outputString
                    strAllData = "0" & strAllData
                    PromotionIDList.Value = strAllData
                Else
                    SubmitForm.Enabled = False
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
	
	Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
	Dim FoundError As Boolean
	FoundError = False
	Session("ReportResult") = ""
	
	Dim LangDiscountData As DataTable = getProp.GetLangData(MemberDiscountPageID,2,-1,Request)
	Dim LangData2 As DataTable = getProp.GetLangData(SaleReportPageID,2,-1,Request)
	Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
	Dim LangText As String = "lang" + Session("LangID").ToString
	
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""
	Dim DailyDateValue As String = ""
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	Dim AdditionalHeader As String = ""
	
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
	Dim outputString As String = ""
	Dim grandTotal As Double = 0
	Dim VATTotal As Double = 0
	Dim GraphData As New DataSet()
        Dim ReportDate, strPromoID, strGroupID As String
        Dim bolByDate, bolByMonth, bolByDateRange As Boolean
	Dim bolViewByBill, bolViewByProduct As Boolean
	bolByMonth = False
	bolByDateRange = False
	bolByDate = False
	If Request.Form("ReportSelectDateGroup") = "optMonthlyDate" Then 
		bolByMonth = True
	ElseIf Request.Form("ReportSelectDateGroup") = "optRangeDate" Then
		bolByDateRange = True
	ElseIf Request.Form("ReportSelectDateGroup") = "optDailyDate" Then 
		bolByDate = True
	End If
	
        Dim ReportType As String
        ReportType = ""
        If Request.Form("ReportViewGroup") = "optViewByBill" Then
            bolViewByBill = True
            If bolMemberDiscountReport = True Then
                ReportType = BackOfficeReport.GetLanguageText(LangDiscountData, 1, LangText, "à¸£à¸²à¸¢à¸à¸²à¸à¸ªà¹à¸§à¸à¸¥à¸à¸ªà¸¡à¸²à¸à¸´à¸à¸à¸²à¸¡à¹à¸à¹à¸ªà¸£à¹à¸à¸à¸­à¸")
            Else
                ReportType = BackOfficeReport.GetLanguageText(LangDiscountData, 10, LangText, "à¸£à¸²à¸¢à¸à¸²à¸à¸ªà¹à¸§à¸à¸¥à¸à¸à¸à¸±à¸à¸à¸²à¸à¸à¸²à¸¡à¹à¸à¹à¸ªà¸£à¹à¸à¸à¸­à¸")
            End If
        ElseIf Request.Form("ReportViewGroup") = "optViewByProduct" Then
            bolViewByProduct = True
            If bolMemberDiscountReport = True Then
                ReportType = BackOfficeReport.GetLanguageText(LangDiscountData, 2, LangText, "à¸£à¸²à¸¢à¸à¸²à¸à¸ªà¹à¸§à¸à¸¥à¸à¸ªà¸¡à¸²à¸à¸´à¸à¸à¸²à¸¡à¸ªà¸´à¸à¸à¹à¸²à¸à¸­à¸")
            Else
                ReportType = BackOfficeReport.GetLanguageText(LangDiscountData, 11, LangText, "à¸£à¸²à¸¢à¸à¸²à¸à¸ªà¹à¸§à¸à¸¥à¸à¸à¸à¸±à¸à¸à¸²à¸à¸à¸²à¸¡à¸ªà¸´à¸à¸à¹à¸²à¸à¸­à¸")
            End If
        End If

        ReportDate = ""
        StartDate = ""
        EndDate = ""
        If bolByMonth = True Then
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
                errorMsg.InnerHtml = ex.Message
            End Try
        ElseIf bolByDateRange = True Then
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
                errorMsg.InnerHtml = ex.Message
            End Try
        ElseIf bolByDate = True Then
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
        Else
            DateFromValue = ""
            DateToValue = ""
            DailyDateValue = ""
        End If

	If FoundError = False Then
		If LangDefault.Rows.Count >= 3 Then
			CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(NOW(), "DateAndTime",Session("LangID"),objCnn)
		End If
		Dim displayTable As New DataTable()
		
		ShowPrint.Visible = True
		ShowResults.Visible = True
				
		'Application.Lock()
		
		Dim LangPath As String = Util.GetLangPath(Request.PhysicalApplicationPath)
            If Request.Form("MemberStaffPromotionID") = 0 Then
                strPromoID = PromotionIDList.Value
            Else
                strPromoID = Request.Form("MemberStaffPromotionID")
            End If
            ResultText.InnerHtml = getReport.MemberStaffDiscountReport(GlobalParam.GrayBGColor, GlobalParam.AdminBGColor, Session("LangID"), _
                                         bolViewByBill, bolViewByProduct, bolMemberDiscountReport, chkDisplayDate.Checked, _
                                         Request.Form("MemberStaffGroupID"), "", "", "", StartDate, EndDate, _
                                         Request.Form("ShopID"), strPromoID, LangPath, Session("StaffRole"), objCnn)

		Dim ShopDisplay As String
		If Request.Form("ShopID") = 0 Then
			ShopDisplay = LangData2.Rows(70)(LangText)
		Else
			ShopDisplay = SelShopName.Value
		End If
		ResultSearchText.InnerHtml = ReportType + " " + ShopDisplay + " (" + ReportDate + ")"
		'Application.UnLock()
		
		Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"

	End If

End Sub
 
Sub ExportData(Source As Object, E As EventArgs)
	Dim FileName As String = "MemberDiscountData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
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
