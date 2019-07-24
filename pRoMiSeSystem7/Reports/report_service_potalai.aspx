<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Service Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body<% = GlobalParam.BodyProp %>>
<div id="showPage" visible="true" runat="server">
<form runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><b class="headerText"><div class="headerText" align="left" id="HeaderText" runat="server" /></b></div>
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
<div class="noprint">
<table border="0">
<tr id="ShowShop" runat="server">
	<td colspan="2"><span id="SelectShop" class="text" runat="server"></span></td>
	<td colspan="3"><span id="ShopText" runat="server"></span></td>
	<td colspan="2"><span id="MemberFirstNameText" class="text" runat="server" /><br><asp:TextBox ID="MemberFirstName" Width="100" CssClass="text" runat="server" /></td>
	<td><span id="MemberLastNameText" class="text" runat="server" /><br><asp:TextBox ID="MemberLastName" Width="100" CssClass="text" runat="server" /></td>
</tr>
<tr>
	<td align="right" valign="middle"><div id="DocumentDateParam" class="text" runat="server"></div></td>
	<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
	<td><synature:date id="MonthYearDate" runat="server" /></td>
	<td>&nbsp;</td>
	<td><asp:radiobutton ID="Radio_2" GroupName="Group1" runat="server" /></td>
	<td><synature:date id="CurrentDate" runat="server" /></td>
	<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
	<td><synature:date id="ToDate" runat="server" /></td>

</tr>

<tr>
	<td colspan="2">&nbsp;</td>
	<td colspan="2"><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
	<td class="text" colspan="4"><asp:radiobutton ID="Radio_3" GroupName="Group2" runat="server" Checked="true" /> <asp:radiobutton ID="Radio_4" GroupName="Group2" runat="server" /> <asp:CheckBox ID="DisplayAll" runat="server" /></td>
</tr>

</table>
</div>
<br>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
<tr>
	<td><div id="ResultSearchText" class="boldText" runat="server"></div></td>
