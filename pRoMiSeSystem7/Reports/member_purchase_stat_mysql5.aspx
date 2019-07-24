<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="ReportModuleMySQL5" %>
<html>
<head>
<title>Member Purchase Stat</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body<% = GlobalParam.BodyProp1 %>>
<form runat="server">
<ASP:Label id="updateMessage" CssClass="text" runat="server" />

<table cellpadding="2" cellspacing="2" width="100%">
<tr>
<td align="left"><div class="headerText" align="left" id="HeaderText" runat="server" /></td>
<td align="right"><div class="noprint"><div class="text"><a href="javascript: window.print()">Print</a> | <a href="javascript: window.close()">Close</a></div></div></td>
</tr>
<tr><td height="5" colspan="2"></td></tr>
<tr><td><div id="CostText" class="text" runat="server"></div></td>
<td align="right"><div class="text" id="GoBackText" runat="server"></div></td></tr>
<tr><td height="5" colspan="2"></td></tr>
</table>

<table>
	<tr>
		<td><asp:RadioButton ID="Radio_1" GroupName="Group1" AutoPostBack="true" OnCheckedChanged="DisplayData" CssClass="text" runat="server" /></td>
		<td><asp:RadioButton ID="Radio_2" GroupName="Group1" AutoPostBack="true" Visible="false" OnCheckedChanged="DisplayData" CssClass="text" runat="server" /></td>
	</tr>
</table>
<div id="ShowResultByDate" runat="server">
	<asp:DataGrid ID="ResultByDate" AutoGenerateColumns="false" CellPadding="3" CssClass="text" HeaderStyle-BackColor="#507093" HeaderStyle-CssClass="tdHeader" HeaderStyle-HorizontalAlign="center" AllowPaging="true" OnPageIndexChanged="ChangeGridPage1" Width="100%" OnItemDataBound="ResultDate_ItemDataBound" PagerStyle-Mode="NumericPages" PageSize="20" runat="server">
		<columns>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" DataField="Date"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" DataField="Time"></asp:BoundColumn> 
            <asp:BoundColumn ItemStyle-HorizontalAlign="left" DataField="Shop"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" DataField="Receipt"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="Amount"></asp:BoundColumn> 
		</columns>
	</asp:DataGrid>
</div>
<div id="ShowResultByProduct" runat="server">
	<asp:DataGrid ID="ResultByProduct" AutoGenerateColumns="false" CellPadding="3" CssClass="text" HeaderStyle-BackColor="#507093" HeaderStyle-CssClass="tdHeader" HeaderStyle-HorizontalAlign="center" AllowPaging="true" OnPageIndexChanged="ChangeGridPage2" Width="100%" OnItemDataBound="ResultProduct_ItemDataBound" PagerStyle-Mode="NumericPages" PageSize="20" runat="server">
		<columns>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" DataField="ProductCode"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" DataField="ProductName"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="Qty"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="PricePerUnit"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="SubTotal"></asp:BoundColumn>
		</columns>
	</asp:DataGrid>
</div>
</form>


<div id="errorMsg" runat="server" />

<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim getPageText As New DefaultText()
Dim DateTimeUtil As New MyDateTime()
Dim objDB As New CDBUtil()
Dim getData As New CMembers()
Dim FormatDocNumber As New FormatText()
Dim getReport As New stReports()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated AND IsNumeric(Request.QueryString("MemberID")) Then
	  	objCnn = getCnn.EstablishConnection()	
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(13,Session("LangID"),objCnn)
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
		Dim textTable1 As New DataTable()
		textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
			
		'Try		
			Dim AdditionalHeaderText As String = ""		

			Radio_1.Text = "Group By Date"
			Radio_2.Text = "Group By Product"
			Dim DisplayType As Integer
			If Not Page.IsPostBack Then
				Radio_1.Checked = True
			End If
			If Radio_1.Checked = True Then
				DisplayType = 2
			Else
				DisplayType = 1
			End If
			If Not Page.IsPostBack Then
				AdditionalHeaderText += "Purchase statistics (" + Request.QueryString("ReportDate") + ")"
				If IsNumeric(Request.QueryString("MemberID")) Then
					Dim memberInfo As DataTable = getData.GetMemberInfo(5,-1,Request.QueryString("MemberID"),-1,"MemberFirstName,MemberLastName", objCnn)
					If memberInfo.Rows.Count > 0 Then AdditionalHeaderText += "<br>" + memberInfo.Rows(0)("MemberFirstName") + " " + memberInfo.Rows(0)("MemberLastName")
				End If
				HeaderText.InnerHtml = AdditionalHeaderText
				BuildDataByDate()
				BuildDataByProduct()
				ShowResultByDate.Visible = True
				ShowResultByProduct.Visible = False

			End If

		'Catch ex As Exception
			'errorMsg.InnerHtml = ex.Message
		'End Try

	Else
		updateMessage.Text = "Access Denied"
	End If
