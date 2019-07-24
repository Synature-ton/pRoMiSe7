<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

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
<div id="DisplayCriteria" visible="true" runat="server">
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
<tr id="DateError" visible="false" runat="server">
	<td></td>
	<td class="errorText">Invalid date range</td>
</tr>
<tr>
	<td align="right"><asp:CheckBox ID="FilterDate" runat="server" /></td>
	<td><synature:date id="CurrentDate" runat="server" /></td>
	<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
	<td><synature:date id="ToDate" runat="server" /></td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td colspan="3" class="text"><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="60" OnClick="DoSearch" runat="server" /> Order By <asp:dropdownlist ID="OrderBy" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist>  Display Option: <asp:dropdownlist ID="DisplayOption" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
</tr>

</table></td></tr>
</table></div></div></form>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left" colspan="2"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
<tr><td colspan="2">
<table id="myTable" border="1" cellpadding="4" cellspacing="0" width="100%" style="border-collapse:collapse;">
	<tr>
		<td id="headerTD1" align="center" class="smallTdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD2" align="center" class="smallTdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD8" align="center" class="smallTdHeader" runat="server"><div id="Text8" runat="server"></div></td>
		<td id="headerTD9" align="center" class="smallTdHeader" runat="server"><div id="Text9" runat="server"></div></td>
		<td id="headerTD3" align="center" class="smallTdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD4" align="center" class="smallTdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td id="headerTD5" align="center" class="smallTdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<td id="headerTD10" align="center" class="smallTdHeader" runat="server"><div id="Text10" runat="server"></div></td>
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
	If User.Identity.IsAuthenticated AND Session("Report_PackageSummary") Then
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor
		headerTD6.BgColor = GlobalParam.AdminBGColor
		headerTD7.BgColor = GlobalParam.AdminBGColor
		headerTD8.BgColor = GlobalParam.AdminBGColor
		headerTD9.BgColor = GlobalParam.AdminBGColor
		headerTD10.BgColor = GlobalParam.AdminBGColor
		
		Dim QueryStringList As String

		errorMsg.InnerHtml = ""
		OrderBy.Items(0).Text = "Package Name"
		OrderBy.Items(0).Value = "0"
		OrderBy.Items(1).Text = "Member Name"
		OrderBy.Items(1).Value = "1"
		OrderBy.Items(2).Text = "Sale Date"
		OrderBy.Items(2).Value = "2"
		
		DisplayOption.Items(0).Text = "Display All Packages"
		DisplayOption.Items(0).Value = "1"
		DisplayOption.Items(1).Text = "Display Active Packages"
		DisplayOption.Items(1).Value = "2"
		DisplayOption.Items(2).Text = "Display Inactive Packages"
		DisplayOption.Items(2).Value = "3"
		
		If Not Page.IsPostBack Then
			DisplayOption.Items(1).Selected = True
		End If
		
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
			
			SectionText.InnerHtml = "Package Summary Report"
			DocumentToDateParam.InnerHtml = defaultTextTable.Rows(91)("TextParamValue")
			
			Text1.InnerHtml = "Package Name"
			Text2.InnerHtml = textTable.Rows(17)("TextParamValue")
			Text3.InnerHtml = "Price"

			Text4.InnerHtml = "# Ramaining"
			Text5.InnerHtml = "#Used"
			Text6.InnerHtml = "Remaining<br>Price"
			Text7.InnerHtml = "Expire Date"
			Text8.InnerHtml = "Receipt #"
			Text9.InnerHtml = "Sale Date"
			Text10.InnerHtml = "Used Price"
			
			CodeSearchText.InnerHtml = textTable.Rows(19)("TextParamValue")
			FirstNameSearchText.InnerHtml = defaultTextTable.Rows(16)("TextParamValue")
			LastNameSearchText.InnerHtml = defaultTextTable.Rows(17)("TextParamValue")
			GroupSearchText.InnerHtml = textTable.Rows(18)("TextParamValue")
			SubmitForm.Text = defaultTextTable.Rows(92)("TextParamValue")
			SelectShop.InnerHtml = "Select Shop"
			
			CurrentDate.YearType = GlobalParam.YearType
			CurrentDate.FormName = "Doc"
			CurrentDate.StartYear = GlobalParam.StartYear
			CurrentDate.EndYear = GlobalParam.EndYear
		CurrentDate.LangID = Session("LangID")
		CurrentDate.Lang_Data = LangDefault
		CurrentDate.Culture = CultureString
		
		ToDate.YearType = GlobalParam.YearType
			ToDate.FormName = "DocTo"
			ToDate.StartYear = GlobalParam.StartYear
			ToDate.EndYear = GlobalParam.EndYear
			ToDate.LangID = Session("LangID")
			
			Dim outputString,FormSelected As String
			Dim i As Integer
			
			If IsNumeric(Request.Form("Doc_Day")) Then 
				Session("DocDay") = Request.Form("Doc_Day")
			Else If IsNumeric(Request.QueryString("Doc_Day")) Then 
				Session("DocDay") = Request.QueryString("Doc_Day")
			Else If Trim(Session("DocDay")) = "" Then
			Session("DocDay") = DateTime.Now.Day
		Else If Trim(Session("DocDay")) = 0 And Not Page.IsPostBack Then
			Session("DocDay") = DateTime.Now.Day
			End If
			If Page.IsPostBack AND Request.Form("Doc_Day") = "" Then Session("DocDay") = 0
			CurrentDate.SelectedDay = Session("DocDay")
			
			
			If IsNumeric(Request.Form("Doc_Month")) Then 
				Session("Doc_Month") = Request.Form("Doc_Month")
			Else If IsNumeric(Request.QueryString("Doc_Month")) Then 
				Session("Doc_Month") = Request.QueryString("Doc_Month")
			Else If Trim(Session("Doc_Month")) = "" Then
			Session("Doc_Month") = DateTime.Now.Month
		Else If Trim(Session("Doc_Month")) = 0 And Not Page.IsPostBack Then
			Session("Doc_Month") = DateTime.Now.Month
			End If
			If Page.IsPostBack AND Request.Form("Doc_Month") = "" Then Session("Doc_Month") = 0
			CurrentDate.SelectedMonth = Session("Doc_Month")
			
			If IsNumeric(Request.Form("Doc_Year")) Then 
				Session("Doc_Year") = Request.Form("Doc_Year")
			Else If IsNumeric(Request.QueryString("Doc_Year")) Then 
				Session("Doc_Year") = Request.QueryString("Doc_Year")
			Else If Trim(Session("Doc_Year")) = "" Then
			Session("Doc_Year") = DateTime.Now.Year
		Else If Trim(Session("Doc_Year")) = 0 And Not Page.IsPostBack Then
			Session("Doc_Year") = DateTime.Now.Year
			End If
			If Page.IsPostBack AND Request.Form("Doc_Year") = "" Then Session("Doc_Year") = 0
			CurrentDate.SelectedYear = Session("Doc_Year")
			
			If IsNumeric(Request.Form("DocTo_Day")) Then 
				Session("DocTo_Day") = Request.Form("DocTo_Day")
			Else If IsNumeric(Request.QueryString("DocTo_Day")) Then 
				Session("DocTo_Day") = Request.QueryString("DocTo_Day")
			Else If Trim(Session("DocTo_Day")) = "" Then
			Session("DocTo_Day") = DateTime.Now.Day
		Else If Trim(Session("DocTo_Day")) = 0 And Not Page.IsPostBack Then
			Session("DocTo_Day") = DateTime.Now.Day
			End If
			If Page.IsPostBack AND Request.Form("DocTo_Day") = "" Then Session("DocTo_Day") = 0
			ToDate.SelectedDay = Session("DocTo_Day")
			
			
			If IsNumeric(Request.Form("DocTo_Month")) Then 
				Session("DocTo_Month") = Request.Form("DocTo_Month")
			Else If IsNumeric(Request.QueryString("DocTo_Month")) Then 
				Session("DocTo_Month") = Request.QueryString("DocTo_Month")
			Else If Trim(Session("DocTo_Month")) = "" Then
			Session("DocTo_Month") = DateTime.Now.Month
		Else If Trim(Session("DocTo_Month")) = 0 And Not Page.IsPostBack Then
			Session("DocTo_Month") = DateTime.Now.Month
			End If
			If Page.IsPostBack AND Request.Form("DocTo_Month") = "" Then Session("DocTo_Month") = 0
			ToDate.SelectedMonth = Session("DocTo_Month")
			
			If IsNumeric(Request.Form("DocTo_Year")) Then 
				Session("DocTo_Year") = Request.Form("DocTo_Year")
			Else If IsNumeric(Request.QueryString("DocTo_Year")) Then 
				Session("DocTo_Year") = Request.QueryString("DocTo_Year")
			Else If Trim(Session("DocTo_Year")) = "" Then
			Session("DocTo_Year") = DateTime.Now.Year
		Else If Trim(Session("DocTo_Year")) = 0 And Not Page.IsPostBack Then
			Session("DocTo_Year") = DateTime.Now.Year
			End If
			If Page.IsPostBack AND Request.Form("DocTo_Year") = "" Then Session("DocTo_Year") = 0
			ToDate.SelectedYear = Session("DocTo_Year")
			
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
			
			If Request.QueryString("DisplayOnly") = "yes" Then
				GenResult(Request.QueryString("StartDate"),Request.QueryString("EndDate"),"-1","","","",Request.QueryString("ShopID"),2,1, objCnn)
				DisplayCriteria.Visible = False
			End If

		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
	Else
		updateMessage.Text = "Access Denied"
	End If
