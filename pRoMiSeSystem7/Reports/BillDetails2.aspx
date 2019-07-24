<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="SaleReport2" %>
<html>
<head>
<title>Bill Details</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">
<form id="mainForm" runat="server">
<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<div class="noprint">
<table cellpadding="2" cellspacing="2" width="90%">
<tr>
<td align="left"><div class="headerText" align="left" id="HeaderText" runat="server" /></td>
<td align="right"><div class="text"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print" runat="server" /></a> | <a href="javascript: window.close()"><asp:Label ID="CloseText" Text="Close Windows" runat="server" /></a></div></td>
</tr>
<tr><td height="5" colspan="2"></td></tr>
<tr><td><div id="CostText" class="text" runat="server"></div></td>
<td align="right"><div class="text" id="GoBackText" runat="server"></div></td></tr>
<tr><td height="5" colspan="2"></td></tr>
</table>
</div>
<table id="myTable" border="0" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="90%">
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD8" align="center" class="tdHeader" runat="server"><div id="Text8" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="Text6" runat="server"></div></td>
		<td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="Text7" runat="server"></div></td>	
		<td id="headerTD9" align="center" class="tdHeader" runat="server"><div id="Text9" runat="server"></div></td>
		<td id="headerTD10" align="center" class="tdHeader" runat="server"><div id="Text10" runat="server"></div></td>
		<td id="headerTD11" align="center" class="tdHeader" runat="server"><div id="Text11" runat="server"></div></td>
	</tr>
	<div id="ResultText" runat="server"></div>
	
</table>
<div id="DisplayPayDetail" runat="server">
<table>
	<tr><td>&nbsp;</td></tr>
	<tr><td class="text">Pay Details</td></tr>
</table>
<table id="myTable1" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
	<tr>
		<td id="headerTD17" align="center" class="tdHeader" runat="server"><div id="Text17" runat="server"></div></td>
		<td id="headerTD18" align="center" class="tdHeader" runat="server"><div id="Text18" runat="server"></div></td>
		<td id="headerTD19" align="center" class="tdHeader" runat="server"><div id="Text19" runat="server"></div></td>
		<td id="headerTD20" align="center" class="tdHeader" runat="server"><div id="Text20" runat="server"></div></td>
		<td id="headerTD21" align="center" class="tdHeader" runat="server"><div id="Text21" runat="server"></div></td>
	</tr>
	<div id="PayDetails" runat="server"></div>
</table>
</div>
</form>


<div id="errorMsg" runat="server" />