End Sub

Sub DisplayData(Source As Object, e As System.EventArgs)
	If Radio_1.Checked = True Then
		ShowResultByDate.Visible = True
		ShowResultByProduct.Visible = False
	Else
		ShowResultByDate.Visible = False
		ShowResultByProduct.Visible = True
	End If
End Sub

Private Sub ResultDate_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) 
	
	If e.Item.ItemType = ListItemType.Header Then
		e.Item.Cells(0).Text = "Date"
		e.Item.Cells(1).Text = "Paid Time"
		e.Item.Cells(2).Text = "Shop Name"
		e.Item.Cells(3).Text = "Receipt #"
		e.Item.Cells(4).Text = "Amount"
	End If
End Sub
Private Sub ResultProduct_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) 
	
	If e.Item.ItemType = ListItemType.Header Then
		e.Item.Cells(0).Text = "Product Code"
		e.Item.Cells(1).Text = "Product Name"
		e.Item.Cells(2).Text = "Qty"
		e.Item.Cells(3).Text = "Price/Unit"
		e.Item.Cells(4).Text = "Subtotal"
	End If
End Sub

Public Function BuildDataByDate() As String
	
	
	Dim i As Integer
	Dim outputString As String = ""
	Dim TotalProductDiscount As Double = 0
	Dim TotalSale As Double
	Dim grandTotalRetailPrice As Double = 0
	Dim grandTotalDiscount As Double = 0
	Dim grandTotalServiceCharge As Double = 0
	Dim grandTotalBeforeVAT As Double = 0
	Dim grandTotalVAT As Double = 0
	Dim grandTotalAfterVAT As Double = 0
	
	Dim dtTable As DataTable = getReport.MemberPurchaseReports(1,Request.QueryString("StartDate"),Request.QueryString("EndDate"),Request.QueryString("ShopList"),Request.QueryString("MemberID"), Session("LangID"), grandTotalServiceCharge, objCnn)

	Dim sqlStatement As String

	Dim DiscountArray(7) As Double
	Dim AdditionalHeaderText, HText, RText As String
	Dim getInfo As New CCategory
	Dim getProp As New CPreferences

	Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

	Dim ReceiptHeaderData As DataTable
	ReceiptHeaderData = getInfo.GetDocType(1, 0, 8, 1, objCnn)

	If ReceiptHeaderData.Rows.Count > 0 Then
		If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
			AdditionalHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
		End If
	End If
	Dim TextClass As String
	Dim FullText As String = ""
	
	Dim myDataTable As DataTable = new DataTable("SaleDataDate")
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
	myDataColumn.ColumnName = "Shop"
	myDataTable.Columns.Add(myDataColumn)
	
	myDataColumn = New DataColumn()
	myDataColumn.DataType = System.Type.GetType("System.String")
	myDataColumn.ColumnName = "Date"
	myDataTable.Columns.Add(myDataColumn)
	
	myDataColumn = New DataColumn()
	myDataColumn.DataType = System.Type.GetType("System.String")
	myDataColumn.ColumnName = "Time"
	myDataTable.Columns.Add(myDataColumn)
	
	myDataColumn = New DataColumn()
	myDataColumn.DataType = System.Type.GetType("System.String")
	myDataColumn.ColumnName = "Receipt"
	myDataTable.Columns.Add(myDataColumn)
	
	myDataColumn = New DataColumn()
	myDataColumn.DataType = System.Type.GetType("System.String")
	myDataColumn.ColumnName = "Amount"
	myDataTable.Columns.Add(myDataColumn)
	Dim counter As Integer = 1
	
	For i = 0 To dtTable.Rows.Count - 1

		TotalSale = dtTable.Rows(i)("TotalSale")

		If dtTable.Rows(i)("TransactionStatusID") = 2 Then
			myDataRow = myDataTable.NewRow()
			myDataRow("#") = counter.ToString

			grandTotalAfterVAT += TotalSale
			myDataRow("Shop") = dtTable.Rows(i)("ShopName")
			myDataRow("Date") = DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly")
			myDataRow("Time") = DateTimeUtil.FormatDateTime(dtTable.Rows(i)("PaidTime"), "TimeOnly")
			HText = ""
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
				RText = FormatDocNumber.GetReceiptHeader(HText, dtTable.Rows(i)("ReceiptYear"), dtTable.Rows(i)("ReceiptMonth"), dtTable.Rows(i)("ReceiptID"))
			End If
			If Not IsDBNull(dtTable.Rows(i)("DocTypeHeader")) Then
				FullText = "<br>" + FormatDocNumber.GetReceiptHeader(dtTable.Rows(i)("DocTypeHeader"), dtTable.Rows(i)("FReceiptYear"), dtTable.Rows(i)("FReceiptMonth"), dtTable.Rows(i)("FReceiptID"))
			Else
				FullText = ""
			End If
			If RText <> "-" Then
				myDataRow("Receipt") = "<a href=""JavaScript: newWindow = window.open( 'BillDetails.aspx?ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "&ShopID=" + dtTable.Rows(i)("ShopID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & RText & "</a>" & FullText
			Else
				myDataRow("Receipt") = RText 
			End If
	
			myDataRow("Amount") = Format(TotalSale, "##,##0.00")

			counter += 1
			myDataTable.Rows.Add(myDataRow)
		End If
	Next
	myDataRow = myDataTable.NewRow()
	myDataRow("Receipt") = "Grand Total"
	myDataRow("Amount") = Format(grandTotalAfterVAT, "##,##0.00")
	myDataTable.Rows.Add(myDataRow)
	ResultByDate.DataSource = myDataTable
	ResultByDate.DataBind()

