<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="ReportModule" %>

<html>
<head>
<title>Manage Document Header</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">
<form id="mainForm" runat="server">
<table width="95%">
	<tr>
	<td width="50%" class="text"><div id="showHeaderText" class="headerText" runat="server"></div></td>
	<td width="50%" align="right"><a href="javascript: window.close()">Close</a></td>
	</tr>
</table>
<div id="ValidateSaveData" class="requireText" runat="server"></div>
<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="95%">
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="OrderText" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="Text6" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>
	
</table></form>
<div id="errorMsg" runat="server" />

<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim cls As New CCategory()
Dim objDB As New CDBUtil()
Dim getProp As New CPreferences()
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated AND IsNumeric(Request.QueryString("CashMovement")) AND IsNumeric(Request.QueryString("SessionID")) AND IsNumeric(Request.QueryString("ComputerID")) Then
	
		
		headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor
		headerTD6.BgColor = GlobalParam.AdminBGColor
		headerTD7.BgColor = GlobalParam.AdminBGColor
		Try
			objCnn = getCnn.EstablishConnection()
			
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(11,Session("LangID"),objCnn)
			
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			OrderText.InnerHtml = textTable.Rows(31)("TextParamValue")
			If Request.QueryString("CashMovement") = 1 Then
				Text1.InnerHtml = "Cash In"
				showHeaderText.InnerHtml = "Cash In Details"
			Else
				Text1.InnerHtml = "Cash  Out"
				showHeaderText.InnerHtml = "Cash Out Details"
			End If
			Text2.InnerHtml = "Reference"
			Text3.InnerHtml = "Remark"
			Text4.InnerHtml = "Staff Name"
			Text5.InnerHtml = "Date"
			Text6.InnerHtml = "Amount"

			Dim DisableText As String = "disabled"
			
			Dim i As Integer
			Dim FormSelected,SelectedText,FormValue As String
			
			Dim IDValueFromDB As Integer
			Dim counter As Integer = 1
			Dim AccessIDList As String = ""
			Dim TotalPrice As Double = 0
			Dim GetDataInfo As New DataTable()
			Dim StartDate AS String = ""
			Dim EndDate As String = ""
			If Trim(Request.QueryString("StartDate")) <> "" Then
				StartDate = Request.QueryString("StartDate")
			End If
			If Trim(Request.QueryString("EndDate")) <> "" Then
				EndDate = Request.QueryString("EndDate")
			End If
			GetDataInfo = getReport.CashInOutDetails(Request.QueryString("SessionID"),Request.QueryString("ComputerID"),Request.QueryString("CashMovement"),StartDate,EndDate,objCnn)
			SelectedText = "text"
			Dim outputString As String = ""
			For i = 0 to GetDataInfo.Rows.Count - 1

				outputString += "<tr><td align=""center"" class=""" + SelectedText + """>" & counter.ToString & "</td>"
				outputString += "<td align=""left"" class=""" + SelectedText + """>" & getDataInfo.Rows(i)("ProductName") & "</td>"
				If Not IsDBNull(getDataInfo.Rows(i)("CashOutReference")) Then
					outputString += "<td align=""left"" class=""" + SelectedText + """>" & getDataInfo.Rows(i)("CashOutReference") & "</td>"
				Else
					outputString += "<td align=""left"" class=""" + SelectedText + """>" & "&nbsp;" & "</td>"
				End If
				If Not IsDBNull(getDataInfo.Rows(i)("TransactionNote")) Then
					outputString += "<td align=""left"" class=""" + SelectedText + """>" & getDataInfo.Rows(i)("TransactionNote") & "</td>"
				Else
					outputString += "<td align=""left"" class=""" + SelectedText + """>" & "&nbsp;" & "</td>"
				End If
				If Not IsDBNull(getDataInfo.Rows(i)("StaffFirstName")) AND Not IsDBNull(getDataInfo.Rows(i)("StaffLastName")) Then
					outputString += "<td align=""left"" class=""" + SelectedText + """>" & getDataInfo.Rows(i)("StaffFirstName") & " " & getDataInfo.Rows(i)("StaffLastName") & "</td>"
				Else
					outputString += "<td align=""left"" class=""" + SelectedText + """>" & "&nbsp;" & "</td>"
				End If
				If Not IsDBNull(getDataInfo.Rows(i)("CashOutDateTime")) Then
					
					'outputString += "<td align=""left"" class=""" + SelectedText + """>" & Format(getDataInfo.Rows(i)("CashOutDateTime"), "dd MMMM yyyy HH:mm:ss") & "</td>"
					outputString += "<td align=""left"" class=""" + SelectedText + """>" & DateTimeUtil.FormatDateTime(getDataInfo.Rows(i)("CashOutDateTime"), "DateAndTime", Session("LangID"), objCnn) & "</td>"
				Else
					outputString += "<td align=""left"" class=""" + SelectedText + """>" & "&nbsp;" & "</td>"
				End If
				outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(getDataInfo.Rows(i)("CashOutPrice"),"##,##0.00;(##,##0.00)") & "</td>"

				outputString += "</tr>"
				counter = counter + 1
				TotalPrice += getDataInfo.Rows(i)("CashOutPrice")
			Next
			outputString += "<tr><td align=""right"" class=""" + SelectedText + """ colspan=""6"">" & "Summary" & "</td>"
			outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(TotalPrice,"##,##0.00;(##,##0.00)") & "</td>"
			outputString += "</tr>"
			ResultText.InnerHtml = outputString

			
		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
	Else
		errorMsg.InnerHtml = "Access Denied"
	End If
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
