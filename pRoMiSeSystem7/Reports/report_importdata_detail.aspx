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
<input type="hidden" id="ProductLevelID" runat="server">
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
Dim rpt As New GenReports()
Dim objDB As New CDBUtil()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated Then
	  
	  If NOT Request.QueryString("FromShopID") AND IsNumeric(Request.QueryString("FromShopID")) Then
	  	
		'Try
		
			objCnn = getCnn.EstablishConnection()
				
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
			ProductLevelID.Value = Request.QueryString("ProductLevelID")
			
			headerTD1.BgColor = GlobalParam.AdminBGColor
			headerTD2.BgColor = GlobalParam.AdminBGColor
			headerTD3.BgColor = GlobalParam.AdminBGColor
			headerTD4.BgColor = GlobalParam.AdminBGColor
			headerTD5.BgColor = GlobalParam.AdminBGColor
			headerTD6.BgColor = GlobalParam.AdminBGColor
			headerTD7.BgColor = GlobalParam.AdminBGColor
			headerTD8.BgColor = GlobalParam.AdminBGColor
			headerTD9.BgColor = GlobalParam.AdminBGColor
			
			headerTD6.Visible = True
			headerTD7.Visible = True
			headerTD8.Visible = False

			GoBackText.InnerHtml = "<a href=""javascript: window.print()"">Print this Page</a> | <a href=""javascript: window.close()"">Close Window</a>"
			
			
			Text1.InnerHtml = ""
			Text2.InnerHtml = "From Shop"
			Text9.InnerHtml = "To Shop"
			Text3.InnerHtml = "Data Type"
			Text4.InnerHtml = "File Name"
			Text5.InnerHtml = "Export Time"
			Text6.InnerHtml = "Import Time"
			Text7.InnerHtml = "Status"
			Text8.InnerHtml = ""
				
        	Dim dtTable As New DataTable()
        	dtTable = rpt.TransferDataLogDetail(Request.QueryString("FromShopID"),Request.QueryString("ToShopID"),Request.QueryString("StartDate"),Request.QueryString("EndDate"), Request.QueryString("DataType"),"",1, objCnn)	
			
			Dim DataDetail As DataTable
			
			Dim i As Integer
			Dim outputString As String = ""
			Dim ReportDate As String
			Dim SelectedText As String = "smallText"
			Dim DocHeader As String
			Dim TotalCost As Double = 0
			Dim TotalQty As Double = 0
			Dim StaffString As String
			If dtTable.Rows.Count > 0 Then

				HeaderText.InnerHtml = "Transfer Data Log Detail" 
				For i = 0 To dtTable.Rows.Count - 1

					outputString += "<tr><td align=""center"" class=""" + SelectedText + """>" & (i+1).ToString & "</td>"
					If Not IsDBNull(dtTable.Rows(i)("FromShopName")) Then
						outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("FromShopName") & "</td>"
					Else
						outputString += "<td align=""left"" class=""" + SelectedText + """>" & "-" & "</td>"
					End If
					If Not IsDBNull(dtTable.Rows(i)("ToShopName")) Then
						outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("ToShopName") & "</td>"
					Else
						outputString += "<td align=""left"" class=""" + SelectedText + """>" & "-" & "</td>"
					End If
					
					If Not IsDBNull(dtTable.Rows(i)("DataTypeName")) Then
						outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("DataTypeName") & "</td>"
					Else
						outputString += "<td align=""left"" class=""" + SelectedText + """>" & "-" & "</td>"
					End If
					
					If Not IsDBNull(dtTable.Rows(i)("FileName")) Then
						outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("FileName") & "</td>"
					Else
						outputString += "<td align=""left"" class=""" + SelectedText + """>" & "-" & "</td>"
					End If
					
					If Not IsDBNull(dtTable.Rows(i)("LogDateTime")) Then
						outputString += "<td align=""left"" class=""" + SelectedText + """>" & DateTimeUtil.FormatDateTime(dtTable.Rows(i)("LogDateTime"), "DateAndTime") & "</td>"
					Else
						outputString += "<td align=""left"" class=""" + SelectedText + """>" & "-" & "</td>"
					End If
					
					If Not IsDBNull(dtTable.Rows(i)("ImportDateTime")) Then
						outputString += "<td align=""left"" class=""" + SelectedText + """>" & DateTimeUtil.FormatDateTime(dtTable.Rows(i)("ImportDateTime"), "DateAndTime") & "</td>"
					Else
						outputString += "<td align=""left"" class=""" + SelectedText + """>" & "-" & "</td>"
					End If
					
					outputString += "<td align=""center"" class=""" + SelectedText + """>" & "Completed" & "</td>"
					
				Next
				
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
