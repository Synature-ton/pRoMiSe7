<%@ Page Language="VB" ContentType="text/html" EnableViewState="False" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="CostingClass.pRoMiSeCosting" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="QAReports" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<html>
<head>
<title>Stock Card Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
    <td><asp:radiobutton ID="Radio_1" GroupName="Group1" Enabled="True" runat="server" /></td>
	<td colspan="3"><synature:date id="MonthYearDate" runat="server" /></td>
</tr>
<tr>
	<td></td>
	<td><span id="GroupString" runat="server"></span></td>
    <td><asp:radiobutton ID="Radio_2" GroupName="Group1" Enabled="True" runat="server" /></td>
    <td><synature:date id="CurrentDate" runat="server" /></td>
    <td>to</td>
    <td><synature:date id="ToDate" runat="server" /></td>

</tr>
<tr>
	<td></td>
	<td><asp:dropdownlist ID="OrderParam" Width="250" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
     <td></td>
     <td colspan="3"><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" />&nbsp;&nbsp;<asp:CheckBox ID="DisplayOnly" Checked="false" Text="Display only materials that have movement" CssClass="text" Visible="True" runat="server" /></td>
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
<tr><td align="left"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>

<span id="myTable2" visible="false" runat="server">
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
Dim getPageText As New DefaultText()
Dim objDB As New CDBUtil()
Dim DateTimeUtil As New MyDateTime()
Dim getReport As New StReports()
Dim CostInfo As New CostClass()
Dim getProp As New CPreferences()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer  = 998

Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Report_StockCard2") Then
		
		Try	
			SubmitForm.Attributes.Item("onclick") = "this.disabled=true;" & GetPostBackEventReference(SubmitForm).ToString
			objCnn = getCnn.EstablishConnection()
			ShowContent.Visible = True	
			
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
			
			LangText0.Text = "Stock Card Report"
			
			Dim ChkExist As Boolean = getProp.CheckColumnExist("DocumentType","CalcuateRealCost",objCnn)
			
			If ChkExist = False Then
				'objDB.sqlExecute("ALTER TABLE DocumentType ADD CalcuateRealCost tinyint NOT NULL Default '0' AFTER CalculateStandardProfitLoss", objCnn)
				'objDB.sqlExecute("UPDATE DocumentType SET CalcuateRealCost=1 WHERE DocumentTypeID IN (1,2,10,39,46,47,50,53,12,13)", objCnn)
			End If
			
			MonthYearDate.YearType = GlobalParam.YearType
			MonthYearDate.FormName = "MonthYearDate"
			MonthYearDate.StartYear = GlobalParam.StartYear
			MonthYearDate.EndYear = GlobalParam.EndYear
			MonthYearDate.LangID = Session("LangID")
			MonthYearDate.ShowDay = False
			MonthYearDate.Lang_Data = LangDefault
			MonthYearDate.Culture = CultureString
			
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
			ToDate.Lang_Data = LangDefault
			ToDate.Culture = CultureString
			
			OrderParam.Items(0).Text = "Order By Group -> Material Code"
			OrderParam.Items(0).Value = "mg.MaterialGroupCode,a.MaterialCode"
			OrderParam.Items(1).Text = "Order By Group -> Material Name"
			OrderParam.Items(1).Value = "mg.MaterialGroupCode,a.MaterialName"
			OrderParam.Items(2).Text = "Order By Material Code"
			OrderParam.Items(2).Value = "a.MaterialCode"
			OrderParam.Items(3).Text = "Order By Material Name"
			OrderParam.Items(3).Value = "a.MaterialName"
			
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
			
			If Not Page.IsPostBack Then
				Radio_1.Checked = True
			End If
			
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

				outputString = "<select name=""ShopID"" style=""width:250px"">"
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
			
			Dim MaterialGroup As DataTable = getInfo.GetMaterialGroup(0,0,objCnn)
			Dim GroupStringValue As String = ""
			If Trim(Request.Form("MaterialGroup")) <> "" Then
				GroupStringValue = Request.Form("MaterialGroup").ToString
			Else If Trim(Request.QueryString("MaterialGroup")) <> "" Then
				GroupStringValue = Request.QueryString("MaterialGroup").ToString
			End If
			outputString = "<select name=""MaterialGroup"" style=""width:250px"">"
			If GroupStringValue = "" Then
				FormSelected = "selected"
			Else
				FormSelected = ""
			End If
			outputString += "<option value="""" " & FormSelected & ">" & "-- All Group--"
			For i = 0 to MaterialGroup.Rows.Count - 1
				If GroupStringValue = MaterialGroup.Rows(i)("MaterialGroupCode") Then
					FormSelected = "selected"
				Else
					FormSelected = ""
				End If
				outputString += "<option value=""" & MaterialGroup.Rows(i)("MaterialGroupCode") & """ " & FormSelected & ">" & MaterialGroup.Rows(i)("MaterialGroupName")
			Next
			outputString += "</select>"
			GroupString.InnerHtml = outputString
				
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
	
	myTable2.Visible = False
	errorMsg.InnerHtml = ""

	'Try
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
	Dim ReportDate As String
		
	Dim SelMonth As Integer = 0
	Dim SelYear As Integer = 0
	If IsNumeric(Request.Form("MonthYearDate_Month")) Then SelMonth = Request.Form("MonthYearDate_Month")
	If IsNumeric(Request.Form("MonthYearDate_Year")) Then SelYear = Request.Form("MonthYearDate_Year")
	Dim BeginningDay As Integer = 0
	Dim BeginningMonth As Integer = 0
	Dim BeginningYear As Integer = 0
	Dim StartDateForMovement, BeginStartDate, BeginEndDate As String
	
	Dim ReportType As Integer
	If Radio_1.Checked = True Then
		ReportType = 1
		If SelMonth = 0 Or SelYear = 0 Then
			FoundError = True
		Else
			Dim SDate As New Date(Request.Form("MonthYearDate_Year"),Request.Form("MonthYearDate_Month"),1)
			ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy",Session("LangID"),objCnn)
			If SelMonth = 12 Then
                StartMonthValue = SelMonth
                EndMonthValue = 1
                StartYearValue = SelYear
                EndYearValue = SelYear + 1
            Else
                StartMonthValue = SelMonth
                EndMonthValue = SelMonth + 1
                StartYearValue = SelYear
                EndYearValue = SelYear
            End If
            StartDate = DateTimeUtil.FormatDate(1, StartMonthValue, StartYearValue)
            EndDate = DateTimeUtil.FormatDate(1, EndMonthValue, EndYearValue)
			StartDateForMovement = StartDate
		End If
	ElseIf Radio_2.Checked = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(Request.Form("Doc_Day"),Request.Form("Doc_Month"),Request.Form("Doc_Year"))
		Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))
		StartDateForMovement = DateTimeUtil.FormatDate(1,Request.Form("Doc_Month"),Request.Form("Doc_Year"))
		SelMonth = Request.Form("Doc_Month")
		SelYear = Request.Form("Doc_Year")
		If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
			FoundError = True
		Else
			ResultSearchText.InnerHtml = ""
			Dim SDate1 As New Date(Request.Form("Doc_Year"), Request.Form("Doc_Month"), Request.Form("Doc_Day"))
			Dim EDate1 As New Date(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"))
			ReportDate = DateTimeUtil.FormatDateTime(SDate1, "DateOnly",Session("LangID"),objCnn) + " - " + DateTimeUtil.FormatDateTime(EDate1, "DateOnly",Session("LangID"),objCnn)
			BeginningDay = Request.Form("Doc_Day")
			BeginningMonth = Request.Form("Doc_Month")
			BeginningYear = Request.Form("DocTo_Year")
			BeginStartDate = DateTimeUtil.FormatDate(1, BeginningMonth, BeginningYear)
			BeginEndDate = StartDate
		End If
		ReportType = 2
		Catch ex As Exception
			FoundError = True
		End Try
	End If	
	If FoundError = False Then
		If LangDefault.Rows.Count >= 3 Then
			CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(NOW(), "DateAndTime",Session("LangID"),objCnn)
		End If
		ShowPrint.Visible = True
		myTable2.Visible = True
		Dim TestTime,Result As String
		Dim dtTable,groupData,groupDataL As DataTable
		Dim displayTable As New DataTable()
		
		Dim MGroupData As String = ""
		If Trim(Request.Form("MaterialGroup")) <> "" Then
			MGroupData = "'" & Replace(Request.Form("MaterialGroup"),"'","''") & "'"
		End If
		

			Result = StockCardReport2(MGroupData,"",dtTable,groupData,groupDataL,Request.Form("ShopID"),SelMonth, SelYear,OrderParam.SelectedItem.Value,StartDate,EndDate,ReportType,BeginningDay,BeginningMonth,BeginningYear,objCnn)

		
		ResultSearchText.InnerHtml = "Stock Card Report (Show Stock Movement) " + " (" + ReportDate + ")"
		Dim i As Integer
		
		Dim ExtraInfo As String
		Dim totalSale As Double = 0
		Dim totalCost As Double = 0
		Dim deptCost As Double = 0
		Dim groupCost As Double = 0
		Dim DummyPGroupID,DummyPDeptID,DummyMGroupID,DummyMDeptID As Integer
		Dim ProductGroupName,ProductDeptName,MaterialGroupName,MaterialDeptName As String


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
		Dim ShowGroup As Boolean = False
		If Trim(Request.Form("MaterialGroup")) = "" AND (OrderParam.SelectedIndex = 0 Or OrderParam.SelectedIndex = 1) Then
			ShowGroup = True
		End If
		Dim BeginningSumGroup As Double = 0
		Dim EndingSumGroup As Double = 0
		Dim TotalSumGroup As Double = 0
		Dim ColumnSumGroup(groupData.Rows.Count) As Double
		Dim ColumnSaleSumGroup(groupDataL.Rows.Count) As Double
		Dim DummyGroupCode As String = ""
		Dim DummyGroupName As String = ""
		Dim ShowGroupSummary As Boolean
		
		Dim LineBeginningSumGroup As Double = 0
		Dim LineEndingSumGroup As Double = 0
		Dim LineTotalSumGroup As Double = 0
		Dim LineColumnSumGroup(groupData.Rows.Count) As Double
		Dim LineColumnSaleSumGroup(groupDataL.Rows.Count) As Double
		
		Dim DLineBeginningSumGroup As Double = 0
		Dim DLineEndingSumGroup As Double = 0
		Dim DLineTotalSumGroup As Double = 0
		Dim DLineColumnSumGroup(groupData.Rows.Count) As Double
		Dim DLineColumnSaleSumGroup(groupDataL.Rows.Count) As Double
		Dim OString As String
		Dim BSumText As String = ""
		Dim NoCol As Integer = 1
		
		Dim HeaderString As String = "<tr>"
		If ShowGroup = True Then
			HeaderString += "<td rowspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Code" + "</td>"
			HeaderString += "<td rowspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Group Name" + "<br>" + "<img src=""images/blank.gif"" width=""120"" height=""0"">" + "</td>"
		End If
		HeaderString += "<td rowspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Code" + "</td>"
		HeaderString += "<td rowspan=""2"" align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Material Name" + "<br>" + "<img src=""images/blank.gif"" width=""200"" height=""0"">" + "</td>"
		HeaderString += "<td rowspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Cost" + "</td>"
		HeaderString += "<td rowspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Unit" + "<br>" + "<img src=""images/blank.gif"" width=""100"" height=""0"">" + "</td>"
		HeaderString += "<td colspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "+Beginning" + "</td>"
		For i = 0 To groupData.Rows.Count - 1
			HeaderString += "<td colspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + groupData.Rows(i)("GroupHeader") + "</td>"
			NoCol += 1
		Next
		
		NoCol += 3
		HeaderString += "<td colspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Onhand" + "</td>"
		HeaderString += "<td colspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Ending" + "</td>"

		For i = 0 To groupDataL.Rows.Count - 1
			HeaderString += "<td colspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + groupDataL.Rows(i)("GroupHeader") + "</td>"
			NoCol += 1
		Next
		HeaderString += "<td colspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Actual" + "</td>"
		HeaderString += "<td rowspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "%<br>Variance" + "<br></td>"
		HeaderString += "<td rowspan=""2"" align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Compare<br>Standard" + "<br></td>"
		HeaderString += "</tr>"
		For i = 1 To NoCol 
			HeaderString += "<td align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Qty" + "</td>"
			HeaderString += "<td align=""center"" class=""smalltdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Amount" + "</td>"
		Next
		HeaderString += "<tr>"
		
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
		Dim ActualQty,GroupActualQty,TotalActualQty As Double 
		Dim StdQty,GroupStdQty,TotalStdQty As Double
		Dim VarianceQty,GroupVarianceQty,TotalVarianceQty As Double
		Dim StatGBColor As String = "#ffe4e1"
		Dim GroupSumActual,TotalSumActual,GroupSumStd,TotalSumStd As Double
		Dim LineSumActual,LineSumStd As Double
		Dim SumVariance As Double
		Dim CheckGroupVal As Double
            Dim UseAvgString As String
	
            For i = 0 To dtTable.Rows.Count - 1
                Dim outputString As StringBuilder = New StringBuilder
                showData = False
                SubTotalUse = 0
                SubTotalPrice = 0
                ActualQty = 0
                StdQty = 0
			
                DLineBeginningSumGroup = 0
                DLineEndingSumGroup = 0
                DLineTotalSumGroup = 0
                For j = 0 To groupData.Rows.Count - 1
                    DLineColumnSumGroup(j) = 0
                Next
                For j = 0 To groupDataL.Rows.Count - 1
                    DLineColumnSaleSumGroup(j) = 0
                Next
                outputString = outputString.Append("<tr>")
                If ShowGroup = True Then
                    outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MaterialGroupCode") + "</td>")
                    outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MaterialGroupName") + "</td>")
                End If
                outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MaterialCode") + "</td>")
                outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MaterialName") + "</td>")
                CostPerUnit = 0
                If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                    If dtTable.Rows(i)("TotalAmount") > 0 Then
                        CostPerUnit = dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")
                    End If
                End If
                If CostPerUnit = 0 And Not IsDBNull(dtTable.Rows(i)("BeginningPricePerUnit")) Then
                    CostPerUnit = dtTable.Rows(i)("BeginningPricePerUnit")
                End If
                UnitRatioVal = 1
                If Not IsDBNull(dtTable.Rows(i)("UnitSmallName")) Then
                    UnitText = dtTable.Rows(i)("UnitSmallName")
                Else
                    UnitText = "-"
                End If
                UnitInfo = getInfo.GetUnitSetting(dtTable.Rows(i)("MaterialID"), dtTable.Rows(i)("UnitSmallID"), objCnn)
                If UnitInfo.Rows.Count <> 0 Then
                    UnitRatioVal = UnitInfo.Rows(0)("UnitSmallRatio")
                    UnitText = UnitInfo.Rows(0)("UnitLargeName")
                End If
			
                outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"">" + "<a  class=""smallText"" href=""JavaScript: newWindow = window.open( '../Inventory/product_stdcost.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&SelMonth=" & SelMonth.ToString & "&SelYear=" & SelYear.ToString & "&ProductLevelID=" & Request.Form("ShopID").ToString + "', '', 'width=900,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(CostPerUnit * UnitRatioVal, "##,##0.00") + "</a></td>")
                outputString = outputString.Append("<td class=""smallText"" align=""left"" valign=""top"">" + UnitText + "</td>")
			
                '----- Beginning Stock ---------------
                If Not IsDBNull(dtTable.Rows(i)("NetSmallAmount0")) Then
                    'If dtTable.Rows(i)("NetSmallAmount0") > 0 Then
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"">" + Format(dtTable.Rows(i)("NetSmallAmount0") / UnitRatioVal, "##,##0.0000;(##,##0.0000)") + "</td>")
                    SubTotalUse += dtTable.Rows(i)("NetSmallAmount0")
                    If dtTable.Rows(i)("NetSmallAmount0") <> 0 Then
                        showData = True
                    End If
                    'Else
                    'outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"">0.0000<br>")
                    'End If
                Else
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"">0.0000" + "</td>")
                End If
			
                If Not IsDBNull(dtTable.Rows(i)("ProductNetPrice0")) Then
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"">" + Format(dtTable.Rows(i)("ProductNetPrice0"), "##,##0.00") + "</td>")
                    SubTotalPrice += dtTable.Rows(i)("ProductNetPrice0")
                    BeginningSum += dtTable.Rows(i)("ProductNetPrice0")
                    BeginningSumGroup += dtTable.Rows(i)("ProductNetPrice0")
                    DLineBeginningSumGroup = dtTable.Rows(i)("ProductNetPrice0")
                    showData = True
                Else
                    outputString = outputString.Append("<td class=""smallText"">&nbsp;</td>")
                End If

                '------------- End Beginning -------------------
			
                For j = 0 To groupData.Rows.Count - 1
                    UnitPrice = "0"
                    groupString = "NetSmallAmount" + groupData.Rows(j)("DocumentTypeGroupID").ToString
                    PriceString = "ProductNetPrice" + groupData.Rows(j)("DocumentTypeGroupID").ToString
                    QtyString = "TotalAmount" + groupData.Rows(j)("DocumentTypeGroupID").ToString
                    StdString = "CalculateStandardProfitLoss" + groupData.Rows(j)("DocumentTypeGroupID").ToString
                    UseAvgString = "UseAvgCost" + groupData.Rows(j)("DocumentTypeGroupID").ToString
				
                    If Not IsDBNull(dtTable.Rows(i)("TotalAmount")) And Not IsDBNull(dtTable.Rows(i)("TotalPrice")) Then
                        If dtTable.Rows(i)("TotalAmount") > 0 Then
                            UnitPrice = Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")), "##,##0.000000")
                        Else
                            UnitPrice = "0"
                        End If
                    Else
                        UnitPrice = "0"
                    End If
                    If Not IsDBNull(dtTable.Rows(i)(groupString)) Then
                        outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top""><a class=""smalltext"" href=""JavaScript: newWindow = window.open( 'report_material_doc2.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&UnitPrice=" + UnitPrice + "&DocumentTypeGroupID=" & groupData.Rows(j)("DocumentTypeGroupID").ToString + "&SelMonth=" & SelMonth.ToString & "&SelYear=" & SelYear.ToString & "&ProductLevelID=" & Request.Form("ShopID").ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "&ReportDate=" + ReportDate + "', '', 'width=1000,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(dtTable.Rows(i)(groupString) / UnitRatioVal, "##,##0.0000;(##,##0.0000)") + "</a></td>")
                        SubTotalUse += dtTable.Rows(i)(groupString)
                        If groupData.Rows(j)("ActualCost") = 1 Or groupData.Rows(j)("ActualCost") = 2 Then
                            ActualQty += dtTable.Rows(i)(groupString)
                            GroupActualQty += dtTable.Rows(i)(groupString)
                            TotalActualQty += dtTable.Rows(i)(groupString)
                        End If
                        If groupData.Rows(j)("ActualCost") = 2 Then
                            StdQty += dtTable.Rows(i)(groupString)
                            GroupStdQty += dtTable.Rows(i)(groupString)
                            TotalStdQty += dtTable.Rows(i)(groupString)
                        End If
                        showData = True
                    Else
                        outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"">0.0000</td>")
                    End If
				
                    If dtTable.Rows(i)(UseAvgString) = 1 Then
                        If Not IsDBNull(dtTable.Rows(i)(QtyString)) Then
                            outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"">" + Format(CostPerUnit * dtTable.Rows(i)(groupString), "##,##0.00;(##,##0.00)") + "</td>")
                            SubTotalPrice += CostPerUnit * dtTable.Rows(i)(groupString)
                            ColumnSum(j) += CostPerUnit * dtTable.Rows(i)(groupString)
                            ColumnSumGroup(j) += CostPerUnit * dtTable.Rows(i)(groupString)
                            DLineColumnSumGroup(j) = CostPerUnit * dtTable.Rows(i)(groupString)
                            showData = True
                        Else
                            outputString = outputString.Append("<td class=""smallText"">&nbsp;</td>")
                        End If
                    Else
                        If Not IsDBNull(dtTable.Rows(i)(PriceString)) Then
                            outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"">" + Format(dtTable.Rows(i)(PriceString), "##,##0.00;(##,##0.00)") + "</td>")
                            SubTotalPrice += dtTable.Rows(i)(PriceString)
                            ColumnSum(j) += dtTable.Rows(i)(PriceString)
                            ColumnSumGroup(j) += dtTable.Rows(i)(PriceString)
                            DLineColumnSumGroup(j) = dtTable.Rows(i)(PriceString)
                        Else
                            outputString = outputString.Append("<td class=""smallText"">&nbsp;</td>")
                        End If
                    End If
				
                Next
                If Not IsDBNull(SubTotalUse) Then
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"" bgColor=""" + GlobalParam.GrayBGColor + """>" + Format(SubTotalUse / UnitRatioVal, "##,##0.0000;(##,##0.0000)") + "</td>")

                    If SubTotalUse > 0 Or (SubTotalUse = 0 And showData = True) Then
                        outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"" bgColor=""" + GlobalParam.GrayBGColor + """>" + Format(CostPerUnit * SubTotalUse, "##,##0.00") + "</td>")
                        SubTotalPrice += CostPerUnit * SubTotalUse
                        EndingSum += CostPerUnit * SubTotalUse
                        EndingSumGroup += CostPerUnit * SubTotalUse
                        DLineEndingSumGroup = CostPerUnit * SubTotalUse
                        showData = True
                    Else
                        outputString = outputString.Append("<td class=""smallText"" bgColor=""" + GlobalParam.GrayBGColor + """>&nbsp;</td>")
                    End If

                Else
                    outputString = outputString.Append("<td class=""smallText"" bgColor=""" + GlobalParam.GrayBGColor + """>&nbsp;</td>")
                    outputString = outputString.Append("<td class=""smallText"" bgColor=""" + GlobalParam.GrayBGColor + """>&nbsp;</td>")
                End If
			
                For j = 0 To groupDataL.Rows.Count - 1 ' Calculate subTotal including Variance
                    UnitPrice = "0"
                    groupString = "NetSmallAmount" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
                    PriceString = "ProductNetPrice" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
                    QtyString = "TotalAmount" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
                    StdString = "CalculateStandardProfitLoss" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
                    UseAvgString = "UseAvgCost" + groupData.Rows(j)("DocumentTypeGroupID").ToString
				
                    If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                        If dtTable.Rows(i)("TotalAmount") > 0 Then
                            UnitPrice = Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")), "##,##0.000000")
                        End If
                    End If
				
                    If Not IsDBNull(dtTable.Rows(i)(groupString)) Then
                        SubTotalUse += dtTable.Rows(i)(groupString)
                        If groupDataL.Rows(j)("ActualCost") = 1 Or groupDataL.Rows(j)("ActualCost") = 2 Then
                            ActualQty += dtTable.Rows(i)(groupString)
                            GroupActualQty += dtTable.Rows(i)(groupString)
                            TotalActualQty += dtTable.Rows(i)(groupString)
                        End If
                        If groupDataL.Rows(j)("ActualCost") = 2 Then
                            StdQty += dtTable.Rows(i)(groupString)
                            GroupStdQty += dtTable.Rows(i)(groupString)
                            TotalStdQty += dtTable.Rows(i)(groupString)
                        End If
                        showData = True
                    End If
				
                    If dtTable.Rows(i)(UseAvgString) = 1 Then
                        If Not IsDBNull(dtTable.Rows(i)(StdString)) Then
                            If Not IsDBNull(dtTable.Rows(i)(QtyString)) Then
	
                                SubTotalPrice += CostPerUnit * dtTable.Rows(i)(groupString)
                                ColumnSaleSum(j) += CostPerUnit * dtTable.Rows(i)(groupString)
                                ColumnSaleSumGroup(j) += CostPerUnit * dtTable.Rows(i)(groupString)
                                DLineColumnSaleSumGroup(j) = CostPerUnit * dtTable.Rows(i)(groupString)
                                showData = True

                            End If
                        End If
                    Else
                        If Not IsDBNull(dtTable.Rows(i)(PriceString)) Then
                            SubTotalPrice += dtTable.Rows(i)(PriceString)
                            ColumnSaleSum(j) += dtTable.Rows(i)(PriceString)
                            ColumnSaleSumGroup(j) += dtTable.Rows(i)(PriceString)
                            DLineColumnSaleSumGroup(j) = dtTable.Rows(i)(PriceString)
                            showData = True
                        End If
                    End If
                Next
			
                If Not IsDBNull(SubTotalUse) Then
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"" bgColor=""" + GlobalParam.GrayBGColor + """><a  class=""smallText"" href=""JavaScript: newWindow = window.open( 'report_material_movement2.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&SelMonth=" & SelMonth.ToString & "&SelYear=" & SelYear.ToString & "&ProductLevelID=" & Request.Form("ShopID").ToString + "&StartDate=" + Replace(StartDateForMovement, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "&ReportDate=" + ReportDate + "', '', 'width=1000,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(SubTotalUse / UnitRatioVal, "##,##0.0000;(##,##0.0000)") + "</a></td>")

                    If SubTotalUse > 0 Or (SubTotalUse = 0 And showData = True) Then
                        outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"" bgColor=""" + GlobalParam.GrayBGColor + """>" + Format(CostPerUnit * SubTotalUse, "##,##0.00;(##,##0.00)") + "</td>")
                        SubTotalPrice += CostPerUnit * SubTotalUse
                        TotalSum += CostPerUnit * SubTotalUse
                        TotalSumGroup += CostPerUnit * SubTotalUse
                        DLineTotalSumGroup = CostPerUnit * SubTotalUse
                        showData = True

                    Else
                        outputString = outputString.Append("<td class=""smallText"" bgColor=""" + GlobalParam.GrayBGColor + """>&nbsp;</td>")
                    End If


                    TotalUse += SubTotalUse
                    TotalPrice += SubTotalPrice
                Else
                    outputString = outputString.Append("<td class=""smallText"" bgColor=""" + GlobalParam.GrayBGColor + """>&nbsp;</td>")
                    outputString = outputString.Append("<td class=""smallText"" bgColor=""" + GlobalParam.GrayBGColor + """>&nbsp;</td>")
                End If
			
                VarianceQty = 0
                For j = 0 To groupDataL.Rows.Count - 1 'Display Variance
                    UnitPrice = "0"
                    groupString = "NetSmallAmount" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
                    PriceString = "ProductNetPrice" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
                    QtyString = "TotalAmount" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
                    StdString = "CalculateStandardProfitLoss" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
                    UseAvgString = "UseAvgCost" + groupDataL.Rows(j)("DocumentTypeGroupID").ToString
				
                    If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                        If dtTable.Rows(i)("TotalAmount") > 0 Then
                            UnitPrice = Format((dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")), "##,##0.000000")
                        End If
                    End If
				
                    If Not IsDBNull(dtTable.Rows(i)(groupString)) Then
                        outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top""><a class=""smalltext"" href=""JavaScript: newWindow = window.open( 'report_material_doc2.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&UnitPrice=" + UnitPrice + "&DocumentTypeGroupID=" & groupDataL.Rows(j)("DocumentTypeGroupID").ToString + "&SelMonth=" & SelMonth.ToString & "&SelYear=" & SelYear.ToString & "&ProductLevelID=" & Request.Form("ShopID").ToString + "&StartDate=" + Replace(StartDate, "'", "\'") + "&EndDate=" + Replace(EndDate, "'", "\'") + "&ReportDate=" + ReportDate + "', '', 'width=1000,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + Format(dtTable.Rows(i)(groupString) / UnitRatioVal, "##,##0.0000;(##,##0.0000)") + "</a></td>")
                        VarianceQty += dtTable.Rows(i)(groupString)
                        showData = True
                    Else
                        outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"">0.0000</td>")
                    End If
				
                    If dtTable.Rows(i)(UseAvgString) = 1 Then
	  
                        outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"">" + Format(CostPerUnit * dtTable.Rows(i)(groupString), "##,##0.00;(##,##0.00)") + "</td>")

                    Else
                        If Not IsDBNull(dtTable.Rows(i)(PriceString)) Then
                            outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"">" + Format(dtTable.Rows(i)(PriceString), "##,##0.00;(##,##0.00)") + "</td>")
                        Else
                            outputString = outputString.Append("<td class=""smallText"">&nbsp;</td>")
                        End If
                    End If
                Next
			
                outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"" bgColor=""" + StatGBColor + """>" + Format(ActualQty / UnitRatioVal, "##,##0.0000;(##,##0.0000)") + "</td>")
			
                outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"" bgColor=""" + StatGBColor + """>" + Format(CostPerUnit * ActualQty, "##,##0.00;(##,##0.00)") + "</td>")
                GroupSumActual += CostPerUnit * ActualQty
                TotalSumActual += CostPerUnit * ActualQty
                GroupSumStd += CostPerUnit * StdQty
                TotalSumStd += CostPerUnit * StdQty
                LineSumActual = CostPerUnit * ActualQty
                LineSumStd = CostPerUnit * StdQty
			
                If ActualQty <> 0 Then
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"" bgColor=""" + StatGBColor + """>" + Format(Math.Abs(VarianceQty * 100 / ActualQty), "##,##0.00") + "%")
                    outputString = outputString.Append("</td>")
                Else
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"" bgColor=""" + StatGBColor + """>" + "-" + "</td>")
                End If
			
                If StdQty <> 0 Then
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"" bgColor=""" + StatGBColor + """>" + Format(ActualQty * 100 / StdQty, "##,##0.00") + "%")
                    outputString = outputString.Append("</td>")
                Else
                    outputString = outputString.Append("<td class=""smallText"" align=""right"" valign=""top"" bgColor=""" + StatGBColor + """>" + "-" + "</td>")
                End If
			
                outputString = outputString.Append("</tr>")
			
                If (showData = True And DisplayOnly.Checked = True) Or DisplayOnly.Checked = False Then
                    If Trim(dtTable.Rows(i)("MaterialCode")) <> "" Then
                        resultString = resultString.Append(outputString.ToString)
                    End If
                End If
			
                CheckGroupVal = BeginningSumGroup

                For j = 0 To groupData.Rows.Count - 1
                    CheckGroupVal += ColumnSumGroup(j)
                Next
                CheckGroupVal += EndingSumGroup
                CheckGroupVal += TotalSumGroup
                For j = 0 To groupDataL.Rows.Count - 1
                    CheckGroupVal += ColumnSaleSumGroup(j)
                Next
                
                If ShowGroup = True Then
                    ShowGroupSummary = False
                    If Not IsDBNull(dtTable.Rows(i)("MaterialGroupCode")) Then
                        If i = dtTable.Rows.Count - 1 Then
                            ShowGroupSummary = True
                        ElseIf dtTable.Rows(i + 1)("MaterialGroupCode") <> dtTable.Rows(i)("MaterialGroupCode") Then
                            ShowGroupSummary = True
                        End If
                    End If
                    If i = 0 Then
                        ShowGroupSummary = False
                    End If
                    '                  If CheckGroupVal = 0 Then
                    '                       ShowGroupSummary = False
                    '                    End If
                    
                    If ShowGroupSummary = True Then
                        Dim outputS As StringBuilder = New StringBuilder
                        outputS = outputS.Append("<tr bgColor=""" + "#eeeeee" + """>")

                        outputS = outputS.Append("<td class=""smallText"" align=""right"" colspan=""6"">Summary for " + dtTable.Rows(i)("MaterialGroupName") + "</td>")

                        outputS = outputS.Append("<td colspan=""2"" class=""smallText"" align=""right"">" + Format(BeginningSumGroup, "##,##0.00;(##,##0.00)") + "</td>")
                        For j = 0 To groupData.Rows.Count - 1
                            outputS = outputS.Append("<td colspan=""2"" class=""smallText"" align=""right"">" + Format(ColumnSumGroup(j), "##,##0.00;(##,##0.00)") + "</td>")
                            ColumnSumGroup(j) = LineColumnSumGroup(j)
                        Next
                        outputS = outputS.Append("<td colspan=""2"" class=""smallText"" align=""right"">" + Format(EndingSumGroup, "##,##0.00;(##,##0.00)") + "</td>")
                        outputS = outputS.Append("<td colspan=""2"" class=""smallText"" align=""right"">" + Format(TotalSumGroup, "##,##0.00;(##,##0.00)") + "</td>")
                        SumVariance = 0
                        For j = 0 To groupDataL.Rows.Count - 1
                            outputS = outputS.Append("<td colspan=""2"" class=""smallText"" align=""right"">" + Format(ColumnSaleSumGroup(j), "##,##0.00;(##,##0.00)") + "</td>")
                            SumVariance += ColumnSaleSumGroup(j)
                            ColumnSaleSumGroup(j) = 0
                        Next
                        outputS = outputS.Append("<td colspan=""2"" class=""smallText"" align=""right"">" + Format(GroupSumActual - LineSumActual, "##,##0.00;(##,##0.00)") + "</td>")
					
                        If GroupSumActual - LineSumActual <> 0 Then
                            outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format(Math.Abs((SumVariance) * 100 / (GroupSumActual - LineSumActual)), "##,##0.00") + "%</td>")
                        Else
                            outputS = outputS.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
                        End If
					
                        If (GroupSumStd - LineSumStd) <> 0 Then
                            outputS = outputS.Append("<td class=""smallText"" align=""right"">" + Format((GroupSumActual - LineSumActual) * 100 / (GroupSumStd - LineSumStd), "##,##0.00") + "%</td>")
                        Else
                            outputS = outputS.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
                        End If
		
                        outputS = outputS.Append("</tr>")
                        BeginningSumGroup = 0
                        EndingSumGroup = 0
                        TotalSumGroup = 0
                        GroupSumActual = 0
                        GroupSumStd = 0
                        OString = outputS.ToString
                        resultString = resultString.Append(outputS.ToString)

                    End If

                End If

            Next
				
		SumVariance = 0
		resultString = resultString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
		If ShowGroup = True Then
			resultString = resultString.Append("<td class=""smallText"" align=""right"" colspan=""6"">Summary</td>")
		Else
			resultString = resultString.Append("<td class=""smallText"" align=""right"" colspan=""4"">Summary</td>")
		End If
		resultString = resultString.Append("<td colspan=""2"" class=""smallText"" align=""right"">" + Format(BeginningSum,"##,##0.00;(##,##0.00)") + "</td>")
		For i = 0 to groupData.Rows.Count - 1
			resultString = resultString.Append("<td colspan=""2"" class=""smallText"" align=""right"">" + Format(ColumnSum(i),"##,##0.00;(##,##0.00)") + "</td>")
		Next
		resultString = resultString.Append("<td colspan=""2"" class=""smallText"" align=""right"">" + Format(EndingSum,"##,##0.00;(##,##0.00)") + "</td>")
		resultString = resultString.Append("<td colspan=""2"" class=""smallText"" align=""right"">" + Format(TotalSum,"##,##0.00;(##,##0.00)") + "</td>")
		For i = 0 to groupDataL.Rows.Count - 1
			resultString = resultString.Append("<td colspan=""2"" class=""smallText"" align=""right"">" + Format(ColumnSaleSum(i),"##,##0.00;(##,##0.00)") + "</td>")
			SumVariance += ColumnSaleSum(i)
		Next
		
		resultString = resultString.Append("<td colspan=""2"" class=""smallText"" align=""right"">" + Format(TotalSumActual,"##,##0.00;(##,##0.00)") + "</td>")
		
		If TotalSumActual <> 0 Then
			resultString = resultString.Append("<td class=""smallText"" align=""right"">" + Format(Math.Abs((SumVariance)*100/TotalSumActual),"##,##0.00") + "%</td>")
		Else
			resultString = resultString.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
		End If
		
		If TotalSumStd <> 0 Then
			resultString = resultString.Append("<td class=""smallText"" align=""right"">" + Format(TotalSumActual*100/TotalSumStd,"##,##0.00") + "%</td>")
		Else
			resultString = resultString.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
		End If
		resultString = resultString.Append("</tr>")
		
		ResultText.InnerHtml = resultString.ToString
		
		Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & headerTextString.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"
		
		TestTime += "<br>" + DateTimeUtil.CurrentDateTime
		'errorMsg.InnerHtml = BSumText
	End If
	'Catch ex As Exception
			'FoundError = True
		'End Try
End Sub

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "StockCardData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub

Public Function StockCardReport2(ByVal GroupCode As String, ByVal DeptCode As String, ByRef GetData As DataTable, ByRef groupData As DataTable, ByRef GroupDataL As DataTable, ByVal ShopID As Integer, ByVal SelMonth As Integer, ByVal SelYear As Integer, ByVal OrderParam As String, ByVal StartDateData As String, ByVal EndDateData As String, ByVal ReportType As Integer, ByVal BeginningDay As Integer, ByVal BeginningMonth As Integer, ByVal BeginningYear As Integer, ByVal objCnn As MySqlConnection) As String

        Dim sqlStatement, ResultString As String
        Dim AdditionalQuery As String = ""
        Dim ShopIDListValue As String
        Dim TestString As String

        If Trim(GroupCode) <> "" Then
            AdditionalQuery += " AND mg.MaterialGroupCode IN (" + GroupCode + ")"
        End If
        If Trim(DeptCode) <> "" Then
            AdditionalQuery += " AND md.MaterialDeptCode IN (" + DeptCode + ")"
        End If
        'Dim DateTimeUtil As New GlobalFunctions.MyDateTime
        Dim StartDate, EndDate As String
        Dim BeginStartDate, BeginEndDate As String
        Dim StartMonthValue, StartYearValue, EndMonthValue, EndYearValue As Integer
        If SelMonth = 12 Then
            StartMonthValue = SelMonth
            EndMonthValue = 1
            StartYearValue = SelYear
            EndYearValue = SelYear + 1
        Else
            StartMonthValue = SelMonth
            EndMonthValue = SelMonth + 1
            StartYearValue = SelYear
            EndYearValue = SelYear
        End If
        If ReportType = 1 Then
            StartDate = DateTimeUtil.FormatDate(1, StartMonthValue, StartYearValue)
            EndDate = DateTimeUtil.FormatDate(1, EndMonthValue, EndYearValue)
        Else
            StartDate = StartDateData
            EndDate = EndDateData
            BeginStartDate = DateTimeUtil.FormatDate(1, BeginningMonth, BeginningYear)
            BeginEndDate = StartDate
        End If

        If ReportType = 1 Or (ReportType = 2 And BeginningDay = 1) Then
            sqlStatement = "(select 0 AS Ordering, 0 AS DocumentTypeGroupID,'Beginning' AS GroupHeader,ProductID As MaterialID,UnitSmallAmount As NetSmallAmount,UnitSmallAmount AS TotalAmount,ProductNetPrice, dt.CalculateStandardProfitLoss, 0 As ActualCost,0 As UseAvgCost FROM document aa, docdetail bb, documenttype dt where aa.DocumentID=bb.DocumentID AND aa.ShopID=bb.ShopID AND aa.DocumentTypeID=10  AND aa.DocumentStatus=2 AND aa.DocumentTypeID=dt.DocumentTypeID AND dt.LangID=1 AND dt.ShopID=aa.ProductLevelID AND aa.ProductLevelID=" + ShopID.ToString + " AND aa.DocumentDate >= " + StartDate + " AND aa.DocumentDate < " + EndDate + " ) UNION ( select d.Ordering, d.DocumentTypeGroupID,d.GroupHeader, ProductID As MaterialID ,sum(e.MovementInStock*b.UnitSmallAmount) As NetSmallAmount, sum(b.UnitSmallAmount) AS TotalAmount, sum(ProductNetPrice) As ProductNetPrice,e.CalculateStandardProfitLoss,d.ActualCost,d.UseAvgCost from document a, docdetail b, documentTypeGroupValue c, DocumentTypeGroup d, DocumentType e where a.DocumentID=b.DocumentID AND a.ShopID=b.ShopID AND a.DocumentTypeID=c.DocumentTypeID   AND c.DocumentTypeGroupID = d.DocumentTypeGroupID  AND a.DocumentTypeID=e.DocumentTypeID AND a.ShopID=e.ShopID  AND d.Ordering > 0 AND e.DocumentTypeID<>10 AND a.DocumentStatus=2 AND a.ProductLevelID=" + ShopID.ToString + " AND e.LangID=1  AND a.DocumentDate >= " + StartDate + " AND a.DocumentDate < " + EndDate + " group by d.Ordering,d.DocumentTypeGroupID,d.GroupHeader, ProductID,e.CalculateStandardProfitLoss,d.ActualCost order by d.Ordering ) UNION ( select d.Ordering,d.DocumentTypeGroupID,d.GroupHeader, ProductID As MaterialID ,sum(e.MovementInStock*b.UnitSmallAmount) As NetSmallAmount, sum(b.UnitSmallAmount) AS TotalAmount, sum(ProductNetPrice) As ProductNetPrice,e.CalculateStandardProfitLoss, d.ActualCost, d.UseAvgCost from document a, docdetail b, documentTypeGroupValue c, DocumentTypeGroup d, DocumentType e where a.DocumentID=b.DocumentID AND a.ShopID=b.ShopID AND a.DocumentTypeID=c.DocumentTypeID   AND c.DocumentTypeGroupID = d.DocumentTypeGroupID  AND a.DocumentTypeID=e.DocumentTypeID AND a.ShopID=e.ShopID  AND d.Ordering < 0 AND e.DocumentTypeID<>10 AND a.DocumentStatus=2 AND a.ProductLevelID=" + ShopID.ToString + " AND e.LangID=1  AND a.DocumentDate >= " + StartDate + " AND a.DocumentDate < " + EndDate + " group by d.Ordering,d.DocumentTypeGroupID,d.GroupHeader, ProductID ,CalculateStandardProfitLoss,d.ActualCost order by d.Ordering )"
        Else
            sqlStatement = "(select 0 AS Ordering, 0 AS DocumentTypeGroupID,'Beginning' AS GroupHeader,ProductID As MaterialID,sum(dt.MovementInStock*bb.UnitSmallAmount) As NetSmallAmount,sum(bb.UnitSmallAmount) AS TotalAmount,sum(ProductNetPrice) As ProductNetPrice,1 As CalculateStandardProfitLoss, 0 As ActualCost, 0 As UseAvgCost FROM document aa, docdetail bb, documenttype dt where aa.DocumentID=bb.DocumentID AND aa.ShopID=bb.ShopID AND aa.DocumentStatus=2 AND aa.DocumentTypeID=dt.DocumentTypeID AND dt.LangID=1 AND dt.ShopID=aa.ProductLevelID AND aa.ProductLevelID=" + ShopID.ToString + " AND aa.DocumentDate >= " + BeginStartDate + " AND aa.DocumentDate < " + BeginEndDate + " group by ProductID ) UNION ( select d.Ordering, d.DocumentTypeGroupID,d.GroupHeader, ProductID As MaterialID ,sum(e.MovementInStock*b.UnitSmallAmount) As NetSmallAmount, sum(b.UnitSmallAmount) AS TotalAmount, sum(ProductNetPrice) As ProductNetPrice,e.CalculateStandardProfitLoss,d.ActualCost,d.UseAvgCost from document a, docdetail b, documentTypeGroupValue c, DocumentTypeGroup d, DocumentType e where a.DocumentID=b.DocumentID AND a.ShopID=b.ShopID AND a.DocumentTypeID=c.DocumentTypeID   AND c.DocumentTypeGroupID = d.DocumentTypeGroupID  AND a.DocumentTypeID=e.DocumentTypeID AND a.ShopID=e.ShopID  AND d.Ordering > 0 AND a.DocumentTypeID<>10 AND a.DocumentStatus=2 AND a.ProductLevelID=" + ShopID.ToString + " AND e.LangID=1  AND a.DocumentDate >= " + StartDate + " AND a.DocumentDate < " + EndDate + " group by d.Ordering,d.DocumentTypeGroupID,d.GroupHeader, ProductID,e.CalculateStandardProfitLoss,d.ActualCost order by d.Ordering ) UNION ( select d.Ordering,d.DocumentTypeGroupID,d.GroupHeader, ProductID As MaterialID ,sum(e.MovementInStock*b.UnitSmallAmount) As NetSmallAmount, sum(b.UnitSmallAmount) AS TotalAmount, sum(ProductNetPrice) As ProductNetPrice,e.CalculateStandardProfitLoss,d.ActualCost,d.UseAvgCost from document a, docdetail b, documentTypeGroupValue c, DocumentTypeGroup d, DocumentType e where a.DocumentID=b.DocumentID AND a.ShopID=b.ShopID AND a.DocumentTypeID=c.DocumentTypeID   AND c.DocumentTypeGroupID = d.DocumentTypeGroupID  AND a.DocumentTypeID=e.DocumentTypeID AND a.ShopID=e.ShopID  AND d.Ordering < 0 AND a.DocumentTypeID<>10 AND a.DocumentStatus=2 AND a.ProductLevelID=" + ShopID.ToString + " AND e.LangID=1  AND a.DocumentDate >= " + StartDate + " AND a.DocumentDate < " + EndDate + " group by d.Ordering,d.DocumentTypeGroupID,d.GroupHeader, ProductID ,CalculateStandardProfitLoss, d.ActualCost order by d.Ordering )"

        End If

        TestString = sqlStatement

        Dim TestTime As String
        TestTime += "<br>" + DateTimeUtil.CurrentDateTime
        objDB.sqlExecute("DROP TABLE IF EXISTS DummyStockCard", objCnn)
        objDB.sqlExecute("create table DummyStockCard (Ordering int, DocumentTypeGroupID int, GroupHeader varchar(50), MaterialID int, NetSmallAmount decimal(18,4),TotalAmount decimal(18,4), ProductNetPrice decimal(18,4), CalculateStandardProfitLoss tinyint, ActualCost tinyint, UseAvgCost tinyint)", objCnn)
        objDB.sqlExecute("insert into DummyStockCard " + sqlStatement, objCnn)
        objDB.sqlExecute("ALTER TABLE dummystockcard ADD INDEX OrderingIndex (Ordering,MaterialID);", objCnn)
        objDB.sqlExecute("ALTER TABLE dummystockcard ADD INDEX GroupMaterialIndex (DocumentTypeGroupID,MaterialID);", objCnn)
        TestTime += "<br>" + DateTimeUtil.CurrentDateTime
        '------- Calculate Material Standard Cost

        MaterialStdCost("DummyMaterialStandardCost_For_Stock", SelMonth, SelYear, ShopID, objCnn)
        '-----------------------------------------
        TestTime += "<br>" + DateTimeUtil.CurrentDateTime
        groupData = objDB.List("select * from DocumentTypeGroup where Ordering > 0 order by Ordering", objCnn)

        Dim SelectString As String = "u.UnitSmallName,a.UnitSmallID,a.MaterialID,a.MaterialName,a.MaterialCode,mg.MaterialGroupCode,mg.MaterialGroupName,std.TotalPrice,std.TotalAmount,std.BeginningPricePerUnit,std.RecTotalPrice,std.RecTotalAmount,b.CalculateStandardProfitLoss AS CalculateStandardProfitLoss0,IF(b.UseAvgCost is NULL,-1,b.UseAvgCost) As UseAvgCost0,b.NetSmallAmount AS NetSmallAmount0,b.TotalAmount AS TotalAmount0,b.ProductNetPrice AS ProductNetPrice0"
        Dim WhereString As String = " left outer join UnitSmall u ON a.UnitSmallID=u.UnitSmallID left outer join DummyMaterialStandardCost_For_Stock std ON a.MaterialID=std.MaterialID left outer join DummyStockCard b on a.MaterialID=b.MaterialID AND b.Ordering=0 "

        Dim i As Integer
        For i = 0 To groupData.Rows.Count - 1
            SelectString += ",b" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ".CalculateStandardProfitLoss AS CalculateStandardProfitLoss" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ",IF(b" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ".UseAvgCost is NULL,-1,b" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ".UseAvgCost) AS UseAvgCost" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ",b" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ".NetSmallAmount As NetSmallAmount" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ",b" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ".TotalAmount AS TotalAmount" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ",b" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ".ProductNetPrice AS ProductNetPrice" + groupData.Rows(i)("DocumentTypeGroupID").ToString
            WhereString += " left outer join DummyStockCard b" + groupData.Rows(i)("DocumentTypeGroupID").ToString + " on a.MaterialID=b" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ".MaterialID AND b" + groupData.Rows(i)("DocumentTypeGroupID").ToString + ".DocumentTypeGroupID=" + groupData.Rows(i)("DocumentTypeGroupID").ToString
        Next

        GroupDataL = objDB.List("select * from DocumentTypeGroup where Ordering < 0 order by Ordering", objCnn)

        For i = 0 To GroupDataL.Rows.Count - 1
            SelectString += ",b" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ".CalculateStandardProfitLoss AS CalculateStandardProfitLoss" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ",IF(b" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ".UseAvgCost is NULL,-1,b" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ".UseAvgCost) AS UseAvgCost" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ",b" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ".NetSmallAmount As NetSmallAmount" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ",b" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ".TotalAmount AS TotalAmount" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ",b" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ".ProductNetPrice AS ProductNetPrice" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString
            WhereString += " left outer join DummyStockCard b" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + " on a.MaterialID=b" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ".MaterialID AND b" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString + ".DocumentTypeGroupID=" + GroupDataL.Rows(i)("DocumentTypeGroupID").ToString
        Next

        sqlStatement = "select " + SelectString + " from Materials a inner join (select count(*),ProductID As MaterialID from document a1,docdetail b1 where a1.DocumentID=b1.DocumentID AND a1.ShopID=b1.ShopID AND a1.ProductLevelID=" + ShopID.ToString + " AND a1.DocumentStatus=2 AND a1.DocumentDate >= " + StartDate + " AND a1.DocumentDate < " + EndDate + " group by ProductID) aa ON a.MaterialID=aa.MaterialID left outer join MaterialDept md ON a.MaterialDeptID=md.MaterialDeptID left outer join MaterialGroup mg ON md.MaterialGroupID=mg.MaterialGroupID " + WhereString + " where 0=0 " + AdditionalQuery + " order by " + OrderParam

        
        GetData = objDB.List(sqlStatement, objCnn)
        TestTime += "<br>" + DateTimeUtil.CurrentDateTime
        TestString += "<HR>" + sqlStatement
        'errorMsg.InnerHtml = TestString

        objDB.sqlExecute("DROP TABLE IF EXISTS DummyStockCard", objCnn)
        objDB.sqlExecute("DROP TABLE IF EXISTS DummyMaterialStandardCost_For_Stock", objCnn)


    End Function
	
	 Public Function MaterialStdCost(ByVal TableName As String, ByVal SelMonth As Integer, ByVal SelYear As Integer, ByVal ShopID As Integer, ByVal objCnn As MySqlConnection) As String

            Dim sqlStatement As String
            Dim shopInfo As New DataTable
            shopInfo = GetProductLevel(ShopID, objCnn)

            Dim CalculateFromShopID As Integer = 0

            Dim CostTypeVal As Integer = -2 'Calculate based on material costing table

            Dim CostType As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramTypeID=2 AND PropertyID=4 AND KeyID=1", objCnn)
            If CostType.Rows.Count > 0 Then

                If CostType.Rows(0)("PropertyValue") = 0 Then
                    If shopInfo.Rows.Count > 0 Then
                        CalculateFromShopID = shopInfo.Rows(0)("CalculateCostType")
                    Else
                        CalculateFromShopID = ShopID
                    End If

                Else
                    CalculateFromShopID = CostType.Rows(0)("PropertyValue")
                End If
                CostTypeVal = CalculateFromShopID
            End If

            Dim DateTimeString As String = "{ d '" + SelYear.ToString + "-" + SelMonth.ToString + "-1' }"

            Dim LastSelYear As Integer
            Dim LastSelMonth As Integer
            If SelMonth = 1 Then
                LastSelMonth = 12
                LastSelYear = SelYear - 1
            Else
                LastSelMonth = SelMonth - 1
                LastSelYear = SelYear
            End If
            Dim LastMonthString As String = "{ d '" + LastSelYear.ToString + "-" + LastSelMonth.ToString + "-1' }"
            Dim TestString As String = ""
            Dim i As Integer
            If CostTypeVal = -2 Then
                Dim ChkData As DataTable
                Dim ChkLastMonth As DataTable
                Dim Exist As Boolean
                Exist = getProp.CheckTableExist("MaterialCostGroupLinkInventory", objCnn)
                Dim ChkLink As DataTable
                If Exist = True Then
                    ChkLink = objDB.List("select * from MaterialCostGroupLinkInventory", objCnn)
                Else
                    ChkLink = objDB.List("select * from Property where 0=1", objCnn)
                End If
                If ChkLink.Rows.Count = 0 Then
                    sqlStatement = "select * from MaterialCostGroup where StartDate <= " + DateTimeString + " AND EndDate > " + DateTimeString + " order by StartDate"
                    TestString += "<br>" + sqlStatement
                    ChkData = objDB.List(sqlStatement, objCnn)

                    sqlStatement = "select * from MaterialCostGroup where StartDate <= " + LastMonthString + " AND EndDate > " + LastMonthString + " order by StartDate"
                    TestString += "<br>" + sqlStatement

                    ChkLastMonth = objDB.List(sqlStatement, objCnn)
                Else
                    sqlStatement = "select a.* from MaterialCostGroup a, MaterialCostGroupLinkInventory b where a.MaterialCostGroupID=b.MaterialCostGroupID AND b.InventoryID=" + ShopID.ToString + " AND StartDate <= " + DateTimeString + " AND EndDate > " + DateTimeString + " order by StartDate"
                    TestString += "<br>" + sqlStatement
                    ChkData = objDB.List(sqlStatement, objCnn)

                    sqlStatement = "select a.* from MaterialCostGroup a, MaterialCostGroupLinkInventory b where a.MaterialCostGroupID=b.MaterialCostGroupID AND b.InventoryID=" + ShopID.ToString + " AND StartDate <= " + LastMonthString + " AND EndDate > " + LastMonthString + " order by StartDate"
                    TestString += "<br>" + sqlStatement

                    ChkLastMonth = objDB.List(sqlStatement, objCnn)
                End If


                Dim CostGroupID As Integer = 0
                Dim LastMonthCostGroupID As Integer = 0

                If ChkData.Rows.Count > 0 Then CostGroupID = ChkData.Rows(0)("MaterialCostGroupID")
                If ChkLastMonth.Rows.Count > 0 Then LastMonthCostGroupID = ChkLastMonth.Rows(0)("MaterialCostGroupID")

                objDB.sqlExecute("Drop Table If Exists " + TableName, objCnn)
                objDB.sqlExecute("create table if not exists " + TableName + " (MaterialID int, TotalPrice decimal(18,4), TotalAmount decimal(18,4), BeginningPricePerUnit decimal(18,4), BeginningAmount decimal(18,4), PricePerUnit decimal(18,4), RecTotalPrice decimal(18,4), RecTotalAmount decimal(18,4), PRIMARY KEY (MaterialID))", objCnn)

                sqlStatement = " select a.MaterialID,IF(b.MaterialPrice is NULL,0,b.MaterialPrice) AS TotalPrice" + _
                    " ,IF(b.UnitSmallRatio is NULL,1,b.UnitSmallRatio) AS TotalAmount,IF(c.MaterialPrice is NULL,0,c.MaterialPrice) AS BeginningPricePerUnit,IF(c.UnitSmallRatio is NULL,1,c.UnitSmallRatio) As BeginningAmount,1,IF(b.MaterialPrice is NULL,0,b.MaterialPrice) AS RecTotalPrice,IF(b.UnitSmallRatio is NULL,1,b.UnitSmallRatio) AS RecTotalAmount from Materials a left outer join MaterialCostTable b ON a.MaterialID=b.MaterialID AND b.MaterialCostGroupID=" + CostGroupID.ToString + " left outer join MaterialCostTable c ON a.MaterialID=c.MaterialID AND c.MaterialCostGroupID=" + LastMonthCostGroupID.ToString
                objDB.sqlExecute("insert into " + TableName + sqlStatement, objCnn)
                TestString += "<br>" + sqlStatement
            ElseIf CostTypeVal = -1 Then
                objDB.sqlExecute("Drop Table If Exists " + TableName, objCnn)
                objDB.sqlExecute("create table if not exists " + TableName + " (MaterialID int, TotalPrice decimal(18,4), TotalAmount decimal(18,4), BeginningPricePerUnit decimal(18,4), BeginningAmount decimal(18,4), PricePerUnit decimal(18,4), RecTotalPrice decimal(18,4), RecTotalAmount decimal(18,4), PRIMARY KEY (MaterialID))", objCnn)
            Else
                ' Get standard cost in case amount is 0 from beginning stock
                sqlStatement = "select b.ProductID AS MaterialID,b.ProductPricePerUnit from document a, docdetail b, documenttype c where a.documentid=b.documentid and a.shopid=b.shopid and a.documenttypeid=c.documenttypeid and a.shopid=c.shopid and c.langid=1 and a.documenttypeid=10 and a.documentstatus=2 and MONTH(a.documentdate) = " + SelMonth.ToString + " AND YEAR(a.documentdate) = " + SelYear.ToString + " and a.productlevelid=" + ShopID.ToString

                objDB.sqlExecute("Drop Table If Exists " + TableName + "_Begin", objCnn)
                objDB.sqlExecute("create table if not exists " + TableName + "_Begin (MaterialID int, BeginningPricePerUnit decimal(18,4), PRIMARY KEY (MaterialID))", objCnn)
                objDB.sqlExecute("insert into " + TableName + "_Begin " + sqlStatement, objCnn)

                Dim dtTable As DataTable = objDB.List("select * from " + TableName + "_Begin", objCnn)
                Dim IDString As StringBuilder = New StringBuilder
                For i = 0 To dtTable.Rows.Count - 1
                    IDString = IDString.Append(dtTable.Rows(i)("MaterialID").ToString + ",")
                Next
                IDString = IDString.Append("0")
                Dim IDList As String = IDString.ToString

                If Trim(IDList) = "" Then IDList = "0"

                sqlStatement = " select b.MaterialID,a.BeginningPricePerUnit from " + TableName + "_Begin a left outer join Materials b ON a.MaterialID=b.MaterialID where b.MaterialID is not NULL AND b.MaterialID NOT IN (" + IDList + ")"
                objDB.sqlExecute("insert into " + TableName + "_Begin " + sqlStatement, objCnn)

                '----------------------

                '----------- Calculate Receive Average Cost
                objDB.sqlExecute("Drop Table If Exists " + TableName + "_Rec", objCnn)
                objDB.sqlExecute("create table if not exists " + TableName + "_Rec (MaterialID int, RecTotalPrice decimal(18,4), RecTotalAmount decimal(18,4), PRIMARY KEY (MaterialID))", objCnn)

                sqlStatement = " select b.ProductID as MaterialID, sum(c.MovementInStock*b.ProductNetPrice) as totalPrice, sum(c.MovementInStock*b.UnitSmallAmount) as totalAmount from document a, docdetail b, documenttype c where a.documentid=b.documentid and a.shopid=b.shopid and a.documenttypeid=c.documenttypeid and a.shopid=c.shopid and c.langid=1 and c.calculatestandardprofitloss=1 and a.documentstatus=2 and c.DocumentTypeID IN (2,39) and MONTH(a.documentdate) = " + SelMonth.ToString + " AND YEAR(a.documentdate) = " + SelYear.ToString + " and a.productlevelid=" + ShopID.ToString + " group by b.ProductID"
                objDB.sqlExecute("insert into " + TableName + "_Rec " + sqlStatement, objCnn)
                '----------- End Rec Cal ----------

                sqlStatement = " select b.ProductID as MaterialID, sum(c.MovementInStock*b.ProductNetPrice) as totalPrice, sum(c.MovementInStock*b.UnitSmallAmount) as totalAmount,IF(d.BeginningPricePerUnit is NULL,0,d.BeginningPricePerUnit) AS BeginningPricePerUnit from document a inner join docdetail b ON a.documentid=b.documentid and a.shopid=b.shopid inner join documenttype c ON a.documenttypeid=c.documenttypeid and a.shopid=c.shopid left outer join " + TableName + "_Begin d ON b.ProductID=d.MaterialID where  c.langid=1 and c.calculatestandardprofitloss=1 and a.documentstatus=2 and MONTH(a.documentdate) = " + SelMonth.ToString + " AND YEAR(a.documentdate) = " + SelYear.ToString + " and a.productlevelid=" + CalculateFromShopID.ToString + " group by b.ProductID"

                objDB.sqlExecute("Drop Table If Exists " + TableName + "_Stock", objCnn)
                objDB.sqlExecute("create table if not exists " + TableName + "_Stock (MaterialID int, TotalPrice decimal(18,4), TotalAmount decimal(18,4), BeginningPricePerUnit decimal(18,4), PRIMARY KEY (MaterialID))", objCnn)
                objDB.sqlExecute("insert into " + TableName + "_Stock " + sqlStatement, objCnn)

                sqlStatement = " select a.MaterialID,TotalPrice,TotalAmount,BeginningPricePerUnit,IF(TotalAmount = 0,BeginningPricePerUnit,TotalPrice/TotalAmount) AS PricePerUnit,1, RecTotalPrice, RecTotalAmount from " + TableName + "_Stock a left outer join " + TableName + "_Rec b ON a.MaterialID=b.MaterialID"
                objDB.sqlExecute("Drop Table If Exists " + TableName, objCnn)
                objDB.sqlExecute("create table if not exists " + TableName + " (MaterialID int, TotalPrice decimal(18,4), TotalAmount decimal(18,4), BeginningPricePerUnit decimal(18,4), BeginningAmount decimal(18,4), PricePerUnit decimal(18,4), RecTotalPrice decimal(18,4), RecTotalAmount decimal(18,4), PRIMARY KEY (MaterialID))", objCnn)
                objDB.sqlExecute("insert into " + TableName + sqlStatement, objCnn)

                objDB.sqlExecute("Drop Table If Exists " + TableName + "_Stock", objCnn)
                objDB.sqlExecute("Drop Table If Exists " + TableName + "_Begin", objCnn)
                objDB.sqlExecute("Drop Table If Exists " + TableName + "_Rec", objCnn)
            End If

        End Function
		
		Public Function GetProductLevel(ByVal ProductLevelID As Integer, ByVal objCnn As MySqlConnection) As DataTable
            Dim sqlStatement As String
            If ProductLevelID = 0 Or Not IsNumeric(ProductLevelID) Then
                sqlStatement = "SELECT * FROM ProductLevel WHERE Deleted=0 AND ProductLevelID > 1 ORDER BY ProductLevelOrder,ProductLevelName"
            ElseIf ProductLevelID = -1 Then
                sqlStatement = "SELECT * FROM ProductLevel WHERE Deleted=0 ORDER BY ProductLevelOrder,ProductLevelName"
            ElseIf ProductLevelID = -99 Then
                sqlStatement = "SELECT * FROM ProductLevel WHERE Deleted=0 AND IsInv=1 ORDER BY ProductLevelOrder,ProductLevelName"
            ElseIf ProductLevelID = -999 Then
                sqlStatement = "SELECT * FROM ProductLevel WHERE Deleted=0 AND IsShop=1 AND ProductLevelID > 1 ORDER BY ProductLevelOrder,ProductLevelName"
            ElseIf ProductLevelID = -9999 Then
                sqlStatement = "SELECT * FROM ProductLevel WHERE Deleted=0 AND IsShop=1 ORDER BY ProductLevelOrder,ProductLevelName"
            Else
                sqlStatement = "SELECT * FROM ProductLevel WHERE Deleted=0 AND ProductLevelID=" + ProductLevelID.ToString + " ORDER BY ProductLevelOrder,ProductLevelName"
            End If
            Return objDB.List(sqlStatement, objCnn)
        End Function
	
Sub Page_UnLoad()
	objCnn.Close()
End Sub
</script>
</body>
</html>
