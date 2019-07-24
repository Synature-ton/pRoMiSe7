<%@ Page Language="VB" ContentType="text/html" EnableViewState="False" debug="True" %>
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
<title>Sales Report By Product Tax</title>
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
<input type="hidden" id="DisplayVAT" runat="server" />
<input type="hidden" id="AllShopID" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Sales Report By Product Tax" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
	<td valign="middle">
		<span id="SelShopText" runat="server"></span>
    </td>
	<td valign="top">
		<table>
			<tr>
				<td><span id="ShopText" runat="server"></span></td>
			</tr>
			<tr id="showbill" visible="false" runat="server">
				<td><asp:radiobutton ID="Radio_11" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
			<tr>
				<td><asp:radiobutton ID="Radio_12" GroupName="Group2" CssClass="text" runat="server" /></td>
			</tr>
            <tr>
            	<td>
                	<table>
                    	<tr><td width="20">&nbsp;</td><td><asp:dropdownlist ID="ReportProductOrdering" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td></tr>
                        <tr id="ShowBySaleMode" visible="false" runat="server"><td>&nbsp;</td><td><asp:CheckBox ID="BySaleMode" Text="Group By Sale Mode" Checked="false" runat="server"></asp:CheckBox></td></tr>
                    </table>
                </td>
            </tr>
			<tr id="showdw" visible="false" runat="server">
				<td><asp:radiobutton ID="Radio_13" GroupName="Group2" CssClass="text" runat="server" />
				<asp:dropdownlist ID="GroupByParam" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
			</tr>
		</table></td>
	<td>
	<table>
		<tr>
		<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="DailyDate" runat="server" /></td>
		<td colspan="2"><asp:CheckBox ID="ExpandReceipt" CssClass="text" Checked="false" Visible="false" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="MonthYearDate" runat="server" /></td>
		<td colspan="2"><asp:radiobutton ID="Linechart" Text="Line Chart" Checked="true" GroupName="Group3" CssClass="text" Visible="false" runat="server" />
			&nbsp;<asp:radiobutton ID="Barchart" Text="Column Chart" GroupName="Group3" CssClass="text" Visible="false" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="Radio_4" GroupName="Group1" runat="server" /></td>
		<td colspan="3"><synature:date id="YearDate" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="Radio_2" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="CurrentDate" runat="server" /></td>
		<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
		<td><synature:date id="ToDate" runat="server" /></td>
	</tr>
	<tr><td>&nbsp;</td>
		<td colspan="4"><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" />&nbsp;<asp:CheckBox ID="DisplayGraph" CssClass="text" Checked="true" Visible="false" runat="server" /></td>
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
	<span id="TableHeaderText" runat="server"></span>
	<span id="ExtraHeader" runat="server"></span>
	
	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>

<asp:Panel ID="showGraph" Visible="false" runat="server">
<br>
<Web:ChartControl id="ChartControl1" ChartPadding=40 runat="Server" />
    </asp:Panel></td></tr>
</table></span>

<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table>

