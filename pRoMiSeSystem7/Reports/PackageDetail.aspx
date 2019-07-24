<%@ Page Language="VB" ContentType="text/html" debug="True" EnableViewState="false" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<html>
<head>
<title>Package Details</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body leftmargin="0" topmargin="0">

<form id="mainForm" runat="server">
<input type="hidden" name="SubmitParam" value="0">
<table width="100%" border="1" cellspacing="0" cellpadding="3" style="border-collapse:collapse;">
<tr><td colspan="<% = (ColSpanValue+1) %>"><table cellpadding="0" cellspacing="0" width="100%">
<tr><td class="boldText"><span id="HeaderText" runat="server"></span></td>
<td align="right"><div class="noprint"><div class="text"><a href="javascript: window.print()">Print</a> | <a href="javascript: window.close()">Close</a></div></div></td></tr>
</table></td></tr>
<span id="showAddService" runat="server">
<tr><td colspan="<% = (ColSpanValue+1) %>">
<table>
	<tr>
		<td class="text">Service Name:</td>
		<td><span id="ServiceSelection" runat="server"></span></td>
		<td>&nbsp;</td>
		<td><input type="text" name="NumAdd" style="font-size:10px;" size="3" value="1"></td>
		<td><input type="submit" name="AddMore" style="font-size:10px; width:auto;" value="Add Service(s)" onClick="this.disabled=true; this.value='Please wait...'; document.forms[0].SubmitParam.value=1; document.forms[0].submit();"></td>
		<td class="text">Add Comment: <input type="text" name="AddComment" style="font-size:10px;" size="40" value=""></td>
	</tr>
</table>
</td></tr>
</span>
<tr>
	<td id="headerTD0" align="center" class="tdHeader" runat="server"></td>
	<td id="headerTD7" align="center" class="tdHeader" runat="server"></td>
	<td id="headerTD1" align="center" class="tdHeader" runat="server">Service Name</td>
	<td id="headerTD6" align="center" class="tdHeader" runat="server">Receipt #</td>
	<td id="headerTD2" align="center" class="tdHeader" runat="server">Use Date</td>
	<td id="headerTD3" align="center" class="tdHeader" runat="server">Use Time</td>
	<td id="headerTD4" align="center" class="tdHeader" runat="server">Staff Name</td>
	<td id="headerTD5" align="center" class="tdHeader" runat="server">Weighted<br>Price</td>
</tr>
<div id="ResultText" runat="server"></div>
</table>
<div id="showHistory" runat="server">
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" style="border-collapse:collapse;">
<tr><td class="boldText">Change History</td></tr>
<tr><td>
<table width="100%" border="1" cellspacing="0" cellpadding="3" style="border-collapse:collapse;">
<tr>
	<td id="headerTD11" align="center" class="tdHeader" runat="server">Action</td>
	<td id="headerTD12" align="center" class="tdHeader" runat="server">By/Comment</td>
	<td id="headerTD13" align="center" class="tdHeader" runat="server">Service Name</td>
	<td id="headerTD14" align="center" class="tdHeader" runat="server">Date</td>
</tr>
<div id="ChangeHistoryText" runat="server"></div>
</table></td></tr>
</table>
</div>
<div id="errorMsg" style="color:red;" runat="server" />

