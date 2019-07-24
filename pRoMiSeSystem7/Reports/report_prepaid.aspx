<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<html>
<head>
<title>Prepaid Report</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<ASP:Label id="updateMessage" CssClass="headerText" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><b class="headerText"><div class="headerText" align="left" id="SectionText" runat="server" /></b></div>
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
<form id="mainForm" runat="server">
<input type="hidden" name="SubmitFormSearch" value="yes">
<div class="noprint">
<table cellpadding="0" cellspacing="3">
<tr>
	<td class="text"><span id="CodeSearchText" class="text" runat="server"></span></td>
	<td><asp:textbox ID="MemberCode" Font-Size="10" Height="22" Width="150" runat="server" /></td>
	<td class="text"><span id="FirstNameSearchText" class="text" runat="server"></span></td>
	<td><asp:textbox ID="MemberFirstName" Font-Size="10" Height="22" Width="130" runat="server" /></td>
	<td class="text"><span id="TelSearchText" class="text" runat="server"></span></td>
	<td><asp:textbox ID="MemberTelephone" Font-Size="10" Height="22" Width="130" runat="server" /></td>
	<td>&nbsp;</td>
</tr>
<tr>
	<td class="text"><span id="GroupSearchText" class="text" runat="server"></span></td>
	<td><div id="GroupTextSelect" runat="server"></div></td>
	<td class="text"><span id="LastNameSearchText" class="text" runat="server"></span></td>
	<td><asp:textbox ID="MemberLastName" Font-Size="10" Height="22" Width="130" runat="server" /></td>
	<td class="text"><span id="MobileSearchText" class="text" runat="server"></span></td>
	<td><asp:textbox ID="MemberMobile" Font-Size="10" Height="22" Width="130" runat="server" /></td>
	<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="60" OnClick="DoSearch" runat="server" /></td>
</tr>

</table></div></form>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left" colspan="2"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
<tr><td colspan="2">
<table id="myTable" border="1" cellpadding="4" cellspacing="0" width="100%" style="border-collapse:collapse;">
	<tr>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="ActivationText" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="GroupText" runat="server"></div></td>
		<td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="CodeText" runat="server"></div></td>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="NameText" runat="server"></div></td>
		
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="Default_ViewText" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Default_EditText" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Default_DelText" runat="server"></div></td>
	</tr>
	<div id="ResultText" runat="server"></div>

</table></td></tr>
</table>
<div id="testMsg" runat="server"></div>