</div>
</form>
</div>
<div id="outString" runat="server" />
<div id="errorMsg" runat="server" />
<div id="errorMsg2" runat="server" />
<div id="errorMsg3" runat="server" />
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
Dim Reports As New ReportV6()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer = 6

Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_ProductTax") Then
		
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
		Dim LangData As DataTable = getProp.GetLang(LangListText,LangListData,PageName & "?ID" & Request.QueryString("ID") & "&Order=" + Request.QueryString("Order") & "&GroupID=" & Request.QueryString("GroupID"),PageID,1,-1,Request,objCnn)
		Dim LangText As String = "lang" + Session("LangID").ToString
		
		For z = 0 To LangData.Rows.Count - 1
			Dim TestLabel =	Util.FindControlRecursive(mainForm,"LangText" & z)
			Try
				'TestLabel.Text = LangData.Rows(z)(LangText)
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
		
		ResultText.InnerHtml = ""
		ResultSearchText.InnerHtml = ""
		errorMsg.InnerHtml = ""
		ExtraHeader.InnerHtml = ""
		
		Dim SMData As DataTable = objDB.List("select * from SaleMode where Deleted=0 order by SaleModeID", objCnn)
		
		ShowBySaleMode.Visible = False
		If SMData.Rows.Count > 1 Then
			'ShowBySaleMode.Visible = True
		End If
		
		Dim HeaderString As String = ""
		Dim ShopProp1 As DataTable = getInfo.GetProductLevel(Request.Form("ShopID"),objCnn)
		If (Radio_11.Checked = True AND (Radio_1.Checked = True Or Radio_2.Checked = True Or Radio_4.Checked = True)) Or Radio_13.Checked = True Or (Request.Form("ShopID") = 0 And Radio_12.Checked = False) Or (Radio_11.Checked = True AND Radio_3.Checked = True And ExpandReceipt.Checked = False) Then
			If Radio_11.Checked = True AND Radio_3.Checked = True And ExpandReceipt.Checked = False And Request.Form("ShopID") >= 0 Then
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
				If Radio_13.Checked = True Then
					If Request.Form("GroupByParam") = 1 Then
						HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(61)(LangText) & "</td>"
					Else
						HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(60)(LangText) + "</td>"
					End if
				ElseIf Radio_4.Checked = True Then
					HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(63)(LangText) + "</td>"
				Else
					If Request.Form("ShopID") = 0 Then
						HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(64)(LangText) + "</td>"
					Else
						HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(65)(LangText) + "</td>"
					End If
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
			
		ElseIf Radio_12.Checked = True Then
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(33)(LangText) + "</td>"		
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(34)(LangText) + "</td>"
			'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(36)(LangText) + "</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(37)(LangText) + "</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(35)(LangText) + "</td>"
			
			'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(38)(LangText) + "</td>"
			'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(35)(LangText) + "</td>"
			'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(39)(LangText) + "</td>"
			'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Sub Total (Incl Tax)" + "</td>"
			'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(35)(LangText) + "</td>"
			'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Tax</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Sub Total (Ex Tax)</td>"
			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>"

		End If
		
		
		If Radio_3.Checked = True AND (Radio_11.Checked = True Or Radio_13.Checked = True) And ExpandReceipt.Checked = True AND Request.Form("ShopID") >= 0 Then
			StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
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
			StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		End If
		
		TableHeaderText.InnerHtml = HeaderString

		GroupByParam.Items(0).Text = LangData2.Rows(4)(LangText)
		GroupByParam.Items(0).Value = "1"
		GroupByParam.Items(1).Text = LangData2.Rows(5)(LangText)
		GroupByParam.Items(1).Value = "2"
		If Request.Form("GroupByParam") = 1 Then
			GroupByParam.Items(0).Selected = True
		ElseIf Request.Form("GroupByParam") = 2 Then
			GroupByParam.Items(1).Selected = True
		Else
			GroupByParam.Items(0).Selected = True
		End If
		
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
		
		ExpandReceipt.Text = LangData2.Rows(6)(LangText)
		DisplayGraph.Text = LangData2.Rows(7)(LangText)
		
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
		
		YearDate.YearType = GlobalParam.YearType
		YearDate.FormName = "YearDate"
		YearDate.StartYear = GlobalParam.StartYear
		YearDate.EndYear = GlobalParam.EndYear
		YearDate.LangID = Session("LangID")
		YearDate.ShowDay = False
		YearDate.ShowMonth = False
		YearDate.Lang_Data = LangDefault
		YearDate.Culture = CultureString
		
		Radio_11.Text = LangData2.Rows(0)(LangText)
		Radio_12.Text = LangData2.Rows(1)(LangText)
		Linechart.Text = LangData2.Rows(8)(LangText)
		Barchart.Text = LangData2.Rows(9)(LangText)
		
		
		
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
		
		If IsNumeric(Request.Form("YearDate_Year")) Then 
			Session("YearDate_Year") = Request.Form("YearDate_Year")
		Else If IsNumeric(Request.QueryString("YearDate_Year")) Then 
			Session("YearDate_Year") = Request.QueryString("YearDate_Year")
		Else If Trim(Session("YearDate_Year")) = "" Then
			Session("YearDate_Year") = DateTime.Now.Year
		Else If Trim(Session("YearDate_Year")) = 0 And Not Page.IsPostBack Then
			Session("YearDate_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("YearDate_Year") = "" Then Session("YearDate_Year") = 0
		YearDate.SelectedYear = Session("YearDate_Year")
		
		If Not Page.IsPostBack Then
			Radio_3.Checked = True
			Radio_12.Checked = True
		End If

		Dim ShopIDValue As String = "0"
		If IsNumeric(Request.Form("ShopID")) Then
			ShopIDValue = Request.Form("ShopID").ToString
		Else If IsNumeric(Request.QueryString("ShopID"))
			ShopIDValue = Request.QueryString("ShopID").ToString
		End If

		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		Dim Multiple As Boolean = False
		Dim ShopList As String = ""
		
		Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
		Dim ShopIDListValue As String
		'SelShopText.InnerHtml = Reports.ShopListReport(ShopData,ShopIDListValue,ShopIDValue,Session("StaffRole"),Session("StaffID"),Session("LangID"),objCnn)
		AllShopID.Value = ShopIDListValue
		If ShopData.Rows.Count > 0 Then

			outputString = "<select name=""ShopID"">"
			If ShopData.Rows.Count > 1 Then
				If Not Page.IsPostBack Then 
					FormSelected = "selected"
				ElseIf ShopIDValue = 0 Then
					FormSelected = "selected"
				Else
					FormSelected = ""
				End If
				outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & "--- All Shops ---"
				Multiple = True
			End If
			For i = 0 to ShopData.Rows.Count - 1
				If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
					FormSelected = "selected"
					SelShopName.Value = ShopData.Rows(i)("ProductLevelName")
				Else
					If Not Page.IsPostBack And i=0 And Multiple = False Then
						FormSelected = "selected"
					Else
						FormSelected = ""
					End If
				End If
				outputString += "<option value=""" & ShopData.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & ShopData.Rows(i)("ProductLevelName")
				ShopList += "," + ShopData.Rows(i)("ProductLevelID").ToString
			Next
			outputString += "</select>"
			ShopText.InnerHtml = outputString
			ShowShop.Visible = True
			ShopList = "0" + ShopList
			ShopIDList.Value = ShopList
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
	
	Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
	Dim FoundError As Boolean
	FoundError = False
	Session("ReportResult") = ""
	
	Dim LangData2 As DataTable = getProp.GetLangData(PageID,2,-1,Request)
	Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
	Dim LangText As String = "lang" + Session("LangID").ToString
	
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""
	Dim DailyDateValue As String = ""
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	Dim AdditionalHeader As String = ""
	Dim PayTypeList As DataTable
	Dim i As Integer
	
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
	Dim outputString As String = ""
	Dim grandTotal As Double = 0
	Dim VATTotal As Double = 0
	Dim GraphData As New DataSet()
	Dim ReportDate As String
	Dim YearValue4 As Integer
	Dim R1,R2,R3,R4,R11,R12,R13 As Boolean
	R1 = False
	R2 = False
	R3 = False
	R4 = False
	If Request.Form("Group1") = "Radio_1" Then 
		R1 = True
	ElseIf Request.Form("Group1") = "Radio_2" Then
		R2 = True
	ElseIf Request.Form("Group1") = "Radio_3" Then ' Date
		R3 = True
	Else
		R4 = True
	End If
	
	Dim ReportType As String
	If Request.Form("Group2") = "Radio_11" Then
		R11 = True
		If R3 = True Then
			ReportType = LangData2.Rows(11)(LangText)
		ElseIf R2 = True Then
			ReportType = LangData2.Rows(14)(LangText)
		ElseIf R1 = True Then
			ReportType = LangData2.Rows(12)(LangText)
		Else
			ReportType = LangData2.Rows(13)(LangText)
		End If
	ElseIf Request.Form("Group2") = "Radio_12" Then
		R12 = True
		ReportType = LangData2.Rows(15)(LangText)
	ElseIf Request.Form("Group2") = "Radio_13" Then
		R13 = True
		If Request.Form("GroupByParam") = 1 Then
			ReportType = LangData2.Rows(16)(LangText)
		Else
			ReportType = LangData2.Rows(17)(LangText)
		End If
	End If
	
	Dim ExpReceipt As Boolean = False
	If Request.Form("ExpandReceipt") = "on" Then ExpReceipt = True
	
	Dim DGraph As Boolean = False
	If Request.Form("DisplayGraph") = "on" Then DGraph = True
	
	Dim SMode As Boolean = False
	If Request.Form("BySaleMode") = "on" Then SMode = True
	
	If R1 = True Then
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
		StartDate = DateTimeUtil.FormatDate(1,StartMonthValue,StartYearValue)
		EndDate = DateTimeUtil.FormatDate(1,EndMonthValue,EndYearValue)
		Dim SDate As New Date(StartYearValue,StartMonthValue,1)
		ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy",Session("LangID"),objCnn)
		Catch ex As Exception
			FoundError = True
			errorMsg.InnerHtml = ex.Message
		End Try
	ElseIf R2 = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(Request.Form("Doc_Day"),Request.Form("Doc_Month"),Request.Form("Doc_Year"))
		Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))
		
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
			ReportDate = DateTimeUtil.FormatDateTime(SDate1, "DateOnly",Session("LangID"),objCnn) + " - " + DateTimeUtil.FormatDateTime(EDate1, "DateOnly",Session("LangID"),objCnn)
		End If
		Catch ex As Exception
			FoundError = True
			errorMsg.InnerHtml = ex.Message
		End Try
	Else If R3 = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(Request.Form("DocDaily_Day"),Request.Form("DocDaily_Month"),Request.Form("DocDaily_Year"))
		Dim CheckDate As New DateTime(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"), 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))

		If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
			FoundError = True
			DateFromValue = ""
			DateToValue = ""
			DailyDateValue = ""
		Else
			ResultSearchText.InnerHtml = ""
			Dim SDate2 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
			ReportDate = DateTimeUtil.FormatDateTime(SDate2, "DateOnly",Session("LangID"),objCnn)
		End If
		Catch ex As Exception
			FoundError = True
		End Try
	Else If R4 = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(1,1,Request.Form("YearDate_Year"))
		 
		YearValue4 = Request.Form("YearDate_Year") + 1
		EndDate = DateTimeUtil.FormatDate(1,1,YearValue4)
		Dim SDate4 As New Date(Request.Form("YearDate_Year"),1,1)
		ReportDate = DateTimeUtil.FormatDateTime(SDate4, "yyyy",Session("LangID"),objCnn)
		Catch ex As Exception
			FoundError = True
			errorMsg.InnerHtml = ex.Message
		End Try
	Else
		DateFromValue = ""
		DateToValue = ""
		DailyDateValue = ""
	End If	
	
	If Request.Form("ShopID") = 0 AND R4 = True Then
		errorMsg.InnerHtml = "Report is not support option All Shop with total year data"
		FoundError = True
	End If
	
	If Trim(Request.Form("ShopID")) = "" Then
		FoundError = True
		errorMsg.InnerHtml = "Please select shop before submission"
	End If
	
	If FoundError = False Then
		Reports.CheckConfigReport(1,objCnn)
		
		If LangDefault.Rows.Count >= 3 Then
			CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(NOW(), "DateAndTime",Session("LangID"),objCnn)
		End If
		Dim displayTable As New DataTable()
		
		ShowPrint.Visible = True
		ShowResults.Visible = True
		
		Dim ViewOption As Integer
		If R1 = True Then
			ViewOption = 1
		ElseIf R2 = True Then
			ViewOption = 2
		ElseIf R4 = True Then
			ViewOption = 4
		Else
			ViewOption = 0 
		End If
		
		'Application.Lock()
		Dim HavePrepaid As Boolean = False
		Dim HavePrepaidDiscount As Boolean = False
		Dim ExtraPayText As String
		Dim IncomeType As DataTable
		Dim LangPath As String = Util.GetLangPath(Request.PhysicalApplicationPath)
			
		If Request.Form("ShopID") >= 0 Or (Request.Form("ShopID")=0 AND R12 = True) Then
			ResultText.InnerHtml = SaleReports(IncomeType,PayTypeList,outputString, grandTotal, VATTotal, GraphData, True,GlobalParam.GrayBGColor,GlobalParam.AdminBGColor,Session("LangID"),ViewOption,R11, R12, R13, Request.Form("GroupByParam"), StartDate, EndDate,Request.Form("ReportProductOrdering"),"","","", Request.Form("ShopID"),0,0,GlobalParam.ShowSubmitOrderDetail,ExpReceipt, DGraph, LangPath, SMode, Session("StaffRole"), objCnn)
			
		'Else
			'ResultText.InnerHtml = SaleReportsAll(PayTypeList,outputString, grandTotal, GraphData, True,GlobalParam.GrayBGColor,GlobalParam.AdminBGColor,Session("LangID"),ViewOption,R11, R12, R13, Request.Form("GroupByParam"), StartDate, EndDate, Request.Form("ShopID"),0,0,True,ExpReceipt, DGraph, objCnn)

		End If
	
		If (R11 = True AND (R1 = True Or R2 = True Or R4 = True)) Or R13 = True Or (R11 = True AND R3 = True And ExpReceipt = False) Then
				
				For i = 0 To IncomeType.Rows.Count - 1
					AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + IncomeType.Rows(i)("IncomeName") + "</td>"
				Next
				
				AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(26)(LangText) + "</td>"
				If Request.Form("ShopID") >= 0 Then
					If DisplayVAT.Value = "E" Then
						AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(27)(LangText) + "</td>"
						AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(28)(LangText) + "</td>"
					End If
				End If
				If DisplayVAT.Value <> "E" Then
				AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(29)(LangText) + "</td>"
				AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(30)(LangText) + "</td>"
			    End If
				
				
				For i = 0 To PayTypeList.Rows.Count - 1
					ExtraPayText = ""
					If PayTypeList.Rows(i)("PrepaidDiscountPercent") > 0 Then
						HavePrepaidDiscount = True
						ExtraPayText = "<br>Total/Disc"
					End If
					AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + PayTypeList.Rows(i)("PayTypeName") + ExtraPayText + "</td>"
					If PayTypeList.Rows(i)("IsSale") = 0 Then
						If PropertyInfo.Rows(0)("SummaryPrepaidInSaleReport") = 1 Then
							HavePrepaid = True
						End If	
					End If
				Next
				
				Dim ShopProp1 As DataTable = getInfo.GetProductLevel(Request.Form("ShopID"),objCnn)
			
				AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(31)(LangText) + "</td>"
				AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(32)(LangText) + "</td>"
				
				AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(88)(LangText) & "</td>"
				If ShopProp1.Rows(0)("ShopType") = 1 Then
						AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(87)(LangText) & "</td>"
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
					For i = 0 to NotInRevenueData.Rows.Count - 1
						AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + NotInRevenueData.Rows(i)("NotInRevenueName") + "</td>"
					Next
					AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(66)(LangText) + "</td>"
					HavePrepaidDiscount = True
				End If
				Catch ex As Exception
					NotInRevenueBit = False
				End Try
				If HavePrepaidDiscount = True  Then
					AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(67)(LangText) + "</td>"
				End If
				If HavePrepaid = True Then
					AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(68)(LangText) + "</td>"
					AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(69)(LangText) + "</td>"
				End If	
				
				ExtraHeader.InnerHtml = AdditionalHeader
			End If

		Dim ShopDisplay As String
		If Request.Form("ShopID") = 0 Then
			ShopDisplay = LangData2.Rows(70)(LangText)
		Else
			ShopDisplay = SelShopName.Value
		End If
		ResultSearchText.InnerHtml = ReportType + " " + ShopDisplay + " (" + ReportDate + ")"
		'Application.UnLock()
		
		Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"

		If DGraph = True AND (R3 = False Or (R3 = True AND Request.Form("ShopID")=0) Or (R3 = True AND ExpReceipt = False AND Request.Form("GroupByParam") = 2)) AND (R11 = True Or R13 = True) Then

				showGraph.Visible = True
				Dim view As DataView = GraphData.Tables(0).DefaultView
				
				If view.Count > 0 Then
            
				If BarChart.Checked = True Then
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
		ElseIf R12 = True AND DGraph = True Then
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
			Dim ChartWidth As Integer = 650
			Dim ChartHeight As Integer = 500
			If Request.Form("Group2") = "Radio_12" Then
				ChartWidth = 700
				ChartHeight = 550
			ElseIf Request.Form("Group2") = "Radio_13" Then
				If Request.Form("GroupByParam") = 1 Then
					ChartWidth = 650
					ChartHeight = 450
				Else
					ChartWidth = 650
					ChartHeight = 450
				End If
			End If
            ChartControl1.Background.Type = InteriorType.LinearGradient
            ChartControl1.Background.ForeColor = Color.SteelBlue
            ChartControl1.Background.EndPoint = new Point(ChartWidth, ChartHeight) 
            ChartControl1.Legend.Position = LegendPosition.Bottom
            'ChartControl1.Legend.Width = 40
			ChartControl1.Width = Unit.Parse(ChartWidth.ToString + "px")
			ChartControl1.Height = Unit.Parse(ChartHeight.ToString + "px")
 
            ChartControl1.YAxisFont.ForeColor = Color.SteelBlue
            ChartControl1.XAxisFont.ForeColor = Color.SteelBlue
            
            ChartControl1.ChartTitle.Text = TitleName
            ChartControl1.ChartTitle.ForeColor = Color.White
      
            ChartControl1.Border.Color = Color.SteelBlue

            'ChartControl1.BorderStyle = BorderStyle.Ridge
    End Sub
	
Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "SalesProductTax_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub	

Public Function SaleReports(ByRef IncomeType As DataTable, ByRef PayTypeList As DataTable, ByRef outputString As String, ByRef grandTotal As Double, ByRef VATTotal As Double, ByRef GraphData As DataSet, ByVal ShowSummary As Boolean, ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal LangID As Integer, ByVal ViewOption As Integer, ByVal ReportByBill As Boolean, ByVal ReportByProduct As Boolean, ByVal ReportByTime As Boolean, ByVal GroupByParam As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal StartTimeHour As String, ByVal StartTimeMinute As String, ByVal EndTimeHour As String, ByVal EndTimeMinute As String, ByVal ShopID As String, ByVal TransactionID As Integer, ByVal ComputerID As Integer, ByVal DisplaySummary As Boolean, ByVal ExpandReceipt As Boolean, ByVal DisplayGraph As Boolean, ByVal LangPath As String, ByVal BySaleMode As Boolean, ByVal StaffRoleID As Integer, ByVal objCnn As MySqlConnection) As String

        Dim sqlStatement, sqlStatement1, sqlStatement2, WhereString, WString, ExtraSql, ExtraSelect, PaymentQuery As String
        Dim AdditionalQuery As String = ""
        Dim ShopIDListValue As String = ""
        Dim ResultString As String = ""
        Dim TextClass As String
        Dim GetData As DataTable
        Dim PayTypeData As DataTable
        Dim sqlStatement3 As String

        Dim BranchStr, StrBefore As String
        Dim ii As Integer
        Dim getProp As New CPreferences

        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
        If PropertyInfo.Rows(0)("ImportDataToCopyTable") = 1 Then
            For ii = 1 To 4 - Len(ShopID.ToString)
                StrBefore = StrBefore & "0"
            Next
            BranchStr = StrBefore & ShopID.ToString
        Else
            BranchStr = ""
        End If
        Dim PName As String = "p." + getReport.ProductNameForReport(LangID, objCnn) + " As ProductName"
        Dim PName2 As String = "p." + getReport.ProductNameForReport(LangID, objCnn)
        Dim SaleModePName As String = "IF(a.SaleMode = 1," + PName2 + ",IF(sm.PositionPrefix=0,CONCAT(sm.PrefixText," + PName2 + "),CONCAT(" + PName2 + ",sm.PrefixText))) As ProductName"

        Dim NotInRevenueBit As Boolean = False
        Try
            NotInRevenueBit = PropertyInfo.Rows(0)("EnableNotInRevenue")
        Catch ex As Exception
            NotInRevenueBit = False
        End Try

        If ShopID = "0" Then
            Dim getInfo As New CCategory
            Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999, StaffRoleID, objCnn)
            For ii = 0 To ShopData.Rows.Count - 1
                ShopIDListValue += "," + ShopData.Rows(ii)("ProductLevelID").ToString
            Next
            If ShopIDListValue <> "" Then ShopIDListValue = "0" + ShopIDListValue
        Else
            ShopIDListValue = ShopID.ToString
        End If


        If TransactionID > 0 And ComputerID > 0 Then
            AdditionalQuery += " AND ( a.TransactionID = " + TransactionID.ToString + " AND a.ComputerID = " + ComputerID.ToString + ")"
        Else
            AdditionalQuery += " AND a.DocType IN (4,8)"
        End If

        If ShopIDListValue <> "" Then
            AdditionalQuery += " AND a.ShopID IN (" + ShopIDListValue + ")"
            WhereString += " AND ShopID IN (" + ShopIDListValue + ")"
            WString += " AND a.ShopID IN (" + ShopIDListValue + ")"
            PaymentQuery += " AND a.ShopID IN (" + ShopIDListValue + ")"
        End If

        If StartDate <> "" And EndDate <> "" Then
            AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
            WhereString += " AND (PayDate >= " + StartDate + " AND PayDate < " + EndDate + ")"
            WString += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
            PaymentQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
        End If

        Dim StartTime As String = ""
        Dim EndTime As String = ""
        If IsNumeric(StartTimeHour) And IsNumeric(StartTimeMinute) Then
            StartTime = StartTimeHour + ":" + StartTimeMinute + ":0"
            AdditionalQuery += " AND ( TIME_TO_SEC(a.OpenTime) >= TIME_TO_SEC('" + StartTime + "') )"
        End If
        If IsNumeric(EndTimeHour) And IsNumeric(EndTimeMinute) Then
            EndTime = EndTimeHour + ":" + EndTimeMinute + ":0"
            AdditionalQuery += " AND ( TIME_TO_SEC(a.OpenTime) <= TIME_TO_SEC('" + EndTime + "') )"
        End If

        If Trim(WhereString) = "" Then
            WhereString = " AND 0=1"
            WString = " AND 0=1"
        End If
        Dim OrderBy As String = " a.DocType,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID,b.OrderDetailID,d.PayTypeID"
        Dim ExtraTableString As String = Now.Year.ToString + Now.Month.ToString + Now.Day.ToString + Now.Hour.ToString + Now.Minute.ToString + Now.Second.ToString + Now.Millisecond.ToString
        sqlStatement = "select sum(payamount) AS TotalPay, sum(PaymentVAT) AS TotalVAT, a.PayTypeID,b.PayType AS PayTypeName from paybycreditmoney" + BranchStr + " a left outer join paytype b ON a.PayTypeID=b.TypeID where a.CreditMoneyStatusID=2 " + WhereString + " group by a.PayTypeID,b.PayType order by a.PayTypeID,b.PayType"
        Dim PayByCreditMoney As DataTable = objDB.List(sqlStatement, objCnn)

        Dim ReportType As Integer = 0

        Dim Chk As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramTypeID=2 AND PropertyID=16 AND KeyID=1", objCnn)
        If Chk.Rows.Count > 0 Then
            ReportType = Chk.Rows(0)("PropertyValue")
        End If

        sqlStatement2 = "select * from BankName where 0=1"
        PayTypeList = Reports.GetSalePayType(ShopID.ToString, StartDate, EndDate, objCnn)

        Dim ChkIncome As Boolean = getProp.CheckTableExist("ordertransactionotherincomedetail", objCnn)
        Dim IncomeSelect As String = ""

        If ChkIncome = True Then
            IncomeType = objDB.List("select count(*),b.IncomeTypeID,c.IncomeCode As IncomeName from ordertransaction a, ordertransactionotherincomedetail b, otherincometype c where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.IncomeTypeID=c.IncomeTypeID AND b.IncomeStatus=1 " + PaymentQuery + " group by b.IncomeTypeID,c.IncomeCode order by b.IncomeTypeID", objCnn)
        Else
            IncomeType = objDB.List("select * from BankName where 0=1", objCnn)
        End If

        ExtraSql = ""
        ExtraSelect = ""
        Dim PromotionData As DataTable

        Dim TimeNow As String = DateTimeUtil.CurrentDateTime

        If ReportByProduct = True Or (ReportByBill = True And ShopID > 0 And ViewOption = 0 And ExpandReceipt = True) Then
            TimeNow += "<BR>" + DateTimeUtil.CurrentDateTime

            If ReportByProduct = True Then
                Dim OrderingProduct As String = "p.ProductName"
                If Trim(StartTimeHour) <> "" Then
                    OrderingProduct = StartTimeHour
                End If
                Dim ReportTable As String = "summary_productreport"

                If ShopID = 0 Then
                    'ReportTable = "summary_productreportall"
                End If

                Dim OrderingText As String = "a.GroupOrdering,a.DeptOrdering," + OrderingProduct
                If BySaleMode = True Then
                    OrderingText = "sm.SaleModeID,a.GroupOrdering,a.DeptOrdering," + OrderingProduct
                End If

                sqlStatement = "SELECT a.ProductLinkID As ProductIDLink,a.TransactionStatusID,a.OtherFoodName,a.OrderStatusID,a.ProductSetType,a.VATType, p.ProductCode," + SaleModePName + ", IF(a.ProductDeptName is NULL,'Other',a.ProductDeptName) As ProductDeptName,IF(a.ProductGroupName is NULL,'Other',a.ProductGroupName) As ProductGroupName,IF(a.ProductGroupCode is NULL,'',a.ProductGroupCode) As ProductGroupCode,IF(a.ProductDeptCode is NULL,'',a.ProductDeptCode) As ProductDeptCode,a.GroupOrdering,a.DeptOrdering,a.SaleMode,sm.SaleModeName,sm.PositionPrefix,sm.PrefixText," & _
                            "SUM(a.Amount) AS Amount,SUM(a.TotalPrice) AS TotalPrice,SUM(a.TotalRetailPrice) AS TotalRetailPrice,SUM(SalePrice) AS SalePrice,ROUND(SUM(IF(a.VATType=1,SalePrice*a.VATPercent/(100 + a.VATPercent),IF(a.VATType=0,0,SalePrice*a.VATPercent/100))),2) As ProductTax, " & _
                            "SUM(a.MemberDiscount) AS MemberDiscount, SUM(a.StaffDiscount) AS StaffDiscount, SUM(a.CouponDiscount) AS CouponDiscount, SUM(a.VoucherDiscount) AS VoucherDiscount, SUM(a.OtherPercentDiscount) AS OtherPercentDiscount, SUM(a.EachProductOtherDiscount) AS EachProductOtherDiscount, " & _
                            "SUM(a.PricePromotionDiscount) AS PricePromotionDiscount " & _
                            "FROM " + ReportTable + " a left outer join Products p ON a.ProductID=p.ProductID left outer join SaleMode sm ON a.SaleMode=sm.SaleModeID " & _
                            " WHERE a.OrderStatusID NOT IN (3,4) " + AdditionalQuery & _
                            "  GROUP BY a.ProductLinkID,a.TransactionStatusID,a.OtherFoodName,a.OrderStatusID,a.ProductSetType,a.VATType, p.ProductCode, " & _
                            " p.ProductName, a.ProductDeptName,a.ProductGroupName,a.ProductGroupCode,a.ProductDeptCode,a.SaleMode,sm.SaleModeName,sm.PositionPrefix,sm.PrefixText " & _
                            " ORDER BY " + OrderingText

                '   Dim strSQL As String
                '   strSQL = sqlStatement
                '   strSQL = "Insert INTO ErrorLog(ErrorMessage, ErrorTime) VALUES('" & Replace(strSQL, "'", "''") & "', {ts '" & Now.Year & Format(Now, "-MM-dd HH:mm:ss") & "'})"
                '  objDB.sqlExecute(strSQL, objCnn)

                
                
                
                sqlStatement1 = "select PayTypeID,PayTypeName,SUM(TotalPay) AS TotalPay,SUM(TotalPayDiscount) AS TotalPayDiscount, sum(TotalVAT) AS TotalVAT, SUM(TotalBill) As TotalBill, IsSale, IsVAT, IsOtherReceipt from Summary_PaymentReport a where 0=0 " + PaymentQuery + " group by PayTypeID,PayTypeName,IsSale,IsVAT,IsOtherReceipt order by PayTypeID,PayTypeName,IsSale DESC"
                GetData = objDB.List(sqlStatement, objCnn)
                TimeNow += "<BR>Out Data:" + DateTimeUtil.CurrentDateTime
                Dim PaymentData As DataTable = objDB.List(sqlStatement1, objCnn)
                TimeNow += "<BR>Payment:" + DateTimeUtil.CurrentDateTime
                outputString = ""
                grandTotal = 0
                sqlStatement = "select PromotionID,PromotionName,SUM(TotalDiscount) As TotalDiscount,SUM(PriceAfterDiscount) As PriceAfterDiscount from Summary_PromotionReport a where 0=0 " + PaymentQuery + " group by PromotionID,PromotionName order by SUM(TotalDiscount) DESC"
                PromotionData = objDB.List(sqlStatement, objCnn)

                SaleReportByProduct(BySaleMode, PromotionData, GraphData, outputString, grandTotal, VATTotal, ShowSummary, GrayBGColor, AdminBGColor, ShopIDListValue, ViewOption, StartDate, EndDate, GetData, PaymentData, PayByCreditMoney, LangID, LangPath, objCnn)
                TimeNow += "<BR>" + DateTimeUtil.CurrentDateTime

                
                Return outputString
            Else
                
                Dim ResultText As String
                Dim LangData As DataTable = pRoMiSeLanguage.pRoMiSeLanguage.LangInfo(6, 2, -1, LangPath)
                Dim LangDefault As DataTable = pRoMiSeLanguage.pRoMiSeLanguage.LangInfo(999, 2, -1, LangPath)
                Dim LangText As String = "lang" + LangID.ToString
                Return Reports.BillDetailReport(ResultText, GrayBGColor, AdminBGColor, DisplaySummary, LangID, StartDate, EndDate, ShopID, 0, 0, LangPath, LangDefault, LangData, "", StaffRoleID, objCnn)

            End If


        Else
            Dim DisplayReceipt As Boolean = False
            If ReportByProduct = False And ReportByTime = False And ViewOption = 0 And ExpandReceipt = False Then DisplayReceipt = True
            Dim ExtraCriteria As String = ""
            If DisplayReceipt = False Then
                ExtraCriteria = "  AND a.TransactionStatusID=2"
            End If

            If ChkIncome = True Then
                IncomeSelect = ",SUM(a.OtherIncome) As OtherIncome,SUM(a.OtherIncomeVAT) As OtherIncomeVAT"
            End If

            If ShopID = 0 And ReportByBill = True Then

                sqlStatement = "select CONCAT(a.ShopCode,':',a.ShopName) AS SaleDate,a.ShopID,a.ShopCode,a.ShopName,a.ShopOrdering,SUM(a.TotalBill) As TotalBill,SUM(a.TotalCustomer) As TotalCustomer,SUM(a.TransactionVATable) AS TransactionVATable,SUM(a.TransactionVAT) AS TransactionVAT,SUM(a.TransactionExcludeVAT) AS TransactionExcludeVAT,SUM(a.ServiceCharge) AS ServiceCharge,SUM(a.ServiceChargeVAT) AS ServiceChargeVAT,SUM(a.ReceiptTotalAmount) AS ReceiptTotalAmount,SUM(a.TotalDiscount) AS TotalDiscount, SUM(a.SalePrice) AS SalePrice,SUM(a.TotalRetailPrice) As RetailPrice" + IncomeSelect + " FROM Summary_TranReport a where a.TransactionStatusID=2 " + AdditionalQuery + " group by a.ShopID,a.ShopCode,a.ShopName,a.ShopOrdering Order By a.ShopOrdering,a.ShopID"

                sqlStatement2 = "select CONCAT(pl.ProductLevelCode,':',pl.ProductLevelName) AS SaleDate,a.ShopID,pl.ProductLevelCode,pl.ProductLevelName,pl.ProductLevelOrder,PayTypeID,PayTypeName,SUM(TotalPay) AS TotalPay,SUM(TotalPayDiscount) AS TotalPayDiscount, sum(TotalVAT) AS TotalVAT, SUM(TotalBill) As TotalBill, IsSale, IsVAT, IsOtherReceipt from Summary_PaymentReport a, ProductLevel pl where a.ShopID=pl.ProductLevelID " + PaymentQuery + " group by PayTypeID,PayTypeName,IsSale,IsVAT,IsOtherReceipt,a.ShopID,pl.ProductLevelCode,pl.ProductLevelName,pl.ProductLevelOrder order by pl.ProductLevelOrder,pl.ProductLevelID,PayTypeID"

                sqlStatement3 = "select CONCAT(pl.ProductLevelCode,':',pl.ProductLevelName) AS SaleDate,a.ShopID,pl.ProductLevelOrder,b.IncomeTypeID,c.IncomeCode AS IncomeName,SUM(b.IncomeAmount) As IncomeQty,SUM(b.Income) AS Income,SUM(b.IncomeVAT) AS IncomeVAT from ordertransaction a, ordertransactionotherincomedetail b, otherincometype c, ProductLevel pl where a.transactionid=b.transactionid and a.computerid=b.computerid and b.IncomeTypeID=c.IncomeTypeID AND a.ShopID=pl.ProductLevelID AND a.ReceiptID>0 AND a.TransactionStatusID=2 AND b.IncomeStatus=1 " + PaymentQuery + " group by b.IncomeTypeID,c.IncomeCode,a.ShopID,pl.ProductLevelCode,pl.ProductLevelName,pl.ProductLevelOrder order by pl.ProductLevelOrder,pl.ProductLevelID,b.IncomeTypeID"


            ElseIf DisplayReceipt = True Then
                objDB.sqlExecute("DROP TABLE IF EXISTS DummyDocType", objCnn)
                objDB.sqlExecute("create table DummyDocType (DocumentTypeID int, ComputerID int, DocumentTypeHeader varchar(50))", objCnn)
                objDB.sqlExecute("insert into DummyDocType select DocumentTypeID,ComputerID,DocumentTypeHeader from DocumentType where DocumentTypeID=11 AND langid=" + LangID.ToString, objCnn)

                Dim ChkColumn As Boolean = getProp.CheckColumnExist("ordertransaction", "ReceiptProductRetailPrice", objCnn)
                Dim SelSalePrice As String
                Dim SelRetailPrice As String
                If ChkColumn = True Then
                    SelSalePrice = "a.ReceiptProductRetailPrice-a.ReceiptDiscount"
                    SelRetailPrice = "a.ReceiptProductRetailPrice"
                Else
                    SelSalePrice = "a.ReceiptSalePrice-a.ServiceCharge-a.ServiceChargeVAT-a.TransactionExcludeVAT"
                    SelRetailPrice = "a.ReceiptSalePrice-a.ServiceCharge-a.ServiceChargeVAT-a.TransactionExcludeVAT+a.ReceiptDiscount"
                End If

                If ChkIncome = True Then
                    IncomeSelect = ",a.OtherIncome,a.OtherIncomeVAT"
                End If

                sqlStatement = "select CONCAT('T=',a.TransactionID,':C=',a.ComputerID) AS SaleDate,a.TransactionID,a.ComputerID,a.TransactionStatusID,a.ReceiptID,a.ReceiptMonth,a.ReceiptYear,pt.ReceiptNumber,a.DocType,dt.DocumentTypeHeader,ft.ReceiptID AS FReceiptID,ft.ReceiptMonth AS FReceiptMonth,ft.ReceiptYear AS FReceiptYear,dt1.DocumentTypeHeader AS DocTypeHeader,a.TransactionVATable AS TransactionVATable,1 AS TotalBill,a.NoCustomer AS TotalCustomer,a.TransactionVAT AS TransactionVAT,a.TransactionExcludeVAT AS TransactionExcludeVAT,a.ServiceCharge AS ServiceCharge,a.ServiceChargeVAT AS ServiceChargeVAT,a.ReceiptTotalAmount AS Amount,a.TransactionName,a.QueueName," + SelRetailPrice + " AS RetailPrice, " + SelSalePrice + " AS SalePrice,a.ReceiptDiscount As TotalDiscount,a.TableID,t.TableNumber,t.TableName" + ExtraSelect + IncomeSelect + " FROM OrderTransaction a left outer join PickTransactionDetail pt ON a.TransactionID=pt.TransactionID AND a.ComputerID=pt.ComputerID left outer join DocumentType dt ON a.DocType=dt.DocumentTypeID AND (a.CloseComputerID=dt.ComputerID OR a.ShopID=dt.ShopID) left outer join OrderFullTaxInvoiceLink ftl ON a.TransactionID=ftl.TransactionID AND a.ComputerID=ftl.ComputerID AND ftl.FullTaxStatus=2 left outer join OrderTransactionFullTaxInvoice ft ON ftl.FullTaxInvoiceID=ft.FullTaxInvoiceID AND ftl.FullTaxInvoiceComputerID=ft.FullTaxInvoiceComputerID AND ft.FullTaxStatus=2 left outer join DummyDocType dt1 ON ft.DocType=dt1.DocumentTypeID AND ft.CloseComputerID=dt1.ComputerID left outer join TableNo t ON a.TableID=t.TableID  " + ExtraSql + " where a.ReceiptID > 0 AND dt.LangID=" + LangID.ToString + AdditionalQuery + " Order By a.CloseComputerID,a.DocType,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"

                If ReportType = 0 Then
                    sqlStatement2 = "select CONCAT('T=',a.TransactionID,':C=',a.ComputerID) AS SaleDate,a.TransactionID,a.ComputerID,a.TransactionStatusID,a.DocType,b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT,COUNT(DISTINCT a.TransactionID,a.ComputerID) As TotalBill from ordertransaction a, paydetail" + BranchStr + " b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.PayTypeID=c.TypeID " + AdditionalQuery + " group by b.PayTypeID,c.PayType,IsSale,IsVAT,a.TransactionID,a.ComputerID,a.DocType,a.TransactionStatusID order by a.DocType,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"
                Else
                    sqlStatement2 = "select CONCAT('T=',a.TransactionID,':C=',a.ComputerID) AS SaleDate,a.TransactionID,a.ComputerID,a.TransactionStatusID,a.DocType,c.TypeID As PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT, COUNT(DISTINCT a.TransactionID,a.ComputerID) As TotalBill from ordertransaction a, paydetail" + BranchStr + " b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and IF(SmartcardType > 0,b.SmartcardType,b.PayTypeID)=c.TypeID " + AdditionalQuery + " group by c.TypeID,c.PayType,IsSale,IsVAT,a.TransactionID,a.ComputerID,a.DocType,a.TransactionStatusID order by a.DocType,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"
                End If


                sqlStatement3 = "select CONCAT('T=',a.TransactionID,':C=',a.ComputerID) AS SaleDate,a.TransactionID,a.ComputerID,a.TransactionStatusID,a.DocType,b.IncomeTypeID,c.IncomeCode AS IncomeName,SUM(b.IncomeAmount) As IncomeQty,SUM(b.Income) AS Income,SUM(b.IncomeVAT) AS IncomeVAT from ordertransaction a, ordertransactionotherincomedetail b, otherincometype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.IncomeTypeID=c.IncomeTypeID AND b.IncomeStatus=1 " + AdditionalQuery + " group by a.TransactionID,a.ComputerID,a.DocType,a.TransactionStatusID,b.IncomeTypeID,c.IncomeCode order by a.DocType,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"


            ElseIf ReportByTime = True Then
                If GroupByParam = 1 Then
                    sqlStatement = "select DAYNAME(a.SaleDate) AS SaleDate,SUM(a.TotalBill) As TotalBill,SUM(a.TotalCustomer) As TotalCustomer,SUM(a.TransactionVATable) AS TransactionVATable,SUM(a.TransactionVAT) AS TransactionVAT,SUM(a.TransactionExcludeVAT) AS TransactionExcludeVAT,SUM(a.ServiceCharge) AS ServiceCharge,SUM(a.ServiceChargeVAT) AS ServiceChargeVAT,SUM(a.ReceiptTotalAmount) AS ReceiptTotalAmount,SUM(a.TotalDiscount) AS TotalDiscount, SUM(a.SalePrice) AS SalePrice,SUM(a.TotalRetailPrice) As RetailPrice" + IncomeSelect + " FROM Summary_TranReport a where a.TransactionStatusID=2 " + AdditionalQuery + " group by WEEKDAY(a.SaleDate) Order By WEEKDAY(a.SaleDate)"

                    sqlStatement2 = "select DAYNAME(a.SaleDate) AS SaleDate,PayTypeID,PayTypeName,SUM(TotalPay) AS TotalPay,SUM(TotalPayDiscount) AS TotalPayDiscount, sum(TotalVAT) AS TotalVAT, SUM(TotalBill) As TotalBill, IsSale, IsVAT, IsOtherReceipt from Summary_PaymentReport a where 0=0 " + PaymentQuery + " group by PayTypeID,PayTypeName,IsSale,IsVAT,IsOtherReceipt,WEEKDAY(a.SaleDate) order by WEEKDAY(a.SaleDate),PayTypeID"

                    sqlStatement3 = "select DAYNAME(a.SaleDate) AS SaleDate,b.IncomeTypeID,c.IncomeCode AS IncomeName,SUM(b.IncomeAmount) As IncomeQty,SUM(b.Income) AS Income,SUM(b.IncomeVAT) AS IncomeVAT from ordertransaction a, ordertransactionotherincomedetail b, otherincometype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.IncomeTypeID=c.IncomeTypeID AND a.ReceiptID>0 AND a.TransactionStatusID=2 AND b.IncomeStatus=1 " + PaymentQuery + " group by b.IncomeTypeID,c.IncomeCode,WEEKDAY(a.SaleDate) order by WEEKDAY(a.SaleDate)"

                Else
                    'Check 24 Hour Feature
                    'Dim Chk As DataTable
                    Dim AllDayFeature As Boolean = False
                    If ShopID = 0 Then
                        Chk = objDB.List("select * from programpropertyvalue where ProgramTypeID=1 AND propertyid=1049 AND PropertyValue>0", objCnn)
                        If Chk.Rows.Count > 0 Then
                            AllDayFeature = True
                        End If
                    Else
                        Chk = objDB.List("select * from programpropertyvalue where ProgramTypeID=1 AND propertyid=1049 AND KeyID=" + ShopID.ToString + " AND PropertyValue>0", objCnn)
                        If Chk.Rows.Count > 0 Then
                            AllDayFeature = True
                        End If
                    End If

                    Dim IncomeSelect2 As String
                    If ChkIncome = True Then
                        IncomeSelect2 = ",IF(bb.OtherIncome is NULL,0,bb.OtherIncome) As OtherIncome,IF(bb.OtherIncomeVAT is NULL,0,bb.OtherIncomeVAT) As OtherIncomeVAT"
                    End If

                    If AllDayFeature = True Then

                        sqlStatement = "select bb.Hourly AS SaleDate,IF(bb.TransactionVATable is NULL,0,bb.TransactionVATable) As TransactionVATable,IF(bb.TotalBill is NULL,0,bb.TotalBill) As TotalBill,IF(bb.TotalCustomer is NULL,0,bb.TotalCustomer) As TotalCustomer,IF(bb.TransactionVAT is NULL,0,bb.TransactionVAT) As TransactionVAT,IF(bb.TransactionExcludeVAT is NULL,0,bb.TransactionExcludeVAT) As TransactionExcludeVAT,IF(bb.ServiceCharge is NULL,0,bb.ServiceCharge) As ServiceCharge,IF(bb.ServiceChargeVAT is NULL,0,bb.ServiceChargeVAT) As ServiceChargeVAT,IF(bb.ReceiptTotalAmount is NULL,0,bb.ReceiptTotalAmount) As Amount,IF(bb.TotalRetailPrice is NULL,0,bb.TotalRetailPrice) As RetailPrice,IF(bb.SalePrice is NULL,0,bb.SalePrice) As SalePrice,IF(bb.TotalDiscount is NULL,0,bb.TotalDiscount) As TotalDiscount" + IncomeSelect2 + " from (select Hourly,SUM(a.TransactionVATable) AS TransactionVATable,SUM(TotalBill) AS TotalBill,SUM(TotalCustomer) AS TotalCustomer,SUM(a.TransactionVAT) AS TransactionVAT,SUM(a.TransactionExcludeVAT) AS TransactionExcludeVAT,SUM(a.ServiceCharge) AS ServiceCharge,SUM(a.ServiceChargeVAT) AS ServiceChargeVAT,SUM(ReceiptTotalAmount) AS ReceiptTotalAmount,SUM(TotalRetailPrice) AS TotalRetailPrice, SUM(SalePrice) AS SalePrice,SUM(TotalDiscount) As TotalDiscount" + IncomeSelect + " FROM Summary_HourlyReport a where 0=0 " + AdditionalQuery + " group by Hourly) bb Order By bb.Hourly"

                    Else
                        Dim OpenShopID As Integer = ShopID
                        If ShopID = 0 Then
                            OpenShopID = 1
                        End If
                        Dim getOpenHour As DataTable = objDB.List("select HOUR(OpenHour) As OpenHour,HOUR(CloseHour) As CloseHour from productlevel where ProductLevelID=" + OpenShopID.ToString, objCnn)
                        Dim OpenHourVal As Integer = 0
                        Dim EndHourVal As Integer = 23
                        If getOpenHour.Rows.Count > 0 Then
                            If Not IsDBNull(getOpenHour.Rows(0)("OpenHour")) Then
                                OpenHourVal = getOpenHour.Rows(0)("OpenHour")
                            End If
                            If Not IsDBNull(getOpenHour.Rows(0)("CloseHour")) Then
                                EndHourVal = getOpenHour.Rows(0)("CloseHour")
                            End If
                        End If
                        objDB.sqlExecute("DROP TABLE IF EXISTS DummyHourly", objCnn)
                        objDB.sqlExecute("create table DummyHourly (ID int, Hourly int)", objCnn)
                        ii = 1
                        Dim i As Integer
                        Dim EndLoop As Integer = EndHourVal
                        If OpenHourVal >= EndHourVal Then
                            EndLoop = 23
                        End If
                        For i = OpenHourVal To EndLoop
                            objDB.sqlExecute("insert into DummyHourly (ID,Hourly) values (" & ii & "," & i & ")", objCnn)
                            ii += 1
                        Next
                        If OpenHourVal >= EndHourVal Then
                            If OpenHourVal = EndHourVal Then
                                EndLoop = EndHourVal - 1
                            Else
                                EndLoop = EndHourVal
                            End If
                            For i = 0 To EndLoop
                                objDB.sqlExecute("insert into DummyHourly (ID,Hourly) values (" & ii & "," & i & ")", objCnn)
                                ii += 1
                            Next
                        End If
                        

                        sqlStatement = "select aa.Hourly AS SaleDate,IF(bb.TransactionVATable is NULL,0,bb.TransactionVATable) As TransactionVATable,IF(bb.TotalBill is NULL,0,bb.TotalBill) As TotalBill,IF(bb.TotalCustomer is NULL,0,bb.TotalCustomer) As TotalCustomer,IF(bb.TransactionVAT is NULL,0,bb.TransactionVAT) As TransactionVAT,IF(bb.TransactionExcludeVAT is NULL,0,bb.TransactionExcludeVAT) As TransactionExcludeVAT,IF(bb.ServiceCharge is NULL,0,bb.ServiceCharge) As ServiceCharge,IF(bb.ServiceChargeVAT is NULL,0,bb.ServiceChargeVAT) As ServiceChargeVAT,IF(bb.ReceiptTotalAmount is NULL,0,bb.ReceiptTotalAmount) As Amount,IF(bb.TotalRetailPrice is NULL,0,bb.TotalRetailPrice) As RetailPrice,IF(bb.SalePrice is NULL,0,bb.SalePrice) As SalePrice,IF(bb.TotalDiscount is NULL,0,bb.TotalDiscount) As TotalDiscount" + IncomeSelect2 + " from DummyHourly aa left outer join (select Hourly As OpenHour,SUM(a.TransactionVATable) AS TransactionVATable,SUM(TotalBill) AS TotalBill,SUM(TotalCustomer) AS TotalCustomer,SUM(a.TransactionVAT) AS TransactionVAT,SUM(a.TransactionExcludeVAT) AS TransactionExcludeVAT,SUM(a.ServiceCharge) AS ServiceCharge,SUM(a.ServiceChargeVAT) AS ServiceChargeVAT,SUM(ReceiptTotalAmount) AS ReceiptTotalAmount,SUM(TotalRetailPrice) AS TotalRetailPrice, SUM(SalePrice) AS SalePrice,SUM(TotalDiscount) As TotalDiscount" + IncomeSelect + " FROM Summary_HourlyReport a where 0=0 " + AdditionalQuery + " group by Hourly) bb ON aa.Hourly=bb.OpenHour Order By aa.ID"

                    End If
                    If ReportType = 0 Then
                        sqlStatement2 = "select HOUR(a.OpenTime) AS SaleDate,b.PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT, COUNT(DISTINCT a.TransactionID,a.ComputerID) As TotalBill from ordertransaction a, paydetail b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.PayTypeID=c.TypeID and a.TransactionStatusID=2 " + AdditionalQuery + " group by b.PayTypeID,c.PayType,IsSale,IsVAT,HOUR(a.OpenTime) order by HOUR(a.OpenTime),b.PayTypeID"
                    Else
                        sqlStatement2 = "select HOUR(a.OpenTime) AS SaleDate,c.TypeID As PayTypeID,c.PayType AS PayTypeName,SUM(b.Amount) AS TotalPay,SUM(Round(b.Amount*b.PrepaidDiscountPercent/100,2)) AS TotalPayDiscount, sum(paymentVAT) AS TotalVAT, IsSale, IsVAT, COUNT(DISTINCT a.TransactionID,a.ComputerID) As TotalBill from ordertransaction a, paydetail b, paytype c where a.transactionid=b.transactionid and a.computerid=b.computerid and IF(SmartcardType > 0,b.SmartcardType,b.PayTypeID)=c.TypeID and a.TransactionStatusID=2 " + AdditionalQuery + " group by c.TypeID,c.PayType,IsSale,IsVAT,HOUR(a.OpenTime) order by HOUR(a.OpenTime),b.PayTypeID"
                    End If

                    sqlStatement3 = "select HOUR(a.OpenTime) AS SaleDate,b.IncomeTypeID,c.IncomeCode AS IncomeName,SUM(b.IncomeAmount) As IncomeQty,SUM(b.Income) AS Income,SUM(b.IncomeVAT) AS IncomeVAT from ordertransaction a, ordertransactionotherincomedetail b, otherincometype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.IncomeTypeID=c.IncomeTypeID AND a.ReceiptID>0 AND a.TransactionStatusID=2 AND b.IncomeStatus=1 " + AdditionalQuery + " group by b.IncomeTypeID,c.IncomeCode,HOUR(a.OpenTime) order by HOUR(a.OpenTime),b.IncomeTypeID"
                End If
            Else
                If ViewOption = 4 Then

                    sqlStatement = "select DATE_FORMAT(a.SaleDate,'%M') AS SaleDate,SUM(a.TotalBill) As TotalBill,SUM(a.TotalCustomer) As TotalCustomer,SUM(a.TransactionVATable) AS TransactionVATable,SUM(a.TransactionVAT) AS TransactionVAT,SUM(a.TransactionExcludeVAT) AS TransactionExcludeVAT,SUM(a.ServiceCharge) AS ServiceCharge,SUM(a.ServiceChargeVAT) AS ServiceChargeVAT,SUM(a.ReceiptTotalAmount) AS ReceiptTotalAmount,SUM(a.TotalDiscount) AS TotalDiscount, SUM(a.SalePrice) AS SalePrice,SUM(a.TotalRetailPrice) As RetailPrice" + IncomeSelect + " FROM Summary_TranReport a where a.TransactionStatusID=2 " + AdditionalQuery + " group by  MONTH(a.SaleDate) Order By  MONTH(a.SaleDate)"

                    sqlStatement2 = "select DATE_FORMAT(a.SaleDate,'%M') AS SaleDate,PayTypeID,PayTypeName,SUM(TotalPay) AS TotalPay,SUM(TotalPayDiscount) AS TotalPayDiscount, sum(TotalVAT) AS TotalVAT, sum(TotalBill) As TotalBill, IsSale, IsVAT, IsOtherReceipt from Summary_PaymentReport a where 0=0 " + PaymentQuery + " group by PayTypeID,PayTypeName,IsSale,IsVAT,IsOtherReceipt,MONTH(a.SaleDate) order by MONTH(a.SaleDate),PayTypeID"

                    sqlStatement3 = "select DATE_FORMAT(a.SaleDate,'%M') AS SaleDate,b.IncomeTypeID,c.IncomeCode AS IncomeName,SUM(b.IncomeAmount) As IncomeQty,SUM(b.Income) AS Income,SUM(b.IncomeVAT) AS IncomeVAT from ordertransaction a, ordertransactionotherincomedetail b, otherincometype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.IncomeTypeID=c.IncomeTypeID AND a.ReceiptID>0 AND a.TransactionStatusID=2 AND b.IncomeStatus=1 " + PaymentQuery + " group by b.IncomeTypeID,c.IncomeCode,MONTH(a.SaleDate)  order by MONTH(a.SaleDate),b.IncomeTypeID"

                Else

                    sqlStatement = "select a.SaleDate,SUM(a.TotalBill) As TotalBill,SUM(a.TotalCustomer) As TotalCustomer,SUM(a.TransactionVATable) AS TransactionVATable,SUM(a.TransactionVAT) AS TransactionVAT,SUM(a.TransactionExcludeVAT) AS TransactionExcludeVAT,SUM(a.ServiceCharge) AS ServiceCharge,SUM(a.ServiceChargeVAT) AS ServiceChargeVAT,SUM(a.ReceiptTotalAmount) AS ReceiptTotalAmount,SUM(a.TotalDiscount) AS TotalDiscount, SUM(a.SalePrice) AS SalePrice,SUM(a.TotalRetailPrice) As RetailPrice" + IncomeSelect + " FROM Summary_TranReport a where a.TransactionStatusID=2 " + AdditionalQuery + " group by a.SaleDate Order By a.SaleDate"

                    sqlStatement2 = "select a.SaleDate,PayTypeID,PayTypeName,SUM(TotalPay) AS TotalPay,SUM(TotalPayDiscount) AS TotalPayDiscount, sum(TotalVAT) AS TotalVAT, sum(TotalBill) As TotalBill, IsSale, IsVAT, IsOtherReceipt from Summary_PaymentReport a where 0=0 " + PaymentQuery + " group by PayTypeID,PayTypeName,IsSale,IsVAT,IsOtherReceipt,a.SaleDate order by a.SaleDate,PayTypeID"

                    sqlStatement3 = "select a.SaleDate,b.IncomeTypeID,c.IncomeCode AS IncomeName,SUM(b.IncomeAmount) As IncomeQty,SUM(b.Income) AS Income,SUM(b.IncomeVAT) AS IncomeVAT from ordertransaction a, ordertransactionotherincomedetail b, otherincometype c where a.transactionid=b.transactionid and a.computerid=b.computerid and b.IncomeTypeID=c.IncomeTypeID AND a.ReceiptID>0 AND a.TransactionStatusID=2 AND b.IncomeStatus=1 " + PaymentQuery + " group by b.IncomeTypeID,c.IncomeCode,a.SaleDate order by a.SaleDate,b.IncomeTypeID"

                End If
            End If

            Dim IncomeData As DataTable
            sqlStatement1 = "select PayTypeID,PayTypeName,SUM(TotalPay) AS TotalPay,SUM(TotalPayDiscount) AS TotalPayDiscount, sum(TotalVAT) AS TotalVAT, SUM(TotalBill) As TotalBill, IsSale, IsVAT, IsOtherReceipt from Summary_PaymentReport a where 0=0 " + PaymentQuery + " group by PayTypeID,PayTypeName,IsSale,IsVAT,IsOtherReceipt order by PayTypeID,PayTypeName,IsSale DESC"

            TimeNow = DateTimeUtil.CurrentDateTime
            GetData = objDB.List(sqlStatement, objCnn)
            TimeNow += "<BR>Out Data:" + DateTimeUtil.CurrentDateTime
            PayTypeData = objDB.List(sqlStatement2, objCnn)
            TimeNow += "<BR>Payment Data:" + DateTimeUtil.CurrentDateTime

            sqlStatement = "select PromotionID,PromotionName,SUM(TotalDiscount) As TotalDiscount,SUM(PriceAfterDiscount) As PriceAfterDiscount from Summary_PromotionReport a where 0=0 " + PaymentQuery + " group by PromotionID,PromotionName order by SUM(TotalDiscount) DESC"
            PromotionData = objDB.List(sqlStatement, objCnn)
            TimeNow += "<BR>Promotion Data:" + DateTimeUtil.CurrentDateTime

            If sqlStatement3 <> "" And ChkIncome = True Then
                IncomeData = objDB.List(sqlStatement3, objCnn)
            Else
                IncomeData = objDB.List("select * from BankName where 0=1", objCnn)
            End If
            TimeNow += "<BR>Income Data:" + DateTimeUtil.CurrentDateTime

            ResultString = Reports.SaleReportByDate(GraphData, GrayBGColor, AdminBGColor, ShopID, ViewOption, StartDate, EndDate, GetData, objDB.List(sqlStatement1, objCnn), PayByCreditMoney, PayTypeList, PayTypeData, PromotionData, ChkIncome, IncomeData, IncomeType, DisplayGraph, DisplayReceipt, LangID, LangPath, objCnn)

            TimeNow += "<BR>Result Data:" + DateTimeUtil.CurrentDateTime

            'objDB.sqlExecute("DROP TABLE IF EXISTS DummyHourly", objCnn)
            'objDB.sqlExecute("DROP TABLE IF EXISTS DummyDocType", objCnn)

            Return ResultString
        End If

    End Function
	
	Public Function SaleReportByProduct(ByVal BySaleMode As Boolean, ByVal PromotionData As DataTable, ByRef GraphData As DataSet, ByRef ResultString As String, ByRef grandTotal As Double, ByRef VATTotal As Double, ByVal ShowSummary As Boolean, ByVal GrayBGColor As String, ByVal AdminBGColor As String, ByVal ShopID As String, ByVal ViewOption As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal dtTable As DataTable, ByVal PaymentResult As DataTable, ByVal PayByCreditMoney As DataTable, ByVal LangID As Integer, ByVal LangPath As String, ByVal objCnn As MySqlConnection) As String

        Dim FormatData As DataTable = Fm.FormatParam(FormatObject, LangID, objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
        Dim LangData2 As DataTable = pRoMiSeLanguage.pRoMiSeLanguage.LangInfo(6, 2, -1, LangPath)
        Dim LangText As String = "lang" + LangID.ToString

        Dim i As Integer
        Dim outputString As StringBuilder = New StringBuilder
        Dim counter As Integer
        Dim ShowString As String = ""
        Dim subTotalRetailPrice As Double = 0
        Dim subTotalPriceDiscount As Double = 0
        Dim subTotalDiscount As Double = 0
        Dim subTotalBeforeVAT As Double = 0
        Dim subTotalVAT As Double = 0
        Dim subTotalAfterVAT As Double = 0
        Dim subTotalOtherDiscount As Double = 0
        Dim subTotalQty As Double = 0

        Dim subTotalGroupRetailPrice As Double = 0
        Dim subTotalGroupPriceDiscount As Double = 0
        Dim subTotalGroupDiscount As Double = 0
        Dim subTotalGroupBeforeVAT As Double = 0
        Dim subTotalGroupVAT As Double = 0
        Dim subTotalGroupAfterVAT As Double = 0
        Dim subTotalGroupOtherDiscount As Double = 0
        Dim subTotalGroupQty As Double = 0

        Dim subTotalRetailPriceDate As Double = 0
        Dim subTotalPriceDiscountDate As Double = 0
        Dim subTotalDiscountDate As Double = 0
        Dim subTotalBeforeVATDate As Double = 0
        Dim subTotalVATDate As Double = 0
        Dim subTotalAfterVATDate As Double = 0
        Dim subTotalOtherDiscountDate As Double = 0
        Dim subTotalServiceChargeDate As Double = 0

        Dim grandTotalRetailPrice As Double = 0
        Dim grandTotalPriceDiscount As Double = 0
        Dim grandTotalDiscount As Double = 0
        Dim grandTotalBeforeVAT As Double = 0
        Dim grandTotalVAT As Double = 0
        Dim grandTotalAfterVAT As Double = 0
        Dim grandTotalOtherDiscount As Double = 0
        Dim grandTotalServiceCharge As Double = 0
        Dim grandTotalQty As Double = 0
        Dim DiscountArray(7) As Double
        Dim grandTotalVoid As Double = 0

        Dim RetailPriceAfterVAT As Double = 0
        Dim TextClass As String
        Dim DummyGroupID, DummyDeptID As String
        Dim VATString As String
        Dim TotalProductDiscount As Double
        Dim bgColor As String = "white" 'GlobalParam.GrayBGColor
        Dim ExtraInfo As String
        Dim getProp As New CPreferences

        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

        TextClass = "smallText"

        Dim table As DataTable = GraphData.Tables.Add("Data")
        table.Columns.Add("Description")
        table.Columns.Add("Value1", GetType(Double))

        Dim CompareDeptID, CompareGroupID As String
        counter = 1
        Dim PriceDiscount, PricePerUnit, ProductQty As Double
        Dim totalSale As Double = 0
        Dim totalSaleBeforeDiscount As Double = 0
        Dim totalQty As Integer = 0
        Dim SumSaleMode As Double = 0

        Dim SaleModePriceDiscount As Double = 0
        Dim SaleModeDiscount As Double = 0
        Dim SaleModeBeforeVAT As Double = 0
        Dim SaleModeVAT As Double = 0
        Dim SaleModeAfterVAT As Double = 0
        Dim SaleModeRetailPrice As Double = 0
        Dim SaleModeQty As Double = 0
		
		Dim subTotalTax As Double = 0
		Dim subTotalBeforeTax As Double = 0
		Dim grandTotalTax As Double = 0
		Dim grandTotalBeforeTax As Double = 0
		Dim subTotalGroupTax As Double  = 0
		Dim subTotalGroupBeforeTax As Double = 0

        Dim ChangeSM As Boolean

        For i = 0 To dtTable.Rows.Count - 1
            If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                If Not IsDBNull(dtTable.Rows(i)("SalePrice")) Then
                    totalSale += dtTable.Rows(i)("SalePrice")
                End If
                If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) Then
                    totalSaleBeforeDiscount += dtTable.Rows(i)("TotalRetailPrice")
                End If
                totalQty += dtTable.Rows(i)("Amount")
            End If
        Next
        For i = 0 To dtTable.Rows.Count - 1

            If BySaleMode = True Then
                If i = 0 Then
                    outputString = outputString.Append("<tr><td align=""center"" colspan=""7"" class=""" + "smallboldtext" + """ bgColor=""" + "#ffe4b5" + """>" + dtTable.Rows(i)("SaleModeName") + "</td></tr>")
                End If
            End If

            If i = 0 Then
                outputString = outputString.Append("<tr><td colspan=""7"" class=""tdHeader"" bgColor=""" + AdminBGColor + """>" + dtTable.Rows(i)("ProductGroupName") + " :: " + dtTable.Rows(i)("ProductDeptName") + "</td></tr>")
            End If

            outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")

            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & counter.ToString & ")</td>")

            If Not IsDBNull(dtTable.Rows(i)("ProductCode")) Then
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("ProductCode") & "</td>")
            Else
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>")
            End If
            If dtTable.Rows(i)("ProductSettype") < 0 Then
                ExtraInfo = "**"
            ElseIf dtTable.Rows(i)("OrderStatusID") = 5 Then
                ExtraInfo = "*"
            ElseIf Not IsDBNull(dtTable.Rows(i)("ProductIDLink")) Then
                ExtraInfo = "**"
            Else
                ExtraInfo = ""
            End If
            If Not IsDBNull(dtTable.Rows(i)("ProductName")) Then
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("ProductName") + ExtraInfo & "</td>")
            ElseIf Not IsDBNull(dtTable.Rows(i)("OtherFoodName")) Then
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("OtherFoodName") & "</td>")
            Else
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>")
            End If
            If Not IsDBNull(dtTable.Rows(i)("Amount")) Then

                ProductQty = dtTable.Rows(i)("Amount")
                If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                    subTotalQty += ProductQty
                    grandTotalQty += ProductQty
                    subTotalGroupQty += ProductQty
                    SaleModeQty += ProductQty
                End If
            Else
                ProductQty = 0
            End If

            If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) Then
                If dtTable.Rows(i)("ProductSettype") < 0 And dtTable.Rows(i)("ProductSettype") <> -4 Then
                    RetailPriceAfterVAT = 0
                Else
                    RetailPriceAfterVAT = dtTable.Rows(i)("TotalRetailPrice")
                End If
                PricePerUnit = RetailPriceAfterVAT / ProductQty
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(PricePerUnit).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
                If ProductQty > 0 Then
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(ProductQty).ToString(FormatObject.QtyFormat, ci) & "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl((ProductQty / totalQty)).ToString(FormatObject.PercentFormat, ci) & "</td>")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                End If
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(RetailPriceAfterVAT).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl((RetailPriceAfterVAT / totalSaleBeforeDiscount)).ToString(FormatObject.PercentFormat, ci) & "</td>")
                If dtTable.Rows(i)("TransactionStatusID") = 2 And (dtTable.Rows(i)("ProductSettype") >= 0 Or dtTable.Rows(i)("ProductSettype") = -4) Then
                    subTotalRetailPrice += dtTable.Rows(i)("TotalRetailPrice")
                    grandTotalRetailPrice += dtTable.Rows(i)("TotalRetailPrice")
                    subTotalGroupRetailPrice += dtTable.Rows(i)("TotalRetailPrice")
                    SaleModeRetailPrice += dtTable.Rows(i)("TotalRetailPrice")
                End If
            Else
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(0).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
                If ProductQty > 0 Then
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(ProductQty).ToString(FormatObject.QtyFormat, ci) & "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl((ProductQty / totalQty)).ToString(FormatObject.PercentFormat, ci) & "</td>")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                End If
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(0).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(0).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
                PricePerUnit = 0
            End If

            If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And (dtTable.Rows(i)("ProductSettype") >= 0 Or dtTable.Rows(i)("ProductSettype") = -4) Then
                PriceDiscount = dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalPrice")
                If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                    subTotalPriceDiscount += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalPrice")
                    grandTotalPriceDiscount += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalPrice")
                    subTotalGroupPriceDiscount += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalPrice")
                    SaleModePriceDiscount += dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalPrice")
                End If
            Else
                PriceDiscount = 0

            End If

            If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                TotalProductDiscount = 0
                If Not IsDBNull(dtTable.Rows(i)("MemberDiscount")) Then
                    TotalProductDiscount += dtTable.Rows(i)("MemberDiscount")
                    DiscountArray(2) += dtTable.Rows(i)("MemberDiscount")
                End If
                If Not IsDBNull(dtTable.Rows(i)("StaffDiscount")) Then
                    TotalProductDiscount += dtTable.Rows(i)("StaffDiscount")
                    DiscountArray(3) += dtTable.Rows(i)("StaffDiscount")
                End If
                If Not IsDBNull(dtTable.Rows(i)("CouponDiscount")) Then
                    TotalProductDiscount += dtTable.Rows(i)("CouponDiscount")
                    DiscountArray(4) += dtTable.Rows(i)("CouponDiscount")
                End If
                If Not IsDBNull(dtTable.Rows(i)("OtherPercentDiscount")) Then
                    TotalProductDiscount += dtTable.Rows(i)("OtherPercentDiscount")
                    DiscountArray(6) += dtTable.Rows(i)("OtherPercentDiscount")
                End If
                If Not IsDBNull(dtTable.Rows(i)("EachProductOtherDiscount")) Then
                    TotalProductDiscount += dtTable.Rows(i)("EachProductOtherDiscount")
                    DiscountArray(6) += dtTable.Rows(i)("EachProductOtherDiscount")
                End If
                If Not IsDBNull(dtTable.Rows(i)("VoucherDiscount")) Then
                    TotalProductDiscount += dtTable.Rows(i)("VoucherDiscount")
                    DiscountArray(5) += dtTable.Rows(i)("VoucherDiscount")
                End If
                'If Not IsDBNull(dtTable.Rows(i)("CompensateOtherDiscount")) Then
                'TotalProductDiscount += dtTable.Rows(i)("CompensateOtherDiscount")
                'DiscountArray(6) += dtTable.Rows(i)("CompensateOtherDiscount")
                'End If
                If Not IsDBNull(dtTable.Rows(i)("PricePromotionDiscount")) Then
                    TotalProductDiscount += dtTable.Rows(i)("PricePromotionDiscount")
                    DiscountArray(1) += dtTable.Rows(i)("PricePromotionDiscount")
                End If
                subTotalDiscount += TotalProductDiscount
                grandTotalDiscount += TotalProductDiscount
                subTotalGroupDiscount += TotalProductDiscount
                SaleModeDiscount += TotalProductDiscount
            End If


            'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(TotalProductDiscount + PriceDiscount).ToString(FormatObject.CurrencyFormat, ci) & "</td>")

            'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(RetailPriceAfterVAT - TotalProductDiscount - PriceDiscount).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
            'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(((RetailPriceAfterVAT - TotalProductDiscount - PriceDiscount) / totalSale)).ToString(FormatObject.PercentFormat, ci) & "</td>")
			
			'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(dtTable.Rows(i)("ProductTax")).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(dtTable.Rows(i)("SalePrice") - dtTable.Rows(i)("ProductTax")).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
			
            If dtTable.Rows(i)("ProductSettype") >= 0 Or dtTable.Rows(i)("ProductSettype") = -4 Then
                If dtTable.Rows(i)("TransactionStatusID") = 2 Then
                    subTotalAfterVAT += RetailPriceAfterVAT - TotalProductDiscount - PriceDiscount
                    grandTotalAfterVAT += RetailPriceAfterVAT - TotalProductDiscount - PriceDiscount
                    subTotalGroupAfterVAT += RetailPriceAfterVAT - TotalProductDiscount - PriceDiscount
                    SaleModeAfterVAT += RetailPriceAfterVAT - TotalProductDiscount - PriceDiscount
					subTotalTax += dtTable.Rows(i)("ProductTax")
					subTotalBeforeTax += dtTable.Rows(i)("SalePrice") - dtTable.Rows(i)("ProductTax")
					subTotalGroupTax += dtTable.Rows(i)("ProductTax")
					subTotalGroupBeforeTax += dtTable.Rows(i)("SalePrice") - dtTable.Rows(i)("ProductTax")
					grandTotalTax += dtTable.Rows(i)("ProductTax")
					grandTotalBeforeTax += dtTable.Rows(i)("SalePrice") - dtTable.Rows(i)("ProductTax")
                Else
                    grandTotalVoid += RetailPriceAfterVAT - TotalProductDiscount - PriceDiscount
                End If
            End If

            If dtTable.Rows(i)("VATType") = 0 Then
                VATString = "N"
            ElseIf dtTable.Rows(i)("VATType") = 1 Then
                VATString = "V"
            Else
                VATString = "E"
            End If
            outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" & VATString & "</td>")
            outputString = outputString.Append("</tr>")

            counter = counter + 1

            If i < dtTable.Rows.Count - 1 Then
                If dtTable.Rows(i + 1)("ProductDeptCode") <> dtTable.Rows(i)("ProductDeptCode") Then
                    outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
                    outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(91)(LangText) + " " + dtTable.Rows(i)("ProductDeptName") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((subTotalQty / totalQty)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                    'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl((subTotalRetailPrice / totalSaleBeforeDiscount)).ToString(FormatObject.PercentFormat, ci) & "</td>")
                    'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalPriceDiscount + subTotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((subTotalAfterVAT / totalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
					'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalTax).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
					outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalBeforeTax).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td></td></tr>")

                    counter = 1
                    subTotalPriceDiscount = 0
                    subTotalDiscount = 0
                    subTotalBeforeVAT = 0
                    subTotalVAT = 0
                    subTotalAfterVAT = 0
                    subTotalRetailPrice = 0
                    subTotalQty = 0
					
					subTotalTax = 0
					subTotalBeforeTax = 0

                End If

                If dtTable.Rows(i + 1)("ProductGroupCode") <> dtTable.Rows(i)("ProductGroupCode") Then
                    outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                    outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(89)(LangText) + " " + dtTable.Rows(i)("ProductGroupName") + LangData2.Rows(90)(LangText) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((subTotalGroupQty / totalQty)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                    'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl((subTotalGroupRetailPrice / totalSaleBeforeDiscount)).ToString(FormatObject.PercentFormat, ci) & "</td>")
                    'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupPriceDiscount + subTotalGroupDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((subTotalGroupAfterVAT / totalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
					'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupTax).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
					outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupBeforeTax).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td></td></tr>")
                    Dim row As DataRow = table.NewRow()
                    row("Description") = dtTable.Rows(i)("ProductGroupName")
                    row("Value1") = CDbl((subTotalGroupAfterVAT / totalSale) * 100).ToString(FormatObject.NumericFormat, ci)
                    table.Rows.Add(row)

                    subTotalGroupPriceDiscount = 0
                    subTotalGroupDiscount = 0
                    subTotalGroupBeforeVAT = 0
                    subTotalGroupVAT = 0
                    subTotalGroupAfterVAT = 0
                    subTotalGroupRetailPrice = 0
                    subTotalGroupQty = 0
					subTotalGroupTax = 0
					subTotalGroupBeforeTax = 0

                    subTotalPriceDiscount = 0
                    subTotalDiscount = 0
                    subTotalBeforeVAT = 0
                    subTotalVAT = 0
                    subTotalAfterVAT = 0
                    subTotalRetailPrice = 0
                    subTotalQty = 0
					subTotalTax = 0
					subTotalBeforeTax = 0
                End If

                If BySaleMode = True Then
                    If dtTable.Rows(i + 1)("SaleMode") <> dtTable.Rows(i)("SaleMode") Then
                        outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                        outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""" + TextClass + """>" + "Summary for Sale Mode " + dtTable.Rows(i)("SaleModeName") + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SaleModeQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((SaleModeQty / totalQty)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                        'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SaleModeRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                        'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl((SaleModeRetailPrice / totalSaleBeforeDiscount)).ToString(FormatObject.PercentFormat, ci) & "</td>")
                        'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SaleModePriceDiscount + SaleModeDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                        'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SaleModeAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                        'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((SaleModeAfterVAT / totalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                        outputString = outputString.Append("<td></td></tr>")

                        outputString = outputString.Append("<tr><td align=""center"" colspan=""7"" class=""" + "smallboldtext" + """ bgColor=""" + "#ffe4b5" + """>" + dtTable.Rows(i + 1)("SaleModeName") + "</td></tr>")

                        SaleModePriceDiscount = 0
                        SaleModeDiscount = 0
                        SaleModeBeforeVAT = 0
                        SaleModeVAT = 0
                        SaleModeAfterVAT = 0
                        SaleModeRetailPrice = 0
                        SaleModeQty = 0

                        subTotalGroupPriceDiscount = 0
                        subTotalGroupDiscount = 0
                        subTotalGroupBeforeVAT = 0
                        subTotalGroupVAT = 0
                        subTotalGroupAfterVAT = 0
                        subTotalGroupRetailPrice = 0
                        subTotalGroupQty = 0
						subTotalGroupTax = 0
						subTotalGroupBeforeTax = 0

                        subTotalPriceDiscount = 0
                        subTotalDiscount = 0
                        subTotalBeforeVAT = 0
                        subTotalVAT = 0
                        subTotalAfterVAT = 0
                        subTotalRetailPrice = 0
                        subTotalQty = 0
						subTotalTax = 0
						subTotalBeforeTax = 0
                    End If
                End If

                If dtTable.Rows(i + 1)("ProductDeptCode") <> dtTable.Rows(i)("ProductDeptCode") Or (dtTable.Rows(i + 1)("SaleMode") <> dtTable.Rows(i)("SaleMode") And BySaleMode = True) Then
                    outputString = outputString.Append("<tr><td colspan=""7"" class=""tdHeader"" bgColor=""" + AdminBGColor + """>" + dtTable.Rows(i + 1)("ProductGroupName") + " :: " + dtTable.Rows(i + 1)("ProductDeptName") + "</td></tr>")
                End If
            End If

            If Not IsDBNull(dtTable.Rows(i)("ProductGroupCode")) Then
                DummyGroupID = dtTable.Rows(i)("ProductGroupCode")
            Else
                DummyGroupID = ""
            End If
            If Not IsDBNull(dtTable.Rows(i)("ProductDeptCode")) Then
                DummyDeptID = dtTable.Rows(i)("ProductDeptCode")
            Else
                DummyDeptID = ""
            End If

        Next
        If counter > 0 Then
            outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
            If i > 0 Then
                outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(91)(LangText) + " " + dtTable.Rows(i - 1)("ProductDeptName") + "</td>")
            Else
                outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""" + TextClass + """></td>")
            End If
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((subTotalQty / totalQty)).ToString(FormatObject.PercentFormat, ci) + "</td>")
            'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl((subTotalRetailPrice / totalSaleBeforeDiscount)).ToString(FormatObject.PercentFormat, ci) & "</td>")
            'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalPriceDiscount + subTotalDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl((subTotalAfterVAT / totalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
			'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalTax).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
			outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalBeforeTax).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
            outputString = outputString.Append("<td></td></tr>")
            If dtTable.Rows.Count > 0 Then
                Dim row As DataRow = table.NewRow()
                row("Description") = dtTable.Rows(i - 1)("ProductGroupName")
                row("Value1") = CDbl((subTotalGroupAfterVAT / totalSale) * 100).ToString(FormatObject.NumericFormat, ci)
                table.Rows.Add(row)
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(89)(LangText) + " " + dtTable.Rows(i - 1)("ProductGroupName") + LangData2.Rows(90)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(((subTotalGroupQty) / totalQty)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl((subTotalGroupRetailPrice / totalSaleBeforeDiscount)).ToString(FormatObject.PercentFormat, ci) & "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupPriceDiscount + subTotalGroupDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(((subTotalGroupAfterVAT) / totalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
				'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupTax).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(subTotalGroupBeforeTax).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td></td></tr>")

                If BySaleMode = True Then
                    outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                    outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""" + TextClass + """>" + "Summary for Sale Mode " + dtTable.Rows(i - 1)("SaleModeName") + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SaleModeQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
                    outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(((SaleModeQty) / totalQty)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                    'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SaleModeRetailPrice).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl(((SaleModeRetailPrice) / totalSaleBeforeDiscount)).ToString(FormatObject.PercentFormat, ci) & "</td>")
                    'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SaleModePriceDiscount + SaleModeDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(SaleModeAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                    'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(((SaleModeAfterVAT) / totalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                    outputString = outputString.Append("<td></td></tr>")

                End If

                outputString = outputString.Append("<tr><td colspan=""7"" height=""5""></td></tr>")
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""3"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(92)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(totalQty).ToString(FormatObject.QtyFormat, ci) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(((totalQty) / totalQty)).ToString(FormatObject.PercentFormat, ci) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(totalSaleBeforeDiscount).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & CDbl((totalSaleBeforeDiscount / totalSaleBeforeDiscount)).ToString(FormatObject.PercentFormat, ci) & "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(totalSaleBeforeDiscount - totalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(totalSale).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(((totalSale) / totalSale)).ToString(FormatObject.PercentFormat, ci) + "</td>")
				'outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(grandTotalTax).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
				outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + CDbl(grandTotalBeforeTax).ToString(FormatObject.CurrencyFormat, ci) + "</td>")
                outputString = outputString.Append("<td></td></tr>")

            End If

        End If

        'outputString = outputString.Append("</table>")

        If ShowSummary = True Then
            Dim ServiceChargeQuery As String = ""

            If ShopID <> "" Then
                ServiceChargeQuery = " AND a.ShopID IN (" + ShopID.ToString + ")"
            End If
            Dim grandTotalServiceChargeVAT As Double = 0

            Dim ProductLevelID As Integer
            Dim ShopIDVal As Integer
            Dim shopArray() As String
            shopArray = ShopID.Split(","c)

            If shopArray.Length > 1 Then
                ProductLevelID = 1
                ShopIDVal = 0
            Else
                ShopIDVal = CInt(ShopID)
            End If

            Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel where ProductLevelID=" + ProductLevelID.ToString, objCnn)
            Dim DisplayVATType As String = "V"
            If ShopInfo.Rows.Count > 0 Then
                If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
                    DisplayVATType = "E"
                End If
            Else
                ShopInfo = objDB.List("select * from ProductLevel where IsShop=1 AND Deleted=0", objCnn)
                If ShopInfo.Rows.Count > 0 Then
                    If ShopInfo.Rows(0)("DisplayReceiptVATableType") = 2 Then
                        DisplayVATType = "E"
                    End If
                End If
            End If

            outputString = outputString.Append("<tr><td colspan=""7"" height=""5""></td></tr>")

            Dim serviceCharge As DataTable = objDB.List("select SUM(a.ServiceCharge) AS ServiceCharge, SUM(a.ServiceChargeVAT) AS ServiceChargeVAT from  Summary_TranReport a WHERE TransactionStatusID=2 AND SaleDate >= " + StartDate + " AND SaleDate < " + EndDate + ServiceChargeQuery, objCnn)
            If Not IsDBNull(serviceCharge.Rows(0)("ServiceCharge")) Then
                grandTotalServiceCharge = serviceCharge.Rows(0)("ServiceCharge") + serviceCharge.Rows(0)("ServiceChargeVAT")
                grandTotalServiceChargeVAT = serviceCharge.Rows(0)("ServiceChargeVAT")
            Else
                grandTotalServiceCharge = 0
            End If

            Dim grandTotalOtherIncome As Double = 0
            Dim ChkIncome As Boolean = getProp.CheckTableExist("ordertransactionotherincomedetail", objCnn)
            Dim IncomeText As String = ""
            If ChkIncome = True Then
                Dim OtherIncome As DataTable = objDB.List("select b.IncomeTypeID,c.DisplayName As IncomeName,SUM(b.Income) AS Income, SUM(b.IncomeVAT) AS IncomeVAT from ordertransaction a, ordertransactionotherincomedetail b, OtherIncomeType c  WHERE a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.IncomeTypeID=c.IncomeTypeID AND a.TransactionStatusID=2 AND b.IncomeStatus=1 AND ReceiptID > 0 AND SaleDate >= " + StartDate + " AND SaleDate < " + EndDate + ServiceChargeQuery + " group by b.IncomeTypeID,c.DisplayName order by b.IncomeTypeID", objCnn)
                For i = 0 To OtherIncome.Rows.Count - 1
                    IncomeText += "<tr bgColor=""" + GrayBGColor + """>"
                    IncomeText += "<td colspan=""9"" align=""right"" class=""" + TextClass + """>" + OtherIncome.Rows(i)("IncomeName") + "</td>"
                    If DisplayVATType = "V" Then
                        IncomeText += "<td align=""right"" class=""smallText"">" + CDbl(OtherIncome.Rows(i)("Income") + OtherIncome.Rows(i)("IncomeVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td>"
                        grandTotalOtherIncome += OtherIncome.Rows(i)("Income") + OtherIncome.Rows(i)("IncomeVAT")
                    Else
                        IncomeText += "<td align=""right"" class=""smallText"">" + CDbl(OtherIncome.Rows(i)("Income")).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td>"
                        grandTotalOtherIncome += OtherIncome.Rows(i)("Income")
                    End If
                    IncomeText += "</tr>"
                Next
            End If

            Dim grandTotalSaleAvg As Double

            If DisplayVATType = "V" Then
                'outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                'outputString = outputString.Append("<td colspan=""9"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(93)(LangText) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalServiceCharge).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")
                'grandTotalAfterVAT = totalSale
                'grandTotalAfterVAT += grandTotalServiceCharge + grandTotalOtherIncome
                'grandTotalSaleAvg = grandTotalAfterVAT
                'If IncomeText <> "" Then
                '    outputString = outputString.Append(IncomeText)
                'End If
                'outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                'outputString = outputString.Append("<td colspan=""9"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(95)(LangText) + "</td>")
                'outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td></tr>")

            Else
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""9"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(93)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalServiceCharge - grandTotalServiceChargeVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>")

                If IncomeText <> "" Then
                    outputString = outputString.Append(IncomeText)
                End If

                Dim VATData As DataTable = objDB.List("select SUM(a.TransactionVAT) AS TotalVAT from  Summary_TranReport a WHERE TransactionStatusID=2 AND SaleDate >= " + StartDate + " AND SaleDate < " + EndDate + ServiceChargeQuery, objCnn)
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""9"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(94)(LangText) + "</td>")
                grandTotalAfterVAT = totalSale
                If Not IsDBNull(VATData.Rows(0)("TotalVAT")) Then
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(VATData.Rows(0)("TotalVAT")).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>")
                    grandTotalSaleAvg += grandTotalAfterVAT + grandTotalServiceCharge - grandTotalServiceChargeVAT + grandTotalOtherIncome
                    grandTotalAfterVAT += grandTotalServiceCharge - grandTotalServiceChargeVAT + grandTotalOtherIncome + VATData.Rows(0)("TotalVAT")
                Else
                    outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(0).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>")
                End If
                outputString = outputString.Append("<tr bgColor=""" + GrayBGColor + """>")
                outputString = outputString.Append("<td colspan=""9"" align=""right"" class=""" + TextClass + """>" + LangData2.Rows(95)(LangText) + "</td>")
                outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(grandTotalAfterVAT).ToString(FormatObject.CurrencyFormat, ci) + "</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>")

            End If

            outputString = outputString.Append("</table>")
            'End If

            Dim ChkShowComment As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramTypeID=1 AND PropertyID=91 AND KeyID=1", objCnn)
            If ChkShowComment.Rows.Count > 0 Then
                If ChkShowComment.Rows(0)("PropertyValue") = 1 Then
                    Dim CommentData As DataTable = objDB.List("select SUM(b.Amount) As TotalQty,ProductID,ProductCode,ProductName from ordertransaction a, ordercommentdetail b, Products p where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.CommentID=p.ProductID AND a.TransactionStatusID=2 AND a.ReceiptID>0 AND a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + " group by ProductID,ProductCode,ProductName", objCnn)
                    outputString = outputString.Append("<br><table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"">")
                    outputString = outputString.Append("<tr bgColor=""" + AdminBGColor + """>")
                    outputString = outputString.Append("<td align=""center"" class=""tdHeader"">" + "Comment Code" + "</td>")
                    outputString = outputString.Append("<td align=""center"" class=""tdHeader"">" + "Comment Name" + "</td>")
                    outputString = outputString.Append("<td align=""center"" class=""tdHeader"">" + "Qty" + "</td>")
                    outputString = outputString.Append("</tr>")
                    For i = 0 To CommentData.Rows.Count - 1
                        outputString = outputString.Append("<tr>")
                        outputString = outputString.Append("<td align=""left"" class=""smallText"">" + CommentData.Rows(i)("ProductCode") + "</td>")
                        outputString = outputString.Append("<td align=""left"" class=""smallText"">" + CommentData.Rows(i)("ProductName") + " </td>")
                        outputString = outputString.Append("<td align=""right"" class=""smallText"">" + CDbl(CommentData.Rows(i)("TotalQty")).ToString(FormatObject.QtyFormat, ci) + "</td>")
                        outputString = outputString.Append("</tr>")
                    Next
                    outputString = outputString.Append("</table>")
                End If
            End If

            Dim FinalSaleAmount As Double
            'If DisplayVATType = "V" Then
            DiscountArray(0) = grandTotalPriceDiscount + grandTotalDiscount
            DiscountArray(1) += grandTotalPriceDiscount
            If dtTable.Rows.Count > 0 Then
                Dim ResultSummary As String = Reports.SaleReportSummaryNew(PromotionData, grandTotalSaleAvg, grandTotalRetailPrice, FinalSaleAmount, GrayBGColor, AdminBGColor, ShopIDVal, ViewOption, StartDate, EndDate, grandTotalVAT, grandTotalAfterVAT, grandTotalVoid, PaymentResult, PayByCreditMoney, DiscountArray, True, False, LangID, LangPath, objCnn)
                outputString = outputString.Append(ResultSummary)
            End If

            'End If
        End If
        grandTotal = grandTotalAfterVAT
        ResultString = outputString.ToString()

    End Function

	
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
