<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="MonthlySummaryReport" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Report Credit Money</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<div id="showContent" visible="True" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="SelectedItemList" runat="server">
<input type="hidden" id="OrderParam" runat="server">

<div id="showLevelID" runat="server"></div>


<div id="myTable" runat="server">
<table width="100%">
<tr>
<td align="left"><div class="headerText" align="left" id="HeaderText" runat="server" /></td>
<td align="right"><div class="noprint"><div class="text"><a href="javascript: window.print()">Print</a> | <a href="javascript: window.close()">Close</a></div></div></td>
</tr>
</table>
<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td id="headerTD100" align="center" class="tdHeader" runat="server"><div id="ZoneText" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="NameText" runat="server"></div><asp:LinkButton ID="NameAsc" Text="Asc" CssClass="tableHeader" OnClick="DoSearch" Enabled="false" runat="server" />&nbsp;&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="NameDesc" Text="Desc" CssClass="tableHeader" OnClick="DoSearch" Enabled="false" runat="server" /></td>
		<td id="headerTD11" align="center" class="tdHeader" runat="server"><div id="CMReceiptText" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="ReceiptText" runat="server"></div><asp:LinkButton ID="OrderAsc" Text="Asc" CssClass="tableHeader" OnClick="DoSearch" Enabled="false" runat="server" />&nbsp;&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="OrderDesc" Text="Desc" CssClass="tableHeader" OnClick="DoSearch" Enabled="false" runat="server" /></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="AmountText" runat="server"></div></td>
		<td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="AmountPaidText" runat="server"></div></td>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="AmountCurrentPaidText" runat="server"></div></td>
		<td id="headerTD8" align="center" class="tdHeader" runat="server"><div id="AmountRestText" runat="server"></div></td>
		
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="DateText" runat="server"></div><asp:LinkButton ID="DateAsc" Text="Asc" CssClass="tableHeader" OnClick="DoSearch" Enabled="false" runat="server" />&nbsp;&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="DateDesc" Text="Desc" CssClass="tableHeader" OnClick="DoSearch" Enabled="false" runat="server" /></td>
		<td id="headerTD12" align="center" class="tdHeader" runat="server"><div id="StaffText" runat="server"></div></td>
		<td id="headerTD13" align="center" class="tdHeader" runat="server"><div id="VoidStaffText" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="StatusText" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>
	
</table>
</div>

</form>
</div>
<div id="errorMsg" runat="server" />

<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getInfo As New CMembers()
Dim getPageText As New DefaultText()
Dim FormatDocNumber As New FormatText()
Dim DateTimeUtil As New MyDateTime()
Dim getInfo1 As New CCategory()
Dim getReport As New stReports()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated Then
		
	  	headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor
		headerTD6.BgColor = GlobalParam.AdminBGColor
		headerTD7.BgColor = GlobalParam.AdminBGColor
		headerTD8.BgColor = GlobalParam.AdminBGColor
		headerTD11.BgColor = GlobalParam.AdminBGColor
		headerTD12.BgColor = GlobalParam.AdminBGColor
		headerTD13.BgColor = GlobalParam.AdminBGColor
		headerTD100.BgColor = GlobalParam.AdminBGColor
		
		headerTD6.Visible = False
		
		ResultText.InnerHtml = ""
		myTable.Visible = True
		errorMsg.InnerHtml = ""
		If Request.QueryString("PayTypeID") >= -2 Then
			headerTD5.Visible = False
			headerTD7.Visible = False
			headerTD8.Visible = False
		End If
		
		ZoneText.InnerHtml = "Zone Name"
		Dim IDValue As Integer = 0
		If IsNumeric(Request.Form("ShopID")) Then
			IDValue = Request.Form("ShopID")
		Else If IsNumeric(Request.QueryString("ShopID"))
			IDValue = Request.QueryString("ShopID")
		End If
		
		'Try
			objCnn = getCnn.EstablishConnection()
			
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(11,Session("LangID"),objCnn)
			
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			
			AmountText.InnerHtml = "Toal Credit Money"'textTable.Rows(42)("TextParamValue")
			AmountPaidText.InnerHtml = "Paid"
			If Request.QueryString("ViewOption") = 0 Then
				AmountCurrentPaidText.InnerHtml = "This Period Paid"
				ReceiptText.InnerHtml = "Reference Receipt #"
				DateText.InnerHtml = "Paid Date"
				StaffText.InnerHtml = "Staff Name"
				VoidStaffText.InnerHtml = "Void Staff Name"
				CMReceiptText.InnerHtml = "Receipt #"
			Else
				Select Request.QueryString("PayTypeID")
				Case 5
					AmountCurrentPaidText.InnerHtml = "Credit Amount"
				Case 3
					AmountCurrentPaidText.InnerHtml = "Smart Card Payment"
				Case 9
					AmountCurrentPaidText.InnerHtml = "Prepaid Payment"
				End Select
				ReceiptText.InnerHtml = "Receipt #"
				DateText.InnerHtml = "Date"
				headerTD11.Visible = False
				headerTD12.Visible = False
				headerTD13.Visible = False
			End If
			AmountRestText.InnerHtml = "Balance"
			StatusText.InnerHtml = textTable.Rows(13)("TextParamValue")
			
			
			NameText.InnerHtml = "Customer Name"'textTable.Rows(40)("TextParamValue")
			GetCreditMoneyReport(Request.QueryString("ViewOption"),Request.QueryString("StartDate"),Request.QueryString("EndDate"),Request.QueryString("ShopID"),Request.QueryString("PayTypeID"),Session("LangID"),Request.QueryString("ZoneID"),objCnn)
			
		'Catch ex As Exception
			'errorMsg.InnerHtml = ex.Message
		'End Try
	  
	Else
		showContent.Visible = False
		errorMsg.InnerHtml = "Access Denied"
	End If