End Sub

Sub DoSearch(Source As Object, E As EventArgs)
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	Dim ReportDate,StartDate,EndDate As String
	Dim FoundError As Boolean = False
	DateError.Visible = False
	StartDate = ""
	EndDate = ""
	If FilterDate.Checked = True Then
		Try
			StartDate = DateTimeUtil.FormatDate(Request.Form("Doc_Day"),Request.Form("Doc_Month"),Request.Form("Doc_Year"))
			Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
			CheckDate = DateAdd("d",1,CheckDate)
			EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))
			
			If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
				FoundError = True
				DateError.Visible = True
			Else
				Dim SDate1 As New Date(Request.Form("Doc_Year"), Request.Form("Doc_Month"), Request.Form("Doc_Day"))
				Dim EDate1 As New Date(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"))
				ReportDate = DateTimeUtil.FormatDateTime(SDate1, "DateOnly",Session("LangID"),objCnn) + " - " + DateTimeUtil.FormatDateTime(EDate1, "DateOnly",Session("LangID"),objCnn)
			End If
		Catch ex As Exception
			FoundError = True
			DateError.Visible = True
		End Try
	End If	
	If FoundError = False Then
		GenResult(StartDate,EndDate,Request.Form("MemberGroupID"),Request.Form("MemberCode"),Request.Form("MemberFirstName"),Request.Form("MemberLastName"),Request.Form("ShopID"),OrderBy.SelectedItem.Value,DisplayOption.SelectedItem.Value, objCnn)
	End If
	
End Sub

Public Function GenResult(ByVal StartDate As String, ByVal EndDate As String, ByVal MemberGroupID As String, ByVal MemberCode As String, ByVal MemberFirstName As String, ByVal MemberLastName As String, ByVal ShopID As String, ByVal OrderBy As Integer, ByVal DisplayOpt As Integer, ByVal objCnn As MySqlConnection) As String
	
	Dim dtTable As New DataTable()
	dtTable = GetPackageSummary(StartDate,EndDate,MemberGroupID,MemberCode,MemberFirstName,MemberLastName,ShopID,OrderBy, objCnn)
	
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
	Dim sumTotalUsed As Double = 0
	Dim i As integer
	Dim outputString As String = ""
	Dim DisplayRecord As Boolean
	Dim BgColor,ExpireText As String
	For i = 0 to dtTable.Rows.Count - 1
	  If Not IsDBNull(dtTable.Rows(i)("totalNum")) AND Not IsDBNull(dtTable.Rows(i)("totalUsed")) Then
	  	totalRemaining = dtTable.Rows(i)("totalNum") - dtTable.Rows(i)("totalUsed")
	  Else
	  	totalRemaining = 0
	  End If
	  DisplayRecord = True
	  If DisplayOpt = 2 AND totalRemaining <= 0 Then
	  	DisplayRecord = False
	  ElseIf DisplayOpt = 3 AND totalRemaining > 0 Then
	  	DisplayRecord = False
	  End If
	  
	  If totalRemaining = 0 Then
	  		BgColor = "#ccffff"
	  Else	
	  		BgColor = "white"
	  End If
	  
	  ExpireText = "smallText"
	  If Not IsDBNull(dtTable.Rows(i)("ExpireDate")) Then
			If DateTime.Compare(dtTable.Rows(i)("ExpireDate").AddDays(1),Now()) < 0 Then
				ExpireText = "smallRedText"
			End If
	  End If
	  
	  If ExpireText = "smallRedText" Then
	  		BgColor = "f0f0f0"
	  End If
	  
	  If DisplayRecord = True Then
		outputString += "<tr bgColor=""" + BgColor + """>"
		outputString += "<td align=""left"" class=""smallText"">" + "<a class=""smallText"" href=""JavaScript: newWindow = window.open( '../reports/PackageDetail.aspx?PackageID=" + dtTable.Rows(i)("PackageID").ToString + "&ProductLevelID=" + dtTable.Rows(i)("ProductLevelID").ToString + "&ShowCommission=0&ShowPrice=1', '', 'width=800,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + dtTable.Rows(i)("ProductName") + "</a>" + "</td>"
		
		If Not IsDBNull(dtTable.Rows(i)("MemberID")) Then
			outputString += "<td class=""smallText""><a class=""smallText"" href=""JavaScript: newWindow = window.open( '../members/member_stat.aspx?MemberID=" + dtTable.Rows(i)("MemberID").ToString + "', '', 'width=950,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & dtTable.Rows(i)("MemberFullName") & "</a></td>"
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
			outputString += "<td align=""left"" class=""smallText""><a class=""smallText"" href=""JavaScript: newWindow = window.open( 'BillDetails.aspx?ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & RText & "</a></td>"
		Else
			outputString += "<td align=""left"" class=""smallText"">" & RText & "</td>"
		End If
		If Not IsDBNull(dtTable.Rows(i)("SaleDate")) Then
			outputString += "<td align=""left"" class=""smallText"">" & DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly") & "</td>"
		Else
			outputString += "<td align=""left"" class=""smallText"">" & "-" & "</td>"
		End If
		If Not IsDBNull(dtTable.Rows(i)("SalePrice")) Then
			outputString += "<td align=""right"" class=""smallText"">" & Format(dtTable.Rows(i)("SalePrice"),"##,##0.00") & "</td>"
		Else
			outputString += "<td align=""right"" class=""smallText"">" & "-" & "</td>"
		End If
		
		outputString += "<td align=""right"" class=""smallText"">" & totalRemaining.ToString & "</td>"
		outputString += "<td align=""right"" class=""smallText"">" & dtTable.Rows(i)("totalUsed") & "</td>"
		
		If Not IsDBNull(dtTable.Rows(i)("SalePrice")) AND Not IsDBNull(dtTable.Rows(i)("RemainingPrice")) Then
			outputString += "<td align=""right"" class=""smallText"">" & Format(dtTable.Rows(i)("SalePrice")-dtTable.Rows(i)("RemainingPrice"),"##,##0.00") & "</td>"
		Else
			outputString += "<td align=""right"" class=""smallText"">" & "-" & "</td>"
		End If
		
		If Not IsDBNull(dtTable.Rows(i)("RemainingPrice")) Then
			outputString += "<td align=""right"" class=""smallText"">" & Format(dtTable.Rows(i)("RemainingPrice"),"##,##0.00") & "</td>"
		Else
			outputString += "<td align=""right"" class=""smallText"">" & "N/A" & "</td>"
		End If
		
		
		If Not IsDBNull(dtTable.Rows(i)("ExpireDate")) Then
			outputString += "<td align=""right"" class=""" + ExpireText + """>" & DateTimeUtil.FormatDateTime(dtTable.Rows(i)("ExpireDate"),"DateOnly") & "</td>"
		Else
			outputString += "<td align=""right"" class=""smallText"">-</td>"
		End If
		
		If Not IsDBNull(dtTable.Rows(i)("RemainingPrice")) Then
			sumTotalDB += dtTable.Rows(i)("RemainingPrice")
		End If
		If Not IsDBNull(dtTable.Rows(i)("SalePrice")) Then
			sumTotalCurrent += dtTable.Rows(i)("SalePrice")
		End If
		If Not IsDBNull(dtTable.Rows(i)("RemainingPrice")) AND Not IsDBNull(dtTable.Rows(i)("SalePrice")) Then
			sumTotalUsed += dtTable.Rows(i)("SalePrice") - dtTable.Rows(i)("RemainingPrice")
		End If

		outputString += "</tr>"
	  End If
	Next
	If Trim(outputString) <> "" Then
		outputString += "<tr bgColor=""" + GlobalParam.GrayBGColor + """><td colspan=""4"" align=""right"" class=""smallText"">" + "Total Sale" + "</td><td class=""smallText"" align=""right"">" + Format(sumTotalCurrent,"##,##0.00") + "</td><td colspan=""2"" class=""smallText"" align=""right"">Total</td><td align=""right"" class=""smallText"">" + Format(sumTotalUsed,"##,##0.00") + "</td><td align=""right"" class=""smallText"">" + Format(sumTotalDB,"##,##0.00") + "</td><td></td></tr>"
	End If
	ResultText.InnerHtml = outputString
End Function		

Public Overloads Function GetPackageSummary(ByVal StartDate As String, ByVal EndDate As String, ByVal MemberGroupID As String, ByVal MemberCode As String, ByVal MemberFirstName As String, ByVal MemberLastName As String, ByVal ShopList As String, ByVal OrderBy As Integer, ByVal objCnn As MySqlConnection) As DataTable
            Dim sqlStatement As String
            Dim AdditionalQuery As String = ""

            Dim BranchStr, StrBefore As String
            Dim ii As Integer
            Dim getProp As New CPreferences

            Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
            If PropertyInfo.Rows(0)("ImportDataToCopyTable") = 1 Then
                For ii = 1 To 4 - Len(ShopList.ToString)
                    StrBefore = StrBefore & "0"
                Next
                BranchStr = StrBefore & ShopList.ToString
            Else
                BranchStr = ""
            End If

            Dim OrderByParam As String = " Order By c.ProductName, h.MemberFirstName, h.MemberLastName"
            If OrderBy = 1 Then
                OrderByParam = " Order By h.MemberFirstName, h.MemberLastName, a.PackageFirstName, a.PackageLastName, c.ProductName"
			ElseIf OrderBy = 2 Then
				OrderByParam = " Order By ot.ReceiptYear,ot.ReceiptMonth,ot.ReceiptID, h.MemberFirstName, h.MemberLastName"
            End If

            If Trim(ShopList) <> "" Then
                AdditionalQuery += " AND a.ProductLevelID IN (" + ShopList + ")"
            End If

            If Trim(MemberCode) <> "" Then
                AdditionalQuery += " AND h.MemberCode LIKE '%" + Trim(Replace(MemberCode, "'", "''")) + "%'"
            End If

            If Trim(MemberFirstName) <> "" Then
                AdditionalQuery += " AND h.MemberFirstName LIKE '%" + Trim(Replace(MemberFirstName, "'", "''")) + "%'"
            End If

            If Trim(MemberLastName) <> "" Then
                AdditionalQuery += " AND h.MemberLastName LIKE '%" + Trim(Replace(MemberLastName, "'", "''")) + "%'"
            End If

            If Trim(MemberGroupID) <> "" Then
                If MemberGroupID <> "-1" And MemberGroupID <> 0 Then
                    AdditionalQuery += " AND h.MemberGroupID=" + MemberGroupID
                End If
            End If
			
			If StartDate <> "" And EndDate <> "" Then
                AdditionalQuery += " AND (ot.SaleDate >= " + StartDate + " AND ot.SaleDate < " + EndDate + ")"
            End If
			
            If Trim(AdditionalQuery) = "" And MemberGroupID <> "-1" Then
                AdditionalQuery = " And 0=1"
            End If
			
			Dim ShopInfo As DataTable = objDB.List("select * from ProductLevel where ProductLevelID IN (" + ShopList + ")", objCnn)
            Dim DisplayVATType As String = "E"
			For ii = 0 To ShopInfo.Rows.Count - 1
				If ShopInfo.Rows(ii)("DisplayReceiptVATableType") = 1 Then
					DisplayVATType = "V"
				End If
			Next
			
			If DisplayVATType = "V" Then
           	 	sqlStatement = "select PackageID,ProductLevelID,sum(PackageStatus) AS totalUsed, count(PackageStatus) AS totalNum, SUM((1-PackageStatus)*(CommissionPrice+CommissionPriceVAT)) AS RemainingPrice FROM PackageHistory GROUP BY PackageID,ProductLevelID"
			Else
				sqlStatement = "select PackageID,ProductLevelID,sum(PackageStatus) AS totalUsed, count(PackageStatus) AS totalNum, SUM((1-PackageStatus)*(CommissionPrice)) AS RemainingPrice FROM PackageHistory GROUP BY PackageID,ProductLevelID"
			End If

            objDB.sqlExecute("DROP TABLE IF EXISTS DummyPackage", objCnn)
            objDB.sqlExecute("create table DummyPackage (PackageID int, ProductLevelID int, totalUsed int, totalNum int, RemainingPrice decimal(18,4))", objCnn)
            objDB.sqlExecute("insert into DummyPackage " + sqlStatement, objCnn)

            sqlStatement = "SELECT a.ProductCode,c.ProductName,a.PackageID,a.ProductLevelID,a.ExpireDate,a.TransactionID,a.ComputerID,ot.ReceiptID,ot.ReceiptMonth,ot.ReceiptYear,ot.SaleDate,DocumentTypeHeader, dp.totalUsed, dp.totalNum, h.MemberID, h.MemberCode, CONCAT(h.MemberFirstName, ' ',h.MemberLastName) AS MemberFullName, CONCAT(a.PackageFirstName, ' ',a.PackageLastName) AS PackageFullName ,g.SalePrice, dp.RemainingPrice FROM PackageDetail a, Products c, ProductDept d, ProductGroup e, ProductLevel f left outer join PackageHistory b ON a.PackageID=b.PackageID AND a.ProductLevelID=b.ProductLevelID left outer join OrderDiscountDetail" + BranchStr + " g ON a.OrderDetailID=g.OrderDetailID AND a.TransactionID=g.TransactionID AND a.ComputerID=g.ComputerID left outer join OrderTransaction" + BranchStr + " ot ON a.TransactionID=ot.TransactionID AND a.ComputerID=ot.ComputerID left outer join Members h ON a.MemberID=h.MemberID left outer join DummyPackage dp ON a.PackageID=dp.PackageID AND a.ProductLevelID=dp.ProductLevelID left outer join DocumentType z ON ot.CloseComputerID=z.ComputerID AND z.LangID=1 AND z.DocumentTypeID=8 WHERE  a.ProductCode=c.ProductCode AND c.ProductDeptID=d.ProductDeptID AND d.ProductGroupID=e.ProductGroupID AND e.ProductLevelID=f.ProductLevelID AND a.ProductLevelID=f.ProductLevelID AND a.Deleted=0 And c.Deleted=0 AND h.Deleted=0 AND (PackageStatus>=0 Or PackageStatus is NULL) " + AdditionalQuery + " GROUP BY a.ProductCode,c.ProductName,a.PackageID,a.ProductLevelID,a.ExpireDate,a.TransactionID,a.ComputerID,ot.ReceiptID,ot.ReceiptMonth,ot.ReceiptYear,DocumentTypeHeader " + OrderByParam
            Dim getData As DataTable = objDB.List(sqlStatement, objCnn)
            objDB.sqlExecute("DROP TABLE IF EXISTS DummyPackage", objCnn)
            Return getData

        End Function
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
