<%@ Page Language="VB" ContentType="text/html" debug="True"%>
<%@ Register tagPrefix="Web" Namespace="WebChart" Assembly="WebChart" %>
<%@ Import Namespace="System.Drawing" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.Data.MySql" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>ERP Interface</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="../StyleSheet/webscript.js"></script>
</head>
<body<% = GlobalParam.BodyProp %>>
<div id="showPage" visible="true" runat="server">
<form runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
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
<table>
<tr id="ShowShop" runat="server">
	<td valign="top">
		<table>
			<tr>
				<td><span id="ShopText" runat="server"></span></td>
                <td><span id="OutletText" runat="server"></span></td>
				<td><synature:date id="DailyDate" runat="server" /></td>
                <td class="text">To</td>
				<td><synature:date id="ToDate" runat="server" /></td>
				<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
			</tr>
		</table></td>
</tr>


</table>
</div>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a> | <a href="javascript:ExportToExcel()">Export to Excel</a> <a href="JavaScript: newWindow = window.open( '../Help/ExportExcel.html', '', 'width=500,height=500,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"><img src="../images/help.jpg" border="0" hspace="4" vspace="0" align="absmiddle"></a></div></td>
</tr>
</table>
<span id="MyTable">
<table width="100%">
<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr><tr><td height="10"></td></tr>
<span id="showResult" visible="false" runat="server">
<tr><td>
<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
	<span id="TableHeaderText" runat="server"></span>
	<span id="ExtraHeader" runat="server"></span>
	</tr>
	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>
