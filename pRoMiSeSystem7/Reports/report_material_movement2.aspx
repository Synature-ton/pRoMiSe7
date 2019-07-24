<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="QAReports" %>
<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<html>
<head>
<title>Report Material Document</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">

<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<form runat="server">
<input type="hidden" id="MaterialID" runat="server">
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
Dim getInfo As New CCategory()
Dim getPageText As New DefaultText()
Dim FormatHeader As New FormatText()
Dim DateTimeUtil As New MyDateTime()
Dim getReport As New StReports()
Dim objDB As New CDBUtil()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated Then
	  
	  If NOT Request.QueryString("MaterialID") AND IsNumeric(Request.QueryString("MaterialID")) Then
	  	
		'Try
		
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

			GoBackText.InnerHtml = "<a href=""javascript: window.print()"">Print this Page</a> | <a href=""javascript: window.close()"">Close Window</a>"
			
			
			Text1.InnerHtml = ""
			Text2.InnerHtml = "Document No.<br>Document Name"
			Text9.InnerHtml = "Inputed By<br>Approved By"
			Text3.InnerHtml = "Document Date"
			Text4.InnerHtml = "Vendor Name"
			Text5.InnerHtml = "Qty"
			Text6.InnerHtml = "Qty<br>(Unit Small)"
			Text7.InnerHtml = "Balance<br>(Unit Small)"
			Text8.InnerHtml = "Balance"
			
			Dim UnitInfo As DataTable
        	Dim dtTable As New DataTable()
        	dtTable = getReport.MaterialMovement(Request.QueryString("ProductLevelID"),MaterialID.Value,Request.QueryString("StartDate"),Request.QueryString("EndDate"), Request.QueryString("SelMonth"),Request.QueryString("SelYear"), Session("LangID"), objCnn)	
			
			Dim DocGroupName As String = "Movement"
			
			Dim i,j As Integer
			Dim outputString As String = ""
			Dim ReportDate As String
			Dim SelectedText As String = "smallText"
			Dim DocHeader As String
			Dim TotalCost As Double = 0
			Dim TotalQty As Double = 0
			Dim TotalQtyUnit As Double = 0
			Dim TotalQtyUnitR As Double = 0
			Dim UnitString As String
			Dim UnitRatioString As String = ""
			Dim UnitRatioValue As String = ""
			Dim StaffString As String

			Dim UnitText As String
			Dim UnitRatioVal As Double = 1
			
			If dtTable.Rows.Count > 0 Then
				'Dim SDate As New Date(Request.QueryString("SelYear"),Request.QueryString("SelMonth"),1)
				'ReportDate = Format(SDate,"MMMM yyyy")
				HeaderText.InnerHtml = DocGroupName + " of " + dtTable.Rows(0)("MaterialName") + " for " + Request.QueryString("ReportDate")
				UnitInfo = getInfo.GetUnitInfo(2,dtTable.Rows(0)("UnitSmallID"),objCnn)
				For j = UnitInfo.Rows.Count - 1 To 0 Step -1
					If UnitInfo.Rows(j)("UnitSmallRatio") > 1 Then
						If j = 0 Then
							UnitRatioString += UnitInfo.Rows(j)("UnitLargeName")
							UnitRatioValue += (UnitInfo.Rows(j)("UnitSmallRatio")/UnitInfo.Rows(j-1)("UnitSmallRatio")).ToString
						Else
							UnitRatioString += UnitInfo.Rows(j)("UnitLargeName") + ":"
							UnitRatioValue += (UnitInfo.Rows(j)("UnitSmallRatio")/UnitInfo.Rows(j-1)("UnitSmallRatio")).ToString + ":"
						End If
					Else
						If j = 0 Then
							UnitRatioString += UnitInfo.Rows(j)("UnitSmallName")
							UnitRatioValue += UnitInfo.Rows(j)("UnitSmallRatio").ToString
						Else
							UnitRatioString += UnitInfo.Rows(j)("UnitSmallName") + ":"
							UnitRatioValue += UnitInfo.Rows(j)("UnitSmallRatio").ToString + ":"
						End If
					End If
				Next
				
				UnitRatioVal = 1
				UnitText = dtTable.Rows(0)("UnitSmallName")
				UnitInfo = getInfo.GetUnitSetting(dtTable.Rows(0)("MaterialID"),dtTable.Rows(0)("UnitSmallID"),objCnn)
				If UnitInfo.Rows.Count <> 0 Then
					UnitRatioVal = UnitInfo.Rows(0)("UnitSmallRatio")
					UnitText = UnitInfo.Rows(0)("UnitLargeName")
				End If
				
				For i = 0 To dtTable.Rows.Count - 1
					UnitString = ""
					StaffString = ""
					DocHeader = FormatHeader.DocumentNumber(dtTable.Rows(i)("ShopID"),dtTable.Rows(i)("DocumentTypeID"),dtTable.Rows(i)("DocumentID"),Session("LangID"), GlobalParam.YearType, objCnn)
					outputString += "<tr><td align=""center"" class=""" + SelectedText + """>" & (i+1).ToString & "</td>"
					outputString += "<td align=""left"" class=""" + SelectedText + """><a class=""" + SelectedText + """ href=""JavaScript: newWindow = window.open( '../Inventory/document_detail.aspx?MaterialID=" + Request.QueryString("MaterialID").ToString + "&SelMonth=" & Request.QueryString("SelMonth").ToString & "&SelYear=" & Request.QueryString("SelYear").ToString & "&DocumentID=" & dtTable.Rows(i)("DocumentID").ToString & "&ShopID=" & dtTable.Rows(i)("ShopID").ToString & "&ProductLevelID=" & Request.QueryString("ProductLevelID").ToString + "', '', 'width=800,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & DocHeader & "</a><br>" + dtTable.Rows(i)("DocumentTypeName") +  "</td>"
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
					outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("ProductAmount"),"##,##0.00") & " " & dtTable.Rows(i)("UnitName") & "</td>"
					outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("MovementInStock")*dtTable.Rows(i)("UnitSmallAmount"),"##,##0.00") & " " & dtTable.Rows(i)("UnitSmallName") & "</td>"
					
					TotalQty += dtTable.Rows(i)("UnitSmallAmount")*dtTable.Rows(i)("MovementInStock")
					
					outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(TotalQty,"##,##0.00") & " " & dtTable.Rows(i)("UnitSmallName") & "</td>"
					TotalQtyUnitR = TotalQty
					'For j = UnitInfo.Rows.Count - 1 To 0 Step -1
						'If UnitInfo.Rows(j)("UnitSmallRatio") > 1 Then
							'TotalQtyUnit =  TotalQtyUnitR \ UnitInfo.Rows(j)("UnitSmallRatio")
							'If TotalQtyUnit <> 0 Then
								'If UnitString <> "" Then
									'UnitString += " "
								'End If
								'UnitString += TotalQtyUnit.ToString + " " + UnitInfo.Rows(j)("UnitLargeName")
							'End If
						'Else
							'TotalQtyUnit =  TotalQtyUnitR \ UnitInfo.Rows(j)("UnitSmallRatio")
							'If TotalQtyUnit <> 0 Then
								'If UnitString <> "" Then
									'UnitString += " "
								'End If
								'UnitString += TotalQtyUnit.ToString + " " + UnitInfo.Rows(j)("UnitSmallName")
							'End If
						'End If
						'TotalQtyUnitR = TotalQtyUnitR mod UnitInfo.Rows(j)("UnitSmallRatio")
					'Next
					'outputString += "<td align=""right"" class=""" + SelectedText + """>" & UnitString & "</td>"
					
					outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(TotalQty/UnitRatioVal,"##,##0.00") & " " & UnitText & "</td>"
					
				Next
				outputString += "<tr><td colspan=""9"" align=""right"" class=""" + SelectedText + """>" + UnitRatioString + " = " + UnitRatioValue + "</td></tr>"
				ResultText.InnerHtml = outputString
			Else
				updateMessage.Text = "No Data"
			End If
		'Catch ex As Exception
			'errorMsg.InnerHtml = ex.Message
		'End Try
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
