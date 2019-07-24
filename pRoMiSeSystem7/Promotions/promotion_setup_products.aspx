<%@ Page Language="VB" ContentType="text/html" EnableViewState="False" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<html>
<head>
<title>Promotion Setup By Products</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<form runat="server">
<ASP:Label id="updateMessage" CssClass="text" runat="server" />

<span id="HiddenForm" runat="server"></span>
<b class="headerText"><div class="headerText" align="left" id="Text_SectionParam" runat="server" /></b>
<br>
<div id="ShowContent" runat="server">
<table>
	<tr>
		<td><asp:button ID="SubmitForm" OnClick="DoAddUpdate" Text=" Submit Changes " runat="server" />&nbsp;&nbsp;<span id="UpdateMsg" class="boldText" runat="server"></span></td>
	</tr>
</table>
<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
	<span id="TableHeaderText" runat="server"></span>
	<div id="ResultText" runat="server"></div>

</table>
<table>
	<tr>
		<td><asp:button ID="SubmitForm1" OnClick="DoAddUpdate" Text=" Submit Changes " runat="server" /></td>
	</tr>
</table>
</div>
<div id="errorMsg" runat="server" />
</form>
<script language="VB" runat="server">
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim getData As New CPromotions()
Dim getPageText As New DefaultText()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Promotion_Setup") Then
			
		'Try
			objCnn = getCnn.EstablishConnection()
			Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
			If PropertyInfo.Rows(0)("HeadOrBranch") = 1 Then
				ShowContent.Visible = False
			Else
				ShowContent.Visible = True
			End If
			
			SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
			SubmitForm1.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm1).ToString
			
			If Request.QueryString("Update") = "done" Then
				UpdateMsg.InnerHtml = "Promotion data have been updated"
			End If
			
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(12,Session("LangID"),objCnn)
			
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			Text_SectionParam.InnerHtml = "Manage Promotion By Products (Display Maximum of 10 Products)"
			
			Dim ProductLevelIDList,ProductGroupIDList,ProductDeptIDList,ProductIDList As String
			
			ProductLevelIDList = Request.QueryString("ProductLevelID").ToString
			ProductGroupIDList = Request.QueryString("ProductGroupID").ToString
			ProductDeptIDList = Request.QueryString("ProductDeptID").ToString
			ProductIDList = Request.QueryString("ProductID").ToString
			
			Dim ProductData As DataTable
			Dim PromotionData As DataTable
			Dim InvPromoData As DataTable
			Dim dtTable As DataTable = getData.PromoByProduct(InvPromoData,ProductData,PromotionData,ProductLevelIDList,ProductGroupIDList,ProductDeptIDList,ProductIDList,objCnn)
			
			
				
			Dim i,j As integer

			Dim TestString As String
        	
			Dim HeaderString As StringBuilder = New StringBuilder
			HeaderString = HeaderString.Append("<tr>")
			HeaderString = HeaderString.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "" + "</td>")
			For i = 0 To ProductData.Rows.Count - 1
				HeaderString = HeaderString.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + ProductData.Rows(i)("ProductName") + "</td>")
			Next
			HeaderString = HeaderString.Append("</tr>")
			TableHeaderText.InnerHtml = HeaderString.ToString
			
			Dim UnitString,UnitParamName,DiscountParamName,DiscountVal As String
			Dim outputString As StringBuilder = New StringBuilder
			For i = 0 to dtTable.Rows.Count - 1		
				outputString = outputString.Append("<tr>")
				outputString = outputString.Append("<td align=""left"" class=""smalltext"">" + dtTable.Rows(i)("PromotionName") + "</td>")
				For j = 0 To ProductData.Rows.Count - 1
					UnitParamName = "Unit:" + dtTable.Rows(i)("PromotionID").ToString + ":" + ProductData.Rows(j)("ProductID").ToString
					DiscountParamName = "Discount:" + dtTable.Rows(i)("PromotionID").ToString + ":" + ProductData.Rows(j)("ProductID").ToString
					UnitString = "<select name=""" + UnitParamName + """ class=""smalltext"">"
					If Not IsDBNull(dtTable.Rows(i)("AmountOrPercent" & ProductData.Rows(j)("ProductID").ToString))
						If dtTable.Rows(i)("AmountOrPercent" & ProductData.Rows(j)("ProductID").ToString) = 0 Then
							DiscountVal = Format(dtTable.Rows(i)("DiscountPercent" & ProductData.Rows(j)("ProductID").ToString), "##,##0.00")
							UnitString += "<option value=""0"" selected>%"
							UnitString += "<option value=""1"">" + defaultTextTable.Rows(10)("TextParamValue")
						Else
							DiscountVal = Format(dtTable.Rows(i)("DiscountAmount" & ProductData.Rows(j)("ProductID").ToString), "##,##0.00")
							UnitString += "<option value=""0"">%"
							UnitString += "<option value=""1"" selected>" + defaultTextTable.Rows(10)("TextParamValue")
						End If
					Else
						DiscountVal = ""
						UnitString += "<option value=""0"">%"
						UnitString += "<option value=""1"">" + defaultTextTable.Rows(10)("TextParamValue")
					End If
					UnitString += "</select>"
					outputString = outputString.Append("<td align=""right""><input type=""text"" class=""smalltext"" style=""width=50px;"" name=""" + DiscountParamName + """ value=""" + DiscountVal + """>" + UnitString + "</td>")
				Next
				outputString = outputString.Append("</tr>")
			Next
			
			Dim CheckParam, Checked As String
			Dim PromoIDList As String = ""
			Dim PIDList As String = ""
			For i = 0 to InvPromoData.Rows.Count - 1		
				outputString = outputString.Append("<tr>")
				outputString = outputString.Append("<td align=""left"" class=""smalltext"">" + InvPromoData.Rows(i)("PromotionName") + "</td>")
				PromoIDList += "," + InvPromoData.Rows(i)("PromotionID").ToString
				DiscountParamName = "DiscountInv:" + InvPromoData.Rows(i)("PromotionID").ToString
				For j = 0 To ProductData.Rows.Count - 1
					CheckParam = "InvProductID" + ProductData.Rows(j)("ProductID").ToString
					
					If i = 0 Then
						PIDList += "," + ProductData.Rows(j)("ProductID").ToString
					End If
					If Not IsDBNull(InvPromoData.Rows(i)(CheckParam)) Then
						Checked = "checked"
					Else
						Checked = " "
					End If
					outputString = outputString.Append("<td align=""center""><input type=""checkbox"" name=""" + DiscountParamName + """ value=""" + ProductData.Rows(j)("ProductID").ToString + """" + Checked + "></td>")
				Next
				outputString = outputString.Append("</tr>")
			Next
			If Trim(PromoIDList) <> "" Then
				PromoIDList = "0" + PromoIDList
				PIDList = "0" + PIDList
			End If
			HiddenForm.InnerHtml = "<input type=""hidden"" name=""PromoIDList"" value=""" + PromoIDList + """><input type=""hidden"" name=""PIDList"" value=""" + PIDList + """>"
			ResultText.InnerHtml = outputString.ToString
			'errorMsg.InnerHtml = TestString
		'Catch ex As Exception
			'errorMsg.InnerHtml = ex.Message
		'End Try
	Else
		updateMessage.Text = "Access Denied"
	End If
End Sub

Sub DoAddUpdate(Source As Object, E As EventArgs)
	getData.PromoByProductUpdate(Request, objCnn)
	
	Response.Redirect("promotion_setup_products.aspx?Update=done&ProductGroupID=" + Request.QueryString("ProductGroupID").ToString + "&ProductDeptID=" + Request.QueryString("ProductDeptID").ToString + "&ProductID=" + Request.QueryString("ProductID").ToString + "&ProductLevelID=" + Request.QueryString("ProductLevelID").ToString)
End Sub
	
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
