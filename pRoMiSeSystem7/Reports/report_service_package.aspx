<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Service Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Sale Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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

</div>
<br>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
<tr>
	<td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td>
</tr>
</table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td id="headerTD1" align="center" class="smallTdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD5" align="center" class="smallTdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<td id="headerTD0" align="center" class="smallTdHeader" runat="server"><div id="Text0" runat="server"></div></td>
		<td id="headerTD7" align="center" class="smallTdHeader" runat="server"><div id="Text7" runat="server"></div></td>
		<td id="headerTD9" align="center" class="smallTdHeader" runat="server"><div id="Text9" runat="server"></div></td>
		<td id="headerTD2" align="center" class="smallTdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD3" align="center" class="smallTdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD6" align="center" class="smallTdHeader" runat="server"><div id="Text6" runat="server"></div></td>
		<td id="headerTD4" align="center" class="smallTdHeader" runat="server"><div id="Text4" runat="server"></div></td>
	</tr>
	
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
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getInfo As New CCategory()
Dim getPageText As New DefaultText()
Dim getStaffRole As New CStaffRole()
Dim DateTimeUtil As New MyDateTime()
Dim commInfo As New CPromotions()
Dim getProp As New CPreferences()
Dim getReport As New GenReports()
Dim FormatDocNumber As New FormatText()
Dim objDB As New CDBUtil()

		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_Sale_New") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")

		headerTD0.BgColor = GlobalParam.AdminBGColor
	  	headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor
		headerTD6.BgColor = GlobalParam.AdminBGColor
		headerTD7.BgColor = GlobalParam.AdminBGColor
		headerTD9.BgColor = GlobalParam.AdminBGColor
		
		ResultText.InnerHtml = ""
		ResultSearchText.InnerHtml = ""
		errorMsg.InnerHtml = ""
		
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(13,Session("LangID"),objCnn)
			Dim textTable1 As New DataTable()
			textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			Text0.InnerHtml = "Package #"
			Text1.InnerHtml = "Staff Name"
			Text2.InnerHtml = "Service Name"
			Text6.InnerHtml = "Weighted Price"
			Text5.InnerHtml = "Customer Name"
			Text3.InnerHtml = "Qty"
			Text4.InnerHtml = "Service Time"
			Text9.InnerHtml = "Receipt #"
			Text7.InnerHtml = "Package Name"
			
			HeaderText.InnerHtml = "Service Report"
			
			Dim i As Integer
			Dim outputString,FormSelected,compareString As String
			Dim SelectString As String 
			Dim ReportDate As String
			Try
			ReportDate = " (" + Trim(Replace(Replace(Replace(Replace(Request.QueryString("StartDate"),"{",""),"}",""),"d",""),"'","")) + " - " + Trim(Replace(Replace(Replace(Replace(Request.QueryString("EndDate"),"{",""),"}",""),"d",""),"'","")) + ")"
			
			Catch ex As Exception
				ReportDate = ""
			End Try
			ResultSearchText.InnerHtml = "Used Services from Course/Package" + ReportDate
			GenReports("","",False,True,True,False,0,0,Request.QueryString("StartDate"),Request.QueryString("EndDate"),Request.QueryString("ShopID"),Session("LangID"),objCnn)
					
		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
	  
	Else
		showPage.Visible = False
		errorMsg.InnerHtml = "Access Denied"
	End If
End Sub