</form>
<script language="VB" runat="server">
Dim getInfo As New CCategory()
Dim userInfo As New CMembers()
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim DateTimeUtil As New MyDateTime()
Dim getUDD As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim ColSpanValue As Integer = 6
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Member_Info_View_History") AND IsNumeric(Request.QueryString("PackageID")) AND IsNumeric(Request.QueryString("ProductLevelID")) Then
		
		'Try
		errorMsg.InnerHtml = ""
		If Session("POS_ChangePackageBackOffice") Then
			headerTD7.Visible = True
			showAddService.Visible = True
		Else
			headerTD7.Visible = False
			showAddService.Visible = False
		End If
		objCnn = getCnn.EstablishConnection()

		Dim textTable As New DataTable()
		textTable = getPageText.GetText(11,Session("LangID"),objCnn)
		
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
		headerTD0.BgColor = GlobalParam.AdminBGColor
		headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor
		headerTD6.BgColor = GlobalParam.AdminBGColor
		headerTD7.BgColor = GlobalParam.AdminBGColor
		
		headerTD11.BgColor = GlobalParam.AdminBGColor
		headerTD12.BgColor = GlobalParam.AdminBGColor
		headerTD13.BgColor = GlobalParam.AdminBGColor
		headerTD14.BgColor = GlobalParam.AdminBGColor
		
		Dim StaffFullName As String =""
		Dim HeaderString As String = ""
		Dim ExtraInfoText As String = ""
		Dim ChangeText As String = ""
		Dim ServiceText As String = ""
		
		If headerTD7.Visible = True Then ColSpanValue = 7
		Dim ReturnValue As Boolean
		If Request.Form("SubmitDel") = "Delete Checked Item(s)" Then
			ReturnValue = userInfo.AlterPackageInfo(Request.Form("PackageHistoryIDList"),Request.QueryString("PackageID"),Request.QueryString("ProductLevelID"), Session("StaffID"), Request.Form("DelComment"), objCnn)
			If ReturnValue = True Then
				Response.Redirect("PackageDetail.aspx" + "?" + Request.QueryString.ToString)
			End If
		ElseIf Request.Form("SubmitParam") = "1" Then
			If IsNumeric(Request.Form("NumAdd")) And Request.Form("ProductID") > 0 Then
				
				ReturnValue = userInfo.AddServiceToPackage(Request.Form("ProductID"),Request.QueryString("PackageID"),Request.QueryString("ProductLevelID"), Request.Form("NumAdd"), Session("StaffID"), Request.Form("AddComment"), objCnn)
				If ReturnValue = True Then
					Response.Redirect("PackageDetail.aspx" + "?" + Request.QueryString.ToString)
				End If
			End If
		End If
		Dim i As Integer
		Dim dtTable As DataTable = userInfo.ServiceData(Request.QueryString("ProductLevelID"), objCnn)
		ServiceText = "<select name=""ProductID"" style=""font-size:10px;"">"
		ServiceText += "<option value=""0"">-- Select Service Name --"
		For i = 0 to dtTable.Rows.Count - 1
			ServiceText += "<option value=""" + dtTable.Rows(i)("ProductID").ToString + """>" + dtTable.Rows(i)("ProductName") 
		Next
		ServiceText += "</select>"
		ServiceSelection.InnerHtml = ServiceText
		
		Dim dt,dt2 As DateTime
		Dim productInfo As DataTable

		Dim GetData As DataTable
		GetData = userInfo.GetPackageData(Request.QueryString("PackageID"), Request.QueryString("ProductLevelID"), 0, objCnn)
		If GetData.Rows.Count > 0 Then
			'If Not IsDBNull(GetData.Rows(0)("ProductCode")) Then
				'productInfo = getInfo.GetProductInfo(0,0,GetData.Rows(0)("ProductCode"),Request.QueryString("ProductLevelID"),objCnn)
				'If productInfo.Rows.Count > 0 Then
					'HeaderString += "<br>" + productInfo.Rows(0)("ProductName")
				'End If
			'End If
			HeaderString += "<br>" + GetData.Rows(0)("ProductName") + "; Package Number: "
			If Not IsDBNull(GetData.Rows(0)("PackageNumber")) Then
				HeaderString += GetData.Rows(0)("PackageNumber")
			Else
				HeaderString += "-"
			End If
			If Not IsDBNull(GetData.Rows(0)("MemberFirstName")) AND Not IsDBNull(GetData.Rows(0)("MemberLastName")) Then
				HeaderString += "<br>" + GetData.Rows(0)("MemberFirstName") + " " + GetData.Rows(0)("MemberLastName")
			ElseIf Not IsDBNull(GetData.Rows(0)("PackageFirstName")) AND Not IsDBNull(GetData.Rows(0)("PackageLastName")) Then
				HeaderString += "<br>" + GetData.Rows(0)("PackageFirstName") + " " + GetData.Rows(0)("PackageLastName") + "**"
			End If
			If Not IsDBNull(GetData.Rows(0)("ExpireDate")) Then
				HeaderString += "<br>Expiration: " + DateTimeUtil.FormatDateTime(GetData.Rows(0)("ExpireDate"),"DateOnly")
			End If
		End If
		HeaderText.InnerHtml = HeaderString
		
		Dim AdditionalHeaderText, HText, RText As String
		Dim PropertyInfo As DataTable = getUDD.PropertyInfo(1, objCnn)

		Dim ReceiptHeaderData As DataTable
		ReceiptHeaderData = getInfo.GetDocType(1, 0, 8, 1, objCnn)

		If ReceiptHeaderData.Rows.Count > 0 Then
			If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
				AdditionalHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
			End If
		End If
			
		Dim CellColor As String
		Dim totalPrice As Double = 0
		Dim totalUse As Double = 0
		Dim ChkKey As String = ""
		Dim counter As Integer = 1
		
		For i = 0 To GetData.Rows.Count - 1
			StaffFullName = ""
			If Not IsDBNull(GetData.Rows(i)("StaffFirstName")) Then
				StaffFullName += GetData.Rows(i)("StaffFirstName")
			End If
			If Not IsDBNull(GetData.Rows(i)("StaffLastName")) Then
				StaffFullName += " " + GetData.Rows(i)("StaffLastName")
			End If
			If StaffFullName = "" Then StaffFullName = "-"
			
			If Not IsDBNull(GetData.Rows(i)("PackageStatus")) Then
				If GetData.Rows(i)("PackageStatus") = 1 Or GetData.Rows(i)("PackageStatus") = True Then
					CellColor = "#dbdbdb"
					If ChkKey <> GetData.Rows(i)("PrimaryKey") Then
						If Not IsDBNull(GetData.Rows(i)("EachPackagePrice")) Then
							totalUse += GetData.Rows(i)("EachPackagePrice")
						End If
					End If
				Else
					CellColor = "white"
				End If
			End If
			ExtraInfoText += "<tr bgcolor=""" + CellColor + """>"
			If ChkKey <> GetData.Rows(i)("PrimaryKey") Then
				ExtraInfoText += "<td class=""text"" align=""center"">" + counter.ToString + "</td>"
			Else
				ExtraInfoText += "<td class=""text"" align=""center""></td>"
			End If
			If headerTD7.Visible = True Then
				If Not IsDBNull(GetData.Rows(i)("PackageStatus")) Then
					If GetData.Rows(i)("PackageStatus") = 1 Or GetData.Rows(i)("PackageStatus") = True Then
						ExtraInfoText += "<td class=""text"" align=""center""></td>"
					Else
						ExtraInfoText += "<td class=""text"" align=""center"">" + "<input type=""checkbox"" name=""PackageHistoryIDList"" value=""" + GetData.Rows(i)("PackageHistoryID").ToString + """></td>"
					End If
				Else
					ExtraInfoText += "<td class=""text"" align=""center""></td>"
				End If
			End If
			
			If ChkKey <> GetData.Rows(i)("PrimaryKey") Then
				counter += 1
				If Not IsDBNull(GetData.Rows(i)("PackageProductCode")) Then
					productInfo = getInfo.GetProductInfo(0,0,GetData.Rows(i)("PackageProductCode"),GetData.Rows(i)("ProductLevelID"),objCnn)
					If productInfo.Rows.Count > 0 Then
						ExtraInfoText += "<td class=""text"">" + productInfo.Rows(0)("ProductName") + " (" + GetData.Rows(i)("PackageProductCode") + ")</td>"
					ElseIf Not IsDBNull(GetData.Rows(i)("ProductName")) Then
						ExtraInfoText += "<td class=""text"">" + GetData.Rows(i)("ProductName") + " (" + GetData.Rows(i)("PackageProductCode") + ")</td>"
					Else
						ExtraInfoText += "<td class=""text"">N/A (" + GetData.Rows(i)("PackageProductCode") + ")</td>"
					End If
					
				Else
					ExtraInfoText += "<td class=""text"">-</td>"
				End If
			
				HText = ""
				If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
					If Not IsDBNull(GetData.Rows(i)("DocumentTypeHeader")) Then
						HText = GetData.Rows(i)("DocumentTypeHeader")
					End If
				Else
					HText = AdditionalHeaderText
				End If
				If IsDBNull(GetData.Rows(i)("ReceiptID")) Or IsDBNull(GetData.Rows(i)("ReceiptMonth")) Or IsDBNull(GetData.Rows(i)("ReceiptYear")) Then
					RText = "-"
				Else
					RText = FormatDocNumber.GetReceiptHeader(HText, GetData.Rows(i)("ReceiptYear"), GetData.Rows(i)("ReceiptMonth"), GetData.Rows(i)("ReceiptID"))
				End If
				If RText <> "-" Then
					ExtraInfoText += "<td align=""left"" class=""text""><a href=""JavaScript: newWindow = window.open( 'BillDetails.aspx?ComputerID=" + GetData.Rows(i)("CID").ToString + "&TransactionID=" + GetData.Rows(i)("TID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & RText & "</a></td>"
				Else
					ExtraInfoText += "<td align=""left"" class=""text"">" & RText & "</td>"
				End If
					
				If Not IsDBNull(GetData.Rows(i)("SaleDate")) Then
					ExtraInfoText += "<td class=""text"">" + DateTimeUtil.FormatDateTime(GetData.Rows(i)("SaleDate"),"DateOnly") + "</td>"
				Else
					ExtraInfoText += "<td class=""text"">-</td>"
				End If
				If Not IsDBNull(GetData.Rows(i)("StartTime")) Then
					dt = GetData.Rows(i)("StartTime")
					dt2 = dt.AddMinutes(GetData.Rows(i)("DurationTime"))
					ExtraInfoText += "<td class=""text"">" + dt.ToString("HH:mm") + " - " + dt2.ToString("HH:mm") + "</td>"
				Else
					ExtraInfoText += "<td class=""text"">-</td>"
				End If
			Else
				ExtraInfoText += "<td class=""text""></td>"
				ExtraInfoText += "<td class=""text""></td>"
				ExtraInfoText += "<td class=""text""></td>"
				ExtraInfoText += "<td class=""text""></td>"
			End If
			
			ExtraInfoText += "<td class=""text"">" + StaffFullName + "</td>"
			
			If ChkKey <> GetData.Rows(i)("PrimaryKey") Then
				If Not IsDBNull(GetData.Rows(i)("EachPackagePrice")) Then
					ExtraInfoText += "<td align=""right"" class=""text"">" & Format(GetData.Rows(i)("EachPackagePrice"),"##,##0.00") & "</td>"
				Else
					ExtraInfoText += "<td align=""right"" class=""text"">" & "-" & "</td>"
				End If
				
				If Not IsDBNull(GetData.Rows(i)("EachPackagePrice")) Then
					totalPrice += GetData.Rows(i)("EachPackagePrice")
				End If
			Else
				ExtraInfoText += "<td class=""text""></td>"
			End If
			ExtraInfoText += "</tr>"
			ChkKey = GetData.Rows(i)("PrimaryKey")
		Next
		CellColor = "#dbdbdb"
		
		If GetData.Rows.Count > 0 Then
			ExtraInfoText += "<tr><td></td><td class=""text"" colspan=""" + ColSpanValue.ToString + """><input type=""submit"" name=""SubmitDel"" value=""Delete Checked Item(s)"" class=""buttn"" onclick=""javascript: return confirm('Are you sure you want to deleted checked item(s)')""> Del Comment: <input type=""text"" name=""DelComment"" style=""font-size:10px;"" size=""50"" value=""""></td></tr>"
			ExtraInfoText += "<tr bgcolor=""" + CellColor + """><td colspan=""" + ColSpanValue.ToString + """ align=""right"" class=""text"">Total</td><td align=""right"" class=""text"">" + Format(totalPrice,"##,##0.00") + "</td></tr>"
			ExtraInfoText += "<tr bgcolor=""" + CellColor + """><td colspan=""" + ColSpanValue.ToString + """ align=""right"" class=""text"">Total Use</td><td align=""right"" class=""text"">" + Format(totalUse,"##,##0.00") + "</td></tr>"
			ExtraInfoText += "<tr bgcolor=""" + CellColor + """><td colspan=""" + ColSpanValue.ToString + """ align=""right"" class=""text"">Total Remaining</td><td align=""right"" class=""text"">" + Format(totalPrice-totalUse,"##,##0.00") + "</td></tr>"
		End If
		If GetData.Rows.Count > 0 Then
			If Not IsDBNull(GetData.Rows(0)("PackageNote")) Then
				ExtraInfoText += "<tr><td colspan=""" + (ColSpanValue+1).ToString + """ class=""boldText"">Course/Package Note:</td></tr>"
				ExtraInfoText += "<tr><td colspan=""" + (ColSpanValue+1).ToString + """ class=""text"">" + GetData.Rows(0)("PackageNote") + "</td></tr>"
			End If
		End If
		
		ResultText.InnerHtml = ExtraInfoText
		
		GetData = UserInfo.PackageHistoryData(Request.QueryString("PackageID"), Request.QueryString("ProductLevelID"), objCnn)
		If GetData.Rows.Count > 0 Then
			showHistory.Visible = True
		Else
			showHistory.Visible = False
		End If
		Dim ActionText As String
		Dim CommentString As String
		Dim HistoryRecordIDList As String = ",0"
		For i = 0 to GetData.Rows.Count - 1
			CommentString = ""
			If  GetData.Rows(i)("HistoryStatus") = -2 Then
				ActionText = "Delete"
			Else
				ActionText = "Add"
			End If
			If  Not IsDBNull(GetData.Rows(i)("StaffName")) Then
				StaffFullName = GetData.Rows(i)("StaffName")
			Else
				StaffFullName = "-"
			End If
			If  Not IsDBNull(GetData.Rows(i)("Comment")) Then
				If Trim(GetData.Rows(i)("Comment")) <> "" Then
					CommentString = "<br><span class=""smallText"">Comment: " + GetData.Rows(i)("Comment") + "</span>"
				End If
			End If
			If HistoryRecordIDList.IndexOf("," + GetData.Rows(i)("HistoryRecordID").ToString + ",") = -1 Then
				ChangeText += "<tr>"
				ChangeText += "<td class=""text"" align=""left"">" + ActionText + "</td>"
				ChangeText += "<td class=""text"" align=""left"">" + StaffFullName + CommentString + "</td>"
				ChangeText += "<td class=""text"" align=""left"">" + GetData.Rows(i)("ProductName") + "</td>"
				ChangeText += "<td class=""text"" align=""left"">" + DateTimeUtil.FormatDateTime(GetData.Rows(i)("InsertDate"),"DateAndTime") + "</td>"
				ChangeText += "</tr>"
				HistoryRecordIDList += "," + GetData.Rows(i)("HistoryRecordID").ToString + ","
			End If
		Next
		ChangeHistoryText.InnerHtml = ChangeText
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
