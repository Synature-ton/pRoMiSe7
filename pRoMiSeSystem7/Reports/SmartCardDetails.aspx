<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<html>
<head>
<title>Smart Card Details</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">
<form id="mainForm" runat="server">
<ASP:Label id="updateMessage" CssClass="text" runat="server" />

<table cellpadding="2" cellspacing="2" width="100%">
<tr>
<td align="left"><div class="headerText" align="left" id="HeaderText" runat="server" /></td>
<td align="right"><div class="text"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print" runat="server" /></a> | <a href="javascript: window.close()"><asp:Label ID="CloseText" Text="Close Windows" runat="server" /></a></div></td>
</tr>
<tr><td height="5" colspan="2"></td></tr>
<tr><td><div id="CostText" class="text" runat="server"></div></td>
<td align="right"><div class="text" id="GoBackText" runat="server"></div></td></tr>
<tr><td height="5" colspan="2"></td></tr>
</table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="Text5" runat="server"></div></td>
	</tr>
	<div id="ResultText" runat="server"></div>
	
</table>

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
Dim getProp As New CPreferences()
Dim getReport As New GenReports()
Dim objDB As New CDBUtil()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Report_Smartcard") AND IsNumeric(Request.QueryString("CardID")) AND IsNumeric(Request.QueryString("ProductLevelID")) Then
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
			
		Try		
			Dim AdditionalHeaderText As String = ""		
			Text1.InnerHtml = "Detail"
			Text2.InnerHtml = "Shop"
			Text3.InnerHtml = "Staff Name"
			Text4.InnerHtml = "Amount"
			Text5.InnerHtml = "Date"
			
			If Not Page.IsPostBack Then
				
				Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
				Dim dtTable As DataTable = SmartCardDetails(Request.QueryString("CardID"),Request.QueryString("ProductLevelID"),Session("LangID"),objCnn)
				Dim ReceiptHeaderData As Datatable
				ReceiptHeaderData = getInfo.GetDocType(1,0,8,Session("LangID"),objCnn)

				If ReceiptHeaderData.Rows.Count > 0 Then
					If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
						AdditionalHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
					End If
				End If
				HeaderText.InnerHtml = "Smart Card Details: " + Request.QueryString("MemberName")
				Dim TotalAmount As Double = 0
				Dim i,counter As integer
				Dim outputString As String = ""
				counter = 1
				Dim HText,RText As String
				Dim TotalSale As Double = 0
				Dim bgColor As String = "e9e9e9"
				For i=0 To dtTable.Rows.Count - 1
					If bgColor = "white" Then
						bgColor = "e9e9e9"
					Else
						bgColor = "white"
					End If
					HText  = ""
					If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
						If Not IsDBNull(dtTable.Rows(i)("DocumentTypeHeader")) Then
							HText = dtTable.Rows(i)("DocumentTypeHeader")
						End If
					Else
						HText = AdditionalHeaderText
					End If
					If dtTable.Rows(i)("TransactionID") = 0 Then
						RText = "Refill"
					Else If IsDBNull(dtTable.Rows(i)("ReceiptID")) Or IsDBNull(dtTable.Rows(i)("ReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("ReceiptYear")) Then
						RText = "-"
					Else
						RText = FormatDocNumber.getReceiptHeader(HText,dtTable.Rows(i)("ReceiptYear"),dtTable.Rows(i)("ReceiptMonth"),dtTable.Rows(i)("ReceiptID"))
					End If
				
					outputString += "<tr bgcolor=""" + bgColor + """>"
					outputString += "<td align=""left"" class=""text"">" & RText & "</td>"
					outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("RefillShop") & "</td>"
					outputString += "<td align=""right"" class=""text"">" & dtTable.Rows(i)("StaffName") & "</td>"
					outputString += "<td align=""right"" class=""text"">" & Format(dtTable.Rows(i)("Amount"),"##,##0.00") & "</td>"
					outputString += "<td align=""right"" class=""text"">" & DateTimeUtil.FormatDateTime(dtTable.Rows(i)("HistoryDateTime"), "DateAndTime") & "</td>"	
					
					outputString += "</tr>"
					counter = counter + 1
					TotalAmount += dtTable.Rows(i)("Amount")
				Next
				
				outputString += "<tr><td colspan=""3"">&nbsp;</td><td align=""right"" class=""boldText"">" + Format(TotalAmount,"##,##0.00") + "</td><td>&nbsp;</td></tr>"
				ResultText.InnerHtml = outputString
				
				

				
			End If

		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try

	Else
		updateMessage.Text = "Access Denied"
	End If
End Sub

Public Function SmartCardDetails(ByVal CardID As Integer, ByVal ProductLevelID As Integer, ByVal LangID As Integer, ByVal objCnn As MySqlConnection) As DataTable
            Dim sqlStatement As String
            Dim AdditionalQuery As String = ""

            If CardID > 0 Then
                AdditionalQuery += " AND a.CardID = " + CardID.ToString
            End If

            If ProductLevelID > 0 Then
                AdditionalQuery += " AND a.ProductLevelID=" + ProductLevelID.ToString
            End If

            sqlStatement = "select a.*,b.SaleDate,c.ProductLevelName AS CreateShop, d.ProductLevelName AS UseShop, e.ProductLevelName AS RefillShop, CONCAT(f.StaffFirstName, ' ', f.StaffLastName) AS StaffName, g.DocumentTypeHeader, b.ReceiptID, b.ReceiptMonth, b.ReceiptYear from smartcardhistory a left outer join ordertransaction b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID left outer join ProductLevel c ON a.ProductLevelID=c.ProductLevelID left outer join ProductLevel d ON b.ShopID=d.ProductLevelID left outer join ProductLevel e ON a.InsertProductLevelID=e.ProductLevelID left outer join Staffs f ON a.StaffID=f.StaffID left outer join DocumentType g ON b.CloseComputerID=g.ComputerID AND g.LangID=" + LangID.ToString + " AND g.DocumentTypeID=8 where 0=0 " + AdditionalQuery + " order by a.HistoryDateTime"

            Return objDB.List(sqlStatement, objCnn)
        End Function

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
