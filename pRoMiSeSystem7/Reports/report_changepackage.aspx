<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<html>
<head>
<title>Package Summary Report</title>
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
<table>
<tr id="ShowShop" runat="server"><td valign="top"><span id="SelectShop" class="text" runat="server"></span><br><span id="ShopText" runat="server"></span></td><td valign="top">
<table cellpadding="0" cellspacing="3">
<tr>
	<td class="text"><span id="CodeSearchText" class="text" runat="server"></span></td>
	<td><asp:textbox ID="MemberCode" Font-Size="10" Height="22" Width="150" runat="server" /></td>
	<td class="text"><span id="FirstNameSearchText" class="text" runat="server"></span></td>
	<td><asp:textbox ID="MemberFirstName" Font-Size="10" Height="22" Width="130" runat="server" /></td>
</tr>
<tr>
	<td class="text"><span id="GroupSearchText" class="text" runat="server"></span></td>
	<td><div id="GroupTextSelect" runat="server"></div></td>
	<td class="text"><span id="LastNameSearchText" class="text" runat="server"></span></td>
	<td><asp:textbox ID="MemberLastName" Font-Size="10" Height="22" Width="130" runat="server" /></td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td colspan="3" class="text"><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="60" OnClick="DoSearch" runat="server" /> Order By <asp:dropdownlist ID="OrderBy" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist> &nbsp;<asp:CheckBox ID="DisplayAll" CssClass="text" Checked="false" runat="server" /></td>
</tr>

</table></td></tr>
</table></div></form>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left" colspan="2"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
<tr><td colspan="2">
<div align="right" class="text">R:U = Remainging:Used, A:D = Add:Delete</div>
<table id="myTable" border="1" cellpadding="4" cellspacing="0" width="100%" style="border-collapse:collapse;">
	<tr>
		<td id="headerTD1" align="center" class="smallTdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD2" align="center" class="smallTdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD8" align="center" class="smallTdHeader" runat="server"><div id="Text8" runat="server"></div></td>
		<td id="headerTD3" align="center" class="smallTdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD4" align="center" class="smallTdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td id="headerTD5" align="center" class="smallTdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<td id="headerTD6" align="center" class="smallTdHeader" runat="server"><div id="Text6" runat="server"></div></td>
		<td id="headerTD7" align="center" class="smallTdHeader" runat="server"><div id="Text7" runat="server"></div></td>
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
Dim DateTimeUtil As New MyDateTime()
Dim getInfo As New CCategory()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture

Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Report_ChangePackage") Then
	
		headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor
		headerTD6.BgColor = GlobalParam.AdminBGColor
		headerTD7.BgColor = GlobalParam.AdminBGColor
		headerTD8.BgColor = GlobalParam.AdminBGColor
		
		headerTD6.Visible = False
		
		Dim QueryStringList As String

		errorMsg.InnerHtml = ""
		OrderBy.Items(0).Text = "Package Name"
		OrderBy.Items(0).Value = "0"
		OrderBy.Items(1).Text = "Member Name"
		OrderBy.Items(1).Value = "1"
		
		Try
			objCnn = getCnn.EstablishConnection()
			Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
			
			Dim MultipleShop As String  = ""
			If PropertyInfo.Rows(0)("ImportDataToCopyTable") = 0 Then
				MultipleShop = "multiple"
			End If
			If session("Member_Info_Edit") Then headerTD3.Visible = True
			
			
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(11,Session("LangID"),objCnn)
			
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			SectionText.InnerHtml = "Modify Package(s) History Report"
			
			Text1.InnerHtml = "Package Name"
			Text2.InnerHtml = textTable.Rows(17)("TextParamValue")
			Text3.InnerHtml = "Price"

			Text4.InnerHtml = "R:U"
			Text5.InnerHtml = "A:D"
			Text6.InnerHtml = "Remaining<br>Price"
			Text7.InnerHtml = "Expire Date"
			Text8.InnerHtml = "Receipt #"
			DisplayAll.Text = "Display All"
			
			CodeSearchText.InnerHtml = textTable.Rows(19)("TextParamValue")
			FirstNameSearchText.InnerHtml = defaultTextTable.Rows(16)("TextParamValue")
			LastNameSearchText.InnerHtml = defaultTextTable.Rows(17)("TextParamValue")
			GroupSearchText.InnerHtml = textTable.Rows(18)("TextParamValue")
			SubmitForm.Text = defaultTextTable.Rows(92)("TextParamValue")
			SelectShop.InnerHtml = "Select Shop"
			
			Dim outputString,FormSelected As String
			Dim i As Integer
			
			Dim GroupIDValue As Integer = 0
			If IsNumeric(Request.Form("MemberGroupID")) Then
				GroupIDValue = Request.Form("MemberGroupID")
			Else If IsNumeric(Request.QueryString("MemberGroupID"))
				GroupIDValue = Request.QueryString("MemberGroupID")
			End If
			
			Dim ShopIDValue As String = "0"
			If IsNumeric(Request.Form("ShopID")) Then
				ShopIDValue = Request.Form("ShopID").ToString
			Else If IsNumeric(Request.QueryString("ShopID"))
				ShopIDValue = Request.QueryString("ShopID").ToString
			End If
			Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
			If ShopData.Rows.Count > 0 Then

				outputString = "<select name=""ShopID"" " + MultipleShop + ">"
				For i = 0 to ShopData.Rows.Count - 1
					If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
						FormSelected = "selected"
					Else
						If Not Page.IsPostBack And i=0 Then
							FormSelected = "selected"
						Else
							FormSelected = ""
						End If
					End If
					outputString += "<option value=""" & ShopData.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & ShopData.Rows(i)("ProductLevelName")
				Next
				outputString += "</select>"
				ShopText.InnerHtml = outputString
				ShowShop.Visible = True
			Else
				ShowShop.Visible = False
			End If

			QueryStringList = "&MemberGroupID=" + GroupIDValue.ToString
			
			
			Dim GroupTable As New DataTable()
        	GroupTable = getData.GetMemberInfo(4,-1,-1,-1,"MemberGroupID",objCnn)
			
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
	GenResult(Request.Form("MemberGroupID"),Request.Form("MemberCode"),Request.Form("MemberFirstName"),Request.Form("MemberLastName"),Request.Form("ShopID"),OrderBy.SelectedItem.Value, objCnn)
	