<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim FormatDocNumber As New FormatText()
Dim DateTimeUtil As New MyDateTime()
Dim getInfo As New CCategory()
Dim objDB As New CDBUtil()
Dim getReport As New StReports()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated AND IsNumeric(Request.QueryString("ComputerID")) AND IsNumeric(Request.QueryString("TransactionID")) Then
	  	objCnn = getCnn.EstablishConnection()	
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(13,Session("LangID"),objCnn)
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
				
		headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor
		headerTD6.BgColor = GlobalParam.AdminBGColor
		headerTD7.BgColor = GlobalParam.AdminBGColor
		headerTD8.BgColor = GlobalParam.AdminBGColor
		headerTD9.BgColor = GlobalParam.AdminBGColor
		headerTD10.BgColor = GlobalParam.AdminBGColor
		headerTD11.BgColor = GlobalParam.AdminBGColor
		headerTD8.Visible = False
		headerTD9.Visible = False
		
		headerTD17.BgColor = GlobalParam.AdminBGColor
		headerTD18.BgColor = GlobalParam.AdminBGColor
		headerTD19.BgColor = GlobalParam.AdminBGColor
		headerTD20.BgColor = GlobalParam.AdminBGColor
		headerTD21.BgColor = GlobalParam.AdminBGColor
			
		'Try		
			Dim AdditionalHeaderText As String = ""		

			Text1.InnerHtml = ""
			Text2.InnerHtml = "Code"
			Text3.InnerHtml = "Product Name"
			Text4.InnerHtml = "Unit Price"
			Text5.InnerHtml = "Qty"
			Text6.InnerHtml = "Subtotal"
			Text7.InnerHtml = "Discount"
			Text8.InnerHtml = "Order #"
			Text9.InnerHtml = ""
			Text10.InnerHtml = "Total"
			Text11.InnerHtml = ""
			
			Text17.InnerHtml = ""
			Text18.InnerHtml = "Date"
			Text19.InnerHtml = "Received By"
			Text20.InnerHtml = "Amount Paid"
			Text21.InnerHtml = "Status"
			
			If Not Page.IsPostBack Then

				Dim ShopProp As DataTable = getInfo.GetProductLevel(Request.QueryString("ShopID"),objCnn)
				If ShopProp.Rows(0)("DisplayOrderBookRecord") = 1 Then
					headerTD8.Visible = True
				End If
				
				Dim i,counter As integer
				Dim outputString As String = ""
				counter = 1
				
				Dim TotalSale As Double = 0
				Dim bgColor As String = "e9e9e9"
				Dim TotalCreditMoney AS Double = 0
				Dim TotalPay As Double = 0
				Dim outString As String = ""
				Dim bgColor1 As String

				
				Dim grandTotal,TotalVAT As Double
				Dim GraphData As DataSet
				Dim PayTypeList As DataTable
				ResultText.InnerHtml = getReport.SaleReports(PayTypeList,outputString, grandTotal, TotalVAT, graphData, True,GlobalParam.GrayBGColor,GlobalParam.AdminBGColor,Session("LangID"),0,True, False, False, 0, "", "", Request.QueryString("ShopID"), Request.QueryString("TransactionID"), Request.QueryString("ComputerID"),False,True, False, objCnn)
				

				Dim PayDetail As DataTable = getInfo.GetPayDetail(Request.QueryString("ComputerID"),Request.QueryString("TransactionID"),objCnn)

				outputString = ""
				bgColor = "e9e9e9"
				Dim TotalPaid As Double = 0
				counter = 1
				For i=0 To PayDetail.Rows.Count - 1
					If bgColor = "white" Then
						bgColor = "e9e9e9"
					Else
						bgColor = "white"
					End If
	
					outputString += "<tr bgcolor=""" + bgColor + """><td align=""center"" class=""text"">" & counter.ToString & "</td>"
					outputString += "<td align=""right"" class=""text"">" & DateTimeUtil.FormatDateTime(PayDetail.Rows(i)("InsertDate"),"DateOnly") & "</td>"
					
					outputString += "<td align=""left"" class=""text"">" & PayDetail.Rows(i)("StaffFirstName") + " " + PayDetail.Rows(i)("StaffLastName") & "</td>"
					outputString += "<td align=""right"" class=""text"">" & Format(PayDetail.Rows(i)("PayAmount"),"##,##0.00") & "</td>"
					If PayDetail.Rows(i)("CreditMoneyStatusID") = 2 Then
						outputString += "<td align=""center"" class=""text"">" & "Completed" & "</td>"
					Else
						outputString += "<td align=""center"" class=""redtext"">" & "Voided" & "</td>"
					End If
					outputString += "</tr>"
					counter = counter + 1
					If PayDetail.Rows(i)("CreditMoneyStatusID") = 2 Then
						TotalPaid += PayDetail.Rows(i)("PayAmount")
					End If
				Next
				If bgColor = "white" Then
					bgColor = "e9e9e9"
				Else
					bgColor = "white"
				End If
				If PayDetail.Rows.Count > 0 Then
					Dim getCreditMoney As DataTable = objDB.List("SELECT SUM(Amount) AS TotalCreditMoney FROM PayDetail WHERE PayTypeID=5 AND TransactionID=" + Request.QueryString("TransactionID").ToString + " AND ComputerID=" + Request.QueryString("ComputerID").ToString, objCnn)
					TotalCreditMoney = getCreditMoney.Rows(0)("TotalCreditMoney")
					outputString += "<tr bgcolor=""" + bgColor + """><td colspan=""3"" align=""right"" class=""text"">" + "Total Paid" + "</td><td class=""text"" align=""right"">" + Format(TotalPaid,"##,##0.00") + "</td><td></td></tr>"
					If bgColor = "white" Then
						bgColor = "e9e9e9"
					Else
						bgColor = "white"
					End If
					outputString += "<tr bgcolor=""" + bgColor + """><td colspan=""3"" align=""right"" class=""text"">" + "Balance" + "</td><td class=""text"" align=""right"">" + Format(TotalCreditMoney-TotalPaid,"##,##0.00") + "</td><td></td></tr>"
					DisplayPayDetail.Visible = True
					PayDetails.InnerHtml = outputString
				Else
					DisplayPayDetail.Visible = False
				End If
			End If

		'Catch ex As Exception
			'errorMsg.InnerHtml = ex.Message
		'End Try

	Else
		updateMessage.Text = "Access Denied"
	End If
End Sub


Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
