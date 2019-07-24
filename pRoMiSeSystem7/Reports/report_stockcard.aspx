<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<html>
<head>
<title>Loss Profit Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
	<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
	<td><asp:CheckBox ID="DisplayOnly" Checked="true" Text="Display only materials that have movement" CssClass="text" runat="server" /></td>
</tr>
<tr>
	<td></td>
	<td colspan="5"><asp:dropdownlist ID="OrderParam" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
</tr>
</span>
</table>
</div>
<br>
<table width="100%">

<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
<tr><td align="left"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
</table>

<span id="myTable" visible="false" runat="server">
<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
	<span id="headerTextString" runat="server"></span>
	
	<div id="ResultText" runat="server"></div>
</table>
</span>
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
Dim objDB As New CDBUtil()
Dim DateTimeUtil As New MyDateTime()
Dim getReport As New GenReports()
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("StockCard_Report") Then
		
		Try	
			SubmitForm.Attributes.Item("onclick") = "this.disabled=true;" & GetPostBackEventReference(SubmitForm).ToString
			objCnn = getCnn.EstablishConnection()
			ShowContent.Visible = True		
			
			SubmitForm.Text = "Generate Report"
			LangText0.Text = "Stock Card Report"
			
			MonthYearDate.YearType = GlobalParam.YearType
			MonthYearDate.FormName = "MonthYearDate"
			MonthYearDate.StartYear = GlobalParam.StartYear
			MonthYearDate.EndYear = GlobalParam.EndYear
			MonthYearDate.LangID = Session("LangID")
			MonthYearDate.ShowDay = False
			
			OrderParam.Items(0).Text = "Order By Material Code"
			OrderParam.Items(0).Value = "a.MaterialCode"
			OrderParam.Items(1).Text = "Order By Material Name"
			OrderParam.Items(1).Value = "a.MaterialName"
			
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
			
			Dim i As Integer
			Dim outputString,FormSelected,compareString As String
			Dim SelectString As String 
			
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
	myTable.Visible = False
	'Try
	
	Dim SelMonth As Integer = 0
	Dim SelYear As Integer = 0
	If IsNumeric(Request.Form("MonthYearDate_Month")) Then SelMonth = Request.Form("MonthYearDate_Month")
	If IsNumeric(Request.Form("MonthYearDate_Year")) Then SelYear = Request.Form("MonthYearDate_Year")
	
	If SelMonth = 0 Or SelYear = 0 Then
		FoundError = True
	End If	
	If FoundError = False Then
		ShowPrint.Visible = True
		myTable.Visible = True
		Dim TestTime,Result As String
		Dim dtTable,groupData,groupDataL As DataTable
		Dim displayTable As New DataTable()
		
		Application.Lock()
			Result = getReport.StockCardReport("","",dtTable,groupData,groupDataL,Request.Form("ShopID"),SelMonth, SelYear,OrderParam.SelectedItem.Value,objCnn)
		Application.UnLock()

		Dim ReportDate As String
		Dim SDate As New Date(Request.Form("MonthYearDate_Year"),Request.Form("MonthYearDate_Month"),1)
		ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy",Session("LangID"),objCnn)
		ResultSearchText.InnerHtml = "Stock Card Report " + " (" + ReportDate + ")"
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
		Dim AmountDiff As Double = 0
		Dim StdUse As Double = 0
		Dim TotalUse As Double = 0
		Dim SubTotalUse As Double = 0
		Dim SubTotalPrice As Double = 0
		Dim TotalPrice As Double = 0
		Dim BeginningSum As Double = 0
		Dim EndingSum As Double = 0
		Dim TotalSum As Double = 0
		Dim ColumnSum(groupData.Rows.Count) As Double
		Dim ColumnSaleSum(groupDataL.Rows.Count) As Double
		Dim UnitName As String
		
		Dim HeaderString As String = "<tr>"
		HeaderString += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Material Code" + "</td>"
		HeaderString += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Material Name" + "</td>"
		HeaderString += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Cost/Unit" + "</td>"
		HeaderString += "<td colspan=""2"" align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Beginning" + "</td>"
		For i = 0 To groupData.Rows.Count - 1
			HeaderString += "<td colspan=""2"" align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + groupData.Rows(i)("GroupHeader") + "</td>"
		Next
		HeaderString += "<td colspan=""2"" align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Ending" + "</td>"
		For i = 0 To groupDataL.Rows.Count - 1
			HeaderString += "<td colspan=""2"" align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + groupDataL.Rows(i)("GroupHeader") + "</td>"
		Next
		HeaderString += "<td colspan=""2"" align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Balance" + "</td>"
		HeaderString += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Unit" + "</td>"
		HeaderString += "</tr>"
		headerTextString.InnerHtml = HeaderString
		
		Dim groupString,PriceString,QtyString,StdString As String
		Dim resultString As StringBuilder = New StringBuilder
		Dim showData As Boolean
		Dim j As Integer
		Dim UnitPrice As String
		Dim UnitInfo As DataTable
		Dim CostPerUnit As Double
		Dim UnitText As String
		Dim UnitRatioVal As Double = 1
		For i = 0 to dtTable.Rows.Count - 1
			Dim outputString As StringBuilder = New StringBuilder
			showData = False
			subTotalUse = 0
			subTotalPrice = 0
			outputString = outputString.Append("<tr>")
			outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MaterialCode") + "</td>")
			outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MaterialName") + "</td>")
			CostPerUnit = 0
			If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
				If dtTable.Rows(i)("TotalAmount") > 0 Then
					CostPerUnit = dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount")
				End If
			End If
			UnitRatioVal = 1
			UnitText = dtTable.Rows(i)("UnitSmallName")
			UnitInfo = getInfo.GetUnitSetting(dtTable.Rows(i)("MaterialID"),dtTable.Rows(i)("UnitSmallID"),objCnn)
			If UnitInfo.Rows.Count <> 0 Then
				UnitRatioVal = UnitInfo.Rows(0)("UnitSmallRatio")
				UnitText = UnitInfo.Rows(0)("UnitLargeName")
			End If
			outputString = outputString.Append("<td class=""smallText"" align=""right""><a  class=""smallText"" href=""JavaScript: newWindow = window.open( '../Inventory/product_stdcost.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&SelMonth=" & Request.Form("MonthYearDate_Month").ToString & "&SelYear=" & Request.Form("MonthYearDate_Year").ToString & "&ProductLevelID=" & Request.Form("ShopID").ToString + "', '', 'width=900,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(CostPerUnit*UnitRatioVal,"##,##0.00") + "</a></td>")
			
			'----- Beginning Stock ---------------
			If Not IsDBNull(dtTable.Rows(i)("NetSmallAmount0")) Then
				If dtTable.Rows(i)("NetSmallAmount0") > 0 Then
					outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(dtTable.Rows(i)("NetSmallAmount0")/UnitRatioVal,"##,##0.#") + "</td>")
					subTotalUse += dtTable.Rows(i)("NetSmallAmount0")
					showData = True
				Else
					outputString = outputString.Append("<td class=""smallText"" align=""right"">0</td>")
				End If
			Else
				outputString = outputString.Append("<td class=""smallText"" align=""right"">0</td>")
			End If
			
			If Not IsDBNULL(dtTable.Rows(i)("NetSmallAmount0")) AND Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
				If dtTable.Rows(i)("TotalPrice") > 0 AND dtTable.Rows(i)("TotalAmount") > 0 Then
					outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(dtTable.Rows(i)("NetSmallAmount0")*(dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount")),"##,##0.00") + "</td>")
					subTotalPrice += dtTable.Rows(i)("NetSmallAmount0")*(dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount"))
					BeginningSum += dtTable.Rows(i)("NetSmallAmount0")*(dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount"))
					showData = True
				Else
					outputString = outputString.Append("<td class=""smallText"" align=""right"">0</td>")
				End If
			Else
				outputString = outputString.Append("<td class=""smallText"" align=""right"">0</td>")
			End If

			'------------- End Beginning -------------------
			
			For j = 0 To groupData.Rows.Count - 1
				UnitPrice = "0"
				groupString = "NetSmallAmount" + groupData.Rows(j)("DocumentTypeGroupID").ToString
				PriceString = "ProductNetPrice" + groupData.Rows(j)("DocumentTypeGroupID").ToString
				QtyString = "TotalAmount" + groupData.Rows(j)("DocumentTypeGroupID").ToString
				StdString = "CalculateStandardProfitLoss" + groupData.Rows(j)("DocumentTypeGroupID").ToString
				
				If Not IsDBNull(dtTable.Rows(i)("TotalAmount")) AND Not IsDBNull(dtTable.Rows(i)("TotalPrice")) Then
					If dtTable.Rows(i)("TotalAmount") > 0 Then
						UnitPrice = Format((dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount")),"##,##0.000000")
					Else
						UnitPrice = "0"	
					End If
				Else
					UnitPrice = "0"	
				End If
				If Not IsDBNull(dtTable.Rows(i)(groupString)) Then
					outputString = outputString.Append("<td class=""smallText"" align=""right""><a class=""smalltext"" href=""JavaScript: newWindow = window.open( 'report_material_doc.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&UnitPrice=" + UnitPrice + "&DocumentTypeGroupID=" & groupData.Rows(j)("DocumentTypeGroupID").ToString + "&SelMonth=" & Request.Form("MonthYearDate_Month").ToString & "&SelYear=" & Request.Form("MonthYearDate_Year").ToString & "&ProductLevelID=" & Request.Form("ShopID").ToString + "', '', 'width=1000,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(dtTable.Rows(i)(groupString)/UnitRatioVal,"##,##0.00;(##,##0.00)") + "</a></td>")
					subTotalUse += dtTable.Rows(i)(groupString)
					showData = True
				Else
					outputString = outputString.Append("<td class=""smallText"" align=""right"">0</td>")
				End If
				
				
				If Not IsDBNull(dtTable.Rows(i)(QtyString)) AND Not IsDBNull(dtTable.Rows(i)("TotalPrice")) AND Not IsDBNull("TotalAmount") Then
						If dtTable.Rows(i)("TotalAmount") = 0 Then
							outputString = outputString.Append("<td class=""smallText"" align=""right"">0</td>")
						Else
							outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format((dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount"))*dtTable.Rows(i)(groupString),"##,##0.00;(##,##0.00)") + "</td>")
							subTotalPrice += (dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount"))*dtTable.Rows(i)(groupString)
							ColumnSum(j) += (dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount"))*dtTable.Rows(i)(groupString)
							
						End If
						showData = True
				Else
					outputString = outputString.Append("<td class=""smallText"" align=""right"">0</td>")
				End If
				
			Next
			If Not IsDBNull(subTotalUse) Then
				outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>" + Format(subTotalUse/UnitRatioVal,"##,##0.00;(##,##0.00)") + "</td>")
				If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) AND Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
					If dtTable.Rows(i)("TotalAmount") > 0 Then
						If subTotalUse > 0 Or (subTotalUse = 0 And showData = True) Then
							outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>" + Format((dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount"))*subTotalUse,"##,##0.00") + "</td>")
							subTotalPrice += (dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount"))*subTotalUse
							EndingSum += (dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount"))*subTotalUse
							showData = True
						Else
							outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>0</td>")
						End If
					Else
						outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>0</td>")
					End If
				Else
					outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>0</td>")
				End If
			Else
				outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>0</td>")
				outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>0</td>")
			End If
			
			For j = 0 To groupDataL.Rows.Count - 1
				UnitPrice = "0"
				groupString = "NetSmallAmount" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
				PriceString = "ProductNetPrice" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
				QtyString = "TotalAmount" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
				StdString = "CalculateStandardProfitLoss" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
				
				If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) AND Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
					If dtTable.Rows(i)("TotalAmount") > 0 Then
						UnitPrice = Format((dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount")),"##,##0.000000")
					End If
				End If
				
				If Not IsDBNull(dtTable.Rows(i)(groupString)) Then
					outputString = outputString.Append("<td class=""smallText"" align=""right""><a class=""smalltext"" href=""JavaScript: newWindow = window.open( 'report_material_doc.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&UnitPrice=" + UnitPrice + "&DocumentTypeGroupID=" & groupDataL.Rows(j)("DocumentTypeGroupID").ToString + "&SelMonth=" & Request.Form("MonthYearDate_Month").ToString & "&SelYear=" & Request.Form("MonthYearDate_Year").ToString & "&ProductLevelID=" & Request.Form("ShopID").ToString + "', '', 'width=1000,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(dtTable.Rows(i)(groupString)/UnitRatioVal,"##,##0.00;(##,##0.00)") + "</a></td>")
					subTotalUse += dtTable.Rows(i)(groupString)
					showData = True
				Else
					outputString = outputString.Append("<td class=""smallText"" align=""right"">0</td>")
				End If
				
				
				If Not IsDBNull(dtTable.Rows(i)(StdString)) Then
					If Not IsDBNull(dtTable.Rows(i)(QtyString)) AND Not IsDBNull(dtTable.Rows(i)("TotalPrice")) AND Not IsDBNull("TotalAmount") Then
					  If dtTable.Rows(i)("TotalAmount") <> 0 Then
						outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format((dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount"))*dtTable.Rows(i)(groupString),"##,##0.00;(##,##0.00)") + "</td>")
						subTotalPrice += (dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount"))*dtTable.Rows(i)(groupString)
						ColumnSaleSum(j) += (dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount"))*dtTable.Rows(i)(groupString)
						showData = True
					  Else
						outputString = outputString.Append("<td class=""smallText"" align=""right"">0</td>")
					  End If
					Else
						outputString = outputString.Append("<td class=""smallText"" align=""right"">0</td>")
					End If
				Else
					outputString = outputString.Append("<td class=""smallText"" align=""right"">0</td>")
				End If
			Next
			If Not IsDBNull(subTotalUse) Then
				outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """><a  class=""smallText"" href=""JavaScript: newWindow = window.open( 'report_material_movement.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&SelMonth=" & Request.Form("MonthYearDate_Month").ToString & "&SelYear=" & Request.Form("MonthYearDate_Year").ToString & "&ProductLevelID=" & Request.Form("ShopID").ToString + "', '', 'width=1000,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(subTotalUse/UnitRatioVal,"##,##0.00;(##,##0.00)") + "</a></td>")
				If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) AND Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
					If dtTable.Rows(i)("TotalAmount") > 0 Then
						If subTotalUse > 0 Or (subTotalUse = 0 And showData = True) Then
							outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>" + Format((dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount"))*subTotalUse,"##,##0.00;(##,##0.00)") + "</td>")
							subTotalPrice += (dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount"))*subTotalUse
							TotalSum += (dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount"))*subTotalUse
							showData = True
						Else
							outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>0</td>")
						End If
					Else
						outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>0</td>")
					End If
				Else
					outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>0</td>")
				End If
				TotalUse += subTotalUse
				TotalPrice += subTotalPrice
			Else
				outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>0</td>")
				outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>0</td>")
			End If

			If Not IsDBNull(dtTable.Rows(i)("UnitSmallName")) Then
				outputString = outputString.Append("<td class=""smallText"" align=""left"" bgColor=""" + "white" + """>" + UnitText + "</td>")
			Else
				outputString = outputString.Append("<td class=""smallText"" align=""left"" bgColor=""" + "white" + """>" + "-" + "</td>")
			End If
			outputString = outputString.Append("</tr>")
			If (showData = True AND DisplayOnly.Checked = True) OR DisplayOnly.Checked = False Then
				resultString = resultString.Append(outputString.ToString)
			End If
		Next
		
		resultString = resultString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
		resultString = resultString.Append("<td class=""smallText"" align=""right"" colspan=""3"">Summary</td>")
		resultString = resultString.Append("<td class=""smallText"" align=""right"" colspan=""2""><a class=""smalltext"" href=""JavaScript: newWindow = window.open( 'report_material_typegroup.aspx?DocumentTypeGroupID=" & "0" + "&SelMonth=" & Request.Form("MonthYearDate_Month").ToString & "&SelYear=" & Request.Form("MonthYearDate_Year").ToString & "&ProductLevelID=" & Request.Form("ShopID").ToString + "', '', 'width=1000,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(BeginningSum,"##,##0.00;(##,##0.00)") + "</a></td>")
		'resultString = resultString.Append("<td class=""smallText"" align=""right"" colspan=""3"">" + Format(BeginningSum,"##,##0.00;(##,##0.00)") + "</td>")
		For i = 0 to groupData.Rows.Count - 1
			resultString = resultString.Append("<td class=""smallText"" align=""right"" colspan=""2""><a class=""smalltext"" href=""JavaScript: newWindow = window.open( 'report_material_typegroup.aspx?DocumentTypeGroupID=" & groupData.Rows(i)("DocumentTypeGroupID").ToString + "&SelMonth=" & Request.Form("MonthYearDate_Month").ToString & "&SelYear=" & Request.Form("MonthYearDate_Year").ToString & "&ProductLevelID=" & Request.Form("ShopID").ToString + "', '', 'width=1000,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(ColumnSum(i),"##,##0.00;(##,##0.00)") + "</a></td>")
			'resultString = resultString.Append("<td class=""smallText"" align=""right"" colspan=""3"">" + Format(ColumnSum(i),"##,##0.00;(##,##0.00)") + "</td>")
		Next
		resultString = resultString.Append("<td class=""smallText"" align=""right"" colspan=""2"">" + Format(EndingSum,"##,##0.00;(##,##0.00)") + "</td>")
		For i = 0 to groupDataL.Rows.Count - 1
			resultString = resultString.Append("<td class=""smallText"" align=""right"" colspan=""2"">" + Format(ColumnSaleSum(i),"##,##0.00;(##,##0.00)") + "</td>")
		Next
		resultString = resultString.Append("<td class=""smallText"" align=""right"" colspan=""2"">" + Format(TotalSum,"##,##0.00;(##,##0.00)") + "</td>")
		resultString = resultString.Append("<td class=""smallText"" align=""left"">-</td>")
		resultString = resultString.Append("</tr>")
		
		ResultText.InnerHtml = resultString.ToString
		TestTime += "<br>" + DateTimeUtil.CurrentDateTime
	End If
	'Catch ex As Exception
			'FoundError = True
		'End Try
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub
</script>
</body>
</html>
