<%@ Page Language="VB" ContentType="text/html" debug="True"%>
<%@ Register tagPrefix="Web" Namespace="WebChart" Assembly="WebChart" %>
<%@ Import Namespace="System.Drawing" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>

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
<input type="hidden" id="ShopList" runat="server" />
<input type="hidden" id="TempTableName" runat="server" />
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
Dim Util As New UtilityFunction()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated  Then
		
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
		
		HeaderText.InnerHtml = "Export Sale Data to SUN"
		
		Dim CultureString As String = Util.GetCultureByLangID(Session("LangID"), objCnn)
		Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
			
		DailyDate.YearType = GlobalParam.YearType
		DailyDate.FormName = "DocDaily"
		DailyDate.StartYear = GlobalParam.StartYear
		DailyDate.EndYear = GlobalParam.EndYear
		DailyDate.LangID = Session("LangID")
		DailyDate.Lang_Data = LangDefault
		DailyDate.Culture = CultureString
		
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

		Dim ShopIDValue As String = "0"
		If IsNumeric(Request.Form("ShopID")) Then
			ShopIDValue = Request.Form("ShopID").ToString
		Else If IsNumeric(Request.QueryString("ShopID"))
			ShopIDValue = Request.QueryString("ShopID").ToString
		End If
			
		Dim i As Integer
		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		Dim OutIDList As String = "0"
		
		Dim getCompany As DataTable = objDB.List("select distinct(CompanyCode) As CompanyCode from ShopExtData where Deleted=0 AND CompanyCode is not NULL", objCnn)
		Dim CompanyCode As String = ""
		If getCompany.Rows.Count > 0 Then
			outputString = "<select name=""CompanyCode"" onchange=""submit()"">"
			For i = 0 To getCompany.Rows.Count - 1
				If Request.Form("CompanyCode") = getCompany.Rows(i)("CompanyCode") Then
					FormSelected = " selected"
				Else
					FormSelected = ""
				End If
				outputString += "<option value=""" & getCompany.Rows(i)("CompanyCode") & """ " & FormSelected & ">" & getCompany.Rows(i)("CompanyCode")
			Next
			outputString += "</select>"
			ShopText.InnerHtml = outputString
			
			If Request.Form("CompanyCode") is Nothing Then
				CompanyCode = getCompany.Rows(0)("CompanyCode")
			Else
				CompanyCode = Request.Form("CompanyCode")
			End If
			
			Dim getOutlet As DataTable = objDB.List("select * from ProductLevel a, ShopExtData b where a.ProductLevelID=b.ShopID AND a.Deleted=0 AND a.IsShop=1 AND ExportERP=1 AND CompanyCode='" + Replace(CompanyCode,"'","''") + "' order by a.ProductLevelID", objCnn)
			
			outputString = "<select name=""ShopIDList"">"
		
			If Request.Form("ShopIDList") = 0 OR Not Page.IsPostBack Then
				FormSelected = " selected"
			Else
				FormSelected = ""
			End If
			Dim AllShop As String = "-- All Shops --"
			
	
			outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & AllShop
			For i = 0 To getOutlet.Rows.Count - 1
				If Request.Form("ShopIDList") = getOutlet.Rows(i)("ProductLevelID") Then
					FormSelected = " selected"
				Else
					FormSelected = ""
				End If
				outputString += "<option value=""" & getOutlet.Rows(i)("ProductLevelID").ToString & """ " & FormSelected & ">" & getOutlet.Rows(i)("ProductLevelName")
				OutIDList += "," + getOutlet.Rows(i)("ProductLevelID").ToString
			Next
			outputString += "</select>"
			OutletText.InnerHtml = outputString
			SubmitForm.Enabled = True
		Else
			SubmitForm.Enabled = False
			errorMsg.InnerHtml = "Cannot find company data"
		End If
		ShopList.Value = OutIDList
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
	Dim DateTo As New DateTime(Request.Form("DocDaily_Year"),Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"), 0, 0, 0)
	Dim NumDay As Integer = DateDiff("d",DateFrom,DateTo)
	EndDate = DateTimeUtil.FormatDate(Request.Form("DocDaily_Day"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Year"))
	
	If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
		ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + defaultTextTable.Rows(45)("TextParamValue") + "</td></tr></table>"
		FoundError = True
	ElseIf NumDay > 16 Then
		ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + "You choose date range greater than 16 days. Please reselect to reduce the date range" + "</td></tr></table>"
		FoundError = True
	Else
		ResultSearchText.InnerHtml = ""
		Dim SDate1 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
		Dim EDate1 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
		ReportDate = Format(SDate1, "dd MMMM yyyy") + " - " + Format(EDate1, "dd MMMM yyyy")
	End If
	

	
	Dim ShopIDList As String = ""
	Dim i As Integer
	Dim ChkEndDay As DataTable
	If Request.Form("ShopIDList") <> 0 Then
		ShopIDList = Request.Form("ShopIDList").ToString
	Else
		ShopIDList = ShopList.Value
	End If

	
	If FoundError = False Then
		'ShowPrint.Visible = True
		showResult.Visible = True
		Dim displayTable As New DataTable()
		Dim dtTable As New DataTable()

		Dim foundRows() As DataRow
        Dim expression As String
		'Application.Lock()
		ExportSUN(Request.Form("CompanyCode"),ShopIDList,StartDate,EndDate,objCnn)
		'Application.UnLock()

	End If
End Sub

Public Function ExportSUN (ByVal CompanyCode As String,ByVal ShopIDList As String, ByVal StartDate As String, ByVal EndDate As String, ByVal objCnn As MySqlConnection) As String
	Dim SaleDate As String = Trim(Replace(Replace(Replace(Replace(StartDate,"{",""),"}",""),"'",""),"d",""))
	Dim myArray() As String

	Dim SaleYear,SaleMonth,SaleDay As String

	Dim DocDate,ShortDocDate As String 

	Dim LastDate As String 
	
	myArray = SaleDate.Split("-"c)
	If myArray.Length = 3 Then
		SaleYear = myArray(0)
		SaleMonth = myArray(1)
		SaleDay = myArray(2)
	End If
	DocDate = SaleYear + SaleMonth + SaleDay
	ShortDocDate = SaleDay + SaleMonth + RIGHT(SaleYear,2)
	
	Dim filename As String = CompanyCode + ShortDocDate + ".prn"
	Dim ResultText As String = ""

	Dim i As Integer = 0
	Dim j As Integer
	
	Dim AdditionalQuery As String = ""
	If ShopIDList <> "" Then
		AdditionalQuery += " AND a.ShopID IN (" + ShopIDList + ")"
	End If
	
	Dim sqlStatement As String
	
	'sqlStatement = "select 1 As Ordering,'C' As Type,a.ShopID,ShopCode,ShopName,ERPShopCode,ShopLevelCode,CompanyCode,ProductGroupCode,ProductGroupName,SaleDate,SUM(SalePrice) As SalePrice from DummyTran a left outer join ShopExtData b ON a.ShopID=b.ShopID WHERE TransactionStatusID=2 AND DocType=8 AND ProductGroupCode is not NULL AND SaleDate=" + StartDate + AdditionalQuery + " group by a.ShopID,ShopCode,ShopName,ERPShopCode,ShopLevelCode,CompanyCode,ProductGroupCode,ProductGroupName,SaleDate" + _
	'			" UNION select 2 As Ordering,'C' As Type,a.ShopID,e.ERPShopCode As ShopCode,pl.ProductLevelName As ShopName,ERPShopCode,ShopLevelCode,CompanyCode,'4240000' As ProductGroupCode,'PB1 10%' As ProductGroupName,SaleDate,SUM(TransactionVAT) As SalePrice from ordertransaction a left outer join ShopExtData e ON a.ShopID=e.ShopID left outer join ProductLevel pl ON a.ShopID=pl.ProductLevelID WHERE TransactionStatusID=2 AND DocType=8 AND SaleDate=" + StartDate + AdditionalQuery + " group by a.ShopID,ShopCode,ShopName,ERPShopCode,ShopLevelCode,CompanyCode,SaleDate " + _
	'			" UNION select 3 As Ordering,'D' As Type,a.ShopID,e.ERPShopCode As ShopCode,pl.ProductLevelName As ShopName,ERPShopCode,ShopLevelCode,CompanyCode,IF(d.PayTypeCode is NULL,c.PayTypeCode,d.PayTypeCode) As ProductGroupCode,IF(d.PayType is NULL, c.PayType, d.PayType) As ProductGroupName,SaleDate,SUM(Amount) As SalePrice from ordertransaction a left outer join paydetail b ON a.TransactionID=b.TransactionID AND a.ComputerID=b.ComputerID left outer join PayType c ON b.PayTypeID=c.TypeID left outer join PayType d ON b.SmartCardType=d.TypeID left outer join ShopExtData e ON a.ShopID=e.ShopID left outer join ProductLevel pl ON a.ShopID=pl.ProductLevelID WHERE TransactionStatusID=2 AND DocType=8 AND SaleDate=" + StartDate + AdditionalQuery + " group by a.ShopID,ShopCode,ShopName,ERPShopCode,ShopLevelCode,CompanyCode,d.PayTypeCode,c.PayTypeCode,c.PayType,d.PayType,SaleDate"		
				
	sqlStatement = "select 1 As Ordering,'C' As Type,a.ShopID,ShopCode,ShopName,ERPShopCode,ShopLevelCode,CompanyCode,IF(ProductGroupCode is NULL,'NOCODE',ProductGroupCode) As ProductGroupCode,IF(ProductGroupName is NULL,'NoGroup',ProductGroupName) As ProductGroupName,SaleDate,SUM(SalePrice) As SalePrice from Summary_ProductReport a left outer join ShopExtData b ON a.ShopID=b.ShopID WHERE TransactionStatusID=2 AND SaleDate=" + StartDate + AdditionalQuery + " group by a.ShopID,ShopCode,ShopName,ERPShopCode,ShopLevelCode,CompanyCode,SaleDate,ProductGroupCode,ProductGroupName" + _
				" UNION select 2 As Ordering,'C' As Type,a.ShopID,e.ERPShopCode As ShopCode,pl.ProductLevelName As ShopName,ERPShopCode,ShopLevelCode,CompanyCode,'4240000' As ProductGroupCode,'PB1 10%' As ProductGroupName,SaleDate,SUM(TransactionVAT) As SalePrice from Summary_TranReport a left outer join ShopExtData e ON a.ShopID=e.ShopID left outer join ProductLevel pl ON a.ShopID=pl.ProductLevelID WHERE TransactionStatusID=2 AND SaleDate=" + StartDate + AdditionalQuery + " group by a.ShopID,ShopCode,ShopName,ERPShopCode,ShopLevelCode,CompanyCode,SaleDate " + _
				" UNION select 3 As Ordering,'D' As Type,a.ShopID,e.ERPShopCode As ShopCode,pl.ProductLevelName As ShopName,ERPShopCode,ShopLevelCode,CompanyCode,IF(d.PayTypeCode is NULL,'',d.PayTypeCode) As ProductGroupCode,a.PayTypeName As ProductGroupName,SaleDate,SUM(TotalPay) As SalePrice from summary_paymentsolariareport a left outer join ShopExtData e ON a.ShopID=e.ShopID left outer join ProductLevel pl ON a.ShopID=pl.ProductLevelID left outer join PayType d ON a.PayTypeID=d.TypeID WHERE a.PayTypeID<99999 AND SaleDate=" + StartDate + AdditionalQuery + " group by a.ShopID,ShopCode,ShopName,ERPShopCode,ShopLevelCode,CompanyCode,d.PayTypeCode,a.PayTypeName,SaleDate"							
				
	Dim ExtraTableString As String = Now.Year.ToString + Now.Month.ToString + Now.Day.ToString + Now.Hour.ToString + Now.Minute.ToString + Now.Second.ToString + Now.Millisecond.ToString			
	Dim TempTable As String = "DummyRevenue_" + ExtraTableString		
	
	TempTableName.Value = TempTable

    objDB.sqlExecute("create table " + TempTable + " (Ordering smallint,Type varchar(10), ShopID int, ShopCode varchar(20),ShopName varchar(100),ERPShopCode varchar(20),ShopLevelCode varchar(20),CompanyCode varchar(20),ProductGroupCode varchar(20),ProductGroupName varchar(100),SaleDate datetime,SalePrice decimal(18,4))", objCnn)				
	
	objDB.sqlExecute("insert into " + TempTable + " " + sqlStatement, objCnn)
	Dim dtTable As DataTable 
	Dim SaleTotal As Double
	Dim counter As Integer
	Dim DummyDate As DateTime
	Dim cReturn As String
	cReturn = chr(13) & chr(10)
	Dim dataString As String
	Dim outputString As StringBuilder = New StringBuilder
	Dim outData As String
	Dim DayOfYearValue As Integer
	Dim SaleAmount As String
	Dim SumCredit As Double = 0
	Dim SumDebit As Double = 0
	Dim Diff As Double
	Response.Clear()
    Response.ContentType = "application/text"
    Response.AddHeader("Content-Disposition", "attachment; filename=""" & filename & """")

    Response.Flush()
	Dim ChkSum As DataTable
	Dim TotalSum As Double
	Dim TotalSumRounding As Double
	Dim SumCompare As Double
	Dim getShop As DataTable = objDB.List("select distinct(ShopID) As ShopID from " + TempTable, objCnn)
	
	For j = 0 To getShop.Rows.Count - 1
	  sqlStatement = "select * from " + TempTable + " where ShopID=" + getShop.Rows(j)("ShopID").ToString + " order by Ordering"
	  dtTable = objDB.List(sqlStatement, objCnn)
	  ChkSum = objDB.List("select * from " + TempTable + " where ShopID=" + getShop.Rows(j)("ShopID").ToString + " AND Ordering=1", objCnn)
	  TotalSum = 0
	  For i = 0 to ChkSum.Rows.Count - 1
	  	TotalSum += dtTable.Rows(i)("SalePrice")
	  Next
	  TotalSumRounding = CDbl(Format(TotalSum, "####0"))
	  SumCredit = 0
	  SumDebit = 0
	  SumCompare = 0
	  For i = 0 To dtTable.Rows.Count - 1
	    outData = ""
		If dtTable.Rows(i)("Type") = "C" Then
			SumCredit += dtTable.Rows(i)("SalePrice")
		ElseIf dtTable.Rows(i)("Type") = "D" Then
			SumDebit += dtTable.Rows(i)("SalePrice")
		End If
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
		
		DayOfYearValue = SaleMonth

		dataString = FormatDataString(dtTable.Rows(i)("ProductGroupCode"),10," ",0)
		outData += dataString
		
		dataString = FormatDataString("",5," ",0)
		outData += dataString
		
		dataString = FormatDataString(DayOfYearValue.ToString,3,"0",1)
		outData += SaleYear & dataString
		
		outData += DocDate
		
		dataString = FormatDataString("",2," ",0)
		outData += dataString
		
		outData += "M"
		
		dataString = FormatDataString("",14," ",0)
		outData += dataString
		
		If i = ChkSum.Rows.Count - 1 AND dtTable.Rows(i)("Type") = "C" Then
			SaleAmount = Format(TotalSumRounding-SumCompare, "####0") & "000"
		Else
			SaleAmount = Replace(Format(dtTable.Rows(i)("SalePrice"), "####0"),".","") & "000"
		End If		
		
		If dtTable.Rows(i)("Type") = "C" Then
			SumCompare += CDbl(Format(dtTable.Rows(i)("SalePrice"), "####0"))
		End If
		dataString = FormatDataString(SaleAmount,18,"0",1)
		outData += dataString & dtTable.Rows(i)("Type")
		
		outData += " " & "SAL  " + "     "
		
		dataString = FormatDataString(dtTable.Rows(i)("CompanyCode") & SaleDay & SaleMonth & RIGHT(SaleYear,2),15," ",0)
		outData += dataString
		
		dataString = FormatDataString(dtTable.Rows(i)("ProductGroupName"),25," ",0)
		outData += dataString
		
		dataString = FormatDataString("",8,"0",0)
		outData += dataString
		dataString = FormatDataString("",7,"0",0)
		outData += dataString
		dataString = FormatDataString("",8,"0",0)
		outData += dataString
		
		dataString = FormatDataString("",116," ",0)
		outData += dataString
		
		dataString = FormatDataString(dtTable.Rows(i)("CompanyCode"),15," ",0)
		outData += dataString
		
		dataString = FormatDataString(dtTable.Rows(i)("ERPShopCode"),15," ",0)
		outData += dataString
		
		dataString = FormatDataString(dtTable.Rows(i)("ShopLevelCode"),15," ",0)
		outData += dataString
		
		'outData += "<BR>"
		
		Response.Write(outData & chr(13) & chr(10))
	  Next	
	  outData = ""
	  Diff = Math.ABS(SumCredit - SumDebit)
	  dataString = FormatDataString("4200900",10," ",0)
	  outData += dataString
	  
	  dataString = FormatDataString("",5," ",0)
	  outData += dataString
	  
	  dataString = FormatDataString(DayOfYearValue.ToString,3,"0",1)
	  outData += SaleYear & dataString
	  
	  outData += DocDate
	  
	  dataString = FormatDataString("",2," ",0)
	  outData += dataString
	  
	  outData += "M"
	  
	  dataString = FormatDataString("",14," ",0)
	  outData += dataString
	  
	  SaleAmount = Replace(Format(Diff, "####0"),".","") & "000"
	  
	  dataString = FormatDataString(SaleAmount,18,"0",1)
	  outData += dataString & "D"
	  
	  outData += " " & "SAL  " + "     "
	  
	  dataString = FormatDataString(dtTable.Rows(0)("CompanyCode") & SaleDay & SaleMonth & RIGHT(SaleYear,2),15," ",0)
	  outData += dataString
	  
	  dataString = FormatDataString("PEMBULATAN",25," ",0)
	  outData += dataString
	  
	  dataString = FormatDataString("",8,"0",0)
	  outData += dataString
	  dataString = FormatDataString("",7,"0",0)
	  outData += dataString
	  dataString = FormatDataString("",8,"0",0)
	  outData += dataString
	  
	  dataString = FormatDataString("",116," ",0)
	  outData += dataString
	  
	  dataString = FormatDataString(dtTable.Rows(0)("CompanyCode"),15," ",0)
	  outData += dataString
	  
	  dataString = FormatDataString(dtTable.Rows(0)("ERPShopCode"),15," ",0)
	  outData += dataString
	  
	  dataString = FormatDataString(dtTable.Rows(0)("ShopLevelCode"),15," ",0)
	  outData += dataString
	  
	  'outData += "<BR>"
	  
	  Response.Write(outData & chr(13) & chr(10))
	Next
	'errorMsg.InnerHtml = outData + "<P>" + sqlStatement + "<P>" + DocDate
	objDB.sqlExecute("DROP TABLE IF EXISTS " + TempTable, objCnn)
	Response.End()
	
End Function

Public Function FormatDataString (ByVal dataString As String, ByVal NoDigit As Integer, ByVal dataChar As String, ByVal Position As Integer) As String
	Dim i As Integer
	If LEN(dataString) > NoDigit Then
		dataString =  LEFT(dataString, NoDigit)
	Else
		Dim dataLEN As Integer = LEN(dataString)
		Dim totalLoop As Integer
		Dim insertChar As String = ""
		totalLoop = NoDigit - dataLEN
		For i = 1 to totalLoop
			insertChar += dataChar
		Next
		If Position = 0 Then
			dataString = dataString & insertChar
		Else
			dataString = InsertChar & dataString
		End If
		Return dataString
	End If
	Return dataString
End Function

Public Function GenerateGUID() As String
        Return System.Guid.NewGuid.ToString()
End Function

Sub Page_UnLoad()
	
	objCnn.Close()
End Sub

</script>
</body>
</html>