Public Function GenReports(ByVal MemberFirstName As String, ByVal MemberLastName As String, ByVal Radio1 As Boolean, ByVal Radio2 As Boolean, ByVal Radio3 As Boolean, ByVal Radio4 As Boolean, ByVal selMonth As Integer, ByVal selYear As Integer, ByVal StartDate As String, ByVal EndDate As String, ByVal ShopID As String, ByVal LangID As Integer, ByVal objCnn As MySqlConnection) As DataTable
	Dim FoundError As Boolean
	FoundError = False
	Session("ReportResult") = ""
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(12,Session("LangID"),objCnn)
			
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""
	
	If FoundError = False Then
		ShowPrint.Visible = True
		If Radio4 = True Then
			Text1.InnerHtml = "Member Name"
			Text5.InnerHtml = "Staff Name"
		Else
			Text5.InnerHtml = "Member Name"
			Text1.InnerHtml = "Staff Name"
		End If
		Dim displayTable As New DataTable()
		
		Dim i As Integer
		Dim DateCheck As Boolean

		Dim outputString As String = ""
		Dim counter As Integer
		Dim DummyText,ExtraText As String
		Dim DummySaleDate As Date
		Dim ShowSaleDate As String = ""
		Dim DummyStaffID As Integer
		Dim bgColor As String = "e9e9e9"
		Dim FullName,DurationTime As String 
		Dim dt,dt2 As DateTime
		Dim DummyMember As String
		Dim MemberName As String
		Dim CompareMember As String
		Try
		Dim dtTable As DataTable = getReport.ServicePackageReports(Trim(MemberFirstName),Trim(MemberLastName),Radio1, Radio2, Radio3, Radio4, SelMonth, SelYear, StartDate, EndDate, ShopID, LangID, objCnn)
		
		Dim AdditionalHeaderText, HText, RText As String
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

		Dim ReceiptHeaderData As DataTable
		ReceiptHeaderData = getInfo.GetDocType(1, 0, 8, 1, objCnn)

		If ReceiptHeaderData.Rows.Count > 0 Then
			If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
				AdditionalHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
			End If
		End If
		
		Dim WeightedPrice As Double
		
		Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel where ProductLevelID IN (" + ShopID + ")", objCnn)
		Dim DisplayVATType As String = "E"
		For i = 0 To ShopInfo.Rows.Count - 1
			If ShopInfo.Rows(i)("DisplayReceiptVATableType") = 1 Then
				DisplayVATType = "V"
			End If
		Next
		Dim totalQty As Double = 0
		Dim totalPrice As Double = 0
		Dim ChkKey As String = ""
		
		For i=0 To dtTable.Rows.Count - 1
				
			If dtTable.Rows(i)("SaleDate") <> DummySaleDate Then
				ShowSaleDate = DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly")
				outputString += "<tr><td colspan=""9"" class=""smallText"" bgColor=""" + "#ccffff" + """>" + ShowSaleDate + "</td></tr>"
				DummyStaffID=0
				DummyMember = ""
			End If
			
			If ChkKey <> dtTable.Rows(i)("PrimaryKey") Then
				If bgColor = "white" Then
					bgColor = "e9e9e9"
				Else
					bgColor = "white"
				End If
			End If
			FullName = ""
			If Not IsDBNull(dtTable.Rows(i)("StaffID")) Then
				If NOT IsDBNull(dtTable.Rows(i)("StaffFirstName")) Then
					FullName += dtTable.Rows(i)("StaffFirstName")
				End If
				If NOT IsDBNull(dtTable.Rows(i)("StaffLastName")) Then
					FullName += " " + dtTable.Rows(i)("StaffLastName")
				End If
			Else
				FullName = "-"
			End If
			
			
			If Not IsDBNull(dtTable.Rows(i)("StartTime")) Then
				dt = dtTable.Rows(i)("StartTime")
				dt2 = dt.AddMinutes(dtTable.Rows(i)("DurationTime"))
				DurationTime = dt.ToString("HH:mm") + " - " + dt2.ToString("HH:mm")
			Else
				DurationTime = "-"
			End If
			If dtTable.Rows(i)("OrderStatusID") = 3 Then
				bgColor = "f4592d"
			End If
			
			If ChkKey <> dtTable.Rows(i)("PrimaryKey") Then
			outputString += "<tr bgcolor=""" + bgColor + """>"
			
			
			If Not IsDBNull(dtTable.Rows(i)("MemberFullName")) Then
				MemberName = dtTable.Rows(i)("MemberFullName")
			Else
				MemberName = ""
			End If

			outputString += "<td align=""left"" class=""smallText"">" & FullName & "</td>"
			
			
				If dtTable.Rows(i)("MemberDiscountID") = 0 Then
					ExtraText = MemberName
				ElseIf Session("Member_Info") Then
					ExtraText =  "<a class=""smallText"" href=""JavaScript: newWindow = window.open( '../members/member_stat.aspx?MemberID=" + dtTable.Rows(i)("MemberDiscountID").ToString + "', '', 'width=950,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & MemberName & "</a>"
				Else
					ExtraText = MemberName
				End If
				outputString += "<td align=""left"" class=""smallText"">" & ExtraText & "</td>"
				
				If Not IsDBNull(dtTable.Rows(i)("PackageNumber")) Then
					outputString += "<td align=""left"" class=""smallText"">" + dtTable.Rows(i)("PackageNumber") + "</td>"
				Else
					outputString += "<td align=""left"" class=""smallText"">" & "-" & "</td>"
				End If
				
				If Not IsDBNull(dtTable.Rows(i)("PackageName")) Then
					outputString += "<td align=""left"" class=""smallText"">" + "<a class=""smallText"" href=""JavaScript: newWindow = window.open( '../reports/PackageDetail.aspx?PackageID=" + dtTable.Rows(i)("PackageID").ToString + "&ProductLevelID=" + dtTable.Rows(i)("ProductLevelID").ToString + "&ShowCommission=0&ShowPrice=1', '', 'width=800,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + dtTable.Rows(i)("PackageName") + "</a>" + "</td>"
				Else
					outputString += "<td align=""left"" class=""smallText"">" & "-" & "</td>"
				End If
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
				
				If RText <> "-" Then
					outputString += "<td align=""left"" class=""smallText""><a class=""smallText"" href=""JavaScript: newWindow = window.open( 'BillDetails.aspx?ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & RText & "</a></td>"
				Else
					outputString += "<td align=""left"" class=""smallText"">" & RText & "</td>"
				End If
				
				If Not IsDBNull(dtTable.Rows(i)("ProductName")) Then
					outputString += "<td align=""left"" class=""smallText"">" & dtTable.Rows(i)("ProductName") & "</td>"
				Else
					outputString += "<td align=""left"" class=""smallText"">" & "N/A" & "</td>"
				End If
				totalQty += dtTable.Rows(i)("Amount")
				outputString += "<td align=""right"" class=""smallText"">" & Format(dtTable.Rows(i)("Amount"),"##,##0.0") & "</td>"
				
				If Not IsDBNull(dtTable.Rows(i)("CommissionPrice")) Then
					WeightedPrice = dtTable.Rows(i)("CommissionPrice")
				Else
					WeightedPrice = 0
				End If
				
				totalPrice += WeightedPrice
				outputString += "<td align=""right"" class=""smallText"">" & Format(WeightedPrice,"##,##0.00") & "</td>"
				outputString += "<td align=""right"" class=""smallText"">" & DurationTime & "</td>"
				counter = counter + 1
				outputString += "</tr>"
			Else
				'outputString += "<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>"
			End If
			
			
			
			DummySaleDate = dtTable.Rows(i)("SaleDate")
			
			ChkKey = dtTable.Rows(i)("PrimaryKey")
		Next
		If Trim(outputString) <> "" Then
			outputString += "<tr bgColor=""" + "#ffffcc" + """><td colspan=""6"" align=""right"" class=""smallText"">" + "Summary" + "</td><td class=""smallText"" align=""right"">" + Format(totalQty,"##,##0.0") + "</td><td align=""right"" class=""smallText"">" + Format(totalPrice,"##,##0.00") + "</td><td></td></tr>"
		End If
		If dtTable.Rows.Count = 0 Then
			outputString = "<tr><td class=""boldText"" colspan=""4"">No Data Found</td></tr>"
		End If
		ResultText.InnerHtml = outputString
		Catch ex As Exception
			FoundError = True
		End Try
	End If
End Function

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
