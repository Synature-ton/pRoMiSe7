<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="ReportModule" %>
<%@ Register tagprefix="synature" Tagname="MemberMenu" Src="../UserControls/MemberMenu.ascx" %>
<html>
<head>
<title>Member History</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body<% = GlobalParam.BodyProp %>>
<form runat="server">
<input type="hidden" id="MemberID" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<b class="headerText"><div class="headerText" align="left" id="SectionText" runat="server" /></b>
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
<synature:MemberMenu id="MMenu" runat="server" />


<table border="0" >
	<tr>
		<span id="ShowPackage" visible="true" runat="server"><td><IFRAME NAME="package" width="430" frameborder="0" height="180"></IFRAME></td></span>
		<td><table><span id="MemberInfo" runat="server"></span></table></td>
	</tr>
	<tr>
		<td><IFRAME NAME="historyproduct" width="430" frameborder="0" height="180" SRC="member_history_product.aspx?MemberID=<% = Request.QueryString("MemberID") %>"></IFRAME></td>
		<td><IFRAME NAME="topproduct" width="430" frameborder="0" height="180" SRC="member_top_product.aspx?MemberID=<% = Request.QueryString("MemberID") %>"></IFRAME></td>
		
	</tr>
	<tr>
		<td colspan="2">
		<table>
			<tr>
				<span id="ShowHistoryService" visible="true" runat="server"><td><IFRAME NAME="historyservices" width="400" frameborder="0" height="180" SRC="member_history_service.aspx?MemberID=<% = Request.QueryString("MemberID") %>"></IFRAME></td></span>
				<span id="ShowTopService" visible="true" runat="server"><td><IFRAME NAME="topservice" width="225" frameborder="0" height="180" SRC="member_top_service.aspx?MemberID=<% = Request.QueryString("MemberID") %>"></IFRAME></td></span>
				<span id="ShowTopStaff" visible="true" runat="server"><td><IFRAME NAME="topstaff" width="225" frameborder="0" height="180" SRC="member_top_staff.aspx?MemberID=<% = Request.QueryString("MemberID") %>"></IFRAME></td></span>
			</tr>
		</table>
		</td>
	</tr>
</table>
<div id="ResultText" runat="server"></div>

<div id="Msg" runat="server"></div><p>&nbsp;</p>
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
</form>
<script language="VB" runat="server">

