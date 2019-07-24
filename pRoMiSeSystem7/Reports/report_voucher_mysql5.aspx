<%@ Page Language="VB" ContentType="text/html" debug="True" %>
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
<title>Voucher/Coupon Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body<% = GlobalParam.BodyProp %>>
<div id="showPage" visible="true" runat="server">
<form runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
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
<tr>
<td>&nbsp;</td>
<td>
<div class="noprint">
<table>
<tr id="ShowShop" runat="server">
	<td colspan="2"><span id="SelectShop" class="text" runat="server"></span></td>
	<td><span id="ShopText" runat="server"></span></td>
	<td colspan="2"><span class="text">Coupon/Voucher</span></td>
	<td colspan="4" class="text"><asp:textbox ID="VoucherHeader" MaxLength="10" Width="70" runat="server" /> / <asp:textbox ID="VoucherNumber" Width="120" runat="server" /> You can use "," as number list</td>
</tr>
<tr>
	<td align="right" valign="middle"><div id="DocumentDateParam" class="text" runat="server"></div></td>
	<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
	<td><synature:date id="MonthYearDate" runat="server" /></td>
	<td>&nbsp;</td>
	<td align="right"><asp:radiobutton ID="Radio_2" GroupName="Group1" runat="server" /></td>
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
</div>
<br>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
<tr><td align="center">
<div id="ResultSearchText" runat="server"></div></td></tr>
<tr><td>
	<asp:DataGrid ID="Results" AutoGenerateColumns="false" CellPadding="3" CssClass="text" HeaderStyle-BackColor="#507093" HeaderStyle-CssClass="smallTdHeader" HeaderStyle-HorizontalAlign="center" AllowPaging="true" OnPageIndexChanged="ChangeGridPage" OnItemDataBound="Results_ItemDataBound" runat="server">
		<columns>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="Shop"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="Date"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="Receipt"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="CV"></asp:BoundColumn> 
		</columns>
	</asp:DataGrid></td></tr>
</table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
	
	<div id="ResultText" runat="server"></div>
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
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getReport As New stReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim RecordPerPage As Integer = 100
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_Voucher") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
		Dim GetReportLog As DataTable = getReport.ReportLog(objCnn)
		If GetReportLog.Rows.Count > 0 Then
			DBText.InnerHtml = "Report Database: " + Format(GetReportLog.Rows(0)("LogDateTime"), "dd MMMM yyyy HH:mm:ss") + "&nbsp;&nbsp;"
		Else
			DBText.InnerHtml = "Report Database&nbsp;&nbsp;"
		End If

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
		
		ResultText.InnerHtml = ""
		ResultSearchText.InnerHtml = ""
		errorMsg.InnerHtml = ""
		
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
			Radio_2.Checked = True
		End If

		Dim ShopIDValue As String = "0"
		If IsNumeric(Request.Form("ShopID")) Then
			ShopIDValue = Request.Form("ShopID").ToString
		Else If IsNumeric(Request.QueryString("ShopID"))
			ShopIDValue = Request.QueryString("ShopID").ToString
		End If
			
			
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(13,Session("LangID"),objCnn)
			Dim textTable1 As New DataTable()
			textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			DocumentDateParam.InnerHtml = textTable.Rows(5)("TextParamValue")
			SubmitForm.Text = textTable.Rows(8)("TextParamValue")

			SelectShop.InnerHtml = "Select Shop"
			DocumentToDateParam.InnerHtml = defaultTextTable.Rows(91)("TextParamValue")
			
			HeaderText.InnerHtml = "Voucher/Coupon Report"

			
			Dim i As Integer
			Dim outputString,FormSelected,compareString As String
			Dim SelectString As String 
			
			Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
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
			
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""
	Try
	If Radio_2.Checked = True Then
		DateFromValue = DateTimeUtil.FormatDate(Request.Form("Doc_Day"),Request.Form("Doc_Month"),Request.Form("Doc_Year"))
		
		DateToValue = DateTimeUtil.FormatDate(Request.Form("DocTo_Day"),Request.Form("DocTo_Month"),Request.Form("DocTo_Year"))
		
		If Trim(DateFromValue) = "InvalidDate" Or Trim(DateToValue) = "InvalidDate" Then
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + defaultTextTable.Rows(45)("TextParamValue") + "</td></tr></table>"
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
	If Radio_1.Checked = True Then
		If Not (IsNumeric(Request.Form("MonthYearDate_Month")) AND IsNumeric(Request.Form("MonthYearDate_Year"))) Then
			FoundError = True
		End If
	End If
	Catch ex As Exception
			FoundError = True
		End Try

	
	If FoundError = False Then
		ShowPrint.Visible = True
		Dim displayTable As New DataTable()
		
		Dim i As Integer
		Dim DateCheck As Boolean

		Dim outputString As String = ""
		Dim counter,MaxNum As Integer
		Dim ShowSaleDate As String = ""
		Dim bgColor As String = "e9e9e9"
		Dim DummySaleDate As Date
		Dim TypeHeader,TypeString,CouponNumber As String
		Dim SelMonth As Integer = 0
		Dim SelYear As Integer = 0
		
		If IsNumeric(Request.Form("MonthYearDate_Month")) Then SelMonth = Request.Form("MonthYearDate_Month")
		If IsNumeric(Request.Form("MonthYearDate_Year")) Then SelYear = Request.Form("MonthYearDate_Year")
		'Application.Lock()
		GenResult(Session("LangID"), Radio_1.Checked, Radio_2.Checked, SelMonth, SelYear, DateFromValue, DateToValue, Request.Form("ShopID"),trim(VoucherHeader.Text),trim(VoucherNumber.Text), objCnn)
		'Application.UnLock()
		
	End If
