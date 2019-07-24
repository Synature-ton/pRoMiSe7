<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<html>
<head>
<title>Profit and Loss By Products Reports</title>
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
<table width="100%"><tr><td>
<table>
<span id="showShop" runat="server">
<tr>
	<td><span id="SelectShop" class="text" runat="server"></span></td>
	<td><span id="ShopText" runat="server"></span></td>
	<td><span id="SelectMonth" class="text" runat="server"></span></td>
	<td><synature:date id="MonthYearDate" runat="server" /></td>
	<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
</tr>

</span>
</table></td><td align="right" class="text"><a href="JavaScript: newWindow = window.open( 'clear_tempCosting.aspx', '', 'width=300,height=300,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()">Clear Temporary Data</a></td></tr></table>
</div>
<br>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
</table>
<span id="myTable" visible="false" runat="server">
<table  visible="false" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="Text6" runat="server"></div></td>
		<td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="Text7" runat="server"></div></td>
		<td id="headerTD8" align="center" class="tdHeader" runat="server"><div id="Text8" runat="server"></div></td>
		<td id="headerTD9" align="center" class="tdHeader" runat="server"><div id="Text9" runat="server"></div></td>
		<td id="headerTD10" align="center" class="tdHeader" runat="server"><div id="Text10" runat="server"></div></td>
		<td id="headerTD11" align="center" class="tdHeader" runat="server"><div id="Text11" runat="server"></div></td>
		<td id="headerTD12" align="center" class="tdHeader" runat="server"><div id="Text12" runat="server"></div></td>
		<td id="headerTD13" align="center" class="tdHeader" runat="server"><div id="Text13" runat="server"></div></td>
	</tr>
	
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
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Report_ListProducts") Then
		
		Try	
			objCnn = getCnn.EstablishConnection()
			ShowContent.Visible = True	
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
			headerTD11.BgColor = GlobalParam.AdminBGColor
			headerTD12.BgColor = GlobalParam.AdminBGColor
			headerTD13.BgColor = GlobalParam.AdminBGColor
			
			headerTD1.Visible = False
			headerTD2.Visible = False
			headerTD8.Visible = False
			
			Text1.InnerHtml = "Product Group"
			Text2.InnerHtml = "Product Dept"
			Text3.InnerHtml = "Product Code"
			Text4.InnerHtml = "Product Name"
			Text5.InnerHtml = "Reg. Price"
			Text6.InnerHtml = "Sale Price"
			Text7.InnerHtml = "Std Unit Cost"
			Text8.InnerHtml = "Std Unit Cost (include loss)"
			Text9.InnerHtml = "Actual Unit Cost"
			Text10.InnerHtml = "Qty"
			Text11.InnerHtml = "Actual Sale"
			Text12.InnerHtml = "Actual Cost"
			Text13.InnerHtml = "% Margin"
			
			SubmitForm.Text = "Generate Report"
			HeaderText.InnerHtml = "Profit and Loss By Product Report"
			
			MonthYearDate.YearType = GlobalParam.YearType
			MonthYearDate.FormName = "MonthYearDate"
			MonthYearDate.StartYear = GlobalParam.StartYear
			MonthYearDate.EndYear = GlobalParam.EndYear
			MonthYearDate.LangID = Session("LangID")
			MonthYearDate.ShowDay = False
			
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
		errorMsg.InnerHtml = "Access Denied"
	End If
End Sub

