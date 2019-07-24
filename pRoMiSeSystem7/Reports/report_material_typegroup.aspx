<%@ Page Language="VB" ContentType="text/html" debug="True" %>
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
<title>Report Material Document</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">

<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<form id="mainForm" runat="server">
<input type="hidden" id="DocumentTypeGroupID" runat="server">
<table cellpadding="2" cellspacing="2" width="100%">
<tr>
<td align="left"><div class="headerText" align="left" id="HeaderText" runat="server" /></td>
<td align="right"><div class="text" id="GoBackText" runat="server"></div></td>
</tr>

</table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td id="headerTD1" align="center" class="smallTdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD2" align="center" class="smallTdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD9" align="center" class="smallTdHeader" runat="server"><div id="Text9" runat="server"></div></td>
		<td id="headerTD3" align="center" class="smallTdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD4" align="center" class="smallTdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td id="headerTD5" align="center" class="smallTdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<td id="headerTD6" align="center" class="smallTdHeader" runat="server"><div id="Text6" runat="server"></div></td>
		<td id="headerTD7" align="center" class="smallTdHeader" runat="server"><div id="Text7" runat="server"></div></td>
		<td id="headerTD8" align="center" class="smallTdHeader" runat="server"><div id="Text8" runat="server"></div></td>
	</tr>
	
	
	<div id="ResultText" runat="server"></div>
	
</table></form>

<div id="errorMsg" runat="server" />

<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getInfo As New CCategory()
Dim getPageText As New DefaultText()
Dim FormatHeader As New FormatText()
Dim DateTimeUtil As New MyDateTime()
Dim objDB As New CDBUtil()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("StockCard_Report") Then
	  
	  If NOT Request.QueryString("DocumentTypeGroupID") AND IsNumeric(Request.QueryString("DocumentTypeGroupID")) Then
	  	
		Try
		
			objCnn = getCnn.EstablishConnection()
				
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
			DocumentTypeGroupID.Value = Request.QueryString("DocumentTypeGroupID")
			
			headerTD1.BgColor = GlobalParam.AdminBGColor
			headerTD2.BgColor = GlobalParam.AdminBGColor
			headerTD3.BgColor = GlobalParam.AdminBGColor
			headerTD4.BgColor = GlobalParam.AdminBGColor
			headerTD5.BgColor = GlobalParam.AdminBGColor
			headerTD6.BgColor = GlobalParam.AdminBGColor
			headerTD7.BgColor = GlobalParam.AdminBGColor
			headerTD8.BgColor = GlobalParam.AdminBGColor
			headerTD9.BgColor = GlobalParam.AdminBGColor
			
			headerTD5.Visible = False
			headerTD6.Visible = False
			headerTD8.Visible = False

			GoBackText.InnerHtml = "<a href=""javascript: window.print()"">Print this Page</a> | <a href=""javascript: window.close()"">Close Window</a>"
			
			
			Text1.InnerHtml = ""
			Text2.InnerHtml = "Document No.<br>Document Name"
			Text9.InnerHtml = "Inputed By<br>Approved By"
			Text3.InnerHtml = "Document Date"
			Text4.InnerHtml = "Vendor Name"
			Text5.InnerHtml = "Qty"
			Text6.InnerHtml = "Qty<br>(Unit Small)"
			Text7.InnerHtml = "Net Price"
			Text8.InnerHtml = "Price/Small Unit"
			Dim OrderByString As String = ""
        	Dim dtTable As New DataTable()
        	dtTable = getInfo.MaterialTypeGroupDocument(Request.QueryString("ProductLevelID"),Request.QueryString("DocumentTypeGroupID"),Request.QueryString("SelMonth"),Request.QueryString("SelYear"), Session("LangID"), OrderByString, objCnn)	
			
			Dim DocTypeGroup As DataTable = getInfo.DocumentTypeGroup(Request.QueryString("DocumentTypeGroupID"),objCnn)
			Dim DocGroupName As String = "Documents"
			If DocTypeGroup.Rows.Count > 0 Then
				DocGroupName = DocTypeGroup.Rows(0)("GroupHeader") + " documents"
			End If
			
			Dim i As Integer
			Dim outputString As String = ""
			Dim ReportDate As String
			Dim SelectedText As String = "smallText"
			Dim DocHeader As String
			Dim TotalCost As Double = 0
			Dim TotalQty As Double = 0
			Dim StaffString As String
			If dtTable.Rows.Count > 0 Then
				Dim SDate As New Date(Request.QueryString("SelYear"),Request.QueryString("SelMonth"),1)
				ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy",Session("LangID"),objCnn)
				HeaderText.InnerHtml = DocGroupName + " for " + ReportDate
				For i = 0 To dtTable.Rows.Count - 1
					StaffString = ""
					DocHeader = FormatHeader.DocumentNumber(dtTable.Rows(i)("ShopID"),dtTable.Rows(i)("DocumentTypeID"),dtTable.Rows(i)("DocumentID"),Session("LangID"), GlobalParam.YearType, objCnn)
					outputString += "<tr><td align=""center"" class=""" + SelectedText + """>" & (i+1).ToString & "</td>"
					outputString += "<td align=""left"" class=""" + SelectedText + """><a class=""" + SelectedText + """ href=""JavaScript: newWindow = window.open( '../Inventory/document_detail.aspx?MaterialID=" + "0" + "&SelMonth=" & Request.QueryString("SelMonth").ToString & "&SelYear=" & Request.QueryString("SelYear").ToString & "&DocumentID=" & dtTable.Rows(i)("DocumentID").ToString & "&ShopID=" & dtTable.Rows(i)("ShopID").ToString & "&ProductLevelID=" & Request.QueryString("ProductLevelID").ToString + "', '', 'width=800,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & DocHeader & "</a><br>" + dtTable.Rows(i)("DocumentTypeName") +  "</td>"
					If Not IsDBNull(dtTable.Rows(i)("InputStaff")) Then
						StaffString += dtTable.Rows(i)("InputStaff")
					Else
						StaffString += "-"
					End If
					If Not IsDBNull(dtTable.Rows(i)("ApproveStaff")) Then
						StaffString += "<br>" + dtTable.Rows(i)("ApproveStaff")
					Else
						StaffString += "<br>-"
					End If
					
					outputString += "<td align=""left"" class=""" + SelectedText + """>" & StaffString & "</td>"
					outputString += "<td align=""left"" class=""" + SelectedText + """>" & DateTimeUtil.FormatDateTime(dtTable.Rows(i)("DocumentDate"), "DateOnly") & "</td>"
					If Not IsDBNull(dtTable.Rows(i)("VendorName")) Then
						outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("VendorName") & "</td>"
					Else
						outputString += "<td align=""left"" class=""" + SelectedText + """>" & "-" & "</td>"
					End If
					
					If IsNumeric(dtTable.Rows(i)("TotalDocPrice")) Then
						outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("TotalDocPrice"),"##,##0.0000") & "</td></tr>"
						TotalCost += dtTable.Rows(i)("TotalDocPrice")
					Else
						outputString += "<td align=""right"" class=""" + SelectedText + """>" & "-" & "</td></tr>"
					End If

				Next
				outputString += "<tr bgColor=""" + GlobalParam.GrayBGColor + """><td colspan=""5"" align=""right"" class=""text"">Summary</td>"
				outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(TotalCost,"##,##0.0000") & "</td></tr>"
				ResultText.InnerHtml = outputString
			Else
				updateMessage.Text = "No Data"
			End If
		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
	  Else
	  	updateMessage.Text = "Invalid Parameters"
	  End If
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
