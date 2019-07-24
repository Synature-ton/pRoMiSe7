<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@ Register tagPrefix="Web" Namespace="WebChart" Assembly="WebChart" %>
<%@ Import Namespace="System.Drawing" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="MySQL5DBClass.POSControl" %>
<%@Import Namespace="MySQL5DBClass.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="ReportModuleMySQL5" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Member No Age Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body<% = GlobalParam.BodyProp %>>
<div id="showPage" visible="true" runat="server">
<form runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />

<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">

<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><b class="headerText"><div class="headerText" align="left" id="HeaderText" runat="server"></div></b></div>
	</td>
	<td width="1" nowrap rowspan="99" bgcolor="003366"><img src="../images/clear.gif" height="1" width="1"></td>
</tr>
<tr bgcolor="666666">
	<td width="3%" height="1"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	<td width="94%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="252"></p></td>
	<td width="3%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	
</tr>
<tr><td colspan="3" class="smalltext" align="right"><span id="DBText" class="smalltext" runat="server" /></td></tr>

<tr>
<td>&nbsp;</td>
<td>
<span id="showResults" runat="server">
<table width="100%">
<div class="noprint">
<tr id="ShowPrint" visible="True" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a><span class="smalltext"> (NOTE: Updated data will be effected after data have been updated to database report in the next day)</span></div></td>
</tr>
</div>
<tr>
	<td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td>
</tr>
<tr><td>
<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">

	<span id="TableHeaderText" runat="server"></span>
	<span id="ExtraHeader" runat="server"></span>

	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>
</table></td></tr>
</table>
</span>
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
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getReport As New stReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("MemberTopSpender") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")

		showResults.Visible = True
		
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(13,Session("LangID"),objCnn)
		Dim textTable1 As New DataTable()
		textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
		
		Dim GetReportLog As DataTable = getReport.ReportLog(objCnn)
		If GetReportLog.Rows.Count > 0 Then
			DBText.InnerHtml = "Report Database: " + Format(GetReportLog.Rows(0)("LogDateTime"), "dd MMMM yyyy HH:mm:ss") + "&nbsp;&nbsp;"
		Else
			DBText.InnerHtml = "Report Database&nbsp;&nbsp;"
		End If
		
		HeaderText.InnerHtml = "Member No BirthDay Report"
		
		Dim dtTable As DataTable = getReport.MemberNoAgeReports(1,Request.QueryString("StartDate"),Request.QueryString("EndDate"),Request.QueryString("ShopList"),Request.QueryString("MemberID"), Session("LangID"), objCnn)
		
		Dim HeaderString As String
		HeaderString += "<tr>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>#</td>"		
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Member Code</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Member Name</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Birth Day</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Edit</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>Amount</td>"
		HeaderString += "</tr>"
		
		TableHeaderText.InnerHtml = HeaderString
		Dim i As Integer
		Dim outputString As StringBuilder = New StringBuilder
		Dim TotalPaid As Double = 0
		For i = 0 To dtTable.Rows.Count - 1
			outputString = outputString.Append("<tr>")
			outputString = outputString.Append("<td class=""smallText"" align=""center"">" + (i+1).ToString + "</td>")
			outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MemberCode") + "</td>")
			outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MemberFullName") + "</td>")
			If Not IsDBNull(dtTable.Rows(i)("MemberBirthDay")) Then
				outputString = outputString.Append("<td class=""smallText"" align=""left"">" + DateTimeUtil.FormatDateTime(dtTable.Rows(i)("MemberBirthDay"),"DateOnly") + "</td>")
			Else
				outputString = outputString.Append("<td class=""smallText"" align=""left"">" + "-" + "</td>")
			End If

			outputString = outputString.Append("<td class=""smallText"" align=""center"">" + "<a href=""JavaScript: newWindow = window.open( '../Members/member_info_edit.aspx?MemberID=" & dtTable.Rows(i)("MemberID") & "', '', 'width=950,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Edit" + "</a></td>")

			outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(dtTable.Rows(i)("TotalPaid"),"##,##0.00;(##,##0.00)")  + "</td>")
			TotalPaid += dtTable.Rows(i)("TotalPaid")
		Next
		
		Dim ColSpan As Integer = 5
		outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
		outputString = outputString.Append("<td class=""smallText"" align=""right"" colspan=""" + ColSpan.ToString + """>Total</td>")
		outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(TotalPaid,"##,##0.00;(##,##0.00)") + "</td>")
		outputString = outputString.Append("</tr>")
		
		ResultText.InnerHtml = outputString.ToString
		
		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
	  
	Else
		showPage.Visible = False
		errorMsg.InnerHtml = "Access Denied"
	End If
End Sub
	
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
