<%@ Page Language="VB" ContentType="text/html" EnableViewState="True"  debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="CostingClass.pRoMiSeCosting" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<html>
<head>
<title>Ending Stock Report Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script language="JavaScript" src="../StyleSheet/webscript.js"></script> 
</head>
<body>

<div id="ShowContent" visible="false" runat="server">
<form id="mainForm" runat="server">
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Sale Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
<span id="showShop" runat="server">
<tr>
	<td><span id="SelectShop" class="text" runat="server"></span></td>
	<td><span id="ShopText" runat="server"></span></td>
	<td><span id="SelectMonth" class="text" runat="server"></span></td>
	<td><synature:date id="MonthYearDate" runat="server" /></td>
	<td><asp:dropdownlist ID="OrderParam" Width="250" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
	<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
</tr>

</span>
</table>
</div>
<br>
<table width="100%">

<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr>
</table>
<span id="MyTable">
<table width="100%">
<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>

<span id="myTable" visible="false" runat="server">
<span id="startTable" runat="server"></span>
	<span id="headerTextString" runat="server"></span>
	
	<div id="ResultText" runat="server"></div>
</table>
</span></td></tr>
</table></span>
<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
<span id="ResultString" runat="server"></span>
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
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getInfo As New CCategory()
Dim Reports As New ReportV6()
Dim objDB As New CDBUtil()
Dim DateTimeUtil As New MyDateTime()
Dim getReport As New GenReports()
Dim CostInfo As New CostClass()
Dim getProp As New CPreferences
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer  = 998

Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("EndingStock") Then
		
		Try	
			SubmitForm.Attributes.Item("onclick") = "this.disabled=true;" & GetPostBackEventReference(SubmitForm).ToString
			objCnn = getCnn.EstablishConnection()
			ShowContent.Visible = True		
			errorMsg.InnerHtml = ""
		
		StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
			
		Dim z As Integer
		If NOT Request.QueryString("ToLangID") Is Nothing Then
			If IsNumeric(Request.QueryString("ToLangID")) Then
				Session("LangID") = Request.QueryString("ToLangID")
			End If
		End If

		Dim CultureString As String = Util.GetCultureByLangID(Session("LangID"), objCnn)
		Dim PageName as string = System.IO.Path.GetFileName(Request.ServerVariables("SCRIPT_NAME"))
		Dim LangListText As String = ""
		Dim LangListData As DataTable
		Dim LangData As DataTable = getProp.GetLang(LangListText,LangListData,PageName & "?ID" & Request.QueryString("ID") & "&Order=" + Request.QueryString("Order") & "&GroupID=" & Request.QueryString("GroupID"),PageID,1,-1,Request,objCnn)
		Dim LangText As String = "lang" + Session("LangID").ToString
		
		For z = 0 To LangData.Rows.Count - 1
			Dim TestLabel =	Util.FindControlRecursive(mainForm,"LangText" & z)
			Try
				TestLabel.Text = LangData.Rows(z)(LangText)
			Catch ex As Exception
			End Try
		Next
		LangList.Text = LangListText
		
		Dim LangData2 As DataTable = getProp.GetLangData(PageID,2,-1,Request)
		
		Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
		If LangDefault.Rows.Count >= 2 Then
			PrintText.Text = LangDefault.Rows(0)(LangText)
			Export.Text = LangDefault.Rows(1)(LangText)
		End If

		SubmitForm.Text = LangDefault.Rows(3)(LangText)
		
		LangText0.Text = "Ending Stock Report"

			
			MonthYearDate.YearType = GlobalParam.YearType
			MonthYearDate.FormName = "MonthYearDate"
			MonthYearDate.StartYear = GlobalParam.StartYear
			MonthYearDate.EndYear = GlobalParam.EndYear
			MonthYearDate.LangID = Session("LangID")
			MonthYearDate.ShowDay = False
			MonthYearDate.Lang_Data = LangDefault
			MonthYearDate.Culture = CultureString
			
			Dim chk As Boolean = getProp.CheckTableColumn("Materials","MaterialAccountID",objCnn)
			
			Dim AccountCodeExist As Boolean = False
			If chk = False Then
				AccountCodeExist = True
			End If
			
			
			If AccountCodeExist = True Then
				OrderParam.Items(0).Text = "Order By Accounting Code -> Material Code"
				OrderParam.Items(0).Value = "m.MaterialAccountID,m.MaterialCode"
				OrderParam.Items(1).Text = "Order By Accounting Code -> Material Name"
				OrderParam.Items(1).Value = "m.MaterialAccountID,m.MaterialName"
				OrderParam.Items(2).Text = "Order By Group -> Material Code"
				OrderParam.Items(2).Value = "mg.MaterialGroupCode,m.MaterialCode"
				OrderParam.Items(3).Text = "Order By Group -> Material Name"
				OrderParam.Items(3).Value = "mg.MaterialGroupCode,m.MaterialName"
			Else
				OrderParam.Items(0).Text = "Order By Group -> Material Code"
				OrderParam.Items(0).Value = "mg.MaterialGroupCode,m.MaterialCode"
				OrderParam.Items(1).Text = "Order By Group -> Material Name"
				OrderParam.Items(1).Value = "mg.MaterialGroupCode,m.MaterialName"
			End If
			
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
			
			Dim ShopIDValue As String = "0"
			If IsNumeric(Request.Form("ShopID")) Then
				ShopIDValue = Request.Form("ShopID").ToString
			Else If IsNumeric(Request.QueryString("ShopID"))
				ShopIDValue = Request.QueryString("ShopID").ToString
			End If
			
			Dim outputString As String
			Dim i As Integer
			
			Dim FormSelected As String
			Dim ShopData As DataTable = getInfo.GetProductLevel(-99,objCnn)
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
		errorMsg.InnerHtml = "Access Denied"
	End If