End Function

Public Function BuildDataByProduct() As String

	Dim myDataTable As DataTable = new DataTable("SaleDataProduct")
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
	myDataColumn.ColumnName = "ProductCode"
	myDataTable.Columns.Add(myDataColumn)
	
	myDataColumn = New DataColumn()
	myDataColumn.DataType = System.Type.GetType("System.String")
	myDataColumn.ColumnName = "ProductName"
	myDataTable.Columns.Add(myDataColumn)
	
	myDataColumn = New DataColumn()
	myDataColumn.DataType = System.Type.GetType("System.String")
	myDataColumn.ColumnName = "Qty"
	myDataTable.Columns.Add(myDataColumn)
	
	myDataColumn = New DataColumn()
	myDataColumn.DataType = System.Type.GetType("System.String")
	myDataColumn.ColumnName = "PricePerUnit"
	myDataTable.Columns.Add(myDataColumn)
	
	myDataColumn = New DataColumn()
	myDataColumn.DataType = System.Type.GetType("System.String")
	myDataColumn.ColumnName = "SubTotal"
	myDataTable.Columns.Add(myDataColumn)

	Dim i As Integer
	Dim counter As Integer
	Dim ShowString As String = ""
	Dim DummyShopID As Integer
	Dim subTotalRetailPrice As Double = 0
	Dim subTotalPriceDiscount As Double = 0
	Dim subTotalDiscount As Double = 0
	Dim subTotalBeforeVAT As Double = 0
	Dim subTotalVAT As Double = 0
	Dim subTotalAfterVAT As Double = 0
	Dim subTotalOtherDiscount As Double = 0

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
	
	Dim dtTable As DataTable = getReport.MemberPurchaseReports(0,Request.QueryString("StartDate"),Request.QueryString("EndDate"),Request.QueryString("ShopList"),Request.QueryString("MemberID"), Session("LangID"), grandTotalServiceCharge, objCnn)

	Dim DiscountArray(7) As Double

	Dim RetailPriceAfterVAT As Double = 0
	Dim sqlCommand, TextClass As String
	Dim DummyGroupID, DummyDeptID, SectionString As Integer
	Dim VATString As String
	Dim TotalProductDiscount, EachSubTotal As Double
	Dim bgColor As String = "white" 'GlobalParam.GrayBGColor
	Dim ExtraInfo As String
	Dim DummyVAT As Double
	Dim DummySaleDate As Date
	Dim getProp As New CPreferences

	Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

	Dim PaymentString, compareString, ExtraPaymentString As String

	counter = 1
	For i = 0 To dtTable.Rows.Count - 1
		myDataRow = myDataTable.NewRow()
		myDataRow("#") = (i+1).ToString

		If Not IsDBNull(dtTable.Rows(i)("ProductCode")) Then
			myDataRow("ProductCode") = dtTable.Rows(i)("ProductCode")
		Else
			myDataRow("ProductCode") = "-"
		End If
		If dtTable.Rows(i)("ProductSettype") < 0 Then
			ExtraInfo = "**"
		Else
			ExtraInfo = ""
		End If
		If Not IsDBNull(dtTable.Rows(i)("ProductName")) Then
			myDataRow("ProductName") = dtTable.Rows(i)("ProductName") + ExtraInfo
		ElseIf Not IsDBNull(dtTable.Rows(i)("OtherFoodName")) Then
			myDataRow("ProductName") = dtTable.Rows(i)("OtherFoodName")
		Else
			myDataRow("ProductName") = "-" 
		End If
		If Not IsDBNull(dtTable.Rows(i)("Amount")) Then
			myDataRow("Qty") = Format(dtTable.Rows(i)("Amount"), "##,##0.0")
		Else
			myDataRow("Qty") = "-" 
		End If


		If Not IsDBNull(dtTable.Rows(i)("TotalSale")) Then
			myDataRow("SubTotal") = Format(dtTable.Rows(i)("TotalSale"), "##,##0.00")
			If Not IsDBNull(dtTable.Rows(i)("Amount")) Then
				myDataRow("PricePerUnit") = Format((dtTable.Rows(i)("TotalSale"))/dtTable.Rows(i)("Amount"), "##,##0.00")
			Else
				myDataRow("PricePerUnit") = "-" 
			End If
			If dtTable.Rows(i)("TransactionStatusID") = 2 Then
				subTotalAfterVAT += dtTable.Rows(i)("TotalSale")
				grandTotalAfterVAT += dtTable.Rows(i)("TotalSale")
			End If
		Else
			myDataRow("PricePerUnit") = "0.00" 
			myDataRow("SubTotal") = "0.00" 
		End If

		counter = counter + 1
		myDataTable.Rows.Add(myDataRow)
	Next

	myDataRow = myDataTable.NewRow()
	myDataRow("PricePerUnit") = "Grand Total"
	myDataRow("SubTotal") = Format(grandTotalAfterVAT, "##,##0.00")
	myDataTable.Rows.Add(myDataRow)
	
	ResultByProduct.DataSource = myDataTable
	ResultByProduct.DataBind()


End Function


Sub ChangeGridPage1(objSender As Object, objArgs As DataGridPageChangedEventArgs)
	
   ResultByDate.CurrentPageIndex = objArgs.NewPageIndex

   BuildDataByDate()
	
End Sub

Sub ChangeGridPage2(objSender As Object, objArgs As DataGridPageChangedEventArgs)
	
   ResultByProduct.CurrentPageIndex = objArgs.NewPageIndex

   BuildDataByProduct()
	
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
