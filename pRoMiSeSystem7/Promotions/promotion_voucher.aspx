<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<html>
<head>
<title>Promotions</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body<% = GlobalParam.BodyProp %>>

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
<tr>
<td><div id="Text_AddParam" runat="server"></div></td>
</tr></table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="<% = GlobalParam.AdminTableWidth %>">
	<tr>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="StatusText" runat="server"></div></td>
		<td id="headerTD7" align="center" class="tdHeader" visible="true" runat="server"><div id="ActivationText" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="Text_NameParam" runat="server"></div></td>
		<td id="headerTD1" visible="true" align="center" class="tdHeader" runat="server"><div id="ShowNumberText" runat="server"></div></td>
		<td id="headerTD8" align="center" class="tdHeader" runat="server"><div id="AddMoreText" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Default_EditText" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Default_DelText" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>

</table>
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

<div id="errorMsg" runat="server" />

<script language="VB" runat="server">
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim getData As New CPromotions()
Dim getPageText As New DefaultText()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Sub Page_Load()
	If User.Identity.IsAuthenticated AND ( (Session("Promotion_Coupon") AND Request.QueryString("type") = 4) OR (Session("Promotion_Voucher") AND Request.QueryString("type") = 5) ) Then
	
		
		headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD6.BgColor = GlobalParam.AdminBGColor
		headerTD7.BgColor = GlobalParam.AdminBGColor
		headerTD8.BgColor = GlobalParam.AdminBGColor
			
		Try
			objCnn = getCnn.EstablishConnection()
			
			Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
			If PropertyInfo.Rows(0)("HeadOrBranch") = 1 Then
				Text_AddParam.Visible = False
				headerTD3.Visible = False
				headerTD4.Visible = False
				headerTD7.Visible = False
				headerTD8.Visible = False
			End If
			
			Dim ExtraURL As String = ""
			If IsNumeric(Request.QueryString("type")) Then
				ExtraURL = "type=" + Request.QueryString("type").ToString
			End If
			
			If IsNumeric(Request.QueryString("VoucherTypeID")) Then
			
				Dim DelResult As String
				If Request.QueryString("action") = "delete" Then
					DelResult = getData.ModifyCV(2, Request.QueryString("VoucherTypeID"), 0, objCnn)
				Else If Request.QueryString("action") = "activation" AND IsNumeric(Request.QueryString("ChangeActivateValue")) Then
					DelResult = getData.ModifyCV(1, Request.QueryString("VoucherTypeID"),Request.QueryString("ChangeActivateValue"), objCnn)
				End If
				If DelResult = "Success" Then
					Response.Redirect("promotion_voucher.aspx?" + ExtraURL)
				End If
			End If
			
        
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(12,Session("LangID"),objCnn)
			
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			Dim PromotionType As String = "Voucher"
			Dim CouponType As Integer
			If Request.QueryString("type") = 4 Then
				PromotionType = "Coupon"
				CouponType = 4
				Text_SectionParam.InnerHtml = textTable.Rows(26)("TextParamValue")
				Text_AddParam.InnerHtml = "<a href=""promotion_voucher_edit.aspx?" + ExtraURL + """>" + textTable.Rows(29)("TextParamValue") + "</a>"
			Else
				PromotionType = "Voucher"
				CouponType = 5
				Text_SectionParam.InnerHtml = textTable.Rows(27)("TextParamValue")
				Text_AddParam.InnerHtml = "<a href=""promotion_voucher_edit.aspx?" + ExtraURL + """>" + textTable.Rows(30)("TextParamValue") + "</a>"
			End If
			
			Dim dtTable As New DataTable()
        	dtTable = getData.GetCVPromoInfo_New(Request.QueryString("type"), -1, -1, objCnn)	
			
			
			StatusText.InnerHtml = defaultTextTable.Rows(74)("TextParamValue")
			ActivationText.InnerHtml = defaultTextTable.Rows(75)("TextParamValue")
			AddMoreText.InnerHtml = textTable.Rows(49)("TextParamValue")
			
			
			Text_NameParam.InnerHtml = textTable.Rows(31)("TextParamValue")
			ShowNumberText.InnerHtml = textTable.Rows(28)("TextParamValue")

			Default_EditText.InnerHtml = defaultTextTable.Rows(0)("TextParamValue")
			Default_DelText.InnerHtml = defaultTextTable.Rows(1)("TextParamValue")
			
			Dim i,ChangeActivateValue,TotalUsedValue As integer
			Dim outputString As String = ""
			Dim stringCriteria As String = ""
			Dim StatusImage,ActivationMsg,UsedString As String
			Dim ExpirationStatus As Boolean
			Dim totalUse As String
			Dim totalNum,totalUsed As Integer
			Dim reuseData As DataTable
        	For i = 0 to dtTable.Rows.Count - 1		
				ExpirationStatus = False
				If Not IsDBNull(dtTable.Rows(i)("ExpireDate")) Then
					If DateTime.Compare(dtTable.Rows(i)("ExpireDate").AddDays(1),Now()) < 0 Then
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
				
				If headerTD7.Visible = True Then
					outputString += "<td align=""left"" class=""text""><a href=""promotion_voucher.aspx?action=activation&VoucherTypeID=" & dtTable.Rows(i)("VoucherTypeID").ToString & "&ChangeActivateValue=" & ChangeActivateValue.ToString & "&" & ExtraURL & """>" & ActivationMsg & "</a></td>"
				End If
				
				getData.GetCVPromoRecord(TotalNum,TotalUsed,dtTable.Rows(i)("VoucherTypeID"),dtTable.Rows(i)("ReuseCoupon"),objCnn)

				UsedString = "<a href=""promotion_voucher_details.aspx?VoucherTypeID=" + dtTable.Rows(i)("VoucherTypeID").ToString + "&Used=1&" + ExtraURL + """>" + totalUsed.ToString + "</a>"

				
				outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("VoucherTypeName") & "<br>(" & dtTable.Rows(i)("VoucherHeader") & ")</td>"
				
				outputString += "<td align=""center"" class=""text"">" & "<a href=""promotion_voucher_details.aspx?VoucherTypeID=" + dtTable.Rows(i)("VoucherTypeID").ToString + "&" + ExtraURL + """>" + TotalNum.ToString + "</a>" & "::" + UsedString + "</td>"
				
				If headerTD8.Visible = True Then
					If dtTable.Rows(i)("ReuseCoupon") = 2 Then
						outputString += "<td align=""center"" class=""text"">-</td>"
					Else
						outputString += "<td align=""center"" class=""text""><a href=""promotion_voucher_add.aspx?VoucherTypeID=" & dtTable.Rows(i)("VoucherTypeID").ToString & "&" & ExtraURL & """>" & textTable.Rows(49)("TextParamValue") & "</a></td>"
					End If
				End If
				
				If headerTD3.Visible = True Then
					outputString += "<td align=""center"" class=""text""><a href=""promotion_voucher_edit.aspx?VoucherTypeID=" & dtTable.Rows(i)("VoucherTypeID").ToString & "&" & ExtraURL & """>" & defaultTextTable.Rows(0)("TextParamValue") & "</a></td>"
				End If
				
				If headerTD4.Visible = True Then
					outputString += "<td align=""center"" class=""text""><a href=""promotion_voucher.aspx?action=delete&VoucherTypeID=" & dtTable.Rows(i)("VoucherTypeID") & "&" & ExtraURL & """ onClick=""javascript: return confirm('" & defaultTextTable.Rows(14)("TextParamValue") & " " & Replace(dtTable.Rows(i)("VoucherTypeName"),"'","\'") & " " & defaultTextTable.Rows(15)("TextParamValue") & "')"">" & defaultTextTable.Rows(1)("TextParamValue") & "</a></td>"
				End If

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