Dim userInfo As New CMembers()
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim getPageText As New DefaultText()
Dim DateTimeUtil As New MyDateTime()
Dim getUDD As New CPreferences()
Dim objDB As New CDBUtil()
Dim getReport As New GenReports()
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Member_Info_View_History") AND IsNumeric(Request.QueryString("MemberID")) Then
		
		'Try
			objCnn = getCnn.EstablishConnection()

		Dim textTable As New DataTable()
		textTable = getPageText.GetText(11,Session("LangID"),objCnn)
		
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
		Dim PropertyInfo As DataTable = getUDD.PropertyInfo(1,objCnn)
            Dim getInfo As New DataTable
		
		'If PropertyInfo.Rows(0)("SystemTypeID") = 1 Or PropertyInfo.Rows(0)("SystemTypeID") = 2 Or PropertyInfo.Rows(0)("SystemTypeID") = 4 Then
		If PropertyInfo.Rows(0)("SystemTypeID") = 0 Or PropertyInfo.Rows(0)("SystemTypeID") = 1 Or PropertyInfo.Rows(0)("SystemTypeID") = 2 Or PropertyInfo.Rows(0)("SystemTypeID") = 4 Then
                ShowPackage.Visible = True
                ShowTopService.Visible = False
                ShowTopStaff.Visible = False
				ShowHistoryService.Visible = False
		End If
            getInfo = userInfo.GetMemberInfo(1, -1, Request.QueryString("MemberID"), -1, "CodeOrder", objCnn)
		If Request.QueryString("Logout") = "yes" Then
			MMenu.Logout = 1
		Else
			MMenu.Logout = 0
		End If
            MMenu.MemberPage = 2
       
		SectionText.InnerHtml = textTable.Rows(29)("TextParamValue")
		
		Dim getPrepaid As DataTable
		Dim i As Integer
		
		If getInfo.Rows.Count > 0 Then
		
			Dim HeaderParam As String = "<tr><td class=""text"" valign=""top"" width=""300""><table><tr><td class=""text"">Name:</td><td class=""text"">"

			If Not IsDBNull(getInfo.Rows(0)("MemberFirstName")) Then HeaderParam += getInfo.Rows(0)("MemberFirstName")
			
			If Not IsDBNull(getInfo.Rows(0)("MemberLastName")) Then 
				HeaderParam += " " + getInfo.Rows(0)("MemberLastName")
			End If
			HeaderParam += "<br>(" + getInfo.Rows(0)("MemberGroupName") + ")"
			HeaderParam += "</td></tr>"
			
			HeaderParam += "<tr><td class=""text"">Birth Date:</td><td class=""text"">"
			If Not IsDBNull(getInfo.Rows(0)("MemberBirthDay")) Then
				Dim MemberAge As Integer = 0
				MemberAge = Year(Now()) - Year(getInfo.Rows(0)("MemberBirthDay"))
				HeaderParam += DateTimeUtil.FormatDateTime(getInfo.Rows(0)("MemberBirthDay"),"DateOnly") + " (" + MemberAge.ToString + ")"
			Else
				HeaderParam += "N/A"
			End If
			HeaderParam += "</td></tr>"
			
			HeaderParam += "<tr><td class=""text"">Tel:</td><td class=""text"">"
			If Not IsDBNull(getInfo.Rows(0)("MemberTelephone")) Then
				HeaderParam += getInfo.Rows(0)("MemberTelephone")
			Else
				HeaderParam += "N/A"
			End If
			HeaderParam += "</td></tr>"
			
			HeaderParam += "<tr><td class=""text"">Mobile:</td><td class=""text"">"
			If Not IsDBNull(getInfo.Rows(0)("MemberMobile")) Then
				HeaderParam += getInfo.Rows(0)("MemberMobile")
			Else
				HeaderParam += "N/A"
			End If
			HeaderParam += "</td></tr>"
			
			HeaderParam += "<tr><td class=""text"">Email:</td><td class=""text"">"
			If Not IsDBNull(getInfo.Rows(0)("MemberEmail")) Then
				HeaderParam += "<a href=""mailto:" + getInfo.Rows(0)("MemberEmail") + """>" + getInfo.Rows(0)("MemberEmail") + "</a>" 
			Else
				HeaderParam += "N/A"
			End If
			HeaderParam += "</td></tr>"
			
			HeaderParam += "<tr><td class=""text"">Register Date:</td><td class=""text"">"
			If Not IsDBNull(getInfo.Rows(0)("InputDate")) Then
				HeaderParam += DateTimeUtil.FormatDateTime(getInfo.Rows(0)("InputDate"),"DateOnly")
			Else
				HeaderParam += "N/A"
			End If
			HeaderParam += "</td></tr>"
			
			HeaderParam += "<tr><td class=""text"">Expire Date:</td><td class=""text"">"
			If Not IsDBNull(getInfo.Rows(0)("MemberExpiration")) Then
				HeaderParam += DateTimeUtil.FormatDateTime(getInfo.Rows(0)("MemberExpiration"),"DateOnly")
			Else
				HeaderParam += "N/A"
			End If
			HeaderParam += "</td></tr>"
			
			getPrepaid = getReport.SearchPrepaidMember(0,getInfo.Rows(0)("MemberCode"),"","","","","",objCnn)
			If getPrepaid.Rows.Count > 0 Then
				For i = 0 To getPrepaid.Rows.Count - 1
					HeaderParam += "<tr><td class=""text"">Prepaid #" + (i+1).ToString + ":</td><td class=""text"">"
					If Not IsDBNull(getPrepaid.Rows(i)("CurrentAmountMoney")) Then
						HeaderParam += "<a href=""JavaScript: newWindow = window.open( '../Reports/PrepaidDetails.aspx?CardID=" + getPrepaid.Rows(i)("CardID").ToString + "&ProductLevelID=" + getPrepaid.Rows(i)("ProductLevelID").ToString + "&PayTypeID=9&MemberName=" + getPrepaid.Rows(i)("MemberFullName") + "', '', 'width=700,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + getPrepaid.Rows(i)("RemainingAmount").ToString + "</a>"
					Else
						HeaderParam += "0.00"
					End If
					HeaderParam += "</td></tr>"
				Next
			End If
			
			HeaderParam += "</table><td vlign=""top""><img border=""0"" width=""120"" height=""155"" src="""
			If Not IsDBNull(getInfo.Rows(0)("MemberPictureFileServer")) Then
			 	If Trim(getInfo.Rows(0)("MemberPictureFileServer")) <> "" Then
					HeaderParam += "../images/Members/" + getInfo.Rows(0)("MemberPictureFileServer")
				Else
					HeaderParam += "../images/no_photo.jpg"
				End If
			Else
				HeaderParam += "../images/no_photo.jpg"
			End If
			HeaderParam += """></td></tr>"
			MemberInfo.InnerHtml = HeaderParam
			
		End If

		MemberID.Value = Request.QueryString("MemberID")
		
		
		'Catch ex As Exception
			'errorMsg.InnerHtml = ex.Message
		'End Try
		
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
