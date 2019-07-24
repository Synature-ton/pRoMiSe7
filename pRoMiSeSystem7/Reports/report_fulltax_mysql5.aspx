<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@ Register tagPrefix="Web" Namespace="WebChart" Assembly="WebChart" %>
<%@ Import Namespace="System.Drawing" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="MySQL5DBClass.POSControl" %>
<%@Import Namespace="MySQL5DBClass.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="ReportModuleMySQL5" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Full Tax Invoice Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body<% = GlobalParam.BodyProp %>>
<div id="showPage" visible="true" runat="server">
<form runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White"> 
<div class="noprint">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><b class="headerText"><div class="headerText" align="left" id="HeaderText" runat="server" /></b></div>
	</td>
	<td width="1" nowrap rowspan="99" bgcolor="003366"><img src="../images/clear.gif" height="1" width="1"></td>
</tr>

<tr bgcolor="666666">
	<td width="3%" height="1"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	<td width="94%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="252"></p></td>
	<td width="3%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	
</tr>
<tr><td colspan="3" class="smalltext" align="right"><span id="DBText" class="smalltext" runat="server" /></td></tr>
</div>
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
			<td colspan="4"><table cellpadding="0" cellspacing="0"><tr><td><synature:date id="DailyDate" runat="server" /></td><td>&nbsp;&nbsp;</td><td><span id="ItemNameText" class="text" runat="server"></span>&nbsp;<asp:TextBox ID="ItemNameVal" runat="server"></asp:TextBox></td></tr></table></td>
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
<div id="showResults" runat="server">
<table width="100%">
<div class="noprint">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
</div>
<tr>
	<td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td>
</tr>
<tr>
	<td width="100%">
	<table width="100%">
		<tr>
			<td valign="top"><span id="CompanyInfoText1" runat="server"></span></td>
			<td align="right" valign="top"><span id="CompanyInfoText2" runat="server"></span></td>
		</tr>
	</table>
	</td>
</tr>
<tr><td>
	<asp:DataGrid ID="Results" AutoGenerateColumns="false" CellPadding="3" CssClass="text" HeaderStyle-BackColor="#507093" HeaderStyle-CssClass="tdHeader" HeaderStyle-HorizontalAlign="center" AllowPaging="false" OnPageIndexChanged="ChangeGridPage" Width="100%" OnItemDataBound="Results_ItemDataBound" runat="server">
		<columns>
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="#"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="Date"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="FullTaxInvoice"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="CustomerName"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="ItemName"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" ItemStyle-CssClass="smallText" DataField="PriceBeforeVAT"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" ItemStyle-CssClass="smallText" DataField="VAT"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" ItemStyle-CssClass="smallText" DataField="SubTotal"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="RefNo"></asp:BoundColumn> 
		</columns>
	</asp:DataGrid></td></tr>
</table>
</div>
</form>
</div>
<div id="errorMsg" runat="server" />
</td>
<td>&nbsp;</td>
</tr>
<div class="noprint">
<tr><td colspan="3" height="30">&nbsp;</td></tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
<tr>
	<td height="50" colspan="3" background="../images/footerbg2000.gif">&nbsp;</td>
</tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
</div>
</table>
<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getReport As New StReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_FullTax") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString

		showResults.Visible = False
		
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(13,Session("LangID"),objCnn)
		Dim textTable1 As New DataTable()
		textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)

		SubmitForm.Text = textTable.Rows(8)("TextParamValue")
		ItemNameText.InnerHtml = textTable.Rows(21)("TextParamValue")
		
		Dim GetReportLog As DataTable = getReport.ReportLog(objCnn)
        If GetReportLog.Rows.Count > 0 Then
            DBText.InnerHtml = "Report Database: " + Format(GetReportLog.Rows(0)("LogDateTime"), "dd MMMM yyyy HH:mm:ss") + "&nbsp;&nbsp;"
        Else
            DBText.InnerHtml = "Report Database&nbsp;&nbsp;"
        End If
		
		HeaderText.InnerHtml = "Full Tax Invoice Report"
			
		DailyDate.YearType = GlobalParam.YearType
		DailyDate.FormName = "DocDaily"
		DailyDate.StartYear = GlobalParam.StartYear
		DailyDate.EndYear = GlobalParam.EndYear
		DailyDate.LangID = Session("LangID")
		
		CurrentDate.YearType = GlobalParam.YearType
		CurrentDate.FormName = "Doc"
		CurrentDate.StartYear = GlobalParam.StartYear
		CurrentDate.EndYear = GlobalParam.EndYear
		CurrentDate.LangID = Session("LangID")
		
		ToDate.YearType = GlobalParam.YearType
		ToDate.FormName = "DocTo"
		ToDate.StartYear = GlobalParam.StartYear
		ToDate.EndYear = GlobalParam.EndYear
		ToDate.LangID = Session("LangID")
		
		MonthYearDate.YearType = GlobalParam.YearType
		MonthYearDate.FormName = "MonthYearDate"
		MonthYearDate.StartYear = GlobalParam.StartYear
		MonthYearDate.EndYear = GlobalParam.EndYear
		MonthYearDate.LangID = Session("LangID")
		MonthYearDate.ShowDay = False

		errorMsg.InnerHtml = ""
		
		If IsNumeric(Request.Form("DocDaily_Day")) Then 
			Session("DocDailyDay") = Request.Form("DocDaily_Day")
		Else If IsNumeric(Request.QueryString("DocDaily_Day")) Then 
			Session("DocDailyDay") = Request.QueryString("DocDaily_Day")
		Else If Trim(Session("DocDailyDay")) = "" Then
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
		End If
		If Page.IsPostBack AND Request.Form("DocDaily_Month") = "" Then Session("DocDaily_Month") = 0
		DailyDate.SelectedMonth = Session("DocDaily_Month")
		
		If IsNumeric(Request.Form("DocDaily_Year")) Then 
			Session("DocDaily_Year") = Request.Form("DocDaily_Year")
		Else If IsNumeric(Request.QueryString("DocDaily_Year")) Then 
			Session("DocDaily_Year") = Request.QueryString("DocDaily_Year")
		Else If Trim(Session("DocDaily_Year")) = "" Then
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
		End If
		If Page.IsPostBack AND Request.Form("Doc_Day") = "" Then Session("DocDay") = 0
		CurrentDate.SelectedDay = Session("DocDay")
		
		
		If IsNumeric(Request.Form("Doc_Month")) Then 
			Session("Doc_Month") = Request.Form("Doc_Month")
		Else If IsNumeric(Request.QueryString("Doc_Month")) Then 
			Session("Doc_Month") = Request.QueryString("Doc_Month")
		Else If Trim(Session("Doc_Month")) = "" Then
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
		End If
		If Page.IsPostBack AND Request.Form("Doc_Year") = "" Then Session("Doc_Year") = 0
		CurrentDate.SelectedYear = Session("Doc_Year")
		
		If IsNumeric(Request.Form("DocTo_Day")) Then 
			Session("DocTo_Day") = Request.Form("DocTo_Day")
		Else If IsNumeric(Request.QueryString("DocTo_Day")) Then 
			Session("DocTo_Day") = Request.QueryString("DocTo_Day")
		Else If Trim(Session("DocTo_Day")) = "" Then
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
		End If
		If Page.IsPostBack AND Request.Form("DocTo_Month") = "" Then Session("DocTo_Month") = 0
		ToDate.SelectedMonth = Session("DocTo_Month")
		
		If IsNumeric(Request.Form("DocTo_Year")) Then 
			Session("DocTo_Year") = Request.Form("DocTo_Year")
		Else If IsNumeric(Request.QueryString("DocTo_Year")) Then 
			Session("DocTo_Year") = Request.QueryString("DocTo_Year")
		Else If Trim(Session("DocTo_Year")) = "" Then
			Session("DocTo_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("DocTo_Year") = "" Then Session("DocTo_Year") = 0
		ToDate.SelectedYear = Session("DocTo_Year")
		
		If IsNumeric(Request.Form("MonthYearDate_Day")) Then 
			Session("MonthYearDate_Day") = Request.Form("MonthYearDate_Day")
		Else If IsNumeric(Request.QueryString("MonthYearDate_Day")) Then 
			Session("MonthYearDate_Day") = Request.QueryString("MonthYearDate_Day")
		Else If Trim(Session("DocDay")) = "" Then
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
		End If
		If Page.IsPostBack AND Request.Form("MonthYearDate_Month") = "" Then Session("MonthYearDate_Month") = 0
		MonthYearDate.SelectedMonth = Session("MonthYearDate_Month")
		
		If IsNumeric(Request.Form("MonthYearDate_Year")) Then 
			Session("MonthYearDate_Year") = Request.Form("MonthYearDate_Year")
		Else If IsNumeric(Request.QueryString("MonthYearDate_Year")) Then 
			Session("MonthYearDate_Year") = Request.QueryString("MonthYearDate_Year")
		Else If Trim(Session("MonthYearDate_Year")) = "" Then
			Session("MonthYearDate_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("MonthYearDate_Year") = "" Then Session("MonthYearDate_Year") = 0
		MonthYearDate.SelectedYear = Session("MonthYearDate_Year")
		
		If Not Page.IsPostBack Then
			Radio_3.Checked = True
			ItemNameVal.Text = textTable.Rows(26)("TextParamValue")
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
		Dim Multiple As Boolean = True
		
		Dim ShopData As DataTable = getInfo.GetProductLevel(-999,objCnn)
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
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(12,Session("LangID"),objCnn)
	Dim textTable1 As New DataTable()
	textTable1 = getPageText.GetText(13,Session("LangID"),objCnn)
	Dim textTable2 As New DataTable()
	textTable2 = getPageText.GetText(9,Session("LangID"),objCnn)
			
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""
	Dim DailyDateValue As String = ""
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
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
		StartDate = DateTimeUtil.FormatDate(1,StartMonthValue,StartYearValue)
		EndDate = DateTimeUtil.FormatDate(1,EndMonthValue,EndYearValue)
		Dim SDate As New Date(StartYearValue,StartMonthValue,1)
		ReportDate = Format(SDate,"MMMM yyyy")
		Catch ex As Exception
			FoundError = True
		End Try
	ElseIf Radio_2.Checked = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(Request.Form("Doc_Day"),Request.Form("Doc_Month"),Request.Form("Doc_Year"))
		Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))
		
		If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + defaultTextTable.Rows(45)("TextParamValue") + "</td></tr></table>"
			FoundError = True
			DateFromValue = ""
			DateToValue = ""
			DailyDateValue = ""
		Else
			ResultSearchText.InnerHtml = ""
			Dim SDate1 As New Date(Request.Form("Doc_Year"), Request.Form("Doc_Month"), Request.Form("Doc_Day"))
			Dim EDate1 As New Date(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"))
			ReportDate = Format(SDate1, "dd MMMM yyyy") + " - " + Format(EDate1, "dd MMMM yyyy")
		End If
		Catch ex As Exception
			FoundError = True
		End Try
	Else If Radio_3.Checked = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(Request.Form("DocDaily_Day"),Request.Form("DocDaily_Month"),Request.Form("DocDaily_Year"))
		Dim CheckDate As New DateTime(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"), 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))

		If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + defaultTextTable.Rows(45)("TextParamValue") + "</td></tr></table>"
			FoundError = True
			DateFromValue = ""
			DateToValue = ""
			DailyDateValue = ""
		Else
			ResultSearchText.InnerHtml = ""
			Dim SDate2 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
			ReportDate = Format(SDate2, "d MMMM yyyy")
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

		Dim displayTable As New DataTable()
		
		ShowResults.Visible = True
		ShowPrint.Visible = True

		'Application.Lock()
		Dim dtTable As DataTable = getReport.FullTaxReports(StartDate, EndDate, Request.Form("ShopID"), Session("LangID"), objCnn)					
		ResultSearchText.InnerHtml = textTable1.Rows(17)("TextParamValue")
		'Application.UnLock()
		Dim GlobalRCHeaderText,GlobalFTHeaderText,GlobalCMHeaderText, HText, RText As String
		Dim i As Integer
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

		Dim ReceiptHeaderData As DataTable
		ReceiptHeaderData = getInfo.GetDocType(1, 0, 8, 1, objCnn)
		If ReceiptHeaderData.Rows.Count > 0 Then
			If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
				GlobalRCHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
			End If
		End If
		ReceiptHeaderData = getInfo.GetDocType(1, 0, 11, 1, objCnn)
		If ReceiptHeaderData.Rows.Count > 0 Then
			If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
				GlobalFTHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
			End If
		End If
		ReceiptHeaderData = getInfo.GetDocType(1, 0, 33, 1, objCnn)
		If ReceiptHeaderData.Rows.Count > 0 Then
			If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
				GlobalCMHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
			End If
		End If
		
		Dim myDataTable As DataTable = new DataTable("FullTax")
		Dim myDataColumn As DataColumn 
		Dim myDataRow As DataRow
	
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "#"
		myDataColumn.ReadOnly = True
		myDataColumn.Unique = False
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "Date"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "FullTaxInvoice"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "RefNo"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "CustomerName"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "ItemName"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "PriceBeforeVAT"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "VAT"
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "SubTotal"
		myDataTable.Columns.Add(myDataColumn)
	
		Dim TextClass As String
		Dim TotalVAT As Double = 0
		Dim TotalFullTax As Double
		Dim ShopTotal As Double = 0
		Dim ShopVAT As Double = 0
		
		Dim DummyHeader As String
		Dim FullText As String
		Dim counter As Integer = 1
		Dim DummyShopID As Integer = -1
		For i = 0 To dtTable.Rows.Count - 1
			If Request.Form("ShopID") = 0 Then
				If dtTable.Rows(i)("ShopID") <> DummyShopID Then
					myDataRow = myDataTable.NewRow()
					myDataRow("Date") = dtTable.Rows(i)("ProductLevelName")
					myDataTable.Rows.Add(myDataRow)
					counter = 1
					ShopTotal = 0
					ShopVAT = 0
				End If
			End If
			HText = ""
			If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
				If Not IsDBNull(dtTable.Rows(i)("DocumentTypeHeader")) Then
					HText = dtTable.Rows(i)("DocumentTypeHeader")
				End If
			Else
				HText = GlobalFTHeaderText
			End If
			If IsDBNull(dtTable.Rows(i)("ReceiptID")) Or IsDBNull(dtTable.Rows(i)("ReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("ReceiptYear")) Then
				RText = "-"
			Else
				RText = FormatDocNumber.GetReceiptHeader(HText, dtTable.Rows(i)("ReceiptYear"), dtTable.Rows(i)("ReceiptMonth"), dtTable.Rows(i)("ReceiptID"))
				If dtTable.Rows(i)("TransactionStatusID") = 5 Or dtTable.Rows(i)("TransactionStatusID") = 8 Then
					RText += " " + "(Voided)"
				End If
			End If
			
			myDataRow = myDataTable.NewRow()
			myDataRow("#") = (counter).ToString
			myDataRow("FullTaxInvoice") = RText
			myDataRow("ItemName") = ItemNameVal.Text
			
			If dtTable.Rows(i)("RefDocType") = 8 Then
				DummyHeader = GlobalRCHeaderText
			Else
				DummyHeader = GlobalCMHeaderText
			End If
			HText = ""
			If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
				If Not IsDBNull(dtTable.Rows(i)("RefDocumentTypeHeader")) Then
					HText = dtTable.Rows(i)("RefDocumentTypeHeader")
				End If
			Else
				HText = DummyHeader
			End If
			If IsDBNull(dtTable.Rows(i)("RefReceiptID")) Or IsDBNull(dtTable.Rows(i)("RefReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("RefReceiptYear")) Then
				RText = "-"
			Else
				RText = FormatDocNumber.GetReceiptHeader(HText, dtTable.Rows(i)("RefReceiptYear"), dtTable.Rows(i)("RefReceiptMonth"), dtTable.Rows(i)("RefReceiptID"))
			End If
			
			If dtTable.Rows(i)("RefDocType") = 8 Then
				myDataRow("RefNo") = "<a href=""JavaScript: newWindow = window.open( 'BillFullTaxDetails.aspx?ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"" class=""smallText"">" & RText & "</a>"
			Else
				myDataRow("RefNo") = RText
			End If
			
			If Not IsDBNull(dtTable.Rows(i)("InvoiceName")) Then
				myDataRow("CustomerName") = dtTable.Rows(i)("InvoiceName")
			Else
				myDataRow("CustomerName") = "-"
			End If
			
			If Not IsDBNull(dtTable.Rows(i)("InvoiceDate")) Then
				myDataRow("Date") = DateTimeUtil.FormatDateTime(dtTable.Rows(i)("InvoiceDate"), "DateOnly")
			Else
				myDataRow("Date") = "-"
			End If
			
			myDataRow("PriceBeforeVAT") = Format(dtTable.Rows(i)("PaymentAmount")-dtTable.Rows(i)("PaymentVAT"), "##,##0.00")
			myDataRow("VAT") = Format(dtTable.Rows(i)("PaymentVAT"), "##,##0.00")
			myDataRow("SubTotal") = Format(dtTable.Rows(i)("PaymentAmount"), "##,##0.00")
			
			If dtTable.Rows(i)("TransactionStatusID") = 2 Then
				TotalFullTax += dtTable.Rows(i)("PaymentAmount")
				TotalVAT += dtTable.Rows(i)("PaymentVAT")
				
				ShopTotal += dtTable.Rows(i)("PaymentAmount")
				ShopVAT += dtTable.Rows(i)("PaymentVAT")
			End If
			
			myDataTable.Rows.Add(myDataRow)
			counter = counter + 1
			DummyShopID = dtTable.Rows(i)("ShopID")
			
			If Request.Form("ShopID") = 0 Then
				If i = dtTable.Rows.Count - 1 Then
					  myDataRow = myDataTable.NewRow()
					  myDataRow("ItemName") = "Sub Total"
					  myDataRow("PriceBeforeVAT") = Format(ShopTotal-ShopVAT, "##,##0.00")
					  myDataRow("VAT") = Format(ShopVAT, "##,##0.00")
					  myDataRow("SubTotal") = Format(ShopTotal, "##,##0.00")
					  myDataTable.Rows.Add(myDataRow)
				Else
				  If dtTable.Rows(i+1)("ShopID") <> DummyShopID Then
					  myDataRow = myDataTable.NewRow()
					  myDataRow("ItemName") = "Sub Total"
					  myDataRow("PriceBeforeVAT") = Format(ShopTotal-ShopVAT, "##,##0.00")
					  myDataRow("VAT") = Format(ShopVAT, "##,##0.00")
					  myDataRow("SubTotal") = Format(ShopTotal, "##,##0.00")
					  myDataTable.Rows.Add(myDataRow)
				  End If
				End If
			End If
		Next
		myDataRow = myDataTable.NewRow()
		myDataRow("ItemName") = "Grand Total"
		myDataRow("PriceBeforeVAT") = Format(TotalFullTax-TotalVAT, "##,##0.00")
		myDataRow("VAT") = Format(TotalVAT, "##,##0.00")
		myDataRow("SubTotal") = Format(TotalFullTax, "##,##0.00")
		myDataTable.Rows.Add(myDataRow)
		Results.DataSource = myDataTable
		Results.DataBind()
		
		Dim CompanyInfo As DataTable
		Dim FullTaxShopID As Integer = 1
		If Request.Form("ShopID") > 0 Then FullTaxShopID = Request.Form("ShopID")
		CompanyInfo = getInfo.GetCompanyInfo(FullTaxShopID, objCnn)
		
		Dim CompanyInfo1,CompanyInfo2 As String
		Dim Add2 As String = ""
		
		If CompanyInfo.Rows.Count > 0 Then
			CompanyInfo1 += "<table>"
			CompanyInfo1 += "<tr><td class=""text"">" + CompanyInfo.Rows(0)("CompanyName") + "</td></tr>"
			If Not IsDBNull(CompanyInfo.Rows(0)("CompanyAddress1")) Then
				CompanyInfo1 += "<tr><td class=""text"">" + CompanyInfo.Rows(0)("CompanyAddress1") + "</td></tr>"
			End If
			
			If Not IsDBNull(CompanyInfo.Rows(0)("CompanyAddress2")) Then
				Add2 += CompanyInfo.Rows(0)("CompanyAddress2")
			End If
			If Not IsDBNull(CompanyInfo.Rows(0)("CompanyCity")) Then
				If Add2 <> "" Then Add2 += " "
				Add2 += CompanyInfo.Rows(0)("CompanyCity")
			End If
			
			If Add2 <> "" Then
				CompanyInfo1 += "<tr><td class=""text"">" + Add2 + "</td></tr>"
			End If
			
			Dim Province As DataTable = objDB.List("select * from provinces where provinceid=" + CompanyInfo.Rows(0)("CompanyProvince").ToString + " and LangID=" + Session("LangID").ToString, objCnn)
			
			Add2 = ""
			If Province.Rows.Count > 0 Then
				Add2 += Province.Rows(0)("ProvinceName")
			End If
			If Not IsDBNull(CompanyInfo.Rows(0)("CompanyZipcode")) Then
				If Add2 <> "" Then Add2 += " "
				Add2 += CompanyInfo.Rows(0)("CompanyZipcode")
			End If
			If Add2 <> "" Then
				CompanyInfo1 += "<tr><td class=""text"">" + Add2 + "</td></tr>"
			End If

			CompanyInfo1 += "</table>"
			
			CompanyInfo2 = "<table>"
			CompanyInfo2 += "<tr><td class=""text"">" + ReportDate + "</td></tr>"
			If Not IsDBNull(CompanyInfo.Rows(0)("CompanyTaxID")) Then
				CompanyInfo2 += "<tr><td class=""text"">" + textTable2.Rows(10)("TextParamValue") + "</td></tr>"
				CompanyInfo2 += "<tr><td class=""text"">" + CompanyInfo.Rows(0)("CompanyTaxID") + "</td></tr>"
			End If
			CompanyInfo2 += "</table>"
			
		End If
		CompanyInfoText1.InnerHtml = CompanyInfo1
		CompanyInfoText2.InnerHtml = CompanyInfo2
	End If
	
End Sub

Sub ChangeGridPage(objSender As Object, objArgs As DataGridPageChangedEventArgs)
	
   Results.CurrentPageIndex = objArgs.NewPageIndex

	
End Sub
		
Private Sub Results_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) 
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(13,Session("LangID"),objCnn)
	If e.Item.ItemType = ListItemType.Header Then
		e.Item.Cells(0).Text = "#"
		e.Item.Cells(1).Text = textTable.Rows(18)("TextParamValue")
		e.Item.Cells(2).Text = textTable.Rows(19)("TextParamValue")
		e.Item.Cells(3).Text = textTable.Rows(20)("TextParamValue")
		e.Item.Cells(4).Text = textTable.Rows(21)("TextParamValue")
		e.Item.Cells(5).Text = textTable.Rows(22)("TextParamValue")
		e.Item.Cells(6).Text = textTable.Rows(23)("TextParamValue")
		e.Item.Cells(7).Text = textTable.Rows(24)("TextParamValue")
		e.Item.Cells(8).Text = textTable.Rows(25)("TextParamValue")
	End If
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

		
</script>
</body>
</html>