End Sub

Sub DoSearch(Source As Object, E As EventArgs)
	Dim FoundError As Boolean
	FoundError = False
	Session("ReportResult") = ""
	Dim LangData2 As DataTable = getProp.GetLangData(PageID,2,-1,Request)
	Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
	Dim LangText As String = "lang" + Session("LangID").ToString
	Dim FormatData As DataTable = Util.FormatParam(FormatObject,Session("LangID"),objCnn)
	Dim ci As New CultureInfo(FormatObject.CultureString)
	myTable.Visible = False
	'Try
	
	Dim SelMonth As Integer = 0
	Dim SelYear As Integer = 0
	If IsNumeric(Request.Form("MonthYearDate_Month")) Then SelMonth = Request.Form("MonthYearDate_Month")
	If IsNumeric(Request.Form("MonthYearDate_Year")) Then SelYear = Request.Form("MonthYearDate_Year")
	
	Dim ShowGroup As Boolean = False
	If Trim(Request.Form("MaterialGroup")) = "" AND (OrderParam.SelectedIndex = 0 Or OrderParam.SelectedIndex = 1) Then
		ShowGroup = True
	End If
	ShowGroup = True
	
	If SelMonth = 0 Or SelYear = 0 Then
		FoundError = True
	End If	
	If FoundError = False Then
		If LangDefault.Rows.Count >= 3 Then
			CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(NOW(), "DateAndTime",Session("LangID"),objCnn)
		End If
		ShowPrint.Visible = True
		myTable.Visible = True
		Dim TestTime,Result As String
		Dim dtTable,groupData As DataTable
		Dim displayTable As New DataTable()
		Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-99,Session("StaffRole"),objCnn)
		Dim TableNameString As String = "DummyMaterialCostTableAllStock"'Session.SessionID + "AllStock"
		
		
		'Application.Lock()
			Result = Reports.EndingStockReport(dtTable,TableNameString,Request.Form("ShopID"),SelMonth, SelYear,Request.Form("OrderParam"),OrderParam.SelectedIndex,objCnn)
		'Application.UnLock()

		Dim ReportDate As String
		Dim SDate As New Date(Request.Form("MonthYearDate_Year"),Request.Form("MonthYearDate_Month"),1)
		ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy",Session("LangID"),objCnn)
		ResultSearchText.InnerHtml = "Ending Stock Report " + " (" + ReportDate + ")"
		Dim i As Integer
		
		Dim ExtraInfo As String
		Dim totalSale As Double = 0
		Dim totalCost As Double = 0
		Dim deptCost As Double = 0
		Dim groupCost As Double = 0
		Dim DummyPGroupID,DummyPDeptID,DummyMGroupID,DummyMDeptID As Integer
		Dim ProductGroupName,ProductDeptName,MaterialGroupName,MaterialDeptName As String
		
		Dim StartDate,EndDate As String
		Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
		If Request.Form("MonthYearDate_Month") = 12 Then
			StartMonthValue = Request.Form("MonthYearDate_Month")
			EndMonthValue = 1
			StartYearValue = Request.Form("MonthYearDate_Year")
			EndYearValue = Request.Form("MonthYearDate_Year") + 1
		Else
			StartMonthValue = Request.Form("MonthYearDate_Month")
			EndMonthValue = Request.Form("MonthYearDate_Month") + 1
			StartYearValue = Request.Form("MonthYearDate_Year")
			EndYearValue = Request.Form("MonthYearDate_Year")
		End If
		StartDate = DateTimeUtil.FormatDate(1,StartMonthValue,StartYearValue)
		EndDate = DateTimeUtil.FormatDate(1,EndMonthValue,EndYearValue)

		Dim totalStandardCost As Double = 0
		Dim SubTotalQty As Double = 0
		Dim GroupTotalPrice As Double = 0
		Dim SubTotalPrice As Double = 0
		Dim TotalPrice As Double = 0
		Dim TotalQty As Double = 0
		Dim EndingSum As Double = 0
		Dim TotalSum As Double = 0
		Dim UnitName As String
		
		Dim HeaderString As String = "<tr>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "No" + "</td>"

		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "รหัสสินค้า" + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "รายละเอียด" + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "ยอดคงเหลือ" + "</td>"


		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "หน่วยนับ" + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "ต้นทุนต่อหน่วย" + "</td>"
		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "ต้นทุน" + "</td>"
		HeaderString += "</tr>"
		headerTextString.InnerHtml = HeaderString
		
		Dim groupString,PriceString,QtyString,StdString As String
		Dim resultString As StringBuilder = New StringBuilder
		Dim showData As Boolean
		Dim j As Integer
		Dim UnitPrice As String
		Dim UnitInfo As DataTable
		Dim PricePerUnit As Double
		
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
		Dim outString As String = ""
		Dim UnitText As String
		Dim UnitRatioVal As Double = 1
		Dim DummyGroupID As Integer = 0
		Dim DummyGroupName As String = ""
		Dim DummyGroupCode As String = ""
		Dim ShowGroupSummary As Boolean 
		Dim ColSpan As Integer
		ColSpan = 6

		For i = 0 to dtTable.Rows.Count - 1
			Dim outputString As StringBuilder = New StringBuilder
			UnitRatioVal = 1
			If Not IsDBNull(dtTable.Rows(i)("UnitName")) Then
				UnitText = dtTable.Rows(i)("UnitName")
			Else
				UnitText = "-"
			End If
			'UnitInfo = getInfo.GetUnitSetting(dtTable.Rows(i)("MaterialID"),dtTable.Rows(i)("UnitSmallID"),objCnn)
			'If UnitInfo.Rows.Count <> 0 Then
			'	UnitRatioVal = UnitInfo.Rows(0)("UnitSmallRatio")
			'	UnitText = UnitInfo.Rows(0)("UnitLargeName")
			'End If
			showData = False
			SubTotalQty = 0
			
			outputString = outputString.Append("<tr>")
			outputString = outputString.Append("<td class=""smallText"" align=""center"">" + (i+1).ToString + "</td>")
			outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MaterialCode") + "</td>")
			outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MaterialName") + "</td>")

			QtyString = "ProductAmount"
			If Not IsDBNull(dtTable.Rows(i)("UnitSmallAmount")) Then
				'outputString = outputString.Append("<td class=""smallText"" align=""right""><a  class=""smallText"" href=""JavaScript: newWindow = window.open( 'report_material_movement.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&SelMonth=" & Request.Form("MonthYearDate_Month").ToString & "&SelYear=" & Request.Form("MonthYearDate_Year").ToString & "&ProductLevelID=" & ShopData.Rows(j)("ProductLevelID").ToString + "', '', 'width=900,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + CDbl(dtTable.Rows(i)(QtyString)/UnitRatioVal).ToString(FormatObject.AccountingFormat,ci) + "</a></td>")
				If Not IsDBNull(dtTable.Rows(i)("UnitSmallRatio")) Then
					outputString = outputString.Append("<td class=""smallText"" align=""right"">" + CDbl(dtTable.Rows(i)("UnitSmallAmount")/dtTable.Rows(i)("UnitSmallRatio")).ToString(FormatObject.AccountingFormat,ci) + "</td>")
				Else
					outputString = outputString.Append("<td class=""smallText"" align=""right"">" + CDbl(dtTable.Rows(i)("UnitSmallAmount")).ToString(FormatObject.AccountingFormat,ci) + "</td>")
				End If
				SubTotalQty = dtTable.Rows(i)("UnitSmallAmount")
			Else
				outputString = outputString.Append("<td class=""smallText"" align=""right"">" + "0" + "</td>")
			End If
			outputString = outputString.Append("<td class=""smallText"" align=""left"">" + UnitText + "</td>")	


			If Not IsDBNull(dtTable.Rows(i)("CalPricePerUnit")) Then
				PricePerUnit = dtTable.Rows(i)("CalPricePerUnit")
			ElseIf Not IsDBNull(dtTable.Rows(i)("ProductPricePerUnit")) Then
				PricePerUnit = dtTable.Rows(i)("ProductPricePerUnit")
			Else
				PricePerUnit = 0
			End If

			outputString = outputString.Append("<td class=""smallText"" align=""right"">" + CDbl(PricePerUnit).ToString(FormatObject.MaterialQtyFormat,ci) + "</td>")
			outputString = outputString.Append("<td class=""smallText"" align=""right"">" + CDbl(dtTable.Rows(i)("ProductNetPrice")).ToString(FormatObject.AccountingFormat,ci) + "</td>")
			outputString = outputString.Append("</tr>")
			
			TotalQty += SubTotalQty
			TotalPrice += dtTable.Rows(i)("ProductNetPrice")'PricePerUnit*SubTotalQty
			GroupTotalPrice += dtTable.Rows(i)("ProductNetPrice")'PricePerUnit*SubTotalQty
			
			outString = ""

			Dim outputS As StringBuilder = New StringBuilder

			If i < dtTable.Rows.Count - 1 Then
				If dtTable.Rows(i)("MaterialGroupID") <> dtTable.Rows(i+1)("MaterialGroupID") Then
					outputS = outputS.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
					outputS = outputS.Append("<td class=""smallText"" align=""right"" colspan=""" + ColSpan.ToString + """>Summary for " + dtTable.Rows(i)("MaterialGroupCode") + ":" + dtTable.Rows(i)("MaterialGroupName") + "</td>")
					outputS = outputS.Append("<td class=""smallText"" align=""right"">" + (GroupTotalPrice).ToString(FormatObject.AccountingFormat,ci) + "</td>")
					outputS = outputS.Append("</tr>")
					outString = outputS.ToString
					GroupTotalPrice = 0'PricePerUnit*subTotalQty
				End If
			Else
				outputS = outputS.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
				outputS = outputS.Append("<td class=""smallText"" align=""right"" colspan=""" + ColSpan.ToString + """>Summary for " + dtTable.Rows(i)("MaterialGroupCode") + ":" + dtTable.Rows(i)("MaterialGroupName") + "</td>")
				outputS = outputS.Append("<td class=""smallText"" align=""right"">" + (GroupTotalPrice).ToString(FormatObject.AccountingFormat,ci) + "</td>")
				outputS = outputS.Append("</tr>")
				outString = outputS.ToString
			End If


			resultString = resultString.Append(outputString.ToString)
			resultString = resultString.Append(outString)

		Next
				
		resultString = resultString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
		resultString = resultString.Append("<td class=""smallText"" align=""right"" colspan=""" + ColSpan.ToString + """>Summary</td>")
		
		resultString = resultString.Append("<td class=""smallText"" align=""right"">" + (TotalPrice).ToString(FormatObject.AccountingFormat,ci) + "</td>")
		
		resultString = resultString.Append("</tr>")
		
		ResultText.InnerHtml = resultString.ToString
		TestTime += "<br>" + DateTimeUtil.CurrentDateTime
		
		Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & headerTextString.InnerHtml  & ResultText.InnerHtml & "</td></tr></table>"
	End If
	'Catch ex As Exception
			'FoundError = True
	'End Try
End Sub

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "EndingStockData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