<div id="errorMsg" style="color:red;" runat="server" />
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
Dim getData As New CMembers()
Dim getPageText As New DefaultText()
Dim getReport As New GenReports()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Report_Prepaid") Then
	
		headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor
		headerTD6.BgColor = GlobalParam.AdminBGColor
		headerTD7.BgColor = GlobalParam.AdminBGColor
		
		Dim QueryStringList As String
		
		
		errorMsg.InnerHtml = ""
		
		
		Try
			objCnn = getCnn.EstablishConnection()
			Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
			

			If session("Member_Info_Edit") Then headerTD3.Visible = True
			
			
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(11,Session("LangID"),objCnn)
			
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			SectionText.InnerHtml = "Prepaid Card Information"
			
			NameText.InnerHtml = textTable.Rows(17)("TextParamValue")
			GroupText.InnerHtml = "Shop"
			CodeText.InnerHtml = textTable.Rows(19)("TextParamValue")

			ActivationText.InnerHtml = "CardID"
			Default_ViewText.InnerHtml = "Card Amount"
			Default_EditText.InnerHtml = "DB Amount"
			Default_DelText.InnerHtml = "Expire Date"
			
			CodeSearchText.InnerHtml = textTable.Rows(19)("TextParamValue")
			FirstNameSearchText.InnerHtml = defaultTextTable.Rows(16)("TextParamValue")
			LastNameSearchText.InnerHtml = defaultTextTable.Rows(17)("TextParamValue")
			GroupSearchText.InnerHtml = textTable.Rows(18)("TextParamValue")
			TelSearchText.InnerHtml = defaultTextTable.Rows(23)("TextParamValue")
			MobileSearchText.InnerHtml = defaultTextTable.Rows(27)("TextParamValue")
			SubmitForm.Text = defaultTextTable.Rows(92)("TextParamValue")
			
			Dim GroupIDValue As Integer = 0
			If IsNumeric(Request.Form("MemberGroupID")) Then
				GroupIDValue = Request.Form("MemberGroupID")
			Else If IsNumeric(Request.QueryString("MemberGroupID"))
				GroupIDValue = Request.QueryString("MemberGroupID")
			End If

			QueryStringList = "&MemberGroupID=" + GroupIDValue.ToString
			
			
			Dim GroupTable As New DataTable()
        	GroupTable = getData.GetMemberInfo(4,-1,-1,-1,"MemberGroupID",objCnn)
			Dim outputString,FormSelected As String
			Dim i As Integer
			Dim SelectString As String = textTable.Rows(11)("TextParamValue")
			outputString = "<select name=""MemberGroupID""><option value=""0"">" & SelectString
			If GroupIDValue = -1 Then
				outputString += "<option value=""-1"" selected>" + textTable.Rows(12)("TextParamValue")
			Else
				outputString += "<option value=""-1"">" + textTable.Rows(12)("TextParamValue")
			End If
			For i = 0 to GroupTable.Rows.Count - 1
				If GroupIDValue = GroupTable.Rows(i)("MemberGroupID") Then
					FormSelected = "selected"
				Else
					FormSelected = ""
				End If
				outputString += "<option value=""" & GroupTable.Rows(i)("MemberGroupID") & """ " & FormSelected & ">" & GroupTable.Rows(i)("MemberGroupName")
			Next
			GroupTextSelect.InnerHtml = outputString

		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
	Else
		updateMessage.Text = "Access Denied"
	End If
End Sub

Sub DoSearch(Source As Object, E As EventArgs)
	GenResult(Request.Form("MemberGroupID"),Request.Form("MemberCode"),Request.Form("MemberFirstName"),Request.Form("MemberLastName"),Request.Form("MemberTelephone"),Request.Form("MemberMobile"), objCnn)
	
End Sub

Public Function GenResult(ByVal MemberGroupID As String, ByVal MemberCode As String, ByVal MemberFirstName As String, ByVal MemberLastName As String, ByVal MemberTelephone As String, ByVal MemberMobile As String, ByVal objCnn As MySqlConnection) As String
	ShowPrint.Visible = True
	Dim dtTable As New DataTable()
	dtTable = getReport.SearchPrepaidMember(MemberGroupID,MemberCode,MemberFirstName,MemberLastName,MemberTelephone,MemberMobile, "", objCnn)
	
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(11,Session("LangID"),objCnn)
	
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
	Dim sumTotalCurrent As Double = 0
	Dim sumTotalDB As Double = 0
	Dim i As integer
	Dim outputString As String = ""
	Dim MTel As String
	For i = 0 to dtTable.Rows.Count - 1

		outputString += "<tr>"
		outputString += "<td align=""center"" class=""text"">" + dtTable.Rows(i)("CardID").ToString + "</td>"
		
		If Not IsDBNull(dtTable.Rows(i)("ProductLevelName")) Then
			outputString += "<td class=""text"" align=""left"">" + dtTable.Rows(i)("ProductLevelName") + "</td>"
		Else
			outputString += "<td class=""text"" align=""left"">-</td>"
		End If
		
		outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("MemberCode") & "</td>"
		
		outputString += "<td><a href=""JavaScript: newWindow = window.open( '../members/member_stat.aspx?MemberID=" + dtTable.Rows(i)("MemberID").ToString + "', '', 'width=950,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & dtTable.Rows(i)("MemberFullName") & "</a></td>"
		

		
		If Not IsDBNull(dtTable.Rows(i)("CurrentAmountMoney")) Then
			sumTotalCurrent += dtTable.Rows(i)("CurrentAmountMoney")
			outputString += "<td class=""text"" align=""right"">" + dtTable.Rows(i)("CurrentAmountMoney") + "</td>"
		Else
			outputString += "<td class=""text"" align=""right"">-</td>"
		End If
		If Not IsDBNull(dtTable.Rows(i)("RemainingAmount")) Then
			sumTotalDB += dtTable.Rows(i)("RemainingAmount")
			outputString += "<td class=""text"" align=""right""><a href=""JavaScript: newWindow = window.open( 'PrepaidDetails.aspx?CardID=" + dtTable.Rows(i)("CardID").ToString + "&ProductLevelID=" + dtTable.Rows(i)("ProductLevelID").ToString + "&PayTypeID=9&MemberName=" + dtTable.Rows(i)("MemberFullName") + "', '', 'width=700,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & dtTable.Rows(i)("RemainingAmount") & "</a></td>"
		Else
			outputString += "<td class=""text"" align=""right"">-</td>"
		End If
		If Not IsDBNull(dtTable.Rows(i)("ExpireDate")) Then
			outputString += "<td class=""text"" align=""right"">" + dtTable.Rows(i)("ExpireDate") + "</td>"
		Else
			outputString += "<td class=""text"" align=""right"">N/A</td>"
		End If

		outputString += "</tr>"
	Next
	If Trim(outputString) <> "" Then
		outputString += "<tr><td colspan=""4"" align=""right"" class=""text"">" + "Total" + "</td><td class=""text"" align=""right"">" + Format(sumTotalCurrent,"##,##0.00") + "</td><td align=""right"" class=""text"">" + Format(sumTotalDB,"##,##0.00") + "</td><td></td></tr>"
	End If
	ResultText.InnerHtml = outputString
End Function

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