End Sub

Public Function GenResult(ByVal LangID As Integer, ByVal Radio1 As Boolean, ByVal Radio2 As Boolean, ByVal selMonth As Integer, ByVal selYear As Integer, ByVal DateFrom As String, ByVal DateTo As String, ByVal ShopID As Integer, ByVal VoucherHeader As String, ByVal VoucherNumber As String, ByVal objCnn As MySqlConnection) As DataTable
	Dim dtTable As DataTable = getReport.VoucherReports(LangID, Radio1, Radio2, SelMonth, SelYear, DateFrom, DateTo, ShopID,VoucherHeader,VoucherNumber, objCnn)
		Dim outputString As String = ""
		Dim DummyTypeID As Integer = -1
		Dim i As Integer
		Dim counter,MaxNum As Integer
		Dim ShowSaleDate As String = ""
		Dim bgColor As String = "e9e9e9"
		Dim DummySaleDate As Date
		Dim TypeHeader,TypeString,CouponNumber As String
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		Dim AdditionalHeaderText,HText,RText As String
		Dim ReceiptHeaderData As Datatable
		ReceiptHeaderData = getInfo.GetDocType(1,0,8,Session("LangID"),objCnn)

		If ReceiptHeaderData.Rows.Count > 0 Then
			If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
				AdditionalHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
			End If
		End If
		
		Dim dTable As DataTable = New DataTable("Results")
		Dim rNew As DataRow
		
		dTable.Columns.Add("Shop", System.Type.GetType("System.String"))
		dTable.Columns.Add("Date", System.Type.GetType("System.String"))
		dTable.Columns.Add("Receipt", System.Type.GetType("System.String"))
		dTable.Columns.Add("CV", System.Type.GetType("System.String"))

		For i=0 To dtTable.Rows.Count - 1
			
			If dtTable.Rows(i)("VTypeID") <> DummyTypeID Then
				rNew = dTable.NewRow
				If dtTable.Rows(i)("VTypeID") = 4 Then
					TypeHeader = "Coupons"
					TypeString = "Coupon #"
				Else If dtTable.Rows(i)("VTypeID") = 5 Then
					TypeHeader = "Vouchers"
					TypeString = "Voucher #"
				Else 
					TypeHeader = "Cash Coupon"
					TypeString = "Cash Coupon #"
				End If
				rNew("Shop") = TypeHeader
				dTable.Rows.Add(rNew)
				'outputString += "<tr><td colspan=""4"" align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + TypeHeader + "</td></tr>"
				'outputString += "<tr>" + "<td class=""tdHeader"" align=""center"" bgColor=""" + GlobalParam.AdminBGColor + """>Shop</td>" + "<td class=""tdHeader"" align=""center"" bgColor=""" + GlobalParam.AdminBGColor + """>Date</td>" + "<td class=""tdHeader"" align=""center"" bgColor=""" + GlobalParam.AdminBGColor + """>Receipt #</td>" + "<td class=""tdHeader"" align=""center"" bgColor=""" + GlobalParam.AdminBGColor + """>" + TypeString + "</td></tr>"
			End If
			HText  = ""
			If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
				If Not IsDBNull(dtTable.Rows(i)("DocumentTypeHeader")) Then
					HText = dtTable.Rows(i)("DocumentTypeHeader")
				End If
			Else
				HText = AdditionalHeaderText
			End If
			If IsDBNull(dtTable.Rows(i)("ReceiptID")) Or IsDBNull(dtTable.Rows(i)("ReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("ReceiptYear")) Then
				RText = "-"
			Else
				RText = FormatDocNumber.getReceiptHeader(HText,dtTable.Rows(i)("ReceiptYear"),dtTable.Rows(i)("ReceiptMonth"),dtTable.Rows(i)("ReceiptID"))
			End If
			ShowSaleDate = DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly")
			
			If dtTable.Rows(i)("VTypeID") = 4 Then
				maxNum = dtTable.Rows(i)("VoucherID") + 1000000
				CouponNumber = dtTable.Rows(i)("VoucherHeader") + "/" + Right(maxNum.ToString, 6)
			Else If dtTable.Rows(i)("VTypeID") = 5 Then
				maxNum = dtTable.Rows(i)("VoucherID") + 1000000
				CouponNumber = dtTable.Rows(i)("VoucherHeader") + "/" + Right(maxNum.ToString, 6)
			ElseIf Not IsDBNull(dtTable.Rows(i)("CashCouponNumber")) 
				CouponNumber = dtTable.Rows(i)("CashCouponNumber")
			Else
				CouponNumber = "N/A"
			End If
			rNew = dTable.NewRow
			rNew("Shop") = dtTable.Rows(i)("ShopName")
			rNew("Date") = ShowSaleDate
			If RText <> "-" Then
				rNew("Receipt") = "<a href=""JavaScript: newWindow = window.open( '../Reports/BillDetails.aspx?ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & RText & "</a>"
			Else
				rNew("Receipt") = RText
			End If
			rNew("CV") = CouponNumber
			dTable.Rows.Add(rNew)
			counter = counter + 1
			DummyTypeID = dtTable.Rows(i)("VTypeID")

		Next
		If dtTable.Rows.Count = 0 Then
			outputString = "<tr><td class=""boldText"" colspan=""4"">No Data Found</td></tr>"
		Else
			Try
				Results.PageSize = RecordPerPage
				Results.PagerStyle.Mode = PagerMode.NumericPages
				Results.DataSource = dTable
				Results.DataBind()
			Catch ex As Exception
				Results.CurrentPageIndex = 0
				Results.PageSize = RecordPerPage
				Results.PagerStyle.Mode = PagerMode.NumericPages
				Results.DataSource = dTable
				Results.DataBind()
			End Try
		End If

End Function

Sub ChangeGridPage(objSender As Object, objArgs As DataGridPageChangedEventArgs)

	Dim SelMonth As Integer = 0
	Dim SelYear As Integer = 0
		
	If IsNumeric(Request.Form("MonthYearDate_Month")) Then SelMonth = Request.Form("MonthYearDate_Month")
	If IsNumeric(Request.Form("MonthYearDate_Year")) Then SelYear = Request.Form("MonthYearDate_Year")
	
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""

	If Radio_2.Checked = True Then
		DateFromValue = DateTimeUtil.FormatDate(Request.Form("Doc_Day"),Request.Form("Doc_Month"),Request.Form("Doc_Year"))
		
		DateToValue = DateTimeUtil.FormatDate(Request.Form("DocTo_Day"),Request.Form("DocTo_Month"),Request.Form("DocTo_Year"))

	Else
		DateFromValue = ""
		DateToValue = ""
	End If
   'update the current page number from the parameter values
   Results.CurrentPageIndex = objArgs.NewPageIndex
	GenResult(Session("LangID"), Radio_1.Checked, Radio_2.Checked, SelMonth, SelYear, DateFromValue, DateToValue, Request.Form("ShopID"),trim(VoucherHeader.Text),trim(VoucherNumber.Text), objCnn)
	
End Sub

Private Sub Results_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) 
	If e.Item.ItemType = ListItemType.Header Then
		e.Item.Cells(0).Text = "Shop"
		e.Item.Cells(1).Text = "Date"
		e.Item.Cells(2).Text = "Receipt"
		e.Item.Cells(3).Text = "Voucher/Coupon"
	End If
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