</tr>
</table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td id="headerTD9" align="center" class="tdHeader" runat="server"><div id="Text9" runat="server"></div></td>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="Text5" runat="server"></div></td>	
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="Text6" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Text4" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>
</table>
</form>
</div>
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
Dim getInfo As New CCategory()
Dim getPageText As New DefaultText()
Dim getStaffRole As New CStaffRole()
Dim DateTimeUtil As New MyDateTime()
Dim commInfo As New CPromotions()
Dim getProp As New CPreferences()
Dim FormatDocNumber As New FormatText()
Dim userInfo As New CMembers()
Dim objDB As New CDBUtil()

		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_Service") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")

		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
	  	headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor
		headerTD6.BgColor = GlobalParam.AdminBGColor
		headerTD9.BgColor = GlobalParam.AdminBGColor
		
		Radio_3.Visible = False
		Radio_4.Visible = False
		
		MemberFirstNameText.InnerHtml = "Member First Name"
		MemberLastNameText.InnerHtml = "Member Last Name"
		Radio_3.Text = "Group By Staff"
		Radio_4.Text = "Group By Member"
		DisplayAll.Text = "Display All Items"
		CurrentDate.YearType = GlobalParam.YearType
		CurrentDate.FormName = "Doc"
		CurrentDate.StartYear = GlobalParam.StartYear
		CurrentDate.EndYear = GlobalParam.EndYear
		CurrentDate.LangID = Session("LangID")
		
		ToDate.YearType = GlobalParam.YearType
		ToDate.FormName = "DocTo"
		ToDate.StartYear = GlobalParam.StartYear
		ToDate.EndYear = GlobalParam.EndYear
		ToDate.LangID = Session("LangID")
		
		MonthYearDate.YearType = GlobalParam.YearType
		MonthYearDate.FormName = "MonthYearDate"
		MonthYearDate.StartYear = GlobalParam.StartYear
		MonthYearDate.EndYear = GlobalParam.EndYear
		MonthYearDate.LangID = Session("LangID")
		MonthYearDate.ShowDay = False
		
		ResultText.InnerHtml = ""
		ResultSearchText.InnerHtml = ""
		errorMsg.InnerHtml = ""
		
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
		
		If IsNumeric(Request.Form("MonthYearDate_Day")) Then 
			Session("MonthYearDate_Day") = Request.Form("MonthYearDate_Day")
		Else If IsNumeric(Request.QueryString("MonthYearDate_Day")) Then 
			Session("MonthYearDate_Day") = Request.QueryString("MonthYearDate_Day")
		Else If Trim(Session("MonthYearDate_Day")) = "" Then
			Session("MonthYearDate_Day") = DateTime.Now.Day
		Else If Trim(Session("MonthYearDate_Day")) = 0 And Not Page.IsPostBack Then
			Session("MonthYearDate_Day") = DateTime.Now.Day
		End If
		If Page.IsPostBack AND Request.Form("MonthYearDate_Day") = "" Then Session("MonthYearDate_Day") = 0
		MonthYearDate.SelectedDay = Session("MonthYearDate_Day")
		
		
		If IsNumeric(Request.Form("MonthYearDate_Month")) Then 
			Session("MonthYearDate_Month") = Request.Form("MonthYearDate_Month")
		Else If IsNumeric(Request.QueryString("MonthYearDate_Month")) Then 
			Session("MonthYearDate_Month") = Request.QueryString("MonthYearDate_Month")
		Else If Trim(Session("MonthYearDate_Month")) = "" Then
			Session("MonthYearDate_Month") = DateTime.Now.Month
		Else If Trim(Session("MonthYearDate_Month")) = 0 And Not Page.IsPostBack Then
			Session("MonthYearDate_Month") = DateTime.Now.Month
		End If
		If Page.IsPostBack AND Request.Form("MonthYearDate_Month") = "" Then Session("MonthYearDate_Month") = 0
		MonthYearDate.SelectedMonth = Session("MonthYearDate_Month")
		
		If IsNumeric(Request.Form("MonthYearDate_Year")) Then 
			Session("MonthYearDate_Year") = Request.Form("MonthYearDate_Year")
		Else If IsNumeric(Request.QueryString("MonthYearDate_Year")) Then 
			Session("MonthYearDate_Year") = Request.QueryString("MonthYearDate_Year")
		Else If Trim(Session("MonthYearDate_Year")) = "" Then
			Session("MonthYearDate_Year") = DateTime.Now.Year
		Else If Trim(Session("MonthYearDate_Year")) = 0 And Not Page.IsPostBack Then
			Session("MonthYearDate_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("MonthYearDate_Year") = "" Then Session("MonthYearDate_Year") = 0
		MonthYearDate.SelectedYear = Session("MonthYearDate_Year")
		
		If Not Page.IsPostBack Then
			Radio_2.Checked = True
		End If

		Dim ShopIDValue As String = "0"
		If IsNumeric(Request.Form("ShopID")) Then
			ShopIDValue = Request.Form("ShopID").ToString
		Else If IsNumeric(Request.QueryString("ShopID"))
			ShopIDValue = Request.QueryString("ShopID").ToString
		End If
			
			
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(13,Session("LangID"),objCnn)
			Dim textTable1 As New DataTable()
			textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			DocumentDateParam.InnerHtml = textTable.Rows(5)("TextParamValue")
			SubmitForm.Text = textTable.Rows(8)("TextParamValue")
			Text1.InnerHtml = "Staff Name"
			Text2.InnerHtml = "Service/Product"
			Text6.InnerHtml = "Price"
			Text5.InnerHtml = "Customer Name"
			Text3.InnerHtml = "Qty"
			Text4.InnerHtml = "Service Time"
			Text9.InnerHtml = "Receipt #"
			SelectShop.InnerHtml = "Select Shop"
			DocumentToDateParam.InnerHtml = defaultTextTable.Rows(91)("TextParamValue")
			
			HeaderText.InnerHtml = "Service Report"

			
			Dim i As Integer
			Dim outputString,FormSelected,compareString As String
			Dim SelectString As String 
			
			Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
			If ShopData.Rows.Count > 0 Then

				outputString = "<select name=""ShopID"">"
				For i = 0 to ShopData.Rows.Count - 1
					If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
						FormSelected = "selected"
					Else
						FormSelected = ""
					End If
					outputString += "<option value=""" & ShopData.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & ShopData.Rows(i)("ProductLevelName")
				Next
				outputString += "</select>"
				ShopText.InnerHtml = outputString
				ShowShop.Visible = True
			Else
				ShowShop.Visible = False
			End If
					
		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
	  
	Else
		showPage.Visible = False
		errorMsg.InnerHtml = "Access Denied"
	End If
End Sub

Sub DoSearch(Source As Object, E As EventArgs)
	
	Dim FoundError As Boolean
	FoundError = False
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(12,Session("LangID"),objCnn)
			
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""

	If Radio_2.Checked = True Then

		DateFromValue = DateTimeUtil.FormatDate(Request.Form("Doc_Day"),Request.Form("Doc_Month"),Request.Form("Doc_Year"))
		
		DateToValue = DateTimeUtil.FormatDate(Request.Form("DocTo_Day"),Request.Form("DocTo_Month"),Request.Form("DocTo_Year"))
		
		If Trim(DateFromValue) = "InvalidDate" Or Trim(DateToValue) = "InvalidDate" Then
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + defaultTextTable.Rows(45)("TextParamValue") + "</td></tr></table>"
			FoundError = True
			DateFromValue = ""
			DateToValue = ""
		Else
			ResultSearchText.InnerHtml = ""
		End If
		
	Else
		DateFromValue = ""
		DateToValue = ""
	End If
	
	If FoundError = False Then
		ShowPrint.Visible = True
		If Radio_4.Checked = True Then
			Text1.InnerHtml = "Member Name"
			Text5.InnerHtml = "Staff Name"
		Else
			Text5.InnerHtml = "Member Name"
			Text1.InnerHtml = "Staff Name"
		End If
		Dim displayTable As New DataTable()
		
		Dim i,j As Integer
		Dim DateCheck As Boolean

		Dim outputString As String = ""
		Dim counter As Integer
		Dim DummyText,ExtraText As String
		Dim DummySaleDate As Date
		Dim ShowSaleDate As String = ""
		Dim DummyStaffID As Integer
		Dim bgColor As String = "e9e9e9"
		Dim FullName,DurationTime As String 
		Dim dt,dt2 As DateTime
		Dim DummyMember As String
		Dim MemberName As String
		Dim CompareMember As String

		Dim dtTable As DataTable = ServiceReports(Trim(MemberFirstName.Text),Trim(MemberLastName.Text),Radio_1.Checked, Radio_2.Checked, Radio_3.Checked, Radio_4.Checked, DisplayAll.Checked, Request.Form("MonthYearDate_Month"), Request.Form("MonthYearDate_Year"), DateFromValue, DateToValue, Request.Form("ShopID"), Session("LangID"), objCnn)
		
		Dim AdditionalHeaderText, HText, RText As String
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

		Dim ReceiptHeaderData As DataTable
		ReceiptHeaderData = getInfo.GetDocType(1, 0, 8, 1, objCnn)

		If ReceiptHeaderData.Rows.Count > 0 Then
			If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
				AdditionalHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
			End If
		End If
		
		Dim staffData As DataTable
		Dim StaffFullName As String
		For i=0 To dtTable.Rows.Count - 1
				
			If dtTable.Rows(i)("SaleDate") <> DummySaleDate Then
				ShowSaleDate = DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly")
				outputString += "<tr><td colspan=""7"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + ShowSaleDate + "</td></tr>"
				DummyStaffID=0
				DummyMember = ""
				bgColor = "e9e9e9"
			End If
			
			If bgColor = "white" Then
				bgColor = "e9e9e9"
			Else
				bgColor = "white"
			End If
			
			If dtTable.Rows(i)("OrderStatusID") = 3 Then
				bgColor = "f4592d"
			End If
			outputString += "<tr bgcolor=""" + bgColor + """>"
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
				outputString += "<td align=""left"" class=""text""><a href=""JavaScript: newWindow = window.open( 'BillDetails.aspx?ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & RText & "</a></td>"
			Else
				outputString += "<td align=""left"" class=""text"">" & RText & "</td>"
			End If	
			
			DurationTime = "N/A"
			StaffFullName = ""
			staffData = GetServiceStaff(dtTable.Rows(i)("TransactionID"),dtTable.Rows(i)("ComputerID"),dtTable.Rows(i)("OrderDetailID"),objCnn)
			If staffData.Rows.Count > 0 Then
				If Not IsDBNull(staffData.Rows(0)("StartTime")) Then
					dt = staffData.Rows(0)("StartTime")
					dt2 = dt.AddMinutes(staffData.Rows(0)("DurationTime"))
					DurationTime = dt.ToString("HH:mm") + " - " + dt2.ToString("HH:mm")
				End If
				For j = 0 to staffData.Rows.Count - 1
					If StaffFullName <> "" AND j > 0 Then
						StaffFullName += "<br>"
					End If
					If Not IsDBNull(staffData.Rows(j)("StaffFirstName")) Then
						StaffFullName += staffData.Rows(j)("StaffFirstName")
					End If
					If Not IsDBNull(staffData.Rows(j)("StaffLastName")) Then
						StaffFullName += " " + staffData.Rows(j)("StaffLastName")
					End If
				Next
			End If
			
			outputString += "<td align=""left"" class=""text"">" & StaffFullName & "</td>"
			
			If Not IsDBNull(dtTable.Rows(i)("MemberFullName")) Then
				MemberName = dtTable.Rows(i)("MemberFullName")
			Else
				MemberName = ""
			End If
			If dtTable.Rows(i)("MemberDiscountID") = 0 Then
				ExtraText = MemberName
			ElseIf Session("Member_Info") Then
				ExtraText =  "<a href=""JavaScript: newWindow = window.open( '../members/member_stat.aspx?MemberID=" + dtTable.Rows(i)("MemberDiscountID").ToString + "', '', 'width=950,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & MemberName & "</a>"
			Else
				ExtraText = MemberName
			End If
			outputString += "<td align=""left"" class=""text"">" & ExtraText & "</td>"
			
			If Not IsDBNull(dtTable.Rows(i)("ProductName")) Then
				outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("ProductName") & "</td>"
			Else
				outputString += "<td align=""left"" class=""text"">" & "N/A" & "</td>"
			End If
			outputString += "<td align=""right"" class=""text"">" & Format(dtTable.Rows(i)("Amount"),"##,##0.0") & "</td>"
			outputString += "<td align=""right"" class=""text"">" & Format(dtTable.Rows(i)("SalePrice"),"##,##0.00") & "</td>"
			outputString += "<td align=""right"" class=""text"">" & DurationTime & "</td>"
			
			outputString += "</tr>"
			counter = counter + 1
			DummySaleDate = dtTable.Rows(i)("SaleDate")
		Next
		If dtTable.Rows.Count = 0 Then
			outputString = "<tr><td class=""boldText"" colspan=""4"">No Data Found</td></tr>"
		End If
		ResultText.InnerHtml = outputString

	End If
End Sub

Public Function GetServiceStaff(ByVal TransactionID As Integer, ByVal ComputerID As Integer, ByVal OrderDetailID As Integer, ByVal objCnn As MySqlConnection) As DataTable
            Dim sqlStatement As String
            Dim AdditionalQuery As String = " AND TransactionID=" + TransactionID.ToString + " AND ComputerID=" + ComputerID.ToString + " AND OrderDetailID=" + OrderDetailID.ToString

            sqlStatement = "SELECT s.StaffFirstName,s.StaffLastName,a.StartTime,a.DurationTime FROM OrderStaffDetail a LEFT OUTER JOIN Staffs s ON a.StaffID=s.StaffID WHERE 0=0 " + AdditionalQuery
            Return objDB.List(sqlStatement, objCnn)
        End Function
		
Public Function ServiceReports(ByVal MemberFirstName As String, ByVal MemberLastName As String, ByVal Radio1 As Boolean, ByVal Radio2 As Boolean, ByVal Radio3 As Boolean, ByVal Radio4 As Boolean, ByVal DisplayAll As Boolean, ByVal selMonth As Integer, ByVal selYear As Integer, ByVal DateFrom As String, ByVal DateTo As String, ByVal ShopID As Integer, ByVal LangID As Integer, ByVal objCnn As MySqlConnection) As DataTable
            Dim sqlStatement As String
            Dim AdditionalQuery As String = ""
            Dim ShopIDListValue As String

            Dim BranchStr, StrBefore As String
            Dim ii As Integer
            Dim getProp As New CPreferences

            Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
            If PropertyInfo.Rows(0)("ImportDataToCopyTable") = 1 Then
                For ii = 1 To 4 - Len(ShopID.ToString)
                    StrBefore = StrBefore & "0"
                Next
                BranchStr = StrBefore & ShopID.ToString
            Else
                BranchStr = ""
            End If

            If ShopID > 0 Then
                AdditionalQuery += " AND a.ShopID IN (" + ShopID.ToString + ")"
            End If

            If Trim(MemberFirstName) <> "" Then
                AdditionalQuery += " AND e.MemberFirstName LIKE '%" + MemberFirstName + "%'"
            End If

            If Trim(MemberLastName) <> "" Then
                AdditionalQuery += " AND e.MemberLastName LIKE '%" + MemberLastName + "%'"
            End If

            If DisplayAll = False Then
                AdditionalQuery += " AND b.ProductSetType IN (3,-1,-3,-4,-13,9) " '" AND c.StaffID is not NULL"
            End If

            If Radio1 = True Then
                If selMonth > 0 And IsNumeric(selMonth) Then
                    AdditionalQuery += " AND MONTH(a.SaleDate)=" + selMonth.ToString
                End If
                If selYear > 0 And IsNumeric(selYear) Then
                    AdditionalQuery += " AND YEAR(a.SaleDate)=" + selYear.ToString
                End If
            ElseIf Radio2 = True Then
                If Trim(DateFrom) <> "" And Trim(DateTo) <> "" Then
                    AdditionalQuery += " AND a.SaleDate BETWEEN " + DateFrom + " AND " + DateTo
                End If
            End If
            Dim OrderBy As String = "" '"c.StaffID DESC"
            'If Radio4 = True Then
            'OrderBy = "MemberFullName DESC, c.StaffID DESC"
            'End If
            OrderBy = "a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"
            sqlStatement = "select a.TransactionID,a.ComputerID,b.OrderDetailID,a.ReceiptID,a.ReceiptMonth,a.ReceiptYear,DocumentTypeHeader,a.SaleDate,f.SalePrice,c.StaffID,c.StaffFirstName,c.StaffLastName,b.ProductID, IF(d.ProductName is NULL, CONCAT(""**"",b.OtherFoodName),d.ProductName) AS ProductName,b.Amount,b.StartTime,b.DurationTime,b.OrderStatusID, IF(a.MemberDiscountID = 0, CONCAT(""**"",a.TransactionName), CONCAT( e.MemberFirstName, "" "", e.MemberLastName)) AS MemberFullName, a.MemberDiscountID from ordertransaction" + BranchStr + " a, orderdetail" + BranchStr + " b, orderdiscountdetail" + BranchStr + " f left outer join staffs c on b.StaffID=c.StaffID left outer join products d ON b.ProductID = d.ProductID left outer join Members e ON a.MemberDiscountID=e.MemberID left outer join DocumentType dt ON a.DocType=dt.DocumentTypeID AND a.CloseComputerID=dt.ComputerID where a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID AND b.TransactionID=f.TransactionID AND b.ComputerID=f.ComputerID AND b.OrderDetailID=f.OrderDetailID AND a.TransactionStatusID=2 AND b.OrderStatusID IN (1,3,5) AND dt.LangID=" + LangID.ToString + AdditionalQuery + " order by a.SaleDate," + OrderBy

            Return objDB.List(sqlStatement, objCnn)

        End Function
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