End Sub

Public Function GenResult(ByVal MemberGroupID As String, ByVal MemberCode As String, ByVal MemberFirstName As String, ByVal MemberLastName As String, ByVal ShopID As String, ByVal OrderBy As Integer, ByVal objCnn As MySqlConnection) As String
	
	Dim dtTable As New DataTable()
	dtTable = getReport.GetPackageHistory(MemberGroupID,MemberCode,MemberFirstName,MemberLastName,ShopID,OrderBy, objCnn)
	
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(11,Session("LangID"),objCnn)
	
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
	ShowPrint.Visible = True
	
	Dim AdditionalHeaderText, HText, RText As String
	Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

	Dim ReceiptHeaderData As DataTable
	ReceiptHeaderData = getInfo.GetDocType(1, 0, 8, 1, objCnn)

	If ReceiptHeaderData.Rows.Count > 0 Then
		If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
			AdditionalHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
		End If
	End If
		
	Dim totalRemaining As Integer
	Dim sumTotalCurrent As Double = 0
	Dim sumTotalDB As Double = 0
	Dim i As integer
	Dim outputString As String = ""

	For i = 0 to dtTable.Rows.Count - 1
	  totalRemaining = dtTable.Rows(i)("totalNum") - dtTable.Rows(i)("totalUsed")
	  If (totalRemaining > 0 AND DisplayAll.Checked = False) Or DisplayAll.Checked = True Then
		outputString += "<tr>"
		outputString += "<td align=""left"" class=""smallText"">" + "<a href=""JavaScript: newWindow = window.open( '../reports/PackageDetail.aspx?PackageID=" + dtTable.Rows(i)("PackageID").ToString + "&ProductLevelID=" + dtTable.Rows(i)("ProductLevelID").ToString + "&ShowCommission=0&ShowPrice=1', '', 'width=800,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + dtTable.Rows(i)("ProductName") + "</a>" + "</td>"
		
		If Not IsDBNull(dtTable.Rows(i)("MemberID")) Then
			outputString += "<td class=""smallText""><a href=""JavaScript: newWindow = window.open( '../members/member_stat.aspx?MemberID=" + dtTable.Rows(i)("MemberID").ToString + "', '', 'width=950,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & dtTable.Rows(i)("MemberFullName") & "</a></td>"
		ElseIf Not IsDBNull(dtTable.Rows(i)("MemberFullName")) Then
			outputString += "<td class=""smallText"">" + dtTable.Rows(i)("MemberFullName") & "</td>"
		Else
			outputString += "<td class=""smallText"">" + dtTable.Rows(i)("PackageFullName") & "**</td>"
		End If
		
		HText = ""
		If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
			If Not IsDBNull(dtTable.Rows(i)("DocumentTypeHeader")) Then
				HText = dtTable.Rows(i)("DocumentTypeHeader")
			End If
		Else
			HText = AdditionalHeaderText
		End If
		If IsDBNull(dtTable.Rows(i)("ReceiptID")) Or IsDBNull(dtTable.Rows(i)("ReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("ReceiptYear")) Then
			RText = "-"
		Else
			RText = FormatDocNumber.GetReceiptHeader(HText, dtTable.Rows(i)("ReceiptYear"), dtTable.Rows(i)("ReceiptMonth"), dtTable.Rows(i)("ReceiptID"))
		End If
		If RText <> "-" Then
			outputString += "<td align=""left"" class=""smallText""><a href=""JavaScript: newWindow = window.open( 'BillDetails.aspx?ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & RText & "</a></td>"
		Else
			outputString += "<td align=""left"" class=""smallText"">" & RText & "</td>"
		End If
		
		If Not IsDBNull(dtTable.Rows(i)("SalePrice")) Then
			outputString += "<td align=""right"" class=""smallText"">" & Format(dtTable.Rows(i)("SalePrice"),"##,##0") & "</td>"
		Else
			outputString += "<td align=""right"" class=""smallText"">" & "-" & "</td>"
		End If
		
		outputString += "<td align=""right"" class=""smallText"">" & totalRemaining.ToString & ":" & dtTable.Rows(i)("totalUsed").ToString & "</td>"
		outputString += "<td align=""right"" class=""smallText"">" & (dtTable.Rows(i)("totalChangeRecord")-dtTable.Rows(i)("totalDelRecord")).ToString & ":" & dtTable.Rows(i)("totalDelRecord").ToString & "</td>"
		
		If Not IsDBNull(dtTable.Rows(i)("ExpireDate")) Then
			outputString += "<td align=""right"" class=""smallText"">" & DateTimeUtil.FormatDateTime(dtTable.Rows(i)("ExpireDate"),"DateOnly") & "</td>"
		Else
			outputString += "<td align=""right"" class=""smallText"">-</td>"
		End If
		
		If Not IsDBNull(dtTable.Rows(i)("SalePrice")) Then
			sumTotalCurrent += dtTable.Rows(i)("SalePrice")
		End If

		outputString += "</tr>"
	  End If
	Next

	ResultText.InnerHtml = outputString
End Function


Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
