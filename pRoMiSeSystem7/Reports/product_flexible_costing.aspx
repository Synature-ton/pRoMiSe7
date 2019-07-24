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
<title>Product Flexible Costing</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">

<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<form id="mainForm" runat="server">
<input type="hidden" id="ProductID" runat="server">
<table cellpadding="2" cellspacing="2" width="100%">
<tr>
<td align="left"><div class="headerText" align="left" id="HeaderText" runat="server" /></td>
<td align="right">&nbsp;</td>
</tr>
<tr><td height="5" colspan="2"></td></tr>
<tr id="showMsg" visible="false" runat="server"><td colspan="2"><span id="periodText" class="text" runat="server"></span></td></tr>
<tr><td><div id="CostText" class="text" runat="server"></div></td>
<td align="right"><div class="text" id="GoBackText" runat="server"></div></td></tr>
<tr><td height="5" colspan="2"></td></tr>
<span id="showGroupSel" visible="false" runat="server">
	<tr><td colspan="2" align="right"><span id="GroupSelection" runat="server"></span></td></tr>
</span>

</table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="OrderText" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="CodeText" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="NameText" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="TotalAmountText" runat="server"></div></td>
		<td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="TotalSoldText" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="AmountText" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="UnitText" runat="server"></div></td>
		<td id="headerTD8" align="center" class="tdHeader" runat="server"><div id="CostPerUnitText" runat="server"></div></td>
		<td id="headerTD9" align="center" class="tdHeader" runat="server"><div id="TotalCostText" runat="server"></div></td>
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
	  	

		ProductID.Value = Request.QueryString("ProductID")
		
		headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor
		headerTD6.BgColor = GlobalParam.AdminBGColor
		headerTD7.BgColor = GlobalParam.AdminBGColor
		headerTD8.BgColor = GlobalParam.AdminBGColor
		headerTD9.BgColor = GlobalParam.AdminBGColor
		If Session("Material_Cost") = False Then
			headerTD8.Visible = False
			headerTD9.Visible = False
		End If
		
		
			
		Try
			objCnn = getCnn.EstablishConnection()

        	Dim dtTable As New DataTable()
        	dtTable = getInfo.GetProductInfo(0,Request.QueryString("ProductID"), objCnn)	
			
			Dim StartTransactionID,EndTransactionID As Integer
			Dim StartDateString,EndDateString As String

			Dim costValue As Double = 0
				
			If dtTable.Rows.Count <> 0 Then
			
				Dim textTable As New DataTable()
				textTable = getPageText.GetText(8,Session("LangID"),objCnn)

				Dim componentTable As New DataTable()
				Application.Lock()
				componentTable = getReport.ProductFlexibleUnitCost(Request.QueryString("ProductLevelID"),Request.QueryString("ProductID"), Request.QueryString("SelMonth"),Request.QueryString("SelYear"), Session.SessionID,objCnn)
				Application.UnLock()


				StartDateString = "-"
				
				EndDateString = textTable.Rows(49)("TextParamValue")

				showMsg.Visible = True

					
				Dim defaultTextTable As New DataTable()
				defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)

				GoBackText.InnerHtml = "<a href=""javascript: window.close()"">Close Window</a>"
				
				HeaderText.InnerHtml = textTable.Rows(0)("TextParamValue") + dtTable.Rows(0)("ProductName")
				OrderText.InnerHtml = textTable.Rows(1)("TextParamValue")
				CodeText.InnerHtml = textTable.Rows(2)("TextParamValue")
				NameText.InnerHtml = textTable.Rows(3)("TextParamValue")
				AmountText.InnerHtml = textTable.Rows(4)("TextParamValue")
				UnitText.InnerHtml = textTable.Rows(5)("TextParamValue")
				TotalCostText.InnerHtml = textTable.Rows(18)("TextParamValue") + " (" + defaultTextTable.Rows(10)("TextParamValue") + ")"
				CostPerUnitText.InnerHtml = "Price/Unit"
				TotalAmountText.InnerHtml = "Amount Selected"
				TotalSoldText.InnerHtml = "Total Sold"
						
				
				Dim i,counter As integer
				Dim outputString As String = ""
				
				Dim UnitIDValue As Integer = 0
				Dim FormSelected As String
				Dim SelectedText As String = "text"
				Dim SelectedMaterialID As String = 0
				Dim SelectedMaterialAmount As String
				Dim SelectedShowOnOrder As Boolean
				counter = 1
				For i=0 To componentTable.Rows.Count - 1


					outputString += "<tr><td align=""center"" class=""" + SelectedText + """>" & counter.ToString & "</td>"
					outputString += "<td align=""left"" class=""" + SelectedText + """>" & componentTable.Rows(i)("MaterialCode") & "</td>"
					outputString += "<td align=""left"" class=""" + SelectedText + """>" & componentTable.Rows(i)("MaterialName") & "</td>"
					outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(componentTable.Rows(i)("TotalMaterialAmount"),"##,##0") & "</td>"
					outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(componentTable.Rows(i)("TotalSold"),"##,##0") & "</td>"
					outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(componentTable.Rows(i)("MaterialAmount"),"##,##0.0000") & "</td>"
					outputString += "<td align=""left"" class=""" + SelectedText + """>" & componentTable.Rows(i)("UnitSmallName") & "</td>"
					If headerTD8.Visible = True Then
						If Not IsDBNull(componentTable.Rows(i)("TotalPrice")) AND Not IsDBNull(componentTable.Rows(i)("TotalAmount")) Then
						  If (componentTable.Rows(i)("TotalPrice")*1000)/componentTable.Rows(i)("TotalAmount") < 1 And (componentTable.Rows(i)("TotalPrice")*1000)/componentTable.Rows(i)("TotalAmount") <> 0 Then
						  	outputString += "<td align=""right"" class=""" + SelectedText + """><a href=""JavaScript: newWindow = window.open( '../Inventory/product_stdcost.aspx?MaterialID=" + componentTable.Rows(i)("MaterialID").ToString + "&SelMonth=" & Request.QueryString("SelMonth").ToString & "&SelYear=" & Request.QueryString("SelYear").ToString & "&ProductLevelID=" & Request.QueryString("ProductLevelID").ToString + "', '', 'width=800,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & Format((componentTable.Rows(i)("TotalPrice"))/componentTable.Rows(i)("TotalAmount"),"E4") & "</a></td>"
						  Else
							outputString += "<td align=""right"" class=""" + SelectedText + """><a href=""JavaScript: newWindow = window.open( '../Inventory/product_stdcost.aspx?MaterialID=" + componentTable.Rows(i)("MaterialID").ToString + "&SelMonth=" & Request.QueryString("SelMonth").ToString & "&SelYear=" & Request.QueryString("SelYear").ToString & "&ProductLevelID=" & Request.QueryString("ProductLevelID").ToString + "', '', 'width=800,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & Format((componentTable.Rows(i)("TotalPrice"))/componentTable.Rows(i)("TotalAmount"),"##,##0.0000") & "</a></td>"
						  End If
							
						Else
							outputString += "<td align=""right"" class=""" + SelectedText + """>" & "N/A" & "</td>"
						End If
					End If
					If headerTD9.Visible = True Then
						If Not IsDBNull(componentTable.Rows(i)("TotalPrice")) AND Not IsDBNull(componentTable.Rows(i)("TotalAmount")) Then
							outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format((componentTable.Rows(i)("TotalPrice")*componentTable.Rows(i)("MaterialAmount"))/componentTable.Rows(i)("TotalAmount"),"##,##0.0000") & "</td>"
							costValue += (componentTable.Rows(i)("TotalPrice")*componentTable.Rows(i)("MaterialAmount"))/componentTable.Rows(i)("TotalAmount")
						Else
							outputString += "<td align=""right"" class=""" + SelectedText + """>" & "N/A" & "</td>"
						End If
					End If
					
					
					outputString += "</tr>"
					counter = counter + 1

				Next
				Dim costTextValue As String = "0"
				If costValue > 0 Then
					costTextValue = Format(costValue, "##,##0.0000")
				End If
				
				outputString += "<tr bgColor=""" + GlobalParam.GrayBGColor + """><td colspan=""8"" align=""right"" class=""boldText"">Total</td>"
				outputString += "<td align=""right"" class=""boldText"">" & costTextValue & "</td></tr>"
				
				ResultText.InnerHtml = outputString
				
				
				
				If Session("Material_Cost") = True Then
					CostText.InnerHtml = textTable.Rows(16)("TextParamValue") + " " + dtTable.Rows(0)("ProductName") + " " + textTable.Rows(17)("TextParamValue") + " " + costTextValue + " " + defaultTextTable.Rows(10)("TextParamValue")
				End If	
				
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