Sub DoSearch(Source As Object, E As EventArgs)
	Dim FoundError As Boolean
	FoundError = False
	Session("ReportResult") = ""
	myTable.Visible = False
	Try
	If FoundError = False Then
		ShowPrint.Visible = True
		myTable.Visible = True
		Dim dtTable As New DataTable()
		Dim displayTable As New DataTable()
		Dim gData As New DataTable()
		Application.Lock()
			dtTable = getReport.ProductCost(Request.Form("ShopID"),Request.Form("MonthYearDate_Month"), Request.Form("MonthYearDate_Year"),Session.SessionID,objCnn)
			
		Application.UnLock()
		
		Dim ReportDate As String
		Dim SDate As New Date(Request.Form("MonthYearDate_Year"),Request.Form("MonthYearDate_Month"),1)
		ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy",Session("LangID"),objCnn)
		
		ResultSearchText.InnerHtml = "Profit and loss by product report " + " (" + ReportDate + ")"

		Dim i As Integer
		Dim outputString As String = ""
		Dim ExtraInfo As String
		Dim totalSale As Double = 0
		Dim totalCost As Double = 0
		Dim totalAmount As Double = 0
		Dim subTotalSale As Double = 0
		Dim subTotalCost As Double = 0
		Dim subTotalAmount As Double = 0

		Dim DummyPGroupID,DummyPDeptID,DummyMGroupID,DummyMDeptID As Integer
		Dim ProductGroupName,ProductDeptName,MaterialGroupName,MaterialDeptName As String
		Dim CheckGroup As String
		outputString = ""
		Dim ColSpan As String = "6"
		Dim ColSpan1 As String = "10"
		If headerTD8.Visible = True Then 
			ColSpan = "7"
			ColSpan1 = "11"
		End If
		For i = 0 to dtTable.Rows.Count - 1
			
		  	If (DummyPGroupID = dtTable.Rows(i)("ProductGroupID") AND DummyPDeptID = dtTable.Rows(i)("ProductDeptID")) Then
				ProductGroupName = ""
		  		ProductDeptName = ""
			Else
				ProductGroupName = dtTable.Rows(i)("ProductGroupName")
				ProductDeptName = dtTable.Rows(i)("ProductDeptName")
		 	End If
			
			
			If ProductGroupName <> "" AND ProductDeptName <> "" Then
				If i <> 0 Then
					outputString += "<tr bgcolor=""" + GlobalParam.GrayBGColor + """><td colspan=""" + ColSpan + """ align=""right"" class=""text"">Sub Total Sale/Sub Total Cost</td><td align=""right"" class=""text"">" + Format(subTotalAmount,"##,##0") + "</td><td align=""right"" class=""text"">" + Format(subTotalSale,"##,##0.00") + "</td><td align=""right"" class=""text"">" + Format(subTotalCost,"##,##0.00") + "</td><td align=""right"" class=""text"">" + Format((subTotalSale-subTotalCost)*100/subTotalSale,"##,##0.00") + "%</td></tr>"
				End If
				subTotalSale = 0
				subTotalCost = 0
				subTotalAmount = 0
				outputString += "<tr><td colspan=""" + ColSpan1 + """ class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + ProductGroupName + " :: " + ProductDeptName + "</td></tr>"
			End If
			outputString += "<tr>"
			outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("ProductCode") & "</td>"
			outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("ProductName") & "</td>"
			If Not IsDBNull(dtTable.Rows(i)("RegPrice")) Then
				outputString += "<td align=""right"" class=""text"">" & Format(dtTable.Rows(i)("RegPrice"),"##,##0.00") & "</td>"
			Else
				outputString += "<td align=""right"" class=""text"">" & "-" & "</td>"
			End If
			If Not IsDBNull(dtTable.Rows(i)("ProductPrice")) Then
				outputString += "<td align=""right"" class=""text"">" & Format(dtTable.Rows(i)("ProductPrice"),"##,##0.00") & "</td>"
			Else
				outputString += "<td align=""right"" class=""text"">" & "-" & "</td>"
			End If
			If Not IsDBNull(dtTable.Rows(i)("ProductStandardCost")) Then
				If dtTable.Rows(i)("ProductSet") = 6 Or dtTable.Rows(i)("ProductSet") = 7 Then
					outputString += "<td align=""right"" class=""text""><a href=""JavaScript: newWindow = window.open( 'product_flexible_costing.aspx?ProductID=" + dtTable.Rows(i)("ProductID").ToString + "&ProductGroupID=" + dtTable.Rows(i)("ProductGroupID").ToString + "&ProductLevelID=" + Request.Form("ShopID").ToString + "&ProductDeptID=" + dtTable.Rows(i)("ProductDeptID").ToString & "&SelMonth=" + Request.Form("MonthYearDate_Month").ToString + "&SelYear=" + Request.Form("MonthYearDate_Year").ToString + "', '', 'width=750,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & Format(dtTable.Rows(i)("ProductStandardCost"),"##,##0.00") & "</a></td>"
				Else
					outputString += "<td align=""right"" class=""text""><a href=""JavaScript: newWindow = window.open( 'std_costing_detail.aspx?ProductID=" + dtTable.Rows(i)("ProductID").ToString + "&SelMonth=" + Request.Form("MonthYearDate_Month").ToString + "&SelYear=" + Request.Form("MonthYearDate_Year") + "&ProductLevelID=" + Request.Form("ShopID").ToString + "', '', 'width=900,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & Format(dtTable.Rows(i)("ProductStandardCost"),"##,##0.00") & "</a></td>"
					'outputString += "<td align=""right"" class=""text""><a href=""JavaScript: newWindow = window.open( '../Inventory/pcomponent_group.aspx?ProductID=" + dtTable.Rows(i)("ProductID").ToString + "&ProductGroupID=" + dtTable.Rows(i)("ProductGroupID").ToString + "&ProductLevelID=" + Request.Form("ShopID").ToString + "&ProductDeptID=" + dtTable.Rows(i)("ProductDeptID").ToString & "&SelMonth=" + Request.Form("MonthYearDate_Month").ToString + "&SelYear=" + Request.Form("MonthYearDate_Year").ToString + "', '', 'width=750,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & Format(dtTable.Rows(i)("ProductStandardCost"),"##,##0.00") & "</a></td>"
				End If
			Else
				outputString += "<td align=""right"" class=""text"">" & "-" & "</td>"
			End If
			If headerTD8.Visible = True
				If Not IsDBNull(dtTable.Rows(i)("ProductCost")) Then
					outputString += "<td align=""right"" class=""text"">" & Format(dtTable.Rows(i)("ProductCost"),"##,##0.00") & "</td>"
				Else
					outputString += "<td align=""right"" class=""text"">" & "-" & "</td>"
				End If
			End If
			If Not IsDBNull(dtTable.Rows(i)("RealPrice")) Then
				outputString += "<td align=""right"" class=""text""><a href=""JavaScript: newWindow = window.open( 'costing_detail.aspx?ProductID=" + dtTable.Rows(i)("ProductID").ToString + "&SelMonth=" + Request.Form("MonthYearDate_Month").ToString + "&SelYear=" + Request.Form("MonthYearDate_Year") + "&ProductLevelID=" + Request.Form("ShopID").ToString + "', '', 'width=900,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & Format(dtTable.Rows(i)("RealPrice"),"##,##0.00") & "</a></td>"
			Else
				outputString += "<td align=""right"" class=""text"">" & "-" & "</td>"
			End If
			If Not IsDBNull(dtTable.Rows(i)("totalUse")) Then
				outputString += "<td align=""right"" class=""text"">" & Format(dtTable.Rows(i)("totalUse"),"##,##0") & "</td>"
				totalAmount += dtTable.Rows(i)("totalUse")
				subTotalAmount += dtTable.Rows(i)("totalUse")
			Else
				outputString += "<td align=""right"" class=""text"">" & "-" & "</td>"
			End If
			If Not IsDBNull(dtTable.Rows(i)("ProductPrice")) And Not IsDBNull(dtTable.Rows(i)("totalUse")) Then
				outputString += "<td align=""right"" class=""text"">" & Format(dtTable.Rows(i)("ProductPrice")*dtTable.Rows(i)("totalUse"),"##,##0.00") & "</td>"
				TotalSale += dtTable.Rows(i)("ProductPrice")*dtTable.Rows(i)("totalUse")
				subTotalSale += dtTable.Rows(i)("ProductPrice")*dtTable.Rows(i)("totalUse")
			Else
				outputString += "<td align=""right"" class=""text"">" & "-" & "</td>"
			End If
			If Not IsDBNull(dtTable.Rows(i)("RealPrice")) And Not IsDBNull(dtTable.Rows(i)("totalUse")) Then
				outputString += "<td align=""right"" class=""text"">" & Format(dtTable.Rows(i)("RealPrice")*dtTable.Rows(i)("totalUse"),"##,##0.00") & "</td>"
				TotalCost += dtTable.Rows(i)("RealPrice")*dtTable.Rows(i)("totalUse")
				subTotalCost += dtTable.Rows(i)("RealPrice")*dtTable.Rows(i)("totalUse")
			Else
				outputString += "<td align=""right"" class=""text"">" & "-" & "</td>"
			End If
			If Not IsDBNull(dtTable.Rows(i)("ProductPrice")) And Not IsDBNull(dtTable.Rows(i)("RealPrice")) And Not IsDBNull(dtTable.Rows(i)("totalUse")) Then
				outputString += "<td align=""right"" class=""text"">" & Format((dtTable.Rows(i)("ProductPrice")-dtTable.Rows(i)("RealPrice"))*100/dtTable.Rows(i)("ProductPrice"),"##,##0.00") & "%</td>"
			Else
				outputString += "<td align=""right"" class=""text"">" & "-" & "</td>"
			End If
			outputString += "</tr>"

		  DummyPGroupID = dtTable.Rows(i)("ProductGroupID")
		  DummyPDeptID = dtTable.Rows(i)("ProductDeptID")
		Next
		If subTotalSale > 0 AND subTotalCost > 0 Then
			outputString += "<tr bgcolor=""" + GlobalParam.GrayBGColor + """><td colspan=""" + ColSpan + """ align=""right"" class=""text"">Sub Total Sale/Sub Total Cost</td><td align=""right"" class=""text"">" + Format(subTotalAmount,"##,##0") + "</td><td align=""right"" class=""text"">" + Format(subTotalSale,"##,##0.00") + "</td><td align=""right"" class=""text"">" + Format(subTotalCost,"##,##0.00") + "</td><td align=""right"" class=""text"">" + Format((subTotalSale-subTotalCost)*100/subTotalSale,"##,##0.00") + "%</td></tr>"
		End If
		If totalSale > 0 AND totalCost > 0 Then
			outputString += "<tr><td colspan=""" + ColSpan1 + """ class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Summary of Sale/Cost" + "</td></tr>"
			outputString += "<tr><td colspan=""" + ColSpan + """ align=""right"" class=""boldText"">Total Sale*/Total Cost</td><td align=""right"" class=""boldText"">" + Format(totalAmount,"##,##0") + "</td><td align=""right"" class=""boldText"">" + Format(totalSale,"##,##0.00") + "</td><td align=""right"" class=""boldText"">" + Format(totalCost,"##,##0.00") + "</td><td align=""right"" class=""boldText"">" + Format((totalSale-totalCost)*100/totalSale,"##,##0.00") + "%</td></tr>"
		End If
		
		Dim OtherData As DataTable = getReport.OtherProductCost(Request.Form("ShopID"),Request.Form("MonthYearDate_Month"), Request.Form("MonthYearDate_Year"),objCnn)
		
		If OtherData.Rows.Count > 0 Then
			subTotalSale = 0
			subTotalCost = 0
			subTotalAmount = 0
			outputString += "<tr><td colspan=""" + ColSpan1 + """ class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Other Products and Services" + "</td></tr>"
			For i = 0 To OtherData.Rows.Count - 1 
				outputString += "<tr>"
				outputString += "<td align=""right"" class=""text"">-</td>"
				outputString += "<td align=""right"" class=""text"">" + OtherData.Rows(i)("OtherFoodName") + "</td>"
				If Not IsDBNull(OtherData.Rows(i)("TotalRetailPrice")) Then
					outputString += "<td align=""right"" class=""text"">" & Format(OtherData.Rows(i)("TotalRetailPrice")/OtherData.Rows(i)("Amount"),"##,##0.00") & "</td>"
				Else
					outputString += "<td align=""right"" class=""text"">" & "-" & "</td>"
				End If
				If Not IsDBNull(OtherData.Rows(i)("SalePrice")) Then
					outputString += "<td align=""right"" class=""text"">" & Format(OtherData.Rows(i)("SalePrice")/OtherData.Rows(i)("Amount"),"##,##0.00") & "</td>"
				Else
					outputString += "<td align=""right"" class=""text"">" & "-" & "</td>"
				End If
				outputString += "<td align=""right"" class=""text"">-</td>"
				If headerTD8.Visible = True Then outputString += "<td align=""right"" class=""text"">-</td>"
				outputString += "<td align=""right"" class=""text"">-</td>"
				outputString += "<td align=""right"" class=""text"">" & Format(OtherData.Rows(i)("Amount"),"##,##0") & "</td>"
				If Not IsDBNull(OtherData.Rows(i)("SalePrice")) Then
					outputString += "<td align=""right"" class=""text"">" & Format(OtherData.Rows(i)("SalePrice"),"##,##0.00") & "</td>"
					subTotalSale += OtherData.Rows(i)("SalePrice")
					TotalSale += OtherData.Rows(i)("SalePrice")
				Else
					outputString += "<td align=""right"" class=""text"">" & "-" & "</td>"
				End If
				outputString += "<td align=""right"" class=""text"">-</td>"
				outputString += "<td align=""right"" class=""text"">-</td>"
				outputString += "</tr>"
				subTotalAmount += OtherData.Rows(i)("Amount")
				totalAmount += OtherData.Rows(i)("Amount")
			Next
			If subTotalSale > 0 Then
				outputString += "<tr bgcolor=""" + GlobalParam.GrayBGColor + """><td colspan=""" + ColSpan + """ align=""right"" class=""text"">Sub Total Sale</td><td align=""right"" class=""text"">" + Format(subTotalAmount,"##,##0") + "</td><td align=""right"" class=""text"">" + Format(subTotalSale,"##,##0.00") + "</td><td align=""right"" class=""text"">" + "-" + "</td><td align=""right"" class=""text"">" + "-" + "</td></tr>"
			End If
		End If
		
		Dim PackageData As DataTable = getReport.PackageProductCost(Request.Form("ShopID"),Request.Form("MonthYearDate_Month"), Request.Form("MonthYearDate_Year"),objCnn)'objDB.List("select * from ProductLevel where 0=1",objCnn)
		
		If PackageData.Rows.Count > 0 Then
			subTotalSale = 0
			subTotalCost = 0
			subTotalAmount = 0
			outputString += "<tr><td colspan=""" + ColSpan1 + """ class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Package Sale Data" + "</td></tr>"
			For i = 0 To PackageData.Rows.Count - 1 
				outputString += "<tr>"
				outputString += "<td align=""right"" class=""text"">-</td>"
				If PackageData.Rows(i)("ProductSetType") >= 0 Then
					outputString += "<td align=""right"" class=""text"">" + PackageData.Rows(i)("ProductName") + "</td>"
				Else
					outputString += "<td align=""right"" class=""text"">" + PackageData.Rows(i)("ProductName") + "**</td>"
				End If
				If Not IsDBNull(PackageData.Rows(i)("TotalRetailPrice")) Then
					outputString += "<td align=""right"" class=""text"">" & Format(PackageData.Rows(i)("TotalRetailPrice")/PackageData.Rows(i)("Amount"),"##,##0.00") & "</td>"
				Else
					outputString += "<td align=""right"" class=""text"">" & "-" & "</td>"
				End If
				If Not IsDBNull(PackageData.Rows(i)("SalePriceBeforeVAT")) Then
					outputString += "<td align=""right"" class=""text"">" & Format((PackageData.Rows(i)("SalePriceBeforeVAT")+PackageData.Rows(i)("ProductVAT"))/PackageData.Rows(i)("Amount"),"##,##0.00") & "</td>"
				Else
					outputString += "<td align=""right"" class=""text"">" & "-" & "</td>"
				End If
				outputString += "<td align=""right"" class=""text"">-</td>"
				If headerTD8.Visible = True  Then outputString += "<td align=""right"" class=""text"">-</td>"
				outputString += "<td align=""right"" class=""text"">-</td>"
				outputString += "<td align=""right"" class=""text"">" & Format(PackageData.Rows(i)("Amount"),"##,##0") & "</td>"
				If Not IsDBNull(PackageData.Rows(i)("SalePriceBeforeVAT")) Then
					If PackageData.Rows(i)("ProductSetType") >= 0 Then
						outputString += "<td align=""right"" class=""text"">" & Format(PackageData.Rows(i)("SalePriceBeforeVAT")+PackageData.Rows(i)("ProductVAT"),"##,##0.00") & "</td>"
						subTotalSale += PackageData.Rows(i)("SalePriceBeforeVAT")+PackageData.Rows(i)("ProductVAT")
						TotalSale += PackageData.Rows(i)("SalePriceBeforeVAT")+PackageData.Rows(i)("ProductVAT")
					Else
						outputString += "<td align=""right"" class=""redText"">(" & Format(PackageData.Rows(i)("SalePriceBeforeVAT")+PackageData.Rows(i)("ProductVAT"),"##,##0.00") & ")</td>"
						subTotalSale -= PackageData.Rows(i)("SalePriceBeforeVAT")+PackageData.Rows(i)("ProductVAT")
						TotalSale -= PackageData.Rows(i)("SalePriceBeforeVAT")+PackageData.Rows(i)("ProductVAT")
					End If
				Else
					outputString += "<td align=""right"" class=""text"">" & "-" & "</td>"
				End If
				outputString += "<td align=""right"" class=""text"">-</td>"
				outputString += "<td align=""right"" class=""text"">-</td>"
				outputString += "</tr>"
				subTotalAmount += PackageData.Rows(i)("Amount")
				totalAmount += PackageData.Rows(i)("Amount")
			Next
			If subTotalSale > 0 Then
				outputString += "<tr bgcolor=""" + GlobalParam.GrayBGColor + """><td colspan=""" + ColSpan + """ align=""right"" class=""text"">Sub Total Sale</td><td align=""right"" class=""text"">" + Format(subTotalAmount,"##,##0") + "</td><td align=""right"" class=""text"">" + Format(subTotalSale,"##,##0.00") + "</td><td align=""right"" class=""text"">" + "-" + "</td><td align=""right"" class=""text"">" + "-" + "</td></tr>"
			End If
		End If
		
		If totalSale > 0 Then
			outputString += "<tr><td colspan=""11"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Summary of Sale" + "</td></tr>"
			outputString += "<tr><td colspan=""" + ColSpan + """ align=""right"" class=""boldText"">Total Sale</td><td align=""right"" class=""boldText"">" + Format(totalAmount,"##,##0") + "</td><td align=""right"" class=""boldText"">" + Format(totalSale,"##,##0.00") + "</td><td align=""right"" class=""boldText"">" + "-" + "</td><td align=""right"" class=""boldText"">" + "-</td></tr>"
		End If
		
		ResultText.InnerHtml = outputString
		
	End If
	Catch ex As Exception
			FoundError = True
		End Try
End Sub


Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
