<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="RewardModule.RewardPoint" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<html>
<head>
<title>Select Products</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body<% = GlobalParam.BodyProp1 %>>

<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<div id="FormParam" runat="server"></div>
<input type="hidden" id="TypeID" runat="server" />
<input type="hidden" id="LinkID" runat="server" />
<table cellpadding="2" cellspacing="2" width="100%">
<tr>
<td align="left"><div class="headerText" align="left" id="HeaderText" runat="server" /></td>
<td align="right"><div id="LinkText" class="text" runat="server"></div></td>
</tr>
<tr><td colspan="2"><hr size="0"></td></tr>
</table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
	<span id="TableColumn" runat="server"></span>
	
	<div id="ResultText" runat="server"></div>

</table>

</form>

<div id="errorMsg" runat="server" />

<script language="VB" runat="server">
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim getInfo As New CCategory()
Dim getPageText As New DefaultText()
Dim getPromo As New CPromotions()
Dim getReward As New ManageReward()
Dim DateTimeUtil As New MyDateTime()
Dim objDB As New CDBUtil()

Sub Page_Load()
	If User.Identity.IsAuthenticated Then
		
			
		'Try
			objCnn = getCnn.EstablishConnection()	
			
			Dim textTable As New DataTable()
			Dim textTable1 As New DataTable()
			textTable = getPageText.GetText(7,Session("LangID"),objCnn)
			textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
			
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			Dim AdditionalHeaderText As String = ""
			Dim ConfigType As New DataTable()
			Dim PriceGroupID,PromoType As Integer
			ConfigType = getPromo.GetPromotionInfo(Request.QueryString("PriceGroupID"), -1, "", objCnn)
			If ConfigType.Rows.Count > 0 Then
				AdditionalHeaderText = ConfigType.Rows(0)("PromotionPriceName")
				PriceGroupID = ConfigType.Rows(0)("PriceGroupID")
				PromoType = ConfigType.Rows(0)("AmountType")
			Else
				PriceGroupID = 0
				PromoType = 0
			End If
			
			HeaderText.InnerHtml = "Details for """ + AdditionalHeaderText + """ promotion"
			
			Dim LinkString As String = ""
			Dim outputString As StringBuilder = New StringBuilder
			Dim selList As String = ""
			Dim PageSection As Integer = 1
			Dim i,j As integer
			Dim FormSelected As String
			Dim ShowTableContent As Boolean = True
			
			Dim dtTable As New DataTable()
			Dim selDataList,Checked,compareString As String
			Dim ShopData As DataTable
			dtTable = getPromo.PromotionDetails(ShopData,PriceGroupID,PromoType,objCnn)

			Dim TextClass As String = "smallText"
			Dim DiscountString
			Dim ShopIDDummy As Integer = 0
			
			If PromoType = 100 Then
				outputString = outputString.Append("<tr>")
			
				outputString = outputString.Append("<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""" + "smallTdHeader" + """>" + "Product Group" + "</td>")
				outputString = outputString.Append("<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""" + "smallTdHeader" + """>" + "Product Dept" + "</td>")
				outputString = outputString.Append("<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""" + "smallTdHeader" + """>" + "Product Name" + "</td>")
				If PromoType = 100 Then
					outputString = outputString.Append("<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""" + "smallTdHeader" + """>" + "Discount" + "</td>")
					outputString = outputString.Append("<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""" + "smallTdHeader" + """>" + "" + "</td>")
				End If
				outputString = outputString.Append("</tr>")
				For i = 0 To dtTable.Rows.Count - 1
					If ShopIDDummy <> dtTable.Rows(i)("ProductLevelID") Then
						outputString = outputString.Append("<tr>")
						outputString = outputString.Append("<td colspan=""5"" bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""" + "smallTdHeader" + """>" + dtTable.Rows(i)("ProductLevelName") + "</td>")
						outputString = outputString.Append("</tr>")
					End If
					outputString = outputString.Append("<tr bgColor=""" + "white" + """>")
					outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + dtTable.Rows(i)("ProductGroupName") + "</td>")
					outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + dtTable.Rows(i)("ProductDeptName") + "</td>")
					outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + dtTable.Rows(i)("ProductName") + "</td>")
					If PromoType = 100 Then
						If dtTable.Rows(i)("AmountOrPercent") = 1 Then
							outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("DiscountAmount"), "##,##0.00") + "</td>")
							'outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + defaultTextTable.Rows(10)("TextParamValue") + "</td>")
							outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + "B" + "</td>")
						Else
							outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" + Format(dtTable.Rows(i)("DiscountPercent"), "##,##0.00") + "</td>")
							outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + "%" + "</td>")
						End If
					End If
					outputString = outputString.Append("</tr>")
					ShopIDDummy = dtTable.Rows(i)("ProductLevelID")
				Next

			Else
			
				outputString = outputString.Append("<tr>")
				outputString = outputString.Append("<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""" + "smallTdHeader" + """>" + "#" + "</td>")
				outputString = outputString.Append("<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""" + "smallTdHeader" + """>" + "Product Code" + "</td>")
				outputString = outputString.Append("<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""" + "smallTdHeader" + """>" + "Product Name" + "</td>")
				For i = 0 To ShopData.Rows.Count - 1
					outputString = outputString.Append("<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""" + "smallTdHeader" + """>" + shopData.Rows(i)("ProductLevelName") + "</td>")
				Next
				outputString = outputString.Append("</tr>")
				Dim CodeString As String
				For i = 0 To dtTable.Rows.Count - 1
					outputString = outputString.Append("<tr>")
					outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + (i+1).ToString + "</td>")
					outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + dtTable.Rows(i)("ProductCode") + "</td>")
					outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + dtTable.Rows(i)("ProductName") + "</td>")
					For j = 0 To ShopData.Rows.Count - 1
						CodeString = "ProductCode" + ShopData.Rows(j)("ShopID").ToString
						If Not IsDBNull(dtTable.Rows(i)(CodeString)) Then
							outputString = outputString.Append("<td align=""center"" class=""" + TextClass + """>" + "<img src=""../images/checkbl.gif"" border=""0"">" + "</td>")
						Else
							outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" + "" + "</td>")
						End If
					Next
					outputString = outputString.Append("</tr>")
				Next
			End If
			ResultText.InnerHtml = outputString.ToString

			
			
			'errorMsg.InnerHtml = selDataList
		'Catch ex As Exception
			'errorMsg.InnerHtml = ex.Message
		'End Try
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