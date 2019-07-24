<%@ Page Language="VB" ContentType="text/html" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<html>
<head>
<title>Manage Promotion Group</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body<% = GlobalParam.BodyProp %>>
<form runat="server">
<input type="hidden" id="PromotionGroupID" runat="server" />
<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<b class="headerText"><div class="headerText" align="left" id="Text_SectionParam" runat="server" /></b>
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
<table cellpadding="2" cellspacing="2" width="100%">
<tr id="showAdd" visible="True" runat="server">
<td><a href="../Members/member_group_edit.aspx"><div id="Text_AddParam" runat="server"></div></a></td>
</tr></table>

<table>
<div id="ValidateError" runat="Server"></div>
<tr>
	<td class="smallText">Promotion Group Name:</td>
	<td><asp:textbox ID="PromotionGroupName" CssClass="smalltext" Width="150" runat="server" /></td>
	<td><asp:button ID="SubmitForm" OnClick="DoAddUpdate" runat="server" />&nbsp;<asp:button ID="CancelButton" Text=" Cancel " OnClick="DoCancel" runat="server" /></td>
</tr>
</table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="<% = GlobalParam.AdminTableWidth %>">
	<tr>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="Text_NameParam" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Default_EditText" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Default_DelText" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>

</table>
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
</table></form>
<script language="VB" runat="server">
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim promo As New CPromotions()
Dim getPageText As New DefaultText()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()

Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Promotion_Group") Then

		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor	
			
		Try
			objCnn = getCnn.EstablishConnection()
			Dim getInfo As DataTable
        	Dim dtTable As New DataTable()
        	dtTable = promo.PromotionGroup(0,objCnn)	
			Dim i As integer
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(11,Session("LangID"),objCnn)
			
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
			Text_SectionParam.InnerHtml = "Manage Promotion Group"
			Text_AddParam.InnerHtml = ""
			Text_NameParam.InnerHtml = "Promotion Group Name"
			Default_EditText.InnerHtml = defaultTextTable.Rows(0)("TextParamValue")
			Default_DelText.InnerHtml = defaultTextTable.Rows(1)("TextParamValue")
			SubmitForm.Text = " Add "
			CancelButton.Visible = False
			
			If Not Page.IsPostBack Then
				PromotionGroupID.Value = 0
				If IsNumeric(Request.QueryString("PromotionGroupID")) AND Request.QueryString("Action") = "Edit" Then
					PromotionGroupID.Value = Request.QueryString("PromotionGroupID")
					getInfo = promo.PromotionGroup(PromotionGroupID.Value,objCnn)	
					For i = 0 To getInfo.Rows.Count - 1
						If Not IsDBNull(getInfo.Rows(i)("PromotionGroupName")) Then
							PromotionGroupName.Text = getInfo.Rows(i)("PromotionGroupName")
						Else
							PromotionGroupName.Text = ""
						End If
					Next
					SubmitForm.Text = " Update "
					CancelButton.Visible = True
				ElseIf IsNumeric(Request.QueryString("PromotionGroupID")) AND Request.QueryString("Action") = "Delete" Then
					promo.DelPromotionGroup(Request.QueryString("PromotionGroupID"),objCnn)
					Response.Redirect("promotion_group.aspx")
				End If
			End If
			
			
			Dim outputString As String = ""
			Dim string1 As String
        	For i = 0 to dtTable.Rows.Count - 1
		 	  If dtTable.Rows(i)("PromotionGroupID") > 0 Then

				outputString += "<tr><td align=""left"" class=""text"">" & dtTable.Rows(i)("PromotionGroupName") & "</td>"
				
				
				outputString += "<td align=""center"" class=""text""><a href=""promotion_group.aspx?Action=Edit&PromotionGroupID=" & dtTable.Rows(i)("PromotionGroupID").ToString & """>" & defaultTextTable.Rows(0)("TextParamValue") & "</a></td>"
				
				If dtTable.Rows(i)("totalRecord") = 0 Then
					outputString += "<td align=""center"" class=""text""><a href=""promotion_group.aspx?action=Delete&PromotionGroupID=" & dtTable.Rows(i)("PromotionGroupID").ToString & """ onClick=""javascript: return confirm('" & defaultTextTable.Rows(14)("TextParamValue") & " " & Replace(dtTable.Rows(i)("PromotionGroupName"),"'","\'") & " " & defaultTextTable.Rows(15)("TextParamValue") & "')"">" & defaultTextTable.Rows(1)("TextParamValue") & "</a></td>"
				Else
					outputString += "<td align=""center"" class=""text"">" & defaultTextTable.Rows(1)("TextParamValue") & "</td>"
				End If

				outputString += "</tr>"
			  End If

			Next
			ResultText.InnerHtml = outputString
			
		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
	Else
		updateMessage.Text = "Access Denied"
	End If
End Sub

Sub DoAddUpdate(Source As Object, E As EventArgs)
	Dim AddUpdate As New CCategory()
	Dim FoundError AS Boolean = False

	validateError.InnerHtml = ""
	If Trim(PromotionGroupName.Text) = "" Then
		validateError.InnerHtml = "<tr><td></td><td class=""errorText"" colspan=""5"">" & "Promotion group names must be filled before submission" & "</td></tr>"
		FoundError = True
	End If
	
	If FoundError = False Then
		Dim Result As String

		
		Application.Lock()
		Result = promo.AddUpdatePromotionGroup(PromotionGroupID.Value,PromotionGroupName.Text, objCnn)
		Application.UnLock()
		If Result = "Success" Then
			Response.Redirect("promotion_group.aspx")
		Else
			errorMsg.InnerHtml = Result
		End If
	End If
End Sub

Sub DoCancel(Source As Object, E As EventArgs)

	Response.Redirect("promotion_group.aspx")

End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
