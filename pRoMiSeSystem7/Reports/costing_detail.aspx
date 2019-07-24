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
<title>Document Detail</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">

<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<form id="mainForm" runat="server">
<input type="hidden" id="MaterialID" runat="server">
<div class="noprint">
<table cellpadding="2" cellspacing="2" width="100%">
<tr>
<td align="left"><div class="headerText" align="left" id="HeaderText" runat="server" /></td>
<td align="right"><div class="text" id="GoBackText" runat="server"></div></td>
</tr>

</table>
</div>


<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<td id="headerTD11" align="center" class="tdHeader" runat="server"><div id="Text11" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="Text6" runat="server"></div></td>
		<td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="Text7" runat="server"></div></td>
		<td id="headerTD8" align="center" class="tdHeader" runat="server"><div id="Text8" runat="server"></div></td>
		<td id="headerTD9" align="center" class="tdHeader" runat="server"><div id="Text9" runat="server"></div></td>
		<td id="headerTD10" align="center" class="tdHeader" runat="server"><div id="Text10" runat="server"></div></td>
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
Dim getReport As New GenReports()
Dim objDB As New CDBUtil()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Report_ListProducts") Then
	  
	  If NOT Request.QueryString("ProductID") AND IsNumeric(Request.QueryString("ProductID")) Then
	  	
		Try
		
			objCnn = getCnn.EstablishConnection()
				
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
			MaterialID.Value = Request.QueryString("MaterialID")
			
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

			GoBackText.InnerHtml = "<a href=""javascript: window.print()"">Print this Page</a> | <a href=""javascript: window.close()"">Close Window</a>"
			
			
			Text1.InnerHtml = ""
			Text2.InnerHtml = "Material Code"
			Text3.InnerHtml = "Material Name"
			Text4.InnerHtml = "Material Use"
			Text5.InnerHtml = "Total Material Net Use"
			Text11.InnerHtml = "Total Material Use From Formular"
			Text6.InnerHtml = "Material Use<br>(Including Loss)"
			Text7.InnerHtml = "Standard Cost"
			Text8.InnerHtml = "Total Cost"
			Text9.InnerHtml = "Total Sale"
			Text10.InnerHtml = "Sub Total Per Unit"
			
			Dim VendorData As DataTable
        	Dim dtTable As New DataTable()
        	dtTable = getReport.ProductCosting(Request.QueryString("ProductID"),Session.SessionID, objCnn)	
			'Exit Sub
			Dim i As Integer
			Dim outputString As String = ""
			Dim ReportDate As String
			Dim SelectedText As String = "text"
			Dim DocHeader As String
			Dim TotalCost As Double = 0
			Dim RealUse As Double = 0
			
			If dtTable.Rows.Count > 0 Then
				HeaderText.InnerHtml = "Actual Cost Details of " + dtTable.Rows(0)("ProductName")
				For i = 0 To dtTable.Rows.Count - 1
					RealUse = (dtTable.Rows(i)("TotalMaterialUse")-dtTable.Rows(i)("TotalMaterialNotUse"))*(dtTable.Rows(i)("MaterialNetUse")/dtTable.Rows(i)("NetFormularUse"))
					outputString += "<tr><td align=""center"" class=""" + SelectedText + """>" & (i+1).ToString & "</td>"
					outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("MaterialCode") & "</td>"
					outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("MaterialName") & "</td>"
					outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("TotalMaterialUse")-dtTable.Rows(i)("TotalMaterialNotUse"),"##,##0") & "</td>"
					outputString += "<td align=""right"" class=""" + SelectedText + """><a href=""JavaScript: newWindow = window.open( '../Inventory/Product_NetUse.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&SelMonth=" + Request.QueryString("SelMonth").ToString + "&SelYear=" + Request.QueryString("SelYear") + "&ProductLevelID=" + Request.QueryString("ProductLevelID").ToString + "', '', 'width=750,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & Format(dtTable.Rows(i)("MaterialNetUse"),"##,##0") & "</a></td>"
					outputString += "<td align=""right"" class=""" + SelectedText + """><a href=""JavaScript: newWindow = window.open( '../Inventory/Product_FormularUse.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&SelMonth=" + Request.QueryString("SelMonth").ToString + "&SelYear=" + Request.QueryString("SelYear") + "&ProductLevelID=" + Request.QueryString("ProductLevelID").ToString + "', '', 'width=750,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(dtTable.Rows(i)("NetFormularUse"),"##,##0") & "</a></td>"
					outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(RealUse,"##,##0.0000") & "</td>"
					If Not IsDBNull(dtTable.Rows(i)("MaterialStdPricePerUnit")) Then
						If (dtTable.Rows(i)("MaterialStdPricePerUnit")*1000) < 1 And dtTable.Rows(i)("MaterialStdPricePerUnit") <> 0 Then
							outputString += "<td align=""right"" class=""" + SelectedText + """><a href=""JavaScript: newWindow = window.open( '../Inventory/Product_StdCost.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&SelMonth=" + Request.QueryString("SelMonth").ToString + "&SelYear=" + Request.QueryString("SelYear") + "&ProductLevelID=" + Request.QueryString("ProductLevelID").ToString + "', '', 'width=750,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & Format(dtTable.Rows(i)("MaterialStdPricePerUnit"),"E4") & "</a></td>"
						Else
							outputString += "<td align=""right"" class=""" + SelectedText + """><a href=""JavaScript: newWindow = window.open( '../Inventory/Product_StdCost.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&SelMonth=" + Request.QueryString("SelMonth").ToString + "&SelYear=" + Request.QueryString("SelYear") + "&ProductLevelID=" + Request.QueryString("ProductLevelID").ToString + "', '', 'width=750,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & Format(dtTable.Rows(i)("MaterialStdPricePerUnit"),"##,##0.0000") & "</a></td>"
						End If
						outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(RealUse*dtTable.Rows(i)("MaterialStdPricePerUnit"),"##,##0.0000") & "</td>"
						outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("TotalAmount"),"##,##0") & "</td>"
						outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(RealUse*dtTable.Rows(i)("MaterialStdPricePerUnit")/dtTable.Rows(i)("TotalAmount"),"##,##0.0000") & "</td>"

						TotalCost += RealUse*dtTable.Rows(i)("MaterialStdPricePerUnit")/dtTable.Rows(i)("TotalAmount")
					Else
						outputString += "<td align=""right"" class=""" + SelectedText + """>" & "N/A" & "</td>"
						outputString += "<td align=""right"" class=""" + SelectedText + """>" & "N/A" & "</td>"
						outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("TotalAmount"),"##,##0") & "</td>"
						outputString += "<td align=""right"" class=""" + SelectedText + """>" & "N/A" & "</td>"
					End If

				Next
				SelectedText = "text"

				outputString += "<tr bgColor=""" + GlobalParam.GrayBGColor + """><td colspan=""10"" align=""right"" class=""boldText"">Total</td>"
				outputString += "<td align=""right"" class=""boldText"">" & Format(TotalCost,"##,##0.0000") & "</td></tr>"
				
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