End Sub

Public Function GetCreditMoneyReport(ByVal ViewOption As Integer, ByVal DateFrom As String, ByVal DateTo As String, ByVal ShopID As Integer, ByVal PayTypeID As Integer, ByVal LangID As Integer, ByVal ZoneID As String, ByVal objCnn As MySqlConnection) As DataTable
	Dim FoundError As Boolean
	FoundError = False
	Session("ReportResult") = ""
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(11,Session("LangID"),objCnn)
			
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
	Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)

	NameAsc.Enabled = True
	NameDesc.Enabled = True
	OrderAsc.Enabled = True
	OrderDesc.Enabled = True
	DateAsc.Enabled = True
	DateDesc.Enabled = True
	
	Dim counter As Integer = 0
		
	If FoundError = False Then
		Dim OrderByParam As String = ""
		If Request.Form("__EVENTTARGET") = "NameAsc" Then
			OrderByParam = "PaidByName Asc"
			NameAsc.Enabled = False
		Else If Request.Form("__EVENTTARGET") = "NameDesc" Then
			OrderByParam = "PaidByName Desc"
			NameDesc.Enabled = False
		Else If Request.Form("__EVENTTARGET") = "OrderAsc" Then
			OrderByParam = "ReceiptYear,ReceiptMonth,ReceiptID"
			OrderAsc.Enabled = False
		Else If Request.Form("__EVENTTARGET") = "OrderDesc" Then
			OrderByParam = "ReceiptYear Desc,ReceiptMonth Desc, ReceiptID Desc"
			OrderDesc.Enabled = False
		Else If Request.Form("__EVENTTARGET") = "DateAsc" Then
			OrderByParam = "SaleDate"
			DateAsc.Enabled = False
		Else If Request.Form("__EVENTTARGET") = "DateDesc" Then
			OrderByParam = "SaleDate Desc"
			DateDesc.Enabled = False
		Else If Request.Form("OrderParam") = "PaidByName Asc" Then
			OrderByParam = "PaidByName Asc"
			NameAsc.Enabled = False
		Else If Request.Form("OrderParam") = "PaidByName Desc" Then
			OrderByParam = "PaidByName Desc"
			NameDesc.Enabled = False
		Else If Request.Form("OrderParam") = "ReceiptYear,ReceiptMonth,ReceiptID" Then
			OrderByParam = "ReceiptYear,ReceiptMonth,ReceiptID"
			OrderAsc.Enabled = False
		Else If Request.Form("OrderParam") = "ReceiptYear Desc,ReceiptMonth Desc, ReceiptID Desc" Then
			OrderByParam = "ReceiptYear Desc,ReceiptMonth Desc, ReceiptID Desc"
			OrderDesc.Enabled = False
		Else If Request.Form("OrderParam") = "InSertDate Asc" Then
			OrderByParam = "InSertDate Asc"
			DateAsc.Enabled = False
		Else If Request.Form("OrderParam") = "InSertDate Desc" Then
			OrderByParam = "InSertDate Desc"
			DateDesc.Enabled = False
		Else
			OrderByParam = "InSertDate"
			DateAsc.Enabled = False
		End If
		OrderParam.Value = OrderByParam
		
		Dim displayTable As New DataTable

		displayTable = getReport.CreditMoneyReport(ViewOption,DateFrom,DateTo,ShopID,PayTypeID,LangID,OrderByParam,ZoneID,objCnn)
		
		Dim FormatDateString As String = "DateOnly"

		Dim i,MemberIDParam As Integer
		Dim outputString As String = ""
		Dim checked As String = ""
		Dim compareString,PaidByNameString,ReceiptHeader,StatusDisplay,CMReceiptHeader,GlobalFTHeaderText As String
		Dim StringToCompare As String = "," + SelectedItemList.Value + ","
		Dim ReceiptHeaderData As Datatable
		Dim CMReceiptHeaderData As Datatable
		Dim FReceiptHeaderData As Datatable
		Dim AmountBalance,AmountPaid,AmountPaidThisPeriod As Double
		Dim InputParam As String
		Dim grandTotalCreditMoney As Double = 0
		Dim grandTotalPaid As Double = 0
		Dim grandTotalThisPeriod As Double = 0
		Dim grandTotalRest As Double = 0
		ReceiptHeaderData = getInfo1.GetDocType(1,8,Session("LangID"),objCnn)
		
		Dim AdditionalHeaderText As String = ""
		Dim CMHeaderText As String = ""
		
		If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
			AdditionalHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
		End If
		CMReceiptHeaderData = getInfo1.GetDocType(1,33,Session("LangID"),objCnn)
		
		If Not IsDBNull(CMReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
			CMHeaderText = CMReceiptHeaderData.Rows(0)("DocumentTypeHeader")
		End If
		
		FReceiptHeaderData = getInfo1.GetDocType(1, 0, 11, 1, objCnn)
		If FReceiptHeaderData.Rows.Count > 0 Then
			If Not IsDBNull(FReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
				GlobalFTHeaderText = FReceiptHeaderData.Rows(0)("DocumentTypeHeader")
			End If
		End If
		
		Dim HText As String
		Dim CMText As String
		
		For i=0 To displayTable.Rows.Count - 1
			If IsNumeric(displayTable.Rows(i)("TotalPay")) Then
				AmountPaid = displayTable.Rows(i)("TotalPay") - displayTable.Rows(i)("ThisPeriodPaid")
				If Request.QueryString("ViewOption") = 0 Then
					If displayTable.Rows(i)("CreditMoneyStatusID") = 2 Then
						grandTotalPaid += displayTable.Rows(i)("TotalPay") - displayTable.Rows(i)("ThisPeriodPaid")
					End If
				Else
					grandTotalPaid += displayTable.Rows(i)("TotalPay") - displayTable.Rows(i)("ThisPeriodPaid")
				End If
			Else
				AmountPaid = 0
			End If
			If IsNumeric(displayTable.Rows(i)("ThisPeriodPaid")) Then
				AmountPaidThisPeriod = displayTable.Rows(i)("ThisPeriodPaid")
				grandTotalThisPeriod += displayTable.Rows(i)("ThisPeriodPaid")
			Else
				AmountPaidThisPeriod = 0
			End If
			AmountBalance = displayTable.Rows(i)("TotalCreditMoney") - AmountPaid - AmountPaidThisPeriod
			grandTotalRest += AmountBalance
			grandTotalCreditMoney += displayTable.Rows(i)("TotalCreditMoney")

			If Not IsDBNull(displayTable.Rows(i)("MemberFirstName")) AND Not IsDBNull(displayTable.Rows(i)("MemberLastName")) Then
				If Trim(displayTable.Rows(i)("MemberFirstName")) <> "" Then
					PaidByNameString = displayTable.Rows(i)("MemberFirstName") + " " + displayTable.Rows(i)("MemberLastName")
				Else
					PaidByNameString = "N/A"
				End If
			ElseIf Not IsDBNull(displayTable.Rows(i)("PaidByName")) Then
				If Trim(displayTable.Rows(i)("PaidByName")) <> "" Then
					PaidByNameString = displayTable.Rows(i)("PaidByName")
				Else
					PaidByNameString = "N/A"
				End If
			Else
				PaidByNameString = "N/A"
			End If
			outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("ZoneName") & "</td>"
			outputString += "<td align=""left"" class=""text"">" & PaidByNameString & "</td>"
			
			If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
				If Not IsDBNull(displayTable.Rows(i)("DocumentTypeHeader")) Then
					HText = displayTable.Rows(i)("DocumentTypeHeader")
				End If
			Else
				HText = AdditionalHeaderText
			End If
			
			If headerTD11.Visible = True Then
				If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
					If Not IsDBNull(displayTable.Rows(i)("CMDocumentTypeHeader")) Then
						CMText = displayTable.Rows(i)("CMDocumentTypeHeader")
					End If
				Else
					CMText = CMHeaderText
				End If
			End If
			
			If headerTD11.Visible = True Then
				CMReceiptHeader = FormatDocNumber.getReceiptHeader(CMText,displayTable.Rows(i)("CMReceiptYear"),displayTable.Rows(i)("CMReceiptMonth"),displayTable.Rows(i)("CMReceiptID"))
				outputString += "<td align=""left"" class=""text"">" & CMReceiptHeader & "</td>"
			End If
			If Not IsDBNull(HText) Then
				ReceiptHeader = FormatDocNumber.getReceiptHeader(HText,displayTable.Rows(i)("ReceiptYear"),displayTable.Rows(i)("ReceiptMonth"),displayTable.Rows(i)("ReceiptID"))
			Else
				ReceiptHeader = FormatDocNumber.getReceiptHeader("",displayTable.Rows(i)("ReceiptYear"),displayTable.Rows(i)("ReceiptMonth"),displayTable.Rows(i)("ReceiptID"))
			End If
			outputString += "<td align=""left"" class=""text""><a href=""JavaScript: newWindow = window.open( '../Reports/BillDetails.aspx?ComputerID=" + displayTable.Rows(i)("ComputerID").ToString + "&TransactionID=" + displayTable.Rows(i)("TransactionID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & ReceiptHeader & "</a></td>"
			If headerTD5.Visible = True Then
				outputString += "<td align=""right"" class=""text"">" & Format(displayTable.Rows(i)("TotalCreditMoney"),"##,##0.00") & "</td>"
			End If
			If headerTD7.Visible = True Then
				outputString += "<td align=""right"" class=""text"">" & Format(AmountPaid,"##,##0.00") & "</td>"
			End If
			outputString += "<td align=""right"" class=""text"">" & Format(AmountPaidThisPeriod,"##,##0.00") & "</td>"
			If headerTD8.Visible = True Then
				outputString += "<td align=""right"" class=""text"">" & Format(AmountBalance,"##,##0.00") & "</td>"
			End If
			
			If Request.QueryString("ViewOption") = 0 Then
				outputString += "<td align=""right"" class=""text"">" & DateTimeUtil.FormatDateTime(displayTable.Rows(i)("InsertDate"),FormatDateString) & "</td>"
			Else
				outputString += "<td align=""right"" class=""text"">" & DateTimeUtil.FormatDateTime(displayTable.Rows(i)("SaleDate"),FormatDateString) & "</td>"
			End If
			
			If headerTD12.Visible = True 
				If Not IsDBNull(displayTable.Rows(i)("PaidStaffName")) Then
					outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("PaidStaffName") & "</td>"
				Else
					outputString += "<td align=""left"" class=""text"">" & "-" & "</td>"
				End If
			End If
			If headerTD13.Visible = True 
				If Not IsDBNull(displayTable.Rows(i)("VoidStaffName")) Then
					outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("VoidStaffName") & "</td>"
				Else
					outputString += "<td align=""left"" class=""text"">" & "-" & "</td>"
				End If
			End If
			
			
			outputString += "</tr>"
		Next
		If Request.QueryString("ViewOption") = 0 Then
			outputString += "<tr bgcolor=""" + GlobalParam.GrayBGColor + """><td colspan=""3"" class=""text"" align=""right"">Total This Period Paid</td><td align=""right"" class=""text"">" + Format(grandTotalThisPeriod,"##,##0.00") + "</td><td colspan=""3"">&nbsp;</td></tr>"
			
		Else
			outputString += "<tr bgcolor=""" + GlobalParam.GrayBGColor + """><td colspan=""3"" class=""text"" align=""right"">Total Amount</td><td align=""right"" class=""text"">" + Format(grandTotalThisPeriod,"##,##0.00") + "</td><td></td></tr>"
		End If
		ResultText.InnerHtml = outputString

	End If
	'errorMsg.InnerHtml = Val(DocumentNumber.Text).ToString + "<br>" + displayTable1
End Function

Sub DoSearch(Source As Object, E As EventArgs)
	GetCreditMoneyReport(Request.QueryString("ViewOption"),Request.QueryString("StartDate"),Request.QueryString("EndDate"),Request.QueryString("ShopID"),Request.QueryString("PayTypeID"),Session("LangID"),Request.QueryString("ZoneID"),objCnn)
End Sub
		

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