</table></td></tr></span>
</table></span>
<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
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
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("ERPInterface") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(13,Session("LangID"),objCnn)
		Dim textTable1 As New DataTable()
		textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)

		SubmitForm.Text = "Export Data"'textTable.Rows(8)("TextParamValue")
		'SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
		HeaderText.InnerHtml = "Export Sale Data to ERP"
			
		DailyDate.YearType = GlobalParam.YearType
		DailyDate.FormName = "DocDaily"
		DailyDate.StartYear = GlobalParam.StartYear
		DailyDate.EndYear = GlobalParam.EndYear
		DailyDate.LangID = Session("LangID")
		
		ToDate.YearType = GlobalParam.YearType
		ToDate.FormName = "DocTo"
		ToDate.StartYear = GlobalParam.StartYear
		ToDate.EndYear = GlobalParam.EndYear
		ToDate.LangID = Session("LangID")
		
		ResultText.InnerHtml = ""
		ResultSearchText.InnerHtml = ""
		errorMsg.InnerHtml = ""
		
		Dim HeaderString As String = ""

		TableHeaderText.InnerHtml = HeaderString
		If IsNumeric(Request.Form("DocDaily_Day")) Then 
			Session("DocDailyDay") = Request.Form("DocDaily_Day")
		Else If IsNumeric(Request.QueryString("DocDaily_Day")) Then 
			Session("DocDailyDay") = Request.QueryString("DocDaily_Day")
		Else If Trim(Session("DocDailyDay")) = "" Then
			Session("DocDailyDay") = DateTime.Now.Day
		Else If Trim(Session("DocDailyDay")) = 0 And Not Page.IsPostBack Then
			Session("DocDailyDay") = DateTime.Now.Day
		End If
		If Page.IsPostBack AND Request.Form("DocDaily_Day") = "" Then Session("DocDailyDay") = 0
		DailyDate.SelectedDay = Session("DocDailyDay")
		
		
		If IsNumeric(Request.Form("DocDaily_Month")) Then 
			Session("DocDaily_Month") = Request.Form("DocDaily_Month")
		Else If IsNumeric(Request.QueryString("DocDaily_Month")) Then 
			Session("DocDaily_Month") = Request.QueryString("DocDaily_Month")
		Else If Trim(Session("DocDaily_Month")) = "" Then
			Session("DocDaily_Month") = DateTime.Now.Month
		Else If Trim(Session("DocDaily_Month")) = 0 And Not Page.IsPostBack Then
			Session("DocDaily_Month") = DateTime.Now.Month
		End If
		If Page.IsPostBack AND Request.Form("DocDaily_Month") = "" Then Session("DocDaily_Month") = 0
		DailyDate.SelectedMonth = Session("DocDaily_Month")
		
		If IsNumeric(Request.Form("DocDaily_Year")) Then 
			Session("DocDaily_Year") = Request.Form("DocDaily_Year")
		Else If IsNumeric(Request.QueryString("DocDaily_Year")) Then 
			Session("DocDaily_Year") = Request.QueryString("DocDaily_Year")
		Else If Trim(Session("DocDaily_Year")) = "" Then
			Session("DocDaily_Year") = DateTime.Now.Year
		Else If Trim(Session("DocDaily_Year")) = 0 And Not Page.IsPostBack Then
			Session("DocDaily_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("DocDaily_Year") = "" Then Session("DocDaily_Year") = 0
		DailyDate.SelectedYear = Session("DocDaily_Year")
		
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

		Dim ShopIDValue As String = "0"
		If IsNumeric(Request.Form("ShopID")) Then
			ShopIDValue = Request.Form("ShopID").ToString
		Else If IsNumeric(Request.QueryString("ShopID"))
			ShopIDValue = Request.QueryString("ShopID").ToString
		End If
			
		Dim i As Integer
		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		outputString = "<select name=""ExportType"" onchange=""submit()"">"
		If Request.Form("ExportType") = 1 Then
			FormSelected = " selected"
		Else
			FormSelected = ""
		End If
		outputString += "<option value=""" & "1" & """ " & FormSelected & ">" & "Export AR Data"
		If Request.Form("ExportType") = 2 Then
			FormSelected = " selected"
		Else
			FormSelected = ""
		End If
		outputString += "<option value=""" & "2" & """ " & FormSelected & ">" & "Export GL Data"
		outputString += "</select>"
		ShopText.InnerHtml = outputString
		ShowShop.Visible = True
		
		Dim IsConsignment As Integer = 1
		If Request.Form("ExportType") = 2 Then
			IsConsignment = 0
		End If
		
		Dim getOutlet As DataTable = objDB.List("select * from ProductLevel a, ShopExtData b where a.ProductLevelID=b.ShopID AND a.Deleted=0 AND a.IsShop=1 AND b.IsConsignment=" + IsConsignment.ToString + " AND ExportERP=1 order by a.ProductLevelID", objCnn)
		
		outputString = "<select name=""ShopIDList"">"
	
		If Request.Form("ShopIDList") = 0 OR Not Page.IsPostBack Then
			FormSelected = " selected"
		Else
			FormSelected = ""
		End If
		Dim AllShop As String = "-- All AR Shops --"
		If IsConsignment = 0 Then
			AllShop = "-- All GL Shops --"
		End If
		outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & AllShop
		For i = 0 To getOutlet.Rows.Count - 1
			If Request.Form("ShopIDList") = getOutlet.Rows(i)("ProductLevelID") Then
				FormSelected = " selected"
			Else
				FormSelected = ""
			End If
			outputString += "<option value=""" & getOutlet.Rows(i)("ProductLevelID").ToString & """ " & FormSelected & ">" & getOutlet.Rows(i)("ProductLevelName")
		Next
		outputString += "</select>"
		OutletText.InnerHtml = outputString
		
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
	

	Dim DailyDateValue As String = ""
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
	Dim outputString As String = ""
	Dim grandTotal As Double = 0
	Dim GraphData As New DataSet()
	Dim ReportDate As String
	showResult.Visible = False
	
	StartDate = DateTimeUtil.FormatDate(Request.Form("DocDaily_Day"),Request.Form("DocDaily_Month"),Request.Form("DocDaily_Year"))
	Dim DateFrom As New DateTime(Request.Form("DocDaily_Year"),Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"), 0, 0, 0)
	Dim DateTo As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
	Dim NumDay As Integer = DateDiff("d",DateFrom,DateTo)
	EndDate = DateTimeUtil.FormatDate(Request.Form("DocTo_Day"), Request.Form("DocTo_Month"), Request.Form("DocTo_Year"))
	
	If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
		ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + defaultTextTable.Rows(45)("TextParamValue") + "</td></tr></table>"
		FoundError = True
	ElseIf NumDay > 16 Then
		ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + "You choose date range greater than 16 days. Please reselect to reduce the date range" + "</td></tr></table>"
		FoundError = True
	Else
		ResultSearchText.InnerHtml = ""
		Dim SDate1 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
		Dim EDate1 As New Date(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"))
		ReportDate = Format(SDate1, "dd MMMM yyyy") + " - " + Format(EDate1, "dd MMMM yyyy")
	End If
	
	Dim IsConsignment As Integer = 0
	If Request.Form("ExportType") = 1 Then
		IsConsignment = 1
	End If
	
	Dim Chk As DataTable = objDB.List("select * from ProductLevel a, ShopExtData b where a.ProductLevelID=b.ShopID AND a.Deleted=0 AND a.IsShop=1 AND b.IsConsignment=" + IsConsignment.ToString + " AND ExportERP=1", objCnn)
	
	Dim ShopIDList As String = ""
	Dim i As Integer
	Dim ChkEndDay As DataTable
	If Request.Form("ShopIDList") <> 0 Then
		ShopIDList = Request.Form("ShopIDList").ToString
	End If
	
	'If Chk.Rows.Count = 0 Then
		'ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + "There is no shop data for export. Please check the ERPExport in ERP Mapping Data" + "</td></tr></table>"
		'FoundError = True
	'Else
		'For i = 0 To Chk.Rows.Count - 1
		'	ShopIDList += "," + Chk.Rows(i)("ProductLevelID").ToString
		'Next
		'ShopIDList = "0" + ShopIDList
		'ChkEndDay = objDB.List("select * from SessionEndDayDetail where ProductLevelID IN (" + ShopIDList + ") AND IsEndDay=1 AND SessionDate = " + StartDate, objCnn)
		'If ChkEndDay.Rows.Count <> Chk.Rows.Count Then
		'	ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + "Number of shops for exporting are " + Chk.Rows.Count.ToString + ",but the sale data are not the same which are " + ChkEndDay.Rows.Count.ToString + ". Please check the sale data and then try again." + "</td></tr></table>"
		'	FoundError = True
		'End If
	'End If

	
	If FoundError = False Then
		'ShowPrint.Visible = True
		showResult.Visible = True
		Dim displayTable As New DataTable()
		Dim dtTable As New DataTable()

		Dim foundRows() As DataRow
        Dim expression As String
		
		If Request.Form("ExportType") = 1 Then
			ExportAR(ShopIDList,StartDate,EndDate,objCnn)
		Else
			ExportGL(ShopIDList,StartDate,EndDate,objCnn)
		End If
	End If
End Sub

Public Function ExportAR (ByVal ShopIDList As String, ByVal StartDate As String, ByVal EndDate As String, ByVal objCnn As MySqlConnection) As String
	Dim SaleDate As String = Trim(Replace(Replace(Replace(Replace(StartDate,"{",""),"}",""),"'",""),"d",""))
	Dim myArray() As String

	Dim SaleYear,SaleMonth,SaleDay As String

	Dim DocDate As String 

	Dim LastDate As String 
	
	myArray = SaleDate.Split("-"c)
	If myArray.Length = 3 Then
		SaleYear = myArray(0)
		SaleMonth = myArray(1)
		SaleDay = myArray(2)
	End If
	DocDate = SaleYear + SaleMonth + SaleDay
	
	Dim filename As String = "AR-" + DocDate + ".csv"
	Dim ResultText As String = ""

	Dim i As Integer = 0
	
	Dim AdditionalQuery As String = ""
	If ShopIDList <> "" Then
		AdditionalQuery += " AND a.ShopID IN (" + ShopIDList + ")"
	End If
	
	Dim sqlStatement As String
	
	sqlStatement = "select a.SaleDate,a.ShopID,pl.ProductLevelCode,pl.ProductLevelName,IF(b.ShopCodeAbb is NULL,'',b.ShopCodeAbb) As ShopCodeAbb,IF(b.AccountCodeVAT is NULL,'',b.AccountCodeVAT) As AccountCodeVAT,IF(b.AccountCodeSale is NULL,'',b.AccountCodeSale) As AccountCodeSale,IF(b.AccountCodeService is NULL,'',b.AccountCodeService) As AccountCodeService,IF(b.CodeAR is NULL,'',b.CodeAR) As CodeAR,IF(b.TaxGroup is NULL,'',b.TaxGroup) As TaxGroup,IF(b.SourceCode is NULL,'',b.SourceCode) As SourceCode,SUM(Round(a.ServiceCharge,2)) AS ServiceCharge,SUM(Round(a.TransactionVatable,2)) AS TransactionVatable,SUM(Round(a.TransactionVAT,2)) AS TransactionVAT,SUM(Round(aa.SalePrice,2)+Round(a.TransactionExcludeVAT,2)-Round(a.TransactionVAT,2)+Round(a.ServiceChargeVAT,2)+Round(a.OtherIncome,2)+Round(a.OtherIncomeVAT,2)) As SaleBeforeVAT from ordertransaction a inner join (select TransactionID,ComputerID,SUM(SalePrice) As SalePrice from DummyTran a WHERE TransactionStatusID=2 AND DocType=8 AND SaleDate between " + StartDate + " and " + EndDate + AdditionalQuery + " group by TransactionID,ComputerID) aa ON a.TransactionID=aa.TransactionID AND a.ComputerID=aa.ComputerID left outer join ProductLevel pl ON a.ShopID=pl.ProductLevelID left outer join ShopExtData b ON a.ShopID=b.ShopID where a.DocType=8 AND a.TransactionStatusID=2 AND b.ExportERP=1 AND b.IsConsignment=1 AND a.SaleDate between " + StartDate + " and " + EndDate + AdditionalQuery + " group by a.SaleDate,a.ShopID,pl.ProductLevelCode,pl.ProductLevelName,b.ShopCodeAbb,b.AccountCodeVAT,b.AccountCodeSale,b.AccountCodeService,b.CodeAR,b.TaxGroup,b.SourceCode order by a.SaleDate,a.ShopID"
	
	Dim dtTable As DataTable = objDB.List(sqlStatement, objCnn)
	Dim SaleTotal As Double
	Dim counter As Integer
	Dim DummyDate As DateTime
	Response.Clear()
    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader("Content-Disposition", "attachment; filename=""" & filename & """")
	Response.Charset = "windows-874"
	Response.ContentEncoding = System.Text.Encoding.GetEncoding(874)
    Response.Flush()
	Response.Write("RECTYPE,CNTBTCH,CNTITEM,IDCUST,IDINVC,TEXTTRX,IDTRX,INVCDESC,INVCAPPLTO,DATEINVC,DATEASOF,RATETYPE,EXCHRATEHC,DATEDUE,SWTAXBL,SWMANTX,CODETAXGRP,TAXSTTS1,VALUES" + chr(13) & chr(10))
	Response.Write("RECTYPE,CNTBTCH,CNTITEM,CNTLINE,IDDIST,TEXTDESC,AMTEXTN,BASETAX1,TAXSTTS1,SWTAXINCL1,RATETAX1,AMTTAX1,IDACCTREV,,,,,," + chr(13) & chr(10))
	Response.Write("RECTYPE,CNTBTCH,CNTITEM,CNTPAYM,DATEDUE,AMTDUE,DATEDISC,AMTDISC,,,,,,,,,,," + chr(13) & chr(10))
	Response.Write("RECTYPE,CNTBTCH,CNTITEM,OPTFIELD,VALUE,,,,,,,,,,,,,," + chr(13) & chr(10))
	Response.Write("RECTYPE,CNTBTCH,CNTITEM,CNTLINE,OPTFIELD,VALUE,,,,,,,,,,,,," + chr(13) & chr(10))
	For i = 0 To dtTable.Rows.Count - 1
	  If Not IsDBNull(dtTable.Rows(i)("SaleBeforeVAT")) Then
		DummyDate = dtTable.Rows(i)("SaleDate")
		SaleDate = DummyDate.ToString("yyyy-MM-dd", InvC)
		myArray = SaleDate.Split("-"c)
		If myArray.Length = 3 Then
			SaleYear = myArray(0)
			SaleMonth = myArray(1)
			SaleDay = myArray(2)
		End If
		DocDate = SaleYear + SaleMonth + SaleDay
		Dim LastDayOfMonth As New Date(SaleYear,SaleMonth,1)
		LastDayOfMonth = DateAdd("m",1,LastDayOfMonth)
		LastDayOfMonth = DateAdd("d",-1,LastDayOfMonth)
		LastDate = LastDayOfMonth.ToString("yyyyMMdd", InvC)
		
		Response.Write("1,1," + (i+1).ToString + "," + dtTable.Rows(i)("CodeAR") + "," + dtTable.Rows(i)("ShopCodeAbb") + "-" + DocDate + ",1,12," + dtTable.Rows(i)("ProductLevelName") + ",," + DocDate + "," + DocDate + ",AR,1," + LastDate + ",0,0," + dtTable.Rows(i)("TaxGroup") + ",1,," + chr(13) & chr(10))
		'Detail
		counter = 20
		SaleTotal = dtTable.Rows(i)("SaleBeforeVAT")
		'SaleTotal = dtTable.Rows(i)("TransactionVatable") - dtTable.Rows(i)("TransactionVAT") - dtTable.Rows(i)("ServiceCharge")
		Response.Write("2,1," + (i+1).ToString + "," + counter.ToString + ",,Sale " + dtTable.Rows(i)("ShopCodeAbb") + "," + SaleTotal.ToString + "," + SaleTotal.ToString + ",1,0,0,0," + dtTable.Rows(i)("AccountCodeSale") + chr(13) & chr(10))
		If dtTable.Rows(i)("ServiceCharge") > 0 Then
			counter = counter + 20
			Response.Write("2,1," + (i+1).ToString + "," + counter.ToString + ",,Service Charge " + dtTable.Rows(i)("ShopCodeAbb") + "," + dtTable.Rows(i)("ServiceCharge").ToString + "," + dtTable.Rows(i)("ServiceCharge").ToString + ",1,0,0,0," + dtTable.Rows(i)("AccountCodeService") + chr(13) & chr(10))
		End If
		counter = counter + 20
		Response.Write("2,1," + (i+1).ToString + "," + counter.ToString + ",,Output VAT " + dtTable.Rows(i)("ShopCodeAbb") + "," + dtTable.Rows(i)("TransactionVAT").ToString + "," + dtTable.Rows(i)("TransactionVAT").ToString + ",1,0,0,0," + dtTable.Rows(i)("AccountCodeVAT") + chr(13) & chr(10))
	  End If
	Next
	Response.End()
End Function

Public Function ExportGL (ByVal ShopIDList As String, ByVal StartDate As String, ByVal EndDate As String, ByVal objCnn As MySqlConnection) As String
	Dim SaleDate As String = Trim(Replace(Replace(Replace(Replace(StartDate,"{",""),"}",""),"'",""),"d",""))
	Dim myArray() As String
	
	Dim SaleYear,SaleMonth,SaleDay As String
	
	Dim DocDate As String 
	
	Dim LastDate As String 
	
	myArray = SaleDate.Split("-"c)
	If myArray.Length = 3 Then
		SaleYear = myArray(0)
		SaleMonth = myArray(1)
		SaleDay = myArray(2)
	End If
	DocDate = SaleYear + SaleMonth + SaleDay
	
	Dim filename As String = "GL-" + DocDate + ".csv"
	Dim ResultText As String = ""

	Dim i As Integer = 0
	Dim j As Integer
	
	Dim AdditionalQuery As String = ""
	If ShopIDList <> "" Then
		AdditionalQuery += " AND a.ShopID IN (" + ShopIDList + ")"
	End If
	
	Dim sqlStatement As String
	
	sqlStatement = "select a.SaleDate,a.ShopID,pl.ProductLevelCode,pl.ProductLevelName,IF(b.ShopCodeAbb is NULL,'',b.ShopCodeAbb) As ShopCodeAbb,IF(b.AccountCodeVAT is NULL,'',b.AccountCodeVAT) As AccountCodeVAT,IF(b.AccountCodeSale is NULL,'',b.AccountCodeSale) As AccountCodeSale,IF(b.AccountCodeService is NULL,'',b.AccountCodeService) As AccountCodeService,IF(b.AccountCodeMisc is NULL,'',b.AccountCodeMisc) As AccountCodeMisc,IF(b.CodeAR is NULL,'',b.CodeAR) As CodeAR,IF(b.TaxGroup is NULL,'',b.TaxGroup) As TaxGroup,IF(b.SourceCode is NULL,'',b.SourceCode) As SourceCode,SUM(Round(a.ServiceCharge,2)) AS ServiceCharge,SUM(Round(a.TransactionVatable,2)) AS TransactionVatable,SUM(Round(a.TransactionVAT,2)) AS TransactionVAT,SUM(Round(aa.SalePrice,2)+Round(a.TransactionExcludeVAT,2)-Round(a.TransactionVAT,2)+Round(a.ServiceChargeVAT,2)+Round(a.OtherIncome,2)+Round(a.OtherIncomeVAT,2)) As SaleBeforeVAT from ordertransaction a inner join (select TransactionID,ComputerID,SUM(SalePrice) As SalePrice from DummyTran a WHERE TransactionStatusID=2 AND DocType=8 AND SaleDate between " + StartDate + " and " + EndDate + AdditionalQuery + " group by TransactionID,ComputerID) aa ON a.TransactionID=aa.TransactionID AND a.ComputerID=aa.ComputerID left outer join ProductLevel pl ON a.ShopID=pl.ProductLevelID left outer join ShopExtData b ON a.ShopID=b.ShopID where a.DocType=8 AND a.TransactionStatusID=2 AND b.ExportERP=1 AND b.IsConsignment=0 AND a.SaleDate between " + StartDate + " and " + EndDate + AdditionalQuery + " group by a.SaleDate,a.ShopID,pl.ProductLevelCode,pl.ProductLevelName,b.ShopCodeAbb,b.AccountCodeVAT,b.AccountCodeSale,b.AccountCodeService,b.CodeAR,b.TaxGroup,b.SourceCode order by a.SaleDate,a.ShopID"
	
	Dim dtTable As DataTable = objDB.List(sqlStatement, objCnn)
	Dim SaleTotal As Double
	Dim counter As Integer
	Dim foundRows() As DataRow
	Dim ccType() As DataRow
    Dim expression As String
	Dim paystring2 As String
	
	sqlStatement = "select DAYOFMONTH(a.SaleDate) As SaleDay,MONTH(a.SaleDate) As SaleMonth,YEAR(a.SaleDate) As SaleYear,a.SaleDate,a.ShopID,pl.ProductLevelCode As ShopCode,pl.ProductLevelName,pl.ProductLevelCode AS TransactionKey,b.PayTypeID,c.PayType AS PayTypeName,IF(ex.BankAccount is NULL,'',ex.BankAccount) As BankAccount,IF(ex.BankTransferBBL is NULL,'',ex.BankTransferBBL) As BankTransferBBL,IF(ex.BankTransferBLA is NULL,'',ex.BankTransferBLA) As BankTransferBLA,IF(ex.BankTransferBKB is NULL,'',ex.BankTransferBKB) As BankTransferBKB,IF(ex.DefaultBankTransfer is NULL,'BBL',ex.DefaultBankTransfer) As DefaultBankTransfer,IF(ex.AccountCoupon is NULL,'',ex.AccountCoupon) As AccountCoupon,SUM(Round(b.Amount,2)) AS TotalPay, IsSale, IsVAT from ordertransaction a, paydetail b, paytype c, ProductLevel pl, ShopExtData ex where a.transactionid=b.transactionid and a.computerid=b.computerid and a.ShopID=pl.ProductLevelID and a.ShopID=ex.ShopID and a.TransactionStatusID=2 and b.PayTypeID=c.TypeID and a.DocType=8 and ex.IsConsignment=0 AND ex.ExportERP=1 and a.SaleDate between " + StartDate + " and " + EndDate + AdditionalQuery + " group by b.PayTypeID,c.PayType,IsSale,IsVAT,a.ShopID,pl.ProductLevelCode,pl.ProductLevelName,ex.BankAccount,ex.BankTransferBBL,ex.BankTransferBLA,ex.BankTransferBKB,ex.AccountCoupon,a.SaleDate order by a.SaleDate,a.ShopID,b.PayTypeID"
	'paystring2 = sqlStatement
	
	Dim PayDetail As DataTable = objDB.List(sqlStatement, objCnn)
	
	sqlStatement = "select DAYOFMONTH(a.SaleDate) As SaleDay,MONTH(a.SaleDate) As SaleMonth,YEAR(a.SaleDate) As SaleYear,a.SaleDate,a.ShopID,pl.ProductLevelCode As ShopCode,pl.ProductLevelName,pl.ProductLevelCode AS TransactionKey,b.PayTypeID,c.PayType AS PayTypeName,IF(ex.BankAccount is NULL,'',ex.BankAccount) As BankAccount,IF(ex.BankTransferBBL is NULL,'',ex.BankTransferBBL) As BankTransferBBL,IF(ex.BankTransferBLA is NULL,'',ex.BankTransferBLA) As BankTransferBLA,IF(ex.BankTransferBKB is NULL,'',ex.BankTransferBKB) As BankTransferBKB,IF(ex.AccountCoupon is NULL,'',ex.AccountCoupon) As AccountCoupon,SUM(Round(b.Amount,2)) AS TotalPay, IsSale, IsVAT from ordertransaction a, paydetail b, paytype c, ProductLevel pl, ShopExtData ex where a.transactionid=b.transactionid and a.computerid=b.computerid and a.ShopID=pl.ProductLevelID and a.ShopID=ex.ShopID and a.TransactionStatusID=2 and b.PayTypeID=c.TypeID and a.DocType=8 and ex.IsConsignment=0 AND ex.ExportERP=1 and b.CreditCardType=5 AND b.PayTypeID=2 and a.SaleDate between " + StartDate + " and " + EndDate + AdditionalQuery + " group by b.PayTypeID,c.PayType,IsSale,IsVAT,a.ShopID,pl.ProductLevelCode,pl.ProductLevelName,ex.BankAccount,ex.BankTransferBBL,ex.BankTransferBLA,ex.BankTransferBKB,ex.AccountCoupon,a.SaleDate order by a.SaleDate,a.ShopID,b.PayTypeID"
	
	Dim AMEX As DataTable = objDB.List(sqlStatement, objCnn)
	Dim PayString As String
	Dim TotalPay As Double
	Dim grandTotalSale As Double
	Dim DummyDate As DateTime

	Response.Clear()
    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader("Content-Disposition", "attachment; filename=""" & filename & """")
	Response.Charset = "windows-874"
	Response.ContentEncoding = System.Text.Encoding.GetEncoding(874)
    Response.Flush()
	Response.Write("RECTYPE,BATCHID,BTCHENTRY,SRCELEDGER,SRCETYPE,FSCSYR,FSCSPERD,SWEDIT,SWREVERSE,JRNLDESC,DATEENTRY,,,,,,,," + chr(13) & chr(10))
	Response.Write("RECTYPE,BATCHNBR,JOURNALID,TRANSNBR,SRCELDGR,SRCETYPE,TRANSDATE,TRANSREF,TRANSDESC,ACCTID,TRANSAMT,TRANSQTY,SCURNAMT,RATETYPE,SCURNCODE,RATEDATE,CONVRATE,COMMENT,VALUES" + chr(13) & chr(10))
	Response.Write("RECTYPE,BATCHNBR,JOURNALID,TRANSNBR,OPTFIELD,VALUE,,,,,,,,,,,,," + chr(13) & chr(10))

	For i = 0 To dtTable.Rows.Count - 1
	  If Not IsDBNull(dtTable.Rows(i)("SaleBeforeVAT")) Then
	  	DummyDate = dtTable.Rows(i)("SaleDate")
		SaleDate = DummyDate.ToString("yyyy-MM-dd", InvC)
		myArray = SaleDate.Split("-"c)
		If myArray.Length = 3 Then
			SaleYear = myArray(0)
			SaleMonth = myArray(1)
			SaleDay = myArray(2)
		End If
		DocDate = SaleYear + SaleMonth + SaleDay
		
		Response.Write("1,1," + (i+1).ToString + ",GL,RV," + SaleYear + "," + SaleMonth + ",0,0," + dtTable.Rows(i)("ProductLevelName") + "," + DocDate + chr(13) & chr(10))
		'Detail

		Dim LastDayOfMonth As New Date(SaleYear,SaleMonth,1)
		LastDayOfMonth = DateAdd("m",1,LastDayOfMonth)
		LastDayOfMonth = DateAdd("d",-1,LastDayOfMonth)
		LastDate = LastDayOfMonth.ToString("yyyyMMdd", InvC)
		
		expression = " ShopID=" + dtTable.Rows(i)("ShopID").ToString + " AND SaleDay=" + SaleDay + " AND SaleMonth=" + SaleMonth + " AND SaleYear=" + SaleYear
		foundRows = PayDetail.Select(expression)
		'Response.Write(expression + ":::" + foundRows.GetUpperBound(0).ToString + chr(13) & chr(10))
		
		'Response.Write(chr(13) & chr(10) + chr(13) & chr(10) + paystring2 + chr(13) & chr(10) + chr(13) & chr(10))
		counter = 0
		SaleTotal = dtTable.Rows(i)("SaleBeforeVAT")
		'SaleTotal = dtTable.Rows(i)("TransactionVatable") - dtTable.Rows(i)("TransactionVAT") - dtTable.Rows(i)("ServiceCharge")
		grandTotalSale = dtTable.Rows(i)("TransactionVatable")
		TotalPay = 0
		For j = 0 To foundRows.GetUpperBound(0)
			TotalPay += foundRows(j)("TotalPay")
			counter = counter + 20
			If foundRows(j)("PayTypeID") = 1 Then 'Cash
				Response.Write("2,1," + (i+1).ToString + "," + counter.ToString + ",GL,RV," + DocDate + ",,Cash " + dtTable.Rows(i)("ShopCodeAbb") + "," + foundRows(j)("BankAccount") + "," + foundRows(j)("TotalPay").ToString + ",0," + foundRows(j)("TotalPay").ToString + ",AP,THB," + DocDate + ",1,,," + chr(13) & chr(10))
			ElseIf foundRows(j)("PayTypeID") = 2 Then 'Credit Card
				ccType = AMEX.Select(expression)
				If ccType.GetUpperBound(0) >= 0 Then
					If foundRows(j)("DefaultBankTransfer") = "KBK" Then
						Response.Write("2,1," + (i+1).ToString + "," + counter.ToString + ",GL,RV," + DocDate + ",,Credit Card KBK " + dtTable.Rows(i)("ShopCodeAbb") + "," + foundRows(j)("BankTransferBKB") + "," + (foundRows(j)("TotalPay")-ccType(0)("TotalPay")).ToString + ",0," + (foundRows(j)("TotalPay")-ccType(0)("TotalPay")).ToString + ",AP,THB," + DocDate + ",1,,," + chr(13) & chr(10))
					Else
						Response.Write("2,1," + (i+1).ToString + "," + counter.ToString + ",GL,RV," + DocDate + ",,Credit Card BBL " + dtTable.Rows(i)("ShopCodeAbb") + "," + foundRows(j)("BankTransferBBL") + "," + (foundRows(j)("TotalPay")-ccType(0)("TotalPay")).ToString + ",0," + (foundRows(j)("TotalPay")-ccType(0)("TotalPay")).ToString + ",AP,THB," + DocDate + ",1,,," + chr(13) & chr(10))
					End If
					counter += 20
					Response.Write("2,1," + (i+1).ToString + "," + counter.ToString + ",GL,RV," + DocDate + ",,Credit Card AMEX " + dtTable.Rows(i)("ShopCodeAbb") + "," + foundRows(j)("BankTransferBLA") + "," + ccType(0)("TotalPay").ToString + ",0," + ccType(0)("TotalPay").ToString + ",AP,THB," + DocDate + ",1,,," + chr(13) & chr(10))
				Else
					If foundRows(j)("DefaultBankTransfer") = "KBK" Then
						Response.Write("2,1," + (i+1).ToString + "," + counter.ToString + ",GL,RV," + DocDate + ",,Credit Card KBK " + dtTable.Rows(i)("ShopCodeAbb") + "," + foundRows(j)("BankTransferBKB") + "," + foundRows(j)("TotalPay").ToString + ",0," + foundRows(j)("TotalPay").ToString + ",AP,THB," + DocDate + ",1,,," + chr(13) & chr(10))
					Else
						Response.Write("2,1," + (i+1).ToString + "," + counter.ToString + ",GL,RV," + DocDate + ",,Credit Card BBL " + dtTable.Rows(i)("ShopCodeAbb") + "," + foundRows(j)("BankTransferBBL") + "," + foundRows(j)("TotalPay").ToString + ",0," + foundRows(j)("TotalPay").ToString + ",AP,THB," + DocDate + ",1,,," + chr(13) & chr(10))
					End If
				End If
			Else 'Coupon
				Response.Write("2,1," + (i+1).ToString + "," + counter.ToString + ",GL,RV," + DocDate + ",,Coupon " + dtTable.Rows(i)("ShopCodeAbb") + "," + foundRows(j)("AccountCoupon") + "," + foundRows(j)("TotalPay").ToString + ",0," + foundRows(j)("TotalPay").ToString + ",AP,THB," + DocDate + ",1,,," + chr(13) & chr(10))
			End If
		Next
		If Math.Round(TotalPay,2) <> Math.Round(grandTotalSale,2) Then
			counter += 20
			Response.Write("2,1," + (i+1).ToString + "," + counter.ToString + ",GL,RV," + DocDate + ",,Miscellaneous " + dtTable.Rows(i)("ShopCodeAbb") + "," + dtTable.Rows(i)("AccountCodeMisc") + "," + (TotalPay-grandTotalSale).ToString + ",0," + (TotalPay-grandTotalSale).ToString + ",AP,THB," + DocDate + ",1,,," + chr(13) & chr(10))
		End If
		counter = counter + 20
		Response.Write("2,1," + (i+1).ToString + "," + counter.ToString + ",GL,RV," + DocDate + ",,Sale " + dtTable.Rows(i)("ShopCodeAbb") + "," + dtTable.Rows(i)("AccountCodeSale") + ",-" + SaleTotal.ToString + ",0,-" + SaleTotal.ToString + ",AP,THB," + DocDate + ",1,,," + chr(13) & chr(10))
		If dtTable.Rows(i)("ServiceCharge") > 0 Then
			counter = counter + 20
			Response.Write("2,1," + (i+1).ToString + "," + counter.ToString + ",GL,RV," + DocDate + ",,Service Charge " + dtTable.Rows(i)("ShopCodeAbb") + "," + dtTable.Rows(i)("AccountCodeService") + ",-" +  dtTable.Rows(i)("ServiceCharge").ToString + ",0,-" +  dtTable.Rows(i)("ServiceCharge").ToString + ",AP,THB," + DocDate + ",1,,," + chr(13) & chr(10))
		End If
		counter = counter + 20
		Response.Write("2,1," + (i+1).ToString + "," + counter.ToString + ",GL,RV," + DocDate + ",,Output VAT " + dtTable.Rows(i)("ShopCodeAbb") + "," + dtTable.Rows(i)("AccountCodeVAT") + ",-" +  dtTable.Rows(i)("TransactionVAT").ToString + ",0,-" +  dtTable.Rows(i)("TransactionVAT").ToString + ",AP,THB," + DocDate + ",1,,," + chr(13) & chr(10))
	  End If
	Next
	Response.End()
End Function

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
