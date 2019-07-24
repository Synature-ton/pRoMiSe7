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
<html>
<head>
<title>Print Bill Details</title>
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
<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="Text1" runat="server"></div></td>
        <td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Text4" runat="server"></div></td>
	</tr>
	<div id="ResultText" runat="server"></div>
	
</table>
<div id="DisplayDelDetail" runat="server">
<table>
	<tr><td>&nbsp;</td></tr>
	<tr><td class="text"><asp:Label ID="DelItem" Text="Delete Products Details" runat="server" /></td></tr>
</table>
<table id="myTable1" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
	<tr>
		<td id="headerTD17" align="center" class="tdHeader" runat="server"><div id="Text17" runat="server"></div></td>
		<td id="headerTD18" align="center" class="tdHeader" runat="server"><div id="Text18" runat="server"></div></td>
		<td id="headerTD19" align="center" class="tdHeader" runat="server"><div id="Text19" runat="server"></div></td>
		<td id="headerTD20" align="center" class="tdHeader" runat="server"><div id="Text20" runat="server"></div></td>
		<td id="headerTD21" align="center" class="tdHeader" runat="server"><div id="Text21" runat="server"></div></td>
	</tr>
	<div id="DelProductDetails" runat="server"></div>
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
Dim getReport As New GenReports()
Dim getProp As New CPreferences()
Dim PageID As Integer = 15
		
Sub Page_Load()
	If User.Identity.IsAuthenticated AND IsNumeric(Request.QueryString("ComputerID")) AND IsNumeric(Request.QueryString("TransactionID")) Then
	  	objCnn = getCnn.EstablishConnection()	
		Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
		Dim LangData2 As DataTable = getProp.GetLangData(PageID,2,-1,Request)
		Dim LangText As String = "lang" + Session("LangID").ToString
	Dim FormatData As DataTable = Util.FormatParam(FormatObject,Session("LangID"),objCnn)
	Dim ci As New CultureInfo(FormatObject.CultureString)
		PrintText.Text = LangDefault.Rows(20)(LangText)
		CloseText.Text = LangDefault.Rows(21)(LangText)
				
		headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor
		
		headerTD17.BgColor = GlobalParam.AdminBGColor
		headerTD18.BgColor = GlobalParam.AdminBGColor
		headerTD19.BgColor = GlobalParam.AdminBGColor
		headerTD20.BgColor = GlobalParam.AdminBGColor
		headerTD21.BgColor = GlobalParam.AdminBGColor
			
		Try		
			Dim AdditionalHeaderText As String = ""		

			Text1.InnerHtml = ""
			Text5.InnerHtml = LangData2.Rows(1)(LangText)
			Text2.InnerHtml = LangData2.Rows(12)(LangText)
			Text3.InnerHtml = LangData2.Rows(13)(LangText)
			Text4.InnerHtml = LangData2.Rows(14)(LangText)
			
			Text17.InnerHtml = ""
			Text18.InnerHtml = LangData2.Rows(15)(LangText)
			Text19.InnerHtml = LangData2.Rows(16)(LangText)
			Text20.InnerHtml = LangData2.Rows(17)(LangText)
			Text21.InnerHtml = LangData2.Rows(18)(LangText)
			DelItem.Text = LangData2.Rows(19)(LangText)
			
			If Not Page.IsPostBack Then

			
				Dim i,counter As integer
				Dim outputString As String = ""
				counter = 1
				

				Dim outString As String = ""
				Dim bgColor1 As String
				Dim dtTable As DataTable 
				
				Dim bgColor As String

				dtTable = getReport.PrintBillDetail(Request.QueryString("TransactionID"), Request.QueryString("ComputerID"), objCnn)
				counter = 1
				bgColor = "e9e9e9"
				For i=0 To dtTable.Rows.Count - 1
					If bgColor = "white" Then
						bgColor = "e9e9e9"
					Else
						bgColor = "white"
					End If
	
					outputString += "<tr bgcolor=""" + bgColor + """><td align=""center"" class=""text"">" & counter.ToString & "</td>"
					
					If dtTable.Rows(i)("FrontFunctionID") = 3 Then
						outputString += "<td align=""center"" class=""" + "text" + """>" + LangData2.Rows(9)(LangText) + "</td>"
					Else
						outputString += "<td align=""center"" class=""" + "text" + """>" + LangData2.Rows(10)(LangText) + "</td>"
					End If
			
					outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("PrintStaffName") & "</td>"
					outputString += "<td align=""right"" class=""text"">" & DateTimeUtil.FormatDateTime(dtTable.Rows(i)("PrintDateTime"),"DateAndTime", Session("LangID"), objCnn) & "</td>"
					If Not IsDBNull(dtTable.Rows(i)("HistoryNote")) Then
						outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("HistoryNote") & "</td>"
					Else
						outputString += "<td align=""left"" class=""text"">" & "-" & "</td>"
					End If
					outputString += "</tr>"
					counter = counter + 1
				Next
				ResultText.InnerHtml = outputString
				
				dtTable = getReport.DelProductReports(0, "", "", 0, Request.QueryString("TransactionID"), Request.QueryString("ComputerID"), Session("LangID"), objCnn)
				outputString = ""
				bgColor = "e9e9e9"
				counter = 1
				For i=0 To dtTable.Rows.Count - 1
					If bgColor = "white" Then
						bgColor = "e9e9e9"
					Else
						bgColor = "white"
					End If
	
					outputString += "<tr bgcolor=""" + bgColor + """><td align=""center"" class=""text"">" & counter.ToString & "</td>"
					outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("DelStaffName") & "</td>"
					outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("ProductName") & "</td>"
					outputString += "<td align=""right"" class=""text"">" & Format(dtTable.Rows(i)("ProductPrice"),"##,##0.00") & "</td>"
					outputString += "<td align=""right"" class=""text"">" & DateTimeUtil.FormatDateTime(dtTable.Rows(i)("ChangeDateTime"),"DateAndTime") & "</td>"
		
					outputString += "</tr>"
					counter = counter + 1
				Next
				If dtTable.Rows.Count > 0 Then
					DisplayDelDetail.Visible = True
					DelProductDetails.InnerHtml = outputString
				Else
					DisplayDelDetail.Visible = False
				End If	
				
				
			End If

		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try

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
