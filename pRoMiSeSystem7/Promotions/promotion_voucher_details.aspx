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
<body<% = GlobalParam.BodyProp %>><form runat="server">
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
<td align="left"><div id="GoBackText" runat="server"></div></td>
</tr>
</table>

<input type="hidden" id="VoucherTypeID" runat="server" />
	<input type="hidden" id="Used" runat="server" />
	<table>
	<tr>
		<td colspan="2" align="right"><div class="text" id="navigateText" runat="server"></div></td>
	</tr>
	<tr><td colspan="2">
	<table><tr><td valign="top">
		<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" >
		<tr>
			<td id="headerTD1" align="center" class="tdHeader" runat="server">&nbsp;</td>
			<td id="headerTD2" align="center" class="tdHeader" visible="true" runat="server"><div id="CVNumberText" runat="server"></div></td>
			<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="UsedText" runat="server"></div></td>
			<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="NumUseText" runat="server"></div></td>
		</tr>
		
		<div id="ResultText" runat="server"></div>
	
		</table>
	</td>
	<td id="secondCol" runat="server" visible="False" valign="top">
		<table id="myTable2" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" >
		<tr>
			<td id="headerTD11" align="center" class="tdHeader" runat="server">&nbsp;</td>
			<td id="headerTD22" align="center" class="tdHeader" visible="true" runat="server"><div id="CVNumberText2" runat="server"></div></td>
			<td id="headerTD33" align="center" class="tdHeader" runat="server"><div id="UsedText2" runat="server"></div></td>
			<td id="headerTD44" align="center" class="tdHeader" runat="server"><div id="NumUseText2" runat="server"></div></td>
		</tr>
		
		<div id="ResultText2" runat="server"></div>
	
		</table>
	</td>
	<td id="thirdCol" runat="server" visible="False" valign="top">
		<table id="myTable3" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" >
		<tr>
			<td id="headerTD111" align="center" class="tdHeader" runat="server">&nbsp;</td>
			<td id="headerTD222" align="center" class="tdHeader" visible="true" runat="server"><div id="CVNumberText3" runat="server"></div></td>
			<td id="headerTD333" align="center" class="tdHeader" runat="server"><div id="UsedText3" runat="server"></div></td>
			<td id="headerTD444" align="center" class="tdHeader" runat="server"><div id="NumUseText3" runat="server"></div></td>
		</tr>
		
		<div id="ResultText3" runat="server"></div>
	
		</table>
	</td>
	<td id="fourthCol" runat="server" visible="False" valign="top">
		<table id="myTable3" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" >
		<tr>
			<td id="headerTD1111" align="center" class="tdHeader" runat="server">&nbsp;</td>
			<td id="headerTD2222" align="center" class="tdHeader" visible="true" runat="server"><div id="CVNumberText4" runat="server"></div></td>
			<td id="headerTD3333" align="center" class="tdHeader" runat="server"><div id="UsedText4" runat="server"></div></td>
			<td id="headerTD4444" align="center" class="tdHeader" runat="server"><div id="NumUseText4" runat="server"></div></td>
		</tr>
		
		<div id="ResultText4" runat="server"></div>
	
		</table>
	</td>
	</tr></table>
	</td></tr>
	<tr id="showRange" visible="true" runat="server">
		<td colspan="2">
		<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" >
			<tr>
				<td class="text"><span id="VoucherRangeText" class="text" runat="server"></span></td>
				<td class="text"><span id="VoucherRangeVal" class="text" runat="server"></span></td>
			</tr>
			<tr>
				<td class="text"><span id="TotalText" class="text" runat="server"></span></td>
				<td class="text"><span id="TotalVal" class="text" runat="server"></span></td>
			</tr>
			<tr>
				<td class="text"><span id="TotalUsedText" class="text" runat="server"></span></td>
				<td class="text"><span id="TotalUsedVal" class="text" runat="server"></span></td>
			</tr>
		</table></td>
	</tr> 
	<tr id="showSubmit" visible="false" runat="server">
		<td colspan="2" align="left">
		<table><tr>
		<td class="text"><asp:TextBox ID="ItemList" Width="200" runat="server"></asp:TextBox> Ex: 1-10,22,35,40-45</td></tr>
		<tr><td><asp:button ID="SubmitForm" OnClick="DoDelete" Font-Size="8" Width="120" runat="server" /></td></tr>
		</table></td>
	</tr>
	</table>

</form>


