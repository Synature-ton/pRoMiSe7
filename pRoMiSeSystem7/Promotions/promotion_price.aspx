<%@ Page Language="VB" ContentType="text/html" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<html>
<head>
<title>Members</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body<% = GlobalParam.BodyProp %>>

<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<b class="headerText"><div class="headerText" align="left" id="HeaderText" runat="server" /></b>
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
<tr>
<td><a href="promotion_price_edit.aspx"><div id="Text_AddParam" runat="server"></div></a></td>
</tr></table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="<% = GlobalParam.AdminTableWidth %>">
	<tr>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="StatusText" runat="server"></div></td>
		<td id="headerTD7" align="center" class="tdHeader" visible="true" runat="server"><div id="ActivationText" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="Text_NameParam" runat="server"></div></td>
		<td id="headerTD1" visible="false" align="center" class="tdHeader" runat="server"><div id="ConfigPropText" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="AddProductText" runat="server"></div></td>
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
</table>
<script language="VB" runat="server">
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim getData As New CPromotions()
Dim getPageText As New DefaultText()
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Promotion_Price") Then
	
		
		headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor
		headerTD6.BgColor = GlobalParam.AdminBGColor
		headerTD7.BgColor = GlobalParam.AdminBGColor
			
		Try
			objCnn = getCnn.EstablishConnection()
			
			If IsNumeric(Request.QueryString("PriceGroupID")) Then
			
				Dim DelResult As String
				If Request.QueryString("action") = "delete" Then
					DelResult = getData.DelPromo(Request.QueryString("PriceGroupID"), objCnn)
				Else If Request.QueryString("action") = "activation" AND IsNumeric(Request.QueryString("ChangeActivateValue")) Then
					DelResult = getData.ActivatePromo(Request.QueryString("PriceGroupID"),Request.QueryString("ChangeActivateValue"), objCnn)
				End If
				If DelResult = "Success" Then
					Response.Redirect("promotion_price.aspx")
				End If
			End If
			
        	Dim dtTable As New DataTable()
        	dtTable = getData.GetPromotionInfo(-1, -1, "", objCnn)	
			
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(12,Session("LangID"),objCnn)
			
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			StatusText.InnerHtml = defaultTextTable.Rows(74)("TextParamValue")
			ActivationText.InnerHtml = defaultTextTable.Rows(75)("TextParamValue")
			
			Text_SectionParam.InnerHtml = textTable.Rows(0)("TextParamValue")
			Text_AddParam.InnerHtml = textTable.Rows(1)("TextParamValue")
			Text_NameParam.InnerHtml = textTable.Rows(2)("TextParamValue")
			ConfigPropText.InnerHtml = textTable.Rows(4)("TextParamValue")
			AddProductText.InnerHtml = textTable.Rows(3)("TextParamValue")
			Default_EditText.InnerHtml = defaultTextTable.Rows(0)("TextParamValue")
			Default_DelText.InnerHtml = defaultTextTable.Rows(1)("TextParamValue")
			
			Dim i,ChangeActivateValue As integer
			Dim outputString As String = ""
			Dim stringCriteria As String = ""
			Dim StatusImage,ActivationMsg As String
			Dim ExpirationStatus As Boolean
        	For i = 0 to dtTable.Rows.Count - 1		
				ExpirationStatus = False
				If Not IsDBNull(dtTable.Rows(i)("PriceToDate")) Then
					If DateTime.Compare(dtTable.Rows(i)("PriceToDate").AddDays(1),Now()) < 0 Then
						ExpirationStatus = True
					End If
				End If
				If dtTable.Rows(i)("Activated") = True Or dtTable.Rows(i)("Activated") = 1 Then
					StatusImage = "../images/checkbl.gif"
					ActivationMsg = defaultTextTable.Rows(53)("TextParamValue")
					ChangeActivateValue = 0
				Else
					StatusImage = "../images/crossbl.gif"
					ActivationMsg = defaultTextTable.Rows(52)("TextParamValue")
					ChangeActivateValue = 1
				End If
				
				If ExpirationStatus = True Then
					outputString += "<tr><td align=""center"" class=""text""><font color=""red"">Expired</font></td>"
				Else 
					outputString += "<tr><td align=""center""><img border=0 src=""" & StatusImage & """></td>"
				End If
				outputString += "<td align=""left"" class=""text""><a href=""promotion_price.aspx?action=activation&PriceGroupID=" & dtTable.Rows(i)("PriceGroupID").ToString & "&ChangeActivateValue=" & ChangeActivateValue.ToString & """>" & ActivationMsg & "</a></td>"

				
				outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("PromotionPriceName") & "</td>"
				
				If headerTD1.Visible = True Then
					outputString += "<td align=""left"" class=""text"">" & stringCriteria & "</td>"
				End If
				
				If dtTable.Rows(i)("GolfPromo") = True Or dtTable.Rows(i)("GolfPromo") = 1 Then
					outputString += "<td class=""disabledText"" align=""center"">" + textTable.Rows(59)("TextParamValue") + "</td>"
				Else
					outputString += "<td class=""text"" align=""center""><a href=""JavaScript: newWindow = window.open( '../Promotions/select_products.aspx?LinkID=" + dtTable.Rows(i)("PriceGroupID").ToString + "&TypeID=2&EditID=1', '', 'width=700,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + textTable.Rows(3)("TextParamValue") + "</a></td>"
				End If
				
				
				outputString += "<td align=""center"" class=""text""><a href=""promotion_price_edit.aspx?PriceGroupID=" & dtTable.Rows(i)("PriceGroupID").ToString & """>" & defaultTextTable.Rows(0)("TextParamValue") & "</a></td>"

				outputString += "<td align=""center"" class=""text""><a href=""promotion_price.aspx?action=delete&PriceGroupID=" & dtTable.Rows(i)("PriceGroupID") & """ onClick=""javascript: return confirm('" & defaultTextTable.Rows(14)("TextParamValue") & " " & Replace(dtTable.Rows(i)("PromotionPriceName"),"'","\'") & " " & defaultTextTable.Rows(15)("TextParamValue") & "')"">" & defaultTextTable.Rows(1)("TextParamValue") & "</a></td>"

				outputString += "</tr>"
			Next
			ResultText.InnerHtml = outputString
			
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