<div id="Msg" runat="server"></div>
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
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Sub Page_Load()
	If User.Identity.IsAuthenticated AND ( (Session("Promotion_Coupon") AND Request.QueryString("type") = 4) OR (Session("Promotion_Voucher") AND Request.QueryString("type") = 5) ) Then
		
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
		headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD11.BgColor = GlobalParam.AdminBGColor
		headerTD22.BgColor = GlobalParam.AdminBGColor
		headerTD33.BgColor = GlobalParam.AdminBGColor
		headerTD44.BgColor = GlobalParam.AdminBGColor
		headerTD111.BgColor = GlobalParam.AdminBGColor
		headerTD222.BgColor = GlobalParam.AdminBGColor
		headerTD333.BgColor = GlobalParam.AdminBGColor
		headerTD444.BgColor = GlobalParam.AdminBGColor
		headerTD1111.BgColor = GlobalParam.AdminBGColor
		headerTD2222.BgColor = GlobalParam.AdminBGColor
		headerTD3333.BgColor = GlobalParam.AdminBGColor
		headerTD4444.BgColor = GlobalParam.AdminBGColor
		
		headerTD1.Visible= True
		headerTD11.Visible= True
		headerTD111.Visible= True
		headerTD1111.Visible= True
		
		VoucherTypeID.Value = Request.QueryString("VoucherTypeID")
		'Try
			objCnn = getCnn.EstablishConnection()
			
			Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
			If PropertyInfo.Rows(0)("HeadOrBranch") = 1 Then
				headerTD1.Visible = False
				headerTD11.Visible = False
				headerTD111.Visible = False
				headerTD1111.Visible = False
			End If
			Dim ExtraURL As String = ""
			If IsNumeric(Request.QueryString("type")) Then
				ExtraURL = "type=" + Request.QueryString("type").ToString
			End If
			Dim UsedValue As Integer = -1
			If IsNumeric(Request.QueryString("Used")) Then
				UsedValue = Request.QueryString("Used")
				ExtraURL += "&Used=" + UsedValue.ToString
			End If
			If UsedValue = -1 AND headerTD1.Visible = True Then
				showSubmit.Visible = True
			End If
			
			
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(12,Session("LangID"),objCnn)
				
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)

			
			Dim PromotionType As String = "Voucher"
			Dim CouponType As Integer
			If Request.QueryString("type") = 4 Then
				PromotionType = "Coupon"
				SubmitForm.Text = "Delete Coupon"
				VoucherRangeText.InnerHtml = "Coupon Number Range"
				TotalText.InnerHtml = "Total Coupon(s)"
				TotalUsedText.InnerHtml = "Total Used Coupon(s)"
			Else
				PromotionType = "Voucher"
				SubmitForm.Text = "Delete Voucher"
				VoucherRangeText.InnerHtml = "Voucher Number Range"
				TotalText.InnerHtml = "Total Voucher(s)"
				TotalUsedText.InnerHtml = "Total Used Voucher(s)"
			End If
			CVNumberText.InnerHtml = PromotionType + " #"
			UsedText.InnerHtml = "Used"
			NumUseText.InnerHtml = " # Used"
			CVNumberText2.InnerHtml = PromotionType + " #"
			UsedText2.InnerHtml = "Used"
			NumUseText2.InnerHtml = " # Used"
			CVNumberText3.InnerHtml = PromotionType + " #"
			UsedText3.InnerHtml = "Used"
			NumUseText3.InnerHtml = " # Used"
			CVNumberText4.InnerHtml = PromotionType + " #"
			UsedText4.InnerHtml = "Used"
			NumUseText4.InnerHtml = " # Used"
			GoBackText.InnerHtml = "<a href=""promotion_voucher.aspx?" + ExtraURL + """>" + defaultTextTable.Rows(51)("TextParamValue") + "</a>"
			Dim RangeTable As DataTable
			Dim TotalUsedCV As Integer
			Dim dtTable As New DataTable()
			dtTable = getData.GetCVPromoDetails_New(RangeTable,TotalUsedCV,-1, VoucherTypeID.Value, "", -1, UsedValue, objCnn)	
			TotalUsedVal.InnerHtml = TotalUsedCV.ToString
			Dim RangeT As String = ""
			Dim TotalNumCV As Integer = 0
			
			Dim j As Integer
			For j = 0 To RangeTable.Rows.Count - 1
				If j = 0 Then
					RangeT += RangeTable.Rows(j)("StartNo").ToString + "-" + RangeTable.Rows(j)("EndNo").ToString
				Else
					RangeT += ", " + RangeTable.Rows(j)("StartNo").ToString + "-" + RangeTable.Rows(j)("EndNo").ToString
				End If
				TotalNumCV += RangeTable.Rows(j)("EndNo") - RangeTable.Rows(j)("StartNo") + 1
			Next
			VoucherRangeVal.InnerHtml = RangeT
			TotalVal.InnerHtml = TotalNumCV.ToString
			
			If dtTable.Rows.Count > 0 Then
				Text_SectionParam.InnerHtml = dtTable.Rows(0)("VoucherTypeName") + " (" + dtTable.Rows(0)("VoucherHeader") + ")"
				
				
				Dim NumPerPage As Integer = 40
				Dim StartPageIndex As Integer = 0
				Dim EndPageIndex,NumberOfPage As Integer
				
				If IsNumeric(Request.QueryString("StartPageIndex")) Then
					If Request.QueryString("StartPageIndex") < dtTable.Rows.Count Then
						StartPageIndex = Request.QueryString("StartPageIndex")
					End If
				End If
				
				NumberOfPage = Math.ceiling(dtTable.Rows.Count/NumPerPage)
				
				If (StartPageIndex + NumPerPage - 1) < dtTable.Rows.Count Then
					EndPageIndex = StartPageIndex + NumPerPage - 1
				Else
					EndPageIndex = dtTable.Rows.Count - 1
				End If
				
				'errorMsg.InnerHtml = "StartPage=" + StartPageIndex.ToString + ":Used=" + UsedValue.ToString
				
				Dim i,maxNum,NumberForPage As Integer
				Dim IndexString As String = ""
				If NumberOfPage > 1 Then
					For i=1 To NumberOfPage
						NumberForPage = (i-1)*NumPerPage
						If StartPageIndex <> NumberForPage Then
							indexString += " " + "<a href=""promotion_voucher_details.aspx?VoucherTypeID=" + VoucherTypeID.Value.ToString + "&StartPageIndex=" + NumberForPage.ToString + "&" + ExtraURL + """>" + i.ToString + "</a>"
						Else
							indexString += " " + i.ToString
						End If
					Next
					navigateText.InnerHtml = indexString
				End If			
				
				Dim outputString As String = ""
				Dim IDNumber As String
				Dim StartLoop,EndLoop As Integer

				For j = 0 To 3
					outputString = ""
					StartLoop = StartPageIndex + j*10
					EndLoop = StartPageIndex + (j+1)*10 - 1

					If EndLoop > dtTable.Rows.Count - 1 Then EndLoop = dtTable.Rows.Count - 1
					For i = StartLoop to EndLoop
						If dtTable.Rows(i)("ReuseCoupon") = 1 Then
							headerTD4.Visible = True
							headerTD44.Visible = True
							headerTD444.Visible = True
							headerTD4444.Visible = True
						Else
							headerTD4.Visible = False
							headerTD44.Visible = False
							headerTD444.Visible = False
							headerTD4444.Visible = False
						End If
						outputString += "<tr>"
						If headerTD1.Visible = True Then
							If dtTable.Rows(i)("Used") = 0 Then
								outputString += "<td align=""center""><input type=""checkbox"" name=""selectedItem"" value=""" + dtTable.Rows(i)("VoucherID").ToString + """></td>"
							Else
								outputString += "<td>&nbsp;</td>"
							End If
						End If
						maxNum = dtTable.Rows(i)("VoucherID") + 1000000
						IDNumber = dtTable.Rows(i)("VoucherHeader") + "/" + Right(maxNum.ToString, 6)
						outputString += "<td class=""text"">" + IDNumber + "</td>"
						outputString += "<td align=""center"" class=""text"">" + dtTable.Rows(i)("Used").ToString + "</td>"
						If headerTD4.Visible = True Then
							outputString += "<td align=""center"" class=""text"">" + dtTable.Rows(i)("NumUse").ToString + "</td>"
						End If
						outputString += "</tr>"
					Next
					If outputString <> "" Then
						If j = 0 Then
							ResultText.InnerHtml = outputString
						ElseIf j = 1 Then
							SecondCol.Visible = True
							ResultText2.InnerHtml = outputString
						ElseIf j = 2 Then
							ThirdCol.Visible = True
							ResultText3.InnerHtml = outputString
						Else
							FourthCol.Visible = True
							ResultText4.InnerHtml = outputString
						End If
					End If
				Next
			End If
				
			
		'Catch ex As Exception
			'errorMsg.InnerHtml = ex.Message
		'End Try
	Else
		updateMessage.Text = "Access Denied"
	End If
End Sub

Sub DoDelete(Source As Object, E As EventArgs)
	
	Dim Result As String
	If Trim(ItemList.Text) <> "" Then
		Result = getData.ModifyVouchers_New(VoucherTypeID.Value,ItemList.Text,objCnn)
	End If
	Response.Redirect("promotion_voucher_details.aspx?" + Request.QueryString.ToString)

End Sub


Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
